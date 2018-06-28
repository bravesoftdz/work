inherited WizImportPerson: TWizImportPerson
  Caption = 'WizImportPerson'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    Width = 686
    inherited tsConfigFile: TTabSheet
      inherited cbxBKPDevice: TGroupBox
        Top = 93
        Height = 93
        inherited lbDelimiter: TLabel
          Left = 152
          Top = 54
          Visible = False
        end
        inherited edtDecimalDelimiter: TEdit
          Left = 244
          Top = 50
          Visible = False
        end
      end
    end
    inherited tsSpecificConfig: TTabSheet
      object Label19: TLabel
        Left = 413
        Top = 118
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
      object gbVendorCatalogue: TGroupBox
        Left = 108
        Top = 65
        Width = 481
        Height = 196
        Caption = '  Person file information  '
        TabOrder = 0
        object Label13: TLabel
          Left = 42
          Top = 57
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Store :'
        end
        object Label2: TLabel
          Left = 9
          Top = 89
          Width = 66
          Height = 13
          Alignment = taRightJustify
          Caption = 'Person Type :'
        end
        object Label18: TLabel
          Left = 373
          Top = 118
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
        object Label14: TLabel
          Left = 48
          Top = 120
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Caption = 'User :'
        end
        object Label3: TLabel
          Left = 373
          Top = 54
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
        object Label4: TLabel
          Left = 373
          Top = 86
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
        object Label5: TLabel
          Left = 19
          Top = 149
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Verify Exist :'
        end
        object cbxStore: TcxLookupComboBox
          Left = 85
          Top = 51
          Width = 286
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'IDStore'
          Properties.ListColumns = <
            item
              FieldName = 'Store'
            end>
          Properties.ListOptions.GridLines = glNone
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = DMImportExport.dtsLookupStore
          Style.BorderStyle = ebs3D
          TabOrder = 0
        end
        object cbxUser: TcxLookupComboBox
          Left = 84
          Top = 116
          Width = 286
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'IDUser'
          Properties.ListColumns = <
            item
              FieldName = 'User'
            end>
          Properties.ListOptions.GridLines = glNone
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = DMImportExport.dtsLookupUser
          Style.BorderStyle = ebs3D
          TabOrder = 1
        end
        object cbPersonType: TComboBox
          Left = 84
          Top = 84
          Width = 286
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          Items.Strings = (
            'Customer '
            'Vendor'
            'Commissioned '
            'Salesman '
            'Guides '
            'Agency '
            'Manufacturer '
            'Another '
            'Prospects')
        end
        object cbVerify: TComboBox
          Left = 84
          Top = 146
          Width = 77
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          Items.Strings = (
            'IDNumber'
            'TaxNumber'
            'Phone')
        end
      end
    end
    inherited tsDatabase: TTabSheet
      inherited grdFile: TcxGrid
        Width = 678
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
        end
      end
    end
    inherited tsCrossColumn: TTabSheet
      inherited sgColumns: TStringGrid
        OnExit = sgColumnsExit
        ColWidths = (
          95
          95)
      end
    end
  end
end
