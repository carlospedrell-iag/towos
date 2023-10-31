package;

import flixel.animation.FlxAnimation;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import openfl.Assets;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author chip
 */
class Player extends FlxSprite {
	public static var SPEED:Float = 220;

	private var FRICTION:Float = 7;
	private var GRAVITY:Float = 1260;
	private var anim:String = "stop";
	private var jumpcount:Int = 2; // default = 2
	private var dustflag:Bool = false;
	private var pstate:PlayState;

	public var added_speed:Int = 0;
	public var on_treadmill:Bool = false;

	private var ss:Float = 0.005;

	public function new(X:Float = 0, Y:Float = 0) {
		super(x, y);
		makeGraphic(16, 48);
		loadGraphic("assets/images/player/spritesheet.png", true, 64, 64);

		// alpha = 0.5;
		width = 14;
		height = 48;

		offset.x = 24;
		offset.y = 16;

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		drag.x = SPEED * FRICTION;
		drag.y = 350 * 7;
		acceleration.y = GRAVITY;

		maxVelocity.x = SPEED;
		maxVelocity.y = 1160;

		setupAnimation();

		// PERO ESTO QUE ES?!¿?!¿!?¿!?¿!
		pstate = cast FlxG.state;
	}

	override public function update(elapsed:Float):Void {
		move_player();
		x += added_speed;

		if (isjumping() && PlayState._up && jumpcount == 1) {
			add_dust(false);
		} else if (isjumping() && PlayState._up) {
			add_dust(true);
		}

		super.update(elapsed);
	}

	private function move_player():Void {
		// Reset to 0 when no button is pushed
		acceleration.x = 0;

		animation.play(anim);

		// WHEN TOUCHING FLORR
		if (isTouching(FlxObject.FLOOR)) {
			if (!on_treadmill) {
				added_speed = 0;
			}
			acceleration.y = GRAVITY;
			jumpcount = 2; // SET TO 2
		} else {
			acceleration.y = acceleration.y + 8;
		}

		// KEYS
		if (PlayState._right) {
			acceleration.x += drag.x;
			facing = FlxObject.RIGHT;
			anim = "moving";
		} else if (PlayState._left) {
			acceleration.x -= drag.x;
			facing = FlxObject.LEFT;
			anim = "moving";
		} else {
			acceleration.x = 0;
		}

		// JUMPING AND DOUBLE JUMPING -/- ANIMATIONS
		if (PlayState._up && (isTouching(FlxObject.FLOOR) || jumpcount > 0)) {
			velocity.y = -maxVelocity.y * 0.5;
			jumpcount -= 1;
		}
		// double jump speed
		if (jumpcount == 1) {
			maxVelocity.y = 1080;
		} else {
			maxVelocity.y = 1160;
		}

		if (isjumping()) {
			anim = "jumping";
		}
		if (!isjumping() && !isTouching(FlxObject.FLOOR)) {
			anim = "falling";
			if (jumpcount > 1) {
				jumpcount -= 1;
			}
		}

		if (justTouched(FlxObject.FLOOR)) {
			anim = "relax";
		} else if (isTouching(FlxObject.FLOOR) && animation.curAnim.name != "relax" && velocity.x == 0) {
			anim = "stop";
		}
		if (animation.curAnim.name == "relax" && animation.curAnim.curFrame > 2) {
			anim = "stop";
		}

		// CHEATS
		if (PlayState._up && FlxG.keys.anyPressed(["SHIFT"])) {
			velocity.y = -maxVelocity.y;
		}
	}

	private function setupAnimation():Void {
		animation.add("stop", [0]);
		animation.add("moving", [6, 7, 8, 9, 10, 11], 12);
		animation.add("jumping", [12, 13, 14, 15, 16, 16, 16, 16, 16, 16, 16, 16], 16, false);
		animation.add("falling", [18, 19, 20], 8, false);
		animation.add("relax", [24, 25, 26, 27], 20, false);
	}

	public function isjumping():Bool {
		if (velocity.y > 0) {
			return false;
		} else if (velocity.y < 0) {
			return true;
		}
		return false;
	}

	public function add_dust(is_second:Bool):Void {
		pstate.dustGroup.add(new Dust(x - 8, y + 34, is_second));
	}

	public function gravitate(Coin:FlxObject, Player:FlxObject):Void {
		acceleration.y = 100;
		maxVelocity.y = 500;
		drag.y = 600;
	}

	public function normalize(Coin:FlxObject, Player:FlxObject):Void {
		on_treadmill = false;
		added_speed = 0;
		acceleration.y = 1260;
		drag.y = 350 * 7;
		maxVelocity.y = 1160;
	}

	public function speed_up(Coin:FlxObject, Player:FlxObject):Void {
		added_speed = -3;
		on_treadmill = true;
	}

	public function speed_up2(Coin:FlxObject, Player:FlxObject):Void {
		added_speed = 3;
		on_treadmill = true;
	}

	public function die(Coin:FlxObject, Player:FlxObject):Void {
		pstate.orbGroup.add(new Orb(x - 8, y + 4));

		FlxG.camera.shake(ss, 1);
		if (ss > 0) {
			ss -= 0.0001;
		}

		// FlxG.camera.fade(FlxColor.WHITE,3);
	}
}
