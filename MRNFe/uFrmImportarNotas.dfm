object FrmImportarNotas: TFrmImportarNotas
  Left = 329
  Top = 343
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Importando Notas'
  ClientHeight = 110
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pb: TProgressBar
    Left = 35
    Top = 40
    Width = 221
    Height = 16
    Step = 1
    TabOrder = 0
  end
  object Timer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerTimer
    Left = 20
    Top = 40
  end
end
