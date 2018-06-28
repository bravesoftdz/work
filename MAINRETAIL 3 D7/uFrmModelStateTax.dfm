inherited FrmModelStateTax: TFrmModelStateTax
  Left = 319
  Top = 179
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Model State Tax'
  ClientHeight = 206
  ClientWidth = 367
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbState: TLabel [0]
    Left = 80
    Top = 65
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'State :'
  end
  object lbSaleTax: TLabel [1]
    Left = 66
    Top = 105
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sale Tax :'
  end
  object lblDepartmentRequired: TLabel [2]
    Left = 289
    Top = 59
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
  object Label1: TLabel [3]
    Left = 289
    Top = 100
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
  inherited Panel2: TPanel
    Width = 367
    inherited Image1: TImage
      Width = 140
    end
    inherited lblMenu: TLabel
      Left = 151
    end
    inherited EspacamentoSuperior: TPanel
      Width = 367
      inherited EEE: TPanel
        Width = 367
      end
    end
  end
  inherited Panel1: TPanel
    Top = 165
    Width = 367
    inherited EspacamentoInferior: TPanel
      Width = 367
      inherited Panel3: TPanel
        Width = 367
      end
    end
    inherited hhh: TPanel
      Left = 219
      Width = 148
      inherited btClose: TButton
        Left = 75
        OnClick = btCloseClick
      end
      object btOk: TButton
        Left = 4
        Top = 3
        Width = 66
        Height = 31
        Cancel = True
        Caption = '&Ok'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 125
  end
  inherited EspacamentoDireito: TPanel
    Left = 364
    Height = 125
  end
  object scEstado: TSuperComboADO [8]
    Left = 120
    Top = 60
    Width = 166
    Height = 21
    TabOrder = 4
    LookUpSource = DM.dsLookUpEstado
    IDLanguage = 0
  end
  object scSaleTax: TSuperComboADO [9]
    Left = 120
    Top = 100
    Width = 166
    Height = 21
    TabOrder = 5
    SpcWhereClause = 'OperationType = 1 AND SaleTaxType = 2'
    LookUpSource = DM.dsLookUpTaxCategory
    IDLanguage = 0
  end
  object cmdInsertStateTax: TADOCommand [10]
    CommandText = 
      'INSERT Inv_ModelStateTax (IDModel, IDEstado, IDTaxCategory)'#13#10'VAL' +
      'UES (:IDModel, :IDEstado, :IDTaxCategory) '#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModel'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDEstado'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDTaxCategory'
        Size = -1
        Value = Null
      end>
    Left = 30
    Top = 75
  end
  object quConsultStateTax: TADODataSet [11]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'ST.IDModel'#13#10'FROM'#13#10#9'Inv_ModelStateTax ST'#13#10'WHERE'#13#10#9'ST.IDM' +
      'odel = :IDModel'#13#10#9'AND'#13#10#9'ST.IDEstado = :IDEstado'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDEstado'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 3
        Value = Null
      end>
    Left = 35
    Top = 125
    object quConsultStateTaxIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelStateTax.sil'
  end
end
