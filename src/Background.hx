package ;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.touch.FlxTouch;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * ...
 * @author chip
 */
class Background extends FlxTypedGroup<FlxSprite> 
{
		public static var cs:Float = 0.2;
		private var fondo:FlxSprite;
		private var cloud1:FlxSprite;
		private var cloud2:FlxSprite;
		private var cloud3:FlxSprite;
		private var cloud4:FlxSprite;
		private var cloud5:FlxSprite;
		private var cloud6:FlxSprite;
		private var cloud7:FlxSprite;
		private var cloud8:FlxSprite;
		private var cloud9:FlxSprite;
		private var layer1:FlxSprite;
		private var layer2:FlxSprite;
		public static  var title:FlxSprite;
		private var move:FlxSprite;
		
		public static var layer3:FlxSprite;
		public static var layer4:FlxSprite;
		public static var towerback:FlxSprite;
		public static var logo:FlxSprite;
		
		public static var R:Int = 212;
		public static var G:Int = 234;
		public static var B:Int = 234;
		
	public function new(X:Int,Y:Int) 
	{
		super();
		
		fondo = new FlxSprite(X, Y); fondo.makeGraphic(960,600);  add(fondo); 
		cloud1 = new FlxSprite(X + 720, Y+155); cloud1.loadGraphic("assets/images/background/cloud1.png"); add(cloud1);
		cloud2 = new FlxSprite(X + 624, Y+95); cloud2.loadGraphic("assets/images/background/cloud2.png"); add(cloud2);
		cloud3 = new FlxSprite(X + 456, Y+155); cloud3.loadGraphic("assets/images/background/cloud3.png"); add(cloud3);
		cloud4 = new FlxSprite(X + 400, Y+115); cloud4.loadGraphic("assets/images/background/cloud4.png"); add(cloud4);
		cloud5 = new FlxSprite(X + 240, Y+115); cloud5.loadGraphic("assets/images/background/cloud5.png"); add(cloud5);
		cloud6 = new FlxSprite(X + 150, Y+155); cloud6.loadGraphic("assets/images/background/cloud6.png"); add(cloud6);
		cloud7 = new FlxSprite(X + -16, Y+155); cloud7.loadGraphic("assets/images/background/cloud7.png"); add(cloud7);
		cloud8 = new FlxSprite(X + -224, Y+95); cloud8.loadGraphic("assets/images/background/cloud8.png"); add(cloud8);
		cloud9 = new FlxSprite(X + -448, Y+85); cloud9.loadGraphic("assets/images/background/cloud9.png"); add(cloud9);
		layer1 = new FlxSprite(X, Y - 5); layer1.loadGraphic("assets/images/background/layer1.png"); add(layer1); 
		layer2 = new FlxSprite(X, Y + 25); layer2.loadGraphic("assets/images/background/layer2.png"); add(layer2); 
		layer3 = new FlxSprite(X, Y -90); layer3.loadGraphic("assets/images/background/layer3.png"); add(layer3);
		title = new FlxSprite(X + 32, Y + 95 - 156); title.loadGraphic("assets/images/background/title.png"); add(title);
		layer4 = new FlxSprite(X, Y + 95); layer4.loadGraphic("assets/images/background/layer4.png"); add(layer4);
					
		towerback = new FlxSprite(X+402, Y - 196); towerback.loadGraphic("assets/images/background/tower_back.png"); add(towerback);
		logo = new FlxSprite(X + 402, Y - 813); logo.loadGraphic("assets/images/background/logo.png"); add(logo);
		
		fondo.scrollFactor.set();
		
		layer1.scrollFactor.set(1, 0.035);
		layer2.scrollFactor.set(1, 0.09);
		layer3.scrollFactor.set(1, 0.2);
		layer4.scrollFactor.set(1, 0.3);
		title.scrollFactor.set(1, 0.4);
		
		towerback.scrollFactor.set(1, 0.5);
		logo.scrollFactor.set(1, 0.4);
	}
	
	override public function update(elapsed: Float):Void {
		fondo.color = FlxColor.fromRGB(R, G, B);
		layer1.color = FlxColor.fromRGB(R-14, G-8, B-7);
		layer2.color = FlxColor.fromRGB(R-28, G-15, B-14);
		layer3.color = FlxColor.fromRGB(R-41, G-22, B-21);
		layer4.color = FlxColor.fromRGB(R - 67, G - 35, B - 35);
		
        for (spr in [cloud1, cloud2, cloud3, cloud4,cloud5,cloud6,cloud7,cloud8,cloud9]) {
            spr.x += cs; 
            if (spr.x >= 976) { spr.x = -288; }
            spr.scrollFactor.set(1, 0.001);
            spr.color = FlxColor.fromRGB(R + 43, G + 21, B + 21); 
        }
	}
	
}