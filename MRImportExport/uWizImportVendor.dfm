inherited WizImportVendor: TWizImportVendor
  Left = 218
  Top = 160
  Caption = 'Vendor Catalog Import '
  ClientHeight = 496
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    inherited tsConfigFile: TTabSheet
      inherited cbxBKPDevice: TGroupBox
        Top = 51
        Height = 190
        object Label4: TLabel [4]
          Left = 59
          Top = 155
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Vendor :'
        end
        object Label21: TLabel [5]
          Left = 396
          Top = 152
          Width = 12
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    inherited tsSpecificConfig: TTabSheet
      TabVisible = False
      object gbSupplier: TGroupBox
        Left = 117
        Top = 94
        Width = 442
        Height = 111
        Caption = '  Purchase Order file information  '
        TabOrder = 0
        object Label11: TLabel
          Left = 67
          Top = 48
          Width = 61
          Height = 13
          Alignment = taRightJustify
          Caption = 'PO Number :'
        end
        object edPONumber: TEdit
          Left = 136
          Top = 44
          Width = 81
          Height = 21
          TabOrder = 0
        end
      end
    end
    inherited tsList: TTabSheet
      inherited grdFile: TcxGrid
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
        end
      end
    end
    inherited tsFileFormat: TTabSheet
      inherited Label5: TLabel
        Top = 82
      end
      inherited cbxFileFormat: TComboBox
        Width = 110
        Items.Strings = (
          'DD'
          'MM'
          'YYYY'
          'PO#'
          'VendorCode'
          'Account#')
      end
      inherited btnAddFormat: TBitBtn
        Left = 289
        Width = 38
      end
      inherited GroupBox1: TGroupBox
        Width = 439
        Caption = '  File header config  '
        inherited cbxColumnsHeaderFile: TCheckBox
          Top = 18
          Caption = 'Insert columns header in the file'
        end
        inherited mHeaderConfig: TMemo
          Left = 210
          Top = 43
          Width = 219
        end
        inherited cbxHeaderConfig: TComboBox
          Top = 43
          Width = 151
          Items.Strings = (
            'Address'
            'City'
            'ZIP'
            'PO#'
            'Vendor Name')
        end
        inherited btnAddHeaderConfig: TBitBtn
          Left = 167
          Top = 43
          Width = 40
        end
        object btnClearList: TBitBtn
          Left = 167
          Top = 68
          Width = 40
          Height = 21
          Caption = 'Clear'
          TabOrder = 4
          OnClick = btnClearListClick
        end
      end
    end
  end
  inherited Panel1: TPanel
    Top = 453
    inherited btBack: TButton
      Left = 435
      Top = 12
    end
    inherited btNext: TButton
      Left = 517
      Top = 12
    end
    inherited btClose: TButton
      Left = 602
      Top = 12
    end
    inherited btHelp: TButton
      Left = 350
      Top = 12
    end
  end
end
