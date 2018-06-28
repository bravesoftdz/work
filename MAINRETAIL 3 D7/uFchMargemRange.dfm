inherited FchMargemRange: TFchMargemRange
  Left = 466
  Top = 200
  Caption = 'FchMargemRange'
  ClientHeight = 240
  ClientWidth = 428
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 428
    inherited Image1: TImage
      Width = 154
    end
    inherited lblMenu: TLabel
      Left = 167
    end
    inherited EspacamentoSuperior: TPanel
      Width = 428
      inherited EEE: TPanel
        Width = 428
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 381
    end
  end
  inherited Panel1: TPanel
    Top = 199
    Width = 428
    inherited EspacamentoInferior: TPanel
      Width = 428
      inherited Panel3: TPanel
        Width = 428
      end
    end
    inherited hhh: TPanel
      Left = 207
    end
  end
  inherited pnlKey: TPanel
    Width = 428
    inherited Panel4: TPanel
      Width = 428
    end
  end
  inherited pnlDetail: TPanel
    Width = 422
    Height = 119
    object Label1: TLabel
      Left = 155
      Top = 20
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'MinValue:'
      FocusControl = dbMinValue
    end
    object Label2: TLabel
      Left = 150
      Top = 50
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'MaxValue:'
      FocusControl = dbMaxValue
    end
    object Label3: TLabel
      Left = 142
      Top = 80
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = 'Percentage:'
      FocusControl = dbPercentage
    end
    object dbMinValue: TDBEdit
      Left = 205
      Top = 15
      Width = 71
      Height = 21
      DataField = 'MinValue'
      DataSource = dsForm
      TabOrder = 0
      OnExit = dbMinValueExit
    end
    object dbMaxValue: TDBEdit
      Left = 205
      Top = 45
      Width = 71
      Height = 21
      DataField = 'MaxValue'
      DataSource = dsForm
      TabOrder = 1
      OnExit = dbMaxValueExit
    end
    object dbPercentage: TDBEdit
      Left = 205
      Top = 75
      Width = 71
      Height = 21
      DataField = 'Percentage'
      DataSource = dsForm
      TabOrder = 2
      OnExit = dbPercentageExit
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 119
  end
  inherited EspacamentoDireito: TPanel
    Left = 425
    Height = 119
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchMargemRange.sil'
  end
  inherited dsForm: TDataSource
    Left = 371
    Top = 91
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDMargemTableRange,'#13#10#9'IDMargemTable,'#13#10#9'MinValue,'#13#10#9'MaxV' +
      'alue,'#13#10#9'Percentage'#13#10'FROM'#13#10#9'MargemTableRange'#13#10'WHERE'#13#10#9'IDMargemTab' +
      'leRange = :IDMargemTableRange'
    Parameters = <
      item
        Name = 'IDMargemTableRange'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 371
    object quFormIDMargemTableRange: TIntegerField
      FieldName = 'IDMargemTableRange'
    end
    object quFormIDMargemTable: TIntegerField
      FieldName = 'IDMargemTable'
    end
    object quFormMinValue: TBCDField
      FieldName = 'MinValue'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormMaxValue: TBCDField
      FieldName = 'MaxValue'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormPercentage: TFloatField
      FieldName = 'Percentage'
      Required = True
      DisplayFormat = '#,##0.00'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDMargemTableRange'
    Left = 371
    Top = 169
  end
end
