inherited FrmTeleMarketing: TFrmTeleMarketing
  Left = 42
  Top = 7
  Width = 780
  Height = 666
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'FrmTeleMarketing'
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 260
    Width = 764
    Height = 1
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter2: TSplitter [1]
    Left = 0
    Top = 388
    Width = 764
    Height = 1
    Cursor = crVSplit
    Align = alTop
  end
  inherited Panel2: TPanel
    Width = 764
    inherited imgTopIni: TImage
      Height = 38
    end
    inherited Image1: TImage
      Width = 537
      Height = 38
    end
    inherited lblMenu: TLabel
      Left = 556
    end
    inherited Image3: TImage
      Height = 38
    end
    inherited EspacamentoSuperior: TPanel
      Top = 38
      Width = 764
      Height = 2
      inherited EEE: TPanel
        Width = 764
      end
    end
  end
  inherited Panel1: TPanel
    Top = 587
    Width = 764
    inherited EspacamentoInferior: TPanel
      Width = 764
      inherited Panel3: TPanel
        Width = 764
      end
    end
    inherited hhh: TPanel
      Left = 682
      inherited btClose: TButton
        Cancel = True
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 389
    Width = 0
    Height = 198
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 764
    Top = 389
    Width = 0
    Height = 198
    Visible = False
  end
  object pnlCustomer: TPanel [6]
    Left = 0
    Top = 40
    Width = 764
    Height = 220
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object pnlObs: TPanel
      Left = 552
      Top = 0
      Width = 212
      Height = 220
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 212
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnReport: TSpeedButton
          Left = 4
          Top = 1
          Width = 87
          Height = 22
          Caption = 'Print label'
          Flat = True
          Glyph.Data = {
            B6020000424DB60200000000000036000000280000000D000000100000000100
            1800000000008002000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00FF00FFA6740EC99631C99631C99631C99631C99631C99631C99631C99631
            C99631A6740EFF00FF00FF00FFC99631FFF2DBFFF1D7FFF0D3FFEECFFFEECDFF
            ECC9FFECC7FFEAC3FFE8BBC99631FF00FF00FF00FFC99631FFEECFFFEDCBFFEC
            C9FFEBC5FFEAC1FFE8BDFFE8BBFFEAC3FFEAC3C99631FF00FF00FF00FFC99631
            FFECC9FFECC7FFEAC3FFE9BFFFE8BBFFE6B7FFE5B3FFEAC3FFEAC3C99631FF00
            FF00FF00FFC99631FFEAC3FFE9BFFFE8BDFFE7B9FFE5B3FFE2ABFFDE9DFFDE9D
            FFDE9DC99631FF00FF00FF00FFC99631FFE8BDFFE7B9FFE5B3FFE2A9FFDC97FF
            D37EFFCC6AFFCC6AFFCC6AC99631FF00FF00FF00FFC99631FFE6B5FFE2ABFFDC
            97FFD37EFECB66F8C560F7C45FF7C45FF7C45FC99631FF00FF00FF00FFC99631
            FFDE9DFFD481FECB66F8C560F7C45FF7C45FF7C45FF7C45FF7C45FC99631FF00
            FF00FF00FFC99631FFCC6AF9C661F7C45FF7C45FF7C45FF7C45FF7C45FF7C45F
            F7C45FC99631FF00FF00FF00FFC7942FF4C15CF3C05BF7C45FFBC863FDCA65FF
            CC67FECB66FECB66FECB66C99631FF00FF00FF00FFBA8722E9B651F1BE59F8C5
            60FFCC6AFFD076FFD27AFFD27AFFD27AFFD27AC99631FF00FF00FF00FFCBBB9B
            895C01A5730D895C01FFD076FFD789FFDA91FFD98FFFD98FFFD98FC99631FF00
            FF00FF00FFFF00FFC6B593F9C661A5730DFFD685FFDE9DFFE2A9FFE1A7FFE1A7
            FFE1A7C99631FF00FF00FF00FFFF00FFFF00FFC0AA80895C01FFDA93FFE6B7FF
            EAC3FFE9BFFFE9BFFFE9BFC99631FF00FF00FF00FFFF00FFFF00FFFF00FFAE8D
            4FBA8722C7942FC99631C99631C99631C99631A6740EFF00FF00}
          Margin = 3
          OnClick = btnReportClick
        end
        object btnConfigureLabel: TSpeedButton
          Left = 94
          Top = 1
          Width = 99
          Height = 22
          Caption = 'Configure label'
          Flat = True
          Glyph.Data = {
            C2010000424DC20100000000000036000000280000000C0000000B0000000100
            1800000000008C010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF628D63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF7D827551554BFFFFFFFFFFFF31CDD2FFFFFFFFFFFF74946B4F5E47FF
            FFFFFFFFFFFFFFFF41C2AF4A6971575C3D599C8C3EC9FF525A46626E5661AAB6
            1EB7A0FFFFFFFFFFFF8C81943CDCF82BC9FA39BCE439CDEC3ED3FF3ABBE539C5
            ED1CD9E7FFFFFFFFFFFFFFFFFF524E3C6F737D26DAFF3FD0FF99C1D7649CB450
            CEFF28D8FF489E90534B2DFFFFFF5EB1DF31A7A1349FBB33D1FF80EFFF5BCEDC
            08837A378D9539D3FF2DD0F32DC8E43ABBCCFFFFFFFFFFFF27B4B92AD1FF84F5
            FF5CD3E914908A25686F2BD7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1BD3B133
            C5FF88ECFF5BD3E8148F8925747A2BEAFF228E88FFFFFFFFFFFFFFFFFFFFFFFF
            85CCFFFFFFFFA1D3FF50D3E4098B823C5679FFFFFF38FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFBBABFF9BFFFF58D0CB568095FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF94AED361F3ADFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF}
          Margin = 3
          OnClick = btnConfigureLabelClick
        end
        object btnSendEmail: TSpeedButton
          Left = 5
          Top = 25
          Width = 86
          Height = 22
          Caption = 'Email'
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
          OnClick = btnSendEmailClick
        end
      end
      object grdHistory: TcxGrid
        Left = 0
        Top = 48
        Width = 212
        Height = 172
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdHistoryDB: TcxGridDBTableView
          DataController.DataSource = dsCHistory
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPessoaHistory'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.Column = grdHistoryDBObs
          Preview.MaxLineCount = 10
          Preview.Visible = True
          object grdHistoryDBSystemUser: TcxGridDBColumn
            Caption = 'User'
            DataBinding.FieldName = 'SystemUser'
            Width = 59
          end
          object grdHistoryDBPessoaHistoryType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'PessoaHistoryType'
            Width = 60
          end
          object grdHistoryDBPessoaHistoryResult: TcxGridDBColumn
            Caption = 'Result'
            DataBinding.FieldName = 'PessoaHistoryResult'
            Width = 74
          end
          object grdHistoryDBMovDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'MovDate'
            Visible = False
            GroupIndex = 0
            SortOrder = soDescending
            Width = 96
          end
          object grdHistoryDBObs: TcxGridDBColumn
            DataBinding.FieldName = 'Obs'
            Width = 143
          end
        end
        object grdHistoryLevel: TcxGridLevel
          GridView = grdHistoryDB
        end
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 552
      Height = 220
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object grdCustomer: TcxGrid
        Left = 131
        Top = 48
        Width = 421
        Height = 172
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdCustomerDB: TcxGridDBTableView
          OnDblClick = grdCustomerDBDblClick
          DataController.DataSource = dsCustomer
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPessoa'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OnCustomDrawCell = grdCustomerDBCustomDrawCell
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdCustomerDBColor: TcxGridDBColumn
            Caption = ' '
            DataBinding.FieldName = 'ResultColor'
            Options.Filtering = False
            Options.Moving = False
            Width = 20
          end
          object grdCustomerDBFullName: TcxGridDBColumn
            DataBinding.FieldName = 'FullName'
            Options.Filtering = False
            Width = 78
          end
          object grdCustomerDBPhone: TcxGridDBColumn
            Caption = 'Phone'
            DataBinding.FieldName = 'APhone'
            Options.Filtering = False
            Width = 50
          end
          object grdCustomerDBCell: TcxGridDBColumn
            Caption = 'Cell'
            DataBinding.FieldName = 'ACel'
            Options.Filtering = False
            Width = 47
          end
          object grdCustomerDBEmail: TcxGridDBColumn
            DataBinding.FieldName = 'Email'
            Options.Filtering = False
            Width = 73
          end
          object grdCustomerDBPType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'PType'
            Width = 51
          end
          object grdCustomerDBPResult: TcxGridDBColumn
            Caption = 'Result'
            DataBinding.FieldName = 'PResult'
            Width = 68
          end
          object grdCustomerDBMovDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'MovDate'
            Width = 60
          end
        end
        object grdCustomerLevel: TcxGridLevel
          GridView = grdCustomerDB
        end
      end
      object pnlFilter: TPanel
        Left = 0
        Top = 48
        Width = 131
        Height = 172
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object gridFilter: TcxGrid
          Left = 0
          Top = 0
          Width = 131
          Height = 172
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object gridFilterView: TcxGridDBTableView
            OnDblClick = btnExecuteClick
            DataController.DataSource = dsFilter
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDTelemarketingFilter'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            Filtering.MaxDropDownCount = 50
            Filtering.Visible = fvNever
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLines = glHorizontal
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            OptionsView.HeaderEndEllipsis = True
            Preview.MaxLineCount = 10
            Preview.Visible = True
            object gridFilterViewFilterName: TcxGridDBColumn
              DataBinding.FieldName = 'FilterName'
              Width = 127
            end
          end
          object gridFilterLevel: TcxGridLevel
            GridView = gridFilterView
          end
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 552
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object btnEndCall: TSpeedButton
          Left = 447
          Top = 5
          Width = 110
          Height = 38
          Caption = 'End Call'
          Flat = True
          Glyph.Data = {
            CA050000424DCA05000000000000360000002800000016000000150000000100
            1800000000009405000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF877C7B77686B76636485888AFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF75545368323A9D6265DFAEB0D8A6A68D
            5E635D3D3C6A5758613E4368383D6C373A5F3236703A3F6A373D61373A683031
            0000FF00FFFF00FFFF00FFFF00FFA0848B8B5356AB6D6FB48284FEECEBFDF9FF
            FFF9F8EEB5BF805354663132583636FF00FF7E5555654041FF00FF8764607957
            5EFF00FF0000FF00FFFF00FFFF00FFA08B8BAC706EBB7C8286484DFDDCDEFFFE
            FEF9FEFFFEF8F8FED0D59D6F66800000800000800000800000800000FF00FF8E
            6463A69897FF00FF0000FF00FFFF00FFFF00FF9D6361BD7C7BB57C7BCF989DFF
            EDEEF9FCFFBCA7ABF9EAE3F6C0C78C8972FF8000FF8000FF8000FF8000800000
            800000FF00FFFF00FFFF00FF0000FF00FFFF00FF6D4240BD7D83BD7A7CD17E84
            E4B6B1FFEDEDFFFAFEFFF2F7FEDFDDE0A4AE506F4CFF8000FF8000FF8000FF80
            00FF8000800000800000FF00FFFF00FF0000FF00FFFF00FFBC7375C57D7BF092
            96E2A1A4D4999FF8DCE3FFE2EBFFDEDEFBBAB6BB7F83A8B6B0E0E5EDF7FDFDFF
            8000FF8000FF8000FF8000800000FF00FFFF00FF0000FF00FF71444CBC7D7BC1
            7F7DFFB8BFFFCAD5A37375D3A9AFF4B7C2D8A9A5BB8B8536674AE6E5E6F7FDFD
            FAF5FFFF8000FF8000FF8000FF8000800000800000FF00FF0000FF00FFA15E5F
            BD7D7BE99496FFCBCEFFE0DFF5F6FA827962B176709D9272FF8000FF8000DEF1
            E4FFFCFFECFDEFFF8000FF8000FF8000FF8000FF8000800000FF00FF0000B49F
            A6BD7D83BE7D7CF7A8A8FFCBCEFEFBFF765646FF8000FF8000FF8000FF8000FF
            8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000800000800000
            000081514EBD797BC97B7DFEA2A5D4A8A3D5CCC445723CFF8000FF8000FF8000
            FF8000175521D3D5DADCDFDED6E2E0FF8000FF8000FF8000FF8000FF8000FF80
            0080000000007C4849BC797BBB7F818E4445E6B9BCFEC6CD955F54FF8000FF80
            00FF8000FF80001C5424DEDFE5E7E3E7E7E9EFFF8000FF8000FF8000FF8000FF
            8000FF80008000000000824849B97A808A4C4AFEE2E6F7FEFEFFFEFEFECBCE8B
            6D5DFF8000FF8000FF8000467153E5EAECEFEEEFF4F2F7FF8000FF8000FF8000
            FF8000FF8000FF800080000000008348499C6162EEBABDFFF7F7FEFBFFFFFFF7
            FFE2E6AF746FFF8000FF8000FF8000759279EFEFEFFBF5F6FCFBFFFF8000FF80
            00FF8000FF8000FF8000FF80008000000000754149844344FDD7DEFDFDFDF5DC
            E5E0C4CBFFD7D8B8807DFF8000FF8000FF800096B6A6F7F7F6F9FEFEFFFCFAFF
            8000FF8000FF8000FF8000FF80008000008000000000A98D93995B5FFFD8DEFA
            F3F3EADFE2FEE6E6F8C1C8B77D6FFF8000FF8000FF8000C9D0CAFEFEFFFEFCFD
            FDFEFFFF8000FF8000FF8000FF8000FF8000800000FF00FF0000FF00FF825257
            F9BFC1FFE8E8FFE5E8F8CFD0DA9BA8FF8000FF8000FF8000FF8000DEDFDFFEFB
            FFFAFCFAFEF9FFFF8000FF8000FF8000F8FEF5FF8000800000FF00FF0000FF00
            FFFF00FFCE9594F0BFBCF8C1C9EAA6B0B28286800000FF8000FF8000FF8000D4
            FEE8D4FEE8F9FEFBF8FEF8FF8000FF8000F8FEF5FF8000800000FF00FFFF00FF
            0000FF00FFFF00FFFF00FFAA767BBC7D84C69D9EFF00FFFF00FF800000FF8000
            FF8000FF8000FF8000FF8000FF8000FF8000FEFEFFFF8000800000FF00FFFF00
            FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF800000FF8000FF8000FF8000FF8000FF8000EEFAF4FF8000800000FF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF800000800000800000800000800000800000800000FF00FF
            FF00FFFF00FFFF00FFFF00FF0000}
          Margin = 3
          Visible = False
          OnClick = btnEndCallClick
        end
        object btnAdd: TSpeedButton
          Left = 2
          Top = 2
          Width = 25
          Height = 22
          Hint = 'Add'
          Flat = True
          Margin = 3
          ParentShowHint = False
          ShowHint = False
          OnClick = btAddClick
        end
        object btnOpenFilter: TSpeedButton
          Left = 29
          Top = 2
          Width = 26
          Height = 22
          Hint = 'Edit'
          Flat = True
          Margin = 3
          ParentShowHint = False
          ShowHint = False
          OnClick = btOpenFilterClick
        end
        object btDelFilter: TSpeedButton
          Left = 57
          Top = 2
          Width = 25
          Height = 22
          Hint = 'Delete'
          Flat = True
          Margin = 3
          ParentShowHint = False
          ShowHint = False
          OnClick = btDelFilterClick
        end
        object btnExecute: TSpeedButton
          Left = 3
          Top = 25
          Width = 79
          Height = 22
          Hint = 'Execute'
          Caption = 'Execute'
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84828400FFFF000000000000FF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF84828400FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
            0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000FF
            FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF848284FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
            0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00
            FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00FFFF000000000000FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84
            8284FFFFFF00FFFF00FFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          Margin = 3
          ParentShowHint = False
          ShowHint = False
          OnClick = btnExecuteClick
        end
        object btnEditCustomer: TSpeedButton
          Left = 343
          Top = 2
          Width = 59
          Height = 22
          Caption = 'Edit'
          Enabled = False
          Flat = True
          Margin = 3
          OnClick = btnEditCustomerClick
        end
        object btnStartCall: TSpeedButton
          Left = 447
          Top = 4
          Width = 111
          Height = 40
          Caption = 'Start Call'
          Flat = True
          Glyph.Data = {
            CA050000424DCA05000000000000360000002800000016000000150000000100
            1800000000009405000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF877C7B77686B76636485888AFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF75545368323A9D6265DFAEB0D8A6A68D
            5E635D3D3C6A5758613E4368383D6C373A5F3236703A3F6A373D61373A683031
            0000FF00FFFF00FFFF00FFFF00FFA0848B8B5356AB6D6FB48284FEECEBFDF9FF
            FFF9F8EEB5BF805354663132583636FF00FF7E5555654041FF00FF8764607957
            5EFF00FF0000FF00FFFF00FFFF00FFA08B8BAC706EBB7C8286484DFDDCDEFFFE
            FEF9FEFFFEF8F8FED0D59D6F661A7F361A7F361A7F361A7F361A7F36FF00FF8E
            6463A69897FF00FF0000FF00FFFF00FFFF00FF9D6361BD7C7BB57C7BCF989DFF
            EDEEF9FCFFBCA7ABF9EAE3F6C0C78C897200FF0000FF0000FF0000FF001A7F36
            1A7F36FF00FFFF00FFFF00FF0000FF00FFFF00FF6D4240BD7D83BD7A7CD17E84
            E4B6B1FFEDEDFFFAFEFFF2F7FEDFDDE0A4AE506F4C00FF0000FF0000FF0000FF
            0000FF001A7F361A7F36FF00FFFF00FF0000FF00FFFF00FFBC7375C57D7BF092
            96E2A1A4D4999FF8DCE3FFE2EBFFDEDEFBBAB6BB7F83A8B6B0E0E5EDF7FDFD00
            FF0000FF0000FF0000FF001A7F36FF00FFFF00FF0000FF00FF71444CBC7D7BC1
            7F7DFFB8BFFFCAD5A37375D3A9AFF4B7C2D8A9A5BB8B8536674AE6E5E6F7FDFD
            FAF5FF00FF0000FF0000FF0000FF001A7F361A7F36FF00FF0000FF00FFA15E5F
            BD7D7BE99496FFCBCEFFE0DFF5F6FA827962B176709D927200FF0000FF00DEF1
            E4FFFCFFECFDEF00FF0000FF0000FF0000FF0000FF001A7F36FF00FF0000B49F
            A6BD7D83BE7D7CF7A8A8FFCBCEFEFBFF76564600FF0000FF0000FF0000FF0000
            FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF001A7F361A7F36
            000081514EBD797BC97B7DFEA2A5D4A8A3D5CCC445723C00FF0000FF0000FF00
            00FF00175521D3D5DADCDFDED6E2E000FF0000FF0000FF0000FF0000FF0000FF
            001A7F3600007C4849BC797BBB7F818E4445E6B9BCFEC6CD955F5400FF0000FF
            0000FF0000FF001C5424DEDFE5E7E3E7E7E9EF00FF0000FF0000FF0000FF0000
            FF0000FF001A7F360000824849B97A808A4C4AFEE2E6F7FEFEFFFEFEFECBCE8B
            6D5D00FF0000FF0000FF00467153E5EAECEFEEEFF4F2F700FF0000FF0000FF00
            00FF0000FF0000FF001A7F3600008348499C6162EEBABDFFF7F7FEFBFFFFFFF7
            FFE2E6AF746F00FF0000FF0000FF00759279EFEFEFFBF5F6FCFBFF00FF0000FF
            0000FF0000FF0000FF0000FF001A7F360000754149844344FDD7DEFDFDFDF5DC
            E5E0C4CBFFD7D8B8807D00FF0000FF0000FF0096B6A6F7F7F6F9FEFEFFFCFA00
            FF0000FF0000FF0000FF0000FF001A7F361A7F360000A98D93995B5FFFD8DEFA
            F3F3EADFE2FEE6E6F8C1C8B77D6F00FF0000FF0000FF00C9D0CAFEFEFFFEFCFD
            FDFEFF00FF0000FF0000FF0000FF0000FF001A7F36FF00FF0000FF00FF825257
            F9BFC1FFE8E8FFE5E8F8CFD0DA9BA800FF0000FF0000FF0000FF00DEDFDFFEFB
            FFFAFCFAFEF9FF00FF0000FF0000FF00A2FED300FF001A7F36FF00FF0000FF00
            FFFF00FFCE9594F0BFBCF8C1C9EAA6B0B28286217D2F00FF0000FF0000FF00D4
            FEE8D4FEE8F9FEFBF8FEF800FF0000FF00F8FEF500FF001A7F36FF00FFFF00FF
            0000FF00FFFF00FFFF00FFAA767BBC7D84C69D9EFF00FFFF00FF14923B00FF00
            00FF0000FF0000FF0000FF0000FF0000FF00FEFEFF00FF001A7F36FF00FFFF00
            FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF1A7F3600FF0000FF0000FF0000FF0000FF00EEFAF400FF001A7F36FF00FFFF
            00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF1A7F361A7F361A7F361A7F361A7F361A7F361A7F36FF00FF
            FF00FFFF00FFFF00FFFF00FF0000}
          Margin = 3
          OnClick = btnStartCallClick
        end
        object Label7: TLabel
          Left = 136
          Top = 4
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Customer : '
        end
        object Label8: TLabel
          Left = 148
          Top = 28
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'History : '
        end
        object btnClear: TSpeedButton
          Left = 318
          Top = 2
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888888888888888888888700000078888888808888880088
            8888808888880708888887088888077088888808F8F8F077088888808F8F8F07
            7088888808F8F8F077788888808F8F8F070888888808F8F8F708888888808F8F
            8808888888887000077888888888888888888888888888888888}
          OnClick = btnClearClick
        end
        object btnMessage: TSpeedButton
          Left = 318
          Top = 25
          Width = 84
          Height = 21
          Caption = 'Message'
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
            0000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF84828484828484828484828484
            8284FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
            00000000000000000000FF00FF848284FFFFFF84828484828484828484828484
            8284FFFFFF000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000FF00FF848284
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
            FFFFFFFFC6C3C6000000FF00FF848284FFFFFF848284848284FFFFFF00000000
            0000000000000000840000FFFFFFFFFFFFFFFFFFC6C3C6000000FF00FF848284
            FFFFFFFFFFFFFFFFFFFFFFFF848284FFFFFFFFFFFF848284FFFFFFFFFFFFFFFF
            FFFFFFFFC6C3C6000000FF00FF848284FFFFFFFFFFFFFFFFFFFFFFFF848284FF
            FFFF848284840000840000FFFFFF000084000084C6C3C6000000FF00FF848284
            848284848284848284848284848284848284FFFFFFFFFFFFFFFFFFFFFFFF0000
            84000084C6C3C6000000FF00FFFF00FFFF00FFFF00FF848284C6C3C6C6C3C6C6
            C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000FF00FFFF00FF
            FF00FFFF00FFFF00FF848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFFFFFFFFFFFFFFFFFFFF0000
            00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FF848284848284848284848284FF00FFFF00FFFF00FFFF00FF}
          Margin = 3
          OnClick = btnMessageClick
        end
        object cbxSaleHistory: TComboBox
          Left = 193
          Top = 25
          Width = 124
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          OnChange = cbxSaleHistoryChange
          Items.Strings = (
            ''
            'Resumed'
            'Detailed')
        end
        object scCustomerList: TSuperComboADO
          Left = 193
          Top = 2
          Width = 123
          Height = 21
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookUpSource = DM.dsLookUpCustomer
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
          OnSelectItem = scCustomerListSelectItem
        end
      end
    end
  end
  object pnlHistory: TPanel [7]
    Left = 0
    Top = 261
    Width = 764
    Height = 127
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object shpItems: TShape
      Left = 0
      Top = 0
      Width = 764
      Height = 1
      Align = alTop
      Brush.Style = bsClear
      Pen.Color = clGray
      Visible = False
    end
    object Splitter3: TSplitter
      Left = 551
      Top = 1
      Width = 2
      Height = 126
      Align = alRight
    end
    object grdProducts: TcxGrid
      Left = 0
      Top = 1
      Width = 551
      Height = 126
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdProductsView: TcxGridDBTableView
        DataController.DataSource = dsSaleItems
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDModel'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdProductsViewMovDate: TcxGridDBColumn
          DataBinding.FieldName = 'MovDate'
          Visible = False
        end
        object grdProductsViewModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 66
        end
        object grdProductsViewDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 121
        end
        object grdProductsViewCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Width = 97
        end
        object grdProductsViewSubCategory: TcxGridDBColumn
          DataBinding.FieldName = 'SubCategory'
          Width = 92
        end
        object grdProductsViewMGroup: TcxGridDBColumn
          DataBinding.FieldName = 'MGroup'
          Width = 67
        end
        object grdProductsViewQty: TcxGridDBColumn
          DataBinding.FieldName = 'Qty'
          SortOrder = soDescending
          Width = 63
        end
        object grdProductsViewSalePrice: TcxGridDBColumn
          Caption = 'Total Sold'
          DataBinding.FieldName = 'SalePrice'
          Width = 70
        end
        object grdProductsViewExtSalePrice: TcxGridDBColumn
          DataBinding.FieldName = 'ExtSalePrice'
          Visible = False
        end
      end
      object grdProductsLevel: TcxGridLevel
        GridView = grdProductsView
      end
    end
    object DBChart1: TDBChart
      Left = 553
      Top = 1
      Width = 211
      Height = 126
      AllowPanning = pmNone
      AllowZoom = False
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      BackWall.Pen.Visible = False
      Title.Text.Strings = (
        '')
      AxisVisible = False
      ClipPoints = False
      Frame.Visible = False
      Legend.Font.Charset = DEFAULT_CHARSET
      Legend.Font.Color = clBlack
      Legend.Font.Height = -9
      Legend.Font.Name = 'Arial'
      Legend.Font.Style = []
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      View3DWalls = False
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Series1: TPieSeries
        Marks.ArrowLength = 8
        Marks.Visible = False
        DataSource = quCategory
        SeriesColor = clRed
        Title = 'Category'
        XLabelsSource = 'Category'
        OtherSlice.Text = 'Other'
        PieValues.DateTime = False
        PieValues.Name = 'Pie'
        PieValues.Multiplier = 1.000000000000000000
        PieValues.Order = loNone
        PieValues.ValueSource = 'SalePrice'
      end
    end
  end
  object Panel5: TPanel [8]
    Left = 0
    Top = 389
    Width = 764
    Height = 198
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object Shape2: TShape
      Left = 0
      Top = 0
      Width = 764
      Height = 1
      Align = alTop
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object Panel8: TPanel
      Left = 552
      Top = 1
      Width = 212
      Height = 197
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object pnlCreateHold: TPanel
        Left = 0
        Top = 0
        Width = 212
        Height = 84
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 10
          Top = 8
          Width = 54
          Height = 11
          Alignment = taRightJustify
          Caption = 'Customer :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 28
          Top = 29
          Width = 36
          Height = 11
          Alignment = taRightJustify
          Caption = 'Media :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 32
          Top = 50
          Width = 32
          Height = 11
          Alignment = taRightJustify
          Caption = 'Total :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object scCustomer: TSuperComboADO
          Left = 68
          Top = 4
          Width = 123
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          LookUpSource = DM.dsLookUpCustomer
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object scMedia: TSuperComboADO
          Left = 68
          Top = 25
          Width = 123
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          LookUpSource = DM.dsLookUpMedia
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object edtTotal: TEdit
          Left = 68
          Top = 45
          Width = 69
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = '0.00'
        end
        object chkLayaway: TCheckBox
          Left = 68
          Top = 65
          Width = 120
          Height = 17
          Caption = 'Layaway'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
      end
      object gridSaleItems: TcxGrid
        Left = 0
        Top = 84
        Width = 212
        Height = 65
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object gridSaleItemsView: TcxGridDBTableView
          DataController.DataSource = dsPreInvMov
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'ID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.MaxLineCount = 10
          Preview.Place = ppTop
          object gridSaleItemsViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Visible = False
            Options.Editing = False
            Width = 86
          end
          object gridSaleItemsViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
            Width = 103
          end
          object gridSaleItemsViewQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
            Width = 54
          end
          object gridSaleItemsViewSalePrice: TcxGridDBColumn
            DataBinding.FieldName = 'SalePrice'
            Options.Editing = False
            Width = 53
          end
          object gridSaleItemsViewItemTotal: TcxGridDBColumn
            DataBinding.FieldName = 'ItemTotal'
            Visible = False
          end
        end
        object gridSaleItemsLevel: TcxGridLevel
          GridView = gridSaleItemsView
        end
      end
      object pnlCreateSale: TPanel
        Left = 0
        Top = 149
        Width = 212
        Height = 48
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object btnCreateHold: TSpeedButton
          Left = 119
          Top = 3
          Width = 92
          Height = 22
          Caption = 'Finalize Hold'
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000
            0000000000000000000000000000000000000000000000FF00FFFF00FF000000
            008284008284000000000000000000000000000000000000C6C3C6C6C3C60000
            00008284000000FF00FFFF00FF00000000828400828400000000000000000000
            0000000000000000C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
            008284008284000000000000000000000000000000000000C6C3C6C6C3C60000
            00008284000000FF00FFFF00FF00000000828400828400000000000000000000
            0000000000000000000000000000000000008284000000FF00FFFF00FF000000
            0082840082840082840082840082840082840082840082840082840082840082
            84008284000000FF00FFFF00FF00000000828400828400000000000000000000
            0000000000000000000000000000008284008284000000FF00FFFF00FF000000
            008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
            00008284000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
            C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
            008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
            00008284000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
            C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
            008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
            00000000000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
            C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000C6C3C6000000FF00FFFF00FF000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          Margin = 3
          OnClick = btnCreateHoldClick
        end
        object btnNewHold: TSpeedButton
          Left = 58
          Top = 3
          Width = 60
          Height = 22
          Caption = 'Hold'
          Flat = True
          Margin = 3
          OnClick = btnNewHoldClick
        end
        object btnDeleteItem: TSpeedButton
          Left = 3
          Top = 3
          Width = 54
          Height = 22
          Caption = 'Item'
          Flat = True
          Margin = 3
          OnClick = btnDeleteItemClick
        end
        object btnEmail: TSpeedButton
          Left = 3
          Top = 26
          Width = 54
          Height = 22
          Caption = 'Email'
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
          OnClick = btnEmailClick
        end
      end
    end
    object Panel10: TPanel
      Left = 0
      Top = 1
      Width = 552
      Height = 197
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlItemFilter: TPanel
        Left = 0
        Top = 0
        Width = 552
        Height = 83
        Align = alTop
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        DesignSize = (
          552
          83)
        object btnExec: TSpeedButton
          Left = 492
          Top = 16
          Width = 56
          Height = 26
          Anchors = [akTop, akRight]
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          ParentFont = False
          OnClick = btnExecClick
        end
        object Label4: TLabel
          Left = 265
          Top = 7
          Width = 74
          Height = 11
          Alignment = taRightJustify
          Caption = 'Manufacturer :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 22
          Top = 6
          Width = 52
          Height = 11
          Alignment = taRightJustify
          Caption = 'Category :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbSubCategory: TLabel
          Left = 3
          Top = 25
          Width = 73
          Height = 11
          Alignment = taRightJustify
          Caption = 'Sub Category :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbGroup: TLabel
          Left = 34
          Top = 44
          Width = 36
          Height = 11
          Alignment = taRightJustify
          Caption = 'Group :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 297
          Top = 28
          Width = 42
          Height = 11
          Alignment = taRightJustify
          Caption = 'Vendor :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object scFabricante: TSuperComboADO
          Left = 342
          Top = 3
          Width = 123
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '<-->'
          LookUpSource = DM.dsLookUpFabricante
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object btFabricanteAll: TButton
          Left = 468
          Top = 4
          Width = 33
          Height = 19
          Caption = 'All'
          TabOrder = 1
          OnClick = btFabricanteAllClick
        end
        object scCategory: TSuperComboADO
          Left = 78
          Top = 2
          Width = 152
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '<-->'
          CodeLength = 315
          LookUpSource = DM.dsLookUpGroup
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          EditCodePos = taEditCodeRight
          IDLanguage = 0
        end
        object btCategoryAll: TButton
          Left = 232
          Top = 3
          Width = 32
          Height = 18
          Caption = 'All'
          TabOrder = 3
          OnClick = btCategoryAllClick
        end
        object scSubCategory: TSuperComboADO
          Left = 78
          Top = 22
          Width = 152
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = '<-->'
          CodeLength = 315
          LookUpSource = DM.dsLookUpModelGroup
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          EditCodePos = taEditCodeRight
          MostraDesativado = STD_AMBOSDESATIVADO
          MostraHidden = STD_AMBOSHIDDEN
          IDLanguage = 0
        end
        object btnSubCateAll: TButton
          Left = 232
          Top = 23
          Width = 32
          Height = 18
          Caption = 'All'
          TabOrder = 5
          OnClick = btnSubCateAllClick
        end
        object scGroup: TSuperComboADO
          Left = 78
          Top = 42
          Width = 152
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Text = '<-->'
          CodeLength = 315
          LookUpSource = DM.dsLookUpModelSubGroup
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          EditCodePos = taEditCodeRight
          IDLanguage = 0
        end
        object btnMGroupAll: TButton
          Left = 232
          Top = 43
          Width = 32
          Height = 19
          Caption = 'All'
          TabOrder = 7
          OnClick = btnMGroupAllClick
        end
        object scVendor: TSuperComboADO
          Left = 342
          Top = 24
          Width = 123
          Height = 19
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          Text = '<-->'
          LookUpSource = DM.dsLookUpFornecedor
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object btnVendorAll: TButton
          Left = 468
          Top = 25
          Width = 33
          Height = 19
          Caption = 'All'
          TabOrder = 9
          OnClick = btnVendorAllClick
        end
      end
      object grdSellItems: TcxGrid
        Left = 0
        Top = 83
        Width = 552
        Height = 114
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdSellItemsView: TcxGridDBTableView
          OnDblClick = grdSellItemsViewDblClick
          DataController.DataSource = dsModelSell
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDModel'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdSellItemsViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Width = 66
          end
          object grdSellItemsViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 107
          end
          object grdSellItemsViewCategory: TcxGridDBColumn
            DataBinding.FieldName = 'Category'
            Width = 88
          end
          object grdSellItemsViewVendor: TcxGridDBColumn
            DataBinding.FieldName = 'Vendor'
            Width = 69
          end
          object grdSellItemsViewQtyOnHand: TcxGridDBColumn
            Caption = 'OnHand'
            DataBinding.FieldName = 'QtyOnHand'
            Width = 77
          end
          object grdSellItemsViewPromotionPrice: TcxGridDBColumn
            Caption = 'Promotion'
            DataBinding.FieldName = 'PromotionPrice'
            Width = 77
          end
          object grdSellItemsViewFinalPrice: TcxGridDBColumn
            DataBinding.FieldName = 'FinalPrice'
            Width = 94
          end
        end
        object grdSellItemsLevel: TcxGridLevel
          GridView = grdSellItemsView
        end
      end
    end
  end
  object quCustomer: TADODataSet [9]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quCustomerAfterOpen
    OnCalcFields = quCustomerCalcFields
    CommandText = 
      'SELECT DISTINCT'#13#10#9'P.IDPessoa, '#13#10#9'P.Pessoa as FullName, '#13#10#9'P.IDTi' +
      'poPessoa, '#13#10#9'P.IDStore, '#13#10#9'P.NomeJuridico, '#13#10#9'P.Endereco,'#13#10#9'P.Ci' +
      'dade, '#13#10#9'P.CEP, '#13#10#9'P.Pais, '#13#10#9'P.Telefone as Phone, '#13#10#9'P.Cellular' +
      ' as Cell, '#13#10#9'P.PhoneAreaCode as PCode, '#13#10#9'P.CellAreaCode as CCod' +
      'e, '#13#10#9'P.Fax, '#13#10#9'P.Beeper, '#13#10#9'P.Contato, '#13#10#9'P.Email, '#13#10#9'P.OBS, '#13#10 +
      #9'P.Juridico, '#13#10#9'P.TotalMovimentado, '#13#10#9'P.Limite, '#13#10#9'P.Nascimento' +
      ', '#13#10#9'P.IDEstado, '#13#10#9'P.DiaQuitacao, '#13#10#9'P.IDPessoaBoss, '#13#10#9'P.IDTip' +
      'oPessoaFilho, '#13#10#9'P.IDRamoAtividade, '#13#10#9'P.CPF,'#13#10#9'P.CGC, '#13#10#9'P.Iden' +
      'tidade, '#13#10#9'P.CartTrabalho, '#13#10#9'P.InscEstadual, '#13#10#9'P.InscMunicipal' +
      ', '#13#10#9'P.Contatos, '#13#10#9'P.NumAtrasos, '#13#10#9'P.DiasAtraso,'#13#10#9'P.NumTransa' +
      'coes, '#13#10#9'P.HomePage, '#13#10#9'P.OrgaoEmissor, '#13#10#9'P.Bairro, '#13#10#9'P.NumMov' +
      'imentacoes, '#13#10#9'P.System, '#13#10#9'P.Desativado, '#13#10#9'P.Hidden, '#13#10#9'P.Comi' +
      'ssaoSobreGuia, '#13#10#9'P.DescontaCoordenacao, '#13#10#9'P.AjusteComiss, '#13#10#9'P' +
      '.IDUser, '#13#10#9'P.ShortName, '#13#10#9'P.Short_Name, '#13#10#9'P.Code, '#13#10#9'P.IDTipo' +
      'PessoaRoot, '#13#10#9'P.IDPais, '#13#10#9'P.PessoaLastName, '#13#10#9'P.CustomerCard,' +
      ' '#13#10#9'P.PessoaFirstName,'#13#10#9'P.UserCode,'#13#10#9'P.CartMotorista,'#13#10#9'P.Data' +
      'Expedicao,'#13#10#9'PH.IDPessoaHistory,'#13#10#9'H.PType,'#13#10#9'H.PResult,'#13#10#9'H.Res' +
      'ultColor,'#13#10#9'H.IDPessoaHistoryType,'#13#10#9'H.IDPessoaHistoryResult,'#13#10#9 +
      'H.MovDate,'#13#10#9'E.Estado'#13#10'FROM '#13#10#9'Pessoa P (NOLOCK) '#13#10#9'JOIN TipoPes' +
      'soa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa)'#13#10#9'LEFT JOI' +
      'N Estado E (NOLOCK) ON (E.IDEstado = P.IDEstado)'#13#10#9'LEFT JOIN Inv' +
      'oice I (NOLOCK) ON (I.IDCustomer = P.IDPessoa)'#13#10#9'LEFT JOIN Inven' +
      'toryMov IM (NOLOCK) ON (I.IDInvoice = IM.DocumentID AND IM.Inven' +
      'tMovTypeID = 1)'#13#10#9'LEFT JOIN Model M (NOLOCK) ON (IM.ModelID = M.' +
      'IDModel)'#13#10#9'LEFT JOIN Ser_ServiceOrder SO (NOLOCK) ON (P.IDPessoa' +
      ' = SO.IDCustomer)'#13#10#9'LEFT JOIN Ser_SOItem SOI (NOLOCK) ON (SO.IDS' +
      'erviceOrder = SOI.IDServiceOrder)'#13#10#9'LEFT JOIN ('#9#9#13#10#9'SELECT'#13#10#9#9'PH' +
      '.IDPessoa,'#13#10#9#9'MAX(PH.IDPessoaHistory) as IDPessoaHistory'#13#10#9'FROM'#13 +
      #10#9#9'Mnt_PessoaHistory PH (NOLOCK) '#13#10#9'GROUP BY'#13#10#9#9'PH.IDPessoa'#13#10#9') ' +
      'PH ON (PH.IDPessoa = P.IDPessoa)'#13#10#9'LEFT JOIN ('#9#13#10#9'SELECT'#13#10#9#9'PH.I' +
      'DPessoaHistory,'#13#10#9#9'PH.MovDate,'#13#10#9#9'PHT.IDPessoaHistoryType,'#13#10#9#9'PH' +
      'T.PessoaHistoryType as PType,'#13#10#9#9'PHR.IDPessoaHistoryResult,'#13#10#9#9'P' +
      'HR.PessoaHistoryResult as PResult,'#13#10#9#9'PHR.ResultColor'#13#10#9'FROM'#13#10#9#9 +
      'Mnt_PessoaHistory PH (NOLOCK) '#13#10#9#9'JOIN Mnt_PessoaHistoryType PHT' +
      ' (NOLOCK) ON (PH.IDPessoaHistoryType = PHT.IDPessoaHistoryType)'#13 +
      #10#9#9'JOIN Mnt_PessoaHistoryResult PHR (NOLOCK) ON (PH.IDPessoaHist' +
      'oryResult = PHR.IDPessoaHistoryResult)'#13#10#9') H ON (PH.IDPessoaHist' +
      'ory = H.IDPessoaHistory)'#13#10#13#10#13#10
    CommandTimeout = 360
    Parameters = <>
    Left = 268
    Top = 100
    object quCustomerIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quCustomerFullName: TStringField
      FieldName = 'FullName'
      Size = 50
    end
    object quCustomerIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object quCustomerIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quCustomerNomeJuridico: TStringField
      FieldName = 'NomeJuridico'
      Size = 50
    end
    object quCustomerEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object quCustomerCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object quCustomerCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quCustomerPais: TStringField
      FieldName = 'Pais'
      Size = 21
    end
    object quCustomerPhone: TStringField
      FieldName = 'Phone'
      Size = 40
    end
    object quCustomerCell: TStringField
      FieldName = 'Cell'
      FixedChar = True
      Size = 18
    end
    object quCustomerPCode: TStringField
      FieldName = 'PCode'
      Size = 5
    end
    object quCustomerCCode: TStringField
      FieldName = 'CCode'
      Size = 5
    end
    object quCustomerFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quCustomerBeeper: TStringField
      FieldName = 'Beeper'
      FixedChar = True
      Size = 25
    end
    object quCustomerContato: TStringField
      FieldName = 'Contato'
      Size = 50
    end
    object quCustomerEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quCustomerOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
    object quCustomerJuridico: TBooleanField
      FieldName = 'Juridico'
    end
    object quCustomerTotalMovimentado: TBCDField
      FieldName = 'TotalMovimentado'
      Precision = 19
    end
    object quCustomerLimite: TBCDField
      FieldName = 'Limite'
      Precision = 19
    end
    object quCustomerNascimento: TDateTimeField
      FieldName = 'Nascimento'
    end
    object quCustomerIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quCustomerDiaQuitacao: TIntegerField
      FieldName = 'DiaQuitacao'
    end
    object quCustomerIDPessoaBoss: TIntegerField
      FieldName = 'IDPessoaBoss'
    end
    object quCustomerIDTipoPessoaFilho: TIntegerField
      FieldName = 'IDTipoPessoaFilho'
    end
    object quCustomerIDRamoAtividade: TIntegerField
      FieldName = 'IDRamoAtividade'
    end
    object quCustomerCPF: TStringField
      FieldName = 'CPF'
      Size = 30
    end
    object quCustomerCGC: TStringField
      FieldName = 'CGC'
      Size = 30
    end
    object quCustomerIdentidade: TStringField
      FieldName = 'Identidade'
      Size = 30
    end
    object quCustomerCartTrabalho: TStringField
      FieldName = 'CartTrabalho'
      Size = 30
    end
    object quCustomerInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
    object quCustomerInscMunicipal: TStringField
      FieldName = 'InscMunicipal'
      Size = 30
    end
    object quCustomerContatos: TStringField
      FieldName = 'Contatos'
      Size = 255
    end
    object quCustomerNumAtrasos: TIntegerField
      FieldName = 'NumAtrasos'
    end
    object quCustomerDiasAtraso: TIntegerField
      FieldName = 'DiasAtraso'
    end
    object quCustomerNumTransacoes: TIntegerField
      FieldName = 'NumTransacoes'
    end
    object quCustomerHomePage: TStringField
      FieldName = 'HomePage'
      Size = 200
    end
    object quCustomerOrgaoEmissor: TStringField
      FieldName = 'OrgaoEmissor'
      Size = 50
    end
    object quCustomerBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object quCustomerNumMovimentacoes: TIntegerField
      FieldName = 'NumMovimentacoes'
    end
    object quCustomerSystem: TBooleanField
      FieldName = 'System'
    end
    object quCustomerDesativado: TIntegerField
      FieldName = 'Desativado'
    end
    object quCustomerHidden: TIntegerField
      FieldName = 'Hidden'
    end
    object quCustomerComissaoSobreGuia: TBCDField
      FieldName = 'ComissaoSobreGuia'
      Precision = 19
    end
    object quCustomerDescontaCoordenacao: TBooleanField
      FieldName = 'DescontaCoordenacao'
    end
    object quCustomerAjusteComiss: TBCDField
      FieldName = 'AjusteComiss'
      Precision = 19
    end
    object quCustomerIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quCustomerShortName: TStringField
      FieldName = 'ShortName'
      Size = 15
    end
    object quCustomerShort_Name: TStringField
      FieldName = 'Short_Name'
      Size = 30
    end
    object quCustomerCode: TIntegerField
      FieldName = 'Code'
    end
    object quCustomerIDTipoPessoaRoot: TIntegerField
      FieldName = 'IDTipoPessoaRoot'
    end
    object quCustomerIDPais: TIntegerField
      FieldName = 'IDPais'
    end
    object quCustomerPessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quCustomerCustomerCard: TStringField
      FieldName = 'CustomerCard'
    end
    object quCustomerPessoaFirstName: TStringField
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quCustomerUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object quCustomerCartMotorista: TStringField
      FieldName = 'CartMotorista'
      Size = 15
    end
    object quCustomerDataExpedicao: TDateTimeField
      FieldName = 'DataExpedicao'
    end
    object quCustomerAPhone: TStringField
      DisplayLabel = 'Phone'
      FieldKind = fkCalculated
      FieldName = 'APhone'
      Size = 45
      Calculated = True
    end
    object quCustomerACel: TStringField
      DisplayLabel = 'ACell'
      FieldKind = fkCalculated
      FieldName = 'ACel'
      Size = 45
      Calculated = True
    end
    object quCustomerIDPessoaHistory: TIntegerField
      FieldName = 'IDPessoaHistory'
    end
    object quCustomerPType: TStringField
      FieldName = 'PType'
      Size = 30
    end
    object quCustomerPResult: TStringField
      FieldName = 'PResult'
      Size = 30
    end
    object quCustomerResultColor: TStringField
      FieldName = 'ResultColor'
    end
    object quCustomerIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quCustomerIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quCustomerMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object quCustomerEstado: TStringField
      FieldName = 'Estado'
      Size = 50
    end
  end
  object dsCustomer: TDataSource [10]
    DataSet = cdsCustomer
    Left = 268
    Top = 152
  end
  object quCHistory: TADODataSet [11]
    Connection = DM.ADODBConnect
    CommandText = 
      'Select'#13#10#9'PH.IDPessoaHistory,'#13#10#9'PH.IDPessoa,'#13#10#9'PH.IDUser,'#13#10#9'PH.ID' +
      'PessoaHistoryType,'#13#10#9'PH.IDPessoaHistoryResult,'#13#10#9'PH.MovDate,'#13#10#9'P' +
      'H.Obs,'#13#10#9'SU.SystemUser,'#13#10#9'PHT.PessoaHistoryType,'#13#10#9'PHR.PessoaHis' +
      'toryResult'#13#10'From'#13#10#9'Mnt_PessoaHistory PH (NOLOCK) '#13#10#9'JOIN SystemU' +
      'ser SU (NOLOCK) ON (PH.IDUser = SU.IDUser)'#13#10#9'JOIN Mnt_PessoaHist' +
      'oryType PHT (NOLOCK) ON (PH.IDPessoaHistoryType = PHT.IDPessoaHi' +
      'storyType)'#13#10#9'JOIN Mnt_PessoaHistoryResult PHR (NOLOCK) ON (PH.ID' +
      'PessoaHistoryResult = PHR.IDPessoaHistoryResult)'#13#10'Where'#13#10#9'PH.IDP' +
      'essoa = :IDPessoa'#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 688
    Top = 148
    object quCHistoryIDPessoaHistory: TIntegerField
      FieldName = 'IDPessoaHistory'
    end
    object quCHistoryIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quCHistoryIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quCHistoryIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quCHistoryIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quCHistoryMovDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'MovDate'
    end
    object quCHistoryObs: TStringField
      FieldName = 'Obs'
      Size = 255
    end
    object quCHistorySystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quCHistoryPessoaHistoryType: TStringField
      DisplayLabel = 'Type'
      FieldName = 'PessoaHistoryType'
      Size = 30
    end
    object quCHistoryPessoaHistoryResult: TStringField
      DisplayLabel = 'Result'
      FieldName = 'PessoaHistoryResult'
      Size = 30
    end
  end
  object dsCHistory: TDataSource [12]
    DataSet = quCHistory
    Left = 688
    Top = 100
  end
  object dsFilter: TDataSource [13]
    DataSet = quFilter
    Left = 40
    Top = 100
  end
  object quFilter: TADODataSet [14]
    Connection = DM.ADODBConnect
    AfterOpen = quFilterAfterOpen
    CommandText = 
      'Select'#13#10#9'IDTelemarketingFilter,'#13#10#9'FilterName,'#13#10#9'FilterValues,'#13#10#9 +
      'SQL'#13#10'From '#13#10#9'Sal_TelemarketingFilter (NOLOCK) '#13#10
    Parameters = <>
    Left = 40
    Top = 148
    object quFilterIDTelemarketingFilter: TIntegerField
      FieldName = 'IDTelemarketingFilter'
    end
    object quFilterFilterName: TStringField
      DisplayLabel = 'Filter Name'
      FieldName = 'FilterName'
      Size = 30
    end
    object quFilterFilterValues: TMemoField
      FieldName = 'FilterValues'
      BlobType = ftMemo
    end
    object quFilterSQL: TMemoField
      FieldName = 'SQL'
      BlobType = ftMemo
    end
  end
  object quSaleItems: TADODataSet [15]
    Connection = DM.ADODBConnect
    OnCalcFields = quSaleItemsCalcFields
    CommandText = 
      'SELECT'#13#10#9'GetDate() as MovDate,'#13#10#9'SUM(CostPrice) as CostPrice,'#13#10#9 +
      'SUM(SalePrice) as SalePrice,'#13#10#9'SUM(Discount) as Discount,'#13#10#9'SUM(' +
      'Qty) as Qty,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'MG.Model' +
      'Group as SubCategory,'#13#10#9'MGS.ModelSubGroup as MGroup,'#13#10#9'TG.Name a' +
      's Category'#9#13#10'FROM'#13#10#9'InventoryMov IM (NOLOCK) '#13#10#9'JOIN Model M (NO' +
      'LOCK) ON (IM.ModelID = M.IDModel)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON' +
      ' (M.GroupID = TG.IDGroup)'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOC' +
      'K) ON (M.IDModelGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN Model' +
      'SubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGrou' +
      'p)'#13#10'WHERE'#13#10#9'IM.InventMovTypeID in (1, 50)'#13#10#9'AND'#13#10#9'IM.IDPessoa = ' +
      ':IDPessoa'#13#10#9'AND'#13#10#9'IM.StoreID = IsNull(:IDStore, IM.StoreID)'#13#10'GRO' +
      'UP BY'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'MG.ModelGroup,'#13 +
      #10#9'MGS.ModelSubGroup,'#13#10#9'TG.Name'#13#10
    CommandTimeout = 360
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
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 276
    Top = 256
    object quSaleItemsMovDate: TDateTimeField
      FieldName = 'MovDate'
      ReadOnly = True
      DisplayFormat = 'ddddd'
    end
    object quSaleItemsModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quSaleItemsDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quSaleItemsCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quSaleItemsSubCategory: TStringField
      FieldName = 'SubCategory'
      Size = 30
    end
    object quSaleItemsMGroup: TStringField
      DisplayLabel = 'Group'
      FieldName = 'MGroup'
      Size = 30
    end
    object quSaleItemsQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quSaleItemsCostPrice: TBCDField
      FieldName = 'CostPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSaleItemsSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSaleItemsDiscount: TBCDField
      FieldName = 'Discount'
      ReadOnly = True
      Precision = 19
    end
    object quSaleItemsIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quSaleItemsExtSalePrice: TCurrencyField
      DisplayLabel = 'Total Sold'
      FieldKind = fkCalculated
      FieldName = 'ExtSalePrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
  end
  object dsSaleItems: TDataSource [16]
    DataSet = quSaleItems
    Left = 276
    Top = 308
  end
  object quCategory: TADODataSet [17]
    Connection = DM.ADODBConnect
    OnCalcFields = quSaleItemsCalcFields
    CommandText = 
      'SELECT TOP 10'#13#10#9'SUM((SalePrice * Qty) - Discount) as SalePrice,'#13 +
      #10#9'TG.Name as Category'#9#13#10'FROM'#13#10#9'InventoryMov IM (NOLOCK) '#13#10#9'JOIN ' +
      'Model M (NOLOCK) ON (IM.ModelID = M.IDModel)'#13#10#9'JOIN TabGroup TG ' +
      '(NOLOCK)  ON (M.GroupID = TG.IDGroup)'#13#10#9'LEFT OUTER JOIN ModelGro' +
      'up MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTE' +
      'R JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.ID' +
      'ModelSubGroup)'#13#10'WHERE'#13#10#9'IM.InventMovTypeID = 1'#13#10#9'AND'#13#10#9'IM.IDPess' +
      'oa = :IDPessoa'#13#10#9'AND'#13#10#9'IM.StoreID = IsNull(:IDStore, IM.StoreID)' +
      #13#10'GROUP BY'#13#10#9'TG.Name'#13#10'ORDER BY'#13#10#9'SalePrice DESC'#13#10
    CommandTimeout = 360
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
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 628
    Top = 264
    object quCategorySalePrice: TFloatField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object quCategoryCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
  end
  object dsCategory: TDataSource [18]
    DataSet = quCategory
    Left = 628
    Top = 316
  end
  object quModelSell: TADODataSet [19]
    Connection = DM.ADODBConnect
    OnCalcFields = quModelSellCalcFields
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.PromotionPri' +
      'ce,'#13#10#9'M.SellingPrice as ModelPrice,'#13#10#9'M.FinalCost as ModelCost,'#13 +
      #10#9'I.SellingPrice as StoreSellingPrice,'#13#10#9'I.StoreCostPrice,'#13#10#9'I.Q' +
      'tyOnHand,'#13#10#9'P.Pessoa as Manufacture,'#13#10#9'TG.Name as Category,'#13#10#9'MG' +
      '.ModelGroup as CatSubGroup,'#13#10#9'V.Pessoa as Vendor'#13#10'FROM'#13#10#9'Model M' +
      ' (NOLOCK) '#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGrou' +
      'p)'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup =' +
      ' MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) O' +
      'N (M.IDModelSubGroup = MGS.IDModelSubGroup)'#13#10#9'LEFT OUTER JOIN Pe' +
      'ssoa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante)'#13#10#9'LEFT OUTER JO' +
      'IN Inventory I (NOLOCK) ON (M.IDModel = I.ModelID)'#13#10#9'LEFT JOIN I' +
      'nv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel AND Vendor' +
      'Order = 1)'#13#10#9'LEFT JOIN Pessoa V ON (V.IDPessoa = MV.IDPessoa)'#13#10
    CommandTimeout = 360
    Parameters = <>
    Left = 272
    Top = 444
    object quModelSellIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelSellModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelSellDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelSellPromotionPrice: TBCDField
      DisplayLabel = 'Promotion'
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object quModelSellModelPrice: TBCDField
      FieldName = 'ModelPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelSellStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelSellQtyOnHand: TFloatField
      DisplayLabel = 'On Hand'
      FieldName = 'QtyOnHand'
    end
    object quModelSellManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
    object quModelSellCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quModelSellCatSubGroup: TStringField
      FieldName = 'CatSubGroup'
      Size = 30
    end
    object quModelSellVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quModelSellFinalPrice: TCurrencyField
      DisplayLabel = 'Selling Price'
      FieldKind = fkCalculated
      FieldName = 'FinalPrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quModelSellStoreCostPrice: TBCDField
      FieldName = 'StoreCostPrice'
      Precision = 19
    end
    object quModelSellModelCost: TBCDField
      FieldName = 'ModelCost'
      ReadOnly = True
      Precision = 19
    end
    object quModelSellFinalCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'FinalCost'
      Calculated = True
    end
  end
  object dsModelSell: TDataSource [20]
    DataSet = quModelSell
    Left = 272
    Top = 496
  end
  object cdsPreInvMov: TClientDataSet [21]
    Aggregates = <>
    Params = <>
    AfterPost = cdsPreInvMovAfterPost
    OnCalcFields = cdsPreInvMovCalcFields
    Left = 672
    Top = 490
    object cdsPreInvMovID: TIntegerField
      FieldName = 'ID'
    end
    object cdsPreInvMovIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsPreInvMovIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsPreInvMovIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsPreInvMovIDCustomer: TIntegerField
      FieldName = 'IDCustomer'
    end
    object cdsPreInvMovModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsPreInvMovDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsPreInvMovQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsPreInvMovSalePrice: TCurrencyField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsPreInvMovCostPrice: TCurrencyField
      FieldName = 'CostPrice'
    end
    object cdsPreInvMovItemTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ItemTotal'
      Calculated = True
    end
    object cdsPreInvMovDiscount: TCurrencyField
      FieldName = 'Discount'
    end
  end
  object dsPreInvMov: TDataSource [22]
    DataSet = cdsPreInvMov
    Left = 672
    Top = 542
  end
  object quSaleItemDetail: TADODataSet [23]
    Connection = DM.ADODBConnect
    OnCalcFields = quSaleItemDetailCalcFields
    CommandText = 
      'SELECT'#13#10#9'IM.IDInventoryMov,'#13#10#9'IM.MovDate,'#13#10#9'IM.CostPrice,'#13#10#9'IM.S' +
      'alePrice,'#13#10#9'IM.Discount,'#13#10#9'IM.Qty,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.D' +
      'escription,'#13#10#9'MG.ModelGroup as SubCategory,'#13#10#9'MGS.ModelSubGroup ' +
      'as MGroup,'#13#10#9'TG.Name as Category'#9#13#10'FROM'#13#10#9'InventoryMov IM (NOLOC' +
      'K) '#13#10#9'JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)'#13#10#9'JOIN T' +
      'abGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'#13#10#9'LEFT OUTER JOI' +
      'N ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup)'#13#10 +
      #9'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGrou' +
      'p = MGS.IDModelSubGroup)'#13#10'WHERE'#13#10#9'IM.InventMovTypeID in (1, 50)'#13 +
      #10#9'AND'#13#10#9'IM.IDPessoa = :IDPessoa'#13#10#9'AND'#13#10#9'IM.StoreID = IsNull(:IDS' +
      'tore, IM.StoreID)'#13#10
    CommandTimeout = 360
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
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 184
    Top = 260
    object quSaleItemDetailIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quSaleItemDetailMovDate: TDateTimeField
      FieldName = 'MovDate'
      DisplayFormat = 'ddddd'
    end
    object quSaleItemDetailCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quSaleItemDetailSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quSaleItemDetailDiscount: TBCDField
      FieldName = 'Discount'
      Precision = 19
    end
    object quSaleItemDetailQty: TFloatField
      FieldName = 'Qty'
    end
    object quSaleItemDetailIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quSaleItemDetailModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quSaleItemDetailDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quSaleItemDetailSubCategory: TStringField
      FieldName = 'SubCategory'
      Size = 30
    end
    object quSaleItemDetailMGroup: TStringField
      FieldName = 'MGroup'
      Size = 30
    end
    object quSaleItemDetailCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quSaleItemDetailExtSalePrice: TCurrencyField
      DisplayLabel = 'Total Sold'
      FieldKind = fkCalculated
      FieldName = 'ExtSalePrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
  end
  object dsSaleItemDetail: TDataSource [24]
    DataSet = quSaleItemDetail
    Left = 183
    Top = 312
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmTeleMarketing.sil'
  end
  object cdsCustomer: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCustomer'
    AfterScroll = cdsCustomerAfterScroll
    Left = 204
    Top = 152
  end
  object dspCustomer: TDataSetProvider
    DataSet = quCustomer
    Left = 204
    Top = 100
  end
end
