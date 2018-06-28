inherited SisMunicipio: TSisMunicipio
  Caption = 'SisMunicipio'
  ClientHeight = 217
  ClientWidth = 411
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [0]
    Left = 36
    Top = 108
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Description :'
    FocusControl = DBEdit2
  end
  object Label6: TLabel [1]
    Left = 352
    Top = 106
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label1: TLabel [2]
    Left = 63
    Top = 68
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'Code :'
    FocusControl = DBEdit1
  end
  object Label3: TLabel [3]
    Left = 351
    Top = 66
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 140
    TabOrder = 2
  end
  inherited EspacamentoDireito: TPanel
    Left = 408
    Height = 140
    TabOrder = 3
  end
  inherited EspacamentoSuperior: TPanel
    Width = 411
    TabOrder = 4
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 174
    Width = 411
    TabOrder = 5
  end
  inherited pnlPBarra: TPanel
    Top = 180
    Width = 411
    TabOrder = 6
    inherited pnlPBarraRightAlign: TPanel
      Left = 142
    end
    inherited pnlPLinha: TPanel
      Width = 411
    end
  end
  inherited pnlPTitulo: TPanel
    Width = 411
    TabOrder = 7
    inherited lblPTituloShadow: TLabel
      Width = 112
      Caption = 'Municipio'
    end
    inherited lblPTitulo: TLabel
      Width = 112
      Caption = 'Municipio'
    end
    inherited pnlAutoInc: TPanel
      Left = 377
    end
  end
  object DBEdit2: TDBEdit [10]
    Left = 101
    Top = 105
    Width = 251
    Height = 21
    DataField = 'Descricao'
    DataSource = dsForm
    TabOrder = 1
  end
  object DBEdit1: TDBEdit [11]
    Left = 100
    Top = 65
    Width = 251
    Height = 21
    DataField = 'Codigo'
    DataSource = dsForm
    TabOrder = 0
  end
  inherited bmMDI: TdxBarManager [12]
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      0
      0)
  end
  inherited ilSmallButtons: TImageList [13]
  end
  inherited PrintFch: TPrintDialog [14]
  end
  inherited dsForm: TDataSource [15]
    Left = 246
    Top = 51
  end
  inherited quForm: TPowerADOQuery [16]
    CommandText = 
      'SELECT'#13#10#9'IDMunicipio,'#13#10#9'Codigo,'#13#10#9'Descricao'#13#10'FROM'#13#10#9'Sis_Municipi' +
      'o'#13#10'WHERE'#13#10#9'IDMunicipio = :IDMunicipio'
    Parameters = <
      item
        Name = 'IDMunicipio'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 301
    Top = 47
    object quFormIDMunicipio: TIntegerField
      FieldName = 'IDMunicipio'
    end
    object quFormCodigo: TStringField
      FieldName = 'Codigo'
      Required = True
    end
    object quFormDescricao: TStringField
      FieldName = 'Descricao'
      Required = True
      Size = 100
    end
  end
  inherited FormConfig: TFormConfig [17]
    AutoIncField = 'IDMunicipio'
    Left = 366
    Top = 49
  end
  inherited siLang: TsiLangRT [18]
    StorageFile = 'OM_SisMunicipio.sil'
  end
end
