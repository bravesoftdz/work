inherited FrmMarginTableApply: TFrmMarginTableApply
  Left = 259
  Top = 186
  Caption = 'Margin Table Apply'
  ClientHeight = 227
  ClientWidth = 349
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText [0]
    Left = 4
    Top = 8
    Width = 337
    Height = 17
    DataField = 'Name'
    DataSource = dsApplyMargin
  end
  inherited Panel1: TPanel
    Top = 188
    Width = 349
    inherited Bevel1: TBevel
      Width = 349
    end
    inherited Panel2: TPanel
      Left = 199
      inherited Cancelar: TButton
        ModalResult = 2
        OnClick = CancelarClick
      end
      inherited Aplicar: TButton
        ModalResult = 1
        OnClick = AplicarClick
      end
    end
  end
  object Panel13: TPanel [2]
    Left = 176
    Top = 35
    Width = 171
    Height = 152
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 1
    object lbQuestion2: TLabel
      Left = 5
      Top = 25
      Width = 78
      Height = 13
      Caption = 'Calculate margin'
    end
    object pnMSRP: TPanel
      Left = 0
      Top = 0
      Width = 171
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Caption = 'MSRP Margin'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object scMSRPMargemType: TDBSuperComboADO
      Left = 5
      Top = 67
      Width = 113
      Height = 21
      TabOrder = 1
      Text = 'scMSRPMargemType'
      LookUpSource = DM.dsLookUpMargemType
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDMSRPMargemTable'
      DataSource = dsApplyMargin
    end
    object dbMSRPPercent: TDBEdit
      Left = 4
      Top = 67
      Width = 67
      Height = 21
      DataField = 'MSRPMargemPercent'
      DataSource = dsApplyMargin
      TabOrder = 2
      OnExit = dbMSRPPercentExit
    end
    object cbMSRP: TComboBox
      Left = 4
      Top = 42
      Width = 141
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbMSRPChange
      Items.Strings = (
        'With flat margin'
        'With margin table')
    end
  end
  object Panel9: TPanel [3]
    Left = 1
    Top = 35
    Width = 171
    Height = 152
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 2
    object lbQuestion: TLabel
      Left = 5
      Top = 25
      Width = 78
      Height = 13
      Caption = 'Calculate margin'
    end
    object pnSalePrice: TPanel
      Left = 0
      Top = 0
      Width = 171
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Sale Price Margin'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object scSalePriceMargemType: TDBSuperComboADO
      Left = 6
      Top = 70
      Width = 113
      Height = 21
      TabOrder = 1
      Text = 'scSalePriceMargemType'
      LookUpSource = DM.dsLookUpMargemType
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDSalePriceMargemTable'
      DataSource = dsApplyMargin
    end
    object dbSalePricePercent: TDBEdit
      Left = 6
      Top = 70
      Width = 67
      Height = 21
      DataField = 'SalePriceMargemPercent'
      DataSource = dsApplyMargin
      TabOrder = 2
      OnExit = dbSalePricePercentExit
    end
    object cbSalePrice: TComboBox
      Left = 6
      Top = 44
      Width = 138
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbSalePriceChange
      Items.Strings = (
        'With flat margin'
        'With margin table')
    end
  end
  object dsApplyMargin: TDataSource [4]
    DataSet = quApplyMargin
    Left = 160
    Top = 124
  end
  object quApplyMargin: TADODataSet [5]
    Connection = DM.ADODBConnect
    AfterOpen = quApplyMarginAfterOpen
    BeforePost = quApplyMarginBeforePost
    AfterPost = quApplyMarginAfterPost
    CommandText = 
      'SELECT '#13#10#9'TG.IDGroup as ID,'#13#10#9'TG.Name,'#13#10#9'TG.IDSalePriceMargemTab' +
      'le,'#13#10#9'TG.SalePriceMargemPercent,'#13#10#9'TG.UseSalePricePercent,'#13#10#9'TG.' +
      'IDMSRPMargemTable,'#13#10#9'TG.MSRPMargemPercent,'#13#10#9'TG.UseMSRPPercent'#13#10 +
      'FROM'#13#10#9'TabGroup TG'
    Parameters = <>
    Left = 161
    Top = 79
    object quApplyMarginID: TIntegerField
      FieldName = 'ID'
    end
    object quApplyMarginName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quApplyMarginIDSalePriceMargemTable: TIntegerField
      FieldName = 'IDSalePriceMargemTable'
    end
    object quApplyMarginSalePriceMargemPercent: TFloatField
      FieldName = 'SalePriceMargemPercent'
      DisplayFormat = '#,##0.00'
    end
    object quApplyMarginUseSalePricePercent: TBooleanField
      FieldName = 'UseSalePricePercent'
    end
    object quApplyMarginIDMSRPMargemTable: TIntegerField
      FieldName = 'IDMSRPMargemTable'
    end
    object quApplyMarginMSRPMargemPercent: TFloatField
      FieldName = 'MSRPMargemPercent'
      DisplayFormat = '#,##0.00'
    end
    object quApplyMarginUseMSRPPercent: TBooleanField
      FieldName = 'UseMSRPPercent'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmMarginTableApply.sil'
  end
end
