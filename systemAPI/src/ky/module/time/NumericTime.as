package ky.module.time
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	public class NumericTime extends TimeBase
	{
		private var hourTxt:TextField;
		private var minuteTxt:TextField;
		private var dot:Sprite;
		private var secondTxt:TextField;
		private var timer:Timer;
		private var dotVisible:Boolean;
		public function NumericTime()
		{
			super();
		}
		public function init(hourTxt:TextField,minuteTxt:TextField,dot:Sprite=null,secondTxt:TextField=null):void
		{
			this.hourTxt = hourTxt;
			this.minuteTxt = minuteTxt;
			if(dot)
				this.dot = dot;
			if(secondTxt)
				this.secondTxt = secondTxt;
			timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER,run);
			timer.start();
		}
		private function run(e:TimerEvent):void
		{
			if(dot)
			{
				dotVisible = !dotVisible;
				dot.visible = dotVisible;
			}
			setTime();
		}
		private function setTime():void
		{
			var date:Date = new Date();
			var hour:int = date.getHours();
			var minute:int = date.getMinutes();
			if (hour < 10)
				hourTxt.text = "0" + String(hour);
			else
				hourTxt.text = String(hour);
			if (minute < 10)
				minuteTxt.text = "0"+String(minute);
			else
				minuteTxt.text = String(minute);
		}
	}
}