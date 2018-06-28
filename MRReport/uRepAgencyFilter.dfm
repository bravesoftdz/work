inherited RepAgencyFilter: TRepAgencyFilter
  Caption = 'RepAgencyFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDAgency'
    Properties.ListColumns = <
      item
        FieldName = 'Agency'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuAgency'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
