package irc.loggers
{
    import irc.IRCChannel;
    import irc.IRCPrivateTalk;
    import irc.IRCServer;

    public interface IChatLoggerFactory
    {
        function createChannel(channelName:String):IRCChannel;
        function createPrivateTalk(sender:String):IRCPrivateTalk;
        function createServerLogger(host:String, port:uint):IRCServer;
    }
}

