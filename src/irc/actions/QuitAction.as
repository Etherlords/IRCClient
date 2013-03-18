package irc.actions 
{
	import core.services.ServicesLocator;
	
	import irc.IRCMessage;
	
	import irc.services.IRCChannelsService;
	import irc.services.IRCSettingsService;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class QuitAction extends AbstractAction 
	{
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		private var settingsService:IRCSettingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
		
		public function QuitAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			clientQuit(params as IRCMessage)
			
			return super.execute(params);
		}
		
		private function clientQuit(m:IRCMessage):void {
			var reason:String = m.trailing;
			trace('quit acti', m.prefix.nick);
			channelService.clientQuit(m.prefix.nick);
		}
	}

}