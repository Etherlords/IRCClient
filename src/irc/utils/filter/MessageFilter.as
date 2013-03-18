package irc.utils.filter 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class MessageFilter 
	{
		public static var OPTION_NO:String = 'no';
		public static var OPTION_ANY:String = 'any';
		public static var OPTION_YES:String = 'yes';
		
		private var _channels:Object = { };
		
		private var _channelsNameFiltring:String = OPTION_NO;
		private var _channelPrivatFiltering:String = OPTION_ANY;
		
		public function MessageFilter() 
		{
			
		}
		
		public function noNameFiltring():void
		{
			_channelsNameFiltring = OPTION_NO;
		}
		
		public function nameFilttring():void
		{
			_channelsNameFiltring = OPTION_YES
		}
		
		public function onlyPrivatOption():void
		{
			_channelPrivatFiltering = OPTION_YES
		}
		
		public function isChannelPassed(channel:String):Boolean
		{
			return _channels[channel.toLocaleLowerCase()] == 1;
		}
		
		public function allChannels():void
		{
			_channelPrivatFiltering = OPTION_ANY
		}
		
		public function clearChannels():void
		{
			_channels = { };
		}
		
		public function addChannel(chan:String):void
		{
			_channels[chan.toLocaleLowerCase()] = 1;
		}
		
		public function removeChannel(chan:String):void
		{
			delete _channels[chan.toLocaleLowerCase()];
		}
		
		public function get channelPrivatFiltering():String 
		{
			return _channelPrivatFiltering;
		}
		
		public function get channels():Object 
		{
			return _channels;
		}
		
		public function get channelsNameFiltring():String 
		{
			return _channelsNameFiltring;
		}
		
		
		
	}

}