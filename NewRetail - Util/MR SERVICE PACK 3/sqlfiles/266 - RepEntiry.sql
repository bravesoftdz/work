if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Entity]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Entity]
GO

CREATE VIEW vw_Rep_Entity AS
SELECT 
	P.IDPessoa as IDPerson,
	P.IDPessoa as IDAgency,
	P.IDPessoa as IDAgenty,
	P.IDPessoa as IDCustomer,
	P.IDPessoa as IDVendor,
	P.IDPessoa as IDCommission,
	P.IDPessoa as IDManufactore,
 	P.IDTipoPessoa as IDPersonType,
	P.IDStore as IDStore,
	P.IDEstado as IDState,
	P.IDUser as IDUser,
	P.IDPais as IDCountry ,
	P.Code as Code,
	P.Pessoa as FullName,
	P.PessoaFirstName as FirstName,
	P.PessoaLastName as LastName,
	P.NomeJuridico as DBA,
	P.Endereco as Address,
	P.Cidade as City,
	P.CEP as Zip,
	P.Telefone as Phone,
	P.Cellular as Cellular,
	P.Fax as Fax,
	P.Beeper as Beeper,
	P.Contato as Contact,
	P.Email as Email,
	P.Limite as Limit,
	P.Nascimento as BirthDate,
	P.DiaQuitacao as PaymentDay,
	P.CPF as BirthState,
	P.CartTrabalho as SocialSecurity,
	P.InscEstadual as FederalID,
	P.InscMunicipal as SalesTax,
	P.HomePage as HomePage,
	P.OrgaoEmissor as DriveLicense,
	P.ComissaoSobreGuia as GuideCommission,
	P.DescontaCoordenacao as CoordDiscount,
	P.AjusteComiss as CommissAjust,
	P.CustomerCard as CustomerCard,
	P.Bairro as Neighborhood,
	P.OBS
FROM 
	Pessoa P
GO
