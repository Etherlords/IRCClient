package irc.model 
{
	import core.collections.SimpleMap;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCChannelsModel 
	{
		private var _channels:Vector.<IRCChannel>
		private var channelsMap:SimpleMap = new SimpleMap();
		
		public function IRCChannelsModel() 
		{
			
			initilize();
		}
		
		public function addChannel(channel:IRCChannel):void
		{
			_channels.push(channel);
			
			channelsMap.addItem(channel.name.toLocaleLowerCase(), channel);
		}
		
		public function getChannel(channelName:String):IRCChannel
		{
			return channelsMap.getItem(channelName.toLocaleLowerCase());
		}
		
		private function initilize():void 
		{
			_channels = new Vector.<IRCChannel>;
		}
		
		public function get channels():Vector.<IRCChannel> 
		{
			return _channels;
		}
		
	}

}