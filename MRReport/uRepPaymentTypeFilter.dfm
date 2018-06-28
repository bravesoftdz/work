inherited RepPaymentTypeFilter: TRepPaymentTypeFilter
  Caption = 'RepPaymentTypeFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDMeioPag'
    Properties.ListColumns = <
      item
        FieldName = 'MeioPag'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspPaymentType'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
