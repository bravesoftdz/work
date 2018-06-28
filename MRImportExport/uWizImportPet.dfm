inherited WizImportPet: TWizImportPet
  Caption = 'WizImportPet'
  ClientHeight = 488
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    Height = 383
    ActivePage = tsList
    inherited tsConfigFile: TTabSheet
      inherited cbxBKPDevice: TGroupBox
        Top = 66
      end
      object rgFileType: TGroupBox
        Left = 112
        Top = 188
        Width = 441
        Height = 109
        Caption = '  Vendor file type  '
        TabOrder = 1
        object rdHeaderFile: TRadioButton
          Left = 20
          Top = 67
          Width = 325
          Height = 17
          Caption = 'Header file'
          TabOrder = 0
        end
        object rdPuppyFile: TRadioButton
          Left = 20
          Top = 32
          Width = 293
          Height = 17
          Caption = 'PuppyTracker file'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
    end
    inherited tsSpecificConfig: TTabSheet
      TabVisible = False
    end
    inherited tsDatabase: TTabSheet
      Hint = 'List all data available on the file'
      Caption = 'File Data'
      inherited grdFile: TcxGrid
        Height = 352
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          OptionsData.Editing = True
        end
      end
    end
    inherited tsCrossColumn: TTabSheet
      Hint = 'Columns to be associates to the MRPet'
      inherited sgColumns: TStringGrid
        OnExit = sgColumnsExit
        ColWidths = (
          99
          95)
      end
    end
    object tsList: TTabSheet [4]
      Hint = 
        'All data listed will be imported. If the data is not valid, it w' +
        'ill display the error at to footer of each line.'
      Caption = 'List'
      ImageIndex = 5
      object grdListFile: TcxGrid
        Left = 0
        Top = 0
        Width = 677
        Height = 352
        Align = alClient
        TabOrder = 0
        object grdListFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OnCustomDrawCell = grdListFileTableViewCustomDrawCell
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Preview.Visible = True
        end
        object cxGridLevel1: TcxGridLevel
          GridView = grdListFileTableView
        end
      end
    end
    inherited tsImport: TTabSheet
      Hint = 'Click on Finish to complete the import'
      Caption = 'Finalize'
    end
  end
  inherited Panel1: TPanel
    Top = 449
  end
  inherited cdsFile: TClientDataSet
    AfterOpen = cdsFileAfterOpen
  end
  object cdsPetTreatment: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 412
    Top = 220
    object cdsPetTreatmentSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object cdsPetTreatmentMicrochip: TStringField
      FieldName = 'Microchip'
      Size = 50
    end
    object cdsPetTreatmentCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object cdsPetTreatmentTreatment: TStringField
      FieldName = 'Treatment'
      Size = 50
    end
    object cdsPetTreatmentTreatmentType: TIntegerField
      FieldName = 'TreatmentType'
    end
    object cdsPetTreatmentMfg: TStringField
      FieldName = 'Mfg'
      Size = 50
    end
    object cdsPetTreatmentTreatmentLotSize: TIntegerField
      FieldName = 'TreatmentLotSize'
    end
    object cdsPetTreatmentLotNumber: TStringField
      FieldName = 'LotNumber'
      Size = 30
    end
    object cdsPetTreatmentLotExpirationDate: TDateTimeField
      FieldName = 'LotExpirationDate'
    end
    object cdsPetTreatmentIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsPetTreatmentDosesUsed: TIntegerField
      FieldName = 'DosesUsed'
    end
    object cdsPetTreatmentTreatExpirationDate: TDateTimeField
      FieldName = 'TreatExpirationDate'
    end
    object cdsPetTreatmentTreatmentDate: TDateTimeField
      FieldName = 'TreatmentDate'
    end
    object cdsPetTreatmentNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object cdsPetTreatmentSpecies: TStringField
      FieldName = 'Species'
      Size = 10
    end
  end
end
