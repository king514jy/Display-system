package controller
{
	import model.WeatherPro;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.DisplayBoxMe;
	
	public class GetWeatherCmd extends SimpleCommand
	{
		public function GetWeatherCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			var weatherPro:WeatherPro = this.facade.retrieveProxy(WeatherPro.NAME) as WeatherPro;
			var displayBoxMe:DisplayBoxMe = this.facade.retrieveMediator(DisplayBoxMe.NAME) as DisplayBoxMe;
			if(weatherPro.complete)
			{
				displayBoxMe.injectWeather(weatherPro.weatherObj);
			}
			else
			{
				weatherPro.wait = true;
				this.facade.registerCommand(DisplaySystemFacade.LOAD_WEATHER_COMPLETE,GetWeatherSecondCmd);
			}
		}
	}
}