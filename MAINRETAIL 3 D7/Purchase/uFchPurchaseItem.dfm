inherited FchPurchaseItem: TFchPurchaseItem
  Left = 445
  Top = 73
  Caption = 'FchPurchaseItem'
  ClientHeight = 622
  ClientWidth = 660
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 660
    inherited Image1: TImage
      Width = 386
    end
    inherited lblMenu: TLabel
      Left = 598
    end
    inherited EspacamentoSuperior: TPanel
      Width = 660
      inherited EEE: TPanel
        Width = 660
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 613
    end
  end
  inherited Panel1: TPanel
    Top = 581
    Width = 660
    inherited EspacamentoInferior: TPanel
      Width = 660
      inherited Panel3: TPanel
        Width = 660
      end
    end
    inherited hhh: TPanel
      Left = 439
    end
  end
  inherited pnlKey: TPanel
    Width = 660
    Height = 6
    Visible = False
    inherited Panel4: TPanel
      Top = 4
      Width = 660
    end
  end
  inherited pnlDetail: TPanel
    Top = 46
    Width = 654
    Height = 0
    Visible = False
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 46
    Height = 0
  end
  inherited EspacamentoDireito: TPanel
    Left = 657
    Top = 46
    Height = 0
  end
  inherited pnlPPageControl: TPanel
    Top = 38
    Width = 660
    Height = 543
    inherited PPageControl: TPageControl
      Width = 660
      Height = 543
      ActivePage = tsItem
      inherited tsBrowse: TTabSheet
        TabVisible = False
        inherited Label1: TLabel
          Width = 652
        end
        inherited pnlComand: TPanel
          Left = 545
          Height = 494
        end
        inherited pnlsdjhfksdhfjksdhf: TPanel
          Width = 652
        end
        inherited grdBrowse: TcxGrid
          Width = 545
          Height = 494
          inherited grdBrowseDB: TcxGridDBTableView
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
          end
        end
      end
      object tsItem: TTabSheet
        Caption = 'Purchased Item'
        ImageIndex = 1
        object Label10: TLabel
          Left = 0
          Top = 0
          Width = 652
          Height = 17
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Purchased Item'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Panel5: TPanel
          Left = 5
          Top = 398
          Width = 644
          Height = 116
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 3
          TabStop = True
          object Label9: TLabel
            Left = 0
            Top = 0
            Width = 644
            Height = 17
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Purchase History'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
          end
          object grdHistory: TSMDBGrid
            Left = 0
            Top = 17
            Width = 644
            Height = 99
            TabStop = False
            Align = alClient
            BorderStyle = bsNone
            Color = 14607076
            DataSource = dsHistory
            Options = [dgTitles, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Flat = True
            Groupings = <>
            GridStyle.Style = gsCustom
            GridStyle.OddColor = 14607076
            GridStyle.EvenColor = 14607076
            FooterColor = clBtnFace
            ExOptions = [eoAutoWidth, eoKeepSelection]
            RegistryKey = 'Software\Scalabium'
            RegistrySection = 'SMDBGrid'
            WidthOfIndicator = 11
            DefaultRowHeight = 17
            ScrollBars = ssVertical
            RowCount = 2
            Columns = <
              item
                Expanded = False
                FieldName = 'MovDate'
                Width = 92
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Vendor'
                Width = 301
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'CostPrice'
                Width = 84
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Freight'
                Width = 77
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'OtherCost'
                Width = 88
                Visible = True
                FooterType = ftCustom
              end>
          end
        end
        object pgPrices: TPageControl
          Left = 4
          Top = 146
          Width = 646
          Height = 251
          ActivePage = tsQty
          TabOrder = 2
          OnChange = pgPricesChange
          object tsQty: TTabSheet
            Caption = 'New Prices'
            object Label2: TLabel
              Left = 2
              Top = 0
              Width = 227
              Height = 17
              Alignment = taCenter
              AutoSize = False
              Caption = 'Purchase Info'
              Color = clBtnShadow
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Layout = tlCenter
            end
            object pnlPurchaseItem: TPanel
              Left = 2
              Top = 16
              Width = 227
              Height = 206
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 2
              object pnlCaseQty: TPanel
                Left = 0
                Top = 192
                Width = 227
                Height = 163
                Align = alTop
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 2
                object lbCCaseQty: TLabel
                  Left = 45
                  Top = 58
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Case Qty :'
                  FocusControl = DBEdit24
                end
                object lbCUnitCost: TLabel
                  Left = 46
                  Top = 83
                  Width = 51
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Unit Cost :'
                  FocusControl = DBEdit25
                end
                object lbCNewPrice: TLabel
                  Left = 22
                  Top = 109
                  Width = 75
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New Our Price :'
                  FocusControl = DBEdit26
                end
                object lbCNewMSRP: TLabel
                  Left = 39
                  Top = 133
                  Width = 58
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New MSRP :'
                  FocusControl = DBEdit27
                end
                object Label39: TLabel
                  Left = 165
                  Top = 107
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
                object Label40: TLabel
                  Left = 165
                  Top = 131
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
                object lbCCaseCost: TLabel
                  Left = 41
                  Top = 33
                  Width = 56
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Case Cost :'
                  FocusControl = DBEdit28
                end
                object Label42: TLabel
                  Left = 165
                  Top = 31
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
                object lbCQty: TLabel
                  Left = 72
                  Top = 8
                  Width = 25
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Qty :'
                  FocusControl = edtCaseQtyUS
                end
                object Label44: TLabel
                  Left = 165
                  Top = 6
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
                object DBEdit24: TDBEdit
                  Left = 99
                  Top = 55
                  Width = 64
                  Height = 21
                  TabStop = False
                  Color = clSilver
                  DataField = 'Qty'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 2
                end
                object DBEdit25: TDBEdit
                  Left = 99
                  Top = 80
                  Width = 64
                  Height = 21
                  TabStop = False
                  Color = clSilver
                  DataField = 'NewCostPrice'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 3
                  OnExit = DBEdit3Exit
                end
                object DBEdit26: TDBEdit
                  Left = 99
                  Top = 105
                  Width = 64
                  Height = 21
                  DataField = 'NewSalePrice'
                  DataSource = dsForm
                  TabOrder = 4
                  OnKeyPress = edtFreightPerKeyPress
                end
                object DBEdit27: TDBEdit
                  Left = 99
                  Top = 130
                  Width = 64
                  Height = 21
                  DataField = 'NewSuggRetail'
                  DataSource = dsForm
                  TabOrder = 5
                  OnKeyPress = edtFreightPerKeyPress
                end
                object DBEdit28: TDBEdit
                  Left = 99
                  Top = 30
                  Width = 64
                  Height = 21
                  DataField = 'CaseCost'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                  OnExit = DBEdit28Exit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtCaseQtyUS: TDBEdit
                  Left = 99
                  Top = 5
                  Width = 64
                  Height = 21
                  DataField = 'CaseQty'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  OnExit = edtCaseQtyUSExit
                end
              end
              object pnlQtyType: TPanel
                Left = 0
                Top = 0
                Width = 227
                Height = 26
                Align = alTop
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 0
                Visible = False
                object lblQtyType: TLabel
                  Left = 65
                  Top = 6
                  Width = 31
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Type :'
                end
                object cbxQtyType: TComboBox
                  Left = 99
                  Top = 2
                  Width = 82
                  Height = 22
                  Style = csOwnerDrawFixed
                  ItemHeight = 16
                  TabOrder = 0
                  OnSelect = cbxQtyTypeSelect
                  Items.Strings = (
                    'Case'
                    'Unit')
                end
              end
              object pnlQty: TPanel
                Left = 0
                Top = 26
                Width = 227
                Height = 166
                Align = alTop
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 1
                object Label4: TLabel
                  Left = 72
                  Top = 16
                  Width = 25
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Qty :'
                  FocusControl = edtQty
                end
                object Label5: TLabel
                  Left = 7
                  Top = 53
                  Width = 90
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New Vendor Cost :'
                  FocusControl = DBEdit3
                end
                object Label6: TLabel
                  Left = 22
                  Top = 90
                  Width = 75
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New Our Price :'
                  FocusControl = DBEdit4
                end
                object Label7: TLabel
                  Left = 39
                  Top = 129
                  Width = 58
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New MSRP :'
                  FocusControl = DBEdit5
                end
                object Label11: TLabel
                  Left = 165
                  Top = 14
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
                object Label12: TLabel
                  Left = 165
                  Top = 51
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
                object Label13: TLabel
                  Left = 165
                  Top = 88
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
                object Label14: TLabel
                  Left = 165
                  Top = 124
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
                object edtQty: TDBEdit
                  Left = 99
                  Top = 13
                  Width = 64
                  Height = 21
                  DataField = 'Qty'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object DBEdit3: TDBEdit
                  Left = 99
                  Top = 50
                  Width = 64
                  Height = 21
                  DataField = 'NewCostPrice'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                  OnExit = DBEdit3Exit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object DBEdit4: TDBEdit
                  Left = 99
                  Top = 86
                  Width = 64
                  Height = 21
                  DataField = 'NewSalePrice'
                  DataSource = dsForm
                  TabOrder = 2
                  OnKeyPress = edtFreightPerKeyPress
                end
                object DBEdit5: TDBEdit
                  Left = 99
                  Top = 124
                  Width = 64
                  Height = 21
                  DataField = 'NewSuggRetail'
                  DataSource = dsForm
                  TabOrder = 3
                  OnKeyPress = edtFreightPerKeyPress
                end
              end
            end
            object pnlPOItem: TPanel
              Left = 238
              Top = 1
              Width = 214
              Height = 221
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label8: TLabel
                Left = 0
                Top = 0
                Width = 214
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'PO Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object Label16: TLabel
                Left = 45
                Top = 21
                Width = 25
                Height = 13
                Alignment = taRightJustify
                Caption = 'Qty :'
              end
              object Label17: TLabel
                Left = 4
                Top = 60
                Width = 66
                Height = 13
                Alignment = taRightJustify
                Caption = 'Vendor Cost :'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBtnShadow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label18: TLabel
                Left = 19
                Top = 103
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Our Price :'
              end
              object Label19: TLabel
                Left = 36
                Top = 146
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'MSRP :'
              end
              object Label29: TLabel
                Left = 38
                Top = 192
                Width = 32
                Height = 13
                Alignment = taRightJustify
                Caption = 'PO # :'
              end
              object DBEdit6: TDBText
                Tag = 4
                Left = 72
                Top = 22
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'Qty'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBEdit7: TDBText
                Tag = 4
                Left = 72
                Top = 60
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'CostPrice'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBEdit8: TDBText
                Tag = 4
                Left = 72
                Top = 103
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'SalePrice'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit9: TDBText
                Tag = 4
                Left = 72
                Top = 146
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'SuggRetail'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBText1: TDBText
                Tag = 4
                Left = 72
                Top = 192
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'IDPO'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object pnlNavigatorPo: TPanel
                Left = 0
                Top = 0
                Width = 35
                Height = 17
                Ctl3D = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clBtnShadow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                Visible = False
                object sbPrior: TSpeedButton
                  Left = 0
                  Top = 0
                  Width = 17
                  Height = 17
                  Hint = 'Prior'
                  Flat = True
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlue
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  Glyph.Data = {
                    DE000000424DDE000000000000007600000028000000100000000D0000000100
                    04000000000068000000C40E0000C40E00001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                    888888888888880888888888888880088888888888880C08888888888880C408
                    88888888880C4C088888888880C4C40888888888880C4C08888888888880C408
                    8888888888880C08888888888888800888888888888888088888888888888888
                    8888}
                  ParentFont = False
                  OnClick = sbPriorClick
                end
                object sbNext: TSpeedButton
                  Left = 17
                  Top = 0
                  Width = 17
                  Height = 17
                  Hint = 'Next'
                  Flat = True
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlue
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  Glyph.Data = {
                    DE000000424DDE000000000000007600000028000000100000000D0000000100
                    04000000000068000000C40E0000C40E00001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                    888888888088888888888888800888888888888880C0888888888888804C0888
                    8888888880C4C08888888888804C4C088888888880C4C08888888888804C0888
                    8888888880C08888888888888008888888888888808888888888888888888888
                    8888}
                  ParentFont = False
                  OnClick = sbNextClick
                end
              end
            end
            object Panel7: TPanel
              Left = 456
              Top = 1
              Width = 179
              Height = 221
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object Label24: TLabel
                Left = 0
                Top = 0
                Width = 179
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Inventory Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object Label25: TLabel
                Left = 4
                Top = 22
                Width = 64
                Height = 13
                Alignment = taRightJustify
                Caption = 'QtyOnHand :'
              end
              object Label26: TLabel
                Left = 2
                Top = 63
                Width = 66
                Height = 13
                Alignment = taRightJustify
                Caption = 'Vendor Cost :'
              end
              object Label27: TLabel
                Left = 17
                Top = 104
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Our Price :'
              end
              object Label28: TLabel
                Left = 34
                Top = 148
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'MSRP :'
              end
              object DBText2: TDBText
                Tag = 4
                Left = 3
                Top = 201
                Width = 173
                Height = 15
                DataField = 'Category'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit13: TDBText
                Tag = 4
                Left = 68
                Top = 148
                Width = 60
                Height = 15
                Alignment = taRightJustify
                DataField = 'SuggRetail'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit12: TDBText
                Tag = 4
                Left = 68
                Top = 104
                Width = 60
                Height = 15
                Alignment = taRightJustify
                DataField = 'SellingPrice'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBEdit11: TDBText
                Tag = 4
                Left = 68
                Top = 63
                Width = 60
                Height = 14
                Alignment = taRightJustify
                DataField = 'VendorCost'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBEdit10: TDBText
                Tag = 4
                Left = 68
                Top = 22
                Width = 60
                Height = 18
                Alignment = taRightJustify
                DataField = 'TotQtyOnHand'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
          end
          object tsCostTaxes: TTabSheet
            Caption = 'Cost Taxes'
            ImageIndex = 1
            object lbQtyPrice: TLabel
              Left = 0
              Top = 0
              Width = 206
              Height = 17
              Alignment = taCenter
              AutoSize = False
              Caption = 'Qty and Price'
              Color = clBtnShadow
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Layout = tlCenter
            end
            object pnlItemTax: TPanel
              Left = 0
              Top = 17
              Width = 206
              Height = 205
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object pnlCastTypeTax: TPanel
                Left = 0
                Top = 0
                Width = 206
                Height = 26
                Align = alTop
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 0
                Visible = False
                object lblTQtyType: TLabel
                  Left = 45
                  Top = 6
                  Width = 31
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Type :'
                end
                object cbxTypeCostTax: TComboBox
                  Left = 79
                  Top = 2
                  Width = 108
                  Height = 22
                  Style = csOwnerDrawFixed
                  ItemHeight = 16
                  TabOrder = 0
                  OnSelect = cbxQtyTypeSelect
                  Items.Strings = (
                    'Case'
                    'Unit')
                end
              end
              object pnlQtyCostTax: TPanel
                Left = 0
                Top = 26
                Width = 206
                Height = 161
                Align = alTop
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 1
                object lbOther: TLabel
                  Left = 16
                  Top = 120
                  Width = 60
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Other Cost :'
                  FocusControl = edtOther
                end
                object lbFreight: TLabel
                  Left = 8
                  Top = 97
                  Width = 68
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Total Freight :'
                  FocusControl = edtFreight
                end
                object lbCost: TLabel
                  Left = 20
                  Top = 32
                  Width = 56
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Total Cost :'
                  FocusControl = edtCostTotalCost
                end
                object Label53: TLabel
                  Left = 188
                  Top = 30
                  Width = 14
                  Height = 15
                  Hint = 'Field can not be empty'
                  AutoSize = False
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
                object Label35: TLabel
                  Left = 188
                  Top = 8
                  Width = 14
                  Height = 17
                  Hint = 'Field can not be empty'
                  AutoSize = False
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
                object lbQty: TLabel
                  Left = 52
                  Top = 8
                  Width = 25
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Qty :'
                  FocusControl = edtCostQty
                end
                object lbUnitCost: TLabel
                  Left = 25
                  Top = 56
                  Width = 51
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Unit Cost :'
                end
                object lbItemDiscount: TLabel
                  Left = 28
                  Top = 142
                  Width = 48
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Discount :'
                  FocusControl = edtDiscount
                end
                object edtOther: TDBEdit
                  Left = 79
                  Top = 116
                  Width = 108
                  Height = 21
                  DataField = 'OtherCost'
                  DataSource = dsForm
                  TabOrder = 7
                  OnExit = edtOtherExit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtFreight: TDBEdit
                  Left = 79
                  Top = 93
                  Width = 108
                  Height = 21
                  DataField = 'FreightCost'
                  DataSource = dsForm
                  TabOrder = 5
                  OnExit = edtFreightExit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtCostTotalCost: TDBEdit
                  Left = 79
                  Top = 29
                  Width = 108
                  Height = 21
                  DataField = 'CostPrice'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                  OnExit = edtCostTotalCostExit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtCostQty: TDBEdit
                  Left = 79
                  Top = 5
                  Width = 108
                  Height = 21
                  DataField = 'Qty'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                end
                object cbxDisplayPercent: TCheckBox
                  Left = 79
                  Top = 73
                  Width = 97
                  Height = 17
                  Caption = 'Display Percent'
                  TabOrder = 3
                  OnClick = cbxDisplayPercentClick
                end
                object edtFreightPer: TEdit
                  Left = 79
                  Top = 93
                  Width = 45
                  Height = 21
                  TabOrder = 4
                  Visible = False
                  OnExit = edtFreightPerExit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtOtherPerc: TEdit
                  Left = 79
                  Top = 116
                  Width = 45
                  Height = 21
                  TabOrder = 6
                  Visible = False
                  OnExit = edtOtherPercExit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtUnitCost: TSuperEdit
                  Left = 79
                  Top = 52
                  Width = 108
                  Height = 21
                  TabStop = False
                  Color = clSilver
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 2
                  Alignment = taRightJustify
                end
                object edtDiscount: TDBEdit
                  Left = 79
                  Top = 139
                  Width = 108
                  Height = 21
                  DataField = 'Discount'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 8
                  OnExit = edtCostTotalCostExit
                  OnKeyPress = edtFreightPerKeyPress
                end
              end
              object pnlCaseQtyCostTax: TPanel
                Left = 0
                Top = 187
                Width = 206
                Height = 165
                Align = alTop
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 2
                object lbTCaseQty: TLabel
                  Left = 25
                  Top = 87
                  Width = 52
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Case Qty :'
                  FocusControl = DBEdit30
                end
                object lbTCaseCost: TLabel
                  Left = 21
                  Top = 51
                  Width = 56
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Case Cost :'
                  FocusControl = edtCaseCost
                end
                object Label46: TLabel
                  Left = 190
                  Top = 49
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
                object lbTQty: TLabel
                  Left = 52
                  Top = 14
                  Width = 25
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Qty :'
                  FocusControl = edtCaseQty
                end
                object Label48: TLabel
                  Left = 190
                  Top = 12
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
                object lbUnitCost1: TLabel
                  Left = 25
                  Top = 122
                  Width = 51
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'Unit Cost :'
                end
                object DBEdit30: TDBEdit
                  Left = 79
                  Top = 84
                  Width = 107
                  Height = 21
                  TabStop = False
                  Color = clSilver
                  DataField = 'Qty'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 2
                end
                object edtCaseCost: TDBEdit
                  Left = 79
                  Top = 48
                  Width = 107
                  Height = 21
                  DataField = 'CaseCost'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 1
                  OnExit = edtCaseCostExit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object edtCaseQty: TDBEdit
                  Left = 79
                  Top = 11
                  Width = 107
                  Height = 21
                  DataField = 'CaseQty'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 0
                  OnExit = edtCaseQtyUSExit
                end
                object edtUnitCost1: TSuperEdit
                  Left = 79
                  Top = 119
                  Width = 107
                  Height = 21
                  TabStop = False
                  Color = clSilver
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 3
                  Alignment = taRightJustify
                end
              end
            end
            object Panel12: TPanel
              Left = 448
              Top = 0
              Width = 184
              Height = 221
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              object lbFinalPrices: TLabel
                Left = 0
                Top = 0
                Width = 184
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Final Prices'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object lbNewCost: TLabel
                Left = 39
                Top = 70
                Width = 53
                Height = 13
                Alignment = taRightJustify
                Caption = 'New Cost :'
                FocusControl = DBEdit2
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label54: TLabel
                Left = 162
                Top = 67
                Width = 14
                Height = 17
                Hint = 'Field can not be empty'
                AutoSize = False
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
              object btnReturnItem: TSpeedButton
                Left = 44
                Top = 180
                Width = 122
                Height = 22
                Caption = 'Return item ?'
                Enabled = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                OnClick = btnReturnItemClick
              end
              object DBEdit2: TDBEdit
                Left = 95
                Top = 66
                Width = 64
                Height = 21
                DataField = 'NewCostPrice'
                DataSource = dsForm
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnExit = DBEdit2Exit
                OnKeyPress = edtFreightPerKeyPress
              end
              object btnCalcNewCost: TBitBtn
                Left = 19
                Top = 31
                Width = 157
                Height = 20
                Caption = 'Update New Cost'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                OnClick = btnCalcNewCostClick
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
              end
              object pnlMarginSale: TPanel
                Left = 0
                Top = 98
                Width = 183
                Height = 73
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 1
                Visible = False
                object lbMSRP: TLabel
                  Left = 34
                  Top = 47
                  Width = 58
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New MSRP :'
                  FocusControl = DBEdit16
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object lbOurPrice: TLabel
                  Left = 17
                  Top = 9
                  Width = 75
                  Height = 13
                  Alignment = taRightJustify
                  Caption = 'New Our Price :'
                  FocusControl = DBEdit15
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object DBEdit16: TDBEdit
                  Left = 95
                  Top = 5
                  Width = 64
                  Height = 21
                  DataField = 'NewSalePrice'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  OnExit = DBEdit16Exit
                  OnKeyPress = edtFreightPerKeyPress
                end
                object DBEdit15: TDBEdit
                  Left = 95
                  Top = 43
                  Width = 64
                  Height = 21
                  DataField = 'NewSuggRetail'
                  DataSource = dsForm
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  OnExit = DBEdit15Exit
                  OnKeyPress = edtFreightPerKeyPress
                end
              end
            end
            object Panel13: TPanel
              Left = 212
              Top = 0
              Width = 229
              Height = 221
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object lbTax: TLabel
                Left = 0
                Top = 0
                Width = 229
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Taxes'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object btnRemovTax: TSpeedButton
                Tag = 2
                Left = 181
                Top = 69
                Width = 47
                Height = 20
                Caption = 'Del'
                Enabled = False
                Flat = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
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
                Margin = 3
                ParentFont = False
                OnClick = btnRemovTaxClick
              end
              object Bevel1: TBevel
                Left = 4
                Top = 198
                Width = 223
                Height = 3
                Shape = bsTopLine
              end
              object Bevel2: TBevel
                Left = 3
                Top = 64
                Width = 223
                Height = 3
                Shape = bsTopLine
              end
              object grdSpecialPrice: TSMDBGrid
                Left = 4
                Top = 69
                Width = 177
                Height = 127
                BorderStyle = bsNone
                DataSource = dsItemTax
                FixedColor = 14607076
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines]
                ParentFont = False
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clBlack
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                Flat = True
                Groupings = <>
                GridStyle.Style = gsCustom
                GridStyle.OddColor = clWindow
                GridStyle.EvenColor = clWindow
                FooterColor = clBtnFace
                ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
                FixedCols = 1
                RegistryKey = 'Software\Scalabium'
                RegistrySection = 'SMDBGrid'
                WidthOfIndicator = 11
                DefaultRowHeight = 17
                ScrollBars = ssVertical
                ColCount = 3
                RowCount = 2
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'TaxCategory'
                    Width = 57
                    Visible = True
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'TaxPercentage'
                    Width = 33
                    Visible = True
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'TaxValue'
                    Width = 69
                    Visible = True
                    FooterType = ftCustom
                  end>
              end
              object chkInCost: TCheckBox
                Left = 7
                Top = 204
                Width = 209
                Height = 17
                Caption = 'Tax in Cost'
                Checked = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                State = cbChecked
                TabOrder = 1
              end
              object btnUpdate: TBitBtn
                Left = 60
                Top = 39
                Width = 108
                Height = 20
                Caption = 'Calculate Tax'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                OnClick = btnUpdateClick
              end
              object pnlMVA: TPanel
                Left = 3
                Top = 17
                Width = 222
                Height = 21
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 3
                Visible = False
                object lbMVA: TLabel
                  Left = 5
                  Top = 2
                  Width = 42
                  Height = 13
                  Caption = 'MVA % :'
                end
                object rbMVAIn: TRadioButton
                  Left = 47
                  Top = 2
                  Width = 66
                  Height = 17
                  Caption = '0.00'
                  TabOrder = 0
                end
                object rbMVAOut: TRadioButton
                  Left = 139
                  Top = 2
                  Width = 66
                  Height = 17
                  Caption = '0.00'
                  TabOrder = 1
                end
              end
            end
          end
          object tsInfo: TTabSheet
            Caption = 'Info'
            ImageIndex = 2
            object Panel9: TPanel
              Left = 1
              Top = 1
              Width = 327
              Height = 218
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object lbPOInfo: TLabel
                Left = 0
                Top = 0
                Width = 327
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'PO Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object lbPOQty: TLabel
                Left = 73
                Top = 29
                Width = 25
                Height = 13
                Alignment = taRightJustify
                Caption = 'Qty :'
              end
              object lbPOCost: TLabel
                Left = 32
                Top = 62
                Width = 66
                Height = 13
                Alignment = taRightJustify
                Caption = 'Vendor Cost :'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBtnShadow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbPOOurPrice: TLabel
                Left = 47
                Top = 96
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Our Price :'
              end
              object lbPOMSRP: TLabel
                Left = 64
                Top = 131
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'MSRP :'
              end
              object lbPONum: TLabel
                Left = 66
                Top = 162
                Width = 32
                Height = 13
                Alignment = taRightJustify
                Caption = 'PO # :'
              end
              object DBText3: TDBText
                Tag = 4
                Left = 100
                Top = 30
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'Qty'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBText4: TDBText
                Tag = 4
                Left = 100
                Top = 62
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'CostPrice'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBText5: TDBText
                Tag = 4
                Left = 100
                Top = 96
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'SalePrice'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBText6: TDBText
                Tag = 4
                Left = 100
                Top = 131
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'SuggRetail'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBText7: TDBText
                Tag = 4
                Left = 100
                Top = 162
                Width = 60
                Height = 16
                Alignment = taRightJustify
                DataField = 'IDPO'
                DataSource = dsPO
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object pnlNav1: TPanel
                Left = 0
                Top = 0
                Width = 35
                Height = 17
                Ctl3D = True
                Font.Charset = ANSI_CHARSET
                Font.Color = clBtnShadow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                Visible = False
                object sbPrior1: TSpeedButton
                  Left = 0
                  Top = 0
                  Width = 17
                  Height = 17
                  Hint = 'Prior'
                  Flat = True
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlue
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  Glyph.Data = {
                    DE000000424DDE000000000000007600000028000000100000000D0000000100
                    04000000000068000000C40E0000C40E00001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                    888888888888880888888888888880088888888888880C08888888888880C408
                    88888888880C4C088888888880C4C40888888888880C4C08888888888880C408
                    8888888888880C08888888888888800888888888888888088888888888888888
                    8888}
                  ParentFont = False
                  OnClick = sbPriorClick
                end
                object sbNext1: TSpeedButton
                  Left = 17
                  Top = 0
                  Width = 17
                  Height = 17
                  Hint = 'Next'
                  Flat = True
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlue
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  Glyph.Data = {
                    DE000000424DDE000000000000007600000028000000100000000D0000000100
                    04000000000068000000C40E0000C40E00001000000000000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
                    888888888088888888888888800888888888888880C0888888888888804C0888
                    8888888880C4C08888888888804C4C088888888880C4C08888888888804C0888
                    8888888880C08888888888888008888888888888808888888888888888888888
                    8888}
                  ParentFont = False
                  OnClick = sbNextClick
                end
              end
            end
            object Panel11: TPanel
              Left = 338
              Top = 1
              Width = 298
              Height = 218
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object lbInvInfo: TLabel
                Left = 0
                Top = 0
                Width = 298
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Inventory Info'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object lbInvQty: TLabel
                Left = 34
                Top = 45
                Width = 64
                Height = 13
                Alignment = taRightJustify
                Caption = 'QtyOnHand :'
              end
              object lbInvCost: TLabel
                Left = 32
                Top = 67
                Width = 66
                Height = 13
                Alignment = taRightJustify
                Caption = 'Vendor Cost :'
              end
              object lbInvOurPrice: TLabel
                Left = 47
                Top = 89
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Our Price :'
              end
              object lbInvMSRP: TLabel
                Left = 64
                Top = 111
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'MSRP :'
              end
              object DBText8: TDBText
                Tag = 4
                Left = 36
                Top = 24
                Width = 218
                Height = 15
                DataField = 'Category'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBText9: TDBText
                Tag = 4
                Left = 98
                Top = 111
                Width = 60
                Height = 15
                Alignment = taRightJustify
                DataField = 'SuggRetail'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBText10: TDBText
                Tag = 4
                Left = 98
                Top = 89
                Width = 60
                Height = 15
                Alignment = taRightJustify
                DataField = 'SellingPrice'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object DBText11: TDBText
                Tag = 4
                Left = 98
                Top = 67
                Width = 60
                Height = 14
                Alignment = taRightJustify
                DataField = 'VendorCost'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object DBText12: TDBText
                Tag = 4
                Left = 98
                Top = 45
                Width = 60
                Height = 18
                Alignment = taRightJustify
                DataField = 'TotQtyOnHand'
                DataSource = dsModel
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lbNewMarkup: TLabel
                Left = 32
                Top = 156
                Width = 66
                Height = 13
                Alignment = taRightJustify
                Caption = 'New Markup :'
              end
              object lbInvNewCost: TLabel
                Left = 45
                Top = 135
                Width = 53
                Height = 13
                Alignment = taRightJustify
                Caption = 'New Cost :'
              end
              object DBText13: TDBText
                Tag = 4
                Left = 98
                Top = 135
                Width = 60
                Height = 15
                Alignment = taRightJustify
                DataField = 'NewCostPrice'
                DataSource = dsForm
                Font.Charset = ANSI_CHARSET
                Font.Color = clMenuText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Bevel3: TBevel
                Left = 8
                Top = 130
                Width = 285
                Height = 3
                Shape = bsTopLine
              end
              object edtMarkup: TStaticText
                Left = 98
                Top = 156
                Width = 60
                Height = 17
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0.00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
            end
          end
          object tsReturn: TTabSheet
            Caption = 'Return'
            ImageIndex = 3
            object Panel10: TPanel
              Left = 0
              Top = 0
              Width = 209
              Height = 220
              BevelOuter = bvNone
              Color = 14607076
              TabOrder = 0
              object lbCostRet: TLabel
                Left = 28
                Top = 68
                Width = 56
                Height = 13
                Alignment = taRightJustify
                Caption = 'Total Cost :'
                FocusControl = DBEdit19
              end
              object lbFreteRet: TLabel
                Left = 16
                Top = 109
                Width = 68
                Height = 13
                Alignment = taRightJustify
                Caption = 'Total Freight :'
                FocusControl = DBEdit20
              end
              object lbOtherRet: TLabel
                Left = 24
                Top = 147
                Width = 60
                Height = 13
                Alignment = taRightJustify
                Caption = 'Other Cost :'
                FocusControl = DBEdit21
              end
              object Label33: TLabel
                Left = 151
                Top = 66
                Width = 14
                Height = 15
                Hint = 'Field can not be empty'
                AutoSize = False
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
              object lbQtyPriceRet: TLabel
                Left = 0
                Top = 0
                Width = 209
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Qty and Price'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object lbQtyRet: TLabel
                Left = 60
                Top = 28
                Width = 25
                Height = 13
                Alignment = taRightJustify
                Caption = 'Qty :'
                FocusControl = DBEdit22
              end
              object Label37: TLabel
                Left = 152
                Top = 28
                Width = 14
                Height = 17
                Hint = 'Field can not be empty'
                AutoSize = False
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
              object lbDiscountRet: TLabel
                Left = 35
                Top = 184
                Width = 48
                Height = 13
                Alignment = taRightJustify
                Caption = 'Discount :'
                FocusControl = DBEdit1
              end
              object DBEdit19: TDBEdit
                Left = 86
                Top = 65
                Width = 64
                Height = 21
                DataField = 'CostPriceRet'
                DataSource = dsForm
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
                OnKeyPress = edtFreightPerKeyPress
              end
              object DBEdit20: TDBEdit
                Left = 86
                Top = 105
                Width = 64
                Height = 21
                DataField = 'FreightCostRet'
                DataSource = dsForm
                TabOrder = 2
                OnKeyPress = edtFreightPerKeyPress
              end
              object DBEdit21: TDBEdit
                Left = 86
                Top = 143
                Width = 64
                Height = 21
                DataField = 'OtherCostRet'
                DataSource = dsForm
                TabOrder = 3
                OnKeyPress = edtFreightPerKeyPress
              end
              object DBEdit22: TDBEdit
                Left = 87
                Top = 25
                Width = 64
                Height = 21
                DataField = 'QtyRet'
                DataSource = dsForm
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object DBEdit1: TDBEdit
                Left = 86
                Top = 181
                Width = 64
                Height = 21
                DataField = 'DiscountRet'
                DataSource = dsForm
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
                OnExit = edtCostTotalCostExit
                OnKeyPress = edtFreightPerKeyPress
              end
            end
            object Panel14: TPanel
              Left = 216
              Top = 0
              Width = 229
              Height = 221
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object lbTaxRet: TLabel
                Left = 0
                Top = 0
                Width = 229
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Taxes'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object Bevel4: TBevel
                Left = 3
                Top = 41
                Width = 217
                Height = 3
                Shape = bsTopLine
              end
              object sbGridItemTaxRet: TSMDBGrid
                Left = 4
                Top = 45
                Width = 173
                Height = 173
                BorderStyle = bsNone
                DataSource = dsItemTaxRet
                FixedColor = 14607076
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines]
                ParentFont = False
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clBlack
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                Flat = True
                Groupings = <>
                GridStyle.Style = gsCustom
                GridStyle.OddColor = clWindow
                GridStyle.EvenColor = clWindow
                FooterColor = clBtnFace
                ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
                FixedCols = 1
                RegistryKey = 'Software\Scalabium'
                RegistrySection = 'SMDBGrid'
                WidthOfIndicator = 11
                DefaultRowHeight = 17
                ScrollBars = ssVertical
                ColCount = 3
                RowCount = 2
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'TaxCategory'
                    Width = 58
                    Visible = True
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'TaxPercentage'
                    Width = 32
                    Visible = True
                    FooterType = ftCustom
                  end
                  item
                    Expanded = False
                    FieldName = 'TaxValue'
                    Width = 65
                    Visible = True
                    FooterType = ftCustom
                  end>
              end
              object btnUpdateRet: TBitBtn
                Left = 60
                Top = 19
                Width = 108
                Height = 20
                Caption = 'Calculate Tax'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                OnClick = btnUpdateRetClick
              end
            end
            object Panel15: TPanel
              Left = 452
              Top = 0
              Width = 184
              Height = 220
              BevelOuter = bvNone
              Color = 14607076
              Font.Charset = ANSI_CHARSET
              Font.Color = clBtnShadow
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              object lbFinalPriceRet: TLabel
                Left = 0
                Top = 0
                Width = 184
                Height = 17
                Align = alTop
                Alignment = taCenter
                AutoSize = False
                Caption = 'Final Prices'
                Color = clBtnShadow
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -12
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
              end
              object lbNewDevCost: TLabel
                Left = 37
                Top = 104
                Width = 53
                Height = 13
                Alignment = taRightJustify
                Caption = 'New Cost :'
                FocusControl = DBEdit23
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label45: TLabel
                Left = 165
                Top = 101
                Width = 14
                Height = 17
                Hint = 'Field can not be empty'
                AutoSize = False
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
              object DBEdit23: TDBEdit
                Left = 98
                Top = 100
                Width = 65
                Height = 21
                DataField = 'NewCostPriceRet'
                DataSource = dsForm
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnKeyPress = edtFreightPerKeyPress
              end
              object btnCalcNewCostRet: TBitBtn
                Left = 19
                Top = 54
                Width = 157
                Height = 20
                Caption = 'Update New Return Cost'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                OnClick = btnCalcNewCostRetClick
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
              end
            end
          end
        end
        object pnlBarcode: TPanel
          Left = 0
          Top = 17
          Width = 652
          Height = 53
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lbVCode: TLabel
            Left = 15
            Top = 6
            Width = 69
            Height = 13
            Alignment = taRightJustify
            Caption = 'Vendor Code :'
          end
          object Label3: TLabel
            Left = 38
            Top = 30
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Caption = 'Barcode :'
          end
          object lbCaseBarcode: TLabel
            Left = 364
            Top = 32
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = 'Case Barcode :'
            Visible = False
          end
          object cbxAutoCreate: TCheckBox
            Left = 236
            Top = 32
            Width = 100
            Height = 17
            TabStop = False
            Caption = 'Same as model'
            TabOrder = 2
            Visible = False
            OnClick = cbxAutoCreateClick
          end
          object edtBarCode: TmrBarCodeEdit
            Left = 90
            Top = 28
            Width = 135
            Height = 21
            Color = 8454143
            TabOrder = 1
            OnEnter = edtBarCodeEnter
            OnExit = edtBarCodeExit
            Connection = DM.ADODBConnect
            SQL.Strings = (
              'SELECT'
              '      B.IDModel'
              'FROM'
              '      Barcode B'
              'WHERE'
              '      B.IDBarcode = :IDBarcode')
            SecondSQL.Strings = (
              'SELECT'
              '      M.IDModel'
              'FROM'
              '      Model M'
              'WHERE'
              '      M.Model = :Model')
            KeyField = 'IDBarcode'
            SecondKeyField = 'Model'
            DisplayQty = False
            RunSecondSQL = False
            CheckBarcodeDigit = 0
            MinimalDigits = 0
            AfterSearchBarcode = edtBarCodeAfterSearchBarcode
          end
          object edtVendorCode: TEdit
            Left = 90
            Top = 3
            Width = 135
            Height = 21
            TabOrder = 0
            OnEnter = edtVendorCodeEnter
            OnExit = edtVendorCodeExit
            OnKeyDown = edtVendorCodeKeyDown
          end
          object btnSerialNumb: TBitBtn
            Left = 443
            Top = 2
            Width = 134
            Height = 23
            Caption = '&Add Serial Number(s)'
            TabOrder = 6
            TabStop = False
            OnClick = btnSerialNumbClick
          end
          object edtCaseBarcode: TmrBarCodeEdit
            Left = 443
            Top = 28
            Width = 135
            Height = 21
            Color = 13303807
            TabOrder = 3
            Visible = False
            OnEnter = edtBarCodeEnter
            OnExit = edtCaseBarcodeExit
            Connection = DM.ADODBConnect
            SQL.Strings = (
              'SELECT'
              '      B.IDModel'
              'FROM'
              '      Barcode B'
              'WHERE'
              '      B.IDBarcode = :IDBarcode')
            SecondSQL.Strings = (
              'SELECT'
              '      M.IDModel'
              'FROM'
              '      Model M'
              'WHERE'
              '      M.Model = :Model')
            KeyField = 'IDBarcode'
            SecondKeyField = 'Model'
            DisplayQty = False
            RunSecondSQL = False
            CheckBarcodeDigit = 0
            MinimalDigits = 0
            AfterSearchBarcode = edtCaseBarcodeAfterSearchBarcode
          end
        end
        object pnlModelCat: TPanel
          Left = 0
          Top = 70
          Width = 652
          Height = 76
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label20: TLabel
            Left = 32
            Top = 32
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'Category :'
          end
          object Label21: TLabel
            Left = 49
            Top = 7
            Width = 35
            Height = 13
            Alignment = taRightJustify
            Caption = 'Model :'
          end
          object Label22: TLabel
            Left = 583
            Top = 27
            Width = 14
            Height = 17
            Hint = 'Field can not be empty'
            AutoSize = False
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
          object Label23: TLabel
            Left = 583
            Top = 2
            Width = 14
            Height = 18
            Hint = 'Field can not be empty'
            AutoSize = False
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
          object lbLot: TLabel
            Left = 62
            Top = 55
            Width = 22
            Height = 13
            Alignment = taRightJustify
            Caption = 'Lot :'
            FocusControl = DBEdit2
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object scModel: TDBSuperComboADO
            Left = 89
            Top = 3
            Width = 459
            Height = 21
            TabOrder = 0
            Text = 'scModel'
            OnChange = scModelChange
            CodeLength = 240
            LookUpSource = DM.dsLookUpModelPack
            DropDownRows = 18
            ShowEditCode = True
            EditCodePos = taEditCodeRight
            MostraHidden = STD_AMBOSHIDDEN
            IDLanguage = 0
            OnSelectItem = scModelSelectItem
            DataField = 'IDModel'
            DataSource = dsForm
          end
          object scCategory: TDBSuperComboADO
            Left = 89
            Top = 28
            Width = 487
            Height = 21
            TabOrder = 2
            Text = 'scCategory'
            CodeLength = 268
            LookUpSource = DM.dsLookUpGroup
            DropDownRows = 18
            ShowEditCode = True
            EditCodePos = taEditCodeRight
            IDLanguage = 0
            DataField = 'IDGroup'
            DataSource = dsForm
          end
          object btnSearchDesc: TBitBtn
            Left = 554
            Top = 2
            Width = 23
            Height = 22
            TabOrder = 1
            OnClick = btnSearchDescClick
          end
          object scLot: TDBSuperComboADO
            Left = 89
            Top = 53
            Width = 217
            Height = 21
            TabOrder = 3
            Text = 'scLot'
            Visible = False
            OnEnter = scLotEnter
            CodeLength = 240
            LookUpSource = DM.dsLookUpLot
            DropDownRows = 18
            EditCodePos = taEditCodeRight
            IDLanguage = 0
            DataField = 'IDLote'
            DataSource = dsForm
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPurchaseItem.sil'
    TranslationData = {
      737443617074696F6E730D0A5462727746726D506172656E7442727701627277
      46726D506172656E744272770101010D0A50616E656C31010101010D0A6C626C
      557365724E616D65016C626C557365724E616D650101010D0A4C6162656C3135
      01557365723A0101010D0A4573706163616D656E746F496E666572696F720101
      01010D0A50616E656C33010101010D0A686868010101010D0A737048656C7001
      2648656C700101010D0A627443616E63656C0143616E63656C0101010D0A6274
      436C6F736501536176650101010D0A706E6C4E617669676174696F6E01010101
      0D0A62744669727374526563013C3C0101010D0A62745072696F72526563013C
      0101010D0A62744E657874526563013E0101010D0A62744C617374526563013E
      3E0101010D0A50616E656C32010101010D0A6C626C5375624D656E75014D6169
      6E204D656E750101010D0A6C626C4D656E75014669727374204D656E75204974
      656D0101010D0A4573706163616D656E746F5375706572696F72010101010D0A
      454545010101010D0A706E6C4175746F496E63010101010D0A62744C6F6F7049
      6E63010101010D0A6C626C4D6F6469666965640145646974204D6F6465010101
      0D0A706E6C4B6579010101010D0A50616E656C34010101010D0A706E6C446574
      61696C010101010D0A4573706163616D656E746F457371756572646F01010101
      0D0A4573706163616D656E746F4469726569746F010101010D0A706E6C505061
      6765436F6E74726F6C01706E6C5050616765436F6E74726F6C0101010D0A7473
      42726F77736501747342726F7773650101010D0A4C6162656C31014368616E67
      6520666F722074686520636F7272656374206E616D650101010D0A706E6C436F
      6D616E64010101010D0A627441646401463220264164640101010D0A62744465
      7461696C014633202644657461696C73200101010D0A627452656D6F76650146
      34205265266D6F76650101010D0A627447726F7570012647726F7570696E6701
      01010D0A6274436F6C756D6E0126436F6C756D6E730101010D0A627450726576
      6965770146352026507265766965770101010D0A6274457863656C0146362053
      707265616473686565740101010D0A50616E656C38010101010D0A50616E656C
      36010101010D0A706E6C73646A68666B736468666A6B73646866010101010D0A
      737448696E74730D0A5462727746726D506172656E7442727701010D0A50616E
      656C31010101010D0A6C626C557365724E616D65010101010D0A4C6162656C31
      35010101010D0A4573706163616D656E746F496E666572696F72010101010D0A
      50616E656C33010101010D0A686868010101010D0A737048656C70010101010D
      0A627443616E63656C010101010D0A6274436C6F7365010101010D0A706E6C4E
      617669676174696F6E010101010D0A62744669727374526563014D6F76652074
      6F204669727374205265636F72640101010D0A62745072696F72526563014D6F
      766520746F205072696F72205265636F72640101010D0A62744E657874526563
      014D6F766520746F204E657874205265636F72640101010D0A62744C61737452
      6563014D6F766520746F204C617374205265636F72640101010D0A50616E656C
      32010101010D0A496D61676531010101010D0A6C626C5375624D656E75010101
      010D0A6C626C4D656E75010101010D0A4573706163616D656E746F5375706572
      696F72010101010D0A454545010101010D0A706E6C4175746F496E6301507265
      7373206865726520746F20636F6E74696E75696E6720696E7365727420646174
      610101010D0A62744C6F6F70496E6301436F6E74696E75696E6720696E736572
      74206461746120776974686F757420636C6F73696E6720746865207363726565
      6E2E0101010D0A6C626C4D6F646966696564010101010D0A706E6C4B65790101
      01010D0A50616E656C34010101010D0A706E6C44657461696C010101010D0A45
      73706163616D656E746F457371756572646F010101010D0A4573706163616D65
      6E746F4469726569746F010101010D0A706E6C5050616765436F6E74726F6C01
      0101010D0A5050616765436F6E74726F6C010101010D0A747342726F77736501
      0101010D0A4C6162656C31010101010D0A706E6C436F6D616E64010101010D0A
      6274416464010101010D0A627444657461696C010101010D0A627452656D6F76
      65010101010D0A627447726F7570010101010D0A6274436F6C756D6E01010101
      0D0A627450726576696577010101010D0A6274457863656C014578706F727420
      6772696420746F2053707265616473686565740101010D0A50616E656C380101
      01010D0A50616E656C36010101010D0A706E6C73646A68666B736468666A6B73
      646866010101010D0A7374446973706C61794C6162656C730D0A7374466F6E74
      730D0A5462727746726D506172656E74427277015461686F6D610101010D0A6C
      626C557365724E616D6501417269616C0101010D0A4C6162656C313501417269
      616C0101010D0A627443616E63656C015461686F6D610101010D0A6274436C6F
      7365015461686F6D610101010D0A6274466972737452656301417269616C0101
      010D0A62745072696F7252656301417269616C0101010D0A62744E6578745265
      6301417269616C0101010D0A62744C61737452656301417269616C0101010D0A
      6C626C5375624D656E750156657264616E610101010D0A6C626C4D656E750156
      657264616E610101010D0A6C626C4D6F64696669656401536D616C6C20466F6E
      74730101010D0A4C6162656C31015461686F6D610101010D0A73744D756C7469
      4C696E65730D0A7175466F726D2E46696C7465724669656C6473010101010D0A
      7175466F726D2E46696C74657256616C756573010101010D0A466F726D436F6E
      6669672E446570656E64656E745461626C654B657973010101010D0A466F726D
      436F6E6669672E446570656E64656E745461626C6573010101010D0A466F726D
      436F6E6669672E52657175697265644669656C6473010101010D0A466F726D43
      6F6E6669672E556E697175654669656C6473010101010D0A717542726F777365
      2E46696C7465724669656C6473010101010D0A717542726F7773652E46696C74
      657256616C756573010101010D0A7374446C677343617074696F6E730D0A5761
      726E696E67015761726E696E670101010D0A4572726F72014572726F72010101
      0D0A496E666F726D6174696F6E01496E666F726D6174696F6E0101010D0A436F
      6E6669726D01436F6E6669726D0101010D0A59657301265965730101010D0A4E
      6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63656C0143616E6365
      6C0101010D0A41626F7274012641626F72740101010D0A526574727901265265
      7472790101010D0A49676E6F7265012649676E6F72650101010D0A416C6C0126
      416C6C0101010D0A4E6F20546F20416C6C014E266F20746F20416C6C0101010D
      0A59657320546F20416C6C0159657320746F2026416C6C0101010D0A48656C70
      012648656C700101010D0A7374537472696E67730D0A73744F74686572537472
      696E67730D0A7175466F726D2E436F6D6D616E6454657874010101010D0A7175
      466F726D2E436F6E6E656374696F6E537472696E67010101010D0A7175466F72
      6D2E46696C746572010101010D0A7175466F726D2E496E6465784669656C644E
      616D6573010101010D0A7175466F726D2E4B65794669656C6473010101010D0A
      466F726D436F6E6669672E456E7469646164654E6F6D65010101010D0A717542
      726F7773652E436F6D6D616E6454657874010101010D0A717542726F7773652E
      436F6E6E656374696F6E537472696E67010101010D0A717542726F7773652E46
      696C746572010101010D0A717542726F7773652E496E6465784669656C644E61
      6D6573010101010D0A717542726F7773652E4B65794669656C6473010101010D
      0A53442E46696C746572014D6963726F736F667420457863656C7C2A2E786C73
      0101010D0A53442E5469746C65010101010D0A73744C6F63616C65730D0A4375
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
      0A737443686172536574730D0A5462727746726D506172656E7442727701414E
      53495F434841525345540101010D0A6C626C557365724E616D65014445464155
      4C545F434841525345540101010D0A4C6162656C31350144454641554C545F43
      4841525345540101010D0A6274436C6F736501414E53495F4348415253455401
      01010D0A6C626C4D656E7501414E53495F434841525345540101010D0A6C626C
      5375624D656E7501414E53495F434841525345540101010D0A627443616E6365
      6C01414E53495F434841525345540101010D0A6274466972737452656301414E
      53495F434841525345540101010D0A62745072696F7252656301414E53495F43
      4841525345540101010D0A62744E65787452656301414E53495F434841525345
      540101010D0A62744C61737452656301414E53495F434841525345540101010D
      0A6C626C4D6F64696669656401414E53495F434841525345540101010D0A4C61
      62656C3101414E53495F434841525345540101010D0A}
  end
  inherited dsForm: TDataSource
    Left = 128
    Top = 6
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'PI.IDPurchaseItem,'#13#10#9'PI.IDPurchase,'#13#10#9'PI.IDModel,'#13#10#9'PI.' +
      'BarCode,'#13#10#9'PI.BarcodeCase,'#13#10#9'PI.Qty,'#13#10#9'PI.IDGroup,'#13#10#9'PI.FreightC' +
      'ost,'#13#10#9'PI.OtherCost,'#13#10#9'PI.CostPrice,'#13#10#9'PI.Discount,'#13#10#9'PI.NewCost' +
      'Price,'#13#10#9'PI.NewSalePrice,'#13#10#9'PI.NewSuggRetail,'#13#10#9'PI.IDFornecedor,' +
      #13#10#9'PI.IDPOItem,'#13#10#9'PI.QtyRet,'#13#10#9'PI.CostPriceRet,'#13#10#9'PI.DiscountRet' +
      ','#13#10#9'PI.FreightCostRet,'#13#10#9'PI.OtherCostRet,'#13#10#9'PI.NewCostPriceRet,'#13 +
      #10#9'PI.CaseQty,'#13#10#9'PI.CaseCost,'#13#10#9'PI.IDLote,'#13#10#9'M.IDModelGroup,'#13#10#9'M.' +
      'IDModelSubGroup'#13#10'FROM'#13#10#9'Pur_PurchaseItem PI'#13#10#9'LEFT JOIN Model M ' +
      'ON (PI.IDModel  = M.IDModel)'#13#10'WHERE'#13#10#9'PI.IDPurchaseItem = :IDPur' +
      'chaseItem'#13#10
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 182
    Top = 13
    object quFormIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object quFormIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quFormIDModel: TIntegerField
      FieldName = 'IDModel'
      Required = True
    end
    object quFormBarCode: TStringField
      FieldName = 'BarCode'
    end
    object quFormIDGroup: TIntegerField
      FieldName = 'IDGroup'
      Required = True
    end
    object quFormCostPrice: TBCDField
      FieldName = 'CostPrice'
      OnChange = quFormCostPriceChange
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormNewCostPrice: TBCDField
      FieldName = 'NewCostPrice'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormNewSalePrice: TBCDField
      FieldName = 'NewSalePrice'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormNewSuggRetail: TBCDField
      FieldName = 'NewSuggRetail'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormIDFornecedor: TIntegerField
      FieldName = 'IDFornecedor'
    end
    object quFormIDPOItem: TIntegerField
      FieldName = 'IDPOItem'
    end
    object quFormFreightCost: TBCDField
      FieldName = 'FreightCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormOtherCost: TBCDField
      FieldName = 'OtherCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormCostPriceRet: TBCDField
      FieldName = 'CostPriceRet'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormFreightCostRet: TBCDField
      FieldName = 'FreightCostRet'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormOtherCostRet: TBCDField
      FieldName = 'OtherCostRet'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormNewCostPriceRet: TBCDField
      FieldName = 'NewCostPriceRet'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormQty: TFloatField
      FieldName = 'Qty'
      OnChange = quFormQtyChange
      DisplayFormat = '0.#####'
    end
    object quFormQtyRet: TFloatField
      FieldName = 'QtyRet'
      DisplayFormat = '0.#####'
    end
    object quFormCaseQty: TFloatField
      FieldName = 'CaseQty'
      DisplayFormat = '0.#####'
    end
    object quFormCaseCost: TBCDField
      FieldName = 'CaseCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object quFormIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object quFormBarcodeCase: TStringField
      FieldName = 'BarcodeCase'
    end
    object quFormIDLote: TIntegerField
      DisplayLabel = 'IDLot'
      FieldName = 'IDLote'
    end
    object quFormDiscount: TBCDField
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormDiscountRet: TBCDField
      FieldName = 'DiscountRet'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    PostOnInsert = True
    AutoIncField = 'IDPurchaseItem'
    RequiredFields.Strings = (
      'Qty')
    DependentTables.Strings = (
      'Pur_PurchaseItemSerial'
      'Pur_PurchaseItemTax'
      'Pur_PurchaseItemTaxRet')
    DependentTableKeys.Strings = (
      'IDPurchaseItem'
      'IDPurchaseItem'
      'IDPurchaseItem')
    Left = 294
    Top = 7
  end
  inherited quBrowse: TPowerADOQuery
    AfterOpen = quBrowseAfterOpen
    CommandText = 
      'SELECT'#13#10#9'PIS.IDPurchaseItemSerial,'#13#10#9'PIS.IDPurchaseItem,'#13#10#9'PIS.S' +
      'erialNumber'#13#10'FROM'#13#10#9'Pur_PurchaseItemSerial PIS'#13#10'WHERE'#13#10#9'PIS.IDPu' +
      'rchaseItem = :IDPurchaseItem'
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 245
    Top = 7
    object quBrowseIDPurchaseItemSerial: TIntegerField
      FieldName = 'IDPurchaseItemSerial'
    end
    object quBrowseIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object quBrowseSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 30
    end
  end
  inherited dsBrowse: TDataSource
    Left = 478
    Top = 10
  end
  inherited SD: TSaveDialog
    Left = 362
    Top = 65533
  end
  object quHistory: TADOQuery [14]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 300
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
      'SELECT TOP 20'
      #9'IM.IDInventoryMov,'
      #9'IM.IDPessoa,'
      '        P.Pessoa as Vendor,'
      '        IM.MovDate,'
      ' '#9'IM.CostPrice,'
      '        IM.Freight,'
      '        IM.OtherCost'
      'FROM'
      #9'InventoryMov IM (NOLOCK)'
      '        JOIN Pessoa P (NOLOCK) ON (IM.IDPessoa = P.IDPessoa)'
      ''
      'WHERE'
      '   '#9'IM.InventMovTypeID = 2'
      '   '#9'AND'
      '  '#9'IM.ModelID = :IDModel'
      'ORDER BY'
      #9'IM.MovDate DESC'
      ''
      ' '
      ' '
      ' '
      ' ')
    Left = 31
    Top = 471
    object quHistoryIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
      Origin = 'RETAIL.InventoryMov.IDInventoryMov'
    end
    object quHistoryIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Origin = 'RETAIL.InventoryMov.IDPessoa'
    end
    object quHistoryVendor: TStringField
      FieldName = 'Vendor'
      Origin = 'RETAIL.Pessoa.Pessoa'
      Size = 50
    end
    object quHistoryMovDate: TDateTimeField
      FieldName = 'MovDate'
      Origin = 'RETAIL.InventoryMov.MovDate'
      DisplayFormat = 'ddddd'
    end
    object quHistoryCostPrice: TFloatField
      FieldName = 'CostPrice'
      Origin = 'RETAIL.InventoryMov.CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object quHistoryFreight: TFloatField
      FieldName = 'Freight'
      Origin = 'RETAIL.InventoryMov.Freight'
      DisplayFormat = '#,##0.00'
    end
    object quHistoryOtherCost: TFloatField
      FieldName = 'OtherCost'
      Origin = 'RETAIL.InventoryMov.OtherCost'
      DisplayFormat = '#,##0.00'
    end
  end
  object dsHistory: TDataSource [15]
    DataSet = quHistory
    Left = 30
    Top = 521
  end
  object dsPO: TDataSource [16]
    DataSet = quPO
    Left = 102
    Top = 522
  end
  object quPO: TADOQuery [17]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quPOAfterOpen
    Parameters = <
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT TOP 10'
      '        PIM.IDPreInventoryMov,'
      '        PIM.ModelID,'
      '        PIM.MovDate,'
      '        (PIM.Qty - PIM.QtyRealMov) as Qty,'
      '        PIM.CostPrice,'
      '        PIM.SalePrice,'
      '        PIM.IDPessoa,'
      '        PIM.DateEstimatedMov,'
      '        PIM.SuggRetail,'
      '        PIM.DocumentID as IDPO'
      'FROM'
      #9'PreInventoryMov PIM (NOLOCK)'
      'WHERE'
      #9'PIM.IDPessoa = :IDFornecedor'
      '        AND'
      '        PIM.ModelID  = :IDModel'
      #9'AND'
      #9'PIM.Qty > PIM.QtyRealMov'
      'ORDER BY'
      #9'PIM.MovDate'
      ' '
      ' ')
    Left = 97
    Top = 472
    object quPOIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
    object quPOModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quPOMovDate: TDateTimeField
      FieldName = 'MovDate'
      DisplayFormat = 'ddddd'
    end
    object quPOCostPrice: TFloatField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object quPOSalePrice: TFloatField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object quPOIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quPODateEstimatedMov: TDateTimeField
      FieldName = 'DateEstimatedMov'
    end
    object quPOSuggRetail: TFloatField
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
    end
    object quPOIDPO: TIntegerField
      FieldName = 'IDPO'
    end
    object quPOQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
  end
  object quModel: TADOQuery [18]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    SQL.Strings = (
      'SELECT'
      '        M.SellingPrice,'
      '        M.Description,'
      '        M.VendorCost,'
      '        M.SuggRetail,'
      '        M.GroupID,'
      '        M.TotQtyOnHand,'
      '        M.IDModel,'
      '        M.IDSize,'
      '        M.Markup,'
      '        M.IDColor,'
      '        M.UseScale,'
      '        M.UseLot,'
      '        M.IDFabricante,'
      '        TG.Name as Category,'
      #9'CASE WHEN ISNULL(IMV.CaseQty, -1) < 2 THEN  M.CaseQty'
      #9#9'ELSE IMV.CaseQty END as CaseQty,'
      #9'NCM.MVAInterno,'
      #9'NCM.MVAInterestadual,'
      #9'NCM.Incide,'
      '  M.UpdatePrice'
      'FROM'
      #9'Model M (NOLOCK)'
      '        JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'
      
        #9'LEFT JOIN Inv_ModelVendor IMV (NOLOCK) ON (IMV.IDModel = M.IDMo' +
        'del and IMV.IDPessoa = :IDPessoa)'
      #9'LEFT JOIN Inv_NCM NCM (NOLOCK) ON (NCM.IDNCM = M.IDNCM)'
      'WHERE'
      #9'M.IDModel = :IDModel')
    Left = 160
    Top = 473
    object quModelSellingPrice: TFloatField
      FieldName = 'SellingPrice'
      Origin = 'RETAIL.Model.SellingPrice'
      DisplayFormat = '#,##0.00'
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      Origin = 'RETAIL.Model.Description'
      Size = 50
    end
    object quModelVendorCost: TFloatField
      FieldName = 'VendorCost'
      Origin = 'RETAIL.Model.VendorCost'
      DisplayFormat = '#,##0.00'
    end
    object quModelSuggRetail: TFloatField
      FieldName = 'SuggRetail'
      Origin = 'RETAIL.Model.SuggRetail'
      DisplayFormat = '#,##0.00'
    end
    object quModelGroupID: TIntegerField
      FieldName = 'GroupID'
      Origin = 'RETAIL.Model.GroupID'
    end
    object quModelCategory: TStringField
      FieldName = 'Category'
      Origin = 'RETAIL.TabGroup.Name'
      Size = 30
    end
    object quModelIDModel: TAutoIncField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quModelIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object quModelIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object quModelIDFabricante: TIntegerField
      FieldName = 'IDFabricante'
    end
    object quModelTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      DisplayFormat = '0.#####'
    end
    object quModelCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object quModelMarkup: TBCDField
      FieldName = 'Markup'
      Precision = 19
    end
    object quModelUseScale: TBooleanField
      FieldName = 'UseScale'
    end
    object quModelUseLot: TBooleanField
      FieldName = 'UseLot'
    end
    object quModelMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object quModelMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object quModelIncide: TBooleanField
      FieldName = 'Incide'
    end
    object quModelUpdatePrice: TBooleanField
      FieldName = 'UpdatePrice'
    end
  end
  object dsModel: TDataSource [19]
    DataSet = quModel
    Left = 162
    Top = 522
  end
  object quPurBarcode: TADOQuery [20]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'BarCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
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
      #9'IDModel'
      '              , Barcode'
      'FROM'
      #9'Pur_PurchaseItem (NOLOCK)'
      'WHERE'
      #9'IDPurchase = :IDPurchase'
      #9'AND'
      #9'(BarCode = IsNull(:Barcode,'#39#39')'
      #9'OR'
      #9'IDModel = IsNull(:IDModel,0))'
      ''
      ' '
      ' ')
    Left = 227
    Top = 477
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {0000000000000000A005000068030000}
    Left = 528
    Top = 14
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37963.680400405090000000
      PrinterPage.Footer = 336
      PrinterPage.Header = 20
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 215900
      PrinterPage.PageSize.Y = 279400
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
  inherited GridPopupMenu: TcxGridPopupMenu
    Left = 422
    Top = 11
  end
  object quItemTax: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterEdit = quItemTaxAfterEdit
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIT.IDPurchaseItemTax,'
      #9'PIT.TaxValue,'
      #9'PIT.TaxPercentage,'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.Formula'
      'FROM'
      #9'Pur_PurchaseItemTax PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchaseItem = :IDPurchaseItem'
      'ORDER BY'
      #9'LEN(TG.Formula)')
    Left = 307
    Top = 482
    object quItemTaxIDPurchaseItemTax: TIntegerField
      FieldName = 'IDPurchaseItemTax'
    end
    object quItemTaxTaxValue: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'TaxValue'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quItemTaxTaxPercentage: TBCDField
      DisplayLabel = '%'
      FieldName = 'TaxPercentage'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quItemTaxTaxCategory: TStringField
      DisplayLabel = 'Tax'
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quItemTaxDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quItemTaxFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
  object dsItemTax: TDataSource
    DataSet = quItemTax
    OnStateChange = dsItemTaxStateChange
    Left = 307
    Top = 532
  end
  object quItemTaxRet: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterEdit = quItemTaxAfterEdit
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIT.IDPurchaseItemTaxRet,'
      #9'PIT.TaxValue,'
      #9'PIT.TaxPercentage,'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.Formula'
      'FROM'
      #9'Pur_PurchaseItemTaxRet PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchaseItem = :IDPurchaseItem'
      'ORDER BY'
      #9'LEN(TG.Formula)')
    Left = 379
    Top = 482
    object quItemTaxRetIDPurchaseItemTaxRet: TIntegerField
      FieldName = 'IDPurchaseItemTaxRet'
    end
    object quItemTaxRetTaxValue: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'TaxValue'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quItemTaxRetTaxPercentage: TBCDField
      DisplayLabel = '%'
      FieldName = 'TaxPercentage'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quItemTaxRetTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quItemTaxRetDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quItemTaxRetFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
  object dsItemTaxRet: TDataSource
    DataSet = quItemTaxRet
    OnStateChange = dsItemTaxStateChange
    Left = 379
    Top = 532
  end
  object quVendorCode: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
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
        Name = 'VendorCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 35
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDVendorModelCode,'
      #9'IDPessoa,'
      #9'IDModel,'
      #9'VendorCode'
      'FROM'
      #9'VendorModelCode (NOLOCK)'
      'WHERE'
      #9'IDPessoa = :IDPessoa'
      #9'and'
      #9'VendorCode = :VendorCode')
    Left = 574
    Top = 8
    object quVendorCodeIDVendorModelCode: TIntegerField
      FieldName = 'IDVendorModelCode'
    end
    object quVendorCodeIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quVendorCodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quVendorCodeVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 10
    end
  end
  object quBarcode: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'BarCode'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'BC.IDBarCode,'
      '        BC.IDModel'
      'FROM'
      #9'BarCode BC'
      'WHERE'
      #9'BC.IDBarCode = :BarCode'
      ' ')
    Left = 222
    Top = 522
    object quBarcodeIDBarCode: TStringField
      FieldName = 'IDBarCode'
      FixedChar = True
    end
    object quBarcodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
end
