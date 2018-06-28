inherited FchNCM: TFchNCM
  Left = 229
  Top = 200
  Caption = 'FchNCM'
  ClientHeight = 289
  ClientWidth = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 430
    inherited Image1: TImage
      Width = 156
    end
    inherited lblMenu: TLabel
      Left = 169
    end
    inherited EspacamentoSuperior: TPanel
      Width = 430
      inherited EEE: TPanel
        Width = 430
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 383
    end
  end
  inherited Panel1: TPanel
    Top = 248
    Width = 430
    inherited EspacamentoInferior: TPanel
      Width = 430
      inherited Panel3: TPanel
        Width = 430
      end
    end
    inherited hhh: TPanel
      Left = 209
    end
  end
  inherited pnlKey: TPanel
    Width = 430
    Height = 11
    inherited Panel4: TPanel
      Top = 9
      Width = 430
    end
  end
  inherited pnlDetail: TPanel
    Top = 51
    Width = 424
    Height = 197
    object Label1: TLabel
      Left = 39
      Top = 34
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 66
      Top = 7
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Code :'
      FocusControl = DBEdit7
    end
    object Label43: TLabel
      Left = 391
      Top = 4
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
    object Label2: TLabel
      Left = 392
      Top = 35
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
    object Label3: TLabel
      Left = 33
      Top = 112
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Internal Tax :'
      FocusControl = DBEdit1
    end
    object Label4: TLabel
      Left = 202
      Top = 110
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
    object Label5: TLabel
      Left = 31
      Top = 139
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'External Tax :'
      FocusControl = DBEdit2
    end
    object Label6: TLabel
      Left = 202
      Top = 137
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
    object DBMemo1: TDBMemo
      Left = 101
      Top = 35
      Width = 287
      Height = 67
      DataField = 'Descricao'
      DataSource = dsForm
      TabOrder = 1
    end
    object DBEdit7: TDBEdit
      Left = 101
      Top = 3
      Width = 287
      Height = 21
      DataField = 'Codigo'
      DataSource = dsForm
      TabOrder = 0
    end
    object DBEdit1: TDBEdit
      Left = 101
      Top = 108
      Width = 99
      Height = 21
      DataField = 'MVAInterno'
      DataSource = dsForm
      TabOrder = 2
    end
    object DBEdit2: TDBEdit
      Left = 101
      Top = 135
      Width = 99
      Height = 21
      DataField = 'MVAInterestadual'
      DataSource = dsForm
      TabOrder = 3
    end
    object DBCheckBox1: TDBCheckBox
      Left = 102
      Top = 164
      Width = 97
      Height = 17
      Caption = 'Apply tax'
      DataField = 'Incide'
      DataSource = dsForm
      TabOrder = 4
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 51
    Height = 197
  end
  inherited EspacamentoDireito: TPanel
    Left = 427
    Top = 51
    Height = 197
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchNCM.sil'
  end
  inherited dsForm: TDataSource
    Left = 31
  end
  inherited quForm: TPowerADOQuery
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'IDNCM,'#13#10#9'Codigo,'#13#10#9'Descricao,'#13#10#9'MVAInterno,'#13#10#9'MVAIntere' +
      'stadual,'#13#10#9'Incide'#13#10'FROM'#13#10#9'Inv_NCM (NOLOCK)'#13#10'WHERE'#13#10#9'IDNCM = :IDN' +
      'CM'#13#10
    Parameters = <
      item
        Name = 'IDNCM'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 31
    object quFormIDNCM: TIntegerField
      FieldName = 'IDNCM'
    end
    object quFormCodigo: TStringField
      FieldName = 'Codigo'
      Required = True
    end
    object quFormDescricao: TStringField
      FieldName = 'Descricao'
      Required = True
      Size = 255
    end
    object quFormMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Required = True
      DisplayFormat = '0.00'
      Precision = 38
    end
    object quFormMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Required = True
      DisplayFormat = '0.00'
      Precision = 38
    end
    object quFormIncide: TBooleanField
      FieldName = 'Incide'
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDNCM'
    UniqueFields.Strings = (
      'Codigo')
    Left = 31
  end
end
