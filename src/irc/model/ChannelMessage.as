package irc.model 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class ChannelMessage 
	{
		public static var FORMAT_FUNCTION:Function;
		
		public var channel:String;
		public var message:String;
		public var senderId:String;
		public var time:int;
		public var type:String = '';
		
		static private var colors:Object = 
									{
										'#Global':'#AAAAAA', '#Local':'#ff5555',
										'#Private':"#aa00aa", '#LFG':'#ffaa00',
										'#Trade':'#5555ff'
									}
		
		
		public function ChannelMessage() 
		{
			
		}
		
		public function toString():String
		{
			if (Boolean(FORMAT_FUNCTION))
				return FORMAT_FUNCTION(this);
				
			return /*time + '|' + */channel + ' ' + senderId + ': ' + message; 
		}
		
		static public function standartChannelFormating(message:ChannelMessage):String 
		{
			var color:String = '#FFFFFF';
			
			if (message.channel in colors)
				color = colors[message.channel];
			
			return "<FONT color='"+color+"'>"+message.message+"</FONT>";
		}
		
	}

}