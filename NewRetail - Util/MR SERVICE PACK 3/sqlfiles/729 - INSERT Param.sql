INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (99, 'Calculate commission on invoice', 'TRUE', 'Boolean', 'If this option is TRUE, the software will calculate commission on invoices. Otherwise, it calculates commission including hold.', 'TRUE', 0, 6)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (99, 1, 'Calculate commission on invoice', 'If this option is TRUE, the software will calculate commission on invoices. Otherwise, it calculates commission including hold.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (99, 2, 'Calcular comissão sobre fatura', 'Se esta opção for TRUE, o sistema calculará a comissão sobre Fatura. Se FALSE, calculará sobre pedidos e faturas.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (99, 3, 'Calcular la comisión en factura', 'Si esta opción es TRUE, el software calculará a comisión en facturas. Si FALSE, calcula a comisión incluyendo boletos.')
GO

UPDATE Param
SET SrvValue = (SELECT (CASE SrvValue WHEN '2' THEN 'False' ELSE 'True' END) FROM Param Where IDParam = 63)
WHERE IDParam = 99
GO
