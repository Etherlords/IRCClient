package irc.services 
{
	import core.collections.SimpleMap;
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import irc.actions.ActionPrivmsg;
	import irc.actions.ChangeModeAction;
	import irc.actions.ChannelEndOfMembersAction;
	import irc.actions.ChannelJoinedAction;
	import irc.actions.ChannelMembersAction;
	import irc.actions.ChannelPartAction;
	import irc.actions.ConnectionAction;
	import irc.actions.IAction;
	import irc.actions.NoticeAction;
	import irc.actions.PingAction;
	import irc.actions.QuitAction;
	import irc.actions.RegistredAction;
	import irc.actions.WelcomeAction;
	import irc.events.IRCEvent;
	import irc.IRCCommands;
	import irc.IRCConnection;
	import irc.IRCMessage;
	import irc.loggers.DefaultLoggerFactory;
	import irc.names.IIRCName;
	import irc.NumericReplies;
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCConnectionService extends AbstractService
	{
		private var settingsService:IRCSettingsService;
		private var _connection:IRCConnection;
		
		private var actions:SimpleMap = new SimpleMap();
		
		public function IRCConnectionService() 
		{
			
		}
		
		public function sendMessage(command:String, params:Array,
            trailing:String=null, prefix:IIRCName=null):void
		{
			_connection.sendMessage(command, params, trailing, prefix)
		}
		
		private function initilize():void 
		{
			var logger:DefaultLoggerFactory = new DefaultLoggerFactory();
			_connection = new IRCConnection();
			manageActions();
			manageEvents();
		}
		
		private function manageActions():void 
		{
			actions.addItem(IRCCommands.CONNECT, new ConnectionAction());
			actions.addItem(IRCCommands.NOTICE, new NoticeAction());
			actions.addItem(IRCCommands.PING, new PingAction());
			actions.addItem(IRCCommands.MODE, new ChangeModeAction());
			actions.addItem(IRCCommands.JOIN, new ChannelJoinedAction());
			actions.addItem(IRCCommands.PRIVMSG, new ActionPrivmsg());
			actions.addItem(IRCCommands.PART, new ChannelPartAction());
			
			actions.addItem(IRCCommands.QUIT, new QuitAction());
			
			actions.addItem(NumericReplies.RPL_NAMREPLY, new ChannelMembersAction());
			actions.addItem(NumericReplies.RPL_ENDOFNAMES, new ChannelEndOfMembersAction());
			
			actions.addItem(NumericReplies.RPL_WELCOME, new WelcomeAction());
			
			actions.addItem(NumericReplies.RPL_YOURHOST, new RegistredAction());
			actions.addItem(NumericReplies.RPL_CREATED, new RegistredAction());
			actions.addItem(NumericReplies.RPL_MYINFO, new RegistredAction());
			actions.addItem(NumericReplies.RPL_ISUPPORT, new RegistredAction());
			
		}
		
		private function manageEvents():void
		{
			_connection.addEventListener(Event.CONNECT, connectHandler);
			_connection.addEventListener(Event.CLOSE, closeHandler);
			_connection.addEventListener(IOErrorEvent.IO_ERROR, errorHandled);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandled);
			_connection.addEventListener(IRCEvent.RECEIVED, receivedHandler);
		}
		
		private function connectHandler(e:Event):void 
		{
			actions.getItem(IRCCommands.CONNECT).execute();
		}
		
		private function closeHandler(e:Event):void 
		{
			
		}
		
		private function receivedHandler(e:IRCEvent):void 
		{
			var m:IRCMessage = e.message;
			
			var action:IAction = actions.getItem(m.command);
			
			if (action)
				action.execute(m);
			else
				trace('### UNKNOWN ACTION', m.command);
		}
		
		private function errorHandled(e:Event):void 
		{
			
		}
		
		public function get connected():Boolean
		{
			return connection.connected;
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
			settingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
			
			initilize();
		}
		
		public function connect():void
		{
			connection.connect(settingsService.serverSettings.host, settingsService.serverSettings.port, settingsService.serverSettings.overTLS);
		}
		
		public function get connection():IRCConnection 
		{
			return _connection;
		}
		
		
		
	}

}