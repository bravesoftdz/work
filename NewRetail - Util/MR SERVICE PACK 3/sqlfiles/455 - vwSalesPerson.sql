if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSalesPerson]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSalesPerson]
GO

CREATE VIEW vwSalesPerson AS
SELECT 
	Pessoa.IDPessoa IDSalesPerson,
	TipoPessoa.IDTipoPessoa IDTipoSalesPerson,
	Pessoa.Pessoa SalesPerson,
	(Pessoa.PessoaFirstName + ', ' + Pessoa.PessoaLastName) as PessoaEdited,
	Pessoa.IDStore,
	Pessoa.NomeJuridico,
	Pessoa.Endereco,
	Pessoa.Bairro,
	Pessoa.Cidade,
	Pessoa.CEP,
	Pessoa.Pais,
	Pessoa.Telefone,
	Pessoa.Fax,
	Pessoa.Contato,
	Pessoa.Email,
	Pessoa.OBS,
	Pessoa.Juridico,
	Pessoa.TotalMovimentado,
	Pessoa.Limite,
	Pessoa.Nascimento,
	Pessoa.OrgaoEmissor,
	Pessoa.IDEstado,
	Pessoa.IDRamoAtividade,
	Pessoa.CPF,
	Pessoa.CGC,
	Pessoa.Identidade,
	Pessoa.CartTrabalho,
	Pessoa.InscEstadual,
	Pessoa.InscMunicipal,
	Pessoa.Contatos,
	Pessoa.NumAtrasos,
	Pessoa.NumMovimentacoes,
	Pessoa.DiasAtraso,
	Pessoa.NumTransacoes,
	Pessoa.HomePage,
	TipoPessoa.Path,
	Pessoa.System,
	Pessoa.Desativado,
	Pessoa.Hidden,
	Pessoa.IDUser,
	Pessoa.Code
FROM 	
	Pessoa,
	TipoPessoa
WHERE
	Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
	AND 
	TipoPessoa.Path LIKE '.003.001%'
GO
