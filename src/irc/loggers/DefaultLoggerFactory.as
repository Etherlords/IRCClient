package irc.loggers
{
    import irc.IRCChannel;
    import irc.IRCPrivateTalk;
    import irc.IRCServer;

    public class DefaultLoggerFactory implements IChatLoggerFactory
    {
        public function createChannel(channelName:String):IRCChannel
        {
            return new IRCChannel(channelName);
        }

        public function createPrivateTalk(senderNick:String):IRCPrivateTalk
        {
            return new IRCPrivateTalk(senderNick);
        }

        public function createServerLogger(host:String, port:uint):IRCServer
        {
            return new IRCServer(host, port);
        }
    }
}

