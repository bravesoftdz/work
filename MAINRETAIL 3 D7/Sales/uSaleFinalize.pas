(*
-----------------------------------------------------------------------------------------------------
Version : (290 - 287)
Date    : 03.30.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : wrong gift error ( balance is same total amount ).
Solution: divide by quantity of gift cards.
Version : (290 - 288)
-----------------------------------------------------------------------------------------------------

Version : (287 - 275)
Date    : 12.01.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Bonus code expired date.
Solution: Bonuscode field must be NULL.
Version : (287 - 276)
-----------------------------------------------------------------------------------------------------

Version : (287 - 274)
Date    : 11.05.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Bonus Bucks can not be generated to sales less than minvalue sale to discount (bonus bucks screen)
Solution: because Gymbo is not used anymore, I had to test minvalue before write record in Sal_RebateDiscount.
Version : (287 - 275)
-----------------------------------------------------------------------------------------------------

Version : (287 - 273)
Date    : 11.05.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Bonus Bucks error when finalize sale
Solution: Disable call to Gymbo WebServer and not test any more BonusCode before insert bonus bucks.
Version : (287 - 274)
-----------------------------------------------------------------------------------------------------
*)


unit uSaleFinalize;

interface

uses
  Classes, ADODB, uMRTraceControl, Contnrs, uGynboSyncClasses, uMsgBox,
  uMsgConstant, Dialogs, uInvoiceInfo, dbClient,  uCCMercuryIntegration;

type
  TInventoryMov = class
    FIDInventoryMov      : Integer;
    FInventMovTypeID     : Integer;
    FIDPessoa            : Integer;
    FStoreID             : Integer;
    FModelID             : Integer;
    FBarCodeID           : String;
    FMovDate             : TDateTime;
    FQty                 : Double;
    FCostPrice           : Currency;
    FSalePrice           : Currency;
    FDiscount            : Currency;
    FPreInventoryMovID   : Integer;
    FIDUser              : Integer;
    FIDTaxCategory       : Integer;
    FSalesTax            : Currency;
    FIDParentPack        : Integer;
    FQtyExchanged        : Double;
    FIDPreInvMovExchange : Integer;
    FAvgCost             : Currency;
    FDesiredMarkup       : Double;
    FSequencyNum         : Variant;
    FIDDepartment        : Integer;
    FPromo               : Boolean;

    //Antonio M F Souza December 10, 2012
    FUnitDiscount        : Currency;
  end;

  TSaleFinalize = class
  private
    FADOConnection     : TADOConnection;
    FTraceControl      : TMRTraceControl;
    FSearchQuery       : TADOQuery;
    FFreeQuery         : TADOQuery;
    FInsertCommand     : TADOCommand;
    FStoredProc        : TADOStoredProc;
    FInvMovList        : TList;
    FBonusBucks        : Currency;
    FCashReceived      : Currency;
    FIDCashRegMov      : Integer;
    FIDTouristGroup    : Integer;
    FIDStore           : Integer;
    FOtherComID        : Integer;
    FIDPreSale         : Integer;
    FIDInvoice         : Integer;
    FIDUser            : Integer;
    FPayDate           : TDateTime;
    FSaleDate          : TDateTime;
    FBonusSync         : TbgBonusSync;

    FGeneratePrice     : Boolean;
    FInvoiceCode       : String;
    FInvoiceInfo       : TInvoiceInfo;
    FInvoiceTotal      : Currency;

    // Antonio 2013 Dec 06, MR-135
    procedure VerifyMercuryTransaction(arg_pendingList: TClientDataset; arg_mercuryGiftCard: TCPrepaid;
    arg_issued: Integer = 0);

    // Antonio, 2013 Dec 06, MR-135
    procedure prepareNotIssuedMercuryGift();

    procedure CreateInvoiceCode;
    procedure FreeInvMovList;

    function getSerialMovQuantityRecorded(arg_invoice: Integer): integer;
    function GetNextCode(Tabela : String) : Integer;
    function GetIntProperty(AProperty : String) : Integer;
    function GetCurProperty(AProperty : String) : Currency;

    function FormatIntToVariant(AValue : Integer) : Variant;
    function FormatCurToVariant(AValue : Currency) : Variant;
    function FormatFloatToVariant(AValue : Double) : Variant;
    function FormatStrToVariant(AValue : String) : Variant;

    function LoadParams : Boolean;
    function LoadInvMovData : Boolean;
    function ValidatePayments : Boolean;
    function UpdateInvoice : Boolean;
    function CreateInventoryMov : Boolean;
    function SendItemRepair : Boolean;
    function InsertAccountCard : Boolean;
    function InsertSerialMov : Boolean;
    function DelInsInventorySerial : Boolean;
    function DelPreSerialMov : Boolean;
    function UpdateInvModelsPack : Boolean;
    function UpdatePreInvMovParent : Boolean;
    function DeletePreInventory : Boolean;
    function UpdatePaymentStatus : Boolean;
    function InsertBonusBucks : Boolean;
    function ProcessBonus : Boolean;
    function VoidBonus : Boolean;
    function getMercuryGiftCards(card_list: TClientDataSet): Boolean;


  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl; invoice_info: TInvoiceInfo = nil);
    destructor Destroy; Override;

    property IDPreSale      : Integer       read FIDPreSale      write FIDPreSale;
    property IDTouristGroup : Integer       read FIDTouristGroup write FIDTouristGroup;
    property OtherComID     : Integer       read FOtherComID     write FOtherComID;
    property IDCashRegMov   : Integer       read FIDCashRegMov   write FIDCashRegMov;
    property IDStore        : Integer       read FIDStore        write FIDStore;
    property IDInvoice      : Integer       read FIDInvoice      write FIDInvoice;
    property IDUser         : Integer       read FIDUser         write FIDUser;
    property SaleDate       : TDateTime     read FSaleDate       write FSaleDate;
    property PayDate        : TDateTime     read FPayDate        write FPayDate;
    property CashReceived   : Currency      read FCashReceived   write FCashReceived;
    property BonusBucks     : Currency      read FBonusBucks     write FBonusBucks;
    property BonusSync      : TbgBonusSync  read FBonusSync      write FBonusSync;

    function ProccessSale(var AIDInvoice : Integer; var AError : String; cdsmercury_gift: TClientDataSet = nil) : Boolean;

  end;

implementation

uses SysUtils, DB, Variants, ConvUtils, uNumericFunctions,uCreditCardFunction, uDM, uDebugFunctions;

{ TSaleReceive }

function TSaleFinalize.ProccessSale(var AIDInvoice : Integer; var AError : String; cdsmercury_gift: TClientDataSet): Boolean;
begin

  Result := False;
  AError := '';

  //amfsouza 02.04.2012
  //FInvoiceInfo := invoice_info;

  FInvoiceTotal := 0;

  FTraceControl.TraceIn('TSaleFinalize.ProccessSale');

  //1 - Carrega os parametros
  LoadParams;
  //2 - Valida total pagamentos
  ValidatePayments;
  //3 - Carrega os dados necessários para o processamento
  LoadInvMovData;

  CreateInvoiceCode;

  //Save bonus
  ProcessBonus;

  FADOConnection.BeginTrans;

  try
   debugTofile('finishing sale - begin');
    //3 - Atualiza o Invoice
    UpdateInvoice;
    //4 - Move os PreInventMov para o InventMov
    CreateInventoryMov;
    //5 - Envia o item da venda para reparo
    SendItemRepair;

    //6 - Insere a movimentação de crédito na tabela de AccountCard
    debugtofile('insert account card - begin');
    InsertAccountCard;
    debugtofile('insert account card - end');


    //7 - Move os PreSerialMov para o SerialMov
    debugtofile('moving PreserialMov to SerialMov - begin');
    InsertSerialMov;
    debugtofile('moving PreserialMov to SerialMov - end');

    //8 - Deleta/Insert os seriais do Inventario
    debugtofile('delete/insert inventory serial - begin');
    DelInsInventorySerial;
    debugtofile('delete/insert inventory serial - end');

    //9 - Deleta PreSerial Movement
    debugtofile('delete PreserialMov - begin');
    DelPreSerialMov;
    debugtofile('delete PreserialMov - end');

    //10 - Atualiza  os ModelsPack de InvMov
    debugtofile('update ModelPack - begin');
    UpdateInvModelsPack;
    debugtofile('update ModelPack - end');

    //11 - Desmarca os PreInventoryMovement Parent
    debugtofile('Unckeck Preinventory Movement Parent - begin');
    UpdatePreInvMovParent;
    debugtofile('Unckeck Preinventory Movement Parent - end');

    //12 - Deleta PreInventory Movement
    debugtofile('Delete Preinventory movement - begin');
    DeletePreInventory;
    debugtofile('Delete Preinventory movement - end');

    //13 - Marca os lancamentos como confimados, e troca o documento
    debugtofile('Update Payment Status - begin');
    UpdatePaymentStatus;
    debugtofile('Update Payment Status - end');

    //14 - Insere o bonus bucks
    debugtofile('Insert Bonus Bucks - begin');
    InsertBonusBucks;
    debugtofile('Insert Bonus Bucks - end');

   debugTofile('finishing sale - end');

    FADOConnection.CommitTrans;
    Result := True;

  except
    on E: Exception do
    begin
      FADOConnection.RollbackTrans;
      VoidBonus;
      Result := False;
      AIDInvoice := -1;
      AError := E.Message;

      debugtofile(format('Exception to Finish Sale:  %s', [e.Message]));

      FTraceControl.SaveTrace(IDUser, AError, 'TSaleFinalize');
    end;
  end;

  FTraceControl.TraceOut;

end;

constructor TSaleFinalize.Create(AADOConnection: TADOConnection;
  ATraceControl: TMrTraceControl; invoice_info: TInvoiceInfo);
begin

  FADOConnection     := AADOConnection;
  FTraceControl      := ATraceControl;
  FSearchQuery       := TADOQuery.Create(nil);
  FInsertCommand     := TADOCommand.Create(nil);
  FFreeQuery         := TADOQuery.Create(nil);
  FStoredProc        := TADOStoredProc.Create(nil);
  FInvMovList        := TList.Create;

  FSearchQuery.Connection       := FADOConnection;
  FFreeQuery.Connection         := FADOConnection;
  FInsertCommand.Connection     := FADOConnection;
  FStoredProc.Connection        := FADOConnection;
  FInvoiceInfo                  := invoice_info;
end;

destructor TSaleFinalize.Destroy;
begin
  FreeAndNil(FSearchQuery);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FFreeQuery);
  FreeAndNil(FStoredProc);
  FreeInvMovList;
  FreeAndNil(FInvMovList);
  inherited;
end;

function TSaleFinalize.LoadParams: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.LoadParams');

  Result := False;

  try
    with FSearchQuery do
      try
        SQL.Clear;
        SQL.Add('SELECT SrvValue FROM Param (NOLOCK) WHERE IDParam = 97');
        Open;
        if UpperCase(FieldByName('SrvValue').AsString) = 'TRUE' then
          FGeneratePrice := True
        else
          FGeneratePrice := False;
      finally
        Close;
        SQL.Clear;
      end;

  except
    on E: Exception do
      raise Exception.Create('-100: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.ValidatePayments: Boolean;
var
  TotalPaid : Currency;
  totalPaidStr: String;
  totalInvoiceStr: String;
  commaPosition: Integer;
begin

  FTraceControl.TraceIn('TSaleFinalize.ValidatePayments');

  TotalPaid := 0;

  Result := False;

  try
    with FSearchQuery do
      try
        SQL.Clear;
        SQL.Add('SELECT SUM(IsNull(ValorNominal, 0)) as TotalPaid');
        SQL.Add('FROM Fin_Lancamento (NOLOCK)');
        SQL.Add('WHERE IDPreSale = :IDPreSale');
        Parameters.ParamByName('IDPreSale').Value := IDPreSale;
        Open;

        //amfsouza 02.07.2012: Total paid
        totalPaidStr := floatToStrF(FieldByName('TotalPaid').AsCurrency, ffNumber, 15, 2);
        commaPosition := pos(',', totalPaidStr);

        if ( commaPosition > 0 ) then
           System.delete(totalPaidStr, commaPosition, 1);

        TotalPaid := strToFloat(totalPaidStr);

        // AmfSouza November 20, 2012: Total Invoice
        totalInvoiceStr := floatToStrF(FInvoiceInfo.TotalInvoice, ffNumber, 15, 2);
        commaPosition := pos(',', totalInvoiceStr);

        if ( commaPosition > 0 ) then
           System.delete(totalInvoiceStr, commaPosition, 1);

        FInvoiceTotal := strToFloat(totalInvoiceStr);

      finally
        Close;
        SQL.Clear;
      end;
  except
    on E: Exception do
      raise Exception.Create('-101: ' + E.Message);
  end;

  if ( TotalPaid <> FInvoiceTotal ) then
    raise Exception.Create('-103: Total Invoice <> Payments');

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.UpdateInvoice: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.UpdateInvoice');

  Result := False;

  try
    with FInsertCommand do
    begin
      CommandText := 'UPDATE Invoice SET IDInvoice = :IDInvoice, InvoiceDate = :PayDate, CashReceived = :CashReceived, ' +
                     'CashRegMovID = :IDCashRegMov, InvoiceCode = :InvoiceCode ' +
                     'WHERE IDPreSale = :IDPreSale';

      Parameters.ParamByName('IDInvoice').Value    := FIDInvoice;
      Parameters.ParamByName('PayDate').Value      := FPayDate;
      Parameters.ParamByName('CashReceived').Value := FCashReceived;
      Parameters.ParamByName('IDCashRegMov').Value := FIDCashRegMov;
      Parameters.ParamByName('InvoiceCode').Value  := FInvoiceCode;
      Parameters.ParamByName('IDPreSale').Value    := FIDPreSale;
      Execute;
    end;

  except
    on E: Exception do
      raise Exception.Create('-104: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.GetNextCode(Tabela: String): Integer;
begin

  FTraceControl.TraceIn('TSaleFinalize.UpdateInvoice');

  Result := -1;

  try
    with FStoredProc do
    begin
      ProcedureName := 'sp_Sis_GetNextCode;1';
      Parameters.Refresh;
      Parameters.ParamByName('@Tabela').Value := Tabela;
      ExecProc;
      Result := Parameters.ParamByName('@NovoCodigo').Value;
    end;
  except
    on E: Exception do
      raise Exception.Create('-105: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

procedure TSaleFinalize.CreateInvoiceCode;
begin
  FIDInvoice   := GetNextCode('InvoiceGen.IDInvoice');
  FInvoiceCode := IntToStr(GetNextCode('Invoice.InvoiceCode' + IntToStr(FIDStore)));
end;

function TSaleFinalize.CreateInventoryMov: Boolean;
var
  i: Integer;
  cSuggPrice : Currency;
  iIDVendorPrice, iIDLancamentoTipo, iIDDocumentoTipo,
  iIDPagamentoTipo, iDiasVencimento, iIDVendorType,
  iIDCentroCusto, iIDContaCorrente, iIDEmpresa,
  iIDFinLancamento : Integer;
begin

  FTraceControl.TraceIn('TSaleFinalize.CreateInventoryMov');

  Result := False;

  for i := 0 to Pred(FInvMovList.Count) do
  begin
    //Insiro os produtos no Inventory Mov
    try
      FInsertCommand.CommandText
          := 'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID, ' +
             'IDPessoa, StoreID, ModelID, BarCodeID, MovDate, Qty, CostPrice, ' +
             'SalePrice, Discount, PreInventoryMovID, IDUser, SalesTax, ' +
             'IDParentPack, QtyExchanged, IDPreInvMovExchange, AvgCost, ' +
             'DesiredMarkup, SequencyNum, IDDepartment, Promo, UnitDiscount) ' +
             'VALUES (:IDInventoryMov, :InventMovTypeID, :DocumentID, ' +
             ':IDPessoa, :StoreID, :ModelID, :BarCodeID, :MovDate, :Qty, :CostPrice, ' +
             ':SalePrice, :Discount, :PreInventoryMovID, :IDUser, :SalesTax, ' +
             ':IDParentPack, :QtyExchanged, :IDPreInvMovExchange, :AvgCost, ' +
             ':DesiredMarkup, :SequencyNum, :IDDepartment, :Promo, :unitdiscount) ';

      FInsertCommand.Parameters.ParamByName('IDInventoryMov').Value      := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
      FInsertCommand.Parameters.ParamByName('InventMovTypeID').Value     := TInventoryMov(FInvMovList[i]).FInventMovTypeID;
      FInsertCommand.Parameters.ParamByName('DocumentID').Value          := FIDInvoice;
      FInsertCommand.Parameters.ParamByName('IDPessoa').Value            := TInventoryMov(FInvMovList[i]).FIDPessoa;
      FInsertCommand.Parameters.ParamByName('StoreID').Value             := TInventoryMov(FInvMovList[i]).FStoreID;
      FInsertCommand.Parameters.ParamByName('ModelID').Value             := TInventoryMov(FInvMovList[i]).FModelID;
      FInsertCommand.Parameters.ParamByName('BarCodeID').Value           := FormatStrToVariant(TInventoryMov(FInvMovList[i]).FBarCodeID);
      FInsertCommand.Parameters.ParamByName('MovDate').Value             := TInventoryMov(FInvMovList[i]).FMovDate;
      FInsertCommand.Parameters.ParamByName('Qty').Value                 := TInventoryMov(FInvMovList[i]).FQty;
      FInsertCommand.Parameters.ParamByName('CostPrice').Value           := TInventoryMov(FInvMovList[i]).FCostPrice;
      FInsertCommand.Parameters.ParamByName('SalePrice').Value           := TInventoryMov(FInvMovList[i]).FSalePrice;
      FInsertCommand.Parameters.ParamByName('Discount').Value            := TInventoryMov(FInvMovList[i]).FDiscount;
      FInsertCommand.Parameters.ParamByName('PreInventoryMovID').Value   := TInventoryMov(FInvMovList[i]).FPreInventoryMovID;
      FInsertCommand.Parameters.ParamByName('IDUser').Value              := TInventoryMov(FInvMovList[i]).FIDUser;
      FInsertCommand.Parameters.ParamByName('SalesTax').Value            := TInventoryMov(FInvMovList[i]).FSalesTax;
      FInsertCommand.Parameters.ParamByName('IDParentPack').Value        := FormatIntToVariant(TInventoryMov(FInvMovList[i]).FIDParentPack);
      FInsertCommand.Parameters.ParamByName('QtyExchanged').Value        := FormatFloatToVariant(TInventoryMov(FInvMovList[i]).FQtyExchanged);
      FInsertCommand.Parameters.ParamByName('IDPreInvMovExchange').Value := FormatIntToVariant(TInventoryMov(FInvMovList[i]).FIDPreInvMovExchange);
      FInsertCommand.Parameters.ParamByName('AvgCost').Value             := TInventoryMov(FInvMovList[i]).FAvgCost;
      FInsertCommand.Parameters.ParamByName('DesiredMarkup').Value       := FormatCurToVariant(TInventoryMov(FInvMovList[i]).FDesiredMarkup);
      FInsertCommand.Parameters.ParamByName('SequencyNum').Value         := TInventoryMov(FInvMovList[i]).FSequencyNum;
      FInsertCommand.Parameters.ParamByName('IDDepartment').Value        := TInventoryMov(FInvMovList[i]).FIDDepartment;
      FInsertCommand.Parameters.ParamByName('Promo').Value               := TInventoryMov(FInvMovList[i]).FPromo;

      // Antonio M F Souza, December 10, 2012 - added unit discount field
      FInsertCommand.Parameters.ParamByName('UnitDiscount').Value        := TInventoryMov(FInvMovList[i]).FUnitDiscount;

      //Antonio M F Souza, April 17, 2013
      FInsertCommand.Parameters.ParamByName('Discount').Value := ( TInventoryMov(FInvMovList[i]).FUnitDiscount *
      																				TInventoryMov(FInvMovList[i]).FQty );

      FInsertCommand.Execute;
    except
      on E: Exception do
        raise Exception.Create('-107: ' + E.Message);
    end;

    //Atualiza SaleItemCommission
    try
      FInsertCommand.CommandText
        := 'UPDATE SaleItemCommission SET IDPreInventoryMov = NULL, ' +
           'IDInventoryMov = :IDInventoryMov ' +
           'WHERE IDPreInventoryMov = :IDPreInventoryMov ';
      FInsertCommand.Parameters.ParamByName('IDInventoryMov').Value    := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
      FInsertCommand.Parameters.ParamByName('IDPreInventoryMov').Value := TInventoryMov(FInvMovList[i]).FPreInventoryMovID;

      FInsertCommand.Execute;
    except
      on E: Exception do
        raise Exception.Create('-108: ' + E.Message);
    end;

    //Insert Encargos de Venda na tabela de Taxas InventoryMovTax
    try
      FInsertCommand.CommandText
        := 'INSERT INTO InventoryMovTax (IDInventoryMov, IDTaxCategory, Tax, TaxValue) ' +
           'SELECT IM.IDInventoryMov, ISNULL (TCC.IDTaxCategory,0) AS IDTaxCategory, ' +
           'ISNULL (TCC.Tax,0)/100 AS Tax, ' +
           'ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TCC.Tax,0)/100 AS TaxValue ' +
           'FROM InventoryMov IM (NOLOCK)' +
           'JOIN Model Mo (NOLOCK) ON (IM.ModelID = Mo.IDModel) ' +
           'JOIN StoreToTabGroup SG (NOLOCK) ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID ) ' +
           'JOIN TaxCategory TCP (NOLOCK) ON (TCP.IDTaxCategory = IsNull(:IDTaxCategory, SG.IDTaxCategory)) ' +
           'JOIN TaxCategory TCC (NOLOCK) ON (SG.IDTaxCategory = TCC.IDTaxCategoryParent) ' +
           'WHERE IM.IDInventoryMov = :IDInventoryMov ';

      FInsertCommand.Parameters.ParamByName('IDInventoryMov').Value := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
      FInsertCommand.Parameters.ParamByName('IDTaxCategory').Value  := TInventoryMov(FInvMovList[i]).FIDTaxCategory;
      FInsertCommand.Execute;
    except
      on E: Exception do
        raise Exception.Create('-109: ' + E.Message);
    end;

    //Insert Impostos de Venda na tabela de Taxas InventoryMovTax
    try
      FInsertCommand.CommandText
        := 'INSERT INTO InventoryMovTax (IDInventoryMov, IDTaxCategory, Tax, TaxValue) ' +
           'SELECT IM.IDInventoryMov, ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory, ' +
           'ISNULL (TC.Tax,0)/100 AS Tax, ' +
           'ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue ' +
           'FROM InventoryMov IM (NOLOCK) ' +
           'JOIN Model Mo (NOLOCK) ON (IM.ModelID = Mo.IDModel) ' +
           'JOIN StoreToTabGroup SG (NOLOCK) ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID ) ' +
           'JOIN TaxCategory TC (NOLOCK) ON (SG.IDSaleTax = TC.IDTaxCategory) ' +
           'WHERE IM.IDInventoryMov = :IDInventoryMov ' ;

      FInsertCommand.Parameters.ParamByName('IDInventoryMov').Value := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
      FInsertCommand.Execute;
    except
      on E: Exception do
        raise Exception.Create('-110: ' + E.Message);
    end;

    //Informações de price
    if FGeneratePrice then
    begin
      //Atualiza Inv_MovPrice
      try
        FInsertCommand.CommandText
          := 'UPDATE Inv_MovPrice SET IDPreInventoryMov = NULL, ' +
             'IDInventoryMov = :IDInventoryMov ' +
             'WHERE IDPreInventoryMov = :PreInventoryMovID ';

        FInsertCommand.Parameters.ParamByName('IDInventoryMov').Value    := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
        FInsertCommand.Parameters.ParamByName('PreInventoryMovID').Value := TInventoryMov(FInvMovList[i]).FPreInventoryMovID;

        FInsertCommand.Execute;
      except
        on E: Exception do
          raise Exception.Create('-111: ' + E.Message);
      end;

      cSuggPrice        := TInventoryMov(FInvMovList[i]).FSalePrice;
      iIDVendorPrice    := -1;
      iIDLancamentoTipo := -1;
      iIDDocumentoTipo  := -1;
      iIDPagamentoTipo  := -1;
      iDiasVencimento   := -1;
      iIDVendorType     := -1;
      iIDCentroCusto    := -1;
      iIDContaCorrente  := -1;
      iIDEmpresa        := -1;

      try
        try
          FFreeQuery.SQL.Clear;
          FFreeQuery.SQL.Add('SELECT IDVendor, SuggPrice');
          FFreeQuery.SQL.Add('FROM Inv_MovPrice (NOLOCK)');
          FFreeQuery.SQL.Add('WHERE IDInventoryMov = :IDInventoryMov');
          FFreeQuery.Parameters.ParamByName('IDInventoryMov').Value := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
          FFreeQuery.Open;
          if not FFreeQuery.IsEmpty then
          begin
            cSuggPrice     := FFreeQuery.FieldByName('SuggPrice').AsCurrency;
            iIDVendorPrice := FFreeQuery.FieldByName('IDVendor').AsInteger;
          end;
        finally
          FFreeQuery.Close;
          FFreeQuery.SQL.Clear;
        end;
      except
        on E: Exception do
          raise Exception.Create('-112: ' + E.Message);
      end;

      //Verifica o pricing
      if cSuggPrice < TInventoryMov(FInvMovList[i]).FSalePrice then
      begin
        iIDLancamentoTipo := GetIntProperty('PriceRecordType');
        iIDDocumentoTipo  := GetIntProperty('PriceDocumentType');
        iIDPagamentoTipo  := GetIntProperty('PricePaymentType');
        iDiasVencimento   := GetIntProperty('PriceDueDateDays');

        try
          try
            FFreeQuery.SQL.Clear;
            FFreeQuery.SQL.Add('SELECT IDTipoPessoaRoot');
            FFreeQuery.SQL.Add('FROM Pessoa (NOLOCK)');
            FFreeQuery.SQL.Add('WHERE IDPessoa = :IDVendorPrice');
            FFreeQuery.Parameters.ParamByName('IDVendorPrice').Value := iIDVendorPrice;
            FFreeQuery.Open;
            if not FFreeQuery.IsEmpty then
            begin
              iIDVendorType := FFreeQuery.FieldByName('IDTipoPessoaRoot').AsInteger;
            end;
          finally
            FFreeQuery.Close;
            FFreeQuery.SQL.Clear;
          end;
        except
          on E: Exception do
            raise Exception.Create('-113: ' + E.Message);
        end;

        try
          try
            FFreeQuery.SQL.Clear;
            FFreeQuery.SQL.Add('SELECT S.IDCentroCusto, MPS.IDContaCorrente, S.IDEmpresa');
            FFreeQuery.SQL.Add('FROM Store S');
            FFreeQuery.SQL.Add('JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)');
            FFreeQuery.SQL.Add('WHERE S.IDStore = :IDStore');
            FFreeQuery.SQL.Add('AND MPS.IDMeioPag = :IDPagamentoTipo');
            FFreeQuery.Parameters.ParamByName('IDStore').Value         := TInventoryMov(FInvMovList[i]).FStoreID;
            FFreeQuery.Parameters.ParamByName('IDPagamentoTipo').Value := iIDPagamentoTipo;
            FFreeQuery.Open;
            if not FFreeQuery.IsEmpty then
            begin
              iIDCentroCusto   := FFreeQuery.FieldByName('IDCentroCusto').AsInteger;
              iIDContaCorrente := FFreeQuery.FieldByName('IDContaCorrente').AsInteger;
              iIDEmpresa       := FFreeQuery.FieldByName('IDEmpresa').AsInteger;
            end;
          finally
            FFreeQuery.Close;
            FFreeQuery.SQL.Clear;
          end;
        except
          on E: Exception do
            raise Exception.Create('-114: ' + E.Message);
        end;

        //Insere a diferenca do price no financeiro
        iIDFinLancamento := GetNextCode('Fin_Lancamento.IDLancamento');
        try
          FInsertCommand.CommandText
            := 'INSERT INTO Fin_Lancamento (IDLancamento, IDPessoa, IDPessoaTipo, IDUsuarioLancamento, IDEmpresa, DataLancamento, DataVencimento, ' +
               'ValorNominal, Pagando, NumDocumento, IDCentroCusto, IDContaCorrentePrevista, IDQuitacaoMeioPrevisto, IDLancamentoTipo, ' +
               'IDDocumentoTipo, Situacao) ' +
               ' VALUES (:IDLancamento, :IDPessoa, :IDPessoaTipo, :IDUsuarioLancamento, :IDEmpresa, :DataLancamento, :DataVencimento, ' +
               ':ValorNominal, :Pagando, :NumDocumento, :IDCentroCusto, :IDContaCorrentePrevista, :IDQuitacaoMeioPrevisto, :IDLancamentoTipo, ' +
               ':IDDocumentoTipo, :Situacao) ';

          FInsertCommand.Parameters.ParamByName('IDLancamento').Value            := iIDFinLancamento;
          FInsertCommand.Parameters.ParamByName('IDPessoa').Value                := iIDVendorPrice;
          FInsertCommand.Parameters.ParamByName('IDPessoaTipo').Value            := iIDVendorType;
          FInsertCommand.Parameters.ParamByName('IDUsuarioLancamento').Value     := IDUser;
          FInsertCommand.Parameters.ParamByName('IDEmpresa').Value               := iIDEmpresa;
          FInsertCommand.Parameters.ParamByName('DataLancamento').Value          := PayDate;
          FInsertCommand.Parameters.ParamByName('DataVencimento').Value          := PayDate + iDiasVencimento;
          FInsertCommand.Parameters.ParamByName('ValorNominal').Value            := cSuggPrice - TInventoryMov(FInvMovList[i]).FSalePrice;
          FInsertCommand.Parameters.ParamByName('Pagando').Value                 := 0;
          FInsertCommand.Parameters.ParamByName('NumDocumento').Value            := FInvoiceCode;
          FInsertCommand.Parameters.ParamByName('IDCentroCusto').Value           := iIDCentroCusto;
          FInsertCommand.Parameters.ParamByName('IDContaCorrentePrevista').Value := iIDContaCorrente;
          FInsertCommand.Parameters.ParamByName('IDQuitacaoMeioPrevisto').Value  := iIDPagamentoTipo;
          FInsertCommand.Parameters.ParamByName('IDLancamentoTipo').Value        := iIDLancamentoTipo;
          FInsertCommand.Parameters.ParamByName('IDDocumentoTipo').Value         := iIDDocumentoTipo;
          FInsertCommand.Parameters.ParamByName('Situacao').Value                := 1;
          FInsertCommand.Execute;
        except
          on E: Exception do
            raise Exception.Create('-115: ' + E.Message);
        end;
      end;
    end; //End Generate price

    //Atualiza Inv_MovDocument
    try
      FInsertCommand.CommandText
        := 'UPDATE Inv_MovDocument ' +
           'SET IDPreInventoryMov = NULL, ' +
           'IDInventoryMov = :IDInventoryMov ' +
           'WHERE IDPreInventoryMov = :PreInventoryMovID ';

      FInsertCommand.Parameters.ParamByName('IDInventoryMov').Value    := TInventoryMov(FInvMovList[i]).FIDInventoryMov;
      FInsertCommand.Parameters.ParamByName('PreInventoryMovID').Value := TInventoryMov(FInvMovList[i]).FPreInventoryMovID;

      FInsertCommand.Execute;
    except
      on E: Exception do
        raise Exception.Create('-115: ' + E.Message);
    end;

  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.GetCurProperty(AProperty : String) : Currency;
begin

  FTraceControl.TraceIn('TSaleFinalize.GetCurProperty');

  Result := -1;

  try
    with FFreeQuery do
      try
        SQL.Clear;
        SQL.Add('SELECT CAST(PropertyValue AS money) PValue');
        SQL.Add('FROM Sis_PropertyDomain (NOLOCK)');
        SQL.Add('WHERE Property = :Property');
        Parameters.ParamByName('Property').Value := AProperty;
        Open;
        if not IsEmpty then
          Result := FieldByName('PValue').AsCurrency;
      finally
        Close;
        SQL.Clear;
      end;
  except
    on E: Exception do
      raise Exception.Create('PropertyDomain: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.GetIntProperty(AProperty: String): Integer;
begin

  FTraceControl.TraceIn('TSaleFinalize.GetIntProperty');

  Result := -1;

  try
    with FFreeQuery do
      try
        SQL.Clear;
        SQL.Add('SELECT CAST(PropertyValue AS INT) PValue');
        SQL.Add('FROM Sis_PropertyDomain (NOLOCK)');
        SQL.Add('WHERE Property = :Property');
        Parameters.ParamByName('Property').Value := AProperty;
        Open;
        if not IsEmpty then
          Result := FieldByName('PValue').AsInteger;
      finally
        Close;
        SQL.Clear;
      end;
  except
    on E: Exception do
      raise Exception.Create('PropertyDomain: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.SendItemRepair: Boolean;
var
  iIDRepair : Integer;
begin

  FTraceControl.TraceIn('TSaleFinalize.SendItemRepair');

  Result := False;

  with FSearchQuery do
    try
      try
        SQL.Clear;
        SQL.Add('SELECT IR.Obs, IR.IDDefectType, IR.RA, IR.IDVendor, PIM.ModelID,');
        SQL.Add('PIM.StoreID, PIM.MovDate, PIM.CostPrice, ABS(PIM.Qty) as Qty, PIM.UserID');
        SQL.Add('FROM Sal_ItemRepair IR (NOLOCK) ');
        SQL.Add('JOIN PreInventoryMov PIM (NOLOCK) ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)');
        SQL.Add('WHERE PIM.DocumentID = :IDPreSale');
        SQL.Add('AND PIM.InventMovTypeID = 1');
        Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
        Open;
      except
        on E: Exception do
          raise Exception.Create('-116: ' + E.Message);
      end;

      First;
      while not EOF do
      begin
        try
          FInsertCommand.CommandText
            := 'INSERT Repair (IDRepair, IDModel, IDStore, Fase, IDFornecedor, ' +
               'RA, SentDate, IDUserSent, LastCost, Tipo, Qty, IDDefectType, ' +
               'TipoRepair, Desativado, Defect) ' +
               'VALUES (:IDRepair, :ModelID, :StoreID, :Fase, ' +
               ':IDVendor, :RA, :MovDate, :IDUser, :CostPrice, 2, :Qty, ' +
               ':IDDefectType, 0, 0, :Obs) ' ;

          iIDRepair                                                   := GetNextCode('Repair.IDRepair');
          FInsertCommand.Parameters.ParamByName('IDRepair').Value     := iIDRepair;
          FInsertCommand.Parameters.ParamByName('ModelID').Value      := FieldByName('ModelID').AsInteger;
          FInsertCommand.Parameters.ParamByName('StoreID').Value      := FieldByName('StoreID').AsInteger;
          FInsertCommand.Parameters.ParamByName('Fase').Value         := 'Send to Vendor';
          FInsertCommand.Parameters.ParamByName('IDVendor').Value     := FieldByName('IDVendor').AsInteger;
          FInsertCommand.Parameters.ParamByName('RA').Value           := FieldByName('RA').AsString;
          FInsertCommand.Parameters.ParamByName('MovDate').Value      := FieldByName('MovDate').AsDateTime;
          FInsertCommand.Parameters.ParamByName('IDUser').Value       := FieldByName('UserID').AsInteger;
          FInsertCommand.Parameters.ParamByName('CostPrice').Value    := FieldByName('CostPrice').AsCurrency;
          FInsertCommand.Parameters.ParamByName('Qty').Value          := FieldByName('Qty').AsFloat;
          FInsertCommand.Parameters.ParamByName('IDDefectType').Value := FieldByName('IDDefectType').AsInteger;
          FInsertCommand.Parameters.ParamByName('Obs').Value          := FieldByName('Obs').AsString;

          FInsertCommand.Execute;

          with FStoredProc do
          begin
            ProcedureName := 'sp_Repair_Do;1';
            Parameters.Refresh;
            Parameters.ParamByName('@IDRepair').Value := iIDRepair;
            ExecProc;
          end;

        except
          on E: Exception do
            raise Exception.Create('-117: ' + E.Message);
        end;
        Next;
      end;

    finally
      Close;
      SQL.Clear;
    end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.InsertAccountCard: Boolean;
var
  iExpDateMonth : Integer;
  iIDAccountCard : Integer;
  cCardAmount : Currency;
begin
  FTraceControl.TraceIn('TSaleFinalize.InsertAccountCard');

  Result := False;

  with FSearchQuery do
  try
    try
      SQL.Clear;
//amfsouza 03.30.2011:  SQL.Add('SELECT PSM.SerialNumber, ((PIM.SalePrice * PIM.Qty)- PIM.Discount) as SalePrice, PIM.UserID');
      SQL.Add('SELECT PSM.SerialNumber, (((PIM.SalePrice * PIM.Qty)- PIM.Discount) / PIM.Qty) as SalePrice, PIM.UserID, psm.IsIssued ');
      SQL.Add('FROM PreSerialMov PSM (NOLOCK)');
      SQL.Add('JOIN PreInventoryMov PIM (NOLOCK) ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)');
      SQL.Add('JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)');
      SQL.Add('WHERE PIM.DocumentID = :IDPreSale');
      SQL.Add('AND PIM.InventMovTypeID = 1');
      SQL.Add('AND M.ModelType = :ModelType');
      Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
      Parameters.ParamByName('ModelType').Value := 'G';
      Open;
    except
      on E: Exception do
        raise Exception.Create('-118: ' + E.Message);
    end;

    First;
    if not IsEmpty then
    try
      try
        FFreeQuery.SQL.Clear;
        FFreeQuery.SQL.Add('SELECT Convert(int, SrvValue) as SrvValue FROM Param Where IDParam = 86');
        FFreeQuery.Open;
        iExpDateMonth := FFreeQuery.FieldByName('SrvValue').AsInteger;
      finally
        FFreeQuery.Close;
        FFreeQuery.SQL.Clear;
      end;
    except
      on E: Exception do
        raise Exception.Create('-119: ' + E.Message);
    end;

    while not EOF do
    begin

      // Antonio, August 22, 2013
      if ( not fieldByName('IsIssued').IsNull ) then begin
         next;
         continue;
      end;

      try
        try
          FFreeQuery.SQL.Clear;
          FFreeQuery.SQL.Add('SELECT	A.IDAccountCard, A.Amount');
          FFreeQuery.SQL.Add('FROM Sal_AccountCard A (NOLOCK)');
          FFreeQuery.SQL.Add('WHERE A.CardNumber = :CardNumber');
          FFreeQuery.Parameters.ParamByName('CardNumber').Value := FieldByName('SerialNumber').AsString;
          FFreeQuery.Open;
          iIDAccountCard := FFreeQuery.FieldByName('IDAccountCard').AsInteger;
          cCardAmount    := FFreeQuery.FieldByName('Amount').AsCurrency;
        finally
          FFreeQuery.Close;
          FFreeQuery.SQL.Clear;
        end;
      except
        on E: Exception do
          raise Exception.Create('-120: ' + E.Message);
      end;

      try
        FInsertCommand.CommandText
          := 'INSERT Sal_AccountCardMov (IDAccountCardMov, DateMov, Value,' +
             'Credit, IDPreSale, IDUser, IDAccountCard) ' +
             'VALUES (:IDAccountCardMov, :DateMov, :Value, ' +
             ':Credit, :IDPreSale, :IDUser, :IDAccountCard) ' ;

        FInsertCommand.Parameters.ParamByName('IDAccountCardMov').Value := GetNextCode('Sal_AccountCardMov.IDAccountCardMov');
        FInsertCommand.Parameters.ParamByName('DateMov').Value          := Now;
        FInsertCommand.Parameters.ParamByName('Value').Value            := FieldByName('SalePrice').AsCurrency;
        FInsertCommand.Parameters.ParamByName('Credit').Value           := 1;
        FInsertCommand.Parameters.ParamByName('IDPreSale').Value        := FIDPreSale;
        FInsertCommand.Parameters.ParamByName('IDUser').Value           := FIDUser;
        FInsertCommand.Parameters.ParamByName('IDAccountCard').Value    := iIDAccountCard;

        FInsertCommand.Execute;
      except
        on E: Exception do
          raise Exception.Create('-121 SaleFinalize.Insert Sal_AccountCardMov: ' + E.Message);
      end;


      try
        FInsertCommand.CommandText
          := 'UPDATE Sal_AccountCard ' +
             'SET Amount = :Amount ' +
             'WHERE IDAccountCard = :IDAccountCard ' ;

        FInsertCommand.Parameters.ParamByName('IDAccountCard').Value  := iIDAccountCard;
        FInsertCommand.Parameters.ParamByName('Amount').Value         := cCardAmount + FieldByName('SalePrice').AsCurrency;

        FInsertCommand.Execute;
      except
        on E: Exception do
          raise Exception.Create('-122 SaleFinale.Update Sal_AccountCard : ' + E.Message);
      end;

      Next;
    end;

  finally
    Close;
    SQL.Clear;
  end;

  Result := True;

  FTraceControl.TraceOut;
end;

function TSaleFinalize.InsertSerialMov: Boolean;
var
   cdsSerialNumbers: TClientdataset;
begin
  try

    FTraceControl.TraceIn('TSaleFinalize.InsertSerialMov');

    Result := False;

    try
          // Antonio, August 07, 2013
          prepareNotIssuedMercuryGift();

          FInsertCommand.CommandText
            := 'INSERT SerialMov (InventoryMovID, SerialNumber, IdentificationNumber) ' +
               'SELECT IM.IDInventoryMov, PSM.SerialNumber, PSM.IdentificationNumber ' +
               'FROM PreSerialMov PSM (NOLOCK) ' +
               'JOIN InventoryMov IM (NOLOCK) ON (PSM.PreInventoryMovID = IM.PreInventoryMovID) ' +
               'WHERE IM.DocumentID = :IDInvoice AND IM.InventMovTypeID = 1 ' ;

          FInsertCommand.Parameters.ParamByName('IDInvoice').Value  := FIDInvoice;

          FInsertCommand.Execute;
      Result := True;

    except
      on E: Exception do
        raise Exception.Create('-123: SaleFinalized.InsertSerialMov failed ' + E.Message);
    end;

  finally
  //    freeAndNil(cdsSerialNumbers);
  end;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.DelInsInventorySerial: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.DelInsInventorySerial');

  Result := False;

  try
    FInsertCommand.CommandText
      := 'DELETE InventorySerial ' +
         'FROM PreInventoryMov PIM (NOLOCK), PreSerialMov PSV (NOLOCK) ' +
         'WHERE PIM.DocumentID = :IDPreSale ' +
         'AND PIM.InventMovTypeID = 1 ' +
         'AND InventorySerial.ModelID = PIM.ModelID ' +
         'AND InventorySerial.StoreID = :IDStore ' +
         'AND InventorySerial.Serial = PSV.SerialNumber ' +
         'AND PIM.Qty > 0 ' ;

    FInsertCommand.Parameters.ParamByName('IDPreSale').Value  := FIDPreSale;
    FInsertCommand.Parameters.ParamByName('IDStore').Value    := FIDStore;

    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-124 TSaleFinalize.DelInsInventorySerial : ' + E.Message);
  end;


  try
    FInsertCommand.CommandText
      := 'INSERT InventorySerial (StoreID, ModelID, Serial) ' +
         'SELECT :IDStore, PIM.ModelID, PSV.SerialNumber ' +
         'FROM PreInventoryMov PIM (NOLOCK) ' +
         'JOIN PreSerialMov PSV (NOLOCK) ON (PIM. IDPreInventoryMov = PSV.PreInventoryMovID) ' +
         'WHERE PIM.DocumentID = :IDPreSale ' +
         'AND PIM.InventMovTypeID = 1 ';

         { Antonio 2013 Dec 27, MR-156
         'AND PIM.InventMovTypeID = 1 ' +
         'AND PIM.Qty < 0 ';
          }
          
    FInsertCommand.Parameters.ParamByName('IDPreSale').Value  := FIDPreSale;
    FInsertCommand.Parameters.ParamByName('IDStore').Value    := FIDStore;

    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-125: ' + E.Message);
  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.DelPreSerialMov: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.DelPreSerialMov');

  Result := False;

  try
    FInsertCommand.CommandText
      := 'DELETE PreSerialMov ' +
         'FROM PreInventoryMov PIM (NOLOCK) ' +
         'WHERE PIM.DocumentID = :IDPreSale ' +
         'AND PIM.InventMovTypeID = 1 ' ;

    FInsertCommand.Parameters.ParamByName('IDPreSale').Value  := FIDPreSale;

    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-126 SaleFinalize.DelPreserialMov : ' + E.Message);
  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.UpdateInvModelsPack: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.UpdateInvModelsPack');

  Result := False;

  try
    FInsertCommand.CommandText
      := 'UPDATE IMC ' +
         'SET IMC.IDParentPack = IMP.IDInventoryMov ' +
         'FROM InventoryMov IMC (NOLOCK) ' +
         'JOIN InventoryMov IMP (NOLOCK) ON (IMP.PreInventoryMovID = IMC.IDParentPack) ' +
         'WHERE IMC.DocumentID = :IDInvoice ' +
         'AND IMC.InventMovTypeID = 1 ' ;

    FInsertCommand.Parameters.ParamByName('IDInvoice').Value  := FIDInvoice;

    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-127: ' + E.Message);
  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.UpdatePreInvMovParent: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.UpdatePreInvMovParent');

  Result := False;

  try
    FInsertCommand.CommandText
      := 'UPDATE PreInventoryMov ' +
         'SET IDPreInventoryMovParent = NULL ' +
         'WHERE DocumentID = :IDPreSale ' +
         'AND InventMovTypeID = 1 ' +
         'AND IDPreInventoryMovParent IS NOT NULL ' ;

    FInsertCommand.Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-128: ' + E.Message);
  end;


  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.DeletePreInventory: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.DeletePreInventory');

  Result := False;

  try
    FInsertCommand.CommandText
      := 'DELETE PreInventoryMov ' +
         'WHERE PreInventoryMov.DocumentID = :IDPreSale ' +
         'AND PreInventoryMov.InventMovTypeID = 1 ';

    FInsertCommand.Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-130: ' + E.Message);
  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.UpdatePaymentStatus: Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.UpdatePaymentStatus');

  Result := False;

  try
    FInsertCommand.CommandText
      := 'UPDATE Fin_Lancamento ' +
         'SET NumDocumento = :IDInvoice, ' +
         'DataEmissao = :PayDate, Previsao = 0 ' +
         'WHERE IDPreSale = :IDPreSale ';

    FInsertCommand.Parameters.ParamByName('IDInvoice').Value := FInvoiceCode;
    FInsertCommand.Parameters.ParamByName('PayDate').Value   := FPayDate;
    FInsertCommand.Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    FInsertCommand.Execute;
  except
    on E: Exception do
      raise Exception.Create('-131: ' + E.Message);
  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.InsertBonusBucks: Boolean;
var
  cBonusMinSaleValue : Currency;
  iDaysToUseBonusBucks : Integer;
  iExpireDaysBonusBucks : Integer;
begin

  FTraceControl.TraceIn('TSaleFinalize.InsertBonusBucks');

  Result := False;

//amfsouza 11.05.2010 - BonusCode information from Gymbo Webserver is not in use
(*  if (BonusSync.BonusCode <> '') then
  begin *)
    //amfsouza 11.05.2010 - force this again due changes ( No more Gymbo WebServer
    if ( FInvoiceTotal >= GetCurProperty('BonusBuckMinSaleValue') ) then begin
      try
        FInsertCommand.CommandText
          := 'INSERT INTO Sal_RebateDiscount (IDPreSaleCreated, DiscountValue, ValidFromDate, ExpirationDate, IDPreSaleUsed, BonusCode) ' +
             'VALUES (:IDPreSaleCreated, :DiscountValue, :ValidFromDate, :ExpirationDate, :IDPreSaleUsed, :BonusCode) ';

        FInsertCommand.Parameters.ParamByName('IDPreSaleCreated').Value := FIDPreSale;
        FInsertCommand.Parameters.ParamByName('DiscountValue').Value    := FBonusBucks;
        FInsertCommand.Parameters.ParamByName('ValidFromDate').Value    := BonusSync.ValidFrom;
        FInsertCommand.Parameters.ParamByName('ExpirationDate').Value   := BonusSync.ExpirationDate;
        FInsertCommand.Parameters.ParamByName('IDPreSaleUsed').Value    := NULL;

       //amfsouza 12.01.2010 bonuscode must be NULL        FInsertCommand.Parameters.ParamByName('BonusCode').Value        := BonusSync.BonusCode;
        FInsertCommand.Parameters.ParamByName('BonusCode').Value        := NULL;

        FInsertCommand.Execute;
      except
        on E: Exception do
          raise Exception.Create('-132: ' + E.Message);
      end;

    end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.FormatIntToVariant(AValue: Integer): Variant;
begin
  if AValue = 0 then
    Result := Null
  else
    Result := AValue;
end;

function TSaleFinalize.FormatCurToVariant(AValue: Currency): Variant;
begin
  if AValue = 0 then
    Result := Null
  else
    Result := AValue;
end;

function TSaleFinalize.FormatFloatToVariant(AValue: Double): Variant;
begin
  if AValue = 0 then
    Result := Null
  else
    Result := AValue;
end;

function TSaleFinalize.FormatStrToVariant(AValue: String): Variant;
begin
  if Trim(AValue) = '' then
    Result := Null
  else
    Result := AValue;
end;

function TSaleFinalize.LoadInvMovData: Boolean;
var
  InventoryMov: TInventoryMov;
  iServiceNum: Variant;
begin

  FTraceControl.TraceIn('TSaleFinalize.LoadInvMovData');

  Result := False;

  try
    with FSearchQuery do
    begin
      SQL.Clear;
      SQL.Add('SELECT	PIM.InventMovTypeID, PIM.IDPessoa, PIM.StoreID, PIM.ModelID,');
      SQL.Add('PIM.BarCodeID, PIM.Qty, PIM.CostPrice, PIM.SalePrice, PIM.Discount, PIM.UnitDiscount,');
      SQL.Add('PIM.IDPreInventoryMov, PIM.UserID, PIM.IDParentPack, PIM.QtyExchanged,');
      SQL.Add('PIM.IDPreInvMovExchange, M.AvgCost, TG.DesiredMarkup, TG.ServiceAutoNumber,');
      SQL.Add('TG.Service, TG.IDGroup, PIM.IDDepartment, PIM.Promo, PIM.IDTaxCategory,');
      SQL.Add('IsNull((CASE WHEN (TC.SpecialDateStart <= :Date1) AND (TC.SpecialDateEnd >= :Date2) AND');
      SQL.Add('( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0)');
      SQL.Add('< ISNULL(TC.MaxItemValue, 0)) THEN TC.SpecialTax ELSE TC.Tax END / 100.00),0)  as Tax');

      SQL.Add('FROM dbo.PreInventoryMov PIM (NOLOCK)');
      SQL.Add('JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )');
      SQL.Add('JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )');
      SQL.Add('JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )');
      SQL.Add('LEFT JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory AND ');
      SQL.Add('TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, STC.IDTaxCategory))');

      SQL.Add('WHERE PIM.DocumentID = :IDPreSale');
      SQL.Add('AND PIM.InventMovTypeID = 1');

      Parameters.ParamByName('Date1').Value     := Trunc(SaleDate);
      Parameters.ParamByName('Date2').Value     := Trunc(SaleDate);
      Parameters.ParamByName('IDPreSale').Value := IDPreSale;
      Open;

      First;
      while not eof do
      begin
        //Incremento o sequencial do servico
        if FieldByName('Service').AsBoolean then
          iServiceNum := GetNextCode('TabGroup.Service' + FieldByName('IDGroup').AsString)
        else
          iServiceNum := Null;

        InventoryMov                      := TInventoryMov.Create;
        InventoryMov.FIDInventoryMov      := GetNextCode('InventoryMov.IDInventoryMov');;
        InventoryMov.FInventMovTypeID     := FieldByName('InventMovTypeID').AsInteger;
        InventoryMov.FIDPessoa            := FieldByName('IDPessoa').AsInteger;
        InventoryMov.FStoreID             := FieldByName('StoreID').AsInteger;
        InventoryMov.FModelID             := FieldByName('ModelID').AsInteger;
        InventoryMov.FBarCodeID           := FieldByName('BarCodeID').AsString;
        InventoryMov.FMovDate             := PayDate;
        InventoryMov.FQty                 := FieldByName('Qty').AsFloat;
        InventoryMov.FCostPrice           := FieldByName('CostPrice').AsCurrency;
        InventoryMov.FSalePrice           := FieldByName('SalePrice').AsCurrency;
        InventoryMov.FDiscount            := FieldByName('Discount').AsCurrency;
        InventoryMov.FPreInventoryMovID   := FieldByName('IDPreInventoryMov').AsInteger;
        InventoryMov.FIDUser              := FieldByName('UserID').AsInteger;
        InventoryMov.FIDTaxCategory       := FieldByName('IDTaxCategory').AsInteger;
        InventoryMov.FSalesTax            := FieldByName('Tax').AsCurrency;
        InventoryMov.FIDParentPack        := FieldByName('IDParentPack').AsInteger;
        InventoryMov.FQtyExchanged        := FieldByName('QtyExchanged').AsFloat;
        InventoryMov.FIDPreInvMovExchange := FieldByName('IDPreInvMovExchange').AsInteger;
        InventoryMov.FAvgCost             := FieldByName('AvgCost').AsCurrency;
        InventoryMov.FDesiredMarkup       := FieldByName('DesiredMarkup').AsCurrency;
        InventoryMov.FSequencyNum         := iServiceNum;
        InventoryMov.FIDDepartment        := FieldByName('IDDepartment').AsInteger;
        InventoryMov.FPromo               := FieldByName('Promo').AsBoolean;

        // Antonio M F Souza, December 10, 2012
        InventoryMov.FUnitDiscount        := FieldByName('UnitDiscount').AsCurrency;
        FInvMovList.Add(InventoryMov);

        Next;
      end;
    end;

  except
    on E: Exception do
      raise Exception.Create('-104: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

procedure TSaleFinalize.FreeInvMovList;
var
  FInvMov : TInventoryMov;
begin
  while FInvMovList.Count > 0 do
  begin
    FInvMov := TInventoryMov(FInvMovList.Items[0]);
    if FInvMov <> nil then
      FreeAndNil(FInvMov);
    FInvMovList.Delete(0);
  end;
end;

function TSaleFinalize.ProcessBonus: Boolean;
var
  cBonusMinSaleValue : Currency;
  iDaysToUseBonusBucks : Integer;
  iExpireDaysBonusBucks : Integer;
  bError : Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.LoadBonusValue');

  Result := False;

  BonusSync.BonusCode := '';

  if FBonusBucks > 0 then
  begin
    cBonusMinSaleValue := GetCurProperty('BonusBuckMinSaleValue');
    if FInvoiceTotal >= cBonusMinSaleValue then
    begin
      iDaysToUseBonusBucks  := GetIntProperty('DaysToUseBonusBucks');
      iExpireDaysBonusBucks := GetIntProperty('ExpireDaysBonusBucks');

      BonusSync.BonusValue      := FBonusBucks;
      BonusSync.ValidFrom       := Trunc(FPayDate + iDaysToUseBonusBucks);
      BonusSync.ExpirationDate  := (FPayDate + iDaysToUseBonusBucks + iExpireDaysBonusBucks);
      BonusSync.InvoiceNumber   := FInvoiceCode;
      BonusSync.InvoiceDate     := FPayDate;

      //amfsouza 11.05.2010 - disable because Gymbo WebServer is not in use.
(*      bError := True;
      try
        if BonusSync.Generate then
          bError := (BonusSync.IDResult <> 0);
      except
      end;

      if bError then
        if (MsgBox(MSG_QST_PROCESS_BONUS + BonusSync.ResultMessage, vbYesNo + vbQuestion) = vbNo) then
          Exit;
*)
    end;

  end;

  Result := True;

  FTraceControl.TraceOut;

end;


function TSaleFinalize.VoidBonus: Boolean;
var
  bError : Boolean;
begin

  FTraceControl.TraceIn('TSaleFinalize.VoidBonus');

  Result := False;

  if (BonusSync.BonusCode <> '') then
  begin
      try
        bError := True;
        if BonusSync.Void then
          bError := (BonusSync.IDResult <> 0);
      except
      end;

      if bError then
        MsgBox(MSG_CRT_ERROR_VOIDING_BONUS + BonusSync.ResultMessage, vbOK + vbInformation);
  end;

  Result := True;

  FTraceControl.TraceOut;

end;

function TSaleFinalize.getMercuryGiftCards(
  card_list: TClientDataSet): Boolean;
var
   objMercuryTransaction: TCPrePaid;
begin
  try
     objMercuryTransaction := TCPrePaid.Create();

     while ( not card_list.Eof ) do begin

           objMercuryTransaction.Purchase := card_list.fieldByname('Balance').Value;
           objMercuryTransaction.AcctNo   := card_list.FieldByName('SerialNumber').Value;

           // to each account number call Issue / Reload from Mercury Gift.
           if ( card_list.FieldByName('Issued').Value = 1 ) then begin
              objMercuryTransaction.prePaidReload;
           end
           else begin
              objMercuryTransaction.prePaidIssue;
           end;

           card_list.Next();
     end;

  finally
     freeAndNil(objMercuryTransaction);
  end;

end;

function TSaleFinalize.getSerialMovQuantityRecorded(arg_invoice: Integer): integer;
var
   cds: TClientDataset;
begin
   try
     cds := dm.searchPreserialMovInInventoryMov(arg_invoice);
     if ( not cds.IsEmpty ) then begin
        if ( cds.FieldByName('qty').Value > 0 ) then
            result := cds.fieldByName('qty').Value;
     end;
    finally
     freeAndNil(cds);
    end;
end;

procedure TSaleFinalize.prepareNotIssuedMercuryGift();
var
  mercuryGiftCardsPending: TClientDataset;
  mercuryGiftCard: TCPrepaid;
begin
  try
      try
         mercuryGiftCardsPending := dm.searchPreserialMovInInventoryMov(FIDInvoice);
         mercuryGiftCardsPending.filter := 'IsIssued = 0 ';
         mercuryGiftCardsPending.filtered := true;
         mercuryGiftCard := TCPrePaid.Create();

         // Antonio 09/14/2015 - to instantiate according to processor and device ( referenced object: fCreditX )
         mercuryGiftCard.setPrepaidDevice(dm.fMRMercury.Processor, dm.fMRMercury.DeviceProcess);


         // read giftcards not issued come from cash register without swiped
         VerifyMercuryTransaction(mercuryGiftCardsPending, mercuryGiftCard);

         mercuryGiftCardsPending.filtered := false;
         mercuryGiftCardsPending.filter := 'IsIssued = 1 ';
         mercuryGiftCardsPending.filtered := true;

          // read giftcards already issued
         VerifyMercuryTransaction(mercuryGiftCardsPending, mercuryGiftCard, 1);

      except on E: exception do
          raise Exception.Create('Mercury Error: ' + mercuryGiftCard.Msg + ' : ' + e.Message);
      end;
  finally
     freeAndNil(mercuryGiftCard);
     freeAndNil(mercuryGiftCardsPending);
  end;

end;

procedure TSaleFinalize.VerifyMercuryTransaction(arg_pendingList: TClientDataset; arg_mercuryGiftCard: TCPrepaid;
arg_issued: Integer);
begin
   try
      arg_pendingList.First;
      while ( not arg_pendingList.Eof ) do begin

          arg_mercuryGiftCard.AcctNo := arg_pendingList.fieldByName('SerialNumber').Value;
          arg_mercuryGiftCard.Purchase := arg_pendingList.fieldByName('SalePrice').Value; // balance
          arg_mercuryGiftCard.RefNo := intToStr(FIDInvoice);
          arg_mercuryGiftCard.InvoiceNo := intToStr(FIDInvoice);
          arg_mercuryGiftCard.Memo :=  'MainRetail ' + dm.fSystem.VerBuild;
          arg_mercuryGiftCard.OperatorID := intToStr(dm.fUser.id);

          if ( arg_issued = 0) then
             arg_mercuryGiftCard.prePaidIssue
          else
             arg_mercuryGiftCard.prePaidReload;

          // Antonio 2013 Dec

          if ( arg_mercuryGiftCard.FCreditX.TransactionReturn in [ttrError, ttrNotSuccessfull] ) then begin
             raise Exception.Create('Transaction card decline.');
          end;

          arg_pendingList.next;
     end;

   except
      raise;
   end;
end;

end.
