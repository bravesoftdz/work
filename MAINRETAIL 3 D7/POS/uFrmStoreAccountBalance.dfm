inherited FrmStoreAccountBalance: TFrmStoreAccountBalance
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Verificar Saldo do Cliente'
  ClientHeight = 162
  ClientWidth = 352
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbInfo: TLabel [0]
    Left = 18
    Top = 19
    Width = 326
    Height = 55
    AutoSize = False
    Caption = 'Consultando saldo do cliente ....'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object pnlOK: TPanel [1]
    Left = 0
    Top = 121
    Width = 352
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    DesignSize = (
      352
      41)
    object Panel9: TPanel
      Left = 0
      Top = 0
      Width = 352
      Height = 6
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = 4
        Width = 352
        Height = 2
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object btOK: TButton
      Left = 281
      Top = 9
      Width = 66
      Height = 31
      Anchors = [akTop, akRight]
      Caption = '&OK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btOKClick
    end
    object btnChageUser: TButton
      Left = 210
      Top = 9
      Width = 69
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Autorizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnChageUserClick
    end
  end
  object TimerStoreAcc: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TimerStoreAccTimer
    Left = 75
    Top = 15
  end
  object quAccLimit: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'StoreAccountLimit'#13#10'FROM'#9#13#10#9'Pessoa'#13#10'WHERE'#13#10#9'IDPessoa = :' +
      'IDPessoa'
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 70
    Top = 80
    object quAccLimitStoreAccountLimit: TBCDField
      FieldName = 'StoreAccountLimit'
      Precision = 19
    end
  end
  object quStoreAccBalance: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'SUM(SA.Amount) as Amount'#13#10'FROM '#13#10#9'Sal_StoreAccount SA ' +
      '(NOLOCK)'#13#10'WHERE '#13#10#9'SA.IDStoreAccountUsed IS NULL'#13#10#9'AND SA.IsUsed' +
      ' = 0'#13#10#9'AND SA.IsReceiving = 0'#13#10#9'AND SA.IDPessoa = :IDPessoa'#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 175
    Top = 80
    object quStoreAccBalanceAmount: TBCDField
      FieldName = 'Amount'
      ReadOnly = True
      Precision = 19
    end
  end
  object cmdInsertStoreAcc: TADOCommand
    CommandText = 
      'INSERT Sal_StoreAccount (IDStoreAccount, IDPessoa, IDUser, IDSto' +
      're, TransactionDate, Amount, IsUsed, IsReceiving, Verify)'#13#10'VALUE' +
      'S (:IDStoreAccount, :IDPessoa, :IDUser, :IDStore, :TransactionDa' +
      'te, :Amount, 0, 0, 1)'#13#10
    CommandTimeout = 180
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDStoreAccount'
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
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'TransactionDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Amount'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    Left = 270
    Top = 80
  end
end
