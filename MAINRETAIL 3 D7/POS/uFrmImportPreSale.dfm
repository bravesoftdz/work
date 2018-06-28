inherited FrmImportPreSale: TFrmImportPreSale
  Left = 288
  Top = 192
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import Hold'
  ClientHeight = 169
  ClientWidth = 291
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbHoldNum: TLabel [0]
    Left = 48
    Top = 56
    Width = 53
    Height = 20
    Alignment = taRightJustify
    Caption = 'Hold #'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlButtom: TPanel
    Top = 128
    Width = 291
    TabOrder = 1
    inherited lblUserName: TLabel
      Visible = False
    end
    inherited Label15: TLabel
      Visible = False
    end
    inherited hhh: TPanel
      Left = 77
      Width = 214
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 141
        ModalResult = 2
      end
      object btnOK: TButton
        Left = 70
        Top = 6
        Width = 66
        Height = 31
        Caption = 'OK'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 126
    Width = 291
    TabOrder = 2
  end
  object edtHold: TEdit [3]
    Left = 116
    Top = 51
    Width = 121
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmImportPreSale.sil'
  end
end
