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
	public class ChannelJoinedAction extends AbstractAction 
	{
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		private var settingsService:IRCSettingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
		
		public function ChannelJoinedAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			joinedChannel(params as IRCMessage)
			
			return super.execute(params);
		}
		
		private function joinedChannel(m:IRCMessage):void {
			var channelName:String = m.trailing;
			var channel:IRCChannel = new IRCChannel(channelName);
			
			if (m.prefix.nick == settingsService.serverSettings.nickname)
			{
				channelService.joinChannel(channel);
			}
			else if (m.prefix.type == IRCNameType.USER)
			{
				channelService.addUser(channelName, m.prefix.nick);// (channelName).addUser(m.prefix.nick);
			}
			
			//dispatchEvent(new IRCEvent(IRCEvent.JOINED));
		}
	}

}