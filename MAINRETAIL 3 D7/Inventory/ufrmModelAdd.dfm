inherited frmModelAdd: TfrmModelAdd
  Left = 46
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmModelAdd'
  ClientHeight = 595
  ClientWidth = 593
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object lblPricing: TLabel [0]
    Left = 0
    Top = 1
    Width = 245
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'Pricing'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lblEstoque: TLabel [1]
    Left = 213
    Top = 1
    Width = 248
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'Inventory'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 5
    Top = 6
    Width = 245
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'Pricing'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel [3]
    Left = 239
    Top = 1
    Width = 248
    Height = 14
    Alignment = taCenter
    AutoSize = False
    Caption = 'Inventory'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lblModelInformation: TLabel [4]
    Left = 0
    Top = 40
    Width = 593
    Height = 14
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Model Information'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  inherited Panel2: TPanel
    Width = 593
    inherited Image1: TImage
      Width = 366
    end
    inherited lblMenu: TLabel
      Left = 377
    end
    inherited EspacamentoSuperior: TPanel
      Width = 593
      inherited EEE: TPanel
        Width = 593
      end
    end
  end
  inherited Panel1: TPanel
    Top = 554
    Width = 593
    inherited lblUserName: TLabel
      Width = 140
    end
    object SpeedButton3: TSpeedButton [2]
      Left = 277
      Top = 10
      Width = 107
      Height = 31
      Cursor = crHandPoint
      Caption = 'Label Options'
      Glyph.Data = {
        D60B0000424DD60B0000000000003600000028000000200000001F0000000100
        180000000000A00B0000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8383837878787474747B7B7B8383
        83FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF918686806D6D8B7070997A7AA58585B29090A07F7F9572728869
        69715D5D685E5E6C6C6CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        A79C9C997C7CC0A8A8D1C3C3D8CDCDDED6D6DCD1D1DBCDCDDBC9C9D6BCBCC8A5
        A5C59F9FB68D8D8A68686357576E6E6EFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB19C9C
        BDA4A4DCDADAE0E2E2E0E0E0DDDBDBDBD4D4D9D0D0D8CCCCD5C1C1D1B5B5CDBD
        BDBDA1A1C09B9BC89E9EB789896E5A5A6C6C6CFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC4ADAD
        E4E8E8E5E5E5E6E6E6E3E3E3E0E1E1DDDBDBDBD5D5DAD0D0D1BBBBE2D4D4D7CD
        CDCDC2C2C6B4B4B89494C89E9EB988886F5E5EFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC09F9FE0E0E0
        E9E9E9EDEDEDEEEEEEEDEDEDE8E8E8E0E1E1DCDADADBD4D4CFB2B2E2D2D2D0B4
        B4CBADADCEB3B3C09F9FC39797CB9D9D937070FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC19B9BE7EAEA
        EBEBEBF3F3F3F6F6F6F3F3F3EDEDEDE5E5E5DEDDDDDBD4D4D2B4B4DABEBECDA1
        A1CC9F9FCEA2A2BD8F8FBF9494CDA0A09B7979FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD6BBBBE2DEDE
        F0F1F1F7F8F8FFFFFFF8F9F9EFEFEFE7E7E7DFE1E1D5C4C4D3B1B1D4ABABCB8E
        8ECC9191CE9292BD8585C09696CD9F9FA18484FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF667666757875FF00FFFF00FFD3B7B7
        EFEFEFF1EDEDE5CACAEDE3E4EFF2F2E7EAEADFE0E0D2B6B6D1A9A9CF9090CC81
        81CC8181CD8181BD7E7EC29898BC9393FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF4164421B67210C6E11346234FF00FFFF00FFFF00FF
        DDC6C6D8BDBDC18081C98C93CFA0A4D9C4C3DBD3D3CEA6A6CF9E9ECD7575CC73
        73CC7373CC7272B97373AC8989FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF787E7839603D1B7225178E2B21A84005720B407A40FF00FFFF00FFFF00FF
        FF00FFCBA5A5C88678F7BA6BE6B8A5D29CA2C88A8FC68486CA7171CA6363CA66
        66CB6666CC6767A06262878484FF00FFFF00FFFF00FFFF00FFFF00FF6B726C39
        61401F813316922C1B9B3435C6611C9A353A7A3AFF00FFFF00FFFF00FFFF00FF
        FF00FFC59C9ED28B62FFA107FFAF29FDBB5DEEC19CD89E96C87B82C26468BD56
        56BB5555BA5454905E5E868585FF00FFFF00FFFF00FF7074703B624429954320
        A43F15962D26A84340D26D1B912F588858FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFC29399DF954DFFA91BFFA920FFAA1FFFAB1EFEBA4AF3BD78DFA792CD89
        8DBE6268B1505482595967676796969676747641624B2F9C5129B9521EA63E18
        963137C05B47D8721A8026FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFC4969EE89B3CFFAF27FFB02EFFB131FFB233FFB12EFFB22CFFBB43F8B3
        4DEC9E52D58971BE6F6D7D5555454845338C5231C56029BD531B9F3920A13B4D
        DF7941CD68227627FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        CBB2B3C79A98F0A63AFFB534FFB63AFFB73DFFB840FFB943FFBB45FFB334FF9E
        06FF9901FF9701E08932675B4830AB5C30CB6225B44D1DA13C3DBE5C5EEF8B32
        B04C327533FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C4A7AACD9C84F8B13EFFBA41FFBC47FFBC49FFC04FFFC04FFFB334FF9E06FF99
        01E68301B0680C5C47282F9C5322CA581FAF4736B55469E08766E48726923456
        8456FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C8AAB1CE9972FEBC46FFBF4DFFC152FFC458FFC04EFFAA1DFF9F01F38E01CA79
        0EAE8A63C0B8B4ABA39B2B95477ADE9580DD938BED9F50B8621C71218DA88DFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        CBAEB5D49F68FFC64EFFC559FFC85FFFCA65FFAC19DD8309754830C78240EEE1
        D5FEEBD6FFD5ACEAC39F738D62D2DFD181C18A23752A558255FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        CBADAEE2AE65FFC95BFFCA64FFCF6EFFC44CC9861D153E77012E81986946F5BB
        85FFEBCBFDD69EEBA760E2A7697D69545E4939FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        C6A8A3F0BC65FFCE66FFD06FFFD775D7B258276F881C85C11C83B7085C91424F
        59B48152F8DBA4FDD89CC79156B58452AF6A69FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCDBCBE
        BEA299FBC967FFD270FFD579FFDA7B8DB5A934A6E56CD2FB69CEF451BAE51E8B
        C60D5889615B52B4885CC69246ECAE699B6368FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD1C1C4
        C5A78CFFD26DFFD67AFFDB81FCDD8B67B3CC35A1DB63C8F86BD0FD7DE1FF6FD3
        F444AFDD0170AF7F886FFFD970E3A873906568FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD3C6C9
        CFAE81FFD776FFDA81FFDF8AFDE3949BB8A02F84A71F8AC240A6DB5ABFF371D6
        FF5DC6F881B9BEFADF8AFFDC80DA9D76866567FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCCC1C6
        DDB976FFDC7DFFDE88FFE293FFE79CFFF0A4E3E3A990B5A7207EA92D91C535A1
        DC63BDE4F3E5A5FFE28DFFDD85CE917982696AFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBDB4B6
        D9B97CF7D583FFE58EFFEA9BFFEEA5FFF2AFFFF8B6FFFDBBE9EAB8B6CEB390BE
        B788B9B6FFEDA1FFE496FFDE8BC3877B816F70FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFACA3A2
        9B8E8AA9988DB8A28ECFB996E1CEA0F6E9B0FCF5BEFFFEC8FFFFCDFFFFCAFFFF
        BEF9EFB1FFEDA7FFE69BFDDF8FB17A78817676FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        BFB8B9AFA6A8A194979A86899E898AA48A8AB29992C9B6A3DCCCAFE7DDB8F3E9
        BAFFF6B6FFF6AEFFEE9FF5D38FA97574857E7EFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFD3CCCCD6CBCBC8B8B8BBA7A7AE9495A88B8DA58285A88384B18D
        88BD998CCBA990E1C293DDB489A073738B8888FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD0C3C3CFBEBEC8B2B2BEA1A2BC9B
        9CB69093AF8487AC7E7FAE7E7F9F7A7AA2A2A2FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFD0BBBBC9AEAEC7A4A4C29B9BB49797FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Margin = 1
      Visible = False
    end
    object spHelp: TSpeedButton [3]
      Tag = 5
      Left = 386
      Top = 9
      Width = 65
      Height = 17
      Caption = '&Help'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D002000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFF3E1D7F4E3D9F4E3DAF3E2D8F3E1D7FF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFF4E3D8F8FAFBE4E2E2CFB1A2D4
        AB96DDC6BBECF1F0F6F3F2F2E1D6FF00FFFF00FFFF00FF000000FF00FFFF00FF
        F5EAE2F4FFFFCF9A80B74C15B9643CD9AF9AC05823B95624D5AF9FF7FFFFF4E2
        D9FF00FFFF00FF000000FF00FFF2E1D7F8FFFFC77D58BB450CC64E13C2A495FF
        FFFFD9926FC14A0FB8450BCE9A80F8FFFFF2E0D6FF00FF000000FF00FFFAFAF9
        D8A890BD480DCD622ECD6029CB6B3AD88E68CA5E29CC622DC95D29B94710E0C9
        BDF6EDE8FF00FF000000F3E0D7F8FAFBC56232CA5C26CE6733CB5B23CA8969F7
        E7DFD06B38CA5A23CD6531C3531BC77850F8FCFDDCC8BE000000F3E1D8F2DED6
        C5561ECE6632CC6531CC5A21C28669FFFFFFE8AD91C44A0FCC622DCB5F28C35E
        2BF3F2F1F1DFD5000000F2E1D9F3D8CACD5B22CF6632CC642FCC602BC4551FCF
        B5A8FFFFFFE09C7AC7531ACD602BC65E29F5F1EDEFDED4000000F1E0D7FBEDE6
        DB6A32D36833CA5E28C95821C95419C14B10E2D0C6FFFFFFD0703FCD5A20CE6A
        38FCFBFBEEDDD2000000F1DED4FFFFFFF5986AE2662AC88B6DF0EAE3D77E51BD
        3000D79C7EFFFFFFDA8C65D15314E29A76FEFDFED3BDB2000000FF00FFF6F1EF
        FFEADBFF8A49DE875CEEFFFFFEFCFDE7B9A1FAFFFFF3F9FEE0723CE67035FFF3
        EEF4E7E0FF00FF000000FF00FFF1DED4FFFFFFFFE9CEFFB270ECAF87ECE2DFEB
        F0F4F1E4E0F6A478FE8C4DFFDECAFDFFFFF0DDD2FF00FF000000FF00FFFF00FF
        F0DFD6FFFFFFFFFFFBFFF3C6FEDDA8FCCF98FFC991FFD4A9FFFEF8FCFFFFF1DF
        D4FF00FFFF00FF000000FF00FFFF00FFFF00FFF1DCD3F5E8E4FDFCFDFFFFFFFF
        FFFFFFFFFFFCFBFDF3E6E0F1DDD2FF00FFFF00FFFF00FF000000FF00FFFF00FF
        FF00FFFF00FFFF00FFF1DCD1EFDBD0EFDBD1EFDCD1F1DBD0FF00FFFF00FFFF00
        FFFF00FFFF00FF000000}
      Margin = 5
      ParentFont = False
      Visible = False
    end
    object btnVideo: TSpeedButton [4]
      Tag = 5
      Left = 386
      Top = 25
      Width = 65
      Height = 16
      Caption = '&Video'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        D6020000424DD60200000000000036000000280000000F0000000E0000000100
        180000000000A002000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FF84474091251A961E1607A5CA07A5CA19839C556A6EFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFA4331AB23011BA4327BA4F362B
        C7EC2BC7EC17C0E801AFD9226E80FF00FFFF00FFFF00FF000000FF00FFFF00FF
        B43B12C24D1DC8622FCE6A36D17A5143CCED43CCED4AC7E53AC4E402BBE82072
        84FF00FFFF00FF000000FF00FFB85328CB5B1BD0661DDE8F56F6DDCAFEF9F6F9
        FEFFD2F2FA73D6ED47C8E53BC3E301AFDA567179FF00FF000000FF00FFCE5C16
        DA741EE99C54F0EFEA888E93BEC0C1FBF9F9FFFFFFFFFFFF78D8EE48C7E51BC0
        E8138BA7FF00FF000000D0804AE17618EF8D21F4DEC1E9F1F81E1D1D131313A7
        A7A7CFCFCFFFFDFCE3F7FC4ACBEA37C5E707A8D0FF00FF000000CF7F46DE832B
        E9A448EAE7E0E9F1F84847481B1B1B0404041C1C1CCFCFCFE3E0E068D5ED38C0
        DE06A8CDFF00FF0000005373F01B4AFF4D73FFDADCE1E9F1F84847484E4E4E21
        2121080808646464EAE8E855B499288A72065A49FF00FF0000005373F01B4AFF
        4D73FFC5CBE1E9F1F84847486B6B6B797979C7C7C7FFFEFFE1EEE92CA1771C81
        5F0A533AFF00FF000000FF00FF1B48F84C71FF9EAFF5E9F1F86B6B6BC6C6C4EB
        E9E9F4EBEEF7EAEF67C4A0149B6D05734F2A6150FF00FF000000FF00FF3E63F4
        2E59FE5376FFA1B1F1C7CBDBD9D8D8D9D8D7C3DCD35FCEA301A96D068D610167
        45FF00FFFF00FF000000FF00FFFF00FF244EF7315AFE5376FF5D7DFF597AF530
        D1A80DD58401B773019C66017A4E578375FF00FFFF00FF000000FF00FFFF00FF
        FF00FF385EF51B47F9234DFC224EF901B99101BE7101A065098A5C689685FF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FF8EA2F25876EB3258EC1A
        A58B29AE785AA98CFF00FFFF00FFFF00FFFF00FFFF00FF000000}
      Margin = 5
      ParentFont = False
      Visible = False
    end
    inherited EspacamentoInferior: TPanel
      Width = 593
      TabOrder = 1
      inherited Panel3: TPanel
        Width = 593
      end
    end
    inherited hhh: TPanel
      Left = 482
      Width = 111
      TabOrder = 2
      inherited btClose: TButton
        Left = 40
        Top = 4
        Caption = '&Cancel'
        OnClick = btCloseClick
      end
    end
    object btnAdd: TButton
      Left = 453
      Top = 10
      Width = 66
      Height = 31
      Caption = '&Add'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btnAddClick
    end
    object dbckPrintLabel: TDBCheckBox
      Left = 199
      Top = 17
      Width = 73
      Height = 13
      Caption = 'Print Label'
      DataField = 'UpdatePrice'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      Visible = False
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 559
    Height = 433
  end
  inherited EspacamentoDireito: TPanel
    Left = 590
    Top = 559
    Height = 433
  end
  object Panel4: TPanel [9]
    Left = 0
    Top = 54
    Width = 593
    Height = 505
    Align = alTop
    TabOrder = 4
    object lblCategory: TLabel
      Left = 4
      Top = 76
      Width = 60
      Height = 16
      Alignment = taRightJustify
      Caption = 'Category :'
    end
    object lblDescription: TLabel
      Left = 4
      Top = 53
      Width = 72
      Height = 16
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object lblManufacturer: TLabel
      Left = 4
      Top = 147
      Width = 85
      Height = 16
      Alignment = taRightJustify
      Caption = 'Manufacturer :'
    end
    object lblGroup: TLabel
      Left = 4
      Top = 123
      Width = 43
      Height = 16
      Alignment = taRightJustify
      Caption = 'Group :'
    end
    object lblSubCategory: TLabel
      Left = 4
      Top = 99
      Width = 87
      Height = 16
      Alignment = taRightJustify
      Caption = 'Sub-Category :'
    end
    object lbCaseQty: TLabel
      Left = 224
      Top = 170
      Width = 60
      Height = 16
      Alignment = taRightJustify
      Caption = 'Case Qty :'
      FocusControl = edtCaseQty
    end
    object lblModel: TLabel
      Left = 4
      Top = 30
      Width = 43
      Height = 16
      Alignment = taRightJustify
      Caption = 'Model :'
    end
    object Label2: TLabel
      Left = 374
      Top = 27
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
    object Label1: TLabel
      Left = 374
      Top = 51
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
    object Label4: TLabel
      Left = 374
      Top = 75
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
    object lblBarcode: TLabel
      Left = 4
      Top = 8
      Width = 55
      Height = 16
      Alignment = taRightJustify
      Caption = 'Barcode :'
    end
    object lbBarcodeCase: TLabel
      Left = 4
      Top = 170
      Width = 83
      Height = 16
      Alignment = taRightJustify
      Caption = 'Case Barcode:'
    end
    object lblUnitCost: TLabel
      Left = 3
      Top = 234
      Width = 60
      Height = 16
      Alignment = taRightJustify
      Caption = 'Unit Cost :'
    end
    object lblOurPrice: TLabel
      Left = 3
      Top = 259
      Width = 75
      Height = 16
      Alignment = taRightJustify
      Caption = 'Selling Price:'
    end
    object Label8: TLabel
      Left = 169
      Top = 257
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
    object lblfactor: TLabel
      Left = 3
      Top = 284
      Width = 36
      Height = 13
      Caption = 'Margin:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblfactordesire: TLabel
      Left = 178
      Top = 284
      Width = 94
      Height = 13
      Alignment = taRightJustify
      Caption = 'Desired Margin(%):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 1
      Top = 212
      Width = 590
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Pricing'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel
      Left = 324
      Top = 333
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Min qty :'
    end
    object Label9: TLabel
      Left = 321
      Top = 360
      Width = 53
      Height = 16
      Alignment = taRightJustify
      Caption = 'Max qty :'
    end
    object Label16: TLabel
      Left = 4
      Top = 333
      Width = 78
      Height = 16
      Alignment = taRightJustify
      Caption = 'Qty on hand :'
    end
    object Label10: TLabel
      Left = 2
      Top = 309
      Width = 590
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Inventory'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblVendorPart: TLabel
      Left = -2
      Top = 449
      Width = 87
      Height = 16
      Alignment = taRightJustify
      Caption = 'Vendor code :'
    end
    object lbMinQtyPO: TLabel
      Left = 6
      Top = 474
      Width = 72
      Height = 16
      Alignment = taRightJustify
      Caption = 'Min Qty PO :'
    end
    object lblVendor: TLabel
      Left = 4
      Top = 422
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Vendor :'
    end
    object lbQtyType: TLabel
      Left = 220
      Top = 477
      Width = 60
      Height = 16
      Alignment = taRightJustify
      Caption = 'Case Qty :'
    end
    object btnVendorSuggestion: TSpeedButton
      Left = 374
      Top = 444
      Width = 109
      Height = 26
      Cursor = crHandPoint
      Caption = 'Add Vendor'
      Glyph.Data = {
        06080000424D060800000000000036000000280000001A000000190000000100
        180000000000D0070000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFAE8584A27C7C98787998817FA99C9CFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        E4B3A6E7B6A3DCAF9DCEA292A27F7EFF00FFFF00FFBD9D9DAF9291A68F90A494
        95AAA4A3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFD5B1B1F1C2ABFCD3AAFDD3AAF4C8A7B08B85FF
        00FFFF00FFD3A79CE0B3A7D5A79FC59993B58A87AA83839A7D7F958786FF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFD6AEAD
        F3C5AFFDD5AFFDD5ADF6D0ACC39E8C94817EB59790F1CCB0FCDCBDFADABFF8D8
        C0F3D1BFECC9B9DCB4A9A48580FF00FFFF00FFB68F88A786819C84819B8A86A5
        9898FF00FFFF00FF0000FF00FFD6AEADF4C6B1FDD6B1FCD9B3FDD8B4EDCAA9C4
        A28FD8B4A1FDDFBEFCE1C2FEE2C4FFE6C8FEE6CBFDE6CDEED4C1A2877FFF00FF
        D4B8B0EAC6BBEAC9BFE0BDB5D5AEA8B38F8BB7A7A7FF00FF0000FF00FFD6AFAD
        F4C6B5F8D9B7E6D0A8D9CA9FCFC799D2C79FDDCDAAF4DFBEFCE2C9FDE4CCFEE6
        CDFFE8D0FEEAD3F7E0CCB79B8F988480D5B4AAFBE9DAFDEEE2FBECE1F7E5DCCF
        B3ACBAA9A7FF00FF0000FF00FFD8B1AEF2C8B200008000008000008000008000
        0080000080000080000080D2D2ADFAE9D0FDEAD9FEEBDAFDEDDAEFDBCADEC3BB
        F5E1D6FCF2E4FDF4EAFEF5ECFDF1E9D2BCB5B7ABA8FF00FF0000FF00FFDBB4B0
        EDC8B20000800000800000FF0000FF0000FF8080FF0000FF000080000080DADB
        BCF9EEDEFDEFDEFEF0E1FEF0E4FEF2E7FDF3E9FBF6ECFBF5F0FDF7F0FDF4EED4
        BEBBB7ABA8FF00FF0000FF00FFDBB4B1F2CCBB0000800000800000FF0000FF80
        80FF8080FF0000FF0000FF000080CED8B4FAECE1FCECDBFDF2E2FEF4E8FEF6EB
        FCF7EEFCF8F1FDF9F6FEFAF7FCF8F6D4C2BEB8ACA8FF00FF0000FF00FFDBB5B4
        F5D0C4E5D8B80000800000800000FF8080FF8080FF0000FF0000FF000080E3E3
        CFF8E5D3FAD4BCFCD5BEFED8C4FFDFCEFEE8DAFDEEE5FDF4EDFEFBF9FCFBFAD5
        C5BFBAAEA9FF00FF0000FF00FFDBB5B4F5D1C7FDE9D5CED6B2000080247D9834
        89C4418DB7000080000080C7D8B8FAF1EAFDF2E4FCE9DCFAE3D7FDE1D2FFD9C7
        FDD3BEFACBB3FACEB6FBF0E6F9FBFAD8C5C0BBAFAAFF00FF0000FF00FFDEBBB4
        F5D5C7FEEBD9CFD5D44492D22F94F43498FA2F95F74E99D5D6DFE1FFF7EEFBF7
        F1FCF4EFFCF2ECFEF5F1FDF9F5FCFDFBFDFEFBFBFDFBFCFAF7FEFCFCFDFBFAD8
        C6BEBAAEAAFF00FF0000FF00FFE1BBB4F6D6CBFEEFDE93B9D23497EB3BA3FD42
        A6FD3CA3FD449EE8ABC8DBFEFAF2FCFBF8FBE7E0FCD6C3FDD9C7FEDFCEFEE3D4
        FBE5D9FAE8DEFBEEE6FDFAF7FBFBFAD8C7C0BBB0ABFF00FF0000FF00FFE4BBB5
        F8D7D0FFEFE5589FCE44A8FA4BB0FD50B4FD4DB1FE48A9F299C3DFFEFEF9FCFF
        FCFDF6F6FBEEE8FCEBE0FCE5D9FEE0D2FDDCCEFBDACBFBDDCEFCF4EEF9FBFADA
        C7C1BCB0ABFF00FF0000FF00FFE4BDBAF8D9D3FFF3E74998CE4DAEFA50B6FB4D
        B3F64AAEF251AEED9AC9E1FDFEFEFCFFFEFCF4F4FBEFEAFBF5F0FBFAF6FDFCFA
        FEFBF8FCF8F6FBF7F4FEFAFBFCFAFADAC7C2BDB0ADFF00FF0000FF00FFE7BEB9
        F8DAD5FCF6ED6B9FC63A8BCA4C9ED455A7DC4DA3D94C95C8B9D7E6FAFFFFFCFF
        FFF9E9E3FAD0C0FED0BAFED0B9FCD0BDFDD6C4FADCCCFBE2D6FCF6F2FDFBFADB
        CAC1BFB1ABFF00FF0000FF00FFE8BEB9F8DBD9FBF8F4B4CEDE5C9EC987BADF89
        BFE266AAD87AB0CDE9F1F6FDFFFEFCFFFFFBFDFCFBF9F6FDF6F1FEF2EDFEEEE6
        FEEADEFDE4D5FBDED0FAF3EDFCFBFADCCAC3C1B1ACFF00FF0000FF00FFE9BFBB
        F8DDDCFDF9FBEFF7F9B3D3E496C3DB9DC8DF9DC7DCDCEAF0F9FEFCFCFFFEFEFF
        FFFEFEFFFEFDFEFEFFFCFCFFFDFDFFFEFEFEFEFEFCFEFDFDFCFCFEFDFDFBFBDE
        CAC5C3B0ADFF00FF0000FF00FFEAC0BDF9DFDDFEFCFAFBFEFEF4FBFAEAF4F7E8
        F3F7F0F5F8FDFDFEFCFFFEFBFFFEFEFDFFFFFFFFFFFFFEFEFFFBFEFFFBFEFFFD
        FEFFFFFEFFFFFCFFFEFDFFFEFCFBF9DECBC4C3B0B0FF00FF0000FF00FFECC3BB
        F8E0DDFBFCFCFDFFFEFDFFFDFEFFFEFEFFFFFEFEFFFEFEFFFCFFFFFBF7F5F1DB
        D7F4E3D9F8EBE5FBEFEDFCF4F1FDF6F3FDF7F4FDF8F6FCFAF8FDFBF9FDFAF6E1
        CDC3C6B6B3FF00FF0000FF00FFEDC3BFFCDFE0FFFCFDFFFFFFFFFFFFFEFFFFFD
        FFFFFEFFFEFEFFFFFBFFFFFAF0EBBA9D92E5D2CAF8E0D8F8DED4F6DDD0F6DCCE
        F4DACDF8DCCEF9DCD0F8DFD2F9E1D3EBD5C9E1D9D7FF00FF0000FF00FFECC5BD
        F7D7D3FCF1F0FBF5F3FDF8F5FCFAF8FBFCFCFDFEFCFCFFFFFCFFFFFBF0ECB29A
        94FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFEFD4CDF2DCD4F1DAD1F5DAD3F6DAD3F7
        DBD3F7DDD4F6DDD4FBE1D7F8DACDCFB8B0FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000}
      Margin = 1
      Visible = False
    end
    object Label12: TLabel
      Left = 214
      Top = 450
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vendor Cost :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 2
      Top = 399
      Width = 590
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Vendor'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object dbedMarkup: TDBEdit
      Left = 276
      Top = 280
      Width = 80
      Height = 24
      DataField = 'MarkUp'
      DataSource = dtsModel
      TabOrder = 14
      OnChange = dbedMarkupChange
      OnKeyDown = dbedMarkupKeyDown
    end
    object edtDescription: TDBEdit
      Tag = 99
      Left = 93
      Top = 49
      Width = 277
      Height = 24
      DataField = 'Description'
      DataSource = dtsModel
      TabOrder = 2
    end
    object edtCaseQty: TDBEdit
      Left = 288
      Top = 166
      Width = 83
      Height = 24
      DataField = 'CaseQty'
      DataSource = dtsModel
      TabOrder = 8
      OnChange = edtCaseQtyChange
      OnExit = edtCaseQtyExit
      OnKeyPress = edtCaseQtyKeyPress
    end
    object edtModel: TDBEdit
      Tag = 99
      Left = 93
      Top = 26
      Width = 277
      Height = 24
      DataField = 'Model'
      DataSource = dtsModel
      TabOrder = 1
      OnChange = edtModelChange
      OnExit = edtModelExit
      OnKeyPress = edtModelKeyPress
    end
    object edtBarcode: TDBEdit
      Left = 93
      Top = 4
      Width = 113
      Height = 24
      Color = 8454143
      DataField = 'IDBarcode'
      DataSource = dtsModel
      TabOrder = 0
      OnEnter = edtBarcodeEnter
      OnExit = edtBarcodeExit
      OnKeyDown = edtBarcodeKeyDown
    end
    object scManufacturer: TDBSuperComboADO
      Tag = 99
      Left = 93
      Top = 143
      Width = 277
      Height = 24
      TabOrder = 6
      Text = 'scManufacturer'
      FilterSugest = True
      LookUpSource = DM.dsLookUpFabricante
      DropDownRows = 18
      IDLanguage = 0
      DataField = 'IDManufacturer'
      DataSource = dtsModel
    end
    object scCategory: TDBSuperComboADO
      Tag = 99
      Left = 93
      Top = 72
      Width = 277
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = 'scCategory'
      LookUpSource = DM.dsLookUpGroup
      DropDownRows = 18
      EditCodePos = taEditCodeRight
      IDLanguage = 0
      OnSelectItem = scCategorySelectItem
      DataField = 'IDGroup'
      DataSource = dtsModel
    end
    object scGroup: TDBSuperComboADO
      Tag = 99
      Left = 93
      Top = 119
      Width = 277
      Height = 24
      TabOrder = 5
      Text = 'scGroup'
      FilterSugest = True
      LookUpSource = DM.dsLookUpModelSubGroup
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = scGroupSelectItem
      DataField = 'IDModelSubGroup'
      DataSource = dtsModel
    end
    object scSubCategory: TDBSuperComboADO
      Tag = 99
      Left = 93
      Top = 95
      Width = 277
      Height = 24
      TabOrder = 4
      Text = 'scSubCategory'
      FilterSugest = True
      LookUpSource = DM.dsLookUpModelGroup
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = scSubCategorySelectItem
      DataField = 'IDModelGroup'
      DataSource = dtsModel
    end
    object edtBarcodeCase: TDBEdit
      Left = 93
      Top = 166
      Width = 111
      Height = 24
      DataField = 'BarcodeCase'
      DataSource = dtsModel
      TabOrder = 7
    end
    object chkManualCalcPrice: TDBCheckBox
      Left = 214
      Top = 8
      Width = 138
      Height = 13
      Caption = 'Override Catalog Info.'
      DataField = 'UpdatePrice'
      TabOrder = 25
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      Visible = False
    end
    object chbAskSPOnSale: TDBCheckBox
      Left = 82
      Top = 194
      Width = 257
      Height = 17
      Caption = 'Require Sales Person On Sale'
      DataField = 'AskUserOnSale'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      ValueChecked = 'true'
      ValueUnchecked = 'false'
    end
    object edtUnitCost: TDBEdit
      Left = 83
      Top = 230
      Width = 85
      Height = 24
      DataField = 'VendorCost'
      DataSource = dtsModel
      TabOrder = 10
      OnChange = edtUnitCostChange
      OnExit = edtUnitCostExit
      OnKeyDown = edtUnitCostKeyDown
      OnKeyPress = edtUnitCostKeyPress
    end
    object edtSellingPrice: TDBEdit
      Left = 83
      Top = 255
      Width = 85
      Height = 24
      DataField = 'SellingPrice'
      DataSource = dtsModel
      TabOrder = 11
      OnChange = edtUnitCostChange
      OnExit = edtSellingPriceExit
      OnKeyDown = edtSellingPriceKeyDown
    end
    object dbckAdjustManually: TDBCheckBox
      Left = 275
      Top = 236
      Width = 138
      Height = 13
      Caption = 'Adjust Price Manually'
      DataField = 'UpdatePrice'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = dbckAdjustManuallyClick
    end
    object dbckAskForSale: TDBCheckBox
      Left = 275
      Top = 254
      Width = 138
      Height = 13
      Caption = 'Ask For Sale Price'
      DataField = 'CustomSalePrice'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      ValueChecked = 'true'
      ValueUnchecked = 'false'
    end
    object edtMargin: TEdit
      Left = 83
      Top = 280
      Width = 84
      Height = 24
      TabStop = False
      Color = clSilver
      Enabled = False
      TabOrder = 26
    end
    object dbedMinQty: TDBEdit
      Left = 378
      Top = 329
      Width = 70
      Height = 24
      DataField = 'MinQty'
      DataSource = dtsModel
      TabOrder = 18
    end
    object dbedMaxQty: TDBEdit
      Left = 378
      Top = 352
      Width = 70
      Height = 24
      DataField = 'MaxQty'
      DataSource = dtsModel
      TabOrder = 19
      OnKeyDown = dbedMaxQtyKeyDown
    end
    object dbedQtyOnHand: TDBEdit
      Left = 83
      Top = 329
      Width = 70
      Height = 24
      DataField = 'QtyOnHand'
      DataSource = dtsModel
      TabOrder = 15
    end
    object dbckClassE: TDBCheckBox
      Left = 83
      Top = 356
      Width = 138
      Height = 13
      Caption = 'Auto Request Class "E"'
      DataField = 'ClasseABC'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      ValueChecked = 'E'
      ValueUnchecked = 'C'
    end
    object dbckNotVerify: TDBCheckBox
      Left = 83
      Top = 375
      Width = 209
      Height = 13
      Caption = 'Do Not Verify Qty On Hand During Sale'
      DataField = 'NotVerifyQty'
      DataSource = dtsModel
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object edtVendorPart: TDBEdit
      Left = 87
      Top = 444
      Width = 73
      Height = 24
      DataField = 'VendorCode'
      DataSource = dtsModel
      TabOrder = 21
    end
    object edMinQtyPO: TDBEdit
      Left = 87
      Top = 471
      Width = 73
      Height = 24
      DataField = 'VendorMinQtyPO'
      DataSource = dtsModel
      TabOrder = 22
    end
    object scVendor: TDBSuperComboADO
      Tag = 99
      Left = 87
      Top = 418
      Width = 250
      Height = 24
      TabOrder = 20
      Text = 'scVendor'
      FilterSugest = True
      LookUpSource = DM.dsLookUpFornecedor
      DropDownRows = 18
      IDLanguage = 0
      DataField = 'IDVendor'
      DataSource = dtsModel
    end
    object edCaseQtyPO: TDBEdit
      Left = 288
      Top = 472
      Width = 72
      Height = 24
      DataField = 'VendorCaseQty'
      DataSource = dtsModel
      TabOrder = 24
      OnKeyDown = edCaseQtyPOKeyDown
    end
    object DBEdit5: TDBEdit
      Left = 288
      Top = 446
      Width = 73
      Height = 24
      DataField = 'VendorCost'
      DataSource = dtsModel
      TabOrder = 23
    end
  end
  object cdsVendorSuggestion: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModel'
    Left = 498
    Top = 247
    object cdsVendorSuggestionIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsVendorSuggestionVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsVendorSuggestionVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 15
    end
    object cdsVendorSuggestionMinQtyPO: TFloatField
      FieldName = 'MinQtyPO'
    end
    object cdsVendorSuggestionCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object cdsVendorSuggestionVendorCost: TCurrencyField
      FieldName = 'VendorCost'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsModel: TDataSource
    DataSet = cdsModel
    Left = 498
    Top = 416
  end
  object dspModel: TDataSetProvider
    DataSet = quModel
    Left = 490
    Top = 219
  end
  object quModel: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'm.IDModel,'#13#10#9'Model,'#13#10#9'GroupID as IDGroup,'#13#10#9'Description' +
      ','#13#10#9'FreightCost,'#13#10#9'OtherCost,'#13#10#9'm.VendorCost,'#13#10#9'SuggRetail,'#13#10#9'Da' +
      'teLastCost,'#13#10#9'MarkUp,'#13#10#9'm.SellingPrice,'#13#10#9'DateLastSellingPrice,'#13 +
      #10#9'IDUserLastSellingPrice,'#9#13#10#9'Peso,'#13#10#9'IDFabricante as IDManufactu' +
      'rer,'#13#10#9'm.System,'#13#10#9'm.Desativado,'#13#10#9'm.Hidden,'#13#10#9'ModelType,'#13#10#9'IDCo' +
      'lor,'#13#10#9'IDSize,'#13#10#9'IDUnidade as IDUnit,'#13#10#9'LastCost,'#13#10#9'LastMovDate,' +
      #13#10#9'ClasseABC,'#13#10#9'ES,'#13#10#9'PVD,'#13#10#9'PP,'#13#10#9'TR,'#13#10#9'AutomaticRequest,'#13#10#9'Avg' +
      'Cost,'#13#10#9'ReplacementCost,'#13#10#9'FloatPercent,'#13#10#9'NotVerifyQty,'#13#10#9'Promo' +
      'tionPrice,'#13#10#9'DiscountPerc,'#13#10#9'TotQtyOnHand,'#13#10#9'CustomSalePrice,'#13#10#9 +
      'm.CaseQty,'#13#10#9'Verify,'#13#10#9'IDModelGroup,'#13#10#9'IDModelSubGroup,'#13#10#9'SendTo' +
      'Trash,'#13#10#9'AskUserOnSale,'#13#10#9'UpdatePrice,'#13#10#9'UseScale,'#13#10#9'ScaleValidD' +
      'ay,'#13#10#9'UseLot,'#13#10#9'IndicadorProducao,'#13#10#9'IndicadorAT,'#13#10#9'b.idbarcode,' +
      ' '#13#10#9'b.idbarcode barcodecase,'#13#10#9'i.*,'#13#10#9'imv.CaseQty as VendorCaseQ' +
      'ty,'#13#10#9'imv.MinQtyPO as VendorMinQtyPO,'#13#10#9'imv.IDPessoa as IDVendor' +
      ','#13#10#9'vmc.VendorCode as VendorCode'#13#10'FROM'#13#10#9'Model m (NOLOCK) join b' +
      'arcode b on m.idmodel = b.idmodel'#13#10#9'join Inventory i (NOLOCK) on' +
      ' m.IDModel = i.ModelID'#13#10#9'join Inv_ModelVendor imv (NOLOCK) on m.' +
      'IDModel = imv.IDModel'#13#10#9'join Pessoa v (NOLOCK) on v.IDPessoa = i' +
      'mv.IDPessoa'#13#10#9'join VendorModelCode vmc (NOLOCK) on vmc.IDPessoa ' +
      '= v.IDPessoa'#13#10'WHERE'#13#10#9'm.IDModel = :IDModel'#13#10
    Parameters = <
      item
        Name = 'idmodel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 490
    Top = 164
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'idmodel'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspModel'
    Left = 493
    Top = 308
  end
end
