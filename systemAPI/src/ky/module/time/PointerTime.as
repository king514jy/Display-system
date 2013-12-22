package ky.module.time
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class PointerTime extends TimeBase
	{
		private var secondSpr:Sprite;
		private var minuteSpr:Sprite;
		private var hourSpr:Sprite;
		private var second:Number;
		private var minute:Number;
		private var hour:Number;
		private var date:Date;
		private var graduate:uint = 6;
		private var graduate2:uint = 30;
		private var timer:Timer;
		private var secondSpeed:Number;
		public function PointerTime()
		{
			super();
		}
		public function initPointer(hourSpr:Sprite,minuteSpr:Sprite,secondSpr:Sprite=null,secondSpeed:Number=1000):void
		{
			this.hourSpr = hourSpr;
			this.minuteSpr = minuteSpr;
			if(secondSpr)
				this.secondSpr = secondSpr;
			date = new Date();
			second = date.getSeconds();
			minute = date.getMinutes();
			hour = date.getHours();
			secondSpr.rotation = graduate * second;
			minuteSpr.rotation = graduate * minute + second * 0.1;
			hourSpr.rotation = graduate2 * hour + minute * 0.5;
			this.secondSpeed = secondSpeed;
			timer = new Timer(secondSpeed);
			timer.addEventListener(TimerEvent.TIMER,run);
			timer.start();
		}
		private function run(e:TimerEvent):void
		{
			date.setTime(date.valueOf() + secondSpeed);
			second = date.getSeconds();
			minute = date.getMinutes();
			hour = date.getHours();
			secondSpr.rotation = graduate * second;
			minuteSpr.rotation = graduate * minute + second * 0.1;
			hourSpr.rotation = graduate2 * hour + minute * 0.5;
		}
		public function dispose():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, run);
			timer = null;
			date = null;
			secondSpr = null;
			minuteSpr = null;
			hourSpr = null;
		}
	}
}