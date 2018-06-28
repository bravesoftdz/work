inherited FchHistoryType: TFchHistoryType
  Left = 181
  Top = 159
  Caption = 'FchHistoryType'
  ClientHeight = 196
  ClientWidth = 435
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 435
    inherited Image1: TImage
      Width = 161
    end
    inherited lblMenu: TLabel
      Left = 174
      Visible = False
    end
    inherited EspacamentoSuperior: TPanel
      Width = 435
      inherited EEE: TPanel
        Width = 435
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 388
    end
  end
  inherited Panel1: TPanel
    Top = 155
    Width = 435
    inherited EspacamentoInferior: TPanel
      Width = 435
      inherited Panel3: TPanel
        Width = 435
      end
    end
    inherited hhh: TPanel
      Left = 214
    end
  end
  inherited pnlKey: TPanel
    Width = 435
    Height = 26
    inherited Panel4: TPanel
      Top = 24
      Width = 435
    end
  end
  inherited pnlDetail: TPanel
    Top = 66
    Width = 429
    Height = 89
    object Label1: TLabel
      Left = 44
      Top = 33
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'History Type :'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 363
      Top = 29
      Width = 14
      Height = 19
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 129
      Top = 28
      Width = 231
      Height = 21
      DataField = 'HistoryType'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 66
    Height = 89
  end
  inherited EspacamentoDireito: TPanel
    Left = 432
    Top = 66
    Height = 89
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchHistoryType.sil'
  end
  inherited dsForm: TDataSource
    Left = 26
    Top = 71
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10'        IDHistoryType,'#13#10'        HistoryType'#13#10'FROM'#13#10'     ' +
      '   HistoryType'#13#10'WHERE'#13#10'        IDHistoryType = :IDHistoryType'
    Parameters = <
      item
        Name = 'IDHistoryType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 26
    Top = 127
    object quFormIDHistoryType: TIntegerField
      FieldName = 'IDHistoryType'
    end
    object quFormHistoryType: TStringField
      FieldName = 'HistoryType'
      Required = True
      Size = 255
    end
  end
  inherited FormConfig: TFormConfig
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDHistoryType'
    Left = 111
    Top = 94
  end
end
