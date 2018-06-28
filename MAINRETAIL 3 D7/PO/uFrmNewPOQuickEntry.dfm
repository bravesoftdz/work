inherited FrmNewPOQuickEntry: TFrmNewPOQuickEntry
  Left = 476
  Top = 377
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmNewPOQuickEntry'
  ClientHeight = 336
  ClientWidth = 540
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
    Width = 540
    TabOrder = 6
    DesignSize = (
      540
      40)
    inherited Image1: TImage
      Width = 313
    end
    inherited lblMenu: TLabel
      Left = 324
    end
    inherited EspacamentoSuperior: TPanel
      Width = 540
      inherited EEE: TPanel
        Width = 540
      end
    end
  end
  inherited Panel1: TPanel
    Top = 295
    Width = 540
    TabOrder = 5
    inherited EspacamentoInferior: TPanel
      Width = 540
      inherited Panel3: TPanel
        Width = 540
      end
    end
    inherited hhh: TPanel
      Left = 458
      inherited btClose: TButton
        Cancel = True
        Caption = '&Cancel'
        ModalResult = 2
      end
    end
    object btAdd: TButton
      Left = 400
      Top = 9
      Width = 66
      Height = 31
      Anchors = [akRight, akBottom]
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
    Height = 255
    TabOrder = 7
  end
  inherited EspacamentoDireito: TPanel
    Left = 420
    Height = 255
    TabOrder = 8
  end
  object gbxModelProperties: TGroupBox [8]
    Left = 4
    Top = 140
    Width = 409
    Height = 153
    TabOrder = 9
    object lblModel: TLabel
      Left = 53
      Top = 32
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
    end
    object lblDescription: TLabel
      Left = 28
      Top = 52
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object lblCost: TLabel
      Left = 59
      Top = 72
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cost :'
    end
    object lblManufacturer: TLabel
      Left = 16
      Top = 12
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Manufacturer :'
    end
    object lblOurPrice: TLabel
      Left = 37
      Top = 92
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Our price :'
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
    object lblVendorCode: TLabel
      Left = 13
      Top = 132
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vendor item # :'
    end
    object DBText6: TDBText
      Left = 96
      Top = 132
      Width = 41
      Height = 13
      AutoSize = True
      DataField = 'VendorCode'
      DataSource = dtsModel
    end
  end
  object cbxSearchType: TComboBox [9]
    Left = 76
    Top = 84
    Width = 130
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Barcode'
    OnChange = cbxSearchTypeChange
    Items.Strings = (
      'Barcode'
      'Model'
      'Vendor #')
  end
  object edtSearchNumber: TEdit [10]
    Left = 212
    Top = 84
    Width = 201
    Height = 21
    TabOrder = 2
    OnExit = edtSearchNumberExit
    OnKeyDown = edtSearchNumberKeyDown
  end
  object pnlButtons: TPanel [11]
    Left = 423
    Top = 40
    Width = 117
    Height = 255
    Align = alRight
    TabOrder = 10
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
  object edtVendor: TEdit [12]
    Left = 76
    Top = 56
    Width = 337
    Height = 21
    TabStop = False
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object edtQty: TEdit [13]
    Left = 212
    Top = 112
    Width = 53
    Height = 21
    TabOrder = 4
    OnKeyDown = edtQtyKeyDown
    OnKeyPress = edtQtyKeyPress
  end
  object cbxQtyType: TComboBox [14]
    Left = 75
    Top = 111
    Width = 90
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 1
    TabOrder = 3
    Text = 'Unit'
    Visible = False
    OnKeyDown = cbxQtyTypeKeyDown
    Items.Strings = (
      'Case'
      'Unit')
  end
  object edtBarcode: TmrBarCodeEdit [15]
    Left = 212
    Top = 84
    Width = 201
    Height = 21
    Color = 8454143
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
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
    StorageFile = 'MR_FrmNewPOQuickEntry.sil'
    Left = 16
    Top = 8
  end
  object qryModel: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.Desativado,'#13 +
      #10#9'M.SellingPrice,'#13#10#9'M.FinalCost,'#13#10#9'M.SuggRetail,'#13#10#9'(CASE WHEN IS' +
      'NULL(IMV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE IMV.Case' +
      'Qty END) CaseQty,'#13#10#9'F.Pessoa as Manufacturer,'#13#10#9'VMC.VendorCode,'#13 +
      #10#9'IsNull(IMV.MinQtyPO, 0) MinQtyPO'#13#10'FROM'#13#10#9'Model M (NOLOCK) '#13#10#9'L' +
      'EFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa' +
      ')'#13#10#9'LEFT OUTER JOIN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel' +
      ')'#13#10#9'LEFT OUTER JOIN VendorModelCode VMC (NOLOCK) ON (M.IDModel =' +
      ' VMC.IDModel AND VMC.IDPessoa = :IDVendorVMC)'#13#10#9'LEFT OUTER JOIN ' +
      'Inv_ModelVendor IMV (NOLOCK) ON (M.IDModel = IMV.IDModel AND IMV' +
      '.IDPessoa = :IDVendorIMV)'
    Parameters = <
      item
        Name = 'IDVendorVMC'
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
    Left = 465
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
    object qryModelMinQtyPO: TFloatField
      FieldName = 'MinQtyPO'
    end
    object qryModelVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 35
    end
    object qryModelDesativado: TIntegerField
      FieldName = 'Desativado'
    end
  end
  object dtsModel: TDataSource
    DataSet = qryModel
    Left = 465
    Top = 140
  end
  object cmdInsPOItem: TADOCommand
    CommandText = 
      'INSERT INTO PreInventoryMov (IDPreInventoryMov, InventMovTypeID,' +
      ' StoreID, ModelID, IDPessoa, UserID, DocumentID, MovDate, Qty, C' +
      'ostPrice, SalePrice, SuggRetail, CaseQty, CaseCost, DateEstimate' +
      'dMov)'#13#10'VALUES (:IDPreInventoryMov, :InventMovTypeID, :StoreID, :' +
      'ModelID, :IDPessoa, :UserID, :DocumentID, :MovDate, :Qty, :CostP' +
      'rice, :SalePrice, :SuggRetail, :CaseQty, :CaseCost, :DateEstimat' +
      'edMov)'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'InventMovTypeID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'StoreID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ModelID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'UserID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DocumentID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
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
        Name = 'CostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SalePrice'
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
        Name = 'DateEstimatedMov'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 464
    Top = 188
  end
  object spPoItemDO: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PO_Item_Do;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreInventoryMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 467
    Top = 239
  end
end
