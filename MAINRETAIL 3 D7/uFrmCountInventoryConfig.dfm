inherited FrmCountInventoryConfig: TFrmCountInventoryConfig
  Left = 397
  Top = 225
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Inventory Count'
  ClientHeight = 352
  ClientWidth = 365
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbNumItem: TLabel [0]
    Left = 12
    Top = 20
    Width = 81
    Height = 13
    Alignment = taRightJustify
    Caption = 'Number of Itens :'
  end
  object Label1: TLabel [1]
    Left = 37
    Top = 48
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'Print when :'
  end
  object Label9: TLabel [2]
    Left = 266
    Top = 16
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
  object Label2: TLabel [3]
    Left = 266
    Top = 45
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
  object btCheckAll: TSpeedButton [4]
    Left = 271
    Top = 71
    Width = 85
    Height = 22
    Caption = 'Check All'
    OnClick = btCheckAllClick
  end
  object btUnCheckAll: TSpeedButton [5]
    Left = 272
    Top = 96
    Width = 85
    Height = 22
    Caption = 'UnCheck All'
    OnClick = btUnCheckAllClick
  end
  inherited Panel1: TPanel
    Top = 311
    Width = 365
    inherited EspacamentoInferior: TPanel
      Width = 365
      inherited Panel3: TPanel
        Width = 365
      end
    end
    inherited hhh: TPanel
      Left = 116
      Width = 249
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 177
        OnClick = btCloseClick
      end
      object btOk: TButton
        Left = 109
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        TabOrder = 1
        OnClick = btOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 305
  end
  inherited EspacamentoDireito: TPanel
    Left = 362
    Height = 305
  end
  inherited EspacamentoSuperior: TPanel
    Width = 365
  end
  object clbCategory: TCheckListBox [10]
    Left = 13
    Top = 72
    Width = 253
    Height = 235
    ItemHeight = 13
    TabOrder = 4
  end
  object edtNumItem: TEdit [11]
    Left = 100
    Top = 16
    Width = 164
    Height = 21
    TabOrder = 5
    Text = 'edtNumItem'
  end
  object cmbPrint: TComboBox [12]
    Left = 100
    Top = 44
    Width = 165
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'Open Cash Reg'
    Items.Strings = (
      'Open Cash Reg'
      'Close Cash Reg')
  end
  object quCategory: TADOQuery [13]
    Connection = DM.ADODBConnect
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDGroup,'
      #9'Name'
      'FROM '
      #9'TabGroup (NOLOCK) '
      'WHERE'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0'
      'ORDER BY'
      #9'Name')
    Left = 36
    Top = 108
    object quCategoryIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quCategoryName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object cmdUpdPrint: TADOCommand [14]
    CommandText = 
      'UPDATE'#13#10#9'Sis_PropertyDomain'#13#10'SET'#13#10#9'Propertyvalue = :PropertyValu' +
      'e'#13#10'WHERE'#13#10#9'Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 36
    Top = 176
  end
  object cmdUpdCategory: TADOCommand [15]
    CommandText = 
      'UPDATE'#13#10#9'Sis_PropertyDomain'#13#10'SET'#13#10#9'PropertyValue = :PropertyValu' +
      'e'#13#10'WHERE'#13#10#9'Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 120
    Top = 176
  end
  object cmdUpdNumItens: TADOCommand [16]
    CommandText = 
      'UPDATE'#13#10#9'Sis_PropertyDomain'#13#10'SET'#13#10#9'Propertyvalue = :PropertyValu' +
      'e'#13#10'WHERE'#13#10#9'Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 216
    Top = 176
  end
  object quGetCategory: TADOQuery [17]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD (NOLOCK) '
      'WHERE'
      #9'PD.Property = :Property')
    Left = 120
    Top = 244
    object quGetCategoryPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object quGetPrint: TADOQuery [18]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD (NOLOCK) '
      'WHERE'
      #9'PD.Property = :Property')
    Left = 36
    Top = 244
    object quGetPrintPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object quGetNumber: TADOQuery [19]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD (NOLOCK) '
      'WHERE'
      #9'PD.Property = :Property')
    Left = 216
    Top = 244
    object quGetNumberPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmCountInventoryConfig.sil'
  end
end
