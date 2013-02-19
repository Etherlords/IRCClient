package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import irc.IRCClient;
	import irc.IRCCommands;
	import irc.IRCMessage;
	import irc.IRCMessageParser;
	import irc.loggers.DefaultLoggerFactory;
	import irc.names.IIRCName;
	import irc.services.CamutatorService;
	import irc.services.IRCChannelsService;
	import irc.services.IRCConnectionService;
	import irc.services.IRCSettingsService;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends Sprite 
	{
		private var sock:Socket;
		private var _buffer:String = '';
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var settings:IRCSettingsService = new IRCSettingsService();
			settings.settings.host = '127.0.0.1';
			settings.settings.username = 'AsCleint';
			settings.settings.nickname = 'AsCleint';
			settings.settings.realname = 'AsCleint';
			
			
			var camutator:CamutatorService = new CamutatorService();
			var channels:IRCChannelsService = new IRCChannelsService();
			var conenction:IRCConnectionService = new IRCConnectionService();
			conenction.connect();
		}
		
		
		
	}
	
}