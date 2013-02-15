package irc.actions {
	import core.services.ServicesLocator;
	import irc.actions.AbstractAction;
	import irc.actions.IActionParams;
	import irc.IRCCommands;
	import irc.services.IRCConnectionService;
	import irc.services.IRCSettingsService;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class ConnectionAction extends AbstractAction {
		private var settingsService:IRCSettingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
		private var connectionService:IRCConnectionService = ServicesLocator.instance.getService(IRCConnectionService) as IRCConnectionService;
		
		public function ConnectionAction() {
		
		}
		
		override public function execute(params:IActionParams = null):* {
			if (settingsService.settings.password != null && settingsService.settings.password.length > 0)
				connectionService.sendMessage(IRCCommands.PASS, [settingsService.settings.password]);
			
			connectionService.sendMessage(IRCCommands.NICK, [settingsService.settings.nickname]);
			connectionService.sendMessage(IRCCommands.USER, [settingsService.settings.username, settingsService.settings.usermode, "*"], settingsService.settings.realname);
			
			return null;
		}
	
	}

}