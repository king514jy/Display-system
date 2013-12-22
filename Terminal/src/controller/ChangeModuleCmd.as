package controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.DisplayBoxMe;
	
	public class ChangeModuleCmd extends SimpleCommand
	{
		public function ChangeModuleCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			var me:DisplayBoxMe = this.facade.retrieveMediator(DisplayBoxMe.NAME) as DisplayBoxMe;
			var coding:String = notification.getType();
			me.changeModule(coding);
		}
	}
}