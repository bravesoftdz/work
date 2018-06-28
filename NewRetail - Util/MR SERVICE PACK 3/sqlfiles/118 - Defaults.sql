ALTER TABLE HistoryType ADD CONSTRAINT
	DF_HistoSystem DEFAULT (0) FOR System
GO

ALTER TABLE HistoryType ADD CONSTRAINT
	DF_HistoHidden DEFAULT (0) FOR Hidden
GO

ALTER TABLE HistoryType ADD CONSTRAINT
	DF_HistoDesativ DEFAULT (0) FOR Desativado
GO

UPDATE Sis_CodigoIncremental SET UltimoCodigo=2
WHERE Tabela='HistoryType.IDHistoryType'
GO
