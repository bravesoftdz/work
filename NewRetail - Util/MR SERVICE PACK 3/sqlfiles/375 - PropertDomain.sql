DELETE ParamLanguage
WHERE IDParam IN (77, 78, 79)
GO

DELETE Param
WHERE IDParam IN (77, 78, 79)
GO

-- Periodo para calcular a curva ABC
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('ABCCalcPeriodInMonth', '6')
GO

-- Periodo para calcular as vendas da auto requisicao
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('AutoRequestSalePeriodInMonth', '3')
GO

--Percentual da Classe A
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('ClassAPerc', '60')
GO

--Percentual da Classe B
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('ClassBPerc', '25')
GO

--Percentual da Classe C
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('ClassCPerc', '15')
GO

--Periodo em dias que o produto nao pode faltar em estoque Classe A
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('POTimeSetupClassAInDays', '30')
GO

--Periodo em dias que o produto nao pode faltar em estoque Classe B
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('POTimeSetupClassBInDays', '20')
GO

--Periodo em dias que o produto nao pode faltar em estoque Classe C
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('POTimeSetupClassCInDays', '10')
GO

--Percentual da margem de seguranca no ponto de pedido ClassA
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PercSecurityMarginClassA', '30')
GO

--Percentual da margem de seguranca no ponto de pedido ClassB
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PercSecurityMarginClassB', '10')
GO

--Percentual da margem de seguranca no ponto de pedido ClassC
INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PercSecurityMarginClassC', '0')
GO
