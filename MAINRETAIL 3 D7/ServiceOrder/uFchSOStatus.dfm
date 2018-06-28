inherited FchSOStatus: TFchSOStatus
  Left = 210
  Top = 257
  Caption = 'SO Status'
  ClientHeight = 195
  ClientWidth = 440
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 440
    inherited Image1: TImage
      Width = 166
    end
    inherited lblMenu: TLabel
      Left = 179
    end
    inherited EspacamentoSuperior: TPanel
      Width = 440
      inherited EEE: TPanel
        Width = 440
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 393
    end
  end
  inherited Panel1: TPanel
    Top = 154
    Width = 440
    inherited EspacamentoInferior: TPanel
      Width = 440
      inherited Panel3: TPanel
        Width = 440
      end
    end
    inherited hhh: TPanel
      Left = 219
    end
  end
  inherited pnlKey: TPanel
    Width = 440
    Height = 3
    inherited Panel4: TPanel
      Top = 1
      Width = 440
    end
  end
  inherited pnlDetail: TPanel
    Top = 43
    Width = 434
    Height = 111
    object Label5: TLabel
      Left = 51
      Top = 28
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = 'Status :'
      FocusControl = DBEdit2
    end
    object Label6: TLabel
      Left = 399
      Top = 26
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
    object Label13: TLabel
      Left = 117
      Top = 64
      Width = 57
      Height = 13
      Caption = 'Status color'
    end
    object DBEdit2: TDBEdit
      Left = 92
      Top = 25
      Width = 304
      Height = 21
      DataField = 'SOStatus'
      DataSource = dsForm
      TabOrder = 0
    end
    object pnlMenuHighlight: TPanel
      Left = 93
      Top = 61
      Width = 18
      Height = 19
      Cursor = crHandPoint
      TabOrder = 1
      OnClick = pnlMenuHighlightClick
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 43
    Height = 111
  end
  inherited EspacamentoDireito: TPanel
    Left = 437
    Top = 43
    Height = 111
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchSOStatus.sil'
  end
  inherited dsForm: TDataSource
    Left = 76
    Top = 21
  end
  object CD: TColorDialog [8]
    Left = 204
    Top = 107
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforePost = quFormBeforePost
    CommandText = 
      'SELECT '#13#10#9'IDSOStatus,'#13#10#9'SOStatus,'#13#10#9'Color'#13#10'FROM '#13#10#9'Ser_SOStatus'#13 +
      #10'WHERE'#13#10#9'IDSOStatus = :IDSOStatus'#13#10
    Parameters = <
      item
        Name = 'IDSOStatus'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 146
    Top = 22
    object quFormIDSOStatus: TIntegerField
      FieldName = 'IDSOStatus'
    end
    object quFormSOStatus: TStringField
      FieldName = 'SOStatus'
      Required = True
      Size = 50
    end
    object quFormColor: TStringField
      FieldName = 'Color'
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDSOStatus'
    Left = 221
    Top = 24
  end
end
