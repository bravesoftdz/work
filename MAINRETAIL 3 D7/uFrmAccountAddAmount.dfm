inherited FrmAccountAddAmount: TFrmAccountAddAmount
  Left = 248
  Top = 176
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Obs'
  ClientHeight = 192
  ClientWidth = 367
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbOBS: TLabel [0]
    Left = 28
    Top = 64
    Width = 25
    Height = 13
    Alignment = taRightJustify
    Caption = 'Obs :'
  end
  object pnlAmount: TPanel [1]
    Left = 7
    Top = 13
    Width = 350
    Height = 41
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 4
      Top = 15
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'Amount :'
    end
    object edtAmount: TEdit
      Left = 49
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyPress = edtAmountKeyPress
    end
  end
  inherited Panel1: TPanel
    Top = 151
    Width = 367
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 367
      inherited Panel3: TPanel
        Width = 367
      end
    end
    inherited hhh: TPanel
      Left = 156
      Width = 211
      inherited sbHelp: TSpeedButton
        Left = 5
        Top = 4
        Visible = False
      end
      inherited btClose: TButton
        Left = 141
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 73
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Save'
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 145
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 364
    Height = 145
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 367
    TabOrder = 5
  end
  object memOBS: TMemo [6]
    Left = 56
    Top = 60
    Width = 301
    Height = 85
    MaxLength = 100
    TabOrder = 1
  end
  object pnlExpDate: TPanel [7]
    Left = 6
    Top = 14
    Width = 350
    Height = 41
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object lbExpDate: TLabel
      Left = 4
      Top = 15
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Expiration Date :'
    end
    object dtExp: TDateBox
      Left = 86
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 0
    end
  end
  object spAccountAddAmount: TADOStoredProc [8]
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Sal_AccountCard_AddAmount;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@CardNumber'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
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
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
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
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Credit'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end>
    Left = 260
    Top = 40
  end
  object cmdCancelAccount: TADOCommand [9]
    CommandText = 
      'UPDATE'#13#10#9'Sal_AccountCard'#13#10'SET'#13#10#9'Canceled = :Canceled'#13#10'WHERE'#13#10#9'Ca' +
      'rdNumber = :CardNumber'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Canceled'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CardNumber'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 88
    Top = 92
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAccountAddAmount.sil'
  end
  object cmdExpDate: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Sal_AccountCard'#13#10'SET'#13#10#9'ExpirationDate = :ExpirationDate' +
      #13#10'WHERE'#13#10#9'CardNumber = :CardNumber'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'ExpirationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'CardNumber'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 192
    Top = 92
  end
end
