package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.events.IRCEvent;
	import irc.events.JoinEvents;
	
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
		
		public function get channels():Vector.<IRCChannel>
		{
			return channelsPool.channels;
		}
		
		public function updateChannelMembers(chan:String):void 
		{
			dispatchEvent(new JoinEvents(JoinEvents.MEMBERS_UPDATED, false, false, chan)) 
		}
		
		public function clientQuit(nick:String):void
		{
			for (var i:int = 0; i < channelsPool.channels.length; i++)
			{
				channelsPool.channels[i].leaved(nick);
			}
			
			dispatchEvent(new JoinEvents(JoinEvents.USER_QUIT, false, false, '', nick)) 
		}
		
		public function partChannel(channelName:String, nick:String):void 
		{
			getChannel(channelName).leaved(nick);
			
			dispatchEvent(new JoinEvents(JoinEvents.USER_PART, false, false, channelName, nick)) 
		}
		
		public function addUser(channelName:String, nick:String):void 
		{
			getChannel(channelName).addUser(nick);
			
			dispatchEvent(new JoinEvents(JoinEvents.USER_JOIN, false, false, channelName, nick)) 
		}
		
		public function joinChannel(channel:IRCChannel):void
		{
			
			channelsPool.addChannel(channel);
			dispatchEvent(new JoinEvents(JoinEvents.CHANNEL_JOIN, false, false, channel.name))
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