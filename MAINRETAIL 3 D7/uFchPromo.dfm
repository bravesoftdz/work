inherited FchPromo: TFchPromo
  Left = 443
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = ''
  ClientHeight = 895
  ClientWidth = 1001
  Font.Height = -12
  OnKeyDown = nil
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel2: TPanel
    Width = 1001
    inherited Image1: TImage
      Width = 727
    end
    inherited lblMenu: TLabel
      Left = 740
    end
    inherited EspacamentoSuperior: TPanel
      Width = 1001
      inherited EEE: TPanel
        Width = 1001
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 954
    end
  end
  inherited Panel1: TPanel
    Top = 854
    Width = 1001
    inherited EspacamentoInferior: TPanel
      Width = 1001
      Height = 4
      inherited Panel3: TPanel
        Top = 2
        Width = 1001
      end
    end
    inherited hhh: TPanel
      Left = 780
      Top = 4
      Height = 37
      inherited btCancel: TButton
        ModalResult = 2
      end
    end
    inherited pnlNavigation: TPanel
      Top = 4
      Height = 37
    end
  end
  inherited pnlKey: TPanel
    Width = 1001
    Height = 0
    inherited Panel4: TPanel
      Top = -2
      Width = 1001
    end
  end
  inherited pnlDetail: TPanel
    Top = 40
    Width = 995
    Height = 814
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 995
      Height = 814
      Align = alClient
      TabOrder = 0
      object Splitter2: TSplitter
        Left = 619
        Top = 1
        Width = 2
        Height = 812
      end
      object Splitter3: TSplitter
        Left = 928
        Top = 1
        Width = 5
        Height = 812
      end
      object pnlDiscount: TPanel
        Left = 621
        Top = 1
        Width = 307
        Height = 812
        Align = alLeft
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 0
        object lblStartDate: TLabel
          Left = 33
          Top = 23
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Start Date :'
        end
        object lblEndDate: TLabel
          Left = 39
          Top = 56
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'End Date :'
        end
        object lblDayOfWeek: TLabel
          Left = 17
          Top = 87
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Day Of Week :'
        end
        object Label2: TLabel
          Left = 33
          Top = 212
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Start Hour :'
        end
        object Label4: TLabel
          Left = 39
          Top = 245
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'End Hour :'
        end
        object pnDiscount: TPanel
          Left = 0
          Top = 0
          Width = 307
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Time Restrictions'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object cbxDayOfWeek: TCheckListBox
          Left = 103
          Top = 88
          Width = 111
          Height = 107
          ItemHeight = 14
          Items.Strings = (
            'Sunday'
            'Monday'
            'Tuesday'
            'Wednesday'
            'Thursday'
            'Friday'
            'Saturday')
          TabOrder = 1
          OnExit = cbxDayOfWeekExit
        end
        object startHour: TDateTimePicker
          Left = 103
          Top = 207
          Width = 111
          Height = 22
          Date = 41843.715264386580000000
          Time = 41843.715264386580000000
          Kind = dtkTime
          TabOrder = 2
        end
        object endHour: TDateTimePicker
          Left = 103
          Top = 240
          Width = 111
          Height = 22
          Date = 41843.715264386580000000
          Time = 41843.715264386580000000
          Kind = dtkTime
          TabOrder = 3
        end
        object startDate: TDateBox
          Left = 103
          Top = 23
          Width = 113
          Height = 22
          TabOrder = 4
          InputTime = False
          Language = Portuguese
        end
        object endDate: TDateBox
          Left = 103
          Top = 52
          Width = 113
          Height = 22
          TabOrder = 5
          OnClick = endDateClick
          OnExit = endDateExit
          InputTime = False
          Language = Portuguese
        end
      end
      object pnlSchedule: TPanel
        Left = 933
        Top = 1
        Width = 61
        Height = 812
        Align = alClient
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 1
        Visible = False
        object pnSchedule: TPanel
          Left = 0
          Top = 0
          Width = 61
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Qualifiers'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object pnlDiscountAll: TPanel
          Left = 0
          Top = 756
          Width = 61
          Height = 56
          Align = alBottom
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 1
        end
        object firstTimeCustomer: TCheckBox
          Left = 20
          Top = 27
          Width = 156
          Height = 17
          Caption = 'First Time Customer Only'
          TabOrder = 2
          Visible = False
        end
        object maxUsesSelected: TCheckBox
          Left = 20
          Top = 52
          Width = 74
          Height = 17
          Caption = 'Max Uses'
          TabOrder = 3
          OnClick = maxUsesSelectedClick
        end
        object minimumSaleSubtotal: TCheckBox
          Left = 20
          Top = 135
          Width = 145
          Height = 17
          Caption = 'Minimum Sale Subtotal'
          TabOrder = 4
          Visible = False
        end
        object canBeCombinedDiscounts: TCheckBox
          Left = 20
          Top = 104
          Width = 220
          Height = 17
          Caption = 'May be Combined with other discounts'
          TabOrder = 5
        end
        object customerGroup: TCheckBox
          Left = 20
          Top = 238
          Width = 15
          Height = 17
          TabOrder = 6
          OnClick = customerGroupClick
        end
        object storeGroup: TCheckBox
          Left = 20
          Top = 342
          Width = 16
          Height = 17
          TabOrder = 7
          OnClick = storeGroupClick
        end
        object maxUses: TSpinEdit
          Left = 100
          Top = 48
          Width = 41
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object maxUsesPerCustomer: TCheckBox
          Left = 20
          Top = 78
          Width = 143
          Height = 17
          Caption = 'Max Uses Per Customer'
          TabOrder = 9
          OnClick = maxUsesPerCustomerClick
        end
        object maxUsesCustomer: TSpinEdit
          Left = 163
          Top = 75
          Width = 41
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object minimumSaleSubtotalValue: TcxCurrencyEdit
          Left = 165
          Top = 131
          Width = 130
          Height = 22
          Properties.DisplayFormat = '0.00;-0.00'
          Style.BorderStyle = ebs3D
          TabOrder = 11
          Visible = False
        end
        object minimumQualifiedItemsAmount: TCheckBox
          Left = 20
          Top = 165
          Width = 201
          Height = 17
          Caption = 'Minimum Qualified Items Amount'
          TabOrder = 12
          Visible = False
        end
        object minimumQualifiedItemsAmountValue: TcxCurrencyEdit
          Left = 222
          Top = 162
          Width = 116
          Height = 22
          Properties.DisplayFormat = '0.00;-0.00'
          Style.BorderStyle = ebs3D
          TabOrder = 13
          Visible = False
        end
        object customerGroupBox: TGroupBox
          Left = 47
          Top = 234
          Width = 296
          Height = 90
          Caption = ' Customer Group '
          TabOrder = 14
          object addGroupImage: TImage
            Left = 254
            Top = 15
            Width = 24
            Height = 24
            OnClick = addGroupImageClick
          end
          object deleteCustomerGroup: TImage
            Left = 254
            Top = 46
            Width = 24
            Height = 24
            OnClick = deleteCustomerGroupClick
          end
          object customerGroupList: TListBox
            Left = 10
            Top = 45
            Width = 231
            Height = 40
            ItemHeight = 14
            TabOrder = 0
          end
          object customGroupSelect: TComboBox
            Left = 11
            Top = 19
            Width = 230
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 1
            OnCloseUp = promoTypeCloseUp
          end
        end
        object storeGroupBox: TGroupBox
          Left = 45
          Top = 337
          Width = 296
          Height = 90
          Caption = ' Stores '
          TabOrder = 15
          object addStoreImage: TImage
            Left = 254
            Top = 17
            Width = 24
            Height = 24
            OnClick = addStoreImageClick
          end
          object deleteStore: TImage
            Left = 255
            Top = 46
            Width = 24
            Height = 24
            OnClick = deleteStoreClick
          end
          object storeList: TListBox
            Left = 10
            Top = 45
            Width = 231
            Height = 40
            ItemHeight = 14
            TabOrder = 0
          end
          object storeSelect: TComboBox
            Left = 11
            Top = 19
            Width = 230
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 1
            OnCloseUp = promoTypeCloseUp
          end
        end
      end
      object pnlPromo: TPanel
        Left = 1
        Top = 1
        Width = 618
        Height = 812
        Align = alLeft
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 2
        object pnPromo: TPanel
          Left = 0
          Top = 0
          Width = 618
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Promo'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 0
          Top = 16
          Width = 618
          Height = 112
          Align = alTop
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 1
          object lblPromo: TLabel
            Left = 20
            Top = 9
            Width = 78
            Height = 14
            Caption = 'Promo Name :'
          end
          object lblPromoType: TLabel
            Left = 20
            Top = 33
            Width = 75
            Height = 14
            Alignment = taRightJustify
            Caption = 'Promo Type :'
          end
          object Label35: TLabel
            Left = 302
            Top = 7
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
          object Label1: TLabel
            Left = 237
            Top = 32
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
            Left = 20
            Top = 60
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Amount Type :'
          end
          object Label6: TLabel
            Left = 238
            Top = 57
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
          object promoType: TComboBox
            Left = 105
            Top = 29
            Width = 131
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 0
            OnCloseUp = amountTypeCloseUp
            Items.Strings = (
              'Coupon'
              'Promo')
          end
          object amountType: TComboBox
            Left = 105
            Top = 56
            Width = 131
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 1
            OnCloseUp = amountTypeCloseUp
            Items.Strings = (
              'Amount Off Item'
              'Percent Off Item ')
          end
          object promoName: TEdit
            Left = 106
            Top = 4
            Width = 193
            Height = 22
            TabOrder = 2
          end
          object loyaltyCardRequired: TCheckBox
            Left = 20
            Top = 84
            Width = 141
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Loyalty Card Required'
            TabOrder = 3
            Visible = False
          end
          object chkBogo: TCheckBox
            Left = 263
            Top = 33
            Width = 57
            Height = 17
            Alignment = taLeftJustify
            Caption = 'BOGO'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = amountTypeCloseUp
          end
        end
        object panelGroupTag: TPanel
          Left = 0
          Top = 128
          Width = 618
          Height = 309
          Align = alTop
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 2
          object pgcTag: TPageControl
            Left = 0
            Top = 0
            Width = 618
            Height = 309
            ActivePage = tbsTag
            Align = alClient
            TabOrder = 0
            object tbsTag: TTabSheet
              Caption = 'Tags -> Models'
              object purchaseTagGroup: TGroupBox
                Left = 0
                Top = 0
                Width = 610
                Height = 280
                Align = alClient
                Color = 14607076
                ParentColor = False
                TabOrder = 0
                object addPurchaseTagImage: TImage
                  Left = 177
                  Top = 19
                  Width = 24
                  Height = 24
                  Cursor = crHandPoint
                  OnClick = addPurchaseTagImageClick
                end
                object deletePurchaseTag: TImage
                  Left = 205
                  Top = 19
                  Width = 24
                  Height = 24
                  Cursor = crHandPoint
                  OnClick = deletePurchaseTagClick
                end
                object purchaseTagSelect: TComboBox
                  Left = 11
                  Top = 19
                  Width = 165
                  Height = 22
                  Style = csDropDownList
                  ItemHeight = 14
                  TabOrder = 0
                end
                object purchaseTagList: TListBox
                  Left = 10
                  Top = 45
                  Width = 166
                  Height = 228
                  Hint = 'Double Click to see details about this tag.'
                  ItemHeight = 14
                  MultiSelect = True
                  TabOrder = 1
                  OnClick = purchaseTagListClick
                  OnDblClick = purchaseTagListDblClick
                end
                object cxGridModelsInTag: TcxGrid
                  Left = 178
                  Top = 45
                  Width = 433
                  Height = 230
                  TabOrder = 2
                  object cxGridModelsInTagDBTableView1: TcxGridDBTableView
                    DataController.DataSource = dsModelsInsideTag
                    DataController.Filter.Criteria = {FFFFFFFF0000000000}
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsData.Deleting = False
                    OptionsData.Editing = False
                    OptionsData.Inserting = False
                    OptionsView.GroupByBox = False
                    object cxGridModelsInTagDBTableView1DBColumn3: TcxGridDBColumn
                      Caption = 'Model'
                      DataBinding.FieldName = 'model'
                      Width = 69
                    end
                    object cxGridModelsInTagDBTableView1DBColumn4: TcxGridDBColumn
                      DataBinding.FieldName = 'Description'
                      SortOrder = soAscending
                      Width = 159
                    end
                  end
                  object cxGridModelsInTagLevel1: TcxGridLevel
                    GridView = cxGridModelsInTagDBTableView1
                  end
                end
              end
            end
            object tabSale: TTabSheet
              Caption = 'Sale'
              ImageIndex = 1
              TabVisible = False
              object salePriceSelected: TGroupBox
                Left = 0
                Top = 0
                Width = 610
                Height = 110
                Align = alTop
                TabOrder = 0
                Visible = False
                object salePriceInfo: TLabel
                  Left = 2
                  Top = 40
                  Width = 281
                  Height = 43
                  Align = alCustom
                  AutoSize = False
                  Caption = 
                    'This is the effective price the items will be sold for.  A disco' +
                    'unt will be calculated to make the post discount price this valu' +
                    'e.'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Visible = False
                  WordWrap = True
                end
                object saleprice: TcxCurrencyEdit
                  Left = 80
                  Top = 10
                  Width = 130
                  Height = 22
                  Properties.DisplayFormat = '0.00;-0.00'
                  Style.BorderStyle = ebs3D
                  TabOrder = 0
                end
              end
            end
            object tabAmount: TTabSheet
              Caption = 'Amount'
              ImageIndex = 2
              object rewardAmountSelected: TGroupBox
                Left = 0
                Top = 0
                Width = 610
                Height = 54
                Align = alTop
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                Visible = False
                object lbRewardAmountValue: TLabel
                  Left = 49
                  Top = 24
                  Width = 92
                  Height = 16
                  Alignment = taRightJustify
                  Caption = 'Reward Amount'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object rewardamount: TcxCurrencyEdit
                  Left = 193
                  Top = 18
                  Width = 130
                  Height = 22
                  Properties.DisplayFormat = '0.00;-0.00'
                  Style.BorderStyle = ebs3D
                  TabOrder = 0
                end
              end
            end
            object tabItem: TTabSheet
              Caption = 'Percent'
              ImageIndex = 3
              object rewardPercentSelected: TGroupBox
                Left = 0
                Top = 0
                Width = 610
                Height = 54
                Align = alTop
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                Visible = False
                object lbReward: TLabel
                  Left = 49
                  Top = 24
                  Width = 92
                  Height = 16
                  Alignment = taRightJustify
                  Caption = 'Reward Amount'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object lbPercent: TLabel
                  Left = 335
                  Top = 21
                  Width = 16
                  Height = 19
                  Caption = '%'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object rewardpercent: TcxCurrencyEdit
                  Left = 194
                  Top = 18
                  Width = 130
                  Height = 24
                  ParentFont = False
                  Properties.DisplayFormat = '0.00;-0.00'
                  Style.BorderStyle = ebs3D
                  Style.Font.Charset = ANSI_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -13
                  Style.Font.Name = 'Tahoma'
                  Style.Font.Style = []
                  TabOrder = 0
                end
              end
            end
            object tabCoupon: TTabSheet
              Caption = 'Coupon'
              ImageIndex = 4
              object couponGroup: TGroupBox
                Left = 0
                Top = 0
                Width = 610
                Height = 280
                Align = alClient
                Caption = ' Coupon  '
                TabOrder = 0
                object addCouponImage: TImage
                  Left = 345
                  Top = 20
                  Width = 25
                  Height = 24
                  Cursor = crHandPoint
                  OnClick = addCouponImageClick
                end
                object deleteCoupon: TImage
                  Left = 345
                  Top = 48
                  Width = 24
                  Height = 24
                  OnClick = deleteCouponClick
                end
                object couponList: TListBox
                  Left = 10
                  Top = 50
                  Width = 331
                  Height = 161
                  ItemHeight = 14
                  TabOrder = 0
                end
                object coupon: TEdit
                  Left = 10
                  Top = 21
                  Width = 331
                  Height = 22
                  TabOrder = 1
                end
                object chbWarning: TCheckBox
                  Left = 18
                  Top = 238
                  Width = 193
                  Height = 17
                  Alignment = taLeftJustify
                  Caption = 'The Cashier Should Warn'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 2
                  OnClick = amountTypeCloseUp
                end
              end
            end
          end
        end
        object pagePromo: TPageControl
          Left = 0
          Top = 437
          Width = 618
          Height = 487
          ActivePage = tabBOGO
          Align = alTop
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object tabBOGO: TTabSheet
            Caption = 'BOGO -> Get'
            ImageIndex = 3
            object rewardTagGroup: TGroupBox
              Left = 0
              Top = 0
              Width = 610
              Height = 456
              Align = alClient
              Color = 14607076
              ParentColor = False
              TabOrder = 0
              object quantitySelected: TGroupBox
                Left = 2
                Top = 18
                Width = 606
                Height = 57
                Align = alTop
                Caption = 'BOGO Quantity '
                Color = 14607076
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                TabOrder = 0
                object Label7: TLabel
                  Left = 10
                  Top = 24
                  Width = 24
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Buy:'
                end
                object Label8: TLabel
                  Left = 314
                  Top = 24
                  Width = 24
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Get:'
                end
                object minimumQuantity: TcxCurrencyEdit
                  Left = 45
                  Top = 19
                  Width = 107
                  Height = 22
                  Properties.DisplayFormat = '0.00;-0.00'
                  Style.BorderStyle = ebs3D
                  TabOrder = 0
                end
                object rewardQuantity: TcxCurrencyEdit
                  Left = 348
                  Top = 19
                  Width = 113
                  Height = 22
                  Properties.DisplayFormat = '0.00;-0.00'
                  Style.BorderStyle = ebs3D
                  TabOrder = 1
                  OnExit = rewardQuantityExit
                end
                object cmbAndOrGet: TComboBox
                  Left = 172
                  Top = 20
                  Width = 131
                  Height = 22
                  Style = csDropDownList
                  ItemHeight = 14
                  ItemIndex = 0
                  TabOrder = 2
                  Text = 'Buy X  And Get Y'
                  OnCloseUp = cmbAndOrGetCloseUp
                  Items.Strings = (
                    'Buy X  And Get Y'
                    'Buy X  OR Get Y')
                end
              end
              object pnlReward: TPanel
                Left = 2
                Top = 75
                Width = 606
                Height = 379
                Align = alClient
                TabOrder = 1
                object addRewardTagImage: TImage
                  Left = 177
                  Top = 18
                  Width = 24
                  Height = 24
                  OnClick = addRewardTagImageClick
                end
                object deleteRewardTag: TImage
                  Left = 205
                  Top = 18
                  Width = 24
                  Height = 24
                  OnClick = deleteRewardTagClick
                end
                object rewardTagSelect: TComboBox
                  Left = 11
                  Top = 18
                  Width = 165
                  Height = 24
                  Style = csDropDownList
                  ItemHeight = 16
                  TabOrder = 0
                end
                object rewardTagList: TListBox
                  Left = 10
                  Top = 44
                  Width = 166
                  Height = 226
                  Hint = 'Double Click to see detais about this rewards.'
                  ItemHeight = 16
                  TabOrder = 1
                  OnClick = rewardTagListClick
                end
                object cxGrid1: TcxGrid
                  Left = 180
                  Top = 44
                  Width = 420
                  Height = 227
                  TabOrder = 2
                  object cxGridDBTableView1: TcxGridDBTableView
                    DataController.DataSource = dsModelsInsideReward
                    DataController.Filter.Criteria = {FFFFFFFF0000000000}
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsData.Deleting = False
                    OptionsData.Editing = False
                    OptionsData.Inserting = False
                    OptionsView.GroupByBox = False
                    object cxGridDBColumn2: TcxGridDBColumn
                      Caption = 'Model'
                      DataBinding.FieldName = 'model'
                      Width = 72
                    end
                    object cxGridDBColumn3: TcxGridDBColumn
                      DataBinding.FieldName = 'Description'
                      SortOrder = soAscending
                      Width = 154
                    end
                  end
                  object cxGridLevel1: TcxGridLevel
                    GridView = cxGridDBTableView1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 40
    Height = 814
  end
  inherited EspacamentoDireito: TPanel
    Left = 998
    Top = 40
    Height = 814
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPromo.sil'
  end
  inherited dsForm: TDataSource
    Left = 1062
    Top = 360
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT '#13#10#9'IDPromo,'#13#10#9'Barcode,'#13#10#9'Promo,'#13#10#9'PromoType,'#13#10#9'QtyFrequen' +
      't,'#13#10#9'StartDate,'#13#10#9'EndDate,'#13#10#9'DaysOfWeek,'#13#10#9'DiscountType,'#13#10#9'Disco' +
      'untValue,'#13#10#9'QtyPromoItem,'#13#10#9'IDStore,'#13#10#9'FlatPromo'#13#10'FROM'#13#10#9'Sal_Pro' +
      'mo'#13#10'WHERE'#13#10#9'IDPromo = :IDPromo'
    Parameters = <
      item
        Name = 'IDPromo'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 1067
    Top = 417
    object quFormIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object quFormBarcode: TStringField
      FieldName = 'Barcode'
    end
    object quFormPromo: TStringField
      DisplayLabel = 'Promo Name'
      FieldName = 'Promo'
      Required = True
      Size = 35
    end
    object quFormPromoType: TIntegerField
      FieldName = 'PromoType'
      Required = True
    end
    object quFormQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
    object quFormStartDate: TDateTimeField
      FieldName = 'StartDate'
      Required = True
    end
    object quFormEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object quFormDaysOfWeek: TStringField
      FieldName = 'DaysOfWeek'
      Size = 14
    end
    object quFormDiscountType: TIntegerField
      FieldName = 'DiscountType'
      Required = True
    end
    object quFormDiscountValue: TFloatField
      FieldName = 'DiscountValue'
      Required = True
    end
    object quFormQtyPromoItem: TFloatField
      FieldName = 'QtyPromoItem'
    end
    object quFormIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quFormFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    ConfirmPost = False
    AutoIncField = 'IDPromo'
    RequiredFields.Strings = (
      'IDPromo'
      'Promo'
      'PromoType'
      'StartDate'
      'DiscountType'
      'DiscountValue')
    DependentTables.Strings = (
      'Sal_PromoItem'
      'Sal_PromoLoyaltyCustomer')
    DependentTableKeys.Strings = (
      'IDPromo'
      'IDPromo')
    Left = 904
    Top = 475
  end
  object dsModelsInsideTag: TDataSource
    Left = 283
    Top = 194
  end
  object dsModelsInsideReward: TDataSource
    Left = 283
    Top = 375
  end
end
