package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.group.FlxGroup;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class GravityBase extends FlxSprite {
	public function new(x:Int, y:Int, type:Int) {
		super(x, y);

		switch (type) {
			case 0:
				loadGraphic("assets/images/brillo_grav.png");
				offset.x = 16;
				offset.y = 128;

			case 1:
				loadGraphic("assets/images/brillo_grav.png");
				set_flipY(true);
				offset.x = 16;
				offset.y = 16;
		}
	}
}
