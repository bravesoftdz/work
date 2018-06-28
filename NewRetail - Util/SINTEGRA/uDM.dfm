object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 221
  Top = 160
  Height = 340
  Width = 484
  object MRDBConnection: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=RodrigoTestDB;Data Source=(local);Use P' +
      'rocedure for Prepare=1;Auto Translate=True;Packet Size=4096;Work' +
      'station ID=IGM001;Use Encryption for Data=False;Tag with column ' +
      'collation when possible=False'
    ConnectionTimeout = 20
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 69
    Top = 22
  end
  object quProduto: TADODataSet
    Connection = MRDBConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'I.InvoiceDate,'#13#10#9'I.CupomFiscal,'#13#10#9'MOV.Qty,'#13#10#9'MOV.MovDa' +
      'te,'#13#10#9'MOV.ModelID,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'((MOV.SalePrice' +
      ' * MOV.Qty) - MOV.Discount) as ExtSubTotal,'#13#10#9'(MOV.SalePrice - M' +
      'OV.Discount) as SalePrice,'#13#10'                MOVT.TaxValue,'#13#10'    ' +
      '            MOVT.Tax,'#13#10#9'TCX.SituacaoTributaria,'#13#10#9'I.NumeroSerieP' +
      'rinter'#13#10'FROM'#13#10#9'Invoice I'#13#10'        JOIN InventoryMOV MOV ON (MOV.' +
      'DocumentID = I.IDInvoice)'#13#10'        JOIN Model M ON (M.IDModel = ' +
      'MOV.ModelID)'#13#10#9'JOIN InventoryMOVTax MOVT ON (MOVT.IDInventoryMOV' +
      ' = MOV.IDInventoryMOV)'#13#10#9'JOIN TaxCategory TCX ON (MOVT.IDTaxCate' +
      'gory = TCX.IDTaxCategory)'#13#10'WHERE'#13#10#9'I.CupomFiscal IS NOT NULL'#13#10#9'A' +
      'ND'#13#10'        MOV.InventMOVTypeID = 1'#13#10#9'AND'#13#10#9'TCX.OperationType = ' +
      '1'#13#10#9'AND'#13#10#9'TCX.SaleTaxType = 2'#13#10'                AND'#13#10#9'I.InvoiceDa' +
      'te >= :Data_Inicial '#13#10#9'AND '#13#10#9'I.InvoiceDate < :Data_Final'#13#10#9'AND ' +
      #13#10#9'I.NumeroSeriePrinter = :NumeroSeriePrinter'#13#10'ORDER BY'#13#10#9'Invoic' +
      'eDate'#13#10#13#10#13#10
    Parameters = <
      item
        Name = 'Data_Inicial'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Data_Final'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'NumeroSeriePrinter'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 70
    Top = 80
    object quProdutoInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object quProdutoQty: TIntegerField
      FieldName = 'Qty'
    end
    object quProdutoMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object quProdutoModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quProdutoTaxValue: TBCDField
      FieldName = 'TaxValue'
      Precision = 19
    end
    object quProdutoExtSubTotal: TBCDField
      FieldName = 'ExtSubTotal'
      ReadOnly = True
      Precision = 19
    end
    object quProdutoCupomFiscal: TStringField
      FieldName = 'CupomFiscal'
      Size = 8
    end
    object quProdutoSituacaoTributaria: TIntegerField
      FieldName = 'SituacaoTributaria'
    end
    object quProdutoNumeroSeriePrinter: TStringField
      FieldName = 'NumeroSeriePrinter'
    end
    object quProdutoTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object quProdutoModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quProdutoDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quProdutoSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      Precision = 19
    end
  end
  object quImpSerial: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT DISTINCT'#13#10#9'NumeroSeriePrinter'#13#10'FROM'#13#10#9'Invoice'#13#10'WHERE'#13#10#9'Nu' +
      'meroSeriePrinter is not null'#13#10
    Parameters = <>
    Left = 340
    Top = 16
    object quImpSerialNumeroSeriePrinter: TStringField
      FieldName = 'NumeroSeriePrinter'
    end
  end
  object quVendaBruta: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT '#13#10#9'SUM(SubTotal - ItemDiscount + AditionalExpenses) as Ve' +
      'ndaBruta'#13#10'FROM '#13#10#9'Invoice'#13#10'WHERE '#13#10#9'NumeroSeriePrinter = :NumSer' +
      'io'#13#10#13#10#13#10
    Parameters = <
      item
        Name = 'NumSerio'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 340
    Top = 76
  end
  object quHasSale: TADODataSet
    Connection = MRDBConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'I.InvoiceDate'#13#10'FROM'#13#10#9'Invoice I'#13#10'WHERE'#13#10#9'I.CupomFiscal' +
      ' IS NOT NULL'#13#10#9'AND'#13#10#9'I.InvoiceDate >= :Data_Inicial '#13#10#9'AND '#13#10#9'I.' +
      'InvoiceDate < :Data_Final'#13#10#9'AND'#13#10#9'I.Canceled = 0'
    Parameters = <
      item
        Name = 'Data_Inicial'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Data_Final'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 338
    Top = 140
  end
end
