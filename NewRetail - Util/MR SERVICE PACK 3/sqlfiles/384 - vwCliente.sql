if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCliente]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCliente]
GO

CREATE  VIEW vwCliente (IDCliente, IDTipoPessoa, Cliente, Customer, Code, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, asSystem, Desativado, Hidden, IDUser)  AS

SELECT
	P.IDPessoa,
	P.IDTipoPessoa,
	P.Pessoa as Cliente,
	P.Pessoa as Customer,
	P.Code,
	P.IDStore,
	P.NomeJuridico,
	P.Endereco,
	P.Bairro,
	P.Cidade,
	P.CEP,
	P.Pais,
	P.Telefone,
	P.Fax,
	P.Contato,
	P.Email,
	P.OBS,
	P.Juridico,
	P.TotalMovimentado,
	P.Limite,
	P.Nascimento,
	P.IDEstado,
	P.IDRamoAtividade,
	P.CPF,
	P.CGC,
	P.Identidade,
	P.CartTrabalho,
	P.InscEstadual,
	P.InscMunicipal,
	P.Contatos,
	P.NumAtrasos,
	P.NumMovimentacoes,
	P.DiasAtraso,
	P.NumTransacoes,
	P.HomePage,
	TP.Path,
	P.System,
	P.System,
	P.Desativado,
	P.Hidden,
	P.IDUser
FROM
	Pessoa P (NOLOCK)
	JOIN TipoPessoa TP ON (P.IDTipoPessoa = TP.IDTipoPessoa)
WHERE
	TP.Path LIKE '.001%'

GO
