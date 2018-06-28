inherited FrmSerialNumber: TFrmSerialNumber
  Left = 229
  Top = 74
  Width = 357
  Height = 368
  Caption = 'Serial Number'
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pgSerial: TPageControl [0]
    Left = 0
    Top = 0
    Width = 349
    Height = 235
    ActivePage = tsOnSale
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tsOnSale: TTabSheet
      Caption = 'S/N entry'
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 341
        Height = 204
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          341
          204)
        object Label1: TLabel
          Left = 30
          Top = 16
          Width = 26
          Height = 13
          Alignment = taRightJustify
          Caption = 'Serial'
        end
        object btnInvSerial: TSpeedButton
          Left = 255
          Top = 100
          Width = 71
          Height = 24
          Hint = 'Display inventory serial number'
          Caption = 'View'
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000130B0000130B00000000000000000000FF00FF7D8497
            747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF747DAE4985D6767DAC747DAEFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4B1F75BB9FD
            4589DF707CAF747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFA0A5FA55B5FC4588DE727CAF747DAEFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            A1AFFA57B6FC4689DE747DAE747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1A5FB57B1FC468AD59385A6FF
            00FFFF00FFCEA890CEA890CEA890CEA890FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFA5ADFA95BFE4A69E9EC86DA4E0A5A3EDD5ADF0E4C2F2E7C9EBD6
            BDDE8EBECEA890FE02FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEADA9E6
            C1A0FBF0C2FFFCD1FFFFD9FFFFE7FFFFF6F8F2EED4B6B5CEA890FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFDEB6ABFFEDBCFFEFBAFFFCD0FFFFDFFFFDF2FFFF
            FFFEFEFCEEE1D0D57FB6FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E9D2B4FF
            EABAFFE4B2FFFCD1FFFFDFFFFEF6FFFDFAFFFCF3FCF6D7CBA693FF00FFFF00FF
            FF00FFFF00FFFF00FFCEA890F2E1BCFFE4B2FFE4B2FFF8C9FFFFDAFFFEE6FFFD
            EAFFFEDFFFFDD3D1B7A5FF00FFFF00FFFF00FFFF00FFFF00FFCEA890F1DFBBFF
            F1C3FFE9B6FFECB9FFF9CBFFFDD4FFFDD5FFFDD3FFF6CAD0A993FF00FFFF00FF
            FF00FFFF00FFFF00FFCEA890E7CAB6FFF9E8FFF2DAFFE2BBFFEBB5FFF0BCFFF1
            BDFFF6C4F7E4BCCDA294FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA890F4
            E7E0FEFDFCFFEACBFFE4B3FBDCADFFE8B9FCEEBEDDAA94CEA890FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E8D2CAF9EED1FFF4C3FDF2C1F2E0
            B7DFAF9BCEA890FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFCEA890CCA590CEA890D1B09DD5B1A8CEA890FF00FFFF00FF}
          Margin = 5
          ParentShowHint = False
          ShowHint = True
          OnClick = btnInvSerialClick
        end
        object btAdd: TSpeedButton
          Left = 255
          Top = 40
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
          OnClick = btAddClick
        end
        object btRemove: TSpeedButton
          Left = 255
          Top = 70
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
          OnClick = btRemoveClick
        end
        object gridSerial: TSMDBGrid
          Left = 65
          Top = 38
          Width = 183
          Height = 114
          Anchors = [akLeft, akTop, akBottom]
          DataSource = dsSerial
          Options = [dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
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
          ColCount = 3
          RowCount = 1
          Columns = <
            item
              Expanded = False
              FieldName = 'InventoryMovID'
              Visible = False
              FooterType = ftCustom
            end
            item
              Expanded = False
              FieldName = 'SerialNumber'
              Width = 168
              Visible = True
              FooterType = ftCustom
            end>
        end
        object EditSerial: TEdit
          Left = 65
          Top = 11
          Width = 181
          Height = 21
          TabOrder = 1
          OnChange = EditSerialChange
        end
      end
    end
    object tsInventory: TTabSheet
      Caption = 'Inventory'
      ImageIndex = 1
      object grdSerial: TSMDBGrid
        Left = 0
        Top = 0
        Width = 341
        Height = 204
        Align = alClient
        DataSource = dsInvSerial
        Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
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
            FieldName = 'Name'
            Width = 170
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Serial'
            Width = 166
            Visible = True
            FooterType = ftCustom
          end>
      end
    end
    object tsTransfer: TTabSheet
      Caption = 'Transfer'
      ImageIndex = 2
      object Label4: TLabel
        Left = 10
        Top = 7
        Width = 156
        Height = 13
        Caption = 'Select serial number(s) to transfer'
      end
      object clbSerial: TCheckListBox
        Left = 0
        Top = 30
        Width = 341
        Height = 174
        OnClickCheck = clbSerialClickCheck
        Align = alBottom
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object pnlQty: TPanel [1]
    Left = 0
    Top = 235
    Width = 349
    Height = 67
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      349
      67)
    object Label3: TLabel
      Left = 48
      Top = 13
      Width = 114
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Serial numbers entered :'
    end
    object Label2: TLabel
      Left = 24
      Top = 40
      Width = 138
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Maximum Quantity of Serials :'
    end
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 349
      Height = 2
      Align = alTop
      Shape = bsTopLine
    end
    object editQty: TEdit
      Left = 172
      Top = 9
      Width = 81
      Height = 21
      Anchors = [akTop, akRight]
      Color = clSilver
      TabOrder = 0
    end
    object EditMaxQty: TEdit
      Left = 172
      Top = 37
      Width = 81
      Height = 21
      Anchors = [akTop, akRight]
      Color = clSilver
      TabOrder = 1
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 302
    Width = 349
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 349
      Height = 2
      Align = alTop
      Shape = bsTopLine
    end
    object Panel2: TPanel
      Left = 120
      Top = 2
      Width = 229
      Height = 37
      Hint = 'Panel2'
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object spHelp: TSpeedButton
        Tag = 5
        Left = 17
        Top = 5
        Width = 66
        Height = 31
        Caption = '&Help'
        Glyph.Data = {
          0E060000424D0E06000000000000360000002800000016000000160000000100
          180000000000D8050000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFADA6A5BDBABDCECBCECED3D6D6D7D6D6D7D6D6D3
          D6CECBCEC6C3C6ADAEADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
          FFFF00FFFF00FFFF00FFA5A29CC6C3C6D6D7DEDEDFE7D6D7D6D6CBC6D6BEB5D6
          BEB5D6C7C6D6D7D6DEDFE7D6DBDEC6C7C6ADA6A5FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FFFF00FFB5B2ADD6D7D6E7EBEFE7D7CED6A28CC67952BD6539
          BD5D31BD5929BD5D31BD6D4AC69684D6CBC6DEE3E7D6D7D6B5B6B5FF00FFFF00
          FFFF00FF0000FF00FFFF00FFB5B6B5DEDFDEF7F7F7E7C3ADD67D52CE6D39CE6D
          42CE6D42B57D63AD7963B55D31BD5929B55521BD6139CEA694E7E3E7DEDFDEC6
          BEBDFF00FFFF00FF0000FF00FFBDB2ADDEDFDEFFFFFFF7C3ADDE7D4AE78252E7
          8252DE794ACE9E84D6DBDEC6CFD6B58A73BD5D29BD6131BD5929B55529CE967B
          E7E3E7E7E3E7C6B6B5FF00FF0000FF00FFD6D3D6FFFFFFFFD7C6EF8652EF8A5A
          EF8A63E78A5AE77D52DEB6A5FFFFFFD6DFE7B58E7BC65D31C66131BD6131BD5D
          31B55529CEA694E7E7EFDEDFDEFF00FF0000CEC3C6F7F7F7FFFFF7F79A73EF8A
          5AEF9263EF8E63EF8A63E7865ADE865ACEA294BD9684C66D42C66539C66131BD
          6131BD6131BD5929BD6139DECFC6E7EBEFCEC7C60000DEDBDEFFFFFFFFD3BDF7
          8E5AF79263F79263EF8E63EF8A5AE78652DE926BD6AE9CC69684C6714AC66539
          C66539C66131BD6131BD6131BD5521CE9684E7E7E7DEDBDE0000EFEBEFFFFFFF
          FFAE8CF79263F79263F79263EF8E63EF8A5AE78252E7AE9CFFFFFFCED7DEBD7D
          63CE6531C66539C66131BD6131BD6131BD5929C6714ADEDFDEDEDFDE0000F7FB
          FFFFFFFFFFA273F7966BF79263F79263EF8E63EF8A5AE78252DEAA94FFFFFFD6
          D7D6BD8A73C66131C66539C66131BD6131BD6131BD5D31BD6131DECFCEDEE3E7
          0000FFFFFFFFFBF7FF9E73F7966BF79263F79263EF8E63EF8A5AE78252DE8E6B
          FFFBFFF7F7F7C6C3C6B58263C66131C66131C66131BD6131BD5D31BD6131D6C7
          BDDEE3E70000FFFFFFFFFBF7FFA27BFF966BF79263F79263EF8E63EF8A5AE782
          52DE794AD69E84F7F7F7F7F7FFCECFCEB5866BC65D31C66131BD6131BD5D31BD
          6131D6C7BDDEDFE70000FFFFFFFFFFFFFFAA84FF9A6BF7966BF79263EF8A5AE7
          8252E77D4ADE7D4AD66D42CE8663F7EBE7F7F7F7C6C7C6B56D4AC66131BD6131
          BD5D31BD6539DED3CED6D7DE0000F7F7FFFFFFFFFFC39CFF9A6BF7966BF79263
          E7A284E7B6A5D6A28CD67D52D6754ACE6531D69273FFFFFFD6DFDEB58A73BD59
          29BD6131BD5929C67952DEDFDECECFCE0000EFE7E7FFFFFFFFE3CEFF9E73FF9A
          6BFF9263E7BAA5FFFFFFD6DFE7C6927BD66D39CE6531CE8663EFF3F7D6DFE7AD
          8A7BBD5929BD6131BD5529CEA28CDEE3E7BDBABD0000D6CFCEFFFFFFFFFFFFFF
          BA94FF9E6BFF9A6BEFA284FFFBFFF7F3F7CEC7C6C69E8CC69684CEC3BDE7E7E7
          C6CBCEAD715AC65D29BD5929BD6D42DED7D6D6D7DEFF00FF0000FF00FFEFEFEF
          FFFFFFFFF3E7FFAA7BFF9E73FF9A6BE7BEADFFFFFFF7FBFFE7EBEFDEE7EFE7E7
          EFD6D7DEAD968CB55D31BD5D29BD5D29D6B6ADDEE3E7BDBEBDFF00FF0000FF00
          FFFF00FFFFFFFFFFFFFFFFEBDEFFAE84FFA273FF9A6BE7AE94E7D7D6DEDFDED6
          D3D6BDBAB5AD8A7BB56139BD5929BD5D31D6AE9CE7E7E7CECFCEFF00FFFF00FF
          0000FF00FFFF00FFD6D3D6FFFFFFFFFFFFFFF7EFFFC39CFFA273FF9263E7865A
          CE8263C67952BD6939C65929BD5D29C67952D6BEB5E7E7E7D6D3D6FF00FFFF00
          FFFF00FF0000FF00FFFF00FFFF00FFCECBCEFFFBFFFFFFFFFFFFFFFFEBDEFFC7
          ADF7A27BE78A63D67D52CE7D5ACE9273D6B6A5DEDBDEDEE3E7CECFCEFF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFDEDFDEF7F7F7FF
          FFFFFFFFFFFFF7F7EFEBE7E7E3DEE7DFDEDEE3E7DEDFE7D6D7D6BDBEBDFF00FF
          FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          BDB6B5CECBCED6D7D6D6DBDED6DBDED6D7D6CED3D6C6C7C6B5B6B5FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
        Margin = 5
        Visible = False
      end
      object Cancelar: TButton
        Left = 158
        Top = 5
        Width = 66
        Height = 31
        Hint = 'Cancel'
        Cancel = True
        Caption = '&Cancel'
        ModalResult = 2
        TabOrder = 0
        OnClick = CancelarClick
      end
      object Aplicar: TButton
        Left = 87
        Top = 5
        Width = 66
        Height = 31
        Hint = 'OK'
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        TabOrder = 1
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSerialNumber.sil'
  end
  object quSerialPreMov: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterPost = quSerialMovAfterPost
    AfterDelete = quSerialMovAfterPost
    OnNewRecord = quSerialPreMovNewRecord
    Parameters = <
      item
        Name = 'InventoryMovID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'PreInventoryMovID,'
      #9'SerialNumber'
      'FROM '
      #9'PreSerialMov'
      'WHERE '
      #9'( PreInventoryMovID = :InventoryMovID )'
      ' ')
    Left = 92
    Top = 295
    object quSerialPreMovPreInventoryMovID: TIntegerField
      FieldName = 'PreInventoryMovID'
    end
    object StringField1: TStringField
      FieldName = 'SerialNumber'
      Size = 30
    end
  end
  object quSerialMov: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterPost = quSerialMovAfterPost
    AfterDelete = quSerialMovAfterPost
    OnNewRecord = quSerialPreMovNewRecord
    Parameters = <
      item
        Name = 'InventoryMovID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'InventoryMovID,'
      #9'SerialNumber'
      'FROM '
      #9'SerialMov'
      'WHERE '
      #9'( InventoryMovID = :InventoryMovID )'
      ' ')
    Left = 17
    Top = 294
    object quSerialMovInventoryMovID: TIntegerField
      FieldName = 'InventoryMovID'
    end
    object quSerialMovSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 30
    end
  end
  object dsSerial: TDataSource
    OnDataChange = dsSerialDataChange
    Left = 15
    Top = 240
  end
  object quInventorySerial: TADOQuery
    Connection = DM.ADODBConnect
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
    SQL.Strings = (
      'SELECT'
      '        ST.Name,'
      '        Serial,'
      '        ISN.StoreID'
      'FROM'
      '        InventorySerial ISN'
      '        JOIN Store ST ON (ISN.StoreID = ST.IDStore)'
      'WHERE'
      '        ISN.ModelID = :IDModel'
      '        AND'
      '        ISN.StoreID = :IDStore'
      'ORDER BY'
      '        ST.Name'
      ' ')
    Left = 260
    Top = 235
    object quInventorySerialName: TStringField
      DisplayLabel = 'Store'
      FieldName = 'Name'
      Size = 30
    end
    object quInventorySerialSerial: TStringField
      DisplayLabel = 'Serial Number'
      FieldName = 'Serial'
    end
    object quInventorySerialStoreID: TIntegerField
      FieldName = 'StoreID'
    end
  end
  object dsInvSerial: TDataSource
    DataSet = quInventorySerial
    Left = 260
    Top = 280
  end
  object quSNPurchase: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterPost = quSNPurchaseAfterPost
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDPurchaseItemSerial,'
      #9'IDPurchaseItem,'
      #9'IDPurchase,'
      #9'SerialNumber'
      ''
      'FROM'
      #9'Pur_PurchaseItemSerial'
      'WHERE'
      #9'IDPurchaseItem = :IDPurchaseItem'
      '        AND'
      '        IDPurchase = :IDPurchase')
    Left = 92
    Top = 244
    object quSNPurchaseIDPurchaseItemSerial: TIntegerField
      FieldName = 'IDPurchaseItemSerial'
    end
    object quSNPurchaseIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object quSNPurchaseIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quSNPurchaseSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 30
    end
  end
  object quSNStoreOrigem: TADOQuery
    Connection = DM.ADODBConnect
    AfterOpen = quSNStoreOrigemAfterOpen
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
    SQL.Strings = (
      'SELECT'
      '        ISN.ModelID,'
      '        ISN.StoreID,'
      '        ISN.Serial'
      'FROM'
      '        InventorySerial ISN'
      'WHERE'
      '        ISN.ModelID = :IDModel'
      '        AND'
      '        ISN.StoreID = :IDStore'
      ' ')
    Left = 175
    Top = 240
    object quSNStoreOrigemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quSNStoreOrigemStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object quSNStoreOrigemSerial: TStringField
      FieldName = 'Serial'
    end
  end
end
