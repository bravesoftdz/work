(*
-----------------------------------------------------------------------------------------------------
Version : (296 - 305)
Date    : 09.01.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : Combine lines is not working if sale has different prices
Solution: remove price of the condition
Version : (296 - 306)
------------------------------------------------------------------------------------------------------

Version : (291 - 292)
Date    : 05.11.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : Combine lines is not working if sale has discount
Solution: I had to get another discounts to documentID
Version : (291 - 293)
------------------------------------------------------------------------------------------------------

Version : (288 - 279)
Date    : 02.04.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : Change qty in cash register ( sale is disappearing )
Solution: I did some changes ( identify when Insert or Update a sale ) in previous routine.
Version : (288 - 280)
------------------------------------------------------------------------------------------------------

Version : (288 - 278)
Date    : 10.22.2010
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : To negative quantities combine lines is not working.
Solution: I implemented a new routine ( function ) to verify previous quantity presales with same condition.
Version : (287 - 277)
------------------------------------------------------------------------------------------------------
Version : (287 - 272)
Date    : 10.20.2010
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : Cash Register Combine Line Items
Solution: I implemented a new routine ( function ) to verify previous quantity presales with same condition.
Version : (287 - 273)
-----------------------------------------------------------------------------------------------------
*)
unit uFrmPOSFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls, PowerADOQuery, DBClient, Provider,
  HTTPApp;

type

  TPayment = class
    fCustomer      : ShortString;
    fPhone         : ShortString;
    fDocument      : ShortString;
    fBank          : ShortString;
    fDocNumber     : ShortString;
    fOBS           : ShortString;
    fAuthorization : ShortString;
    fExpireDate    : TDateTime;
    fCreationDate  : TDateTime;
    fAmount        : Double;
    property Customer      : ShortString read fCustomer      write fCustomer;
    property Phone         : ShortString read fPhone         write fPhone;
    property Document      : ShortString read fDocument      write fDocument;
    property Bank          : ShortString read fBank          write fBank;
    property DocNumber     : ShortString read fDocNumber     write fDocNumber;
    property OBS           : ShortString read fOBS           write fOBS;
    property Authorization : ShortString read fAuthorization write fAuthorization;
    property ExpireDate    : TDateTime   read fExpireDate    write fExpireDate;
    property CreationDate  : TDateTime   read fCreationDate  write fCreationDate;
    property Amount        : Double      read fAmount        write fAmount;
  end;

  TExtPayment = class(TPayment)
    fIDPreSale     : Integer;
    fIDPaymentType : Integer;
    fTypeOfPayment : Integer;
    fIDCashRegMov  : Integer;
    fIDLancamento  : Integer;
    property IDPreSale     : Integer read fIDPreSale     write fIDPreSale;
    property IDPaymentType : Integer read fIDPaymentType write fIDPaymentType;
    property TypeOfPayment : Integer read fTypeOfPayment write fTypeOfPayment;
    property IDCashRegMov  : Integer read fIDCashRegMov  write fIDCashRegMov;
    property IDLancamento  : Integer read fIDLancamento  write fIDLancamento;
  end;

  TSalesPerson = class
    IDPessoa: Integer;
    Pessoa:   String;
    Percent:  Real;
  end;

  TFrmPOSFunctions = class(TForm)
    spCashRegOpen: TADOStoredProc;
    spCashRegClose: TADOStoredProc;
    quCashRegResidual: TADOQuery;
    quCashRegResidualIDCashRegMov: TIntegerField;
    quCashRegResidualIDOpenUser: TIntegerField;
    quCashRegResidualResidual: TFloatField;
    quCashRegInfo: TADOQuery;
    quCashRegInfoIDCashRegMov: TIntegerField;
    quCashRegInfoSystemUser: TStringField;
    quCashRegInfoCashRegister: TStringField;
    quCashRegInfoOpenTime: TDateTimeField;
    quCashRegInfoIDCashRegStatus: TIntegerField;
    quTestRefresh: TADOQuery;
    quTestRefreshInvoiceCount: TIntegerField;
    Label1: TLabel;
    spCashRegCalcCash: TADOStoredProc;
    spCashRegPetty: TADOStoredProc;
    spCashRegCalcCashWidraw: TADOStoredProc;
    spCashRegWidraw: TADOStoredProc;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    spDeletePreSale: TADOStoredProc;
    spquQuantity: TADOStoredProc;
    spquQuantityName: TStringField;
    spquQuantityStoreID: TIntegerField;
    spquQuantityCurrentCost: TFloatField;
    spquKitPrice: TADOStoredProc;
    spquKitPriceSellingPrice: TFloatField;
    spAddPreSaleItem: TADOStoredProc;
    spDeletePreSaleItem: TADOStoredProc;
    spUpdatePreSaleItem: TADOStoredProc;
    spAddParcela: TADOStoredProc;
    spPreSalePay: TADOStoredProc;
    spRecalcTax: TADOStoredProc;
    cmdExemptTax: TADOCommand;
    spAddSpecialPrice: TADOStoredProc;
    spDeleteSpecialPrice: TADOStoredProc;
    spManageDiscount: TADOStoredProc;
    spMaxDiscount: TADOStoredProc;
    spSetTaxIsention: TADOStoredProc;
    spCalcFullTotal: TADOStoredProc;
    spAddInvAdtionalCost: TADOStoredProc;
    spDeleteInvAdtionalCost: TADOStoredProc;
    quPaymentValue: TADOQuery;
    Shape3: TShape;
    Label3: TLabel;
    spPreSaleCancelHold: TADOStoredProc;
    spCashRegSubClose: TADOStoredProc;
    sp_CashRegister_QuitaLancamento: TADOStoredProc;
    spDivideHold: TADOStoredProc;
    spCreateHold: TADOStoredProc;
    quPaymentValueTotal: TBCDField;
    spAddCustomerCredit: TADOStoredProc;
    spquQuantityFloatPercent: TIntegerField;
    quQtyInventoryPreSale: TADOQuery;
    quVerifyDeliveryModel: TADOQuery;
    quDeliverOpenHolds: TADODataSet;
    quDeliverOpenHoldsSaleCode: TStringField;
    quHasPendingPayment: TADODataSet;
    quHasPendingPaymentIDLancamento: TIntegerField;
    spNewSaleCode: TADOStoredProc;
    quSalesPerson: TPowerADOQuery;
    quSalesPersonPessoa: TStringField;
    quSalesPersonIDPessoa: TIntegerField;
    quSalesPersonCommissionPercent: TBCDField;
    spquQuantityQtyOnPreSale: TFloatField;
    spquQuantityQtyOnHand: TFloatField;
    spquQuantityQtyOnOrder: TFloatField;
    spquQuantityQtyOnRepair: TFloatField;
    spquQuantityQtyOnPrePurchase: TFloatField;
    quVerifyDeliveryModelQty: TFloatField;
    quVerifyDeliveryModelOnHand: TFloatField;
    quVerifyDeliveryModelInPurchasing: TFloatField;
    spquKitPriceQty: TFloatField;
    spApplyCustomerDiscount: TADOStoredProc;
    spCalcCustomerDiscount: TADOStoredProc;
    dspKitPrice: TDataSetProvider;
    cdsKitPrice: TClientDataSet;
    cdsKitPriceSellingPrice: TFloatField;
    cdsKitPriceQty: TFloatField;
    spApplyCustItemDiscount: TADOStoredProc;
    spCashAddPayment: TADOStoredProc;
    spImporEstimated: TADOStoredProc;
    quValidateDelivery: TADODataSet;
    quValidateDeliveryQty: TBCDField;
    WebDispatcher1: TWebDispatcher;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
     //Antonio M F Souza august 31, 2012 - to fix price break after apply promo.
     fCdsPriceBreak: TClientDataSet;

     // Antonio M F Souza, Feb 19, 2013
     fPriceBreakIsCrossed: Boolean;

     function isUnitPriceInInventorySetToZero(arg_idmodel: Integer): Boolean;
     function isAskSalePriceEnable(arg_idmodel: Integer): Boolean;

  public
     fCommisList : TStringList;
     fDefaultSalesPerson : TStringList;

     //Antonio M F Souza august 31, 2012 - save price breaks objects.
     property cdsPriceBreak: TClientDataset read fCdsPriceBreak;

    //CashRegister functions
    function OpenCashRegister(f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fIDCashReg, fIDUser : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit: Currency;
                              fDate : TDateTime;
                              var fIDCashRegMov, fIDCashRegLog : Integer):Boolean;
    function CloseCashRegister(fIDCashRegMov, fIDUser : Integer;
                              f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              var fIDCashRegLog, fError : Integer):Boolean;

    function SubCloseCashRegister(fIDCashRegMov, fIDUser: Integer;
                                  fTotalCount, fTotalCash, fTotalCard,
                                  fTotalPreCard, fTotalCheck,
                                  fTotalOther, fTotalDebit: Currency; fEnvolop: String;
                                  fDate: TDateTime; var fIDCashRegLog,
                                  fError: Integer): Boolean;

    function QuitaLancamento(FIDCashRegMov, FIDLancamentoQuitar,
                             FUser: Integer; FDate: TDateTime): Boolean;




    function WithdrawCashRegister(fIDCashRegMov, fIDUser : Integer;
                                f100, f50, f20, f10, f05, f02, f01,
                                f0100, f050, f025, f010, f005, f001 : Integer;
                                fTotalCash, fTotalCard, fTotalPreCard,
                                fTotalCheck, fTotalOther, fTotalDebit : Currency;
                                fEnvolop : String;
                                fDate : TDateTime;
                                fOBS: String; fIDReason: Integer):Boolean;

    procedure GetCashRegisterResidual(fIDCashRegMov:Integer;
                                     var fIDOpenUser : Integer;
                                     var fResidual   : Double);
    procedure GetCashRegisterInfo(fIDCashReg : Integer;
                                  var fCashRegName, fOpenUser : String;
                                  var fStatus : Integer;
                                  var fOpenDate : TDateTime);
    function TestRefresh:Integer;
    function GetTotalCashReceived(fIDCashRegMov:Integer):Double;
    function GetTotalCashWithdraw(fIDCashRegMov:Integer):Double;
    function AddPettyCash(fIDCashRegMov, fIDUser:Integer;
                          fCash : Currency;
                          fDate : TDateTime;
                          fIDReason : Integer;
                          fOBS: String;
                          var fIDCashRegLog: Integer):Boolean;
    function AddCash(fIDCashRegMov, fIDUser:Integer;
                          fCash : Currency;
                          fDate : TDateTime;
                          fIDReason : Integer;
                          fOBS: String;
                          var fIDCashRegLog: Integer):Boolean;
    function AddPayment(fIDPreSale, fIDStore, fIDUser, fIDCustomer,
                        fIDMeioPag, fIDCashRegMov : Integer;
                        fPreSaleDate, fExpireDate : TDateTime;
                        fNumParcela, fAutotize : String;
                        fTotalInvoice : Double;
                        fCheckNumber, fCustomerDocument,
                        fCustomerName, fCustomerPhone: String;
                        fIDBankCheck : Integer;
                        fOBS: String;
                        fPaymentPlace: Integer;
                        fIsPreDatado: Boolean):Boolean;

    function PreSalePay(fIDPreSale, fIDTourGroup, fIDOtherCommis,
                        fIDCashRegMov, fIDStore : Integer;
                        fDate, fPayDate : TDateTime;
                        fCashReceived : Double; fBonusBucks: Currency;
                        fBonusCode : String;
                        var fIDInvoice : Integer):Boolean;

    //Invoice functions
    // Antonio Apr 08, 2014
    function resetDiscount(arg_IdPreInventoryMov: Integer): Boolean;
    function resetManualPrice(arg_IdPreInventoryMov: Integer): Boolean;

    function CreateHold(fDeliverType : Integer;
                     fIsLayaway : Boolean; fIDStore : Integer;
                     fFName, fLName, fZip : String;
                     fIDTourGroup : Integer; fPreSaleDate : TDateTime;
                     fIDCustomer, fIDMedia, fIDOtherComm : Integer;
                     InvObs:String; var fIDPreSale: Integer):Boolean;
    function DeleteHold(fIDPreSale, fIDUser:Integer):Boolean;
    procedure GetQty(fIDModel, fIDStore : Integer;
                     var OnHand, OnPreSale, OnPrePurchase, OnAvailable : Double);
    function GetKitPrice(fIDModel : Integer; fQty : Double; fSellingPrice:Currency;
                         var fIsEmpty:Boolean; aIdPresale: Integer = -1; pIsStoreSellingPrice: Boolean = false; pIsAddingItem: boolean = false):Currency;
    function AddHoldItem(fIDCustomer, fIDHold, fIDModel, fIDStore: Integer; fQty : Double;
                         fDiscount, fSale, fCost : Currency;
                         fIDUser, fIDCommis : Integer;
                         fMovDate, fDate : TDateTime;
                         fResetDisc, fManager : Boolean;
                         fIDPreInvMovExchange : Integer;
                         fDepartment : Integer;
                         var fError, fIDPreInvMov : Integer;
                         fIDParentPack : Integer = 0;
                         fPromo : Boolean = False;
                         fIDDescriptionPrice: Integer = 0;
                         fIDVendorPrice: Integer = 0;
                         fSuggPrice: Currency = 0;
                         fDocumentNumber: String = '';
                         fIDDocumentType: Integer = 0;
                         fDiscountPromo: Currency=0;
                         { Alex 09/17/2011 }
                         fEachDiscount : Currency = 0;
                         pbCheckForExistingItems : Boolean = True;
                         arg_ManualPrice: Currency = 0;
                         arg_ManualDiscount: Currency = 0;
                         arg_IdSpecialPrice: Integer = 0;
                         arg_isManualPrice: Boolean = false;
                         arg_isManualDiscount: Boolean = false
                          ): Boolean;

    function DeleteHoldItem(fIDHold, fIDPreInvMov, fIDModel,
                            fIDUser : Integer; fQty : Double;
                            fDiscount, fSale : Double;
                            fResetDisc, fManage, SellBelowCost : Boolean;
                            fDate:TDateTime;
                            var fError : Integer):Boolean;

    //Antonio M F Souza 12.22.2010 - I had to add IdStore information in order to realize uses same function.
    function UpdateHoldItem(fIDHold, fPreInvMovID, fIDModel,
                            fIDCommis, fIDUSer : Integer; fQty : Double;
                            fDiscount, fSale, fCost : Double;
                            fMovDate, fDate : TDateTime;
                            fResetDisc, fManager : Boolean;
                            fDepartment : Integer;
                            var fError, fIDPreInvMov : Integer;
                            fIDPreSaleParent : Integer = 0;
                            fPromo : Boolean = False;
                            fIDDescriptionPrice: Integer = 0;
                            fIDVendorPrice: Integer = 0;
                            fSuggPrice: Currency = 0;
                            fDocumentNumber: String = '';
                            fIDDocumentType: Integer = 0;
                            fDiscountPromo: Currency=0;
                            fIdStore: Integer = 1;
                            // Antonio M F Souza December 10 2012
                            fEachDiscount : Currency = 0):Boolean;
    function RecalcTax(fIDPreSale : Integer; fDate :TDateTime):Boolean;
    function ExemptTax(fIDPreSale : Integer; fExempt :Boolean):Boolean;
    function SetExemptTax(fIDPreSale, fIDMedia : Integer; fDate :TDateTime):Boolean;
    function AddSpecialPrice(fIDPreSale, fIDSpecialPrice: Integer;
                             fDate :TDateTime; fExemptTax:Boolean):Boolean;
    function DeleteSpecialPrice(fIDPreSale : Integer; fDate :TDateTime; fExemptTax:Boolean):Boolean;
    function GetSpecialPriceTotal(fIDPreSale:Integer):Double;
    function ManageDiscount(fIDPreSale: Integer; fDiscountPercent : Double;
                            fDate :TDateTime; fExemptTax, fSellBellowCost, fIsPromo:Boolean):Boolean;
    function GetMinSaleAndMaxDiscount(fIDPreSale, fIDUser : Integer;
                                      var fMaxMinSale, fMaxDiscount : Double):Boolean;
    function AddInvoiceAdtionalCost(fIDPreSale, fIDCostType : Integer; fAmount : Currency):Boolean;
    function DeleteInvoiceAdtionalCost(fIDInvoiceCost:Integer):Boolean;
    function CancelHold(IDPreSale, IDUser:Integer):Boolean;

    function DivideHold(IDPreSale, DeliverTypeID: Integer;
       DeliverDate: TDateTime; DeliverAddress, DeliverOBS: String;
       var NewIDPreSale: Integer): Boolean;

    //Invoice Values
    function GetInvoicePayments(IDPreSale:Integer):Currency;

    function AddCustomerCredit(fIDPessoa, fIDUser, fIDStore, fIDLancamento: Integer; fCreditDate,
      fExpirationDate: TDateTime; fAmount: Double;
      var fIDCustomerCredit: Integer): Boolean;

    function GetPayType(FIDMeioPag: String): Integer;

    function IsNegativeStoreDelivery(IDPreSale, IDStore, IDModel: Integer; var AQtyAvaiable: Double): Boolean;
    function QtyInDelivered(IDModel, IDStore : Integer; var HasDeliver: Boolean):Double;
    function GetCustomerDeliverOpenHold(IDCustomer, IDPreSale: Integer):String;
    function HasPaymentPending(IDPreSale: Integer): Boolean;
    function CanMarkDelivery(AIDPreSale, AIDModel : Integer; APreSaleDate : TDateTime;
         AQtyAvaiable, AQtyActual: Double): Boolean;

    function CreateSaleCode(IDPreSale, IDPreSaleParent, IDStore: Integer):String;

    function AddItemCommission(IDInventoryMov, IDPreInventoryMov: String;
      IDPessoa: Integer; Percent: Real):Boolean;

    // set discount to zero in PreInventoryMov
    procedure setDiscountToZero(arg_idpreinvmov: Integer);

    procedure ClearCommissionList;
    procedure AddSaleItemCommission(ID, PreSaleType: Integer);
    procedure AddCommissionsList(ID, PreSaleType: Integer);
    procedure ApplyCustomerDiscount(AIDPreSale, AIDCustomer: Integer; ADate: TDateTime);
    procedure ApplyCustomerItemDiscount(AIDPreSale, AIDCustomer, AIDPreInventoryMov: Integer; ADate: TDateTime);
    function CalcCustomerDiscount(AIDCustomer, AIDModel: Integer; AQty, ASalePrice: Double): Currency;

    procedure AddPreSaleItemCommission(ID: Integer; DefaultSalesPerson: TStringList);
    procedure ClearDefaultSalesPerson;

    function ImportEstimated(IDEstimated, IDMedia, IDStore, IDUser : Integer;
      TaxIsent, UpdateSalePrice : Boolean):Integer;

    //Antonio M F Souza 10.20.2010: Verify if already exists presale with the same conditions(IdModel, sale price, discount, comission)
    function IsThereSameConditionsToSale(var APreInvQtyCurrent: double; var AIdPreInvMov: integer; var OutQtyPreSale: double; var OutDiscount: double; AIdStore, AIdModel, ADocumentID, AIdComission: integer;
    ASalePrice, ADiscount: double; AInsert: boolean; AManager: boolean; pPromoDiscount: double; eachDiscount: double = 0): boolean;

    //Antonio M F Souza 10.20.2010: update quantity into preInventory
    procedure UpdateQtyPreInventory(ATotalQtyPreInventory: double;
      AIdStore, AIdModel, ADocumentID, AIdComission: integer; ASalePrice, ADiscount: double);

    //Antonio M F Souza 10.21.2011 - test if total of records is greater than 1 to can delete and replace changes.
    function canDeleteInDetail(AIdStore, AIdModel, AIdPreSale, AIdCommission: integer; ASalePrice: double): boolean;

    //Antonio M F Souza August 27, 2012
    function getQtyInCashRegisterToModel(aIdPreSale, aIdModel: Integer; pSaveQtyEdited: Double = 0): Double;

    //Antonio M F Souza august 31, 2012
    function getItemPreSaleDetail(aIdPreSale: Integer): TADOStoredProc;

    function ApplySalePriceBroke(aInventoryMovId: Integer; aDiscount, aSalePrice: Currency): boolean;

    //Antonio M F Souza September 10, 2012
    function getSellingPriceFromModel(pIdModel: Integer): Currency;

    //Antonio M F Souza September 26, 2012
    function getCurrentIdPreinventoryMov: Integer;
    function preInventoryMovIsEmpty(pIdPreInvMov: Integer): Boolean;

    //Antonio M F Souza September 28, 2012
    function getQtyAfterEditScreen(pIdInvMov, pIdModel: Integer): Integer;

    //Antonio M F Souza October 04, 2012
    function getSaleItemCommision(pIdPreinvMov: Integer): TADOQuery;

    // Antonio M F Souza, Feb 19, 2013
    function canUpdatePriceOnEdit(arg_idModel: Integer): Boolean;



  end;

implementation

uses uDM, uSystemConst, uSqlFunctions, uHandleError, ConvUtils,
  uCDSFunctions, uPassword, uDMParent;

{$R *.dfm}

function TFrmPOSFunctions.WithdrawCashRegister(fIDCashRegMov, fIDUser : Integer;
                              f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              fOBS: String; fIDReason: Integer):Boolean;
var
  iError : Integer;
begin

  try
    // Fecha a caixa registradora
    with spCashRegWidraw do
    begin
      Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
      Parameters.ParamByName('@IDUser').Value       := fIDUser;
      Parameters.ParamByName('@Bill100').Value      := f100;
      Parameters.ParamByName('@Bill50').Value       := f50;
      Parameters.ParamByName('@Bill20').Value       := f20;
      Parameters.ParamByName('@Bill10').Value       := f10;
      Parameters.ParamByName('@Bill5').Value        := f05;
      Parameters.ParamByName('@Bill2').Value        := f02;
      Parameters.ParamByName('@Bill1').Value        := f01;
      Parameters.ParamByName('@Coin1').Value        := f0100;
      Parameters.ParamByName('@Coin050').Value      := f050;
      Parameters.ParamByName('@Coin025').Value      := f025;
      Parameters.ParamByName('@Coin010').Value      := f010;
      Parameters.ParamByName('@Coin005').Value      := f005;
      Parameters.ParamByName('@Coin001').Value      := f001;
      Parameters.ParamByName('@TotalCash').Value    := fTotalCash;
      Parameters.ParamByName('@TotalCard').Value    := fTotalCard;
      Parameters.ParamByName('@TotalCardPre').Value := fTotalPreCard;
      Parameters.ParamByName('@TotalCheck').Value   := fTotalCheck;
      Parameters.ParamByName('@TotalOther').Value   := fTotalOther;
      Parameters.ParamByName('@TotalDebit').Value   := fTotalDebit;
      Parameters.ParamByName('@LogDocument').Value  := fEnvolop;
      Parameters.ParamByName('@Date').Value         := fDate;
      Parameters.ParamByName('@IDReason').Value     := fIDReason;
      Parameters.ParamByName('@COO').Value          := 0;
      Parameters.ParamByName('@GNF').Value          := 0;

      if Trim(fOBS) <> '' then
        Parameters.ParamByName('@OBS').Value         := fOBS
      else
        Parameters.ParamByName('@OBS').Value         := NULL;
      ExecProc;
      iError := Parameters.ParamByName('@RETURN_VALUE').Value;
      Result := (iError = 0);
    end;
  except
    Result := False;
    end;

end;

function TFrmPOSFunctions.GetTotalCashWithdraw(fIDCashRegMov:Integer):Double;
begin
  with spCashRegCalcCashWidraw do
     begin
     Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
     ExecProc;
     Result := Parameters.ParamByName('@TotalCash').Value;
     end;
end;

function TFrmPOSFunctions.AddPettyCash(fIDCashRegMov, fIDUser:Integer;
                         fCash : Currency;
                         fDate : TDateTime;
                         fIDReason : Integer;
                         fOBS: String; var fIDCashRegLog: Integer):Boolean;
begin

  try
    with spCashRegPetty do
       begin
       Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
       Parameters.ParamByName('@IDUser').Value       := fIDUser;
       Parameters.ParamByName('@TotalCash').Value    := fCash;
       Parameters.ParamByName('@Date').Value         := fDate;
       Parameters.ParamByName('@IDReason').Value     := fIDReason;
       Parameters.ParamByName('@COO').Value          := 0;
       Parameters.ParamByName('@GNF').Value          := 0;

       if Trim(fOBS) <> '' then
         Parameters.ParamByName('@OBS').Value         := fOBS
       else
         Parameters.ParamByName('@OBS').Value         := NULL;
       ExecProc;
       fIDCashRegLog := Parameters.ParamByName('@IDCashRegLog').Value;
       //fIDCashRegLog := Parameters.ParamByName('@RETURN_VALUE').Value;
       end;
    Result := True;
  except
     Result := False;
     end;
end;

function TFrmPOSFunctions.AddPayment(fIDPreSale, fIDStore, fIDUser, fIDCustomer,
                                     fIDMeioPag, fIDCashRegMov : Integer;
                                     fPreSaleDate, fExpireDate : TDateTime;
                                     fNumParcela, fAutotize : String;
                                     fTotalInvoice : Double;
                                     fCheckNumber, fCustomerDocument,
                                     fCustomerName, fCustomerPhone: String;
                                     fIDBankCheck : Integer;
                                     fOBS: String;
                                     fPaymentPlace: Integer;
                                     fIsPreDatado: Boolean):Boolean;
var
  iError : Integer;
begin
  DM.FTraceControl.TraceIn('TFrmPOSFunctions.AddPayment');

    try
      with spAddParcela do
        begin
        Parameters.ParambyName('@PreSaleID').Value      := fIDPreSale;
        Parameters.ParambyName('@IDStore').Value        := fIDStore;
        Parameters.ParambyName('@IDUser').Value         := fIDUser;
        Parameters.ParambyName('@IDCliente').Value      := fIDCustomer;
        Parameters.ParambyName('@IDMeioPag').Value      := fIDMeioPag;
        Parameters.ParambyName('@IDCashRegMov').Value   := fIDCashRegMov;

        Parameters.ParambyName('@PreSaleDate').Value    := Int(fPreSaleDate);
        Parameters.ParambyName('@ExpirationDate').Value := Int(fExpireDate);
        Parameters.ParambyName('@Parcela').Value        := fNumParcela;
        if fAutotize <> '' then
           Parameters.ParambyName('@Authorization').Value := fAutotize
        else
           Parameters.ParambyName('@Authorization').Value := Null;
        Parameters.ParambyName('@Value').Value          := fTotalInvoice;

        if fCheckNumber <> '' then
          Parameters.ParambyName('@CheckNumber').Value       := fCheckNumber
        else
          Parameters.ParambyName('@CheckNumber').Value       := Null;

        if fCustomerDocument <> '' then
          Parameters.ParambyName('@CustomerDocument').Value  := fCustomerDocument
        else
          Parameters.ParambyName('@CustomerDocument').Value  := Null;

        if fCustomerName <> '' then
          Parameters.ParambyName('@CustomerName').Value      := fCustomerName
        else
          Parameters.ParambyName('@CustomerName').Value      := Null;

        if fCustomerPhone <> '' then
          Parameters.ParambyName('@CustomerPhone').Value     := fCustomerPhone
        else
          Parameters.ParambyName('@CustomerPhone').Value     := Null;

        if fIDBankCheck <> 0 then
          Parameters.ParambyName('@IDBankCheck').Value       := fIDBankCheck
        else
          Parameters.ParambyName('@IDBankCheck').Value       := Null;

        if fOBS <> '' then
          Parameters.ParambyName('@OBS').Value     := fOBS
        else
          Parameters.ParambyName('@OBS').Value     := Null;

        Parameters.ParambyName('@PaymentPlace').Value  := fPaymentPlace;

        Parameters.ParambyName('@IsPreDatado').Value  := fIsPreDatado;


        ExecProc;

        iError := Parameters.ParamByName('@RETURN_VALUE').Value;

        Result := (iError = 0);

        if iError <> 0 then
          Raise Exception.Create('sp_PreSale_AddParcela Error ' + IntToStr(iError));
        end;
    except
      on E: Exception do
      begin
        DM.FTraceControl.SetException(E.Message, 'TFrmPOSFunctions');
        Result := False;
      end;
    end;

  DM.FTraceControl.TraceOut;
end;

function TFrmPOSFunctions.PreSalePay(fIDPreSale, fIDTourGroup, fIDOtherCommis,
                                     fIDCashRegMov, fIDStore : Integer;
                                     fDate, fPayDate : TDateTime;
                                     fCashReceived : Double; fBonusBucks: Currency;
                                     fBonusCode : String;
                                     var fIDInvoice : Integer):Boolean;
var
  sParamError: String;
  iError : Integer;
begin

  DM.FTraceControl.TraceIn('TFrmPOSFunctions.PreSalePay');

  Result := True;

   Try
     with spPreSalePay do
        begin
        Parameters.ParambyName('@PreSaleID').Value         := fIDPreSale;
        Parameters.ParambyName('@IDTouristGroup').Value    := fIDTourGroup;
        Parameters.ParambyName('@OtherComID').Value        := fIDOtherCommis;
        Parameters.ParambyName('@IDCashRegMov').Value      := fIDCashRegMov;
        Parameters.ParambyName('@IDStore').Value           := fIDStore;
        Parameters.ParambyName('@Date').Value              := fDate;
        Parameters.ParambyName('@PayDate').Value           := fPayDate;
        Parameters.ParambyName('@CashReceived').Value      := fCashReceived;
        Parameters.ParamByName('@BonusBucks').Value        := fBonusBucks;
        Parameters.ParamByName('@InvoiceCode').Value       := Null;
        Parameters.ParamByName('@BonusCode').Value         := fBonusCode;
        ExecProc;
        fIDInvoice := Parameters.ParambyName('@IDInvoice').Value;

        iError := Parameters.ParamByName('@RETURN_VALUE').Value;
        Result := (iError = 0);

        if iError <> 0 then
          Raise Exception.Create('sp_PreSale_Pay Error ' + IntToStr(iError));

        end;
    except
      on E: Exception do
      begin
        Result := False;
        sParamError := 'fIDPreSale=' + IntTostr(fIDPreSale) + ';fIDTourGroup=' +
          IntTostr(fIDTourGroup) + ';fIDOtherCommis=' + IntTostr(fIDOtherCommis) +
          ';fIDCashRegMov=' + IntTostr(fIDCashRegMov) + ';fIDStore='+IntTostr(fIDStore) +
          ';fDate=' + FormatDateTime('ddddd hh:mm', fDate) + ';fDate=' + FormatDateTime('ddddd hh:mm', fPayDate) +
          ';fCashReceived=' + CurrToStr(fCashReceived) + '.';
       DM.FTraceControl.SetException(E.Message + ' Param = ' + sParamError, 'TFrmPOSFunctions');
      end;
    end;
end;

function TFrmPOSFunctions.GetTotalCashReceived(fIDCashRegMov:Integer):Double;
begin
  with spCashRegCalcCash do
     begin
     Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
     ExecProc;
     Result := Parameters.ParamByName('@TotalCash').Value;
     end;
end;


function TFrmPOSFunctions.TestRefresh:Integer;
begin
  with quTestRefresh do
     begin
     Open;
     Result := FieldByName('InvoiceCount').AsInteger;
     Close;
     end;
end;

procedure TFrmPOSFunctions.GetCashRegisterInfo(fIDCashReg : Integer;
                                 var fCashRegName, fOpenUser : String;
                                 var fStatus : Integer;
                                 var fOpenDate : TDateTime);
begin

  with quCashRegInfo do
     begin
     Close;
     Parameters.ParamByName('IDCashRegMov').Value := fIDCashReg;
     Open;
     fCashRegName := quCashRegInfoCashRegister.AsString;
     fOpenUser    := quCashRegInfoSystemUser.AsString;
     fStatus      := quCashRegInfoIDCashregStatus.AsInteger;
     fOpenDate    := quCashRegInfoOpenTime.AsDateTime;
     Close;
     end;

end;


procedure TFrmPOSFunctions.GetCashRegisterResidual(fIDCashRegMov:Integer;
                              var fIDOpenUser : Integer;
                              var fResidual   : Double);
begin
  with quCashRegResidual do
     begin
     Parameters.ParamByName('IDCashRegMov').Value := fIDCashRegMov;
     Open;
     fIDOpenUser := quCashRegResidualIDOpenUser.AsInteger;
     fResidual   := quCashRegResidualResidual.AsFloat;
     Close;
     end;
end;


function TFrmPOSFunctions.CloseCashRegister(fIDCashRegMov, fIDUser : Integer;
                              f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              var fIDCashRegLog, fError : Integer):Boolean;
begin

   try
      // Fecha a caixa registradora
      with spCashRegClose do
      begin
        Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
        Parameters.ParamByName('@IDUser').Value       := fIDUser;
        Parameters.ParamByName('@IDUsuario').Value    := fIDUser;
        Parameters.ParamByName('@Bill100').Value      := f100;
        Parameters.ParamByName('@Bill50').Value       := f50;
        Parameters.ParamByName('@Bill20').Value       := f20;
        Parameters.ParamByName('@Bill10').Value       := f10;
        Parameters.ParamByName('@Bill5').Value        := f05;
        Parameters.ParamByName('@Bill2').Value        := f02;
        Parameters.ParamByName('@Bill1').Value        := f01;
        Parameters.ParamByName('@Coin1').Value        := f0100;
        Parameters.ParamByName('@Coin050').Value      := f050;
        Parameters.ParamByName('@Coin025').Value      := f025;
        Parameters.ParamByName('@Coin010').Value      := f010;
        Parameters.ParamByName('@Coin005').Value      := f005;
        Parameters.ParamByName('@Coin001').Value      := f001;
        Parameters.ParamByName('@FinalCount').Value   := fTotalCount;
        Parameters.ParamByName('@TotalCash').Value    := fTotalCash;
        Parameters.ParamByName('@TotalCard').Value    := fTotalCard;
        Parameters.ParamByName('@TotalCardPre').Value := fTotalPreCard;
        Parameters.ParamByName('@TotalCheck').Value   := fTotalCheck;
        Parameters.ParamByName('@TotalOther').Value   := fTotalOther;
        Parameters.ParamByName('@TotalDebit').Value   := fTotalDebit;
        Parameters.ParamByName('@LogDocument').Value  := fEnvolop;
        Parameters.ParamByName('@Date').Value         := fDate;
        ExecProc;
        fIDCashRegLog := spCashRegClose.Parameters.ParamByName('@IDCashRegLog').Value;
        fError        := Parameters.ParamByName('@RETURN_VALUE').Value; //IF Error = -1  (Error closing)
        Result        := True;
      end;
   except
      fError := -1;
      Result := False;
      end;

end;


function TFrmPOSFunctions.SubCloseCashRegister(fIDCashRegMov, fIDUser : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              var fIDCashRegLog, fError : Integer):Boolean;
begin

   try
      // Fecha a caixa registradora
      with spCashRegSubClose do
      begin
        Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
        Parameters.ParamByName('@IDUser').Value       := fIDUser;
        Parameters.ParamByName('@IDUsuario').Value    := fIDUser;
        Parameters.ParamByName('@FinalCount').Value   := fTotalCount;
        Parameters.ParamByName('@TotalCash').Value    := fTotalCash;
        Parameters.ParamByName('@TotalCard').Value    := fTotalCard;
        Parameters.ParamByName('@TotalCardPre').Value := fTotalPreCard;
        Parameters.ParamByName('@TotalCheck').Value   := fTotalCheck;
        Parameters.ParamByName('@TotalOther').Value   := fTotalOther;
        Parameters.ParamByName('@TotalDebit').Value   := fTotalDebit;
        Parameters.ParamByName('@LogDocument').Value  := fEnvolop;
        Parameters.ParamByName('@Date').Value         := fDate;
        ExecProc;
        fIDCashRegLog := spCashRegSubClose.Parameters.ParamByName('@IDCashRegLog').Value;
        fError        := Parameters.ParamByName('@RETURN_VALUE').Value; //IF Error = -1  (Error closing)
        Result        := True;
      end;
   except
      fError := -1;
      Result := False;
      end;
end;


function TFrmPOSFunctions.QuitaLancamento(FIDCashRegMov, FIDLancamentoQuitar, FUser: Integer; FDate: TDateTime): Boolean;
begin
  Result := True;
  try
    with sp_CashRegister_QuitaLancamento do
    begin
      Parameters.ParamByName('@IDCashRegMov').Value       := FIDCashRegMov;
      Parameters.ParamByName('@IDLancamentoQuitar').Value := FIDLancamentoQuitar;
      Parameters.ParamByName('@IDUsuario').Value          := FUser;
      Parameters.ParamByName('@Date').Value               := FDate;
      ExecProc;
    end;
  except
    Result := False;
  end;
end;


function TFrmPOSFunctions.OpenCashRegister(f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fIDCashReg, fIDUser : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fDate : TDateTime;
                              var fIDCashRegMov, fIDCashRegLog : Integer):Boolean;
begin

  try

    with spCashRegOpen do
    begin
      Parameters.ParamByName('@Bill100').Value        := f100;
      Parameters.ParamByName('@Bill50').Value         := f50;
      Parameters.ParamByName('@Bill20').Value         := f20;
      Parameters.ParamByName('@Bill10').Value         := f10;
      Parameters.ParamByName('@Bill5').Value          := f05;
      Parameters.ParamByName('@Bill2').Value          := f02;
      Parameters.ParamByName('@Bill1').Value          := f01;
      Parameters.ParamByName('@Coin1').Value          := f0100;
      Parameters.ParamByName('@Coin050').Value        := f050;
      Parameters.ParamByName('@Coin025').Value        := f025;
      Parameters.ParamByName('@Coin010').Value        := f010;
      Parameters.ParamByName('@Coin005').Value        := f005;
      Parameters.ParamByName('@Coin001').Value        := f001;
      Parameters.ParamByName('@IDCashregister').Value := fIDCashReg;
      Parameters.ParamByName('@IDUser').Value         := fIDUser;
      Parameters.ParamByName('@OpenMoney').Value      := fTotalCount;
      Parameters.ParamByName('@TotalCash').Value      := fTotalCash;
      Parameters.ParamByName('@TotalCard').Value      := fTotalCard;
      Parameters.ParamByName('@TotalCardPre').Value   := fTotalPreCard;
      Parameters.ParamByName('@TotalCheck').Value     := fTotalCheck;
      Parameters.ParamByName('@TotalOther').Value     := fTotalOther;
      Parameters.ParamByName('@TotalDebit').Value     := fTotalDebit;
      Parameters.ParamByName('@Date').Value           := fDate;
      Parameters.ParamByName('@COO').Value            := 0;
      Parameters.ParamByName('@GNF').Value            := 0;

      ExecProc;
      fIDCashRegLog := spCashRegOpen.Parameters.ParamByName('@IDCashRegLog').Value;
      fIDCashRegMov := spCashRegOpen.Parameters.ParamByName('@IDCashRegMov').Value;
    end;
    Result := True;
  except
    Result := False;
    end;

end;

//Invoice Function s
function TFrmPOSFunctions.CreateHold(fDeliverType : Integer;
                                     fIsLayaway : Boolean; fIDStore : Integer;
                                     fFName, fLName, fZip : String;
                                     fIDTourGroup : Integer; fPreSaleDate : TDateTime;
                                     fIDCustomer, fIDMedia, fIDOtherComm : Integer;
                                     InvObs:String; var fIDPreSale: Integer):Boolean;
begin
  Dm.FTraceControl.TraceIn('TFrmPOSFunctions.CreateHold');

  try
    with spCreateHold do
      begin
        Parameters.ParambyName('@DeliverTypeID').Value     := fDeliverType;
        Parameters.ParambyName('@Layaway').Value           := fIsLayaway;
        Parameters.ParambyName('@IDStore').Value           := fIDStore;
        Parameters.ParambyName('@FirstName').Value         := fFName;
        Parameters.ParambyName('@LastName').Value          := fLName;
        Parameters.ParambyName('@ZIP').Value               := fZip;
        Parameters.ParambyName('@PreSaleDate').Value       := fPreSaleDate;
        Parameters.ParambyName('@IDCustomer').Value        := fIDCustomer;
        Parameters.ParambyName('@MediaID').Value           := fIDMedia;
        Parameters.ParambyName('@IDOtherCommission').Value := fIDOtherComm;
        Parameters.ParambyName('@CustomerDOC').Value       := Null;
        if fIDOtherComm = 0 then
           Parameters.ParambyName('@IDOtherCommission').Value := Null
        else
           Parameters.ParambyName('@IDOtherCommission').Value := fIDOtherComm;
        if fIDTourGroup = 0 then
           Parameters.ParambyName('@IDTouristGroup').Value := Null
        else
           Parameters.ParambyName('@IDTouristGroup').Value := fIDTourGroup;
        if Trim(InvObs) = '' then
           begin
           Parameters.ParambyName('@Note').Value       := Null;
           Parameters.ParambyName('@PrintNotes').Value := False;
           end
        else
           begin
           Parameters.ParambyName('@Note').Value       := InvObs;
           Parameters.ParambyName('@PrintNotes').Value := True;
           end;
        ExecProc;
        fIDPreSale := Parameters.ParambyName('@IDPreSale').Value;
      end;
     Result := True;
   except
     on E: Exception do
     begin
       Result := False;
       DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmPOSFunctions');
     end;
   end;

  Dm.FTraceControl.TraceOut;
end;

function TFrmPOSFunctions.DeleteHold(fIDPreSale, fIDUser:Integer):Boolean;
var
  presale: TClientDataset;
begin
  // remove sal_account card to
  try
      presale := dm.getPresale(intToStr(fIDPresale));

      while ( not presale.Eof ) do begin
         dm.deleteSalAccountCardByPreInvMov(presale.fieldByName('IdPreInventoryMov').Value);
         presale.Next;
      end;
  finally
      freeAndNil(presale);
  end;

  try
    with spDeletePreSale do
       begin
       Parameters.ParambyName('@PreSaleID').Value := fIDPreSale;
       Parameters.ParambyName('@IDUser').Value    := fIDUser;
       ExecProc;
       end;
    Result := True;
  except
    Result := False;
    end;

end;

procedure TFrmPOSFunctions.GetQty(fIDModel, fIDStore : Integer;
                                  var OnHand, OnPreSale, OnPrePurchase, OnAvailable : Double);
begin

  with spquQuantity do
     if not Active then
        begin
        if fIDModel = 0 then
           Parameters.ParambyName('@ModelID').Value := Null
        else
           Parameters.ParambyName('@ModelID').Value := fIDModel;
        Open;
        Locate('StoreID', IntToStr(fIDStore), []);
        OnHand        := spquQuantityQtyOnHand.AsFloat;
        OnPreSale     := spquQuantityQtyOnPreSale.AsFloat;
        OnPrePurchase := spquQuantityQtyOnPrePurchase.AsFloat;
        if not DM.fSystem.SrvParam[PARAM_DISPLAY_QTY_FLOATING] then
           OnAvailable := OnHand - OnPreSale
        else
          begin
            if DM.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] then
               OnAvailable := (OnHand - OnPreSale) + ((OnPreSale * spquQuantityFloatPercent.AsFloat)) / 100
            else
               OnAvailable := Trunc((OnHand - OnPreSale) + ((OnPreSale * spquQuantityFloatPercent.AsFloat)) / 100);
          end;

        Close;
        end;

end;

function TFrmPOSFunctions.GetKitPrice(fIDModel : Integer; fQty : Double; fSellingPrice:Currency;
                                      var fIsEmpty : Boolean; aIdPresale: Integer = -1; pIsStoreSellingPrice: Boolean = false; pIsAddingItem: boolean = false):Currency;
const
  PAR_1 = 1;

           // Antonio M F Souza September 18, 2012 local function
           function getNextIndexFromVetQty(pVet: Array of Integer; pQty: Integer): Integer;
           var
             k: Integer;
           begin
             result := 0;
             for k:= 0 to 9 do begin
                 if pVet[k] = pQty then begin
                    result := k + 1;
                    break;
                 end;
             end;
           end;

//Antonio M F Souza August 28, 2012
var
  completeQty: Extended;
  nextQty: extended;
  vetQty: Array[0..9] of Integer;
  i: Integer;
  indexVetQty: Integer;
  //Antonio M F Souza September 20, 2012
  maxIndexVetQty: Integer;
begin
  Result := getSellingPriceFromModel(fIDModel);//fSellingPrice;

  fIsEmpty := True;

  //Antonio M F Souza September 26, 2012 - to fix when detail button was pressed.
  if ( not pIsAddingItem ) then begin
      completeQty := 0;
      completeQty := getQtyInCashRegisterToModel(aIdPresale, fIdModel);
      completeQty := completeQty + fQty;
  end;

  if ( completeQty <= 0 ) then begin
     completeQty := fQty;
     fIsEmpty := false;
  end;

  // amfsouza, April 23, 2013 - result = price on inventory maintenance
  if ( completeQty = 1 ) then
     exit;

  try
    cdsKitPrice.filter   := '';
    cdsKitPrice.Filtered := False;
    cdsKitPrice.Close;
    cdsKitPrice.Params.ParamByName('@IDModel').Value := fIDModel;
    cdsKitPrice.Open;

    i := 0;
    maxIndexVetQty := i;
    while ( not cdsKitPrice.Eof ) do begin
         vetQty[i] := cdsKitPrice.fieldByName('Qty').asInteger;
         maxIndexVetQty := i;
         cdsKitPrice.Next;
         inc(i);
    end;

    cdsKitPrice.First;

    if DM.fSystem.SrvParam[PARAM_PROGRESSIVE_QTY_DISCOUNT] then begin
        while ( not cdsKitPrice.eof ) do begin

            //Antonio M F Souza September 21, 2012 - keep store price
            if ( pIsStoreSellingPrice ) then begin
               fCdsPriceBreak.Append;
               fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
               fCdsPriceBreak.FieldByName('PriceBreak').Value := fSellingPrice;
               fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
               fCdsPriceBreak.Post;
               Result := fSellingPrice;//getSellingPriceFromModel(fIDModel);
               break;
            end;

            if ( cdsKitPrice.RecordCount = 1 ) then begin
               if ( abs(completeQty) >= cdsKitPrice.fieldByname('qty').Value ) then begin
                   fCdsPriceBreak.Append;
                   fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
                   fCdsPriceBreak.FieldByName('PriceBreak').Value := cdsKitPriceSellingPrice.AsFloat;
                   fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
                   fCdsPriceBreak.Post;
                   Result := cdsKitPriceSellingPrice.AsFloat;//getSellingPriceFromModel(fIDModel);

                   fPriceBreakIsCrossed := true;

                   break;
               end;

            end
            else begin

                // Antonio M F Souza November 20: To fix price breaks when kit price has just one record.
                if ( abs(completeQty) < cdsKitPrice.fieldByName('Qty').Value ) then begin
                   if ( cdsKitprice.RecordCount = 1 ) then begin
                       fCdsPriceBreak.Append;
                       fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
                       fCdsPriceBreak.FieldByName('PriceBreak').Value := cdsKitPriceSellingPrice.AsFloat;
                       fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
                       fCdsPriceBreak.Post;
                       Result := cdsKitPriceSellingPrice.AsFloat;//getSellingPriceFromModel(fIDModel);

                       fPriceBreakIsCrossed := true;

                       break;

                   end
                   else begin
                       fCdsPriceBreak.Append;
                       fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
                       fCdsPriceBreak.FieldByName('PriceBreak').Value := fSellingPrice;
                       fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
                       fCdsPriceBreak.Post;
                       Result := fSellingPrice;//getSellingPriceFromModel(fIDModel);

                       fPriceBreakIsCrossed := true;

                       break;

                       end;
                end;

                if ( abs(completeQty) = cdsKitPrice.fieldByname('Qty').Value ) then begin
                    fCdsPriceBreak.Append;
                    fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
                    fCdsPriceBreak.FieldByName('PriceBreak').Value := cdsKitPriceSellingPrice.AsFloat;
                    fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
                    fCdsPriceBreak.Post;
                    Result := cdsKitPriceSellingPrice.AsFloat;

                    fPriceBreakIsCrossed := true;

                    break;
                end;

                if ( abs(completeQty) > cdsKitPrice.fieldByname('Qty').Value) then begin
                    //get content matches with qty kit price
                    indexVetQty := getNextIndexFromVetQty(vetQty, cdsKitPrice.fieldByname('Qty').asInteger);

                    if ( abs(completeQty) <= vetQty[indexVetQty] - 1 ) then begin
                        fCdsPriceBreak.Append;
                        fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
                        fCdsPriceBreak.FieldByName('PriceBreak').Value := cdsKitPriceSellingPrice.AsFloat;
                        fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
                        fCdsPriceBreak.Post;
                        Result := cdsKitPriceSellingPrice.AsFloat;

                        fPriceBreakIsCrossed := true;

                        Break;
                    end
                    else begin

                        //Antonio M F Souza September 20, 2012
                        if ( indexVetQty > maxIndexVetQty ) then begin
                            dec(indexVetQty);
                            fCdsPriceBreak.Append;
                            fCdsPriceBreak.FieldByName('IdModel').Value := fIdModel;
                            fCdsPriceBreak.FieldByName('PriceBreak').Value := cdsKitPriceSellingPrice.AsFloat;
                            fCdsPriceBreak.fieldByName('IsPriceBroke').value := true;
                            fCdsPriceBreak.Post;
                            Result := cdsKitPriceSellingPrice.AsFloat;

                            fPriceBreakIsCrossed := true;

                            Break;
                        end;


                    end;
                end;
            end;

            cdsKitPrice.next;
        end;
    end
    else  begin // Antonio M F Souza August 29, 2012 - ?? not sure about yet code bellow.
         //Antonio M F Souza August 28, 2012  if Locate('Qty', FloatToStr(fQty), []) then
         if cdsKitPrice.Locate('Qty', FloatToStr(abs(fQty)), []) then
            Result := cdsKitPriceSellingPrice.AsFloat;
    end;

  finally
    cdsKitPrice.Close;
    cdsKitPrice.Filter   := '';
    cdsKitPrice.Filtered := False;
  end;
end;

function TFrmPOSFunctions.AddHoldItem(fIDCustomer,
                                      fIDHold,
                                      fIDModel,
                                      fIDStore : Integer;
                                      fQty : Double;
                                      fDiscount,
                                      fSale,
                                      fCost : Currency;
                                      fIDUser,
                                      fIDCommis : Integer;
                                      fMovDate,
                                      fDate : TDateTime;
                                      fResetDisc,
                                      fManager : Boolean;
                                      fIDPreInvMovExchange : Integer;
                                      fDepartment : Integer;
                                      var fError,
                                      fIDPreInvMov : Integer;
                                      fIDParentPack : Integer = 0;
                                      fPromo : Boolean = False;
                                      fIDDescriptionPrice: Integer = 0;
                                      fIDVendorPrice: Integer = 0;
                                      fSuggPrice: Currency = 0;
                                      fDocumentNumber: String = '';
                                      fIDDocumentType: Integer = 0;
                                      fDiscountPromo: Currency=0;
                                      { Alex 09/17/ 2011 }
                                      fEachDiscount : Currency = 0;
                                      pbCheckForExistingItems : Boolean = True;
                                      arg_ManualPrice: Currency = 0;
                                      arg_ManualDiscount: Currency = 0;
                                      arg_IdSpecialPrice: Integer = 0;
                                      arg_isManualPrice: Boolean = false;
                                      arg_isManualDiscount: Boolean = false
                                      ) : Boolean;
var
   qtyPreInventoryCurrent: double;
   OutQtyPreSale: double;
   OutDiscount: double;
   IdpreInvMov: integer;
   iError: integer;
   _list_param: TStringList;
begin
(*  showmessage(
  format('sending to sp: PresaleID  = %d,  IdModel = %d, SalePrice = %.2f, Customer = %d, manual discount = %.2f, discount = %.2f',
  [fIDHold, fIdModel, fSale, fIDCustomer, arg_manualDiscount, fDiscount]));
*)
  try
       spAddPreSaleItem.Parameters.ParambyName('@PreSaleID').Value           := fIDHold;

       spAddPreSaleItem.Parameters.ParambyName('@IDCliente').Value           := fIDCustomer;

       spAddPreSaleItem.Parameters.ParambyName('@ModelID').Value             := fIDModel;

       spAddPreSaleItem.Parameters.ParambyName('@StoreID').Value             := fIDStore;

       spAddPreSaleItem.Parameters.ParambyName('@UserID').Value              := fIDUser;

       spAddPreSaleItem.Parameters.ParambyName('@IDComission').Value         := fIDCommis;

       spAddPreSaleItem.Parameters.ParambyName('@Qty').Value                 := fQty;

       spAddPreSaleItem.Parameters.ParambyName('@SalePrice').Value           := fSale;

       spAddPreSaleItem.Parameters.ParambyName('@CostPrice').Value           := fCost;

       spAddPreSaleItem.Parameters.ParambyName('@Discount').Value            := fDiscount;

       spAddPreSaleItem.Parameters.ParambyName('@MovDate').Value             := fMovDate;

       if ( fIDPreInvMovExchange = 0 ) then begin
           spAddPreSaleItem.Parameters.ParambyName('@IDPreInvMovExchange').Value := Null;

       end else begin
                spAddPreSaleItem.Parameters.ParambyName('@IDPreInvMovExchange').Value := fIDPreInvMovExchange;
           end;

       if ( fIDParentPack = 0 ) then begin
           spAddPreSaleItem.Parameters.ParambyName('@PreInvMovParentID').Value := Null;
       end else begin
                spAddPreSaleItem.Parameters.ParambyName('@PreInvMovParentID').Value := fIDParentPack;
           end;

       spAddPreSaleItem.Parameters.ParambyName('@IDDepartment').Value        := fDepartment;

       spAddPreSaleItem.Parameters.ParambyName('@Promo').Value               := fPromo;

       spAddPreSaleItem.Parameters.ParambyName('@IDDescriptionPrice').Value  := fIDDescriptionPrice;

       spAddPreSaleItem.Parameters.ParambyName('@IDVendorPrice').Value       := fIDVendorPrice;

       spAddPreSaleItem.Parameters.ParambyName('@SuggPrice').Value           := fSuggPrice;

       spAddPreSaleItem.Parameters.ParambyName('@DocumentNumber').Value      := fDocumentNumber;

       spAddPreSaleItem.Parameters.ParambyName('@IDDocumentType').Value      := fIDDocumentType;

       spAddPreSaleItem.Parameters.ParambyName('@SequencyNum').Value         := Null;

       spAddPreSaleItem.Parameters.ParambyName('@TotParcial').Value          := Null;

       spAddPreSaleItem.Parameters.ParambyName('@DiscountPromo').Value       := fDiscountPromo;

       // Antonio M F Souza December 10, 2012 - Unit discount
       spAddPreSaleItem.Parameters.ParamByName('@UnitDiscount').Value        := fEachDiscount;

       // Antonio June, 11 2013: to fix issue refund.
       if ( fQty < 0 ) then begin
          spAddPreSaleItem.Parameters.paramByName('@UnitDiscount').value := (-1) * fEachDiscount;
       end;

       // Just to refund movement
       if ( fIDPreInvMov = -1 ) then begin
             spAddPreSaleItem.Parameters.ParamByName('@PreInventMovID').Value := NULL;
       end else begin
                spAddPreSaleItem.Parameters.ParamByName('@PreInventMovID').Value := fIDPreInvMov;
           end;

       if ( not arg_IsManualDiscount ) then begin
             spAddPreSaleItem.Parameters.ParambyName('@ManualDiscount').value      := 0
       end else begin
                spAddPreSaleItem.Parameters.ParambyName('@ManualDiscount').value      := arg_manualDiscount;
           end;


       spAddPreSaleItem.Parameters.ParambyName('@IDSpecialPrice').value      := NULL;

       if ( not arg_IsManualPrice ) then begin
           spAddPreSaleItem.Parameters.ParambyName('@ManualPrice').value         := NULL;
       end else begin
                spAddPreSaleItem.Parameters.ParambyName('@ManualPrice').value         := arg_ManualPrice;
           end;

        //
        _list_param := TStringList.Create();

        _list_param.add(intToStr(fIDHold));
        _list_param.add(',' + intToStr(fIDCustomer));
        _list_param.add(',' + intToStr(fIDModel));
        _list_param.add(',' + IntToStr(fIDStore));
        _list_param.Add(',' + IntToStr(fIDUser));
        _list_param.Add(',' + IntToStr(fIDCommis));
        _list_param.add(',' + FloatToStr(fQty));
        _list_param.Add(',' + FloatToStr(fSale));
        _list_param.Add(',' + FloatToStr(fCost));
        _list_param.add(',' + FloatToStr(fDiscount));
        _list_param.Add(',' + QuotedStr(DateToStr(fMovDate)));
        _list_param.add(',' + BoolToStr(fResetDisc));
        _list_param.add(',' + BoolToStr(fManager));
        _list_param.Add(',' + QuotedStr(DateToStr(fDate)));
        _list_param.add(',' + IntToStr(fIDPreInvMovExchange) );
        _list_param.add(',' + IntToStr(fIDParentPack) );
        _list_param.add(',' + IntToStr(fDepartment));
        _list_param.add(',' + BoolToStr(fPromo));
        _list_param.add(',' + IntToStr(fIDDescriptionPrice));
        _list_param.add(',' + IntToStr(fIDVendorPrice));
        _list_param.add(',' + FloatToStr(fSuggPrice));
        _list_param.add(',' + QuotedStr(fDocumentNumber));
        _list_param.add(',' + IntToStr(fIDDocumentType));
        _list_param.add(',' + 'Null');
        _list_param.add(',' + 'Null');
        _list_param.add(',' + FloatToStr(fDiscountPromo));
        _list_param.add(',' + FloatToStr(fEachDiscount));
        _list_param.add(',' + IntToStr(fIDPreInvMov) );
        _list_param.add(',' + FloatToStr(arg_ManualDiscount));
        _list_param.add(',' + 'Null');
        _list_param.add(',' + FloatToStr(arg_ManualPrice));

       spAddPreSaleItem.Parameters.ParambyName('@Date').Value                := fDate;
       spAddPreSaleItem.Parameters.ParambyName('@ResetDiscount').Value       := fResetDisc;
       spAddPreSaleItem.Parameters.ParambyName('@Manager').Value             := fManager;

//       _list_param.SaveToFile('c:\pinogy\paramsubadditem.txt');
       FreeAndNil(_list_param);


       spAddPreSaleItem.ExecProc;
       fIDPreInvMov := spAddPreSaleItem.Parameters.ParambyName('@PreInventMovID').Value;
       fError       := spAddPreSaleItem.Parameters.ParambyName('@RETURN_VALUE').Value;

//        showMessage(format('PreInventoryMovId %d erro %d ', [fIdPreInvMov, fError]));

       Result := True;
  except
        Result := False;
        fError := -1;
  end;
end;

function TFrmPOSFunctions.DeleteHoldItem(fIDHold, fIDPreInvMov, fIDModel,
                                         fIDUser : Integer; fQty : Double;
                                         fDiscount, fSale : Double;
                                         fResetDisc, fManage, SellBelowCost : Boolean;
                                         fDate:TDateTime;
                                         var fError : Integer):Boolean;
var
   _list_param: TStringList;
begin

  try


      spDeletePreSaleItem.Parameters.ParambyName('@PreSaleID').Value      := fIDHold;

      spDeletePreSaleItem.Parameters.ParambyName('@ModelID').Value        := fIDModel;

      spDeletePreSaleItem.Parameters.ParambyName('@UserID').Value         := fIDUser;

      spDeletePreSaleItem.Parameters.ParambyName('@PreInventMovID').Value := fIDPreInvMov;

      spDeletePreSaleItem.Parameters.ParambyName('@Discount').Value       := fDiscount;

      spDeletePreSaleItem.Parameters.ParambyName('@SalePrice').Value      := fSale;

      spDeletePreSaleItem.Parameters.ParambyName('@Qty').Value            := fQty;

      spDeletePreSaleItem.Parameters.ParambyName('@Date').Value           := fDate;

      spDeletePreSaleItem.Parameters.ParambyName('@ResetDiscount').Value  := fResetDisc;

      spDeletePreSaleItem.Parameters.ParambyName('@Manager').Value        := fManage;

      spDeletePreSaleItem.Parameters.ParambyName('@SellBelowCost').Value  := SellBelowCost;

      // save parameter to debug
     _list_param := TStringList.Create();
     _list_param.Add(intToStr(fIDHold));
     _list_param.add(',' + intToStr(fIDModel));
     _list_param.Add(',' + IntToStr(fIDUser));
     _list_param.add(',' + IntToStr(fIDPreInvMov));
     _list_param.add(',' + FloatToStr(fDiscount));
     _list_param.Add(',' + FloatToStr(fSale));
     _list_param.add(',' + FloatToStr(fQty));
     _list_param.Add(',' + QuotedStr(DateToStr(fDate)));
     _list_param.add(',' + BoolToStr(fResetDisc));
     _list_param.add(',' + BoolToStr(fManage));
     _list_param.add(',' + BoolToStr(SellBelowCost));

//     _list_param.SaveToFile('c:\pinogy\ParamRemoveItem.txt');

      spDeletePreSaleItem.ExecProc;

      fError := spDeletePreSaleItem.Parameters.ParambyName('@RETURN_VALUE').Value;

      Result := (fError = 0);

      FreeAndNil(_list_param);

  except
     Result := False;
     end;

end;

function TFrmPOSFunctions.UpdateHoldItem(fIDHold, fPreInvMovID, fIDModel,
                                         fIDCommis, fIDUSer : Integer; fQty : Double;
                                         fDiscount, fSale, fCost : Double;
                                         fMovDate, fDate : TDateTime;
                                         fResetDisc, fManager : Boolean;
                                         fDepartment: Integer;
                                         var fError, fIDPreInvMov : Integer;
                                         fIDPreSaleParent : Integer = 0;
                                         fPromo : Boolean = False;
                                         fIDDescriptionPrice: Integer = 0;
                                         fIDVendorPrice: Integer = 0;
                                         fSuggPrice: Currency = 0;
                                         fDocumentNumber: String = '';
                                         fIDDocumentType: Integer = 0;
                                         fDiscountPromo: Currency=0;
                                         fIdStore: Integer = 1;
                                         fEachDiscount : Currency = 0):Boolean;
var
   iError: integer;
begin

  try
    with spUpdatePreSaleItem do
    begin
      Parameters.ParambyName('@PreSaleID').Value          := fIDHold;
      Parameters.ParambyName('@PreInventMovID').Value     := fPreInvMovID;
      Parameters.ParambyName('@ModelID').Value            := fIDModel;
      Parameters.ParambyName('@IDComission').Value        := fIDCommis;
      Parameters.ParambyName('@UserID').Value             := fIDUSer;
      Parameters.ParambyName('@Qty').Value                := fQty;
      Parameters.ParambyName('@Discount').Value           := fDiscount;
      Parameters.ParambyName('@SalePrice').Value          := fSale;
      Parameters.ParambyName('@CostPrice').Value          := fCost;
      Parameters.ParambyName('@MovDate').Value            := fMovDate;
      Parameters.ParambyName('@Date').Value               := fDate;
      Parameters.ParambyName('@ResetDiscount').Value      := fResetDisc;
      Parameters.ParambyName('@IDDepartment').Value       := fDepartment;
      Parameters.ParambyName('@Promo').Value              := fPromo;
      Parameters.ParambyName('@Manager').Value            := fManager;
      Parameters.ParambyName('@IDDescriptionPrice').Value := fIDDescriptionPrice;
      Parameters.ParambyName('@IDVendorPrice').Value      := fIDVendorPrice;
      Parameters.ParambyName('@SuggPrice').Value          := fSuggPrice;
      Parameters.ParambyName('@DocumentNumber').Value     := fDocumentNumber;
      Parameters.ParambyName('@IDDocumentType').Value     := fIDDocumentType;
      Parameters.ParambyName('@DiscountPromo').Value      := fDiscountPromo;

      // Antonio M F Souza, April 18, 2013
      if ( (fDiscountPromo > 0) and (fEachDiscount = 0 ) ) then begin
         fEachDiscount := fDiscountPromo;
         Parameters.ParambyName('@DiscountPromo').Value := fEachDiscount * fQty;
      end;

      // Antonio M F Souza, December 10, 2012
      Parameters.ParamByName('@UnitDiscount').Value       := fEachDiscount;

      if fIDPreSaleParent <> 0 then
        Parameters.ParambyName('@PreInvMovParentID').Value := fIDPreSaleParent
      else
        Parameters.ParambyName('@PreInvMovParentID').Value := Null;

      ExecProc;
      fIDPreInvMov := Parameters.ParambyName('@PreInventMovID').Value;
      fError       := Parameters.ParambyName('@RETURN_VALUE').Value;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.RecalcTax(fIDPreSale: Integer; fDate: TDateTime):Boolean;
begin
  try
    with spRecalcTax do
    begin
      Parameters.ParambyName('@PreSaleID').Value := fIDPreSale;
      Parameters.ParambyName('@Date').Value      := fDate;
      ExecProc;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.SetExemptTax(fIDPreSale, fIDMedia: Integer; fDate: TDateTime): Boolean;
begin
  try
    with spSetTaxIsention do
    begin
      Parameters.ParambyName('@IDPreSale').Value := fIDPreSale;
      Parameters.ParambyName('@IDMedia').Value   := fIDMedia;
      Parameters.ParambyName('@Date').Value      := fDate;
      ExecProc;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.ExemptTax(fIDPreSale: Integer; fExempt: Boolean): Boolean;
begin
  try
(*
    if ( fexempt ) then begin
       showmessage('exempt = true')
    end else begin
            showmessage('exempt = false')
        end;
  *)

    with cmdExemptTax do
    begin
      Parameters.ParambyName('IDPreSale').Value := fIDPreSale;
      Parameters.ParambyName('TaxIsent').Value  := fExempt;
      Execute;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.AddSpecialPrice(fIDPreSale, fIDSpecialPrice: Integer;
  fDate: TDateTime; fExemptTax: Boolean): Boolean;
begin
  try
    with spAddSpecialPrice do
    begin
      Parameters.ParambyName('@PreSaleID').Value      := fIDPreSale;
      Parameters.ParambyName('@SpecialPriceID').Value := fIDSpecialPrice;
      Parameters.ParambyName('@Date').Value           := fDate;
      Parameters.ParambyName('@ExemptTax').Value      := fExemptTax;
      ExecProc;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.DeleteSpecialPrice(fIDPreSale : Integer; fDate :TDateTime;
                  fExemptTax:Boolean):Boolean;
begin
  try
    with spDeleteSpecialPrice do
    begin
      Parameters.ParambyName('@PreSaleID').Value := fIDPreSale;
      Parameters.ParambyName('@Date').Value      := fDate;
      Parameters.ParambyName('@ExemptTax').Value := fExemptTax;

      ExecProc;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.ManageDiscount(fIDPreSale: Integer; fDiscountPercent: Double;
  fDate: TDateTime; fExemptTax, fSellBellowCost, fIsPromo: Boolean): Boolean;
begin
  try
    with spManageDiscount do
    begin
      Parameters.ParambyName('@PreSaleID').Value     := fIDPreSale;
      Parameters.ParambyName('@PercDiscount').Value  := fDiscountPercent;
      Parameters.ParambyName('@Date').Value          := fDate;
      Parameters.ParambyName('@ExemptTax').Value     := fExemptTax;
      Parameters.ParambyName('@SellBelowCost').Value := fSellBellowCost;
      Parameters.ParambyName('@IsPromo').Value       := fIsPromo;

      ExecProc;
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.GetMinSaleAndMaxDiscount(fIDPreSale, fIDUser : Integer;
                                               var fMaxMinSale, fMaxDiscount : Double):Boolean;
begin

 try
  with spMaxDiscount do
   begin
     Parameters.ParambyName('@PreSaleID').Value := fIDPreSale;
     Parameters.ParambyName('@UserID').Value    := fIDUser;
     ExecProc;
     fMaxMinSale  := Parameters.ParambyName('@MaxVendaMin').Value;
     fMaxDiscount := Parameters.ParambyName('@MaxDiscount').Value;
   end;
    result := True;
  except
    Result := false;
  end;
end;

function TFrmPOSFunctions.GetSpecialPriceTotal(fIDPreSale:Integer):Double;
begin

  with spCalcFullTotal do
     begin
     Parameters.ParambyName('@IDPreSale').Value := fIDPreSale;
     ExecProc;
     Result := Parameters.ParambyName('@FullTotal').Value;
     end;

end;

function TFrmPOSFunctions.AddInvoiceAdtionalCost(fIDPreSale,
  fIDCostType: Integer; fAmount: Currency): Boolean;
begin

 try
  with spAddInvAdtionalCost do
   begin
     Parameters.ParambyName('@IDPreSale').Value   := fIDPreSale;
     Parameters.ParambyName('@IDCostType').Value  := fIDCostType;
     Parameters.ParambyName('@Amount').Value      := fAmount;
     ExecProc;
   end;
    result := True;
  except
    Result := false;
  end;

end;

function TFrmPOSFunctions.DeleteInvoiceAdtionalCost(
  fIDInvoiceCost: Integer): Boolean;
begin

 try
  with spDeleteInvAdtionalCost do
   begin
     Parameters.ParambyName('@IDInvoiceCost').Value := fIDInvoiceCost;
     ExecProc;
   end;
    result := True;
  except
    Result := false;
  end;

end;

function TFrmPOSFunctions.GetInvoicePayments(IDPreSale: Integer): Currency;
begin
   with quPaymentValue do
      begin
      if Active then
         Close;
      Parameters.ParambyName('IDPreSale').Value := IDPreSale;
      Try
         Open;
         Result := quPaymentValueTotal.AsFloat;
      finally
         Close;
         end;
      end;
end;

function TFrmPOSFunctions.CancelHold(IDPreSale, IDUser: Integer): Boolean;
begin

  Result := True;
  try
    with spPreSaleCancelHold do
       begin
       Parameters.ParamByName('@IDPreSale').Value := IDPreSale;
       Parameters.ParamByName('@IDUser').Value    := IDUser;
       ExecProc;
      end;
  except
    Result := False;
    end;

end;

function TFrmPOSFunctions.DivideHold(IDPreSale, DeliverTypeID: Integer;
                    DeliverDate: TDateTime; DeliverAddress,
                    DeliverOBS: String; var NewIDPreSale: Integer): Boolean;
begin
  Result := False;
  NewIDPreSale := -1;
  try
    with spDivideHold do
    begin
      Parameters.ParambyName('@IDPreSale').Value      := IDPreSale;
      Parameters.ParambyName('@DeliverTypeID').Value  := DeliverTypeID;
      Parameters.ParambyName('@DeliverDate').Value    := DeliverDate;
      Parameters.ParambyName('@DeliverAddress').Value := DeliverAddress;
      Parameters.ParambyName('@DeliverOBS').Value     := DeliverOBS;
      ExecProc;
      Result :=  Parameters.ParambyName('@RETURN_VALUE').Value = 0;
      NewIDPreSale := Parameters.ParambyName('@NewIDPreSale').Value;
    end;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.AddCustomerCredit(fIDPessoa, fIDUser, fIDStore, fIDLancamento : Integer;
  fCreditDate, fExpirationDate: TDateTime; fAmount: Double;
  var fIDCustomerCredit: Integer): Boolean;
begin
  fIDCustomerCredit := -1;
  try
    with spAddCustomerCredit do
    begin
      Parameters.ParamByName('@IDPessoa').Value         := fIDPessoa;
      Parameters.ParamByName('@IDUser').Value           := fIDUser;
      Parameters.ParamByName('@IDStore').Value          := fIDStore;
      Parameters.ParamByName('@CreditDate').Value       := fCreditDate;
      if fExpirationDate = 0 then
        Parameters.ParamByName('@ExpirationDate').Value := Null
      else
        Parameters.ParamByName('@ExpirationDate').Value := fExpirationDate;
      Parameters.ParamByName('@Amount').Value           := fAmount;

      if fIDLancamento = 0 then
        Parameters.ParamByName('@IDLancamento').Value   := Null
      else
        Parameters.ParamByName('@IDLancamento').Value   := fIDLancamento;

      ExecProc;
      Result                                            := Parameters.ParambyName('@RETURN_VALUE').Value = 0;
      if Result then
        fIDCustomerCredit                               := Parameters.ParamByName('@IDCustomerCredit').Value;
    end;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.GetPayType(FIDMeioPag: String): Integer;
begin
   if Trim(FIDMeioPag) = '' then
      Result := -1
   else
      Result := StrToInt(DM.DescCodigo(['IDMeioPag'], [FIDMeioPag], 'MeioPag', 'Tipo'));
end;


function TFrmPOSFunctions.IsNegativeStoreDelivery(
  IDPreSale, IDStore, IDModel: Integer; var AQtyAvaiable: Double): Boolean;
var
  fIDModel : Integer;
  fOnHand,
  fOnPreSale,
  fOnPrePurchase : Double;
begin
  Result := False;
  with quQtyInventoryPreSale do
  try
    Parameters.ParamByName('PreSaleID').Value := IDPreSale;
    Parameters.ParamByName('StoreID').Value   := IDStore;
    if IDModel = 0 then
       Parameters.ParamByName('IDModel').Value   := Null
    else
       Parameters.ParamByName('IDModel').Value   := IDModel;
    Open;
    while not EOF do
    begin
      fOnHand        := FieldByName('QtyOnHand').AsFloat;
      fOnPreSale     := FieldByName('QtyOnPreSale').AsFloat;
      fOnPrePurchase := FieldByName('QtyOnPrePurchase').AsFloat;

      if DM.fSystem.SrvParam[PARAM_INCLUDEPREPURCHASE] then
        fOnHand := fOnHand + fOnPrePurchase;

      AQtyAvaiable := fOnHand;
      if fOnHand <= 0 then
      begin
        Result := True;
        Break;
      end;

      Next;
    end;
  finally
    Close;
  end;
end;

function TFrmPOSFunctions.QtyInDelivered(IDModel, IDStore: Integer; var HasDeliver: Boolean):Double;
var
  fQtyAvailable : Double;
begin
  with quVerifyDeliveryModel do
    begin
    If Active then
       Close;
    Parameters.ParamByName('IDModel').Value := IDModel;
    Parameters.ParamByName('IDStore').Value := IDStore;
    Open;
    HasDeliver    := not (quVerifyDeliveryModelOnHand.IsNull);
    fQtyAvailable := quVerifyDeliveryModelOnHand.AsFloat;
    if DM.fSystem.SrvParam[PARAM_INCLUDEPREPURCHASE] then
       fQtyAvailable := fQtyAvailable + quVerifyDeliveryModelInPurchasing.AsFloat;
    Result := (fQtyAvailable - quVerifyDeliveryModelQty.AsFloat);
    Close;
    end;
end;

function TFrmPOSFunctions.GetCustomerDeliverOpenHold(
  IDCustomer, IDPreSale: Integer): String;
begin
  Result := '';
  with quDeliverOpenHolds do
    begin
    Parameters.ParamByName('IDCustomer').Value := IDCustomer;
    Parameters.ParamByName('IDPreSale').Value  := IDPreSale;
    Try
      Open;
      First;
      While not EOF do
        begin
        Result := Result + quDeliverOpenHoldsSaleCode.AsString;
        Next;
        if not EOF then
           Result := Result + ', ';
        end;
    Finally
      Close;
      end;
    end;
end;

function TFrmPOSFunctions.HasPaymentPending(IDPreSale: Integer): Boolean;
begin
   with quHasPendingPayment do
     begin
     if Active then
        Close;
     Parameters.ParamByName('IDPreSale').Value := IDPreSale;
     Open;
     Result := (RecordCount>0);
     Close;
     end;
end;

function TFrmPOSFunctions.CreateSaleCode(IDPreSale, IDPreSaleParent, IDStore: Integer):String;
begin
  DM.FTraceControl.TraceIn('TFrmPOSFunctions.CreateSaleCode');

  try
    with spNewSaleCode do
      begin
      if IDPreSaleParent = 0 then
         Parameters.ParambyName('@IDPreSaleParent').Value := Null
      else
         Parameters.ParambyName('@IDPreSaleParent').Value := IDPreSaleParent;

      Parameters.ParambyName('@IDStore').Value := IDStore;
      ExecProc;
      Result := Parameters.ParambyName('@SaleCode').Value;
      end;

      DM.RunSQL('UPDATE Invoice SET SaleCode = '+QuotedStr(Result)+' WHERE IDPreSale = ' + IntToStr(IDPreSale));
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmPOSFunctions');
  end;

  DM.FTraceControl.TraceOut;
end;

function TFrmPOSFunctions.AddItemCommission(IDInventoryMov,IDPreInventoryMov:String;
  IDPessoa: Integer; Percent: Real): Boolean;
var  iID : Integer;
begin
  iID := DM.GetNextID('SaleItemCommission.IDSaleItemCommission');
  DM.RunSQL('INSERT SaleItemCommission (IDSaleItemCommission,IDInventoryMov,IDPreInventoryMov, IDCommission, CommissionPercent) ' +
            'VALUES ('+intToStr(iID) + ', ' + IDInventoryMov + ', ' + IDPreInventoryMov + ', ' + IntToStr(IDPessoa) + ', ' + FloattoStr(Percent) + ')');
end;

procedure TFrmPOSFunctions.ClearCommissionList;
begin
  if Assigned(fCommisList) and (fCommisList.Count > 0) then
     fCommisList.Clear;
end;

procedure TFrmPOSFunctions.AddSaleItemCommission(ID, PreSaleType :Integer);
var
  i: Integer;
begin
  case PreSaleType of
    SALE_INVOICE:
    begin
      DM.RunSQL('DELETE FROM SaleItemCommission WHERE IDInventoryMov = ' + InttoStr(ID) );

      for i := 0 to fCommisList.Count - 1 do
        AddItemCommission(InttoStr(ID),
                          'NULL',
                          TSalesPerson(fCommisList.Objects[I]).IDPessoa,
                          TSalesPerson(fCommisList.Objects[I]).Percent);
    end

    else
      AddPreSaleItemCommission(ID, fCommisList);
  end;
end;

procedure TFrmPOSFunctions.AddPreSaleItemCommission(ID :Integer; DefaultSalesPerson : TStringList);
var
  i: Integer;
begin
  DM.RunSQL('DELETE FROM SaleItemCommission WHERE IDPreInventoryMov = ' + InttoStr(ID) );

  for i := 0 to DefaultSalesPerson.Count - 1 do
    AddItemCommission('NULL',
                      InttoStr(ID),
                      TSalesPerson(DefaultSalesPerson.Objects[I]).IDPessoa,
                      TSalesPerson(DefaultSalesPerson.Objects[I]).Percent);
end;

procedure TFrmPOSFunctions.AddCommissionsList(ID,PreSaleType :Integer);
var
  SalesPerson: TSalesPerson;
  sWhere, sOldSQL: String;
begin
  with quSalesPerson do
  begin
    if Active then
      Close;
    sOldSQL := CommandText;

    case PreSaleType of
      SALE_INVOICE : sWhere := 'IDInventoryMov =' +InttoStr(ID)
      else
        sWhere := 'IDPreInventoryMov =' +InttoStr(ID);
    end;

    CommandText := ChangeWhereClause(CommandText, sWhere, True);

    Open;
    First;

    while not EOF do
    begin
      SalesPerson := TSalesPerson.Create;
      SalesPerson.IDPessoa := quSalesPersonIDPessoa.AsInteger;
      SalesPerson.Pessoa   := quSalesPersonPessoa.AsString;
      SalesPerson.Percent  := quSalesPersonCommissionPercent.AsFloat;
      DM.fPOS.fCommisList.AddObject(SalesPerson.Pessoa + ' - ' + FloattoStr(SalesPerson.Percent) + '%',SalesPerson);
      Next;
    end;

    Close;
    CommandText := ChangeWhereClause(sOldSQL, '', True);
  end;
end;

procedure TFrmPOSFunctions.ApplyCustomerItemDiscount(AIDPreSale, AIDCustomer,
  AIDPreInventoryMov: Integer; ADate: TDateTime);
begin
  with spApplyCustItemDiscount do
  begin
    Parameters.ParamByName('@IDPreSale').Value         := AIDPreSale;
    Parameters.ParamByName('@IDCustomer').Value        := AIDCustomer;
    Parameters.ParamByName('@IDPreInventoryMov').Value := AIDPreInventoryMov;
    Parameters.ParamByName('@Date').Value              := ADate;
    ExecProc;
  end;
end;

procedure TFrmPOSFunctions.ApplyCustomerDiscount(AIDPreSale,
  AIDCustomer: Integer; ADate: TDateTime);
begin
  with spApplyCustomerDiscount do
  begin
    Parameters.ParamByName('@IDPreSale').Value  := AIDPreSale;
    Parameters.ParamByName('@IDCustomer').Value := AIDCustomer;
    Parameters.ParamByName('@Date').Value       := ADate;
    ExecProc;
  end;
end;

function TFrmPOSFunctions.CalcCustomerDiscount(AIDCustomer,
  AIDModel: Integer; AQty, ASalePrice: Double): Currency;
begin
  with spCalcCustomerDiscount do
  begin
    Parameters.ParamByName('@IDCustomer').Value := AIDCustomer;
    Parameters.ParamByName('@IDModel').Value := AIDModel;
    Parameters.ParamByName('@Qty').Value := AQty;
    Parameters.ParamByName('@SalePrice').Value := ASalePrice;
    Parameters.ParamByName('@Discount').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@Discount').Value;
  end;
end;

procedure TFrmPOSFunctions.ClearDefaultSalesPerson;
begin
  if Assigned(fDefaultSalesPerson) and (fDefaultSalesPerson.Count > 0) then
    fDefaultSalesPerson.Clear;
end;

function TFrmPOSFunctions.AddCash(fIDCashRegMov, fIDUser: Integer;
  fCash: Currency; fDate: TDateTime; fIDReason: Integer; fOBS: String;
  var fIDCashRegLog: Integer): Boolean;
begin
  try
    with spCashAddPayment do
       begin
       Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
       Parameters.ParamByName('@IDUser').Value       := fIDUser;
       Parameters.ParamByName('@TotalCash').Value    := fCash;
       Parameters.ParamByName('@Date').Value         := fDate;
       Parameters.ParamByName('@IDReason').Value     := fIDReason;
       Parameters.ParamByName('@COO').Value          := 0;
       Parameters.ParamByName('@GNF').Value          := 0;
       
       if Trim(fOBS) <> '' then
         Parameters.ParamByName('@OBS').Value         := fOBS
       else
         Parameters.ParamByName('@OBS').Value         := NULL;
       ExecProc;
       fIDCashRegLog := Parameters.ParamByName('@IDCashRegLog').Value;
       //fIDCashRegLog := Parameters.ParamByName('@RETURN_VALUE').Value;
       end;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.ImportEstimated(IDEstimated, IDMedia, IDStore,
  IDUser: Integer; TaxIsent, UpdateSalePrice: Boolean): Integer;
begin

  with spImporEstimated do
  try
    Parameters.ParamByName('@IDEstimated').Value     := IDEstimated;
    Parameters.ParamByName('@TaxIsent').Value        := TaxIsent;
    Parameters.ParamByName('@MediaID').Value         := IDMedia;
    Parameters.ParamByName('@IDStore').Value         := IDStore;
    Parameters.ParamByName('@IDUser').Value          := IDUser;
    Parameters.ParamByName('@UpdateSalePrice').Value := UpdateSalePrice;
    ExecProc;
    Result := Parameters.ParamByName('@NewIDPreSale').Value;

    if DM.fSystem.SrvParam[PARAM_SALECODE_ON_CREATE_SALE] then
      CreateSaleCode(Result, 0, IDStore);

  except
    raise;
    Result := -1;
  end;

end;

function TFrmPOSFunctions.CanMarkDelivery(AIDPreSale, AIDModel: Integer;
  APreSaleDate: TDateTime; AQtyAvaiable, AQtyActual: Double): Boolean;
var
  Balance : Double;
begin

  Result := False;

  with quValidateDelivery do
  try
    Parameters.ParamByName('IDModel').Value   := AIDModel;
    Parameters.ParamByName('MovDate').Value   := APreSaleDate;
    Parameters.ParamByName('IDPreSale').Value := AIDPreSale;
    Open;
    Balance := (AQtyAvaiable - quValidateDeliveryQty.AsFloat);
    if Balance <= 0 then
      Result := False
    else if (Balance - AQtyActual) >= 0 then
      Result := True;

  finally
    Close;
  end;
end;



function TFrmPOSFunctions.IsThereSameConditionsToSale(var APreInvQtyCurrent: double; var AIdPreInvMov: integer; var OutQtyPreSale: double; var OutDiscount: double;
                                                      AIdStore, AIdModel, ADocumentID, AIdComission: integer;
                                                      ASalePrice, ADiscount: double;
                                                      AInsert: boolean; AManager: boolean;
                                                      pPromoDiscount: double; eachDiscount: double): boolean;
var
  qry: TADOQuery;
  sql: String;
  savePreInvQtyCurrent: double;
  NewDiscount: double;
  DiscountToCondition: double;
  i: integer;
begin
  try
     qry := TADOQuery.Create(nil);
     qry.Connection := DM.ADODBConnect;

    DiscountToCondition := 0;
    savePreInvQtyCurrent := APreInvQtyCurrent;

    if ( APreInvQtyCurrent > 0 ) then
       DiscountToCondition  := ( ADiscount / APreInvQtyCurrent )
    else
       DiscountToCondition := Adiscount; // under test

     (* I not sure yet but according to test if AManager is true some discount was applied. *)
     if ( not AManager ) then begin
        //Antonio M F Souza 05.11.2011 - get discounts
        sql := 'SELECT IsNull( Sum( IsNull(PIM.Discount,0) ), 0) NewDiscount '+
               'FROM                                             '+
               'dbo.PreInventoryMov PIM (NOLOCK)                 '+
               'WHERE                                            '+
               'PIM.DocumentID = :DocumentNumber                 '+
               'AND                                              '+
               'PIM.InventMovTypeID = 1                          '+
               'and PIM.ModelID = :modelID                       ';

        qry.SQL.Text   := sql;
        qry.Parameters.ParamByName('DocumentNumber').Value     := ADocumentId;
        qry.Parameters.ParamByName('modelID').value            := AIdModel;
        qry.Open;

        NewDiscount := qry.FieldByName('NewDiscount').Value;

        if ( ADiscount = 0 ) then
           DiscountToCondition := NewDiscount
        else
           DiscountToCondition := DiscountToCondition + NewDiscount;
     end;

    //Antonio M F Souza 10.20.2010: Verify if there are sale items that matches with conditions. So, items must be added to quantity group by conditions.
    sql := 'select sum(isnull(pim.qty, 0)) currentQty ' +
           '       ,pim.IdPreInventoryMov                ' +
           '       ,pim.discount ' +
           '       ,pim.documentID ' +
           'from PreInventoryMov pim join SaleItemCommission sic on pim.IdPreInventoryMov = sic.IdPreInventoryMov ' +
           'where ModelId = :modelId ' +
           '  and sic.IdCommission = :idcomission ';// Antonio M F Souza August 29, 2012 +

           fCdsPriceBreak.Filter := 'IdModel = ' + intToStr(AIdModel);
           fCdsPriceBreak.Filtered := true;

           if ( fCdsPriceBreak.RecordCount = 0 ) then
              sql := sql +
              '  and pim.SalePrice = :saleprice ';

           sql := sql +

//           '  and Discount = :discount ' +
           '  and StoreId = :storeid ' +
           '  and DocumentId = :documentid ' +
           '  and pim.InventMovTypeID = 1 ' +
           'group by pim.StoreId ' +
           '        ,pim.ModelId '; // Antonio M F Souza August 29, 2012  +

           if ( fCdsPriceBreak.RecordCount = 0 ) then
              sql := sql +
                     '        ,pim.SalePrice ';

           sql := sql +
           '        ,pim.Discount ' +
           '        ,sic.IdCommission ' +
           '        ,pim.IdPreInventoryMov ' +
           '        ,pim.DocumentId ';

    qry.SQL.Text   := sql;

    qry.Parameters.ParamByName('modelId').Value     := AIdModel;
    qry.Parameters.ParamByName('idcomission').Value := AIdComission;

    if ( fCdsPriceBreak.RecordCount = 0 ) then
       qry.Parameters.ParamByName('saleprice').Value   := ASaleprice;

  //  qry.Parameters.ParamByName('discount').Value   := DiscountToCondition;
    qry.Parameters.ParamByName('storeid').Value    := AIdStore;
    qry.Parameters.ParamByName('documentid').Value     := ADocumentId;
    qry.Open;

    while ( not qry.Eof ) do begin
      if ( qry.fieldByName('currentqty').isNull ) then begin
         result := false;
         break;
      end
      else begin
         result := true;
         if ( (APreInvQtyCurrent > 0) and (qry.fieldByName('currentQty').Value < 0) ) then
                result := false
         else if ( (APreInvQtyCurrent < 0) and (qry.FieldByName('currentQty').Value > 0)) then
             result := false;

         //Antonio M F Souza 02.04.2011 - I need sum quantity when insert an item.
         if ( result ) then begin
            if ( AInsert ) then begin
               if ( qry.FieldByName('discount').Value / qry.FieldByName('currentQty').Value = eachDiscount ) then begin
                   APreInvQtyCurrent := APreInvQtyCurrent + qry.FieldByName('currentQty').Value;
                   AIdPreInvMov      := qry.fieldByName('IdPreInventoryMov').value;
                   OutDiscount       := qry.FieldByName('discount').Value;
                   OutQtyPreSale     := qry.FieldByName('currentQty').Value;
                   break;
               end
(*
               else if ( qry.FieldByName('discount').Value = DiscountToCondition ) then begin
                   APreInvQtyCurrent := APreInvQtyCurrent + qry.FieldByName('currentQty').Value;
                   AIdPreInvMov      := qry.fieldByName('IdPreInventoryMov').value;
                   OutDiscount       := qry.FieldByName('discount').Value;
                   OutQtyPreSale     := qry.FieldByName('currentQty').Value;
                   break;
               end

*)               else begin
                   APreInvQtyCurrent := APreInvQtyCurrent + qry.FieldByName('currentQty').Value;
                   AIdPreInvMov      := qry.fieldByName('IdPreInventoryMov').value;
                   OutDiscount       := qry.FieldByName('discount').Value;
                   OutQtyPreSale     := qry.FieldByName('currentQty').Value;
                   result := false;
                   break;
               end;
            end
            else begin //case update an item I need save quantity typed.
               APreInvQtyCurrent := savePreInvQtyCurrent;
               AIdPreInvMov      := qry.fieldByName('IdPreInventoryMov').value;
               result := false;
            end;
         end;
      end;
      qry.Next;
    end;

  finally
    freeAndNil(qry);
  end;
end;

procedure TFrmPOSFunctions.UpdateQtyPreInventory(
  ATotalQtyPreInventory: double; AIdStore, AIdModel, ADocumentID,
  AIdComission: integer; ASalePrice, ADiscount: double);
var
  sql: String;
  qryUpd: TADOQuery;
begin
  try
     qryUpd := TADOQuery.Create(nil);
     qryUpd.Connection := dm.ADODBConnect;

     sql := 'update PreInventoryMov ' +
            'set qty = qty + :qtycurrent ' +
            'where StoreID = :storeid ' +
            '  and ModelID = :modelid ' +
            '  and DocumentID = :documentid ' +
            '  and SalePrice  = :saleprice ' +
            '  and Discount = :discount ' +
            '  and :idcomission in (select sic.IDCommission from PreInventoryMov pim join SaleItemCommission sic on pim.IDPreInventoryMov = sic.IDPreInventoryMov) ';
     qryUpd.SQL.Text := sql;
     qryUpd.Parameters.ParamByName('qtycurrent').Value  := ATotalQtyPreInventory;
     qryUpd.Parameters.ParamByName('storeid').Value     := AIdStore;
     qryUpd.Parameters.ParamByName('modelid').Value     := AIdModel;
     qryUpd.Parameters.ParamByName('documentid').Value  := ADocumentID;
     qryUpd.Parameters.ParamByName('saleprice').Value   := ASalePrice;
     qryUpd.Parameters.ParamByName('discount').Value    := ADiscount;
     qryUpd.Parameters.ParamByName('idcomission').Value := AIdComission;

     qryUpd.ExecSQL;

  finally
     freeAndNil(qryUpd);
  end;

end;

function TFrmPOSFunctions.canDeleteInDetail(AIdStore, AIdModel, AIdPreSale, AIdCommission: integer; ASalePrice: double): boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   result := false;

   sql := 'select pim.IdPreInventoryMov ,pim.discount ' +
          ' ,pim.documentID from PreInventoryMov pim  '+
          'join SaleItemCommission sic on pim.IdPreInventoryMov = sic.IdPreInventoryMov '+
          'join Invoice I on pim.DocumentId = I.IdPreSale ' +
          ' where ModelId = :modelid and sic.IdCommission = :idcommission ' +
          ' and pim.SalePrice = :saleprice and StoreId = :storeid ' +
          ' and pim.InventMovTypeID = 1 and pim.DocumentId = :documentId' +
          ' group by pim.StoreId         ,pim.ModelId         ,pim.SalePrice '+
          '  ,pim.Discount, sic.IdCommission, pim.IdPreInventoryMov ,pim.DocumentId ';
     try
        qry := TADOQuery.Create(nil);
        qry.Connection := dm.ADODBConnect;
        qry.SQL.Text := sql;

        qry.Parameters.ParamByName('modelId').Value     := AIdModel;
        qry.Parameters.ParamByName('idcommission').Value := AIdCommission;
        qry.Parameters.ParamByName('saleprice').Value   := ASaleprice;
        qry.Parameters.ParamByName('storeid').Value    := AIdStore;
        qry.Parameters.ParamByName('documentid').Value     := AIdPresale;
        qry.Open;

        result := ( qry.RecordCount > 1 );

     finally
        freeAndNil(qry);
     end;
end;

function TFrmPOSFunctions.getQtyInCashRegisterToModel(aIdPreSale, aIdModel: Integer; pSaveQtyEdited: Double = 0): Double;
var
  sp: TADOStoredProc;
  totQtyInSale: double;
begin
  totQtyInSale := 0;
  result := 0;
  sp := TADOStoredProc.Create(nil);
  sp.Connection := dm.ADODBConnect;
  sp.ProcedureName := 'dbo.sp_PreSale_quPreSaleItem';

  sp.Parameters.Clear;
  sp.Parameters.CreateParameter('@DocumentID', ftInteger, pdInput, 0, aIdPreSale);
  sp.Parameters.CreateParameter('@IsPreSale', ftBoolean, pdInput, 0, true);
  sp.Parameters.CreateParameter('@Date', ftDateTime, pdInput, 0, now);

  sp.Parameters.ParamByName('@DocumentID').Value := aIdPreSale;
  sp.Parameters.ParamByName('@IsPreSale').Value  := true;
  sp.Parameters.ParamByName('@Date').Value       := now;

  sp.Open;

  sp.Filter  := 'ModelID = ' + intToStr(aIdModel);
  sp.Filtered := true;

  while ( not sp.Eof ) do begin
     totQtyInsale := totQtyInSale + sp.fieldByName('qty').Value;
     sp.Next;
  end;

 {
  // Antonio M F Souza under test
  if ( sp.RecordCount >  1 ) then begin
     if ( pSaveQtyEdited > 0 ) then // qty was edited by screen
        totQtyInSale := totQtyInSale - pSaveQtyEdited;

  end;
  }

  result := totQtyInSale;

  freeAndNil(sp);

end;

procedure TFrmPOSFunctions.FormCreate(Sender: TObject);
begin
   FCdsPriceBreak := TClientDataSet.Create(self);
   FCdsPriceBreak.FieldDefs.add('IdModel', ftInteger, 0, false);
   fCdsPriceBreak.FieldDefs.Add('PriceBreak', ftCurrency);
   fcdsPriceBreak.FieldDefs.Add('IsPriceBroke', ftBoolean, 0, false);

   //Antonio M F Souza september 07, 2012 - to know if there was item free to this model due promo.
   fCdsPriceBreak.FieldDefs.Add('FoundItemFree', ftBoolean, 0, false);
   fCdsPriceBreak.FieldDefs.Add('QtyToItemFree', ftInteger, 0, false);
   fCdsPriceBreak.FieldDefs.Add('IdPreinventoryItemFree', ftBoolean, 0, false);
   fCdsPriceBreak.CreateDataSet;
end;

procedure TFrmPOSFunctions.FormDestroy(Sender: TObject);
begin
   freeAndNil(fcdsPriceBreak);
end;

function TFrmPOSFunctions.getItemPreSaleDetail(aIdPreSale: Integer): TADOStoredProc;
var
  sp: TADOStoredProc;
  totQtyInSale: Integer;
begin
  totQtyInSale := 0;
  result := nil;
  sp := TADOStoredProc.Create(nil);
  sp.Connection := dm.ADODBConnect;
  sp.ProcedureName := 'dbo.sp_PreSale_quPreSaleItem';

  sp.Parameters.Clear;
  sp.Parameters.CreateParameter('@DocumentID', ftInteger, pdInput, 0, aIdPreSale);
  sp.Parameters.CreateParameter('@IsPreSale', ftBoolean, pdInput, 0, true);
  sp.Parameters.CreateParameter('@Date', ftDateTime, pdInput, 0, now);

  sp.Parameters.ParamByName('@DocumentID').Value := aIdPreSale;
  sp.Parameters.ParamByName('@IsPreSale').Value  := true;
  sp.Parameters.ParamByName('@Date').Value       := now;

  sp.Open;
  result := sp;
end;

function TFrmPOSFunctions.ApplySalePriceBroke(aInventoryMovId: Integer; aDiscount, aSalePrice: Currency): boolean;
var
  sql: String;
  qry: TADOQuery;
begin
  qry := TADOQuery.Create(nil);
  qry.Connection := dm.ADODBConnect;
  sql := 'update PreInventoryMov set Discount =:discount, SalePrice =:saleprice, discountpromo =:discpromo where IdPreInventoryMov =:idpreinvmov';
  qry.SQL.Text := sql;

  qry.Parameters.ParamByName('saleprice').Value := aSalePrice;
  qry.Parameters.ParamByName('discount').Value  := aDiscount;
  qry.Parameters.ParamByName('discpromo').Value := ADiscount;
  qry.Parameters.ParamByName('idpreinvmov').Value := aInventoryMovId;

  qry.ExecSQL;
  freeAndNil(qry);
end;

function TFrmPOSFunctions.getSellingPriceFromModel(
  pIdModel: Integer): Currency;
var
  qry: TADOQuery;
begin
  qry := TADOQuery.Create(nil);
  qry.Connection := dm.ADODBConnect;

  qry.sql.Add('select SellingPrice from Model where IdModel =:idmodel');
  qry.Parameters.ParamByName('idmodel').Value := pIdModel;
  qry.Open;

  result := 0;

  if ( not qry.fieldByName('SellingPrice').isNull ) then
     result := qry.fieldByname('SellingPrice').Value;
  freeAndNil(qry);

end;

function TFrmPOSFunctions.preInventoryMovIsEmpty(pIdPreInvMov: Integer): Boolean;
var
  qry: TADOQuery;
begin
  try
      result := false;
      qry := TADOQuery.create(nil);
      qry.Connection := dm.ADODBConnect;
      qry.SQL.Add('select IdPreinventoryMov from PreInventoryMov');
      qry.sql.add('where IdPreinventoryMov =:id');
      qry.Parameters.ParamByName('id').value := pIdPreInvMov;
      qry.open;
      result := qry.IsEmpty;
  finally
      freeAndnil(qry);
  end;



end;

function TFrmPOSFunctions.getQtyAfterEditScreen(pIdInvMov, pIdModel : Integer): Integer;
var
  qry: TADOQuery;
begin
  try
     result := 0;
     qry := TADOQuery.Create(nil);
     qry.Connection := dm.ADODBConnect;
     qry.SQL.Add('select qty from PreInventoryMov where IdPreInventoryMov =:id');
     qry.Parameters.ParamByName('id').Value := pIdInvMov;
     qry.Open;
     if ( not qry.IsEmpty ) then
        result := qry.fieldByname('qty').value;
  finally
     freeAndNil(qry);
  end;

end;

function TFrmPOSFunctions.getCurrentIdPreinventoryMov: Integer;
var
   qry: TADOQuery;
begin
   try
     result := -1;
     qry := TADOQuery.Create(nil);
     qry.Connection := dm.ADODBConnect;
     qry.sql.Add('select max(IdPreinventoryMov) IdPreinventoryMov from PreinventoryMov');
     qry.open;
     if ( not qry.IsEmpty ) then
        result := qry.fieldByName('IdPreinventoryMov').Value;
   finally
     freeAndNil(qry);
   end;

end;

function TFrmPOSFunctions.getSaleItemCommision(pIdPreinvMov: Integer): TADOQuery;
var
  qry: TADOQuery;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := dm.ADODBConnect;
    qry.sql.add('select IdCommission, CommissionPercent from SaleItemCommission');
    qry.sql.add('where IdPreinventoryMov =:id');
    qry.Parameters.ParamByName('id').value := pIdPreinvMov;
    qry.Open;
    result := qry;
  finally
//    freeAndNil(qry);
  end;
end;

function TFrmPOSFunctions.canUpdatePriceOnEdit(arg_idModel: Integer): Boolean;
var
   canUpdate: Boolean;
begin
   canUpdate := not isUnitPriceInInventorySetToZero(arg_idmodel);
   canUpdate := canUpdate and (not isAskSalePriceEnable(arg_idmodel));
   canUpdate := canUpdate and fPriceBreakIsCrossed;

   result := canUpdate;

end;

function TFrmPOSFunctions.isAskSalePriceEnable(arg_idmodel: Integer): Boolean;
var
   cdsModel: TClientDataset;
begin
   try
     cdsModel := dm.searchModel(arg_idmodel);
     result := cdsModel.fieldByName('CustomSalePrice').AsBoolean;
   finally
     freeAndNil(cdsModel);
   end;
end;

function TFrmPOSFunctions.isUnitPriceInInventorySetToZero(arg_idmodel: Integer): Boolean;
var
  cdsInventory: TClientDataset;
begin
  try
     cdsInventory := dm.searchInventory(arg_idmodel);
     result := ( cdsInventory.fieldByName('SellingPrice').Value > 0 );
  finally
     freeAndNil(cdsInventory);
  end;

end;

function TFrmPOSFunctions.resetDiscount(arg_IdPreInventoryMov: Integer): Boolean;
var
  sp: TADOStoredProc;
begin
  try
    sp := TADOStoredProc.Create(nil);
    sp.Connection := dm.ADODBConnect;
    sp.ProcedureName := 'sp_PreSale_DelManualDiscount';
    sp.Parameters.Refresh();
    sp.Parameters.paramByName('@IDPreInventoryMov').Value := arg_IdPreInventoryMov;

    sp.ExecProc;

    setDiscountToZero(arg_idpreinventoryMov);
    result := true;
  except
    on e: Exception do begin
      raise Exception.Create('Stored proc. error: '+e.Message);
      result := false;
    end;
  end;

end;

function TFrmPOSFunctions.resetManualPrice(arg_IdPreInventoryMov: Integer): Boolean;
var
  sp: TADOStoredProc;
begin
  try
    sp := TADOStoredProc.Create(nil);
    sp.Connection := dm.ADODBConnect;
    sp.ProcedureName := 'sp_PreSale_DelManualPrice';
    sp.Parameters.Refresh();
    sp.Parameters.ParamByName('@IDPreInventoryMov').value := arg_IdPreInventoryMov;

    sp.ExecProc;
    result := true;
  except
    on e: Exception do begin
      raise Exception.Create('Stored proc. error: '+e.Message);
      result := false;
    end;
  end;
end;

procedure TFrmPOSFunctions.setDiscountToZero(arg_idpreinvmov: Integer);
var
  update: TADOQuery;
begin
  try
     try
        update := TADOQuery.Create(nil);
        update.Connection := dm.ADODBConnect;
        update.SQL.Add('update PreInventoryMov set unitdiscount = 0, discount = 0 where IdPreinventoryMov = :param_idpreinventorymov');
        update.Parameters.ParamByName('param_idpreinventorymov').Value := arg_idpreinvmov;
        update.ExecSQL();
     except on e:Exception do
        raise;// exception.create('Cannot reset discount: ' + e.message);
     end;
  finally
     freeAndNil(update);
  end;
end;

end.
