package irc.model
{
    public class IRCServerSettingModel
    {
		static private const RECONNECTION_INTERVAL:Number = 5;
		static private const DEFAULT_PORT:Number = 6667;
		
        public var host:String;
        public var port:uint;
        public var overTLS:Boolean;
        public var password:String;
        public var username:String;
        public var usermode:String;
        public var realname:String;
        public var nickname:String;
        public var presetChannels:Array;
        public var reconnectionAcceptableInterval:uint;
        public var reconnectionMaxCountWithinInterval:uint;

        public function IRCServerSettingModel()
        {
            host           = "";
            username       = "";
            realname       = "";
            nickname       = "";
            password       = "";
			
            port           = DEFAULT_PORT;
			
            overTLS        = false;
            usermode       = IRCUserMode.NUM_NORMAL;
            presetChannels = [];

            reconnectionAcceptableInterval     = RECONNECTION_INTERVAL;
            reconnectionMaxCountWithinInterval = 60 * RECONNECTION_INTERVAL;

        }
    }
}

