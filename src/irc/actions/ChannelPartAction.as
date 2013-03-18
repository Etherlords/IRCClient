package irc.actions 
{
	import core.services.ServicesLocator;
	
	import irc.IRCMessage;
	
	import irc.model.IRCChannel;
	
	import irc.names.IRCNameType;
	
	import irc.services.IRCChannelsService;
	import irc.services.IRCSettingsService;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ChannelPartAction extends AbstractAction 
	{
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		private var settingsService:IRCSettingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
		
		public function ChannelPartAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			partChannel(params as IRCMessage)
			
			return super.execute(params);
		}
		
		private function partChannel(m:IRCMessage):void {
			var channelName:String = m.params[0];
			
			channelService.partChannel(channelName, m.prefix.nick);
		}
	}

}