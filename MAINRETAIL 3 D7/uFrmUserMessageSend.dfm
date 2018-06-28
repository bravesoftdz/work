inherited FrmUserMessageSend: TFrmUserMessageSend
  Left = 195
  Top = 158
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'User Message Send'
  ClientHeight = 293
  ClientWidth = 456
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 252
    Width = 456
    object lbChar: TLabel [0]
      Left = 8
      Top = 18
      Width = 3
      Height = 13
    end
    inherited EspacamentoInferior: TPanel
      Width = 456
      inherited Panel3: TPanel
        Width = 456
      end
    end
    inherited hhh: TPanel
      Left = 208
      Width = 248
      inherited sbHelp: TSpeedButton
        Left = 30
        Visible = False
      end
      inherited btClose: TButton
        Left = 173
        ModalResult = 2
      end
      object btnSend: TButton
        Left = 101
        Top = 3
        Width = 66
        Height = 31
        Caption = 'Send'
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnSendClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 92
    Height = 160
  end
  inherited EspacamentoDireito: TPanel
    Left = 453
    Top = 92
    Height = 160
  end
  inherited EspacamentoSuperior: TPanel
    Width = 456
  end
  object pnlUsers: TPanel [4]
    Left = 0
    Top = 6
    Width = 456
    Height = 86
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object btnSendTo: TSpeedButton
      Left = 5
      Top = 9
      Width = 71
      Height = 22
      Caption = 'To ...'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000130B0000130B00000000000000000000C65D29C65D29
        C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D
        29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C6
        5D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29984C26
        A24C2DAB5237B55641A85035A04B29AB4D22AF5B31C65D29C65D29C65D29C65D
        29C65D29C65D29C65D29C65D29D0481CEE5C41FF6E58FF7A60E48A5EE66E47F9
        624BAF5026338F331E821E37A9372FA52F2298221E7D209A6324C65D29D65931
        FF6E5AFF856BE67D52FBD4A2EA9569FF775ED6643D56C056ACC9965ABA585EC9
        5E43BC4324A4246F6920C65D29C85E29E8714CF2805ADE9471EAB892EA9D6DFF
        8266AE7C3F64BB62FFFFFBA2CBA071D1715CC95C248E249A6324C65D29C65D29
        7748353F191C06187B0A1C816036588A714162C26081C677D1D6D2A8C0C768AA
        6250AC50A5652FC65D29C65D293D24160A0B0A0A27621441A81444AD0E359C6F
        4243A96D318174391C85DC208BE4147EBF776648C65D29C65D299A4C24141614
        12181A1C5BC11C61CC1C62CE1C5DC518467D9862482B91E6359EFF359EFF359E
        FF227FC39E5C39C65D296F3C202727272226222370D62B83EE2D86F3277CE41E
        58946B67673FA9FF46AEFF46AEFF44ABFF39A1F9755D50C65D299A4C242C2E2C
        3F423F1C44752270DC2D89F23196FD1C5B8E6B67674EB5FF52BAFF52BAFF4EB6
        FF48B0FF6F686AC65D29C65D29543A2D4E4F4E6B6B69666A6B2F3B661A2C5673
        41286B67673198D83397D23D9EDC35A0E83598D86B6360C65D29C65D29C65D29
        5C4033797A79929492737573543A2DC65D2998644E2480B158ABDA8BC5EB7FBC
        DE2684B5A56245C65D29C65D29C65D29C65D29774229774229774229C65D29C6
        5D29C65D299862483D92C156A0C83B91C19C664AC65D29C65D29C65D29C65D29
        C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D
        29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C6
        5D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29C65D29}
      OnClick = btnSendToClick
    end
    object Label1: TLabel
      Left = 25
      Top = 65
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'Subject :'
    end
    object edtSubject: TEdit
      Left = 80
      Top = 60
      Width = 371
      Height = 21
      MaxLength = 99
      TabOrder = 0
    end
    object mmReceivers: TMemo
      Left = 81
      Top = 8
      Width = 369
      Height = 49
      TabStop = False
      ParentColor = True
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object pnlBody: TPanel [5]
    Left = 3
    Top = 92
    Width = 450
    Height = 160
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object memBody: TMemo
      Left = 0
      Top = 0
      Width = 450
      Height = 84
      Align = alClient
      MaxLength = 224
      TabOrder = 0
      OnChange = memBodyChange
    end
    object memoHistory: TMemo
      Left = 0
      Top = 84
      Width = 450
      Height = 76
      TabStop = False
      Align = alBottom
      Color = clScrollBar
      MaxLength = 255
      ReadOnly = True
      TabOrder = 1
      OnChange = memBodyChange
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmUserMessageSend.sil'
  end
end
