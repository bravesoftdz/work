INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (100, 'Auto generate transfer items number', 'False', 'Boolean', 'If this option will be TRUE, system will go automatically to generate the number of the transfer for new exit transfers.', 'False', 0, 5)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (100, 1, 'Auto generate transfer items number', 'If this option is TRUE, the software will calculate commission on invoices. Otherwise, it calculates commission including hold.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (100, 2, 'Gerar número de transferência automatico', 'Se esta opção for TRUE, sistema irá gerar automaticamente o número da transferência para novas transferências de saída.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (100, 3, 'Generar número de la transf. automatic.', 'Si esta opción es TRUE, el sistema irá automáticamente a generar el número de la transferencia para las nuevas transferencias de la salida.')
GO
