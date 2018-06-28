ALTER TABLE Nfe_NotaFiscal DROP COLUMN
       XMLEnviado,
       XMLRecebido
GO

ALTER TABLE Nfe_NotaFiscal ADD
       XMLEnviado           Text NULL,
       XMLRecebido          Text NULL,
       Chave	            varchar(255) NULL
GO
