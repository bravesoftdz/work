inherited SubModelWarranty: TSubModelWarranty
  Left = 161
  Top = 184
  Width = 579
  Height = 49
  Caption = 'SubModelWarranty'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 20
    Top = 5
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Warranty :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cbxWarranty: TComboBox [1]
    Left = 82
    Top = 0
    Width = 486
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbxWarrantyChange
  end
  object quModelWarranty: TADODataSet [2]
    Connection = DM.ADODBConnect
    AfterOpen = quModelWarrantyAfterOpen
    OnCalcFields = quModelWarrantyCalcFields
    CommandText = 
      'SELECT'#13#10#9'MS.IDModel,'#13#10#9'MS.Model,'#13#10#9'MS.Description,'#13#10#9'MS.SellingP' +
      'rice,'#13#10#9'MS.ReplacementCost,'#13#10#9'(IsNull(MS.VendorCost,0) + IsNull(' +
      'MS.OtherCost,0) + IsNull(MS.FreightCost, 0)) as CostPrice,'#13#10#9'I.S' +
      'ellingPrice as StoreSellingPrice'#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10#9'JOIN' +
      ' TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID AND TG.Service ' +
      '= 0)'#13#10#9'JOIN ServiceRange SR (NOLOCK) ON (TG.IDGroup = SR.IDGroup' +
      ')'#13#10#9'JOIN Model MS (NOLOCK) ON (MS.IDModel = SR.IDModel) '#13#10#9'LEFT ' +
      'OUTER JOIN Inventory I (NOLOCK) ON (I.ModelID = MS.IDModel AND I' +
      '.StoreID = :IDStore)'#13#10'WHERE'#13#10#9'M.IDModel = :IDModel'#13#10#9'AND'#13#10#9'('#13#10#9':' +
      'Amount Between SR.BeginAmount AND SR.EndAmount'#13#10#9'OR'#13#10#9'SR.UseRang' +
      'e = 0'#13#10#9')'
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Amount'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    Left = 290
    object quModelWarrantyIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelWarrantyModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelWarrantyDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelWarrantySellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelWarrantyCostPrice: TBCDField
      FieldName = 'CostPrice'
      ReadOnly = True
      Precision = 19
    end
    object quModelWarrantyModelDescr: TStringField
      FieldKind = fkCalculated
      FieldName = 'ModelDescr'
      Size = 255
      Calculated = True
    end
    object quModelWarrantyReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quModelWarrantyStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      Precision = 19
    end
  end
  object dsModelWarranty: TDataSource [3]
    DataSet = quModelWarranty
    Left = 390
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubModelWarranty.sil'
  end
end
