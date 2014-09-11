package state;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Masadow
 */
class MarketState extends FlxSubState
{

	var money : FlxText;

	override public function create():Void 
	{
		super.create();
		
		this.bgColor = _parentState.bgColor;

		money = new FlxText(20, 20, 0, "", 16);
		
		var loadState = new LoadState("Looking for the market ...", applyMarket, "getMarket", [GameClass.playerId]);
		loadState.closeCallback = init;
		this.openSubState(loadState);		
	}
	
	public function applyMarket(result : Dynamic)
	{
		money.text = "You have " + result.fund + " " + result.currency;
		for (product in cast(result.products, List<Dynamic>))
		{
			FlxG.log.add(product.name);
		}
	}

	public function init()
	{
		add(money);
		add(new FlxButton(50, 400, "Back to menu", close));
	}
	
}