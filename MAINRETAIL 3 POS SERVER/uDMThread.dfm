object DMThread: TDMThread
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 70
  Top = 91
  Height = 561
  Width = 859
  object spGetNextID: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_Sis_GetNextCode;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Tabela'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@NovoCodigo'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 124
    Top = 24
  end
  object ADODBConnect: TADOConnection
    CommandTimeout = 900
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=CameliDB;Data Source=(local);Use Proced' +
      'ure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstati' +
      'on ID=DESENV002;Use Encryption for Data=False;Tag with column co' +
      'llation when possible=False'
    ConnectionTimeout = 10
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 44
    Top = 24
  end
  object quFreeSQL: TADOQuery
    Connection = ADODBConnect
    CursorType = ctDynamic
    Parameters = <>
    Left = 212
    Top = 24
  end
  object ADOCommand: TADOCommand
    CommandTimeout = 760
    Connection = ADODBConnect
    Parameters = <>
    ParamCheck = False
    Left = 44
    Top = 84
  end
  object imgLarge: TImageList
    Height = 32
    Width = 32
    Left = 444
    Top = 12
  end
  object quMedia: TADODataSet
    Connection = ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'M.IDMedia,'#13#10#9'M.Media '#13#10'FROM'#13#10#9'Media M'#13#10'WHERE'#13#10#9'M.Desati' +
      'vado = 0'#13#10#9'AND'#13#10#9'M.Hidden = 0'#13#10'ORDER BY'#13#10#9'M.Media'
    Parameters = <>
    Left = 36
    Top = 184
    object quMediaIDMedia: TIntegerField
      FieldName = 'IDMedia'
    end
    object quMediaMedia: TStringField
      FieldName = 'Media'
      Size = 255
    end
  end
  object quSystemUser: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'SystemUser.UserTypeID, '#13#10#9'SystemUser.IDUser,'#13#10#9'SystemUs' +
      'er.SystemUser,'#13#10#9'SystemUser.ComissionID,'#13#10#9'SystemUser.StoresAcce' +
      'ss,'#13#10#9'SystemUser.CodSystemUser,'#13#10#9'SystemUser.PW,'#13#10#9'Pessoa.IDTipo' +
      'Pessoa'#13#10'FROM'#13#10#9'SystemUser'#13#10#9'INNER JOIN Pessoa ON'#13#10#9#9'(SystemUser.' +
      'ComissionID = Pessoa.IDPessoa)'#13#10'WHERE'#13#10#9'SystemUser.Desativado = ' +
      '0'#13#10#9'AND'#13#10#9'SystemUser.Hidden = 0'#13#10#9'AND'#13#10#9'SystemUser.System = 0'
    Parameters = <>
    Left = 116
    Top = 184
    object quSystemUserUserTypeID: TIntegerField
      FieldName = 'UserTypeID'
    end
    object quSystemUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quSystemUserSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quSystemUserComissionID: TIntegerField
      FieldName = 'ComissionID'
    end
    object quSystemUserStoresAccess: TStringField
      FieldName = 'StoresAccess'
      Size = 255
    end
    object quSystemUserPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
    object quSystemUserIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object quSystemUserCodSystemUser: TStringField
      FieldName = 'CodSystemUser'
    end
  end
  object quOtherCommission: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.IDPessoa IDComissionado,'#13#10#9'P.Pessoa'#13#10'FR' +
      'OM '#9#13#10#9'Pessoa P'#13#10'WHERE '#9#13#10#9'P.IDTipoPessoaRoot = 9'#13#10#9'AND'#13#10#9'P.Desa' +
      'tivado = 0'#13#10#9'AND'#13#10#9'P.Hidden = 0'#13#10#9'AND'#13#10#9'P.System = 0'#13#10'ORDER BY '#13 +
      #10#9'P.Pessoa'
    Parameters = <>
    Left = 224
    Top = 184
    object quOtherCommissionIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quOtherCommissionIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object quOtherCommissionPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object quCustomer: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10'        P.Pessoa,'#13#10#9'P.PessoaFirstName,'#13#10#9'P' +
      '.PessoaLastName,'#13#10'        P.Endereco,'#13#10#9'P.Cidade,'#13#10#9'P.CEP,'#13#10#9'P.T' +
      'elefone,'#13#10#9'(CASE P.Juridico WHEN 1 THEN P.InscEstadual ELSE P.CP' +
      'F END) as CPF,'#13#10#9'P.InscEstadual,'#13#10#9'P.Bairro,'#13#10#9'P.StoreAccountLim' +
      'it,'#13#10#9'P.Nonpayer'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10#9'JOIN TipoPessoa T' +
      'P ON (TP.IDTipoPessoa = P.IDTipoPessoa)'#13#10'WHERE '#9#13#10#9'TP.Path like ' +
      #39'.001%'#39#13#10#9'AND'#13#10#9'P.Desativado = 0'#13#10#9'AND'#13#10#9'P.Hidden = 0'#13#10#9'AND'#13#10#9'P.' +
      'System = 0'#13#10'ORDER BY '#13#10#9'P.Pessoa'
    Parameters = <>
    Left = 36
    Top = 248
    object quCustomerIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quCustomerPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quCustomerPessoaFirstName: TStringField
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quCustomerPessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quCustomerEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object quCustomerCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object quCustomerCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quCustomerTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object quCustomerCPF: TStringField
      FieldName = 'CPF'
      Size = 30
    end
    object quCustomerInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
    object quCustomerBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object quCustomerStoreAccountLimit: TBCDField
      FieldName = 'StoreAccountLimit'
      Precision = 19
    end
    object quCustomerNonpayer: TBooleanField
      FieldName = 'Nonpayer'
    end
  end
  object quParam: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDParam,'#13#10#9'P.SrvParameter,'#13#10#9'P.SrvValue,'#13#10#9'P.SrvType,' +
      ' '#13#10#9'P.Description,'#13#10#9'P.DefaultValue'#13#10#9#13#10'FROM '#13#10#9'Param P'#13#10'WHERE'#13#10 +
      #9'P.Desativado = 0'#13#10'ORDER BY'#13#10#9'P.IDParam'
    Parameters = <>
    Left = 112
    Top = 248
    object quParamIDParam: TIntegerField
      FieldName = 'IDParam'
    end
    object quParamSrvParameter: TStringField
      FieldName = 'SrvParameter'
      Size = 40
    end
    object quParamSrvValue: TStringField
      FieldName = 'SrvValue'
      Size = 30
    end
    object quParamSrvType: TStringField
      FieldName = 'SrvType'
      FixedChar = True
      Size = 10
    end
    object quParamDescription: TStringField
      FieldName = 'Description'
      Size = 200
    end
    object quParamDefaultValue: TStringField
      FieldName = 'DefaultValue'
      Size = 30
    end
  end
  object quStore: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'S.IDStore,'#13#10#9'S.Name,'#13#10#9'S.TicketHeader,'#13#10#9'S.TicketLayawa' +
      'yFooter,'#13#10#9'S.TicketTaxIsemptFooter,'#13#10#9'S.TicketFooter,'#13#10#9'S.Ticket' +
      'Detail,'#13#10#9'S.TicketTotals,'#13#10#9'S.PrintTicketHeader,'#13#10#9'S.PrintLayawa' +
      'yFooter,'#13#10#9'S.PrintTaxInsemptFooter,'#13#10#9'S.PrintTicketFooter,'#13#10#9'S.I' +
      'DEstado,'#13#10#9'S.Address,'#13#10#9'S.City,'#13#10#9'S.Zip,'#13#10#9'S.Telephone,'#13#10#9'S.Cell' +
      'ular,'#13#10#9'S.Beeper,'#13#10#9'S.Fax,'#13#10#9'S.Contato,'#13#10#9'S.Email,'#13#10#9'S.WebPage'#13#10 +
      'FROM'#13#10#9'Store S'#13#10'WHERE'#13#10#9'S.Desativado = 0'#13#10#9'AND'#13#10#9'S.Hidden = 0'
    Parameters = <>
    Left = 336
    Top = 184
    object quStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quStoreTicketHeader: TMemoField
      FieldName = 'TicketHeader'
      BlobType = ftMemo
    end
    object quStoreTicketLayawayFooter: TMemoField
      FieldName = 'TicketLayawayFooter'
      BlobType = ftMemo
    end
    object quStoreTicketTaxIsemptFooter: TMemoField
      FieldName = 'TicketTaxIsemptFooter'
      BlobType = ftMemo
    end
    object quStoreTicketFooter: TMemoField
      FieldName = 'TicketFooter'
      BlobType = ftMemo
    end
    object quStoreTicketDetail: TMemoField
      FieldName = 'TicketDetail'
      BlobType = ftMemo
    end
    object quStoreTicketTotals: TMemoField
      FieldName = 'TicketTotals'
      BlobType = ftMemo
    end
    object quStorePrintTicketHeader: TBooleanField
      FieldName = 'PrintTicketHeader'
    end
    object quStorePrintLayawayFooter: TBooleanField
      FieldName = 'PrintLayawayFooter'
    end
    object quStorePrintTaxInsemptFooter: TBooleanField
      FieldName = 'PrintTaxInsemptFooter'
    end
    object quStorePrintTicketFooter: TBooleanField
      FieldName = 'PrintTicketFooter'
    end
    object quStoreIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quStoreAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quStoreCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object quStoreZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object quStoreTelephone: TStringField
      FieldName = 'Telephone'
      Size = 40
    end
    object quStoreCellular: TStringField
      FieldName = 'Cellular'
      Size = 18
    end
    object quStoreBeeper: TStringField
      FieldName = 'Beeper'
      Size = 25
    end
    object quStoreFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quStoreContato: TStringField
      FieldName = 'Contato'
      Size = 50
    end
    object quStoreEmail: TStringField
      FieldName = 'Email'
      Size = 60
    end
    object quStoreWebPage: TStringField
      FieldName = 'WebPage'
      Size = 80
    end
  end
  object quUserTypeToSysFunction: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'UT.IDUserType,'#13#10#9'UT.IDSysFunction,'#13#10#9'UT.Acesso'#13#10'FROM '#13#10 +
      #9'UserTypeToSysFunction UT'
    Parameters = <>
    Left = 224
    Top = 248
    object quUserTypeToSysFunctionIDUserType: TIntegerField
      FieldName = 'IDUserType'
    end
    object quUserTypeToSysFunctionIDSysFunction: TIntegerField
      FieldName = 'IDSysFunction'
    end
    object quUserTypeToSysFunctionAcesso: TBooleanField
      FieldName = 'Acesso'
    end
  end
  object quUserRights: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'UT.IDUserType,'#13#10#9'SU.IDUser,'#13#10#9'UR.CanAccess,'#13#10#9'UR.CanIns' +
      'ert,'#13#10#9'UR.CanDelete,'#13#10#9'UR.CanPrint,'#13#10#9'UR.CanUpdate,'#13#10#9'SU.SystemU' +
      'ser,'#13#10#9'UR.MenuID,'#13#10#9'UR.SubMenuID,'#13#10#9'SU.ComissionID,'#13#10#9'SU.PW'#13#10'FRO' +
      'M'#13#10#9'SystemUser SU'#13#10#9'JOIN UserType UT ON (SU.UserTypeID = UT.IDUs' +
      'erType)'#13#10#9'JOIN UserRights UR ON (UR.UserTypeID = UT.IDUserType)'#13 +
      #10'WHERE'#13#10#9'SU.Desativado = 0'#13#10#9'AND'#13#10#9'SU.Hidden = 0'#13#10' '#13#10' '
    Parameters = <>
    Left = 336
    Top = 248
    object quUserRightsIDUserType: TIntegerField
      FieldName = 'IDUserType'
    end
    object quUserRightsIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quUserRightsCanAccess: TBooleanField
      FieldName = 'CanAccess'
    end
    object quUserRightsCanInsert: TBooleanField
      FieldName = 'CanInsert'
    end
    object quUserRightsCanDelete: TBooleanField
      FieldName = 'CanDelete'
    end
    object quUserRightsCanPrint: TBooleanField
      FieldName = 'CanPrint'
    end
    object quUserRightsCanUpdate: TBooleanField
      FieldName = 'CanUpdate'
    end
    object quUserRightsSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quUserRightsMenuID: TIntegerField
      FieldName = 'MenuID'
    end
    object quUserRightsSubMenuID: TIntegerField
      FieldName = 'SubMenuID'
    end
    object quUserRightsComissionID: TIntegerField
      FieldName = 'ComissionID'
    end
    object quUserRightsPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
  end
  object quModelAccessory: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    BeforeOpen = quModelAccessoryBeforeOpen
    CommandText = 
      'SELECT'#13#10#9'IA.IDInvAccessory,'#13#10#9'IA.IDModel,'#13#10#9'(CASE IsNull(I.Selli' +
      'ngPrice,0) WHEN 0 THEN M.SellingPrice '#13#10#9'ELSE I.SellingPrice END' +
      ') AS SellingPrice,'#13#10#9'M.Model, '#13#10#9'M.Description,'#13#10#9'IA.Description' +
      ' as Hint,'#13#10#9'M.LargeImage,'#13#10#9'M.PromotionPrice,'#13#10#9'M.DiscountPerc'#13#10 +
      'FROM'#13#10#9'InvAccessory IA'#13#10#9'JOIN Model M ON (M.IDModel=IA.IDInvAcce' +
      'ssory)'#13#10#9'LEFT OUTER JOIN Inventory I ON (I.ModelID = M.IDModel A' +
      'ND I.StoreID = :IDStore)'#13#10'WHERE'#13#10#9'M.TotQtyOnHand > 0'#13#10#9'AND'#13#10#9'M.D' +
      'esativado = 0'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 36
    Top = 312
    object quModelAccessoryIDInvAccessory: TIntegerField
      FieldName = 'IDInvAccessory'
    end
    object quModelAccessoryIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelAccessorySellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      Precision = 19
    end
    object quModelAccessoryModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelAccessoryDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelAccessoryHint: TStringField
      FieldName = 'Hint'
      Size = 255
    end
    object quModelAccessoryLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
    object quModelAccessoryPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object quModelAccessoryDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
  end
  object quModel: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    BeforeOpen = quModelBeforeOpen
    OnCalcFields = quModelCalcFields
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.ReplacementC' +
      'ost,'#13#10#9'M.Peso,'#13#10#9'M.SuggRetail,'#13#10#9'M.AvgCost,'#13#10#9'M.LargeImage,'#13#10#9'M.' +
      'LargeImage2,'#13#10#9'M.PromotionPrice,'#13#10#9'M.AskUserOnSale,'#13#10#9'CASE WHEN ' +
      'M.DiscountPerc IS NULL THEN ISNULL(TG.PrcPartDiscount, 100) ELSE' +
      ' M.DiscountPerc END AS DiscountPerc,'#13#10#9'M.CustomSalePrice,'#13#10#9'I.Se' +
      'llingPrice as StoreSellingPrice,'#13#10#9'TG.Name as TabGroup,'#13#10#9'U.Unid' +
      'ade,'#13#10#9'U.Sigla,'#13#10#9'F.Pessoa as Fabricante,'#13#10#9'IVS.SizeName,'#13#10#9'IVS.' +
      'CodSize,'#13#10#9'IVC.Color,'#13#10#9'IVC.CodColor,'#13#10#9'TG.RequestCustomer,'#13#10#9'TG' +
      '.PuppyTracker,'#13#10#9'(IsNull(M.VendorCost,0) + IsNull(M.FreightCost,' +
      '0)+ IsNull(M.OtherCost,0)) as VendorCostM,'#13#10#9'IsNull(I.StoreCostP' +
      'rice, 0) as VendorCostI,'#13#10#9'M.SellingPrice as InvSellingPriceM,'#13#10 +
      #9'I.SellingPrice as InvSellingPriceI,'#13#10#9'STG.IDSaleTax as IDTaxCat' +
      'egory,'#13#10#9'TG.IDDepartment,'#13#10#9'V.Pessoa as Fornecedor,'#13#10#9'M.CaseQty,' +
      #13#10#9'TG.SerialNumber,'#13#10#9'TG.UseDocumentOnSale,'#13#10#9'M.UseScale,'#13#10#9'M.In' +
      'dicadorProducao,'#13#10#9'M.IndicadorAT,'#13#10#9'TC.SituacaoTributaria'#13#10'FROM'#13 +
      #10#9'Model M (NOLOCK)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = ' +
      'M.GroupID)'#13#10#9'JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup =' +
      ' M.GroupID)'#13#10#9'JOIN Store S (NOLOCK) ON (STG.IDStore = S.IDStore)' +
      #13#10#9'LEFT OUTER JOIN Unidade U (NOLOCK) ON (U.IDUnidade = M.IDUnid' +
      'ade)'#13#10#9'LEFT OUTER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFa' +
      'bricante)'#13#10#9'LEFT OUTER JOIN InvSize IVS (NOLOCK) ON (IVS.IDSize ' +
      '= M.IDSize)'#13#10#9'LEFT OUTER JOIN InvColor IVC (NOLOCK) ON (IVC.IDCo' +
      'lor = M.IDColor)'#13#10#9'LEFT OUTER JOIN Inventory I (NOLOCK) ON (I.Mo' +
      'delID = M.IDModel AND I.StoreID = S.IDStore)'#13#10#9'LEFT OUTER JOIN I' +
      'nv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel AND MV.Ven' +
      'dorOrder = 1)'#13#10#9'LEFT OUTER JOIN Pessoa V (NOLOCK) ON (MV.IDPesso' +
      'a = V.IDPessoa)'#13#10#9'LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON (TC' +
      '.IDTaxCategory = STG.IDSaleTax)'#13#10'WHERE'#13#10#9'M.Desativado = 0'#13#10#9'AND ' +
      'M.Hidden = 0'#13#10#9'AND M.ModelType IN ('#39'S'#39', '#39'R'#39', '#39'V'#39', '#39'C'#39','#39'K'#39', '#39'G'#39')'#13 +
      #10#9'AND S.IDStore = :IDStore'#13#10'ORDER BY'#13#10#9'M.Model'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 123
    Top = 308
    object quModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quModelPeso: TBCDField
      FieldName = 'Peso'
      Precision = 19
    end
    object quModelSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quModelAvgCost: TBCDField
      FieldName = 'AvgCost'
      Precision = 19
    end
    object quModelLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
    object quModelLargeImage2: TStringField
      FieldName = 'LargeImage2'
      Size = 255
    end
    object quModelPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object quModelAskUserOnSale: TBooleanField
      FieldName = 'AskUserOnSale'
    end
    object quModelDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
      ReadOnly = True
    end
    object quModelCustomSalePrice: TBooleanField
      FieldName = 'CustomSalePrice'
    end
    object quModelStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      Precision = 19
    end
    object quModelTabGroup: TStringField
      FieldName = 'TabGroup'
      Size = 30
    end
    object quModelUnidade: TStringField
      FieldName = 'Unidade'
      Size = 100
    end
    object quModelSigla: TStringField
      FieldName = 'Sigla'
      FixedChar = True
      Size = 4
    end
    object quModelFabricante: TStringField
      FieldName = 'Fabricante'
      Size = 50
    end
    object quModelSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quModelCodSize: TStringField
      FieldName = 'CodSize'
      Size = 10
    end
    object quModelColor: TStringField
      FieldName = 'Color'
    end
    object quModelCodColor: TStringField
      FieldName = 'CodColor'
      Size = 10
    end
    object quModelRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
    end
    object quModelPuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
    end
    object quModelVendorCostM: TBCDField
      FieldName = 'VendorCostM'
      ReadOnly = True
      Precision = 19
    end
    object quModelVendorCostI: TBCDField
      FieldName = 'VendorCostI'
      ReadOnly = True
      Precision = 19
    end
    object quModelInvSellingPriceM: TBCDField
      FieldName = 'InvSellingPriceM'
      Precision = 19
    end
    object quModelInvSellingPriceI: TBCDField
      FieldName = 'InvSellingPriceI'
      Precision = 19
    end
    object quModelIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quModelIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quModelFornecedor: TStringField
      FieldName = 'Fornecedor'
      Size = 50
    end
    object quModelCaseQty: TBCDField
      FieldName = 'CaseQty'
      Precision = 32
    end
    object quModelSerialNumber: TBooleanField
      FieldName = 'SerialNumber'
    end
    object quModelUseDocumentOnSale: TBooleanField
      FieldName = 'UseDocumentOnSale'
    end
    object quModelUseScale: TBooleanField
      FieldName = 'UseScale'
    end
    object quModelSellingPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'SellingPrice'
      Calculated = True
    end
    object quModelInvSellingPrice: TBCDField
      FieldKind = fkCalculated
      FieldName = 'InvSellingPrice'
      Precision = 19
      Calculated = True
    end
    object quModelVendorCost: TBCDField
      FieldKind = fkCalculated
      FieldName = 'VendorCost'
      Calculated = True
    end
    object quModelIndicadorProducao: TStringField
      FieldName = 'IndicadorProducao'
      FixedChar = True
      Size = 1
    end
    object quModelIndicadorAT: TStringField
      FieldName = 'IndicadorAT'
      FixedChar = True
      Size = 1
    end
    object quModelSituacaoTributaria: TIntegerField
      FieldName = 'SituacaoTributaria'
    end
    object quModelDescSituTribut: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescSituTribut'
      Calculated = True
    end
  end
  object quBarcode: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'M.IDModel,'#9#13#10#9'RTRIM(LTRIM(B.IDBarcode)) as IDBarcode,'#13 +
      #10#9'M.Model,'#13#10'                IsNull(B.Qty,1) as CaseQty'#13#10'FROM'#13#10#9'M' +
      'odel M'#13#10#9'INNER JOIN Barcode B ON (M.IDModel = B.IDModel)'#9#13#10'WHERE' +
      #13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.Hidden = 0'#13#10#9'AND'#13#10#9'M.ModelType IN ' +
      '('#39'S'#39', '#39'R'#39', '#39'V'#39', '#39'C'#39','#39'K'#39', '#39'G'#39' )'#13#10'ORDER BY'#13#10#9'B.IDBarcode'
    Parameters = <>
    Left = 220
    Top = 312
    object quBarcodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quBarcodeIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object quBarcodeModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quBarcodeCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
  end
  object quMeioPag: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'MP.IDMeioPag,'#13#10#9'MP.MeioPag,'#13#10#9'MP.ImageIndex,'#13#10#9'MP.Tipo,' +
      #13#10#9'MP.RequireCustomer,'#13#10#9'MP.ValidateNonpayer'#13#10'FROM'#13#10#9'MeioPag MP'#13 +
      #10'WHERE'#13#10#9'MP.ParentType = '#39'Sale'#39' '#13#10#9'AND MP.Desativado = 0'#13#10#9'AND M' +
      'P.Hidden = 0'
    Parameters = <>
    Left = 336
    Top = 312
    object quMeioPagIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quMeioPagMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object quMeioPagImageIndex: TIntegerField
      FieldName = 'ImageIndex'
    end
    object quMeioPagTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object quMeioPagRequireCustomer: TBooleanField
      FieldName = 'RequireCustomer'
    end
    object quMeioPagValidateNonpayer: TBooleanField
      FieldName = 'ValidateNonpayer'
    end
  end
  object dsLookUpCashReg: TDataSource
    Left = 212
    Top = 128
  end
  object spCashRegOpen: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_Open;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegister'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill100'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill50'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill20'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill10'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill5'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill2'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin050'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin025'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin010'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin005'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin001'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OpenMoney'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCard'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCardPre'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCheck'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalOther'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalDebit'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@FinalCount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 520
    Top = 16
  end
  object spCashRegClose: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_Close;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUsuario'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill100'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill50'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill20'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill10'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill5'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill2'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin050'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin025'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin010'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin005'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin001'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCard'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCardPre'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCheck'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalOther'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalDebit'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@FinalCount'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@LogDocument'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 500
    Top = 376
  end
  object spNewSaleCode: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'SP_PreSale_GetNewSaleCode;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSaleParent'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDStore'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 20
        Value = Null
      end>
    Left = 504
    Top = 128
  end
  object quSearchPreSale: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pPreSaleDate'
        DataType = ftString
        Size = 21
        Value = '02/02/2004 10:44:35'
      end
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCashRegister'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'SaleCode'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale , I.IDCustomer'
      'FROM'
      #9'Invoice I INNER JOIN'
      #9'CashRegMov CR ON (I.CashRegMovID = CR.IDCashRegMov)'
      'WHERE'
      
        #9'convert(smalldatetime, I.PreSaleDate, 103) = convert(smalldatet' +
        'ime, :pPreSaleDate, 103)'
      #9'AND'
      #9'I.IDStore = :IDStore'
      #9'AND'
      #9'CR.IDCashRegister = :IDCashRegister'
      #9'AND'
      #9'I.SaleCode = :SaleCode'
      '')
    Left = 432
    Top = 76
  end
  object quSearchCashRegMov: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'OpenTime'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'CR.IDCashRegMov, '
      #9'CR.IDCashregStatus'
      'FROM'
      #9'CashRegMov CR'
      'WHERE'
      #9'CR.IDCashRegister = :IDCashRegister'
      #9'AND'
      #9'OpenTime = convert(smalldatetime, :OpenTime)')
    Left = 324
    Top = 76
  end
  object quRun: TADOQuery
    Connection = ADODBConnect
    Parameters = <>
    Left = 732
    Top = 16
  end
  object quQty: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'S.Name,'#13#10#9'I.QtyOnPreSale,'#13#10#9'I.QtyOnHand,'#13#10#9'I.QtyOnOrder' +
      ','#13#10#9'I.QtyOnRepair,'#13#10#9'I.StoreID,'#13#10#9'I.QtyOnPrePurchase,'#13#10#9'(IsNull(' +
      'M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost,0' +
      ')) as CurrentCost,'#13#10#9'M.FloatPercent,'#13#10#9'M.IDModel'#13#10'FROM'#13#10#9'Invento' +
      'ry I'#13#10#9'JOIN Model M ON (I.ModelID = M.IDModel)'#13#10#9'JOIN Store S ON' +
      ' (S.IDStore = I.StoreID)'#13#10'WHERE'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.Hid' +
      'den = 0'#13#10#9'AND'#13#10#9'S.Desativado = 0'#13#10#9'AND'#13#10#9'S.Hidden = 0'#13#10#9'AND'#13#10#9'Mo' +
      'delType IN ('#39'S'#39','#39'R'#39','#39'V'#39', '#39'C'#39', '#39'K'#39')'
    Parameters = <>
    Left = 36
    Top = 372
    object quQtyName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quQtyStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object quQtyCurrentCost: TBCDField
      FieldName = 'CurrentCost'
      ReadOnly = True
      Precision = 19
    end
    object quQtyFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object quQtyIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quQtyQtyOnPreSale: TBCDField
      FieldName = 'QtyOnPreSale'
      Precision = 32
    end
    object quQtyQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      Precision = 32
    end
    object quQtyQtyOnOrder: TBCDField
      FieldName = 'QtyOnOrder'
      Precision = 32
    end
    object quQtyQtyOnRepair: TBCDField
      FieldName = 'QtyOnRepair'
      Precision = 32
    end
    object quQtyQtyOnPrePurchase: TBCDField
      FieldName = 'QtyOnPrePurchase'
      Precision = 32
    end
  end
  object cmdPessoa: TADOCommand
    CommandText = 
      'INSERT Pessoa (IDPessoa, IDTipoPessoa, IDStore, IDTipoPessoaRoot' +
      ', IDUser, Pessoa, PessoaFirstName, PessoaLastName, Endereco, Cid' +
      'ade, CEP, Telefone, Juridico, CPF, Bairro, PhoneAreaCode, CellAr' +
      'eaCode, Cellular, Email, HomePage, Identidade, OrgaoEmissor, Dat' +
      'aExpedicao, Nascimento, CustomerCard, CartMotorista, NomeJuridic' +
      'o, InscEstadual, InscMunicipal, Contatos, OBS, CreationDate)'#13#10'VA' +
      'LUES (:IDPessoa, :IDTipoPessoa, :IDStore, :IDTipoPessoaRoot, :ID' +
      'User, :Pessoa, :PessoaFirstName, :PessoaLastName, :Endereco, :Ci' +
      'dade, :CEP, :Telefone, :Juridico, :CPF, :Bairro, :PhoneAreaCode,' +
      ' :CellAreaCode, :Cellular, :Email, :HomePage, :Identidade, :Orga' +
      'oEmissor, :DataExpedicao, :Nascimento, :CustomerCard, :CartMotor' +
      'ista, :NomeJuridico, :InscEstadual, :InscMunicipal, :Contatos, :' +
      'OBS, :CreationDate)'#13#10#13#10
    CommandTimeout = 360
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoaRoot'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PessoaFirstName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'PessoaLastName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Endereco'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 80
        Value = Null
      end
      item
        Name = 'Cidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CEP'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end
      item
        Name = 'Telefone'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Juridico'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'CPF'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Bairro'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PhoneAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'CellAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'Cellular'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 18
        Value = Null
      end
      item
        Name = 'Email'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'HomePage'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 200
        Value = Null
      end
      item
        Name = 'Identidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'OrgaoEmissor'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'DataExpedicao'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Nascimento'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'CustomerCard'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'CartMotorista'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'NomeJuridico'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'InscEstadual'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'InscMunicipal'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Contatos'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end
      item
        Name = 'CreationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    Left = 620
    Top = 356
  end
  object cmdExemptTax: TADOCommand
    CommandText = 
      'UPDATE Invoice SET Tax = 0, TaxIsent = :TaxIsent WHERE IDPreSale' +
      ' = :IDPreSale'
    CommandTimeout = 360
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'TaxIsent'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 620
    Top = 416
  end
  object quSearchPreSaleID: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'IDCustomer,'
      #9'IDInvoice,'
      #9'DeliverTypeID,'
      #9'MediaID,'
      #9'FirstName,'
      #9'LastName,'
      #9'Layaway,'
      #9'IDStore,'
      #9'ZIP,'
      #9'PreSaleDate,'
      #9'OtherComissionID,'
      #9'IDTouristGroup'
      'FROM'
      #9'Invoice (NOLOCK)'
      'WHERE'
      #9'IDPreSale = :IDPreSale')
    Left = 324
    Top = 132
  end
  object spCashRegWidraw: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_CashRegister_Widraw;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill100'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill50'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill20'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill10'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill5'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill2'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Bill1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin1'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin050'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin025'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin010'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin005'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Coin001'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCard'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCardPre'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalCheck'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalOther'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@TotalDebit'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@LogDocument'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@IDReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 500
    Top = 432
  end
  object spCashRegPetty: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 360
    ProcedureName = 'sp_CashRegister_PettyCash;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 616
    Top = 300
  end
  object quCashReg: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDCashRegister, '#13#10#9'Name, '#13#10#9'IsAssociated'#13#10'FROM'#13#10#9'CashRe' +
      'gister'#13#10'WHERE'#13#10#9'Desativado = 0'
    Parameters = <>
    Left = 112
    Top = 372
    object quCashRegIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object quCashRegName: TStringField
      FieldName = 'Name'
      Size = 15
    end
    object quCashRegIsAssociated: TBooleanField
      FieldName = 'IsAssociated'
    end
  end
  object quAccess: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'UR.CanAccess,'#13#10#9'SU.PW,'#13#10#9'SU.IDUser,'#13#10#9'UR.MenuID,'#13#10#9'UR.' +
      'SubMenuID'#13#10'FROM '#13#10#9'SystemUser SU '#13#10#9'INNER JOIN UserType UT ON ( ' +
      'SU.UserTypeID = UT.IDUserType )'#13#10#9'INNER JOIN UserRights UR ON  (' +
      ' UR.UserTypeID = UT.IDUserType )'#13#10'WHERE '#13#10#9'( SU.Desativado = 0 )'
    Parameters = <>
    Left = 336
    Top = 376
    object quAccessIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quAccessCanAccess: TBooleanField
      FieldName = 'CanAccess'
    end
    object quAccessPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
    object quAccessMenuID: TIntegerField
      FieldName = 'MenuID'
    end
    object quAccessSubMenuID: TIntegerField
      FieldName = 'SubMenuID'
    end
  end
  object quTaxCategory: TADODataSet
    Connection = ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IDTaxCategory,'#13#10#9'TaxCategory,'#13#10#9'Tax'#13#10'FROM'#13#10#9'TaxCategory' +
      #13#10'WHERE'#13#10#9'OperationType = 1'#13#10#9'AND'#13#10#9'SaleTaxType = 2'#13#10'ORDER BY'#13#10#9 +
      'TaxCategory'#13#10
    Parameters = <>
    Left = 220
    Top = 376
    object quTaxCategoryIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quTaxCategoryTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quTaxCategoryTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
  end
  object spCancelInvoice: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_CancelInvoice;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 612
    Top = 12
  end
  object quBanco: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDBanco, '#13#10#9'CodigoBanco, '#13#10#9'Banco'#13#10'FROM'#13#10#9'Fin_Banco'#13#10'WH' +
      'ERE'#13#10#9'Desativado = 0'
    Parameters = <>
    Left = 416
    Top = 248
    object quBancoIDBanco: TIntegerField
      FieldName = 'IDBanco'
    end
    object quBancoCodigoBanco: TStringField
      FieldName = 'CodigoBanco'
    end
    object quBancoBanco: TStringField
      FieldName = 'Banco'
      Size = 35
    end
  end
  object quDiscRange: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10'        IDTipoComissionado,'#13#10'        TotVendaMin,'#13#10'     ' +
      '   PercDiscMax'#13#10'FROM'#13#10'        DiscRange'
    Parameters = <>
    Left = 412
    Top = 312
    object quDiscRangeIDTipoComissionado: TIntegerField
      FieldName = 'IDTipoComissionado'
    end
    object quDiscRangeTotVendaMin: TBCDField
      FieldName = 'TotVendaMin'
      Precision = 19
    end
    object quDiscRangePercDiscMax: TBCDField
      FieldName = 'PercDiscMax'
      Precision = 19
    end
  end
  object quKitModel: TADODataSet
    Connection = ADODBConnect
    CommandText = 'SELECT'#13#10#9'IDModel, '#13#10#9'SellingPrice, '#13#10#9'Qty '#13#10'FROM'#13#10#9'KitModel'
    Parameters = <>
    Left = 412
    Top = 184
    object quKitModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quKitModelSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quKitModelQty: TBCDField
      FieldName = 'Qty'
      Precision = 32
    end
  end
  object quInvFeatures: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDInvFeatures, '#13#10#9'IDModel, '#13#10#9'Feature '#13#10'FROM'#13#10#9'InvFeatu' +
      'res'#13#10'WHERE'#13#10#9'Desativado = 0'
    Parameters = <>
    Left = 412
    Top = 376
    object quInvFeaturesIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object quInvFeaturesIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quInvFeaturesFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object quInvTechFeatures: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDInvTechFeatures, '#13#10#9'IDModel, '#13#10#9'TechFeature'#13#10'FROM'#13#10#9'I' +
      'nvTechFeatures'#13#10'WHERE'#13#10#9'Desativado = 0'
    Parameters = <>
    Left = 412
    Top = 432
    object quInvTechFeaturesIDInvTechFeatures: TIntegerField
      FieldName = 'IDInvTechFeatures'
    end
    object quInvTechFeaturesIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quInvTechFeaturesTechFeature: TStringField
      FieldName = 'TechFeature'
      Size = 255
    end
  end
  object quInvDepartment: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDDepartment, '#13#10#9'Department '#13#10'FROM'#13#10#9'Inv_Department'#13#10'WH' +
      'ERE'#13#10#9'Desativado = 0'#13#10#9'AND'#13#10#9'Hidden = 0'
    Parameters = <>
    Left = 112
    Top = 436
    object quInvDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quInvDepartmentDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object quInvModelDepartment: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    BeforeOpen = quInvModelDepartmentBeforeOpen
    CommandText = 
      'SELECT TOP 1'#13#10#9'MD.ModelID, '#13#10#9'MD.IDDepartment,'#13#10#9'D.Department'#13#10'F' +
      'ROM'#13#10#9'Inv_ModelDepartment MD (NOLOCK)'#13#10#9'INNER JOIN Inv_Departmen' +
      't D (NOLOCK) ON (MD.IDDepartment = D.IDDepartment)'#13#10'WHERE'#13#10#9'D.De' +
      'sativado = 0'#13#10#9'AND D.Hidden = 0'#13#10#9'AND MD.StoreID = :IDStore'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 220
    Top = 436
    object quInvModelDepartmentModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quInvModelDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quInvModelDepartmentDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object cdsBarcode: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspBarcode'
    Left = 221
    Top = 312
  end
  object dspBarcode: TDataSetProvider
    DataSet = quBarcode
    Options = [poIncFieldProps]
    Left = 222
    Top = 312
  end
  object cdsMedia: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMedia'
    Left = 36
    Top = 184
  end
  object dspMedia: TDataSetProvider
    DataSet = quMedia
    Options = [poIncFieldProps]
    Left = 36
    Top = 184
  end
  object cdsSystemUser: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSystemUser'
    Left = 116
    Top = 184
  end
  object dspSystemUser: TDataSetProvider
    DataSet = quSystemUser
    Options = [poIncFieldProps]
    Left = 116
    Top = 184
  end
  object cdsOtherCommission: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOtherCommission'
    Left = 224
    Top = 184
  end
  object dspOtherCommission: TDataSetProvider
    DataSet = quOtherCommission
    Options = [poIncFieldProps]
    Left = 224
    Top = 184
  end
  object cdsCustomer: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCustomer'
    Left = 36
    Top = 248
  end
  object dspCustomer: TDataSetProvider
    DataSet = quCustomer
    Options = [poIncFieldProps]
    Left = 36
    Top = 248
  end
  object cdsParam: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspParam'
    Left = 112
    Top = 248
  end
  object dspParam: TDataSetProvider
    DataSet = quParam
    Options = [poIncFieldProps]
    Left = 112
    Top = 248
  end
  object cdsStore: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspStore'
    Left = 336
    Top = 184
  end
  object dspStore: TDataSetProvider
    DataSet = quStore
    Options = [poIncFieldProps]
    Left = 336
    Top = 184
  end
  object cdsUserTypeToSysFunction: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUserTypeToSysFunction'
    Left = 224
    Top = 248
  end
  object dspUserTypeToSysFunction: TDataSetProvider
    DataSet = quUserTypeToSysFunction
    Options = [poIncFieldProps]
    Left = 224
    Top = 248
  end
  object cdsUserRights: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUserRights'
    Left = 336
    Top = 248
  end
  object dspUserRights: TDataSetProvider
    DataSet = quUserRights
    Options = [poIncFieldProps]
    Left = 336
    Top = 248
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModel'
    Left = 123
    Top = 308
  end
  object dspModel: TDataSetProvider
    DataSet = quModel
    Options = [poIncFieldProps]
    Left = 123
    Top = 308
  end
  object cdsModelAccessory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModelAccessory'
    Left = 36
    Top = 312
  end
  object dspModelAccessory: TDataSetProvider
    DataSet = quModelAccessory
    Options = [poIncFieldProps]
    Left = 36
    Top = 312
  end
  object cdsQty: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQty'
    Left = 36
    Top = 372
  end
  object cdsCashReg: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCashReg'
    Left = 112
    Top = 372
  end
  object cdsInvDepartment: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvDepartment'
    Left = 112
    Top = 436
  end
  object cdsTaxCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTaxCategory'
    Left = 220
    Top = 376
  end
  object cdsMeioPag: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPag'
    Left = 336
    Top = 312
  end
  object dspMeioPag: TDataSetProvider
    DataSet = quMeioPag
    Options = [poIncFieldProps]
    Left = 336
    Top = 312
  end
  object dspQty: TDataSetProvider
    DataSet = quQty
    Options = [poIncFieldProps]
    Left = 36
    Top = 372
  end
  object dspCashReg: TDataSetProvider
    DataSet = quCashReg
    Options = [poIncFieldProps]
    Left = 112
    Top = 372
  end
  object cdsInvModelDepartment: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvModelDepartment'
    Left = 220
    Top = 436
  end
  object cdsAccess: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspAccess'
    Left = 336
    Top = 376
  end
  object dspAccess: TDataSetProvider
    DataSet = quAccess
    Options = [poIncFieldProps]
    Left = 336
    Top = 376
  end
  object dspTaxCategory: TDataSetProvider
    DataSet = quTaxCategory
    Options = [poIncFieldProps]
    Left = 220
    Top = 376
  end
  object cdsKitModel: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspKitModel'
    Left = 412
    Top = 184
  end
  object dspKitModel: TDataSetProvider
    DataSet = quKitModel
    Options = [poIncFieldProps]
    Left = 412
    Top = 184
  end
  object dspInvDepartment: TDataSetProvider
    DataSet = quInvDepartment
    Options = [poIncFieldProps]
    Left = 112
    Top = 436
  end
  object dspInvModelDepartment: TDataSetProvider
    DataSet = quInvModelDepartment
    Options = [poIncFieldProps]
    Left = 220
    Top = 436
  end
  object cdsBanco: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspBanco'
    Left = 416
    Top = 248
  end
  object dspBanco: TDataSetProvider
    DataSet = quBanco
    Options = [poIncFieldProps]
    Left = 416
    Top = 248
  end
  object cdsDiscRange: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDiscRange'
    Left = 412
    Top = 312
  end
  object dspDiscRange: TDataSetProvider
    DataSet = quDiscRange
    Options = [poIncFieldProps]
    Left = 412
    Top = 312
  end
  object cdsInvFeatures: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvFeatures'
    Left = 412
    Top = 376
  end
  object dspInvFeatures: TDataSetProvider
    DataSet = quInvFeatures
    Options = [poIncFieldProps]
    Left = 412
    Top = 376
  end
  object cdsInvTechFeatures: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvTechFeatures'
    Left = 412
    Top = 432
  end
  object dspInvTechFeatures: TDataSetProvider
    DataSet = quInvTechFeatures
    Options = [poIncFieldProps]
    Left = 412
    Top = 432
  end
  object FTP: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    OnDisconnected = FTPDisconnected
    OnConnected = FTPConnected
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 264
    Top = 12
  end
  object dsLookUpStore: TDataSource
    Left = 120
    Top = 128
  end
  object cmdAddDeletedItem: TADOCommand
    CommandText = 
      'INSERT Sal_RemovedItem '#13#10#9'('#13#10#9'IDRemovedItem,'#13#10#9'IDCashRegister,'#13#10 +
      #9'IDModel,'#13#10#9'IDStore,'#13#10#9'IDDepartment,'#13#10#9'IDUserAuto,'#13#10#9'IDPessoa,'#13#10 +
      #9'IDUser,'#13#10#9'MovDate,'#13#10#9'Qty,'#13#10#9'SalePrice,'#13#10#9'CostPrice,'#13#10#9'Discount,' +
      #13#10#9'SaleCode,'#13#10#9'PosicaoItem,'#13#10#9'Acrescimo,'#13#10#9'TotalizadorParcial,'#13#10 +
      #9'IDNotasCanceladas,'#13#10#9'IDPreSale'#13#10#9')'#13#10'VALUES'#13#10#9'('#13#10#9':IDRemovedItem' +
      ','#13#10#9':IDCashRegister,'#13#10#9':IDModel,'#13#10#9':IDStore,'#13#10#9':IDDepartment,'#13#10#9 +
      ':IDUserAuto,'#13#10#9':IDPessoa,'#13#10#9':IDUser,'#13#10#9':MovDate,'#13#10#9':Qty,'#13#10#9':Sale' +
      'Price,'#13#10#9':CostPrice,'#13#10#9':Discount,'#13#10#9':SaleCode,'#13#10#9':PosicaoItem,'#13#10 +
      #9':Acrescimo,'#13#10#9':TotalizadorParcial,'#13#10#9':IDNotasCanceladas,'#13#10#9':IDP' +
      'reSale'#13#10#9')'#13#10
    CommandTimeout = 360
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'IDRemovedItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDDepartment'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUserAuto'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SalePrice'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Discount'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'PosicaoItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Acrescimo'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'TotalizadorParcial'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end
      item
        Name = 'IDNotasCanceladas'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 616
    Top = 240
  end
  object quTestRemovedItem: TADODataSet
    Connection = ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'IDRemovedItem'#13#10'FROM'#13#10#9'Sal_RemovedItem '#13#10'WHERE'#13#10#9'IDCash' +
      'Register = :IDCashRegister'#13#10#9'AND'#13#10#9'IDModel = :IDModel'#13#10#9'AND'#13#10#9'ID' +
      'Store = :IDStore'#13#10#9'AND'#13#10#9'IDUserAuto = :IDUserAuto'#13#10#9'AND'#13#10#9'MovDat' +
      'e = :MovDate'#13#10#9'AND'#13#10#9'SaleCode = :SaleCode'#13#10#9'AND'#13#10#9'PosicaoItem = ' +
      ':PosicaoItem'#13#10
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUserAuto'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'PosicaoItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 616
    Top = 192
    object quTestRemovedItemIDRemovedItem: TIntegerField
      FieldName = 'IDRemovedItem'
    end
  end
  object quTestReducaoZ: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 360
    Parameters = <
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'NumeroSerie'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'R.IDReducaoZ'
      'FROM'
      #9'Sal_ReducaoZ R'
      'WHERE'
      #9'R.MovDate = :MovDate'
      #9'AND R.NumeroSerie = :NumeroSerie')
    Left = 744
    Top = 296
  end
  object cmdInsertTributacaoECF: TADOCommand
    CommandText = 
      'INSERT INTO Sal_TributacaoECF (IDTributacaoECF, Aliquota, BaseCa' +
      'lculo, ValImposto, IDReducaoZ)'#13#10'VALUES (:IDTributacaoECF, :Aliqu' +
      'ota, :BaseCalculo, :ValImposto, :IDReducaoZ)'#13#10
    CommandTimeout = 360
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'IDTributacaoECF'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Aliquota'
        Attributes = [paSigned]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'BaseCalculo'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'ValImposto'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDReducaoZ'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 744
    Top = 356
  end
  object spCashRegAddCash: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 360
    ProcedureName = 'sp_CashRegister_AddCash;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TotalCash'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 19
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OBS'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@COO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@GNF'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegLog'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 744
    Top = 240
  end
  object spCancelHold: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 900
    ProcedureName = 'sp_PreSale_CancelHold;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSale'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 612
    Top = 72
  end
  object quInvSerial: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 'SELECT'#13#10#9'StoreID,'#13#10#9'ModelID,'#13#10#9'Serial'#13#10'FROM'#13#10#9'InventorySerial'#13#10
    Parameters = <>
    Left = 516
    Top = 184
    object quInvSerialStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object quInvSerialModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quInvSerialSerial: TStringField
      FieldName = 'Serial'
      Size = 30
    end
  end
  object cdsInvSerial: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvSerial'
    Left = 516
    Top = 184
  end
  object dspInvSerial: TDataSetProvider
    DataSet = quInvSerial
    Options = [poIncFieldProps]
    Left = 515
    Top = 184
  end
  object quStoreTablePrice: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'ISP.IDStore,'#13#10#9'ISP.IDModel,'#13#10#9'ISP.IDDescriptionPrice,'#13#10 +
      #9'ISP.IDVendor,'#13#10#9'ISP.SuggPrice,'#13#10#9'ISP.SalePrice,'#13#10#9'IDP.Descripti' +
      'onPrice,'#13#10#9'V.Pessoa Vendor'#13#10'FROM'#13#10#9'Inv_StorePrice ISP'#13#10#9'JOIN Inv' +
      '_DescriptionPrice IDP ON (ISP.IDDescriptionPrice = IDP.IDDescrip' +
      'tionPrice)'#13#10#9'LEFT JOIN Pessoa V ON (ISP.IDVendor = V.IDPessoa)'#13#10 +
      'WHERE'#13#10#9'ISP.IDStore = :IDStore'
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 516
    Top = 248
    object quStoreTablePriceIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreTablePriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quStoreTablePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object quStoreTablePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quStoreTablePriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      Precision = 19
    end
    object quStoreTablePriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quStoreTablePriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
    object quStoreTablePriceVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object cdsStoreTablePrice: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspStoreTablePrice'
    Left = 516
    Top = 248
  end
  object dspStoreTablePrice: TDataSetProvider
    DataSet = quStoreTablePrice
    Options = [poIncFieldProps]
    Left = 515
    Top = 248
  end
  object quModelTablePrice: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IMP.IDModel,'#13#10#9'IMP.IDDescriptionPrice,'#13#10#9'IMP.IDVendor,'#13 +
      #10#9'IMP.SuggPrice,'#13#10#9'IMP.SalePrice,'#13#10#9'IDP.DescriptionPrice,'#13#10#9'V.Pe' +
      'ssoa Vendor'#13#10'FROM'#13#10#9'Inv_ModelPrice IMP'#13#10#9'JOIN Inv_DescriptionPri' +
      'ce IDP ON (IMP.IDDescriptionPrice = IDP.IDDescriptionPrice)'#13#10#9'LE' +
      'FT JOIN Pessoa V ON (IMP.IDVendor = V.IDPessoa)'#13#10
    Parameters = <>
    Left = 516
    Top = 312
    object quModelTablePriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelTablePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object quModelTablePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quModelTablePriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      Precision = 19
    end
    object quModelTablePriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quModelTablePriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
    object quModelTablePriceVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object cdsModelTablePrice: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModelTablePrice'
    Left = 516
    Top = 312
  end
  object dspModelTablePrice: TDataSetProvider
    DataSet = quModelTablePrice
    Options = [poIncFieldProps]
    Left = 515
    Top = 312
  end
  object quDocumentType: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'DT.IDDocumentType,'#13#10#9'DT.DocumentType,'#13#10#9'DT.DefaultType'#13 +
      #10'FROM'#13#10#9'Mnt_DocumentType DT'#13#10'ORDER BY'#13#10#9'DT.DocumentType'#13#10
    Parameters = <>
    Left = 36
    Top = 436
    object quDocumentTypeIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object quDocumentTypeDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object quDocumentTypeDefaultType: TBooleanField
      FieldName = 'DefaultType'
    end
  end
  object cdsDocumentType: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentType'
    Left = 36
    Top = 436
  end
  object dspDocumentType: TDataSetProvider
    DataSet = quDocumentType
    Options = [poIncFieldProps]
    Left = 36
    Top = 436
  end
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    StoreOptions = [soStripPath, soReplace]
    Left = 324
    Top = 11
  end
  object UnZipper: TAbUnZipper
    Left = 377
    Top = 11
  end
  object quCashRegLogReason: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDCashRegLogReason,'
      #9'Reason'
      'FROM'
      #9'CashRegLogReason'
      'WHERE'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0'
      'ORDER BY'
      #9'Reason')
    Left = 740
    Top = 180
    object quCashRegLogReasonIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object quCashRegLogReasonReason: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
  object dspCashRegLogReason: TDataSetProvider
    DataSet = quCashRegLogReason
    Left = 740
    Top = 180
  end
  object cdsCashRegLogReason: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCashRegLogReason'
    Left = 740
    Top = 180
    object cdsCashRegLogReasonIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object cdsCashRegLogReasonReason: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
  object dsMeioPagMinSale: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDMeioPag,'#13#10#9'DifDay,'#13#10#9'TotalSale'#13#10'FROM'#13#10#9'MeioPagMinSale' +
      ' (NOLOCK)'#13#10
    Parameters = <>
    Left = 336
    Top = 432
    object dsMeioPagMinSaleIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object dsMeioPagMinSaleDifDay: TIntegerField
      FieldName = 'DifDay'
    end
    object dsMeioPagMinSaleTotalSale: TBCDField
      FieldName = 'TotalSale'
      Precision = 19
    end
  end
  object cdsMeioPagMinSale: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPagMinSale'
    Left = 336
    Top = 432
  end
  object dspMeioPagMinSale: TDataSetProvider
    DataSet = dsMeioPagMinSale
    Options = [poIncFieldProps]
    Left = 336
    Top = 432
  end
  object cmdInsertLancComplement: TADOCommand
    CommandText = 
      'INSERT Fin_LancamentoComplement (IDLancamento, COO, GNF, CDC, Da' +
      'taEmissao)'#13#10'SELECT'#13#10#9'F.IDLancamento,'#13#10#9':COO,'#13#10#9':GNF,'#13#10#9':CDC,'#13#10#9':' +
      'DataEmissao'#13#10'FROM'#13#10#9'Fin_Lancamento F (NOLOCK)'#13#10#9'JOIN MeioPag MP ' +
      '(NOLOCK) ON (MP.IDMeioPag = F.IDQuitacaoMeioPrevisto)'#13#10'WHERE'#13#10#9'F' +
      '.IDPreSale = :IDPreSale'#13#10#9'AND'#13#10#9'MP.Tipo IN (2, 4, 7)'
    CommandTimeout = 990
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'COO'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'GNF'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'CDC'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataEmissao'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPreSale'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 744
    Top = 124
  end
  object cmdInsertNotaCancel: TADOCommand
    CommandText = 
      'INSERT Sal_NotasCanceladas (IDNotasCanceladas, IDPessoa, IDUser,' +
      ' Cliente, CPFCGC, COO, CCF, DataNota, SubTotal, Desconto, Acresc' +
      'imo, TipoAcrescimo, TipoDesconto, IDCashRegMov)'#13#10'VALUES (:IDNota' +
      'sCanceladas, :IDPessoa, :IDUser, :Cliente, :CPFCGC, :COO, :CCF, ' +
      ':DataNota, :SubTotal, :Desconto, :Acrescimo, :TipoAcrescimo, :Ti' +
      'poDesconto, :IDCashRegMov)'
    CommandTimeout = 900
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'IDNotasCanceladas'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Cliente'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CPFCGC'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'COO'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CCF'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataNota'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'SubTotal'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Desconto'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Acrescimo'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'TipoAcrescimo'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'TipoDesconto'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 1
        Value = Null
      end
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 616
    Top = 132
  end
  object quPreSaleItemCanceled: TADODataSet
    Connection = ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'I.IDCustomer,'#13#10#9'I.FirstName + '#39' '#39' + I.LastName as Custo' +
      'mer,'#13#10#9'I.CompanyCGC as CPFCGC,'#13#10#9'I.CupomFiscal as COO,'#13#10#9'I.Invoi' +
      'ceCode,'#13#10#9'I.PreSaleDate,'#13#10#9'I.SubTotal,'#13#10#9'I.InvoiceDiscount + I.I' +
      'temDiscount as Discount,'#13#10#9'I.CashRegMovID,'#13#10#9'IM.ModelID,'#13#10#9'IM.St' +
      'oreID,'#13#10#9'IM.IDDepartment,'#13#10#9'IM.SequencyNum,'#13#10#9'IM.Qty,'#13#10#9'IM.Disco' +
      'unt,'#13#10#9'IM.SalePrice,'#13#10#9'IM.CostPrice,'#13#10#9'IM.IDUser,'#13#10#9'IMC.Totaliza' +
      'dorParcial'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'JOIN InventoryMov IM (NO' +
      'LOCK) ON (I.IDInvoice = IM.DocumentID AND InventMovTypeID = 1)'#13#10 +
      #9'LEFT JOIN Inv_MovComplement IMC (NOLOCK) ON (IMC.IDInventoryMov' +
      ' = IM.IDInventoryMov)'#13#10'WHERE'#13#10#9'I.IDPreSale = :IDPresale'#13#10#9'AND'#13#10#9 +
      'I.Canceled = 0'
    CommandTimeout = 990
    Parameters = <
      item
        Name = 'IDPresale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 740
    Top = 72
  end
  object cmdInsertTotalizadorParcial: TADOCommand
    CommandText = 
      'INSERT INTO Sal_TotalizadorParcial (IDTotalizadorParcial, IDRedu' +
      'caoZ, Codigo, ValorAcumulado)'#13#10'VALUES (:IDTotalizadorParcial, :I' +
      'DReducaoZ, :Codigo, :ValorAcumulado)'#13#10
    CommandTimeout = 900
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'IDTotalizadorParcial'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDReducaoZ'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'ValorAcumulado'
        DataType = ftFloat
        Size = -1
        Value = Null
      end>
    Left = 749
    Top = 469
  end
  object cmdInsertReducaoZ: TADOCommand
    CommandText = 
      'INSERT INTO Sal_ReducaoZ (IDReducaoZ, MovDate, NumeroSerie, Nume' +
      'roLoja, NumeroECF, NumReducaoZ, COOInicial, COOFinal, NumCancela' +
      'mentos, ValCancelamentos, ValDescontos, GTInicial, GTFinal, Subs' +
      'tituicaoTrib, Isencao, NaoTributavel, TipoECF, MarcaECF, ModeloE' +
      'CF, VersaoSBECF, DataInstalacaoSBECF, MFAdicional, ContadorReduc' +
      'aoZ, ContadorOrdemOperacao, ContadorReinicioOperacao, NumeroUsua' +
      'rioECF, IncideISSQN, DataEmissao, IDCashRegister)'#13#10'VALUES (:IDRe' +
      'ducaoZ, :MovDate, :NumeroSerie, :NumeroLoja, :NumeroECF, :NumRed' +
      'ucaoZ, :COOInicial, :COOFinal, :NumCancelamentos, :ValCancelamen' +
      'tos, :ValDescontos, :GTInicial, :GTFinal, :SubstituicaoTrib, :Is' +
      'encao, :NaoTributavel, :TipoECF, :MarcaECF, :ModeloECF, :VersaoS' +
      'BECF, :DataInstalacaoSBECF, :MFAdicional, :ContadorReducaoZ, :Co' +
      'ntadorOrdemOperacao, :ContadorReinicioOperacao, :NumeroUsuarioEC' +
      'F, :IncideISSQN, :DataEmissao, :IDCashRegister)'#13#10
    CommandTimeout = 900
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'IDReducaoZ'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'NumeroSerie'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'NumeroLoja'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'NumeroECF'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'NumReducaoZ'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'COOInicial'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'COOFinal'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'NumCancelamentos'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ValCancelamentos'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'ValDescontos'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'GTInicial'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'GTFinal'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SubstituicaoTrib'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Isencao'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NaoTributavel'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'TipoECF'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'MarcaECF'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'ModeloECF'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'VersaoSBECF'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInstalacaoSBECF'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'MFAdicional'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'ContadorReducaoZ'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'ContadorOrdemOperacao'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'ContadorReinicioOperacao'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'NumeroUsuarioECF'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IncideISSQN'
        DataType = ftBoolean
        Size = -1
        Value = Null
      end
      item
        Name = 'DataEmissao'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCashRegister'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 748
    Top = 415
  end
  object spPreSaleRemove: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_PreSale_Remove;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 215
    Top = 75
  end
end
