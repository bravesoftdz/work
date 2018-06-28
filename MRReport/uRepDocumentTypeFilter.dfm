inherited RepDocumentTypeFilter: TRepDocumentTypeFilter
  Caption = 'RepDocumentTypeFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDDocumentoTipo'
    Properties.ListColumns = <
      item
        FieldName = 'DocumentoTipo'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuDocumentType'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
