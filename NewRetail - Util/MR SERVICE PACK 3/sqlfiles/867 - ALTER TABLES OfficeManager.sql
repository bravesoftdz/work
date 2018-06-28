UPDATE Sis_MainMenu
SET ClassName = 'TFinLancamentoTipoListTree'
WHERE IDMenuItem = 77
GO

UPDATE Fin_LancamentoTipo
SET CodigoContabil = '1', Pagando = 0
WHERE IDLancamentoTipo = 0
GO

UPDATE Fin_LancamentoTipo
SET CodigoContabil = '2', Pagando = 1
WHERE IDLancamentoTipo = 1
GO

UPDATE Fin_LancamentoTipo
SET IDLancamentoTipoParent = 0
WHERE Pagando = 0 and IDLancamentoTipo not in (0,1)
GO

UPDATE Fin_LancamentoTipo
SET IDLancamentoTipoParent = 1
WHERE Pagando = 1 and IDLancamentoTipo not in (0,1)
GO

UPDATE Fin_LancamentoTipo
SET IDLancamentoTipoParent = NULL
WHERE IDLancamentoTipo in (0,1)
GO

INSERT Sis_MainMenu (IDMenuItem, IDMenuItemParent, FormID, MenuItem, LoaderType, MenuBarBefore, Priority, ClassName)
VALUES (149, 53, 66, 'Balance Sheet', 1, 1, 26, 'TFinLancamentoTipoResult')
GO

INSERT Sis_MainMenuLanguage (IDMenuItem, IDLanguage, MenuItem)
VALUES (149, 1, 'Balance Sheet')
GO

INSERT Sis_MainMenuLanguage (IDMenuItem, IDLanguage, MenuItem)
VALUES (149, 2, 'Balancete')
GO

INSERT Sis_MainMenuLanguage (IDMenuItem, IDLanguage, MenuItem)
VALUES (149, 3, 'Hoja de Balance')
GO

UPDATE Param
SET SrvValue = 'False', DefaultValue = 'False'
WHERE IDParam = 12
GO

ALTER TABLE TabGroup ADD
       TabGroupCode varchar(20) NULL
GO

UPDATE MeioPag
SET IDLancamentoTipo = 2
WHERE IDMeioPagBatch IS NOT NULL
GO
