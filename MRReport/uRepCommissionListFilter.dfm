inherited RepCommissionListFilter: TRepCommissionListFilter
  Caption = 'RepCommissionListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDPessoa'
    Properties.ListColumns = <
      item
        FieldName = 'Pessoa'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuCommission'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
