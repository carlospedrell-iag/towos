package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.touch.FlxTouch;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.input.mouse.FlxMouseEventManager;

/**
 * ...
 * @author chip
 */
class Keypad extends FlxTypedGroup<FlxSprite> {
	private var _up:FlxSprite;
	private var _down:FlxSprite;
	private var _left:FlxSprite;
	private var _right:FlxSprite;

	private var _upDir:String = "n";
	private var _downDir:String = "n";
	private var _leftDir:String = "n";
	private var _rightDir:String = "n";

	public function new(X:Int = 0, Y:Int = 0) {
		super();

		_up = new FlxSprite(X, Y - 80);
		_up.loadGraphic("assets/images/up.png", false, 64, 64);
		add(_up);
		_up.scrollFactor.set();

		_down = new FlxSprite(X, Y);
		_down.loadGraphic("assets/images/down.png", false, 64, 64);
		add(_down);
		_down.scrollFactor.set();

		_left = new FlxSprite(X - 80, Y);
		_left.loadGraphic("assets/images/left.png", false, 64, 64);
		add(_left);
		_left.scrollFactor.set();

		_right = new FlxSprite(X + 80, Y);
		_right.loadGraphic("assets/images/right.png", false, 64, 64);
		add(_right);
		_right.scrollFactor.set();

		var flxMouseEventManager = new FlxMouseEventManager();
		flxMouseEventManager.add(_up, onDown_up, onUp_up, onOver_up, onOut_up);
		flxMouseEventManager.add(_down, onDown_down, onUp_down, onOver_down, onOut_down);
		flxMouseEventManager.add(_left, onDown_left, onUp_left, onOver_left, onOut_left);
		flxMouseEventManager.add(_right, onDown_right, onUp_right, onOver_right, onOut_right);

		_up.animation.add("n", [0], 1, false);
		_up.animation.add("p", [1], 1, false);

		_down.animation.add("n", [0], 1, false);
		_down.animation.add("p", [1], 1, false);

		_left.animation.add("n", [0], 1, false);
		_left.animation.add("p", [1], 1, false);

		_right.animation.add("n", [0], 1, false);
		_right.animation.add("p", [1], 1, false);
	}

	override public function update(elapsed:Float):Void {
		_up.animation.play(_upDir);
		_down.animation.play(_downDir);
		_left.animation.play(_leftDir);
		_right.animation.play(_rightDir);
	}

	public function onDown_up(_up) {
		PlayState._up = true;
		_upDir = "p";
	}

	public function onUp_up(_up) {
		PlayState._up = false;
		_upDir = "n";
	}

	public function onOver_up(_up) {
		PlayState._up = true;
		_upDir = "p";
	}

	public function onOut_up(_up) {
		PlayState._up = false;
		_upDir = "n";
	}

	public function onDown_down(_down) {
		PlayState._down = true;
		_downDir = "p";
	}

	public function onUp_down(_down) {
		PlayState._down = false;
		_downDir = "n";
	}

	public function onOver_down(_down) {
		PlayState._down = true;
		_downDir = "p";
	}

	public function onOut_down(_down) {
		PlayState._down = false;
		_downDir = "n";
	}

	public function onDown_left(_left) {
		PlayState._left = true;
		_leftDir = "p";
	}

	public function onUp_left(_left) {
		PlayState._left = false;
		_leftDir = "n";
	}

	public function onOver_left(_left) {
		PlayState._left = true;
		_leftDir = "p";
	}

	public function onOut_left(_left) {
		PlayState._left = false;
		_leftDir = "n";
	}

	public function onDown_right(_right) {
		PlayState._right = true;
		_rightDir = "p";
	}

	public function onUp_right(_right) {
		PlayState._right = false;
		_rightDir = "n";
	}

	public function onOver_right(_right) {
		PlayState._right = true;
		_rightDir = "p";
	}

	public function onOut_right(_right) {
		PlayState._right = false;
		_rightDir = "n";
	}
}
