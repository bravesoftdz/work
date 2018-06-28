object FMCompany: TFMCompany
  Left = 346
  Top = 314
  Width = 455
  Height = 334
  Caption = 'Maintain Company Information'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 216
    Top = 24
    Width = 105
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Peachtree Version:'
  end
  object lblPeachtreeVersionNo: TLabel
    Left = 325
    Top = 24
    Width = 110
    Height = 14
    Caption = 'lblPeachtreeVersionNo'
  end
  object Label2: TLabel
    Left = 10
    Top = 64
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Company N&ame:'
  end
  object Label3: TLabel
    Left = 10
    Top = 86
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'A&ddress:'
  end
  object Label5: TLabel
    Left = 10
    Top = 130
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'City, ST &Zip:'
  end
  object Label4: TLabel
    Left = 10
    Top = 152
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Country:'
  end
  object Label6: TLabel
    Left = 234
    Top = 155
    Width = 90
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Fed Employer &ID:'
  end
  object Label7: TLabel
    Left = 10
    Top = 174
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Te&lephone:'
  end
  object Label8: TLabel
    Left = 234
    Top = 177
    Width = 90
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State Employer &ID:'
  end
  object Label9: TLabel
    Left = 10
    Top = 196
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'F&ax:'
  end
  object Label10: TLabel
    Left = 211
    Top = 197
    Width = 114
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State &Unemployment ID:'
  end
  object Shape1: TShape
    Left = 98
    Top = 218
    Width = 337
    Height = 2
    Pen.Width = 2
  end
  object Label11: TLabel
    Left = 10
    Top = 228
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Form of Business:'
  end
  object Label12: TLabel
    Left = 10
    Top = 252
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Posting Method:'
  end
  object Label13: TLabel
    Left = 218
    Top = 256
    Width = 105
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Accounting Method::'
  end
  object LblCashBasis: TLabel
    Left = 327
    Top = 256
    Width = 55
    Height = 14
    Caption = 'Cash Basis'
  end
  object Label15: TLabel
    Left = 10
    Top = 274
    Width = 89
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Company Options:'
  end
  object BTNClose: TBitBtn
    Left = 0
    Top = 0
    Width = 65
    Height = 41
    TabOrder = 0
    OnClick = BTNCloseClick
    Kind = bkCancel
    Layout = blGlyphTop
  end
  object BTNOk: TBitBtn
    Left = 65
    Top = 0
    Width = 65
    Height = 41
    TabOrder = 1
    OnClick = BTNOkClick
    Kind = bkOK
    Layout = blGlyphTop
  end
  object EditCompanyName: TEdit
    Left = 101
    Top = 61
    Width = 334
    Height = 22
    AutoSize = False
    TabOrder = 2
  end
  object EditAddrLine1: TEdit
    Left = 101
    Top = 83
    Width = 334
    Height = 22
    AutoSize = False
    TabOrder = 3
    Text = 'Edit1'
  end
  object EditAddrLine2: TEdit
    Left = 101
    Top = 105
    Width = 334
    Height = 22
    AutoSize = False
    TabOrder = 4
    Text = 'Edit1'
  end
  object EditAddrCity: TEdit
    Left = 101
    Top = 127
    Width = 206
    Height = 22
    AutoSize = False
    TabOrder = 5
    Text = 'Edit1'
  end
  object EditAddrState: TEdit
    Left = 309
    Top = 127
    Width = 38
    Height = 22
    AutoSize = False
    TabOrder = 6
    Text = 'Edit1'
  end
  object EditAddrPostalCode: TEdit
    Left = 349
    Top = 127
    Width = 86
    Height = 22
    AutoSize = False
    TabOrder = 7
    Text = 'Edit1'
  end
  object EditAddrCountry: TEdit
    Left = 101
    Top = 149
    Width = 110
    Height = 22
    AutoSize = False
    TabOrder = 8
    Text = 'Edit1'
  end
  object EditFein: TEdit
    Left = 325
    Top = 149
    Width = 110
    Height = 22
    AutoSize = False
    TabOrder = 9
    Text = 'Edit1'
  end
  object EditTelephone: TEdit
    Left = 101
    Top = 171
    Width = 110
    Height = 22
    AutoSize = False
    TabOrder = 10
    Text = 'Edit1'
  end
  object EditSein: TEdit
    Left = 325
    Top = 171
    Width = 110
    Height = 22
    AutoSize = False
    TabOrder = 11
    Text = 'Edit1'
  end
  object EditFax: TEdit
    Left = 101
    Top = 193
    Width = 110
    Height = 22
    AutoSize = False
    TabOrder = 12
    Text = 'Edit1'
  end
  object EditSuin: TEdit
    Left = 325
    Top = 193
    Width = 110
    Height = 22
    AutoSize = False
    TabOrder = 13
    Text = 'Edit1'
  end
  object CBoBusinessType: TComboBox
    Left = 101
    Top = 224
    Width = 221
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 14
    Items.Strings = (
      'Corporation'
      'S Corporation'
      'PartnerShip'
      'Sole Proprietorship'
      'Limited Liability Company'
      'Not Assigned')
  end
  object CBoPostingMethod: TComboBox
    Left = 101
    Top = 248
    Width = 100
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 15
    Items.Strings = (
      'Real-Time'
      'Batch')
  end
  object CBUseAuditTrail: TCheckBox
    Left = 101
    Top = 272
    Width = 97
    Height = 17
    Caption = 'U&se Audit Trail'
    TabOrder = 16
  end
  object Btrieve1: TBtrieve
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 368
    Top = 272
  end
  object CompanyInformation1: TCompanyInformation
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 408
    Top = 272
  end
  object SelectCompany1: TSelectCompany
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 328
    Top = 272
  end
end
