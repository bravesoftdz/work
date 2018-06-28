inherited SubInvAccessory: TSubInvAccessory
  Left = 220
  Top = 207
  BorderStyle = bsSingle
  Caption = 'SubInvAccessory'
  ClientHeight = 104
  ClientWidth = 475
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel [0]
    Left = 0
    Top = 0
    Width = 475
    Height = 16
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Suggestion'
    Color = clBtnShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object gridSuggestion: TDBCtrlGrid [1]
    Left = 0
    Top = 16
    Width = 475
    Height = 88
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    DataSource = dsAccessory
    PanelHeight = 29
    PanelWidth = 459
    TabOrder = 0
    object DBText1: TDBText
      Left = 5
      Top = 3
      Width = 451
      Height = 13
      DataField = 'Model'
      DataSource = dsAccessory
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 5
      Top = 15
      Width = 451
      Height = 13
      DataField = 'Hint'
      DataSource = dsAccessory
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object quAccessory: TADOQuery [2]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quAccessoryAfterOpen
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IA.IDInvAccessory,'
      #9'IA.IDModel,'
      #9'(M.Model + '#39' - '#39'+ M.Description) as Model,'
      #9'IA.Description as Hint,'
      #9'M.LargeImage,'
      #9'M.SellingPrice,'
      #9'TotQtyOnHand'
      'FROM'
      #9'InvAccessory IA (NOLOCK)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel=IA.IDInvAccessory)'
      'WHERE'
      #9'IA.IDModel = :IDModel'
      #9'AND'
      #9'M.TotQtyOnHand > 0')
    Left = 227
    Top = 13
    object quAccessoryIDInvAccessory: TIntegerField
      FieldName = 'IDInvAccessory'
    end
    object quAccessoryIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quAccessoryModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 83
    end
    object quAccessoryHint: TStringField
      FieldName = 'Hint'
      Size = 255
    end
    object quAccessoryLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
    object quAccessorySellingPrice: TBCDField
      DisplayLabel = 'Price'
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quAccessoryf: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'f'
      Calculated = True
    end
    object quAccessoryTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      DisplayFormat = '0.#####'
    end
  end
  object dsAccessory: TDataSource [3]
    DataSet = quAccessory
    Left = 145
    Top = 11
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubInvAccessory.sil'
  end
end
