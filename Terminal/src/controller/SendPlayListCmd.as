package controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendPlayListCmd extends SimpleCommand
	{
		public function SendPlayListCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			
		}
	}
}