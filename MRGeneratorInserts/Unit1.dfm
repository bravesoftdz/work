object Form1: TForm1
  Left = 180
  Top = 264
  Width = 719
  Height = 230
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    711
    203)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 37
    Height = 13
    Caption = 'Table :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 14
    Top = 40
    Width = 35
    Height = 13
    Caption = 'Filter :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 64
    Width = 42
    Height = 13
    Caption = 'Result :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtTable: TcxLookupComboBox
    Left = 52
    Top = 12
    Width = 225
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'id'
    Properties.ListColumns = <
      item
        FieldName = 'Name'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dsLuTable
    TabOrder = 0
  end
  object edtFilter: TcxTextEdit
    Left = 52
    Top = 36
    Width = 653
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ParentFont = False
    TabOrder = 1
    Text = 'IDPreSale > 100016572 and IDPreSale < 100017192'
  end
  object mmInsert: TcxMemo
    Left = 52
    Top = 60
    Width = 653
    Height = 137
    Anchors = [akLeft, akTop, akRight, akBottom]
    ParentFont = False
    Properties.ScrollBars = ssVertical
    TabOrder = 3
  end
  object btnScript: TcxButton
    Left = 628
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Script'
    Default = True
    TabOrder = 2
    OnClick = btnScriptClick
  end
  object ADOConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mruser2000;Persist Security Info=Tr' +
      'ue;User ID=mruser;Initial Catalog=FoxMillDB;Data Source=desenv00' +
      '4'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 360
    Top = 92
  end
  object qryColumns: TADOQuery
    Connection = ADOConn
    Parameters = <
      item
        Name = 'TableName'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 128
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'C.[Name] as ColumnName,'
      #9'T.[Name] as ColumnType'
      'FROM'
      #9'sysobjects O'
      #9'JOIN syscolumns C ON (O.[id] = C.[id])'
      
        #9'JOIN systypes T ON (C.xtype = T.xtype and T.xtype = T.xusertype' +
        ')'
      'WHERE'
      #9'O.[Name] = :TableName'
      'ORDER BY'
      #9'C.colid')
    Left = 420
    Top = 92
    object qryColumnsColumnName: TWideStringField
      FieldName = 'ColumnName'
      Size = 128
    end
    object qryColumnsColumnType: TWideStringField
      FieldName = 'ColumnType'
      Size = 128
    end
  end
  object qryValues: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 484
    Top = 92
  end
  object qryLuTable: TADOQuery
    Connection = ADOConn
    Parameters = <>
    SQL.Strings = (
      'select'
      #9'id,'
      #9'Name'
      'from'
      #9'sysobjects'
      'where'
      #9'uid = 1'
      #9'and xtype = '#39'U'#39
      'order by'
      #9'Name')
    Left = 548
    Top = 92
    object qryLuTableid: TIntegerField
      FieldName = 'id'
    end
    object qryLuTableName: TWideStringField
      FieldName = 'Name'
      Size = 128
    end
  end
  object dsLuTable: TDataSource
    DataSet = qryLuTable
    Left = 548
    Top = 140
  end
end
