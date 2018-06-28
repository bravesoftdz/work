inherited FchInventoryReason: TFchInventoryReason
  Left = 159
  Top = 184
  Caption = 'FchInventoryReason'
  ClientHeight = 155
  ClientWidth = 426
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 426
    inherited Image1: TImage
      Width = 152
    end
    inherited lblMenu: TLabel
      Left = 165
    end
    inherited EspacamentoSuperior: TPanel
      Width = 426
      inherited EEE: TPanel
        Width = 426
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 379
    end
  end
  inherited Panel1: TPanel
    Top = 114
    Width = 426
    inherited EspacamentoInferior: TPanel
      Width = 426
      inherited Panel3: TPanel
        Width = 426
      end
    end
    inherited hhh: TPanel
      Left = 205
    end
  end
  inherited pnlKey: TPanel
    Width = 426
    Height = 8
    inherited Panel4: TPanel
      Top = 6
      Width = 426
    end
  end
  inherited pnlDetail: TPanel
    Top = 48
    Width = 420
    Height = 66
    object Label1: TLabel
      Left = 33
      Top = 24
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Reason :'
      FocusControl = DBEdit1
    end
    object Label35: TLabel
      Left = 364
      Top = 22
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
    object DBEdit1: TDBEdit
      Left = 81
      Top = 21
      Width = 277
      Height = 21
      DataField = 'Reason'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 48
    Height = 66
  end
  inherited EspacamentoDireito: TPanel
    Left = 423
    Top = 48
    Height = 66
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchInventoryReason.sil'
  end
  inherited dsForm: TDataSource
    Left = 84
    Top = 52
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10'        IDMovReason,'#13#10'        Reason,'#13#10#9'System,'#13#10#9'Hidden' +
      ','#13#10#9'Desativado'#13#10'FROM'#13#10'        Inv_MovReason'#13#10'WHERE'#13#10#9'IDMovReason' +
      ' = :IDMovReason'#13#10
    Parameters = <
      item
        Name = 'IDMovReason'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 84
    Top = 108
    object quFormIDMovReason: TIntegerField
      FieldName = 'IDMovReason'
    end
    object quFormReason: TStringField
      FieldName = 'Reason'
      Required = True
      Size = 30
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
    end
    object quFormHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object quFormDesativado: TBooleanField
      FieldName = 'Desativado'
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDMovReason'
    Left = 128
    Top = 13
  end
end
