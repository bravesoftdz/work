inherited FchCost: TFchCost
  Left = 219
  Top = 160
  Caption = 'FchCost'
  ClientHeight = 272
  ClientWidth = 472
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 472
    inherited Image1: TImage
      Width = 198
    end
    inherited lblMenu: TLabel
      Left = 494
    end
    inherited EspacamentoSuperior: TPanel
      Width = 472
      inherited EEE: TPanel
        Width = 472
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 425
    end
  end
  inherited Panel1: TPanel
    Top = 231
    Width = 472
    inherited EspacamentoInferior: TPanel
      Width = 472
      inherited Panel3: TPanel
        Width = 472
      end
    end
    inherited hhh: TPanel
      Left = 243
      Width = 229
      inherited btCancel: TButton
        Left = 152
        Width = 74
      end
      inherited btClose: TButton
        Left = 74
        Width = 74
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 472
    Height = 6
    inherited Panel4: TPanel
      Top = 0
      Width = 472
      Height = 6
      Align = alClient
    end
  end
  inherited pnlDetail: TPanel
    Top = 46
    Width = 466
    Height = 185
    object Label5: TLabel
      Left = 85
      Top = 52
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Date :'
    end
    object Label1: TLabel
      Left = 214
      Top = 83
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 64
      Top = 87
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Unit Cost :'
    end
    object Label4: TLabel
      Left = 66
      Top = 121
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Quantity :'
    end
    object Label3: TLabel
      Left = 59
      Top = 156
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total Cost :'
    end
    object Label6: TLabel
      Left = 59
      Top = 17
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cost Type :'
    end
    object Label21: TLabel
      Left = 214
      Top = 48
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 370
      Top = 12
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object scCostType: TDBSuperComboADO
      Left = 122
      Top = 13
      Width = 246
      Height = 21
      TabOrder = 0
      Text = 'scCostType'
      LookUpSource = DM.dsLookUpCostType
      DropDownRows = 18
      IDLanguage = 0
      OnSelectItem = scCostTypeSelectItem
      DataField = 'IDCostType'
      DataSource = dsForm
    end
    object editData: TDBDateBox
      Left = 122
      Top = 48
      Width = 91
      Height = 21
      ReadOnly = False
      TabOrder = 1
      Text = 'editData'
      Language = Portuguese
      DataField = 'CostDate'
      DataSource = dsForm
    end
    object editCustoUnitario: TDBEdit
      Left = 122
      Top = 83
      Width = 91
      Height = 21
      DataField = 'UnitCost'
      DataSource = dsForm
      TabOrder = 2
    end
    object editQTY: TDBEdit
      Left = 122
      Top = 117
      Width = 91
      Height = 21
      DataField = 'Quantity'
      DataSource = dsForm
      TabOrder = 3
    end
    object editCustoTotal: TDBEdit
      Left = 122
      Top = 152
      Width = 91
      Height = 21
      DataField = 'CustoTotal'
      DataSource = dsForm
      TabOrder = 4
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 46
    Height = 185
  end
  inherited EspacamentoDireito: TPanel
    Left = 469
    Top = 46
    Height = 185
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchCost.sil'
  end
  inherited dsForm: TDataSource
    Left = 240
    Top = 92
  end
  inherited quForm: TPowerADOQuery
    OnCalcFields = quFormCalcFields
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10'        IDCost,'#13#10'        IDTouristGroup,'#13#10'        IDCost' +
      'Type,'#13#10'        CostDate,'#13#10'        Quantity,'#13#10'        UnitCost'#13#10'F' +
      'ROM'#13#10'        GroupCost GroupCost'#13#10'WHERE'#13#10'        IDCost = :IDCos' +
      't'#13#10
    Parameters = <
      item
        Name = 'IDCost'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 240
    Top = 148
    object quFormIDCost: TIntegerField
      FieldName = 'IDCost'
      Origin = 'GroupCost.IDCost'
    end
    object quFormIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
      Origin = 'GroupCost.IDTouristGroup'
    end
    object quFormIDCostType: TIntegerField
      DisplayLabel = 'Cost Type'
      FieldName = 'IDCostType'
      Origin = 'GroupCost.IDCostType'
      Required = True
    end
    object quFormCostDate: TDateTimeField
      DisplayLabel = 'Cost Date'
      FieldName = 'CostDate'
      Origin = 'GroupCost.CostDate'
      Required = True
      DisplayFormat = 'ddddd'
    end
    object quFormUnitCost: TFloatField
      DisplayLabel = 'Unit Cost'
      FieldName = 'UnitCost'
      Origin = 'GroupCost.UnitCost'
      Required = True
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quFormCustoTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CustoTotal'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quFormQuantity: TFloatField
      FieldName = 'Quantity'
      DisplayFormat = '0.#####'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    AutoIncField = 'IDCost'
    Left = 296
    Top = 93
  end
end
