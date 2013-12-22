package view.conmponents
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import ky.enumerate.CutoverMode;
	import ky.module.ModuleCore;
	
	import model.vo.FixAnimationValue;
	
	import view.events.GetDataEvent;
	public class DisplayBox extends Sprite
	{
		private var cutover:String;
		public var animation:String;
		/**
		 * 切换间隔(毫秒);
		 */
		public var interval:Number;
		public var defaultPlay:String;
		public var fixAnimationValue:FixAnimationValue;
		public var codingList:Vector.<String>;
		private var moduleFactory:ModuleFactory;
		private var oldTime:Number;
		private var nowTime:Number;
		private var nowModule:ModuleCore;
		private var moduleAddress:String;
		private var newMain:Object;
		private var spr:Sprite;
		private var nextCoding:String;
		public function DisplayBox()
		{
			var file:File = File.applicationStorageDirectory.resolvePath("module/");
			//var file:File = File.applicationDirectory.resolvePath("module/");
			moduleAddress = file.url;
		}
		public function get module():Object{ return newMain };
		public function start(cutover:String):void
		{
			this.cutover = cutover;
			moduleFactory = new ModuleFactory(codingList,cutover);
			if(cutover == CutoverMode.SINGLE)
				singlePlay();
			else
				multiplePlay();
		}
		private function singlePlay():void
		{
			loadModule(defaultPlay);
		}
		private function multiplePlay():void
		{
			loadModule(moduleFactory.coding);
			oldTime = getTimer();
			this.addEventListener(Event.ENTER_FRAME,run);
		}
		private function loadModule(coding:String):void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(moduleAddress+File.separator+coding+File.separator+"main.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
			//loader.load(new URLRequest("module/0/main.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
		}
		private function complete(e:Event):void
		{
			var loader:Loader = LoaderInfo(e.target).loader;
			var main:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("Main") as Class;
			newMain = new main();
			spr = newMain as Sprite;
			this.addChild(spr);
			newMain.init();
			openModule();
			if(newMain.needWeather)
			{
				dispatchEvent(new GetDataEvent(GetDataEvent.GET_WEATHER));
			}
		}
		private function run(e:Event):void
		{
			nowTime = getTimer();
			if(nowTime - oldTime >= interval)
			{
				oldTime = getTimer();
				nextCoding = moduleFactory.coding;
				closeModule();
			}
		}
		public function changeModule(coding:String):void
		{
			nextCoding = coding;
			oldTime = getTimer();
			closeModule();
		}
		private function openModule():void
		{
			TweenLite.from(spr,2,{alpha:0});
		}
		private function closeModule():void
		{
			TweenLite.to(spr,1,{alpha:0,ease:Quint.easeInOut,onComplete:closeComplete});
		}
		private function closeComplete():void
		{
			this.removeChildren();
			if(newMain.hasOwnProperty("dispose"))
				newMain.dispose();
			//newMain = null;
			spr = null;
			loadModule(nextCoding);
		}
	}
}