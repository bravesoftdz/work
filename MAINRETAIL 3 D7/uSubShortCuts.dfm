inherited SubShortCuts: TSubShortCuts
  Left = 395
  Top = 194
  Width = 167
  Height = 190
  Caption = 'SubShortCuts'
  PixelsPerInch = 96
  TextHeight = 13
  object Panel11: TPanel [0]
    Left = -1
    Top = 0
    Width = 157
    Height = 162
    BevelOuter = bvNone
    Color = 14044716
    TabOrder = 0
    object Panel12: TPanel
      Left = 0
      Top = 0
      Width = 157
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      Color = 14044716
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        157
        17)
      object Shape6: TShape
        Left = 0
        Top = 4
        Width = 158
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Pen.Style = psClear
        Shape = stRoundRect
      end
      object Label12: TLabel
        Left = 54
        Top = 2
        Width = 54
        Height = 16
        Alignment = taCenter
        Caption = 'Shortcuts'
        Font.Charset = ANSI_CHARSET
        Font.Color = 14044716
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object sbShowShotCuts: TSpeedButton
        Left = 139
        Top = 4
        Width = 14
        Height = 13
        Caption = '+'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = 14044716
        Font.Height = -8
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlShortCutInv: TPanel
      Left = 0
      Top = 17
      Width = 157
      Height = 145
      Align = alBottom
      BevelOuter = bvNone
      Color = 14044716
      TabOrder = 1
      Visible = False
      object Label11: TLabel
        Left = 29
        Top = 4
        Width = 100
        Height = 13
        Caption = 'Press (Alt + number)'
        Color = 14044716
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object SpeedButton1: TSpeedButton
        Left = 1
        Top = 19
        Width = 155
        Height = 18
        Caption = '(&1) View Inventory'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
      end
      object SpeedButton2: TSpeedButton
        Left = 1
        Top = 37
        Width = 155
        Height = 18
        Caption = '(&2) Request'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
      end
      object SpeedButton3: TSpeedButton
        Left = 1
        Top = 55
        Width = 155
        Height = 18
        Caption = '(&3) Time Clock'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
      end
      object SpeedButton4: TSpeedButton
        Left = 1
        Top = 73
        Width = 155
        Height = 18
        Caption = '(&4) Customer'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
      end
      object SpeedButton5: TSpeedButton
        Left = 1
        Top = 91
        Width = 155
        Height = 18
        Caption = '(&5) Invoice History'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
        Spacing = 7
      end
      object SpeedButton6: TSpeedButton
        Left = 1
        Top = 109
        Width = 155
        Height = 18
        Caption = '(&6) Full Inventory'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
        Spacing = 7
      end
      object SpeedButton7: TSpeedButton
        Left = 1
        Top = 127
        Width = 155
        Height = 18
        Caption = '(&7) PO'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Margin = 2
        ParentFont = False
        Spacing = 7
      end
    end
  end
end
