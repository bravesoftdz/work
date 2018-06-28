inherited FrmImportTransferNumber: TFrmImportTransferNumber
  Left = 320
  Top = 211
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import Transfer Number'
  ClientHeight = 229
  ClientWidth = 370
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 43
    Top = 21
    Width = 85
    Height = 13
    Alignment = taRightJustify
    Caption = 'Transfer Number :'
  end
  inherited Panel1: TPanel
    Top = 188
    Width = 370
    TabOrder = 3
    inherited EspacamentoInferior: TPanel
      Width = 370
      inherited Panel3: TPanel
        Width = 370
      end
    end
    inherited hhh: TPanel
      Left = 149
      Width = 221
      inherited sbHelp: TSpeedButton
        Left = 9
        Visible = False
      end
      inherited btClose: TButton
        Left = 149
        Cancel = True
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 79
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Import'
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 182
    TabOrder = 4
  end
  inherited EspacamentoDireito: TPanel
    Left = 367
    Height = 182
    TabOrder = 5
  end
  inherited EspacamentoSuperior: TPanel
    Width = 370
    TabOrder = 6
  end
  object edtTransferNum: TEdit [5]
    Left = 132
    Top = 17
    Width = 145
    Height = 21
    MaxLength = 20
    TabOrder = 0
    OnChange = edtTransferNumChange
  end
  object grdTransfers: TcxGrid [6]
    Left = 4
    Top = 48
    Width = 362
    Height = 138
    TabOrder = 2
    LookAndFeel.Kind = lfFlat
    object grdTransfersDB: TcxGridDBTableView
      DataController.DataSource = dsTransfer
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModelTransf'
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
      object grdTransfersDBStoreOrigem: TcxGridDBColumn
        Caption = 'From'
        DataBinding.FieldName = 'StoreOrigem'
        Options.Filtering = False
        Width = 105
      end
      object grdTransfersDBStoreDestino: TcxGridDBColumn
        Caption = 'To'
        DataBinding.FieldName = 'StoreDestino'
        Options.Filtering = False
        Width = 125
      end
      object grdTransfersDBNumber: TcxGridDBColumn
        DataBinding.FieldName = 'Number'
        Options.Filtering = False
        Width = 61
      end
      object grdTransfersDBData: TcxGridDBColumn
        DataBinding.FieldName = 'Data'
        Options.Filtering = False
        Width = 69
      end
    end
    object grdTransfersLevel: TcxGridLevel
      GridView = grdTransfersDB
    end
  end
  object btnSearch: TBitBtn [7]
    Left = 284
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Search'
    Default = True
    TabOrder = 1
    OnClick = btnSearchClick
  end
  object quTransfer: TADODataSet [8]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'MT.IDModelTransf,'#13#10#9'MT.Data,'#13#10#9'SU.[SystemUser],'#13#10#9'SO.[N' +
      'ame] StoreOrigem,'#13#10#9'SD.[Name] StoreDestino,'#13#10#9'MT.Number,'#13#10#9'MT.Im' +
      'ported'#13#10'FROM'#13#10#9'ModelTransf MT (NOLOCK)'#13#10#9'JOIN Store SO (NOLOCK) ' +
      'ON (SO.IDStore = MT.IDLojaOrigem)'#13#10#9'JOIN Store SD (NOLOCK) ON (S' +
      'D.IDStore = MT.IDLojaDestino)'#13#10#9'JOIN [SystemUser] SU (NOLOCK) ON' +
      ' (SU.IDUser = MT.IDUser)'#13#10'WHERE'#13#10#9'MT.Number like '#39'%'#39' + :Number +' +
      ' '#39'%'#39#13#10#9'AND '#13#10#9'MT.TransferType = 0'#13#10
    Parameters = <
      item
        Name = 'Number'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 92
    Top = 16
    object quTransferIDModelTransf: TIntegerField
      FieldName = 'IDModelTransf'
    end
    object quTransferImported: TBooleanField
      FieldName = 'Imported'
    end
    object quTransferData: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'Data'
      DisplayFormat = 'ddddd'
    end
    object quTransferSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quTransferStoreOrigem: TStringField
      DisplayLabel = 'FROM'
      FieldName = 'StoreOrigem'
      Size = 30
    end
    object quTransferStoreDestino: TStringField
      DisplayLabel = 'TO'
      FieldName = 'StoreDestino'
      Size = 30
    end
    object quTransferNumber: TStringField
      FieldName = 'Number'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmImportTransferNumber.sil'
  end
  object dsTransfer: TDataSource
    DataSet = quTransfer
    Left = 92
    Top = 68
  end
end
