package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import irc.model.IRCServerSettingModel;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCSettingsService extends AbstractService 
	{
		private var _settings:IRCServerSettingModel
		
		public function IRCSettingsService() 
		{
			super();
			
			initilize();
		}
		
		private function initilize():void 
		{
			_settings = new IRCServerSettingModel();
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			
		}
		
		public function get settings():IRCServerSettingModel 
		{
			return _settings;
		}
		
	}

}