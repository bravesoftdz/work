inherited FrmPurchaseItemQuickEntry: TFrmPurchaseItemQuickEntry
  Left = 416
  Top = 271
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmPurchaseItemQuickEntry'
  ClientHeight = 323
  ClientWidth = 502
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblVendor: TLabel [0]
    Left = 28
    Top = 60
    Width = 41
    Height = 13
    Caption = 'Vendor :'
  end
  object lblSearchType: TLabel [1]
    Left = 6
    Top = 88
    Width = 63
    Height = 13
    Caption = 'Search with :'
  end
  object lblQty: TLabel [2]
    Left = 180
    Top = 116
    Width = 25
    Height = 13
    Caption = 'Qty :'
  end
  object lblQtyType: TLabel [3]
    Left = 39
    Top = 115
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Type :'
    Visible = False
  end
  inherited Panel2: TPanel
    Width = 502
    inherited Image1: TImage
      Width = 275
    end
    inherited lblMenu: TLabel
      Left = 286
    end
    inherited EspacamentoSuperior: TPanel
      Width = 502
      inherited EEE: TPanel
        Width = 502
      end
    end
  end
  inherited Panel1: TPanel
    Top = 282
    Width = 502
    inherited EspacamentoInferior: TPanel
      Width = 502
      inherited Panel3: TPanel
        Width = 502
      end
    end
    inherited hhh: TPanel
      Left = 420
      inherited btClose: TButton
        Cancel = True
        ModalResult = 2
      end
    end
    object btAdd: TButton
      Left = 360
      Top = 9
      Width = 66
      Height = 31
      Caption = '&Add'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btAddClick
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 242
  end
  inherited EspacamentoDireito: TPanel
    Left = 499
    Height = 242
  end
  object Panel4: TPanel [8]
    Left = 379
    Top = 40
    Width = 3
    Height = 242
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
  end
  object gbxModelProperties: TGroupBox [9]
    Left = 76
    Top = 140
    Width = 297
    Height = 135
    TabOrder = 5
    object lblModel: TLabel
      Left = 53
      Top = 32
      Width = 35
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Model :'
      ParentBiDiMode = False
    end
    object lblDescription: TLabel
      Left = 28
      Top = 52
      Width = 60
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Description :'
      ParentBiDiMode = False
    end
    object lblCost: TLabel
      Left = 62
      Top = 72
      Width = 26
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Cost:'
      ParentBiDiMode = False
    end
    object lblManufacturer: TLabel
      Left = 16
      Top = 12
      Width = 72
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Manufacturer :'
      ParentBiDiMode = False
    end
    object lblOurPrice: TLabel
      Left = 40
      Top = 92
      Width = 48
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Our price:'
      ParentBiDiMode = False
    end
    object DBText: TDBText
      Left = 96
      Top = 12
      Width = 35
      Height = 13
      AutoSize = True
      DataField = 'Manufacturer'
      DataSource = dtsModel
    end
    object DBText1: TDBText
      Left = 96
      Top = 32
      Width = 48
      Height = 13
      AutoSize = True
      DataField = 'Model'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 96
      Top = 52
      Width = 48
      Height = 13
      AutoSize = True
      DataField = 'Description'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 96
      Top = 72
      Width = 41
      Height = 13
      AutoSize = True
      DataField = 'FinalCost'
      DataSource = dtsModel
    end
    object DBText4: TDBText
      Left = 96
      Top = 92
      Width = 41
      Height = 13
      AutoSize = True
      DataField = 'SellingPrice'
      DataSource = dtsModel
    end
    object lblCaseQty: TLabel
      Left = 38
      Top = 112
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Case qty :'
    end
    object DBText5: TDBText
      Left = 96
      Top = 112
      Width = 41
      Height = 13
      AutoSize = True
      DataField = 'CaseQty'
      DataSource = dtsModel
    end
  end
  object cbxSearchType: TComboBox [10]
    Left = 76
    Top = 84
    Width = 130
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = 'Barcode'
    OnChange = cbxSearchTypeChange
    Items.Strings = (
      'Barcode'
      'Model'
      'Vendor #')
  end
  object edtSearchNumber: TEdit [11]
    Left = 212
    Top = 84
    Width = 161
    Height = 21
    TabOrder = 8
    OnExit = edtSearchNumberExit
    OnKeyDown = edtSearchNumberKeyDown
  end
  object pnlButtons: TPanel [12]
    Left = 382
    Top = 40
    Width = 117
    Height = 242
    Align = alRight
    TabOrder = 11
    object btNewItem: TSpeedButton
      Tag = 3
      Left = 3
      Top = 2
      Width = 111
      Height = 25
      AllowAllUp = True
      Caption = '&New Item'
      Flat = True
      Margin = 7
      Spacing = 8
      OnClick = btNewItemClick
    end
    object btSearch: TSpeedButton
      Tag = 4
      Left = 3
      Top = 27
      Width = 111
      Height = 25
      AllowAllUp = True
      Caption = '&Search'
      Flat = True
      Margin = 6
      Spacing = 7
      OnClick = btSearchClick
    end
  end
  object edtVendor: TEdit [13]
    Left = 76
    Top = 56
    Width = 297
    Height = 21
    TabStop = False
    ParentColor = True
    ReadOnly = True
    TabOrder = 6
  end
  object edtQty: TEdit [14]
    Left = 212
    Top = 112
    Width = 53
    Height = 21
    TabOrder = 10
    OnKeyDown = edtQtyKeyDown
    OnKeyPress = edtQtyKeyPress
  end
  object cbxQtyType: TComboBox [15]
    Left = 75
    Top = 111
    Width = 90
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 1
    TabOrder = 9
    Text = 'Unit'
    Visible = False
    OnKeyDown = cbxQtyTypeKeyDown
    Items.Strings = (
      'Case'
      'Unit')
  end
  object edtBarcode: TmrBarCodeEdit [16]
    Left = 213
    Top = 84
    Width = 160
    Height = 21
    Color = 8454143
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnExit = edtSearchNumberExit
    Connection = DM.ADODBConnect
    SQL.Strings = (
      'SELECT'
      '      B.IDModel'
      'FROM'
      '      Barcode B'
      'WHERE'
      '      B.IDBarcode = :IDBarcode')
    SecondSQL.Strings = (
      'SELECT'
      '      M.IDModel'
      'FROM'
      '      Model M'
      'WHERE'
      '      M.Model = :Model')
    KeyField = 'IDBarcode'
    SecondKeyField = 'Model'
    DisplayQty = False
    RunSecondSQL = False
    CheckBarcodeDigit = 0
    MinimalDigits = 0
    AfterSearchBarcode = edtBarcodeAfterSearchBarcode
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPurchaseItemQuickEntry.sil'
  end
  object qryModel: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.Desativado,'#13 +
      #10#9'M.GroupID,'#13#10#9'M.SellingPrice,'#13#10#9'M.FinalCost,'#13#10#9'M.SuggRetail,'#13#10#9 +
      '(CASE WHEN ISNULL(IMV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ' +
      'ELSE IMV.CaseQty END) CaseQty,'#13#10#9'F.Pessoa as Manufacturer'#13#10'FROM'#13 +
      #10#9'Model M (NOLOCK) '#13#10#9'LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.ID' +
      'Fabricante = F.IDPessoa)'#13#10#9'LEFT OUTER JOIN Barcode B (NOLOCK) ON' +
      ' (M.IDModel = B.IDModel)'#13#10#9'LEFT OUTER JOIN VendorModelCode VMC (' +
      'NOLOCK) ON (M.IDModel = VMC.IDModel AND VMC.IDPessoa = :IDVendor' +
      ')'#13#10#9'LEFT OUTER JOIN Inv_ModelVendor IMV (NOLOCK) ON (M.IDModel =' +
      ' IMV.IDModel AND IMV.IDPessoa = :IDVendorIMV)'
    Parameters = <
      item
        Name = 'IDVendor'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDVendorIMV'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 429
    Top = 96
    object qryModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object qryModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object qryModelGroupID: TIntegerField
      FieldName = 'GroupID'
    end
    object qryModelSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryModelFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryModelSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryModelCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object qryModelManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object qryModelDesativado: TIntegerField
      FieldName = 'Desativado'
    end
  end
  object dtsModel: TDataSource
    DataSet = qryModel
    Left = 429
    Top = 140
  end
  object cmdInsPurchaseItem: TADOCommand
    CommandText = 
      'INSERT INTO Pur_PurchaseItem (IDPurchase, IDPurchaseItem, IDForn' +
      'ecedor, IDModel, IDGroup, Qty, NewCostPrice, NewSalePrice, NewSu' +
      'ggRetail, CostPrice, CaseQty, CaseCost)'#13#10'VALUES (:IDPurchase, :I' +
      'DPurchaseItem, :IDFornecedor, :IDModel, :IDGroup, :Qty, :NewCost' +
      'Price, :NewSalePrice, :NewSuggRetail, :CostPrice, :CaseQty, :Cas' +
      'eCost)'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPurchaseItem'
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
        Name = 'IDModel'
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
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
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
        Name = 'CostPrice'
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
      end>
    Left = 428
    Top = 188
  end
end
