inherited FinTransferenciaFch: TFinTransferenciaFch
  Left = 172
  Top = 115
  HelpContext = 23
  Caption = 'FinTransferenciaFch'
  ClientHeight = 359
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 43
    Top = 42
    Width = 62
    Height = 13
    Alignment = taRightJustify
    Caption = 'Transfer ID :'
    FocusControl = DBEdit1
  end
  object Label2: TLabel [1]
    Left = 61
    Top = 192
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Amount :'
    FocusControl = DBEdit1
  end
  object Label3: TLabel [2]
    Left = 75
    Top = 72
    Width = 30
    Height = 13
    Alignment = taRightJustify
    Caption = 'Date :'
    FocusControl = DBEdit1
  end
  object Label4: TLabel [3]
    Left = 76
    Top = 102
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
    FocusControl = DBEdit1
  end
  object Label5: TLabel [4]
    Left = 31
    Top = 132
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Caption = 'Debit Account :'
    FocusControl = DBEdit1
  end
  object Label6: TLabel [5]
    Left = 27
    Top = 162
    Width = 78
    Height = 13
    Alignment = taRightJustify
    Caption = 'Credit Account :'
    FocusControl = DBEdit1
  end
  object Label7: TLabel [6]
    Left = 70
    Top = 222
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Memo :'
    FocusControl = DBEdit1
  end
  object Label8: TLabel [7]
    Left = 270
    Top = 71
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label9: TLabel [8]
    Left = 380
    Top = 101
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label10: TLabel [9]
    Left = 380
    Top = 131
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label11: TLabel [10]
    Left = 380
    Top = 161
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label12: TLabel [11]
    Left = 205
    Top = 191
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 282
    TabOrder = 6
  end
  inherited EspacamentoDireito: TPanel
    Height = 282
    TabOrder = 7
  end
  inherited EspacamentoSuperior: TPanel
    TabOrder = 8
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 316
    TabOrder = 9
  end
  inherited pnlPBarra: TPanel
    Top = 322
    TabOrder = 10
  end
  inherited pnlPTitulo: TPanel
    TabOrder = 11
    inherited lblPTituloShadow: TLabel
      Width = 98
      Caption = 'Transfer'
    end
    inherited lblPTitulo: TLabel
      Width = 98
      Caption = 'Transfer'
    end
  end
  object DBEdit1: TDBEdit [18]
    Tag = 1
    Left = 110
    Top = 40
    Width = 101
    Height = 21
    DataField = 'IDTransferencia'
    DataSource = dsForm
    ParentColor = True
    ReadOnly = True
    TabOrder = 5
  end
  object DBEdit2: TDBEdit [19]
    Left = 110
    Top = 190
    Width = 96
    Height = 21
    DataField = 'Valor'
    DataSource = dsForm
    TabOrder = 3
  end
  object scUsuario: TDBSuperComboADO [20]
    Left = 110
    Top = 100
    Width = 271
    Height = 21
    TabOrder = 0
    Text = 'scUsuario'
    LookUpSource = DM.dsLookUpUsuario
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    DataField = 'IDUsuario'
    DataSource = dsForm
  end
  object scContaCorrenteDebito: TDBSuperComboADO [21]
    Left = 110
    Top = 130
    Width = 271
    Height = 21
    TabOrder = 1
    Text = 'scContaCorrenteDebito'
    LookUpSource = DM.dsLUContaCorrente
    DropDownRows = 18
    DataField = 'IDContaCorrenteDebito'
    DataSource = dsForm
  end
  object scContaCorrenteCredito: TDBSuperComboADO [22]
    Left = 110
    Top = 160
    Width = 271
    Height = 21
    TabOrder = 2
    Text = 'scContaCorrenteCredito'
    LookUpSource = DM.dsLUContaCorrente
    DropDownRows = 18
    DataField = 'IDContaCorrenteCredito'
    DataSource = dsForm
  end
  object DBMemo1: TDBMemo [23]
    Left = 110
    Top = 220
    Width = 271
    Height = 89
    DataField = 'Obs'
    DataSource = dsForm
    TabOrder = 4
  end
  object dxDBDateEdit1: TDBDateBox [24]
    Left = 110
    Top = 70
    Width = 156
    Height = 21
    ReadOnly = False
    TabOrder = 16
    DataField = 'Data'
    DataSource = dsForm
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FinTransferenciaFch.sil'
  end
  inherited dsForm: TDataSource
    Left = 396
    Top = 46
  end
  inherited quForm: TPowerADOQuery
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10'        T.IDTransferencia,'#13#10'        T.IDContaCorrenteDeb' +
      'ito,'#13#10'        T.IDContaCorrenteCredito,'#13#10'        T.IDUsuario, '#13#10 +
      '        T.Data,'#13#10'        T.Valor,'#13#10'        T.Obs'#13#10'FROM'#13#10'        ' +
      'Fin_Transferencia T'#13#10'WHERE'#13#10'        T.IDTransferencia = :IDTrans' +
      'ferencia'
    Parameters = <
      item
        Name = 'IDTransferencia'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 346
    Top = 52
    object quFormIDTransferencia: TIntegerField
      FieldName = 'IDTransferencia'
      Origin = 'RETAILDB.Fin_Transferencia.IDTransferencia'
    end
    object quFormData: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'Data'
      Origin = 'RETAILDB.Fin_Transferencia.Data'
      Required = True
    end
    object quFormIDUsuario: TIntegerField
      DisplayLabel = 'User'
      FieldName = 'IDUsuario'
      Origin = 'RETAILDB.Fin_Transferencia.IDUsuario'
      Required = True
    end
    object quFormIDContaCorrenteDebito: TIntegerField
      DisplayLabel = 'Debit Account'
      FieldName = 'IDContaCorrenteDebito'
      Origin = 'RETAILDB.Fin_Transferencia.IDContaCorrenteDebito'
      Required = True
    end
    object quFormIDContaCorrenteCredito: TIntegerField
      DisplayLabel = 'Credit Account'
      FieldName = 'IDContaCorrenteCredito'
      Origin = 'RETAILDB.Fin_Transferencia.IDContaCorrenteCredito'
      Required = True
    end
    object quFormValor: TFloatField
      DisplayLabel = 'Value'
      FieldName = 'Valor'
      Origin = 'RETAILDB.Fin_Transferencia.Valor'
      Required = True
      DisplayFormat = '#,##0.00'
    end
    object quFormObs: TMemoField
      FieldName = 'Obs'
      Origin = 'RETAILDB.Fin_Transferencia.Obs'
      BlobType = ftMemo
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    PostOnInsert = True
    AutoIncField = 'IDTransferencia'
    RequiredFields.Strings = (
      'Valor')
    DependentTables.Strings = (
      'Fin_Quitacao')
    DependentTableKeys.Strings = (
      'IDTransferencia')
    Left = 411
    Top = 104
  end
  inherited bmMDI: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    Left = 395
    Top = 205
    DockControlHeights = (
      0
      0
      0
      0)
  end
  inherited ilSmallButtons: TImageList
    Left = 302
    Top = 35
  end
  inherited PrintFch: TPrintDialog
    Left = 320
    Top = 110
  end
end
