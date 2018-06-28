object FrmMain: TFrmMain
  Left = 497
  Top = 257
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MainRetail Maintenance'
  ClientHeight = 86
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbversao: TLabel
    Left = 230
    Top = 65
    Width = 70
    Height = 14
    Caption = 'Vers'#227'o: 1.0.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object frmCalcAvgCost: TBitBtn
    Left = 75
    Top = 25
    Width = 151
    Height = 25
    Caption = 'Calculate Avg Cost'
    TabOrder = 0
    OnClick = frmCalcAvgCostClick
  end
end
