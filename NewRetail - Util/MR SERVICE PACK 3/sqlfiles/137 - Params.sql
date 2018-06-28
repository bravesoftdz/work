Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (66, 'Tax included on cost price', 'False', 'Boolean', 'Taxes are included on cost price of the product', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (66, 2, 'Imposto é incluído no preço de custo', 'Os impostos são incluídos no preço de custo do produto')
GO
