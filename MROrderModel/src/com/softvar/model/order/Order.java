/**
 * 
 */
package com.softvar.model.order;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

import com.softvar.model.Customer;

/**
 * @author macleod
 *
 */
public class Order implements Serializable {

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5535435446117455711L;
	public int idorder;
	public int idaccount;
	public ArrayList items = null;
	public Customer customer;
	public Date creation;
	public boolean finalized;
	
	public Order(){
		creation = new Date();
		items = new ArrayList();
		finalized = false;
	}

}


