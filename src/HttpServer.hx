package ;

import beluga.module.account.Account;
import beluga.module.wallet.Wallet;
import beluga.module.market.Market;
import beluga.core.Beluga;
import haxe.ds.Option;

/**
 * ...
 * @author Masadow
 */
class HttpServer
{

	public function new() 
	{
		
	}
	
	public function login(id : Int)
	{
		var acc = Beluga.getInstance().getModuleInstance(Account);
		var usr = acc.getUser(id);
		return usr != null ? { id: usr.id, name: usr.login } : null;
	}
	
	public function getMarket(id : Int)
	{
		//Get user
		var acc = Beluga.getInstance().getModuleInstance(Account);
		var usr = acc.getUser(id);
		//Get user funds
		var wallet = Beluga.getInstance().getModuleInstance(Wallet);
		var currency = wallet.getSiteCurrencyOrDefault();
		var fund = wallet.getCurrentFunds(usr, currency);
		var credit : Float;
		switch (fund)
		{
			case None:
				credit = 0;
			case Some(v):
				credit = v;
		}
		//Get products
		var market = Beluga.getInstance().getModuleInstance(Market);
		var products = market.getProductList();
		//Return all informations
		return {fund: credit, currency: currency.cu_name, products: products};
	}
	
}