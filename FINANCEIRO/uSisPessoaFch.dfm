inherited SisPessoaFch: TSisPessoaFch
  Left = 273
  Top = 27
  Caption = 'SisPessoaFch'
  ClientHeight = 529
  ClientWidth = 497
  PixelsPerInch = 96
  TextHeight = 13
  object lblCode: TLabel [0]
    Left = 74
    Top = 64
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'Code :'
  end
  object lblComissaoSobreGuia: TLabel [1]
    Left = 8
    Top = 121
    Width = 99
    Height = 13
    Caption = 'Agency commission :'
    FocusControl = edComissaoSobreGuia
  end
  object Label15: TLabel [2]
    Left = 46
    Top = 38
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Entity type :'
  end
  object Label36: TLabel [3]
    Left = 428
    Top = 36
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlBusiness: TPanel [4]
    Left = 30
    Top = 91
    Width = 421
    Height = 22
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Label34: TLabel
      Left = 25
      Top = 5
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Company :'
    end
    object Label35: TLabel
      Left = 398
      Top = 3
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edPessoa: TDBEdit
      Left = 80
      Top = 0
      Width = 316
      Height = 21
      AutoSize = False
      DataField = 'Pessoa'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  object pnlPersonal: TPanel [5]
    Left = 30
    Top = 90
    Width = 426
    Height = 25
    BevelOuter = bvNone
    TabOrder = 0
    object Label33: TLabel
      Left = 398
      Top = 3
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label31: TLabel
      Left = 210
      Top = 5
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'Last Name :'
    end
    object Label21: TLabel
      Left = 183
      Top = 3
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPessoa: TLabel
      Left = 19
      Top = 5
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'First Name :'
    end
    object edLastName: TDBEdit
      Left = 270
      Top = 1
      Width = 126
      Height = 21
      AutoSize = False
      DataField = 'PessoaLastName'
      DataSource = dsForm
      MaxLength = 20
      TabOrder = 1
    end
    object edFirstName: TDBEdit
      Left = 80
      Top = 1
      Width = 101
      Height = 21
      AutoSize = False
      DataField = 'PessoaFirstName'
      DataSource = dsForm
      MaxLength = 20
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 110
    TabOrder = 8
  end
  inherited EspacamentoDireito: TPanel
    Left = 494
    Height = 110
    TabOrder = 9
  end
  inherited EspacamentoSuperior: TPanel
    Width = 497
    TabOrder = 10
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 488
    Width = 497
    TabOrder = 11
  end
  inherited pnlPBarra: TPanel
    Top = 492
    Width = 497
    TabOrder = 12
    inherited pnlPBarraRightAlign: TPanel
      Left = 228
    end
    inherited pnlPLinha: TPanel
      Width = 497
    end
  end
  inherited pnlPTitulo: TPanel
    Width = 497
    TabOrder = 13
    inherited lblPTituloShadow: TLabel
      Width = 119
      Caption = 'RUN TIME'
    end
    inherited lblPTitulo: TLabel
      Width = 119
      Caption = 'RUN TIME'
    end
    inherited pnlAutoInc: TPanel
      Left = 463
    end
  end
  inherited pnlBottomAlign: TPanel
    Top = 144
    Width = 497
    Height = 344
    TabOrder = 4
    inherited pnlLeftSpace: TPanel
      Height = 344
      TabOrder = 1
    end
    inherited pnlRightSpace: TPanel
      Left = 494
      Height = 344
      TabOrder = 2
    end
    inherited PPageControl: TPageControl
      Width = 491
      Height = 344
      ActivePage = tsBasic
      TabOrder = 0
      OnChange = PPageControlChange
      object tsBasic: TTabSheet
        Caption = '  Basic  '
        object Label3: TLabel
          Left = 63
          Top = 16
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Address :'
        end
        object Label4: TLabel
          Left = 328
          Top = 117
          Width = 25
          Height = 13
          Alignment = taRightJustify
          Caption = 'Fax :'
        end
        object Label46: TLabel
          Left = 315
          Top = 93
          Width = 38
          Height = 13
          Alignment = taRightJustify
          Caption = 'Beeper:'
          FocusControl = DBEditBeeper
        end
        object Label45: TLabel
          Left = 314
          Top = 68
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cellular:'
          FocusControl = DbEditCellular
        end
        object Label8: TLabel
          Left = 315
          Top = 41
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'Phone :'
        end
        object Label5: TLabel
          Left = 83
          Top = 41
          Width = 26
          Height = 13
          Alignment = taRightJustify
          Caption = 'City :'
        end
        object Label7: TLabel
          Left = 76
          Top = 66
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'State :'
        end
        object Label24: TLabel
          Left = 61
          Top = 90
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Country :'
        end
        object Label6: TLabel
          Left = 86
          Top = 113
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'ZIP :'
        end
        object Label22: TLabel
          Left = 77
          Top = 140
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Email :'
          FocusControl = EditEMail
        end
        object Label23: TLabel
          Left = 51
          Top = 163
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'HomePage :'
        end
        object pnlJuridico: TPanel
          Tag = 1
          Left = 0
          Top = 180
          Width = 694
          Height = 81
          BevelOuter = bvNone
          TabOrder = 11
          object Label2: TLabel
            Left = 82
            Top = 8
            Width = 27
            Height = 13
            Alignment = taRightJustify
            Caption = 'DBA :'
          end
          object Label17: TLabel
            Left = 41
            Top = 33
            Width = 68
            Height = 13
            Alignment = taRightJustify
            Caption = 'Federal ID # :'
          end
          object Label18: TLabel
            Left = 45
            Top = 58
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = 'Sales Tax # :'
          end
          object Label20: TLabel
            Left = 308
            Top = 33
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Contact:'
          end
          object EditDBA: TDBEdit
            Left = 112
            Top = 5
            Width = 363
            Height = 21
            DataField = 'NomeJuridico'
            DataSource = dsForm
            TabOrder = 0
          end
          object EditFederalID: TDBEdit
            Left = 112
            Top = 30
            Width = 166
            Height = 21
            DataField = 'InscEstadual'
            DataSource = dsForm
            TabOrder = 1
            OnExit = EditFederalIDExit
            OnKeyPress = EditFederalIDKeyPress
          end
          object EditSalesTax: TDBEdit
            Left = 112
            Top = 55
            Width = 166
            Height = 21
            DataField = 'InscMunicipal'
            DataSource = dsForm
            TabOrder = 2
          end
          object EditContact: TDBEdit
            Left = 353
            Top = 30
            Width = 125
            Height = 21
            DataField = 'Contatos'
            DataSource = dsForm
            TabOrder = 3
          end
        end
        object pnlFisico: TPanel
          Tag = 2
          Left = 1
          Top = 180
          Width = 580
          Height = 78
          BevelOuter = bvNone
          TabOrder = 12
          object Label10: TLabel
            Left = 22
            Top = 8
            Width = 87
            Height = 13
            Alignment = taRightJustify
            Caption = 'Social Security # :'
          end
          object Label11: TLabel
            Left = 17
            Top = 33
            Width = 92
            Height = 13
            Alignment = taRightJustify
            Caption = 'Driver'#39's Licence # :'
          end
          object Label9: TLabel
            Left = 298
            Top = 34
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'Birth Date :'
          end
          object Label16: TLabel
            Left = 48
            Top = 58
            Width = 61
            Height = 13
            Alignment = taRightJustify
            Caption = 'Emplyee ID :'
          end
          object Label32: TLabel
            Left = 264
            Top = 9
            Width = 90
            Height = 13
            Alignment = taRightJustify
            Caption = 'Customer Card # :'
          end
          object DBEdit9: TDBEdit
            Left = 112
            Top = 5
            Width = 138
            Height = 21
            DataField = 'Identidade'
            DataSource = dsForm
            TabOrder = 0
          end
          object DBEdit10: TDBEdit
            Left = 112
            Top = 30
            Width = 138
            Height = 21
            DataField = 'OrgaoEmissor'
            DataSource = dsForm
            TabOrder = 1
          end
          object DBEdit12: TDBEdit
            Left = 112
            Top = 55
            Width = 138
            Height = 21
            DataField = 'CPF'
            DataSource = dsForm
            TabOrder = 2
            OnExit = DBEdit12Exit
            OnKeyPress = DBEdit12KeyPress
          end
          object DBEdit1: TDBEdit
            Left = 355
            Top = 5
            Width = 123
            Height = 21
            DataField = 'CustomerCard'
            DataSource = dsForm
            TabOrder = 3
          end
          object DBDateBox1: TDBDateBox
            Left = 355
            Top = 30
            Width = 123
            Height = 21
            ReadOnly = False
            TabOrder = 4
            DataField = 'Nascimento'
            DataSource = dsForm
          end
        end
        object edtAddress: TDBEdit
          Left = 112
          Top = 13
          Width = 364
          Height = 21
          DataField = 'Endereco'
          DataSource = dsForm
          TabOrder = 0
        end
        object MemoPhone: TDbMemoStr
          Left = 357
          Top = 38
          Width = 122
          Height = 21
          DataField = 'Telefone'
          DataSource = dsForm
          TabOrder = 5
        end
        object DbEditCellular: TDBEdit
          Left = 357
          Top = 64
          Width = 122
          Height = 21
          DataField = 'Cellular'
          DataSource = dsForm
          TabOrder = 6
        end
        object DBEditBeeper: TDBEdit
          Left = 357
          Top = 88
          Width = 122
          Height = 21
          DataField = 'Beeper'
          DataSource = dsForm
          TabOrder = 7
        end
        object MemoFax: TDbMemoStr
          Left = 357
          Top = 113
          Width = 122
          Height = 21
          DataField = 'Fax'
          DataSource = dsForm
          TabOrder = 8
        end
        object edtZIP: TDBEdit
          Left = 112
          Top = 110
          Width = 140
          Height = 21
          DataField = 'CEP'
          DataSource = dsForm
          TabOrder = 4
        end
        object scCountry: TDBSuperComboADO
          Left = 112
          Top = 86
          Width = 140
          Height = 21
          TabOrder = 3
          Text = 'scCountry'
          CodeLength = 5
          LookUpSource = DM.dsLookUpPais
          DropDownRows = 18
          DataField = 'IDPais'
          DataSource = dsForm
        end
        object scState: TDBSuperComboADO
          Left = 112
          Top = 63
          Width = 140
          Height = 21
          TabOrder = 2
          Text = 'scState'
          CodeLength = 5
          LookUpSource = DM.dsLookUpEstado
          DropDownRows = 18
          DataField = 'IDEstado'
          DataSource = dsForm
        end
        object edtCity: TDBEdit
          Left = 112
          Top = 38
          Width = 140
          Height = 21
          DataField = 'Cidade'
          DataSource = dsForm
          TabOrder = 1
        end
        object EditEMail: TDBEdit
          Left = 112
          Top = 135
          Width = 139
          Height = 21
          DataField = 'Email'
          DataSource = dsForm
          TabOrder = 9
        end
        object EditHomePage: TDBEdit
          Left = 112
          Top = 160
          Width = 363
          Height = 21
          DataField = 'HomePage'
          DataSource = dsForm
          TabOrder = 10
        end
        object pnlWorkHour: TPanel
          Tag = 2
          Left = 1
          Top = 258
          Width = 580
          Height = 51
          BevelOuter = bvNone
          TabOrder = 13
          Visible = False
          object Label12: TLabel
            Left = 50
            Top = 8
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = 'Hour Value :'
          end
          object Label19: TLabel
            Left = 267
            Top = 8
            Width = 86
            Height = 13
            Alignment = taRightJustify
            Caption = 'Over Hour Value :'
          end
          object Label38: TLabel
            Left = 258
            Top = 33
            Width = 95
            Height = 13
            Alignment = taRightJustify
            Caption = 'Double Hour Value :'
          end
          object Label25: TLabel
            Left = 2
            Top = 33
            Width = 107
            Height = 13
            Alignment = taRightJustify
            Caption = 'Work hour per week  :'
          end
          object DBEdit2: TDBEdit
            Left = 112
            Top = 5
            Width = 138
            Height = 21
            DataField = 'ValorHora'
            DataSource = dsForm
            TabOrder = 0
          end
          object DBEdit3: TDBEdit
            Left = 356
            Top = 5
            Width = 123
            Height = 21
            DataField = 'ValorHoraExtra'
            DataSource = dsForm
            TabOrder = 2
          end
          object DBEdit5: TDBEdit
            Left = 355
            Top = 29
            Width = 124
            Height = 21
            DataField = 'ValorHoraExtraExtra'
            DataSource = dsForm
            TabOrder = 3
          end
          object DBEdit4: TDBEdit
            Left = 112
            Top = 29
            Width = 138
            Height = 21
            DataField = 'HorasSemana'
            DataSource = dsForm
            TabOrder = 1
          end
        end
      end
      object tsPurchaseHistory: TTabSheet
        Caption = '   Purchase History  '
        ImageIndex = 1
        object pnlPurchaseHistoryFilter: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 30
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label21312312: TLabel
            Left = 134
            Top = 8
            Width = 78
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Show between :'
          end
          object Label48213: TLabel
            Left = 314
            Top = 8
            Width = 10
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'to'
          end
          object btPHGo: TSpeedButton
            Left = 425
            Top = 4
            Width = 56
            Height = 21
            Anchors = [akTop, akRight]
            Caption = '&GO'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              0400000000000001000000000000000000001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333FFFFF3333333333000003333333333F777773FF333333008877700
              33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
              703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
              77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
              07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
              780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
              8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
              3333333773FFFF77333333333000003333333333377777333333}
            Layout = blGlyphRight
            NumGlyphs = 2
            OnClick = btPHGoClick
          end
          object dtPHIni: TDateBox
            Left = 216
            Top = 5
            Width = 88
            Height = 21
            TabOrder = 0
          end
          object dtPHFim: TDateBox
            Left = 330
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 1
          end
        end
        object dxDBGridPH: TdxDBGrid
          Left = 0
          Top = 30
          Width = 483
          Height = 279
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'IDPurchase'
          ShowSummaryFooter = True
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          TabOrder = 1
          ArrowsColor = clNavy
          DataSource = dsPurchaseHistory
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
          object dxDBGridPHModel: TdxDBGridMaskColumn
            Width = 109
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Model'
          end
          object dxDBGridPHMovDate: TdxDBGridDateColumn
            Width = 94
            BandIndex = 0
            RowIndex = 0
            FieldName = 'MovDate'
          end
          object dxDBGridPHQty: TdxDBGridMaskColumn
            Width = 30
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Qty'
          end
          object dxDBGridPHCostPrice: TdxDBGridMaskColumn
            Width = 57
            BandIndex = 0
            RowIndex = 0
            FieldName = 'CostPrice'
          end
          object dxDBGridPHFreight: TdxDBGridMaskColumn
            Width = 57
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Freight'
          end
          object dxDBGridPHOtherCost: TdxDBGridMaskColumn
            Width = 70
            BandIndex = 0
            RowIndex = 0
            FieldName = 'OtherCost'
          end
          object dxDBGridPHTotal: TdxDBGridMaskColumn
            Width = 63
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Total'
            SummaryFooterType = cstSum
            SummaryFooterField = 'Total'
            SummaryFooterFormat = '#,##0.00'
          end
        end
      end
      object tsGroupHistory: TTabSheet
        Caption = '  Group History  '
        ImageIndex = 2
        object grdGroupHistory: TdxDBGrid
          Left = 0
          Top = 30
          Width = 483
          Height = 281
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'IDTouristGroup'
          ShowSummaryFooter = True
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          BandFont.Charset = ANSI_CHARSET
          BandFont.Color = clWindowText
          BandFont.Height = -11
          BandFont.Name = 'Tahoma'
          BandFont.Style = []
          DataSource = dsGroupHistory
          Filter.Criteria = {00000000}
          HeaderFont.Charset = ANSI_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HideFocusRect = True
          LookAndFeel = lfFlat
          OptionsDB = [edgoCanNavigation, edgoLoadAllRecords, edgoUseBookmarks, edgoUseLocate]
          OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoHideFocusRect, edgoRowSelect, edgoUseBitmap]
          PreviewFont.Charset = DEFAULT_CHARSET
          PreviewFont.Color = clNavy
          PreviewFont.Height = -11
          PreviewFont.Name = 'Tahoma'
          PreviewFont.Style = []
          ShowGrid = False
          object grdGroupHistoryEnterDate: TdxDBGridDateColumn
            Width = 58
            BandIndex = 0
            RowIndex = 0
            FieldName = 'EnterDate'
          end
          object grdGroupHistoryGuide: TdxDBGridMaskColumn
            Caption = 'Agent'
            Width = 113
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Guide'
          end
          object grdGroupHistoryAgency: TdxDBGridMaskColumn
            Width = 85
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Agency'
          end
          object grdGroupHistoryNumTourist: TdxDBGridMaskColumn
            Width = 73
            BandIndex = 0
            RowIndex = 0
            FieldName = 'NumTourist'
          end
          object grdGroupHistoryQTYInvoice: TdxDBGridMaskColumn
            Width = 76
            BandIndex = 0
            RowIndex = 0
            FieldName = 'QTYInvoice'
          end
          object grdGroupHistoryTotalInvoice: TdxDBGridMaskColumn
            Width = 75
            BandIndex = 0
            RowIndex = 0
            FieldName = 'TotalInvoice'
          end
          object grdGroupHistoryIDTouristGroup: TdxDBGridMaskColumn
            Visible = False
            Width = 170
            BandIndex = 0
            RowIndex = 0
            FieldName = 'IDTouristGroup'
          end
        end
        object pnlInvoiceHsitoryFilter: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 30
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label26: TLabel
            Left = 92
            Top = 8
            Width = 114
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Show invoice between :'
          end
          object Label28: TLabel
            Left = 307
            Top = 8
            Width = 18
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'and'
          end
          object btGHGo: TSpeedButton
            Left = 427
            Top = 4
            Width = 56
            Height = 21
            Anchors = [akTop, akRight]
            Caption = '&GO'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              0400000000000001000000000000000000001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333FFFFF3333333333000003333333333F777773FF333333008877700
              33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
              703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
              77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
              07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
              780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
              8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
              3333333773FFFF77333333333000003333333333377777333333}
            Layout = blGlyphRight
            NumGlyphs = 2
            OnClick = btGHGoClick
          end
          object dtGHFim: TDateBox
            Left = 329
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 0
          end
          object dtGHIni: TDateBox
            Left = 210
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 1
          end
        end
      end
      object tsAccounting: TTabSheet
        Caption = '  Accounting  '
        Font.Charset = ANSI_CHARSET
        Font.Color = clMenuText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 3
        ParentFont = False
        object grdObjeto: TdxDBGrid
          Left = 0
          Top = 30
          Width = 481
          Height = 226
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'IDLancamento'
          ShowSummaryFooter = True
          SummaryGroups = <>
          SummarySeparator = ', '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          BandFont.Charset = ANSI_CHARSET
          BandFont.Color = clWindowText
          BandFont.Height = -11
          BandFont.Name = 'Tahoma'
          BandFont.Style = []
          DataSource = dsAccount
          Filter.Criteria = {00000000}
          HeaderFont.Charset = ANSI_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HideFocusRect = True
          LookAndFeel = lfFlat
          OptionsDB = [edgoCanNavigation, edgoLoadAllRecords, edgoUseBookmarks, edgoUseLocate]
          OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoHideFocusRect, edgoRowSelect, edgoUseBitmap]
          PreviewFieldName = 'Historico'
          PreviewFont.Charset = DEFAULT_CHARSET
          PreviewFont.Color = clNavy
          PreviewFont.Height = -11
          PreviewFont.Name = 'Tahoma'
          PreviewFont.Style = []
          ShowGrid = False
          Anchors = [akLeft, akTop, akRight]
          object grdObjetoLancamentoTipo: TdxDBGridMaskColumn
            Caption = 'Lanc. Type'
            Width = 121
            BandIndex = 0
            RowIndex = 0
            FieldName = 'LancamentoTipo'
          end
          object grdObjetoNumDocumento: TdxDBGridMaskColumn
            Caption = 'Document #'
            Width = 81
            BandIndex = 0
            RowIndex = 0
            FieldName = 'NumDocumento'
          end
          object grdObjetoDataVencimento: TdxDBGridDateColumn
            Caption = 'DueDate'
            Width = 81
            BandIndex = 0
            RowIndex = 0
            FieldName = 'DataVencimento'
          end
          object grdObjetoDataInicioQuitacao: TdxDBGridDateColumn
            Visible = False
            Width = 352
            BandIndex = 0
            RowIndex = 0
            FieldName = 'DataInicioQuitacao'
          end
          object grdObjetoValorNominal: TdxDBGridMaskColumn
            Caption = 'Amount'
            Width = 96
            BandIndex = 0
            RowIndex = 0
            FieldName = 'ValorNominal'
            SummaryFooterType = cstSum
            SummaryFooterField = 'ValorNominal'
            SummaryFooterFormat = '#,##0.00'
          end
          object grdObjetoTotalQuitado: TdxDBGridMaskColumn
            Caption = 'Paid'
            Width = 99
            BandIndex = 0
            RowIndex = 0
            FieldName = 'TotalQuitado'
            SummaryFooterType = cstSum
            SummaryFooterField = 'TotalQuitado'
            SummaryFooterFormat = '#,##0.00'
          end
        end
        object pnlAccountingFilter: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 30
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label29: TLabel
            Left = 83
            Top = 8
            Width = 124
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Show accounts between :'
          end
          object Label30: TLabel
            Left = 307
            Top = 8
            Width = 18
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'and'
          end
          object btAGo: TSpeedButton
            Left = 426
            Top = 4
            Width = 56
            Height = 21
            Anchors = [akTop, akRight]
            Caption = '&GO'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              0400000000000001000000000000000000001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333FFFFF3333333333000003333333333F777773FF333333008877700
              33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
              703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
              77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
              07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
              780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
              8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
              3333333773FFFF77333333333000003333333333377777333333}
            Layout = blGlyphRight
            NumGlyphs = 2
            OnClick = btAGoClick
          end
          object dtAIni: TDateBox
            Left = 211
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 0
          end
          object dtAFim: TDateBox
            Left = 330
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 1
          end
        end
        object Panel9: TPanel
          Left = 215
          Top = 259
          Width = 211
          Height = 46
          Anchors = [akLeft, akBottom]
          BevelOuter = bvNone
          Color = 15197951
          TabOrder = 2
          object sdfsdfsdafasdfasd: TLabel
            Left = 67
            Top = 15
            Width = 45
            Height = 13
            Alignment = taRightJustify
            Caption = 'Payable :'
          end
          object wedwerwer: TLabel
            Left = 21
            Top = 0
            Width = 91
            Height = 13
            Alignment = taRightJustify
            Caption = 'Payable Past Due :'
          end
          object dfsdfsdafsda: TLabel
            Left = 58
            Top = 30
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'Total Paid :'
          end
          object lblPagarVencido: TLabel
            Left = 115
            Top = 0
            Width = 91
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblPagarAVencer: TLabel
            Left = 115
            Top = 15
            Width = 91
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTotalPago: TLabel
            Left = 115
            Top = 30
            Width = 91
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel10: TPanel
          Left = 0
          Top = 259
          Width = 211
          Height = 46
          Anchors = [akLeft, akBottom]
          BevelOuter = bvNone
          Color = 16773350
          TabOrder = 3
          object werwqerwqerwq: TLabel
            Left = 4
            Top = 0
            Width = 108
            Height = 13
            Alignment = taRightJustify
            Caption = 'Receivable Past Due  :'
          end
          object weqrqwerwqerwe: TLabel
            Left = 53
            Top = 15
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = 'Receivable :'
          end
          object sdfsadtvertvhjdytnuytr: TLabel
            Left = 34
            Top = 30
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'Total Received :'
          end
          object lblReceberVencido: TLabel
            Left = 115
            Top = 0
            Width = 91
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblReceberAVencer: TLabel
            Left = 115
            Top = 15
            Width = 91
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTotalRecebido: TLabel
            Left = 115
            Top = 30
            Width = 91
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object tsInvoiceHistory: TTabSheet
        Caption = '  Invoices  '
        ImageIndex = 4
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 30
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 86
            Top = 8
            Width = 121
            Height = 13
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = 'Show Invoices between :'
          end
          object Label13: TLabel
            Left = 307
            Top = 8
            Width = 18
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'and'
          end
          object btIHGo: TSpeedButton
            Left = 427
            Top = 4
            Width = 56
            Height = 21
            Anchors = [akTop, akRight]
            Caption = '&GO'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              0400000000000001000000000000000000001000000010000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333FFFFF3333333333000003333333333F777773FF333333008877700
              33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
              703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
              77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
              07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
              780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
              8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
              3333333773FFFF77333333333000003333333333377777333333}
            Layout = blGlyphRight
            NumGlyphs = 2
            OnClick = btIHGoClick
          end
          object dtiHIni: TDateBox
            Left = 210
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 0
          end
          object dtIHFim: TDateBox
            Left = 329
            Top = 4
            Width = 88
            Height = 21
            TabOrder = 1
          end
        end
        object dxDBGrid1: TdxDBGrid
          Left = 0
          Top = 30
          Width = 483
          Height = 281
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'IDInvoice'
          ShowSummaryFooter = True
          SummaryGroups = <>
          SummarySeparator = ', '
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          BandFont.Charset = ANSI_CHARSET
          BandFont.Color = clWindowText
          BandFont.Height = -11
          BandFont.Name = 'Tahoma'
          BandFont.Style = []
          DataSource = dsInvoiceHistory
          Filter.Criteria = {00000000}
          HeaderFont.Charset = ANSI_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HideFocusRect = True
          LookAndFeel = lfFlat
          OptionsDB = [edgoCanNavigation, edgoLoadAllRecords, edgoUseBookmarks, edgoUseLocate]
          OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoHideFocusRect, edgoPreview, edgoRowSelect, edgoUseBitmap]
          PreviewFieldName = 'Historico'
          PreviewFont.Charset = DEFAULT_CHARSET
          PreviewFont.Color = clNavy
          PreviewFont.Height = -11
          PreviewFont.Name = 'Tahoma'
          PreviewFont.Style = []
          ShowGrid = False
          object grdObjetoHold: TdxDBGridMaskColumn
            Caption = 'Hold #'
            Width = 73
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Hold'
          end
          object grdObjetoIDInvoice: TdxDBGridMaskColumn
            Caption = 'Invoice #'
            Width = 73
            BandIndex = 0
            RowIndex = 0
            FieldName = 'IDInvoice'
          end
          object grdObjetoInvoiceDate: TdxDBGridDateColumn
            Caption = 'Invoice Date'
            Width = 129
            BandIndex = 0
            RowIndex = 0
            FieldName = 'InvoiceDate'
          end
          object grdObjetoStore: TdxDBGridMaskColumn
            Width = 213
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Store'
          end
          object grdObjetoValue: TdxDBGridMaskColumn
            Width = 82
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Value'
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = '  Info  '
        ImageIndex = 5
        object Label27: TLabel
          Left = 42
          Top = 58
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'On store :'
        end
        object Label41: TLabel
          Left = 28
          Top = 32
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Included by :'
        end
        object scStore: TDBSuperComboADO
          Tag = 1
          Left = 95
          Top = 55
          Width = 156
          Height = 21
          TabStop = False
          TabOrder = 0
          Text = 'scStore'
          CodeLength = 5
          LookUpSource = DM.dsLookUpStore
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          DataField = 'IDStore'
          DataSource = dsForm
        end
        object scUser: TDBSuperComboADO
          Tag = 3
          Left = 95
          Top = 30
          Width = 156
          Height = 21
          Enabled = False
          ParentColor = True
          ReadOnly = True
          TabOrder = 1
          Text = 'scUser'
          LookUpSource = DM.dsLookUpUser
          DropDownRows = 18
          DataField = 'IDUser'
          DataSource = dsForm
        end
      end
      object tsTerm: TTabSheet
        Caption = '  Terms  '
        ImageIndex = 6
        object Label14: TLabel
          Left = 5
          Top = 30
          Width = 70
          Height = 13
          Caption = 'Vendor Terms.'
        end
        object btNew: TSpeedButton
          Left = 294
          Top = 55
          Width = 70
          Height = 25
          Caption = 'New'
          Enabled = False
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888888888888888888888800000000000888880FFFFFFFFF0888880FFFFFFFFF
            0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF
            0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F0
            8888880FFFFFF008888888000000008888888888888888888888}
          Margin = 3
          OnClick = btNewClick
        end
        object btDelete: TSpeedButton
          Tag = 2
          Left = 294
          Top = 80
          Width = 70
          Height = 25
          Caption = 'Remove'
          Enabled = False
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888888808888888888088800088888888888880000888888
            8088888000888888088888880008888008888888800088008888888888000008
            8888888888800088888888888800000888888888800088008888888000088880
            0888880000888888008888000888888888088888888888888888}
          Margin = 3
          OnClick = btDeleteClick
        end
        object btCancelPost: TSpeedButton
          Tag = 2
          Left = 294
          Top = 135
          Width = 70
          Height = 25
          Caption = 'Cancel'
          Flat = True
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333333333000033338833333333333333333F333333333333
            0000333911833333983333333388F333333F3333000033391118333911833333
            38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
            911118111118333338F3338F833338F3000033333911111111833333338F3338
            3333F8330000333333911111183333333338F333333F83330000333333311111
            8333333333338F3333383333000033333339111183333333333338F333833333
            00003333339111118333333333333833338F3333000033333911181118333333
            33338333338F333300003333911183911183333333383338F338F33300003333
            9118333911183333338F33838F338F33000033333913333391113333338FF833
            38F338F300003333333333333919333333388333338FFF830000333333333333
            3333333333333333333888330000333333333333333333333333333333333333
            0000}
          Margin = 3
          NumGlyphs = 2
          OnClick = btCancelPostClick
        end
        object btPost: TSpeedButton
          Left = 294
          Top = 110
          Width = 70
          Height = 25
          Caption = 'Ok'
          Flat = True
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333F33333333333
            00003333344333333333333333388F3333333333000033334224333333333333
            338338F3333333330000333422224333333333333833338F3333333300003342
            222224333333333383333338F3333333000034222A22224333333338F338F333
            8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
            33333338F83338F338F33333000033A33333A222433333338333338F338F3333
            0000333333333A222433333333333338F338F33300003333333333A222433333
            333333338F338F33000033333333333A222433333333333338F338F300003333
            33333333A222433333333333338F338F00003333333333333A22433333333333
            3338F38F000033333333333333A223333333333333338F830000333333333333
            333A333333333333333338330000333333333333333333333333333333333333
            0000}
          Margin = 3
          NumGlyphs = 2
          OnClick = btPostClick
        end
        object Panel8: TPanel
          Left = 0
          Top = 0
          Width = 483
          Height = 18
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = '  Default Terms for this vendor'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object grdTerm: TdxDBGrid
          Left = 5
          Top = 55
          Width = 286
          Height = 246
          Bands = <
            item
            end>
          DefaultLayout = True
          HeaderPanelRowCount = 1
          KeyField = 'DueDateShift'
          SummaryGroups = <>
          SummarySeparator = ', '
          TabOrder = 1
          OnKeyDown = grdTermKeyDown
          DataSource = dsTerm
          Filter.Criteria = {00000000}
          LookAndFeel = lfFlat
          OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoEnterThrough, edgoImmediateEditor, edgoTabs, edgoTabThrough, edgoVertThrough]
          OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
          OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoUseBitmap]
          object grdTermDueDateShift: TdxDBGridMaskColumn
            Caption = 'Days'
            Sorted = csUp
            BandIndex = 0
            RowIndex = 0
            FieldName = 'DueDateShift'
          end
          object grdTermDiscount: TdxDBGridMaskColumn
            Caption = 'Discount % '
            BandIndex = 0
            RowIndex = 0
            FieldName = 'Discount'
          end
        end
      end
    end
  end
  object DBEdit20: TDBEdit [13]
    Tag = 2
    Left = 110
    Top = 61
    Width = 101
    Height = 21
    TabStop = False
    DataField = 'Code'
    DataSource = dsForm
    ParentColor = True
    ReadOnly = True
    TabOrder = 6
  end
  object scPessoaTipo: TDBSuperComboADO [14]
    Left = 110
    Top = 35
    Width = 316
    Height = 21
    TabStop = False
    AutoSize = False
    TabOrder = 5
    Text = 'scPessoaTipo'
    CodeLength = 96
    LookUpSource = DM.dsLookUpTipoPessoa
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    OnSelectItem = scPessoaTipoSelectItem
    DataField = 'IDTipoPessoa'
    DataSource = dsForm
  end
  object TipoCli: TDBRadioGroup [15]
    Left = 256
    Top = 56
    Width = 170
    Height = 30
    Columns = 2
    DataField = 'Juridico'
    DataSource = dsForm
    Items.Strings = (
      'Personal'
      'Business')
    TabOrder = 7
    Values.Strings = (
      'False'
      'True')
    OnChange = TipoCliChange
  end
  object cbDescontaCordenacao: TDBCheckBox [16]
    Left = 272
    Top = 122
    Width = 212
    Height = 13
    Caption = 'Discount Agency commission from Agent'
    DataField = 'DescontaCoordenacao'
    DataSource = dsForm
    TabOrder = 3
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object edComissaoSobreGuia: TDBEdit [17]
    Left = 110
    Top = 118
    Width = 156
    Height = 21
    DataField = 'ComissaoSobreGuia'
    DataSource = dsForm
    TabOrder = 2
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_SisPessoaFch.sil'
  end
  inherited dsForm: TDataSource
    Left = 16
    Top = 316
  end
  inherited quForm: TPowerADOQuery
    AfterOpen = quFormAfterOpen
    BeforeClose = quFormBeforeClose
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT '#13#10#9'P.IDPessoa, '#13#10#9'P.Pessoa, '#13#10#9'P.IDTipoPessoa, '#13#10#9'P.IDSto' +
      're, '#13#10#9'P.NomeJuridico, '#13#10#9'P.Endereco,'#13#10#9'P.Cidade, '#13#10#9'P.CEP, '#13#10#9'P' +
      '.Pais, '#13#10#9'P.Telefone, '#13#10#9'P.Cellular, '#13#10#9'P.Fax, '#13#10#9'P.Beeper, '#13#10#9'P' +
      '.Contato, '#13#10#9'P.Email, '#13#10#9'P.OBS, '#13#10#9'P.Juridico, '#13#10#9'P.TotalMovimen' +
      'tado, '#13#10#9'P.Limite, '#13#10#9'P.Nascimento, '#13#10#9'P.IDEstado, '#13#10#9'P.DiaQuita' +
      'cao, '#13#10#9'P.IDPessoaBoss, '#13#10#9'P.IDTipoPessoaFilho, '#13#10#9'P.IDRamoAtivi' +
      'dade, '#13#10#9'P.CPF,'#13#10#9'P.CGC, '#13#10#9'P.Identidade, '#13#10#9'P.CartTrabalho, '#13#10#9 +
      'P.InscEstadual, '#13#10#9'P.InscMunicipal, '#13#10#9'P.Contatos, '#13#10#9'P.NumAtras' +
      'os, '#13#10#9'P.DiasAtraso,'#13#10#9'P.NumTransacoes, '#13#10#9'P.HomePage, '#13#10#9'P.Orga' +
      'oEmissor, '#13#10#9'P.Bairro, '#13#10#9'P.NumMovimentacoes, '#13#10#9'P.System, '#13#10#9'P.' +
      'Desativado, '#13#10#9'P.Hidden, '#13#10#9'P.ComissaoSobreGuia, '#13#10#9'P.DescontaCo' +
      'ordenacao, '#13#10#9'P.AjusteComiss, '#13#10#9'P.IDUser, '#13#10#9'P.ShortName, '#13#10#9'P.' +
      'Short_Name, '#13#10#9'P.Code, '#13#10#9'P.IDTipoPessoaRoot, '#13#10#9'P.IDPais, '#13#10#9'P.' +
      'PessoaLastName, '#13#10#9'P.CustomerCard, '#13#10#9'P.PessoaFirstName,'#13#10#9'P.Hor' +
      'asSemana, '#13#10#9'P.ValorHora,'#13#10#9'P.ValorHoraExtra,'#13#10#9'P.ValorHoraExtra' +
      'Extra,'#13#10#9'P.CreationDate'#13#10'FROM '#13#10#9'Pessoa P'#13#10#13#10'Where IDPessoa = :I' +
      'DPessoa'
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 36
    Top = 337
    object quFormIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Origin = 'RETAILDB.Pessoa.IDPessoa'
    end
    object quFormIDTipoPessoa: TIntegerField
      DisplayLabel = 'Entity Type'
      FieldName = 'IDTipoPessoa'
      Origin = 'RETAILDB.Pessoa.IDTipoPessoa'
      Required = True
    end
    object quFormIDStore: TIntegerField
      DisplayLabel = 'Store'
      FieldName = 'IDStore'
      Origin = 'RETAILDB.Pessoa.IDStore'
    end
    object quFormPessoa: TStringField
      DisplayLabel = 'Company'
      FieldName = 'Pessoa'
      Origin = 'RETAILDB.Pessoa.Pessoa'
      Size = 50
    end
    object quFormPessoaFirstName: TStringField
      DisplayLabel = 'First Name'
      FieldName = 'PessoaFirstName'
      Origin = 'RETAILDB.Pessoa.PessoaFirstName'
      Size = 30
    end
    object quFormPessoaLastName: TStringField
      DisplayLabel = 'Last Name'
      FieldName = 'PessoaLastName'
      Origin = 'RETAILDB.Pessoa.PessoaLastName'
      Size = 30
    end
    object quFormEndereco: TStringField
      DisplayLabel = 'Address'
      FieldName = 'Endereco'
      Origin = 'RETAILDB.Pessoa.Endereco'
      Size = 80
    end
    object quFormCidade: TStringField
      DisplayLabel = 'City'
      FieldName = 'Cidade'
      Origin = 'RETAILDB.Pessoa.Cidade'
      Size = 40
    end
    object quFormIDEstado: TStringField
      DisplayLabel = 'State'
      FieldName = 'IDEstado'
      Origin = 'RETAILDB.Pessoa.IDEstado'
      FixedChar = True
      Size = 3
    end
    object quFormIDPais: TIntegerField
      DisplayLabel = 'Contry'
      FieldName = 'IDPais'
      Origin = 'RETAILDB.Pessoa.IDPais'
    end
    object quFormPais: TStringField
      DisplayLabel = 'Contry'
      FieldName = 'Pais'
      Origin = 'RETAILDB.Pessoa.Pais'
      Size = 21
    end
    object quFormCEP: TStringField
      DisplayLabel = 'ZIP'
      FieldName = 'CEP'
      Origin = 'RETAILDB.Pessoa.CEP'
      FixedChar = True
      Size = 12
    end
    object quFormTelefone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'Telefone'
      Origin = 'RETAILDB.Pessoa.Telefone'
      Size = 40
    end
    object quFormCellular: TStringField
      FieldName = 'Cellular'
      Origin = 'RETAILDB.Pessoa.Cellular'
      FixedChar = True
      Size = 18
    end
    object quFormNomeJuridico: TStringField
      DisplayLabel = 'DBA'
      FieldName = 'NomeJuridico'
      Origin = 'RETAILDB.Pessoa.NomeJuridico'
      Size = 50
    end
    object quFormFax: TStringField
      FieldName = 'Fax'
      Origin = 'RETAILDB.Pessoa.Fax'
      Size = 40
    end
    object quFormBeeper: TStringField
      FieldName = 'Beeper'
      Origin = 'RETAILDB.Pessoa.Beeper'
      FixedChar = True
      Size = 25
    end
    object quFormContato: TStringField
      DisplayLabel = 'Contact'
      FieldName = 'Contato'
      Origin = 'RETAILDB.Pessoa.Contato'
      Size = 50
    end
    object quFormEmail: TStringField
      FieldName = 'Email'
      Origin = 'RETAILDB.Pessoa.Email'
      Size = 50
    end
    object quFormOBS: TStringField
      FieldName = 'OBS'
      Origin = 'RETAILDB.Pessoa.OBS'
      Size = 100
    end
    object quFormJuridico: TBooleanField
      DisplayLabel = 'Entity caracter'
      FieldName = 'Juridico'
      Origin = 'RETAILDB.Pessoa.Juridico'
    end
    object quFormNascimento: TDateTimeField
      FieldName = 'Nascimento'
      Origin = 'RETAILDB.Pessoa.Nascimento'
    end
    object quFormIDPessoaBoss: TIntegerField
      FieldName = 'IDPessoaBoss'
      Origin = 'RETAILDB.Pessoa.IDPessoaBoss'
    end
    object quFormIDTipoPessoaFilho: TIntegerField
      FieldName = 'IDTipoPessoaFilho'
      Origin = 'RETAILDB.Pessoa.IDTipoPessoaFilho'
    end
    object quFormCPF: TStringField
      FieldName = 'CPF'
      Origin = 'RETAILDB.Pessoa.CPF'
      Size = 30
    end
    object quFormCGC: TStringField
      FieldName = 'CGC'
      Origin = 'RETAILDB.Pessoa.CGC'
      Size = 30
    end
    object quFormIdentidade: TStringField
      FieldName = 'Identidade'
      Origin = 'RETAILDB.Pessoa.Identidade'
      Size = 30
    end
    object quFormCartTrabalho: TStringField
      FieldName = 'CartTrabalho'
      Origin = 'RETAILDB.Pessoa.CartTrabalho'
      Size = 30
    end
    object quFormInscEstadual: TStringField
      DisplayLabel = 'Federal ID'
      FieldName = 'InscEstadual'
      Origin = 'RETAILDB.Pessoa.InscEstadual'
      Size = 30
    end
    object quFormInscMunicipal: TStringField
      FieldName = 'InscMunicipal'
      Origin = 'RETAILDB.Pessoa.InscMunicipal'
      Size = 30
    end
    object quFormContatos: TStringField
      DisplayLabel = 'Sales Tax #'
      FieldName = 'Contatos'
      Origin = 'RETAILDB.Pessoa.Contatos'
      Size = 255
    end
    object quFormNumAtrasos: TIntegerField
      FieldName = 'NumAtrasos'
      Origin = 'RETAILDB.Pessoa.NumAtrasos'
    end
    object quFormDiasAtraso: TIntegerField
      FieldName = 'DiasAtraso'
      Origin = 'RETAILDB.Pessoa.DiasAtraso'
    end
    object quFormNumTransacoes: TIntegerField
      FieldName = 'NumTransacoes'
      Origin = 'RETAILDB.Pessoa.NumTransacoes'
    end
    object quFormHomePage: TStringField
      FieldName = 'HomePage'
      Origin = 'RETAILDB.Pessoa.HomePage'
      Size = 200
    end
    object quFormOrgaoEmissor: TStringField
      FieldName = 'OrgaoEmissor'
      Origin = 'RETAILDB.Pessoa.OrgaoEmissor'
      Size = 50
    end
    object quFormBairro: TStringField
      FieldName = 'Bairro'
      Origin = 'RETAILDB.Pessoa.Bairro'
      Size = 50
    end
    object quFormNumMovimentacoes: TIntegerField
      FieldName = 'NumMovimentacoes'
      Origin = 'RETAILDB.Pessoa.NumMovimentacoes'
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
      Origin = 'RETAILDB.Pessoa.System'
    end
    object quFormDesativado: TIntegerField
      FieldName = 'Desativado'
      Origin = 'RETAILDB.Pessoa.Desativado'
    end
    object quFormHidden: TIntegerField
      FieldName = 'Hidden'
      Origin = 'RETAILDB.Pessoa.Hidden'
    end
    object quFormComissaoSobreGuia: TFloatField
      FieldName = 'ComissaoSobreGuia'
      Origin = 'RETAILDB.Pessoa.ComissaoSobreGuia'
    end
    object quFormDescontaCoordenacao: TBooleanField
      FieldName = 'DescontaCoordenacao'
      Origin = 'RETAILDB.Pessoa.DescontaCoordenacao'
    end
    object quFormAjusteComiss: TFloatField
      FieldName = 'AjusteComiss'
      Origin = 'RETAILDB.Pessoa.AjusteComiss'
    end
    object quFormIDUser: TIntegerField
      FieldName = 'IDUser'
      Origin = 'RETAILDB.Pessoa.IDUser'
    end
    object quFormShortName: TStringField
      FieldName = 'ShortName'
      Origin = 'RETAILDB.Pessoa.ShortName'
      Size = 15
    end
    object quFormShort_Name: TStringField
      FieldName = 'Short_Name'
      Origin = 'RETAILDB.Pessoa.Short_Name'
      Size = 30
    end
    object quFormCode: TIntegerField
      FieldName = 'Code'
      Origin = 'RETAILDB.Pessoa.Code'
    end
    object quFormIDTipoPessoaRoot: TIntegerField
      FieldName = 'IDTipoPessoaRoot'
    end
    object quFormCustomerCard: TStringField
      FieldName = 'CustomerCard'
      Origin = 'RETAILDB.Pessoa.CustomerCard'
    end
    object quFormHorasSemana: TIntegerField
      FieldName = 'HorasSemana'
    end
    object quFormValorHora: TBCDField
      FieldName = 'ValorHora'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormValorHoraExtra: TBCDField
      FieldName = 'ValorHoraExtra'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormValorHoraExtraExtra: TBCDField
      FieldName = 'ValorHoraExtraExtra'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormCreationDate: TDateTimeField
      FieldName = 'CreationDate'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    PostOnInsert = True
    AutoIncField = 'IDPessoa'
    RequiredFields.Strings = (
      'IDTipoPessoa'
      'Juridico')
    UniqueFields.Strings = (
      '')
    DependentTables.Strings = (
      'PessoaTerm')
    DependentTableKeys.Strings = (
      'IDPessoa')
    Left = 31
    Top = 210
  end
  inherited bmMDI: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    Left = 465
    Top = 300
    DockControlHeights = (
      0
      0
      0
      0)
  end
  inherited ilSmallButtons: TImageList
    Left = 432
    Top = 250
  end
  inherited PrintFch: TPrintDialog
    Left = 470
    Top = 275
  end
  object quInvoiceHistory: TADOQuery
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'DataIni'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '    I.IDPreSale as Hold,'
      '    I.IDInvoice,'
      '    I.InvoiceDate,'
      '    S.Name as Store,'
      '    (I.SubTotal - I.ItemDiscount + I.Tax) as Value'
      ''
      'FROM'
      '    Invoice I'
      '    JOIN Store S ON (I.IDStore = S.IDStore)'
      ''
      'WHERE'
      #9' I.InvoiceDate >= :DataIni'
      #9' AND'
      #9' I.InvoiceDate < :DataFim'
      '   AND'
      #9' I.IDCustomer = :IDPessoa'
      '   AND'
      '   I.IDInvoice IS NOT NULL'
      '   '
      'ORDER BY'
      '   I.InvoiceDate DESC'
      ''
      ' ')
    Left = 357
    Top = 358
    object quInvoiceHistoryHold: TIntegerField
      FieldName = 'Hold'
    end
    object quInvoiceHistoryIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
    end
    object quInvoiceHistoryInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object quInvoiceHistoryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quInvoiceHistoryValue: TFloatField
      FieldName = 'Value'
      DisplayFormat = '#,##0.00'
    end
  end
  object dsInvoiceHistory: TDataSource
    DataSet = quInvoiceHistory
    Left = 357
    Top = 298
  end
  object dsAccount: TDataSource
    DataSet = quAccount
    Left = 285
    Top = 295
  end
  object quAccount: TRCADOQuery
    Connection = DM.DBADOConnection
    AfterOpen = quAccountAfterOpen
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Inicio'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Fim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      L.IDLancamento ,'
      '      L.IDPessoa ,'
      '      L.DataVencimento ,'
      '      LT.LancamentoTipo ,'
      '      L.DataFimQuitacao ,'
      '      L.ValorNominal ,'
      '      L.TotalQuitado ,'
      '      L.Pagando,'
      '      L.NumDocumento,'
      '      L.Historico'
      'FROM  dbo.Fin_LancamentoTipo LT JOIN'
      
        '      dbo.Fin_Lancamento L ON ( L.IDLancamentoTipo = LT.IDLancam' +
        'entoTipo )'
      'WHERE'
      '     ( L.IDPessoa = :IDPessoa )'
      '     AND'
      '     ( L.DataVencimento >= :Inicio )'
      '     AND'
      '     ( L.DataVencimento < :Fim )'
      '     AND'
      '     ( L.Desativado = 0 )'
      ''
      '')
    KeyFields = 'IDPessoaContato'
    Left = 285
    Top = 350
    object quAccountIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
      Origin = 'Fin_Lancamento.IDLancamento'
    end
    object quAccountDataVencimento: TDateTimeField
      DisplayLabel = 'Vencimento'
      FieldName = 'DataVencimento'
      Origin = 'Fin_Lancamento.DataVencimento'
      DisplayFormat = 'ddddd'
    end
    object quAccountLancamentoTipo: TStringField
      DisplayLabel = 'Lanc. Tipo'
      FieldName = 'LancamentoTipo'
      Origin = 'Fin_LancamentoTipo.LancamentoTipo'
      Size = 65
    end
    object quAccountDataFimQuitacao: TDateTimeField
      DisplayLabel = 'Quitação'
      FieldName = 'DataFimQuitacao'
      Origin = 'Fin_Lancamento.DataFimQuitacao'
      DisplayFormat = 'ddddd'
    end
    object quAccountValorNominal: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValorNominal'
      Origin = 'Fin_Lancamento.ValorNominal'
      DisplayFormat = '#,##0.00'
    end
    object quAccountTotalQuitado: TFloatField
      DisplayLabel = 'Quitado'
      FieldName = 'TotalQuitado'
      Origin = 'Fin_Lancamento.TotalQuitado'
      DisplayFormat = '#,##0.00'
    end
    object quAccountPagando: TBooleanField
      FieldName = 'Pagando'
      Origin = 'Fin_Lancamento.Pagando'
    end
    object quAccountHistorico: TMemoField
      FieldName = 'Historico'
      Origin = 'RETAILDB.Fin_Lancamento.Historico'
      BlobType = ftMemo
    end
    object quAccountNumDocumento: TStringField
      FieldName = 'NumDocumento'
    end
  end
  object dsGroupHistory: TDataSource
    DataSet = quGroupHistory
    Left = 207
    Top = 293
  end
  object quGroupHistory: TADOQuery
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'DataIni'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDAgency'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGuide'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'TG.IDTouristGroup,'
      '                TG.EnterDate,'
      #9'TG.NumTourist,'
      #9'A.Pessoa as Agency,'
      #9'G.Pessoa as Guide,'
      #9'count(I.IDInvoice) as QTYInvoice ,'
      #9'Sum(I.SubTotal-I.ItemDiscount+I.Tax) as TotalInvoice'
      #9
      'FROM '
      '        '
      #9'TouristGroup TG '
      '        Join Pessoa A on (TG.IDAgency = A.IDPessoa) '
      '        Join Pessoa G on (TG.IDGuide = G.IDPessoa) '
      
        '        Join Invoice I on (TG.IDTouristGroup = I.IDTouristGroup)' +
        ' '
      '       '
      ''
      'WHERE '
      #9' TG.EnterDate >= :DataIni'
      #9' AND'
      #9' TG.EnterDate < :DataFim'
      '         AND'
      #9' TG.IDAgency = IsNull(:IDAgency, TG.IDAgency)'
      '         AND'
      #9' TG.IDGuide = IsNull(:IDGuide, TG.IDGuide)'
      #9' AND'
      #9' I.IDInvoice IS NOT NULL '
      ''
      'Group by '
      '                TG.IDTouristGroup,'
      #9'TG.EnterDate,'
      #9'TG.NumTourist,'
      #9'A.Pessoa,'
      #9'G.Pessoa')
    Left = 207
    Top = 348
    object quGroupHistoryEnterDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'EnterDate'
      DisplayFormat = 'ddddd'
    end
    object quGroupHistoryGuide: TStringField
      FieldName = 'Guide'
      Size = 50
    end
    object quGroupHistoryNumTourist: TIntegerField
      DisplayLabel = 'Qty Tourists'
      FieldName = 'NumTourist'
    end
    object quGroupHistoryAgency: TStringField
      FieldName = 'Agency'
      Size = 50
    end
    object quGroupHistoryQTYInvoice: TIntegerField
      DisplayLabel = 'Qty Invoices'
      FieldName = 'QTYInvoice'
      DisplayFormat = '#,##0'
    end
    object quGroupHistoryTotalInvoice: TFloatField
      DisplayLabel = 'Invoice Total'
      FieldName = 'TotalInvoice'
      DisplayFormat = '#,##0.00'
    end
    object quGroupHistoryIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
    end
  end
  object quPurchaseHistory: TADOQuery
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicio'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      PI.IDPurchase ,'
      '      M.Model ,'
      '      PI.MovDate ,'
      '      PI.Qty ,'
      '      PI.CostPrice ,'
      '      PI.Freight,'
      '      PI.OtherCost,'
      
        '      (PI.Qty * PI.CostPrice) + PI.Freight + PI.OtherCost as Tot' +
        'al'
      ''
      
        'FROM  dbo.vwPurchaseItem PI JOIN Model M ON (PI.ModelID = M.IDMo' +
        'del)'
      ''
      'WHERE PI.IDFornecedor = :IDTipoPessoa'
      'AND PI.MovDate >= :DataInicio'
      'AND PI.MovDate < :DataFim'
      ''
      'ORDER BY PI.MovDate Desc'
      ''
      ' ')
    Left = 117
    Top = 345
    object quPurchaseHistoryIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
      Origin = 'RETAIL.vwPurchaseItem.IDPurchase'
    end
    object quPurchaseHistoryModel: TStringField
      FieldName = 'Model'
      Origin = 'RETAIL.Model.Model'
      Size = 30
    end
    object quPurchaseHistoryMovDate: TDateTimeField
      FieldName = 'MovDate'
      Origin = 'RETAIL.vwPurchaseItem.MovDate'
      DisplayFormat = 'ddddd'
    end
    object quPurchaseHistoryQty: TBCDField
      FieldName = 'Qty'
      Precision = 32
    end
    object quPurchaseHistoryCostPrice: TFloatField
      FieldName = 'CostPrice'
      Origin = 'RETAIL.vwPurchaseItem.CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object quPurchaseHistoryFreight: TFloatField
      FieldName = 'Freight'
      Origin = 'RETAIL.vwPurchaseItem.Freight'
      DisplayFormat = '#,##0.00'
    end
    object quPurchaseHistoryOtherCost: TFloatField
      FieldName = 'OtherCost'
      Origin = 'RETAIL.vwPurchaseItem.OtherCost'
      DisplayFormat = '#,##0.00'
    end
    object quPurchaseHistoryTotal: TFloatField
      FieldName = 'Total'
      Origin = 'RETAIL.vwPurchaseItem.Qty'
      DisplayFormat = '#,##0.00'
    end
  end
  object dsPurchaseHistory: TDataSource
    DataSet = quPurchaseHistory
    Left = 126
    Top = 293
  end
  object quTerm: TADOQuery
    Connection = DM.DBADOConnection
    OnNewRecord = quTermNewRecord
    DataSource = dsForm
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      IDPessoa,'
      '      DueDateShift,'
      '      Discount'
      'FROM'
      '      PessoaTerm PT'
      'WHERE'
      '      PT.IDPessoa = :IDPessoa')
    Left = 427
    Top = 301
    object quTermIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Origin = 'RETAILDB.PessoaTerm.IDPessoa'
    end
    object quTermDueDateShift: TIntegerField
      FieldName = 'DueDateShift'
      Origin = 'RETAILDB.PessoaTerm.DueDateShift'
    end
    object quTermDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'RETAILDB.PessoaTerm.Discount'
      DisplayFormat = '#0.00 %'
    end
  end
  object dsTerm: TDataSource
    DataSet = quTerm
    OnStateChange = dsTermStateChange
    Left = 427
    Top = 351
  end
  object spGetPessoaRoot: TADOStoredProc
    Connection = DM.DBADOConnection
    ProcedureName = 'sp_Pessoa_GetPessoaRoot;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDTipoPessoa'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPessoa'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Code'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDTipoPessoaRoot'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 287
    Top = 240
  end
end
