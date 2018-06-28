INSERT INTO Sis_PropertyDomain(Property, PropertyValue) VALUES('InvCountConfigNumItens', '0')
GO

INSERT INTO Sis_PropertyDomain(Property, PropertyValue) VALUES('InvCountConfigPrintWhen','0')
GO

INSERT INTO Sis_PropertyDomain(Property, PropertyValue) VALUES('InvCountConfigCategory', '')
GO

UPDATE Param SET Desativado = 1 WHERE IDParam IN (46,47)
GO
