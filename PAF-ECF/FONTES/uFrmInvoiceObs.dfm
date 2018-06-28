inherited FrmInvoiceObs: TFrmInvoiceObs
  Left = 257
  Top = 171
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Obs'
  ClientHeight = 155
  ClientWidth = 230
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 16
    Width = 25
    Height = 13
    Caption = 'OBS:'
  end
  inherited pnlButtom: TPanel
    Top = 114
    Width = 230
    TabOrder = 1
    inherited lblUserName: TLabel
      Visible = False
    end
    inherited Label15: TLabel
      Visible = False
    end
    inherited hhh: TPanel
      Left = 21
      Width = 209
      inherited spHelp: TSpeedButton
        Left = -1
        Top = 7
        Visible = False
      end
      inherited btClose: TButton
        Left = 141
        ModalResult = 2
      end
      object btnOK: TButton
        Left = 71
        Top = 7
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
    Top = 112
    Width = 230
    TabOrder = 2
  end
  object memOBS: TMemo [3]
    Left = 37
    Top = 16
    Width = 185
    Height = 89
    MaxLength = 155
    TabOrder = 0
    WantReturns = False
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmInvoiceObs.sil'
  end
end
