object vwBogoWarningOrphan: TvwBogoWarningOrphan
  Left = 418
  Top = 55
  Width = 1061
  Height = 779
  BorderIcons = [biSystemMenu]
  Caption = 'BOGO Orphans detected'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 506
    Top = 446
    Height = 254
  end
  object pnlOrphan: TPanel
    Left = 0
    Top = 0
    Width = 1045
    Height = 41
    Align = alTop
    Caption = 'There are Orphans Detected on this BOGO Promotion'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 41
    Width = 1045
    Height = 405
    Align = alTop
    Caption = ' Items on  Sale '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object cxGridItemsSale: TcxGrid
      Left = 2
      Top = 18
      Width = 1041
      Height = 385
      Align = alClient
      TabOrder = 0
      object cxGridDBTableViewItemsSale: TcxGridDBTableView
        DataController.DataSource = dsSaleFromCashRegister
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        object cxGridDBTableViewItemsSaleDBColumn2: TcxGridDBColumn
          DataBinding.FieldName = 'Qty'
          Width = 95
        end
        object cxGridDBTableViewItemsSaleDBColumn3: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 103
        end
        object cxGridDBTableViewItemsSaleDBColumn5: TcxGridDBColumn
          Caption = 'Description'
          DataBinding.FieldName = 'description'
          Width = 151
        end
        object cxGridDBTableViewItemsSaleDBColumn4: TcxGridDBColumn
          Caption = 'Selling Price'
          DataBinding.FieldName = 'sellingprice'
          Width = 145
        end
        object cxGridDBTableViewItemsSaleDBColumn1: TcxGridDBColumn
          Caption = 'Ext. Discount'
          DataBinding.FieldName = 'discount'
          Width = 125
        end
        object cxGridDBTableViewItemsSaleDBColumn6: TcxGridDBColumn
          Caption = 'Ext Price'
          DataBinding.FieldName = 'totalprice'
          Width = 110
        end
        object cxGridDBTableViewItemsSaleDBColumn7: TcxGridDBColumn
          Caption = 'Subtotal'
          DataBinding.FieldName = 'totalSaleItem'
          Width = 124
        end
      end
      object cxGridLevelItemsSale: TcxGridLevel
        GridView = cxGridDBTableViewItemsSale
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 446
    Width = 506
    Height = 254
    Align = alLeft
    Caption = ' Orphan Items on  Sale '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object cxGridOrphan: TcxGrid
      Left = 2
      Top = 18
      Width = 502
      Height = 234
      Align = alClient
      TabOrder = 0
      object cxGridDBTableViewOrphan: TcxGridDBTableView
        DataController.DataSource = dsOrphanSale
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        object cxGridDBTableViewOrphanDBColumn1: TcxGridDBColumn
          Caption = 'IdMov'
          DataBinding.FieldName = 'IdPreinventoryMov'
          Width = 70
        end
        object cxGridDBTableViewOrphanDBColumn2: TcxGridDBColumn
          Caption = 'Qty'
          DataBinding.FieldName = 'qty'
          Width = 48
        end
        object cxGridDBTableViewOrphanDBColumn3: TcxGridDBColumn
          Caption = 'Model'
          DataBinding.FieldName = 'model'
          Width = 80
        end
        object cxGridDBTableViewOrphanDBColumn4: TcxGridDBColumn
          Caption = 'Description'
          DataBinding.FieldName = 'description'
          Width = 147
        end
        object cxGridDBTableViewOrphanDBColumn5: TcxGridDBColumn
          Caption = 'Selling Price'
          DataBinding.FieldName = 'sellingprice'
          Width = 117
        end
      end
      object cxGridLevelOrphan: TcxGridLevel
        GridView = cxGridDBTableViewOrphan
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 700
    Width = 1045
    Height = 41
    Align = alBottom
    TabOrder = 3
    object btnSelect: TButton
      Left = 150
      Top = 6
      Width = 251
      Height = 25
      Caption = 'Select Orphan Items to Delete'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object btnOrphansToDelete: TButton
      Left = 680
      Top = 6
      Width = 201
      Height = 25
      Caption = 'Confirm Deletion '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 1
      OnClick = btnOrphansToDeleteClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 509
    Top = 446
    Width = 536
    Height = 254
    Align = alClient
    Caption = ' Orphan Items to Delete '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object clbOrphans: TCheckListBox
      Left = 2
      Top = 18
      Width = 532
      Height = 234
      Align = alClient
      ItemHeight = 16
      TabOrder = 0
    end
  end
  object dsSaleFromCashRegister: TDataSource
    Left = 830
    Top = 116
  end
  object dsOrphanSale: TDataSource
    Left = 30
    Top = 511
  end
end
