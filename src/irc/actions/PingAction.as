package irc.actions 
{
	import core.services.ServicesLocator;
	import irc.IRCCommands;
	import irc.services.IRCConnectionService;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PingAction extends AbstractAction 
	{
		private var connectionService:IRCConnectionService = ServicesLocator.instance.getService(IRCConnectionService) as IRCConnectionService;
		
		public function PingAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			connectionService.sendMessage(IRCCommands.PONG, [params.trailing]);
			
			return super.execute(params);
		}
		
	}

}