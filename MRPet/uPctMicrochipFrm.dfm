inherited PctMicrochipFrm: TPctMicrochipFrm
  Left = 260
  Top = 242
  Caption = 'Microchip'
  ClientHeight = 281
  ClientWidth = 412
  KeyPreview = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 253
    Width = 412
    TabOrder = 1
    inherited btnOk: TXiButton
      Left = 257
      Top = 4
    end
    inherited btnCancel: TXiButton
      Left = 335
      Top = 4
    end
  end
  object grdMicrochip: TcxGrid
    Left = 9
    Top = 14
    Width = 394
    Height = 239
    TabOrder = 0
    object grdMicrochipDB: TcxGridDBTableView
      DataController.DataSource = dsMicrochip
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDMicrochip'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdMicrochipDBMicrochip: TcxGridDBColumn
        DataBinding.FieldName = 'Microchip'
        Options.Editing = False
        Options.Filtering = False
        Width = 255
      end
      object grdMicrochipDBAmount: TcxGridDBColumn
        DataBinding.FieldName = 'Amount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Filtering = False
        Width = 100
      end
    end
    object grdMicrochipLevel: TcxGridLevel
      GridView = grdMicrochipDB
    end
  end
  object cdsMicrochip: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMicrochip'
    RemoteServer = DMPet.PetCenterConn
    Left = 72
    Top = 56
  end
  object dsMicrochip: TDataSource
    DataSet = cdsMicrochip
    Left = 76
    Top = 108
  end
end
