package ia;
import game.Hand;
import state.PlayState;

/**
 * ...
 * @author Masadow
 */
class Random implements IPlayer
{
	
	private var hand : Hand;
	private var score : Int;

	public function new() 
	{
		hand = new Hand();
		score = 0;
	}
	
	// IPlayer
	public function getHand() : Hand
	{
		return hand;
	}

	public function getScore() : Int
	{
		return score;
	}
	
	public function play(game : PlayState) : Void
	{
		
	}

}