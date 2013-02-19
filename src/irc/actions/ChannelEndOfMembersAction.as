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
	public class ChannelEndOfMembersAction extends AbstractAction 
	{
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		
		public function ChannelEndOfMembersAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			//Тут нужно будет разделать модераторов и почее от юзеров, если нужно будет
			//updateChannelMembers(params as IRCMessage);
			
			return super.execute(params);
		}
		
		private function updateChannelMembers(m:IRCMessage):void 
		{
			/*for (var channelName:String in _names) 
			{
				if (channelName in _channels) 
				{
					var channel:IRCChannel = _channels[channelName];
					channel.clearMembers();
					for each (var user:String in _names[channelName]) 
					{
						if (user.charAt(0) == '@')
							channel.addOperator(user.substring(1));
						else
							channel.addUser(user);
					}
					channel.updatedMembers();
				}
				delete _names[channelName];
			}*/
		}
	}

}