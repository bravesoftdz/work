inherited RepGroupListFilter: TRepGroupListFilter
  Caption = 'RepGroupListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btAddAll: TSpeedButton
    Left = 339
  end
  inherited btAdd: TSpeedButton
    Left = 339
  end
  inherited btRemove: TSpeedButton
    Left = 339
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
end
