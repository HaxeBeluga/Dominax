package ;

import flixel.FlxG;
import game.Domino;
import game.Hand;
import state.PlayState;

/**
 * ...
 * @author Masadow
 */
class Player implements IPlayer
{
	public var name(default, null) : String;
	public var id(default, null) : String;

	public static var logged(default, null) : Player = null;

	// in game vars
	private var hand : Hand;
	private var score : Int;
	private var select : Domino;
	
	//Asynchronous call
	public static function login(result : Dynamic)
	{
		if (result != null)
			logged = new Player(result.id, result.name);
	}

	private function new(id : String, name : String)
	{
		this.id = id;
		this.name = name;
		
		hand = new Hand();
		score = 0;
	}
	
	//IPlayer implements
	
	public function getHand() : Hand
	{
		return hand;
	}
	
	public function getScore() : Int
	{
		return score;
	}
	
	public function play(game : PlayState)
	{
		var mouse = FlxG.mouse.cursorContainer;
		var unselect = FlxG.mouse.justPressed;
		game.cursor.visible = false;
		for (domino in hand)
		{
			if (mouse.x > domino.x && mouse.x < domino.x + domino.width
				&& mouse.y > domino.y && mouse.y < domino.y + domino.height)
			{
				game.cursor.x = domino.x;
				game.cursor.y = domino.y;
				game.cursor.visible = true;
				unselect = false;
				if (FlxG.mouse.justPressed)
				{
					if (select == domino)
					{ //Unselect
						select = null;
						game.select.visible = false;
					}
					else
					{
						select = domino;
						game.select.x = domino.x;
						game.select.y = domino.y;
						game.select.visible = true;
					}
				}
			}
		}
		if (unselect)
		{
			select = null;
			game.select.visible = false;
		}
	}
	
}