package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Orb extends FlxSprite {
	// private var sjump:Bool = false;
	public function new(x:Float, y:Float) {
		super(x, y);

		loadGraphic("assets/images/player/orb.png");
	}

	override public function update(elapsed:Float):Void {
		alpha -= 0.03;

		if (alpha < 0) {
			kill();
		}

		super.update(elapsed);
	}
}
