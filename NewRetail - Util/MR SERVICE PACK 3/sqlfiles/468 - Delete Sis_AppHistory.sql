DELETE
	Sis_AppHistory
WHERE
	FormSource = 'Error: sp_PreSale_SubAddItem'
	OR FormSource = 'Error: sp_PreSale_CalcCustomerDiscount'
	OR FormSource = 'Error: sp_PreSale_AddItem'
	OR FormSource = 'Error: sp_PreSale_SubRemoveItem'
GO
