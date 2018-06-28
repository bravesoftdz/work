inherited FchLot: TFchLot
  Left = 174
  Top = 144
  Caption = 'FchLot'
  ClientHeight = 260
  ClientWidth = 374
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 374
    TabOrder = 3
    inherited Image1: TImage
      Width = 100
    end
    inherited lblMenu: TLabel
      Left = 113
    end
    inherited EspacamentoSuperior: TPanel
      Width = 374
      inherited EEE: TPanel
        Width = 374
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 327
    end
  end
  inherited Panel1: TPanel
    Top = 219
    Width = 374
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 374
      inherited Panel3: TPanel
        Width = 374
      end
    end
    inherited hhh: TPanel
      Left = 227
      Width = 147
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btCancel: TButton
        Left = 76
      end
      inherited btClose: TButton
        Left = 5
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 374
    Height = 9
    TabOrder = 1
    inherited Panel4: TPanel
      Top = 7
      Width = 374
    end
  end
  inherited pnlDetail: TPanel
    Top = 49
    Width = 368
    Height = 170
    TabOrder = 0
    object Label2: TLabel
      Left = 49
      Top = 36
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'Lot :'
      FocusControl = edtLot
    end
    object Label1: TLabel
      Left = 340
      Top = 33
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 66
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Expiration :'
      FocusControl = edtLot
    end
    object Label4: TLabel
      Left = 162
      Top = 65
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Top = 96
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Lot date :'
      FocusControl = edtLot
    end
    object Label6: TLabel
      Left = 46
      Top = 126
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'Qty :'
      FocusControl = edtQty
    end
    object Label7: TLabel
      Left = 34
      Top = 9
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
      FocusControl = edtLot
    end
    object Label8: TLabel
      Left = 162
      Top = 123
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtLot: TDBEdit
      Left = 76
      Top = 32
      Width = 261
      Height = 21
      DataField = 'Lot'
      DataSource = dsForm
      TabOrder = 1
    end
    object dtExp: TDBDateBox
      Left = 76
      Top = 62
      Width = 84
      Height = 21
      ReadOnly = False
      TabOrder = 2
      InputTime = False
      DataField = 'ExpirationDate'
      DataSource = dsForm
    end
    object dtLot: TDBDateBox
      Left = 76
      Top = 92
      Width = 84
      Height = 21
      ReadOnly = False
      TabOrder = 3
      InputTime = False
      DataField = 'LotDate'
      DataSource = dsForm
    end
    object edtQty: TDBEdit
      Left = 76
      Top = 122
      Width = 83
      Height = 21
      DataField = 'Qty'
      DataSource = dsForm
      TabOrder = 4
    end
    object scModel: TDBSuperComboADO
      Left = 76
      Top = 5
      Width = 258
      Height = 21
      TabStop = False
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      Text = 'scModel'
      CodeLength = 150
      LookUpSource = DM.dsLookUpModelPack
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      ShowEditCode = True
      EditCodePos = taEditCodeRight
      MostraHidden = STD_AMBOSHIDDEN
      IDLanguage = 0
      DataField = 'IDModel'
      DataSource = dsForm
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 49
    Height = 170
  end
  inherited EspacamentoDireito: TPanel
    Left = 371
    Top = 49
    Height = 170
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchLot.sil'
  end
  inherited dsForm: TDataSource
    Left = 26
    Top = 71
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT '#13#10#9'IDLote,'#13#10#9'IDModel,'#13#10#9'IDUser,'#13#10#9'Lot,'#13#10#9'ExpirationDate,'#13 +
      #10#9'LotDate,'#13#10#9'Qty'#13#10'FROM'#13#10'        Inv_Lot'#13#10'WHERE'#13#10#9'IDLote = :IDLot' +
      'e'
    Parameters = <
      item
        Name = 'IDLote'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 26
    Top = 127
    object quFormIDLote: TIntegerField
      FieldName = 'IDLote'
    end
    object quFormIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quFormIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quFormLot: TStringField
      FieldName = 'Lot'
      Required = True
      Size = 50
    end
    object quFormExpirationDate: TDateTimeField
      FieldName = 'ExpirationDate'
      Required = True
    end
    object quFormLotDate: TDateTimeField
      FieldName = 'LotDate'
    end
    object quFormQty: TBCDField
      FieldName = 'Qty'
      Required = True
      Precision = 32
    end
  end
  inherited FormConfig: TFormConfig
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDLote'
    Left = 26
    Top = 184
  end
end
