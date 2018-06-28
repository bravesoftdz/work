object FrmPOSFunctions: TFrmPOSFunctions
  Left = 0
  Top = 18
  Width = 819
  Height = 540
  Caption = 'FrmPOSFunctions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
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
    Top = 25
    Width = 241
    Height = 507
    Brush.Color = clBlue
    Shape = stRoundRect
  end
  object Shape2: TShape
    Left = 255
    Top = 25
    Width = 406
    Height = 507
    Brush.Color = clLime
    Shape = stRoundRect
  end
  object Shape3: TShape
    Left = 671
    Top = 24
    Width = 105
    Height = 507
    Brush.Color = clRed
    Shape = stRoundRect
  end
  object Label3: TLabel
    Left = 675
    Top = 4
    Width = 98
    Height = 20
    Caption = 'Invoice Calc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object spCashRegOpen: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 48
    Top = 96
  end
  object quCashRegResidual: TADOQuery
    Connection = DM.ADODBConnect
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
      '        CashRegMov CRM (NOLOCK) '
      'WHERE'
      '        CRM.IDCashRegMov = :IDCashRegMov'
      ' ')
    Left = 164
    Top = 40
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
      '        CashRegMov CRM (NOLOCK) '
      
        '        JOIN CashRegister CR (NOLOCK) ON ( CRM.IDCashRegister = ' +
        'CR.IDCashRegister )'
      
        '        JOIN SystemUser SU (NOLOCK) ON ( CRM.IDOpenUser = SU.IDU' +
        'ser )'
      'WHERE'
      '        CRM.IDCashRegMov = :IDCashRegMov'
      ' ')
    Left = 164
    Top = 96
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
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        COUNT(*) as InvoiceCount'
      'FROM'
      '        Invoice (NOLOCK) '
      'WHERE'
      '        IDInvoice IS NULL')
    Left = 48
    Top = 156
    object quTestRefreshInvoiceCount: TIntegerField
      FieldName = 'InvoiceCount'
    end
  end
  object spCashRegCalcCash: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 164
    Top = 156
  end
  object spCashRegPetty: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 48
    Top = 216
  end
  object spCashRegCalcCashWidraw: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 164
    Top = 216
  end
  object spCashRegWidraw: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Top = 276
  end
  object spDeletePreSale: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 288
    Top = 104
  end
  object spquQuantity: TADOStoredProc
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
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
    Left = 396
    Top = 48
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
    object spquQuantityFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
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
  end
  object spquKitPrice: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Model_quKitPrice;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Value = 0
      end
      item
        Name = '@IDModel'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 396
    Top = 104
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
        Name = '@DiscountPromo'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
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
    Left = 288
    Top = 160
  end
  object spDeletePreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
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
      end
      item
        Name = '@SellBelowCost'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 396
    Top = 160
  end
  object spUpdatePreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
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
        Name = '@DiscountPromo'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
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
    Left = 288
    Top = 216
  end
  object spAddParcela: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 164
    Top = 276
  end
  object spPreSalePay: TADOStoredProc
    Connection = DM.ADODBConnect
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
        Name = '@BonusCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 34
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
    Left = 44
    Top = 340
  end
  object spRecalcTax: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 288
    Top = 272
  end
  object cmdExemptTax: TADOCommand
    CommandText = 
      'UPDATE Invoice SET Tax = 0, TaxIsent = :TaxIsent WHERE IDPreSale' +
      ' = :IDPreSale'
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
    Left = 396
    Top = 272
  end
  object spAddSpecialPrice: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_ApplySpecialPrice;1'
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
      end
      item
        Name = '@ExemptTax'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 288
    Top = 328
  end
  object spDeleteSpecialPrice: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_RemoveSpecialPrice;1'
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
      end>
    Left = 396
    Top = 328
  end
  object spManageDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
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
      end
      item
        Name = '@IsPromo'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 288
    Top = 384
  end
  object spMaxDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 396
    Top = 384
  end
  object spSetTaxIsention: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 396
    Top = 216
  end
  object spCalcFullTotal: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 508
    Top = 48
  end
  object spAddInvAdtionalCost: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_AddAdditionalExpenses;1'
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
        Value = 0
      end
      item
        Name = '@IDCostType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Amount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = 0c
      end>
    Left = 508
    Top = 104
  end
  object spDeleteInvAdtionalCost: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_SubRemoveAdditionalExpenses;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDInvoiceCost'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 508
    Top = 160
  end
  object quPaymentValue: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  SUM(L.ValorNominal) as Total'
      'FROM'
      '  Fin_Lancamento L (NOLOCK) '
      'WHERE'
      '  L.IDPreSale = :IDPreSale'
      ' ')
    Left = 705
    Top = 40
    object quPaymentValueTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      Precision = 19
    end
  end
  object spPreSaleCancelHold: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_CancelHold;1'
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
        Value = 0
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 508
    Top = 216
  end
  object spCashRegSubClose: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_CashRegister_SubClose;1'
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
    Left = 164
    Top = 340
  end
  object sp_CashRegister_QuitaLancamento: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_CashRegister_Quita_Lancamento;1'
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
        Name = '@IDLancamentoQuitar'
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
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 44
    Top = 404
  end
  object spDivideHold: TADOStoredProc
    Connection = DM.ADODBConnect
    LockType = ltReadOnly
    ProcedureName = 'sp_PreSale_DivideHold;1'
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
        Name = '@DeliverTypeID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@DeliverDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@DeliverAddress'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@DeliverOBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@NewIDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 508
    Top = 272
  end
  object spCreateHold: TADOStoredProc
    Connection = DM.ADODBConnect
    LockType = ltReadOnly
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
    Left = 288
    Top = 48
  end
  object spAddCustomerCredit: TADOStoredProc
    Connection = DM.ADODBConnect
    LockType = ltReadOnly
    ProcedureName = 'sp_PreSale_AddCustomerCredit;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPessoa'
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
        Name = '@IDStore'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@CreditDate'
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
        Name = '@Amount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@IDLancamento'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCustomerCredit'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 508
    Top = 328
  end
  object quQtyInventoryPreSale: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'StoreID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'PreSaleID'
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'Inventory.QtyOnPreSale,'
      #9'Inventory.QtyOnHand,'
      #9'Inventory.QtyOnOrder,'
      #9'Inventory.QtyOnRepair,'
      #9'Inventory.StoreID,'
      #9'Inventory.QtyOnPrePurchase,'
      #9'IsNull(Model.FloatPercent, 0) FloatPercent'
      'FROM'
      #9'PreInventoryMov (NOLOCK) '
      #9'INNER JOIN Inventory (NOLOCK) '
      #9#9'ON (PreInventoryMov.ModelID = Inventory.ModelID)'
      #9'INNER JOIN Model (NOLOCK) '
      #9#9'ON (Inventory.ModelID = Model.IDModel)'
      'WHERE'
      #9'PreInventoryMov.InventMovTypeID = 1'
      #9'AND'
      #9'Inventory.StoreID = :StoreID'
      #9'AND'
      #9'PreInventoryMov.DocumentID = :PreSaleID'
      #9'AND'
      #9'IsNull(Model.NotVerifyQty,0) = 0'
      #9'AND'
      #9'Model.IDModel = IsNull(:IDModel, Model.IDModel)'
      '')
    Left = 508
    Top = 384
  end
  object quVerifyDeliveryModel: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'SUM(PIM.Qty) as Qty,'
      #9'QtyOnHand as OnHand,'
      #9'QtyOnPrePurchase as InPurchasing'
      'FROM'
      #9'PreInventoryMov PIM (NOLOCK) '
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)'
      #9'JOIN Invoice I (NOLOCK) ON '
      
        #9#9'(PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1 AND ' +
        'I.DeliverConfirmation = 1)'
      #9'LEFT JOIN Inventory IV (NOLOCK) ON (PIM.ModelID = IV.ModelID)'
      'WHERE'
      #9'PIM.ModelID = :IDModel'
      #9'AND'
      #9'IV.StoreID = :IDStore'
      #9'AND'
      #9'IsNull(M.NotVerifyQty,0) = 0'
      'GROUP BY'
      #9'QtyOnHand,'
      #9'QtyOnPrePurchase')
    Left = 288
    Top = 440
    object quVerifyDeliveryModelQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quVerifyDeliveryModelOnHand: TFloatField
      FieldName = 'OnHand'
      DisplayFormat = '0.#####'
    end
    object quVerifyDeliveryModelInPurchasing: TFloatField
      FieldName = 'InPurchasing'
      DisplayFormat = '0.#####'
    end
  end
  object quDeliverOpenHolds: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'I.SaleCode'#13#10'FROM'#13#10#9'Invoice I (NOLOCK) '#13#10'WHERE'#13#10#9'I.IDInv' +
      'oice is Null'#13#10#9'AND'#13#10#9'I.DeliverConfirmation = 0'#13#10#9'AND'#13#10#9'I.IDCusto' +
      'mer = :IDCustomer'#13#10#9'AND'#13#10#9'I.IDPreSale <> :IDPreSale'
    Parameters = <
      item
        Name = 'IDCustomer'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
    Left = 396
    Top = 440
    object quDeliverOpenHoldsSaleCode: TStringField
      FieldName = 'SaleCode'
    end
  end
  object quHasPendingPayment: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IDLancamento '#13#10'FROM'#13#10#9'Fin_Lancamento'#13#10'WHERE'#13#10#9'IDPreSale' +
      ' = :IDPreSale'#13#10#9'AND'#13#10#9'IDCashRegMovClosed IS NULL'#13#10#9'AND'#13#10#9'Payment' +
      'Place = 2'#13#10
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 508
    Top = 440
    object quHasPendingPaymentIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
  end
  object spNewSaleCode: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 620
    Top = 440
  end
  object quSalesPerson: TPowerADOQuery
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'Pessoa,'#13#10#9'IDPessoa,'#13#10#9'CommissionPercent'#13#10'FROM'#13#10#9'SaleIte' +
      'mCommission SIC (NOLOCK) '#13#10#9'JOIN PESSOA P (NOLOCK) ON (SIC.IDCoM' +
      'mission=P.IDPessoa)'#13#10
    Parameters = <>
    Left = 620
    Top = 384
    object quSalesPersonPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quSalesPersonIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quSalesPersonCommissionPercent: TBCDField
      FieldName = 'CommissionPercent'
      Precision = 18
      Size = 0
    end
  end
  object spApplyCustomerDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_ApplyCustomerDiscount;1'
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
        Name = '@IDCustomer'
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
    Left = 620
    Top = 272
  end
  object spCalcCustomerDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_CalcCustomerDiscount;1'
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
        Name = '@IDModel'
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
        Name = '@Discount'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 620
    Top = 328
  end
  object dspKitPrice: TDataSetProvider
    DataSet = spquKitPrice
    Left = 416
    Top = 112
  end
  object cdsKitPrice: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftInteger
        Name = '@IDModel'
        ParamType = ptInput
      end>
    ProviderName = 'dspKitPrice'
    Left = 432
    Top = 120
    object cdsKitPriceSellingPrice: TFloatField
      FieldName = 'SellingPrice'
    end
    object cdsKitPriceQty: TFloatField
      FieldName = 'Qty'
    end
  end
  object spApplyCustItemDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_ApplyCustomerItemDiscount;1'
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
        Name = '@IDCustomer'
        Attributes = [paNullable]
        DataType = ftInteger
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
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 616
    Top = 196
  end
  object spCashAddPayment: TADOStoredProc
    Connection = DM.ADODBConnect
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
    Left = 164
    Top = 400
  end
  object spImporEstimated: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_Import_Estimated;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDEstimated'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TaxIsent'
        Attributes = [paNullable]
        DataType = ftBoolean
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
        Name = '@UpdateSalePrice'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@NewIDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 608
    Top = 144
  end
  object quValidateDelivery: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'SUM(PIM.Qty) as Qty'#13#10'FROM'#13#10#9'PreInventoryMov PIM (NOLOCK' +
      ')'#13#10#9'JOIN Invoice I (NOLOCK) ON (PIM.DocumentID = I.IDPreSale)'#13#10'W' +
      'HERE'#13#10#9'PIM.ModelID = :IDModel'#13#10#9'AND'#13#10#9'PIM.InventMovTypeID = 1'#13#10#9 +
      'AND'#13#10#9'('#13#10#9'I.PreSaleDate < :MovDate'#13#10#9'OR'#13#10#9'I.IDPreSaleParent = :I' +
      'DPreSale'#13#10#9')'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
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
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 600
    Top = 48
    object quValidateDeliveryQty: TBCDField
      FieldName = 'Qty'
      ReadOnly = True
      Precision = 32
    end
  end
  object WebDispatcher1: TWebDispatcher
    OldCreateOrder = False
    Actions = <>
    Left = 620
    Top = 115
    Height = 0
    Width = 0
  end
end
