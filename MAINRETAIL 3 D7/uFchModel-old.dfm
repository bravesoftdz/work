inherited FchModel: TFchModel
  Left = 154
  Top = 139
  Caption = 'brwModel'
  ClientHeight = 546
  ClientWidth = 790
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 790
    Height = 34
    TabOrder = 7
    DesignSize = (
      790
      34)
    inherited Image1: TImage
      Width = 516
    end
    inherited lblMenu: TLabel
      Left = 444
    end
    inherited EspacamentoSuperior: TPanel
      Width = 790
      Height = 0
      Visible = False
      inherited EEE: TPanel
        Width = 790
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 743
    end
  end
  inherited Panel1: TPanel
    Top = 505
    Width = 790
    TabOrder = 4
    inherited lblUserName: TLabel
      Left = 130
    end
    inherited EspacamentoInferior: TPanel
      Width = 790
      inherited Panel3: TPanel
        Width = 790
      end
    end
    inherited hhh: TPanel
      Left = 569
      inherited btCancel: TButton
        Caption = 'Close'
      end
    end
    inherited pnlNavigation: TPanel
      Left = 4
      Align = alNone
      inherited btFirstRec: TSpeedButton
        Left = 14
      end
      inherited btPriorRec: TSpeedButton
        Left = 39
      end
      inherited btNextRec: TSpeedButton
        Left = 64
      end
      inherited btLastRec: TSpeedButton
        Left = 89
      end
    end
  end
  inherited pnlKey: TPanel
    Top = 505
    Width = 790
    Height = 0
    Align = alBottom
    TabOrder = 2
    Visible = False
    inherited Panel4: TPanel
      Top = -2
      Width = 790
    end
  end
  inherited pnlDetail: TPanel
    Left = 0
    Top = 505
    Width = 790
    Height = 0
    Align = alBottom
    Visible = False
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 70
    Width = 0
    Height = 435
    TabOrder = 5
    Visible = False
  end
  object Panel5: TPanel [5]
    Left = 0
    Top = 70
    Width = 790
    Height = 435
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Choose a model !'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object pnlMaster: TPanel
      Left = 0
      Top = 0
      Width = 790
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label11: TLabel
        Left = 41
        Top = 30
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Model :'
      end
      object Label14: TLabel
        Left = 16
        Top = 53
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Description :'
      end
      object Label32: TLabel
        Left = 308
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
      object Label37: TLabel
        Left = 678
        Top = 50
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
      object Label21: TLabel
        Left = 4
        Top = 73
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Manufacturer :'
      end
      object Label20: TLabel
        Left = 24
        Top = 5
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Category :'
      end
      object Label2: TLabel
        Left = 309
        Top = 3
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
      object lbModelSubGroup: TLabel
        Left = 415
        Top = 27
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'Group :'
      end
      object lbModelGroup: TLabel
        Left = 377
        Top = 5
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sub-Category :'
      end
      object EditModel: TDBEdit
        Tag = 99
        Left = 80
        Top = 26
        Width = 226
        Height = 21
        DataField = 'Model'
        DataSource = dsForm
        TabOrder = 1
        OnExit = EditModelExit
      end
      object DBEditDescription: TDBEdit
        Tag = 99
        Left = 80
        Top = 48
        Width = 596
        Height = 21
        DataField = 'Description'
        DataSource = dsForm
        TabOrder = 4
      end
      object scSubManufacture: TDBSuperComboADO
        Tag = 99
        Left = 80
        Top = 70
        Width = 226
        Height = 21
        TabOrder = 5
        Text = 'scSubManufacture'
        FilterSugest = True
        LookUpSource = DM.dsLookUpFabricante
        DropDownRows = 18
        ShowEditCode = True
        IDLanguage = 0
        OnSelectItem = scSubManufactureSelectItem
        DataField = 'IDFabricante'
        DataSource = dsForm
      end
      object cmbGroup: TDBSuperComboADO
        Tag = 99
        Left = 80
        Top = 2
        Width = 226
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'cmbGroup'
        LookUpSource = DM.dsLookUpGroup
        DropDownRows = 18
        EditCodePos = taEditCodeRight
        IDLanguage = 0
        OnSelectItem = cmbGroupSelectItem
        DataField = 'GroupID'
        DataSource = dsForm
      end
      object scModelSubGroup: TDBSuperComboADO
        Tag = 99
        Left = 455
        Top = 23
        Width = 221
        Height = 21
        TabOrder = 3
        Text = 'scModelSubGroup'
        FilterSugest = True
        LookUpSource = DM.dsLookUpModelSubGroup
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
        OnSelectItem = scModelSubGroupSelectItem
        DataField = 'IDModelSubGroup'
        DataSource = dsForm
      end
      object scModelGroup: TDBSuperComboADO
        Tag = 99
        Left = 455
        Top = 1
        Width = 221
        Height = 21
        TabOrder = 2
        Text = 'scModelGroup'
        FilterSugest = True
        LookUpSource = DM.dsLookUpModelGroup
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
        OnSelectItem = scModelGroupSelectItem
        DataField = 'IDModelGroup'
        DataSource = dsForm
      end
    end
    object pnlAlways: TPanel
      Left = 0
      Top = 92
      Width = 790
      Height = 48
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lbLastMovDate: TLabel
        Left = 338
        Top = 6
        Width = 106
        Height = 13
        Alignment = taRightJustify
        Caption = 'Last Movement Date :'
      end
      object lblColor: TLabel
        Left = 44
        Top = 28
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'Color :'
      end
      object lblSize: TLabel
        Left = 50
        Top = 4
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'Size :'
      end
      object lbTotalOnHand: TLabel
        Left = 349
        Top = 29
        Width = 94
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total Qty OnHand :'
      end
      object scColor: TDBSuperComboADO
        Left = 80
        Top = 25
        Width = 226
        Height = 21
        TabOrder = 1
        Text = 'scColor'
        LookUpSource = DM.dsLookUpColor
        DropDownRows = 18
        ShowEditCode = True
        IDLanguage = 0
        DataField = 'IDColor'
        DataSource = dsForm
      end
      object scSize: TDBSuperComboADO
        Left = 80
        Top = 1
        Width = 226
        Height = 21
        TabOrder = 0
        Text = 'scSize'
        LookUpSource = DM.dsLookUpSize
        DropDownRows = 18
        ShowEditCode = True
        IDLanguage = 0
        DataField = 'IDSize'
        DataSource = dsForm
      end
      object DBEdit9: TDBEdit
        Left = 450
        Top = 25
        Width = 51
        Height = 21
        BiDiMode = bdLeftToRight
        DataField = 'TotQtyOnHand'
        DataSource = dsForm
        ParentBiDiMode = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 3
      end
      object pnlFloatPercent: TPanel
        Left = 509
        Top = 23
        Width = 173
        Height = 23
        BevelOuter = bvNone
        TabOrder = 4
        object lbFloatPercent: TLabel
          Left = 42
          Top = 6
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Caption = 'Float percent :'
        end
        object edtFloatPercent: TDBEdit
          Left = 116
          Top = 2
          Width = 51
          Height = 21
          BiDiMode = bdLeftToRight
          DataField = 'FloatPercent'
          DataSource = dsForm
          MaxLength = 2
          ParentBiDiMode = False
          TabOrder = 0
          OnKeyPress = edtFloatPercentKeyPress
        end
      end
      object DBEdit1: TDBEdit
        Left = 450
        Top = 2
        Width = 226
        Height = 21
        DataField = 'LastMovDate'
        DataSource = dsForm
        ParentColor = True
        ReadOnly = True
        TabOrder = 2
      end
    end
    object pgModel: TPageControl
      Left = 0
      Top = 140
      Width = 790
      Height = 295
      ActivePage = tbCostRetail
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnChange = pgModelChange
      object tsGrid: TTabSheet
        Caption = 'Matri&z'
        ImageIndex = 10
        object Shape3: TShape
          Left = 680
          Top = 16
          Width = 102
          Height = 251
          Align = alRight
          Brush.Color = 14607076
          Pen.Style = psClear
        end
        object btAddColor: TSpeedButton
          Left = 688
          Top = 16
          Width = 99
          Height = 27
          Caption = ' Add Vert.'
          Flat = True
          Glyph.Data = {
            A6080000424DA60800000000000036000000280000001A0000001B0000000100
            18000000000070080000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF63656B847D8CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63697B31305208084200005A5251
            63FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF42
            51731838941020A5080CAD0810B508084AFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF84828410598C105DAD0824A50814AD1020A50804
            4A6B696BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF847D7B10
            557318598C10388408206B002863084D5A29717B316973316573426573637984
            63828C5A75846B828CFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF636163293C4A52697B425973182C4221798421A6
            BD18BEDE31C7BD4AC3AD52C7A55ACBBD42C3D621A6CE0886AD106D8C4A6573FF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FF949A9C73797B42494A5A
            555AA59E9C5A5963525D638CAAB56BA6A529AA7331A66339A65252B65A39B273
            08AAC600A6F700AEF700B2EF0086AD21495AFF00FFFF00FF0000FF00FFFF00FF
            FF00FF8482848486849CAAB54A5D6B8C868CB5B2B5423C42848284A59E9C5AAA
            5A63BE524AA242429239428A5A2965AD1855DE1051E71855EF0865F700A6F700
            8AB55A5152FF00FF0000FF00FFFF00FF73757B5A75848CBED6428AAD425D6B94
            8E949C969C393C42948E8C8C9AA542B24A73C35A399231318A39296D8C3155EF
            213CDE1018BD213CDE3159F70865FF00B6EF183442FF00FF0000FF00FFFF00FF
            21516352AED6319ACE105D8C5A69739492947B757B21596B18AED610BEEF10C3
            D621BAB518AA8C1092A52165DE3159EF1020BD0000AD0810C61838F7086DFF00
            BEF710384AFF00FF0000FF00FF737D8408759C189AD61086C608517373797BA5
            A2A55A5D5A18617B009AC600C7F700C7F708C3F708B6EF10A6EF2161E73928C6
            3914B5521CAD63348C5279A508BAEF00C7FF10384AFF00FF0000FF00FF42555A
            0086B5088EC61079B521556B848684A5A6A542414218202100181842CFDE00C3
            F708BEF708B6EF31A6D69C716BEF594AE75131DE4D29EF5D4AEF554242A6B500
            B2DE393439FF00FF0000FF00FF73828C006994088ECE106D9C395D6B948E9494
            969C29303900455200A6B518CFF708C3F710BAF710B6EF29A6CE9C7173E75539
            D64510D64100D64D21AD654A18AED6085573FF00FFFF00FF0000FF00FFFF00FF
            2145520886B508618C52656B9C969C7B757331657308AAC600A2C6009EC600A2
            CE08A6D610AAE710B2EF4A96B5A56552B55939AD59397B7573219ABD08718C52
            595AFF00FFFF00FF0000FF00FFFF00FFFF00FF21556B104D6B63656B9CA2A563
            5D63187194008EB5102C31424D524261733169842175941082AD088ABD188EB5
            2986A52186AD1086AD21697B63696BFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FF8C8A94313C39736D739C9E9C42454A0861840071944A555AFF00FFFF00
            FFFF00FF948A8C6B6D73526D734A758C4A7D9452758463717BFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFC6C7CE6B696B7B797B8C868C42
            4542314D5A4A697BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FFBDBEBD6365638C8A8C6B656B736D73FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFB5B2B54A4D528C8A8C5A55529C
            9A9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FFADAAAD4241427B797B636163FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FF9C969C4A494A6361637B797BFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FF8C868C4245425A555A9C969CFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FF84868C313431736D6BFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FF8C8A8C292829848684FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFA5A6A5FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0000}
          Margin = 1
          Spacing = 1
          OnClick = btAddColorClick
        end
        object btAddSize: TSpeedButton
          Left = 687
          Top = 43
          Width = 100
          Height = 27
          Caption = ' Add Horiz.'
          Flat = True
          Glyph.Data = {
            A2070000424DA207000000000000360000002800000019000000190000000100
            1800000000006C070000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C2222000C0C000E0EFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF43151500
            131300A2A2005F5F1D0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF331A1A00252500A2A21EFFFF04CCCC003D3D000303FF00FFFF00FF
            FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF2B1F1F00070700767615FCFC49FFFF38FFFF
            00D6D6003D3D0F0000FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF451313002020008888
            0036360E5A5A4CFFFF5BFFFF29F6F600BFBF003838090000FF00FFFF00FFFF00
            FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            262222001A1A009E9E16FFFF168282192727257E7E49DDDD4FFFFF2AFFFF00C1
            C10046463C4F4FFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF3C1515000B0B00979717FFFF42FDFD52FFFF30A7A7020A
            0A1A58584CFFFF4CFFFF26FEFE03E6E6003D3D291212FF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3C18180026260065650048481A98
            9850FFFF5FFFFF43F0F023777717939343FFFFA3FFFF6FEBEB006969003939FF
            00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF262121000D
            0D00A6A60CE6E6032D2D22494947FEFE4CFFFF48FFFF4BFFFF4DFFFF64FFFFA1
            FDFD787D7D210C0CFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FF440E0E00181800AAAA17FFFF3DFAFA37C4C43DCBCB47FEFE4BFFFF3F
            FFFF2FFFFF86FFFFB2FFFF2E5353271D1DFF00FFFF00FFFF00FFFF00FF00FF00
            FFFF00FFFF00FFFF00FFFF00FF2B1E1E001F1F004F4F007E7E2FE2E262FFFF59
            FFFF4EFFFF47FEFE36F8F84DFFFF7BFFFF86DFDF6575752F2727FF00FFFF00FF
            FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FF331A1A00090900ADAD00
            A5A50001012670704FFFFF4AFFFF47FEFE47FEFE37FEFE69FFFFBBFFFF556C6C
            070202FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FF42
            111100242400ABAB17FEFE36F2F22E98981637371652523CCFCF3FFFFF37FEFE
            8DFFFF97F0F0375959372E2EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00FF00FFFF00FF181C1C00101000585804C9C938F3F363FFFF57FFFF217777
            071D1D2EBDBD58FFFF69FFFF97F0F0747E7E171111FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00FF00FF6B4A4A00000000A0A0006060001111
            30A8A856FFFF4AFFFF41E3E338D3D32DEEEE81FFFFBBFFFF365959171111FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006C6C6C6A6565
            46AAAA1CFFFF0CB5B52559593CC0C04DFFFF48FDFD3EFFFF4DFFFF72FFFF73DA
            DA556C6C3A2E2EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF000202027E9A9AB8FFFF69FFFF45FFFF4BFFFF48FFFF46FCFC46FE
            FE45FFFF5DFFFF8EFFFF477575070202FF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FF3A3E3E356363A9FFFF90FF
            FF35FFFF3EFFFF3CFAFA30FCFC8DFFFFA2FFFF225454242727FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00
            FFFF00FF241D1D707C7C8CE5E571FFFF48FFFF48FFFF71FFFF8BE5E5717C7C29
            1D1DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FF0C0808446161BEFFFF60FFFF60
            FFFFBEFFFF4461610D0808FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF
            00FF3A31314462628BFEFE8BFEFE4462623A3131FF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00FF00FFFF00FFFF00FFFF00FFFF00FF0D0A0A7FA5A57FA5A50D0A0AFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            404949404949FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FF00}
          Margin = 1
          Spacing = 2
          OnClick = btAddSizeClick
        end
        object btnAddSizeColor: TSpeedButton
          Left = 687
          Top = 70
          Width = 100
          Height = 27
          Caption = ' &3 Matrix'
          Flat = True
          Glyph.Data = {
            B6030000424DB603000000000000360000002800000012000000100000000100
            18000000000080030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
            008080808080808080808080808080800000FF00FFFF00FF000000000000FF9E
            9C633031000000FF00FFFF00FFFF00FF00000000000000000000000000000000
            00000000000000000000000000000000FF9E9CFF9E9CFF9E9C63303163303100
            0000FF00FF0000006361CE6361CE00000000808000FFFF00FFFF00FFFF80FFFF
            0000000000FF9E9CFF9E9CFF9E9CFF9E9C6330316330316330310000006361CE
            6361CE6361CE00000000808000FFFF00FFFF00FFFF80FFFF0000000000FF9E9C
            FF9E9CFF9E9CFF9E9C6330316330316330310000006361CE6361CE6361CE0000
            0000808000FFFF00FFFF00FFFF80FFFF0000000000FF9E9CFF9E9CFFFFFFFFFF
            FFFFCFCE6330316330310000000000006361CEFFFFFF00000000000000000000
            000000FFFF80FFFF0000000000FFFFFFFFFFFFFFCFCEFFCFCEFFCFCE00000000
            000036AC330080000000006361CE00000000808000FFFF00FFFF00FFFF80FFFF
            0000FF00FF000000FFCFCEFFCFCE00000000000036AC3336AC3336AC33008000
            00800000000000000000808000FFFF00FFFF00FFFF80FFFF0000FF00FFFF00FF
            000000FFCFCE00000036AC3336AC3336AC3336AC330080000080000080000000
            0000808000FFFF00FFFF00FFFF80FFFF0000FF00FFFF00FFFF00FF0000000000
            0036AC3336AC3336AC3336AC3300800000800000800000000000808000FFFF00
            FFFF00FFFF80FFFF0000FF00FFFF00FFFF00FFFF00FF00000036AC3336AC3397
            DF9597DF9597DF9500800000800000000000000000000000000000FFFF80FFFF
            0000FF00FFFF00FFFF00FFFF00FF000000FFFFFF97DF9597DF9597DF9597DF95
            97DF9500800000000000808000FFFF00FFFF00FFFF80FFFF0000FF00FFFF00FF
            FF00FFFF00FFFF00FF00000097DF9597DF9597DF9597DF9597DF9597DF950000
            0000808000FFFF00FFFF00FFFF80FFFF0000FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FF00000097DF9597DF9597DF9597DF9500000000000000808000FFFF00
            FFFF00FFFF80FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
            000097DF95000000000000FF00FF00000000808000FFFF00FFFF00FFFF80FFFF
            0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FF
            FF00FFFF00FF00000000000000000000000000FFFF80FFFF0000}
          Margin = 1
          Spacing = 2
          OnClick = btnAddSizeColorClick
        end
        object sgGrid: TStringGrid
          Left = 0
          Top = 16
          Width = 680
          Height = 251
          Align = alClient
          BorderStyle = bsNone
          Color = 14607076
          ColCount = 1
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          GridLineWidth = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goThumbTracking]
          TabOrder = 0
          OnDblClick = sgGridDblClick
          ColWidths = (
            64)
        end
        object pnlTitle1: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Size and Color'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object chkQtyUpdate: TCheckBox
          Left = 701
          Top = 120
          Width = 85
          Height = 17
          Caption = 'Fast update'
          Color = 14607076
          ParentColor = False
          TabOrder = 2
        end
      end
      object tsPackModel: TTabSheet
        Caption = 'Pac&k'
        ImageIndex = 11
        DesignSize = (
          782
          267)
        object Panel15: TPanel
          Left = 486
          Top = 0
          Width = 286
          Height = 164
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 1
          object Label88: TLabel
            Left = 8
            Top = 63
            Width = 109
            Height = 13
            Caption = 'Total Cost for package'
          end
          object Label93: TLabel
            Left = 8
            Top = 30
            Width = 178
            Height = 13
            Caption = 'How many packages you can create?'
          end
          object Label84: TLabel
            Left = 0
            Top = 0
            Width = 121
            Height = 14
            Align = alTop
            Alignment = taCenter
            Caption = 'Package Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label85: TLabel
            Left = 8
            Top = 96
            Width = 181
            Height = 13
            Caption = 'The sum of all items on the package is'
          end
          object edtNumPack: TEdit
            Left = 199
            Top = 26
            Width = 72
            Height = 21
            TabStop = False
            Color = 14607076
            ReadOnly = True
            TabOrder = 0
            Text = '0'
          end
          object edtPackCost: TEdit
            Left = 199
            Top = 58
            Width = 72
            Height = 21
            TabStop = False
            Color = 14607076
            ReadOnly = True
            TabOrder = 1
            Text = '0'
          end
          object edtPackSale: TEdit
            Left = 199
            Top = 90
            Width = 72
            Height = 21
            TabStop = False
            Color = 14607076
            ReadOnly = True
            TabOrder = 2
            Text = '0'
          end
          object btnCalcPrice: TButton
            Left = 32
            Top = 128
            Width = 226
            Height = 20
            Caption = 'Recalculate Prices'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnClick = btnCalcPriceClick
          end
        end
        object Panel38: TPanel
          Left = 1
          Top = 0
          Width = 473
          Height = 267
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 0
          object btnAddPack: TSpeedButton
            Left = 395
            Top = 30
            Width = 71
            Height = 24
            Caption = '&Add'
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
            Margin = 6
            OnClick = btnAddPackClick
          end
          object btnRemovePack: TSpeedButton
            Left = 395
            Top = 57
            Width = 71
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
            OnClick = btnRemovePackClick
          end
          object Label82: TLabel
            Left = 0
            Top = 0
            Width = 473
            Height = 14
            Align = alTop
            Alignment = taCenter
            Caption = 'Items for the Package'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label83: TLabel
            Left = 8
            Top = 16
            Width = 33
            Height = 13
            Caption = 'Model'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Label86: TLabel
            Left = 340
            Top = 16
            Width = 44
            Height = 13
            Caption = 'Qty Out'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object gridPackModel: TSMDBGrid
            Left = 0
            Top = 60
            Width = 391
            Height = 205
            BorderStyle = bsNone
            DataSource = dsPackModel
            FixedColor = 14607076
            Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
            TabOrder = 2
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
            ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
            RegistryKey = 'Software\Scalabium'
            RegistrySection = 'SMDBGrid'
            WidthOfIndicator = 11
            DefaultRowHeight = 17
            ScrollBars = ssVertical
            ColCount = 6
            RowCount = 2
            Columns = <
              item
                Expanded = False
                FieldName = 'Model'
                Width = 69
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Description'
                Width = 112
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'FinalCost'
                Width = 48
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'SellingPrice'
                Width = 55
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'TotQtyOnHand'
                Width = 53
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Qty'
                Width = 51
                Visible = True
                FooterType = ftCustom
              end>
          end
          object scModelPack: TSuperComboADO
            Left = 5
            Top = 32
            Width = 307
            Height = 21
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'cmbBasicFilter'
            CodeLength = 200
            LookUpSource = DM.dsLookUpModelCredit
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            ShowEditCode = True
            EditCodePos = taEditCodeRight
            IDLanguage = 0
          end
          object edtQtyOut: TEdit
            Left = 339
            Top = 31
            Width = 47
            Height = 21
            Color = clWhite
            MaxLength = 10
            TabOrder = 1
            Text = '1'
            OnKeyPress = edtQtyOutKeyPress
          end
          object btnSearchDesc: TBitBtn
            Left = 313
            Top = 30
            Width = 23
            Height = 22
            TabOrder = 3
            OnClick = btnSearchDescClick
          end
        end
      end
      object tbCostRetail: TTabSheet
        Caption = '&Cost, Retail'
        DesignSize = (
          782
          267)
        object pnlFranchaseSale: TPanel
          Left = 205
          Top = 1
          Width = 246
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 6
          object lbStoreSellPrice: TLabel
            Left = 35
            Top = 186
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Our Price :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape9: TShape
            Left = 3
            Top = 173
            Width = 238
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object btPriceTable3: TSpeedButton
            Left = 63
            Top = 238
            Width = 117
            Height = 24
            Caption = 'Price Table'
            Flat = True
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
              88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
              88880F080F08080008440FF08080808880440000080808888844888880808888
              8844888888088888804488888880000008448888888888888888}
            OnClick = btPriceTableClick
          end
          object pnlStoreSale: TPanel
            Left = 0
            Top = 0
            Width = 246
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Retail Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object edtStoreSalle: TStaticText
            Left = 117
            Top = 185
            Width = 103
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'Sale'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
        end
        object pnlTaxWithCost: TPanel
          Left = 205
          Top = 0
          Width = 246
          Height = 267
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 4
          object lbOurPrice2: TLabel
            Left = 30
            Top = 181
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Our Price :'
            FocusControl = DBEdit10
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape4: TShape
            Left = 3
            Top = 174
            Width = 238
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object lbIqual1: TLabel
            Left = 225
            Top = 178
            Width = 13
            Height = 18
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object lbActuMarkUp2: TLabel
            Left = 22
            Top = 132
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'Actual Mark-Up :'
          end
          object lbMarkUp2: TLabel
            Left = 20
            Top = 14
            Width = 82
            Height = 13
            Alignment = taRightJustify
            Caption = 'Desired MarkUp :'
            Visible = False
          end
          object lbPluss2: TLabel
            Left = 225
            Top = 128
            Width = 13
            Height = 18
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object lbLastUpdate2: TLabel
            Left = 37
            Top = 21
            Width = 65
            Height = 13
            Alignment = taRightJustify
            Caption = 'Last Update :'
            FocusControl = DBEdit18
          end
          object Shape5: TShape
            Left = 3
            Top = 103
            Width = 238
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object Shape6: TShape
            Left = 3
            Top = 38
            Width = 238
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object lbSaleTax: TLabel
            Left = 54
            Top = 155
            Width = 48
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sale Tax :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lbSun2: TLabel
            Left = 225
            Top = 152
            Width = 13
            Height = 18
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object lbActualCost: TLabel
            Left = 48
            Top = 110
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'Cost Price :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lbPlus3: TLabel
            Left = 225
            Top = 107
            Width = 13
            Height = 18
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object btPriceTable2: TSpeedButton
            Left = 63
            Top = 238
            Width = 117
            Height = 24
            Caption = 'Price Table'
            Flat = True
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
              88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
              88880F080F08080008440FF08080808880440000080808888844888880808888
              8844888888088888804488888880000008448888888888888888}
            OnClick = btPriceTableClick
          end
          object SubRecalcSalePrice: TSubListPanel
            Left = 2
            Top = 41
            Width = 243
            Height = 60
            BevelOuter = bvNone
            Color = clBtnShadow
            TabOrder = 7
            SubListClassName = 'TSubCalcSaleTax'
          end
          object pnlTitle16: TPanel
            Left = 0
            Top = 0
            Width = 246
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Retail Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
          end
          object DBEdit10: TDBEdit
            Left = 107
            Top = 178
            Width = 116
            Height = 22
            DataField = 'SellingPrice'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            OnClick = editNetCostClick
          end
          object DBEdit13: TDBEdit
            Left = 162
            Top = 128
            Width = 61
            Height = 21
            TabStop = False
            DataField = 'RealMarkUpValue'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object DBEdit16: TDBEdit
            Left = 107
            Top = 11
            Width = 116
            Height = 21
            DataField = 'MarkUp'
            DataSource = dsForm
            TabOrder = 0
            Visible = False
          end
          object DBEdit17: TDBEdit
            Left = 107
            Top = 128
            Width = 51
            Height = 21
            TabStop = False
            DataField = 'RealMarkUpPercet'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object DBEdit18: TDBEdit
            Left = 107
            Top = 17
            Width = 116
            Height = 21
            TabStop = False
            DataField = 'DateLastSellingPrice'
            DataSource = dsForm
            ParentColor = True
            ReadOnly = True
            TabOrder = 2
          end
          object btnCalcSaleTax: TButton
            Left = 93
            Top = 20
            Width = 143
            Height = 22
            Hint = 'Change the % MarkUp'
            Caption = 'Recalculate Our Price'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            Visible = False
            OnClick = btnCalcSaleTaxClick
          end
          object edtSalePlusTax: TStaticText
            Left = 107
            Top = 152
            Width = 115
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'edtSalePlusTax'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 8
          end
          object edtActualCost: TStaticText
            Left = 107
            Top = 107
            Width = 115
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'edtActualCost'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 9
          end
        end
        object pnlSalePrice: TPanel
          Left = 205
          Top = 0
          Width = 246
          Height = 267
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 1
          object lbOurPrice1: TLabel
            Left = 30
            Top = 186
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Our Price :'
            FocusControl = EditSalePrice
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape2: TShape
            Left = 3
            Top = 173
            Width = 238
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object Label24: TLabel
            Left = 225
            Top = 183
            Width = 13
            Height = 18
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object lbMSRP1: TLabel
            Left = 64
            Top = 215
            Width = 38
            Height = 13
            Alignment = taRightJustify
            Caption = 'MSRP :'
            FocusControl = DBEdit2
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object btPriceTable: TSpeedButton
            Left = 63
            Top = 238
            Width = 117
            Height = 24
            Caption = 'Price Table'
            Flat = True
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
              88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
              88880F080F08080008440FF08080808880440000080808888844888880808888
              8844888888088888804488888880000008448888888888888888}
            OnClick = btPriceTableClick
          end
          object pnlTitle3: TPanel
            Left = 0
            Top = 0
            Width = 246
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Retail Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
          end
          object EditSalePrice: TDBEdit
            Left = 107
            Top = 183
            Width = 116
            Height = 22
            DataField = 'SellingPrice'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = editNetCostClick
            OnExit = EditSalePriceExit
          end
          object DBEdit2: TDBEdit
            Left = 107
            Top = 212
            Width = 115
            Height = 21
            DataField = 'SuggRetail'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnClick = editNetCostClick
            OnExit = DBEdit2Exit
          end
          object pnlMarkUp: TPanel
            Left = 0
            Top = 16
            Width = 245
            Height = 155
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            DesignSize = (
              245
              155)
            object Label23: TLabel
              Left = 32
              Top = 111
              Width = 70
              Height = 13
              Alignment = taRightJustify
              Caption = 'Average Cost :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label25: TLabel
              Left = 225
              Top = 109
              Width = 13
              Height = 18
              Caption = '+'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -16
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
            end
            object lbActuMarkUp1: TLabel
              Left = 22
              Top = 136
              Width = 80
              Height = 13
              Alignment = taRightJustify
              Caption = 'Actual Mark-Up :'
            end
            object lbMarkUp1: TLabel
              Left = 16
              Top = 38
              Width = 86
              Height = 13
              Alignment = taRightJustify
              Caption = 'Desired Mark-Up :'
            end
            object Label27: TLabel
              Left = 225
              Top = 132
              Width = 13
              Height = 18
              Caption = '+'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -16
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
            end
            object lbLastUpdate1: TLabel
              Left = 37
              Top = 9
              Width = 65
              Height = 13
              Alignment = taRightJustify
              Caption = 'Last Update :'
              FocusControl = DBEdit15
            end
            object btnClearSellPrice: TSpeedButton
              Left = 224
              Top = 5
              Width = 20
              Height = 19
              Anchors = [akTop, akRight]
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                8888888888888888888888808888888888088800088888888888880000888888
                8088888000888888088888880008888008888888800088008888888888000008
                8888888888800088888888888800000888888888800088008888888000088880
                0888880000888888008888000888888888088888888888888888}
              ParentFont = False
              OnClick = btnClearSellPriceClick
            end
            object DBEdit12: TDBEdit
              Left = 162
              Top = 132
              Width = 61
              Height = 21
              TabStop = False
              DataField = 'RealMarkUpValue'
              DataSource = dsForm
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = True
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
            end
            object dbedDesireValue: TDBEdit
              Left = 107
              Top = 33
              Width = 116
              Height = 21
              DataField = 'MarkUp'
              DataSource = dsForm
              TabOrder = 1
              OnClick = editNetCostClick
              OnExit = dbedDesireValueExit
            end
            object DBEdit14: TDBEdit
              Left = 107
              Top = 132
              Width = 51
              Height = 21
              TabStop = False
              DataField = 'RealMarkUpPercet'
              DataSource = dsForm
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentColor = True
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
            end
            object DBEdit15: TDBEdit
              Left = 107
              Top = 4
              Width = 116
              Height = 21
              TabStop = False
              DataField = 'DateLastSellingPrice'
              DataSource = dsForm
              ParentColor = True
              ReadOnly = True
              TabOrder = 0
            end
            object btUpdate: TButton
              Left = 12
              Top = 81
              Width = 226
              Height = 20
              Hint = 'Change the % MarkUp'
              Caption = 'Recalculate Our Price'
              Font.Charset = ANSI_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = btUpdateClick
            end
            object edtAvgCost: TEdit
              Left = 107
              Top = 107
              Width = 116
              Height = 21
              ParentColor = True
              ReadOnly = True
              TabOrder = 3
            end
            object chkManualCalcPrice: TDBCheckBox
              Left = 108
              Top = 62
              Width = 138
              Height = 13
              Caption = 'Adjust price manually'
              DataField = 'UpdatePrice'
              DataSource = dsForm
              TabOrder = 6
              ValueChecked = 'True'
              ValueUnchecked = 'False'
              OnClick = chkManualCalcPriceClick
            end
          end
        end
        object pnlFranchiseCost: TPanel
          Left = 0
          Top = 0
          Width = 196
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 5
          object lbCostStore: TLabel
            Left = 28
            Top = 146
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'Cost Price :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape7: TShape
            Left = 17
            Top = 173
            Width = 174
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object lbStoreAvg: TLabel
            Left = 6
            Top = 187
            Width = 95
            Height = 13
            Alignment = taRightJustify
            Caption = 'Average Cost :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlStoreCost: TPanel
            Left = 0
            Top = 0
            Width = 196
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Cost Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object edtStoreAvgCost: TStaticText
            Left = 104
            Top = 185
            Width = 87
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'Avg'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
          object edtStoreCost: TStaticText
            Left = 104
            Top = 145
            Width = 87
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'Cost'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
        end
        object pnlCustomQty: TPanel
          Left = 0
          Top = 0
          Width = 194
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 3
          Visible = False
          object lbCostRepos: TLabel
            Left = 80
            Top = 58
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = 'Cost :'
            FocusControl = DBEdit20
          end
          object lbLastPurRepos: TLabel
            Left = 35
            Top = 25
            Width = 74
            Height = 13
            Alignment = taRightJustify
            Caption = 'Last Purchase :'
            FocusControl = DBEdit24
          end
          object lbCustoMedio1: TLabel
            Left = 14
            Top = 90
            Width = 95
            Height = 13
            Alignment = taRightJustify
            Caption = 'Average Cost :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object lbCustoReposition: TLabel
            Left = 20
            Top = 139
            Width = 88
            Height = 13
            Alignment = taRightJustify
            Caption = 'Custom Cost :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape8: TShape
            Left = 1
            Top = 120
            Width = 192
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object pnlCalcCostRepos: TPanel
            Left = 0
            Top = 0
            Width = 194
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Cost Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
          end
          object DBEdit20: TDBEdit
            Left = 112
            Top = 54
            Width = 81
            Height = 21
            TabStop = False
            Color = 14607076
            DataField = 'VendorCost'
            DataSource = dsForm
            ReadOnly = True
            TabOrder = 1
            OnExit = AtuLastCostDate
          end
          object DBEdit24: TDBEdit
            Left = 112
            Top = 22
            Width = 82
            Height = 21
            TabStop = False
            DataField = 'DateLastCost'
            DataSource = dsForm
            ParentColor = True
            ReadOnly = True
            TabOrder = 0
          end
          object edtAvgCost3: TStaticText
            Left = 113
            Top = 88
            Width = 79
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'edtAvgCost2'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            Visible = False
          end
          object DBEdit21: TDBEdit
            Left = 112
            Top = 136
            Width = 81
            Height = 21
            DataField = 'ReplacementCost'
            DataSource = dsForm
            TabOrder = 2
            OnClick = editNetCostClick
            OnExit = AtuLastCostDate
          end
        end
        object pnlCost: TPanel
          Left = 0
          Top = 0
          Width = 196
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 0
          object Label12: TLabel
            Left = 64
            Top = 101
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = 'Cost :'
            FocusControl = editNetCost
          end
          object Label4: TLabel
            Left = 15
            Top = 128
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'Other Charges :'
            FocusControl = editOtherCost
          end
          object Label18: TLabel
            Left = 52
            Top = 152
            Width = 41
            Height = 13
            Alignment = taRightJustify
            Caption = 'Freight :'
            FocusControl = editFreightCost
          end
          object Label7: TLabel
            Left = 4
            Top = 186
            Width = 89
            Height = 13
            Alignment = taRightJustify
            Caption = 'Current Cost :'
            FocusControl = DBEdit4
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 19
            Top = 49
            Width = 74
            Height = 13
            Alignment = taRightJustify
            Caption = 'Last Purchase :'
            FocusControl = DBEdit11
          end
          object Shape1: TShape
            Left = 33
            Top = 173
            Width = 161
            Height = 3
            Brush.Color = clNavy
            Pen.Style = psClear
          end
          object Label16: TLabel
            Left = 181
            Top = 97
            Width = 13
            Height = 18
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object Label17: TLabel
            Left = 181
            Top = 125
            Width = 13
            Height = 18
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object Label19: TLabel
            Left = 181
            Top = 149
            Width = 13
            Height = 18
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object Label22: TLabel
            Left = 181
            Top = 183
            Width = 13
            Height = 18
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object Label3: TLabel
            Left = 41
            Top = 23
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'Last Cost :'
            FocusControl = dbLastCost
          end
          object lbCustoMedio: TLabel
            Left = -3
            Top = 219
            Width = 95
            Height = 13
            Alignment = taRightJustify
            Caption = 'Average Cost :'
            FocusControl = edtAvgCosta
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object pnlTitle2: TPanel
            Left = 0
            Top = 0
            Width = 196
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Cost Calculation'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 9
          end
          object editNetCost: TDBEdit
            Left = 96
            Top = 97
            Width = 81
            Height = 21
            DataField = 'VendorCost'
            DataSource = dsForm
            TabOrder = 3
            OnClick = editNetCostClick
            OnExit = editNetCostExit
          end
          object editOtherCost: TDBEdit
            Left = 96
            Top = 124
            Width = 81
            Height = 21
            DataField = 'OtherCost'
            DataSource = dsForm
            TabOrder = 4
            OnClick = editNetCostClick
            OnExit = editOtherCostExit
          end
          object editFreightCost: TDBEdit
            Left = 96
            Top = 150
            Width = 81
            Height = 21
            DataField = 'FreightCost'
            DataSource = dsForm
            TabOrder = 5
            OnClick = editNetCostClick
            OnExit = editFreightCostExit
          end
          object DBEdit4: TDBEdit
            Left = 96
            Top = 183
            Width = 82
            Height = 22
            TabStop = False
            DataField = 'FinalCost'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object DBEdit11: TDBEdit
            Left = 96
            Top = 46
            Width = 82
            Height = 21
            TabStop = False
            DataField = 'lastReceived'
            DataSource = dsForm
            ParentColor = True
            ReadOnly = True
            TabOrder = 1
          end
          object dbLastCost: TDBEdit
            Left = 96
            Top = 20
            Width = 82
            Height = 21
            DataField = 'LastCost'
            DataSource = dsForm
            TabOrder = 0
            OnClick = editNetCostClick
            OnExit = AtuLastCostDate
          end
          object edtAvgCosta: TDBEdit
            Left = 95
            Top = 240
            Width = 83
            Height = 22
            TabStop = False
            DataField = 'AvgCost'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Visible = False
          end
          object edtAvgCost2: TStaticText
            Left = 96
            Top = 217
            Width = 82
            Height = 18
            Alignment = taRightJustify
            AutoSize = False
            BevelInner = bvLowered
            BevelKind = bkSoft
            BevelOuter = bvSpace
            Caption = 'edtAvgCost2'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 7
            Visible = False
          end
          object pnlCaseCost: TPanel
            Left = 9
            Top = 68
            Width = 185
            Height = 25
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            Visible = False
            object lbCaseCost: TLabel
              Left = 28
              Top = 7
              Width = 56
              Height = 13
              Alignment = taRightJustify
              Caption = 'Case Cost :'
              FocusControl = editNetCost
            end
            object edtCaseCost: TSuperEdit
              Left = 87
              Top = 3
              Width = 81
              Height = 21
              TabOrder = 0
              Text = 'edtCaseCost'
              OnChange = edtCaseCostChange
              OnExit = edtCaseCostExit
              OnKeyPress = edtCaseCostKeyPress
              Alignment = taRightJustify
            end
          end
          object edtLastPurchase: TEdit
            Left = 96
            Top = 46
            Width = 80
            Height = 21
            Color = clBtnFace
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 10
            Text = 'Never'
          end
        end
        object pnlQuantity: TPanel
          Left = 455
          Top = 0
          Width = 331
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 2
          object pgInventory: TPageControl
            Left = -5
            Top = 16
            Width = 333
            Height = 253
            ActivePage = tsQty
            Style = tsButtons
            TabOrder = 1
            TabStop = False
            object tsQty: TTabSheet
              Caption = 'tsQty'
              object SubQty: TSubListPanel
                Left = 0
                Top = 0
                Width = 325
                Height = 222
                Align = alClient
                BevelOuter = bvNone
                Color = clBtnShadow
                TabOrder = 0
                SubListClassName = 'TSubStoreQty'
              end
            end
            object tsPrice: TTabSheet
              Caption = 'tsPrice'
              ImageIndex = 1
              object SubPrice: TSubListPanel
                Left = 0
                Top = 0
                Width = 325
                Height = 222
                Align = alClient
                BevelOuter = bvNone
                Color = clBtnShadow
                TabOrder = 0
                SubListClassName = 'TSubStorePrice'
              end
            end
          end
          object pnlTitle4: TPanel
            Left = 0
            Top = 0
            Width = 331
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Qty/Prices'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object pnlAdjust: TPanel
            Left = 0
            Top = 16
            Width = 331
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object btAdjust: TSpeedButton
              Left = 103
              Top = 2
              Width = 117
              Height = 24
              Caption = 'Adj&ust'
              Flat = True
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
                88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
                88880F080F08080008440FF08080808880440000080808888844888880808888
                8844888888088888804488888880000008448888888888888888}
              OnClick = btAdjustClick
            end
            object btnQty: TSpeedButton
              Left = 3
              Top = 2
              Width = 41
              Height = 22
              GroupIndex = 1
              Down = True
              Caption = 'Qty'
              OnClick = btnQtyClick
            end
            object btnPrice: TSpeedButton
              Left = 47
              Top = 2
              Width = 41
              Height = 22
              GroupIndex = 1
              Caption = 'Price'
              OnClick = btnPriceClick
            end
          end
        end
      end
      object tsAdvanced: TTabSheet
        Caption = 'Ad&vanced'
        ImageIndex = 13
        object pgModelInfo: TPageControl
          Left = 0
          Top = 0
          Width = 782
          Height = 267
          ActivePage = tsVendorInfo
          Align = alClient
          TabOrder = 0
          OnChange = pgModelInfoChange
          object tsModelInfo: TTabSheet
            Caption = 'Model Info'
            DesignSize = (
              774
              239)
            object Panel6: TPanel
              Left = 18
              Top = 6
              Width = 355
              Height = 219
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object pnlModelConfig: TPanel
                Left = 0
                Top = 0
                Width = 355
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Configuration'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object chkNotCheckQty: TDBCheckBox
                Left = 10
                Top = 25
                Width = 326
                Height = 17
                Caption = 'Do not verify Qty on Hand during sales'
                DataField = 'NotVerifyQty'
                DataSource = dsForm
                TabOrder = 1
                ValueChecked = 'True'
                ValueUnchecked = 'False'
              end
              object chkDisableItem: TCheckBox
                Left = 10
                Top = 93
                Width = 331
                Height = 17
                Caption = 'Disable Item'
                TabOrder = 2
                OnClick = chkDisableItemClick
              end
              object chkHiddenItem: TCheckBox
                Left = 10
                Top = 46
                Width = 331
                Height = 17
                Caption = 'Hidden item on sale'
                TabOrder = 4
                OnClick = chkHiddenItemClick
              end
              object chkAskSalePrice: TDBCheckBox
                Left = 10
                Top = 70
                Width = 331
                Height = 17
                Caption = 'Ask Sale Price'
                DataField = 'CustomSalePrice'
                DataSource = dsForm
                TabOrder = 3
                ValueChecked = 'True'
                ValueUnchecked = 'False'
              end
              object chkSendToTrash: TDBCheckBox
                Left = 10
                Top = 115
                Width = 326
                Height = 17
                Caption = 'Send to trash'
                DataField = 'SendToTrash'
                DataSource = dsForm
                TabOrder = 5
                ValueChecked = 'True'
                ValueUnchecked = 'False'
              end
              object chbAskSPOnSale: TDBCheckBox
                Left = 10
                Top = 137
                Width = 257
                Height = 17
                Caption = 'Require Sales Person on sale'
                DataField = 'AskUserOnSale'
                DataSource = dsForm
                TabOrder = 6
                ValueChecked = 'True'
                ValueUnchecked = 'False'
              end
              object chkUseScale: TDBCheckBox
                Left = 10
                Top = 159
                Width = 257
                Height = 17
                Caption = 'Use scale'
                DataField = 'UseScale'
                DataSource = dsForm
                TabOrder = 7
                ValueChecked = 'True'
                ValueUnchecked = 'False'
                OnClick = chkUseScaleClick
              end
              object chkLotControl: TDBCheckBox
                Left = 10
                Top = 180
                Width = 257
                Height = 17
                Caption = 'Lot Control'
                DataField = 'UseLot'
                DataSource = dsForm
                TabOrder = 8
                ValueChecked = 'True'
                ValueUnchecked = 'False'
              end
            end
            object Panel14: TPanel
              Left = 407
              Top = 6
              Width = 331
              Height = 219
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 1
              object lbMeasure: TLabel
                Left = 50
                Top = 89
                Width = 26
                Height = 13
                Alignment = taRightJustify
                Caption = 'Unit :'
              end
              object lbWeight: TLabel
                Left = 35
                Top = 124
                Width = 41
                Height = 13
                Alignment = taRightJustify
                Caption = 'Weight :'
              end
              object lbCaseQty: TLabel
                Left = 24
                Top = 157
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = 'Case Qty :'
                FocusControl = DBEdit26
              end
              object lbModelSubGroup2: TLabel
                Left = 40
                Top = 56
                Width = 36
                Height = 13
                Alignment = taRightJustify
                Caption = 'Group :'
              end
              object lbModelGroup2: TLabel
                Left = 14
                Top = 24
                Width = 62
                Height = 13
                Alignment = taRightJustify
                Caption = 'Sub-Categ. :'
              end
              object lbValidDay: TLabel
                Left = 25
                Top = 191
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Exp. Day :'
                FocusControl = DBEdit27
              end
              object lbScaleExpday: TLabel
                Left = 169
                Top = 191
                Width = 109
                Height = 13
                Caption = '(Scale Expiration date)'
                FocusControl = DBEdit27
              end
              object pnlModelMeasure: TPanel
                Left = 0
                Top = 0
                Width = 331
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Measure'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 3
              end
              object scUnidade: TDBSuperComboADO
                Left = 80
                Top = 85
                Width = 241
                Height = 21
                TabOrder = 2
                Text = 'scUnidade'
                LookUpSource = DM.dsLookUpUnidade
                DropDownRows = 10
                MostraDesativado = STD_AMBOSDESATIVADO
                MostraHidden = STD_AMBOSHIDDEN
                IDLanguage = 0
                DataField = 'IDUnidade'
                DataSource = dsForm
              end
              object DBEdit23: TDBEdit
                Left = 80
                Top = 120
                Width = 86
                Height = 21
                DataField = 'Peso'
                DataSource = dsForm
                TabOrder = 4
              end
              object DBEdit26: TDBEdit
                Left = 80
                Top = 154
                Width = 86
                Height = 21
                DataField = 'CaseQty'
                DataSource = dsForm
                TabOrder = 5
                OnExit = DBEdit26Exit
              end
              object scModelSubGroup2: TDBSuperComboADO
                Tag = 99
                Left = 80
                Top = 52
                Width = 241
                Height = 21
                TabOrder = 0
                Text = 'scModelSubGroup2'
                FilterSugest = True
                LookUpSource = DM.dsLookUpModelSubGroup
                DropDownRows = 18
                ShowBtnAddNew = False
                ShowBtnUpdate = False
                IDLanguage = 0
                OnSelectItem = scModelSubGroupSelectItem
                DataField = 'IDModelSubGroup'
                DataSource = dsForm
              end
              object scModelGroup2: TDBSuperComboADO
                Tag = 99
                Left = 80
                Top = 19
                Width = 241
                Height = 21
                TabOrder = 1
                Text = 'scModelGroup2'
                FilterSugest = True
                LookUpSource = DM.dsLookUpModelGroup
                DropDownRows = 18
                ShowBtnAddNew = False
                ShowBtnUpdate = False
                IDLanguage = 0
                OnSelectItem = scModelSubGroupSelectItem
                DataField = 'IDModelGroup'
                DataSource = dsForm
              end
              object DBEdit27: TDBEdit
                Left = 80
                Top = 187
                Width = 84
                Height = 21
                DataField = 'ScaleValidDay'
                DataSource = dsForm
                TabOrder = 6
              end
            end
          end
          object tsVendorInfo: TTabSheet
            Caption = 'Vendor Info'
            ImageIndex = 1
            DesignSize = (
              774
              239)
            object pnlVendorList: TPanel
              Left = 8
              Top = 6
              Width = 745
              Height = 229
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object btnRemoveVendorList: TSpeedButton
                Left = 660
                Top = 69
                Width = 82
                Height = 24
                Caption = '&Remove'
                Flat = True
                Margin = 6
                OnClick = btnRemoveVendorListClick
              end
              object btnAddVendorList: TSpeedButton
                Left = 660
                Top = 20
                Width = 82
                Height = 24
                Caption = '&Add'
                Flat = True
                Margin = 6
                OnClick = btnAddVendorListClick
              end
              object btnModelVendorUP: TSpeedButton
                Left = 660
                Top = 102
                Width = 82
                Height = 24
                Caption = 'Up'
                Flat = True
                Margin = 5
                OnClick = btnModelVendorUPClick
              end
              object btnModelVendorDown: TSpeedButton
                Left = 660
                Top = 127
                Width = 82
                Height = 24
                Caption = 'Down'
                Flat = True
                Margin = 5
                OnClick = btnModelVendorDownClick
              end
              object btnOpenVendorList: TSpeedButton
                Left = 660
                Top = 45
                Width = 82
                Height = 24
                Caption = '&Detail'
                Flat = True
                Margin = 6
                OnClick = btnOpenVendorListClick
              end
              object pnlVendorOrder: TPanel
                Left = 0
                Top = 0
                Width = 745
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Vendor List'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object grdModelVendor: TcxGrid
                Left = 0
                Top = 16
                Width = 658
                Height = 213
                TabOrder = 1
                LookAndFeel.Kind = lfStandard
                object grdModelVendorTV: TcxGridDBTableView
                  DataController.DataSource = dsModelVendor
                  DataController.Filter.Criteria = {FFFFFFFF0000000000}
                  DataController.KeyFieldNames = 'IDVendor'
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsCustomize.ColumnFiltering = False
                  OptionsData.Deleting = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsSelection.CellSelect = False
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GridLines = glHorizontal
                  OptionsView.GroupByBox = False
                  object grdModelVendorTVVendorOrder: TcxGridDBColumn
                    Caption = 'Order'
                    DataBinding.FieldName = 'VendorOrder'
                    Width = 35
                  end
                  object grdModelVendorTVVendor: TcxGridDBColumn
                    DataBinding.FieldName = 'Vendor'
                    Width = 171
                  end
                  object grdModelVendorTVMinQtyPO: TcxGridDBColumn
                    DataBinding.FieldName = 'MinQtyPO'
                    Width = 62
                  end
                  object grdModelVendorTVCaseQty: TcxGridDBColumn
                    DataBinding.FieldName = 'CaseQty'
                    Width = 54
                  end
                  object grdModelVendorTVVendorCodeList: TcxGridDBColumn
                    DataBinding.FieldName = 'VendorCodeList'
                    Width = 180
                  end
                  object grdModelVendorTVVendorCost: TcxGridDBColumn
                    DataBinding.FieldName = 'VendorCost'
                    Width = 67
                  end
                  object grdModelVendorTVCostLastChange: TcxGridDBColumn
                    DataBinding.FieldName = 'CostLastChange'
                    Width = 85
                  end
                end
                object grdModelVendorLvl: TcxGridLevel
                  GridView = grdModelVendorTV
                end
              end
            end
          end
          object tsPrintReceipt: TTabSheet
            Caption = '  Print Receipt  '
            ImageIndex = 2
            DesignSize = (
              774
              239)
            object pnlModelReceipt: TPanel
              Left = 18
              Top = 6
              Width = 503
              Height = 228
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object btRemoveModelReceipt: TSpeedButton
                Left = 428
                Top = 49
                Width = 73
                Height = 24
                Caption = '&Remove'
                Flat = True
                OnClick = btRemoveModelReceiptClick
              end
              object btAddModelReceipt: TSpeedButton
                Left = 428
                Top = 20
                Width = 73
                Height = 24
                Caption = '&Add'
                Flat = True
                Margin = 6
                OnClick = btAddModelReceiptClick
              end
              object pnlReceiptTextTitle: TPanel
                Left = 0
                Top = 0
                Width = 503
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Receipt Text'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object SMDBGrid1: TSMDBGrid
                Left = 0
                Top = 16
                Width = 425
                Height = 212
                Align = alLeft
                BorderStyle = bsNone
                DataSource = dsModelReceipt
                FixedColor = 14607076
                Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
                TabOrder = 1
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                OnExit = postOnExit
                Flat = True
                Groupings = <>
                GridStyle.Style = gsCustom
                GridStyle.OddColor = clWindow
                GridStyle.EvenColor = clWindow
                FooterColor = clBtnFace
                ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
                OnGetCellParams = grdSpecialPriceGetCellParams
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
                    FieldName = 'IDModelReceipt'
                    Visible = False
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'ReceiptText'
                    Width = 426
                    Visible = True
                    FooterType = ftCustom
                  end>
              end
            end
          end
          object tsGovernement: TTabSheet
            Caption = 'Governement'
            ImageIndex = 3
            DesignSize = (
              774
              239)
            object Panel7: TPanel
              Left = 2
              Top = 120
              Width = 306
              Height = 114
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 1
              object lbIndexProd: TLabel
                Left = 50
                Top = 32
                Width = 60
                Height = 13
                Alignment = taRightJustify
                Caption = 'Index Prod :'
                FocusControl = cbxIndexProd
              end
              object lbIndexRound: TLabel
                Left = 41
                Top = 57
                Width = 69
                Height = 13
                Alignment = taRightJustify
                Caption = 'Index Round :'
                FocusControl = cbxIndexRound
              end
              object lbCFOP: TLabel
                Left = 74
                Top = 83
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'CFOP :'
              end
              object Panel17: TPanel
                Left = 0
                Top = 0
                Width = 306
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object cbxIndexProd: TcxDBImageComboBox
                Left = 114
                Top = 29
                Width = 188
                Height = 21
                DataBinding.DataSource = dsForm
                DataBinding.DataField = 'IndicadorProducao'
                Properties.Alignment.Horz = taLeftJustify
                Properties.ImageAlign = iaRight
                Properties.Items = <
                  item
                    Description = 'Third Part Production'
                    Value = 'T'
                  end
                  item
                    Description = 'Own Production'
                    Value = 'P'
                  end>
                Style.BorderColor = clInactiveCaptionText
                Style.BorderStyle = ebsFlat
                Style.LookAndFeel.Kind = lfStandard
                Style.LookAndFeel.NativeStyle = False
                Style.Shadow = False
                Style.ButtonStyle = btsFlat
                Style.PopupBorderStyle = epbsSingle
                TabOrder = 1
              end
              object cbxIndexRound: TcxDBImageComboBox
                Left = 114
                Top = 54
                Width = 188
                Height = 21
                DataBinding.DataSource = dsForm
                DataBinding.DataField = 'IndicadorAT'
                Properties.Alignment.Horz = taLeftJustify
                Properties.ImageAlign = iaRight
                Properties.Items = <
                  item
                    Description = 'Rounding'
                    Value = 'A'
                  end
                  item
                    Description = 'Trunc'
                    Value = 'T'
                  end>
                Style.BorderColor = clInactiveCaptionText
                Style.BorderStyle = ebsFlat
                Style.LookAndFeel.Kind = lfStandard
                Style.LookAndFeel.NativeStyle = False
                Style.Shadow = False
                Style.ButtonStyle = btsFlat
                Style.PopupBorderStyle = epbsSingle
                TabOrder = 2
              end
              object scCFOP: TDBSuperComboADO
                Tag = 99
                Left = 113
                Top = 80
                Width = 187
                Height = 21
                TabOrder = 3
                Text = 'scCFOP'
                FilterSugest = True
                LookUpSource = DM.dsLookUpCFOP
                DropDownRows = 18
                MostraDesativado = STD_AMBOSDESATIVADO
                MostraHidden = STD_AMBOSHIDDEN
                IDLanguage = 0
                OnSelectItem = scNCMSelectItem
                DataField = 'IDCFOP'
                DataSource = dsForm
              end
            end
            object pnlNCM: TPanel
              Left = 3
              Top = 1
              Width = 305
              Height = 115
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object lbNCM: TLabel
                Left = 74
                Top = 28
                Width = 29
                Height = 13
                Alignment = taRightJustify
                Caption = 'NCM :'
              end
              object lbNCMTaxIn: TLabel
                Left = 65
                Top = 52
                Width = 38
                Height = 13
                Alignment = taRightJustify
                Caption = 'Tax In :'
              end
              object lbNCMTaxOut: TLabel
                Left = 57
                Top = 71
                Width = 46
                Height = 13
                Alignment = taRightJustify
                Caption = 'Tax Out :'
              end
              object lbNCMPayTax: TLabel
                Left = 108
                Top = 90
                Width = 3
                Height = 13
                Caption = '.'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbTaxInValue: TLabel
                Left = 108
                Top = 52
                Width = 24
                Height = 13
                Caption = '0.00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbTaxOutValue: TLabel
                Left = 108
                Top = 71
                Width = 24
                Height = 13
                Caption = '0.00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object pnlNCMInfo: TPanel
                Left = 0
                Top = 0
                Width = 305
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object scNCM: TDBSuperComboADO
                Tag = 99
                Left = 108
                Top = 25
                Width = 187
                Height = 21
                TabOrder = 1
                Text = 'scNCM'
                FilterSugest = True
                LookUpSource = DM.dsLookUpNCM
                DropDownRows = 18
                MostraDesativado = STD_AMBOSDESATIVADO
                MostraHidden = STD_AMBOSHIDDEN
                IDLanguage = 0
                OnSelectItem = scNCMSelectItem
                DataField = 'IDNCM'
                DataSource = dsForm
              end
            end
            object pnlStateTax: TPanel
              Left = 313
              Top = 1
              Width = 329
              Height = 231
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 2
              object btnRemoveStateTax: TSpeedButton
                Left = 243
                Top = 46
                Width = 82
                Height = 24
                Caption = '&Remove'
                Flat = True
                Margin = 6
                OnClick = btnRemoveStateTaxClick
              end
              object btnAddStateTax: TSpeedButton
                Left = 243
                Top = 20
                Width = 82
                Height = 24
                Caption = '&Add'
                Flat = True
                Margin = 6
                OnClick = btnAddStateTaxClick
              end
              object pnlStateTaxInfo: TPanel
                Left = 0
                Top = 0
                Width = 329
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'State Tax'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object cxGrid1: TcxGrid
                Left = 3
                Top = 21
                Width = 238
                Height = 208
                TabOrder = 1
                OnExit = grdKitModelExit
                object cxGridDBStateTax: TcxGridDBTableView
                  DataController.DataSource = dsStateTax
                  DataController.Filter.Criteria = {FFFFFFFF0000000000}
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsCustomize.ColumnFiltering = False
                  OptionsCustomize.ColumnGrouping = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Inserting = False
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GridLines = glHorizontal
                  OptionsView.GroupByBox = False
                  object cxGridDBStateTaxEstado: TcxGridDBColumn
                    Caption = 'State'
                    DataBinding.FieldName = 'Estado'
                    Options.Editing = False
                    Width = 85
                  end
                  object cxGridDBStateTaxTaxCategory: TcxGridDBColumn
                    DataBinding.FieldName = 'TaxCategory'
                    Options.Editing = False
                    Width = 87
                  end
                  object cxGridDBStateTaxTax: TcxGridDBColumn
                    Caption = 'Tax %'
                    DataBinding.FieldName = 'Tax'
                    Options.Editing = False
                  end
                end
                object cxGridLevel1: TcxGridLevel
                  GridView = cxGridDBStateTax
                end
              end
            end
          end
          object tsNutrition: TTabSheet
            Caption = 'Nutrition'
            ImageIndex = 4
            DesignSize = (
              774
              239)
            object Panel18: TPanel
              Left = 3
              Top = 1
              Width = 329
              Height = 231
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object btnRemoveNutrition: TSpeedButton
                Left = 243
                Top = 79
                Width = 82
                Height = 24
                Caption = '&Remove'
                Flat = True
                Margin = 6
                OnClick = btnRemoveNutritionClick
              end
              object btnAddNutrition: TSpeedButton
                Left = 243
                Top = 53
                Width = 82
                Height = 24
                Caption = '&Add'
                Flat = True
                Margin = 6
                OnClick = btnAddNutritionClick
              end
              object lbPortion: TLabel
                Left = 10
                Top = 29
                Width = 41
                Height = 13
                Alignment = taRightJustify
                Caption = 'Portion :'
              end
              object pnlNutrition: TPanel
                Left = 0
                Top = 0
                Width = 329
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Nutrition Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object cxGridNutrition: TcxGrid
                Left = 3
                Top = 53
                Width = 238
                Height = 177
                TabOrder = 1
                OnExit = grdKitModelExit
                object cxGridDBTVNutrition: TcxGridDBTableView
                  DataController.DataSource = dsNutritionItem
                  DataController.Filter.Criteria = {FFFFFFFF0000000000}
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsCustomize.ColumnFiltering = False
                  OptionsCustomize.ColumnGrouping = False
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Inserting = False
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GridLines = glHorizontal
                  OptionsView.GroupByBox = False
                  object cxGridDBTVNutritionDescription: TcxGridDBColumn
                    DataBinding.FieldName = 'Description'
                    Options.Editing = False
                    Width = 109
                  end
                  object cxGridDBTVNutritionQtyPortion: TcxGridDBColumn
                    Caption = 'Qty Portion'
                    DataBinding.FieldName = 'QtyPortion'
                    Width = 60
                  end
                  object cxGridDBTVNutritionVDPortion: TcxGridDBColumn
                    Caption = '% VD'
                    DataBinding.FieldName = 'VDPortion'
                    Width = 67
                  end
                end
                object cxGridLevelNutrition: TcxGridLevel
                  GridView = cxGridDBTVNutrition
                end
              end
              object DBEdit28: TDBEdit
                Left = 55
                Top = 25
                Width = 185
                Height = 21
                DataField = 'Portion'
                DataSource = dsForm
                TabOrder = 2
              end
            end
          end
        end
      end
      object tsInternet: TTabSheet
        Caption = '&Web'
        ImageIndex = 12
        object pgWebInfo: TPageControl
          Left = 0
          Top = 0
          Width = 782
          Height = 267
          ActivePage = tsAccessory
          Align = alClient
          TabOrder = 0
          OnChange = pgWebInfoChange
          object tsAccessory: TTabSheet
            Caption = 'Accessory'
            ImageIndex = 1
            object Panel8: TPanel
              Left = 0
              Top = 0
              Width = 546
              Height = 239
              Align = alLeft
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object btAddAccessory: TSpeedButton
                Left = 462
                Top = 40
                Width = 80
                Height = 24
                Caption = 'A&dd'
                Flat = True
                Margin = 5
                OnClick = btAddAccessoryClick
              end
              object btDelAccessory: TSpeedButton
                Left = 462
                Top = 66
                Width = 80
                Height = 24
                Caption = '&Remove'
                Flat = True
                Margin = 5
                OnClick = btDelAccessoryClick
              end
              object lbAccessory: TLabel
                Left = 5
                Top = 21
                Width = 56
                Height = 13
                Alignment = taRightJustify
                Caption = 'Accessory :'
              end
              object lbAccHint: TLabel
                Left = 35
                Top = 44
                Width = 26
                Height = 13
                Alignment = taRightJustify
                Caption = 'Hint :'
              end
              object pnlAccessTitle: TPanel
                Left = 0
                Top = 0
                Width = 546
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Accessories'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object gridAccessory: TSMDBGrid
                Left = 0
                Top = 64
                Width = 458
                Height = 171
                BorderStyle = bsNone
                DataSource = dsAccessory
                Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
                TabOrder = 1
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
                ExOptions = [eoAutoWidth]
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
                    FieldName = 'Model'
                    Width = 284
                    Visible = True
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'Description'
                    Width = 173
                    Visible = True
                    FooterType = ftCustom
                  end>
              end
              object scModelAccessory: TSuperComboADO
                Left = 64
                Top = 18
                Width = 477
                Height = 21
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                CodeLength = 300
                LookUpSource = DM.dsLookUpModel
                DropDownRows = 10
                ShowBtnAddNew = False
                ShowBtnUpdate = False
                ShowEditCode = True
                EditCodePos = taEditCodeRight
                IDLanguage = 0
              end
              object edtAccessotyHint: TEdit
                Left = 64
                Top = 41
                Width = 392
                Height = 21
                MaxLength = 255
                TabOrder = 3
              end
            end
            object Panel19: TPanel
              Left = 550
              Top = 0
              Width = 224
              Height = 239
              Align = alRight
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 1
              object lbShort: TLabel
                Left = 21
                Top = 23
                Width = 33
                Height = 13
                Alignment = taRightJustify
                Caption = 'Short :'
              end
              object DBWebDescription: TDBMemo
                Left = 57
                Top = 20
                Width = 162
                Height = 80
                DataField = 'WebDescription'
                DataSource = dsForm
                MaxLength = 255
                TabOrder = 0
              end
              object pnlWebDescription: TPanel
                Left = 0
                Top = 0
                Width = 224
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Description'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
              end
            end
          end
          object tsFeatures: TTabSheet
            Caption = 'Features'
            ImageIndex = 2
            DesignSize = (
              774
              239)
            object Panel11: TPanel
              Left = 5
              Top = 3
              Width = 361
              Height = 236
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object btnAddFeature: TSpeedButton
                Left = 276
                Top = 39
                Width = 80
                Height = 24
                Caption = 'A&dd'
                Flat = True
                Margin = 5
                OnClick = btnAddFeatureClick
              end
              object btnDelFeature: TSpeedButton
                Left = 276
                Top = 65
                Width = 80
                Height = 24
                Caption = '&Remove'
                Flat = True
                Margin = 5
                OnClick = btnDelFeatureClick
              end
              object lbFeatures: TLabel
                Left = 32
                Top = 43
                Width = 45
                Height = 13
                Alignment = taRightJustify
                Caption = 'Feature :'
              end
              object pnlFeatures: TPanel
                Left = 0
                Top = 0
                Width = 361
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Product Features'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object grdFeatures: TSMDBGrid
                Left = 0
                Top = 63
                Width = 271
                Height = 172
                BorderStyle = bsNone
                DataSource = dsFeatures
                Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
                TabOrder = 1
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
                ExOptions = [eoAutoWidth]
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
                    FieldName = 'IDInvFeatures'
                    Visible = False
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'Feature'
                    Width = 272
                    Visible = True
                    FooterType = ftCustom
                  end>
              end
              object edtFeature: TEdit
                Left = 79
                Top = 39
                Width = 190
                Height = 21
                MaxLength = 255
                TabOrder = 2
              end
            end
            object Panel12: TPanel
              Left = 400
              Top = 3
              Width = 361
              Height = 236
              Anchors = [akLeft, akTop, akBottom]
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 1
              object btnTechAdd: TSpeedButton
                Left = 276
                Top = 39
                Width = 80
                Height = 24
                Caption = 'A&dd'
                Flat = True
                Margin = 5
                OnClick = btnTechAddClick
              end
              object btnTechDel: TSpeedButton
                Left = 276
                Top = 65
                Width = 80
                Height = 24
                Caption = '&Remove'
                Flat = True
                Margin = 5
                OnClick = btnTechDelClick
              end
              object lbTechFeatures: TLabel
                Left = 32
                Top = 43
                Width = 45
                Height = 13
                Alignment = taRightJustify
                Caption = 'Feature :'
              end
              object pnlTechFeature: TPanel
                Left = 0
                Top = 0
                Width = 361
                Height = 16
                Align = alTop
                BevelOuter = bvNone
                Caption = 'Tech Features'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object grdInvTech: TSMDBGrid
                Left = 0
                Top = 63
                Width = 271
                Height = 172
                BorderStyle = bsNone
                DataSource = dsTechFeature
                Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
                TabOrder = 1
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
                ExOptions = [eoAutoWidth]
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
                    FieldName = 'IDInvTechFeatures'
                    Visible = False
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'TechFeature'
                    Width = 272
                    Visible = True
                    FooterType = ftCustom
                  end>
              end
              object edtTechFeature: TEdit
                Left = 79
                Top = 39
                Width = 190
                Height = 21
                MaxLength = 255
                TabOrder = 2
              end
            end
          end
          object tsWebImagems: TTabSheet
            Caption = 'Image'
            object SubListInternet: TSubListPanel
              Left = 12
              Top = 19
              Width = 308
              Height = 204
              BevelOuter = bvNone
              Color = clBtnShadow
              TabOrder = 0
              SubListClassName = 'TSubModelImage'
            end
            object SubListInternet2: TSubListPanel
              Left = 424
              Top = 20
              Width = 308
              Height = 204
              BevelOuter = bvNone
              Color = clBtnShadow
              TabOrder = 1
              SubListClassName = 'TSubModelImage'
            end
          end
        end
      end
      object tbSpecialPrice: TTabSheet
        Caption = '&Barcodes, SpecialPrices'
        DesignSize = (
          782
          267)
        object Panel10: TPanel
          Left = 5
          Top = 0
          Width = 281
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Caption = 'Panel10'
          Color = 14607076
          TabOrder = 0
          object btRemoveBarCode: TSpeedButton
            Left = 205
            Top = 50
            Width = 71
            Height = 24
            Caption = '&Remove'
            Flat = True
            OnClick = btRemoveBarCodeClick
          end
          object btAddBarCode: TSpeedButton
            Left = 205
            Top = 20
            Width = 71
            Height = 24
            Caption = '&Add'
            Flat = True
            Margin = 6
            OnClick = btAddBarCodeClick
          end
          object btnPrintBarcode: TSpeedButton
            Left = 205
            Top = 80
            Width = 71
            Height = 24
            Caption = '&Print'
            Flat = True
            Margin = 5
            OnClick = btnPrintBarcodeClick
          end
          object SpeedButton1: TSpeedButton
            Left = 205
            Top = 107
            Width = 71
            Height = 24
            Caption = 'Up'
            Flat = True
            Margin = 5
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 205
            Top = 133
            Width = 71
            Height = 24
            Caption = 'Down'
            Flat = True
            Margin = 5
            OnClick = SpeedButton2Click
          end
          object pnlTitle5: TPanel
            Left = 0
            Top = 0
            Width = 281
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Barcodes'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object grdBarcode: TSMDBGrid
            Left = 0
            Top = 16
            Width = 202
            Height = 250
            Align = alLeft
            BorderStyle = bsNone
            DataSource = dsBarCode
            FixedColor = 14607076
            Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnExit = postOnExit
            Flat = True
            Groupings = <>
            GridStyle.Style = gsCustom
            GridStyle.OddColor = clWindow
            GridStyle.EvenColor = 14607076
            FooterColor = clBtnFace
            ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
            RegistryKey = 'Software\Scalabium'
            RegistrySection = 'SMDBGrid'
            WidthOfIndicator = 11
            DefaultRowHeight = 17
            ScrollBars = ssVertical
            ColCount = 4
            RowCount = 2
            Columns = <
              item
                Expanded = False
                FieldName = 'IDBarcode'
                Width = 82
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Data'
                Width = 49
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'BarcodeOrder'
                Title.Caption = 'Order'
                Width = 35
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Qty'
                Width = 35
                Visible = True
                FooterType = ftCustom
              end>
          end
        end
        object Panel9: TPanel
          Left = 300
          Top = 0
          Width = 336
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Caption = 'Panel10'
          Color = 14607076
          TabOrder = 1
          object btAddSpecialPrice: TSpeedButton
            Left = 260
            Top = 19
            Width = 71
            Height = 24
            Caption = '&View'
            Flat = True
            Margin = 6
            OnClick = btAddSpecialPriceClick
          end
          object btRemoveSpecialPrice: TSpeedButton
            Left = 260
            Top = 49
            Width = 71
            Height = 24
            Caption = '&Remove'
            Flat = True
            OnClick = btRemoveSpecialPriceClick
          end
          object pnlTitle6: TPanel
            Left = 0
            Top = 0
            Width = 336
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Special Prices'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object grdSpecialPrice: TSMDBGrid
            Left = 0
            Top = 16
            Width = 246
            Height = 250
            Align = alLeft
            BorderStyle = bsNone
            DataSource = dsSpecialPrice
            FixedColor = 14607076
            Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines]
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnExit = postOnExit
            Flat = True
            Groupings = <>
            GridStyle.Style = gsCustom
            GridStyle.OddColor = clWindow
            GridStyle.EvenColor = clWindow
            FooterColor = clBtnFace
            ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
            FixedCols = 1
            OnGetCellParams = grdSpecialPriceGetCellParams
            RegistryKey = 'Software\Scalabium'
            RegistrySection = 'SMDBGrid'
            WidthOfIndicator = 11
            DefaultRowHeight = 17
            ScrollBars = ssVertical
            ColCount = 2
            RowCount = 2
            Columns = <
              item
                ButtonStyle = cbsNone
                Color = 14607076
                Expanded = False
                FieldName = 'SpecialPrice'
                Width = 140
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'MarkUp'
                Title.Alignment = taRightJustify
                Width = 105
                Visible = True
                FooterType = ftCustom
              end>
          end
        end
      end
      object tbKitModel: TTabSheet
        Caption = '&Promotions, S/N'
        DesignSize = (
          782
          267)
        object Panel13: TPanel
          Left = 0
          Top = 0
          Width = 356
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Caption = 'Panel10'
          Color = 14607076
          TabOrder = 0
          object lblSubTip: TLabel
            Left = 8
            Top = 20
            Width = 303
            Height = 38
            AutoSize = False
            Caption = 
              'This table is designed to set prices for quantity discounts. Ent' +
              'er a quantity greater than one, and its promotional unit sale pr' +
              'ice.'
            WordWrap = True
          end
          object btKitAdd: TSpeedButton
            Left = 280
            Top = 60
            Width = 71
            Height = 24
            Caption = '&Add'
            Flat = True
            Margin = 6
            OnClick = btKitAddClick
          end
          object btKitRemove: TSpeedButton
            Left = 280
            Top = 90
            Width = 71
            Height = 24
            Caption = '&Remove'
            Flat = True
            OnClick = btKitRemoveClick
          end
          object lbPromotion: TLabel
            Left = 76
            Top = 209
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = 'Promotion Price :'
          end
          object lbDiscountPerc: TLabel
            Left = 28
            Top = 237
            Width = 129
            Height = 13
            Alignment = taRightJustify
            Caption = 'Max discount on sale (%) :'
          end
          object lbSalePriceInfo: TLabel
            Left = 104
            Top = 178
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sale Price :'
          end
          object btnClearMaxDisc: TSpeedButton
            Left = 277
            Top = 232
            Width = 23
            Height = 20
            Flat = True
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDDDDDDDDDDDDDDDDDD07DDDDDDDDD0DDD0007DDDDDDDD7DDD0000DDDDDD
              D0DDDDD0007DDDDD07DDDDDD0007DDD00DDDDDDDD0007D007DDDDDDDDD000007
              DDDDDDDDDDD0007DDDDDDDDDDD000007DDDDDDDDD0007D007DDDDDD00007DDD0
              07DDDD00007DDDDD007DDD0007DDDDDDDD0DDDDDDDDDDDDDDDDD}
            OnClick = btnClearMaxDiscClick
          end
          object pnlTitle7: TPanel
            Left = 0
            Top = 0
            Width = 356
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Promotions'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object DBEdit19: TDBEdit
            Left = 162
            Top = 204
            Width = 116
            Height = 21
            DataField = 'PromotionPrice'
            DataSource = dsForm
            TabOrder = 1
          end
          object DBEdit22: TDBEdit
            Left = 162
            Top = 232
            Width = 116
            Height = 21
            DataField = 'DiscountPerc'
            DataSource = dsForm
            TabOrder = 2
          end
          object DBEdit25: TDBEdit
            Left = 162
            Top = 176
            Width = 116
            Height = 22
            Color = clSilver
            DataField = 'SellingPrice'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object grdKitModel: TcxGrid
            Left = 0
            Top = 60
            Width = 277
            Height = 113
            TabOrder = 4
            OnExit = grdKitModelExit
            object grdKitModelDBTableView: TcxGridDBTableView
              DataController.DataSource = dsKitModel
              DataController.Filter.Criteria = {FFFFFFFF0000000000}
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLines = glHorizontal
              OptionsView.GroupByBox = False
              object grdKitModelDBTableViewQty: TcxGridDBColumn
                DataBinding.FieldName = 'Qty'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.MaxValue = 10000.000000000000000000
                Properties.MinValue = 2.000000000000000000
                Properties.ValueType = vtInt
                Properties.OnValidate = grdKitModelDBTableViewQtyPropertiesValidate
              end
              object grdKitModelDBTableViewSellingPrice: TcxGridDBColumn
                DataBinding.FieldName = 'SellingPrice'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '#,##0.00'
                Properties.MaxValue = 10000000.000000000000000000
                Properties.MinValue = 0.010000000000000000
                Properties.OnValidate = grdKitModelDBTableViewSellingPricePropertiesValidate
                Width = 104
              end
              object grdKitModelDBTableViewIDModel: TcxGridDBColumn
                DataBinding.FieldName = 'IDModel'
                Visible = False
              end
              object grdKitModelDBMarginPer: TcxGridDBColumn
                Caption = 'MarginPercentual'
                DataBinding.FieldName = 'MarginPerc'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.MaxValue = 99.989999999999990000
                Properties.MinValue = 0.010000000000000000
                Properties.OnValidate = grdKitModelDBMarginPerPropertiesValidate
                Width = 107
              end
            end
            object grdKitModelLevel: TcxGridLevel
              GridView = grdKitModelDBTableView
            end
          end
        end
        object Panel16: TPanel
          Left = 375
          Top = 0
          Width = 361
          Height = 266
          Anchors = [akLeft, akTop, akBottom]
          BevelOuter = bvNone
          Caption = 'Panel10'
          Color = 14607076
          TabOrder = 1
          object btAddSerial: TSpeedButton
            Left = 276
            Top = 19
            Width = 80
            Height = 24
            Caption = 'A&dd'
            Flat = True
            Margin = 5
            OnClick = btAddSerialClick
          end
          object btSerialRemove: TSpeedButton
            Left = 276
            Top = 74
            Width = 80
            Height = 24
            Caption = '&Remove'
            Flat = True
            Margin = 5
            OnClick = btSerialRemoveClick
          end
          object btEditSerial: TSpeedButton
            Tag = 4
            Left = 278
            Top = 46
            Width = 78
            Height = 25
            Caption = '&Edit'
            Flat = True
            Margin = 3
            OnClick = btEditSerialClick
          end
          object pnlTitle8: TPanel
            Left = 0
            Top = 0
            Width = 361
            Height = 16
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Existing Serial Numbers in Inventory'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object grdSerial: TSMDBGrid
            Left = 0
            Top = 16
            Width = 271
            Height = 250
            Align = alLeft
            BorderStyle = bsNone
            DataSource = dsSerial
            Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = btEditSerialClick
            OnExit = postOnExit
            Flat = True
            Groupings = <>
            GridStyle.Style = gsCustom
            GridStyle.OddColor = clWindow
            GridStyle.EvenColor = 14607076
            FooterColor = clBtnFace
            ExOptions = [eoAutoWidth]
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
                FieldName = 'Name'
                Width = 162
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Serial'
                Width = 108
                Visible = True
                FooterType = ftCustom
              end>
          end
        end
      end
      object tbPurcHistory: TTabSheet
        Caption = 'Pu&rchase History'
        object pnlTitle9: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Purchase History'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object SubListPurHistory: TSubListPanel
          Left = 0
          Top = 16
          Width = 782
          Height = 251
          Align = alClient
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 1
          SubListClassName = 'TSubPurchaseHistory'
        end
      end
      object tbSaleHist: TTabSheet
        Caption = '&Sales Totals'
        object pnlTitle10: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Sales Totals'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object SubListSalesHistory: TSubListPanel
          Left = 0
          Top = 16
          Width = 782
          Height = 251
          Align = alClient
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 1
          SubListClassName = 'TSubSaleHistory'
        end
      end
      object tbMovHistory: TTabSheet
        Caption = '&Mvm'#39't History'
        object pnlTitle11: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Movement History'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object SubListMovHistory: TSubListPanel
          Left = 0
          Top = 16
          Width = 782
          Height = 251
          Align = alClient
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 1
          SubListClassName = 'TSubMovHistory'
        end
      end
      object tbMovTotal: TTabSheet
        Caption = 'Mvm'#39't &Totals'
        object pnlTitle12: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Movement Totals'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object SubListMovTotal: TSubListPanel
          Left = 0
          Top = 16
          Width = 782
          Height = 251
          Align = alClient
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 1
          SubListClassName = 'TSubMovTotal'
        end
      end
      object tbOrder: TTabSheet
        Caption = '&Orders'
        object pnlTitle13: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Pending Orders'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object SubListOrderHistory: TSubListPanel
          Left = 0
          Top = 16
          Width = 782
          Height = 251
          Align = alClient
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 1
          SubListClassName = 'TSubOrderHistory'
        end
      end
      object tbInvoicesHold: TTabSheet
        Caption = '&Inv On Hold'
        object pnlTitle14: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Hold Invoices with this model'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object grdInvHold: TcxGrid
          Left = 0
          Top = 16
          Width = 782
          Height = 251
          Align = alClient
          TabOrder = 1
          LookAndFeel.Kind = lfFlat
          object grdInvHoldDBTableView: TcxGridDBTableView
            OnDblClick = grdInvHoldDBTableViewDblClick
            DataController.DataSource = DsInvHold
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDPreSale'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLines = glNone
            OptionsView.GroupByBox = False
            Styles.Background = DefaultStyle
            Styles.Content = DefaultStyle
            Styles.Inactive = DefaultStyle
            object grdInvHoldDBTableViewSaleCode: TcxGridDBColumn
              Caption = 'Hold #'
              DataBinding.FieldName = 'SaleCode'
            end
            object grdInvHoldDBTableViewFirstName: TcxGridDBColumn
              DataBinding.FieldName = 'FirstName'
            end
            object grdInvHoldDBTableViewLastName: TcxGridDBColumn
              DataBinding.FieldName = 'LastName'
            end
            object grdInvHoldDBTableViewPreSaleDate: TcxGridDBColumn
              DataBinding.FieldName = 'PreSaleDate'
            end
            object grdInvHoldDBTableViewQty: TcxGridDBColumn
              DataBinding.FieldName = 'Qty'
            end
          end
          object grdInvHoldLevel: TcxGridLevel
            GridView = grdInvHoldDBTableView
          end
        end
      end
      object tsOrderPoint: TTabSheet
        Caption = '&AutoRequest'
        DesignSize = (
          782
          267)
        object Label9: TLabel
          Left = 133
          Top = 38
          Width = 55
          Height = 13
          Alignment = taRightJustify
          Caption = 'Class ABC :'
        end
        object Label43: TLabel
          Left = 282
          Top = 38
          Width = 328
          Height = 13
          Caption = 
            'Automatically calculated by the system unless marked "E" (Strate' +
            'gic)'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label45: TLabel
          Left = 282
          Top = 78
          Width = 327
          Height = 13
          Caption = 'Average time delay in days, between Purchase Order and Receiving'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label46: TLabel
          Left = 282
          Top = 122
          Width = 496
          Height = 28
          AutoSize = False
          Caption = 
            'Quantity added in the Order Point, calculated by the security pe' +
            'rcentage of Class ABC'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          WordWrap = True
        end
        object Label47: TLabel
          Left = 282
          Top = 166
          Width = 489
          Height = 29
          AutoSize = False
          Caption = 
            'Sales average in period of the class ABC.  The sales average wit' +
            'h "average time" will determine the Order Point.'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          WordWrap = True
        end
        object Label48: TLabel
          Left = 282
          Top = 213
          Width = 344
          Height = 13
          Caption = 
            'Quantity on hand at which point the system will Auto-Request thi' +
            's item.'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label40: TLabel
          Left = 126
          Top = 213
          Width = 62
          Height = 13
          Alignment = taRightJustify
          Caption = 'Order Point :'
        end
        object Label39: TLabel
          Left = 131
          Top = 168
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Daily sales :'
        end
        object Label26: TLabel
          Left = 114
          Top = 123
          Width = 74
          Height = 13
          Alignment = taRightJustify
          Caption = 'Safety margin :'
        end
        object Label41: TLabel
          Left = 133
          Top = 78
          Width = 55
          Height = 13
          Alignment = taRightJustify
          Caption = 'Lead Time :'
        end
        object DBComboBox1: TDBComboBox
          Left = 193
          Top = 35
          Width = 81
          Height = 21
          DataField = 'ClasseABC'
          DataSource = dsForm
          ItemHeight = 13
          Items.Strings = (
            'A'
            'B'
            'C'
            'E')
          TabOrder = 0
        end
        object DBEdit7: TDBEdit
          Left = 193
          Top = 210
          Width = 81
          Height = 21
          DataField = 'PP'
          DataSource = dsForm
          ParentColor = True
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit6: TDBEdit
          Left = 193
          Top = 165
          Width = 81
          Height = 21
          DataField = 'PVD'
          DataSource = dsForm
          ParentColor = True
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit5: TDBEdit
          Left = 193
          Top = 120
          Width = 81
          Height = 21
          DataField = 'ES'
          DataSource = dsForm
          ParentColor = True
          ReadOnly = True
          TabOrder = 3
        end
        object DBEdit8: TDBEdit
          Left = 193
          Top = 75
          Width = 81
          Height = 21
          DataField = 'TR'
          DataSource = dsForm
          ReadOnly = True
          TabOrder = 4
        end
        object DBCheckBox1: TDBCheckBox
          Left = 193
          Top = 245
          Width = 291
          Height = 17
          Caption = 'Make Auto-Request for this model'
          DataField = 'AutomaticRequest'
          DataSource = dsForm
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object pnlTitle15: TPanel
          Left = -2
          Top = 0
          Width = 786
          Height = 16
          Anchors = [akLeft, akTop, akRight]
          BevelOuter = bvNone
          Caption = 'Automatic request settings'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
        end
      end
    end
  end
  object pnlLookUp: TPanel [6]
    Left = 0
    Top = 34
    Width = 790
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 0
    Visible = False
    DesignSize = (
      790
      36)
    object Label10: TLabel
      Left = 4
      Top = 2
      Width = 89
      Height = 28
      Alignment = taRightJustify
      Caption = 'Look Up'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
    end
    object btAdd: TSpeedButton
      Left = 671
      Top = 5
      Width = 24
      Height = 25
      Hint = 'Insert new model'
      Anchors = [akTop, akRight]
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888888888888800000000000888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F0
        8888880FFFFFF008888888000000008888888888888888888888}
      ParentFont = False
      Visible = False
      OnClick = btAddClick
    end
    object btRemove: TSpeedButton
      Left = 689
      Top = 5
      Width = 20
      Height = 25
      Hint = 'After delete close the screen'
      Anchors = [akTop, akRight]
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888808888888888088800088888888888880000888888
        8088888000888888088888880008888008888888800088008888888888000008
        8888888888800088888888888800000888888888800088008888888000088880
        0888880000888888008888000888888888088888888888888888}
      ParentFont = False
      Visible = False
      OnClick = btRemoveClick
    end
    object btBarcodeSearch: TSpeedButton
      Left = 217
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Search Barcode'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF840000FFFF00FF0000FF0000000000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF840000FF
        FF00FF0000FF0000C6C7C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF840000FFFF00FF0000FF0000C6C7C6FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF848684000000000000848684C6C7C6FF0000FF
        0000C6C7C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848684C6C7C6
        FFFF00C6C7C6000000848684848684C6C7C68080808080808080808080808080
        80FFFFFF000000FFFFFFFFFFFFFFFF00C6C7C6FFFF00C6C7C6000000C6C7C6FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF00FFFFFF
        FFFF00C6C7C6FFFF00000000C6C7C6C0C0C0000000000000FFFFFF000000C0C0
        C0FFFFFF000000FFFFFFFFFFFFFFFF00FFFFFFFFFF00C6C7C6000000C6C7C6C0
        C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFF848684FFFFFF
        FFFF00FFFFFF000000C6C7C6000000C0C0C0000000000000FFFFFF000000C0C0
        C0FFFFFF000000FFFFFFFFFFFF848684848684000000C6C7C6FFFFFF000000C0
        C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFFFFFFFF000000
        000000FFFFFF000000FFFFFF000000C0C0C0000000000000FFFFFF000000C0C0
        C0FFFFFF000000FFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000C0
        C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFFFFFFFF000000
        000000FFFFFF000000FFFFFF000000C0C0C0000000000000FFFFFF000000C0C0
        C0FFFFFF000000FFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000C0
        C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFFFFFFFF000000
        000000FFFFFF000000FFFFFF000000C0C0C0000000000000FFFFFF000000C0C0
        C0FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      OnClick = btBarcodeSearchClick
    end
    object scLookUp: TSuperComboADO
      Left = 245
      Top = 5
      Width = 431
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      CodeLength = 280
      LookUpSource = DM.dsLookUpModelMasterPack
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      ShowEditCode = True
      EditCodePos = taEditCodeRight
      MostraHidden = STD_AMBOSHIDDEN
      IDLanguage = 0
      OnSelectItem = scLookUpSelectItem
    end
    object rbLookByModel: TRadioButton
      Left = 710
      Top = 0
      Width = 80
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'By Model'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = True
      Visible = False
      OnClick = rbLookByModelClick
    end
    object rbLookByBarCode: TRadioButton
      Left = 710
      Top = 17
      Width = 80
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'By BarCode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = rbLookByBarCodeClick
    end
    object edtBarcode: TmrBarCodeEdit
      Left = 101
      Top = 5
      Width = 114
      Height = 24
      Color = 8454143
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = edtBarcodeEnter
      OnExit = edtBarcodeExit
      Connection = DM.ADODBConnect
      SQL.Strings = (
        'SELECT'
        '      B.IDModel,'
        '      M.IDModelParent'
        'FROM'
        '      Barcode B'
        '      JOIN Model M ON (B.IDModel = M.IDModel)'
        'WHERE'
        '      B.IDBarcode = :IDBarcode')
      SecondSQL.Strings = (
        'SELECT'
        '      B.IDModel,'
        '      M.IDModelParent'
        'FROM'
        '      Barcode B'
        '      JOIN Model M ON (B.IDModel = M.IDModel)'
        'WHERE'
        '      M.Model = :Model')
      KeyField = 'IDBarcode'
      SecondKeyField = 'Model'
      DisplayQty = False
      RunSecondSQL = False
      CheckBarcodeDigit = 0
      MinimalDigits = 0
      AfterSearchBarcode = edtBarcodeAfterSearchBarcode
    end
  end
  inherited EspacamentoDireito: TPanel
    Left = 790
    Top = 70
    Width = 0
    Height = 435
    TabOrder = 6
    Visible = False
  end
  object quBarCode: TADOQuery [8]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnPostError = quBarCodePostError
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDModel,'
      #9'IDBarcode,'
      #9'Data,'
      #9'BarcodeOrder,'
      #9'Qty'
      'FROM'
      #9'Barcode (NOLOCK)'
      'WHERE'
      #9'IDModel = :IDModel'
      'ORDER BY'
      #9'BarcodeOrder')
    Left = 25
    Top = 434
    object quBarCodeIDModel: TIntegerField
      FieldName = 'IDModel'
      Origin = 'Barcode.IDModel'
    end
    object quBarCodeIDBarcode: TStringField
      DisplayLabel = 'Barcode'
      FieldName = 'IDBarcode'
      Origin = 'Barcode.IDBarcode'
    end
    object quBarCodeData: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'Data'
      Origin = 'Barcode.Data'
      DisplayFormat = 'ddddd'
    end
    object quBarCodeBarcodeOrder: TIntegerField
      FieldName = 'BarcodeOrder'
    end
    object quBarCodeQty: TFloatField
      FieldName = 'Qty'
    end
  end
  object dsBarCode: TDataSource [9]
    DataSet = quBarCode
    OnStateChange = dsBarCodeStateChange
    OnDataChange = dsBarCodeDataChange
    Left = 176
    Top = 462
  end
  object quAddSpecialPrice: TADOQuery [10]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT ModelToSpecialPrice SELECT :IDModel, SpecialPrice.IDSpeci' +
        'alPrice, 0 FROM SpecialPrice WHERE SpecialPrice.Desativado = 0')
    Left = 389
    Top = 440
  end
  object quSpecialPrice: TADOQuery [11]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quSpecialPriceAfterOpen
    AfterEdit = quSpecialPriceAfterEdit
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        MTSP.IDSpecialPrice,'
      '        SP.SpecialPrice,'
      '        MTSP.MarkUp'
      'FROM'
      '        ModelToSpecialPrice MTSP'
      
        '        JOIN SpecialPrice SP ON (MTSP.IDSpecialPrice = SP.IDSpec' +
        'ialPrice)'
      'WHERE'
      '        MTSP.IDModel = :IDModel'
      ' '
      ' ')
    Left = 709
    Top = 369
    object quSpecialPriceIDSpecialPrice: TIntegerField
      FieldName = 'IDSpecialPrice'
    end
    object quSpecialPriceSpecialPrice: TStringField
      FieldName = 'SpecialPrice'
      ReadOnly = True
      Size = 30
    end
    object quSpecialPriceMarkUp: TBCDField
      DisplayLabel = 'MarkUp %'
      FieldName = 'MarkUp'
      DisplayFormat = '#,#0.00 %'
      Precision = 19
    end
  end
  object dsSpecialPrice: TDataSource [12]
    DataSet = quSpecialPrice
    OnStateChange = dsSpecialPriceStateChange
    Left = 575
    Top = 365
  end
  object quRemoveSpecialPrice: TADOQuery [13]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'DELETE FROM ModelToSpecialPrice WHERE IDModel = :IDModel'
      ' ')
    Left = 415
    Top = 333
  end
  object quKitModel: TADOQuery [14]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quKitModelAfterOpen
    AfterEdit = quKitModelAfterEdit
    AfterPost = quKitModelAfterPost
    OnNewRecord = quKitModelNewRecord
    OnPostError = quKitModelPostError
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDModel,'
      #9'Qty,'
      #9'SellingPrice,'
      #9'MarginPerc'
      'FROM'
      #9'KitModel (NOLOCK)'
      'WHERE'
      #9'IDModel = :IDModel')
    Left = 110
    Top = 461
    object quKitModelSellingPrice: TFloatField
      DisplayLabel = 'Our Price'
      FieldName = 'SellingPrice'
      Origin = 'KitModel.SellingPrice'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quKitModelIDModel: TIntegerField
      FieldName = 'IDModel'
      Origin = 'KitModel.IDModel'
    end
    object quKitModelQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quKitModelMarginPerc: TFloatField
      FieldName = 'MarginPerc'
      OnValidate = quKitModelMarginPercValidate
    end
  end
  object dsKitModel: TDataSource [15]
    DataSet = quKitModel
    OnStateChange = dsKitModelStateChange
    Left = 268
    Top = 458
  end
  object dsQuantity: TDataSource [16]
    DataSet = spquQuantity
    Left = 5
    Top = 236
  end
  object spquQuantity: TADOStoredProc [17]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    AfterOpen = spquQuantityAfterOpen
    ProcedureName = 'sp_PreSale_quQtyOnStore;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@ModelID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 14
    Top = 160
    object spquQuantityName: TStringField
      DisplayLabel = 'Store'
      DisplayWidth = 33
      FieldName = 'Name'
      Size = 30
    end
    object spquQuantityStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object spquQuantityCurrentCost: TFloatField
      FieldName = 'CurrentCost'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object spquQuantityQtyOnPreSale: TFloatField
      FieldName = 'QtyOnPreSale'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnRepair: TFloatField
      FieldName = 'QtyOnRepair'
      DisplayFormat = '0.#####'
    end
    object spquQuantityQtyOnPrePurchase: TFloatField
      FieldName = 'QtyOnPrePurchase'
      DisplayFormat = '0.#####'
    end
    object spquQuantityFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
  end
  object quInvHold: TADOQuery [18]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale,'
      #9'I.SaleCode,'
      #9'I.PreSaleDate,'
      #9'I.FirstName,'
      #9'I.LastName,'
      #9'PIM.Qty'
      'FROM'
      #9'Invoice I (NOLOCK)'
      
        #9'JOIN PreInventoryMov PIM (NOLOCK) ON (PIM.InventMovTypeID = 1 A' +
        'ND I.IDPreSale = PIM.DocumentID)'
      'WHERE'
      #9'IDInvoice Is Null'
      #9'AND PIM.ModelID = :IDModel')
    Left = 221
    Top = 436
    object quInvHoldIDPreSale: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Hold #'
      FieldName = 'IDPreSale'
      Origin = '"dbo.Invoice".IDPreSale'
    end
    object quInvHoldSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object quInvHoldPreSaleDate: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Date'
      FieldName = 'PreSaleDate'
      Origin = '"dbo.Invoice".PreSaleDate'
      DisplayFormat = 'ddddd'
    end
    object quInvHoldFirstName: TStringField
      FieldName = 'FirstName'
    end
    object quInvHoldLastName: TStringField
      FieldName = 'LastName'
    end
    object quInvHoldQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object DsInvHold: TDataSource [19]
    DataSet = quInvHold
    Left = 707
    Top = 323
  end
  object quSerial: TADOQuery [20]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quSerialAfterOpen
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'ST.Name,'
      #9'Serial,'
      #9'ISN.StoreID'
      'FROM'
      #9'InventorySerial ISN (NOLOCK)'
      #9'JOIN Store ST (NOLOCK) ON (ISN.StoreID = ST.IDStore)'
      'WHERE'
      #9'ISN.ModelID = :IDModel'
      'ORDER BY'
      #9'ST.Name')
    Left = 315
    Top = 437
    object quSerialName: TStringField
      DisplayLabel = 'Store'
      FieldName = 'Name'
      Origin = 'Store.Name'
      ReadOnly = True
      Size = 30
    end
    object quSerialSerial: TStringField
      FieldName = 'Serial'
      Origin = 'InventorySerial.Serial'
      ReadOnly = True
      Size = 30
    end
    object quSerialStoreID: TIntegerField
      FieldName = 'StoreID'
      Origin = 'Store.Name'
      ReadOnly = True
    end
  end
  object dsSerial: TDataSource [21]
    DataSet = quSerial
    OnStateChange = dsSerialStateChange
    Left = 193
    Top = 424
  end
  object quGrid: TADOQuery [22]
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
      #9'SM.IDModel,'
      #9'SM.Desativado,'
      #9'C.Color,'
      #9'C.CodColor,'
      #9'S.SizeName,'
      #9'S.CodSize,'
      #9'SUM(IsNull(I.QtyOnHand,0)) as TotQtyOnHand,'
      #9'SM.SellingPrice,'
      #9'SM.SuggRetail'
      'FROM'
      #9'Model SM (NOLOCK)'
      #9'LEFT OUTER JOIN InvColor C (NOLOCK) ON (SM.IDColor = C.IDColor)'
      #9'LEFT OUTER JOIN InvSize S (NOLOCK) ON (SM.IDSize = S.IDSize)'
      #9'LEFT JOIN Inventory I (NOLOCK) ON (I.ModelID = SM.IDModel)'
      'WHERE'
      #9'SM.IDModelParent = :IDModelParent'
      'GROUP BY'
      #9'SM.IDModel,'
      #9'SM.Desativado,'
      #9'C.Color,'
      #9'C.CodColor,'
      #9'S.SizeName,'
      #9'S.CodSize,'
      #9'SM.SellingPrice,'
      #9'SM.SuggRetail')
    Left = 171
    Top = 383
    object quGridIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quGridColor: TStringField
      FieldName = 'Color'
    end
    object quGridCodColor: TStringField
      FieldName = 'CodColor'
      Size = 10
    end
    object quGridSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quGridCodSize: TStringField
      FieldName = 'CodSize'
      Size = 10
    end
    object quGridSellingPrice: TFloatField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00##'
    end
    object quGridSuggRetail: TFloatField
      FieldName = 'SuggRetail'
    end
    object quGridDesativado: TIntegerField
      FieldName = 'Desativado'
    end
    object quGridTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchModel.sil'
  end
  inherited dsForm: TDataSource
    Left = 725
    Top = 116
  end
  object dsPackModel: TDataSource [25]
    DataSet = quPackModel
    Left = 640
    Top = 411
  end
  object quPackModel: TADOQuery [26]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quPackModelAfterOpen
    Parameters = <
      item
        Name = 'IDPackModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PM.IDPackModel,'
      #9'PM.IDModel,'
      #9'PM.Qty,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.SellingPrice,'
      #9'M.VendorCost,'
      #9'M.FinalCost,'
      #9'M.TotQtyOnHand'
      'FROM'
      #9'PackModel PM (NOLOCK)'
      #9'LEFT OUTER JOIN Model M (NOLOCK) ON (PM.IDModel = M.IDModel)'
      'WHERE'
      #9'PM.IDPackModel = :IDPackModel')
    Left = 637
    Top = 458
    object quPackModelIDPackModel: TIntegerField
      FieldName = 'IDPackModel'
    end
    object quPackModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quPackModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPackModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPackModelSellingPrice: TBCDField
      DisplayLabel = 'Our Price'
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quPackModelVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quPackModelFinalCost: TBCDField
      DisplayLabel = 'Cost'
      FieldName = 'FinalCost'
      ReadOnly = True
      Precision = 19
    end
    object quPackModelQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quPackModelTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      DisplayFormat = '0.#####'
    end
  end
  object quAccessory: TADOQuery [27]
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'IA.IDInvAccessory,'
      #9'IA.IDModel,'
      #9'(M.Model + '#39' - '#39'+ M.Description) as Model,'
      #9'IA.Description'
      'FROM'
      #9'InvAccessory IA (NOLOCK)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel=IA.IDInvAccessory)'
      'WHERE'
      #9'IA.IDModel = :IDModel')
    Left = 717
    Top = 458
    object quAccessoryIDInvAccessory: TIntegerField
      FieldName = 'IDInvAccessory'
    end
    object quAccessoryIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quAccessoryModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 83
    end
    object quAccessoryDescription: TStringField
      DisplayLabel = 'Hint'
      FieldName = 'Description'
      Size = 255
    end
  end
  object dsAccessory: TDataSource [28]
    DataSet = quAccessory
    Left = 720
    Top = 411
  end
  object quFeatures: TADOQuery [29]
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'F.IDInvFeatures,'
      #9'F.Feature'
      'FROM'
      #9'InvFeatures F (NOLOCK)'
      'WHERE'
      #9'F.IDModel = :IDModel')
    Left = 701
    Top = 273
    object quFeaturesIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object quFeaturesFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object dsFeatures: TDataSource [30]
    DataSet = quFeatures
    Left = 576
    Top = 294
  end
  object quTechFeature: TADOQuery [31]
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'F.IDInvTechFeatures,'
      #9'F.TechFeature'
      'FROM'
      #9'InvTechFeatures F (NOLOCK)'
      'WHERE'
      #9'F.IDModel = :IDModel')
    Left = 346
    Top = 141
    object quTechFeatureIDInvTechFeatures: TIntegerField
      FieldName = 'IDInvTechFeatures'
    end
    object quTechFeatureTechFeature: TStringField
      FieldName = 'TechFeature'
      Size = 255
    end
  end
  object dsTechFeature: TDataSource [32]
    DataSet = quTechFeature
    Left = 14
    Top = 321
  end
  object quVendorCode: TADOQuery [33]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'VM.IDVendorModelCode,'
      #9'VM.IDPessoa,'
      #9'VM.IDModel,'
      #9'VM.VendorCode,'
      #9'F.Pessoa as Vendor'
      'FROM'
      #9'VendorModelCode VM (NOLOCK)'
      #9'JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = VM.IDPessoa)'
      'WHERE'
      #9'VM.IDModel = :IDModel')
    Left = 639
    Top = 277
    object quVendorCodeIDVendorModelCode: TIntegerField
      FieldName = 'IDVendorModelCode'
    end
    object quVendorCodeIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quVendorCodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quVendorCodeVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quVendorCodeVendorCode: TStringField
      DisplayLabel = 'Code'
      FieldName = 'VendorCode'
      Size = 35
    end
  end
  object spModelSizeColorName: TADOStoredProc [34]
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_Sub_AtuModelName;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModelMaster'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 684
    Top = 213
  end
  object quStorePrice: TADODataSet [35]
    Connection = DM.ADODBConnect
    AfterOpen = quStorePriceAfterOpen
    CommandText = 
      'SELECT'#13#10#9'I.SellingPrice,'#13#10#9'I.StoreCostPrice,'#13#10#9'I.StoreAvgPrice'#13#10 +
      'FROM'#13#10#9'Inventory I (NOLOCK)'#13#10'WHERE'#13#10#9'I.ModelID = :IDModel'#13#10#9'AND'#13 +
      #10#9'I.StoreID = :IDStore'#13#10
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
      end>
    Left = 413
    Top = 131
    object quStorePriceSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quStorePriceStoreCostPrice: TBCDField
      FieldName = 'StoreCostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quStorePriceStoreAvgPrice: TBCDField
      FieldName = 'StoreAvgPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object quModelVendor: TADOQuery [36]
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'MV.IDPessoa,'
      #9'MV.IDModel,'
      #9'MV.VendorOrder,'
      #9'MV.MinQtyPO,'
      #9'CaseQty,'#9
      #9'F.Pessoa as Vendor,'
      #9'MV.VendorCost,'
      #9'MV.CostLastChange'
      'FROM'
      #9'Inv_ModelVendor MV (NOLOCK)'
      #9'JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = MV.IDPessoa)'
      'WHERE'
      #9'MV.IDModel = :IDModel'
      'ORDER BY'
      #9'MV.VendorOrder')
    Left = 315
    Top = 142
    object quModelVendorIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quModelVendorIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelVendorVendorOrder: TIntegerField
      DisplayLabel = 'Order'
      FieldName = 'VendorOrder'
    end
    object quModelVendorVendor: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 50
    end
    object quModelVendorMinQtyPO: TFloatField
      FieldName = 'MinQtyPO'
    end
    object quModelVendorCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object quModelVendorVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quModelVendorCostLastChange: TDateTimeField
      FieldName = 'CostLastChange'
    end
  end
  object dsModelVendor: TDataSource [37]
    DataSet = cdsModelVendor
    OnStateChange = dsModelVendorStateChange
    Left = 381
    Top = 127
  end
  object quModelReceipt: TADOQuery [38]
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
      end>
    SQL.Strings = (
      'SELECT'
      #9'MR.IDModelReceipt,'
      #9'MR.ReceiptText'
      'FROM'
      #9'Inv_ModelReceipt MR (NOLOCK)'
      'WHERE'
      #9'MR.IDModel = :IDModel')
    Left = 636
    Top = 357
    object quModelReceiptIDModelReceipt: TStringField
      FieldName = 'IDModelReceipt'
    end
    object quModelReceiptReceiptText: TStringField
      FieldName = 'ReceiptText'
      Size = 255
    end
  end
  object dsModelReceipt: TDataSource [39]
    DataSet = quModelReceipt
    OnStateChange = dsModelReceiptStateChange
    Left = 637
    Top = 314
  end
  object cdsModelVendor: TClientDataSet [40]
    Aggregates = <>
    Params = <>
    Left = 468
    Top = 292
    object cdsModelVendorIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelVendorIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsModelVendorVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsModelVendorVendorOrder: TIntegerField
      FieldName = 'VendorOrder'
    end
    object cdsModelVendorMinQtyPO: TFloatField
      FieldName = 'MinQtyPO'
    end
    object cdsModelVendorCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object cdsModelVendorVendorCodeList: TStringField
      FieldName = 'VendorCodeList'
      Size = 255
    end
    object cdsModelVendorVendorCost: TCurrencyField
      FieldName = 'VendorCost'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelVendorCostLastChange: TDateTimeField
      DisplayLabel = 'Last Update'
      FieldName = 'CostLastChange'
      DisplayFormat = 'ddddd'
    end
  end
  object grdStyle: TcxStyleRepository [41]
    Left = 724
    Top = 160
    object DefaultStyle: TcxStyle
      AssignedValues = [svColor]
      Color = 14607076
    end
  end
  object dsStateTax: TDataSource [42]
    DataSet = quStateTax
    Left = 521
    Top = 414
  end
  object quStateTax: TADODataSet [43]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'ES.IDEstado,'#13#10#9'ES.Estado,'#13#10#9'TX.IDTaxCategory,'#13#10#9'TX.TaxC' +
      'ategory,'#13#10#9'TX.Tax'#13#10'FROM'#13#10#9'Inv_ModelStateTax ST (NOLOCK)'#13#10#9'JOIN T' +
      'axCategory TX (NOLOCK) ON (TX.IDTaxCategory = ST.IDTaxCategory)'#13 +
      #10#9'JOIN Estado ES (NOLOCK) ON (ES.IDEstado = ST.IDEstado)'#13#10'WHERE'#13 +
      #10#9'ST.IDModel = :IDModel'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 521
    Top = 374
    object quStateTaxEstado: TStringField
      FieldName = 'Estado'
      Size = 50
    end
    object quStateTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quStateTaxTax: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quStateTaxIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quStateTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
  end
  object dsNutritionItem: TDataSource [44]
    DataSet = quNutritionList
    Left = 194
    Top = 281
  end
  object quNutritionList: TADODataSet [45]
    Connection = DM.ADODBConnect
    AfterOpen = quNutritionListAfterOpen
    CommandText = 
      'SELECT '#13#10#9'N.IDNutritionItem,'#13#10#9'N.IDModel,'#13#10#9'N.QtyPortion, '#13#10#9'N.V' +
      'DPortion,'#13#10#9'NI.Description'#13#10'FROM '#13#10#9'Inv_ModelNutrition N (NOLOCK' +
      ')'#13#10#9'JOIN Inv_NutritionItem NI (NOLOCK) ON (N.IDNutritionItem = N' +
      'I.IDNutritionItem)'#13#10'WHERE'#13#10#9'N.IDModel = :IDModel'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 166
    Top = 339
    object quNutritionListIDNutritionItem: TIntegerField
      FieldName = 'IDNutritionItem'
    end
    object quNutritionListIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quNutritionListDescription: TStringField
      FieldName = 'Description'
      Size = 100
    end
    object quNutritionListQtyPortion: TBCDField
      FieldName = 'QtyPortion'
      DisplayFormat = '0.##'
      Precision = 32
    end
    object quNutritionListVDPortion: TBCDField
      FieldName = 'VDPortion'
      DisplayFormat = '0.##'
      Precision = 32
    end
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforeOpen = quFormBeforeOpen
    BeforeClose = quFormBeforeClose
    BeforePost = quFormBeforePost
    BeforeCancel = quFormBeforeCancel
    AfterScroll = quFormAfterScroll
    OnCalcFields = quFormCalcFields
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'Model,'#13#10#9'm.IDModel,'#13#10#9'GroupID,'#13#10#9'Description,'#13#10#9'Freight' +
      'Cost,'#13#10#9'OtherCost,'#13#10#9'VendorCost,'#13#10#9'SuggRetail,'#13#10#9'DateLastCost,'#13#10 +
      #9'MarkUp,'#13#10#9'SellingPrice,'#13#10#9'DateLastSellingPrice,'#13#10#9'IDUserLastSel' +
      'lingPrice,'#9#13#10#9'Peso,'#13#10#9'IDFabricante,'#13#10#9'System,'#13#10#9'Desativado,'#13#10#9'Hi' +
      'dden,'#13#10#9'ModelType,'#13#10#9'IDColor,'#13#10#9'IDSize,'#13#10#9'IDUnidade,'#13#10#9'LastCost,' +
      #13#10#9'LastMovDate,'#13#10#9'ClasseABC,'#13#10#9'ES,'#13#10#9'PVD,'#13#10#9'PP,'#13#10#9'TR,'#13#10#9'Automati' +
      'cRequest,'#13#10#9'AvgCost,'#13#10#9'ReplacementCost,'#13#10#9'FloatPercent,'#13#10#9'NotVer' +
      'ifyQty,'#13#10#9'PromotionPrice,'#13#10#9'DiscountPerc,'#13#10#9'TotQtyOnHand,'#13#10#9'Cust' +
      'omSalePrice,'#13#10#9'CaseQty,'#13#10#9'Verify,'#13#10#9'IDModelGroup,'#13#10#9'IDModelSubGr' +
      'oup,'#13#10#9'SendToTrash,'#13#10#9'AskUserOnSale,'#13#10#9'UpdatePrice,'#13#10#9'UseScale,'#13 +
      #10#9'ScaleValidDay,'#13#10#9'UseLot,'#13#10#9'IndicadorProducao,'#13#10#9'IndicadorAT,'#13#10 +
      #9'IDNCM,'#13#10#9'WebDescription,'#13#10#9'Portion,'#13#10#9'IDCFOP'#13#10#9',Ld.lastReceived' +
      #13#10'FROM'#13#10#9'Model m (NOLOCK) '#13#10#9'left outer join (select max(p.dateF' +
      'inalReceiving) LastReceived'#13#10#9'            ,m.idmodel'#13#10#9#9'  from P' +
      'ur_Purchase p'#13#10#9#9#9'   join Pur_PurchaseItem pci on p.idPurchase =' +
      ' pci.idPurchase'#13#10#9#9#9'   join model m on m.idModel = pci.idModel'#13#10 +
      #9#9'  group by m.idModel'#9'   '#13#10#9#9'  ) Ld on Ld.idModel = m.idModel'#13#10 +
      'WHERE  m.idmodel = :idmodel'#9#13#10#13#10#13#10#13#10'     '#13#10#13#10#13#10
    Parameters = <
      item
        Name = 'IDModel'#9
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 726
    Top = 71
    object quFormModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quFormIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quFormGroupID: TIntegerField
      FieldName = 'GroupID'
    end
    object quFormDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quFormFreightCost: TBCDField
      FieldName = 'FreightCost'
      Precision = 19
    end
    object quFormOtherCost: TBCDField
      FieldName = 'OtherCost'
      Precision = 19
    end
    object quFormVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quFormSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quFormDateLastCost: TDateTimeField
      FieldName = 'DateLastCost'
    end
    object quFormMarkUp: TBCDField
      FieldName = 'MarkUp'
      Precision = 19
    end
    object quFormSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quFormDateLastSellingPrice: TDateTimeField
      FieldName = 'DateLastSellingPrice'
    end
    object quFormIDUserLastSellingPrice: TIntegerField
      FieldName = 'IDUserLastSellingPrice'
    end
    object quFormPeso: TBCDField
      FieldName = 'Peso'
      Precision = 19
    end
    object quFormIDFabricante: TIntegerField
      FieldName = 'IDFabricante'
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
    end
    object quFormDesativado: TIntegerField
      FieldName = 'Desativado'
    end
    object quFormHidden: TIntegerField
      FieldName = 'Hidden'
    end
    object quFormModelType: TStringField
      FieldName = 'ModelType'
      FixedChar = True
      Size = 1
    end
    object quFormIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object quFormIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object quFormIDUnidade: TIntegerField
      FieldName = 'IDUnidade'
    end
    object quFormLastCost: TBCDField
      FieldName = 'LastCost'
      Precision = 19
    end
    object quFormLastMovDate: TDateTimeField
      FieldName = 'LastMovDate'
    end
    object quFormClasseABC: TStringField
      FieldName = 'ClasseABC'
      FixedChar = True
      Size = 1
    end
    object quFormES: TBCDField
      FieldName = 'ES'
      Precision = 19
    end
    object quFormPVD: TBCDField
      FieldName = 'PVD'
      Precision = 19
    end
    object quFormPP: TBCDField
      FieldName = 'PP'
      Precision = 19
    end
    object quFormTR: TIntegerField
      FieldName = 'TR'
    end
    object quFormAutomaticRequest: TBooleanField
      FieldName = 'AutomaticRequest'
    end
    object quFormAvgCost: TBCDField
      FieldName = 'AvgCost'
      Precision = 19
    end
    object quFormReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quFormFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object quFormNotVerifyQty: TBooleanField
      FieldName = 'NotVerifyQty'
    end
    object quFormPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object quFormDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
    object quFormTotQtyOnHand: TBCDField
      FieldName = 'TotQtyOnHand'
      Precision = 38
    end
    object quFormCustomSalePrice: TBooleanField
      FieldName = 'CustomSalePrice'
    end
    object quFormCaseQty: TBCDField
      FieldName = 'CaseQty'
      Precision = 38
    end
    object quFormVerify: TBooleanField
      FieldName = 'Verify'
    end
    object quFormIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object quFormIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object quFormSendToTrash: TBooleanField
      FieldName = 'SendToTrash'
    end
    object quFormAskUserOnSale: TBooleanField
      FieldName = 'AskUserOnSale'
    end
    object quFormUpdatePrice: TBooleanField
      FieldName = 'UpdatePrice'
    end
    object quFormUseScale: TBooleanField
      FieldName = 'UseScale'
    end
    object quFormScaleValidDay: TIntegerField
      FieldName = 'ScaleValidDay'
    end
    object quFormUseLot: TBooleanField
      FieldName = 'UseLot'
    end
    object quFormIndicadorProducao: TStringField
      FieldName = 'IndicadorProducao'
      FixedChar = True
      Size = 1
    end
    object quFormIndicadorAT: TStringField
      FieldName = 'IndicadorAT'
      FixedChar = True
      Size = 1
    end
    object quFormIDNCM: TIntegerField
      FieldName = 'IDNCM'
    end
    object quFormWebDescription: TStringField
      FieldName = 'WebDescription'
      Size = 255
    end
    object quFormPortion: TStringField
      FieldName = 'Portion'
      Size = 100
    end
    object quFormIDCFOP: TIntegerField
      FieldName = 'IDCFOP'
    end
    object quFormlastReceived: TDateTimeField
      FieldName = 'lastReceived'
      ReadOnly = True
    end
    object quFormRealMarkupPercet: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'RealMarkupPercet'
      Calculated = True
    end
    object quFormRealMarkupValue: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'RealMarkupValue'
      Calculated = True
    end
    object quFormFinalCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'FinalCost'
      Calculated = True
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    ConfirmPost = False
    AutoIncField = 'IDModel'
    RequiredFields.Strings = (
      'Model'
      'Description'
      'GroupID')
    DependentTables.Strings = (
      'Barcode'
      'KitModel'
      'InventorySerial'
      'InvFeatures'
      'InvAccessory'
      'PackModel'
      'InvTechFeatures'
      'Inv_ModelVendor')
    DependentTableKeys.Strings = (
      'IDModel'
      'IDModel'
      'ModelID'
      'IDModel'
      'IDModel'
      'IDPackModel'
      'IDModel'
      'IDModel')
    Left = 20
    Top = 85
  end
end
