inherited PctMicrochipAddFrm: TPctMicrochipAddFrm
  Caption = 'Add Microchip'
  ClientHeight = 255
  ClientWidth = 367
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 76
    Top = 65
    Width = 49
    Height = 13
    Alignment = taRightJustify
    Caption = 'Barcode : '
  end
  object Label2: TLabel [1]
    Left = 63
    Top = 100
    Width = 62
    Height = 13
    Alignment = taRightJustify
    Caption = 'Model Num : '
  end
  object Label3: TLabel [2]
    Left = 62
    Top = 136
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Description : '
  end
  object Label4: TLabel [3]
    Left = 69
    Top = 172
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sale Price : '
  end
  object Label5: TLabel [4]
    Left = 275
    Top = 60
    Width = 14
    Height = 25
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel [5]
    Left = 275
    Top = 95
    Width = 14
    Height = 25
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel [6]
    Left = 275
    Top = 131
    Width = 14
    Height = 25
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel [7]
    Left = 275
    Top = 168
    Width = 14
    Height = 25
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 8404992
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBottom: TPanel
    Top = 227
    Width = 367
    TabOrder = 5
    inherited btnOk: TXiButton
      Left = 212
    end
    inherited btnCancel: TXiButton
      Left = 290
    end
  end
  object scMicrochip: TmrSuperCombo
    Left = 128
    Top = 24
    Width = 145
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
        Visible = False
      end>
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 0
    OnBeforeGetRecordsList = scMicrochipBeforeGetRecordsList
    DisableButtons = False
    ConnectionListName = 'LookUpInventoryConn'
    ProviderListName = 'dspLuCategory'
    EditLabel.Width = 99
    EditLabel.Height = 13
    EditLabel.Caption = 'Microchip Category :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
  end
  object edtBarcode: TcxTextEdit
    Left = 128
    Top = 60
    Width = 143
    Height = 21
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 1
  end
  object edtModel: TcxTextEdit
    Left = 128
    Top = 95
    Width = 143
    Height = 21
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 2
  end
  object edtDescription: TcxTextEdit
    Left = 128
    Top = 131
    Width = 143
    Height = 21
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 3
  end
  object edtSalePrice: TcxCurrencyEdit
    Left = 128
    Top = 167
    Width = 141
    Height = 21
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 4
  end
end
