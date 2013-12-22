package view
{
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.conmponents.AppRoot;
	import view.conmponents.TipsGroup;
	
	public class TipsGroupMe extends Mediator implements IMediator
	{
		public static const NAME:String="TipsGroupMe";
		private var tipsGroup:TipsGroup;
		private var appRoot:AppRoot;
		public function TipsGroupMe(viewComponent:Object=null)
		{
			super(viewComponent);
			tipsGroup = new TipsGroup();
			appRoot = AppRoot.getInstance();
		}
		public function render(group:Sprite=null):void
		{
			
		}
		public function show(str:String):void
		{
			
		}
	}
}