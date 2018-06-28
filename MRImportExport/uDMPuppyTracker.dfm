object DMPuppyTracker: TDMPuppyTracker
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 328
  Top = 241
  Height = 427
  Width = 527
  object cdsPup: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 44
    Top = 24
    object cdsPupPuppy_No: TStringField
      FieldName = 'Puppy_No'
      Size = 50
    end
    object cdsPupBreed: TStringField
      FieldName = 'Breed'
      Size = 5
    end
    object cdsPupSex: TStringField
      FieldName = 'Sex'
      Size = 15
    end
    object cdsPupPur_Price: TCurrencyField
      FieldName = 'Pur_Price'
    end
    object cdsPupWeight: TCurrencyField
      FieldName = 'Weight'
    end
    object cdsPupColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object cdsPupUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object cdsPupSales_Price: TCurrencyField
      FieldName = 'Sales_Price'
    end
    object cdsPupChip_No: TStringField
      FieldName = 'Chip_No'
      Size = 50
    end
    object cdsPupDied_Date: TDateTimeField
      FieldName = 'Died_Date'
    end
    object cdsPupComments: TStringField
      FieldName = 'Comments'
      Size = 255
    end
    object cdsPupInvoice_Date: TDateTimeField
      FieldName = 'Invoice_Date'
    end
    object cdsPupDate_Purchased: TDateTimeField
      FieldName = 'Date_Purchased'
    end
    object cdsPupLitter_No: TStringField
      FieldName = 'Litter_No'
    end
    object cdsPupDefects: TStringField
      FieldName = 'Defects'
      Size = 150
    end
    object cdsPupSurgery: TStringField
      FieldName = 'Surgery'
      Size = 150
    end
    object cdsPupInv_Comments: TStringField
      FieldName = 'Inv_Comments'
      Size = 255
    end
  end
  object cdsLitters: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 88
    object cdsLittersLitter_No: TStringField
      FieldName = 'Litter_No'
    end
    object cdsLittersDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object cdsLittersSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object cdsLittersBreeder: TStringField
      FieldName = 'Breeder'
    end
    object cdsLittersRegistry_No: TStringField
      FieldName = 'Registry_No'
      Size = 50
    end
    object cdsLittersWhelp_Date: TDateTimeField
      FieldName = 'Whelp_Date'
    end
    object cdsLittersRegistry: TStringField
      FieldName = 'Registry'
      Size = 50
    end
    object cdsLittersLitter_Pur_Date: TDateTimeField
      FieldName = 'Litter_Pur_Date'
    end
  end
  object cdsBreed: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 148
    object cdsBreedBreed_Code: TStringField
      FieldName = 'Breed_Code'
      Size = 5
    end
    object cdsBreedBreed_Name: TStringField
      FieldName = 'Breed_Name'
      Size = 50
    end
    object cdsBreedSpecies: TStringField
      FieldName = 'Species'
      Size = 10
    end
  end
  object cdsBreeder: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 212
    object cdsBreederBreeder: TStringField
      FieldName = 'Breeder'
    end
    object cdsBreederAddress1: TStringField
      FieldName = 'Address1'
      Size = 80
    end
    object cdsBreederCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object cdsBreederState: TStringField
      FieldName = 'State'
      Size = 50
    end
    object cdsBreederZip: TStringField
      FieldName = 'Zip'
      Size = 12
    end
    object cdsBreederFirst_Name: TStringField
      FieldName = 'First_Name'
      Size = 30
    end
    object cdsBreederLast_Name: TStringField
      FieldName = 'Last_Name'
      Size = 30
    end
  end
  object cdsHouseShots: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 188
    Top = 24
    object cdsHouseShotsVaccine_Code: TStringField
      FieldName = 'Vaccine_Code'
      Size = 5
    end
    object cdsHouseShotsManu_Code: TStringField
      FieldName = 'Manu_Code'
      Size = 5
    end
    object cdsHouseShotsWeek_Ending_Date: TDateTimeField
      FieldName = 'Week_Ending_Date'
    end
    object cdsHouseShotsSpecies: TStringField
      FieldName = 'Species'
      Size = 10
    end
    object cdsHouseShotsLot: TStringField
      FieldName = 'Lot'
      Size = 30
    end
    object cdsHouseShotsExpires: TDateTimeField
      FieldName = 'Expires'
    end
    object cdsHouseShotsDates_Given: TStringField
      FieldName = 'Dates_Given'
      Size = 50
    end
  end
  object cdsPuppyShots: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 188
    Top = 88
    object cdsPuppyShotsPuppy_No: TStringField
      FieldName = 'Puppy_No'
      Size = 50
    end
    object cdsPuppyShotsVaccine_Code: TStringField
      FieldName = 'Vaccine_Code'
      Size = 5
    end
    object cdsPuppyShotsManu_Code: TStringField
      FieldName = 'Manu_Code'
      Size = 5
    end
    object cdsPuppyShotsLot: TStringField
      FieldName = 'Lot'
      Size = 30
    end
    object cdsPuppyShotsExpires: TDateTimeField
      FieldName = 'Expires'
    end
    object cdsPuppyShotsDates_Given: TStringField
      FieldName = 'Dates_Given'
      Size = 50
    end
  end
  object cdsVaccines: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 148
    object cdsVaccinesVaccine_Code: TStringField
      FieldName = 'Vaccine_Code'
      Size = 5
    end
    object cdsVaccinesType: TIntegerField
      FieldName = 'Type'
    end
    object cdsVaccinesVaccine_Name: TStringField
      FieldName = 'Vaccine_Name'
      Size = 50
    end
  end
  object cdsVaccManu: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 212
    object cdsVaccManuManu_Code: TStringField
      FieldName = 'Manu_Code'
      Size = 5
    end
    object cdsVaccManuManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
  end
  object cdsDefects: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 272
    object cdsDefectsDefect_Code: TStringField
      FieldName = 'Defect_Code'
      Size = 10
    end
    object cdsDefectsdefect_description: TStringField
      FieldName = 'defect_description'
      Size = 50
    end
  end
  object cdsPedigrees: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 332
    object cdsPedigreesregistrycode: TStringField
      FieldName = 'registrycode'
      Size = 50
    end
    object cdsPedigreesakc_registry: TStringField
      FieldName = 'akc_registry'
    end
    object cdsPedigreesdog_name: TStringField
      FieldName = 'dog_name'
      Size = 50
    end
    object cdsPedigreessire_name: TStringField
      FieldName = 'sire_name'
      Size = 200
    end
    object cdsPedigreesdam_name: TStringField
      FieldName = 'dam_name'
      Size = 200
    end
  end
end
