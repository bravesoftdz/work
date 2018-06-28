object ECFFch: TECFFch
  Left = 361
  Top = 296
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ECF'
  ClientHeight = 192
  ClientWidth = 406
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
    Left = 71
    Top = 44
    Width = 26
    Height = 13
    Caption = 'Loja :'
  end
  object Label2: TLabel
    Left = 65
    Top = 72
    Width = 32
    Height = 13
    Caption = 'Caixa :'
  end
  object Label3: TLabel
    Left = 71
    Top = 100
    Width = 26
    Height = 13
    Caption = 'ECF :'
  end
  object Label4: TLabel
    Left = 14
    Top = 128
    Width = 83
    Height = 13
    Caption = 'N'#250'mero de s'#233'rie :'
  end
  object Label5: TLabel
    Left = 300
    Top = 44
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 300
    Top = 72
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 196
    Top = 100
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 196
    Top = 128
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 162
    Width = 406
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      406
      30)
    object btCancel: TcxButton
      Left = 327
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancelar'
      TabOrder = 0
      OnClick = btCancelClick
    end
    object btOk: TcxButton
      Left = 247
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      Default = True
      TabOrder = 1
      OnClick = btOkClick
    end
  end
  object luStore: TcxDBLookupComboBox
    Left = 100
    Top = 40
    Width = 201
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDStore'
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'IDStore'
    Properties.ListColumns = <
      item
        FieldName = 'Store'
      end>
    Properties.ListOptions.GridLines = glNone
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = DMSintegra.dsStore
    TabOrder = 0
  end
  object luCashRegister: TcxDBLookupComboBox
    Left = 100
    Top = 68
    Width = 201
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDCashRegister'
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'IDCashRegister'
    Properties.ListColumns = <
      item
        FieldName = 'CashRegister'
      end>
    Properties.ListOptions.GridLines = glNone
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = DMSintegra.dsCashRegister
    TabOrder = 1
  end
  object edECFNumber: TcxDBTextEdit
    Left = 100
    Top = 96
    Width = 97
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'NumeroECF'
    TabOrder = 2
  end
  object edSerialNumber: TcxDBTextEdit
    Left = 100
    Top = 124
    Width = 97
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'NumeroSerie'
    TabOrder = 3
  end
  object dsFch: TDataSource
    Left = 344
    Top = 12
  end
end
