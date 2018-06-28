inherited RepDefectTypeListFilter: TRepDefectTypeListFilter
  Left = 275
  Top = 253
  Caption = 'RepDefectTypeListFilter'
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
