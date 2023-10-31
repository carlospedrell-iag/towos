package ;
import flixel.FlxSprite;
/**
 * ...
 * @author ...
 */
class Dust extends FlxSprite
{
	private var sjump:Bool = false;

	public function new(x:Float,y:Float,is_secondjump:Bool) 
	{
		super(x, y);
		sjump = is_secondjump;
		if(!sjump){ loadGraphic("assets/images/player/dust.png", true, 32, 14);} else {loadGraphic("assets/images/left.png", true, 32, 14);}
		  
		animation.add("dust", [1, 2, 3, 4, 5, 6], 14, false);
		animation.play("dust");
	}
	
	override public function update(elapsed: Float):Void 
    {
		alpha -= 0.03;
		
		if(alpha < 0) { 
            kill();
        }
		
		super.update(elapsed);
	}
}