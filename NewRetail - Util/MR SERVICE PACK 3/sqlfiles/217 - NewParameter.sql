Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (71, 'Mark delivery only after receive payment', 'False', 'Boolean', 'If the payment place is set to "Other", you cannot mark delivery until receive all payments in a cash register', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (71, 1, 'Mark delivery only after receive payment', 'If the payment place is set to "Other", you cannot mark delivery until receive all payments in a cash register')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (71, 2, 'Marcar entrega depois que receber pgtos', 'Se o local de pagamento for  "Outros", o sistema não permitirá marcar entrega até receber todos os pagamentos.')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (71, 3, 'Marque entrega después que recibe pago', 'Si el lugar del pago es puesto a "Otros", usted no puede marcar la entrega hasta que reciba todos pagos')
GO
