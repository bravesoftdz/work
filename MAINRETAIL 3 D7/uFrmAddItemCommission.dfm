inherited FrmAddItemCommission: TFrmAddItemCommission
  Left = 473
  Top = 169
  Width = 551
  Height = 366
  BorderIcons = [biSystemMenu]
  Caption = 'FrmAddItemCommission'
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel [0]
    Left = 10
    Top = 60
    Width = 68
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sales Person :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbPercent: TLabel [1]
    Left = 306
    Top = 59
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Percent :'
  end
  object btApplyAll: TSpeedButton [2]
    Left = 427
    Top = 112
    Width = 99
    Height = 23
    Hint = 'Continuing insert data without closing the screen.'
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Apply to All'
    Transparent = False
  end
  inherited Panel2: TPanel
    Width = 535
    inherited Image1: TImage
      Width = 308
    end
    inherited lblMenu: TLabel
      Left = 323
    end
    inherited EspacamentoSuperior: TPanel
      Width = 535
      inherited EEE: TPanel
        Width = 535
      end
    end
  end
  inherited Panel1: TPanel
    Top = 274
    Width = 535
    Height = 54
    inherited EspacamentoInferior: TPanel
      Width = 535
      inherited Panel3: TPanel
        Width = 535
      end
    end
    inherited hhh: TPanel
      Left = 383
      Width = 152
      Height = 48
      inherited btClose: TButton
        Left = 80
        Caption = '&Cancel'
        OnClick = btCloseClick
      end
      object btOK: TButton
        Left = 7
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 234
  end
  inherited EspacamentoDireito: TPanel
    Left = 531
    Width = 4
    Height = 234
  end
  object lbSalesPerson: TListBox [7]
    Left = 83
    Top = 80
    Width = 336
    Height = 176
    ItemHeight = 13
    TabOrder = 4
  end
  object cmbSalesPerson: TSuperComboADO [8]
    Left = 83
    Top = 56
    Width = 201
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'cmbSalesPerson'
    LookUpSource = DM.dsLookUpSalesPersonEdited
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    ShowEditCode = True
    IDLanguage = 0
  end
  object edPercent: TEdit [9]
    Left = 356
    Top = 56
    Width = 63
    Height = 21
    MaxLength = 3
    TabOrder = 6
    OnKeyPress = edPercentKeyPress
  end
  object btRemove: TBitBtn [10]
    Left = 427
    Top = 83
    Width = 98
    Height = 25
    Caption = 'Remove'
    TabOrder = 7
    OnClick = btRemoveClick
  end
  object btAdd: TBitBtn [11]
    Left = 427
    Top = 55
    Width = 98
    Height = 25
    Caption = 'Add'
    TabOrder = 8
    OnClick = btAddClick
  end
  object quSalesPerson: TPowerADOQuery [12]
    Connection = DM.ADODBConnect
    AfterOpen = quSalesPersonAfterOpen
    CommandText = 
      'SELECT'#13#10#9'Pessoa,'#13#10#9'IDPessoa,'#13#10#9'CommissionPercent'#13#10'FROM'#13#10#9'SaleIte' +
      'mCommission SIC (NOLOCK)'#13#10#9'--JOIN PreInventoryMov PIM (NOLOCK) O' +
      'N (PIM.IDPreInventoryMov=SIC.IDPreInventoryMov)'#13#10#9'JOIN PESSOA P ' +
      '(NOLOCK) ON (SIC.IDCoMmission=P.IDPessoa)'#13#10'WHERE'#13#10#9'IDPreInventor' +
      'yMov = :IDPreInventoryMov'
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 28
    Top = 92
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
  object dsSalesPerson: TDataSource [13]
    DataSet = quSalesPerson
    Left = 28
    Top = 144
  end
  object quName: TADODataSet [14]
    Connection = DM.ADODBConnect
    CommandText = 'SELECT '#13#10#9'Pessoa'#13#10'FROM'#13#10#9'Pessoa'#13#10'WHERE'#13#10#9'IDPessoa = :IDPessoa'
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 28
    Top = 196
    object quNamePessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAddItemCommission.sil'
  end
end
