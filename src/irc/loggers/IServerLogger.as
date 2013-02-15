package irc.loggers
{
    import irc.IRCMessage;

    public interface IServerLogger
    {
        function receivedMessage(m:IRCMessage):void;
    }
}

