inherited WizImportCatalog: TWizImportCatalog
  Caption = 'Wizard Import Catalog'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    ActivePage = tsImport
    inherited tsConfigFile: TTabSheet
      Hint = 'Config File'
    end
    inherited tsSpecificConfig: TTabSheet
      object gbVendorCatalogue: TGroupBox
        Left = 108
        Top = 129
        Width = 441
        Height = 69
        Caption = ' Which Vendor belongs the catalogue?'
        TabOrder = 0
        object cbVendor: TComboBox
          Left = 12
          Top = 28
          Width = 145
          Height = 21
          ItemHeight = 0
          TabOrder = 0
        end
      end
    end
    inherited tsDatabase: TTabSheet
      inherited grdFile: TcxGrid
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
        end
      end
    end
    inherited tsImport: TTabSheet
      object Panel2: TPanel
        Left = 48
        Top = 44
        Width = 353
        Height = 193
        Caption = 'IMPORT'
        TabOrder = 0
      end
    end
  end
end
