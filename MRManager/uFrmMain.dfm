object FrmMain: TFrmMain
  Left = 192
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'MRManager'
  ClientHeight = 364
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 307
    Height = 307
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Connection Settings'
      object Label5: TLabel
        Left = 62
        Top = 24
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Server'
      end
      object Label10: TLabel
        Left = 16
        Top = 52
        Width = 77
        Height = 13
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Database Name'
        ParentBiDiMode = False
      end
      object gbxAutentic: TGroupBox
        Left = 8
        Top = 88
        Width = 281
        Height = 121
        Caption = 'Authentication '
        TabOrder = 0
        object Label7: TLabel
          Left = 64
          Top = 70
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Password'
        end
        object rbWindows: TRadioButton
          Left = -169
          Top = -14
          Width = 231
          Height = 17
          Caption = 'Windows login'
          TabOrder = 0
        end
        object rbSQL: TRadioButton
          Left = 14
          Top = 36
          Width = 232
          Height = 17
          Caption = 'SQLServer login'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object edtUserName: TEdit
          Left = 120
          Top = 35
          Width = 137
          Height = 21
          TabOrder = 2
          Text = 'sa'
        end
        object edtPW: TEdit
          Left = 120
          Top = 67
          Width = 137
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
          Text = 'MR_DB_User'
        end
      end
      object edtServer: TEdit
        Left = 102
        Top = 20
        Width = 187
        Height = 21
        TabOrder = 1
        Text = '(local)\Pinogy'
      end
      object EdtDababase: TEdit
        Left = 102
        Top = 47
        Width = 187
        Height = 21
        TabOrder = 2
        Text = 'MainRetailDB'
      end
      object btnTestConnection: TButton
        Left = 176
        Top = 224
        Width = 113
        Height = 25
        Caption = '&Test Connection'
        TabOrder = 3
        OnClick = btnTestConnectionClick
      end
      object slvQueries: TShellListView
        Left = 352
        Top = 32
        Width = 297
        Height = 217
        ObjectTypes = [otNonFolders]
        Root = 'rfDesktop'
        Sorted = True
        ReadOnly = False
        HideSelection = False
        MultiSelect = True
        TabOrder = 4
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tables'
      ImageIndex = 1
      object labNumberOfTables: TLabel
        Left = 8
        Top = 257
        Width = 83
        Height = 13
        Caption = '0 tables selected.'
      end
      object clbTables: TCheckListBox
        Left = 8
        Top = 29
        Width = 265
        Height = 208
        OnClickCheck = clbTablesClickCheck
        ItemHeight = 13
        TabOrder = 0
      end
      object btnRefreshTables: TButton
        Left = 159
        Top = 248
        Width = 113
        Height = 25
        Caption = '&Refresh Tables'
        TabOrder = 1
        OnClick = btnRefreshTablesClick
      end
      object cbxSelectAllTables: TCheckBox
        Left = 10
        Top = 9
        Width = 101
        Height = 17
        Caption = 'Select all'
        TabOrder = 2
        OnMouseDown = cbxSelectAllTablesMouseDown
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 2
      object labExportPath: TLabel
        Left = 8
        Top = 24
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Export Path'
      end
      object edtExportPath: TEdit
        Left = 72
        Top = 20
        Width = 184
        Height = 21
        TabOrder = 0
      end
      object btnSelectDir: TButton
        Left = 262
        Top = 20
        Width = 21
        Height = 21
        Hint = 'Select export path'
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnSelectDirClick
      end
    end
  end
  object panFooter: TPanel
    Left = 0
    Top = 307
    Width = 307
    Height = 57
    Align = alBottom
    TabOrder = 1
    object lbVersion: TLabel
      Left = 5
      Top = 38
      Width = 47
      Height = 11
      Caption = 'Version 6.3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnOK: TButton
      Left = 128
      Top = 16
      Width = 75
      Height = 25
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 216
      Top = 16
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
  end
  object DBConnection: TADOConnection
    ConnectionTimeout = 30
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 43
    Top = 242
  end
  object ADOQuery1: TADOQuery
    Connection = DBConnection
    Parameters = <>
    Left = 12
    Top = 240
  end
  object tbSyncTables: TADOTable
    Connection = conMRManagement
    TableName = 'SyncTables'
    Left = 124
    Top = 272
  end
  object conMRManagement: TADOConnection
    ConnectionTimeout = 30
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 123
    Top = 240
  end
  object qryMRManagement: TADOQuery
    Connection = DBConnection
    Parameters = <>
    Left = 160
    Top = 273
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cGET_ACP
    UTF8StringsAsWideField = False
    AutoEncodeStrings = False
    Port = 0
    Protocol = 'ado'
    Left = 12
    Top = 288
  end
  object ZQuery1: TZQuery
    Params = <>
    Left = 56
    Top = 291
  end
end
