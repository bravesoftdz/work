inherited FrmNewInvoiceOBS: TFrmNewInvoiceOBS
  Left = 316
  Top = 281
  Width = 417
  Height = 229
  Caption = 'FrmNewInvoiceOBS'
  PixelsPerInch = 96
  TextHeight = 13
  object lblObs: TLabel [0]
    Left = 56
    Top = 96
    Width = 27
    Height = 13
    Caption = 'OBS :'
  end
  object lblType: TLabel [1]
    Left = 52
    Top = 64
    Width = 31
    Height = 13
    Caption = 'Type :'
  end
  object Label37: TLabel [2]
    Left = 235
    Top = 62
    Width = 14
    Height = 23
    Hint = 'Field can not be empty'
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Label1: TLabel [3]
    Left = 351
    Top = 94
    Width = 14
    Height = 23
    Hint = 'Field can not be empty'
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  inherited Panel2: TPanel
    Width = 409
    TabOrder = 3
    inherited Image1: TImage
      Width = 182
    end
    inherited lblMenu: TLabel
      Left = 193
    end
    inherited EspacamentoSuperior: TPanel
      Width = 409
      inherited EEE: TPanel
        Width = 409
      end
    end
  end
  inherited Panel1: TPanel
    Top = 161
    Width = 409
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 409
      TabOrder = 1
      inherited Panel3: TPanel
        Width = 409
      end
    end
    inherited hhh: TPanel
      Left = 327
      TabOrder = 2
      inherited btClose: TButton
        Cancel = True
        ModalResult = 2
      end
    end
    object btSave: TButton
      Left = 266
      Top = 9
      Width = 66
      Height = 31
      Caption = '&Save'
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btSaveClick
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 121
    TabOrder = 4
  end
  inherited EspacamentoDireito: TPanel
    Left = 406
    Height = 121
    TabOrder = 5
  end
  object mmObs: TMemo [8]
    Left = 88
    Top = 92
    Width = 261
    Height = 41
    TabOrder = 1
  end
  object cbxType: TComboBox [9]
    Left = 88
    Top = 60
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Payment'
    Items.Strings = (
      'Payment'
      'Customer'
      'Sales Person')
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmNewInvoiceOBS.sil'
  end
  object cmdInsertOBS: TADOCommand
    CommandText = 
      'INSERT INTO Mnt_DefaultInvoiceOBS (IDDefaultInvoiceOBS, OBSType,' +
      ' DefaultInvoiceOBS)'#13#10'VALUES (:IDDefaultInvoiceOBS, :OBSType, :De' +
      'faultInvoiceOBS)'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDDefaultInvoiceOBS'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'OBSType'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DefaultInvoiceOBS'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Left = 192
    Top = 48
  end
end
