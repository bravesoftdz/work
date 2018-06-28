inherited RepGuideListFilter: TRepGuideListFilter
  Caption = 'RepGuideListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDGuide'
    Properties.ListColumns = <
      item
        FieldName = 'Guide'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuGuide'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
