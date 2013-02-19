package irc.loggers
{

    import irc.IRCPrivateTalk;
    import irc.IRCServer;
	import irc.model.IRCChannel;

    public interface IChatLoggerFactory
    {
        function createChannel(channelName:String):IRCChannel;
        function createPrivateTalk(sender:String):IRCPrivateTalk;
        function createServerLogger(host:String, port:uint):IRCServer;
    }
}

