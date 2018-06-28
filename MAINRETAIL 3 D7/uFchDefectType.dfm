inherited FchDefectType: TFchDefectType
  Left = 151
  Top = 134
  Caption = 'FchDefectType'
  ClientHeight = 216
  ClientWidth = 415
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 415
    TabOrder = 3
    inherited Image1: TImage
      Width = 141
    end
    inherited lblMenu: TLabel
      Left = 154
    end
    inherited EspacamentoSuperior: TPanel
      Width = 415
      inherited EEE: TPanel
        Width = 415
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 368
    end
  end
  inherited Panel1: TPanel
    Top = 175
    Width = 415
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 415
      inherited Panel3: TPanel
        Width = 415
      end
    end
    inherited hhh: TPanel
      Left = 194
      inherited spHelp: TSpeedButton
        Visible = False
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 415
    Height = 25
    TabOrder = 1
    inherited Panel4: TPanel
      Top = 23
      Width = 415
    end
  end
  inherited pnlDetail: TPanel
    Top = 65
    Width = 409
    Height = 110
    TabOrder = 0
    object Label1: TLabel
      Left = 38
      Top = 45
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Defect Type :'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 343
      Top = 41
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
      Left = 109
      Top = 40
      Width = 231
      Height = 21
      DataField = 'DefectType'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 65
    Height = 110
  end
  inherited EspacamentoDireito: TPanel
    Left = 412
    Top = 65
    Height = 110
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchDefectType.sil'
  end
  inherited dsForm: TDataSource
    Left = 68
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDDefectType,'#13#10#9'DefectType'#13#10'FROM'#13#10#9'Inv_DefectType'#13#10'WHER' +
      'E'#13#10#9'IDDefectType = :IDDefectType'
    Parameters = <
      item
        Name = 'IDDefectType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 68
    object quFormIDDefectType: TIntegerField
      FieldName = 'IDDefectType'
    end
    object quFormDefectType: TStringField
      FieldName = 'DefectType'
      Required = True
      Size = 30
    end
  end
  inherited FormConfig: TFormConfig
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDDefectType'
    Left = 68
  end
end
