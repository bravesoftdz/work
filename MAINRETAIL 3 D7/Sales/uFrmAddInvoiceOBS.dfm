inherited FrmAddInvoiceOBS: TFrmAddInvoiceOBS
  Left = 380
  Top = 182
  Width = 482
  Height = 394
  Caption = 'FrmAddInvoiceOBS'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblAdditional: TLabel [0]
    Left = 8
    Top = 304
    Width = 54
    Height = 13
    Caption = 'Additional :'
  end
  inherited Panel2: TPanel
    Width = 474
    inherited Image1: TImage
      Width = 247
    end
    inherited lblMenu: TLabel
      Left = 258
    end
    inherited EspacamentoSuperior: TPanel
      Width = 474
      inherited EEE: TPanel
        Width = 474
      end
    end
  end
  inherited Panel1: TPanel
    Top = 326
    Width = 474
    inherited EspacamentoInferior: TPanel
      Width = 474
      inherited Panel3: TPanel
        Width = 474
      end
    end
    inherited hhh: TPanel
      Left = 392
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 73
    Height = 253
  end
  inherited EspacamentoDireito: TPanel
    Left = 471
    Top = 73
    Height = 253
  end
  object pnlButons: TPanel [5]
    Left = 388
    Top = 73
    Width = 83
    Height = 253
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object btnNew: TSpeedButton
      Tag = 4
      Left = 0
      Top = 1
      Width = 83
      Height = 25
      Caption = '&New'
      Flat = True
      Margin = 7
      Spacing = 5
      OnClick = btnNewClick
    end
    object btnDelete: TSpeedButton
      Tag = 4
      Left = 0
      Top = 26
      Width = 83
      Height = 25
      Caption = '&Delete'
      Enabled = False
      Flat = True
      Margin = 7
      Spacing = 5
      OnClick = btnDeleteClick
    end
  end
  object pnlFilter: TPanel [6]
    Left = 0
    Top = 40
    Width = 474
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object lblType: TLabel
      Left = 8
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Type :'
    end
    object cbxType: TComboBox
      Left = 44
      Top = 4
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'All'
      OnChange = cbxTypeChange
      Items.Strings = (
        'All'
        'Payment'
        'Customer'
        'Sales Person')
    end
  end
  object edtAdditional: TEdit [7]
    Left = 68
    Top = 300
    Width = 317
    Height = 21
    TabOrder = 6
  end
  object clbOBS: TCheckListBox [8]
    Left = 4
    Top = 76
    Width = 381
    Height = 217
    ItemHeight = 13
    TabOrder = 7
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAddInvoiceOBS.sil'
    Left = 376
    Top = 8
  end
  object qryDefaultInvoiceOBS: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'DIO.IDDefaultInvoiceOBS,'#13#10#9'DIO.DefaultInvoiceOBS'#13#10'FROM'#13 +
      #10#9'Mnt_DefaultInvoiceOBS DIO (NOLOCK)'#13#10'WHERE'#13#10#9'DIO.OBSType = IsNu' +
      'll(:OBSType, DIO.OBSType)'
    Parameters = <
      item
        Name = 'OBSType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 148
    Top = 100
    object qryDefaultInvoiceOBSIDDefaultInvoiceOBS: TIntegerField
      FieldName = 'IDDefaultInvoiceOBS'
    end
    object qryDefaultInvoiceOBSDefaultInvoiceOBS: TStringField
      FieldName = 'DefaultInvoiceOBS'
      Size = 80
    end
  end
  object cmdDeleteOBS: TADOCommand
    CommandText = 
      'DELETE'#13#10#9'Mnt_DefaultInvoiceOBS'#13#10'WHERE'#13#10#9'IDDefaultInvoiceOBS = :I' +
      'DDefaultInvoiceOBS'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDDefaultInvoiceOBS'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 248
    Top = 100
  end
end
