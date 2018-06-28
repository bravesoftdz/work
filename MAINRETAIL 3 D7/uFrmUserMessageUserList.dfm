inherited FrmUserMessageUserList: TFrmUserMessageUserList
  Left = 197
  Top = 147
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Message User List'
  ClientHeight = 380
  ClientWidth = 513
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 339
    Width = 513
    inherited EspacamentoInferior: TPanel
      Width = 513
      inherited Panel3: TPanel
        Width = 513
      end
    end
    inherited hhh: TPanel
      Left = 288
      Width = 225
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 149
        ModalResult = 2
      end
      object btnSave: TButton
        Left = 77
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Save'
        ModalResult = 1
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 53
    Height = 286
  end
  inherited EspacamentoDireito: TPanel
    Left = 510
    Top = 53
    Height = 286
  end
  inherited EspacamentoSuperior: TPanel
    Width = 513
    Height = 53
    Color = clGray
    object lbStore: TLabel
      Left = 44
      Top = 8
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
    object lbUserType: TLabel
      Left = 15
      Top = 31
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'User Type :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cmbStore: TSuperComboADO
      Left = 89
      Top = 4
      Width = 160
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '<-->'
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = cmbStoreSelectItem
    end
    object btAreaTodas: TButton
      Left = 255
      Top = 5
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 1
      OnClick = btAreaTodasClick
    end
    object scUserType: TSuperComboADO
      Left = 88
      Top = 27
      Width = 161
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '<-->'
      LookUpSource = DM.dsLookUpUserType
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = cmbStoreSelectItem
    end
    object btnUserType: TButton
      Left = 255
      Top = 28
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 3
      OnClick = btnUserTypeClick
    end
  end
  object pnlUserList: TPanel [4]
    Left = 3
    Top = 53
    Width = 215
    Height = 286
    Align = alLeft
    TabOrder = 4
    object gridUsers: TcxGrid
      Left = 1
      Top = 1
      Width = 213
      Height = 284
      Align = alClient
      TabOrder = 0
      object gridUsersDBTableView1: TcxGridDBTableView
        DataController.DataSource = dsUsers
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDUser'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object gridUsersDBTableView1Image: TcxGridDBColumn
          Caption = ' '
          DataBinding.FieldName = 'Image'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 0
          Properties.Images = imgList
          Properties.Items = <>
          Options.Filtering = False
          Width = 20
        end
        object gridUsersDBTableView1SystemUser: TcxGridDBColumn
          DataBinding.FieldName = 'SystemUser'
          Width = 162
        end
        object gridUsersDBTableView1UserType: TcxGridDBColumn
          DataBinding.FieldName = 'UserType'
          Visible = False
          GroupIndex = 0
          SortOrder = soAscending
        end
      end
      object gridUsersLevel1: TcxGridLevel
        GridView = gridUsersDBTableView1
      end
    end
  end
  object Panel2: TPanel [5]
    Left = 218
    Top = 53
    Width = 78
    Height = 286
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    object btnAdd: TSpeedButton
      Left = 12
      Top = 75
      Width = 51
      Height = 22
      Glyph.Data = {
        DE000000424DDE000000000000007600000028000000100000000D0000000100
        04000000000068000000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888088888888888888800888888888888880C0888888888888804C0888
        8888888880C4C08888888888804C4C088888888880C4C08888888888804C0888
        8888888880C08888888888888008888888888888808888888888888888888888
        8888}
      OnClick = btnAddClick
    end
    object btnRemove: TSpeedButton
      Left = 12
      Top = 98
      Width = 51
      Height = 22
      Glyph.Data = {
        DE000000424DDE000000000000007600000028000000100000000D0000000100
        04000000000068000000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888880888888888888880088888888888880C08888888888880C408
        88888888880C4C088888888880C4C40888888888880C4C08888888888880C408
        8888888888880C08888888888888800888888888888888088888888888888888
        8888}
      OnClick = btnRemoveClick
    end
    object btnRemoveAll: TSpeedButton
      Left = 12
      Top = 173
      Width = 51
      Height = 22
      Glyph.Data = {
        DE000000424DDE000000000000007600000028000000100000000D0000000100
        04000000000068000000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        88888008888808888808844888800888800884488804088804088448804C0880
        4C08844804C40804C40884404C4C004C4C08844804C40804C4088448804C0880
        4C08844888040888040884488880088880088008888808888808888888888888
        8888}
      OnClick = btnRemoveAllClick
    end
    object btnAddAll: TSpeedButton
      Left = 12
      Top = 150
      Width = 51
      Height = 22
      Glyph.Data = {
        DE000000424DDE000000000000007600000028000000100000000D0000000100
        04000000000068000000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888880888880888880088008888008888448804088804088844880C40880C408
        8448804C40804C40844880C4C400C4C40448804C40804C40844880C40880C408
        8448804088804088844880088880088884488088888088888008888888888888
        8888}
      OnClick = btnAddAllClick
    end
  end
  object Panel4: TPanel [6]
    Left = 296
    Top = 53
    Width = 215
    Height = 286
    Align = alLeft
    TabOrder = 6
    object gridReceivers: TcxGrid
      Left = 1
      Top = 1
      Width = 213
      Height = 284
      Align = alClient
      TabOrder = 0
      object cxGridDBTableView1: TcxGridDBTableView
        DataController.DataSource = dsReceivers
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDUser'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBTableView1User: TcxGridDBColumn
          DataBinding.FieldName = 'SystemUser'
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object imgList: TImageList [7]
    Left = 75
    Top = 185
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000331134155519562155193415
      3511751900000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003A0D7D21BF2DFF313C2EBC21
      9F255511261A030EA61A85166412E31193110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000007A19BF2D1F36FC295F535D36
      DF2D9A1D0A2B354BEB2E2B2FE8228412AD110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000007915DD251E2E5B3AFD4A7D36
      1F32F51DEC32FF7F34534E3B2B2F241293110000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002E19670C603C6140CC2C
      D1210C33103B5A6B1563AD32AA2A941500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000087082104813002550255C14C
      0D21B519D01D036E2472E25D8E25000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000033114208620C6361836583656361
      033D93254572667E667E667EE461731D00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ED1084108410C4690576057AE471
      63498D31A77EA87EA87EA87E877E6E2900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003311A514071D0339C46D257A467E
      63458D31C97EEA7EEA7EC97EC97EAD3500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000EA142925AD35AC35E530A328
      0E158D31666E466A676E8676666E8D3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B19EF3D524ACE39EA14
      00009325045AAB6E1177EF6E045A942100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000E150E150E150000
      00000000932547628A6647629325000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      807F000000000000800000000000000080000000000000008000000000000000
      C001000000000000800300000000000000010000000000000001000000000000
      00010000000000008001000000000000C101000000000000E383000000000000
      FFFF000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object dsUsers: TDataSource [8]
    DataSet = quUsers
    Left = 75
    Top = 125
  end
  object quUsers: TADODataSet [9]
    Connection = DM.ADODBConnect
    AfterOpen = quUsersAfterOpen
    CommandText = 
      'SELECT'#13#10#9'SU.IDUser,'#13#10#9'SU.SystemUser,'#13#10#9'UT.Name as UserType'#13#10'FROM' +
      #13#10#9'SystemUser SU (NOLOCK) '#13#10#9'JOIN UserType UT (NOLOCK) ON (UT.ID' +
      'UserType = SU.UserTypeID)'#13#10'WHERE'#13#10#9'SU.Desativado = 0'#13#10#9'AND'#13#10#9'SU.' +
      'Hidden = 0'#13#10#9'AND'#13#10#9'SU.System = 0'#13#10
    Parameters = <>
    Left = 73
    Top = 70
    object quUsersIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quUsersSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quUsersUserType: TStringField
      FieldName = 'UserType'
      Size = 30
    end
    object quUsersImage: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Image'
      Calculated = True
    end
  end
  object dsReceivers: TDataSource [10]
    DataSet = cdsReceivers
    Left = 343
    Top = 185
  end
  object cdsReceivers: TClientDataSet [11]
    Active = True
    Aggregates = <>
    Params = <>
    Left = 343
    Top = 135
    Data = {
      480000009619E0BD010000001800000002000000000003000000480006494455
      73657204000100000000000A53797374656D5573657201004900000001000557
      494454480200020032000000}
    object cdsReceiversIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsReceiversSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmUserMessageUserList.sil'
  end
end
