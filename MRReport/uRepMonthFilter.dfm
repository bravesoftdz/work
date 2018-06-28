inherited RepMonthFilter: TRepMonthFilter
  Caption = 'RepMonthFilter'
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cbxMonth: TcxComboBox [1]
    Left = 141
    Top = 4
    Width = 96
    Height = 21
    Properties.DropDownListStyle = lsFixedList
    Properties.Items.Strings = (
      'January'
      'February'
      'March'
      'April'
      'May'
      'June'
      'July'
      'August'
      'September'
      'October'
      'November'
      'December')
    TabOrder = 0
  end
end
