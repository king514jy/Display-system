package view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import events.MessageEvent;
	
	import ky.enumerate.MobileCommandMode;
	
	import model.UdpSever;
	
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.SwipeGesture;
	import org.gestouch.gestures.SwipeGestureDirection;
	
	import view.component.Bottom;
	import view.component.Image;
	import view.component.ImageFold;
	import view.component.Item;
	import view.component.Title;
	
	public class ItemPage extends Sprite
	{
		private var backGround:Bitmap
		private var icoList:Vector.<String>;
		private var nameList:Vector.<String>;
		private var codingList:Vector.<String>;
		private var _itemGroup:Sprite;
		private var udpSever:UdpSever;
		private var optionsButton:Sprite;
		private var imageFold:ImageFold;
		private var title:Title;
		private var bottom:Bottom;
		private var rect:Rectangle;
		private var count:int=0;
		private var swipe:SwipeGesture;
		private var isOpen:Boolean;
		public var widthA:Number;
		public var widthB:Number;
		public function ItemPage()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function get itemGroup():Sprite{ return _itemGroup; }
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			backGround = new Bitmap(new ItemBack());
			backGround.width = stage.stageWidth;
			backGround.height = stage.stageHeight;
			this.addChild(backGround);
			_itemGroup = new Sprite();
			_itemGroup.y = 82;
			this.addChild(_itemGroup);
			title = new Title();
			title.mouseEnabled = false;
			title.mouseChildren = false;
			this.addChild(title);
			bottom = new Bottom();
			bottom.y = stage.stageHeight;
			bottom.mouseChildren = false;
			bottom.mouseEnabled = false;
			this.addChild(bottom);
			optionsButton = new OptionsButton();
			optionsButton.x = 100;
			this.addChild(optionsButton);
			imageFold = new ImageFold();
			imageFold.mouseChildren = false;
			imageFold.mouseEnabled = false;
			this.addChild(imageFold);
			imageFold.visible = false;
			rect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			
			//this.addEventListener(MouseEvent.CLICK,clickOption);
			udpSever = UdpSever.getInstance();
			swipe = new SwipeGesture(this);
			swipe.direction = SwipeGestureDirection.HORIZONTAL;
			addGesture();
		}
		private function addGesture():void
		{
			swipe.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipe);
		}
		private function removeGesture():void
		{
			swipe.removeEventListener(GestureEvent.GESTURE_RECOGNIZED, onSwipe);
		}
		public function setItem(icoList:Vector.<String>,nameList:Vector.<String>,codingList:Vector.<String>):void
		{
			this.icoList = icoList;
			this.nameList = nameList;
			this.codingList = codingList;
			var le:uint = nameList.length;
			for(var i:int=0;i<le;i++)
			{
				var item:Item = new Item();
				item.y = i * 102;
				_itemGroup.addChild(item);
				item.ico = new Image(icoList[i]);
				item.name = nameList[i];
				item.coding = codingList[i];
			}
		}
		private function clickOption(e:MouseEvent):void
		{
			removeGesture();
			
		}
		private function onSwipe(e:GestureEvent):void
		{
			removeGesture();
			if(swipe.offsetX > 0)
			{
				if(!isOpen)
				{
					isOpen = true;
					imageFold.setDisplayObject(this,8,false,rect);
					title.visible = false;
					bottom.visible = false;
					_itemGroup.visible = false;
					optionsButton.visible = false;
					backGround.visible = false;
					imageFold.visible = true;
					if(imageFold.xAList)
					{
						imageFold.autoFold(3,45,0.5,imageFold.xAList,widthA);
						imageFold.addEventListener("foldComplete",foldComplete);
					}
					else
					{
						imageFold.amount = 3;
						imageFold.bodyDistance = widthA;
						TweenLite.to(imageFold,0.5,{x:widthA,ro:45,al:0.1,al2:0.2,onComplete:runComplete});
					}
				}
			}
			else
			{
				if(isOpen)
				{
					isOpen = false;
					imageFold.back(0.5);
					imageFold.addEventListener("backComplete",backItem);
				}
			}
		}
		private function foldComplete(e:Event):void
		{
			addGesture();
		}
		private function runComplete():void
		{
			if(!imageFold.xAList)
			{
				imageFold.changeRotation();
				imageFold.xAList = imageFold.record();
			}
			addGesture();
		}
		private function backItem(e:Event):void
		{
			imageFold.removeEventListener("backComplete",backItem)
			title.visible = true;
			bottom.visible = true;
			_itemGroup.visible = true;
			optionsButton.visible = true;
			backGround.visible = true;
			imageFold.visible = false;
			imageFold.dispose();
			addGesture();
		}
	}
}