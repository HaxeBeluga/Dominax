package game;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;

enum DominoColor
{
	BLACK;
	RED;
	GREEN;
	BLUE;
}

/**
 * ...
 * @author Masadow
 */
class Domino extends FlxSprite
{
	//Determine the number of occurence of a exact same domino inside the stack
	private static var COPIES : Int = 2;
	
	private var dominoColor : DominoColor;
	private var value : Int;

	public static function makeStack() : Array<Domino>
	{
		var stack : Array<Domino> = [];
		var colors = DominoColor.createAll();
		for (v in 1...8)
		{
			for (c in colors)
			{
				for (i in 0...COPIES)
				{
					stack.push(new Domino(c, v));
				}
			}
		}
		//Don't forget to shuffle the stack
		return FlxG.random.shuffleArray(stack, stack.length * 8);
	}
	
	public function new(c : DominoColor, v : Int)
	{
		super();

		dominoColor = c;
		value = v;
		
		//Make sprite
		this.loadGraphic("images/classic.png", false, 32, 64, true);
		this.animation.frameIndex = v - 1 + 7 * c.getIndex();
	}
	
}