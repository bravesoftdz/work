inherited SubSendFax: TSubSendFax
  Left = 234
  Top = 183
  BorderStyle = bsSingle
  Caption = 'SubSendFax'
  ClientHeight = 50
  ClientWidth = 178
  Color = 14607076
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lbFormType: TLabel [0]
    Left = 0
    Top = 0
    Width = 178
    Height = 13
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'lbFormType'
    Color = clAppWorkSpace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 13
    Width = 178
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object sbEmailFile: TSpeedButton
      Left = 0
      Top = -1
      Width = 55
      Height = 22
      Hint = 'Send by e-mail '
      Caption = 'E-mail'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFC4CBCFAEB5B98C919474787A777C7F92989BB1B8BBC4CCD0C0C8CCB7BE
        C2C0C8CCFF00FFFF00FFC0C8CCAEB4B8A3A9AC979DA0987552BA6829A9723661
        534956595B7C81849EA4A7949A9C7E848691979AAEB4B8C0C8CCAEB4B8757A7C
        635F579D6627E97A0CFF7824FF940DF4A2388A684E494C4D5D6062B2795B4649
        4A4F5354757A7CAEB4B88A5855835151E4994DE98313D28F6AF4A33AFF8D0DFF
        9F17FFBA63A77F63835151FF9605835151835151595C5EA4ABAE8F5D59F8F1E6
        F8F1E6F8F1E6F8F1E6F5D9ACFE9517FF9805FFAB36FFC684FFB75AFF9605FFF4
        E9A97F7A595C5EA4ABAE97655DFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEF5D9ACFE
        9517FF9E0FFFB75AFFC684FF9605FFF4E9A97F7A595C5EA4ABAE9F6E62FFFFFE
        FFFFFEF2F1F1CCCCCCCCCCCCCCCCCCCEC8C0F29623FFA82EFF9605FF9605FFF4
        E9A97F7A595C5EA4ABAEAA7868FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEED
        6536ED6536ED6536ED6536ED6536FFF4E9A97F7A595C5EA4ABAEB4826EFFFFFF
        FFFFFFF2F1F1CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD6D4D0F4EBDBF2E8D5FFF4
        E9A97F7A595C5EA4ABAEBE8C75FFFFFFED6536ED6536DA5F40C36452C28C80FE
        FEFDFEFEFDFEFEFD4853886B81CAFFF4E9A97F7A595C5EA4ABAEC9977BFFFFFF
        FF8F12FF8F12ED6536BE4B0FF9F2EFFEFEFDFEFEFDFEFEFD6197D687ADDEFFF4
        E9A97F7A595C5EA4ABAED3A281FFFFFFFF8F12FEB45AFFA931F99614BF6E33FF
        FFFFFDFCF9FEFEFDFEFEFDFEFEFDFFF4E9A97F7A757A7CAEB4B8DCAA86DCAA86
        FF8F12DCAA86F4A45EFFC37DEC9E49B05F33C49E91C49E91C49E91C49E91C49E
        91A97F7AAEB4B8C0C8CCFF00FFFF00FFFF8F12B7BEC2D5C0A9F4A45EFFDAA8F2
        BD88B56130B35B40CE753F91593DA5ABAFC4CBCFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFCEC2B8F4A45EFFEDBBFFE3B0CC8755944219A2A8ABC1C9
        CDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC9CACCF4
        A45EF4A45EA56645B2B2B2C2CACEFF00FFFF00FFFF00FFFF00FF}
      Margin = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = sbEmailFileClick
    end
    object btPreviewVendorFax: TSpeedButton
      Left = 57
      Top = -1
      Width = 53
      Height = 22
      Hint = 'Preview Models'
      Caption = 'Print'
      Flat = True
      Glyph.Data = {
        B6020000424DB60200000000000036000000280000000D000000100000000100
        18000000000080020000130B0000130B00000000000000000000FF00FFA67D7C
        B08A85BC958BBC958BBC928BBC938BBC9388BC9387BC9186BC9086BC9086996B
        67008E58C699869DCCB3B1FEE7D1FEE5CCFEDFC9FEE0C9FEDDBEFEDDBBFED9B9
        FED4B1FED2B3AB7C75005F9EEA577CC1A391A8E5CAC0FCE8D4FEE4CBFEE4CAFE
        E2C7FEDDBBFEDDBBFEDBB6FED4B1AB7C7500FF00FF589AE0557CC2A391A7E4C8
        BFFDE9D4FEE5CCFEE4CAFEE2C6FEDDBDFEDDBBFED7B9AB7C7500FF00FFA4A1AB
        5C9FE85A7BBEAD9FA9F1DDCCE1C0B4DCBAAEE1C3B7F7D6BBFEDDBBFED6BCAB7C
        7700FF00FFD7BCB4E2E8EB80B5E5989CA4D0ADA0ECD2B0F9F1CBF0E5C5DBBBB3
        E3C6B5FCD6BAAD7E7700FF00FFDAC1B8FCF4EBEEE3DCD5B6A7FAE4B7FDF6C9FE
        FEDEFEFCEEFBF9F4D4BCB4ECC9B7B4878000FF00FFDDC5C0FDF7EEEADBD6E9CE
        AFFCECBCFDF8CAFEFEDFFEFCF8FEFBF6EDE0C4DDB5ADB4888100FF00FFE4CDC2
        FDF9F5EBDBD6EDDBB9FDDFB1FDF3C5FEFED3FEFEDEFEFEDEF3EBC7DAB3ACB68B
        8400FF00FFE5CFC4FEFCFCEDDFDCE8D3B6FCEBC8FDE8BAFDF5C8FDF9CEFDF9CE
        ECDBB8DAB3ACBC928B00FF00FFEBD5C7FEFDFEF2EDECE1C7BDF6EFE8FAEED3FC
        E8B8FDE1B3FAE6B7DCB8A2E7C5B5BC908700FF00FFEDD6C7FEFEFEFEFEFEEDDE
        DDDAC5BBE6D1C5EAD3B7EBD0AEDDB8A5E2B9B0F8BFB9BE8A8400FF00FFEFDACA
        FEFEFEFDFEFDFFFEFFF0E6E5E8D5CEE1CEC6EAD4CCD4B1A7CD9D92CC9189BB84
        7A00FF00FFF1DCCCFEFEFEFEFEFEFFFFFEFFFEFEFDFCFCFDFAF9FDF8F3D0AFA6
        DEAB83E5A362D78A9500FF00FFF6DDC6FEF7F1FAF5F0F8F3EEF7F1ECF4EEEBF4
        ECE7EFE7E0CBA89FE0B38EED90A0FF00FF00FF00FFE8BC99E5BB9FE2BA9FE1B8
        9DE0B79CDFB59CDFB59BDCB399C39483DC8F93FF00FFFF00FF00}
      Margin = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = btPreviewVendorFaxClick
    end
    object sbSendFax: TSpeedButton
      Left = 112
      Top = -1
      Width = 52
      Height = 22
      Hint = 'Send by Fax'
      Caption = 'Fax'
      Enabled = False
      Flat = True
      Glyph.Data = {
        76020000424D760200000000000036000000280000000F0000000C0000000100
        1800000000004002000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFCFCFC878787676767C8C8C8F5F5F5FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFF2F2F2B6B8B8DADBDCAFAFAE9798988B
        8B8B676767C8C8C8F5F5F5FF00FFFF00FFFF00FFFF00FF000000FEFEFEE2E2E2
        C1C2C2EEF1F4979797676767979797C6C6C6AFAFAE9798988B8B8B676767C8C8
        C8F5F5F5FF00FF000000B0B1B1D5D6D6FDFDFD676767BABABA97979767676767
        6767C6C6C6C6C6C6C6C6C6AFAFAE979898676767C8C8C8000000B0B1B1C3C3C3
        8B8B8BBABABADEDEDEDEDEDEBABABA8B8B8BE6E6E6C6C6C6C6C6C6C6C6C6C6C6
        C6AFAFAE676767000000676767C3C3C3DEDEDEFFFFFFF4F4F4BABABA8B8B8BF1
        F3F6D4AF8BE6E6E6D9C5B0DADADAC6C6C6C6C6C66767670000008B8B8BFFFFFF
        F4F4F4DEDEDE8B8B8BC5C5C5FCFFFFD4AF8BF1F3F6D4AF8BE6E6E6D4AF8BDADA
        DAE0E0E08B8B8B000000FF00FFBABABAC3C3C3BABABAFFFFFFFFFFFFFFFFFFFC
        FFFFD7D0C9F1F3F6D4AF8BE6E6E6E0E0E08B8B8BFF00FF000000FF00FFE4D8D8
        E29C9CE38A8AA26C6BE38A8AA9A6A1B7B8B8C6C6C6B7B8B8A9A6A18B8B8B8B8B
        8BFF00FFFF00FF000000FF00FFA26C6BFFCCCCE3A7A7E29C9CE38A8AE38A8AE3
        8A8AE38A8A8B8B8B8B8B8BFF00FFFF00FFFF00FFFF00FF000000FF00FFFAF8F8
        A26C6BE29C9CFFCCCCE3A7A7E29C9CE38A8AA26C6BFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFE4D8D8A26C6BE38A8AA26C6BCA
        ACABFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
      Margin = 3
      ParentShowHint = False
      ShowHint = True
    end
  end
  object quModel: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 180
    Parameters = <>
    Left = 20
    Top = 40
    object quModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object ppPipeline: TppBDEPipeline
    DataSource = dsModel
    UserName = 'Pipeline'
    Left = 90
    Top = 42
    object ppPipelineppField1: TppField
      FieldAlias = 'Model'
      FieldName = 'Model'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppPipelineppField2: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppPipelineppField3: TppField
      FieldAlias = 'Qty'
      FieldName = 'Qty'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
  end
  object dsModel: TDataSource
    DataSet = quModel
    Left = 25
    Top = 90
  end
  object ppModel: TppReport
    AutoStop = False
    DataPipeline = ppPipeline
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'LT 8.5 x 11 in'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    BeforePrint = ppModelBeforePrint
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 90
    Top = 95
    Version = '7.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppPipeline'
    object ppTitleBand: TppTitleBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 49742
      mmPrintPosition = 0
      object ppLabel6: TppLabel
        UserName = 'lblTitulo'
        Caption = 'Report Title'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 18
        Font.Style = []
        Transparent = True
        mmHeight = 7673
        mmLeft = 529
        mmTop = 529
        mmWidth = 32544
        BandType = 1
      end
      object ppMemo2: TppMemo
        UserName = 'mmStoreInfo'
        Caption = 'mmStoreInfo'
        CharWrap = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 10
        Font.Style = []
        Lines.Strings = (
          'Store Info')
        Stretch = True
        Transparent = True
        mmHeight = 24871
        mmLeft = 794
        mmTop = 9790
        mmWidth = 199496
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppMemo3: TppMemo
        UserName = 'mmFrase'
        Caption = 'mmFiltro'
        CharWrap = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold, fsItalic]
        Lines.Strings = (
          'Frase')
        Transparent = True
        mmHeight = 12700
        mmLeft = 1323
        mmTop = 37041
        mmWidth = 199496
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
    end
    object ppHeaderBand: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 3969
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Model'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        mmHeight = 3969
        mmLeft = 0
        mmTop = 0
        mmWidth = 57679
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Description'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        mmHeight = 3969
        mmLeft = 59267
        mmTop = 0
        mmWidth = 97367
        BandType = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Cost Price'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        mmHeight = 3969
        mmLeft = 174890
        mmTop = 0
        mmWidth = 23548
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'lbQty'
        AutoSize = False
        Caption = 'Qty'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3969
        mmLeft = 158221
        mmTop = 0
        mmWidth = 15875
        BandType = 0
      end
    end
    object ppDetailBand: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 265
        mmLeft = 0
        mmTop = 4233
        mmWidth = 198438
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Model'
        DataPipeline = ppPipeline
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPipeline'
        mmHeight = 3440
        mmLeft = 529
        mmTop = 529
        mmWidth = 56886
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Description'
        DataPipeline = ppPipeline
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppPipeline'
        mmHeight = 3440
        mmLeft = 59531
        mmTop = 529
        mmWidth = 96838
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'dbQty'
        DataField = 'Qty'
        DataPipeline = ppPipeline
        DisplayFormat = '0.#####;-0.#####'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppPipeline'
        mmHeight = 3440
        mmLeft = 158221
        mmTop = 529
        mmWidth = 15610
        BandType = 4
      end
    end
    object ppFooterBand: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 7408
      mmPrintPosition = 0
      object ppLabel8: TppLabel
        UserName = 'lblUsuarioData'
        Caption = 'User and Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Name = 'Tahoma'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3969
        mmLeft = 93398
        mmTop = 1588
        mmWidth = 20373
        BandType = 8
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3969
        mmLeft = 178594
        mmTop = 1852
        mmWidth = 17992
        BandType = 8
      end
    end
  end
  object quVendor: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10'        V.IDPessoa,'#13#10'        V.Pessoa as Vendor,'#13#10'      ' +
      '  V.Contato,'#13#10'        V.Telefone,'#13#10'        V.Fax,'#13#10'        V.Ema' +
      'il'#13#10'FROM'#13#10'        Pessoa V'#13#10#9'JOIN TipoPessoa TP ON (V.IDTipoPess' +
      'oa =  TP.IDTipoPessoa)'#13#10'WHERE'#13#10#9'TP.Path LIKE '#39'.002%'#39#13#10#9'AND'#13#10'    ' +
      '    V.IDPessoa = :IDVendor'#13#10'ORDER BY'#13#10'        V.Pessoa'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDVendor'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 25
    Top = 150
    object quVendorIDPessoa: TAutoIncField
      FieldName = 'IDPessoa'
      ReadOnly = True
    end
    object quVendorFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quVendorEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quVendorVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object SD: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File|*.txt'
    InitialDir = 'C:\'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofNoValidate, ofPathMustExist, ofFileMustExist]
    Left = 175
    Top = 98
  end
  object Emails: TEmail
    ShowDialog = False
    UseAppHandle = False
    Left = 210
    Top = 5
  end
end
