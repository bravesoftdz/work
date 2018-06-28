object FrmProgresso: TFrmProgresso
  Left = 291
  Top = 188
  Anchors = [akLeft, akTop, akRight]
  BorderStyle = bsDialog
  Caption = 'Processando...'
  ClientHeight = 141
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    294
    141)
  PixelsPerInch = 96
  TextHeight = 13
  object lblMSG: TLabel
    Left = 10
    Top = 20
    Width = 274
    Height = 26
    Anchors = [akLeft, akTop, akRight]
    Caption = 
      'Por favor aguarde, este processo poder'#39'a levar minutos dependend' +
      'o de quantas notas fiscais foram selecionadas.'
    WordWrap = True
  end
  object pbProgresso: TProgressBar
    Left = 10
    Top = 75
    Width = 278
    Height = 16
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btCancelar: TButton
    Left = 107
    Top = 110
    Width = 86
    Height = 25
    Anchors = [akTop]
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = btCancelarClick
  end
end
