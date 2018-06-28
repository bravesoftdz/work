unit uFrmPOSFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls, uSystemConst, DBClient, Provider,
  uPreSale, uFilePersistence;

const
  CUPOM_VAZIO = 'XXXXXX';

type
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
    spCreateHold: TADOStoredProc;
    spCancelInvoice: TADOStoredProc;
    spNewSaleCode: TADOStoredProc;
    quInvoiceCanceled: TADODataSet;
    quInvoiceCanceledCupomFiscal: TStringField;
    quInvoiceCanceledCanceled: TBooleanField;
    spquQuantityQtyOnPreSale: TFloatField;
    spquQuantityQtyOnHand: TFloatField;
    spquQuantityQtyOnOrder: TFloatField;
    spquQuantityQtyOnRepair: TFloatField;
    spquQuantityQtyOnPrePurchase: TFloatField;
    spquQuantityFloatPercent: TIntegerField;
    spquKitPriceQty: TFloatField;
    quTestOpenHold: TADOQuery;
    quTestOpenHoldnOpenUser: TIntegerField;
    quTestOpenHoldnOpenHoldCaixa: TIntegerField;
    cmdAddDeletedItem: TADOCommand;
    cmdInsertReducaoZ: TADOCommand;
    cmdInsertTributacaoECF: TADOCommand;
    quTestReducaoZ: TADOQuery;
    spAddCash: TADOStoredProc;
    cmdAddPessoa: TADOCommand;
    quGetCustomer: TADOQuery;
    cmdInvoiceDiscount: TADOCommand;
    cmdInsertSerial: TADOCommand;
    cmdInsertObs: TADOCommand;
    quPreSaleTotal: TADODataSet;
    quPreSaleTotalPreSaleTotal: TBCDField;
    cmdInsertNotaCancel: TADOCommand;
    quPreSaleItemCanceled: TADODataSet;
    cmdInsertLancComplement: TADOCommand;
    cmdInsertTotalizadorParcial: TADOCommand;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure GravaDadosTipo60Diario(IDInvoice: Integer);

  public
    //Usado para caixa reg fiscal, para manter a numracao depois que o item for deletado
    InvoiceItem : TStringList;
    //CashRegister functions
    function OpenCashRegister(f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fIDCashReg, fIDUser : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fDate : TDateTime; fCOO, fGNF : Integer;
                              var fIDCashRegMov, fIDCashRegLog : Integer):Boolean;
   function CloseCashRegister(fIDCashRegMov, fIDUser : Integer;
                              f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              var fIDCashRegLog, fError : Integer):Boolean;
  function WithdrawCashRegister(fIDCashRegMov, fIDUser : Integer;
                              f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              fOBS: String; fIDReason, fCOO, fGNF: Integer):Boolean;

   procedure GetCashRegisterResidual(fIDCashRegMov:Integer;
                                     var fIDOpenUser : Integer;
                                     var fResidual   : Double);
   procedure GetCashRegisterInfo(fIDCashReg : Integer;
                                 var fCashRegName, fOpenUser : String;
                                 var fStatus : Integer;
                                 var fOpenDate : TDateTime);
   function TestRefresh:Integer;
   function GetTotalCashReceived(fIDCashRegMov:Integer):Double;
   function GetTotalCashWithdraw(fIDCashRegMov:Integer):Currency;
   function AddPettyCash(fIDCashRegMov, fIDUser:Integer;
                         fCash : Currency;
                         fDate : TDateTime;
                         fOBS: String):Boolean;
   function AddAddCash(fIDCashRegMov, fIDUser:Integer;
                         fCash : Currency;
                         fDate : TDateTime;
                         fOBS: String;
                         fCOO, fGNF : Integer):Boolean;
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
                       fIDCashRegMov, fIDStore: Integer;
                       fDate, fPayDate: TDateTime;
                       fCashReceived: Double;
                       fBonusBucks: Currency;
                       fInvoiceCode : String;
                       var fIDInvoice: Integer;
                       var fParamError: String): Boolean;
   //Invoice functions
   function CreateHold(fDeliverType : Integer;
            fIsLayaway : Boolean; fIDStore : Integer;
            fFName, fLName, fZip : String;
            fIDTourGroup : Integer; fPreSaleDate : TDateTime;
            fIDCustomer, fIDMedia, fIDOtherComm : Integer;
            InvObs, CustomerDoc:String; var fIDPreSale: Integer):Boolean;
   function DeleteHold(fIDCashRegMov, fIDUser: Integer; APreSale: TPreSale):Boolean;
   procedure GetQty(fIDModel, fIDStore : Integer;
                    var OnHand, OnPreSale, OnPrePurchase : Double);
   function GetKitPrice(fIDModel : Integer; fQty : Double; fSellingPrice:Currency;
                        var fIsEmpty:Boolean):Currency;
   function AddHoldItem(fIDCustomer, fIDHold, fIDModel, fIDStore: Integer; fQty: Double;
                        fDiscount, fSale, fCost: Double;
                        fIDUser, fIDCommis, fIDDepartment: Integer;
                        fMovDate, fDate: TDateTime;
                        fResetDisc, fManager: Boolean;
                        var fError, fIDPreInvMov: Integer;
                        fPreInvMovParentID: Integer = 0;
                        fPromo: Boolean = False;
                        fIDDescriptionPrice: Integer = 0;
                        fIDVendorPrice: Integer = 0;
                        fSuggPrice: Currency = 0;
                        fDocumentNumber: String = '';
                        fIDDocumentType: Integer = 0;
                        fSeqNum : Integer = 0; fTotParcial : String = ''): Boolean;
   function DeleteHoldItem(fIDHold, fIDPreInvMov, fIDModel,
                           fIDUser : Integer; fQty : Double;
                           fDiscount, fSale : Double;
                           fResetDisc, fManage : Boolean;
                           fDate:TDateTime;
                           var fError : Integer): Boolean;
   function UpdateHoldItem(fIDHold, fPreInvMovID, fIDModel,
                           fIDCommis, fIDUSer, fIDDepartment: Integer;
                           fQty, fDiscount, fSale, fCost: Double;
                           fMovDate, fDate : TDateTime;
                           fResetDisc, fManager : Boolean;
                           var fError, fIDPreInvMov : Integer;
                           fPreInvMovParentID: Integer = 0;
                           fPromo: Boolean = False):Boolean;
   function RecalcTax(fIDPreSale : Integer; fDate :TDateTime):Boolean;
   function ExemptTax(fIDPreSale : Integer; fExempt :Boolean):Boolean;
   function SetExemptTax(fIDPreSale, fIDMedia : Integer; fDate :TDateTime):Boolean;
   function AddSpecialPrice(fIDPreSale, fIDSpecialPrice: Integer;
                            fDate :TDateTime):Boolean;
   function DeleteSpecialPrice(fIDPreSale : Integer; fDate :TDateTime):Boolean;
   function GetSpecialPriceTotal(fIDPreSale:Integer):Double;
   function ManageDiscount(fIDPreSale :Integer; fDiscount: Currency): Boolean;
   function GetMinSaleAndMaxDiscount(fIDPreSale, fIDUser : Integer;
                                     var fMaxMinSale, fMaxDiscount : Double):Boolean;
   function CancelInvoice(IDPreSale: Integer): Boolean;
   function AddItemSerial(IDPre: Integer; Serial, IdentificationNumber: String): Boolean;

   procedure CancelaUltimoCupom(IDCashRegMov: Integer);
   function GetUltimoCupom(IDCashRegMov:Integer; var ACOO:String):Boolean;

   function CreateSaleCode(IDPreSale, IDPreSaleParent, IDStore:Integer;
                         COO: String; PuppyTracker : Boolean; SN : String):String;
   function TXTDescSystemUser(AIDUser: Integer): String;
   function TXTDescCashReg(AIDCashReg: Integer): String;
   function DescCodigoCDS(CDS: TClientDataSet; AFieldName, AValue,
      ADescField: String; AQuoted: Boolean = False): String;
   function VerifyOpenHold(IDPreSale:Integer):Integer;

   function UpdateCupomFiscal(AIDPreSale: Integer; ACOO: String): Boolean;

   function AddRemovedItem(FIDCashReg, FIDModel, FIDStore, FIDDepartment, FPosicaoItem: Integer;
                           FQty: Double; FDiscount, FSale, FCost, FAcrescimo: Currency;
                           FIDUser, AIDUserAuto, FIDCommis: Integer; FMovDate: TDateTime;
                           FSaleCode, FTotParcial: String; IDNotasCanceladas, IDPreSale : Variant):Boolean;

   function InsertReducaoZ(AMovDate: TDateTime; ANumeroSerie: String;
     ANumeroLoja, ANumeroECF, ANumReducaoZ, ACOOInicial, ACOOFinal,
     ANumCancelamentos: Integer; AValCancelamentos, AValDescontos, AGTInicial,
     AGTFinal, ASubstituicaoTrib, AIsencao, ANaoTributavel: Currency; AAliquota: array of Double;
     ABaseCalculo, AValImposto: array of Currency; ATipoECF, AMarcaECF, AModeloECF, AVersaoSBECF: String;
     ADataInstalacaoSBECF: TDateTime; AMFAdicional: String; AContadorReducaoZ, AContadorOrdemOperacao,
     AContadorReinicioOperacao, ANumeroUsuarioECF: Integer; AIncideISSQN: Boolean;
     ADataEmissao: TDateTime; ATribReducaoZList: array of TRegTribReducaoZ): Boolean;

   function GetCOOInicial(AIDCashRegister: Integer; AMovDate: TDateTime): Integer;
   function GetNumCancelamento(AIDCashRegister: Integer; AMovDate: TDateTime): Integer;

   function AddCustomer(AIDTipoPessoa, AIDTipoPessoaRoot, AIDStore, AIDPreSale: Integer;
      AFirstName, ALastName, AEndereco, ACidade, ABairro, AZip, ADocumento,
      ATelefone, AEstado, ATelDDD, ACelDDD, ACelelular, AEmail, AWebSite,
      ACPF, AIdentidate, AOrgEmiss, ACustCard, ACMotorista,
      ANomeJuridico, AInscEstadual, AInscMunicipal, AContato, AOBS: String;
      AJuridico:Boolean; AExpDate, ABirthDate : TDateTime):  Boolean;

   function GetPessoaID(APessoa, ATel: String): Integer;

   function AddHoldObs(AIDPreSale : Integer; AOBS: String): Boolean;

   function GetPreSaleTotal(AIDPreSale : Integer) : Currency;

   function AddVinculadoInfo(AIDPreSale, ACOO, AGNF, ACDC : Integer; AData : TDateTime) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uTXTCashInfo, uCDSFunctions, uTEFConsts,
  DateUtils;

{$R *.dfm}

function TFrmPOSFunctions.WithdrawCashRegister(fIDCashRegMov, fIDUser : Integer;
                              f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fEnvolop : String;
                              fDate : TDateTime;
                              fOBS: String; fIDReason, fCOO, fGNF: Integer):Boolean;
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
      Parameters.ParamByName('@COO').Value          := fCOO;
      Parameters.ParamByName('@GNF').Value          := fGNF;

      if Trim(fOBS) <> '' then
        Parameters.ParamByName('@OBS').Value         := fOBS
      else
        Parameters.ParamByName('@OBS').Value         := NULL;
      ExecProc;
    end;
    Result := True;
  except
    Result := False;
    end;

end;

function TFrmPOSFunctions.GetTotalCashWithdraw(fIDCashRegMov:Integer):Currency;
begin
  Result := 0;
  case DM.PersistenceType of
    ptDB:
      with spCashRegCalcCashWidraw do
      begin
        Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
        ExecProc;
        Result := Parameters.ParamByName('@TotalCash').Value;
      end;
    ptTXT:
      with DM.TXTCashInfoFactory do
        try
          Result := OpenTotalCash + SaleTotalCash - CancFiscalTotalCash - WidrawTotal + PettyCashTotal;
        finally
          Free;
        end;
  end;
end;

function TFrmPOSFunctions.AddPettyCash(fIDCashRegMov, fIDUser:Integer;
                         fCash : Currency;
                         fDate : TDateTime;
                         fOBS: String):Boolean;
begin
  DM.FTraceControl.TraceIn('TFrmPOSFunctions.AddPettyCash');

  with spCashRegPetty do
  try
    Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
    Parameters.ParamByName('@IDUser').Value       := fIDUser;
    Parameters.ParamByName('@TotalCash').Value    := fCash;
    Parameters.ParamByName('@Date').Value         := fDate;
    Parameters.ParamByName('@IDReason').Value     := 0;
    if Trim(fOBS) <> '' then
      Parameters.ParamByName('@OBS').Value         := fOBS
    else
      Parameters.ParamByName('@OBS').Value         := NULL;

    ExecProc;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      DM.FTraceControl.SetException(E.Message, 'TFrmPOSFunctions');
    end;
  end;

  DM.FTraceControl.TraceOut;
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
  iError: Integer;
  sParamError: String;
begin
  DM.FTraceControl.TraceIn('TFrmPOSFunctions.AddPayment');

  with spAddParcela do
  try
    Parameters.ParambyName('@PreSaleID').Value      := fIDPreSale;
    Parameters.ParambyName('@IDStore').Value        := fIDStore;
    Parameters.ParambyName('@IDUser').Value         := fIDUser;
    Parameters.ParambyName('@IDCliente').Value      := fIDCustomer;
    Parameters.ParambyName('@IDMeioPag').Value      := fIDMeioPag;
    Parameters.ParambyName('@IDCashRegMov').Value   := fIDCashRegMov;
    Parameters.ParambyName('@PreSaleDate').Value    := Int(fPreSaleDate);
    Parameters.ParambyName('@ExpirationDate').Value := Int(fExpireDate);
    Parameters.ParambyName('@Parcela').Value        := fNumParcela;
    Parameters.ParambyName('@Value').Value          := fTotalInvoice;

    if fAutotize <> '' then
      Parameters.ParambyName('@Authorization').Value := fAutotize
    else
      Parameters.ParambyName('@Authorization').Value := Null;

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
    Parameters.ParambyName('@IsPredatado').Value  := fIsPreDatado;

    ExecProc;
    iError := Parameters.ParamByName('@RETURN_VALUE').Value;
    Result := (iError = 0);

    if iError <> 0 then
      raise Exception.Create('sp_PreSale_AddParcela Error ' + IntToStr(iError));
  except
    on E: Exception do
    begin
      Result := False;
      sParamError := 'fIDPreSale=' + IntTostr(fIDPreSale) +
                     ';fIDStore=' + IntTostr(fIDStore) +
                     ';fIDUser=' + IntTostr(fIDUser) +
                     ';fIDCustomer=' + IntTostr(fIDCustomer) +
                     ';fIDMeioPag=' + IntTostr(fIDMeioPag) +
                     ';fIDCashRegMov=' + IntTostr(fIDCashRegMov) +
                     ';fPreSaleDate=' + FormatDateTime('ddddd hh:mm', fPreSaleDate) + ';fPreSaleDate=' + FormatDateTime('ddddd hh:mm', fPreSaleDate) +
                     ';fExpireDate=' + FormatDateTime('ddddd hh:mm', fExpireDate) + ';fExpireDate=' + FormatDateTime('ddddd hh:mm', fExpireDate) +
                     ';fNumParcela=' + fNumParcela +
                     ';fAutotize=' + fAutotize +
                     ';fTotalInvoice=' + FloatToStr(fTotalInvoice) +
                     ';fCheckNumber=' + fCheckNumber +
                     ';fCustomerDocument=' + fCustomerDocument +
                     ';fCustomerName=' + fCustomerName +
                     ';fCustomerPhone=' + fCustomerPhone +
                     ';fIDBankCheck=' + IntToStr(fIDBankCheck) +
                     ';fOBS=' + fOBS +
                     ';fPaymentPlace=' + IntToStr(fPaymentPlace) +
                     ';fIsPreDatado=' + BoolToStr(fIsPreDatado) + '.';
      DM.FTraceControl.SetException(E.Message + ' Param = ' + sParamError, 'TFrmPOSFunctions');
    end
  end;

  DM.FTraceControl.TraceOut;
end;

function TFrmPOSFunctions.PreSalePay(fIDPreSale, fIDTourGroup, fIDOtherCommis,
                                     fIDCashRegMov, fIDStore: Integer;
                                     fDate, fPayDate: TDateTime;
                                     fCashReceived: Double;
                                     fBonusBucks: Currency;
                                     fInvoiceCode : String;
                                     var fIDInvoice: Integer;
                                     var fParamError: String): Boolean;
var
  iError : Integer;
begin
  DM.FTraceControl.TraceIn('TFrmPOSFunctions.PreSalePay');
  Result := False;

  with spPreSalePay do
  begin
    Parameters.ParambyName('@PreSaleID').Value      := fIDPreSale;
    Parameters.ParambyName('@IDTouristGroup').Value := fIDTourGroup;
    Parameters.ParambyName('@OtherComID').Value     := fIDOtherCommis;
    Parameters.ParambyName('@IDCashRegMov').Value   := fIDCashRegMov;
    Parameters.ParambyName('@IDStore').Value        := fIDStore;
    Parameters.ParambyName('@Date').Value           := fDate;
    Parameters.ParambyName('@PayDate').Value        := fPayDate;
    Parameters.ParambyName('@CashReceived').Value   := fCashReceived;
    Parameters.ParamByName('@BonusBucks').Value     := fBonusBucks;
    if fInvoiceCode = '' then
    Parameters.ParamByName('@InvoiceCode').Value    := Null
    else
    Parameters.ParamByName('@InvoiceCode').Value    := fInvoiceCode;

    ExecProc;

    iError := Parameters.ParamByName('@RETURN_VALUE').Value;
    Result := (iError = 0);

    if Result then
      fIDInvoice := Parameters.ParambyName('@IDInvoice').Value
    else
    begin
      fParamError := 'fIDPreSale=' + IntTostr(fIDPreSale) + ';fIDTourGroup=' +
        IntTostr(fIDTourGroup) + ';fIDOtherCommis=' + IntTostr(fIDOtherCommis) +
        ';fIDCashRegMov=' + IntTostr(fIDCashRegMov) + ';fIDStore='+IntTostr(fIDStore) +
        ';fDate=' + FormatDateTime('ddddd hh:mm', fDate) + ';fDate=' + FormatDateTime('ddddd hh:mm', fPayDate) +
        ';fCashReceived=' + CurrToStr(fCashReceived) + '.';
      raise Exception.Create('sp_PreSale_Pay Error ' + IntToStr(iError));
    end;
  end;

  DM.FTraceControl.TraceOut;
end;

function TFrmPOSFunctions.GetTotalCashReceived(fIDCashRegMov:Integer):Double;
begin
  Result := 0;

  case DM.PersistenceType of
    ptDB:
    with spCashRegCalcCash do
    begin
      Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
      ExecProc;
      Result := Parameters.ParamByName('@TotalCash').Value;
    end;

    ptTXT:
    with DM.TXTCashInfoFactory do
    try
      Result := OpenTotalCash + SaleTotalCash - CancFiscalTotalCash;
    finally
      Free;
    end;
  end
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
  case DM.PersistenceType of

    ptDB:
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

    ptTxt:
    begin
      with DM.TXTCashInfoFactory do
      try
        fCashRegName := TXTDescCashReg(IDCashReg);
        fOpenUser    := TXTDescSystemUser(IDOpenUser);
        fOpenDate    := OpenDate;
        fStatus      := Status;
      finally
        Free;
      end;
    end;

  end;
end;


function TFrmPOSFunctions.TXTDescSystemUser(AIDUser: Integer): String;
begin
  Result := DescCodigoCDS(DM.cdsSystemUser, 'IDUser', IntToStr(AIDUser), 'SystemUser');
end;

function TFrmPOSFunctions.TXTDescCashReg(AIDCashReg: Integer): String;
begin
  Result := DescCodigoCDS(DM.cdsCashRegister, 'IDCashRegister', IntToStr(AIDCashReg), 'Name');
end;


function TFrmPOSFunctions.DescCodigoCDS(CDS: TClientDataSet; AFieldName: String; AValue: String; ADescField: String; AQuoted: Boolean = False): String;
var
  AOldFilter: String;
  AOldFiltered: Boolean;
begin
  AOldFilter    := CDS.Filter;
  AOldFiltered  := CDS.Filtered;
  try
    CDS.Filtered := False;

    if AQuoted then
      CDS.Filter   := Format('%S = %S', [AFieldName, QuotedStr(AValue)])
    else
      CDS.Filter   := Format('%S = %S', [AFieldName, AValue]);

    CDS.Filtered := True;

    Result := CDS.FieldByName(ADescField).AsString;
  finally
    CDS.Filtered := False;
    CDS.Filter   := AOldFilter;
    CDS.Filtered := AOldFiltered;
  end;
end;



procedure TFrmPOSFunctions.GetCashRegisterResidual(fIDCashRegMov:Integer;
                              var fIDOpenUser : Integer;
                              var fResidual   : Double);
begin
  case DM.PersistenceType of
    ptDB:
      with quCashRegResidual do
      begin
        Parameters.ParamByName('IDCashRegMov').Value := fIDCashRegMov;
        Open;
        fIDOpenUser := quCashRegResidualIDOpenUser.AsInteger;
        fResidual   := quCashRegResidualResidual.AsFloat;
        Close;
      end;

    ptTXT:
      with DM.TXTCashInfoFactory do
      try
        fIDOpenUser := IDOpenUser;
        fResidual   := OpenTotal + SaleTotal - WidrawTotal - CancFiscalTotal + PettyCashTotal;
      finally
        Free;
      end;
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


function TFrmPOSFunctions.OpenCashRegister(f100, f50, f20, f10, f05, f02, f01,
                              f0100, f050, f025, f010, f005, f001 : Integer;
                              fIDCashReg, fIDUser : Integer;
                              fTotalCount, fTotalCash, fTotalCard, fTotalPreCard,
                              fTotalCheck, fTotalOther, fTotalDebit : Currency;
                              fDate : TDateTime; fCOO, fGNF : Integer;
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
      Parameters.ParamByName('@COO').Value            := fCOO;
      Parameters.ParamByName('@GNF').Value            := fGNF;

      ExecProc;
      fIDCashRegLog := spCashRegOpen.Parameters.ParamByName('@IDCashRegLog').Value;
      fIDCashRegMov := spCashRegOpen.Parameters.ParamByName('@IDCashRegMov').Value;
      Result        := (Parameters.ParamByName('@RETURN_VALUE').Value = 0);
    end;
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
                                     InvObs, CustomerDoc:String; var fIDPreSale: Integer):Boolean;
begin
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

        if CustomerDoc = '' then
           Parameters.ParambyName('@CustomerDOC').Value := Null
        else
          Parameters.ParambyName('@CustomerDOC').Value := CustomerDoc;
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
     Result := False;
   end;
end;

function TFrmPOSFunctions.DeleteHold(fIDCashRegMov, fIDUser: Integer;
  APreSale: TPreSale):Boolean;
var
  iIDNotasCanceladas, i : Integer;
  sSQL : String;
begin

  try
    //PAF
    iIDNotasCanceladas := DM.GetNextID('Sal_NotasCanceladas.IDNotasCanceladas');

    //Inserir tabela de notas canceladas
    with cmdInsertNotaCancel do
    begin
      Parameters.ParamByName('IDNotasCanceladas').Value := iIDNotasCanceladas;
      if APreSale.PreSaleInfo.CustomerInfo <> nil then
      begin
        Parameters.ParamByName('IDPessoa').Value        := APreSale.PreSaleInfo.CustomerInfo.IDCustomer;
        Parameters.ParamByName('Cliente').Value         := APreSale.PreSaleInfo.CustomerInfo.FirstName + ' ' +APreSale.PreSaleInfo.CustomerInfo.LastName;
        Parameters.ParamByName('CPFCGC').Value          := APreSale.PreSaleInfo.CustomerInfo.CPF;
      end
      else
      begin
        Parameters.ParamByName('IDPessoa').Value        := Null;
        Parameters.ParamByName('Cliente').Value         := Null;
        Parameters.ParamByName('CPFCGC').Value          := Null;
      end;
      Parameters.ParamByName('IDUser').Value            := fIDUser;
      if (APreSale.COO = '') or (APreSale.COO = CUPOM_VAZIO) then
      begin
        Parameters.ParamByName('COO').Value             := 0;
        Parameters.ParamByName('CCF').Value             := 0;
      end
      else
      begin
        Parameters.ParamByName('COO').Value             := APreSale.COO;
        Parameters.ParamByName('CCF').Value             := APreSale.CCF;
      end;
      Parameters.ParamByName('DataNota').Value          := APreSale.PreSaleDate;
      Parameters.ParamByName('SubTotal').Value          := APreSale.SaleTotal;
      Parameters.ParamByName('Desconto').Value          := APreSale.DiscountTotal;
      Parameters.ParamByName('Acrescimo').Value         := 0;
      Parameters.ParamByName('TipoAcrescimo').Value     := 'V';
      Parameters.ParamByName('TipoDesconto').Value      := 'V';
      Parameters.ParamByName('IDCashRegMov').Value      := fIDCashRegMov;
      Execute;
   end;

    //Inserir tabela de items canceladas
    for I := 0 to APreSale.Count - 1 do
    begin
      Result := AddRemovedItem(DM.fCashRegister.IDDefault,
                     APreSale.Items[I].IDModel,
                     APreSale.Items[I].IDStore,
                     APreSale.Items[I].IDDepartment,
                     APreSale.Items[I].ECFIndex,
                     APreSale.Items[I].Qty,
                     APreSale.Items[I].Discount,
                     APreSale.Items[I].Sale,
                     APreSale.Items[I].Cost,
                     0,
                     APreSale.Items[I].IDUser,
                     APreSale.Items[I].IDUser,
                     APreSale.Items[I].IDCommis,
                     Now,
                     APreSale.COO,
                     APreSale.Items[I].TotalizadorParcial,
                     iIDNotasCanceladas,
                     Null);

      if not Result then
        Break;
    end;

    if Result then
    begin
      sSQL := 'UPDATE Sal_RemovedItem SET IDPreSale = NULL, IDNotasCanceladas = ' + IntToStr(iIDNotasCanceladas) +
              ' WHERE IDPreSale = ' + IntToStr(APreSale.IDPreSale);
      Result := DM.RunSQL(sSQL);
    end;

    if Result then
    try
      with spDeletePreSale do
         begin
         Parameters.ParambyName('@PreSaleID').Value := APreSale.IDPreSale;
         Parameters.ParambyName('@IDUser').Value    := fIDUser;
         ExecProc;
         end;
      Result := True;
    except
      Result := False;
      end;

  except
    Result := False;
  end;

end;

procedure TFrmPOSFunctions.GetQty(fIDModel, fIDStore : Integer;
                                  var OnHand, OnPreSale, OnPrePurchase : Double);
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
        Close;
        end;

end;

function TFrmPOSFunctions.GetKitPrice(fIDModel : Integer; fQty : Double; fSellingPrice:Currency;
                                      var fIsEmpty:Boolean):Currency;
begin
  Result := fSellingPrice;

  if fQty <= 1 then
     Exit;

  with DM.cdsKitModel do
  try
    if DM.PersistenceType = ptDB then
      Active := True;

    Filtered := False;

    if DM.fSystem.SrvParam[PARAM_PROGRESSIVE_QTY_DISCOUNT] then
      begin
        Filter   := Format('IDModel = %D AND Qty <= %f', [fIDModel, fQty]);
        SetCDSIndex(DM.cdsKitModel, 'IDX_Qty', ['Qty'], ['Qty']);
      end
    else
      begin
        Filter   := Format('IDModel = %D AND Qty = %f', [fIDModel, fQty]);
      end;

    Filtered := True;

    if not IsEmpty then
      Result := DM.cdsKitModelSellingPrice.AsFloat;
    First;

    fIsEmpty := IsEmpty;

    if not fIsEmpty then
      Result := DM.cdsKitModelSellingPrice.AsFloat;

  finally
    IndexName := '';
    Filter   := '';
    Filtered := False;
    if DM.PersistenceType = ptDB then
      Close;
  end;
end;

function TFrmPOSFunctions.AddHoldItem(fIDCustomer, fIDHold, fIDModel, fIDStore: Integer;
                                      fQty, fDiscount, fSale, fCost: Double;
                                      fIDUser, fIDCommis, fIDDepartment: Integer;
                                      fMovDate, fDate: TDateTime;
                                      fResetDisc, fManager: Boolean;
                                      var fError, fIDPreInvMov: Integer;
                                      fPreInvMovParentID: Integer = 0;
                                      fPromo: Boolean = False;
                                      fIDDescriptionPrice: Integer = 0;
                                      fIDVendorPrice: Integer = 0;
                                      fSuggPrice: Currency = 0;
                                      fDocumentNumber: String = '';
                                      fIDDocumentType: Integer = 0;
                                      fSeqNum : Integer = 0; fTotParcial : String = ''): Boolean;
begin
  try
    with spAddPreSaleItem do
    begin
      Parameters.ParambyName('@IDCliente').Value          := fIDCustomer;
      Parameters.ParambyName('@PreSaleID').Value          := fIDHold;
      Parameters.ParambyName('@ModelID').Value            := fIDModel;
      Parameters.ParambyName('@StoreID').Value            := fIDStore;
      Parameters.ParambyName('@Qty').Value                := fQty;
      Parameters.ParambyName('@Discount').Value           := fDiscount;
      Parameters.ParambyName('@SalePrice').Value          := fSale;
      Parameters.ParambyName('@CostPrice').Value          := fCost;
      Parameters.ParambyName('@UserID').Value             := fIDUser;
      Parameters.ParambyName('@IDComission').Value        := fIDCommis;
      Parameters.ParambyName('@MovDate').Value            := fMovDate;
      Parameters.ParambyName('@Date').Value               := fDate;
      Parameters.ParambyName('@ResetDiscount').Value      := fResetDisc;
      Parameters.ParambyName('@Manager').Value            := fManager;
      Parameters.ParambyName('@Promo').Value              := fPromo;
      Parameters.ParambyName('@IDDepartment').Value       := fIDDepartment;
      Parameters.ParambyName('@IDVendorPrice').Value      := fIDVendorPrice;
      Parameters.ParambyName('@IDDescriptionPrice').Value := fIDDescriptionPrice;
      Parameters.ParambyName('@SuggPrice').Value          := fSuggPrice;
      Parameters.ParambyName('@DocumentNumber').Value     := fDocumentNumber;
      Parameters.ParambyName('@IDDocumentType').Value     := fIDDocumentType;
      if fSeqNum <> 0 then
        Parameters.ParambyName('@SequencyNum').Value      := fSeqNum
      else
        Parameters.ParambyName('@SequencyNum').Value      := Null;

      if fTotParcial <> '' then
        Parameters.ParambyName('@TotParcial').Value       := fTotParcial
      else
        Parameters.ParambyName('@TotParcial').Value       := Null;
      if fPreInvMovParentID <> 0 then
        Parameters.ParambyName('@PreInvMovParentID').Value := fPreInvMovParentID
      else
        Parameters.ParambyName('@PreInvMovParentID').Value := Null;
      ExecProc;

      fError       := Parameters.ParambyName('@RETURN_VALUE').Value;
      fIDPreInvMov := Parameters.ParambyName('@PreInventMovID').Value;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.DeleteHoldItem(fIDHold, fIDPreInvMov, fIDModel,
                                         fIDUser : Integer; fQty : Double;
                                         fDiscount, fSale : Double;
                                         fResetDisc, fManage : Boolean;
                                         fDate:TDateTime;
                                         var fError : Integer): Boolean;
begin
  try
    with spDeletePreSaleItem do
    begin
      Parameters.ParambyName('@PreSaleID').Value      := fIDHold;
      Parameters.ParambyName('@PreInventMovID').Value := fIDPreInvMov;
      Parameters.ParambyName('@ModelID').Value        := fIDModel;
      Parameters.ParambyName('@UserID').Value         := fIDUser;
      Parameters.ParambyName('@Qty').Value            := fQty;
      Parameters.ParambyName('@Discount').Value       := fDiscount;
      Parameters.ParambyName('@SalePrice').Value      := fSale;
      Parameters.ParambyName('@ResetDiscount').Value  := fResetDisc;
      Parameters.ParambyName('@Manager').Value        := fManage;
      Parameters.ParambyName('@Date').Value           := fDate;
      ExecProc;
      fError := Parameters.ParambyName('@RETURN_VALUE').Value;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.UpdateHoldItem(fIDHold, fPreInvMovID, fIDModel,
                                         fIDCommis, fIDUSer, fIDDepartment: Integer;
                                         fQty, fDiscount, fSale, fCost : Double;
                                         fMovDate, fDate : TDateTime;
                                         fResetDisc, fManager : Boolean;
                                         var fError, fIDPreInvMov : Integer;
                                         fPreInvMovParentID: Integer = 0;
                                         fPromo: Boolean = False):Boolean;
begin
  try
    with spUpdatePreSaleItem do
    begin
      Parameters.ParambyName('@PreSaleID').Value      := fIDHold;
      Parameters.ParambyName('@PreInventMovID').Value := fPreInvMovID;
      Parameters.ParambyName('@ModelID').Value        := fIDModel;
      Parameters.ParambyName('@IDComission').Value    := fIDCommis;
      Parameters.ParambyName('@UserID').Value         := fIDUSer;
      Parameters.ParambyName('@Qty').Value            := fQty;
      Parameters.ParambyName('@Discount').Value       := fDiscount;
      Parameters.ParambyName('@SalePrice').Value      := fSale;
      Parameters.ParambyName('@CostPrice').Value      := fCost;
      Parameters.ParambyName('@MovDate').Value        := fMovDate;
      Parameters.ParambyName('@Date').Value           := fDate;
      Parameters.ParambyName('@ResetDiscount').Value  := fResetDisc;
      Parameters.ParambyName('@Manager').Value        := fManager;
      Parameters.ParambyName('@Promo').Value          := fPromo;
      Parameters.ParambyName('@IDDepartment').Value   := fIDDepartment;
      if fPreInvMovParentID <> 0 then
        Parameters.ParambyName('@PreInvMovParentID').Value := fPreInvMovParentID
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

function TFrmPOSFunctions.RecalcTax(fIDPreSale: Integer; fDate: TDateTime): Boolean;
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

function TFrmPOSFunctions.SetExemptTax(fIDPreSale, fIDMedia: Integer;
                                       fDate: TDateTime): Boolean;
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

function TFrmPOSFunctions.ExemptTax(fIDPreSale : Integer; fExempt :Boolean):Boolean;
begin
  try
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
                                          fDate :TDateTime):Boolean;
begin
  try
      with spAddSpecialPrice do
         begin
         Parameters.ParambyName('@PreSaleID').Value      := fIDPreSale;
         Parameters.ParambyName('@SpecialPriceID').Value := fIDSpecialPrice;
         Parameters.ParambyName('@Date').Value           := fDate;
         ExecProc;
         end;
    Result := True;
  except
    Result := False;
    end;
end;

function TFrmPOSFunctions.DeleteSpecialPrice(fIDPreSale : Integer; fDate :TDateTime):Boolean;
begin
  try
     with spDeleteSpecialPrice do
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

function TFrmPOSFunctions.ManageDiscount(fIDPreSale :Integer; fDiscount: Currency):Boolean;
begin
  try
     with cmdInvoiceDiscount do
     begin
       Parameters.ParambyName('IDPreSale').Value := fIDPreSale;
       Parameters.ParambyName('Discount').Value  := fDiscount;
       Execute;
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

procedure TFrmPOSFunctions.FormCreate(Sender: TObject);
begin
   InvoiceItem := TStringList.Create;
end;

procedure TFrmPOSFunctions.FormDestroy(Sender: TObject);
begin
   FreeAndNil(InvoiceItem);
end;

procedure TFrmPOSFunctions.GravaDadosTipo60Diario(IDInvoice : Integer);
begin

end;

function TFrmPOSFunctions.CancelInvoice(IDPreSale: Integer): Boolean;
var
  iIDNotasCanceladas : Integer;
  sSQL : String;
begin

  try

    //PAF
    quPreSaleItemCanceled.Parameters.ParamByName('IDPreSale').Value := IDPreSale;
    quPreSaleItemCanceled.Open;
    if not quPreSaleItemCanceled.IsEmpty then
    begin
      quPreSaleItemCanceled.First;
      iIDNotasCanceladas := DM.GetNextID('Sal_NotasCanceladas.IDNotasCanceladas');

      //Inserir tabela de notas canceladas
      with cmdInsertNotaCancel do
      begin
        Parameters.ParamByName('IDNotasCanceladas').Value := iIDNotasCanceladas;
        Parameters.ParamByName('IDPessoa').Value          := quPreSaleItemCanceled.FieldByName('IDCustomer').AsInteger;
        Parameters.ParamByName('Cliente').Value           := quPreSaleItemCanceled.FieldByName('Customer').AsString;
        Parameters.ParamByName('CPFCGC').Value            := quPreSaleItemCanceled.FieldByName('CPFCGC').AsString;
        Parameters.ParamByName('IDUser').Value            := quPreSaleItemCanceled.FieldByName('IDUser').AsInteger;
        Parameters.ParamByName('COO').Value               := quPreSaleItemCanceled.FieldByName('COO').AsString;
        Parameters.ParamByName('CCF').Value               := quPreSaleItemCanceled.FieldByName('InvoiceCode').AsString;
        Parameters.ParamByName('DataNota').Value          := quPreSaleItemCanceled.FieldByName('PreSaleDate').AsDateTime;
        Parameters.ParamByName('SubTotal').Value          := quPreSaleItemCanceled.FieldByName('SubTotal').AsCurrency;
        Parameters.ParamByName('Desconto').Value          := quPreSaleItemCanceled.FieldByName('Discount').AsCurrency;
        Parameters.ParamByName('Acrescimo').Value         := 0;
        Parameters.ParamByName('TipoAcrescimo').Value     := 'V';
        Parameters.ParamByName('TipoDesconto').Value      := 'V';
        Parameters.ParamByName('IDCashRegMov').Value      := quPreSaleItemCanceled.FieldByName('CashRegMovID').AsInteger;
        Execute;
     end;

     //Inserir tabela de items canceladas

     While not quPreSaleItemCanceled.Eof do
     begin
        Result := AddRemovedItem(DM.fCashRegister.IDDefault,
                       quPreSaleItemCanceled.FieldByName('ModelID').AsInteger,
                       quPreSaleItemCanceled.FieldByName('StoreID').AsInteger,
                       quPreSaleItemCanceled.FieldByName('IDDepartment').AsInteger,
                       quPreSaleItemCanceled.FieldByName('SequencyNum').AsInteger,
                       quPreSaleItemCanceled.FieldByName('Qty').AsFloat,
                       quPreSaleItemCanceled.FieldByName('Discount').AsCurrency,
                       quPreSaleItemCanceled.FieldByName('SalePrice').AsCurrency,
                       quPreSaleItemCanceled.FieldByName('CostPrice').AsCurrency,
                       0,
                       quPreSaleItemCanceled.FieldByName('IDUser').AsInteger,
                       quPreSaleItemCanceled.FieldByName('IDUser').AsInteger,
                       0,
                       Now,
                       quPreSaleItemCanceled.FieldByName('COO').AsString,
                       quPreSaleItemCanceled.FieldByName('TotalizadorParcial').AsString,
                       iIDNotasCanceladas,
                       Null);

        if not Result then
          Break;

        quPreSaleItemCanceled.Next;
      end;

      if Result then
      begin
        sSQL := 'UPDATE Sal_RemovedItem SET IDPreSale = NULL, IDNotasCanceladas = ' + IntToStr(iIDNotasCanceladas) +
                ' WHERE IDPreSale = ' + IntToStr(IDPreSale);
        Result := DM.RunSQL(sSQL);
      end;

    end;

    spCancelInvoice.Parameters.ParamByName('@IDPreSale').Value := IDPreSale;
    spCancelInvoice.Parameters.ParamByName('@IDUser').Value    := DM.fUser.ID;
    spCancelInvoice.ExecProc;

    Result := spCancelInvoice.Parameters.ParamByName('@RETURN_VALUE').Value = 0;

  except
    Result := False;
    end;
end;

procedure TFrmPOSFunctions.CancelaUltimoCupom(IDCashRegMov: Integer);
var
  COO: String;
begin
  inherited;
  if GetUltimoCupom(IDCashRegMov, COO) then
  begin
    if (MsgBox(Format(MSG_QST_CANCEL_INVOICE, [COO]), vbYesNo + vbQuestion) = vbNo) then
       Exit;
       
    if DM.EFiscal1.CancelaCupomAtualSemErro((DM.fCashRegister.UseTef in [TEF_DIAL, TEF_DEDICADO])) then
    begin
      case DM.PersistenceType of
        ptDB:
        with DM.quFreeSQL do
          try
            if Active then
              Close;
            SQL.Clear;
            SQL.Add(Format('SELECT IDPreSale FROM Invoice WHERE CupomFiscal = %S AND CashRegMovID = %D', [QuotedStr(Trim(COO)), IDCashRegMov]));
            Open;
            if not IsEmpty then
              CancelInvoice(FieldByName('IDPreSale').AsInteger);
          finally
            Close;
          end;
        ptTXT:
          DM.SaleWritter.CancelFiscalSale(COO, DM.fUser.ID);
      end;
    end;
  end
end;

function TFrmPOSFunctions.CreateSaleCode(IDPreSale, IDPreSaleParent,
  IDStore: Integer; COO: String; PuppyTracker : Boolean; SN : String): String;
var
  SQLFiscal: String;
begin
  if (COO = '') or (COO = CUPOM_VAZIO) then
    begin
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
      SQLFiscal := ', CupomFiscal = NULL, NumeroSeriePrinter = NULL';
    end
  else
    begin
      Result := COO;
      SQLFiscal :=  ', CupomFiscal = '+ QuotedStr(COO);
      if Trim(SN) <> '' then
         SQLFiscal := SQLFiscal + ' , NumeroSeriePrinter = ' + QuotedStr(SN);
    end;

  DM.RunSQL('UPDATE Invoice SET SaleCode = '+QuotedStr(Result)+ SQLFiscal +
            ', PuppyTracker = ' + IntToStr(Byte(PuppyTracker)) +
            ' WHERE IDPreSale = ' + IntToStr(IDPreSale));

end;

function TFrmPOSFunctions.GetUltimoCupom(IDCashRegMov: Integer; var ACOO:String): Boolean;
begin
  Result := False;
  case DM.PersistenceType of
    ptDB:
      with quInvoiceCanceled do
      begin
        if Active then
           Close;
        Parameters.ParamByName('IDCashRegMov').Value := IDCashRegMov;
        try
          Open;

          Result := not (IsEmpty or quInvoiceCanceledCanceled.AsBoolean);
          if not Result then
            Exit;
          ACOO := quInvoiceCanceledCupomFiscal.AsString;
        finally
          Close;
        end;
      end;

    ptTXT:
      with DM.TXTCashInfoFactory do
      try
        Result := not COOCanceled;
        if not Result then
            Exit;
        ACOO := COO;
      finally
        Free;
      end;
  end;
end;

function TFrmPOSFunctions.VerifyOpenHold(IDPreSale:Integer): Integer;
begin

    with quTestOpenHold do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := IDPreSale;
      Open;

      if (quTestOpenHoldnOpenUser.AsInteger > 0) then
        Result := 1
      else if (quTestOpenHoldnOpenHoldCaixa.AsInteger > 0) then
        Result := 2
      else
        Result := 0;

      Close;
    end;
end;


function TFrmPOSFunctions.UpdateCupomFiscal(AIDPreSale: Integer; ACOO: String): Boolean;
begin
  Result := True;
  try
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Clear;
      SQL.Add(Format('UPDATE Invoice SET CupomFiscal = %S WHERE IDPreSale = %D', [QuotedStr(Trim(ACOO)), AIDPreSale]));
      ExecSQL;
    finally
      Close;
    end;
  except
    Result := False;
  end;
end;


function TFrmPOSFunctions.AddRemovedItem(FIDCashReg, FIDModel, FIDStore,
  FIDDepartment, FPosicaoItem: Integer; FQty: Double; FDiscount, FSale, FCost, FAcrescimo: Currency;
  FIDUser, AIDUserAuto, FIDCommis: Integer; FMovDate: TDateTime;
  FSaleCode, FTotParcial: String; IDNotasCanceladas, IDPreSale : Variant): Boolean;
begin
  with cmdAddDeletedItem do
  try
    Parameters.ParamByName('IDRemovedItem').Value  := DM.GetNextID('Sal_RemovedItem.IDRemovedItem');
    Parameters.ParamByName('IDCashRegister').Value := FIDCashReg;
    Parameters.ParamByName('IDModel').Value        := FIDModel;
    Parameters.ParamByName('IDStore').Value        := FIDStore;
    Parameters.ParamByName('IDDepartment').Value   := FIDDepartment;
    Parameters.ParamByName('IDUserAuto').Value     := AIDUserAuto;
    Parameters.ParamByName('IDPessoa').Value       := FIDCommis;
    Parameters.ParamByName('IDUser').Value         := FIDUser;
    Parameters.ParamByName('MovDate').Value        := FMovDate;
    Parameters.ParamByName('Qty').Value            := FQty;
    Parameters.ParamByName('SalePrice').Value      := FSale;
    Parameters.ParamByName('CostPrice').Value      := FCost;
    Parameters.ParamByName('Discount').Value       := FDiscount;
    Parameters.ParamByName('SaleCode').Value       := FSaleCode;
    //PAF
    Parameters.ParamByName('PosicaoItem').Value        := FPosicaoItem;
    Parameters.ParamByName('Acrescimo').Value          := FAcrescimo;
    Parameters.ParamByName('TotalizadorParcial').Value := FTotParcial;
    Parameters.ParamByName('IDNotasCanceladas').Value  := IDNotasCanceladas;
    Parameters.ParamByName('IDPreSale').Value          := IDPreSale;

    Execute;

    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.InsertReducaoZ(AMovDate: TDateTime; ANumeroSerie: String;
  ANumeroLoja, ANumeroECF, ANumReducaoZ, ACOOInicial, ACOOFinal,
  ANumCancelamentos: Integer; AValCancelamentos, AValDescontos, AGTInicial, AGTFinal,
  ASubstituicaoTrib, AIsencao, ANaoTributavel: Currency; AAliquota: array of Double;
  ABaseCalculo, AValImposto: array of Currency; ATipoECF, AMarcaECF, AModeloECF,
  AVersaoSBECF: String; ADataInstalacaoSBECF: TDateTime; AMFAdicional: String;
  AContadorReducaoZ, AContadorOrdemOperacao, AContadorReinicioOperacao,
  ANumeroUsuarioECF: Integer; AIncideISSQN: Boolean; ADataEmissao: TDateTime;
  ATribReducaoZList: array of TRegTribReducaoZ): Boolean;
var
  i, iIDReducaoZ: Integer;
  bHasReducaoZ: Boolean;
begin
  try
    with quTestReducaoZ do
    begin
      if Active then
        Close;

      Parameters.ParamByName('MovDate').Value := AMovDate;
      Parameters.ParamByName('NumeroSerie').Value := ANumeroSerie;
      Open;
      bHasReducaoZ := not IsEmpty;
      Close;
    end;

    if not bHasReducaoZ then
    try
      DM.ADODBConnect.BeginTrans;

      with cmdInsertReducaoZ do
      begin
        iIDReducaoZ := DM.GetNextID('Sal_ReducaoZ.IDReducaoZ');

        Parameters.ParamByName('IDReducaoZ').Value       := iIDReducaoZ;
        Parameters.ParamByName('MovDate').Value          := AMovDate;
        Parameters.ParamByName('NumeroSerie').Value      := ANumeroSerie;
        Parameters.ParamByName('NumeroLoja').Value       := ANumeroLoja;
        Parameters.ParamByName('NumeroECF').Value        := ANumeroECF;
        Parameters.ParamByName('NumReducaoZ').Value      := ANumReducaoZ;
        Parameters.ParamByName('COOInicial').Value       := GetCOOInicial(DM.fCashRegister.IDDefault, AMovDate);
        Parameters.ParamByName('COOFinal').Value         := AContadorOrdemOperacao;
        Parameters.ParamByName('NumCancelamentos').Value := GetNumCancelamento(DM.fCashRegister.IDDefault, AMovDate);
        Parameters.ParamByName('ValCancelamentos').Value := AValCancelamentos;
        Parameters.ParamByName('ValDescontos').Value     := AValDescontos;
        Parameters.ParamByName('GTInicial').Value        := AGTInicial;
        Parameters.ParamByName('GTFinal').Value          := AGTFinal;
        Parameters.ParamByName('SubstituicaoTrib').Value := ASubstituicaoTrib;
        Parameters.ParamByName('Isencao').Value          := AIsencao;
        Parameters.ParamByName('NaoTributavel').Value    := ANaoTributavel;

        // NOVOS CAMPOS PAF-ECF
        Parameters.ParamByName('TipoECF').Value                  := ATipoECF;
        Parameters.ParamByName('MarcaECF').Value                 := AMarcaECF;
        Parameters.ParamByName('ModeloECF').Value                := AModeloECF;
        Parameters.ParamByName('VersaoSBECF').Value              := AVersaoSBECF;
        Parameters.ParamByName('DataInstalacaoSBECF').Value      := ADataInstalacaoSBECF;
        Parameters.ParamByName('MFAdicional').Value              := AMFAdicional;
        Parameters.ParamByName('ContadorReducaoZ').Value         := AContadorReducaoZ;
        Parameters.ParamByName('ContadorOrdemOperacao').Value    := AContadorOrdemOperacao;
        Parameters.ParamByName('ContadorReinicioOperacao').Value := AContadorReinicioOperacao;
        Parameters.ParamByName('NumeroUsuarioECF').Value         := ANumeroUsuarioECF;
        Parameters.ParamByName('IncideISSQN').Value              := AIncideISSQN;
        Parameters.ParamByName('DataEmissao').Value              := ADataEmissao;
        Parameters.ParamByName('IDCashRegister').Value           := DM.fCashRegister.IDDefault;
        Execute;
      end;

      for i := 0 to Pred(Length(AAliquota)) do
      begin
        with cmdInsertTributacaoECF do
        begin
          Parameters.ParamByName('IDTributacaoECF').Value := DM.GetNextID('Sal_TributacaoECF.IDTributacaoECF');
          Parameters.ParamByName('Aliquota').Value        := AAliquota[i];
          Parameters.ParamByName('BaseCalculo').Value     := ABaseCalculo[i];
          Parameters.ParamByName('ValImposto').Value      := AValImposto[i];
          Parameters.ParamByName('IDReducaoZ').Value      := iIDReducaoZ;
          Execute;
        end;
      end;

      // NOVA TABELA PARA PAF-ECF
      for i := 0 to Pred(Length(ATribReducaoZList)) do
      begin
        with cmdInsertTotalizadorParcial do
        begin
          Parameters.ParamByName('IDTotalizadorParcial').Value := DM.GetNextID('Sal_TotalizadorParcial.IDTotalizadorParcial');
          Parameters.ParamByName('Codigo').Value               := ATribReducaoZList[i].Codigo;
          Parameters.ParamByName('ValorAcumulado').Value       := ATribReducaoZList[i].ValorAcumulado;
          Parameters.ParamByName('IDReducaoZ').Value           := iIDReducaoZ;
          Execute;
        end;
      end;

      DM.ADODBConnect.CommitTrans;
      Result := True;
    except
      DM.ADODBConnect.RollbackTrans;
      Result := False;
    end;
  except
    Result := False;
  end;
end;

function TFrmPOSFunctions.AddAddCash(fIDCashRegMov, fIDUser: Integer;
  fCash: Currency; fDate: TDateTime; fOBS: String; fCOO, fGNF : Integer): Boolean;
begin
  DM.FTraceControl.TraceIn('TFrmPOSFunctions.AddPettyCash');

  with spAddCash do
  try
    Parameters.ParamByName('@IDCashRegMov').Value := fIDCashRegMov;
    Parameters.ParamByName('@IDUser').Value       := fIDUser;
    Parameters.ParamByName('@TotalCash').Value    := fCash;
    Parameters.ParamByName('@Date').Value         := fDate;
    Parameters.ParamByName('@IDReason').Value     := 0;
    if Trim(fOBS) <> '' then
      Parameters.ParamByName('@OBS').Value        := fOBS
    else
      Parameters.ParamByName('@OBS').Value        := NULL;
    Parameters.ParamByName('@COO').Value          := fCOO;
    Parameters.ParamByName('@GNF').Value          := fGNF;

    ExecProc;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      DM.FTraceControl.SetException(E.Message, 'TFrmPOSFunctions');
    end;
  end;

  DM.FTraceControl.TraceOut;
end;

function TFrmPOSFunctions.AddCustomer(AIDTipoPessoa,
  AIDTipoPessoaRoot, AIDStore, AIDPreSale: Integer; AFirstName, ALastName, AEndereco, ACidade,
  ABairro, AZip, ADocumento, ATelefone, AEstado, ATelDDD, ACelDDD,
  ACelelular, AEmail, AWebSite, ACPF, AIdentidate, AOrgEmiss, ACustCard,
  ACMotorista, ANomeJuridico, AInscEstadual, AInscMunicipal, AContato,
  AOBS: String; AJuridico: Boolean; AExpDate,
  ABirthDate: TDateTime): Boolean;
var
  tmpIDPessoa: Integer;
  APessoa : String;
begin

  Result := True;

  try

    APessoa := Copy(Trim(AFirstName + ' ' + ALastName), 1, 50);
    tmpIDPessoa := GetPessoaID(APessoa, ATelefone);

    if tmpIDPessoa = -1 then
    begin
      tmpIDPessoa := DM.GetNextID(MR_PESSOA_ID);

      with cmdAddPessoa do
      begin
         Parameters.ParamByName('IDPessoa').Value         := tmpIDPessoa;
         Parameters.ParamByName('IDTipoPessoa').Value     := AIDTipoPessoa;
         Parameters.ParamByName('IDStore').Value          := AIDStore;
         Parameters.ParamByName('IDTipoPessoaRoot').Value := AIDTipoPessoaRoot;
         Parameters.ParamByName('IDUser').Value           := 0;
         Parameters.ParamByName('Pessoa').Value           := APessoa;
         Parameters.ParamByName('PessoaFirstName').Value  := Copy(Trim(AFirstName), 1, 30);;
         Parameters.ParamByName('PessoaLastName').Value   := Copy(Trim(ALastName), 1, 30);;
         Parameters.ParamByName('Endereco').Value         := AEndereco;
         Parameters.ParamByName('Cidade').Value           := ACidade;
         Parameters.ParamByName('CEP').Value              := AZip;
         Parameters.ParamByName('Telefone').Value         := Trim(ATelefone);
         Parameters.ParamByName('Juridico').Value         := AJuridico;
         Parameters.ParamByName('CPF').Value              := ACPF;
         Parameters.ParamByName('Bairro').Value           := ABairro;
         Parameters.ParamByName('PhoneAreaCode').Value    := ATelDDD;
         Parameters.ParamByName('CellAreaCode').Value     := ACelDDD;
         Parameters.ParamByName('Cellular').Value         := ACelelular;
         Parameters.ParamByName('Email').Value            := AEmail;
         Parameters.ParamByName('HomePage').Value         := AWebSite;
         Parameters.ParamByName('Identidade').Value       := AIdentidate;
         Parameters.ParamByName('OrgaoEmissor').Value     := AOrgEmiss;
         Parameters.ParamByName('CreationDate').Value     := Now;

         if AExpDate <> 0 then
            Parameters.ParamByName('DataExpedicao').Value := AExpDate;
         if ABirthDate <> 0 then
            Parameters.ParamByName('Nascimento').Value     := ABirthDate;

         Parameters.ParamByName('CustomerCard').Value     := ACustCard;
         Parameters.ParamByName('CartMotorista').Value    := ACMotorista;
         Parameters.ParamByName('NomeJuridico').Value     := ANomeJuridico;
         Parameters.ParamByName('InscEstadual').Value     := AInscEstadual;
         Parameters.ParamByName('InscMunicipal').Value    := AInscMunicipal;
         Parameters.ParamByName('Contatos').Value         := AContato;
         Parameters.ParamByName('OBS').Value              := AOBS;
         try
           Execute;
         except
           if AExpDate <> 0 then
              Parameters.ParamByName('DataExpedicao').Value := null;
           if ABirthDate <> 0 then
              Parameters.ParamByName('Nascimento').Value     := null;
           Execute;
         end;
      end;
    end;

    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Text := Format('UPDATE Invoice SET IDCustomer = %D WHERE IDPreSale = %D',  [tmpIDPessoa, AIDPreSale]);
      ExecSQL;
    finally
      Close;
    end;

  except
    Result := False;
  end;

end;

function TFrmPOSFunctions.GetPessoaID(APessoa, ATel: String): Integer;
begin
  with quGetCustomer do
  try
    if Active then
      Close;
    Parameters.ParamByName('Pessoa').Value := APessoa;
    Parameters.ParamByName('Tel').Value    := ATel;
    Parameters.ParamByName('Tel1').Value   := ATel;
    Open;
    if IsEmpty then
      Result := -1
    else
      Result := FieldByName('IDPessoa').AsInteger;
  finally
    Close;
  end;

end;

function TFrmPOSFunctions.AddItemSerial(IDPre: Integer;
  Serial, IdentificationNumber: String): Boolean;
begin
  try
     with cmdInsertSerial do
     begin
       Parameters.ParambyName('PreInventoryMovID').Value := IDPre;
       Parameters.ParambyName('SerialNumber').Value := Serial;
       Parameters.ParambyName('IdentificationNumber').Value := IdentificationNumber;
       Execute;
     end;
     Result := True;
  except
     Result := False;
     end;
end;

function TFrmPOSFunctions.AddHoldObs(AIDPreSale: Integer;
  AOBS: String): Boolean;
begin

  try
     with cmdInsertObs do
     begin
       Parameters.ParambyName('Notes').Value     := AOBS;
       Parameters.ParambyName('IDPreSale').Value := AIDPreSale;
       Execute;
     end;
     Result := True;
  except
     Result := False;
     end;

end;

function TFrmPOSFunctions.GetPreSaleTotal(AIDPreSale: Integer): Currency;
begin
  with quPreSaleTotal do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPreSale').Value := AIDPreSale;
    Open;
    Result := FieldByName('PreSaleTotal').AsCurrency;
  finally
    Close;
  end;
end;

function TFrmPOSFunctions.AddVinculadoInfo(AIDPreSale, ACOO, AGNF,
  ACDC: Integer; AData : TDateTime): Boolean;
begin

  with cmdInsertLancComplement do
  begin
    Parameters.ParamByName('IDPreSale').Value   := AIDPreSale;
    Parameters.ParamByName('COO').Value         := ACOO;
    Parameters.ParamByName('GNF').Value         := AGNF;
    Parameters.ParamByName('CDC').Value         := ACDC;
    Parameters.ParamByName('DataEmissao').Value := AData;
    Execute;
  end;

  Result := True;
end;

function TFrmPOSFunctions.GetCOOInicial(AIDCashRegister: Integer;
  AMovDate: TDateTime): Integer;
begin
  with DM.quFreeSQL do
  try
    Close;
    SQL.Text := 'SELECT TOP 1 ' +
                '  CRLC.COO COOInicial ' +
                'FROM ' +
                '  CashRegLogComplement CRLC (NOLOCK) ' +
                '  JOIN CashRegLog CRL (NOLOCK) ON (CRLC.IDCashRegLog = CRL.IDCashRegLog) ' +
                '  JOIN CashRegMov CRM (NOLOCK) ON (CRL.IDCashRegMov = CRM.IDCashRegMov) ' +
                'WHERE ' +
                '  	CRM.IDCashRegister = :IDCashRegister ' +
                '  	AND CRL.IDCashRegTipoLog = 1 ' +
                '  	AND CRL.LogTime >= :DataIni ' +
                '  	AND CRL.LogTime < :DataFim ' +
                '  ORDER BY ' +
                '  	CRL.LogTime';
    Parameters.ParamByName('IDCashRegister').Value := AIDCashRegister;
    Parameters.ParamByName('DataIni').Value := AMovDate;
    Parameters.ParamByName('DataFim').Value := IncDay(AMovDate);
    Open;

    if not IsEmpty then
      Result := FieldByName('COOInicial').AsInteger;
  finally
    Close;
  end;
end;

function TFrmPOSFunctions.GetNumCancelamento(AIDCashRegister: Integer;
  AMovDate: TDateTime): Integer;
begin
  with DM.quFreeSQL do
  try
    Close;
    SQL.Text := 'SELECT ' +
                '  COUNT(IDNotasCanceladas) NumCancelamento ' +
                'FROM ' +
                '	 Sal_NotasCanceladas SNC (NOLOCK) ' +
                '	 JOIN CashRegMov CRM (NOLOCK) ON (SNC.IDCashRegMov = CRM.IDCashRegMov) ' +
                'WHERE ' +
                '	 CRM.IDCashRegister = :IDCashRegister ' +
                '	 AND SNC.DataNota >= :DataIni ' +
                '	 AND SNC.DataNota < :DataFim ';
    Parameters.ParamByName('IDCashRegister').Value := AIDCashRegister;
    Parameters.ParamByName('DataIni').Value := AMovDate;
    Parameters.ParamByName('DataFim').Value := IncDay(AMovDate);
    Open;

    if not IsEmpty then
      Result := FieldByName('NumCancelamento').AsInteger;
  finally
    Close;
  end;
end;

end.
