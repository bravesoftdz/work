INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (105, 'Update Budget prices in X days', '0', 'Integer', 'Type the number of days to auto update budget price. Set 0 do disable.', '0', 0, 1)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (105, 1, 'Update Budget prices in X days', 'Type the number of days to auto update budget. Set 0 do disable.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (105, 2, 'Atualizar Preços do Orçamento em X dias', 'Digite o número de dias para atualizar automáticamente o preço do orçamento. Digite 0 fazer desativar.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (105, 3, 'Actualiza precios Presupuesto de X días', 'Escriba el número de días para actualización automática del presupuesto. 0 Conjunto hacer desactivar.')
GO
