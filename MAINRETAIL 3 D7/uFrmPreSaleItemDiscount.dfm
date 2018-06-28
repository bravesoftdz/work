inherited FrmPreSaleItemDiscount: TFrmPreSaleItemDiscount
  Left = 1127
  Top = 362
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Item Discount'
  ClientHeight = 217
  ClientWidth = 264
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [0]
    Left = 45
    Top = 59
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Discount :'
  end
  object lblValue: TLabel [1]
    Left = 38
    Top = 96
    Width = 54
    Height = 13
    Alignment = taRightJustify
    Caption = 'Percent (%)'
  end
  object Label1: TLabel [2]
    Left = 28
    Top = 23
    Width = 64
    Height = 13
    Alignment = taRightJustify
    Caption = 'Selling Price :'
  end
  object Label3: TLabel [3]
    Left = 37
    Top = 133
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = 'New Price :'
  end
  inherited Panel1: TPanel
    Top = 176
    Width = 264
    inherited EspacamentoInferior: TPanel
      Width = 264
      inherited Panel3: TPanel
        Width = 264
      end
    end
    inherited hhh: TPanel
      Left = 31
      Width = 233
      inherited sbHelp: TSpeedButton
        Left = 20
        Visible = False
      end
      inherited btClose: TButton
        Left = 164
        ModalResult = 2
      end
      object btApply: TButton
        Left = 92
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Apply'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btApplyClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 170
  end
  inherited EspacamentoDireito: TPanel
    Left = 261
    Height = 170
  end
  inherited EspacamentoSuperior: TPanel
    Width = 264
  end
  object cmbCalcType: TComboBox [8]
    Left = 99
    Top = 55
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Percent (%)'
    OnChange = cmbCalcTypeChange
    Items.Strings = (
      'Percent (%)'
      'Amount ($)')
  end
  object edtValue: TEdit [9]
    Left = 99
    Top = 92
    Width = 129
    Height = 21
    TabOrder = 6
    OnChange = edtValueChange
    OnKeyPress = edtValueKeyPress
  end
  object edtSellingPrice: TEdit [10]
    Left = 99
    Top = 19
    Width = 129
    Height = 21
    TabStop = False
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 4
  end
  object edtNewPrice: TEdit [11]
    Left = 99
    Top = 129
    Width = 129
    Height = 21
    TabStop = False
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPreSaleItemDiscount.sil'
  end
end
