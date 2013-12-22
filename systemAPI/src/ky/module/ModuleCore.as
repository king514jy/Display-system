package ky.module
{
	import flash.display.Sprite;
	
	import ky.module.weather.WeatherData;
	
	public class ModuleCore extends Sprite
	{
		private var _needWeather:Boolean = false;
		public var weatherDataList:Vector.<WeatherData>;
		public function ModuleCore()
		{
			super();
		}
		public function set needWeather(b:Boolean):void
		{ 
			_needWeather = b;
			if(weatherDataList)
				weatherDataList = null;
			weatherDataList = new Vector.<WeatherData>();
		}
		public function get needWeather():Boolean{ return _needWeather;}
		public function init():void
		{
			
		}
		/**
		 * obj 含有一个数据（weatherList:Vector.<WeatherSever>）
		 */
		public function injectWeather(obj:Object):void
		{
			for(var i:int=0;i<=4;i++)
			{
				var weatherData:WeatherData = new WeatherData();
				switch(i)
				{
					case 0:
						weatherData.city = obj.city;
						weatherData.status = obj.status;
						weatherData.direction = obj.direction;
						weatherData.power = obj.power;
						weatherData.temperature1 = obj.temperature1;
						weatherData.temperature2 = obj.temperature2;
						weatherData.tgd1 = obj.tgd1;
						weatherData.day = obj.day;
						break;
					case 1:
						weatherData.city = obj.city;
						weatherData.status = obj.Astatus;
						weatherData.direction = obj.Adirection;
						weatherData.power = obj.Apower;
						weatherData.temperature1 = obj.Atemperature1;
						weatherData.temperature2 = obj.Atemperature2;
						weatherData.tgd1 = obj.Atgd1;
						weatherData.day = obj.day;
						break;
					case 2:
						weatherData.city = obj.city;
						weatherData.status = obj.Bstatus;
						weatherData.direction = obj.Bdirection;
						weatherData.power = obj.Bpower;
						weatherData.temperature1 = obj.Btemperature1;
						weatherData.temperature2 = obj.Btemperature2;
						weatherData.tgd1 = obj.Btgd1;
						weatherData.day = obj.day;
						break;
					case 3:
						weatherData.city = obj.city;
						weatherData.status = obj.Cstatus;
						weatherData.direction = obj.Cdirection;
						weatherData.power = obj.Cpower;
						weatherData.temperature1 = obj.Ctemperature1;
						weatherData.temperature2 = obj.Ctemperature2;
						weatherData.tgd1 = obj.Ctgd1;
						weatherData.day = obj.day;
						break;
					case 4:
						weatherData.city = obj.city;
						weatherData.status = obj.Dstatus;
						weatherData.direction = obj.Ddirection;
						weatherData.power = obj.Dpower;
						weatherData.temperature1 = obj.Dtemperature1;
						weatherData.temperature2 = obj.Dtemperature2;
						weatherData.tgd1 = obj.Dtgd1;
						weatherData.day = obj.day;
						break;
				}
				weatherDataList.push(weatherData);
			}
		}
		public function setWeatherUI():void
		{
			
		}
		public function dispose():void
		{
			
		}
	}
}