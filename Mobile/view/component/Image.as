package view.component
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import events.LoaderEvent;
	
	public class Image extends Sprite 
	{
		private var _url:String;
		private var _bitmap:Bitmap;
		private var _selefWidth:Number;
		private var _selefHeight:Number;
		private var _center:Boolean;
		public function Image(url:String=null,center:Boolean=false) 
		{
			_url = url;
			_center = center;
			if(url)
				loadURL();
		}
		public function get url():String { return _url; }
		public function set bitmap(bmp:Bitmap):void
		{
			_bitmap = bmp;
			add();
		}
		public function get bitmap():Bitmap { return _bitmap };
		public function set selefWidth(n:Number):void { _selefWidth = n; }
		public function get selefWidth():Number { return _selefWidth };
		public function set selefHeight(n:Number):void { _selefHeight = n; }
		public function get selefHeight():Number { return _selefHeight; }
		public function set center(b:Boolean):void { _center = b; setPoint(); }
		public function get center():Boolean { return _center; }
		private function loadURL():void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(_url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loading);
		}
		private function loading(e:ProgressEvent):void
		{
			var progress:Number = Math.floor(e.bytesLoaded / e.bytesTotal * 100);
			dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS, progress));
		}
		private function onComplete(e:Event):void
		{
			var loader:Loader = LoaderInfo(e.target).loader;
			_bitmap = loader.content as Bitmap;
			add();
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader = null;
			dispatchEvent(new LoaderEvent(LoaderEvent.COMPLETE));
		}
		private function add():void
		{
			if (this.numChildren > 0)
				this.removeChildren();
			setPoint();
			this.addChild(_bitmap);
		}
		private function setPoint():void
		{
			if (_center)
			{
				_bitmap.x = -_bitmap.width * 0.5;
				_bitmap.y = -_bitmap.height * 0.5;
			}
			else
			{
				_bitmap.x = 0;
				_bitmap.y = 0;
			}
		}
		public function dispose():void
		{
			if (_bitmap)
			{
				_bitmap.bitmapData.dispose();
				_bitmap = null;
			}
		}
	}

}