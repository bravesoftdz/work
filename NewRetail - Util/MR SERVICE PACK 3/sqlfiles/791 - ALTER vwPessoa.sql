IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vwPessoa]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwPessoa]
GO

CREATE VIEW vwPessoa AS
SELECT
	P.IDPessoa,
	P.IDTipoPessoa,
	TP.Path,
	P.Pessoa,
	P.Telefone,
	P.Cellular,
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
	P.CustomerCard as CustomerCard,
	P.Bairro as Neighborwood,
	P.PhoneAreaCode,
	P.CellAreaCode,
	P.Nascimento,
	SU.[SystemUser]
FROM
	Pessoa P (NOLOCK)
	JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa)
	LEFT JOIN Pais C (NOLOCK) ON (P.IDPais = C.IDPais)
	LEFT JOIN Estado E (NOLOCK) ON (P.IDEstado = E.IDEstado)
	LEFT JOIN [SystemUser] SU (NOLOCK) ON (P.IDUser = SU.IDUser)
GO
