inherited RepDefectTypeFilter: TRepDefectTypeFilter
  Left = 280
  Top = 221
  Caption = 'RepDefectTypeFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 71
    Width = 66
    Caption = 'Defect Type :'
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuDefectType'
    RemoteServer = DMReport.LuInventoryConn
  end
end
