object FrmModelUpd: TFrmModelUpd
  Left = 329
  Top = 312
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Main Retail - Module Update'
  ClientHeight = 116
  ClientWidth = 287
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 79
    Top = 28
    Width = 102
    Height = 29
    Alignment = taRightJustify
    Caption = 'Module'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object edtMod: TEdit
    Left = 185
    Top = 28
    Width = 43
    Height = 31
    BorderStyle = bsNone
    CharCase = ecUpperCase
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = '1'
  end
  object Button1: TButton
    Left = 55
    Top = 78
    Width = 188
    Height = 25
    Caption = 'Click here to update module'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 20
    Top = 5
    Width = 241
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
    Visible = False
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mruser2000;Persist Security Info=Tr' +
      'ue;User ID=mruser;Initial Catalog=MainRetailDB;Data Source=.;Use' +
      ' Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Wo' +
      'rkstation ID=RETAIL'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 25
    Top = 15
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'ModuleInfo'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'Update sys_module '
      'SET ModuleInfo  = :ModuleInfo')
    Left = 25
    Top = 70
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'Select ModuleInfo From sys_module')
    Left = 110
    Top = 45
    object ADOQuery2ModuleInfo: TStringField
      FieldName = 'ModuleInfo'
      Size = 255
    end
  end
end
