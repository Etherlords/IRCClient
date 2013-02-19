package irc.model 
{
	import core.collections.SimpleMap;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCChannelsModel 
	{
		private var channels:Vector.<IRCChannel>
		private var channelsMap:SimpleMap = new SimpleMap();
		
		public function IRCChannelsModel() 
		{
			
			initilize();
		}
		
		public function addChannel(channel:IRCChannel):void
		{
			channels.push(channel);
			channelsMap.addItem(channel.name, channel);
		}
		
		public function getChannel(channelName:String):IRCChannel
		{
			return channelsMap.getItem(channelName);
		}
		
		private function initilize():void 
		{
			channels = new Vector.<IRCChannel>;
		}
		
	}

}