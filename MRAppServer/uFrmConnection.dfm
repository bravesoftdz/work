object FrmConnection: TFrmConnection
  Left = 290
  Top = 177
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Connection'
  ClientHeight = 235
  ClientWidth = 262
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 33
    Top = 15
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Connection : '
  end
  object Panel1: TPanel
    Left = 0
    Top = 203
    Width = 262
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 262
      Height = 3
      Align = alTop
      Shape = bsTopLine
    end
    object btnSave: TBitBtn
      Left = 83
      Top = 6
      Width = 87
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnClose: TBitBtn
      Left = 173
      Top = 6
      Width = 87
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object BtnConnection: TButton
      Left = 2
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 2
      OnClick = BtnConnectionClick
    end
  end
  object cbxConnection: TComboBox
    Left = 97
    Top = 11
    Width = 145
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnSelect = cbxConnectionSelect
  end
  object edtDriverName: TLabeledEdit
    Left = 97
    Top = 131
    Width = 144
    Height = 21
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'Driver Name :'
    LabelPosition = lpLeft
    TabOrder = 6
    Text = 'SQLServer'
  end
  object edtBlobSize: TLabeledEdit
    Left = 97
    Top = 155
    Width = 144
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'Blob Size :'
    LabelPosition = lpLeft
    TabOrder = 7
    Text = '-1'
  end
  object edtHostName: TLabeledEdit
    Left = 97
    Top = 36
    Width = 144
    Height = 21
    EditLabel.Width = 59
    EditLabel.Height = 13
    EditLabel.Caption = 'Host Name :'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object edtDataBase: TLabeledEdit
    Left = 97
    Top = 60
    Width = 144
    Height = 21
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'DataBase :'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object edtUser: TLabeledEdit
    Left = 97
    Top = 84
    Width = 144
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'User :'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object edtPassword: TLabeledEdit
    Left = 97
    Top = 108
    Width = 144
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Password :'
    LabelPosition = lpLeft
    PasswordChar = '*'
    TabOrder = 5
  end
  object chkUseLib: TCheckBox
    Left = 97
    Top = 180
    Width = 142
    Height = 17
    Caption = 'Use Network Library'
    TabOrder = 8
  end
  object ADODBConnect: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=MainRetailDB;Data Source=(local)'
    ConnectionTimeout = 10
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 20
    Top = 72
  end
end
