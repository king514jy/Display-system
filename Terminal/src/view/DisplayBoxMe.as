package view
{
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.conmponents.DisplayBox;
	import view.events.GetDataEvent;
	
	public class DisplayBoxMe extends Mediator implements IMediator
	{
		public static const NAME:String = "DisplayBoxMe";
		private var displayBox:DisplayBox;
		public function DisplayBoxMe(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			displayBox = new DisplayBox();
			displayBox.addEventListener(GetDataEvent.GET_WEATHER,getWeather);
		}
		public function setData(obj:Object):void
		{
			if(obj.hasOwnProperty("interval"))
				displayBox.interval = obj.interval * 60 * 1000;
			if(obj.hasOwnProperty("defaultPlay"))
				displayBox.defaultPlay = obj.defaultPlay;
			if(obj.hasOwnProperty("fixAnimationValue"))
				displayBox.fixAnimationValue = obj.fixAnimationValue;
			if(obj.hasOwnProperty("codingList"))
				displayBox.codingList = obj.codingList;
			displayBox.start(obj.cutover);
		}
		public function render(group:Sprite):void
		{
			group.addChild(displayBox);
		}
		private function getWeather(e:GetDataEvent):void
		{
			this.sendNotification(DisplaySystemFacade.GET_WEATHER);
		}
		public function injectWeather(obj:Object):void
		{
			displayBox.module.injectWeather(obj);
			displayBox.module.setWeatherUI();
		}
		public function changeModule(coding:String):void
		{
			displayBox.changeModule(coding);
		}
	}
}