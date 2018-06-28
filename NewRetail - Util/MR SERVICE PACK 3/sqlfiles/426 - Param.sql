Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (80, 'Apply promo on sale', 'False', 'Boolean', 'When a product will be added for sale, the system will go to process the promotion that it will be tied.', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (80, 1, 'Apply promo on sale', 'When a product will be added for sale, the system will go to process the promotion that it will be tied.')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (80, 2, 'Aplicar promoção na venda', 'Quando um produto for adicionado à venda, o sistema irá processar a promoção que ele estiver vinculado.')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (80, 3, 'Apliqúese promoción en la venta', 'Cuando un producto será agregado para la venta, el sistema irá a procesar la promoción que será atado.')
GO
