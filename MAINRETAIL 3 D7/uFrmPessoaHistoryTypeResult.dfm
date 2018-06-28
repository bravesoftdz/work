inherited FrmPessoaHistoryTypeResult: TFrmPessoaHistoryTypeResult
  Left = 227
  Top = 209
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'History Result'
  ClientHeight = 202
  ClientWidth = 397
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 50
    Top = 76
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'Result :'
  end
  object lbHasBairro: TLabel [1]
    Left = 296
    Top = 73
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [2]
    Left = 59
    Top = 120
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'Color :'
  end
  inherited Panel2: TPanel
    Width = 397
    inherited Image3: TImage [0]
    end
    inherited imgTopIni: TImage [1]
    end
    inherited Image1: TImage [2]
      Width = 170
    end
    inherited lblMenu: TLabel [3]
      Left = 181
    end
    inherited lblSubMenu: TLabelEffect [4]
    end
    inherited imgMenu: TImage [5]
    end
    inherited EspacamentoSuperior: TPanel
      Width = 397
      inherited EEE: TPanel
        Width = 397
      end
    end
  end
  inherited Panel1: TPanel
    Top = 161
    Width = 397
    inherited EspacamentoInferior: TPanel
      Width = 397
      inherited Panel3: TPanel
        Width = 397
      end
    end
    inherited hhh: TPanel
      Left = 236
      Width = 161
      inherited btClose: TButton
        Left = 90
        Cancel = True
        ModalResult = 2
      end
      object btnSave: TButton
        Left = 19
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 121
  end
  inherited EspacamentoDireito: TPanel
    Left = 394
    Height = 121
  end
  object edtResult: TEdit [7]
    Left = 96
    Top = 72
    Width = 197
    Height = 21
    MaxLength = 30
    TabOrder = 4
  end
  object pnlMenuHighlight: TPanel [8]
    Left = 97
    Top = 117
    Width = 18
    Height = 19
    Cursor = crHandPoint
    TabOrder = 5
    OnClick = pnlMenuHighlightClick
  end
  object CD: TColorDialog [9]
    Left = 330
    Top = 66
  end
  object cmdInsResult: TADOCommand [10]
    CommandText = 
      'INSERT Mnt_PessoaHistoryResult (IDPessoaHistoryResult, IDPessoaH' +
      'istoryType, PessoaHistoryResult, ResultColor)'#13#10'VALUES (:IDPessoa' +
      'HistoryResult, :IDPessoaHistoryType, :PessoaHistoryResult, :Resu' +
      'ltColor)'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPessoaHistoryResult'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoaHistoryType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'PessoaHistoryResult'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'ResultColor'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 328
    Top = 116
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPessoaHistoryTypeResult.sil'
  end
end
