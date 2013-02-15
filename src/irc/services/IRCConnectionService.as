package irc.services 
{
	import core.collections.SimpleMap;
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import irc.actions.ConnectionAction;
	import irc.actions.IAction;
	import irc.events.IRCEvent;
	import irc.IRCCommands;
	import irc.IRCConnection;
	import irc.IRCMessage;
	import irc.loggers.DefaultLoggerFactory;
	import irc.names.IIRCName;
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
			
			var action:IAction = actions.getItem(m.command).execute(m);
			trace(m);
		}
		
		private function errorHandled(e:Event):void 
		{
			
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
			settingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
			
			initilize();
		}
		
		public function connect():void
		{
			connection.connect(settingsService.settings.host, settingsService.settings.port, settingsService.settings.overTLS);
		}
		
		public function get connection():IRCConnection 
		{
			return _connection;
		}
		
		
		
	}

}