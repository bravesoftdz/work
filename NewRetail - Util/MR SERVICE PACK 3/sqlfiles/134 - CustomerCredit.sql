ALTER TABLE CustomerCredit
       DROP CONSTRAINT FK_Fin_Lancamento_CustomerCredit_IDLancamento
GO

ALTER TABLE CustomerCredit ADD IDPreInventoryMov int null
GO

CREATE  INDEX XIF5CustomerCredit ON CustomerCredit([IDPreInventoryMov]) ON [PRIMARY]
GO
