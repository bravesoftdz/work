inherited frmSerialDgView: TfrmSerialDgView
  Left = 681
  Top = 401
  ActiveControl = edtSerialNumber
  Caption = 'Serial Number'
  ClientHeight = 138
  ClientWidth = 401
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lblSerialType: TLabel [0]
    Left = 16
    Top = 14
    Width = 74
    Height = 13
    Caption = 'lblSerialType'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblValue: TLabel [1]
    Left = 330
    Top = 14
    Width = 46
    Height = 13
    Caption = 'lblValue'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel1: TPanel
    Top = 99
    Width = 401
    inherited Bevel1: TBevel
      Width = 401
    end
    inherited Panel2: TPanel
      Left = 251
      inherited Cancelar: TButton
        Left = 82
        ModalResult = 2
        OnClick = CancelarClick
      end
      inherited Aplicar: TButton
        Left = 11
        ModalResult = 1
        Visible = False
        OnClick = AplicarClick
      end
    end
  end
  object edtSerialNumber: TEdit [3]
    Left = 17
    Top = 40
    Width = 309
    Height = 21
    TabOrder = 1
    OnKeyDown = edtSerialNumberKeyDown
  end
  inherited siLang: TsiLangRT
    Top = 41
  end
end
