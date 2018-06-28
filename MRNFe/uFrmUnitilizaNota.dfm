object FrmUnitilizaNota: TFrmUnitilizaNota
  Left = 352
  Top = 285
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Unitilizar Nota'
  ClientHeight = 282
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 58
    Top = 248
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 138
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 8
    OnClick = Button2Click
  end
  object edtAno: TLabeledEdit
    Left = 85
    Top = 45
    Width = 121
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Ano :'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object edtModelo: TLabeledEdit
    Left = 85
    Top = 73
    Width = 121
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Modelo :'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object edtSerie: TLabeledEdit
    Left = 85
    Top = 101
    Width = 121
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Serie :'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object edtNumInicial: TLabeledEdit
    Left = 85
    Top = 130
    Width = 121
    Height = 21
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = 'N'#250'mero Inicial :'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object edtNumFim: TLabeledEdit
    Left = 85
    Top = 160
    Width = 121
    Height = 21
    EditLabel.Width = 68
    EditLabel.Height = 13
    EditLabel.Caption = 'N'#250'mero Final :'
    LabelPosition = lpLeft
    TabOrder = 5
  end
  object edtJustificativa: TLabeledEdit
    Left = 85
    Top = 190
    Width = 121
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'Justificativa :'
    LabelPosition = lpLeft
    TabOrder = 6
  end
  object edtCNPJ: TLabeledEdit
    Left = 85
    Top = 15
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'CNPJ :'
    LabelPosition = lpLeft
    TabOrder = 0
  end
end
