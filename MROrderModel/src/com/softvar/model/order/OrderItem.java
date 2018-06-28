/**
 * 
 */
package com.softvar.model.order;

import java.io.Serializable;

/**
 * @author macleod
 *
 */
public class OrderItem implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = -6378827030346278585L;
	public int iditem;
	public int idorder;
	public int idproduct;
	public double qty;
	public String description;
	public double cost;
}
