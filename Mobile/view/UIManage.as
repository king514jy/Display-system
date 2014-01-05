package view
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import events.MessageEvent;
	
	import view.component.Bottom;
	import view.component.Menu;
	import view.component.Title;
	
	public class UIManage extends Sprite
	{
		private var itemPage:ItemPage;
		private var menu:Menu;
		public function UIManage()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			menu = new Menu();
			menu.x = 12;
			menu.y = 83;
			this.addChild(menu);
			itemPage = new ItemPage();
			this.addChild(itemPage);
			itemPage.widthA = 12+menu.width;
		}
		public function setData(icoList:Vector.<String>,nameList:Vector.<String>,codingList:Vector.<String>):void
		{
			itemPage.setItem(icoList,nameList,codingList);
			itemPage.addEventListener(MessageEvent.SEND_MESSAGE,changeModule,true);
		}
		private function changeModule(e:MessageEvent):void
		{
			
		}
	}
}