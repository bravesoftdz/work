inherited FrmTransferImport: TFrmTransferImport
  Left = 295
  Top = 180
  Width = 509
  Height = 398
  BorderIcons = [biSystemMenu]
  Caption = 'FrmTransferImport'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 501
    DesignSize = (
      501
      40)
    inherited Image1: TImage
      Width = 274
    end
    inherited lblMenu: TLabel
      Left = 285
    end
    inherited EspacamentoSuperior: TPanel
      Width = 501
      inherited EEE: TPanel
        Width = 501
      end
    end
  end
  inherited Panel1: TPanel
    Top = 330
    Width = 501
    inherited EspacamentoInferior: TPanel
      Width = 501
      inherited Panel3: TPanel
        Width = 501
      end
    end
    inherited hhh: TPanel
      Left = 325
      Width = 176
      inherited btClose: TButton
        Left = 105
        ModalResult = 2
      end
      object btnImport: TButton
        Left = 34
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Import'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnImportClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 290
  end
  inherited EspacamentoDireito: TPanel
    Left = 498
    Height = 290
  end
  object grdTransfer: TcxGrid [4]
    Left = 3
    Top = 40
    Width = 495
    Height = 290
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdTransferDB: TcxGridDBTableView
      DataController.DataSource = dsTransfer
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModelTransfDet'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'CostPrice'
          Column = grdTransferDBCostPrice
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'CostTotal'
          Column = grdTransferDBCostTotal
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdTransferDBIDModel: TcxGridDBColumn
        DataBinding.FieldName = 'IDModel'
        Visible = False
        Options.Filtering = False
      end
      object grdTransferDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Options.Filtering = False
        Width = 73
      end
      object grdTransferDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Options.Filtering = False
        Width = 178
      end
      object grdTransferDBIDModelTransfDet: TcxGridDBColumn
        DataBinding.FieldName = 'IDModelTransfDet'
        Visible = False
        Options.Filtering = False
      end
      object grdTransferDBIDModelTransf: TcxGridDBColumn
        DataBinding.FieldName = 'IDModelTransf'
        Visible = False
        Options.Filtering = False
      end
      object grdTransferDBQtyTransfer: TcxGridDBColumn
        DataBinding.FieldName = 'QtyTransfer'
        Options.Filtering = False
        Width = 83
      end
      object grdTransferDBCostPrice: TcxGridDBColumn
        DataBinding.FieldName = 'CostPrice'
        Options.Filtering = False
        Width = 78
      end
      object grdTransferDBCostTotal: TcxGridDBColumn
        DataBinding.FieldName = 'CostTotal'
        Options.Filtering = False
        Width = 81
      end
    end
    object grdTransferLevel: TcxGridLevel
      GridView = grdTransferDB
    end
  end
  object quTransfer: TPowerADOQuery [5]
    Connection = DM.ADODBConnect
    AfterOpen = quTransferAfterOpen
    OnCalcFields = quTransferCalcFields
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#9#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'MT.IDModelTra' +
      'nsfDet,'#13#10#9'MT.IDModelTransf,'#13#10#9'MT.Qty as QtyTransfer,'#13#10#9'MT.CostPr' +
      'ice'#13#10'FROM '#13#10#9'ModelTransfDet MT (NOLOCK) '#13#10#9'JOIN Model M (NOLOCK)' +
      '  ON (MT.IDModel = M.IDModel)'#13#10#9'JOIN ModelTransf MTR (NOLOCK)  O' +
      'N (MTR.IDModelTransf = MT.IDModelTransf)'#13#10'WHERE '#13#10#9'MTR.IDModelTr' +
      'ansf = :IDModelTransf'#13#10#9'AND'#13#10#9'IsNull(MTR.Imported,0) = 0'
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 124
    Top = 84
    object quTransferIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quTransferModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quTransferDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quTransferIDModelTransfDet: TIntegerField
      FieldName = 'IDModelTransfDet'
    end
    object quTransferIDModelTransf: TIntegerField
      FieldName = 'IDModelTransf'
    end
    object quTransferCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quTransferCostTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'CostTotal'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quTransferQtyTransfer: TFloatField
      FieldName = 'QtyTransfer'
      DisplayFormat = '0.#####'
    end
  end
  object dsTransfer: TDataSource [6]
    DataSet = quTransfer
    Left = 124
    Top = 140
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmTransferImport.sil'
  end
  object cmdInsModelTransfDet: TADOCommand
    CommandText = 
      'INSERT ModelTransfDet'#13#10#9'('#13#10#9'IDModelTransfDet,'#13#10#9'IDModelTransf,'#13#10 +
      #9'IDModel,'#13#10#9'Qty,'#13#10#9'CostPrice,'#13#10#9'Tax,'#13#10#9'AvgCost,'#13#10#9'IDLote'#13#10#9')'#13#10'VA' +
      'LUES'#13#10#9'('#13#10#9':IDModelTransfDet,'#13#10#9':IDTransfIN,'#13#10#9':ModelID,'#13#10#9':Qty,' +
      #13#10#9':CostPrice,'#13#10#9':Tax,'#13#10#9':AvgCost,'#13#10#9':IDLote'#13#10#9')'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModelTransfDet'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTransfIN'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ModelID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 38
        Size = 19
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Tax'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'AvgCost'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDLote'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 216
    Top = 84
  end
end
