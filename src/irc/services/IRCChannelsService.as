package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.model.IRCChannel;
	import irc.model.IRCChannelsModel;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCChannelsService extends AbstractService 
	{
		private var channelsPool:IRCChannelsModel;
		
		public function IRCChannelsService() 
		{
			super();
			
		}
		
		public function joinChannel(channel:IRCChannel):void
		{
			channelsPool.addChannel(channel);
			trace('channel added', channel.name);
		}
		
		public function getChannel(channelName:String):IRCChannel
		{
			return channelsPool.getChannel(channelName);
		}
		
		private function initilize():void 
		{
			channelsPool = new IRCChannelsModel();
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
			initilize();
			
		}
		
		
	}

}