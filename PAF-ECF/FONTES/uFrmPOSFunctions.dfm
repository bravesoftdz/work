object FrmPOSFunctions: TFrmPOSFunctions
  Left = 54
  Top = 64
  Width = 791
  Height = 586
  Caption = 'FrmPOSFunctions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 65
    Top = 4
    Width = 115
    Height = 20
    Caption = 'Cash Register'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 375
    Top = 4
    Width = 58
    Height = 20
    Caption = 'Invoice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = 5
    Top = 33
    Width = 241
    Height = 446
    Brush.Color = clBlue
    Shape = stRoundRect
  end
  object Shape2: TShape
    Left = 255
    Top = 25
    Width = 458
    Height = 528
    Brush.Color = clLime
    Shape = stRoundRect
  end
  object spCashRegOpen: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_Open;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegister'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill100'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill50'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill20'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill10'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill5'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill2'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin050'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin025'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin010'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin005'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin001'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OpenMoney'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCard'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCardPre'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCheck'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalOther'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalDebit'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@FinalCount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 48
    Top = 40
  end
  object spCashRegClose: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_Close;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUsuario'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill100'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill50'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill20'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill10'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill5'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill2'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin050'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin025'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin010'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin005'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin001'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCard'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCardPre'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCheck'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalOther'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalDebit'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@FinalCount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@LogDocument'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 47
    Top = 95
  end
  object quCashRegResidual: TADOQuery
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        CRM.IDCashRegMov,'
      '        CRM.IDOpenUser,'
      
        '        (CRM.OpenDeposit+CRM.TotalSales+CRM.TotalDeposit-CRM.Tot' +
        'alWidraw-CRM.TotalPetty)  as Residual'
      'FROM'
      '        CashRegMov CRM'
      'WHERE'
      '        CRM.IDCashRegMov = :IDCashRegMov'
      ' ')
    Left = 165
    Top = 39
    object quCashRegResidualIDCashRegMov: TIntegerField
      FieldName = 'IDCashRegMov'
      Origin = 'CashRegMov.IDCashRegMov'
    end
    object quCashRegResidualIDOpenUser: TIntegerField
      FieldName = 'IDOpenUser'
      Origin = 'CashRegMov.IDOpenUser'
    end
    object quCashRegResidualResidual: TFloatField
      FieldName = 'Residual'
      Origin = 'CashRegMov.OpenDeposit'
    end
  end
  object quCashRegInfo: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        CRM.IDCashRegMov,'
      '        SU.SystemUser,'
      '        CR.Name as CashRegister,'
      '        CRM.OpenTime,'
      '        CRM.IDCashRegStatus'
      'FROM'
      '        CashRegMov CRM'
      
        '        JOIN CashRegister CR ON ( CRM.IDCashRegister = CR.IDCash' +
        'Register )'
      '        JOIN SystemUser SU ON ( CRM.IDOpenUser = SU.IDUser )'
      'WHERE'
      '        CRM.IDCashRegMov = :IDCashRegMov'
      ' ')
    Left = 162
    Top = 95
    object quCashRegInfoIDCashRegMov: TIntegerField
      FieldName = 'IDCashRegMov'
      Origin = 'CashRegMov.IDCashRegMov'
    end
    object quCashRegInfoSystemUser: TStringField
      FieldName = 'SystemUser'
      Origin = 'SystemUser.SystemUser'
      Size = 50
    end
    object quCashRegInfoCashRegister: TStringField
      FieldName = 'CashRegister'
      Origin = 'CashRegister.Name'
      Size = 15
    end
    object quCashRegInfoOpenTime: TDateTimeField
      FieldName = 'OpenTime'
      Origin = 'CashRegMov.OpenTime'
    end
    object quCashRegInfoIDCashRegStatus: TIntegerField
      FieldName = 'IDCashRegStatus'
      Origin = 'CashRegMov.IDCashRegMov'
    end
  end
  object quTestRefresh: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 900
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        COUNT(*) as InvoiceCount'
      'FROM'
      '        Invoice'
      'WHERE'
      '        IDInvoice IS NULL')
    Left = 47
    Top = 153
    object quTestRefreshInvoiceCount: TIntegerField
      FieldName = 'InvoiceCount'
    end
  end
  object spCashRegCalcCash: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashReg_CalcCash;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 161
    Top = 154
  end
  object spCashRegPetty: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_PettyCash;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 46
    Top = 217
  end
  object spCashRegCalcCashWidraw: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashReg_WidrawCalcCash;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 159
    Top = 215
  end
  object spCashRegWidraw: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_Widraw;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill100'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill50'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill20'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill10'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill5'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill2'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin050'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin025'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin010'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin005'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin001'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCard'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCardPre'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCheck'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalOther'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalDebit'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@LogDocument'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@IDReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 44
    Top = 281
  end
  object spDeletePreSale: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_Remove;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 295
    Top = 100
  end
  object spquQuantity: TADOStoredProc
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_quQtyOnStore;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@ModelID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 405
    Top = 45
    object spquQuantityName: TStringField
      DisplayLabel = 'Store'
      DisplayWidth = 33
      FieldName = 'Name'
      Size = 30
    end
    object spquQuantityStoreID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StoreID'
      Visible = False
    end
    object spquQuantityCurrentCost: TFloatField
      DisplayWidth = 10
      FieldName = 'CurrentCost'
      Visible = False
      DisplayFormat = '#,##0.00'
    end
    object spquQuantityQtyOnPreSale: TFloatField
      FieldName = 'QtyOnPreSale'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnRepair: TFloatField
      FieldName = 'QtyOnRepair'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnPrePurchase: TFloatField
      FieldName = 'QtyOnPrePurchase'
      DisplayFormat = '0.#####'
    end
    object spquQuantityFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
  end
  object spquKitPrice: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_Model_quKitPrice;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 405
    Top = 100
    object spquKitPriceSellingPrice: TFloatField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
    end
    object spquKitPriceQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object spAddPreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_AddItem;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCliente'
        Attributes = [paNullable]
        DataType = ftInteger
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
        Name = '@StoreID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@UserID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDComission'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Qty'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@SalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@CostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Discount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@MovDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@ResetDiscount'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Manager'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDPreInvMovExchange'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreInvMovParentID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDDepartment'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Promo'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@IDDescriptionPrice'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDVendorPrice'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SuggPrice'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@DocumentNumber'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@IDDocumentType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SequencyNum'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotParcial'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@PreInventMovID'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 295
    Top = 155
  end
  object spDeletePreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_RemoveItem;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
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
        Name = '@UserID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreInventMovID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Discount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@SalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Qty'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@ResetDiscount'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Manager'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 405
    Top = 155
  end
  object spUpdatePreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_ChangeItem;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
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
        Name = '@UserID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDComission'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Qty'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@SalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@CostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Discount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@MovDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@Manager'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@ResetDiscount'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@PreInvMovParentID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDDepartment'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Promo'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@PreInventMovID'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 295
    Top = 210
  end
  object spAddParcela: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_AddParcela;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
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
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@ExpirationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDMeioPag'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Value'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Authorization'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Parcela'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@IDBankCheck'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@CheckNumber'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@CustomerDocument'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@CustomerName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 80
        Value = Null
      end
      item
        Name = '@CustomerPhone'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@PaymentPlace'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IsPreDatado'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 158
    Top = 277
  end
  object spPreSalePay: TADOStoredProc
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_Pay;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PayDate'
        Attributes = [paNullable]
        DataType = ftDateTime
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
        Name = '@IDTouristGroup'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OtherComID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@CashReceived'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@BonusBucks'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@InvoiceCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@IDInvoice'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 43
    Top = 342
  end
  object spRecalcTax: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_SubCalcTax;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
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
      end>
    Left = 295
    Top = 265
  end
  object cmdExemptTax: TADOCommand
    CommandText = 
      'UPDATE Invoice SET Tax = 0, TaxIsent = :TaxIsent WHERE IDPreSale' +
      ' = :IDPreSale'
    CommandTimeout = 360
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'TaxIsent'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 405
    Top = 265
  end
  object spAddSpecialPrice: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_ApplySpecialPrice;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
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
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 295
    Top = 320
  end
  object spDeleteSpecialPrice: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_RemoveSpecialPrice;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
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
      end>
    Left = 405
    Top = 320
  end
  object spManageDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_SpecialPriceManager;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PercDiscount'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@ExemptTax'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@SellBelowCost'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 295
    Top = 375
  end
  object spMaxDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_MaxDiscount;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@UserID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@MaxVendaMin'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@MaxDiscount'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 405
    Top = 375
  end
  object spSetTaxIsention: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_SetTaxIsention;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDMedia'
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
      end>
    Left = 405
    Top = 210
  end
  object spCalcFullTotal: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_CalcFullTotal;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@FullTotal'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 500
    Top = 45
  end
  object spCreateHold: TADOStoredProc
    Connection = DM.ADODBConnect
    LockType = ltReadOnly
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_CreateHold;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
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
        Name = '@IDTouristGroup'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@MediaID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@DeliverTypeID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDOtherCommission'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@FirstName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@LastName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@Layaway'
        Attributes = [paNullable]
        DataType = ftBoolean
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
        Name = '@Zip'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@Note'
        Attributes = [paNullable]
        DataType = ftString
        Size = 150
        Value = Null
      end
      item
        Name = '@PrintNotes'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@CustomerDOC'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 295
    Top = 45
  end
  object spCancelInvoice: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_CancelInvoice;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 500
    Top = 100
  end
  object spNewSaleCode: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'SP_PreSale_GetNewSaleCode;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSaleParent'
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
        Name = '@SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 20
        Value = Null
      end>
    Left = 500
    Top = 155
  end
  object quInvoiceCanceled: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT TOP 1'#13#10#9'I.CupomFiscal,'#13#10#9'I.Canceled'#13#10'FROM'#13#10#9'Invoice I'#13#10'WH' +
      'ERE'#13#10#9'I.CupomFiscal IS NOT NULL'#13#10#9'AND'#13#10#9'I.CashRegMovID = :IDCash' +
      'RegMov'#13#10'ORDER BY'#13#10#9'I.IDInvoice DESC'#13#10#13#10
    CommandTimeout = 360
    Parameters = <
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 500
    Top = 210
    object quInvoiceCanceledCupomFiscal: TStringField
      FieldName = 'CupomFiscal'
      ReadOnly = True
      Size = 8
    end
    object quInvoiceCanceledCanceled: TBooleanField
      FieldName = 'Canceled'
    end
  end
  object quTestOpenHold: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 360
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'Select '
      #9'nOpenUser, '
      #9'nOpenHoldCaixa'
      'From '
      #9'Invoice'
      'Where '
      #9'IDPreSale = :IDPreSale')
    Left = 500
    Top = 265
    object quTestOpenHoldnOpenUser: TIntegerField
      FieldName = 'nOpenUser'
      Origin = 'RETAIL.Invoice.nOpenUser'
    end
    object quTestOpenHoldnOpenHoldCaixa: TIntegerField
      FieldName = 'nOpenHoldCaixa'
      Origin = 'RETAIL.Invoice.nOpenHoldCaixa'
    end
  end
  object cmdAddDeletedItem: TADOCommand
    CommandText = 
      'INSERT Sal_RemovedItem '#13#10#9'('#13#10#9'IDRemovedItem,'#13#10#9'IDCashRegister,'#13#10 +
      #9'IDModel,'#13#10#9'IDStore,'#13#10#9'IDDepartment,'#13#10#9'IDUserAuto,'#13#10#9'IDPessoa,'#13#10 +
      #9'IDUser,'#13#10#9'MovDate,'#13#10#9'Qty,'#13#10#9'SalePrice,'#13#10#9'CostPrice,'#13#10#9'Discount,' +
      #13#10#9'SaleCode,'#13#10#9'PosicaoItem,'#13#10#9'Acrescimo,'#13#10#9'TotalizadorParcial,'#13#10 +
      #9'IDNotasCanceladas,'#13#10#9'IDPreSale'#13#10#9')'#13#10'VALUES'#13#10#9'('#13#10#9':IDRemovedItem' +
      ','#13#10#9':IDCashRegister,'#13#10#9':IDModel,'#13#10#9':IDStore,'#13#10#9':IDDepartment,'#13#10#9 +
      ':IDUserAuto,'#13#10#9':IDPessoa,'#13#10#9':IDUser,'#13#10#9':MovDate,'#13#10#9':Qty,'#13#10#9':Sale' +
      'Price,'#13#10#9':CostPrice,'#13#10#9':Discount,'#13#10#9':SaleCode,'#13#10#9':PosicaoItem,'#13#10 +
      #9':Acrescimo,'#13#10#9':TotalizadorParcial,'#13#10#9':IDNotasCanceladas,'#13#10#9':IDP' +
      'reSale'#13#10#9')'#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDRemovedItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
        Name = 'IDStore'
        Attributes = [paSigned]
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
        Name = 'IDUserAuto'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SalePrice'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Discount'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'PosicaoItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Acrescimo'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'TotalizadorParcial'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end
      item
        Name = 'IDNotasCanceladas'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 405
    Top = 430
  end
  object cmdInsertReducaoZ: TADOCommand
    CommandText = 
      'INSERT INTO Sal_ReducaoZ (IDReducaoZ, MovDate, NumeroSerie, Nume' +
      'roLoja, NumeroECF, NumReducaoZ, COOInicial, COOFinal, NumCancela' +
      'mentos, ValCancelamentos, ValDescontos, GTInicial, GTFinal, Subs' +
      'tituicaoTrib, Isencao, NaoTributavel, TipoECF, MarcaECF, ModeloE' +
      'CF, VersaoSBECF, DataInstalacaoSBECF, MFAdicional, ContadorReduc' +
      'aoZ, ContadorOrdemOperacao, ContadorReinicioOperacao, NumeroUsua' +
      'rioECF, IncideISSQN, DataEmissao, IDCashRegister)'#13#10'VALUES (:IDRe' +
      'ducaoZ, :MovDate, :NumeroSerie, :NumeroLoja, :NumeroECF, :NumRed' +
      'ucaoZ, :COOInicial, :COOFinal, :NumCancelamentos, :ValCancelamen' +
      'tos, :ValDescontos, :GTInicial, :GTFinal, :SubstituicaoTrib, :Is' +
      'encao, :NaoTributavel, :TipoECF, :MarcaECF, :ModeloECF, :VersaoS' +
      'BECF, :DataInstalacaoSBECF, :MFAdicional, :ContadorReducaoZ, :Co' +
      'ntadorOrdemOperacao, :ContadorReinicioOperacao, :NumeroUsuarioEC' +
      'F, :IncideISSQN, :DataEmissao, :IDCashRegister)'#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDReducaoZ'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'NumeroSerie'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'NumeroLoja'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'NumeroECF'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'NumReducaoZ'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'COOInicial'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'COOFinal'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'NumCancelamentos'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ValCancelamentos'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'ValDescontos'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'GTInicial'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'GTFinal'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SubstituicaoTrib'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Isencao'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NaoTributavel'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'TipoECF'
        Size = -1
        Value = Null
      end
      item
        Name = 'MarcaECF'
        Size = -1
        Value = Null
      end
      item
        Name = 'ModeloECF'
        Size = -1
        Value = Null
      end
      item
        Name = 'VersaoSBECF'
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInstalacaoSBECF'
        Size = -1
        Value = Null
      end
      item
        Name = 'MFAdicional'
        Size = -1
        Value = Null
      end
      item
        Name = 'ContadorReducaoZ'
        Size = -1
        Value = Null
      end
      item
        Name = 'ContadorOrdemOperacao'
        Size = -1
        Value = Null
      end
      item
        Name = 'ContadorReinicioOperacao'
        Size = -1
        Value = Null
      end
      item
        Name = 'NumeroUsuarioECF'
        Size = -1
        Value = Null
      end
      item
        Name = 'IncideISSQN'
        Size = -1
        Value = Null
      end
      item
        Name = 'DataEmissao'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCashRegister'
        Size = -1
        Value = Null
      end>
    Left = 500
    Top = 375
  end
  object cmdInsertTributacaoECF: TADOCommand
    CommandText = 
      'INSERT INTO Sal_TributacaoECF (IDTributacaoECF, Aliquota, BaseCa' +
      'lculo, ValImposto, IDReducaoZ)'#13#10'VALUES (:IDTributacaoECF, :Aliqu' +
      'ota, :BaseCalculo, :ValImposto, :IDReducaoZ)'#13#10
    CommandTimeout = 360
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDTributacaoECF'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Aliquota'
        Attributes = [paSigned]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'BaseCalculo'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'ValImposto'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDReducaoZ'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 500
    Top = 320
  end
  object quTestReducaoZ: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 360
    Parameters = <
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'NumeroSerie'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'R.IDReducaoZ'
      'FROM'
      #9'Sal_ReducaoZ R'
      'WHERE'
      #9'R.MovDate = :MovDate'
      #9'AND R.NumeroSerie = :NumeroSerie')
    Left = 625
    Top = 375
  end
  object spAddCash: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_AddCash;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 154
    Top = 349
  end
  object cmdAddPessoa: TADOCommand
    CommandText = 
      'INSERT Pessoa (IDPessoa, IDTipoPessoa, IDStore, IDTipoPessoaRoot' +
      ', IDUser, Pessoa, PessoaFirstName, PessoaLastName, Endereco, Cid' +
      'ade, CEP, Telefone, Juridico, CPF, Bairro, PhoneAreaCode, CellAr' +
      'eaCode, Cellular, Email, HomePage, Identidade, OrgaoEmissor, Dat' +
      'aExpedicao, Nascimento, CustomerCard, CartMotorista, NomeJuridic' +
      'o, InscEstadual, InscMunicipal, Contatos, OBS, CreationDate)'#13#10'VA' +
      'LUES (:IDPessoa, :IDTipoPessoa, :IDStore, :IDTipoPessoaRoot, :ID' +
      'User, :Pessoa, :PessoaFirstName, :PessoaLastName, :Endereco, :Ci' +
      'dade, :CEP, :Telefone, :Juridico, :CPF, :Bairro, :PhoneAreaCode,' +
      ' :CellAreaCode, :Cellular, :Email, :HomePage, :Identidade, :Orga' +
      'oEmissor, :DataExpedicao, :Nascimento, :CustomerCard, :CartMotor' +
      'ista, :NomeJuridico, :InscEstadual, :InscMunicipal, :Contatos, :' +
      'OBS, :CreationDate)'#13#10#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
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
        Name = 'IDTipoPessoaRoot'
        Attributes = [paSigned, paNullable]
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
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PessoaFirstName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'PessoaLastName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Endereco'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 80
        Value = Null
      end
      item
        Name = 'Cidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CEP'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end
      item
        Name = 'Telefone'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Juridico'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'CPF'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Bairro'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PhoneAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'CellAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'Cellular'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 18
        Value = Null
      end
      item
        Name = 'Email'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'HomePage'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 200
        Value = Null
      end
      item
        Name = 'Identidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'OrgaoEmissor'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'DataExpedicao'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Nascimento'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'CustomerCard'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'CartMotorista'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'NomeJuridico'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'InscEstadual'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'InscMunicipal'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Contatos'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end
      item
        Name = 'CreationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    Left = 625
    Top = 320
  end
  object quGetCustomer: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Tel'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Tel1'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'IDPessoa '
      'FROM '
      #9'Pessoa '
      'WHERE '
      #9'Pessoa = :Pessoa'
      #9'AND '
      #9'('
      #9'IsNull(Telefone, '#39#39#39#39') = :Tel'
      #9'OR'
      #9'RTRIM(LTRIM(IsNull(Telefone, '#39#39'))) = :Tel1'
      #9')')
    Left = 625
    Top = 265
  end
  object cmdInvoiceDiscount: TADOCommand
    CommandText = 
      'UPDATE '#13#10#9'Invoice '#13#10'SET '#13#10#9'InvoiceDiscount = :Discount'#13#10'WHERE '#13#10 +
      #9'IDPreSale = :IDPreSale'#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
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
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 625
    Top = 210
  end
  object cmdInsertSerial: TADOCommand
    CommandText = 
      'INSERT PreSerialMov (PreInventoryMovID, SerialNumber, Identifica' +
      'tionNumber)'#13#10'VALUES (:PreInventoryMovID, :SerialNumber, :Identif' +
      'icationNumber)'
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PreInventoryMovID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'SerialNumber'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'IdentificationNumber'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end>
    Left = 625
    Top = 155
  end
  object cmdInsertObs: TADOCommand
    CommandText = 'UPDATE Invoice Set Note = :Notes'#13#10'WHERE IDPreSale = :IDPreSale'#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Notes'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 150
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 625
    Top = 100
  end
  object quPreSaleTotal: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'((((IsNull(SubTotal,0) - IsNull(InvoiceDiscount, 0) - I' +
      'sNull(TaxIsemptItemDiscount,0)) - IsNull(ItemDiscount,0)) + IsNu' +
      'll(Tax,0)) + IsNull(AditionalExpenses,0)) as PreSaleTotal'#13#10'FROM'#13 +
      #10#9'Invoice (NOLOCK)'#13#10'WHERE'#13#10#9'IDPreSale =  :IDPreSale'#13#10
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 625
    Top = 45
    object quPreSaleTotalPreSaleTotal: TBCDField
      FieldName = 'PreSaleTotal'
      ReadOnly = True
      Precision = 19
    end
  end
  object cmdInsertNotaCancel: TADOCommand
    CommandText = 
      'INSERT Sal_NotasCanceladas (IDNotasCanceladas, IDPessoa, IDUser,' +
      ' Cliente, CPFCGC, COO, CCF, DataNota, SubTotal, Desconto, Acresc' +
      'imo, TipoAcrescimo, TipoDesconto, IDCashRegMov)'#13#10'VALUES (:IDNota' +
      'sCanceladas, :IDPessoa, :IDUser, :Cliente, :CPFCGC, :COO, :CCF, ' +
      ':DataNota, :SubTotal, :Desconto, :Acrescimo, :TipoAcrescimo, :Ti' +
      'poDesconto, :IDCashRegMov)'
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDNotasCanceladas'
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
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Cliente'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CPFCGC'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'COO'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CCF'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataNota'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'SubTotal'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Desconto'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Acrescimo'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'TipoAcrescimo'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'TipoDesconto'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 295
    Top = 430
  end
  object quPreSaleItemCanceled: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'I.IDCustomer,'#13#10#9'I.FirstName + '#39' '#39' + I.LastName as Custo' +
      'mer,'#13#10#9'I.CompanyCGC as CPFCGC,'#13#10#9'I.CupomFiscal as COO,'#13#10#9'I.Invoi' +
      'ceCode,'#13#10#9'I.PreSaleDate,'#13#10#9'I.SubTotal,'#13#10#9'I.InvoiceDiscount + I.I' +
      'temDiscount as Discount,'#13#10#9'I.CashRegMovID,'#13#10#9'IM.ModelID,'#13#10#9'IM.St' +
      'oreID,'#13#10#9'IM.IDDepartment,'#13#10#9'IM.SequencyNum,'#13#10#9'IM.Qty,'#13#10#9'IM.Disco' +
      'unt,'#13#10#9'IM.SalePrice,'#13#10#9'IM.CostPrice,'#13#10#9'IM.IDUser,'#13#10#9'IMC.Totaliza' +
      'dorParcial'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'JOIN InventoryMov IM (NO' +
      'LOCK) ON (I.IDInvoice = IM.DocumentID AND InventMovTypeID = 1)'#13#10 +
      #9'LEFT JOIN Inv_MovComplement IMC (NOLOCK) ON (IMC.IDInventoryMov' +
      ' = IM.IDInventoryMov)'#13#10'WHERE'#13#10#9'IDPreSale = :IDPresale'
    CommandTimeout = 990
    Parameters = <
      item
        Name = 'IDPresale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 500
    Top = 430
  end
  object cmdInsertLancComplement: TADOCommand
    CommandText = 
      'INSERT Fin_LancamentoComplement (IDLancamento, COO, GNF, CDC, Da' +
      'taEmissao)'#13#10'SELECT'#13#10#9'F.IDLancamento,'#13#10#9':COO,'#13#10#9':GNF,'#13#10#9':CDC,'#13#10#9':' +
      'DataEmissao'#13#10'FROM'#13#10#9'Fin_Lancamento F (NOLOCK)'#13#10#9'JOIN MeioPag MP ' +
      '(NOLOCK) ON (MP.IDMeioPag = F.IDQuitacaoMeioPrevisto)'#13#10'WHERE'#13#10#9'F' +
      '.IDPreSale = :IDPreSale'#13#10#9'AND'#13#10#9'MP.Tipo IN (2, 4, 7)'
    CommandTimeout = 990
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'COO'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'GNF'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'CDC'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataEmissao'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPreSale'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 625
    Top = 430
  end
  object cmdInsertTotalizadorParcial: TADOCommand
    CommandText = 
      'INSERT INTO Sal_TotalizadorParcial (IDTotalizadorParcial, IDRedu' +
      'caoZ, Codigo, ValorAcumulado)'#13#10'VALUES (:IDTotalizadorParcial, :I' +
      'DReducaoZ, :Codigo, :ValorAcumulado)'#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDTotalizadorParcial'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDReducaoZ'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Codigo'
        Size = -1
        Value = Null
      end
      item
        Name = 'ValorAcumulado'
        Size = -1
        Value = Null
      end>
    Left = 625
    Top = 485
  end
end
