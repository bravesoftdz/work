IF NOT EXISTS (Select IDParam From ParamLanguage Where IDParam = 66 and IDLanguage = 1)
INSERT ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (66, 1, 'Tax included on cost price', 'Taxes are included on cost price of the product') 
GO

IF NOT EXISTS (Select IDParam From ParamLanguage Where IDParam = 66 and IDLanguage = 2)
INSERT ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (66, 3, 'Impuesto incluido en precio de costo', 'Los impuestos son incluidos en el precio de costo del producto') 
GO
