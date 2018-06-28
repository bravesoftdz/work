IF EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'MeioPag' AND SC.name = 'CodFiscal')
  ALTER TABLE MeioPag DROP COLUMN CodFiscal
GO

IF EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'MeioPag' AND SC.name = 'DescFiscal')
  ALTER TABLE MeioPag DROP COLUMN DescFiscal
GO

IF EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'TaxCategory' AND SC.name = 'ECFTaxIndex')
  ALTER TABLE TaxCategory DROP COLUMN ECFTaxIndex
GO
