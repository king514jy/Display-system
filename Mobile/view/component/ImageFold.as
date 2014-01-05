package view.component
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ImageFold extends Sprite
	{
		private var isHorizontal:Boolean;
		private var imgList:Vector.<Sprite>;
		private var shadowList:Vector.<Bitmap>;
		private var segments:int
		private var _strength:Number =1
		private var rect:Rectangle;
		private var w:int;
		private var h:int;
		public var amount:uint;
		public var bodyDistance:int;
		private var _ro:Number=0;
		private var _al:Number=0;
		private var _al2:Number=0;
		private var initXList:Vector.<Number>;
		public var xAList:Vector.<Number>;
		public var xBList:Vector.<Number>;
		public function ImageFold()
		{
			imgList = new Vector.<Sprite>();
			shadowList = new Vector.<Bitmap>();
			initXList = new Vector.<Number>();
		}
		public function set ro(n:Number):void
		{ 
			_ro = n ;
			changeRotation();
		}
		public function get ro():Number{ return _ro; }
		public function set al(n:Number):void
		{ 
			_al = n; 
			//changeRotation();
		}
		public function get al():Number{ return _al; }
		public function set al2(n:Number):void
		{
			_al2 = n;
			//changeRotation();
		}
		public function get al2():Number{ return _al2; }
		/**
		 * 设置要折叠的对象
		 * @param	display 目标对象
		 * @param	segments 切割段数
		 * @param	isHorizontal 切割方向，true为横向切割,flase为纵向切割
		 */
		public function setDisplayObject(display:DisplayObject,segments:uint,isHorizontal:Boolean,rect:Rectangle):void
		{
			this.isHorizontal = isHorizontal;
			this.segments = segments;
			this.rect = rect;
			imgList.length = 0;
			initXList.length=0;
			shadowList.length=0;
			if(isHorizontal)
			{
				w=rect.width;
				h=int(rect.height/segments);
			}
			else
			{
				w=int(rect.width/segments);
				h=rect.height;
			}
			var bd:BitmapData =new BitmapData (rect.width,rect.height,false,0x565656)
			bd.draw(display,null,null,null,rect);
			for (var i=0;i<segments;i++)
			{
				var bmp:Bitmap =new Bitmap (new BitmapData(w,h));
				var shadowBmp:Bitmap = new Bitmap(new BitmapData(w,h,false,0x000000));
				var spr:Sprite = new Sprite();
				spr.mouseChildren = false;
				spr.mouseEnabled = false;
				if(isHorizontal)
				{
					spr.x=0;
					spr.y=i * h;
					bmp.bitmapData.copyPixels (bd,new Rectangle (0,i*h,w,h),new Point (),null,null,true)
				}
				else{
					spr.x=i*w
					spr.y=0;
					bmp.bitmapData.copyPixels (bd,new Rectangle (i*w,0,w,h),new Point (),null,null,true)
					
				} 
				bmp.smoothing = true;
				shadowBmp.alpha = 0;
				spr.addChild(bmp);
				spr.addChild(shadowBmp);
				var perspectiveP:PerspectiveProjection=new PerspectiveProjection();
				if(i%2==0)
				{
					bmp.x = -bmp.width;
					shadowBmp.x = -shadowBmp.width;
					spr.x = spr.x + spr.width;
					perspectiveP.projectionCenter=new Point(0,rect.height*0.5);
				}
				else
				{
					perspectiveP.projectionCenter=new Point(0,rect.height*0.5);
				}
				spr.transform.perspectiveProjection = perspectiveP;
				imgList.push (spr);
				shadowList.push(shadowBmp);
				this.addChild (spr);
				initXList.push(spr.x);
			}
			bd.dispose();
			bd=null;
		}
		private function updateX():void
		{
			for(var i:int=0;i<amount;i++)
			{
				if(i!=amount-1)
				{
					if(i%2==0)
						imgList[i].x = imgList[i+1].x;
					else
						imgList[i].x = imgList[i+1].x-imgList[i+1].width-imgList[i].width+1;
				}
			}
		}
		public function autoFold(amount:uint,ro:Number,time:Number,xList:Vector.<Number>,bodyDis:int=0,eventType:String="foldComplete"):void
		{
			var num:uint = amount > segments ? segments:amount;
			this.amount = num;
			this.bodyDistance = bodyDis;
			for(var i:int=0;i<num;i++)
			{
				if(i%2==0)
				{
					TweenLite.to(shadowList[i],time,{alpha:0.1});
					//TweenLite.to(imgList[i],time,{rotationY:ro,onUpdate:updateX,ease:Quint.easeOut});
					TweenLite.to(imgList[i],time,{x:xList[i],rotationY:ro});
				}
				else
				{
					TweenLite.to(shadowList[i],time,{alpha:0.2});
					//TweenLite.to(imgList[i],time,{rotationY:-ro,onUpdate:updateX,ease:Quint.easeOut});
					TweenLite.to(imgList[i],time,{x:xList[i],rotationY:-ro});
				}
			}
			var xx:Number = this.x + bodyDis;
			TweenLite.to(this,time,{x:xx,onComplete:foldComplete,onCompleteParams:[eventType]});
		}
		private function foldComplete(eventType:String):void
		{
			dispatchEvent(new Event(eventType));
		}
		public function back(time:Number,eventType:String="backComplete"):void
		{
			for(var i:int=0;i<amount;i++)
			{
				TweenLite.to(shadowList[i],time,{alpha:0,ease:Quint.easeOut});
				TweenLite.to(imgList[i],time,{x:initXList[i],rotationY:0});
			}
			var xx:Number = this.x - bodyDistance;
			TweenLite.to(this,time,{x:xx,onComplete:backComplete,onCompleteParams:[eventType]});
		}
		private function backComplete(eventType:String):void
		{
			dispatchEvent(new Event(eventType));
		}
		public function changeRotation():void
		{
			for(var i:int=0;i<amount;i++)
			{
				if(i%2==0)
				{
					shadowList[i].alpha = _al;
					imgList[i].rotationY = _ro;
					if(i!=amount-1)
						imgList[i].x = imgList[i+1].x;
				}
				else
				{
					imgList[i].rotationY = -_ro;
					shadowList[i].alpha = _al2;
					if(i!=amount-1)
						imgList[i].x = imgList[i+1].x-imgList[i+1].width-imgList[i].width+1;
				}
			}
		}
		public function record():Vector.<Number>
		{
			var xList:Vector.<Number> = new Vector.<Number>();
			for(var i:int=0;i<amount;i++)
			{
				xList.push(imgList[i].x);
			}
			return xList;
		}
		public function dispose():void
		{
			this.removeChildren();
			var le:uint = shadowList.length;
			for(var i:int=0;i<le;i++)
			{
				shadowList[i].bitmapData.dispose();
				shadowList[i]=null;
				imgList[i] = null;
			}
			imgList.length=0;
			shadowList.length=0;
		}
	}
}