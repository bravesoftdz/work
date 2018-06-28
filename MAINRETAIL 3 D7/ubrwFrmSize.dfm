inherited brwFrmSize: TbrwFrmSize
  Left = 179
  Top = 160
  Caption = 'brwFrmSize'
  ClientHeight = 222
  ClientWidth = 340
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 340
    TabOrder = 1
    inherited Image1: TImage
      Width = 66
    end
    inherited EspacamentoSuperior: TPanel
      Width = 340
      inherited EEE: TPanel
        Width = 340
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 293
    end
  end
  inherited Panel1: TPanel
    Top = 181
    Width = 340
    TabOrder = 5
    inherited EspacamentoInferior: TPanel
      Width = 340
      inherited Panel3: TPanel
        Width = 340
      end
    end
    inherited hhh: TPanel
      Left = 222
      Width = 118
      inherited spHelp: TSpeedButton
        Left = 4
        Top = 32
        Width = 43
        Margin = 1
        Spacing = 1
        Visible = False
      end
      inherited btCancel: TButton
        Left = 61
        Width = 53
      end
      inherited btClose: TButton
        Left = 3
        Width = 54
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 340
    Height = 38
    object Label3: TLabel [0]
      Left = 71
      Top = 18
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID :'
      FocusControl = DBEdit3
    end
    inherited Panel4: TPanel
      Top = 36
      Width = 340
    end
    object DBEdit3: TDBEdit
      Tag = 2
      Left = 93
      Top = 15
      Width = 64
      Height = 21
      TabStop = False
      DataField = 'IDSize'
      DataSource = dsForm
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
    end
  end
  inherited pnlDetail: TPanel
    Top = 78
    Width = 334
    Height = 103
    TabOrder = 2
    object Label1: TLabel
      Left = 54
      Top = 22
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Code :'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 26
      Top = 63
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
      FocusControl = DBEdit2
    end
    object Label4: TLabel
      Left = 269
      Top = 62
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label5: TLabel
      Left = 156
      Top = 21
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object DBEdit2: TDBEdit
      Left = 90
      Top = 61
      Width = 176
      Height = 21
      DataField = 'SizeName'
      DataSource = dsForm
      TabOrder = 1
    end
    object DBEdit1: TDBEdit
      Left = 90
      Top = 20
      Width = 64
      Height = 21
      DataField = 'CodSize'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 78
    Height = 103
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 337
    Top = 78
    Height = 103
    TabOrder = 4
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_brwFrmSize.sil'
  end
  inherited dsForm: TDataSource
    Left = 291
    Top = 46
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10'        IDSize,'#13#10'        CodSize,'#13#10'        SizeName'#13#10'FRO' +
      'M'#13#10'        InvSize'#13#10'WHERE'#13#10'        IDSize = :IDSize'#13#10
    Parameters = <
      item
        Name = 'IDSize'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 296
    Top = 97
    object quFormIDSize: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDSize'
      Origin = 'RETAIL.InvSize.IDSize'
    end
    object quFormCodSize: TStringField
      DisplayLabel = 'Code'
      FieldName = 'CodSize'
      Origin = 'RETAIL.InvSize.CodSize'
      Required = True
      Size = 5
    end
    object quFormSizeName: TStringField
      DisplayLabel = 'Description'
      FieldName = 'SizeName'
      Origin = 'RETAIL.InvSize.SizeName'
      Required = True
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDSize'
    UniqueFields.Strings = (
      'CodSize'
      'SizeName')
    Left = 301
    Top = 149
  end
end
