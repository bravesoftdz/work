inherited PctPetTreatmentSearch: TPctPetTreatmentSearch
  Caption = 'PctPetTreatmentSearch'
  ClientHeight = 324
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Height = 69
    inherited pnlFilter: TPanel
      Height = 69
      object lbTreatmentType: TLabel [0]
        Left = 9
        Top = 11
        Width = 84
        Height = 13
        Alignment = taRightJustify
        Caption = 'Treatment Type :'
      end
      object lbMfg: TLabel [1]
        Left = 68
        Top = 39
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Mfg :'
      end
      inherited pnlRefresh: TPanel
        Top = 17
        TabOrder = 2
      end
      object cbxTreatmentType: TcxImageComboBox
        Left = 99
        Top = 8
        Width = 121
        Height = 21
        Properties.Items = <
          item
            Description = 'Vaccine'
            Value = 1
          end
          item
            Description = 'Wormer'
            Value = 2
          end
          item
            Description = 'Preventative'
            Value = 3
          end>
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 0
      end
      object edtMfg: TcxTextEdit
        Left = 99
        Top = 37
        Width = 121
        Height = 21
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 1
      end
    end
  end
  inherited pnlLeft: TPanel
    Top = 69
    Height = 227
  end
  inherited pnlBottom: TPanel
    Top = 296
  end
  inherited pnlRight: TPanel
    Top = 69
    Height = 227
  end
  inherited grdList: TcxGrid
    Top = 69
    Height = 227
    inherited grdListDBTableView: TcxGridDBTableView
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDTreatment'
      object grdListDBTableViewTreatment: TcxGridDBColumn
        DataBinding.FieldName = 'Treatment'
        Options.Filtering = False
        Width = 147
      end
      object grdListDBTableViewMfg: TcxGridDBColumn
        DataBinding.FieldName = 'Mfg'
        Options.Filtering = False
        Width = 157
      end
      object grdListDBTableViewTreatmentLotSize: TcxGridDBColumn
        Caption = 'Lot Size'
        DataBinding.FieldName = 'TreatmentLotSize'
        Options.Filtering = False
        Width = 77
      end
    end
  end
  inherited cdsSearch: TClientDataSet
    ProviderName = 'dspSearchTreatment'
    RemoteServer = DMPet.SearchPetConn
    BeforeGetRecords = cdsSearchBeforeGetRecords
    object cdsSearchIDTreatment: TIntegerField
      FieldName = 'IDTreatment'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsSearchTreatment: TStringField
      FieldName = 'Treatment'
      Size = 50
    end
    object cdsSearchMfg: TStringField
      FieldName = 'Mfg'
      Size = 50
    end
    object cdsSearchTreatmentLotSize: TIntegerField
      FieldName = 'TreatmentLotSize'
    end
  end
end
