package;

import flixel.FlxSprite;

// REDUNDANT CLASS

/**
 * ...
 * @author ...
 */
class Treadmill_right extends FlxSprite {
	public function new(x:Int, y:Int) {
		super(x, y);
		loadGraphic("assets/images/treadmill.png", true, 32, 32);
		animation.add("moving", [6, 5, 4, 3, 2, 1, 0], 60, true);
		animation.play("moving");
		immovable = true;
		setSize(30, 8);
		offset.y = 32 - 9;
	}
}
