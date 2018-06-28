inherited FrmModelAddSizeColor: TFrmModelAddSizeColor
  Left = 219
  Top = 128
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Model Vert. and Horiz itens'
  ClientHeight = 324
  ClientWidth = 421
  OnClose = FormClose
  DesignSize = (
    421
    324)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 11
    Top = 38
    Width = 347
    Height = 13
    Caption = 
      'Barcodes will be created with (IDModel, IDManufacture, IDHoriz.,' +
      ' IDVert.)'
  end
  inherited Panel1: TPanel
    Top = 283
    Width = 421
    inherited EspacamentoInferior: TPanel
      Width = 421
      inherited Panel3: TPanel
        Width = 421
      end
    end
    inherited hhh: TPanel
      Left = 155
      Width = 266
      inherited sbHelp: TSpeedButton
        Left = 19
        Width = 79
        Margin = -1
        Visible = False
      end
      inherited btClose: TButton
        Left = 181
        Width = 75
        ModalResult = 2
      end
      object btnSave: TBitBtn
        Left = 102
        Top = 3
        Width = 75
        Height = 31
        Caption = '&Save'
        Default = True
        ModalResult = 1
        TabOrder = 1
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 277
  end
  inherited EspacamentoDireito: TPanel
    Left = 418
    Height = 277
  end
  inherited EspacamentoSuperior: TPanel
    Width = 421
  end
  object Panel9: TPanel [5]
    Left = 7
    Top = 88
    Width = 194
    Height = 186
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    Caption = 'Panel10'
    Color = 14607076
    TabOrder = 4
    object pnlTitle6: TPanel
      Left = 0
      Top = 0
      Width = 194
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Horizontal'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object clbSize: TCheckListBox
      Left = 0
      Top = 16
      Width = 194
      Height = 170
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object Panel2: TPanel [6]
    Left = 216
    Top = 87
    Width = 193
    Height = 188
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    Caption = 'Panel10'
    Color = 14607076
    TabOrder = 5
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 193
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Vertical'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object clbColor: TCheckListBox
      Left = 0
      Top = 16
      Width = 193
      Height = 172
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object chkBarcodeCreate: TCheckBox [7]
    Left = 11
    Top = 17
    Width = 266
    Height = 17
    Caption = '&Automatically create barcodes'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = chkBarcodeCreateClick
  end
  object scSize: TSuperComboADO [8]
    Left = 8
    Top = 61
    Width = 150
    Height = 21
    TabOrder = 7
    LookUpSource = DM.dsLookUpSizeGroup
    IDLanguage = 0
    OnSelectItem = scSizeSelectItem
  end
  object btnSize: TButton [9]
    Left = 163
    Top = 61
    Width = 37
    Height = 21
    Caption = 'All'
    TabOrder = 8
    OnClick = btnSizeClick
  end
  object btnColor: TButton [10]
    Left = 373
    Top = 61
    Width = 37
    Height = 21
    Caption = 'All'
    TabOrder = 9
    OnClick = btnColorClick
  end
  object scColor: TSuperComboADO [11]
    Left = 218
    Top = 61
    Width = 150
    Height = 21
    TabOrder = 10
    LookUpSource = DM.dsLookUpColorGroup
    IDLanguage = 0
    OnSelectItem = scColorSelectItem
  end
  object quColor: TPowerADOQuery [12]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'C.IDColor, '#13#10#9'C.CodColor, '#13#10#9'C.Color'#13#10'FROM '#13#10#9'InvColor' +
      ' C (NOLOCK) '#13#10#9'LEFT OUTER JOIN Inv_ColorToGroup CG (NOLOCK) ON (' +
      'CG.IDColor = C.IDColor)'#13#10'WHERE'#13#10#9'C.Desativado = 0'#13#10#9'AND'#13#10#9'C.Hidd' +
      'en = 0'#13#10'GROUP BY'#13#10#9'C.IDColor, '#13#10#9'C.CodColor, '#13#10#9'C.Color'#13#10#13#10#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 357
    Top = 164
    object quColorIDColor: TIntegerField
      FieldName = 'IDColor'
      Origin = 'RETAIL.InvColor.IDColor'
    end
    object quColorCodColor: TStringField
      FieldName = 'CodColor'
      Origin = 'RETAIL.InvColor.CodColor'
      Size = 10
    end
    object quColorColor: TStringField
      FieldName = 'Color'
      Origin = 'RETAIL.InvColor.Color'
    end
  end
  object dsColor: TDataSource [13]
    DataSet = quColor
    Left = 357
    Top = 220
  end
  object quSize: TPowerADOQuery [14]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10'        S.IDSize,'#13#10'        S.CodSize,'#13#10'        S.SizeNam' +
      'e'#13#10'FROM'#13#10'        InvSize S (NOLOCK) '#13#10#9'LEFT OUTER JOIN Inv_SizeT' +
      'oGroup SG (NOLOCK) ON (SG.IDSize = S.IDSize)'#13#10'WHERE'#13#10'        S.D' +
      'esativado = 0'#13#10'        AND'#13#10'        S.Hidden = 0'#13#10'GROUP BY'#13#10'    ' +
      '    S.IDSize,'#13#10'        S.CodSize,'#13#10'        S.SizeName'#13#10#13#10#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 37
    Top = 144
    object quSizeIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object quSizeCodSize: TStringField
      FieldName = 'CodSize'
      Size = 10
    end
    object quSizeSizeName: TStringField
      FieldName = 'SizeName'
    end
  end
  object dsSize: TDataSource [15]
    DataSet = quSize
    Left = 37
    Top = 200
  end
  object spAddSize: TADOStoredProc [16]
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_AddSize;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDSize'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@BarcodeCreate'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 97
    Top = 157
  end
  object spAddColor: TADOStoredProc [17]
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_AddColor;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDColor'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@BarcodeCreate'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 267
    Top = 192
  end
  object quMatrix: TADOQuery [18]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDModelParent'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        SM.GroupID,'
      '        SM.IDModel,'
      '        C.Color,'
      '        S.SizeName,'
      '        SM.IDSize,'
      '        SM.IDColor,'
      '        SM.IDFabricante'
      'FROM'
      '        Model SM'
      '        LEFT OUTER JOIN InvColor C ON (SM.IDColor = C.IDColor)'
      '        LEFT OUTER JOIN InvSize S ON (SM.IDSize = S.IDSize)'
      'WHERE'
      '        SM.IDModelParent = :IDModelParent'
      'ORDER BY'
      '        S.SizeName,'
      '        C.Color'
      ''
      ' '
      ' ')
    Left = 230
    Top = 43
    object quMatrixIDModel: TAutoIncField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quMatrixColor: TStringField
      FieldName = 'Color'
    end
    object quMatrixSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quMatrixIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object quMatrixIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object quMatrixIDFabricante: TIntegerField
      FieldName = 'IDFabricante'
    end
    object quMatrixGroupID: TIntegerField
      FieldName = 'GroupID'
    end
  end
  object quBarcode: TADOQuery [19]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'BarCode'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'BC.IDBarCode,'
      #9'BC.Data,'
      #9'BC.IDModel,'
      #9'BC.BarcodeOrder'
      'FROM'
      #9'BarCode BC'
      'WHERE'
      #9'BC.IDBarCode = :BarCode'
      ' ')
    Left = 282
    Top = 42
    object quBarcodeIDBarCode: TStringField
      FieldName = 'IDBarCode'
      FixedChar = True
    end
    object quBarcodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quBarcodeData: TDateTimeField
      FieldName = 'Data'
    end
    object quBarcodeBarcodeOrder: TIntegerField
      FieldName = 'BarcodeOrder'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelAddSizeColor.sil'
  end
end
