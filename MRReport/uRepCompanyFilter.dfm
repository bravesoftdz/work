inherited RepCompanyFilter: TRepCompanyFilter
  Caption = 'RepCompanyFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDEmpresa'
    Properties.ListColumns = <
      item
        FieldName = 'Empresa'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuCompany'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
