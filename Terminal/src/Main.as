package
{
	import com.kingclass.debug.Debug;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import view.conmponents.AppRoot;

	[SWF(width="1920",height="1080",backgroundColor="#000000",frameRate="30")]
	public class Main extends Sprite
	{
		private var appRoot:AppRoot;
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.align = StageAlign.TOP_LEFT;
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			//Security.allowDomain(
			//this.addChild(new Debug());
			appRoot = AppRoot.getInstance();
			appRoot.root = this;
			appRoot.stageW = stage.stageWidth;
			appRoot.stageH = stage.stageHeight;
			DisplaySystemFacade.getInstance().startup();
		}
	}
}