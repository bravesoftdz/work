inherited RepPetBreedListFilter: TRepPetBreedListFilter
  Caption = 'RepPetBreedListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 102
    Width = 35
    Caption = 'Breed :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDBreed'
    Properties.ListColumns = <
      item
        FieldName = 'Breed'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuPetBreed'
    RemoteServer = DMReport.LuPetConn
  end
end
