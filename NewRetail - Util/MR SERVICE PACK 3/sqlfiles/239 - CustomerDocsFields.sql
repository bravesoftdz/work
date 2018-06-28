ALTER TABLE Pessoa ADD CartMotorista varchar(15) NULL
GO

ALTER TABLE Pessoa ADD DataExpedicao DateTime NULL
GO

UPDATE Pessoa SET CartMotorista = SUBSTRING(OrgaoEmissor, 1, 15)
GO

UPDATE Pessoa SET OrgaoEmissor = NULL
GO

UPDATE Pessoa SET Identidade = CartTrabalho
GO

UPDATE Pessoa SET CartTrabalho = Null
GO

