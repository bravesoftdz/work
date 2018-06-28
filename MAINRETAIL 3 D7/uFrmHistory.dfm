inherited FrmHistory: TFrmHistory
  Left = 251
  Top = 125
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'History'
  ClientWidth = 342
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 16
    Top = 45
    Width = 65
    Height = 13
    Alignment = taRightJustify
    Caption = 'History Type :'
  end
  object Label2: TLabel [1]
    Left = 51
    Top = 21
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
  end
  object Label3: TLabel [2]
    Left = 52
    Top = 73
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'Date :'
  end
  object Label4: TLabel [3]
    Left = 53
    Top = 96
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'OBS :'
  end
  object Label35: TLabel [4]
    Left = 307
    Top = 45
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel [5]
    Left = 180
    Top = 72
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel1: TPanel
    Width = 342
    inherited EspacamentoInferior: TPanel
      Width = 342
      inherited Panel3: TPanel
        Width = 342
      end
    end
    inherited hhh: TPanel
      Left = 132
      Width = 210
      inherited sbHelp: TSpeedButton
        Left = 0
        Visible = False
      end
      inherited btClose: TButton
        Left = 137
        Caption = '&Cancel'
        OnClick = btCloseClick
      end
      object btOk: TButton
        Left = 68
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        TabOrder = 1
        TabStop = False
        OnClick = btOkClick
      end
    end
  end
  inherited EspacamentoDireito: TPanel
    Left = 339
  end
  inherited EspacamentoSuperior: TPanel
    Width = 342
  end
  object scoHistoryType: TSuperComboADO [10]
    Left = 88
    Top = 43
    Width = 217
    Height = 21
    TabOrder = 4
    LookUpSource = DM.dsLookUpHistoryType
    MostraHidden = STD_AMBOSHIDDEN
    IDLanguage = 0
    OnSelectItem = scoHistoryTypeSelectItem
  end
  object scoUser: TSuperComboADO [11]
    Left = 88
    Top = 17
    Width = 217
    Height = 21
    TabStop = False
    Color = clSilver
    ReadOnly = True
    TabOrder = 5
    LookUpSource = DM.dsLookUpUser
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object edtData: TDateBox [12]
    Left = 88
    Top = 69
    Width = 88
    Height = 21
    TabOrder = 6
    InputTime = False
    Language = Portuguese
  end
  object memOBS: TMemo [13]
    Left = 88
    Top = 94
    Width = 215
    Height = 121
    MaxLength = 255
    TabOrder = 7
  end
  object pnlFinalize: TPanel [14]
    Left = 6
    Top = 218
    Width = 320
    Height = 165
    BevelOuter = bvNone
    TabOrder = 8
    Visible = False
    object Label10: TLabel
      Left = 174
      Top = 5
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 31
      Top = 8
      Width = 45
      Height = 13
      Alignment = taRightJustify
      Caption = 'Invoice #'
    end
    object lblReceivedBy: TLabel
      Left = 11
      Top = 32
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'Received By :'
    end
    object Label9: TLabel
      Left = 301
      Top = 30
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCFOP: TLabel
      Left = 43
      Top = 54
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'CFOP :'
    end
    object edtInvoiceNumber: TEdit
      Left = 82
      Top = 4
      Width = 88
      Height = 21
      MaxLength = 20
      TabOrder = 0
    end
    object edtReceivedBy: TEdit
      Left = 82
      Top = 28
      Width = 217
      Height = 21
      TabOrder = 1
    end
    object scCFOP: TSuperComboADO
      Left = 82
      Top = 52
      Width = 217
      Height = 21
      TabOrder = 2
      LookUpSource = DM.dsLookUpCFOP
      MostraDesativado = STD_AMBOSDESATIVADO
      MostraHidden = STD_AMBOSHIDDEN
      IDLanguage = 0
    end
    object gbxCarrier: TGroupBox
      Left = 9
      Top = 76
      Width = 291
      Height = 83
      Caption = '  Carrier  '
      TabOrder = 3
      object lbCarrier: TLabel
        Left = 32
        Top = 38
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'Carrier :'
      end
      object lbFilterCarrier: TLabel
        Left = 40
        Top = 16
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Filter :'
      end
      object lbFreightType: TLabel
        Left = 4
        Top = 61
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'Freight Type :'
      end
      object scFilterCarrier: TSuperComboADO
        Left = 73
        Top = 12
        Width = 214
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
        LookUpSource = DM.dsLookUpTipoPessoa
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        EditCodePos = taEditCodeRight
        IDLanguage = 0
        OnSelectItem = scFilterCarrierSelectItem
      end
      object cbxFreightType: TComboBox
        Left = 73
        Top = 58
        Width = 110
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Store'
        Items.Strings = (
          'Store'
          'Destination')
      end
      object scCarrier: TSuperComboADO
        Left = 73
        Top = 35
        Width = 213
        Height = 21
        TabOrder = 1
        LookUpSource = DM.dsLookUpPessoa
        MostraHidden = STD_AMBOSHIDDEN
        IDLanguage = 0
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmHistory.sil'
  end
  object cmdInsertHistory: TADOCommand
    CommandText = 
      'INSERT INTO History'#13#10'            ('#13#10'            IDHistory,'#13#10'    ' +
      '        IDUser,'#13#10'            MovDate,'#13#10'            OBS,'#13#10'       ' +
      '     IDHistoryType,'#13#10'            IDPreSale,'#13#10'            IDServi' +
      'ceOrder'#13#10'            )'#13#10'VALUES'#13#10'            ('#13#10'            :IDHi' +
      'story,'#13#10'            :IDUser,'#13#10'            :MovDate,'#13#10'           ' +
      ' :OBS,'#13#10'            :IDHistoryType,'#13#10'            :IDPreSale,'#13#10'  ' +
      '          :IDServiceOrder'#13#10'            )'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDHistory'
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
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'OBS'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'IDHistoryType'
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
      end
      item
        Name = 'IDServiceOrder'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 90
    Top = 15
  end
end
