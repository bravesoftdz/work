INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (102, 'Save un-posted Payment closing register', 'False', 'Boolean', 'If this option is TRUE, it will save un-posted payment when close register with option 2 = Office', 'False', 0, 1)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (102, 1, 'Save un-posted Payment closing register', 'If this option is TRUE, it will save un-posted payment when close register with option 2 = Office')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (102, 2, 'Salvar Pagamentos no Fechamento do caixa', 'Se esta opção for TRUE, o sistema salvará os pagamentos não quitados quando o caixa for do tipo 2 = Office')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (102, 3, 'Registrar de cierre un-fijado del pago', 'Si esta opción es TRUE, ahorrará el pago un-fijado cuando está cercana se coloca con la opción 2 = Office')
GO
