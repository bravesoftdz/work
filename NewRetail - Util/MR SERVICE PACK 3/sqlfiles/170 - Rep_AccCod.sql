if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordType]
GO

CREATE VIEW vw_Rep_Acc_RecordType (IDRecordType, IDPerson, IDPersonType, IDBankAccount, IDRecordTypeParent, RecordType, Path, PathName, System, Hidden, Deleted, AccountCode)  AS
       SELECT LT.IDLancamentoTipo, LT.IDPessoa, LT.IDPessoaTipo, LT.IDContaCorrenteDefault, LT.IDLancamentoTipoParent, LT.LancamentoTipo, LT.Path, LT.PathName, LT.System, LT.Hidden, LT.Desativado, LT.CodigoContabil
       FROM Fin_LancamentoTipo LT

GO

INSERT INTO Rep_Field (tablename, fieldname, fieldalias, datatype, selectable, searchable, sortable, autosearch, mandatory)
VALUES ('vw_Rep_Acc_RecordType', 'AccountCode', 'AccountCode', 'dtString', 'T', 'T', 'T', 'T', 'T')
GO