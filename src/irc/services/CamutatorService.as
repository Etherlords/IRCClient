package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.events.MessageEvents;
	import irc.model.ChannelMessage;
	import irc.model.IRCChannel;
	import irc.utils.filter.MessageFilter;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class CamutatorService extends AbstractService 
	{
		
		private var channelService:IRCChannelsService
		
		public function CamutatorService() 
		{
			super();
			
		}
		
		public function getUsers(filter:MessageFilter):Vector.<String> 
		{
			var filtredChannels:Vector.<IRCChannel> = filterChannels(channelService.channels, filter);
			var users:Vector.<String> = new Vector.<String>();
			
			for (var i:int = 0; i < filtredChannels.length; i++)
			{
				users = users.concat(filtredChannels[i].userNicks);
			}
			
			
			return users;
		}
		
		public function getMessages(filter:MessageFilter):Vector.<ChannelMessage>
		{
			var filtredChannels:Vector.<IRCChannel> = filterChannels(channelService.channels, filter)
			var messages:Vector.<ChannelMessage> = new Vector.<ChannelMessage>;
			
			for (var i:int = 0; i < filtredChannels.length; i++)
			{
				messages = messages.concat(filtredChannels[i].messagesLog);
			}
			
			messages = messages.sort(timeSorting);
			
			return messages;
		}
		
		private function timeSorting(x:ChannelMessage, y:ChannelMessage):int 
		{
			if (x.time > y.time)
				return -1;
			else
				return 1;
				
			return 0;
		}
		
		private function filterChannels(v:Vector.<IRCChannel>, filter:MessageFilter):Vector.<IRCChannel>
		{
			var filterChannels:Vector.<IRCChannel> = new Vector.<IRCChannel>;
			var vlen:int = v.length;
			var chan:IRCChannel;
			var pass:Boolean = true;
			
			for (var i:int = 0; i < vlen; i++)
			{
				chan = v[i];
				pass = true;
				
				if (filter.channelPrivatFiltering == MessageFilter.OPTION_YES)
					pass = chan.isPrivate
				else if (filter.channelPrivatFiltering == MessageFilter.OPTION_NO)
					pass = !chan.isPrivate
					
				if (!pass)
					continue
				
				if(filter.channelsNameFiltring == MessageFilter.OPTION_YES)
					pass = filter.isChannelPassed(chan.name)
					
				if (!pass)
					continue
				
				if (pass)
					filterChannels.push(chan);
			}
			
			return filterChannels;
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
			initilize();
		}
		
		public function addedPrivmsg(message:ChannelMessage):void
		{
			var evnt:MessageEvents = new MessageEvents(MessageEvents.MESSAGE_ADDED, false, false, message);
			dispatchEvent(evnt);
		}
		
		
		private function initilize():void 
		{
			channelService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		}
		
	}

}