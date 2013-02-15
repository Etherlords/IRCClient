package irc.actions 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractAction implements IAction
	{
		
		public function AbstractAction() 
		{
			
		}
		
		/* INTERFACE irc.actions.IAction */
		
		public function execute(params:IActionParams = null):* 
		{
			return null
		}
		
	}

}