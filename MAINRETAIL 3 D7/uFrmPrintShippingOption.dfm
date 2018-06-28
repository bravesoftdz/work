inherited FrmPrintShippingOption: TFrmPrintShippingOption
  Left = 189
  Top = 217
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Shipping Print Option'
  ClientHeight = 217
  ClientWidth = 359
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbReport: TLabel [0]
    Left = 73
    Top = 24
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = 'Report :'
  end
  object lbNumCopies: TLabel [1]
    Left = 22
    Top = 62
    Width = 89
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of copies :'
  end
  object lbPrinter: TLabel [2]
    Left = 75
    Top = 102
    Width = 36
    Height = 13
    Alignment = taRightJustify
    Caption = 'Printer :'
  end
  inherited Panel1: TPanel
    Top = 176
    Width = 359
    TabOrder = 4
    inherited EspacamentoInferior: TPanel
      Width = 359
      inherited Panel3: TPanel
        Width = 359
      end
    end
    inherited hhh: TPanel
      Left = 144
      Width = 215
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        OnClick = btCloseClick
      end
      object btnPrint: TButton
        Left = 76
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Print'
        TabOrder = 1
        TabStop = False
        OnClick = btnPrintClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 170
    TabOrder = 5
  end
  inherited EspacamentoDireito: TPanel
    Left = 356
    Height = 170
    TabOrder = 6
  end
  inherited EspacamentoSuperior: TPanel
    Width = 359
    TabOrder = 7
  end
  object cbxReport: TComboBox [7]
    Left = 116
    Top = 20
    Width = 157
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = 'Packing Slip'
    Items.Strings = (
      'Packing Slip'
      'Pick Ticket'
      'Regular Invoice')
  end
  object edtNumCopy: TEdit [8]
    Left = 116
    Top = 57
    Width = 69
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object chkPreview: TCheckBox [9]
    Left = 116
    Top = 140
    Width = 165
    Height = 17
    Caption = 'Preview'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object cbxPrinter: TComboBox [10]
    Left = 116
    Top = 98
    Width = 205
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
end
