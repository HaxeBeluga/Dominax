package ;
import game.Hand;
import game.Domino;
import state.PlayState;

/**
 * ...
 * @author Masadow
 */
interface IPlayer
{
	public function getHand() : Hand;
	public function getScore() : Int;
	public function play(game : PlayState) : Void;
}
