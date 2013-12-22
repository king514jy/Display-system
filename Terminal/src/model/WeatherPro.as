package model
{
	import flash.events.Event;
	
	import ky.module.weather.WeatherSever;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class WeatherPro extends Proxy implements IProxy
	{
		public static const NAME:String = "WeatherPro";
		private var weatherList:Vector.<WeatherSever>;
		private var count:int;
		private var _complete:Boolean;
		private var _wait:Boolean;
		public var weatherObj:Object;
		public function WeatherPro(proxyName:String=null, data:Object=null)
		{
			super(NAME, data);
			weatherList = new Vector.<WeatherSever>();
			weatherObj = new Object();
		}
		public function get complete():Boolean{ return _complete; }
		public function set wait(b:Boolean):void{ _wait = b; }
		public function loadData(city:String):void
		{
			for(var i:int=0;i<=4;i++)
			{
				var weatherSever:WeatherSever = new WeatherSever();
				weatherSever.load("loadOver",i);
				weatherSever.addEventListener("loadOver",removeListener);
				weatherList.push(weatherSever);
			}
		}
		private function removeListener(e:Event):void
		{
			var weatherSever:WeatherSever = e.target as WeatherSever;
			var id:int = weatherSever.day;
			switch(id)
			{
				case 0:
					weatherObj.city = weatherSever.city;
					weatherObj.status = weatherSever.status;
					weatherObj.direction = weatherSever.direction;
					weatherObj.power = weatherSever.power;
					weatherObj.temperature1 = weatherSever.temperature1;
					weatherObj.temperature2 = weatherSever.temperature2;
					weatherObj.tgd1 = weatherSever.tgd1;
					weatherObj.day = weatherSever.day;
					break;
				case 1:
					weatherObj.city = weatherSever.city;
					weatherObj.Astatus = weatherSever.status;
					weatherObj.Adirection = weatherSever.direction;
					weatherObj.Apower = weatherSever.power;
					weatherObj.Atemperature1 = weatherSever.temperature1;
					weatherObj.Atemperature2 = weatherSever.temperature2;
					weatherObj.Atgd1 = weatherSever.tgd1;
					weatherObj.day = weatherSever.day;
					break;
				case 2:
					weatherObj.city = weatherSever.city;
					weatherObj.Bstatus = weatherSever.status;
					weatherObj.Bdirection = weatherSever.direction;
					weatherObj.Bpower = weatherSever.power;
					weatherObj.Btemperature1 = weatherSever.temperature1;
					weatherObj.Btemperature2 = weatherSever.temperature2;
					weatherObj.Btgd1 = weatherSever.tgd1;
					weatherObj.day = weatherSever.day;
					break;
				case 3:
					weatherObj.city = weatherSever.city;
					weatherObj.Cstatus = weatherSever.status;
					weatherObj.Cdirection = weatherSever.direction;
					weatherObj.Cpower = weatherSever.power;
					weatherObj.Ctemperature1 = weatherSever.temperature1;
					weatherObj.Ctemperature2 = weatherSever.temperature2;
					weatherObj.Ctgd1 = weatherSever.tgd1;
					weatherObj.day = weatherSever.day;
					break;
				case 4:
					weatherObj.city = weatherSever.city;
					weatherObj.Dstatus = weatherSever.status;
					weatherObj.Ddirection = weatherSever.direction;
					weatherObj.Dpower = weatherSever.power;
					weatherObj.Dtemperature1 = weatherSever.temperature1;
					weatherObj.Dtemperature2 = weatherSever.temperature2;
					weatherObj.Dtgd1 = weatherSever.tgd1;
					weatherObj.day = weatherSever.day;
					break;
			}
			weatherList[id].removeEventListener("loadOver",removeListener);
			count++;
			if(count>4)
			{
				_complete = true;
				if(_wait)
					this.sendNotification(DisplaySystemFacade.LOAD_WEATHER_COMPLETE);
			}
		}
	}
}