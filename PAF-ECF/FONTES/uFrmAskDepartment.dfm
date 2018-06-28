inherited FrmAskDepartment: TFrmAskDepartment
  Left = 261
  Top = 304
  Width = 495
  Height = 276
  Caption = 'Ask Department'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlButtom: TPanel
    Top = 201
    Width = 487
    inherited hhh: TPanel
      Left = 263
      Width = 224
      inherited spHelp: TSpeedButton
        Left = 15
      end
      inherited btClose: TButton
        Left = 156
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 86
        Top = 6
        Width = 66
        Height = 31
        Caption = 'OK'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 199
    Width = 487
  end
  object grdDepartment: TDBGrid [2]
    Left = 0
    Top = 0
    Width = 487
    Height = 199
    Align = alClient
    DataSource = dtsDepartment
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Department'
        Width = 445
        Visible = True
      end>
  end
  object dtsDepartment: TDataSource
    Left = 40
    Top = 64
  end
end
