package irc.events 
{
	import flash.events.Event;
	import irc.model.ChannelMessage;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class MessageEvents extends Event 
	{
		private var _message:ChannelMessage;
		
		public static const MESSAGE_ADDED:String = 'messageAdded';
		
		public function MessageEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false, message:ChannelMessage = null) 
		{
			super(type, bubbles, cancelable);
			_message = message;
		}
		
		override public function clone():Event 
		{
			return new MessageEvents(type, bubbles, cancelable, message);
		}
		
		public function get message():ChannelMessage 
		{
			return _message;
		}
		
	}

}