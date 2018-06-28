Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (50, 'Display Payment Place on Sale', 'False', 'Boolean', 'Check this option to display field for choosing payment place option', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (50, 1, 'Display payment place on sale', 'Type True to display the field for choosing payment place option')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (50, 2, 'Exibir local do pagamento na venda', 'Selecione True para exibir o campo local do pagamento quando for recever o dinheiro')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (50, 3, 'Demuestre campo lugar del en Recibir', 'Escriba True demostrar el campo lugar del pago')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (51, 'Enter layaway full amount', 'False', 'Boolean', 'Type True to enter full amount on layaway', 'False')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (51, 1, 'Enter layaway full amount', 'Type True to enter full amount on layaway')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (51, 2, 'Exigir quitacao total do pedido', 'Selecione True para quitar o total do pedido antes de fechar')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (51, 3, 'Entre el depósito la cantidad repleta', 'Escriba True para entrar la cantidad repleta en el depósito')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (52, 'Invoice Tab - show other costs', 'False', 'Boolean', 'Type True to displat tab other costs on invoice', 'False')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (52, 1, 'Invoice Tab - show other costs', 'Type True to displat tab other costs on invoice')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (52, 2, 'Tab Nota - Mostrar outros custos', 'Selecione True exibir o tab outros custos na nota')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (52, 3, 'La factura - muestra otros costos', 'Escriba True para mostrar otros costos en la factura')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (53, 'Invoice Tab - show Payment Receive', 'False', 'Boolean', 'Type True to displat tab payments on invoice', 'False')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (53, 1, 'Invoice Tab - show Payment Receive', 'Type True to displat tab payments on invoice')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (53, 2, 'Tab Nota - mostrar pagamentos', 'Selecione True exibir o tab de pagamentos na nota')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (53, 3, 'La factura - muestra pagos', 'Escriba True para mostrar pagos en la factura')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (54, 'Invoice Tab - show Agent Info', 'False', 'Boolean', 'Type True to displat tab Agent info on invoice', 'False')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (54, 1, 'Invoice Tab - show Agent Info', 'Type True to displat tab Agent info on invoice')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (54, 2, 'Tab Nota - Mostrar Agencia', 'Selecione True exibir o tab de Agencia na nota')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (54, 3, 'La factura - muestra guias', 'Escriba True para mostrar guias en la factura')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (55, 'Invoice Tab - show delivery', 'False', 'Boolean', 'Type True to displat tab delivery on invoice', 'False')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (55, 1, 'Invoice Tab - show delivery', 'Type True to displat tab Delivery on invoice')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (55, 2, 'Tab Nota - Mostrar entrega', 'Selecione True exibir o tab de entrega na nota')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (55, 3, 'La factura - muestra entrega', 'Escriba True para mostrar entrega en la factura')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (56, 'Invoice Tab - show deposit date', 'False', 'Boolean', 'Type True to displat tab deposit date on invoice', 'False')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (56, 1, 'Invoice Tab - show deposit date', 'Type True to displat tab deposit date on invoice')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (56, 2, 'Tab Nota - Mostrar data depósito', 'Selecione True exibir o tab de data depósito na nota')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (56, 3, 'La factura - muestra fetcha depósito', 'Escriba True para mostrar fetcha depósito en la factura')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (57, 'Invoice Tab - show discount', 'True', 'Boolean', 'Type True to displat tab discount on invoice', 'True')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (57, 1, 'Invoice Tab - show discount', 'Type True to displat tab discount on invoice')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (57, 2, 'Tab Nota - Mostrar desconto', 'Selecione True exibir o tab de desconto na nota')
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (57, 3, 'La factura - muestra descuento', 'Escriba True para mostrar descuento en la factura')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue, Desativado)
Values (58, 'Max number of payments', '12', 'Integer', 'Enter number of disbursement for payments', '12', 0)
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (58, 1, 'Max number of payments', 'Enter number of disbursement for payments')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (58, 2, 'Número máximo de parcelas', 'Entre com o número máximo de parcelas para notas pre-datadas')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (58, 3, 'El número máx de pagos', 'Entre el número del desembolso para pagos')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue, Desativado)
Values (59, 'Enable SERASA', 'False', 'Boolean', 'Type True to enable SERASA', 'False', 0)
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (59, 2, 'Consulta SERASA', 'Selecione True para habilitar a consulta no SERASA')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue, Desativado)
Values (60, 'ZipCode Database', '', 'String', 'Type the server and table to locate the zip code', 'siCEPDB', 0)
GO
 
Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (60, 2, 'Banco de dados CEP', 'Selecione o banco de dados para procuprar o CEP')
GO
