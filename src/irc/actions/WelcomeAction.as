package irc.actions 
{
	import core.services.ServicesLocator;
	import irc.IRCCommands;
	import irc.IRCUtil;
	import irc.services.IRCConnectionService;
	/**
	 * ...
	 * @author Nikro
	 */
	public class WelcomeAction extends AbstractAction 
	{
		private var connectionService:IRCConnectionService = ServicesLocator.instance.getService(IRCConnectionService) as IRCConnectionService;
		
		public function WelcomeAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			
			//_me = IRCUtil.parseWelcomeMessage(m.trailing);
			//	if (_me == null)
			//		disconnect();
			connectionService.sendMessage(IRCCommands.JOIN, ['#Local'])
			connectionService.sendMessage(IRCCommands.JOIN, ['#Global'])
			connectionService.sendMessage(IRCCommands.JOIN, ['#Trade'])
			connectionService.sendMessage(IRCCommands.JOIN, ['#LFG'])
			return super.execute(params);
		}
	}

}