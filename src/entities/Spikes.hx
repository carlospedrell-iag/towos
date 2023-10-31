package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Spikes extends FlxSprite {
	public function new(x:Int, y:Int) {
		super(x, y);
		makeGraphic(21, 6, FlxColor.RED);
		alpha = 0;
	}
}
