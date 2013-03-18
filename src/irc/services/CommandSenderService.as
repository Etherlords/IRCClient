package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.IRCCommands;
	import irc.model.SendCommands;
	/**
	 * ...
	 * @author Nikro
	 */
	public class CommandSenderService extends AbstractService
	{
		private var _commands:Object
		
		private function get commands():Object
		{
			if (!_commands)
			{
				_commands = { };
				_commands[SendCommands.PRIVATE_SEND] = privateMesasge;
			}
			
			return _commands;
		}
		
		private var connectionService:IRCConnectionService = ServicesLocator.instance.getService(IRCConnectionService) as IRCConnectionService;
		private var settingsService:IRCSettingsService = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
		
		public function CommandSenderService() 
		{
			super();
		}
		
		public function sendCommand(command:String):void
		{
			var parts:Array = command.split(' ');
			
			var commandIdnet:String = parts[0];
			
			if (commands.hasOwnProperty(commandIdnet))
			{
				commands[commandIdnet](parts);
				return;
			}
			
			standartMessage(command);
		}
		
		
		private function standartMessage(command:String):void 
		{
			connectionService.sendMessage(IRCCommands.PRIVMSG, [settingsService.ircSettings.currentChannel], command);
		}
		
		private function privateMesasge(parts:Array):void 
		{
			parts.shift();
			
			var reciptient:String = parts.shift();
			
			connectionService.sendMessage(IRCCommands.PRIVMSG, [reciptient], parts.join(''));
		}
	}
}