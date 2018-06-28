inherited RepPaymentTypeListFilter: TRepPaymentTypeListFilter
  Left = 334
  Top = 195
  Caption = 'RepPaymentTypeListFilter'
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
