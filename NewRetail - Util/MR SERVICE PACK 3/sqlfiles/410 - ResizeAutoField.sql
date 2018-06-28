ALTER TABLE Fin_Lancamento ADD NewColumn varchar(60)
GO

UPDATE 
	Fin_Lancamento
SET 
	NewColumn = NumMeioQuitPrevisto
GO

ALTER TABLE Fin_Lancamento DROP COLUMN NumMeioQuitPrevisto
GO

EXEC sp_rename 'Fin_Lancamento.NewColumn', 'NumMeioQuitPrevisto', 'COLUMN'
GO
