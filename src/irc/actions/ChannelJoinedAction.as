package irc.actions 
{
	import core.services.ServicesLocator;
	import irc.IRCMessage;
	import irc.model.IRCChannel;
	import irc.services.IRCChannelsService;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ChannelJoinedAction extends AbstractAction 
	{
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		
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
			
			channelService.joinChannel(channel);
			//dispatchEvent(new IRCEvent(IRCEvent.JOINED));
		}
	}

}