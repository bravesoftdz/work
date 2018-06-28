INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (110, 'Service Order Type', '0', 'Integer', '0 - Other, 1 - Auto Repair', '0', 0, 9)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (110, 1, 'Service Order Type', '0 - Other, 1 - Auto Repair')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (110, 2, 'Tipo de Ordem Serviço', '0 - Outros, 1 - Auto-peças')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (110, 3, 'Tipo de Orden de Servicio', '0 - Otros, 1 - Repar. de Automóviles')
GO

INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (111, 'Disable Defects in Service Order', 'False', 'Boolean', 'If this option is TRUE, system will disable defects option on Service Order.', 'False', 0, 9)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (111, 1, 'Disable Defects in Service Order', 'If this option is TRUE, system will disable defects option on Service Order.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (111, 2, 'Desabilite defeitos na OS', 'Se esta opção for TRUE, O sistema irá desativar a opção defeitos na Service Order.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (111, 3, 'Deshabilitar defectos en la OS', 'Si esta opción es TRUE, se desactivará el sistema de opción sobre defectos de la orden de servicio.')
GO
