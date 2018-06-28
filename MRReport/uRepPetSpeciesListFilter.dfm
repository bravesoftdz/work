inherited RepPetSpeciesListFilter: TRepPetSpeciesListFilter
  Left = 262
  Top = 239
  Caption = 'RepPetSpeciesListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 94
    Width = 43
    Caption = 'Species :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDSpecies'
    Properties.ListColumns = <
      item
        FieldName = 'Species'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuPetSpecies'
    RemoteServer = DMReport.LuPetConn
  end
end
