package com.softvar.model.order;

public interface IProductDAO {
	Product findByUPC(String UPC);
}
