package com.mainretail.handheld.inventory;

public class InvCount {

	public int idcount;
	public int idstore;
	public int counttype;

	public InvCount(int idcount, int idstore, int counttype) {
		super();
		this.idcount = idcount;
		this.idstore = idstore;
		this.counttype = counttype;
	}

	public InvCount() {

	}

	public String toString()
	{
		return idcount + " " + idstore + " " + counttype;
	}
}