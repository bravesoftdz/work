object FrmMain: TFrmMain
  Left = 302
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MainRetail - Installation'
  ClientHeight = 575
  ClientWidth = 625
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    625
    575)
  PixelsPerInch = 96
  TextHeight = 13
  object LblVersion: TLabel
    Left = 20
    Top = 517
    Width = 133
    Height = 16
    Anchors = [akBottom]
    Caption = 'Version 5 Build 999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblReleaseType: TLabel
    Left = 157
    Top = 516
    Width = 92
    Height = 16
    Anchors = [akBottom]
    Caption = '(ReleaseType)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object pgWizard: TPageControl
    Left = 0
    Top = 0
    Width = 621
    Height = 470
    ActivePage = TbsOptions
    Style = tsFlatButtons
    TabOrder = 0
    object TbsOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 8
      object Memo: TMemo
        Left = 25
        Top = 303
        Width = 572
        Height = 55
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          '/a:Deploy /cs:"Server=(local)\PINOGY;Integrated '
          'Security=true;Pooling=false;Initial '
          
            'Catalog=MainRetailDB; "/dsp:Sql /dd+ /model:C:\TEMP\SCHEMA_UPDAT' +
            'E'
          '\MainRetailDB_Schema.dbschema" /p:TargetDatabase="MainRetailDB"')
        ParentFont = False
        TabOrder = 0
        Visible = False
      end
      object PnlOptions: TPanel
        Left = 25
        Top = 10
        Width = 571
        Height = 293
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label2: TLabel
          Left = 364
          Top = 27
          Width = 102
          Height = 16
          Caption = 'Current version'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 364
          Top = 45
          Width = 111
          Height = 16
          Caption = 'Available version'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblAvailableVersion: TLabel
          Left = 482
          Top = 45
          Width = 88
          Height = 16
          Caption = 'Current version'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object LblCurrentVersion: TLabel
          Left = 482
          Top = 27
          Width = 88
          Height = 16
          Caption = 'Current version'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object LblMessage: TLabel
          Left = 0
          Top = 275
          Width = 531
          Height = 18
          Caption = 
            'MainRetail and all supporting applications will be automatically' +
            ' closed.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object BtnUpdate: TBitBtn
          Left = 0
          Top = 25
          Width = 111
          Height = 81
          Caption = 'Update'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = BtnUpdateClick
          Glyph.Data = {
            360C0000424D360C000000000000360000002800000020000000200000000100
            180000000000000C000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFBDBBBA96898691827F94838099868396817F917D
            7B958784AAA4A2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFB3AFAE9A8480C7B4B4D9D1D2DCD3D4DACFCFD7CACBD6C4C5D0B5
            B5CAA6A8C39B9C9B7A76AAA4A2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFA59D9AC3ACAAE0DDDFDDDEDDDDDCDBDED8D9DAD4D4DACDCFD4BEBED5C0
            C2C4B0B1BA9999C49B9ABC8E8E9C8E8BFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            AAA4A2BC9F9CE0E1E2E5E6E6E7E7E7E5E5E5E0DFDFDBD8D8D9D2D3CEB4B4DECF
            CFCDB3B4CCB4B5BC999AC99E9FB88988AAA4A2FF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            BAB3B1D7C9C9E8E8E8F0EFEFF2F2F2EEEEEEE5E5E5DDDDDDDBD6D6CFB2B2D5B8
            B8CCA3A3CCA3A3BF9595C89C9DC69699ACA09CFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            AAA4A2D1BBBBECEBECF6F6F7FAFAFAF2F3F3E7E7E7DFDFDFD9D4D3CFABACCF9C
            9CCC9291CC9191BD8485C79F9EC79696AFABA8FF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFAFA09BE6DFDFF1EEEDE8D4D3F2F1F1E7E7E7DEDEDED4BCBDD3AAAACC81
            81CC8181CC8181BC7779C99E9FAB6C54A85E38AB5F3AA3603F9269519D8F87FF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFB8AFACC6A5A2C27F7FC78D8FD0A9A9DCD2D3CDA6A5CD9190CC71
            71CB7171CB7271B76D6CAE6747C36131CD6939D26D40D16F46D4714DCE6B44AB
            5D3799877CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFA58A867CA0AB60DBDEA2C2BDC9938FC67677C66263C35E
            5EC35E5FC35E5FA75C51B05317C5611FCD6827D46D2F516D24686E2BD77244D7
            714BCD6A4196654AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFB48A8757B5C71DDBF61DDBF62EDAEC73CFD6AEA3A2C473
            76B85958AF494A9B543FB35309C45F0FCE6815BA6F1E396F233A6D228F722D80
            702FD77242D46F439A6241FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFC292933ACBDF1FDBF620DBF622DBF623DBF622DBF643D6
            E781B5BEB98484A85A4D94470CB25703CD6807A273153B73263B71244E72256A
            7224DA7330D87338D46F39967059FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFABA29FBC939628DBF42ADDF62FDDF631DEF632DEF630DEF62DDD
            F629DDF627DBF455C9D8919AA2AA6250B05B118876173B77293B7528487526D9
            7517DB751DDA7425D9732CC76629FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFA69490989BA134DEF63BDFF740E0F744E1F745E1F743E0F73FE0
            F739DFF732DEF62ADDF622DBF629D5ECA5654D497A2A3C7C2E3C7A2C3B782A8A
            781BDD760DDC7514DD751BDB74229B6947FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFB69A9580A8B145E1F74EE2F855E3F85AE4F85BE4F859E4F854E3
            F84CE2F743E1F738DFF72DDDF632D4E984664C3C80323D81323D7F30487D2C62
            7E26D87705DE7606707923DA7612A26A20FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFC7A7A674BDC958E4F863E6F96CE7F971E8F973E8F970E7F96AE6
            F961E5F855E3F848E1F73ADFF74FC4D8736B473D86383E85363D83357F83273E
            8031847D1DB47A0F3C7A2C7B7A1F597626AB9F97FF00FFFF00FFFF00FFFF00FF
            FF00FFACA5A2C4AAAB6FD4E16CE7F979E9F982EBFA89ECFA8BECFA88EBFA81EA
            FA76E8F968E6F958E4F848E1F76CB6C8617341428E3D478D3C4A8B3A61893349
            85335F822B4481303D7F303D7D2F3D7D2E9A897AFF00FFFF00FFFF00FFFF00FF
            FF00FFA19793B9A1A26FE5F57EEAFA8DECFA9AEEFBA1EFFBA3F0FBA0EFFB97EE
            FB89ECFA7AE9FA68E6F955E3F883A8B7808349B0A753A59F496A943F3F8D3C41
            8A3A4B88363E85363D83353D81333B8132958373FF00FFFF00FFFF00FFFF00FF
            FF00FFB4A59F9FA4A77BE9F98EECFAA0EFFBAFF1FCB8F3FCBBF3FCB6F3FCACF1
            FC9CEEFB89ECFA76E8F961E5F8969BA555884562A14F4F9B48639A4668974343
            913F4F8F3C468B3A3E89393E87373E87369C8D7EFF00FFFF00FFFF00FFFF00FF
            FF00FFCEC0BD90B1B786EBFA9CEFFBB1F2FCC1F4FCCCF6FDD0F6FDCAF5FDBDF4
            FCACF1FC97EEFB81EAFA6AE6F9A38F9091A86848A24F419D4A419B4840984540
            96444093423F91403F8F3E3F8C3C4B8A3AB0A49CFF00FFFF00FFFF00FFFF00FF
            ADAAA6CEC8C98BC4CC8EECFAA5F0FBBBF3FCCFF6FDDCF8FEE1F9FEDAF8FECAF6
            FDB6F2FCA0EFFB88ECFA70E8F9AB847FD0CB9167B36287B46553A552419E4B41
            9C484199474097454094434092416D8940FF00FFFF00FFFF00FFFF00FFFF00FF
            9D9994C4BEBF98A3A89AB9BFA9CFD5BFE8ECD4F7FDE5FAFEECFBFEE1F9FED0F7
            FDBBF3FCA3EFFB8BECFA77E5F5B48277EDE1AE69B76879B76743A75260A85341
            A24E419F4C419D4A419B48409946918960FF00FFFF00FFFF00FFFF00FFFF00FF
            A9A6A1CECDCDB0A9A9A295969E8E8FA18C8FA89394B8A9AAC7C0C1CDD5D8CAEB
            F1B8F3FCA1EFFB89EBFA7FD6E4B68E7DF4E8B6DADB9C59B4604EAF5993AF5AAD
            A44A60A44C4FA24B42A14D619C4CBBB5AEFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFB5B2AFAEA9A7B4AEA9C0B3AEC3B3AFC1AEAFB6A0A2AB8F90A88889A985
            85AC8F91A7A4A798B6BF92B2BABB9884F5E5B0F6DDA1F4D08CEEC074ECAF5BE8
            A042A19F40C48B22AD8A24A49575FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA19893C4A5A0B7A9A3B5A29BBBA4
            9ABE9F9EB99394B08686B08181C29F81F4DCA0F4D494F1C881EEBA6BEAAA53E7
            9B3BDA902ACB881EBF8D58FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA59996C29997FF00FFFF00FFABAF
            8E68B66B65AD6E7DAB7C93A081D6B981F2D08CF1C881EEBE71ECB15DE9A347E5
            9532E18D29BF986AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFEEFCFF9CEFFBFF00FF9CEFFBFF00FFAB9793B99D99FF00FFFF00FFFF00
            FFBDB8ABD1C387C4C475DAC376EFC379EFC075EEBA6BECB15DE9A64BE69D40DA
            A157B6A998FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFEAFCFFFF00FFC0AFADBAACA8FF00FFFF00FFFF00
            FFFF00FFFF00FFBFBAAFC4B28FE1BF85E8BD77E7B871DFB575C3A981BBB2A5FF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9CEFFBFF00
            FF9CEFFBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            9CEFFBFF00FFFF00FFFF00FFFF00FF9CEFFBFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9CEFFBFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          Layout = blGlyphTop
        end
        object BtnRepair: TBitBtn
          Left = 0
          Top = 135
          Width = 111
          Height = 81
          Caption = 'Repair'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = BtnRepairClick
          Glyph.Data = {
            520C0000424D520C0000000000003600000028000000210000001F0000000100
            1800000000001C0C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF45
            312E45312E402722FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            45312E45312E5C332D4C2A23FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            8F574C5B4D405E4935463629402621FFFFFFFFFFFFFFFFFFFFFFFF64372E512D
            2661352D6B3E3B7D4D4D8A65656539384827234A2822FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF715449F9C086E08D3ACB6B1B392A28FFFFFFFFFFFFFFFFFF0E0F9801
            0EB20D0D856D4456AD8585D4B3B3B6ACACA49C9C8F7373653A394727234A2822
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF8B6756F3B475DB832BB6631D392A28FFFFFFFFFFFF24147E
            0B47FF1257FF1B64F85349A6DCC0C0DABABAB8AAAAADA5A5ADA5A5A99E9E8D6F
            6F613736462521502C25FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF896756F2B373D98026B0632A362927562F286C40
            3C1E127C0F50FF1860FF2270FF37319DDCC0C0D8B6B6B39696AFA1A1AFA1A1AF
            A1A1AFA1A1AA9A9A876363502A27FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E5C4DF2B373D98026B0632A4A383790
            6564C6ADAD3F4EBB1358FF1E69FF2B7CFF362E98D2A8A8CC9999A673739C6D6D
            A58282AF9999B19C9C79E69A998882532A28FFFFFF00FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF736353ECA660D37515B26531
            A19595EAE2E2E8DEDE4050B91761FF2472FF3285FF33268DD1A5A5D5B0B0BB9D
            9DA882829C6C6C9B6969A47D7DB09292A07F7F532A28FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF998066ECA660D373
            13B86B42BDBABAEAE2E2E6DADA404FB21C69FF2B7CFF3B90FF373194DCC0C0DA
            BABABE9D9DA27575AC8686AE8888A27474996666936565532A28FFFFFF00FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF987E64EC
            A660D37313B96D46B7ABABD7B5B5CC99992F3BA22174FF3185FF429AFF373190
            DCC0C0DABABABF9A9AB38080C28F8FB07F7FAD8282B18888986969532A28FFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            96795DE6994DD26F11965D3DA88484D9B9B9E4D5D50A2199257DFF3890FF4BA4
            FF37318DDCC0C0DABABAC19797B38080CC9999CC9999C99696B17F7F9E6F6F53
            2A28FFFFFF00FFFFFFFFFFFF45312E45312E45312E45312E45312E45312E4531
            2E45312EA38363E6994DD370138F5C47BDBABAEAE2E2E8DEDE0B23962985FF3D
            99FF52AFFF37318ADCC0C0DABABAC29494B38080BF8C8CCC9999CC9999BF8C8C
            9D6A6A532A28FFFFFF00FFFFFF6D68752A4B6020465E20485F204960204A6220
            4B63204E65244858C89E74E49648D37013905D4ABDBABAEAE2E2E8DEDE0C2593
            2E8EFF44A3FF5BBAFF373187DCC0C0DABABAC49292B38080A976769F6C6CB683
            83BC89899E6969532A28FFFFFF00FFFFFF0583B62AA5D84DB4E74DB5E84DB5E8
            4DB6E94DB7EA4DB7EA4697BDC6996DE08D3AD36D15905D4ABDBABAEAE2E2E8DE
            DE0D26902B83EC3078DA3A81DA373183DCC0C0DABABAC58E8EB38080B38080B3
            8080B38080AC79799F6666532A28FFFFFF00FFFFFF2293C549B4E66AD0FF6AD0
            FF6AD0FF6AD0FF6AD0FF6AD0FF4E8199C6996DE08D3AD6701D936053ECE8E8EA
            E2E2E8DEDE383683767683636363404047615592DCC0C0DABABAC78B8BB38080
            C69393AF7C7CA37070BF8C8CA06565532A28FFFFFF00FFFFFF39A4CF48A9D872
            D5FF6FD5FF6FD5FF6FD5FF6FD5FF6FD5FF518499C49668A06D3AB8652496635D
            ECE8E8EAE2E2E8DEDED7CCD2A6A6A6D2D3D4909091D0B8BEDCC0C0DABABAC888
            88A67373C69393CC9999CC9999BF8C8CA16262532A28FFFFFF00FFFFFF42AED2
            3C98C683DCFF75DBFF75DBFF75DBFF75DBFF75DBFF5891A6404040D7D7D77070
            70574A49ECE8E8EAE2E2E8DEDEB9B0B0CCCCCCBFC0C1858686DEC4C4DCC0C0DA
            BABACA8585BF7373B26E6EA87171B68383BC8989A26161532A28FFFFFF00FFFF
            FF48B5D33EA4CC98E3FF78DEFF6EB4CA82B5C65F8F9F5A93A674D4F262828C81
            81816F6F6FBFBEBEECE8E8DED7D7A2A0A0D4D4D4D4D4D4AEAFB0B6B7B8A5A4A5
            968A8ADABABACC8282C87070C87070C87070BF6D6DAE6A6AA65F5F532A28FFFF
            FF00FFFFFF4CBBD546B0D69ADBF466ACBFC1C1C1F4F4F4D4BEBEB99393484B4D
            797979C6C6C6BCBCBCA6A6A6A6A4A4B3B0B0FCFCFCE9E9E9CCCCCCBCBDBDC1C2
            C3DBDCDDE4E4E49F9999F6E8E8E7BFBFD38888C96C6CC96C6CC96C6CB05E5E53
            2A28FFFFFF00FFFFFF4FBDD650BCE299D3ED6F8F96D1D1D1DEDEDEC7C6C6A89E
            9E6B6666686767B8B8B8C3C3C3CECECE909090B6B3B3EEEEEEF9F9F99393937D
            7A7AD2D1D1D4D5D6ECECEDC6BFBFF3E6E6F3E6E6F3E6E6F0DEDEE3B5B5D68C8C
            B25A5A5A2F2BFFFFFF00FFFFFF55BED85BC6EC9ED1EB839699BEBEBEB9B9B9C6
            C6C6CCCCCC808080737373ABABABB6B6B6C0C0C0CBCBCB8F8F8F9494948F8F8F
            A0A0A08C8080999292CBCDCDD5D6D7A49797E3C7C7E3C7C7E3C7C7DCBFBFC6A5
            A5A882828F6464894841FFFFFF00FFFFFF59C0DA6AD0F674C0E67D9093D2D2D2
            B9B9B9F4F4F4F9F9F97070707C7C7C9D9D9DA7A7A7B3B3B3BDBDBDC8C8C8C9C9
            C9A9A9A97E7676D4A8A88E8383BEC0C0868485A57E7EA779798E5D5D88525085
            48449A534BFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF5EC1DB78D7FD5DBDEDBBEE
            F26B8A8C92ABAD8C8C8C6C6C6CA2A2A2BFBFBFB3B3B3A7A7A7A6A6A6A9A9A996
            A9AA6D97997F8C8C918484A47171726565838A8A8F8180FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF64C3DD81DBFF5D
            C3F5C9F6FE96FCFF96FCFF96FCFF96FCFF96FCFF96FCFF7ECBCC7ECBCC7ECBCC
            96FCFF96FCFF96FCFF96FCFF84D7D97DE3FE86D9D993F2F2CECFD2FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF68C4DE
            88E0FF6BD1FD7FD2FCBCEFFFBFF2FFBFF2FFBFF2FFBFF2FFBFF2FFBFF2FFBFF2
            FFBFF2FFBFF2FFBFF2FFBFF2FFBFF2FFBFF2FFC2EFFFE6FFFFE6FFFFE6C6C0FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FF6DC6DF92E8FF7AE0FF76DCFF72D8FF72D8FF72D8FF72D8FF72D8FF72D8FF72
            D8FF72D8FF72D8FF72D8FF72D8FF72D8FF72D8FF72D8FF55C5EF343F48FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFF73C7E19AEDFF81E7FF81E7FF81E7FF81E7FF81E7FF81E7FF81E7FF
            A0EDFFA0EDFFA0EDFFA0EDFFA0EDFFA0EDFFA0EDFFA0EDFFA0EDFF78D5F0474B
            51FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00FFFFFF77C9E3B6F7FF8BF1FF8BF1FF8BF1FF8BF1FF8BF1FF8BF1
            FFD3F9FFAFDEEE80CAE380CAE380CAE380CAE380CAE380CAE380CAE380CAE36B
            B9D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFF608FA5CAECF5C0FAFFADF9FFADF9FFADF9FFAD
            F9FFD6FCFF9FD8EB327994FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF6D8EA080CCE680CCE680CCE6
            80CCE680CCE670C6E2618192FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
          Layout = blGlyphTop
        end
      end
    end
    object TbsInstallationType: TTabSheet
      Caption = 'TbsInstallationType'
      object RdGrpInstallationType: TRadioGroup
        Left = 20
        Top = 18
        Width = 311
        Height = 138
        Caption = ' Installation type '
        ItemIndex = 0
        Items.Strings = (
          'Client'
          'Server')
        TabOrder = 0
        OnExit = RdGrpInstallationTypeExit
      end
    end
    object TbsInstallationInfo: TTabSheet
      Caption = 'TbsInstallationInfo'
      ImageIndex = 6
      TabVisible = False
      object Panel1: TPanel
        Left = 0
        Top = 2
        Width = 601
        Height = 391
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 30
          Top = 12
          Width = 496
          Height = 13
          Caption = 
            '1 - Verificar se os aplicativos est'#227'o no diret'#243'rio "C:\Program F' +
            'iles\MainRetail\Suporte\"'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object AbMeter1: TAbMeter
          Left = 169
          Top = 201
          Width = 181
          Height = 16
          Orientation = moHorizontal
          UnusedColor = clWhite
          UsedColor = clNavy
          Visible = False
        end
        object Button2: TButton
          Left = 52
          Top = 32
          Width = 109
          Height = 25
          Caption = 'Verificar arquivos'
          TabOrder = 0
        end
        object CheckBox1: TCheckBox
          Left = 52
          Top = 64
          Width = 244
          Height = 17
          Caption = 'Verificar UpdatePack4.zip'
          TabOrder = 1
        end
        object CheckBox2: TCheckBox
          Left = 52
          Top = 87
          Width = 259
          Height = 17
          Caption = 'Verificar CashRegister.zip'
          TabOrder = 2
        end
        object CheckBox3: TCheckBox
          Left = 52
          Top = 131
          Width = 224
          Height = 17
          Caption = 'Verificar Instalador.zip'
          TabOrder = 4
        end
        object CheckBox4: TCheckBox
          Left = 52
          Top = 153
          Width = 219
          Height = 17
          Caption = 'Verificar MRReportInstall.exe'
          TabOrder = 5
        end
        object CheckBox5: TCheckBox
          Left = 52
          Top = 175
          Width = 279
          Height = 17
          Caption = 'Verificar MSDE.zip ou SQL Server zip'
          TabOrder = 6
        end
        object btnExtract: TButton
          Left = 52
          Top = 197
          Width = 109
          Height = 25
          Caption = 'Extrair arquivos'
          TabOrder = 8
        end
        object CheckBox8: TCheckBox
          Left = 52
          Top = 231
          Width = 424
          Height = 17
          Caption = 
            'Extrair os todos os zips para o diret'#243'rio "C:\Program Files\Main' +
            'Retail\"'
          TabOrder = 7
          OnClick = CheckBox8Click
        end
        object Panel2: TPanel
          Left = 15
          Top = 253
          Width = 591
          Height = 144
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 9
          object lbSQLInfo: TLabel
            Left = 230
            Top = 11
            Width = 350
            Height = 13
            Caption = 
              'Instalar o SQL Server manualmente antes de clicar em "Instalar S' +
              'ervidor"'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object rgServer: TRadioGroup
            Left = 37
            Top = 0
            Width = 185
            Height = 33
            Caption = '  Tipo de Servidor  '
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'MSDE'
              'SQL Server')
            TabOrder = 0
            OnClick = rgServerClick
          end
          object btnMSDE: TButton
            Left = 37
            Top = 40
            Width = 109
            Height = 25
            Caption = 'Instalar Servidor'
            TabOrder = 1
          end
          object CheckBox6: TCheckBox
            Left = 37
            Top = 75
            Width = 354
            Height = 17
            Caption = 'MSDE/SQL Server instalado'
            TabOrder = 2
          end
          object CheckBox7: TCheckBox
            Left = 37
            Top = 100
            Width = 255
            Height = 17
            Caption = 'Restaurar o banco de dados MainRetail'
            TabOrder = 3
          end
          object CheckBox52: TCheckBox
            Left = 37
            Top = 124
            Width = 255
            Height = 17
            Caption = 'Atualizar o UpdatePack 4'
            TabOrder = 4
          end
        end
        object CheckBox51: TCheckBox
          Left = 52
          Top = 109
          Width = 259
          Height = 17
          Caption = 'Verificar POSServer.zip'
          TabOrder = 3
        end
      end
    end
    object TbsInstallationComponents: TTabSheet
      Caption = 'TbsInstallationComponents'
      ImageIndex = 3
      object LblTitle: TLabel
        Left = 34
        Top = 11
        Width = 154
        Height = 13
        Caption = 'Execute the following steps'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 34
        Top = 67
        Width = 545
        Height = 8
        Shape = bsTopLine
      end
      object LblRepairMessage: TLabel
        Left = 35
        Top = 313
        Width = 309
        Height = 18
        Caption = 'MainRetail will be repaired automatically'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ChkBxInstallSQLSERVER: TCheckBox
        Left = 34
        Top = 41
        Width = 381
        Height = 17
        Caption = 'Install SQLSERVER 2008 R2 Express Edition'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object ChkBxInstallMRReport: TCheckBox
        Left = 34
        Top = 81
        Width = 204
        Height = 17
        Caption = 'Install MRReport'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object ChkBxInstallDSIClient: TCheckBox
        Left = 34
        Top = 106
        Width = 204
        Height = 17
        Caption = 'Install DSI Client'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object ChkBxInstallIPDialBridge: TCheckBox
        Left = 34
        Top = 131
        Width = 204
        Height = 17
        Caption = 'Install IP Dial Bridge'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object ChkBxInstallU209: TCheckBox
        Left = 34
        Top = 156
        Width = 204
        Height = 17
        Caption = 'Install U209'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object ChkBxInstallTSP100: TCheckBox
        Left = 34
        Top = 181
        Width = 204
        Height = 17
        Caption = 'Install TSP100'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object ChkBxInstallPID: TCheckBox
        Left = 34
        Top = 206
        Width = 204
        Height = 17
        Caption = 'Install Pet Industry Database'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object ChkBxInstallMRImportExport: TCheckBox
        Left = 232
        Top = 81
        Width = 177
        Height = 17
        Caption = 'Install MRImportExport'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object ChkBxInstallSwitchDB: TCheckBox
        Left = 232
        Top = 106
        Width = 177
        Height = 17
        Caption = 'Install SwitchDB'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object ChkBxInstallMRPoleDisplay: TCheckBox
        Left = 232
        Top = 131
        Width = 177
        Height = 17
        Caption = 'Install Pole Display'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object ChkBxInstallMRPoleDisplaySvr: TCheckBox
        Left = 232
        Top = 156
        Width = 177
        Height = 17
        Caption = 'Install Pole Display Server'
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
      object PnlClientInstallationInfo: TPanel
        Left = 34
        Top = 239
        Width = 545
        Height = 67
        BevelInner = bvRaised
        BevelOuter = bvLowered
        ParentBackground = False
        ParentColor = True
        TabOrder = 17
        object Label3: TLabel
          Left = 18
          Top = 7
          Width = 86
          Height = 13
          Caption = 'Server IP address'
        end
        object EdtServerIPAddress: TEdit
          Left = 18
          Top = 23
          Width = 251
          Height = 21
          TabOrder = 0
        end
      end
      object ChkBxBackupDatabase: TCheckBox
        Left = 418
        Top = 106
        Width = 177
        Height = 17
        Caption = 'Backup Database from this host'
        Checked = True
        State = cbChecked
        TabOrder = 13
      end
      object ChkBxInstallDotnetFramework: TCheckBox
        Left = 418
        Top = 131
        Width = 161
        Height = 17
        Caption = 'Install .Net Framework'
        Checked = True
        State = cbChecked
        TabOrder = 14
      end
      object ChkBxInstallWindowsPoweShell: TCheckBox
        Left = 418
        Top = 156
        Width = 161
        Height = 17
        Caption = 'Install Windows PoweShell'
        Checked = True
        State = cbChecked
        TabOrder = 15
      end
      object ChkBxInstallWindowsInstaller: TCheckBox
        Left = 418
        Top = 181
        Width = 161
        Height = 17
        Caption = 'Install Windows Installer'
        Checked = True
        State = cbChecked
        TabOrder = 16
      end
      object ChkBxRecalculateInventoryValues: TCheckBox
        Left = 418
        Top = 81
        Width = 161
        Height = 17
        Caption = 'Recalculate inventory values'
        Checked = True
        State = cbChecked
        TabOrder = 12
      end
      object ChkBxInstallMAGSWIPE_CFG: TCheckBox
        Left = 232
        Top = 181
        Width = 177
        Height = 17
        Caption = 'Install MagSwipe Utility'
        Checked = True
        State = cbChecked
        TabOrder = 11
      end
    end
    object tsInstalEst: TTabSheet
      Caption = 'tsInstalEst'
      ImageIndex = 7
      TabVisible = False
      object Label9: TLabel
        Left = 34
        Top = 11
        Width = 254
        Height = 13
        Caption = '1 - Executar a instala'#231#227'o na seguinte ordem :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object CheckBox32: TCheckBox
        Left = 42
        Top = 178
        Width = 279
        Height = 17
        Caption = 'Configurar "MRReport.exe" '
        TabOrder = 0
      end
      object CheckBox33: TCheckBox
        Left = 42
        Top = 249
        Width = 508
        Height = 17
        Caption = 'Executar o MainRetail e alterar tradu'#231#227'o'
        TabOrder = 1
      end
      object CheckBox34: TCheckBox
        Left = 42
        Top = 273
        Width = 508
        Height = 17
        Caption = 'Executar o Office Manager e alterar tradu'#231#227'o'
        TabOrder = 2
      end
      object CheckBox35: TCheckBox
        Left = 42
        Top = 226
        Width = 508
        Height = 17
        Caption = 'Registrar DLL "midas.dll", "Roboex32.dll" e "crpe32.dll"'
        TabOrder = 3
      end
      object Button9: TButton
        Left = 42
        Top = 197
        Width = 156
        Height = 25
        Caption = 'Registrar DLL'
        TabOrder = 4
      end
      object Button10: TButton
        Left = 42
        Top = 147
        Width = 156
        Height = 25
        Caption = 'Criar Report INI'
        TabOrder = 5
      end
      object Button11: TButton
        Left = 42
        Top = 38
        Width = 156
        Height = 25
        Caption = 'Executar UpdatePack4'
        TabOrder = 6
      end
      object CheckBox37: TCheckBox
        Left = 42
        Top = 70
        Width = 255
        Height = 17
        Caption = 'Executar o Update Pack'
        TabOrder = 7
      end
      object Button12: TButton
        Left = 42
        Top = 92
        Width = 156
        Height = 25
        Caption = 'Executar MRReportInstall'
        TabOrder = 8
      end
      object CheckBox38: TCheckBox
        Left = 42
        Top = 124
        Width = 419
        Height = 17
        Caption = 'Instalar o programa "MRReportInstall.exe"'
        TabOrder = 9
      end
    end
    object tsConfiguracao: TTabSheet
      Caption = 'Configuracao'
      ImageIndex = 1
      TabVisible = False
      object Label4: TLabel
        Left = 30
        Top = 10
        Width = 416
        Height = 13
        Caption = 
          '1 - Clicar no bot'#227'o abaixo para atualizar e ocultar os menus n'#227'o' +
          ' utilizados'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMenu: TLabel
        Left = 145
        Top = 35
        Width = 82
        Height = 13
        Caption = 'Menu atualizado!'
        Visible = False
      end
      object Label5: TLabel
        Left = 30
        Top = 67
        Width = 207
        Height = 13
        Caption = '2 - Verificar as configura'#231#245'es abaixo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Button1: TButton
        Left = 40
        Top = 30
        Width = 96
        Height = 25
        Caption = 'Configurar Menu'
        TabOrder = 0
      end
      object CheckBox16: TCheckBox
        Left = 41
        Top = 88
        Width = 481
        Height = 17
        Caption = 'Office Manager - Empresa'
        TabOrder = 1
      end
      object CheckBox17: TCheckBox
        Left = 41
        Top = 108
        Width = 481
        Height = 17
        Caption = 'Office Manager - Banco'
        TabOrder = 2
      end
      object CheckBox18: TCheckBox
        Left = 41
        Top = 129
        Width = 481
        Height = 17
        Caption = 'Office Manager - Agencia Banc'#225'ria'
        TabOrder = 3
      end
      object CheckBox19: TCheckBox
        Left = 41
        Top = 149
        Width = 481
        Height = 17
        Caption = 'Office Manager - Contas Banc'#225'ria'
        TabOrder = 4
      end
      object CheckBox21: TCheckBox
        Left = 41
        Top = 170
        Width = 481
        Height = 17
        Caption = 'MainRetail - verificar categoria de impostos'
        TabOrder = 5
      end
      object CheckBox22: TCheckBox
        Left = 41
        Top = 191
        Width = 481
        Height = 17
        Caption = 'MainRetail - verificar lojas'
        TabOrder = 6
      end
      object CheckBox23: TCheckBox
        Left = 41
        Top = 211
        Width = 481
        Height = 17
        Caption = 'MainRetail - verificar tipos de pagamentos'
        TabOrder = 7
      end
      object CheckBox24: TCheckBox
        Left = 41
        Top = 233
        Width = 481
        Height = 17
        Caption = 'MainRetail - Criar os caixas'
        TabOrder = 8
      end
      object CheckBox25: TCheckBox
        Left = 41
        Top = 256
        Width = 481
        Height = 17
        Caption = 'MainRetail - Configura'#231#227'o do Cliente'
        TabOrder = 9
      end
      object CheckBox26: TCheckBox
        Left = 41
        Top = 278
        Width = 481
        Height = 17
        Caption = 'MainRetail - Revisar configura'#231#227'o do Servidor'
        TabOrder = 10
      end
      object CheckBox27: TCheckBox
        Left = 41
        Top = 301
        Width = 481
        Height = 17
        Caption = 'MainRetail - Revisar configura'#231#227'o da comiss'#227'o (% ou $)'
        TabOrder = 11
      end
    end
    object tsPOSServer: TTabSheet
      Caption = 'tsPOSServer'
      ImageIndex = 4
      TabVisible = False
      object Label10: TLabel
        Left = 34
        Top = 11
        Width = 254
        Height = 13
        Caption = '1 - Executar a instala'#231#227'o na seguinte ordem :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 47
        Top = 42
        Width = 96
        Height = 13
        Alignment = taRightJustify
        Caption = 'RemoteWorkingDir :'
      end
      object Label13: TLabel
        Left = 148
        Top = 63
        Width = 128
        Height = 13
        Caption = 'Diret'#243'rio dos caixas (.VEN)'
      end
      object Label14: TLabel
        Left = 69
        Top = 85
        Width = 73
        Height = 13
        Alignment = taRightJustify
        Caption = 'ServerFilesDir :'
      end
      object Label15: TLabel
        Left = 147
        Top = 106
        Width = 175
        Height = 13
        Caption = 'Diret'#243'rio dos arquivos globais (.XML)'
      end
      object edtRemoteWorkDir: TEdit
        Left = 146
        Top = 39
        Width = 230
        Height = 21
        MaxLength = 50
        TabOrder = 0
        Text = 'C:\Program Files\MainRetail\PDV\LogFiles'
      end
      object Button14: TButton
        Left = 144
        Top = 127
        Width = 156
        Height = 25
        Caption = 'Criar dir e salva registro'
        TabOrder = 1
      end
      object edtServerFileDir: TEdit
        Left = 145
        Top = 82
        Width = 230
        Height = 21
        MaxLength = 50
        TabOrder = 2
        Text = 'C:\Program Files\MainRetail\PDV\PDVFiles'
      end
      object CheckBox36: TCheckBox
        Left = 41
        Top = 161
        Width = 481
        Height = 17
        Caption = 'POSServer - verificar configura'#231#227'o do Servidor '
        TabOrder = 3
      end
      object CheckBox39: TCheckBox
        Left = 41
        Top = 184
        Width = 481
        Height = 17
        Caption = 'POSServer - programar hor'#225'rios'
        TabOrder = 4
      end
      object CheckBox40: TCheckBox
        Left = 41
        Top = 207
        Width = 481
        Height = 17
        Caption = 'POSServer - programar o setup dos caixas'
        TabOrder = 5
      end
      object CheckBox41: TCheckBox
        Left = 41
        Top = 230
        Width = 481
        Height = 17
        Caption = 'POSServer - fechou e abriu o POSServer'
        TabOrder = 6
      end
      object CheckBox42: TCheckBox
        Left = 41
        Top = 253
        Width = 481
        Height = 17
        Caption = 'POSServer - gerou o cadastro'
        TabOrder = 7
      end
      object CheckBox43: TCheckBox
        Left = 41
        Top = 276
        Width = 481
        Height = 17
        Caption = 'POSServer - verificou se os arquivos XML est'#227'o no diret'#243'rio'
        TabOrder = 8
      end
    end
    object tsPDV: TTabSheet
      Caption = 'tsPDV'
      ImageIndex = 5
      TabVisible = False
      object Label8: TLabel
        Left = 34
        Top = 11
        Width = 254
        Height = 13
        Caption = '1 - Executar a instala'#231#227'o na seguinte ordem :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 40
        Top = 340
        Width = 136
        Height = 13
        Caption = 'Impressora (Marca/Modelo):'
      end
      object Button15: TButton
        Left = 40
        Top = 203
        Width = 156
        Height = 25
        Caption = 'Salva registro'
        TabOrder = 0
      end
      object CheckBox44: TCheckBox
        Left = 38
        Top = 291
        Width = 481
        Height = 17
        Caption = 'PDV - verificar configura'#231#227'o do caixa'
        TabOrder = 1
      end
      object CheckBox45: TCheckBox
        Left = 38
        Top = 314
        Width = 481
        Height = 17
        Caption = 'PDV - verificar configura'#231#227'o da impressora fiscal'
        TabOrder = 2
      end
      object CheckBox46: TCheckBox
        Left = 73
        Top = 365
        Width = 481
        Height = 17
        Caption = 'PDV - verificar configura'#231#227'o das aliquotas'
        TabOrder = 3
      end
      object CheckBox47: TCheckBox
        Left = 73
        Top = 388
        Width = 481
        Height = 17
        Caption = 'PDV - verificar configura'#231#227'o das formas de pagamento'
        TabOrder = 4
      end
      object CheckBox48: TCheckBox
        Left = 73
        Top = 411
        Width = 481
        Height = 17
        Caption = 'PDV - verificar configura'#231#227'o do TEF'
        TabOrder = 5
      end
      object CheckBox49: TCheckBox
        Left = 38
        Top = 434
        Width = 481
        Height = 17
        Caption = 'PDV - verificar configura'#231#227'o da balan'#231'a'
        TabOrder = 6
      end
      object rgTipoPDV: TRadioGroup
        Left = 42
        Top = 33
        Width = 185
        Height = 35
        Caption = '  Tipo do PDV  '
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'DB'
          'TXT')
        TabOrder = 7
      end
      object Panel3: TPanel
        Left = 33
        Top = 69
        Width = 585
        Height = 131
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 8
        object Label16: TLabel
          Left = 9
          Top = 8
          Width = 96
          Height = 13
          Alignment = taRightJustify
          Caption = 'RemoteWorkingDir :'
        end
        object Label17: TLabel
          Left = 9
          Top = 48
          Width = 226
          Height = 13
          Caption = 'Diret'#243'rio dos caixas que fica no servidor (.VEN)'
        end
        object Label18: TLabel
          Left = 9
          Top = 69
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'ServerFilesDir :'
        end
        object Label19: TLabel
          Left = 9
          Top = 110
          Width = 283
          Height = 13
          Caption = 'Diret'#243'rio dos arquivos globais que est'#227'o no servidor (.XML)'
        end
        object btnRemoteDir: TSpeedButton
          Left = 238
          Top = 23
          Width = 23
          Height = 22
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0000000000000000000000000000000000000000000000000000000000
            00000000000000000000FF00FFFF00FF009E9C009E9C009E9C009E9C009E9C00
            9E9C009E9C009E9C009E9C009E9C009E9C009E9C000000000000FF00FFFF00FF
            009E9CFFFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF9CCFFF63CF
            CE009E9C000000000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CCFFF9CFFFF9C
            CFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000009E9C000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF009E
            9C000000009E9C000000009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9C
            FFFF9CFFFF9CCFFF9CFFFF63CFCE00000063CFCE63CFCE000000009E9CFFFFFF
            9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE0000
            0063CFCE63CFCE000000009E9C009E9C009E9C009E9C009E9C009E9C009E9C00
            9E9C009E9C009E9C009E9C009E9C63CFCE9CFFFF63CFCE000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
            FF9CFFFF63CFCE000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
            FFFF9CFFFF9CFFFFFFFFFFFFFFFFFFFFFFFFFFFF63CFCE000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFFFFFFFF009E9C009E9C009E9C009E
            9C009E9C009E9CFF00FFFF00FFFF00FF009E9CFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF009E9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF009E9C009E9C009E9C009E9C009E9CFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object SpeedButton1: TSpeedButton
          Left = 240
          Top = 86
          Width = 23
          Height = 22
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0000000000000000000000000000000000000000000000000000000000
            00000000000000000000FF00FFFF00FF009E9C009E9C009E9C009E9C009E9C00
            9E9C009E9C009E9C009E9C009E9C009E9C009E9C000000000000FF00FFFF00FF
            009E9CFFFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF9CCFFF63CF
            CE009E9C000000000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CCFFF9CFFFF9C
            CFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000009E9C000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF009E
            9C000000009E9C000000009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9C
            FFFF9CFFFF9CCFFF9CFFFF63CFCE00000063CFCE63CFCE000000009E9CFFFFFF
            9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE0000
            0063CFCE63CFCE000000009E9C009E9C009E9C009E9C009E9C009E9C009E9C00
            9E9C009E9C009E9C009E9C009E9C63CFCE9CFFFF63CFCE000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
            FF9CFFFF63CFCE000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
            FFFF9CFFFF9CFFFFFFFFFFFFFFFFFFFFFFFFFFFF63CFCE000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFFFFFFFF009E9C009E9C009E9C009E
            9C009E9C009E9CFF00FFFF00FFFF00FF009E9CFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF009E9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF009E9C009E9C009E9C009E9C009E9CFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object edtPOSRemote: TEdit
          Left = 9
          Top = 24
          Width = 230
          Height = 21
          MaxLength = 50
          TabOrder = 0
          Text = 'C:\Program Files\MainRetail\PDV\LogFiles'
        end
        object edtPOSServerFiles: TEdit
          Left = 9
          Top = 86
          Width = 230
          Height = 21
          MaxLength = 50
          TabOrder = 1
          Text = 'C:\Program Files\MainRetail\PDV\PDVFiles'
        end
      end
      object CheckBox50: TCheckBox
        Left = 38
        Top = 268
        Width = 481
        Height = 17
        Caption = 'PDV - configura'#231#227'o do teclado'
        TabOrder = 9
      end
      object Button16: TButton
        Left = 40
        Top = 233
        Width = 156
        Height = 25
        Caption = 'Criar configura'#231#227'o do teclado'
        TabOrder = 10
      end
      object edtImpressora: TEdit
        Left = 179
        Top = 337
        Width = 154
        Height = 21
        TabOrder = 11
        Text = 'N'#227'o tem impressora'
      end
    end
    object TbsDone: TTabSheet
      Caption = 'TbsDone'
      ImageIndex = 2
      object Label11: TLabel
        Left = 20
        Top = 18
        Width = 63
        Height = 13
        Alignment = taRightJustify
        Caption = 'Information :'
      end
      object MemoInfo: TMemo
        Left = 20
        Top = 38
        Width = 574
        Height = 373
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object pnlBotton: TPanel
    Left = 0
    Top = 544
    Width = 625
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      625
      31)
    object imgBotton: TImage
      Left = 0
      Top = 0
      Width = 625
      Height = 31
      Align = alClient
      Picture.Data = {
        07544269746D61705E050000424D5E0500000000000036000000280000000E00
        00001E0000000100180000000000280500000000000000000000000000000000
        0000AE8D51AE8D51AD8C50AD8C50AD8C50AC8B4FAC8B4FAC8B4FAC8B4FAC8B4F
        AC8B4FAC8B4FAC8B4FAC8B4F0000D7D1C6D7D1C6D6D0C6D6D0C6D6D0C6D6D0C6
        D6D0C6D6D0C6D6D0C6D6D0C6D6D0C6D6D0C6D6D0C6D6D0C60000D8D2C8D8D2C8
        D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2
        C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2
        C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2
        C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2
        C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8
        D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8
        D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8
        D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7
        0000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7
        D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7
        D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8
        D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2
        C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2
        C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2
        C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2
        C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8
        D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8
        D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8
        D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7
        0000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7
        D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7
        D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D8D2C8D8D2C8
        D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2
        C7D8D2C70000D8D2C8D8D2C8D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2
        C7D8D2C7D8D2C7D8D2C7D8D2C7D8D2C70000D9D3C8D9D3C8D9D3C8D9D3C8D9D3
        C8D9D3C8D9D3C8D9D3C8D9D3C8D9D3C8D9D3C8D9D3C8D9D3C8D9D3C80000DBD5
        CADBD5CADBD5CADBD5CADBD5CADBD5CADBD5CADBD5CADBD5CADBD5CADBD5CADB
        D5CADBD5CADBD5CA0000DCD6CCDCD6CCDCD6CCDCD6CCDCD6CCDCD6CCDCD6CCDC
        D6CCDCD6CCDCD6CCDCD6CCDCD6CCDCD6CCDCD6CC0000DED8CDDED8CDDED8CDDE
        D8CDDED8CDDED8CDDED8CDDED8CDDED8CDDED8CDDED8CDDED8CDDED8CDDED8CD
        0000E0DBD0E0DBD0E0DBD0E0DBD0E0DBD0E0DBD0E0DBD0E0DBD0E0DBD0E0DBD0
        E0DBD0E0DBD0E0DBD0E0DBD00000E2DCD2E2DCD2E2DCD2E2DCD2E2DCD2E2DCD2
        E2DCD2E2DCD2E2DCD2E2DCD2E2DCD2E2DCD2E2DCD2E2DCD20000E4DFD4E4DFD4
        E4DFD4E4DFD4E4DFD4E4DFD4E4DFD4E4DFD4E4DFD4E4DFD4E4DFD4E4DFD4E4DF
        D4E4DFD40000E7E1D6E7E1D6E6E1D6E6E1D6E6E1D6E6E1D6E6E1D6E6E1D6E6E1
        D6E6E1D6E6E1D6E6E1D6E6E1D6E6E1D60000FFFBFFFFFBFFFFFBFFFFFBFFFFFB
        FFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFF0000B4A9
        9BB4A99BB4A99BB4A99BB4A99BB4A99BB4A99BB4A99BB4A99BB4A99BB4A99BB4
        A99BB4A99BB4A99B0000}
      Stretch = True
    end
    object btnClose: TBitBtn
      Left = 529
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Close'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnNext: TBitBtn
      Left = 435
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Next >>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnNextClick
    end
    object btnPrior: TBitBtn
      Left = 341
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = ' << Back'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnPriorClick
    end
  end
  object PnlProcessEvolution: TPanel
    Left = 38
    Top = 376
    Width = 545
    Height = 123
    BevelInner = bvLowered
    Ctl3D = False
    ParentColor = True
    ParentCtl3D = False
    TabOrder = 2
    Visible = False
    DesignSize = (
      545
      123)
    object LblStepDescription: TLabel
      Left = 10
      Top = 25
      Width = 126
      Height = 18
      Caption = 'Step description '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblItemDescription: TLabel
      Left = 10
      Top = 50
      Width = 80
      Height = 13
      Caption = 'Item description '
    end
    object ProgressBarExterno: TAbMeter
      Left = 10
      Top = 83
      Width = 525
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      Orientation = moHorizontal
      UnusedColor = clWhite
      UsedColor = clNavy
      Visible = False
    end
    object ProgressBar: TProgressBar
      Left = 10
      Top = 68
      Width = 525
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      Step = 1
      TabOrder = 0
      Visible = False
    end
  end
  object PnlReleaseVersion: TPanel
    Left = 160
    Top = 512
    Width = 276
    Height = 24
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object BtnSaveReleaseOption: TBitBtn
      Left = 142
      Top = 1
      Width = 23
      Height = 22
      TabOrder = 1
      TabStop = False
      OnClick = BtnDownLoadClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000C1761BC27519
        BD6B13B96504B96504B96504BA6504BA6504BA6504BA6504BA6504BA6504BA65
        04BC690AB96A15C3791FD5933DEFB736CDC6C0E9F8FFDBE5F6DBE8F8DBE8F8DB
        E8F9DBE8F8DAE7F8DBE7F8D8E4F5E9F6FFCDC6C0EAA714C0761DCD9551E8AE3C
        DCD7D4ECE8E9ADA0A2A79B9E9E939594898C8A818583797C7B7276685F64ECE8
        E9DCD7D4E59E20C77B25D09653EAB447DCD7D4EFF0EFDFDEDCE1E0DFE0DFDEDF
        E0DDE0DFDDDFDEDDDFE0DEDBD9D9EDEDEDDCD7D4E7A62BC9802BD49B58EBB950
        DCD7D4ECE8E9A99D9FA4999E9A919492888B897F8582797C7A7177655C62ECE8
        E9DCD7D4E8AC37CC8531D69E5BEDBD5ADCD7D4FFFFFFFFFEFEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD7D4EAB340D08B34D9A45EF0C263
        DCD7D4ECE8E9A99D9FA4999E9A919492888B897F8582797C7A7177655C62ECE8
        E9DCD7D4EDB749D2903AD8A35CF0C66DDCD7D4FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCD7D4EEBD54D7963EDEAC69F9D281
        C1975C9A7B6095775E97795D97795D97795D97795D97795C97795C95775E9A7A
        5EC19A64F7CA6BD99B44DDAB67F6D58BFFD056C0A887C8C5C9CEC6BFCDC6C0CD
        C6C0CDC6BFD6D0CAD6D3D0CFCED4C0A888FFD25DF3CC75DCA148DCA966F6D993
        FBC85DC2B4A2D7DEEBDDDDDDDCDDDEDCDBDDE7E8EAC8BAA7A29692C2B4A2C6BC
        A9FBCB63F3D07EE0A74CE5B973F6DA97FBCC62C8BAA7DDE0E9E1DFDDE0DFDEDF
        DDDCEFF3F99F886FE5AF479E9189C7BDB2FDCF6AF5D484E3AC51E9BC75F8DD9E
        FDCF69CEC0AFE3E7EFE7E5E3E6E5E4E5E4E2F1F6FFBAA386FFE873B5AB9ECAC0
        B8FFD26EF9DA8EE7B25BEAC079F8E09BFBD165D3C4AFEAEEF6ECEBE8ECEBE9EB
        E9E6FBFFFFA28E78DEAF4FA89C95D1C7B9FFDA78F5D889E2A442ECC47EFEF4D5
        FFE290DCD7D4F5FFFFF6FEFFF6FEFFF6FDFFFFFFFFDFDDDCC8BAA7DFDDDCE5E4
        E2FFDE88E4AA45DD9734ECC681F0CA82F4CA7DE8C788EFCF94EED192EDCF92EE
        D092EED093F2D396F7D79BF6D69BE6C48AEBB552E19E35000000}
    end
    object CbxReleaseType: TComboBox
      Left = 0
      Top = 3
      Width = 146
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
      Items.Strings = (
        'Stable Release'
        'Release Candidate'
        'Beta Release')
    end
  end
  object BtnTests: TButton
    Left = 170
    Top = 30
    Width = 186
    Height = 25
    Caption = 'Close'
    TabOrder = 4
    Visible = False
    OnClick = BtnTestsClick
  end
  object ADODBConnect: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=MainRetailDB;Data Source=(local)'
    ConnectionTimeout = 10
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 584
    Top = 541
  end
  object cmdUpdateMenu: TADOCommand
    CommandText = 
      'UPDATE MenuItem'#13#10'SET Visible = :Visible'#13#10'WHERE (IDMenu = 2 AND I' +
      'DSubMenu = 1)'#13#10'OR (IDMenu = 2 AND IDSubMenu = 2)'#13#10'OR (IDMenu = 2' +
      ' AND IDSubMenu = 3)'#13#10'OR (IDMenu = 2 AND IDSubMenu = 5)'#13#10'OR (IDMe' +
      'nu = 2 AND IDSubMenu = 8)'#13#10'OR (IDMenu = 2 AND IDSubMenu = 10)'#13#10'O' +
      'R (IDMenu = 2 AND IDSubMenu = 11)'#13#10'OR (IDMenu = 3 AND IDSubMenu ' +
      '= 3)'#13#10'OR (IDMenu = 3 AND IDSubMenu = 4)'#13#10'OR (IDMenu = 3 AND IDSu' +
      'bMenu = 5)'#13#10'OR (IDMenu = 3 AND IDSubMenu = 6)'#13#10'OR (IDMenu = 3 AN' +
      'D IDSubMenu = 7)'#13#10'OR (IDMenu = 3 AND IDSubMenu = 8)'#13#10'OR (IDMenu ' +
      '= 3 AND IDSubMenu = 9)'#13#10'OR (IDMenu = 3 AND IDSubMenu = 10)'#13#10'OR (' +
      'IDMenu = 4 AND IDSubMenu = 1)'#13#10'OR (IDMenu = 4 AND IDSubMenu = 3)' +
      #13#10'OR (IDMenu = 4 AND IDSubMenu = 7)'#13#10'OR (IDMenu = 5 AND IDSubMen' +
      'u = 5)'#13#10'OR (IDMenu = 5 AND IDSubMenu = 6)'#13#10'OR (IDMenu = 5 AND ID' +
      'SubMenu = 7)'#13#10'OR (IDMenu = 5 AND IDSubMenu = 9)'#13#10'OR (IDMenu = 5 ' +
      'AND IDSubMenu = 12)'#13#10'OR (IDMenu = 5 AND IDSubMenu = 13)'#13#10'OR (IDM' +
      'enu = 5 AND IDSubMenu = 15)'#13#10'OR (IDMenu = 5 AND IDSubMenu = 16)'#13 +
      #10'OR (IDMenu = 6 AND IDSubMenu = 2)'#13#10'OR (IDMenu = 6 AND IDSubMenu' +
      ' = 3)'#13#10'OR (IDMenu = 6 AND IDSubMenu = 4)'#13#10'OR (IDMenu = 6 AND IDS' +
      'ubMenu = 5)'#13#10'OR (IDMenu = 8 AND IDSubMenu = 2)'#13#10'OR (IDMenu = 8 A' +
      'ND IDSubMenu = 3)'#13#10'OR (IDMenu = 8 AND IDSubMenu = 10)'#13#10'OR (IDMen' +
      'u = 9 AND IDSubMenu = 2)'#13#10'OR (IDMenu = 9 AND IDSubMenu = 3)'#13#10'OR ' +
      '(IDMenu = 9 AND IDSubMenu = 4)'#13#10
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'Visible'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end>
    Left = 540
    Top = 541
  end
  object UnZipper: TAbUnZipper
    ArchiveProgressMeter = AbVCLMeterLink1
    ExtractOptions = [eoCreateDirs, eoRestorePath]
    Left = 366
    Top = 541
  end
  object AbVCLMeterLink1: TAbVCLMeterLink
    Meter = AbMeter1
    Left = 496
    Top = 541
  end
  object Email1: TEmail
    ShowDialog = False
    UseAppHandle = False
    Left = 409
    Top = 541
  end
  object OD: TOpenDialog
    Left = 453
    Top = 541
  end
end
