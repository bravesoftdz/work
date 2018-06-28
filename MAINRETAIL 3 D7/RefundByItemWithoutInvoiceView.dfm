object frmRefundByItemWithoutInvoiceView: TfrmRefundByItemWithoutInvoiceView
  Left = 1281
  Top = 531
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Refund by Item without invoice'
  ClientHeight = 152
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object selectAction: TcxRadioGroup
    Left = 5
    Top = 31
    Width = 321
    Height = 76
    Properties.Caption = ' Select your action :'
    Properties.Items = <
      item
        Caption = 'Send to shelf'
      end
      item
        Caption = 'Send to vendor'
      end>
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'MS Sans Serif'
    Style.Font.Style = []
    TabOrder = 0
  end
  object cancelAction: TcxButton
    Left = 168
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = cancelActionClick
  end
  object applyAction: TcxButton
    Left = 254
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Apply'
    Default = True
    TabOrder = 2
    OnClick = applyActionClick
  end
  object itemMessage: TStaticText
    Left = 15
    Top = 5
    Width = 66
    Height = 17
    Caption = 'itemMessage'
    TabOrder = 3
  end
end
