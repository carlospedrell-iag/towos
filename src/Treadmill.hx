package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.animation.FlxAnimation;

/**
 * ...
 * @author ...
 */
class Treadmill extends FlxSprite {
	public function new(x:Int, y:Int) {
		super(x, y);
		loadGraphic("assets/images/treadmill.png", true, 32, 32);
		animation.add("moving", [0, 1, 2, 3, 4, 5, 6], 60, true);
		animation.play("moving");
		immovable = true;
		setSize(30, 8);
		offset.y = 32 - 8;
		// offset.x = 1;
	}
}
