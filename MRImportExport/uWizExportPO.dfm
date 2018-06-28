inherited WizExportPO: TWizExportPO
  Left = 230
  Top = 218
  Caption = 'WizExportPO'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    ActivePage = tsFileFormat
    inherited tsSpecificConfig: TTabSheet [0]
      OnShow = tsSpecificConfigShow
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
          OnKeyPress = edPONumberKeyPress
        end
      end
    end
    inherited tsList: TTabSheet [1]
      inherited grdFile: TcxGrid
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
        end
      end
    end
    inherited tsFileFormat: TTabSheet [2]
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
    inherited tsConfigFile: TTabSheet [3]
    end
  end
  inherited Panel1: TPanel
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
