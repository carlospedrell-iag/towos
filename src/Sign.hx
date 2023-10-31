package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;

/**
 * ...
 * @author ...
 */
class Sign extends FlxGroup {
	private var collision:Bool = false;
	private var sign:FlxSprite;

	public var light:FlxSprite;

	private var button:FlxSprite;
	private var endpoint:FlxPoint;

	private var Xs:Int = 0;
	private var Ys:Int = 0;

	private var moveB:Bool = false;
	private var _tween:FlxTween;

	public function new(Xs, Ys) {
		super();

		sign = new FlxSprite(Xs, Ys, "assets/images/terrain/sign.png");
		add(sign);
		light = new FlxSprite(Xs + 14, Ys - 36, "assets/images/terrain/light1.png");
		light.alpha = 0;
		add(light);
		button = new FlxSprite(Xs + 14, Ys + 64, "assets/images/UI/signButton.png"); // add(button);
		endpoint = new FlxPoint(100, 100);
	}

	override public function update(elapsed:Float):Void {
		if (collision && light.alpha < 0.8) {
			light.alpha += 0.06;
		} else if (light.alpha > 0) {
			light.alpha -= 0.06;
		}

		if (collision) {
			moveB = true;
		}
		if (moveB) {
			move_button();
		}

		FlxG.log.add("but " + button.y + " Ys " + Ys);
	}

	override public function draw():Void {
		super.draw();
	}

	public function set_collision(is_colliding:Bool):Bool {
		return collision = is_colliding;
	}

	private function move_button():Void {
		var sp = 0.2;
		var ac = 10;

		if (button.y > Ys - 36) {
			button.y = Ys - sp * ac;
			if (ac > 0)
				ac -= 1;
		}
	}
}
