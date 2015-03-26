package;

import flash.geom.Rectangle;
import nme.display.Shape;
import nme.display.BitmapDataChannel;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;

using Math;

class Main extends Sprite {

	var canvas:BitmapData;

	public function new()
	{
		super();

		//Add image to stage
		var tmp = new Bitmap(Assets.getBitmapData("assets/poophead.png"));
		addChild(tmp);
		canvas = tmp.bitmapData;

		addEventListener(MouseEvent.CLICK, cutCircle);
	}

	function cutCircle(e:MouseEvent):Void
	{
		//Pick mouse X and Y
		var targetX = mouseX;
		var targetY = mouseY;

		//Bounds around the mouse
		var bounds = new Rectangle(mouseX, mouseY);
		bounds.inflate(50, 50);

		//temporary holder
		var tmp = new BitmapData(Math.ceil(bounds.width), Math.ceil(bounds.height), false, 0xFFFFFF);

		//NOTE: Expected behaviour - nothign should change at all, as we just copy pixels forth and back.
		//Copy pixel data around mouse from canvas ALPHA to tmp RED
		tmp.copyChannel(canvas, bounds, new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.RED);
		//Copy back same pixels from tmp RED to canvas ALPHA
		canvas.copyChannel(tmp, tmp.rect, bounds.topLeft, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
		
		//Cleanup
		tmp.dispose();
	}

}