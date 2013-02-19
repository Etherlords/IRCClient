package irc.actions 
{
	import core.services.ServicesLocator;
	import irc.IRCMessage;
	import irc.IRCUtil;
	import irc.model.ChannelMessage;
	import irc.model.IRCChannel;
	import irc.services.CamutatorService;
	import irc.services.IRCChannelsService;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ActionPrivmsg extends AbstractAction 
	{
		
		private var channelService:IRCChannelsService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		private var camutatorService:CamutatorService = ServicesLocator.instance.getService(CamutatorService) as CamutatorService;
		
		private var chMessage:ChannelMessage;
		
		public function ActionPrivmsg() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			receivedPRIVMSG(params as IRCMessage);
			
			if (chMessage)
				camutatorService.addedPrivmsg(chMessage);
			
			return super.execute(params);
		}
		
		private function receivedPRIVMSG(m:IRCMessage):void {
			var target:String = m.params[0];
			var sender:String = m.prefix.nick;
			var message:String = m.trailing;
			
			//trace("received PRIVMSG");
			//trace("target:" + target);
			//trace("sender:" + sender);
			
			var result:Array = IRCUtil.splitAndUnescapeCTCP(message);
			
			chMessage = null;
			
			if (result[0] != null) {
				
				chMessage = new ChannelMessage();
				chMessage.message = result[0];
				chMessage.senderId = sender;
				chMessage.channel = target;
				
				if (target.match(/^[#&!+]/) != null) { // channel
					
					var channel:IRCChannel = channelService.getChannel(target);
					
					if (channel) 
					{
						trace("channel found:" + target);
						channel.receivedPRIVMSG(chMessage);
					} 
					else 
					{
						trace("channel not found:" + target);
						//pushToServerLog(m);
					}
				} 
				
				/*else if (_me != null && target == _me.nick) 
				{ // private talks
					//TODO: тут нужно будет добавить вывод в привты
					trace("target is me");
					//if (!(sender in _privateTalks)) 
					//{
					//	_privateTalks[sender] = _loggerFactory.createPrivateTalk(sender);
					//}
					//_privateTalks[sender].receivedPRIVMSG(sender, result[0]);
				} 
				else 
				{
					//pushToServerLog(m);
				}*/
			}
			if (result[1] != null) {
				// Handle CTCP Request
			}
		
		}
	}

}