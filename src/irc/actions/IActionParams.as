package irc.actions 
{
	import flash.utils.ByteArray;
	import irc.IRCMessage;
	import irc.names.IIRCName;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IActionParams 
	{
		
		function isNumericReply():Boolean;
		
		function toLine():String;
		
		function toString():String;
		
		function valueOf():String;
		
		function copy():IRCMessage;
		
		function toByteArray():ByteArray;
		
		function get trailing():String;
		
		function get params():Array;
		
		function get prefix():IIRCName;
		
		function get command():String;
	}
	
}