package irc.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class JoinEvents extends Event 
	{
		private var _channel:String;
		private var _user:String;
		
		public static const MEMBERS_UPDATED:String = 'membersUpdated';
		public static const USER_JOIN:String = 'userJoin';
		public static const USER_PART:String = 'userPart';
		public static const CHANNEL_JOIN:String = 'channelJoin';
		public static const USER_QUIT:String = 'userQuit';
		
		public function JoinEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false, channel:String = '', user:String = '') 
		{
			super(type, bubbles, cancelable);
			_user = user;
			_channel = channel;
		}
		
		override public function clone():Event 
		{
			return new JoinEvents(type, bubbles, cancelable, _channel, _user);
		}
		
		public function get channel():String 
		{
			return _channel;
		}
		
		public function get user():String 
		{
			return _user;
		}
		
	}

}