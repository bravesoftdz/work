if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPessoa]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPessoa]
GO

CREATE VIEW vwPessoa (IDPessoa, IDTipoPessoa, Path, Pessoa, Telefone, Fax, Code, System, Desativado, Hidden, Country, StateName, State, Address, City, Zip, Email, Contact, FederalID, SalesTax, SocialSecurity, DriverLicense, LastName, FirstName, CPF, CGC, CustomerCard)  AS
       SELECT P.IDPessoa, P.IDTipoPessoa, TP.Path, P.Pessoa, P.Telefone, P.Fax, P.Code, P.System, P.Desativado, P.Hidden, C.Pais, E.Estado, E.IDEstado, P.Endereco, P.Cidade, P.CEP, P.Email, P.Contato, P.InscEstadual, P.InscMunicipal, P.CartTrabalho, P.OrgaoEmissor, P.PessoaLastName, P.PessoaFirstName, P.CPF, P.CGC, P.CustomerCard
       FROM Pessoa P, TipoPessoa TP, Pais C, Estado E
       WHERE P.IDTipoPessoa = TP.IDTipoPessoa
AND 
P.IDPais *= C.IDPais
AND 
P.IDEstado *= E.IDEstado

GO
