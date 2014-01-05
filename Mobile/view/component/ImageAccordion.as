package view.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import com.greensock.TweenLite;
	
	public class ImageAccordion extends Sprite
	{
		private var isHorizontal:Boolean;
		private var imgList:Vector.<Bitmap>;
		private var segments:int
		private var _strength:Number =1
		private var rect:Rectangle;
		public function ImageAccordion()
		{
			imgList = new Vector.<Bitmap>();
		}
		public function set strength(n:Number):void
		{ 
			_strength = n;
			floding();
		}
		public function get strength():Number{ return _strength; }
		/**
		 * 设置要折叠的对象
		 * @param	display 目标对象
		 * @param	segments 切割段数
		 * @param	isHorizontal 切割方向，true为横向切割,flase为纵向切割
		 */
		public function setDisplayObject(display:DisplayObject,segments:uint,isHorizontal:Boolean,rect:Rectangle):void
		{
			this.isHorizontal = isHorizontal;
			this.rect = rect;
			imgList.length = 0;
			var w:int
			var h:int
			if(isHorizontal)
			{
				w=display.width
				h=int(display.height/segments)
			}
			else
			{
				w=int(display.width/segments)
				h=display.height
			}
			var bd:BitmapData =new BitmapData (rect.width,rect.height,false,0x565656)
			bd.draw(display,null,null,null,rect);
			for (var i=0;i<segments;i++)
			{
				var bmp:Bitmap =new Bitmap (new BitmapData(w,h));
				if(isHorizontal)
				{
					bmp.x=0;
					bmp.y=i * h;
					bmp.bitmapData.copyPixels (bd,new Rectangle (0,i*h,w,h),new Point (),null,null,true)
				}
				else{
					bmp.x=i*w
					bmp.y=0
					bmp.bitmapData.copyPixels (bd,new Rectangle (i*w,0,w,h),new Point (),null,null,true)
					
				} 
				bmp.smoothing = true;
				imgList.push (bmp);
				this.addChild (bmp);
			}
		}
		public function auto(endStrength:Number,time:Number):void
		{
			TweenLite.to(this,time,{strength:endStrength});
		}
		private function floding(tall:Number =50):void 
		{
			var i
			/*Strength=Strength<=0?0.0001:Strength
			Strength=Strength>1?1:Strength
			
			if(strength==2){strength=Strength}*/
			
			_strength=_strength<=0?0.0001:_strength
			_strength=_strength>1?1:_strength
			var m:Matrix =new Matrix (1,0,0,1)
			var r:Number =Math.tan((tall-tall*_strength)*Math.PI/180)//斜切角度
			var c:ColorTransform =new ColorTransform (_strength,_strength,_strength)
			for ( i in imgList)
			{
				
				
				if(isHorizontal)
				{
					m.d=_strength
					if(i==0)
					{
						m.c=r
						imgList[i].transform.colorTransform=c
						imgList[i].transform.matrix=m
						
						imgList[i].x+=(rect.width-imgList[0].width)
						continue
					}
					if(i%2==0){
						m.c=r
						imgList[i].transform.colorTransform=c
						imgList[i].transform.matrix=m
						imgList[i].x=imgList[i-1].x
						imgList[i].x+=(rect.width-imgList[i-1].width)
					}else{
						m.c=-r
						imgList[i].transform.matrix=m//折叠
						
					}
					imgList[i].y=imgList[i-1].y+imgList[i-1].height
					
				}else{
					m.a=_strength
					if(i==0){
						m.b=r
						imgList[i].transform.colorTransform=c
						imgList[i].transform.matrix=m
						
						imgList[i].y+=(rect.height-imgList[0].height)
						continue
					}
					if(i%2==0){
						m.b=r
						imgList[i].transform.colorTransform=c
						//(width-menueFragment[i-1].width)
						imgList[i].transform.matrix=m
						imgList[i].y=imgList[i-1].y
						imgList[i].y+=(rect.height-imgList[i-1].height)
					}else{
						m.b=-r
						imgList[i].transform.matrix=m//折叠
						
					}
					imgList[i].x=imgList[i-1].x+imgList[i-1].width
				}
				
			}
		}
	}
}