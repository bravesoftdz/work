if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwFabricante]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwFabricante]
GO

CREATE  VIEW vwFabricante (IDFabricante, Fabricante, IDTipoFabricante, Manufacturer, Code, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Cellular, Beeper, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, Desativado, Hidden, IDUser, IDPais, UserCode, Pessoa, IDPessoa)  AS
       SELECT Pessoa.IDPessoa, Pessoa, Pessoa.IDTipoPessoa, Pessoa, Pessoa.Code, Pessoa.IDStore, Pessoa.NomeJuridico, Pessoa.Endereco, Pessoa.Bairro, Pessoa.Cidade, Pessoa.CEP, Pessoa.Pais, Pessoa.Telefone, Pessoa.Cellular, Pessoa.Beeper, Pessoa.Fax, Pessoa.Contato, Pessoa.Email, Pessoa.OBS, Pessoa.Juridico, Pessoa.TotalMovimentado, Pessoa.Limite, Pessoa.Nascimento, Pessoa.OrgaoEmissor, Pessoa.IDEstado, Pessoa.IDRamoAtividade, Pessoa.CPF, Pessoa.CGC, Pessoa.Identidade, Pessoa.CartTrabalho, Pessoa.InscEstadual, Pessoa.InscMunicipal, Pessoa.Contatos, Pessoa.NumAtrasos, Pessoa.NumMovimentacoes, Pessoa.DiasAtraso, Pessoa.NumTransacoes, Pessoa.HomePage, TipoPessoa.Path, Pessoa.System, Pessoa.Desativado, Pessoa.Hidden, Pessoa.IDUser, Pessoa.IDPais, UserCode, Pessoa, Pessoa.IDPessoa
       FROM Pessoa, TipoPessoa
       WHERE Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
AND 
TipoPessoa.Path LIKE '.004%'
GO
