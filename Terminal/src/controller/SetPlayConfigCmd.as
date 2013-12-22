package controller
{
	import ky.enumerate.CutoverMode;
	
	import model.ConfigProxy;
	import model.vo.PlayItem;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.DisplayBoxMe;
	import view.conmponents.AppRoot;
	
	public class SetPlayConfigCmd extends SimpleCommand
	{
		public function SetPlayConfigCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			var configPro:ConfigProxy = this.facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy
			var displayMe:DisplayBoxMe = this.facade.retrieveMediator(DisplayBoxMe.NAME) as DisplayBoxMe;
			var appRoot:AppRoot = AppRoot.getInstance();
			var obj:Object = new Object();
			if(configPro.cutoverValue == CutoverMode.SINGLE)
				obj.defaultPlay = configPro.defaultCoding;
			if(configPro.fixAnimationValue.switchBtn)
				obj.fixAnimationValue = configPro.fixAnimationValue;
			obj.cutover = configPro.cutoverValue;
			obj.interval = configPro.intervalValue;
			var codingList:Vector.<String> = new Vector.<String>();
			for each(var item:PlayItem in configPro.playList)
			{
				codingList.push(item.coding);
			}
			obj.codingList = codingList;
			displayMe.setData(obj);
			displayMe.render(appRoot.root);
		}
	}
}