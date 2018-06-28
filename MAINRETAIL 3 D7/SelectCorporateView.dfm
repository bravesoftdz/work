inherited dlgSelectCorpView: TdlgSelectCorpView
  Left = 609
  Top = 486
  Caption = 'Select Corporate Location'
  ClientHeight = 177
  ClientWidth = 403
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 65
    Top = 35
    Width = 113
    Height = 13
    Caption = 'Corporate Location:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel1: TPanel
    Top = 138
    Width = 403
    inherited Bevel1: TBevel
      Width = 403
    end
    inherited Panel2: TPanel
      Left = 253
      inherited Cancelar: TButton
        Visible = False
      end
      inherited Aplicar: TButton
        Left = 78
        Caption = '&Save'
        OnClick = AplicarClick
      end
    end
  end
  object cbbStores: TComboBox [2]
    Left = 190
    Top = 35
    Width = 206
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
end
