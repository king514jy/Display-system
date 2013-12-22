package controller
{
	import model.WeatherPro;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.DisplayBoxMe;
	
	public class GetWeatherSecondCmd extends SimpleCommand
	{
		public function GetWeatherSecondCmd()
		{
			super();
		}
		override public function execute(notification:INotification):void
		{
			var weatherPro:WeatherPro = this.facade.retrieveProxy(WeatherPro.NAME) as WeatherPro;
			var displayBoxMe:DisplayBoxMe = this.facade.retrieveMediator(DisplayBoxMe.NAME) as DisplayBoxMe;
			displayBoxMe.injectWeather(weatherPro.weatherObj);
			this.facade.removeCommand(DisplaySystemFacade.LOAD_WEATHER_COMPLETE);
		}
	}
}