package com.mainretail.handheld.inventory;


public class FrozeCountService {
	
	public static FrozeCount toFrozeCount(InvCountItem invcountitem){
		
		FrozeCount frozecount = new FrozeCount();
				
		frozecount.idcount = invcountitem.idcount;
						
		return frozecount;	
	}

}
