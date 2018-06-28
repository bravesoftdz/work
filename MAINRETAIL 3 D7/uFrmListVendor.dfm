inherited FrmListVendor: TFrmListVendor
  Left = 130
  Top = 243
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'List Vendor'
  ClientHeight = 212
  ClientWidth = 500
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 171
    Width = 500
    inherited EspacamentoInferior: TPanel
      Width = 500
      inherited Panel3: TPanel
        Width = 500
      end
    end
    inherited hhh: TPanel
      Left = 248
      Width = 252
      inherited sbHelp: TSpeedButton
        Left = 34
        Visible = False
      end
      inherited btClose: TButton
        Left = 177
        OnClick = btCloseClick
      end
      object btSelect: TButton
        Left = 107
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Select'
        TabOrder = 1
        TabStop = False
        OnClick = btSelectClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 165
  end
  inherited EspacamentoDireito: TPanel
    Left = 497
    Height = 165
  end
  inherited EspacamentoSuperior: TPanel
    Width = 500
  end
  object grdVendorList: TcxGrid [4]
    Left = 3
    Top = 6
    Width = 494
    Height = 165
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdVendorListDB: TcxGridDBTableView
      DataController.DataSource = dsVendorList
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDVendor'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSellingPrice'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubFinalCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubVendorCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubFreightCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubOtherCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubRealMarkUpValue'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSuggRetail'
        end
        item
          Format = '0'
          Kind = skSum
          Position = spFooter
          FieldName = 'PositiveQty'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSellingPrice'
        end>
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
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdVendorListDBVendor: TcxGridDBColumn
        DataBinding.FieldName = 'Vendor'
        Width = 162
      end
      object grdVendorListDBVendorCode: TcxGridDBColumn
        DataBinding.FieldName = 'VendorCode'
        Width = 108
      end
      object grdVendorListDBVendorCost: TcxGridDBColumn
        DataBinding.FieldName = 'VendorCost'
        Width = 74
      end
      object grdVendorListDBMinQtyPO: TcxGridDBColumn
        DataBinding.FieldName = 'MinQtyPO'
        Width = 75
      end
      object grdVendorListDBCaseQty: TcxGridDBColumn
        DataBinding.FieldName = 'CaseQty'
        Width = 73
      end
    end
    object grdVendorListLevel: TcxGridLevel
      GridView = grdVendorListDB
    end
  end
  object dsVendorList: TDataSource [5]
    Left = 28
    Top = 80
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmListVendor.sil'
  end
end
