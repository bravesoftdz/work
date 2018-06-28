ALTER TABLE CustomerCredit ADD IDLancamento int null
GO

CREATE INDEX XIF4CustomerCredit ON CustomerCredit
(
       IDLancamento
)
GO

ALTER TABLE CustomerCredit
       ADD CONSTRAINT FK_Fin_Lancamento_CustomerCredit_IDLancamento
              FOREIGN KEY (IDLancamento)
                             REFERENCES Fin_Lancamento
GO
