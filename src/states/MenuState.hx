package states;

import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

import states.PlayState;
import entities.Background;
import ui.Button;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	var ratio:RatioScaleMode;
	var fixed:FixedScaleMode;

	private var _background2:Background;
	private var _playercam:FlxSprite;
	private var point:FlxObject;
	private var ispeed:Float = 1;

	private var _button:Button;
	private var _button2:Button;

	private var test:Int;
	private var yes:Bool;

	public static var _gamepad:FlxGamepad;

	override public function create():Void {
		super.create();
		//switchToPlayState();
		FlxG.fixedTimestep = true;

		FlxG.mouse.load("assets/images/cursor.png");
		_background2 = new Background(0, 0);
		add(_background2);
        Background.cs = 0.2;
		Background.towerback.kill();
		_playercam = new FlxSprite(0, 0);
		_playercam.makeGraphic(16, 48);
		_playercam.visible = false;
		add(_playercam);
		FlxG.camera.follow(_playercam);

		FlxG.camera.fade(FlxColor.WHITE, 2, true);

		_playercam.x = 472;
		_playercam.y = -4460;

		_button = new Button(-100, 128, "assets/images/UI/playButton.png", 84, 40, 1);
		add(_button);
	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update(elapsed:Float):Void {
        var _gamepadstart: Bool = false;

		if (FlxG.keys.anyJustPressed(["F"])) {
			FlxG.fullscreen = true;
		}

		_playercam.acceleration.y = 0;
		if (_playercam.y > -50) {
			FlxTween.tween(_button, {x: 32}, 0.5);
		}

		if (FlxG.keys.anyPressed(["UP"])) {
			yes = true;
		}

		if (_playercam.y < 0) {
			_playercam.y += 8 * ispeed;
		}
		if (_playercam.y > -780 && ispeed > 0) {
			ispeed -= 0.0053;
		}
		if (ispeed < 0) {
			ispeed = 0;
		}

        _gamepad = FlxG.gamepads.lastActive;
		if (_gamepad != null) {
            _gamepadstart =  _gamepad.anyJustPressed([FlxGamepadInputID.START]) || _gamepad.anyJustPressed([FlxGamepadInputID.A]);
        }

		if ((_button.getBtnDir() == "p" + 1) || _gamepadstart ) {
			switchToPlayState();
		}

		super.update(elapsed);
	}

	private function switchToPlayState():Void {
		FlxG.switchState(new PlayState());
	}
}
