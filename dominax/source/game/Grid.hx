package game;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Masadow
 */
class Grid extends FlxSprite
{
	private inline static var WIDTH = 24;
	private inline static var HEIGHT = 20;
	
	public function new(x : Int, y : Int)
	{
		super(x, y);
		
		makeGraphic(WIDTH * 16 + 1, HEIGHT * 16 + 1, FlxColor.GRAY);

		FlxSpriteUtil.setLineStyle( { color: FlxColor.WHITE } );
		for (y in 0...HEIGHT + 1)
		{
			FlxSpriteUtil.drawLine(this, 0, y * 16, WIDTH * 16, y * 16);
		}
		for (x in 0...WIDTH + 1)
		{
			FlxSpriteUtil.drawLine(this, x * 16, 0, x * 16, HEIGHT * 16);
		}
	}
}