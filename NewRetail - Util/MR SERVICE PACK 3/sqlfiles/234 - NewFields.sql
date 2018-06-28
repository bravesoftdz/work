IF NOT EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'MeioPag' AND SC.name = 'CodFiscal')
  ALTER TABLE MeioPag ADD CodFiscal varchar(2)
GO

IF NOT EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'MeioPag' AND SC.name = 'DescFiscal')
  ALTER TABLE MeioPag ADD DescFiscal varchar(16)
GO

IF NOT EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'TaxCategory' AND SC.name = 'ECFTaxIndex')
  ALTER TABLE TaxCategory ADD ECFTaxIndex varchar(2)
GO

IF NOT EXISTS (SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND O.Name = 'Invoice' AND SC.name = 'CupomFiscal')
  ALTER TABLE Invoice ADD CupomFiscal varchar(8)
GO
