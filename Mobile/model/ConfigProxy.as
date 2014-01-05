package model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import events.LoaderEvent;
	
	public class ConfigProxy extends EventDispatcher
	{
		private var _nameList:Vector.<String>;
		private var _icoList:Vector.<String>;
		private var _codingList:Vector.<String>;
		private var folderAddress:String;
		public function ConfigProxy()
		{
			_nameList = new Vector.<String>();
			_icoList = new Vector.<String>();
			_codingList = new Vector.<String>();
			init();
		}
		public function get nameList():Vector.<String>{ return _nameList; }
		public function get icoList():Vector.<String>{ return _icoList; }
		public function get codingList():Vector.<String>{return _codingList; }
		private function init():void
		{
			var file:File = File.applicationStorageDirectory.resolvePath("module/");
			if(file.exists)
				folderAddress = file.url;
			else
				folderAddress = "module"
			loadConfig()
		}
		private function loadConfig():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(folderAddress+"/"+"playList.xml"));
			urlLoader.addEventListener(Event.COMPLETE,complete);
		}
		private function complete(e:Event):void
		{
			var urlLoader:URLLoader = e.target as URLLoader;
			var xml:XML = XML(urlLoader.data);
			var le:uint = xml.playList.item.length();
			for(var i:int=0;i<le;i++)
			{
				var coding:String = String(xml.playList.item[i].@coding);
				_nameList.push(xml.playList.item[i].@name);
				_codingList.push(coding);
				_icoList.push(folderAddress+"/"+coding+"ico.png");
			}
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE));
		}
	}
}