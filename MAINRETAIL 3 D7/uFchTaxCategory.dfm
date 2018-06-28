inherited FchTaxCategory: TFchTaxCategory
  Left = 274
  Top = 170
  Caption = 'FchTaxCategory'
  ClientHeight = 445
  ClientWidth = 477
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 477
    TabOrder = 3
    inherited Image1: TImage
      Width = 203
    end
    inherited lblMenu: TLabel
      Left = 482
    end
    inherited EspacamentoSuperior: TPanel
      Width = 477
      inherited EEE: TPanel
        Width = 477
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 430
    end
  end
  inherited Panel1: TPanel
    Top = 404
    Width = 477
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 477
      inherited Panel3: TPanel
        Width = 477
      end
    end
    inherited hhh: TPanel
      Left = 256
    end
  end
  inherited pnlKey: TPanel
    Width = 477
    Height = 21
    Visible = False
    inherited Panel4: TPanel
      Top = 19
      Width = 477
    end
  end
  inherited pnlDetail: TPanel
    Top = 61
    Width = 471
    Height = 343
    TabOrder = 1
    object pgTax: TPageControl
      Left = 0
      Top = 0
      Width = 471
      Height = 343
      ActivePage = tsSaleCharge
      Align = alClient
      TabOrder = 0
      TabStop = False
      object tsSaleCharge: TTabSheet
        Caption = 'Sale Charge'
        object Label2: TLabel
          Left = 31
          Top = 17
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax Category :'
          FocusControl = dbedtTaxCategoty
        end
        object Label3: TLabel
          Left = 80
          Top = 194
          Width = 25
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax :'
          FocusControl = dbedtTax
        end
        object Label20: TLabel
          Left = 395
          Top = 14
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 175
          Top = 191
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 46
          Top = 268
          Width = 59
          Height = 13
          Alignment = taRightJustify
          Caption = 'Special tax :'
          FocusControl = dbedtSpecialTax
        end
        object Label6: TLabel
          Left = 249
          Top = 237
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date end :'
          FocusControl = dbedtSpecialTax
        end
        object Label7: TLabel
          Left = 48
          Top = 238
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date start :'
          FocusControl = dbedtSpecialTax
        end
        object Bevel1: TBevel
          Left = 3
          Top = 219
          Width = 415
          Height = 3
          Shape = bsTopLine
        end
        object Label1: TLabel
          Left = 226
          Top = 270
          Width = 75
          Height = 13
          Alignment = taRightJustify
          Caption = 'MaxItemValue :'
          FocusControl = dbedtMaxValue
        end
        object btNew: TSpeedButton
          Left = 349
          Top = 47
          Width = 70
          Height = 25
          Caption = 'New'
          Enabled = False
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
          Margin = 3
          OnClick = btNewClick
        end
        object btDelete: TSpeedButton
          Tag = 2
          Left = 349
          Top = 72
          Width = 70
          Height = 25
          Caption = 'Remove'
          Enabled = False
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
          Margin = 3
          OnClick = btDeleteClick
        end
        object btPost: TSpeedButton
          Left = 349
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
        object btCancelPost: TSpeedButton
          Tag = 2
          Left = 349
          Top = 136
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
        object dbedtTaxCategoty: TDBEdit
          Left = 108
          Top = 13
          Width = 285
          Height = 21
          DataField = 'TaxCategory'
          DataSource = dsForm
          TabOrder = 0
        end
        object dbedtTax: TDBEdit
          Left = 108
          Top = 190
          Width = 64
          Height = 21
          Color = clSilver
          DataField = 'Tax'
          DataSource = dsForm
          ReadOnly = True
          TabOrder = 2
        end
        object dbedtSpecialTax: TDBEdit
          Left = 108
          Top = 264
          Width = 64
          Height = 21
          DataField = 'SpecialTax'
          DataSource = dsForm
          TabOrder = 6
        end
        object DBDateBox1: TDBDateBox
          Left = 305
          Top = 233
          Width = 113
          Height = 21
          ReadOnly = False
          TabOrder = 5
          Text = 'DBDateBox1'
          DataField = 'SpecialDateEnd'
          DataSource = dsForm
        end
        object DBDateBox2: TDBDateBox
          Left = 108
          Top = 234
          Width = 99
          Height = 21
          ReadOnly = False
          TabOrder = 4
          Text = 'DBDateBox2'
          DataField = 'SpecialDateStart'
          DataSource = dsForm
        end
        object DBCheckBox1: TDBCheckBox
          Left = 304
          Top = 192
          Width = 127
          Height = 17
          Caption = 'TaxExempt'
          DataField = 'TaxExempt'
          DataSource = dsForm
          TabOrder = 3
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          Visible = False
        end
        object dbedtMaxValue: TDBEdit
          Left = 306
          Top = 264
          Width = 69
          Height = 21
          DataField = 'MaxItemValue'
          DataSource = dsForm
          TabOrder = 7
        end
        object grdSubTax: TSMDBGrid
          Left = 108
          Top = 45
          Width = 236
          Height = 131
          DataSource = dsSubTax
          FixedColor = 14607076
          Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgConfirmDelete]
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
          GridStyle.EvenColor = clWindow
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
              FieldName = 'TaxCategory'
              Width = 160
              Visible = True
              FooterType = ftCustom
            end
            item
              Expanded = False
              FieldName = 'Tax'
              Width = 71
              Visible = True
              FooterType = ftCustom
            end>
        end
      end
      object tsSaleTax: TTabSheet
        Caption = 'Sale Tax'
        ImageIndex = 1
        object Label8: TLabel
          Left = 39
          Top = 34
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax Category :'
          FocusControl = DBEdit1
        end
        object Label9: TLabel
          Left = 403
          Top = 31
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 88
          Top = 69
          Width = 25
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax :'
          FocusControl = DBEdit2
        end
        object Label11: TLabel
          Left = 183
          Top = 66
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBEdit1: TDBEdit
          Left = 116
          Top = 30
          Width = 285
          Height = 21
          DataField = 'TaxCategory'
          DataSource = dsForm
          TabOrder = 0
        end
        object DBEdit2: TDBEdit
          Left = 116
          Top = 65
          Width = 64
          Height = 21
          DataField = 'Tax'
          DataSource = dsForm
          TabOrder = 1
        end
        object DBRadioGroup2: TDBRadioGroup
          Left = 116
          Top = 95
          Width = 285
          Height = 36
          Caption = ' Operation '
          Columns = 2
          DataField = 'Debit'
          DataSource = dsForm
          Items.Strings = (
            'Subtract'
            'Add')
          TabOrder = 2
          TabStop = True
          Values.Strings = (
            'True'
            'False')
        end
        object cbxSituacaoTrib: TcxDBImageComboBox
          Left = 116
          Top = 147
          Width = 177
          Height = 21
          DataBinding.DataSource = dsForm
          DataBinding.DataField = 'SituacaoTributaria'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ImageAlign = iaRight
          Properties.Items = <
            item
              Description = 'Nenhuma'
              Value = 0
            end
            item
              Description = 'Tribut'#225'vel'
              Value = 1
            end
            item
              Description = 'N'#227'o Tribut'#225'vel'
              Value = 2
            end
            item
              Description = 'Substitui'#231#227'o Tribut'#225'ria'
              Value = 3
            end
            item
              Description = 'Isento'
              Value = 4
            end
            item
              Description = 'ISS'
              Value = 5
            end>
          Style.BorderColor = clInactiveCaptionText
          Style.BorderStyle = ebsFlat
          Style.LookAndFeel.Kind = lfStandard
          Style.LookAndFeel.NativeStyle = False
          Style.Shadow = False
          Style.ButtonStyle = btsFlat
          Style.PopupBorderStyle = epbsSingle
          TabOrder = 3
        end
      end
      object tsPurchase: TTabSheet
        Caption = 'Purchase'
        ImageIndex = 2
        object Label13: TLabel
          Left = 43
          Top = 18
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax Category :'
          FocusControl = DBEdit3
        end
        object Label14: TLabel
          Left = 93
          Top = 48
          Width = 25
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax :'
          FocusControl = DBEdit4
        end
        object Label16: TLabel
          Left = 187
          Top = 46
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 18
          Top = 75
          Width = 99
          Height = 13
          Alignment = taRightJustify
          Caption = 'Acc. Payable Chart :'
          FocusControl = DBEdit4
        end
        object Label12: TLabel
          Left = 57
          Top = 102
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Formulates :'
        end
        object Label18: TLabel
          Left = 367
          Top = 14
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnShowFormula: TSpeedButton
          Left = 314
          Top = 101
          Width = 146
          Height = 16
          Caption = 'Show Formula'
          OnClick = btnShowFormulaClick
        end
        object btnTest: TSpeedButton
          Left = 414
          Top = 270
          Width = 45
          Height = 20
          Caption = 'Test'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          OnClick = btnTestClick
        end
        object btnAddTax: TSpeedButton
          Left = 435
          Top = 247
          Width = 24
          Height = 21
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Glyph.Data = {
            56010000424D56010000000000003600000028000000070000000C0000000100
            18000000000020010000C40E0000C40E000000000000000000008000FF8000FF
            8000FFFFFFFF8000FF8000FF8000FF0000008000FF8000FFFFFFFFFF0000FFFF
            FF8000FF8000FF0000008000FFFFFFFFFF0000FF0000FF0000FFFFFF8000FF00
            0000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF000000FFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFFFFFFF0000008000FF8000FFFFFFFFFF0000FFFF
            FF8000FF8000FF0000008000FF8000FFFFFFFFFF0000FFFFFF8000FF8000FF00
            00008000FF8000FFFFFFFFFF0000FFFFFF8000FF8000FF0000008000FF8000FF
            FFFFFFFF0000FFFFFF8000FF8000FF0000008000FF8000FFFFFFFFFF0000FFFF
            FF8000FF8000FF0000008000FF8000FFFFFFFFFF0000FFFFFF8000FF8000FF00
            00008000FF8000FFFFFFFFFFFFFFFFFFFF8000FF8000FF000000}
          ParentFont = False
          Visible = False
          OnClick = btnAddTaxClick
        end
        object Label19: TLabel
          Left = 369
          Top = 74
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBEdit3: TDBEdit
          Left = 121
          Top = 14
          Width = 243
          Height = 21
          DataField = 'TaxCategory'
          DataSource = dsForm
          TabOrder = 0
        end
        object DBEdit4: TDBEdit
          Left = 121
          Top = 44
          Width = 64
          Height = 21
          DataField = 'Tax'
          DataSource = dsForm
          TabOrder = 1
        end
        object DBSuperComboADO1: TDBSuperComboADO
          Left = 121
          Top = 72
          Width = 245
          Height = 21
          TabOrder = 2
          Text = 'DBSuperComboADO1'
          CodeLength = 80
          SpcWhereClause = 'Pagando = 1'
          LookUpSource = DM.dsLookUpLancamentoTipo
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          ShowEditCode = True
          IDLanguage = 0
          DataField = 'IDLancamentoTipo'
          DataSource = dsForm
        end
        object DBRadioGroup1: TDBRadioGroup
          Left = 121
          Top = 252
          Width = 191
          Height = 36
          Caption = ' Operation '
          Columns = 2
          DataField = 'Debit'
          DataSource = dsForm
          Items.Strings = (
            'Subtract'
            'Add')
          TabOrder = 4
          TabStop = True
          Values.Strings = (
            'True'
            'False')
        end
        object memFormula: TMemo
          Left = 121
          Top = 103
          Width = 189
          Height = 146
          Color = clSilver
          MaxLength = 255
          ReadOnly = True
          TabOrder = 3
          WordWrap = False
        end
        object pnlFormula: TPanel
          Left = 313
          Top = 118
          Width = 148
          Height = 130
          BevelOuter = bvNone
          TabOrder = 6
          Visible = False
          object btnMultiplay: TSpeedButton
            Left = 123
            Top = 4
            Width = 23
            Height = 20
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnDivide: TSpeedButton
            Left = 123
            Top = 25
            Width = 23
            Height = 20
            Caption = '/'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnSubtract: TSpeedButton
            Left = 123
            Top = 46
            Width = 23
            Height = 20
            Caption = '-'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnAdd: TSpeedButton
            Left = 123
            Top = 67
            Width = 23
            Height = 20
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnParent1: TSpeedButton
            Left = 54
            Top = 67
            Width = 23
            Height = 20
            Caption = '('
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnParent2: TSpeedButton
            Left = 100
            Top = 67
            Width = 23
            Height = 20
            Caption = ')'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnSpace: TSpeedButton
            Left = 77
            Top = 87
            Width = 69
            Height = 20
            Caption = 'Space'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnSpaceClick
          end
          object SpeedButton1: TSpeedButton
            Left = 54
            Top = 4
            Width = 23
            Height = 20
            Caption = '1'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton2: TSpeedButton
            Left = 77
            Top = 4
            Width = 23
            Height = 20
            Caption = '2'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton3: TSpeedButton
            Left = 100
            Top = 4
            Width = 23
            Height = 20
            Caption = '3'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton4: TSpeedButton
            Left = 54
            Top = 25
            Width = 23
            Height = 20
            Caption = '4'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton5: TSpeedButton
            Left = 77
            Top = 25
            Width = 23
            Height = 20
            Caption = '5'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton6: TSpeedButton
            Left = 100
            Top = 25
            Width = 23
            Height = 20
            Caption = '6'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton7: TSpeedButton
            Left = 54
            Top = 46
            Width = 23
            Height = 20
            Caption = '7'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton8: TSpeedButton
            Left = 77
            Top = 46
            Width = 23
            Height = 20
            Caption = '8'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton9: TSpeedButton
            Left = 100
            Top = 46
            Width = 23
            Height = 20
            Caption = '9'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton10: TSpeedButton
            Left = 77
            Top = 67
            Width = 23
            Height = 20
            Caption = '0'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object SpeedButton11: TSpeedButton
            Left = 54
            Top = 87
            Width = 23
            Height = 20
            Caption = '.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMultiplayClick
          end
          object btnPercent: TSpeedButton
            Left = 2
            Top = 87
            Width = 51
            Height = 20
            Caption = '(p)Tax'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnPercentClick
          end
          object btnFreight: TSpeedButton
            Left = 2
            Top = 25
            Width = 51
            Height = 20
            Caption = '(f)reight'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnFreightClick
          end
          object btnCost: TSpeedButton
            Left = 2
            Top = 4
            Width = 51
            Height = 20
            Caption = '(c)ost'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnCostClick
          end
          object btnOther: TSpeedButton
            Left = 2
            Top = 46
            Width = 51
            Height = 20
            Caption = '(o)ther'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnOtherClick
          end
          object btnClear: TSpeedButton
            Left = 97
            Top = 107
            Width = 49
            Height = 20
            Caption = 'Clear'
            OnClick = btnClearClick
          end
          object btnMVA: TSpeedButton
            Left = 2
            Top = 107
            Width = 51
            Height = 20
            Caption = '(m)va %'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnMVAClick
          end
          object btnDelete: TSpeedButton
            Left = 54
            Top = 107
            Width = 42
            Height = 20
            Caption = 'Del'
            OnClick = btnDeleteClick
          end
          object btnDiscount: TSpeedButton
            Left = 2
            Top = 66
            Width = 51
            Height = 20
            Caption = '(d)iscount'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnDiscountClick
          end
        end
        object scTaxPurc: TSuperComboADO
          Left = 315
          Top = 247
          Width = 119
          Height = 21
          TabOrder = 7
          Visible = False
          LookUpSource = DM.dsLookUpTaxCategPur
          DropDownRows = 5
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object chkExemptTax: TDBCheckBox
          Left = 122
          Top = 292
          Width = 189
          Height = 17
          Caption = 'Tax Exempt'
          DataField = 'TaxExempt'
          DataSource = dsForm
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 61
    Height = 343
  end
  inherited EspacamentoDireito: TPanel
    Left = 474
    Top = 61
    Height = 343
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchTaxCategory.sil'
  end
  inherited dsForm: TDataSource
    Left = 286
    Top = 11
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforeClose = quFormBeforeClose
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10'        IDTaxCategory,'#13#10'        IDTaxCategoryParent,'#13#10'  ' +
      '      SpecialDateStart,'#13#10'        SpecialDateEnd,'#13#10'        Tax,'#13#10 +
      '        SpecialTax,'#13#10'        TaxCategory,'#13#10'        System,'#13#10'    ' +
      '    Hidden,'#13#10'        Desativado,'#13#10'        TaxExempt,'#13#10'        Ma' +
      'xItemValue,'#13#10'        OperationType,'#13#10'        SaleTaxType,'#13#10'     ' +
      '   IDLancamentoTipo,'#13#10'        Formula,'#13#10'        Debit,'#13#10'        ' +
      'SituacaoTributaria'#13#10'FROM'#13#10'        TaxCategory'#13#10'WHERE'#13#10'        ID' +
      'TaxCategory = :IDTaxCategory'#13#10' '#13#10
    Parameters = <
      item
        Name = 'IDTaxCategory'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 290
    Top = 52
    object quFormIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quFormIDTaxCategoryParent: TIntegerField
      FieldName = 'IDTaxCategoryParent'
    end
    object quFormTaxCategory: TStringField
      DisplayLabel = 'Tax Category'
      FieldName = 'TaxCategory'
      Required = True
      Size = 50
    end
    object quFormTax: TFloatField
      FieldName = 'Tax'
      Required = True
      DisplayFormat = '0.0000 %'
    end
    object quFormSpecialDateStart: TDateTimeField
      FieldName = 'SpecialDateStart'
    end
    object quFormSpecialDateEnd: TDateTimeField
      FieldName = 'SpecialDateEnd'
    end
    object quFormSpecialTax: TFloatField
      FieldName = 'SpecialTax'
      DisplayFormat = '0.00 %'
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
    end
    object quFormHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object quFormDesativado: TBooleanField
      FieldName = 'Desativado'
    end
    object quFormTaxExempt: TBooleanField
      FieldName = 'TaxExempt'
    end
    object quFormMaxItemValue: TFloatField
      FieldName = 'MaxItemValue'
      DisplayFormat = '###,##0.00'
    end
    object quFormOperationType: TIntegerField
      FieldName = 'OperationType'
    end
    object quFormSaleTaxType: TIntegerField
      FieldName = 'SaleTaxType'
    end
    object quFormIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quFormFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
    object quFormDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quFormSituacaoTributaria: TIntegerField
      FieldName = 'SituacaoTributaria'
    end
  end
  object quSubTax: TADOQuery [9]
    Connection = DM.ADODBConnect
    CursorType = ctDynamic
    AfterEdit = quSubTaxAfterEdit
    AfterPost = quSubTaxAfterPost
    AfterDelete = quSubTaxAfterPost
    OnNewRecord = quSubTaxNewRecord
    OnPostError = quFormPostError
    Parameters = <
      item
        Name = 'IDTaxCategory'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'T.IDTaxCategory,'
      #9'T.IDTaxCategoryParent, '
      #9'T.TaxCategory, '
      #9'T.Tax '
      'FROM '
      #9'TaxCategory T (NOLOCK)'
      'WHERE'
      #9'T.IDTaxCategoryParent = :IDTaxCategory')
    Left = 209
    Top = 48
    object quSubTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quSubTaxIDTaxCategoryParent: TIntegerField
      FieldName = 'IDTaxCategoryParent'
    end
    object quSubTaxTaxCategory: TStringField
      DisplayLabel = 'Sub tax name'
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quSubTaxTax: TBCDField
      DisplayLabel = 'Tax %'
      FieldName = 'Tax'
      DisplayFormat = '0.0000'
      Precision = 19
    end
  end
  object dsSubTax: TDataSource [10]
    DataSet = quSubTax
    OnStateChange = dsSubTaxStateChange
    Left = 213
    Top = 1
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    AutoIncField = 'IDTaxCategory'
    RequiredFields.Strings = (
      'TaxCategory'
      'Tax')
    DependentTables.Strings = (
      'TaxCategory')
    DependentTableKeys.Strings = (
      'IDTaxCategoryParent')
    Left = 371
    Top = 44
  end
  object TestFormula: TCalcExpress
    Formula = '0'
    Left = 372
    Top = 120
  end
end
