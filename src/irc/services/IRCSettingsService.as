package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.model.IRCServerSettingModel;
	import irc.model.IRCSettingsModel;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCSettingsService extends AbstractService 
	{
		private var _serverSettings:IRCServerSettingModel
		private var _ircSettings:IRCSettingsModel;
		
		public function IRCSettingsService() 
		{
			super();
			
			initilize();
		}
		
		private function initilize():void 
		{
			_serverSettings = new IRCServerSettingModel();
			_ircSettings = new IRCSettingsModel();
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
		}
		
		public function get serverSettings():IRCServerSettingModel 
		{
			return _serverSettings;
		}
		
		public function get ircSettings():IRCSettingsModel 
		{
			return _ircSettings;
		}
		
	}

}