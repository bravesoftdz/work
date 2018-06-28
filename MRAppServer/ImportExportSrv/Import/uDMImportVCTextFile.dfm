inherited DMImportVCTextFile: TDMImportVCTextFile
  OldCreateOrder = True
  Left = 388
  Top = 195
  Height = 297
  Width = 442
  inherited qryInsConfigImport: TADOQuery
    Left = 235
    Top = 30
  end
  inherited qryUpdConfigImport: TADOQuery
    Left = 245
    Top = 100
  end
  object spPurchaseDo: TADOStoredProc
    ProcedureName = 'sp_Purchase_Do;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchase'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@TaxInCost'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 124
    Top = 28
  end
  object qryInsPurchase: TADOQuery
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUserPreReceiving'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DatePreReceiving'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DocumentType'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'DocumentNumber'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'DocumentDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DocumentDueDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Freight'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDPO'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'OtherCharges'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO Pur_Purchase'
      #9'(IDPurchase,'
      #9'IDFornecedor,'
      #9'IDStore,'
      #9'IDUserPreReceiving,'
      #9'DatePreReceiving,'
      #9'DocumentType,'
      #9'DocumentNumber,'
      #9'DocumentDate,'
      #9'DocumentDueDate,'
      #9'Freight,'
      #9'IDPO,'
      #9'OtherCharges)'
      'VALUES '
      #9'(:IDPurchase,'
      #9':IDFornecedor,'
      #9':IDStore,'
      #9':IDUserPreReceiving,'
      #9':DatePreReceiving,'
      #9':DocumentType,'
      #9':DocumentNumber,'
      #9':DocumentDate,'
      #9':DocumentDueDate,'
      #9':Freight,'
      #9':IDPO,'
      #9':OtherCharges)')
    Left = 32
    Top = 28
  end
  object qryGetIDPreInventoryMov: TADOQuery
    Parameters = <>
    Left = 144
    Top = 88
  end
  object qryInsPurchaseItem: TADOQuery
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPOItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'BarCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewCostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewSalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewSuggRetail'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'FreightCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'OtherCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'CaseQty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'CaseCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IsPromo'
        DataType = ftBoolean
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO Pur_PurchaseItem'
      #9'(IDPurchaseItem,'
      #9'IDPurchase,'
      #9'IDGroup,'
      #9'IDFornecedor,'
      #9'IDModel,'
      #9'IDPOItem,'
      #9'BarCode,'
      #9'CostPrice,'
      #9'NewCostPrice,'
      #9'NewSalePrice,'
      #9'NewSuggRetail,'
      #9'Qty,'
      #9'FreightCost,'
      #9'OtherCost,'
      #9'CaseQty,'
      #9'CaseCost,'
      #9'IsPromo) '
      'VALUES '
      #9'(:IDPurchaseItem,'
      #9':IDPurchase,'
      #9':IDGroup,'
      #9':IDFornecedor,'
      #9':IDModel,'
      #9':IDPOItem,'
      #9':BarCode,'
      #9':CostPrice,'
      #9':NewCostPrice,'
      #9':NewSalePrice,'
      #9':NewSuggRetail, '
      #9':Qty,'
      #9':FreightCost,'
      #9':OtherCost,'
      #9':CaseQty,'
      #9':CaseCost,'
      #9':IsPromo)')
    Left = 32
    Top = 88
  end
  object qryInsModel: TADOQuery
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Model'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Description'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'GroupID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'VendorCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SuggRetail'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'ModelType'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'Verify'
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CaseQty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'DateLastSellingPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO Model'
      #9'(IDModel,'
      #9'Model,'
      #9'Description,'
      #9'GroupID,'
      #9'VendorCost,'
      #9'SuggRetail,'
      #9'ModelType,'
      #9'Verify,'
      #9'IDModelGroup,'
      #9'IDModelSubGroup,'
      #9'CaseQty,'
      #9'DateLastSellingPrice) '
      'VALUES '
      #9'(:IDModel,'
      #9':Model,'
      #9':Description,'
      #9':GroupID,'
      #9':VendorCost,'
      #9':SuggRetail,'
      #9':ModelType,'
      #9':Verify,'
      #9':IDModelGroup,'
      #9':IDModelSubGroup,'
      #9':CaseQty,'
      #9':DateLastSellingPrice)')
    Left = 124
    Top = 148
  end
end
