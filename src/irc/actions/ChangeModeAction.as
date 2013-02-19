package irc.actions 
{
	import irc.IRCMessage;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ChangeModeAction extends AbstractAction 
	{
		
		public function ChangeModeAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			changedMode(params as IRCMessage);
			
			return super.execute(params);
		}
		
		private function changedMode(m:IRCMessage):void 
		{
			/*var target:String = m.params[0];
			var modeSrc:String = m.params[1];
			
			if (target.match(/^[#$!+]/) != null) 
			{
				if (target in _channels) 
				{
					m.params.shift();
					m.params.shift();
					_channels[target].changedMode(modeSrc, m.params);
				} 
				else 
				{
					pushToServerLog(m);
				}
			} 
			else 
			{
				//var userMode:IRCUserMode = parseUserMode(modeSrc, m);
				pushToServerLog(m);
			}*/
		}
		
	}

}