package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;

/**
 * ...
 * @author chip
 */
class Button extends FlxSprite
{
	private var btnDir:String = "s";
	private var bc:Int = 0;

	public function new(X:Float=0, Y:Float=0, buttonGraph:String,btnW:Int,btnH:Int,count:Int) 
	{
		super(X, Y, buttonGraph);
        this.btnDir = "s";
		loadGraphic(buttonGraph, true, btnW, btnH);
		animation.add("s", [0], 1, false);
		animation.add("p"+count, [1], 1, false);
		scrollFactor.set();
	
		//trace("this object is " + count + " and X is " + X);
		bc = count;
	}
	
	override public function update(elapsed: Float):Void {
		animation.play(btnDir);
		
		if (FlxG.mouse.justPressed && btnOver(x, y, width, height)) { btnDir = "p" + bc; }
		if (FlxG.mouse.justReleased ) { btnDir = "s"; }
		
		//trace("" + ispressed);
	}
	
	private function btnOver(x:Float, y:Float, width:Float, height:Float):Bool {
		var mx:Int = FlxG.mouse.screenX;
		var my:Int = FlxG.mouse.screenY;
		 return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
	}

    public function setBtnDir(dir: String): Void
    {
        this.btnDir = dir;
    }

    public function getBtnDir(): String 
    {
        return this.btnDir;
    }
}