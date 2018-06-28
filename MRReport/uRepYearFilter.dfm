inherited RepYearFilter: TRepYearFilter
  Caption = 'RepYearFilter'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited seNumber: TcxSpinEdit
    Width = 56
    Properties.MaxValue = 3000.000000000000000000
    Properties.MinValue = 1900.000000000000000000
    Value = 1900
  end
end
