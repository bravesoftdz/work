ALTER TABLE INVOICE ADD DeliverOBS varchar(255) NULL
GO

ALTER TABLE INVOICE ADD DeliverConfirmation TBit DEFAULT 0
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (49, 'Confirm delivery before sale', 'False', 'Boolean', 'Hold cannot be paid until the delivery option is checked', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (49, 1, 'Confirm delivery before sale', 'Hold cannot be paid until the delivery option is checked')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (49, 2, 'Marcar entrega antes de fechar a nota', 'A nota nao pode ser fechada ate que a entrega seja preenchida')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (49, 3, 'Confirme la entrega antes de la venta', 'Tenga no puede ser pagado hasta que la opción de la entrega se verificado')
GO
