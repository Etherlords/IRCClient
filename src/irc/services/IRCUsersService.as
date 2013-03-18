package irc.services 
{
	import core.services.AbstractService;
	import core.services.ServicesLocator;
	import flash.events.Event;
	import ui.irc.events.RowEvent;
	
	import irc.events.JoinEvents;
	
	import irc.services.CamutatorService;
	
	import irc.utils.filter.MessageFilter;
	
	import ui.irc.TIRCUsersListGridData;
	
	import vcl.core.TApplication;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class IRCUsersService extends AbstractService 
	{
		private var channels:IRCChannelsService;
		private var dataGridModel:TIRCUsersListGridData;
		private var settings:IRCSettingsService;
		private var camutator:CamutatorService;
		private var usersToShow:Vector.<String>;
		
		public function IRCUsersService() 
		{
			super();
			
		}
		
		override public function registred(serviceLocator:ServicesLocator):void 
		{
			super.registred(serviceLocator);
			initilize();
		}
		
		private function initilize():void 
		{
			dataGridModel = new TIRCUsersListGridData();
			TApplication.GetInstance().AddGridDataProvider( "GridData",  dataGridModel);
			
			settings = ServicesLocator.instance.getService(IRCSettingsService) as IRCSettingsService;
			camutator = ServicesLocator.instance.getService(CamutatorService) as CamutatorService;
			
			channels = ServicesLocator.instance.getService(IRCChannelsService) as IRCChannelsService;
			channels.addEventListener(JoinEvents.CHANNEL_JOIN, updateUsers);
			channels.addEventListener(JoinEvents.USER_JOIN, updateUsers);
			channels.addEventListener(JoinEvents.USER_PART, updateUsers);
			channels.addEventListener(JoinEvents.MEMBERS_UPDATED, updateUsers);
			channels.addEventListener(JoinEvents.USER_QUIT, updateUsers);
			
			dataGridModel.onRowClickEvent = onRowClicked
		}
		
		private function onRowClicked(data:String):void 
		{
			dispatchEvent(new RowEvent(RowEvent.CLICKED, false, false, data));
		}
		
		private function usersFilterFunction(element:String, index:int, vector:Vector.<String>):Boolean
		{
			return (element != this.settings.serverSettings.nickname)
				
		}
		
		private function updateUsers(e:JoinEvents):void 
		{
			
			
			if (e.type != JoinEvents.USER_QUIT)
			{
				updateList();
				return;
			}
			
			if (e.user && e.type != JoinEvents.USER_PART && e.channel == settings.ircSettings.mainChannel)
			{
				dataGridModel.DataModel.push(e.user)
				dataGridModel.Update();
			}
			else
			{
				updateList();
				
			}
			
		}
		
		private function updateList():void
		{
			var usersFilter:MessageFilter = new MessageFilter();
			usersFilter.nameFilttring();
			usersFilter.addChannel(settings.ircSettings.mainChannel);
			
			usersToShow = camutator.getUsers(usersFilter).filter(usersFilterFunction, settings.serverSettings);
			dataGridModel.DataModel = usersToShow;
		}
		
	}

}