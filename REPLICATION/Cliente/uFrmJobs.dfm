object FrmJobs: TFrmJobs
  Left = 185
  Top = 35
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Server Manager'
  ClientHeight = 392
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 351
    Width = 436
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      436
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 436
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object BitBtn1: TBitBtn
      Left = 275
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 355
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 15
    Top = 10
    Width = 401
    Height = 321
    Caption = 'Server info '
    TabOrder = 0
    object Label3: TLabel
      Left = 55
      Top = 247
      Width = 74
      Height = 13
      Caption = 'Host Name/IP :'
    end
    object Label4: TLabel
      Left = 55
      Top = 279
      Width = 25
      Height = 13
      Caption = 'Port :'
    end
    object Label1: TLabel
      Left = 55
      Top = 162
      Width = 57
      Height = 13
      Caption = 'Proxy User :'
    end
    object Label2: TLabel
      Left = 55
      Top = 194
      Width = 52
      Height = 13
      Caption = 'Password :'
    end
    object Label5: TLabel
      Left = 55
      Top = 73
      Width = 66
      Height = 13
      Caption = 'Proxy Server :'
    end
    object Label6: TLabel
      Left = 55
      Top = 102
      Width = 54
      Height = 13
      Caption = 'Proxy Port :'
    end
    object Image1: TImage
      Left = 10
      Top = 30
      Width = 32
      Height = 34
      AutoSize = True
      Picture.Data = {
        07544269746D6170F60C0000424DF60C00000000000036000000280000002000
        0000220000000100180000000000C00C00000000000000000000000000000000
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF996B4DB75B25C4612FCD693AD26D
        43D47049CD6A43AA613FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF866224AD4A0BB65213C05C1BCA6623D16D
        2D476D23977035D77247D06D44996950FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF537E333D7C2E8C570EB35004BF5B09CC660FAE70
        1B3A7023426F236B7128CB733AD671429C684CFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF6886423E84363D8233686D20B75301C35E01D06902A674
        113B74273B72268F7521CF7425D9732FD57034FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF93876A3E8E3D3F8B3B5C782AA45508BC5903C86506C6720A647B
        243C7A2C3C782A6C7821DE7510DC7519DB7422BC6528FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5884983384A91C9CD6
        1D96CD307DA08286455D7E30716F24A94E06B75708C4650E797E283B85363D82
        333D80313C7E2F537D29C1790CDB77088F781EC57518FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B98D03B93BA6696AC8AA1AC
        6996AA4F8CA1877028905B13AD4B04B5560AC06514CE7721688C393F8B3B3E88
        393E86365484325D812D7D7F20977B173D7A2C697A22857B5EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF4484A2239CD37296A7FF00FFFF00FFFF00FF
        FF00FFAEA99F529946A2590FB6570CC06618CC7A29D78D3BCF9B485596445E94
        42799540628F3A3E87384085353C82343D80313C7E2F74744CFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF1988BB5089A4FF00FFFF00FFFF00FFFF00FF
        FF00FFB3B0A543AE576A9340C36A1BCD7E2FD89346E0A55ADFB3687AA75696A8
        56619A48649643488F3E568D394589383E86373E833575784FFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF1581B24B7082FF00FFFF00FFFF00FFFF00FF
        FF00FFC0BDB753B55F44B25B6AA44FD5994CE3AC65EAC07DD7C883B1C17A4CA2
        4F419B484299464196444093413F903F3F8D3D3E8A3A898566FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF84939A1768BA185DAF396D8DFF00FFFF00FFFF00FF
        FF00FFFF00FFADA85B43BA6284B05BD7AF63E8C481F2D99DF2E3ABE6DEA36FB6
        6680B26346A14D419D4A419A47409745409442439241FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF2E7A9C2B77C22D75E11A5EBF206596FF00FFFF00FF
        FF00FFFF00FFB5A68267B85FBBB25E5FBB648BC779C8DC9C96D28BFAEEBC92C5
        7D60B25F52A9545DA65140A24E419E4B419C496E914BFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF82949D1CB6EA16A6DC277BBC367CE31E64CD1760A3FF00FF
        FF00FFFF00FFFF00FF8EC272BEB76145C06746BE6561C471F8F2C1F9EEBBF0DF
        A4A3C276A9B563DCA74E97A245809A3C659B42FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF4C829935D4FD20C9FD17B3ED1C7EB93981DD226DD91861AC
        FF00FFFF00FFFF00FFB9B3A47CC56F47C56B47C36945C167D3DFA1F7E3AAF4D8
        99F1C881EDB665E8A347D19532CE871CBB8B57FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF4594B248DDFE26D1FE20C9FD19BCF8148CC5327ECB2573D3
        FF00FFFF00FFFF00FFFF00FFB2B4A36CCD7847C96E45C66CA1CF82F3D290F1CA
        83EEBD6FEBAC56E79B3BE28D28BF9565FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF5B889D73E4FD2ED8FE26D1FE20C9FD19BFFC108AC05B889F
        FF00FFFF00FFFF00FFFF00FFFF00FFCFCDC7C6B989CCC679EEC175EFBF73EDB8
        68EBAD57E7A349D9A25AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF60B3D04DE0FE2CD8FE26D1FE20C9FD337F9FFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF708F9F80DBF23ADDFF2CD8FE26D1FE1BA1D08D989D
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF528CA67CE3FA35DCFF2CD8FE26D1FD1B9CCB
        778A93FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF5295B176E5FD33DBFF2CD8FE27D1FE
        1AAADB5D7F8FFF00FFFF00FF6E8B9A156EB5286B968F9AA0FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF569CB972E5FE33DBFF2CD8FE
        26D1FE1BB4E74478909DA0A2306F8D2D84DD1D75D91667A8718793FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5BA1BE7AE6FD37DCFF
        2CD8FE27D1FE1EBFF2129AD011ABEC108CC83185D2237FE41569B253798DFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5492AD84E0F6
        42DEFF2CD8FE26D1FE20C9FD19BFFC12B7FB0D97D52982C52A87EB166BBE4275
        92FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5E8BA1
        82D2E955E1FF2ED8FE27D1FE20C9FD19BFFC12B7FB0DA1E52080BD2E8AEA1773
        BAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        839AA66BB5D075E6FE38DAFE28D2FE20C8FD19BFFC12B7FB0DA9F0157EB94E83
        A0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFB9BFC25997B282CEE585E6FC65DEFE5FD7FD63D3FD38B3E84F86A0FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFAAB5BA6B8FA06094AA5D8EA46490A498A8B0FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF}
      Transparent = True
    end
    object Bevel2: TBevel
      Left = 55
      Top = 30
      Width = 336
      Height = 11
      Shape = bsTopLine
    end
    object Bevel3: TBevel
      Left = 53
      Top = 227
      Width = 336
      Height = 11
      Shape = bsTopLine
    end
    object Image2: TImage
      Left = 10
      Top = 223
      Width = 30
      Height = 31
      AutoSize = True
      Picture.Data = {
        07544269746D61705A0B0000424D5A0B00000000000036000000280000001E00
        00001F0000000100180000000000240B00000000000000000000000000000000
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF999797857D7D817675837574817777
        868282A1A0A0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        FF00FFFF00FFFF00FFA79E93BB833EBD7E2F957C5F968F8F9791919791919791
        91969090918E8E8A7F7EA99191C4AEAED1BFBFD6C1C1D6BBBBCFB3B2C4A0A0AB
        87868A72718C8989FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF
        00FFFF00FFCBA46CDDB479D39E59C2802C9E776B9570709168688C6161724C4C
        A68686D7D0D0DEDADADCD8D8DAD3D3D9CFCFD8C7C6C09D9CB58D8DC6A1A1CEA8
        A8AF84837F7574FF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
        FFE4C99BF5E3BEE3BE88C98C3FB18676AE8787AB84849B7575A38282E1DDDCE8
        E5E4E8E5E4E5E3E1DDDBDBDAD3D3D1BEBED1BBBBA09595A18181B38686CFA6A5
        B38483989696FF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFB0A696
        EAD5ACD8B37CAA8356D9D8D8EDEDEDF1F1F1D2D2D2CDB9B7EAE8E7EFEEEEF1F0
        F0ECEAEAE5E2E0DCD8D8C7AEAED6C3C2A88B8BA98989B28E8ECFA8A8C9989797
        8A8AFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FF867E7E8E7D7687
        736870605F8D8C8CA5A5A5C7C7C7D1D1D1C6B6B5EEECECF7F7F7FAFAFAF1F0F0
        E8E6E5DDDADAC8A4A4D1B2B2B08282B18181BA8A89CFA8A8CA9998A79F9FFF00
        FFFF00FF0000FF00FFFF00FFFF00FF9D9A9A8E7B7BAB9393C0A4A4C5A9A8C5A4
        A4BF9C9CAD8A899478787C7171918787E6E0E0F3EEEEEEE2E2F0F0EFE8E6E5DC
        D8D8C89F9FC79696BA7A79BC7776C28484CEA7A6B18F8EFF00FFFF00FFFF00FF
        0000FF00FFFF00FF958383C9B8B8DCD7D7DBD6D6D9D2D2DACDCDD9C5C5CDAEAE
        C29D9DD0AFAEC69D9D977474887C7CB99D9DC68888CD9596D7BBBAD4BEBECC9D
        9DC47E7DC1706FC56E6EC87E7DAF9494FF00FFFF00FFFF00FFFF00FF0000FF00
        FF9A8C8CDAD3D2E4E2E1E5E2E1E2DFDEDCD9D9DAD2D2D4C2C2C5A8A7A18F8FA3
        7D7DBB9191CEA3A39A73739B7A75969B7C87D599C0B19ACC8989C67674C96B6A
        CA6969C86565A97878FF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFC7B2B1
        E8E6E5EDECECEEEDEDEAE9E9E3E1DFDCD7D7C9B2B2D7C4C4A68D8DA78B8BAF8B
        8BD0A8A7AE8483B0867E7BA8763FD16F3DD06D64D1819EBB90C98F89C36A69B8
        5954A37877FF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFCFBDBBEDECECF5
        F5F5F8F8F8F0EFEFE8E6E4DDDADAC7A5A4D2B8B8AE8484AF8382B78B8BCEA8A8
        A57D79BB938D6DBA7B4AD47647D37442D2713ED06E43CE6F7AC084B29983BA79
        789B8C8CFF00FFFF00FFFF00FFFF00FF0000FF00FFB2A8A8EDEAEAF7F7F7FAF9
        F9F2F1F0E8E6E5DDDADAC8A1A0C89D9CB77C7BB87B7AC08685CCA6A593786EC6
        9B9B68CA8056D87F52D77C4DD57847D37441D1703BCF6C35CD6853C6738EA37B
        B67D78A68F8FFF00FFFF00FF0000FF00FFFF00FFB9B1B1D0B8B8C58686D6ADAD
        E1D6D5D7C8C8CB9F9FC58383BF7272C27070C78180BA9393878075BE979569DC
        8963DC875FDB8358D98051D77B4AD47642D2713BCF6C34CD6830CC6536CA67B8
        837EFF00FFFF00FF0000FF00FFFF00FFFF00FFA38985AB9D87ACC5A2CF9B97C7
        8685C7807FC86E6DC96C6BCA6868AF7676CECDCD9B978DAC9E9175E29371E190
        6CDF8C64DD875CDA8153D77C4AD47641D17139CF6B33CD6737CA65AD7E7EFF00
        FFFF00FF0000FF00FFFF00FFFF00FFAA8B817EA3753DD06D4ED0748DCC95C0A3
        90CA7978C36463BA5956A67977D1D1D1AFA79AA0A79083E79C7FE59978E39570
        E08F67DD885CDA8252D77C48D4753ED16F37CE6949BE66AB8A89FF00FFFF00FF
        0000FF00FFFF00FFFF00FFBA928A70B67A47D37444D27240D16F3DD06E66CB80
        9EAB88C6807AAE7473938F8CCBB3B0A0B99791EBA68BE9A284E79D7BE49770E1
        8F65DD885AD9814ED57944D2723BCF6C5DB56AA59191FF00FFFF00FF0000FF00
        FFFF00FFABACA8C79B9A69C57E53D77C4FD67A4AD47645D2733FD06F39CE6B42
        CB6E79B47C947965CDB6B6A4CDA39EF0AF98EDAA8FEBA584E79D79E3956DE08D
        60DB8454D77D48D4753ED06E6EAA6CFF00FFFF00FFFF00FF0000FF00FFFF00FF
        979790C1999867D88660DB855BDA8155D87E4FD67A48D37440D17039CF6B32C7
        6468A570C1B1B1ACE1B1AAF3B7A2F1B298EEAB8DEAA381E69B73E29266DD8859
        D9804CD57841D1707FA171FF00FFFF00FFFF00FF0000FF00FFFF00FF97968CB1
        9B9272E1906EDF8E68DE8A61DC8559D98151D67B48D37540D16F35C3658CB594
        B5A5A5B8F4BEB3F7BDAAF4B7A0F0B093ECA785E89E78E3946ADF8B5CDA814FD6
        7A43D2728D9A73FF00FFFF00FFFF00FF0000FF00FFFF00FFA7A397A1A48F80E6
        9A7CE49775E2926DDF8D64DD875AD98150D67B46D37437BC63B6C7B6A7A59DC0
        FBC6B9F9C1B0F5BBA4F2B396EDAA88E9A07BE4966CDF8C5EDB8350D67B45D273
        A1987EFF00FFFF00FFFF00FF0000FF00FFFF00FFC8B1AB9FB5968DEAA388E9A0
        81E69B79E3956EE08E63DC8658D9804DD5783AB763D4D6D39F9594A7AC9EADC1
        A8ACD5AEA4E8B097EDAA88E9A07BE4966CDF8C5EDB8351D67B44D273AE9888FF
        00FFFF00FFFF00FF0000FF00FFBAB6B3CEB6B6A2C8A09BEFAC95ECA88CEAA382
        E69C77E3946BDF8C5FDB8353D77C43C76E96C6A5C0C9BFCCC4C4C6BDBCB8A8A8
        AB9595A598919FA89190BB907BCB8B60D8834FD67A45D272A68683FF00FFFF00
        FFFF00FF0000FF00FFA9A39DC5B4B4AADBADA7F3B5A0F0B096EDA98BE9A27FE5
        9972E19165DD8758D87F4BD4773FCD6E749B6AA49D9CBCBCBAB0ACA9B2AEA9C3
        B6B6CDB4B4CBAFAFBFA0A0B391909D958289A17B9B8383FF00FFFF00FFFF00FF
        0000FF00FFA7A29FB8A8A7B5F0BBB1F6BCA9F3B69EF0AF92ECA684E79D77E394
        69DE8A5BDA814ED57943D2728A9D73FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFC6C4C4B1ABABB1A5A5BDA8A7C19B9AA99E9DFF00FFFF00FFFF00FF0000FF00
        FFB7B3B2AAA49FBEFAC5B8F8C0AFF5BAA3F1B296EDA988E9A07AE4966CDF8C5D
        DA8250D67B44D2739B9679FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFD3D0CE
        A19B96B0C6ACB4DBB4AFEFB9A4F2B397EDAA89E9A07BE4976CDF8C5EDB8351D6
        7B45D273AB9988FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFCBCDCACEC9C9C1
        B8B8B2A4A4A59292A59E95A1B09897C09683D2946DDE8C5DDA8250D67A44D272
        AA8A85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFBAB9B8AEAE
        AABBB4AFC6BDB7CBB9B9C9AFAFBC9D9DAF908D9A9A8584A87F70B5789D8281FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFBBB8B8B1AAAAB4A6A6C4ACACC8A8A7C19897A09090FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0000}
      Transparent = True
    end
    object Label7: TLabel
      Left = 55
      Top = 45
      Width = 77
      Height = 13
      Caption = 'Socket version :'
    end
    object edtHost: TEdit
      Left = 158
      Top = 244
      Width = 225
      Height = 21
      TabOrder = 6
    end
    object edtPort: TEdit
      Left = 158
      Top = 276
      Width = 72
      Height = 21
      TabOrder = 7
    end
    object edtUser: TEdit
      Left = 158
      Top = 159
      Width = 225
      Height = 21
      TabOrder = 4
    end
    object edtProxServer: TEdit
      Left = 158
      Top = 70
      Width = 225
      Height = 21
      TabOrder = 1
    end
    object edtProxPort: TEdit
      Left = 158
      Top = 99
      Width = 72
      Height = 21
      TabOrder = 2
    end
    object edtPW: TMaskEdit
      Left = 158
      Top = 191
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 5
    end
    object cbxSocketVer: TComboBox
      Left = 158
      Top = 41
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'svNoSocks'
      OnChange = cbxSocketVerChange
      Items.Strings = (
        'svNoSocks'
        'svSocks4'
        'svSocks4A'
        'svSocks5')
    end
    object chkAuthentic: TCheckBox
      Left = 55
      Top = 131
      Width = 166
      Height = 17
      Caption = 'Authentication'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = chkAuthenticClick
    end
  end
  object siLang: TsiLang
    version = '5.2.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = DMGlobal.LanguageDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Portugu'#234's'
      'Espa'#241'ol')
    Language = 'English'
    ExtendedTranslations = <>
    Left = 376
    Top = 8
    TranslationData = {
      737443617074696F6E730D0A5446726D4A6F627301536572766572204D616E61
      67657201436F6E666967757261E7E36F20646F207365727669646F7201010D0A
      50616E656C31010101010D0A4C6162656C3401506F7274203A01506F72746120
      3A01010D0A42697442746E31012653617665012653616C76617201010D0A4269
      7442746E32012643616E63656C012643616E63656C617201010D0A4C6162656C
      310150726F78792055736572203A01557375E172696F20646F2050726F78793A
      01010D0A4C6162656C320150617373776F7264203A0153656E68613A01010D0A
      4C6162656C3301486F7374204E616D652F4950203A01486F7374204E616D652F
      4950203A01010D0A4C6162656C350150726F787920536572766572203A015365
      727669646F722050726F78793A01010D0A4C6162656C360150726F787920506F
      7274203A0153656E68613A01010D0A47726F7570426F78320153657276657220
      696E666F2001436F6E666967757261E7E36F20646F207365727669646F720101
      0D0A4C6162656C3701536F636B65742076657273696F6E203A01566572E7E36F
      20646F20536F636B65743A01010D0A63686B41757468656E7469630141757468
      656E7469636174696F6E01417574656E74696361E7E36F01010D0A737448696E
      74730D0A5446726D4A6F627301010D0A50616E656C31010101010D0A42657665
      6C31010101010D0A4C6162656C3401010D0A42697442746E3101010D0A426974
      42746E3201010D0A4C6162656C3101010D0A4C6162656C3201010D0A4C616265
      6C3301010D0A426576656C3201010D0A4C6162656C3501010D0A4C6162656C36
      01010D0A47726F7570426F783201010D0A496D6167653101010D0A426576656C
      3301010D0A496D6167653201010D0A4C6162656C3701010D0A656474486F7374
      01010D0A656474506F727401010D0A6564745573657201010D0A65647450726F
      7853657276657201010D0A65647450726F78506F727401010D0A656474505701
      010D0A636278536F636B657456657201010D0A63686B41757468656E74696301
      010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D0A544672
      6D4A6F6273014D532053616E732053657269660101010D0A73744D756C74694C
      696E65730D0A636278536F636B65745665722E4974656D730173764E6F536F63
      6B732C7376536F636B73342C7376536F636B7334412C7376536F636B73350101
      010D0A7374446C677343617074696F6E730D0A5761726E696E67015761726E69
      6E670101010D0A4572726F72014572726F720101010D0A496E666F726D617469
      6F6E01496E666F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669
      726D0101010D0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F
      4B014F4B0101010D0A43616E63656C0143616E63656C0101010D0A41626F7274
      012641626F72740101010D0A5265747279012652657472790101010D0A49676E
      6F7265012649676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20
      546F20416C6C014E266F20746F20416C6C0101010D0A59657320546F20416C6C
      0159657320746F2026416C6C0101010D0A48656C70012648656C700101010D0A
      7374537472696E67730D0A73744F74686572537472696E67730D0A50616E656C
      312E48656C704B6579776F7264010101010D0A426576656C312E48656C704B65
      79776F7264010101010D0A4C6162656C342E48656C704B6579776F7264010101
      010D0A42697442746E312E48656C704B6579776F7264010101010D0A42697442
      746E322E48656C704B6579776F7264010101010D0A4C6162656C312E48656C70
      4B6579776F7264010101010D0A4C6162656C322E48656C704B6579776F726401
      0101010D0A4C6162656C332E48656C704B6579776F7264010101010D0A426576
      656C322E48656C704B6579776F7264010101010D0A4C6162656C352E48656C70
      4B6579776F7264010101010D0A4C6162656C362E48656C704B6579776F726401
      0101010D0A5446726D4A6F62732E48656C7046696C65010101010D0A5446726D
      4A6F62732E48656C704B6579776F7264010101010D0A47726F7570426F78322E
      48656C704B6579776F7264010101010D0A496D616765312E48656C704B657977
      6F7264010101010D0A426576656C332E48656C704B6579776F7264010101010D
      0A496D616765322E48656C704B6579776F7264010101010D0A4C6162656C372E
      48656C704B6579776F7264010101010D0A656474486F73742E48656C704B6579
      776F7264010101010D0A656474486F73742E496D654E616D65010101010D0A65
      6474486F73742E54657874010101010D0A656474506F72742E48656C704B6579
      776F7264010101010D0A656474506F72742E496D654E616D65010101010D0A65
      6474506F72742E54657874010101010D0A656474557365722E48656C704B6579
      776F7264010101010D0A656474557365722E496D654E616D65010101010D0A65
      6474557365722E54657874010101010D0A65647450726F785365727665722E48
      656C704B6579776F7264010101010D0A65647450726F785365727665722E496D
      654E616D65010101010D0A65647450726F785365727665722E54657874010101
      010D0A65647450726F78506F72742E48656C704B6579776F7264010101010D0A
      65647450726F78506F72742E496D654E616D65010101010D0A65647450726F78
      506F72742E54657874010101010D0A65647450572E456469744D61736B010101
      010D0A65647450572E48656C704B6579776F7264010101010D0A65647450572E
      496D654E616D65010101010D0A65647450572E54657874010101010D0A636278
      536F636B65745665722E48656C704B6579776F7264010101010D0A636278536F
      636B65745665722E496D654E616D65010101010D0A636278536F636B65745665
      722E546578740173764E6F536F636B730101010D0A63686B41757468656E7469
      632E48656C704B6579776F7264010101010D0A73744C6F63616C65730D0A4375
      7272656E637920537472696E6701240101010D0A54686F7573616E6420536570
      617261746F72012C0101010D0A446563696D616C20536570617261746F72012E
      0101010D0A4461746520536570617261746F72012F0101010D0A53686F727420
      4461746520466F726D6174014D2F642F797979790101010D0A4C6F6E67204461
      746520466F726D617401646464642C204D4D4D4D2064642C2079797979010101
      0D0A54696D6520536570617261746F72013A0101010D0A54696D6520414D2053
      7472696E6701414D0101010D0A54696D6520504D20537472696E6701504D0101
      010D0A53686F72742054696D6520466F726D617401683A6D6D20414D504D0101
      010D0A4C6F6E672054696D6520466F726D617401683A6D6D3A737320414D504D
      0101010D0A53686F7274204D6F6E7468204E616D6573014A616E2C4665622C4D
      61722C4170722C4D61792C4A756E2C4A756C2C4175672C5365702C4F63742C4E
      6F762C4465630101010D0A4C6F6E67204D6F6E7468204E616D6573014A616E75
      6172792C46656272756172792C4D617263682C417072696C2C4D61792C4A756E
      652C4A756C792C4175677573742C53657074656D6265722C4F63746F6265722C
      4E6F76656D6265722C446563656D6265720101010D0A53686F72742044617920
      4E616D65730153756E2C4D6F6E2C5475652C5765642C5468752C4672692C5361
      740101010D0A4C6F6E6720446179204E616D65730153756E6461792C4D6F6E64
      61792C547565736461792C5765646E65736461792C54687572736461792C4672
      696461792C53617475726461790101010D0A7374436F6C6C656374696F6E730D
      0A737443686172536574730D0A5446726D4A6F62730144454641554C545F4348
      41525345540101010D0A}
  end
end