inherited ParentWizImp: TParentWizImp
  Left = 326
  Top = 230
  Caption = 'ParentWizImp'
  ClientHeight = 483
  ClientWidth = 687
  DesignSize = (
    687
    483)
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    Left = 0
    Top = 62
    Width = 685
    Height = 378
    ActivePage = tsCrossColumn
    Anchors = [akLeft, akTop, akRight, akBottom]
    object tsConfigFile: TTabSheet
      Hint = '  Select a text file that contain the data to import  '
      Caption = 'Config File'
      object cbxBKPDevice: TGroupBox
        Left = 112
        Top = 100
        Width = 441
        Height = 105
        Caption = '  Select a text file that contain the data to import  '
        TabOrder = 0
        object sbOpenBKP: TSpeedButton
          Left = 330
          Top = 23
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
          Left = 29
          Top = 54
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Text Delimiter :'
        end
        object lbDelimiter: TLabel
          Left = 12
          Top = 78
          Width = 87
          Height = 13
          Alignment = taRightJustify
          Caption = 'Decimal Delimiter :'
        end
        object rbFile: TRadioButton
          Left = 10
          Top = 25
          Width = 81
          Height = 17
          Caption = 'File'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object edtFilePath: TEdit
          Left = 64
          Top = 22
          Width = 264
          Height = 21
          TabOrder = 1
        end
        object edtDelimiter: TEdit
          Left = 104
          Top = 50
          Width = 25
          Height = 21
          MaxLength = 1
          TabOrder = 2
          OnKeyPress = edtDelimiterKeyPress
        end
        object edtDecimalDelimiter: TEdit
          Left = 104
          Top = 74
          Width = 25
          Height = 21
          MaxLength = 1
          TabOrder = 3
          OnKeyPress = edtDecimalDelimiterKeyPress
        end
      end
    end
    object tsSpecificConfig: TTabSheet
      Hint = 'Specific Import Config'
      Caption = 'Specific Config'
      ImageIndex = 1
    end
    object tsDatabase: TTabSheet
      Hint = 'Text File Database'
      Caption = 'File Database'
      ImageIndex = 2
      object lbRecords: TLabel
        Left = 509
        Top = 276
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = '0 line(s)'
      end
      object grdFile: TcxGrid
        Left = 0
        Top = 0
        Width = 677
        Height = 347
        Align = alClient
        TabOrder = 0
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
    object tsCrossColumn: TTabSheet
      Hint = 'Columns to be associates to the MainRetail '
      Caption = 'Cross Columns'
      ImageIndex = 3
      object sgColumns: TStringGrid
        Left = 11
        Top = 2
        Width = 221
        Height = 343
        ColCount = 2
        FixedCols = 0
        RowCount = 21
        TabOrder = 0
        OnSelectCell = sgColumnsSelectCell
        ColWidths = (
          64
          95)
        RowHeights = (
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24
          24)
      end
      object cbColumns: TComboBox
        Left = 151
        Top = 84
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        OnChange = cbColumnsChange
        OnExit = cbColumnsExit
      end
      object btClean: TBitBtn
        Left = 244
        Top = 316
        Width = 75
        Height = 25
        Caption = 'Clean'
        TabOrder = 2
        OnClick = btCleanClick
      end
      object btSave: TBitBtn
        Left = 244
        Top = 288
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 3
        OnClick = btSaveClick
      end
    end
    object tsImport: TTabSheet
      Hint = 'Import File'
      Caption = 'Import'
      ImageIndex = 5
    end
  end
  inherited PTitle: TPanel
    Width = 687
    DesignSize = (
      687
      62)
    inherited ShapeImage: TShape
      Left = 615
      Anchors = [akTop, akRight]
    end
    inherited ImageClass: TImage
      Left = 621
      Anchors = [akTop, akRight]
    end
  end
  inherited Panel1: TPanel
    Top = 444
    Width = 687
    Height = 39
    DesignSize = (
      687
      39)
    inherited bvBottom: TBevel
      Width = 687
    end
    inherited btBack: TButton
      Left = 434
    end
    inherited btNext: TButton
      Left = 516
    end
    inherited btClose: TButton
      Left = 601
    end
    inherited btHelp: TButton
      Left = 349
    end
  end
  object OD: TOpenDialog
    DefaultExt = '*.Txt'
    Filter = 'Text file|*.TXT|All|*.*'
    InitialDir = 'C:\'
    Left = 476
    Top = 131
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
  object SD: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls'
    Left = 140
    Top = 109
  end
end
