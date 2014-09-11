package state;
import flash.text.GridFitType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import ia.Random;
import game.Domino;
import game.Grid;

/**
 * ...
 * @author Masadow
 */
class PlayState extends FlxState
{
	public var cursor : FlxSprite;
	public var select : FlxSprite;
	
	private var turn : Null<IPlayer>;
	private var computer : Random;
	private var human : Player;
	private var stack : Array<Domino>;
	
	//texts
	private var txtScoreHuman : FlxText;
	private var txtScoreComputer : FlxText;
	private var txtTurn : FlxText;
	
	override public function create():Void
	{
		super.create();
		
		bgColor = FlxColor.GRAY;
		
		add(new Grid(120, 80));
		
		cursor = new FlxSprite();
		cursor.visible = false;
		cursor.makeGraphic(32, 64, FlxColor.fromRGB(100, 100, 100, 100));

		select = new FlxSprite();
		select.visible = false;
		select.makeGraphic(32, 64, FlxColor.fromRGB(70, 70, 70, 100));
		
		computer = new Random();
		human = Player.logged;
		turn = null; //Not started yet

		stack = Domino.makeStack();
		
		add(txtScoreComputer = new FlxText(10, 10));
		add(txtScoreHuman = new FlxText(10, 20));
		add(txtTurn = new FlxText(150, 10, 0, "", 32));
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//Init the game
		if (turn == null)
		{
			fillHand(human);
			fillHand(computer);
			//Randomly determine the starting player
			turn = FlxG.random.bool() ? human : computer;
			turn = human; //TEMP !
			txtTurn.text = turn == human ? "It's your turn !" : "Wait for your opponent...";
		}
		//Let's play the current turn
		turn.play(this);
		//Update the displayed score
		txtScoreComputer.text = "Computer : " + computer.getScore();
		txtScoreHuman.text = "Human : " + human.getScore();
	}

	override public function draw():Void
	{
		super.draw();
		
		human.getHand().draw();
		
		if (cursor.visible)
			cursor.draw();
		
		if (select.visible)
			select.draw();
	}
	
	private function fillHand(p : IPlayer)
	{ //Draw up to 5 cards
		var hand = p.getHand();
		while (hand.size() < 5 && stack.length > 0)
		{
			hand.takeDomino(stack.pop());
		}
	}
}
