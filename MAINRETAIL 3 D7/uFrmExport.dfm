inherited FrmExport: TFrmExport
  Left = 342
  Top = 258
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export data to'
  ClientHeight = 114
  ClientWidth = 198
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 23
    Top = 16
    Width = 66
    Height = 13
    Caption = 'Export data to'
  end
  inherited Panel1: TPanel
    Top = 73
    Width = 198
    inherited EspacamentoInferior: TPanel
      Width = 198
      inherited Panel3: TPanel
        Width = 198
      end
    end
    inherited hhh: TPanel
      Left = 61
      Width = 137
      inherited sbHelp: TSpeedButton
        Left = 32
        Top = 12
        Width = 69
        Height = 25
        Margin = 10
        Visible = False
      end
      object btnSave: TButton [1]
        Left = 0
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Export'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btnSaveClick
      end
      inherited btClose: TButton
        Left = 69
        TabOrder = 1
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 67
  end
  inherited EspacamentoDireito: TPanel
    Left = 195
    Height = 67
  end
  inherited EspacamentoSuperior: TPanel
    Width = 198
  end
  object cbxLanguage: TdxImageComboBox [5]
    Left = 22
    Top = 36
    Width = 154
    Height = 24
    Alignment = taLeftJustify
    ImageAlign = dxliLeft
    ItemHeight = 0
    ImageList = DMGlobal.imgSmall
    MultiLines = False
    VertAlignment = tvaCenter
    Items.Strings = (
      'Spreadsheet'
      'HTML'
      'XML'
      'Text')
    TabOrder = 4
    SaveStrings = (
      '45,1'
      '46,2'
      '93,3'
      '47,4'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmExport.sil'
  end
  object SD: TSaveDialog
    Left = 180
    Top = 20
  end
end
