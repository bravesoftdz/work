INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (90, 'Min length for to remove barcode digit', '0', 'Integer', 'Enter the minimal length for verify before to remove the bracode digits', '0', 0, 5)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (90, 1, 'Min length for to remove barcode digit', 'Enter the minimal length for verify before to remove the bracode digits')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (90, 2, 'Tamanho Mín p/ remover Digito Cód Barra', 'Entre com o tamanho mínimo a verificar antes de remover os Dígitos do Código de barras')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (90, 3, 'La long mín antes quita díg del barcode', 'Incorporar la longitud mínima para verifican antes para quitar los dígitos del bracode')
GO
