if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPessoa]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPessoa]
GO

CREATE VIEW vwPessoa AS
SELECT 
	P.IDPessoa, 
	P.IDTipoPessoa, 
	TP.Path, 
	P.Pessoa, 
	P.Telefone, 
	P.Fax, 
	P.Code, 
	P.System, 
	P.Desativado, 
	P.Hidden, 
	C.Pais as Country, 
	E.Estado as StateName, 
	E.IDEstado as State, 
	P.Endereco as Address, 
	P.Cidade as City, 
	P.CEP as Zip, 
	P.Email, 
	P.Contato as Contact, 
	P.InscEstadual as FederalID, 
	P.InscMunicipal as SalesTax, 
	P.CartMotorista as DriverLicense,
	P.CartTrabalho as JobDoc,
	P.UserCode,
	P.Identidade as SocialSecurity,
	P.DataExpedicao as SCDate,
	P.OrgaoEmissor as SCGov,
	P.PessoaLastName as LastName,
	P.PessoaFirstName as FirstName, 
	P.CPF, 
	P.CGC, 
	P.CustomerCard as CustomerCard
FROM 
	Pessoa P
	JOIN TipoPessoa TP ON (P.IDTipoPessoa = TP.IDTipoPessoa)
	LEFT OUTER JOIN Pais C ON (P.IDPais = C.IDPais)
	LEFT OUTER JOIN Estado E ON (P.IDEstado = E.IDEstado)

GO
