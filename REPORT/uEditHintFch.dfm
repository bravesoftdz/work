object EditHintFch: TEditHintFch
  Left = 197
  Top = 211
  Width = 353
  Height = 197
  Caption = 'Edit report hint'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 24
    Width = 28
    Height = 13
    Caption = 'Name'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 20
    Top = 69
    Width = 19
    Height = 13
    Caption = 'Hint'
    FocusControl = DBEdit2
  end
  object DBEdit1: TDBEdit
    Left = 20
    Top = 39
    Width = 313
    Height = 21
    Color = clMenu
    DataField = 'Name'
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 20
    Top = 84
    Width = 313
    Height = 21
    DataField = 'Hint'
    DataSource = DataSource1
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 131
    Width = 345
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      345
      39)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 345
      Height = 2
      Align = alTop
      Shape = bsTopLine
    end
    object Button1: TButton
      Left = 206
      Top = 6
      Width = 66
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 276
      Top = 6
      Width = 66
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object ADOQuery1: TADOQuery
    Connection = DM.euDatabase
    CursorType = ctStatic
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <
      item
        Name = 'ItemId'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '#13
      #9'I.ItemId,'#13
      #9'I.Name,'#13
      #9'I.Hint'#13
      'FROM Rep_Item I'
      'WHERE'
      #9'I.ItemId = :ItemId')
    Left = 10
    Top = 5
    object ADOQuery1ItemId: TAutoIncField
      FieldName = 'ItemId'
      ReadOnly = True
    end
    object ADOQuery1Name: TStringField
      FieldName = 'Name'
      Size = 60
    end
    object ADOQuery1Hint: TStringField
      FieldName = 'Hint'
      Size = 255
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 55
    Top = 5
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 285
    Top = 20
    object ClientDataSet1ItemId: TAutoIncField
      FieldName = 'ItemId'
      ReadOnly = True
    end
    object ClientDataSet1Name: TStringField
      FieldName = 'Name'
      Size = 60
    end
    object ClientDataSet1Hint: TStringField
      FieldName = 'Hint'
      Size = 255
    end
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = ADOQuery1
    Left = 185
    Top = 15
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery1
    Left = 95
    Top = 5
  end
end
