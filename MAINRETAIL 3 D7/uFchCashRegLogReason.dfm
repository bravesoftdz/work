inherited FchCashRegLogReason: TFchCashRegLogReason
  Left = 336
  Top = 258
  Caption = 'FchCashRegLogReason'
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
    Height = 5
    inherited Panel4: TPanel
      Top = 3
      Width = 426
    end
  end
  inherited pnlDetail: TPanel
    Top = 45
    Width = 420
    Height = 69
    object lblReason: TLabel
      Left = 33
      Top = 24
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Reason :'
      FocusControl = edtReason
    end
    object edtReason: TDBEdit
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
    Top = 45
    Height = 69
  end
  inherited EspacamentoDireito: TPanel
    Left = 423
    Top = 45
    Height = 69
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchCashRegLogReason.sil'
  end
  inherited dsForm: TDataSource
    Left = 236
    Top = 68
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDCashRegLogReason,'#13#10#9'Reason,'#13#10#9'System,'#13#10#9'Hidden,'#13#10#9'Des' +
      'ativado'#13#10'FROM'#13#10#9'CashRegLogReason'#13#10'WHERE'#13#10#9'IDCashRegLogReason = :' +
      'IDCashRegLogReason'#13#10
    Parameters = <
      item
        Name = 'IDCashRegLogReason'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 236
    Top = 20
    object quFormIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object quFormReason: TStringField
      FieldName = 'Reason'
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
    AutoIncField = 'IDCashRegLogReason'
    Left = 140
    Top = 17
  end
end
