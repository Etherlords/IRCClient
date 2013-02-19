package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.events.MessageEvents;
	import irc.model.ChannelMessage;
	
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
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
			initilize();
		}
		
		public function addedPrivmsg(message:ChannelMessage):void
		{
			var evnt:MessageEvents = new MessageEvents(MessageEvents.MESSAGE_ADDED, false, false, message);
			dispatchEvent(evnt);
			
			trace('camult message', message);
		}
		
		private function initilize():void 
		{
			channelService = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
		}
		
	}

}