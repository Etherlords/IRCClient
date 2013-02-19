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
	public class ChannelMembersAction extends AbstractAction 
	{
		
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		
		public function ChannelMembersAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			rememberChannelMembers(params as IRCMessage);
			
			return super.execute(params);
		}
		
		private function rememberChannelMembers(m:IRCMessage):void {
			var channelName:String = m.params[m.params.length - 1];
			var channel:IRCChannel = channelService.getChannel(channelName);
			
			for each (var user:String in m.trailing.split(/\s+/))
			{
				trace('add user', user);
				channel.addUser(user);
			}
		}
	}

}