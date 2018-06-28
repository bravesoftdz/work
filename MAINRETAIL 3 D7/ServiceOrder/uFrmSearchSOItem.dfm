inherited FrmSearchSOItem: TFrmSearchSOItem
  Left = 156
  Caption = 'Search tem'
  ClientHeight = 425
  ClientWidth = 535
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel [0]
    Left = 34
    Top = 81
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Model :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnPicture: TSpeedButton [1]
    Left = 507
    Top = 76
    Width = 25
    Height = 22
    OnClick = btnPictureClick
  end
  object lbQty: TLabel [2]
    Left = 25
    Top = 107
    Width = 45
    Height = 13
    Alignment = taRightJustify
    Caption = 'Quantity :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [3]
    Left = 16
    Top = 134
    Width = 54
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sale Price :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbTotal: TLabel [4]
    Left = 40
    Top = 162
    Width = 30
    Height = 13
    Alignment = taRightJustify
    Caption = 'Total :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbCategory: TLabel [5]
    Left = 21
    Top = 56
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Category :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbSearch: TLabel [6]
    Left = 29
    Top = 8
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Search :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbComissionado: TLabel [7]
    Left = 41
    Top = 31
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  inherited Panel1: TPanel
    Top = 386
    Width = 535
    TabOrder = 8
    inherited Bevel1: TBevel
      Width = 535
    end
    inherited Panel2: TPanel
      Left = 385
      inherited Cancelar: TButton
        OnClick = CancelarClick
      end
      inherited Aplicar: TButton
        OnClick = AplicarClick
      end
    end
  end
  object cmbModel: TSuperComboADO [9]
    Left = 75
    Top = 77
    Width = 405
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    CodeLength = 250
    LookUpSource = DM.dsLookUpModelService
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    ShowEditCode = True
    EditCodePos = taEditCodeRight
    IDLanguage = 0
    OnSelectItem = cmbModelSelectItem
  end
  object EditQty: TEdit [10]
    Left = 76
    Top = 101
    Width = 136
    Height = 24
    Hint = 'In case of refund, type negative quantity'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnChange = EditQtyChange
    OnKeyPress = EditQtyKeyPress
  end
  object EditSalePrice: TSuperEditCurrency [11]
    Left = 76
    Top = 128
    Width = 136
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Text = '0.00'
    OnClick = EditSalePriceClick
    OnEnter = EditSalePriceEnter
    OnKeyPress = EditSalePriceKeyPress
    Alignment = taRightJustify
    OnCurrChange = EditSalePriceCurrChange
    DisplayFormat = '0.00'
  end
  object EditTotal: TSuperEdit [12]
    Left = 76
    Top = 155
    Width = 136
    Height = 24
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Alignment = taRightJustify
  end
  object SubQty: TSubListPanel [13]
    Left = 0
    Top = 193
    Width = 535
    Height = 193
    Align = alBottom
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 7
    SubListClassName = 'TSubStoreQty'
  end
  object scCategoria: TSuperComboADO [14]
    Left = 75
    Top = 52
    Width = 405
    Height = 21
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    CodeLength = 250
    LookUpSource = DM.dsLookUpGroup
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    EditCodePos = taEditCodeRight
    IDLanguage = 0
    OnSelectItem = scCategoriaSelectItem
  end
  object rbServices: TRadioButton [15]
    Left = 75
    Top = 7
    Width = 113
    Height = 17
    Caption = 'Services'
    Checked = True
    TabOrder = 9
    TabStop = True
    OnClick = rbServicesClick
  end
  object rbProducts: TRadioButton [16]
    Left = 195
    Top = 7
    Width = 113
    Height = 17
    Caption = 'Products'
    TabOrder = 10
    OnClick = rbProductsClick
  end
  object btnSearchDesc: TBitBtn [17]
    Left = 482
    Top = 76
    Width = 23
    Height = 22
    TabOrder = 3
    OnClick = btnSearchDescClick
  end
  object scMRUser: TSuperComboADO [18]
    Left = 75
    Top = 27
    Width = 405
    Height = 21
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    CodeLength = 250
    LookUpSource = DM.dsLookUpUser
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    EditCodePos = taEditCodeRight
    IDLanguage = 0
  end
  object spSalePrice: TADOStoredProc [19]
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_CalcSalePrice;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ModelID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDStore'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCustomer'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SpecialPriceID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@CostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@Discount'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AvgCostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@ReplacementCost'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@StoreSalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@RequestCustomer'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@PuppyTracker'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@StoreCostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@StoreAvgCost'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AddKitItems'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@PromotionPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 185
    Top = 224
  end
  object cdmAddItem: TADOCommand [20]
    CommandText = 
      'INSERT Ser_SOItemProduct (IDSOItemProduct, IDUser, IDSOItem, IDM' +
      'odel, IDStore, Qty, CostPrice, SalePrice, MovDate, IDCustomer)'#13#10 +
      'VALUES (:IDSOItemProduct, :IDUser, :IDSOItem, :IDModel, :IDStore' +
      ', :Qty, :CostPrice, :SalePrice, :MovDate, :IDCustomer)'
    CommandTimeout = 18000
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDSOItemProduct'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDSOItem'
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
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 38
        Size = 19
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
        Name = 'MovDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCustomer'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 188
    Top = 172
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSearchSOItem.sil'
  end
  object cmdAddInvMov: TADOCommand
    CommandText = 
      'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID' +
      ', StoreID, ModelID, MovDate, Qty, CostPrice, SalePrice, Discount' +
      ', IDUser, IDDepartment, IDPessoa)'#13#10'VALUES (:IDInventoryMov, :Inv' +
      'entMovTypeID, :DocumentID, :StoreID, :ModelID, :MovDate, :Qty, :' +
      'CostPrice, :SalePrice, :Discount, :IDUser, :IDDepartment, :IDPes' +
      'soa)'#13#10
    CommandTimeout = 18000
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'InventMovTypeID'
        Attributes = [paSigned]
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
        Name = 'StoreID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ModelID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 38
        Size = 19
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
        Name = 'Discount'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDDepartment'
        Attributes = [paSigned]
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
      end>
    Left = 280
    Top = 172
  end
end
