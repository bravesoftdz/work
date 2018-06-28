inherited CardNumberDlgView: TCardNumberDlgView
  Left = 1264
  Top = 260
  ActiveControl = edtSerialNumber
  Caption = 'Mercury Gift Card'
  ClientHeight = 172
  ClientWidth = 342
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblValue: TLabel [0]
    Left = 277
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
  object lblSerialType: TLabel [1]
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
  inherited Panel1: TPanel
    Top = 133
    Width = 342
    inherited Bevel1: TBevel
      Width = 342
    end
    inherited Panel2: TPanel
      Left = 192
      inherited Cancelar: TButton
        OnClick = CancelarClick
      end
      inherited Aplicar: TButton
        ModalResult = 1
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
  end
  object Panel3: TPanel [4]
    Left = 250
    Top = 67
    Width = 77
    Height = 61
    BevelInner = bvLowered
    TabOrder = 2
    object Animate1: TAnimate
      Left = 2
      Top = 2
      Width = 73
      Height = 57
      HelpType = htKeyword
      Align = alClient
      FileName = '.\cartao.avi'
      StopFrame = 10
    end
  end
end
