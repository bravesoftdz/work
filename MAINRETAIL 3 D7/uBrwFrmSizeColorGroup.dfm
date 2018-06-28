inherited brwFrmSizeColorGroup: TbrwFrmSizeColorGroup
  Left = 195
  Top = 74
  Caption = 'brwFrmSizeColorGroup'
  ClientHeight = 373
  ClientWidth = 388
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 388
    inherited Image1: TImage
      Width = 114
    end
    inherited lblMenu: TLabel
      Left = 127
    end
    inherited EspacamentoSuperior: TPanel
      Width = 388
      inherited EEE: TPanel
        Width = 388
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 341
    end
  end
  inherited Panel1: TPanel
    Top = 332
    Width = 388
    inherited EspacamentoInferior: TPanel
      Width = 388
      inherited Panel3: TPanel
        Width = 388
      end
    end
    inherited hhh: TPanel
      Left = 167
    end
  end
  inherited pnlKey: TPanel
    Width = 388
    object Label2: TLabel [0]
      Left = 64
      Top = 9
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID :'
    end
    inherited Panel4: TPanel
      Width = 388
    end
    object DBEdit2: TDBEdit
      Left = 86
      Top = 7
      Width = 121
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
  end
  inherited pnlDetail: TPanel
    Width = 382
    Height = 252
    object lblDescription: TLabel
      Left = 44
      Top = 11
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'Group :'
    end
    object btAddCredit: TSpeedButton
      Left = 299
      Top = 72
      Width = 80
      Height = 24
      Caption = 'A&dd'
      Flat = True
      Glyph.Data = {
        B6020000424DB60200000000000036000000280000000D000000100000000100
        18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
        D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
        DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
        D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
        FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
        7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
        FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
        E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
        EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
        FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
        8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
        FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
        F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
        FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
        FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
        7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
        F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
        E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
        9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
      Margin = 5
      OnClick = btAddCreditClick
    end
    object btDelCredit: TSpeedButton
      Left = 299
      Top = 96
      Width = 80
      Height = 24
      Caption = '&Remove'
      Flat = True
      Glyph.Data = {
        06030000424D06030000000000003600000028000000100000000F0000000100
        180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
        2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
        EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
        2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
        ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
        00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
        30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
        31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
        00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
        0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
        FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
        0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF}
      Margin = 5
      OnClick = btDelCreditClick
    end
    object lblColor: TLabel
      Left = 20
      Top = 44
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object Label18: TLabel
      Left = 299
      Top = 9
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
    object edtDescription: TDBEdit
      Left = 83
      Top = 8
      Width = 213
      Height = 21
      DataField = 'Description'
      DataSource = dsForm
      TabOrder = 0
    end
    object grdColor: TSMDBGrid
      Left = 85
      Top = 72
      Width = 211
      Height = 164
      BorderStyle = bsNone
      DataSource = dsColor
      FixedColor = 14607076
      Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 3
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Flat = True
      Groupings = <>
      GridStyle.Style = gsCustom
      GridStyle.OddColor = clWindow
      GridStyle.EvenColor = 14607076
      FooterColor = clBtnFace
      ExOptions = [eoAutoWidth, eoKeepSelection]
      RegistryKey = 'Software\Scalabium'
      RegistrySection = 'SMDBGrid'
      WidthOfIndicator = 11
      DefaultRowHeight = 17
      ScrollBars = ssVertical
      ColCount = 2
      RowCount = 2
      Columns = <
        item
          Expanded = False
          FieldName = 'IDSizeColorGroup'
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Color'
          Width = 196
          Visible = True
          FooterType = ftCustom
        end>
    end
    object scColor: TSuperComboADO
      Left = 83
      Top = 40
      Width = 214
      Height = 21
      TabOrder = 1
      LookUpSource = DM.dsLookUpColor
      IDLanguage = 0
    end
    object scSize: TSuperComboADO
      Left = 83
      Top = 40
      Width = 214
      Height = 21
      TabOrder = 2
      LookUpSource = DM.dsLookUpSize
      IDLanguage = 0
    end
    object grdSize: TSMDBGrid
      Left = 85
      Top = 72
      Width = 211
      Height = 164
      BorderStyle = bsNone
      DataSource = dsSize
      FixedColor = 14607076
      Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 4
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Flat = True
      Groupings = <>
      GridStyle.Style = gsCustom
      GridStyle.OddColor = clWindow
      GridStyle.EvenColor = 14607076
      FooterColor = clBtnFace
      ExOptions = [eoAutoWidth, eoKeepSelection]
      RegistryKey = 'Software\Scalabium'
      RegistrySection = 'SMDBGrid'
      WidthOfIndicator = 11
      DefaultRowHeight = 17
      ScrollBars = ssVertical
      ColCount = 2
      RowCount = 2
      Columns = <
        item
          Expanded = False
          FieldName = 'IDSizeColorGroup'
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SizeName'
          Width = 196
          Visible = True
          FooterType = ftCustom
        end>
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 252
  end
  inherited EspacamentoDireito: TPanel
    Left = 385
    Height = 252
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_BrwFrmSizeColorGroup.sil'
  end
  inherited dsForm: TDataSource
    Left = 132
    Top = 51
  end
  inherited quForm: TPowerADOQuery
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'IDSizeColorGroup,'#13#10#9'Description,'#13#10#9'IsColor,'#13#10#9'System,'#13#10 +
      #9'Hidden,'#13#10#9'Desativado'#13#10'FROM'#13#10#9'Inv_SizeColorGroup'#13#10'WHERE'#13#10#9'IDSize' +
      'ColorGroup = :IDSizeColorGroup'#13#10
    Parameters = <
      item
        Name = 'IDSizeColorGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 132
    Top = 107
    object quFormIDSizeColorGroup: TIntegerField
      DisplayLabel = 'Group Code'
      FieldName = 'IDSizeColorGroup'
    end
    object quFormDescription: TStringField
      DisplayLabel = 'Group Description'
      FieldName = 'Description'
      Required = True
      Size = 50
    end
    object quFormIsColor: TBooleanField
      FieldName = 'IsColor'
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
  object quInvColorToGroup: TADOQuery [9]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDSizeColorGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'Inv_ColorToGroup.IDSizeColorGroup,'
      #9'Inv_ColorToGroup.IDColor,'
      #9'InvColor.Color'
      'FROM'
      #9'Inv_ColorToGroup (NOLOCK)'
      
        #9'INNER JOIN InvColor (NOLOCK) ON (Inv_ColorToGroup.IDColor = Inv' +
        'Color.IDColor)'
      'WHERE'
      #9'Inv_ColorToGroup.IDSizeColorGroup = :IDSizeColorGroup'
      #9'AND InvColor.Hidden = 0'
      #9'AND InvColor.Desativado = 0'
      '')
    Left = 191
    Top = 198
    object quInvColorToGroupIDSizeColorGroup: TIntegerField
      FieldName = 'IDSizeColorGroup'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object quInvColorToGroupIDColor: TIntegerField
      FieldName = 'IDColor'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object quInvColorToGroupColor: TStringField
      FieldName = 'Color'
    end
  end
  object quInvSizeToGroup: TADOQuery [10]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDSizeColorGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'Inv_SizeToGroup.IDSizeColorGroup,'
      #9'Inv_SizeToGroup.IDSize,'
      #9'InvSize.SizeName'
      'FROM'
      #9'Inv_SizeToGroup (NOLOCK)'
      
        #9'INNER JOIN InvSize (NOLOCK) ON (Inv_SizeToGroup.IDSize = InvSiz' +
        'e.IDSize)'
      'WHERE'
      #9'Inv_SizeToGroup.IDSizeColorGroup = :IDSizeColorGroup'
      #9'AND InvSize.Hidden = 0'
      #9'AND InvSize.Desativado = 0')
    Left = 191
    Top = 262
    object quInvSizeToGroupIDSizeColorGroup: TIntegerField
      FieldName = 'IDSizeColorGroup'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quInvSizeToGroupIDSize: TIntegerField
      FieldName = 'IDSize'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quInvSizeToGroupSizeName: TStringField
      DisplayLabel = 'Size'
      FieldName = 'SizeName'
    end
  end
  object dsColor: TDataSource [11]
    DataSet = quInvColorToGroup
    Left = 116
    Top = 198
  end
  object dsSize: TDataSource [12]
    DataSet = quInvSizeToGroup
    Left = 116
    Top = 263
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDSizeColorGroup'
    RequiredFields.Strings = (
      'Description')
    DependentTables.Strings = (
      'Inv_SizeToGroup'
      'Inv_ColorToGroup')
    DependentTableKeys.Strings = (
      'IDSizeColorGroup'
      'IDSizeColorGroup')
    Left = 22
    Top = 49
  end
end
