object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 109
  Top = 115
  Height = 551
  Width = 900
  object ADODatabaseConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=GoldenCoastDB;Data Source=RCOSTA-NOTEBOOK;Use Procedu' +
      're for Prepare=1;Auto Translate=True;Packet Size=4096;Workstatio' +
      'n ID=RCOSTA-NOTEBOOK'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 60
    Top = 5
  end
  object qryLookUpState: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT S.IDState, S.StateName'
      ''
      'FROM Sys_State S '
      ''
      'ORDER BY S.StateName')
    SecondFieldType = ftString
    ListField = 'StateName'
    CodeField = 'IDState'
    LookUpField = 'IDState'
    OnClickButton = qryLookupStateClickButton
    Left = 390
    Top = 120
    object qryLookUpStateIDState: TAutoIncField
      FieldName = 'IDState'
      ReadOnly = True
    end
    object qryLookUpStateStateName: TStringField
      FieldName = 'StateName'
      Size = 50
    end
  end
  object dsLookUpState: TDataSource
    DataSet = qryLookUpState
    Left = 390
    Top = 170
  end
  object qryLookupCity: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT C.IDCity, C.CityName'
      ''
      'FROM Sys_City C'
      ''
      'ORDER BY C.CityName')
    SecondFieldType = ftString
    ListField = 'CityName'
    CodeField = 'IDCity'
    LookUpField = 'IDCity'
    OnClickButton = qryLookupCityClickButton
    Left = 385
    Top = 10
    object qryLookupCityIDCity: TAutoIncField
      FieldName = 'IDCity'
      ReadOnly = True
    end
    object qryLookupCityCityName: TStringField
      FieldName = 'CityName'
      Size = 30
    end
  end
  object dsLookupCity: TDataSource
    DataSet = qryLookupCity
    Left = 385
    Top = 60
  end
  object qryLookupCompany: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT C.IDCompany, C.CompanyName'
      ''
      'FROM Sys_Company C'
      ''
      'ORDER BY C.CompanyName')
    SecondFieldType = ftString
    ListField = 'CompanyName'
    CodeField = 'IDCompany'
    LookUpField = 'IDCompany'
    OnClickButton = qryLookupCityClickButton
    Left = 290
    Top = 240
    object qryLookupCompanyIDCompany: TIntegerField
      FieldName = 'IDCompany'
    end
    object qryLookupCompanyCompanyName: TStringField
      FieldName = 'CompanyName'
      Size = 50
    end
  end
  object dsLookupCompany: TDataSource
    DataSet = qryLookupCompany
    Left = 290
    Top = 295
  end
  object qryLookupCountry: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT C.IDCountry, C.CountryName '
      ''
      'FROM Sys_Country C'
      ''
      'ORDER BY C.CountryName')
    SecondFieldType = ftString
    ListField = 'CountryName'
    CodeField = 'IDCountry'
    LookUpField = 'IDCountry'
    OnClickButton = qryLookupCountryClickButton
    Left = 285
    Top = 120
    object qryLookupCountryIDCountry: TAutoIncField
      FieldName = 'IDCountry'
      ReadOnly = True
    end
    object qryLookupCountryCountryName: TStringField
      FieldName = 'CountryName'
      Size = 30
    end
  end
  object dsLookupCountry: TDataSource
    DataSet = qryLookupCountry
    Left = 285
    Top = 175
  end
  object qryLookupGroup: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT G.IDGroup, G.GroupName'
      ''
      'FROM Sys_Group G'
      ''
      'ORDER BY G.GroupName')
    SecondFieldType = ftString
    ListField = 'GroupName'
    CodeField = 'IDGroup'
    LookUpField = 'IDGroup'
    OnClickButton = qryLookupGroupClickButton
    Left = 280
    Top = 10
    object qryLookupGroupIDGroup: TAutoIncField
      FieldName = 'IDGroup'
      ReadOnly = True
    end
    object qryLookupGroupGroupName: TStringField
      FieldName = 'GroupName'
      Size = 40
    end
  end
  object dsLookupGroup: TDataSource
    DataSet = qryLookupGroup
    Left = 280
    Top = 60
  end
  object qryRebuildIdent: TADOQuery
    Connection = ADODatabaseConnect
    Parameters = <>
    SQL.Strings = (
      'exec sp_system_dbTables @table_type = "'#39'TABLE'#39'"')
    Left = 25
    Top = 370
    object qryRebuildIdentTABLE_NAME: TStringField
      FieldName = 'TABLE_NAME'
      ReadOnly = True
      Size = 255
    end
  end
  object qryFreeSQL: TADOQuery
    Connection = ADODatabaseConnect
    Parameters = <>
    Left = 25
    Top = 425
  end
  object qryLookupHotelCateg: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'HC.IDHotelCategory,'
      #9'HC.HotelCategoryName'
      'FROM '
      #9'Tbl_HotelCategory HC'
      ''
      'ORDER BY '
      '                HC.HotelCategoryName')
    SecondFieldType = ftString
    ListField = 'HotelCategoryName'
    CodeField = 'IDHotelCategory'
    LookUpField = 'IDHotelCategory'
    OnClickButton = qryLookupHotelCategClickButton
    Left = 395
    Top = 235
    object qryLookupHotelCategIDHotelCategory: TAutoIncField
      FieldName = 'IDHotelCategory'
      ReadOnly = True
    end
    object qryLookupHotelCategHotelCategoryName: TStringField
      FieldName = 'HotelCategoryName'
    end
  end
  object dsLookupHotelCateg: TDataSource
    DataSet = qryLookupHotelCateg
    Left = 395
    Top = 295
  end
  object dsLookupContact: TDataSource
    DataSet = qryLookupContact
    Left = 285
    Top = 415
  end
  object qryLookupContact: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'C.IDContact,'
      #9'C.ContactName'
      'FROM '
      #9'Tbl_Contact C'
      'ORDER BY '
      '                C.ContactName')
    SecondFieldType = ftString
    ListField = 'ContactName'
    CodeField = 'IDContact'
    LookUpField = 'IDContact'
    OnClickButton = qryLookupContactClickButton
    Left = 285
    Top = 360
    object qryLookupContactIDContact: TAutoIncField
      FieldName = 'IDContact'
      ReadOnly = True
    end
    object qryLookupContactContactName: TStringField
      FieldName = 'ContactName'
      Size = 30
    end
  end
  object qryLookUpAccomType: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'A.IDAccommodationType,'
      #9'A.AccommodationTypeName'
      'FROM'
      #9'Tbl_AccommodationType A'
      'ORDER BY'
      '        A.AccommodationTypeName'
      ' ')
    SecondFieldType = ftString
    ListField = 'AccommodationTypeName'
    CodeField = 'IDAccommodationType'
    LookUpField = 'IDAccommodationType'
    OnClickButton = qryLookUpAccomTypeClickButton
    Left = 395
    Top = 360
    object qryLookUpAccomTypeIDAccommodationType: TAutoIncField
      FieldName = 'IDAccommodationType'
      ReadOnly = True
    end
    object qryLookUpAccomTypeAccommodationTypeName: TStringField
      FieldName = 'AccommodationTypeName'
      Size = 50
    end
  end
  object dsLookUpAccomType: TDataSource
    DataSet = qryLookUpAccomType
    Left = 395
    Top = 415
  end
  object qryLookUpCarType: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'C.IDCarType,'
      #9'C.CarTypeName'
      'FROM'
      #9'Tbl_CarType C'
      'ORDER BY'
      '        C.CarTypeName'
      ' '
      ' ')
    SecondFieldType = ftString
    ListField = 'CarTypeName'
    CodeField = 'IDCarType'
    LookUpField = 'IDCarType'
    OnClickButton = qryLookUpCarTypeClickButton
    Left = 500
    Top = 360
    object qryLookUpCarTypeIDCarType: TAutoIncField
      FieldName = 'IDCarType'
      ReadOnly = True
    end
    object qryLookUpCarTypeCarTypeName: TStringField
      FieldName = 'CarTypeName'
      Size = 60
    end
  end
  object dsCarType: TDataSource
    DataSet = qryLookUpCarType
    Left = 500
    Top = 415
  end
  object qryLookupRoute: TLookUpADOQuery
    Connection = ADODatabaseConnect
    MaxRecords = 200
    Parameters = <>
    SQL.Strings = (
      'SELECT R.IDRoute, R.RouteName'
      ''
      'FROM tbl_Route R'
      ''
      'ORDER BY R.RouteName')
    SecondFieldType = ftString
    ListField = 'RouteName'
    CodeField = 'IDRoute'
    LookUpField = 'IDRoute'
    OnClickButton = qryLookupRouteClickButton
    Left = 485
    Top = 10
    object qryLookupRouteIDRoute: TAutoIncField
      FieldName = 'IDRoute'
      ReadOnly = True
    end
    object qryLookupRouteRouteName: TStringField
      FieldName = 'RouteName'
      Size = 100
    end
  end
  object dsLookupRoute: TDataSource
    DataSet = qryLookupRoute
    Left = 485
    Top = 65
  end
end
