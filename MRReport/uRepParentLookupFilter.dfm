inherited RepParentLookupFilter: TRepParentLookupFilter
  Left = 307
  Top = 79
  Caption = 'RepParentLookupFilter'
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lcFilter: TcxLookupComboBox [1]
    Left = 141
    Top = 4
    Width = 273
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.GridLines = glNone
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dsFilter
    TabOrder = 0
  end
  object cdsFilter: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 196
  end
  object dsFilter: TDataSource
    DataSet = cdsFilter
    Left = 248
  end
end
