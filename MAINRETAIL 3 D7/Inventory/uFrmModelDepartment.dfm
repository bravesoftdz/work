inherited FrmModelDepartment: TFrmModelDepartment
  Left = 633
  Top = 591
  Width = 391
  Height = 149
  Caption = 'Department'
  PixelsPerInch = 96
  TextHeight = 13
  object lblDepartment: TLabel [0]
    Left = 17
    Top = 36
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Department :'
  end
  object lblDepartmentRequired: TLabel [1]
    Left = 309
    Top = 34
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
  inherited Panel1: TPanel
    Top = 81
    Width = 383
    inherited EspacamentoInferior: TPanel
      Width = 383
      inherited Panel3: TPanel
        Width = 383
      end
    end
    inherited hhh: TPanel
      Left = 169
      Width = 214
      inherited btClose: TButton
        Left = 144
        Cancel = True
        ModalResult = 2
      end
      object btOK: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 75
  end
  inherited EspacamentoDireito: TPanel
    Left = 380
    Height = 75
  end
  inherited EspacamentoSuperior: TPanel
    Width = 383
  end
  object cmbDepartment: TSuperComboADO [6]
    Left = 83
    Top = 32
    Width = 226
    Height = 21
    TabOrder = 4
    Text = 'cmbDepartment'
    LookUpSource = DM.dsLookupDepartment
    DropDownRows = 15
    IDLanguage = 0
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelDepartment.sil'
    Left = 16
    Top = 72
  end
  object quModelDepartment: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
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
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDDepartment'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'MD.IDDepartment'
      'FROM'
      #9'Inv_ModelDepartment MD (NOLOCK) '
      'WHERE'
      #9'MD.ModelID = :IDModel'
      #9'AND MD.StoreID = :IDStore'
      #9'AND MD.IDDepartment = :IDDepartment')
    Left = 92
    Top = 72
    object quModelDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
  end
end
