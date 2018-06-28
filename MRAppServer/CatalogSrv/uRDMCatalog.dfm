object RDMCatalog: TRDMCatalog
  OldCreateOrder = False
  Left = 618
  Top = 481
  Height = 259
  Width = 406
  object dspSearchProduct: TDataSetProvider
    DataSet = qrySearchProduct
    BeforeGetRecords = dspSearchProductBeforeGetRecords
    AfterGetRecords = dspSearchProductAfterGetRecords
    Left = 32
    Top = 60
  end
  object qrySearchProduct: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = '#39'M' +
        'RCatalogDB'#39')'
      
        #9'IF EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Name ' +
        '= '#39'Products'#39' AND xtype = '#39'U'#39')'
      #9#9'SELECT'
      #9#9#9'P.sku SkuProduct,'
      #9#9#9'P.Upc,'
      #9#9#9'P.Title,'
      #9#9#9'P.Department as Category,'
      #9#9#9'P.Category as SubCategory,'
      #9#9#9'P.SubCategory as CGroup,'
      #9#9#9'P.retail_price MSRP,'
      #9#9#9'PV.vsku SkuVendor,'
      #9#9#9'PV.vCost VendorCost,'
      #9#9#9'V.Vendor,'
      #9#9#9'V.Company VendorCompany'
      #9#9'FROM'
      #9#9#9'MRCatalogDB..Products P'
      #9#9#9'JOIN MRCatalogDB..Products_Vendors PV ON (P.sku = PV.sku)'
      #9#9#9'JOIN MRCatalogDB..Vendors V ON (PV.IDVendor = V.IDVendor)'
      '')
    Left = 32
    Top = 12
  end
  object dspLUVendor: TDataSetProvider
    DataSet = qryLUVendor
    Left = 32
    Top = 171
  end
  object qryLUVendor: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF EXISTS (select * from master.dbo.sysdatabases where name = '#39'M' +
        'RCatalogDB'#39')'
      'BEGIN'
      
        #9'IF EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Name ' +
        '= '#39'Vendors'#39' AND xtype = '#39'U'#39')'
      #9'BEGIN'
      #9#9'SELECT'
      #9#9#9'IDVendor,'
      #9#9#9'Vendor'
      #9#9'FROM'
      #9#9#9'MRCatalogDB..Vendors'
      #9#9'WHERE'
      #9#9#9'IsNull(IDVendorMR,0) <> 0'
      #9#9'ORDER BY'
      #9#9#9'Vendor'
      #9'END'
      #9'ELSE'
      #9#9'SELECT'
      #9#9#9'0 IDVendor,'
      #9#9#9'cast('#39#39' as varchar(50)) Vendor'
      'END'
      'ELSE'
      #9'SELECT'
      #9#9'0 IDVendor,'
      #9#9'cast('#39#39' as varchar(50)) Vendor')
    Left = 32
    Top = 120
  end
  object dspLUDepartment: TDataSetProvider
    DataSet = qryLUDepartment
    Left = 128
    Top = 171
  end
  object qryLUDepartment: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF EXISTS (select * from master.dbo.sysdatabases where name = '#39'M' +
        'RCatalogDB'#39')'
      'BEGIN'
      
        #9'IF EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Name ' +
        '= '#39'Products'#39' AND xtype = '#39'U'#39')'
      #9'BEGIN'
      #9#9'SELECT'
      #9#9#9'Department'
      #9#9'FROM'
      #9#9#9'MRCatalogDB..Products'
      #9#9'GROUP BY'
      #9#9#9'Department'
      #9#9'ORDER BY'
      #9#9#9'Department'
      #9'END'
      #9'ELSE'
      #9#9'SELECT'
      #9#9#9'cast('#39#39' as varchar(50)) Department'
      'END'
      'ELSE'
      #9'SELECT'
      #9#9'cast('#39#39' as varchar(50)) Department')
    Left = 128
    Top = 120
  end
  object dspLUCategory: TDataSetProvider
    DataSet = qryLUCategory
    Left = 220
    Top = 171
  end
  object qryLUCategory: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = '#39'M' +
        'RCatalogDB'#39')'
      'BEGIN'
      
        #9'IF EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Name ' +
        '= '#39'Products'#39' AND xtype = '#39'U'#39')'
      #9'BEGIN'
      #9#9'SELECT'
      #9#9#9'Category'
      #9#9'FROM'
      #9#9#9'MRCatalogDB..Products'
      #9#9'GROUP BY'
      #9#9#9'Category'
      #9#9'ORDER BY'
      #9#9#9'Category'
      #9'END'
      #9'ELSE'
      #9#9'SELECT'
      #9#9#9'cast('#39#39' as varchar(50)) Category'
      'END'
      'ELSE'
      #9'SELECT'
      #9#9'cast('#39#39' as varchar(50)) Category')
    Left = 220
    Top = 120
  end
  object dspLUSubCategory: TDataSetProvider
    DataSet = qryLUSubCategory
    Left = 316
    Top = 171
  end
  object qryLUSubCategory: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF EXISTS (SELECT * FROM master.dbo.sysdatabases WHERE name = '#39'M' +
        'RCatalogDB'#39')'
      'BEGIN'
      
        #9'IF EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Name ' +
        '= '#39'Products'#39' AND xtype = '#39'U'#39')'
      #9'BEGIN'
      #9#9'SELECT'
      #9#9#9'SubCategory'
      #9#9'FROM'
      #9#9#9'MRCatalogDB..Products'
      #9#9'GROUP BY'
      #9#9#9'SubCategory'
      #9#9'ORDER BY'
      #9#9#9'SubCategory'
      #9'END'
      #9'ELSE'
      #9#9'SELECT'
      #9#9#9'cast('#39#39' as varchar(50)) SubCategory'
      'END'
      'ELSE'
      #9'SELECT'
      #9#9'cast('#39#39' as varchar(50)) SubCategory')
    Left = 316
    Top = 120
  end
  object qryListVendor: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDVendorMR,'
      #9'IDVendor,'
      #9'Vendor'
      'FROM'
      #9'MRCatalogDB..Vendors'
      'ORDER BY'
      #9'Vendor'
      ''
      '')
    Left = 128
    Top = 12
  end
  object dspListVendor: TDataSetProvider
    DataSet = qryListVendor
    BeforeUpdateRecord = dspListVendorBeforeUpdateRecord
    Left = 128
    Top = 60
  end
end
