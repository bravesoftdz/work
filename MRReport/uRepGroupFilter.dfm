inherited RepGroupFilter: TRepGroupFilter
  Left = 377
  Top = 440
  Caption = 'RepGroupFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Top = 8
    Width = 36
    Caption = 'Group :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDGroup'
    Properties.ListColumns = <
      item
        FieldName = 'Group'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuGroup'
    RemoteServer = DMReport.LuInventoryConn
  end
  inherited dsFilter: TDataSource
    Left = 244
  end
end
