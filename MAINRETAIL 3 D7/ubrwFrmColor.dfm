inherited brwFrmColor: TbrwFrmColor
  Left = 215
  Top = 167
  Caption = 'brwFrmColor'
  ClientHeight = 201
  ClientWidth = 369
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 369
    TabOrder = 5
    inherited Image1: TImage
      Width = 95
    end
    inherited EspacamentoSuperior: TPanel
      Width = 369
      inherited EEE: TPanel
        Width = 369
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 322
    end
  end
  inherited Panel1: TPanel
    Top = 160
    Width = 369
    TabOrder = 4
    inherited EspacamentoInferior: TPanel
      Width = 369
      inherited Panel3: TPanel
        Width = 369
      end
    end
    inherited hhh: TPanel
      Left = 219
      Width = 150
      inherited spHelp: TSpeedButton
        Left = 32
        Top = 33
        Width = 50
        Margin = 2
        Visible = False
      end
      inherited btCancel: TButton
        Left = 92
        Width = 54
      end
      inherited btClose: TButton
        Left = 32
        Width = 54
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 369
    Height = 36
    object Label3: TLabel [0]
      Left = 66
      Top = 10
      Width = 18
      Height = 13
      Caption = 'ID :'
      FocusControl = DBEdit3
    end
    inherited Panel4: TPanel
      Top = 34
      Width = 369
    end
    object DBEdit3: TDBEdit
      Tag = 2
      Left = 86
      Top = 7
      Width = 64
      Height = 21
      TabStop = False
      DataField = 'IDColor'
      DataSource = dsForm
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
    end
  end
  inherited pnlDetail: TPanel
    Top = 76
    Width = 363
    Height = 84
    TabOrder = 1
    object Label1: TLabel
      Left = 51
      Top = 9
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Code:'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 20
      Top = 48
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
      FocusControl = DBEdit2
    end
    object Label4: TLabel
      Left = 261
      Top = 46
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
      Left = 150
      Top = 9
      Width = 14
      Height = 18
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
    object DBEdit1: TDBEdit
      Left = 83
      Top = 7
      Width = 64
      Height = 21
      DataField = 'CodColor'
      DataSource = dsForm
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 83
      Top = 45
      Width = 176
      Height = 21
      DataField = 'Color'
      DataSource = dsForm
      TabOrder = 1
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 76
    Height = 84
    Color = 14607076
    TabOrder = 2
  end
  inherited EspacamentoDireito: TPanel
    Left = 366
    Top = 76
    Height = 84
    Color = 14607076
    TabOrder = 3
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_brwFrmColor.sil'
  end
  inherited dsForm: TDataSource
    Left = 221
    Top = 61
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT '#13#10#9'C.IDColor, '#13#10#9'C.CodColor, '#13#10#9'C.Color'#13#10'FROM '#13#10#9'InvColor' +
      ' C'#13#10'WHERE '#13#10#9'C.IDColor = :IDColor'
    Parameters = <
      item
        Name = 'IDColor'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 269
    Top = 62
    object quFormIDColor: TAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'IDColor'
    end
    object quFormCodColor: TStringField
      DisplayLabel = 'Code'
      FieldName = 'CodColor'
      Required = True
      Size = 5
    end
    object quFormColor: TStringField
      DisplayLabel = 'Description'
      FieldName = 'Color'
      Required = True
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDColor'
    UniqueFields.Strings = (
      'CodColor'
      'Color')
    Left = 326
    Top = 64
  end
end
