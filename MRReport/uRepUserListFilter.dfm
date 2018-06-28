inherited RepUserListFilter: TRepUserListFilter
  Caption = 'RepUserListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDUser'
    Properties.ListColumns = <
      item
        FieldName = 'SystemUser'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuUser'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
