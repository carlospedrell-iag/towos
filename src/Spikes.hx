package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import flixel.FlxG;

class Spikes extends FlxSprite {
	public function new(x:Int, y:Int) {
		super(x, y);
		// loadGraphic("assets/images/brillo_grav.png");
		makeGraphic(21, 6, FlxColor.RED);
		alpha = 0;
	}
}
