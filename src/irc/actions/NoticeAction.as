package irc.actions 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class NoticeAction extends AbstractAction 
	{
		
		public function NoticeAction() 
		{
			super();
			
		}
		
		override public function execute(params:IActionParams = null):* 
		{
			return super.execute(params);
			
			trae(params);
		}
		
	}

}