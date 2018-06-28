inherited DMImportCatalogTextFile: TDMImportCatalogTextFile
  OldCreateOrder = True
  Left = 406
  Top = 166
  Height = 262
  Width = 261
  object qryCreateVendorTable: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF NOT EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Na' +
        'me = '#39'Vendor'#39' AND xtype = '#39'U'#39')'
      'BEGIN'
      'CREATE TABLE MRCatalogDB..Vendor ('
      '  IDVendor int IDENTITY(1, 1) PRIMARY KEY,'
      '  Vendor varchar(50))'
      'END')
    Left = 144
    Top = 16
  end
  object qryCreateDatabase: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'if not exists (select * from master.dbo.sysdatabases where name ' +
        '= '#39'MRCatalogDB'#39')'
      'CREATE DATABASE MRCatalogDB'
      '  ON (NAME=MRCatalogDB_dat,'
      '    FILENAME = '#39'C:\MRCatalogDB_bd.mdf'#39','
      '    SIZE = 5,'
      '    MAXSIZE= 20,'
      '    FILEGROWTH=5)'
      'LOG ON'
      '  (NAME= MRCatalogDB_log,'
      '    FILENAME = '#39'C:\MRCatalogDB_bd.ldf'#39','
      '    SIZE = 10,'
      '    MAXSIZE= 50,'
      '    FILEGROWTH=10 )')
    Left = 144
    Top = 68
  end
  object qryCreateModelCatalogTable: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'IF NOT EXISTS (SELECT Name FROM MRCatalogDB..sysobjects WHERE Na' +
        'me = '#39'Model_Catalog'#39' AND xtype = '#39'U'#39')'
      'BEGIN'
      'CREATE TABLE MRCatalogDB..Model_Catalog ('
      '  IDModelCatalog int,'
      '  IDModel int,'
      '  IDVendor int,'
      '  IDSize int,'
      '  IDColor int,'
      '  IDManufect int,'
      '  IDTabGroup int,'
      '  IDBarcode varchar(20),'
      '  Model varchar(30),'
      '  InvSize varchar(20),'
      '  InvColor varchar(20),'
      '  Description  varchar(50),'
      '  Manufacture varchar(50),'
      '  TabGroup varchar(30),'
      '  CustoPrice money,'
      '  SalePrice money,'
      '  VendorCode varchar(10),'
      '  Qty float,'
      '  QtyMin float, '
      '  QtyMax float)'
      'END')
    Left = 144
    Top = 124
  end
  object qryInsertModelCatalog: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'INSERT INTO MRCatalogDB..Model_Catalog'
      #9'(IDModelCatalog,'
      #9'IDVendor,'
      #9'IDBarcode,'
      #9'Model,'
      #9'InvSize,'
      #9'InvColor,'
      #9'Description,'
      #9'Manufacture,'
      #9'TabGroup,'
      #9'CustoPrice,'
      #9'SalePrice,'
      #9'VendorCode,'
      #9'Qty,'
      #9'QtyMin,'
      #9'QtyMax)'
      'Values '
      #9'( :IDModelCatalog,'
      #9':IDVendor,'
      #9':IDBarcode,'
      #9':Model,'
      #9':InvSize,'
      #9':InvColor,'
      #9':Description,'
      #9':Manufacture,'
      #9':TabGroup,'
      #9':CustoPrice,'
      #9':SalePrice,'
      #9':VendorCode,'
      #9':Qty,'
      #9':QtyMin,'
      #9':QtyMax )')
    Left = 144
    Top = 172
  end
end
