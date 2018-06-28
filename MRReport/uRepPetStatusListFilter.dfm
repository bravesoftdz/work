inherited RepPetStatusListFilter: TRepPetStatusListFilter
  Caption = 'RepPetStatusListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 99
    Width = 38
    Caption = 'Status :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDStatus'
    Properties.ListColumns = <
      item
        FieldName = 'Status'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuPetStatus'
    RemoteServer = DMReport.LuPetConn
  end
end
