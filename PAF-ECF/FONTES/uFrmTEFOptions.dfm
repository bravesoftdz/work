inherited FrmTEFOptions: TFrmTEFOptions
  Left = 235
  Top = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'TEF'
  ClientHeight = 244
  ClientWidth = 296
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object msgClient: TMemo [0]
    Left = 0
    Top = 188
    Width = 296
    Height = 56
    TabStop = False
    Align = alBottom
    BevelInner = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = 16764573
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 5
  end
  object btnCancelTEF: TBitBtn [1]
    Left = 68
    Top = 41
    Width = 158
    Height = 25
    Caption = '&Cancela TEF'
    TabOrder = 1
    OnClick = btnCancelTEFClick
  end
  object btnAdmTEF: TBitBtn [2]
    Left = 68
    Top = 71
    Width = 158
    Height = 25
    Caption = '&Administra'#231#227'o TEF'
    TabOrder = 2
    OnClick = btnAdmTEFClick
  end
  object btnVerificaTEF: TBitBtn [3]
    Left = 68
    Top = 103
    Width = 158
    Height = 25
    Caption = '&Verificar TEF'
    TabOrder = 3
    OnClick = btnVerificaTEFClick
  end
  object btnFechar: TBitBtn [4]
    Left = 68
    Top = 153
    Width = 158
    Height = 25
    Cancel = True
    Caption = '&Fechar'
    TabOrder = 4
    OnClick = btnFecharClick
  end
  object rgTEFDial: TRadioGroup [5]
    Left = 55
    Top = 4
    Width = 187
    Height = 32
    Caption = 'Discado'
    Columns = 2
    TabOrder = 0
    Visible = False
  end
  object TefDedicadoInterface1: TTefDedicadoInterface
    OnExecutaComando1 = TefDedicadoInterface1ExecutaComando1
    OnExecutaComando2 = TefDedicadoInterface1ExecutaComando2
    OnExecutaComando3 = TefDedicadoInterface1ExecutaComando3
    OnExecutaComando22 = TefDedicadoInterface1ExecutaComando22
    OnExecutaComando11 = TefDedicadoInterface1ExecutaComando11
    OnExecutaComando12 = TefDedicadoInterface1ExecutaComando12
    OnExecutaComando13 = TefDedicadoInterface1ExecutaComando13
    OnLimpaMsg = TefDedicadoInterface1LimpaMsg
    Left = 45
    Top = 69
  end
end
