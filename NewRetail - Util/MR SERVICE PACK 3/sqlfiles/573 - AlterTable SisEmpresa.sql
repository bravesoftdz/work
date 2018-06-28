ALTER TABLE Sis_Empresa ADD
	IDEstado char(3),
	Numero int,
	Contato varchar(30),
	Telefone TTelephone,
	Fax TTelephone
GO

ALTER TABLE Sis_Empresa ADD CONSTRAINT
	FK_Estado_SisEmpresa_IDEstado FOREIGN KEY (IDEstado) REFERENCES Estado
GO
