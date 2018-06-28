inherited FrmHistoryManage: TFrmHistoryManage
  Left = 112
  Top = 98
  Width = 528
  Height = 408
  BorderIcons = [biSystemMenu]
  Caption = 'FrmHistoryManage'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 340
    Width = 520
    inherited EspacamentoInferior: TPanel
      Width = 520
      inherited Panel3: TPanel
        Width = 520
      end
    end
    inherited hhh: TPanel
      Left = 369
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 21
    Height = 319
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 517
    Top = 21
    Height = 319
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 520
    Visible = False
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 6
    Width = 520
    Height = 15
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
  end
  object Panel4: TPanel [5]
    Left = 426
    Top = 21
    Width = 91
    Height = 319
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 5
    object btAdd: TSpeedButton
      Left = 2
      Top = 1
      Width = 89
      Height = 25
      Caption = '&Add   '
      Flat = True
      Margin = 6
      Spacing = 7
      OnClick = btAddClick
    end
    object btnPrint: TSpeedButton
      Left = 2
      Top = 27
      Width = 89
      Height = 25
      Caption = '&Print'
      Flat = True
      Margin = 6
      Spacing = 7
      OnClick = btnPrintClick
    end
    object btnEmail: TSpeedButton
      Left = 2
      Top = 53
      Width = 89
      Height = 25
      Caption = '&Email'
      Flat = True
      Margin = 6
      Spacing = 7
      OnClick = btnEmailClick
    end
  end
  object grdHistory: TcxGrid [6]
    Left = 3
    Top = 21
    Width = 423
    Height = 319
    Align = alClient
    TabOrder = 6
    LookAndFeel.Kind = lfFlat
    object grdHistoryDB: TcxGridDBTableView
      DataController.DataSource = dsHistory
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDHistory'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.Column = grdHistoryDBOBS
      Preview.MaxLineCount = 10
      Preview.Visible = True
      object grdHistoryDBMovDate: TcxGridDBColumn
        DataBinding.FieldName = 'MovDate'
        Visible = False
        GroupIndex = 0
        SortOrder = soAscending
      end
      object grdHistoryDBSaleCode: TcxGridDBColumn
        DataBinding.FieldName = 'SaleCode'
        Width = 52
      end
      object grdHistoryDBSystemUser: TcxGridDBColumn
        DataBinding.FieldName = 'SystemUser'
        Width = 157
      end
      object grdHistoryDBHistoryType: TcxGridDBColumn
        DataBinding.FieldName = 'HistoryType'
        Width = 195
      end
      object grdHistoryDBOBS: TcxGridDBColumn
        DataBinding.FieldName = 'OBS'
        Width = 187
      end
    end
    object grdHistoryLevel: TcxGridLevel
      GridView = grdHistoryDB
    end
  end
  object quHistory: TADOQuery [7]
    Connection = DM.ADODBConnect
    AfterOpen = quHistoryAfterOpen
    OnCalcFields = quHistoryCalcFields
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreSaleParent'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDServiceOrder'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'Select '
      #9'H.IDHistory,'
      #9'H.IDUser,'
      #9'H.MovDate,'
      #9'H.OBS,'
      #9'H.IDHistoryType,'
      #9'H.IDPreSale,'
      #9'HT.HistoryType,'
      #9'U.SystemUser,'
      #9'I.SaleCode as ISaleCode,'
      #9'P.Endereco as ClientAddress,'
      #9'P.Cidade as ClientCity,'
      #9'P.Bairro as ClientNeighborhood,'
      #9'P.CEP as ClientZip,'
      #9'P.Telefone as ClientPhone,'
      #9'P.Cellular as ClientCell,'
      #9'P.Email as ClientEmail,'
      #9'P.Nascimento as ClientBirthDate,'
      #9'P.CPF as ClientEmployeeID,'
      #9'P.CartTrabalho as ClientSocialSecurity,'
      #9'P.InscEstadual as ClientFederalID,'
      #9'P.InscMunicipal as ClientSalesTax,'
      #9'P.NomeJuridico as ClientDBA,'
      #9'P.PessoaFirstName,'
      #9'P.PessoaLastName,'
      #9'S.SONumber'
      'From '
      #9'History H (NOLOCK) '
      
        #9'JOIN HistoryType HT (NOLOCK) ON (H.IDHistoryType = HT.IDHistory' +
        'Type)'
      #9'JOIN SystemUser U (NOLOCK) ON (U.IDUser = H.IDUser)'
      #9'LEFT JOIN Invoice I (NOLOCK) ON (I.IDPreSale = H.IDPreSale)'
      
        #9'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = I.IDCustomer' +
        ')'
      
        #9'LEFT JOIN Ser_ServiceOrder S (NOLOCK) ON (S.IDServiceOrder = H.' +
        'IDServiceOrder)'
      'Where'
      #9'('
      #9'H.IDPreSale = :IDPreSale'
      #9'OR'
      #9'I.IDPreSaleParent = :IDPreSaleParent'
      #9')'
      #9'OR'
      #9'H.IDServiceOrder = :IDServiceOrder'
      'Order by'
      #9'H.MovDate')
    Left = 62
    Top = 73
    object quHistoryIDHistory: TIntegerField
      FieldName = 'IDHistory'
    end
    object quHistoryIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quHistoryMovDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'MovDate'
      DisplayFormat = 'ddddd'
    end
    object quHistoryOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object quHistoryIDHistoryType: TIntegerField
      FieldName = 'IDHistoryType'
    end
    object quHistoryIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quHistoryHistoryType: TStringField
      FieldName = 'HistoryType'
      Size = 255
    end
    object quHistorySystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quHistoryClientAddress: TStringField
      FieldName = 'ClientAddress'
      Size = 80
    end
    object quHistoryClientCity: TStringField
      FieldName = 'ClientCity'
      Size = 40
    end
    object quHistoryClientNeighborhood: TStringField
      FieldName = 'ClientNeighborhood'
      Size = 50
    end
    object quHistoryClientZip: TStringField
      FieldName = 'ClientZip'
      FixedChar = True
      Size = 12
    end
    object quHistoryClientPhone: TStringField
      FieldName = 'ClientPhone'
      Size = 40
    end
    object quHistoryClientCell: TStringField
      FieldName = 'ClientCell'
      FixedChar = True
      Size = 18
    end
    object quHistoryClientEmail: TStringField
      FieldName = 'ClientEmail'
      Size = 50
    end
    object quHistoryClientBirthDate: TDateTimeField
      FieldName = 'ClientBirthDate'
    end
    object quHistoryClientEmployeeID: TStringField
      FieldName = 'ClientEmployeeID'
      Size = 30
    end
    object quHistoryClientSocialSecurity: TStringField
      FieldName = 'ClientSocialSecurity'
      Size = 30
    end
    object quHistoryClientFederalID: TStringField
      FieldName = 'ClientFederalID'
      Size = 30
    end
    object quHistoryClientSalesTax: TStringField
      FieldName = 'ClientSalesTax'
      Size = 30
    end
    object quHistoryClientDBA: TStringField
      FieldName = 'ClientDBA'
      Size = 50
    end
    object quHistoryPessoaFirstName: TStringField
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quHistoryPessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quHistorySaleCode: TStringField
      FieldKind = fkCalculated
      FieldName = 'SaleCode'
      Calculated = True
    end
    object quHistoryISaleCode: TStringField
      FieldName = 'ISaleCode'
    end
    object quHistorySONumber: TStringField
      FieldName = 'SONumber'
    end
  end
  object dsHistory: TDataSource [8]
    DataSet = quHistory
    Left = 70
    Top = 125
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmHistoryManage.sil'
    Left = 19
    Top = 6
  end
  object SD: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text File|*.txt'
    InitialDir = 'C:\'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofNoValidate, ofPathMustExist, ofFileMustExist]
    Left = 175
    Top = 98
  end
  object Email: TEmail
    ShowDialog = True
    UseAppHandle = False
    Left = 175
    Top = 150
  end
end
