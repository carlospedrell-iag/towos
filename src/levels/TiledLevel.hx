package levels;

import haxe.io.Path;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;

import entities.GravityBase;
import entities.Spikes;
import entities.Treadmill;
import states.PlayState;

class TiledLevel extends TiledMap {
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/tiled/";

	// Array of tilemaps used for collision
	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
	public var tilemap:FlxTilemap;

	private var collidableTileLayers:Array<FlxTilemap>;
	private var _gravitybase:GravityBase;

	public var y_offset:Int = 18667;

	public function new(levelTiledMap:Dynamic) {
		super(levelTiledMap);

		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();

		// Load Tile Maps
		for (tileLayer in layers) {
			if (tileLayer is TiledTileLayer) {
				var tileSheetName:String = tileLayer.properties.get("tileset");

				if (tileSheetName == null)
					throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";

				var tileSet:TiledTileSet = null;
				for (ts in tilesets) {
					if (ts.name == tileSheetName) {
						tileSet = ts;
						break;
					}
				}

				if (tileSet == null)
					throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";

				var imagePath = new Path(tileSet.imageSource);
				var processedPath = c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;

				tilemap = new FlxTilemap();
				/* tilemap.widthInTiles = width;
					tilemap.heightInTiles = height; */
				tilemap.y = -18667;

				var tiledTileLayer:TiledTileLayer = cast tileLayer; // TODO: REMOVE?

				// tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
				tilemap.loadMapFromArray(tiledTileLayer.tileArray, width, height, processedPath, tileSet.tileWidth, tileSet.tileHeight,
					FlxTilemapAutoTiling.OFF, 1, 1, 1);

				if (tileLayer.properties.contains("nocollide")) {
					backgroundTiles.add(tilemap);
				} else {
					if (collidableTileLayers == null)
						collidableTileLayers = new Array<FlxTilemap>();

					foregroundTiles.add(tilemap);
					collidableTileLayers.push(tilemap);
				}
			}
		}
	}

	public function loadObjects(state:PlayState) {
		/* 		for (group in objectGroups)
			{
				for (o in group.objects)
				{
					loadObject(o, group, state);
				
				}
		}*/

		for (tiledLayer in layers) {
            if (tiledLayer is TiledObjectLayer) {
                var tiledObjectLayer:TiledObjectLayer = cast tiledLayer;
                FlxG.log.add("Loaded ObjectLayer " + tiledObjectLayer.name + ", length: " + tiledObjectLayer.objects.length);
				for (object in tiledObjectLayer.objects) {
					loadObject(object, tiledObjectLayer, state);
				}
			}
		}
	}

	private function loadObject(o:TiledObject, g:TiledObjectLayer, state:PlayState) {
		var x:Int = o.x;
		var y:Int = o.y;

		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= (g.map.getGidOwner(o.gid).tileHeight);

		switch (g.name.toLowerCase()) {
			/*case "gravity_base":
				_gravitybase = new GravityBase(x, y - 18667);
				state._gravbase.add(_gravitybase); */
			case "spawn":
				var spwn = new FlxSprite(x, y - y_offset);
				spwn.alpha = 0;
				state._spawn = spwn;
				state.add(spwn);

			case "gravity_base":
				var gravbase = new GravityBase(x, y - y_offset, 0);

				state._gravbase.add(gravbase);

			case "spike":
				var spk = new Spikes(x + 5, y - y_offset + 26);

				state._spike.add(spk);

			case "gravity_top":
				var gravtop = new GravityBase(x, y - y_offset, 1);

				state._gravbase.add(gravtop);

			case "gravity":
				var grav = new FlxObject(x, y - y_offset, o.width, o.height);
				state._gravity.add(grav);

			case "antigravity":
				var agrav = new FlxObject(x, y - y_offset, o.width, o.height);

				state._agravity.add(agrav);

			case "treadmill":
				var trdmill = new Treadmill(x, y - y_offset + 24, false);
                FlxG.log.add("Treadmill added ");

				state._treadmill.add(trdmill);

			case "treadmill2":
				var trdmill2 = new Treadmill(x, y - y_offset + 24, true);
                FlxG.log.add("Treadmill2 added ");

				state._treadmill2.add(trdmill2);

			case "ice":
				var ice = new FlxSprite(x, y - y_offset );
                ice.loadGraphic("assets/images/ice.png");
                ice.immovable = true;

                FlxG.log.add("ice added ");

				state._ice.add(ice);

            case "top_objects":

                if (o.type.toLowerCase() == "tmill_left") {
                FlxG.log.add("topobject tmill_left added ");

                    var tleft = new FlxSprite(x, y - y_offset);

                    tleft.loadGraphic("assets/tiled/level.png", true, 32, 32);
                    tleft.animation.add("stop", [51], 0);
                    tleft.animation.play("stop");

                    state.topobjects.add(tleft);

                } else if (o.type.toLowerCase() == "tmill_right") {
                FlxG.log.add("topobject tmill_tight added ");

                    var tright = new FlxSprite(x, y - y_offset);

                    tright.loadGraphic("assets/tiled/level.png", true, 32, 32);
                    tright.animation.add("stop", [64], 0);
                    tright.animation.play("stop");
    
                    state.topobjects.add(tright);
                }
		}
	}

	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool {
		if (collidableTileLayers != null) {
			for (map in collidableTileLayers) {
				// IMPORTANT: Always collide the map with objects, not the other way around.
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}
}
