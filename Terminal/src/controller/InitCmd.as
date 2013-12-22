package controller
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	public class InitCmd extends MacroCommand
	{
		public function InitCmd()
		{
			super();
		}
		override protected function initializeMacroCommand():void
		{
			this.addSubCommand(LoadWeatherCmd);
			this.addSubCommand(SetPlayConfigCmd);
			this.addSubCommand(StartNetworkCmd);
		}
	}
}