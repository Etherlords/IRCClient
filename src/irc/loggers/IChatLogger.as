package irc.loggers
{
    import irc.IRCMessage;
	import irc.model.ChannelMessage;

    public interface IChatLogger
    {
        function receivedPRIVMSG(message:ChannelMessage):void;
        function receivedNOTICE(sender:String, message:String):void;
        function receivedMessage(m:IRCMessage):void;
        function sendPRIVMSG(me:String, message:String):void;
        function sendNOTICE(me:String, message:String):void;
    }
}

