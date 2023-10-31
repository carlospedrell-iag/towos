package;

import flash.display.BlendMode;
import flixel.group.FlxGroup;
// import flixel.system.FlxCollisionType;
import Sign;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.lists.FlxGamepadButtonList;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import openfl.Lib;
import flixel.tile.FlxTilemap;
import flixel.input.touch.FlxTouchManager;
import flixel.input.touch.FlxTouch;
import openfl.Assets;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	public var _spawn:FlxSprite;

	// TILED
	public var level:TiledLevel;
	public var score:FlxText;
	public var status:FlxText;
	public var coins:FlxGroup;
	public var _gravbase:FlxGroup;
	public var _spike:FlxGroup;
	public var _gravity:FlxGroup;
	public var _agravity:FlxGroup;
	public var _treadmill:FlxGroup;
	public var _treadmill2:FlxGroup;
	public var player:FlxSprite;
	public var floor:FlxObject;
	public var exit:FlxSprite;
	public var topobjects:FlxGroup;

	private var move:FlxSprite;

	private var _background:Background;

	private var texto2:FlxText;
	private var texto3:FlxText;
	private var _player:Player;
	private var _camera:FlxCamera;
	private var _keypad:Keypad;
	private var _sign:Sign;
	private var floordec:FlxSprite;
	private var grass:FlxSprite;
	private var dark:FlxSprite;
	private var playerlight:FlxSprite;

	private var _spawner:FlxGroup;
	private var _dust:FlxSprite;

	public var dustGroup:FlxGroup;
	public var orbGroup:FlxGroup;

	private var blanco:FlxSprite;

	// KEYS
	public static var _down:Bool = false;
	public static var _up:Bool = false;
	public static var _left:Bool = false;
	public static var _right:Bool = false;
	public static var _gamepad:FlxGamepad;
	public static var _fscreen:Bool = false;
	public static var _mini:Bool = false;

	// ELIMINAR:
	private var axis:Dynamic = 0;
	//-------------
	var y:Int;
	var ss:Float = 0;

	override public function create():Void {
		// Setup cameras
		_camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		FlxG.cameras.reset(_camera);
		// FlxG.camera.setBounds(0, -9484, 960, 10024, true);
		FlxG.camera.setScrollBoundsRect(0, -9484, 960, 10024, true);
		FlxG.worldBounds.set(0, -9484, 960, 10024);

		_camera.fade(FlxColor.WHITE, 2, true);

		blanco = new FlxSprite(0, 0);
		blanco.makeGraphic(960, 540, FlxColor.WHITE);
		blanco.scrollFactor.set();
		add(blanco);
		// Backgrounds y mapas
		_background = new Background(0, 0);
		Background.logo.kill();
		Background.layer4.kill();
		Background.layer3.kill();
		Background.title.kill();

		add(_background);

		decorate();

		/*
			backmap = new FlxTilemap();
			backmap.loadMap(Assets.getText("assets/data/backmap.csv"), "assets/images/tileset.png", 32, 32,0,1);
			add(backmap); backmap.y -= 9484;       		


			map = new FlxTilemap();
			map.loadMap(Assets.getText("assets/data/map.csv"), "assets/images/tileset.png", 32, 32, 0,1,1,28);
			add(map); map.y -= 9452; 
		 */

		// Load the level's tilemaps
		// levelTiledMap = new TiledMap("assets/tiled/level3.tmx");
		level = new TiledLevel("assets/tiled/level3.tmx");

		// Add tilemaps

		// Draw coins first

		_gravbase = new FlxGroup();
		add(_gravbase);

		_gravity = new FlxGroup();
		add(_gravity);

		_agravity = new FlxGroup();
		add(_agravity);

		_treadmill = new FlxGroup();
		add(_treadmill);

		_treadmill2 = new FlxGroup();
		add(_treadmill2);

		topobjects = new FlxGroup();
		add(topobjects);

		_spike = new FlxGroup();
		add(_spike);

		move = new FlxSprite(-6, 332);
		move.loadGraphic("assets/images/move.png");
		add(move);
		move.scrollFactor.set(0, 0.6);

		// Load player objects
		level.loadObjects(this);

		// Add background tiles after adding level objects, so these tiles render on top of player
		add(level.backgroundTiles);
		add(level.foregroundTiles);

		coins = new FlxGroup();
		add(coins);

		// SPRITE del suelo
		floordec = new FlxSprite(0, 500, "assets/images/terrain/floor.png");
		add(floordec);

		// GROUPS
		dustGroup = new FlxGroup();
		add(dustGroup);
		orbGroup = new FlxGroup();
		add(orbGroup);

		// var android_bounds = new FlxSprite(0, 0, "assets/images/android_bounds.png"); add(android_bounds); android_bounds.scrollFactor.set();

		// textos
		texto2 = new FlxText(0, 0);
		add(texto2);
		texto3 = new FlxText(0, 100);
		add(texto3);

		// SPWAN

		// PLAYER
		_player = new Player(0, 0);
		add(_player);
		// FlxG.camera.follow(_player, FlxCameraFollowStyle.TOPDOWN, null, 10);
		FlxG.camera.follow(_player, FlxCameraFollowStyle.TOPDOWN, 10);
		#if mobile
		var point:FlxPoint = new FlxPoint(0, 100);
		// TODO: point is an offset that used to go in the follow() function, must find a way to add it now
		// FlxG.camera.follow(_player, FlxCameraFollowStyle.LOCKON, point, 10);
		FlxG.camera.follow(_player, FlxCameraFollowStyle.LOCKON, 10);
		#end
        
		// Mostrar el keypad en el mobil
		#if mobile
		// QUITO POR TDR
		_keypad = new Keypad(96, FlxG.stage.stageHeight - 96);
		add(_keypad);
		#end
		_player.x = _spawn.x;
		_player.y = _spawn.y;

		super.create();
	}

	override public function draw():Void {
		// This draws all the game objects
		super.draw();
		_sign.light.draw();
		grass.draw();
		_gravbase.draw();
		_treadmill.draw();

		topobjects.draw();
		_spike.draw();
		move.draw();
		#if mobile
		_keypad.draw();
		#end
	}

	override public function destroy():Void {
		super.destroy();
	}

	override public function update(elapsed:Float):Void {
		// Reconocer el gamkepad
		if (FlxG.keys.anyJustPressed(["Q"])) {
			FlxG.fullscreen = true;
		}

		FlxG.log.add(level.tilemap.y);
		#if !mobile
		_gamepad = FlxG.gamepads.lastActive;
		if (_gamepad != null) {
			gamepadControls();
		} else {
			keyControls();
		}
		#end

		if (_fscreen) {
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		// if (_mini) { Lib.current.stage.stageWidth = 480;}

		if (_player.y < -2000) {
			change_color("violet");
		} else {
			change_color("default");
		}

		// COLISIONES:
		level.collideWithLevel(_player);
		FlxG.overlap(_gravity, _player, _player.gravitate);

		FlxG.overlap(_agravity, _player, _player.normalize);
		FlxG.overlap(_spike, _player, _player.die);
		// FlxG.collide(_player, _treadmill);
		FlxG.collide(_treadmill, _player, _player.speed_up);
		FlxG.collide(_treadmill2, _player, _player.speed_up2);

		// FlxG.collide(_player,map);
		// if (FlxG.mouse.justPressed) { y = 1;  } if (y==1) { cataclysm(); }

		// LOGS
		// FlxG.log.add(_gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X));

		super.update(elapsed);
	}

	private function cataclysm():Void {
		FlxG.camera.shake(ss, 10);
		ss += 0.0001;
		Background.cs += 0.05;
		FlxG.camera.fade(FlxColor.WHITE, 10);
	}

	private function decorate():Void {
		add(new FlxSprite(103, 468, "assets/images/terrain/bush1.png"));
		add(new FlxSprite(660, 468, "assets/images/terrain/bush1.png"));
		add(new FlxSprite(209, 468, "assets/images/terrain/bush2.png"));
		add(new FlxSprite(736, 468, "assets/images/terrain/bush3.png"));
		add(new FlxSprite(84, 420, "assets/images/terrain/plant1.png"));
		add(new FlxSprite(230, 420, "assets/images/terrain/plant2.png"));
		add(new FlxSprite(672, 420, "assets/images/terrain/plant3.png"));
		grass = new FlxSprite(0, 496, "assets/images/terrain/grass.png");
		add(grass);
		_sign = new Sign(103, 436);
		add(_sign);

		// dark = new FlxSprite(0, 0); dark.scrollFactor.set(); dark.makeGraphic(960, 540, FlxColor.BLACK); add(dark);
	}

	private function change_color(clr:String) {
		var sp:Int = 1;

		switch clr {
			case "violet":
				if (Background.R > 128) {
					Background.R -= sp;
				}
				if (Background.G > 90) {
					Background.G -= sp;
				}
				if (Background.B > 118) {
					Background.B -= sp;
				}

			case "default":
				if (Background.R < 212) {
					Background.R += sp;
				}
				if (Background.G < 234) {
					Background.G += sp;
				}
				if (Background.B < 234) {
					Background.B += sp;
				}
		}
	}

	private function gamepadControls():Void {
		var MIN:Float = 0.2;
		var MAX:Float = 0.3;
		var minsp:Int = 70;
		var maxsp:Int = 220;

		// var axis:Float = _gamepad.getXAxis(XboxButtonID.LEFT_ANALOGUE_X);
		// TODO:
		// var axis:Float = _gamepad.getXAxis(FlxGamepadAnalogStick.);
		var axis:Float = 0;

		// botones
		// _up = _gamepad.anyJustPressed([XboxButtonID.A]);
		_up = _gamepad.anyJustPressed([FlxGamepadInputID.A]);
		// _fscreen = _gamepad.justPressed(XboxButtonID.BACK);
		_fscreen = _gamepad.anyJustPressed([FlxGamepadInputID.BACK]);

		// Comprobar si el stick está hacia la derecha o izquierda
		if (axis < -MIN) {
			_left = true;
		} else if (axis > MIN) {
			_right = true;
		} else {
			_left = false;
			_right = false;
		}

		// Calcular la posición del eje para regular velocidad
		if (Math.abs(axis) < MAX) {
			Player.SPEED = minsp;
		} else if (Math.abs(axis) > MAX) {
			Player.SPEED = maxsp;
		}
	}

	private function keyControls():Void {
		_up = FlxG.keys.anyJustPressed(["UP"]);
		_down = FlxG.keys.anyPressed(["DOWN"]);
		_left = FlxG.keys.anyPressed(["LEFT"]);
		_right = FlxG.keys.anyPressed(["RIGHT"]);

		_fscreen = FlxG.keys.anyJustPressed(["F2"]);
		_mini = FlxG.keys.anyJustPressed(["F3"]);
	}

	private function getCoin(Coin:FlxObject, Player:FlxObject) {
		Coin.kill();
	}
}
