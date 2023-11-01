package entities;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Treadmill extends FlxSprite {
	public function new(x:Int, y:Int, isRight: Bool) {
        var animationFrames = isRight ? [6, 5, 4, 3, 2, 1, 0] : [0, 1, 2, 3, 4, 5, 6];
		super(x, y);
		loadGraphic("assets/images/treadmill.png", true, 32, 32);
		animation.add("moving", animationFrames, 60, true);
		animation.play("moving");
		immovable = true;
		setSize(30, 8);
		offset.y = 32 - 8;
	}
}
