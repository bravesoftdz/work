ALTER TABLE Fin_LancamentoTipo ADD
	IDCentroCusto int NULL
GO

ALTER TABLE Fin_LancamentoTipo ADD
	SugereCentroCusto bit NULL
GO

ALTER TABLE Fin_LancamentoTipo ADD CONSTRAINT
	FK_ContaCorrente_CentroCusto_IDCentroCustoDefault FOREIGN KEY (IDCentroCusto) REFERENCES Fin_CentroCusto
GO
