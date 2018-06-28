inherited ParentWizExp: TParentWizExp
  Left = 60
  Top = 12
  BorderIcons = [biMaximize]
  Caption = 'ParentWizExp'
  ClientHeight = 495
  ClientWidth = 687
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    Left = 0
    Top = 62
    Width = 685
    Height = 387
    ActivePage = tsExport
    object tsConfigFile: TTabSheet
      Caption = 'Config File'
      object cbxBKPDevice: TGroupBox
        Left = 100
        Top = 76
        Width = 441
        Height = 161
        Caption = 'Config File'
        TabOrder = 0
        object sbOpenBKP: TSpeedButton
          Left = 290
          Top = 47
          Width = 23
          Height = 21
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0000000000000000000000000000000000000000000000000000000000
            00000000000000000000FF00FFFF00FF009E9C009E9C009E9C009E9C009E9C00
            9E9C009E9C009E9C009E9C009E9C009E9C009E9C000000000000FF00FFFF00FF
            009E9CFFFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF9CCFFF63CF
            CE009E9C000000000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CCFFF9CFFFF9C
            CFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000009E9C000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF009E
            9C000000009E9C000000009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9C
            FFFF9CFFFF9CCFFF9CFFFF63CFCE00000063CFCE63CFCE000000009E9CFFFFFF
            9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE0000
            0063CFCE63CFCE000000009E9C009E9C009E9C009E9C009E9C009E9C009E9C00
            9E9C009E9C009E9C009E9C009E9C63CFCE9CFFFF63CFCE000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
            FF9CFFFF63CFCE000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
            FFFF9CFFFF9CFFFFFFFFFFFFFFFFFFFFFFFFFFFF63CFCE000000FF00FF009E9C
            FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFFFFFFFF009E9C009E9C009E9C009E
            9C009E9C009E9CFF00FFFF00FFFF00FF009E9CFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF009E9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF009E9C009E9C009E9C009E9C009E9CFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = sbOpenBKPClick
        end
        object Label1: TLabel
          Left = 33
          Top = 90
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Text Delimiter :'
        end
        object Label2: TLabel
          Left = 17
          Top = 27
          Width = 154
          Height = 13
          Caption = 'Select the folder to save the files'
        end
        object Label3: TLabel
          Left = 16
          Top = 118
          Width = 87
          Height = 13
          Alignment = taRightJustify
          Caption = 'Decimal Delimiter :'
        end
        object edtPath: TEdit
          Left = 20
          Top = 46
          Width = 264
          Height = 21
          TabOrder = 0
        end
        object edtDelimiter: TEdit
          Left = 108
          Top = 86
          Width = 25
          Height = 21
          MaxLength = 1
          TabOrder = 1
          OnKeyPress = edtDelimiterKeyPress
        end
        object edtDecimalDelimiter: TEdit
          Left = 108
          Top = 114
          Width = 25
          Height = 21
          MaxLength = 1
          TabOrder = 2
          OnKeyPress = edtDecimalDelimiterKeyPress
        end
      end
    end
    object tsSpecificConfig: TTabSheet
      Caption = 'Specific Config'
      ImageIndex = 1
    end
    object tsList: TTabSheet
      Caption = 'List'
      ImageIndex = 2
      object Panel2: TPanel
        Left = 616
        Top = 0
        Width = 61
        Height = 356
        Align = alRight
        TabOrder = 0
        object btColumn: TSpeedButton
          Tag = 4
          Left = 3
          Top = 8
          Width = 54
          Height = 49
          AllowAllUp = True
          GroupIndex = 1235
          Caption = 'Colum&ns'
          Flat = True
          Margin = 6
          Spacing = 7
          OnClick = btColumnClick
        end
      end
      object grdFile: TcxGrid
        Left = 0
        Top = 0
        Width = 616
        Height = 356
        Align = alClient
        TabOrder = 1
        object grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
        end
        object grdFileLevel: TcxGridLevel
          GridView = grdFileTableView
        end
      end
    end
    object tsFileFormat: TTabSheet
      Caption = 'File format'
      ImageIndex = 4
      object Label5: TLabel
        Left = 120
        Top = 84
        Width = 54
        Height = 13
        Caption = 'File format :'
      end
      object lbInfo: TLabel
        Left = 120
        Top = 54
        Width = 33
        Height = 13
        Caption = 'lbInfo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbxFileFormat: TComboBox
        Left = 177
        Top = 79
        Width = 113
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'DD'
          'MM'
          'YYYY')
      end
      object btnAddFormat: TBitBtn
        Left = 291
        Top = 79
        Width = 36
        Height = 21
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnAddFormatClick
      end
      object edtFileFormat: TEdit
        Left = 330
        Top = 79
        Width = 221
        Height = 21
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 121
        Top = 120
        Width = 432
        Height = 177
        Caption = 'Header Config'
        TabOrder = 3
        object cbxColumnsHeaderFile: TCheckBox
          Left = 16
          Top = 25
          Width = 181
          Height = 17
          Caption = 'Insert Columns header in the file'
          TabOrder = 0
          OnClick = cbxColumnsHeaderFileClick
        end
        object mHeaderConfig: TMemo
          Left = 172
          Top = 52
          Width = 245
          Height = 113
          TabOrder = 1
        end
        object cbxHeaderConfig: TComboBox
          Left = 15
          Top = 52
          Width = 157
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          Items.Strings = (
            'address'
            'City'
            'CEP')
        end
        object btnAddHeaderConfig: TBitBtn
          Left = 134
          Top = 78
          Width = 36
          Height = 21
          Caption = 'Add'
          TabOrder = 3
          OnClick = btnAddHeaderConfigClick
        end
      end
    end
    object tsExport: TTabSheet
      Caption = 'Export'
      ImageIndex = 3
    end
  end
  inherited PTitle: TPanel
    Width = 687
    inherited ShapeImage: TShape
      Left = 611
    end
    inherited ImageClass: TImage
      Left = 617
    end
  end
  inherited Panel1: TPanel
    Top = 452
    Width = 687
    DesignSize = (
      687
      43)
    inherited bvBottom: TBevel
      Width = 687
    end
  end
  object OD: TOpenDialog
    Filter = 'All Files|*.*'
    Left = 338
    Top = 99
  end
  object cdsFile: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 414
    Top = 118
  end
  object dtsFile: TDataSource
    DataSet = cdsFile
    Left = 414
    Top = 166
  end
end
