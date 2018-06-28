inherited RepChartOfAccountFilter: TRepChartOfAccountFilter
  Caption = 'RepChartOfAccountFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDLancamentoTipo'
    Properties.ListColumns = <
      item
        FieldName = 'LancamentoTipo'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuChartOfAccount'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
