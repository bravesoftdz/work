inherited FrmImportEstimated: TFrmImportEstimated
  Left = 62
  Top = 58
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import Estimates'
  ClientHeight = 427
  ClientWidth = 678
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 386
    Width = 678
    inherited EspacamentoInferior: TPanel
      Width = 678
      inherited Panel3: TPanel
        Width = 678
      end
    end
    inherited hhh: TPanel
      Left = 461
      Width = 217
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 144
        Cancel = True
        ModalResult = 2
      end
      object btnOK: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 97
    Height = 289
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 675
    Top = 97
    Height = 289
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Top = 97
    Width = 678
    Height = 0
    Visible = False
  end
  object grdBrowse: TcxGrid [4]
    Left = 3
    Top = 97
    Width = 672
    Height = 289
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdBrowseDB: TcxGridDBTableView
      DataController.DataSource = dsEstimated
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDEstimated'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ValorNominal'
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdBrowseDBIDEstimated: TcxGridDBColumn
        DataBinding.FieldName = 'IDEstimated'
        Width = 70
      end
      object grdBrowseDBEstimatedDate: TcxGridDBColumn
        DataBinding.FieldName = 'EstimatedDate'
      end
      object grdBrowseDBStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
        Width = 101
      end
      object grdBrowseDBSystemUser: TcxGridDBColumn
        DataBinding.FieldName = 'SystemUser'
        Width = 167
      end
      object grdBrowseDBCustomer: TcxGridDBColumn
        DataBinding.FieldName = 'Customer'
        Width = 169
      end
      object grdBrowseDBTotal: TcxGridDBColumn
        DataBinding.FieldName = 'Total'
        Width = 68
      end
    end
    object grdBrowseLevel: TcxGridLevel
      GridView = grdBrowseDB
    end
  end
  object pnlBasicFilter: TPanel [5]
    Left = 0
    Top = 0
    Width = 678
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Label3: TLabel
      Left = 293
      Top = 30
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbFrom: TLabel
      Left = 295
      Top = 54
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'From :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTo: TLabel
      Left = 451
      Top = 54
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 39
      Top = 30
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = 'Name :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 14
      Top = 6
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estimated :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 298
      Top = 5
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 13
      Top = 54
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Document :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pblGO: TPanel
      Left = 600
      Top = 0
      Width = 78
      Height = 97
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
      object pnlAviso: TPanel
        Left = 8
        Top = 21
        Width = 65
        Height = 30
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        object btnExec: TSpeedButton
          Left = 5
          Top = 2
          Width = 56
          Height = 26
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          ParentFont = False
          OnClick = btnExecClick
        end
      end
    end
    object cmbStore: TSuperComboADO
      Left = 337
      Top = 26
      Width = 214
      Height = 21
      TabOrder = 1
      Text = '<-->'
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object Button2: TButton
      Left = 556
      Top = 27
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 2
      OnClick = Button2Click
    end
    object DateInicio: TDateBox
      Left = 337
      Top = 50
      Width = 87
      Height = 21
      TabOrder = 3
      InputTime = False
    end
    object DateFim: TDateBox
      Left = 470
      Top = 50
      Width = 82
      Height = 21
      TabOrder = 4
      InputTime = False
      Language = Portuguese
    end
    object cbmName: TComboBox
      Left = 84
      Top = 26
      Width = 98
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 5
      Items.Strings = (
        ''
        'First Name'
        'Last Name'
        'Full Name')
    end
    object edtNames: TEdit
      Left = 183
      Top = 26
      Width = 86
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object edtHoldNumber: TEdit
      Left = 84
      Top = 2
      Width = 98
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object scUser: TSuperComboADO
      Left = 338
      Top = 1
      Width = 213
      Height = 21
      TabOrder = 8
      Text = '<-->'
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object Button1: TButton
      Left = 557
      Top = 2
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 9
      OnClick = Button1Click
    end
    object cbmDocs: TComboBox
      Left = 84
      Top = 50
      Width = 98
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 10
      Items.Strings = (
        ''
        'Driver License'
        'Social Security'
        'Customer Card'
        'Employee ID')
    end
    object edtDocs: TEdit
      Left = 183
      Top = 50
      Width = 86
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object chkUpdateSalePrice: TCheckBox
      Left = 337
      Top = 76
      Width = 272
      Height = 17
      Caption = 'Update Sale Price'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 12
    end
  end
  object quEstimated: TPowerADOQuery [6]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'SELECT '#13#10#9'E.IDEstimated,'#13#10#9'E.EstimatedDate,'#13#10#9'E.OBS,'#13#10#9'S.Name as' +
      ' Store,'#13#10#9'SU.IDUser,'#13#10#9'SU.SystemUser,'#13#10#9'P.Pessoa as Customer,'#13#10#9 +
      'SUM(EI.Qty * EI.SalePrice) as Total'#13#10'FROM'#13#10#9'Estimated E (NOLOCK)' +
      #13#10#9'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = E.IDPEssoa' +
      ')'#13#10#9'JOIN EstimatedItem EI (NOLOCK) ON (EI.IDEstimated = E.IDEsti' +
      'mated)'#13#10#9'JOIN Store S (NOLOCK) ON (S.IDStore = E.IDStore)'#13#10#9'JOIN' +
      ' SystemUser SU (NOLOCK) ON (SU.IDUser = E.IDUser)'#13#10'GROUP BY'#13#10#9'E.' +
      'IDEstimated,'#13#10#9'E.EstimatedDate,'#13#10#9'E.OBS,'#13#10#9'S.Name,'#13#10#9'SU.IDUser,'#13 +
      #10#9'SU.SystemUser,'#13#10#9'P.Pessoa'
    CommandTimeout = 180
    Parameters = <>
    Left = 120
    Top = 161
    object quEstimatedIDEstimated: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'IDEstimated'
    end
    object quEstimatedEstimatedDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'EstimatedDate'
    end
    object quEstimatedTotal: TBCDField
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quEstimatedOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object quEstimatedStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quEstimatedIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quEstimatedSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quEstimatedCustomer: TStringField
      FieldName = 'Customer'
      Size = 50
    end
  end
  object dsEstimated: TDataSource [7]
    DataSet = quEstimated
    Left = 117
    Top = 102
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmImportEstimated.sil'
  end
end
