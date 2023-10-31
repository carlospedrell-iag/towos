package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;

import states.MenuState;

class Main extends Sprite {
	#if mobile
	var _stageWidth:Int = Lib.current.stage.stageWidth;
	var _stageHeight:Int = Lib.current.stage.stageHeight;

	var gameWidth:Int = 200;
	var gameHeight:Int = 200;
	#end
	#if desktop
	var gameWidth:Int = 960; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 540; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	#end
	#if web
	var gameWidth:Int = 960; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 540; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	#end
	var initialState:Class<FlxState> = MenuState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void {
		Lib.current.addChild(new Main());
	}

	public function new() {
		super();

		#if mobile
		if (_stageWidth > 1024 || _stageHeight > 1024) {
			gameWidth = 960;
			gameHeight = 540;
		} else {
			gameWidth = 800;
			gameHeight = 480;
		}
		#end
		FlxG.fixedTimestep = true;

		if (stage != null) {
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void {
		if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void {
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1) {
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		addChild(new FlxGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));
	}
}
