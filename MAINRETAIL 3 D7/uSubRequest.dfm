inherited SubRequest: TSubRequest
  Left = 348
  Top = 186
  Width = 370
  Height = 315
  Caption = 'SubRequest'
  Color = 14607076
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TPanel [0]
    Left = 0
    Top = 14
    Width = 354
    Height = 68
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      354
      68)
    object cmbList: TComboBox
      Left = 1
      Top = 2
      Width = 359
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnChange = cmbListChange
      Items.Strings = (
        'All requests'
        'System requests'
        'Sales Person requests'
        'Requests for New Models'
        'Max Qty'
        'Min Qty'
        'All Inventory')
    end
    object scGroup: TcxLookupComboBox
      Left = 2
      Top = 25
      Width = 320
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Properties.KeyFieldNames = 'IDGroup'
      Properties.ListColumns = <
        item
          FieldName = 'Name'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsLookUpGroup
      Properties.OnEditValueChanged = scGroupPropertiesEditValueChanged
      Style.BorderStyle = ebsFlat
      Style.HotTrack = True
      Style.PopupBorderStyle = epbsDefault
      TabOrder = 1
      OnEnter = scGroupEnter
    end
    object btGroupAll: TButton
      Left = 326
      Top = 25
      Width = 31
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'All'
      TabOrder = 2
      OnClick = btGroupAllClick
    end
    object btFabricanteAll: TButton
      Left = 326
      Top = 47
      Width = 30
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'All'
      TabOrder = 3
      TabStop = False
      OnClick = btFabricanteAllClick
    end
    object cbxEntiry: TComboBox
      Left = 2
      Top = 47
      Width = 83
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = 'Vendor'
      OnChange = cbxEntiryChange
      Items.Strings = (
        'Vendor'
        'Manufacture')
    end
    object cbxEntity: TcxLookupComboBox
      Left = 84
      Top = 47
      Width = 238
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Properties.KeyFieldNames = 'IDPessoa'
      Properties.ListColumns = <
        item
          FieldName = 'Pessoa'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsEntity
      Properties.OnChange = cbxEntityPropertiesChange
      Style.BorderStyle = ebsFlat
      Style.HotTrack = True
      Style.PopupBorderStyle = epbsDefault
      TabOrder = 5
      OnEnter = cbxEntityEnter
    end
  end
  object pnlAdd: TPanel [1]
    Left = 0
    Top = 253
    Width = 354
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      354
      24)
    object lblFrameRequestCount: TLabel
      Left = 6
      Top = 7
      Width = 180
      Height = 13
      AutoSize = False
      Caption = 'Count'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btFrameRequestAddRequest: TSpeedButton
      Left = 239
      Top = 3
      Width = 56
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Add'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
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
      Margin = 1
      ParentFont = False
      OnClick = btFrameRequestAddRequestClick
    end
    object btFrameRequestRemoveRequest: TSpeedButton
      Left = 296
      Top = 3
      Width = 61
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Remove'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
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
      Margin = 1
      ParentFont = False
      OnClick = btFrameRequestRemoveRequestClick
    end
    object btnColumn: TSpeedButton
      Left = 215
      Top = 3
      Width = 20
      Height = 21
      Anchors = [akTop, akRight]
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        12040000424D1204000000000000360000002800000011000000130000000100
        180000000000DC03000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00D07622993401993401993401993401993401
        9934019934019934019934019934019934019934019934019934019934018080
        8000D07622FFFFFFF8E1D7FDF4F0FFFFFFFEFCFBFAF3EEF8EFE8F7EDE6F7EDE6
        F7EDE6F8EFE9FDFAF9FFFFFF9D39039C380380808000D07622FFFFFFF6D5C7FB
        EEE9FFFFFFFEFCFBF9F1ECF7EDE6F7EDE6F7EDE6F8EEE7F8EFE9FDFAF9FFFFFF
        A23E0696958080808000D07622FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
        FDFCFDFAF9FCF9F7FDFAF9FFFFFFFFFFFFFFFFFFA74509A4551F80808000D076
        22FFFFFF87F0F4FFFFFFFFFFFFFCF9F7F5E9E0F4E7DDF4E7DDF5E9E0F7ECE5F9
        F2EDFCF8F6FFFFFFB55510B5561180808000D07622FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD5D14A6
        9E7C80808000D07622FFFFFFFE0102FFFFFFFFFFFFF6E9E1F1DFD2F2E1D5F5E7
        DEF7ECE5FAF3EEFDFBFAFFFFFFFFFFFFC36618A4B29680808000D07622FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFCA6E1BCA6E1B80808000D0762257C9FF57C9FF57C9FF57C9FF57C9FF
        57C9FF57C9FF57C9FF57C9FF57C9FF2CBCFF49C5FFC6EDFFD0751FD0751F8080
        8000D07622BEEBFFBEEBFFC6EDFFC6EDFFC6EDFFC6EDFFC6EDFFC6EDFFC6EDFF
        C6ECFDC6EDFFFFFFFFFFFFFFD77D23AFBA9580808000D07622B8F3FEA6F0FEEC
        FCFFFFFFFFFFFEFEF6EBE3F6ECE4F5E8DFF9F1ECFDFBFAFFFFFFFFFFFFFFFFFF
        DE8527D0964980808000D07622F4FDFFCDF7FFFFFFFFFFFFFFFFFFFFFCF7F5FC
        F8F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE58D2BE58D2B80808000D076
        22E8F6E891D491F4FBF3FFFFFFF3E3D8F3E3D9F3E3D9F6EAE2F6EAE2F9F1EBFF
        FFFFFFFFFFFFFFFFEB952EC5BA8180808000D07622DBF1DB67C466FCFEFCFFFF
        FFFBF6F2FBF5F1FBF6F2FCF8F6FCF8F5FDFAF9FFFFFFFFFFFFFFFFFFF19C32BB
        CA9D80808000D07622FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF9C32E2A85180808000D07622D07622
        4666B73C78C2A77254E38B2DE28A2DE08A2DE08A2EE18B2FE28C2DE28E2DE28C
        2DE38D2EE58F2EE38F2D80808000D07622DD86293B92CA4694BEA47862E08A2C
        E0882CE0892DE0892CDF892DE0892EE08A2DDF892CE0892CE08A2DDE882CFF00
        FF00FF00FFF8A436DF8729E38B2AEC9732F5A035F49E35F39E35F29D34F19D34
        F09C34EF9B33EF9A32F09B32F09B33FF00FFFF00FF00}
      Margin = 1
      ParentFont = False
      OnClick = btnColumnClick
    end
    object btnGroup: TSpeedButton
      Left = 192
      Top = 3
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        12040000424D1204000000000000360000002800000011000000130000000100
        180000000000DC03000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00A47874A47874A47874A47874A47874A47874
        A47874A47874A47874A47874FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF00A47874F3E3D1FEE4CAFED6C9FED6C9FED0B7FED0B7FED0B7FED7ABA47874
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00B48176FEEBD7FEE4CAFE
        E4CAFEDDBBC7D195448A3E05710A05710A0F831905710A2A8C43FF00FFFF00FF
        FF00FFFF00FFFF00FF00BA8E85FEEBD7FEEBD7FEE4CAFEE4CA448A3E7DA9727D
        A972448A3E0F831918992E25A63D0F8319FF00FFFF00FFFF00FFFF00FF00CB9A
        82FEF4E9FEEBD7FEEBD7FEE4CAFEE4CAFEDDBBFEDDBBFEDDBBB48176255E2825
        BB4F30C3690F8319FF00FFFF00FFFF00FF00CB9A82FEF4E9FEF0E2FEF0E2FEEB
        D7FEE4CAFEE4CAFEDDBBFEDDBBB48176FEF0E20F831947CE7125BB4F2A8C43FF
        00FFFF00FF00DCA887FEF9F3FEF4E9FEF0E2FEEBD7FEEBD7FEE4CAFEE4CAFEDD
        BBB48176FEF0E20F831947CE7158E0870F8319FF00FFFF00FF00E3B18EFFFDF8
        FFF8EEFEF4E9FEF0E2FEEBD7FEEBD7FEE4CA0F83190F83190F83190F831958E0
        8758E0870F83190F83190F831900EDBD92FFFFFFFEFAF7FEF9F3FEF4E9FEF0E2
        FEEBD7FEEBD7F0E4C7267D2725A63D47CE7158E08758E08758E08725A63D267D
        2700EDBD92FFFFFFFFFFFEFDFAFAFEF9F3FEF4E9FEF0E2FEEBD7F3B9B5B48176
        05710A47CE7158E08758E08758E0870F8319FF00FF00EDBD92FFFFFFFFFEFFFE
        FEFEFFFDF8FEF9F3FEF4E9B48176B48176B48176B1A0970F831958E08758E087
        267D27B48176FF00FF00EDBD92FCFEFBFCFEFEFEFFFCFCFEFEFEFAF7FFF8EEB4
        8176FCC47CDCA887FED6C98DBC8B267D270F8319FECFC2B48176FF00FF00DCA8
        87FFFEFEFDFAFAF8F8F8F3F3F3F3F3F3ECEAEAB48176D6A894F3E3D1FEF0E2FE
        F0E27DA9728DBC8BFECFC2B48176FF00FF00DCA887DCA887DCA887DCA887DCA8
        87DCA887DCA887DCA887F5EADFFFF8EEFEF4E9FEF0E2FEEBD7FECFC2F3B9B5B4
        8176FF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFEDBD92FEFAF7FEFAF7FDFA
        FAFEFAF7FEF9F3FEF4E9B48176B48176B48176B48176FF00FF00FF00FFFF00FF
        FF00FFFF00FFFF00FFEDBD92FFFEFFFFFEFFFFFFFEFFFFFFFEF9F3FEF9F3B481
        76FCB04CD39364D8C5B5FF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFEDBD92
        FFFFFFFCFEFBF8FBFBFAFAFAF8F8F8F8F0F0B48176EDBD92D8C5B5FF00FFFF00
        FF00FF00FFFF00FFFF00FFFF00FFFF00FFDCA887DCA887DCA887DCA887DCA887
        DCA887DCA887DCA887DCA887FF00FFFF00FFFF00FF00}
      Margin = 1
      ParentFont = False
      OnClick = btnGroupClick
    end
  end
  object Label17: TPanel [2]
    Left = 0
    Top = 0
    Width = 354
    Height = 14
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Requests'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      354
      14)
    object sbHideFilter: TSpeedButton
      Left = 298
      Top = 1
      Width = 63
      Height = 14
      Anchors = [akTop, akRight]
      Caption = 'Hide filters'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbHideFilterClick
    end
  end
  object grdOrder: TcxGrid [3]
    Left = 0
    Top = 82
    Width = 354
    Height = 171
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    LookAndFeel.Kind = lfFlat
    object grdOrderDB: TcxGridDBTableView
      DataController.DataSource = dsRequest
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModel;StoreID'
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnHand'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnOrder'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnPrePurchase'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnPreSale'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnRepair'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyFloating'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'MaxQty'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'MinQty'
        end>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
          SummaryItems = <>
        end>
      OnCellClick = grdOrderDBCellClick
      Filtering.CustomizeDialog = False
      Filtering.MaxDropDownCount = 1000
      OptionsBehavior.DragOpening = False
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideFocusRect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdOrderDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Options.Editing = False
        Options.Filtering = False
        Width = 133
      end
      object grdOrderDBStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
        Options.Filtering = False
        Width = 90
      end
      object grdOrderDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
      end
      object grdOrderDBDateRequest: TcxGridDBColumn
        Caption = 'Date'
        DataBinding.FieldName = 'DateRequest'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
        Width = 57
      end
      object grdOrderDBSystemUser: TcxGridDBColumn
        DataBinding.FieldName = 'SystemUser'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
      end
      object grdOrderDBABC: TcxGridDBColumn
        DataBinding.FieldName = 'ClasseABC'
        Options.Filtering = False
        Width = 33
      end
      object grdOrderDBQtyReq: TcxGridDBColumn
        Caption = 'Qty'
        DataBinding.FieldName = 'QtyReq'
        Options.Editing = False
        Options.Filtering = False
        Width = 35
      end
      object grdOrderDBQtyOrdered: TcxGridDBColumn
        Caption = 'Ordered'
        DataBinding.FieldName = 'QtyOrdered'
        Options.Editing = False
        Options.Filtering = False
        Width = 44
      end
      object grdOrderDBCategory: TcxGridDBColumn
        DataBinding.FieldName = 'Category'
        Visible = False
        GroupIndex = 0
        Options.Filtering = False
        SortOrder = soAscending
      end
      object grdOrderDBManufacture: TcxGridDBColumn
        DataBinding.FieldName = 'Manufacture'
        Visible = False
        Options.Filtering = False
      end
    end
    object grdOrderLevel: TcxGridLevel
      GridView = grdOrderDB
    end
  end
  object quRequest: TADOQuery [4]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Type'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
      #9'R.IDRequest,'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.ClasseABC,'
      #9'IsNull(M.Model, '#39'New Model'#39') as Model,'
      #9'IsNull(M.Description, R.Description) as Description,'
      #9'R.DateRequest,'
      #9'S.Name as Store,'
      #9'TG.Name as Category,'
      #9'R.QtyReq,'
      #9'IsNull(R.QtyOrdered, 0) as QtyOrdered,'
      #9'SU.[SystemUser],'
      #9'F.Pessoa as Manufacture'
      'FROM'
      #9'Request R (NOLOCK)'
      #9'LEFT OUTER JOIN Model M (NOLOCK) ON ( R.ModelID = M.IDModel )'
      #9'LEFT JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'
      #9'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'
      
        #9'LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.' +
        'IDModel)'
      
        #9'LEFT OUTER JOIN [SystemUser] SU (NOLOCK) ON (SU.IDUser = R.User' +
        'ID)'
      #9'JOIN Store S (NOLOCK) ON (R.StoreID = S.IDStore)'
      'WHERE'
      '        M.GroupID = IsNull(:IDGroup, M.GroupID)'
      '        AND'
      
        '        IsNull(M.IDFabricante,-1) = IsNull(:IDFabricante, IsNull' +
        '(M.IDFabricante,-1))'
      '        AND'
      
        '      '#9'R.Type = IsNull(:Type, R.Type) -- S'#243' filtra se o parametr' +
        'o nao for nulo'
      #9'AND'
      
        '      '#9'R.StoreID = IsNull(:IDStore, R.StoreID) -- S'#243' filtra se o' +
        ' parametro nao for nulo'
      #9'AND'
      
        '      '#9'IsNull(MV.IDPessoa,-1) = IsNull(:IDPessoa, IsNull(MV.IDPe' +
        'ssoa,-1)) -- S'#243' filtra se o parametro nao for nulo'
      #9'AND'
      '      '#9'R.QtyReq > IsNull(R.QtyOrdered, 0)'
      #9'AND'
      #9'R.IDPreInventoryMov is Null -- O Request ainda nao tem PO'
      'GROUP BY'
      #9'R.IDRequest,'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.ClasseABC,'
      #9'TG.Name,'
      #9'R.Description,'
      #9'R.DateRequest,'
      #9'R.QtyReq,'
      #9'R.QtyOrdered,'
      #9'SU.[SystemUser],'
      #9'F.Pessoa,'
      #9'S.Name')
    Left = 68
    Top = 200
    object quRequestIDRequest: TIntegerField
      FieldName = 'IDRequest'
    end
    object quRequestIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quRequestIDModelParent: TIntegerField
      FieldName = 'IDModelParent'
    end
    object quRequestModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quRequestDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quRequestDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      DisplayFormat = 'ddddd'
    end
    object quRequestSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quRequestQtyReq: TFloatField
      FieldName = 'QtyReq'
      DisplayFormat = '0.#####'
    end
    object quRequestQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
      DisplayFormat = '0.#####'
    end
    object quRequestCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quRequestClasseABC: TStringField
      DisplayLabel = 'ABC'
      FieldName = 'ClasseABC'
      FixedChar = True
      Size = 1
    end
    object quRequestManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
    object quRequestStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object quRequestNew: TADOQuery [5]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    Parameters = <
      item
        Name = 'Type'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '#9'R.IDRequest,'
      #9'Null as IDModel,'
      #9'0 as IDModelParent,'
      #9'Convert(VarChar(30), '#39'New Model'#39') as Model,'
      #9'Convert(VarChar(50), R.Description) as Description,'
      #9'R.DateRequest,'
      #9'R.QtyReq,'
      #9'R.QtyOrdered,'
      #9'SU.[SystemUser],'
      #9#39#39' as Manufacture,'
      #9#39#39' as Category,'
      #9#39#39' as Store,'
      #9#39#39' as ClasseABC'
      'FROM'
      #9'Request R (NOLOCK)'
      
        #9'LEFT OUTER JOIN [SystemUser] SU (NOLOCK) ON (SU.IDUser = R.User' +
        'ID)'
      'WHERE'
      '        R.ModelID IS NULL'
      '        AND'
      
        '      '#9'R.Type = IsNull(:Type, R.Type) -- S'#243' filtra se o parametr' +
        'o nao for nulo'
      #9'AND'
      
        '      '#9'R.StoreID = IsNull(:IDStore, R.StoreID) -- S'#243' filtra se o' +
        ' parametro nao for nulo'
      #9'AND'
      '      '#9'R.QtyReq > IsNull(R.QtyOrdered, 0)'
      #9'AND'
      #9'R.IDPreInventoryMov is Null -- O Request ainda nao tem PO'
      ''
      ' '
      ' '
      ' '
      ' '
      ' '
      ' '
      ' '
      ' '
      ' '
      ' '
      ' '
      ' ')
    Left = 148
    Top = 104
    object IntegerField1: TIntegerField
      FieldName = 'IDRequest'
    end
    object IntegerField2: TIntegerField
      FieldName = 'IDModel'
    end
    object quRequestNewIDModelParent: TIntegerField
      FieldName = 'IDModelParent'
      ReadOnly = True
    end
    object quRequestNewClasseABC: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      Size = 0
    end
    object StringField1: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object StringField2: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DateRequest'
      DisplayFormat = 'ddddd'
    end
    object quRequestNewStore: TStringField
      FieldName = 'Store'
      ReadOnly = True
      Size = 0
    end
    object quRequestNewCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 0
    end
    object quRequestNewQtyReq: TFloatField
      FieldName = 'QtyReq'
      DisplayFormat = '0.#####'
    end
    object quRequestNewQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
      DisplayFormat = '0.#####'
    end
    object StringField3: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quRequestNewManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 0
    end
  end
  object spRemoveRequest: TADOStoredProc [6]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    ProcedureName = 'sp_Request_Remove;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDRequest'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 148
    Top = 152
  end
  object dsRequest: TDataSource [7]
    DataSet = quRequest
    Left = 148
    Top = 200
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubRequest.sil'
  end
  object quMinQty: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '#9
      #9'0 as IDRequest,'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.ClasseABC,'
      #9'S.Name as Store,'
      #9'TG.Name as Category,'
      #9'MAX(INV.UltimaMovimentacao) as DateRequest,'
      
        #9'(SUM((IsNull(INV.MaxQty,0) - IsNull(INV.QtyOnHand,0))) - IsNull' +
        '(PO.QtyOnOrder,0))  as QtyReq,'
      #9'IsNull(PO.QtyOnOrder,0) as QtyOrdered,'
      #9#39'System'#39' as [SystemUser],'
      #9'F.Pessoa as Manufacture'
      'FROM'
      #9'Model M (NOLOCK)'
      #9'JOIN Inventory INV (NOLOCK) ON (INV.ModelID = M.IDModel)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = INV.StoreID)'
      #9'JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'
      #9'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'
      
        #9'LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.' +
        'IDModel)'
      #9'LEFT JOIN (SELECT'
      #9#9'PIM.ModelID,'
      #9#9'PIM.StoreID,'
      #9#9'SUM(PIM.Qty - QtyRealMov) as QtyOnOrder'
      #9'FROM '
      #9#9'PreInventoryMov PIM (NOLOCK)'
      #9#9'JOIN PO (NOLOCK) ON (PIM.DocumentID = PO.IDPO)'
      #9'WHERE'
      #9#9'PIM.InventMovTypeID = 2'
      #9#9'AND'
      #9#9'PO.Aberto = 1'
      #9'GROUP BY'
      #9#9'PIM.ModelID,'
      #9#9'PIM.StoreID'
      #9') PO ON (PO.ModelID = INV.ModelID AND PO.StoreID = INV.StoreID)'
      'WHERE'
      #9'INV.StoreID = IsNull(:IDStore, INV.StoreID)'
      #9'AND'
      #9'IsNull(INV.MinQty,0) > INV.QtyOnHand'
      #9'AND'
      #9'M.GroupID = IsNull(:IDGroup, M.GroupID)'
      #9'AND'
      
        '      '#9'IsNull(MV.IDPessoa,-1) = IsNull(:IDPessoa, IsNull(MV.IDPe' +
        'ssoa,-1))'
      #9'AND'
      
        #9'IsNull(M.IDFabricante,-1) = IsNull(:IDFabricante, IsNull(M.IDFa' +
        'bricante,-1))'
      #9'AND'
      #9'M.ModelType IN ('#39'R'#39','#39'S'#39')'
      'GROUP BY'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.ClasseABC,'
      #9'S.Name,'
      #9'TG.Name,'
      #9'PO.QtyOnOrder,'
      #9'F.Pessoa')
    Left = 68
    Top = 104
    object IntegerField4: TIntegerField
      FieldName = 'IDRequest'
    end
    object IntegerField5: TIntegerField
      FieldName = 'IDModel'
    end
    object quMinQtyIDModelParent: TIntegerField
      FieldName = 'IDModelParent'
    end
    object StringField4: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object StringField5: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DateRequest'
      DisplayFormat = 'ddddd'
    end
    object StringField6: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quMinQtyQtyReq: TFloatField
      FieldName = 'QtyReq'
      DisplayFormat = '0.#####'
    end
    object quMinQtyQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quMinQtyStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quMinQtyCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quMinQtyClasseABC: TStringField
      DisplayLabel = 'ABC'
      FieldName = 'ClasseABC'
      FixedChar = True
      Size = 1
    end
    object quMinQtyManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
  end
  object quMaxQty: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '#9
      #9'0 as IDRequest,'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.ClasseABC,'
      #9'S.Name as Store,'
      #9'TG.Name as Category,'
      #9'MAX(INV.UltimaMovimentacao) as DateRequest,'
      
        #9'(SUM((IsNull(INV.MaxQty,0) - IsNull(INV.QtyOnHand,0))) - IsNull' +
        '(PO.QtyOnOrder,0)) as QtyReq,'
      #9'IsNull(PO.QtyOnOrder,0) as QtyOrdered,'
      #9#39'System'#39' as [SystemUser],'
      #9'F.Pessoa as Manufacture'
      'FROM'
      #9'Model M (NOLOCK)'
      #9'JOIN Inventory INV (NOLOCK) ON (INV.ModelID = M.IDModel)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = INV.StoreID)'
      #9'JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'
      #9'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'
      
        #9'LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.' +
        'IDModel)'
      #9'LEFT JOIN (SELECT'
      #9#9'PIM.ModelID,'
      #9#9'PIM.StoreID,'
      #9#9'SUM(PIM.Qty - QtyRealMov) as QtyOnOrder'
      #9'FROM '
      #9#9'PreInventoryMov PIM (NOLOCK)'
      #9#9'JOIN PO (NOLOCK) ON (PIM.DocumentID = PO.IDPO)'
      #9'WHERE'
      #9#9'PIM.InventMovTypeID = 2'
      #9#9'AND'
      #9#9'PO.Aberto = 1'
      #9'GROUP BY'
      #9#9'PIM.ModelID,'
      #9#9'PIM.StoreID'
      #9') PO ON (PO.ModelID = INV.ModelID AND PO.StoreID = INV.StoreID)'
      'WHERE'
      '      '#9'INV.StoreID = IsNull(:IDStore, INV.StoreID)'
      #9'AND'
      '      '#9'IsNull(INV.MaxQty,0) > INV.QtyOnHand'
      #9'AND'
      
        '      '#9'IsNull(MV.IDPessoa,-1) = IsNull(:IDPessoa, IsNull(MV.IDPe' +
        'ssoa,-1))'
      #9'AND'
      #9'M.GroupID = IsNull(:IDGroup, M.GroupID)'
      #9'AND'
      
        #9'IsNull(M.IDFabricante,-1) = IsNull(:IDFabricante, IsNull(M.IDFa' +
        'bricante,-1))'
      #9'AND'
      #9'IsNull(INV.MaxQty,0) <> 0'
      #9'AND'
      #9'M.ModelType IN ('#39'R'#39','#39'S'#39')'
      'GROUP BY'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.ClasseABC,'
      #9'S.Name,'
      #9'TG.Name,'
      #9'PO.QtyOnOrder,'
      #9'F.Pessoa')
    Left = 68
    Top = 152
    object IntegerField8: TIntegerField
      FieldName = 'IDRequest'
    end
    object IntegerField9: TIntegerField
      FieldName = 'IDModel'
    end
    object quMaxQtyIDModelParent: TIntegerField
      FieldName = 'IDModelParent'
    end
    object StringField7: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object StringField8: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'DateRequest'
      DisplayFormat = 'ddddd'
    end
    object StringField9: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quMaxQtyQtyReq: TFloatField
      FieldName = 'QtyReq'
      DisplayFormat = '0.#####'
    end
    object quMaxQtyQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quMaxQtyStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quMaxQtyCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quMaxQtyClasseABC: TStringField
      DisplayLabel = 'ABC'
      FieldName = 'ClasseABC'
      FixedChar = True
      Size = 1
    end
    object quMaxQtyManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
  end
  object quEntity: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10'        P.IDPessoa IDFornecedor,'#13#10'        ' +
      'P.Pessoa,'#13#10'        P.Code,'#13#10'        P.UserCode'#13#10'FROM '#9#13#10#9'Pessoa ' +
      'P (NOLOCK)'#13#10#9'JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP' +
      '.IDTipoPessoa)'#13#10'WHERE '#9#13#10#9'TP.Path like :Path'#13#10#9'AND'#13#10#9'P.IDPessoa ' +
      '= IsNull(:IDPessoa, P.IDPessoa)'#13#10#9'AND'#13#10#9'P.Desativado = 0'#13#10#9'AND'#13#10 +
      #9'P.Hidden = 0'#13#10#9'AND'#13#10#9'P.System = 0'#13#10'ORDER BY '#13#10#9'P.Pessoa'#13#10
    Parameters = <
      item
        Name = 'Path'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 150
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
    Left = 16
    Top = 104
    object quEntityIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quEntityIDFornecedor: TIntegerField
      FieldName = 'IDFornecedor'
    end
    object quEntityPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quEntityCode: TIntegerField
      FieldName = 'Code'
    end
    object quEntityUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
  end
  object dsEntity: TDataSource
    DataSet = quEntity
    Left = 16
    Top = 152
  end
  object quLookUpGroup: TLookUpADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDGroup,'#13#10#9'Name,'#13#10#9'PathName,'#13#10#9'UserCode'#13#10'FROM'#13#10#9'TabGrou' +
      'p'#13#10'WHERE'#13#10#9'Desativado = 0'#13#10#9'AND'#13#10#9'Hidden = 0'#13#10#9'AND'#13#10#9'System = 0'#13 +
      #10'ORDER BY'#13#10#9'Name'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'PathName'
    CodeFieldSearch = False
    LookUpField = 'IDGroup'
    Left = 244
    Top = 104
    object quLookUpGroupIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quLookUpGroupName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quLookUpGroupPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object quLookUpGroupUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
  end
  object dsLookUpGroup: TDataSource
    DataSet = quLookUpGroup
    Left = 244
    Top = 152
  end
  object quAllInventory: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '#9
      #9'0 as IDRequest,'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.ClasseABC,'
      #9'M.Model,'
      #9'M.Description,'
      #9'CAST(NULL as DateTime) as DateRequest,'
      #9#39#39' Store,'
      #9'TG.Name Category,'
      #9'0 as QtyReq,'
      #9'0 as QtyOrdered,'
      #9#39'System'#39' SystemUser,'
      #9'F.Pessoa as Manufacture'
      'FROM'
      #9'Model M (NOLOCK)'
      #9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'
      
        #9'LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.' +
        'IDModel)'
      #9'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'
      'WHERE'
      #9'M.GroupID = IsNull(:IDGroup, M.GroupID)'
      
        #9'AND IsNull(M.IDFabricante,-1) = IsNull(:IDFabricante, IsNull(M.' +
        'IDFabricante, -1))'
      #9'AND M.ModelType IN ('#39'R'#39','#39'S'#39')'
      
        #9'AND IsNull(MV.IDPessoa, -1) = IsNull(:IDPessoa, IsNull(MV.IDPes' +
        'soa, -1))'
      'GROUP BY'
      #9'M.IDModel,'
      #9'M.IDModelParent,'
      #9'M.ClasseABC,'
      #9'M.Model,'
      #9'M.Description,'
      #9'TG.Name,'
      #9'F.Pessoa')
    Left = 244
    Top = 200
    object quAllInventoryIDRequest: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object quAllInventoryIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quAllInventoryIDModelParent: TIntegerField
      FieldName = 'IDModelParent'
    end
    object quAllInventoryClasseABC: TStringField
      FieldName = 'ClasseABC'
      FixedChar = True
      Size = 1
    end
    object quAllInventoryModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quAllInventoryDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quAllInventoryDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object quAllInventoryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quAllInventoryCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quAllInventoryQtyReq: TIntegerField
      FieldName = 'QtyReq'
      ReadOnly = True
    end
    object quAllInventoryQtyOrdered: TIntegerField
      FieldName = 'QtyOrdered'
      ReadOnly = True
    end
    object quAllInventorySystemUser: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 6
    end
    object quAllInventoryManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
  end
end
