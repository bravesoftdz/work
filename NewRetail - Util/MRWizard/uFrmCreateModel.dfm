object FrmCreateModel: TFrmCreateModel
  Left = 81
  Top = 86
  Width = 702
  Height = 489
  Caption = 'FrmCreateModel'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 425
    Width = 694
    Height = 37
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      694
      37)
    object btnClose: TBitBtn
      Left = 608
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnSave: TBitBtn
      Left = 528
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnOpen: TBitBtn
      Left = 449
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Open'
      TabOrder = 2
      OnClick = btnOpenClick
    end
    object btnCopySave: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Copy Save'
      TabOrder = 3
      Visible = False
      OnClick = btnCopySaveClick
    end
    object Button1: TButton
      Left = 88
      Top = 8
      Width = 107
      Height = 25
      Caption = 'Deletar Linha'
      TabOrder = 4
      Visible = False
      OnClick = Button1Click
    end
  end
  object gridModelList: TcxGrid
    Left = 0
    Top = 41
    Width = 694
    Height = 384
    Align = alClient
    TabOrder = 1
    object gridModelListDBTableView: TcxGridDBTableView
      DataController.DataSource = DMExport.dsModel
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'Model'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Appending = True
      OptionsData.Deleting = False
      OptionsSelection.InvertSelect = False
      OptionsSelection.MultiSelect = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.NewItemRow = True
      object gridModelListDBTableViewCategory: TcxGridDBColumn
        DataBinding.FieldName = 'Category'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'Category'
        Properties.ListColumns = <
          item
            FieldName = 'Category'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = DMExport.dsCategory
      end
      object gridModelListDBTableViewBarcode: TcxGridDBColumn
        DataBinding.FieldName = 'Barcode'
      end
      object gridModelListDBTableViewModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
      end
      object gridModelListDBTableViewDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
      end
      object gridModelListDBTableViewCostPrice: TcxGridDBColumn
        DataBinding.FieldName = 'CostPrice'
      end
      object gridModelListDBTableViewSalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'SalePrice'
      end
      object gridModelListDBTableViewQty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
      end
    end
    object gridModelListLevel1: TcxGridLevel
      GridView = gridModelListDBTableView
    end
  end
  object pnlCategory: TPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 41
    Align = alTop
    TabOrder = 2
    object cbxTipoNegocio: TComboBox
      Left = 6
      Top = 8
      Width = 304
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbxTipoNegocioChange
      Items.Strings = (
        'Supermercados'
        'Lojas de Conveni'#234'ncia'
        'Padarias'
        'Farm'#225'cias'
        'Perfumarias'
        'Livrarias'
        'Papelarias'
        'Brinquedos'
        'Material de Constru'#231#227'o'
        'Vestu'#225'rio'
        'Sapatarias'
        'Autope'#231'as'
        'M'#243'veis'
        'Fotos & Equipamentos'
        'Pet Shop'
        'Materiais El'#233'tricos'
        'Eletrodom'#233'sticos'
        'Loja de Inform'#225'tica'
        'Relojoarias'
        #211'ticas'
        'Nautica'
        'Artesanato'
        'Materiais Esportivos'
        'Outros ...')
    end
  end
  object SV: TSaveDialog
    Filter = 'XML|*.xml'
    Left = 488
    Top = 144
  end
  object OP: TOpenDialog
    Filter = 'XML|*.xml'
    Left = 544
    Top = 144
  end
  object cdsNewModel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 316
    object cdsNewModelCategory: TStringField
      FieldName = 'Category'
      Required = True
      Size = 30
    end
    object cdsNewModelModel: TStringField
      FieldName = 'Model'
      Required = True
      Size = 30
    end
    object cdsNewModelDescription: TStringField
      FieldName = 'Description'
      Required = True
      Size = 50
    end
    object cdsNewModelCostPrice: TCurrencyField
      FieldName = 'CostPrice'
      Required = True
      DisplayFormat = '#,##0.00'
    end
    object cdsNewModelSalePrice: TCurrencyField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsNewModelQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsNewModelBarcode: TStringField
      FieldName = 'Barcode'
    end
    object cdsNewModelSizeAndColor: TBooleanField
      FieldName = 'SizeAndColor'
    end
    object cdsNewModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
end
