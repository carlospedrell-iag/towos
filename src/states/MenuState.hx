package states;

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

	override public function create():Void {
		super.create();
		switchToPlayState();
		FlxG.fixedTimestep = true;

		FlxG.mouse.load("assets/images/CURSOR.png");
		_background2 = new Background(0, 0);
		add(_background2);
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
		// _button.scrollFactor.set(0, 0.6);
		// _button2 = new Button(100, 0, "assets/images/UI/confButton.png", 164, 40, 2); add(_button2);
	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update(elapsed:Float):Void {
		if (FlxG.keys.anyJustPressed(["Q"])) {
			FlxG.fullscreen = true;
		}

		_playercam.acceleration.y = 0;
		if (_playercam.y > -50) {
			FlxTween.tween(_button, {x: 32}, 0.5);
		}
		// txt.text = "" + Lib.current.stage.scaleX;

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

		if (Button.btnDir == "p" + 1) {
			switchToPlayState();
		}

		super.update(elapsed);
	}

	private function switchToPlayState():Void {
		FlxG.switchState(new PlayState());
	}
}