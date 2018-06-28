inherited SisEntityWiz: TSisEntityWiz
  Caption = 'SisEntityWiz'
  ClientWidth = 611
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvBottom: TBevel
    Width = 611
  end
  inherited pgOption: TPageControl
    Left = 24
    Top = 76
    Width = 632
    Height = 312
    ActivePage = tsImport
    object tsOption: TTabSheet
      Hint = 'Select import or export data. '
      Caption = 'Option'
      object rgOperation: TRadioGroup
        Left = 170
        Top = 110
        Width = 306
        Height = 56
        Caption = 'Which operation do you wand to execute?'
        Columns = 2
        Items.Strings = (
          'Import'
          'Export')
        TabOrder = 0
        OnClick = rgOperationClick
      end
    end
    object tsSoftwareList: TTabSheet
      Hint = 'Select a software that you want to import or export data.'
      Caption = 'Software list'
      ImageIndex = 1
      object Label20: TLabel
        Left = 23
        Top = 47
        Width = 124
        Height = 13
        Caption = 'List of software available.'
      end
      object lbSoftware: TLabel
        Left = 310
        Top = 69
        Width = 281
        Height = 87
        AutoSize = False
        Caption = 'The data will exported to '
        Visible = False
        WordWrap = True
      end
      object lbTip: TLabel
        Left = 310
        Top = 165
        Width = 286
        Height = 81
        AutoSize = False
        WordWrap = True
      end
      object treeSoftware: TdxTreeView
        Left = 20
        Top = 69
        Width = 281
        Height = 176
        ShowNodeHint = True
        HotTrack = True
        ShowLines = False
        ShowRoot = False
        Indent = 19
        Items.Data = {
          02000000230000000500000005000000FFFFFFFFFFFFFFFF0000000000000000
          0A517569636B426F6F6B73220000000600000006000000FFFFFFFFFFFFFFFF00
          0000000000000009506561636854726565}
        ParentColor = False
        Options = []
        SelectedIndex = -1
        TabOrder = 0
        OnClick = treeSoftwareClick
        Images = imgSmall
      end
    end
    object tsFileType: TTabSheet
      Hint = 'Type and path of the file you are importing or exporting.'
      Caption = 'File Type'
      ImageIndex = 2
      object Label1: TLabel
        Left = 117
        Top = 68
        Width = 234
        Height = 13
        Caption = 'Which type of file you want to import or export ?'
      end
      object Label2: TLabel
        Left = 117
        Top = 143
        Width = 124
        Height = 13
        Caption = 'Where is the file located ?'
      end
      object lbDirOption: TLabel
        Left = 117
        Top = 171
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Path'
      end
      object sbOpenFile: TSpeedButton
        Left = 406
        Top = 167
        Width = 23
        Height = 21
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000
          0000000000000000000000000000000000000000000000FF00FFFF00FF000000
          008284008284000000000000000000000000000000000000C6C3C6C6C3C60000
          00008284000000FF00FFFF00FF00000000828400828400000000000000000000
          0000000000000000C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
          008284008284000000000000000000000000000000000000C6C3C6C6C3C60000
          00008284000000FF00FFFF00FF00000000828400828400000000000000000000
          0000000000000000000000000000000000008284000000FF00FFFF00FF000000
          0082840082840082840082840082840082840082840082840082840082840082
          84008284000000FF00FFFF00FF00000000828400828400000000000000000000
          0000000000000000000000000000008284008284000000FF00FFFF00FF000000
          008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
          00008284000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
          C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
          008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
          00008284000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
          C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
          008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
          00000000000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
          C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000C6C3C6000000FF00FFFF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = sbOpenFileClick
      end
      object Label3: TLabel
        Left = 117
        Top = 95
        Width = 24
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type'
      end
      object cbxFileType: TComboBox
        Left = 143
        Top = 90
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cbxFileTypeChange
        Items.Strings = (
          'Vendor'
          'Customer'
          'Employee')
      end
      object edtPath: TEdit
        Left = 143
        Top = 167
        Width = 260
        Height = 21
        TabOrder = 1
      end
    end
    object tsImport: TTabSheet
      Hint = 'List of data that will be imported to Office Manager.'
      Caption = 'Import'
      ImageIndex = 3
      object lbGridInfo: TLabel
        Left = 3
        Top = 258
        Width = 47
        Height = 13
        Caption = 'lbGridInfo'
      end
      object gridImport: TStringGrid
        Left = 1
        Top = 19
        Width = 589
        Height = 237
        ColCount = 3
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 3
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goRowMoving, goColMoving, goEditing]
        TabOrder = 0
      end
    end
    object tsExport: TTabSheet
      Hint = 'List of data that will be exported from Office Manager.'
      Caption = 'Export'
      ImageIndex = 4
      object dxDBCGrid1: TdxDBCGrid
        Left = 0
        Top = 40
        Width = 624
        Height = 227
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'IDPessoa'
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        TabOrder = 0
        ArrowsColor = clBlue
        DataSource = dsPessoa
        Filter.Active = True
        Filter.AutoDataSetFilter = True
        Filter.MaxDropDownCount = 300
        Filter.Criteria = {00000000}
        LookAndFeel = lfFlat
        OptionsBehavior = [edgoCaseInsensitive, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowSelect, edgoUseBitmap]
        PreviewFieldName = 'Memo'
        ShowGrid = False
        OnRefreshNodeData = dxDBCGrid1RefreshNodeData
        object dxDBCGrid1IDPessoa: TdxDBGridMaskColumn
          Width = 32
          BandIndex = 0
          RowIndex = 0
          FieldName = 'IDPessoa'
        end
        object dxDBCGrid1EntityFullName: TdxDBGridMaskColumn
          Width = 119
          BandIndex = 0
          RowIndex = 0
          FieldName = 'EntityFullName'
        end
        object dxDBCGrid1Address: TdxDBGridMaskColumn
          Width = 196
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Address'
        end
        object dxDBCGrid1DBA: TdxDBGridMaskColumn
          Width = 110
          BandIndex = 0
          RowIndex = 0
          FieldName = 'DBA'
        end
        object dxDBCGrid1City: TdxDBGridMaskColumn
          Width = 71
          BandIndex = 0
          RowIndex = 0
          FieldName = 'City'
        end
        object dxDBCGrid1Zip: TdxDBGridMaskColumn
          Width = 56
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Zip'
        end
        object dxDBCGrid1Country: TdxDBGridMaskColumn
          Width = 69
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Country'
        end
        object dxDBCGrid1Phone: TdxDBGridMaskColumn
          Width = 87
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Phone'
        end
        object dxDBCGrid1CellPhone: TdxDBGridMaskColumn
          Width = 96
          BandIndex = 0
          RowIndex = 0
          FieldName = 'CellPhone'
        end
        object dxDBCGrid1Fax: TdxDBGridMaskColumn
          Width = 68
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Fax'
        end
        object dxDBCGrid1Contact: TdxDBGridMaskColumn
          Width = 110
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Contact'
        end
        object dxDBCGrid1BirthDay: TdxDBGridDateColumn
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'BirthDay'
        end
        object dxDBCGrid1SocialSecurity: TdxDBGridMaskColumn
          Width = 91
          BandIndex = 0
          RowIndex = 0
          FieldName = 'SocialSecurity'
        end
        object dxDBCGrid1FederalID: TdxDBGridMaskColumn
          Width = 86
          BandIndex = 0
          RowIndex = 0
          FieldName = 'FederalID'
        end
        object dxDBCGrid1SalesTax: TdxDBGridMaskColumn
          Width = 85
          BandIndex = 0
          RowIndex = 0
          FieldName = 'SalesTax'
        end
        object dxDBCGrid1CompanyContact: TdxDBGridMaskColumn
          Width = 110
          BandIndex = 0
          RowIndex = 0
          FieldName = 'CompanyContact'
        end
        object dxDBCGrid1DriveLicence: TdxDBGridMaskColumn
          Width = 93
          BandIndex = 0
          RowIndex = 0
          FieldName = 'DriveLicence'
        end
        object dxDBCGrid1LastName: TdxDBGridMaskColumn
          Width = 94
          BandIndex = 0
          RowIndex = 0
          FieldName = 'LastName'
        end
        object dxDBCGrid1FirstName: TdxDBGridMaskColumn
          Width = 75
          BandIndex = 0
          RowIndex = 0
          FieldName = 'FirstName'
        end
        object dxDBCGrid1HorsPerWeek: TdxDBGridMaskColumn
          Width = 81
          BandIndex = 0
          RowIndex = 0
          FieldName = 'HorsPerWeek'
        end
        object dxDBCGrid1HourValue: TdxDBGridCurrencyColumn
          Width = 70
          BandIndex = 0
          RowIndex = 0
          FieldName = 'HourValue'
          Nullable = False
        end
        object dxDBCGrid1OverHourValue: TdxDBGridCurrencyColumn
          Width = 94
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OverHourValue'
          Nullable = False
        end
        object dxDBCGrid1DoubleHourValue: TdxDBGridCurrencyColumn
          Width = 101
          BandIndex = 0
          RowIndex = 0
          FieldName = 'DoubleHourValue'
          Nullable = False
        end
        object dxDBCGrid1CustomerCard: TdxDBGridMaskColumn
          Width = 124
          BandIndex = 0
          RowIndex = 0
          FieldName = 'CustomerCard'
        end
        object dxDBCGrid1Code: TdxDBGridMaskColumn
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Code'
        end
        object dxDBCGrid1HomePage: TdxDBGridMaskColumn
          Width = 133
          BandIndex = 0
          RowIndex = 0
          FieldName = 'HomePage'
        end
        object dxDBCGrid1Email: TdxDBGridMaskColumn
          Width = 131
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Email'
        end
        object dxDBCGrid1OBS: TdxDBGridMaskColumn
          Width = 149
          BandIndex = 0
          RowIndex = 0
          FieldName = 'OBS'
        end
        object dxDBCGrid1IDTipoPessoa: TdxDBGridMaskColumn
          Visible = False
          Width = 23
          BandIndex = 0
          RowIndex = 0
          FieldName = 'IDTipoPessoa'
        end
        object dxDBCGrid1IDStore: TdxDBGridMaskColumn
          Visible = False
          Width = 21
          BandIndex = 0
          RowIndex = 0
          FieldName = 'IDStore'
        end
        object dxDBCGrid1IDTipoPessoaRoot: TdxDBGridMaskColumn
          Visible = False
          Width = 32
          BandIndex = 0
          RowIndex = 0
          FieldName = 'IDTipoPessoaRoot'
        end
        object dxDBCGrid1IDUser: TdxDBGridMaskColumn
          Visible = False
          Width = 21
          BandIndex = 0
          RowIndex = 0
          FieldName = 'IDUser'
        end
      end
      object pnlExpOpt: TPanel
        Left = 0
        Top = 0
        Width = 624
        Height = 40
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object Label5: TLabel
          Left = 3
          Top = 22
          Width = 111
          Height = 13
          Caption = 'General Ledge Account'
        end
        object Label6: TLabel
          Left = 3
          Top = 1
          Width = 388
          Height = 13
          Caption = 
            'All Entities on the list will be associated with the selected Ge' +
            'neral Ledge Account.'
        end
        object scChartAcc: TSuperComboADO
          Left = 119
          Top = 18
          Width = 146
          Height = 21
          TabOrder = 0
          LookUpSource = DM.dsLULancamentoTipo
          ShowBtnAddNew = False
          ShowBtnUpdate = False
        end
      end
      object pnlSummary: TPanel
        Left = 0
        Top = 267
        Width = 624
        Height = 14
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object lbExportLines: TLabel
          Left = 5
          Top = 1
          Width = 64
          Height = 13
          Caption = 'lbExportLines'
        end
      end
    end
    object tsColumns: TTabSheet
      Hint = 'Select and match columns to be imported or exported.'
      Caption = 'Columns'
      ImageIndex = 5
      object lbTotalColumns: TLabel
        Left = 14
        Top = 269
        Width = 72
        Height = 13
        Caption = 'lbTotalColumns'
      end
      object lbColumnInfo: TLabel
        Left = 275
        Top = 2
        Width = 311
        Height = 71
        AutoSize = False
        Caption = 
          'You have to match each column available in Software column with ' +
          'each column available in Office Manager column. If you don'#39't kno' +
          'w the meaning of the Software columns, click on Back button and ' +
          'see the columns header from the previous grid. '
        WordWrap = True
      end
      object sgColumns: TStringGrid
        Left = 13
        Top = 1
        Width = 258
        Height = 266
        ColCount = 3
        DefaultColWidth = 78
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        OnSelectCell = sgColumnsSelectCell
        ColWidths = (
          22
          106
          106)
      end
      object cbColumns: TComboBox
        Left = 128
        Top = 46
        Width = 116
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        OnChange = cbColumnsChange
        OnExit = cbColumnsExit
        Items.Strings = (
          ''
          'FullName'
          'Address'
          'City'
          'Phone1'
          'Phone2'
          'State'
          'LastName'
          'FirstName'
          'Social Security')
      end
      object cbxNonDublicated: TCheckBox
        Left = 295
        Top = 155
        Width = 286
        Height = 18
        Caption = 'Eliminate duplicated NAME while importing data?'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object tsFinish: TTabSheet
      Hint = 'Summary of Impor or Export wizard.'
      Caption = 'Finishing wizard'
      ImageIndex = 6
      object Label37: TLabel
        Left = 25
        Top = 19
        Width = 424
        Height = 20
        Caption = 'Completing the Office Manager Import/Export Wizard'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label29: TLabel
        Left = 27
        Top = 51
        Width = 261
        Height = 39
        Caption = 
          'You have completed the required steps of your Office Manager imp' +
          'ort/export. Review your information below. Click << &Back to cor' +
          'rect any data.'
        Transparent = True
        WordWrap = True
      end
      object memSummary: TMemo
        Left = 27
        Top = 99
        Width = 358
        Height = 172
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  inherited EspacamentoDireito: TPanel
    Left = 608
  end
  inherited EspacamentoSuperior: TPanel
    Width = 611
  end
  inherited PTitle: TPanel [5]
    Width = 611
    inherited ImageClass: TImage
      Picture.Data = {
        07544269746D6170E6040000424DE60400000000000036000000280000001400
        0000140000000100180000000000B0040000C40E0000C40E0000000000000000
        00008000FF8000FF8000FF8000FF8000FF8000FF8000FF808080808080808080
        8080808080808000FF8000FF8080808080808080808080808080808000FF8000
        FF8000FF8000FF8000FF8000FF8000FF630000F7CFA5CE613163000000000080
        80808000FF0000849C9EFF0000FF0000840000008080808000FF8000FF8000FF
        8000FF8000FF8000FF8000FF630000F7CFA5CE9E636300000000008080808000
        FF0000849C9EFF0000FF0000840000008080808000FF8000FF8000FF8000FF80
        00FF8000FF8000FF630000F7CFA5CE9E636300000000008080808000FF000084
        9C9EFF0000FF0000840000008080808000FF8000FF8000FF8000FF8000FF8000
        FF8000FF630000FFFFFFF7CFA5CE61310000008000FF8000FF000084FFFFFF9C
        9EFF0000FF0000008000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
        8000FF6300006300006300008080808000FF8000FF8000FF0000840000840000
        848080808000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF00
        0000CECFCE0000008080808000FF8000FF8000FF848684CECFCE000000808080
        8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF000000C6C7
        C60000008080808000FF8000FF8000FF848684CECFCE0000008080808000FF80
        00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF000000CECFCE000000
        8080808000FF8000FF808080848684B5B6B50000008080808000FF8000FF8000
        FF8000FF0000000000008000FF8000FF000000000000CECFCE00000000000080
        80808080808080800000000000000000008080808000FF8000FF8000FF848684
        737173848684000000000000848684A5A6A5C6C7C6A5A6A57371730000000000
        00000000A5A6A50000000000008080808000FF8000FF8000FF848684D6D7D6B5
        B6B5848684848684A5A6A5C6C7C6C6C7C6C6C7C6C6C7C6A5A6A5848684A5A6A5
        FFFFFF0000000000008080808000FF8000FF8000FF848684FFFFFFD6D7D6FFFF
        FFFFFFFFD6D7D6D6D7D6D6D7D6D6D7D6D6D7D6C6C7C6C6C7C6FFFFFF000000A5
        A6A50000008080808000FF8000FF8000FF848684FFFFFFFFFFFF848684737173
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000E7E7E7CECFCEA5A6
        A50000008080808000FF8000FF8000FF8486848486848000FF8000FF84868484
        8684848684848684848684848684848684737173E7E7E7CECFCEA5A6A5000000
        8080808000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000
        FF8000FF8000FF8000FF8000FF848684E7E7E7CECFCEA5A6A500000080808080
        00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
        8000FF8000FF8000FF848684FFFFFFE7E7E7A5A6A50000008080808000FF8000
        FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
        00FF8000FF8486848486848486848486840000008000FF8000FF8000FF8000FF
        8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000
        FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
        00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
        8000FF8000FF8000FF8000FF8000FF8000FF}
    end
  end
  inherited Panel1: TPanel [6]
    Width = 611
    object pnlImport: TPanel
      Left = 38
      Top = 10
      Width = 185
      Height = 24
      BevelOuter = bvNone
      TabOrder = 4
      Visible = False
      object Label4: TLabel
        Left = 1
        Top = 5
        Width = 51
        Height = 13
        Caption = 'Completed'
      end
      object pb: TProgressBar
        Left = 56
        Top = 5
        Width = 126
        Height = 16
        Min = 0
        Max = 100
        Smooth = True
        TabOrder = 0
      end
    end
  end
  inherited pnlEspacamentoInferiror: TPanel [7]
    Width = 611
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_SisEntityWiz.sil'
  end
  object SD: TSaveDialog
    InitialDir = 'C:\'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 301
    Top = 6
  end
  object quTestEntity: TADOQuery
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'PessoaName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'P.IDTipoPessoa'
      'FROM '
      #9'Pessoa P'
      'WHERE '
      #9'P.Pessoa = :PessoaName'
      #9'AND'
      #9'P.IDTipoPessoa = :IDTipoPessoa'
      #9'AND'
      #9'P.Desativado = 0'
      #9'AND'
      #9'P.Hidden = 0'
      ''
      ''
      '')
    Left = 530
    Top = 11
  end
  object dsPessoa: TDataSource
    DataSet = quPessoa
    Left = 410
    Top = 11
  end
  object quPessoa: TADODataSet
    Connection = DM.DBADOConnection
    Filtered = True
    OnNewRecord = quPessoaNewRecord
    CommandText = 
      'SELECT DISTINCT'#13#10#9'P.IDPessoa, '#13#10#9'P.IDTipoPessoa, '#13#10#9'P.IDStore, '#13 +
      #10#9'P.IDTipoPessoaRoot, '#13#10#9'P.IDUser, '#13#10#9'P.Pessoa '#9'as EntityFullNam' +
      'e, '#13#10#9'P.Endereco'#9'as Address,'#13#10#9'P.NomeJuridico '#9'as DBA,'#13#10#9'P.Cidad' +
      'e '#9'as City, '#13#10#9'P.CEP '#9#9'as Zip, '#13#10#9'P.Pais '#9#9'as Country, '#13#10#9'P.Tele' +
      'fone '#9'as Phone, '#13#10#9'P.Cellular '#9'as CellPhone, '#13#10#9'P.Fax '#9#9'as Fax, ' +
      #13#10#9'P.Contato '#9'as Contact, '#13#10#9'P.Juridico '#9'as Type, '#13#10#9'P.Nasciment' +
      'o '#9'as BirthDay, '#13#10#9'P.CartTrabalho '#9'as SocialSecurity, '#13#10#9'P.InscE' +
      'stadual '#9'as FederalID,'#13#10#9'P.InscMunicipal as SalesTax, '#13#10#9'P.Conta' +
      'tos '#9'as CompanyContact,'#13#10#9'P.OrgaoEmissor '#9'as DriveLicence, '#13#10#9'P.' +
      'PessoaLastName '#9'as LastName, '#13#10#9'P.PessoaFirstName '#9'as FirstName,' +
      #13#10#9'P.HorasSemana '#9#9'as HorsPerWeek, '#13#10#9'P.ValorHora '#9#9'as HourValue' +
      ','#13#10#9'P.ValorHoraExtra '#9'as OverHourValue,'#13#10#9'P.ValorHoraExtraExtra ' +
      #9'as DoubleHourValue,'#13#10#9'P.CustomerCard, '#13#10#9'P.Code, '#13#10#9'P.HomePage,' +
      ' '#13#10#9'P.Email, '#13#10#9'P.OBS '#13#10'FROM '#13#10#9'Pessoa P (NOLOCK)'#13#10'WHERE '#13#10#9'P.ID' +
      'TipoPessoa = :IDPessoaTipo'#13#10#9'AND'#13#10#9'P.Desativado = 0'#13#10#9'AND'#13#10#9'P.Hi' +
      'dden = 0'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPessoaTipo'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 358
    Top = 9
    object quPessoaIDPessoa: TAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'IDPessoa'
      ReadOnly = True
      Visible = False
    end
    object quPessoaIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
      Visible = False
    end
    object quPessoaIDStore: TIntegerField
      FieldName = 'IDStore'
      Visible = False
    end
    object quPessoaIDTipoPessoaRoot: TIntegerField
      FieldName = 'IDTipoPessoaRoot'
      Visible = False
    end
    object quPessoaIDUser: TIntegerField
      FieldName = 'IDUser'
      Visible = False
    end
    object quPessoaEntityFullName: TStringField
      FieldName = 'EntityFullName'
      Size = 50
    end
    object quPessoaAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quPessoaDBA: TStringField
      FieldName = 'DBA'
      Size = 50
    end
    object quPessoaCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object quPessoaZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object quPessoaCountry: TStringField
      FieldName = 'Country'
      Size = 21
    end
    object quPessoaPhone: TStringField
      FieldName = 'Phone'
      Size = 40
    end
    object quPessoaCellPhone: TStringField
      FieldName = 'CellPhone'
      FixedChar = True
      Size = 18
    end
    object quPessoaFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quPessoaContact: TStringField
      FieldName = 'Contact'
      Size = 50
    end
    object quPessoaType: TBooleanField
      FieldName = 'Type'
    end
    object quPessoaBirthDay: TDateTimeField
      FieldName = 'BirthDay'
    end
    object quPessoaSocialSecurity: TStringField
      FieldName = 'SocialSecurity'
      Size = 30
    end
    object quPessoaFederalID: TStringField
      FieldName = 'FederalID'
      Size = 30
    end
    object quPessoaSalesTax: TStringField
      FieldName = 'SalesTax'
      Size = 30
    end
    object quPessoaCompanyContact: TStringField
      FieldName = 'CompanyContact'
      Size = 255
    end
    object quPessoaDriveLicence: TStringField
      FieldName = 'DriveLicence'
      Size = 50
    end
    object quPessoaLastName: TStringField
      FieldName = 'LastName'
      Size = 30
    end
    object quPessoaFirstName: TStringField
      FieldName = 'FirstName'
      Size = 30
    end
    object quPessoaHorsPerWeek: TIntegerField
      FieldName = 'HorsPerWeek'
    end
    object quPessoaHourValue: TBCDField
      FieldName = 'HourValue'
      Precision = 19
    end
    object quPessoaOverHourValue: TBCDField
      FieldName = 'OverHourValue'
      Precision = 19
    end
    object quPessoaDoubleHourValue: TBCDField
      FieldName = 'DoubleHourValue'
      Precision = 19
    end
    object quPessoaCustomerCard: TStringField
      FieldName = 'CustomerCard'
    end
    object quPessoaCode: TIntegerField
      FieldName = 'Code'
      Visible = False
    end
    object quPessoaHomePage: TStringField
      FieldName = 'HomePage'
      Size = 200
    end
    object quPessoaEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quPessoaOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
  end
end
