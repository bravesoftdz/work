inherited FrmApplyItemTax: TFrmApplyItemTax
  Left = 225
  Top = 270
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Item Tax'
  ClientHeight = 163
  ClientWidth = 338
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label29: TLabel [0]
    Left = 36
    Top = 59
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sale tax :'
  end
  inherited Panel1: TPanel
    Top = 122
    Width = 338
    inherited EspacamentoInferior: TPanel
      Width = 338
      inherited Panel3: TPanel
        Width = 338
      end
    end
    inherited hhh: TPanel
      Left = 117
      Width = 221
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 149
        OnClick = btCloseClick
      end
      object btnApply: TButton
        Left = 80
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Apply'
        TabOrder = 1
        TabStop = False
        OnClick = btnApplyClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 116
  end
  inherited EspacamentoDireito: TPanel
    Left = 335
    Height = 116
  end
  inherited EspacamentoSuperior: TPanel
    Width = 338
  end
  object scSaleTax: TSuperComboADO [5]
    Left = 87
    Top = 55
    Width = 222
    Height = 21
    TabOrder = 4
    SpcWhereClause = 'OperationType = 1 AND SaleTaxType = 1'
    LookUpSource = DM.dsLookUpTaxCategory
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object cmdApplyItemTax: TADOCommand
    CommandText = 
      'UPDATE '#13#10#9'PreInventoryMov '#13#10'SET'#13#10#9'IDTaxCategory = :TaxID'#13#10'WHERE'#13 +
      #10#9'IDPreInventoryMov = :IDPreInventoryMov'#13#10#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'TaxID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 256
    Top = 20
  end
  object cmdApplyHoldTax: TADOCommand
    CommandText = 
      'UPDATE '#13#10#9'PreInventoryMov '#13#10'SET'#13#10#9'IDTaxCategory = :IDTax'#13#10'WHERE'#13 +
      #10#9'DocumentID = :IDPreSale'#13#10#9'AND '#13#10#9'InventMovTypeID = 1'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDTax'
        Attributes = [paSigned, paNullable]
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
    Left = 256
    Top = 80
  end
  object spUpdateTotal: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_SubCalcTotal;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
      end>
    Left = 164
    Top = 20
  end
end
