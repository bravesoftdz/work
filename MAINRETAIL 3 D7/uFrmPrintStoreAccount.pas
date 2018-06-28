unit uFrmPrintStoreAccount;

interface

uses
  {
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, StdCtrls, PsRBExport_Main,
  PsRBExport_PDF, ppEndUsr, ppParameter, ppCtrls, ppBands, ppModule,
  raCodMod, ppClass, myChkBox, ppReport, ppPrnabl, ppStrtch, ppSubRpt,
  ppCache, ppComm, ppRelatv, ppProd, ppDB, ppDBPipe, DB, ADODB, ppMemo,
  ppRegion;
   }

  //{
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, siComp, siLangRT,
  PaiDeForms, PaidePrinter, ppDB, ppDBPipe, ppEndUsr, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, ppPrnabl, ppCtrls, ppBands, ppCache, ppStrtch,
  ppMemo, ppModule, raCodMod, ppSubRpt, ppParameter, ppRegion, jpeg, ppVar,
  PsRBExport_MasterControl, PowerADOQuery, DBCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, BuilderControls, myChkBox, Provider, DBClient,
  XiButton, EanRB, clsInfoCashSale, PsRBExport_Main, PsRBExport_PDF;
  //}


type
  TFrmPrintStoreAccount = class(TFrmParentPrint)
    btnClose: TButton;
    ppReport: TppReport;
    ppDesigner: TppDesigner;
    ppExportPDF: TPsRBExportPDF;
    quStoreAccInfo: TADOQuery;
    dsStoreAccInfo: TDataSource;
    ppStoreAccInfo: TppDBPipeline;
    quStoreAccInfoIDStoreAccount: TIntegerField;
    quStoreAccInfoIDStoreAccountUsed: TIntegerField;
    quStoreAccInfoIDPessoa: TIntegerField;
    quStoreAccInfoIDUser: TIntegerField;
    quStoreAccInfoIDStore: TIntegerField;
    quStoreAccInfoIDLancamento: TIntegerField;
    quStoreAccInfoTransactionDate: TDateTimeField;
    quStoreAccInfoAmount: TBCDField;
    quStoreAccInfoStoreName: TStringField;
    quStoreAccInfoStoreState: TStringField;
    quStoreAccInfoStoreAddress: TStringField;
    quStoreAccInfoStoreCity: TStringField;
    quStoreAccInfoStoreZip: TStringField;
    quStoreAccInfoStorePhone: TStringField;
    quStoreAccInfoStoreFax: TStringField;
    quStoreAccInfoCashRegisterName: TStringField;
    quStoreAccInfoPessoa: TStringField;
    quStoreAccInfoPessoaFirstName: TStringField;
    quStoreAccInfoPessoaLastName: TStringField;
    quStoreAccInfoEndereco: TStringField;
    quStoreAccInfoIDEstado: TStringField;
    quStoreAccInfoCidade: TStringField;
    quStoreAccInfoCEP: TStringField;
    quPayments: TADOQuery;
    quPaymentsMessageField1: TStringField;
    ppPayments: TppDBPipeline;
    dsPayments: TDataSource;
    quStoreAccInfoNumDocumento: TStringField;
    quPaymentsIDMeioPag: TIntegerField;
    quPaymentsMeioPag: TStringField;
    quPaymentsPayType: TIntegerField;
    quPaymentsDrawerKickOnPay: TBooleanField;
    quPaymentsIDLancamento: TIntegerField;
    quPaymentsValorNominal: TBCDField;
    quPaymentsIDQuitacaoMeioPrevisto: TIntegerField;
    quPaymentsIDLancamentoTipo: TIntegerField;
    quPaymentsIDDocumentoTipo: TIntegerField;
    quPaymentsIDPreSale: TIntegerField;
    quPaymentsCheckNumber: TStringField;
    quPaymentsIDBankCheck: TIntegerField;
    quPaymentsCustomerDocument: TStringField;
    quPaymentsCustomerName: TStringField;
    quPaymentsCustomerPhone: TStringField;
    quPaymentsHistorico: TMemoField;
    quPaymentsPaymentPlace: TIntegerField;
    quPaymentsNumMeioQuitPreVisto: TStringField;
    quPaymentsNumDesdobramento: TStringField;
    quPaymentsTotalQuitado: TBCDField;
    quPaymentsCodSystemUser: TStringField;
    quPaymentsPaymentPlaceDesc: TStringField;
    quPaymentsChange: TCurrencyField;
    quPaymentsAuthorization: TStringField;
    quPaymentsCardNumber: TStringField;
    quPaymentsRemains: TCurrencyField;
    quPaymentsMerchantID: TStringField;
    quPaymentsIsChip: TBooleanField;
    quPaymentsAppLabel: TStringField;
    quPaymentsLabelAID: TStringField;
    quPaymentsLabelTVR: TStringField;
    quPaymentsLabelIAD: TStringField;
    ppParameterList1: TppParameterList;
    ppReportBack: TppReport;
    ppDetailBand: TppDetailBand;
    ppSubReport: TppSubReport;
    ppChildReport: TppChildReport;
    ppDetailBandBack: TppDetailBand;
    ppLine1: TppLine;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppRegion1: TppRegion;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText10: TppDBText;
    ppLabel5: TppLabel;
    ppDBText11: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppLabel6: TppLabel;
    ppDBText27: TppDBText;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel17: TppLabel;
    ppDBText30: TppDBText;
    ppLabel25: TppLabel;
    ppDBText31: TppDBText;
    ppDBText32: TppDBText;
    ppDBMemo1: TppDBMemo;
    ppDBMemo2: TppDBMemo;
    raCodeModule1: TraCodeModule;
    raCodeModule2: TraCodeModule;
    ppParameterList2: TppParameterList;
    ppDetailBand3: TppDetailBand;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand4: TppDetailBand;
    ppLine2: TppLine;
    ppLabel13: TppLabel;
    ppDBText12: TppDBText;
    ppLabel14: TppLabel;
    ppDBText13: TppDBText;
    ppRegion2: TppRegion;
    ppDBText14: TppDBText;
    ppLabel15: TppLabel;
    ppDBText15: TppDBText;
    ppLabel16: TppLabel;
    ppDBText16: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppLabel8: TppLabel;
    ppDBText9: TppDBText;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppDBText21: TppDBText;
    ppLabel24: TppLabel;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBMemo3: TppDBMemo;
    ppDBMemo4: TppDBMemo;
    raCodeModule3: TraCodeModule;
    raCodeModule4: TraCodeModule;
//    ppHeaderBand1: TppHeaderBand;
//    ppFooterBand1: TppFooterBand;
//    ppLabel2;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure quPaymentsCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure quPaymentsAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private

    FSumLayawayPaid: double;
    //Antonio M F Souza 11.02.2010 : save layaway payments to avoid fail in sum.
    FLayawayPayments: TStringList;

    // Antonio M F Souza June 29, 2012
    reprint: boolean;
    MyChange       : Currency;
    sPayStore,
    sPayOuter,
    sPayOther: String;
    FChangeList    : TStringList;
    FPrintFooter: Boolean;
    FIDStoreAccount: Integer;
    FPrintToFile: Boolean;
    FFileName: String;


    // Alex 09/30/2015
    function BuildExtraInformationText( originalText:String ): String;

    //Antonio M F Souza July 13, 2012 - gc number masked.
    function getGCNumberMasked(pGCNumber: String): String;

    function PrintReport: Boolean;

    procedure OpenStoreAccInfo;
    procedure CloseStoreAccInfo;
    procedure OpenStorePayments();
    procedure CloseStorePayments();

    procedure LoadLogoImage;
    procedure LoadReport(sReport : String);
    procedure ehReport_BeforePrint(Sender: TObject);
    procedure ehReport_OnEndPage(Sender, aPage: TObject);
    procedure ehReport_OnStartPage(Sender, aPage: TObject);

  public
    function Start(AIDStoreAccount: Integer): Boolean;
    function DesignReport: Boolean;
  end;

implementation

uses //uDM, uDMGlobal, uSQLFunctions, JPEG, ppTypes, uSystemConst, StrUtils;
uDM, XBase, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst, Variants,
     uStringFunctions, ppTypes, Math, uNumericFunctions, raIDE,
     ppCTDsgn, ppChrt, PsRBRoutines, StrUtils, ConvUtils, uInvoiceInfo;


{$R *.dfm}

{ TFrmPrintStoreAccount }

procedure TFrmPrintStoreAccount.ehReport_BeforePrint(Sender: TObject);
begin
  if (ppReport.PrinterDevice <> nil) then
  begin
    ppReport.PrinterDevice.OnEndPage   := ehReport_OnEndPage;
    ppReport.PrinterDevice.OnStartPage := ehReport_OnStartPage;
  end;
end;


procedure TFrmPrintStoreAccount.LoadReport(sReport : String);
var
  sMessage: String;
  saveDefaultTemplate: String;
begin

  if sReport <> '[SYSTEM]' then begin
    // Antonio M F Souza 10.03.2011 - begin
    saveDefaultTemplate := ppReport.Template.FileName;
    ppReport.Template.FileName := sReport;
 end;

 // Antonio M F Souza 10.03.2011 - end
 if FileExists(sReport) then
 begin
    // Antonio, August 13, 2013
    ppReport.Reset;

    ppReport.Template.FileName := sReport;
    ppReport.Template.LoadFromFile;
    ppReport.AllowPrintToArchive := True;
    ppReport.AllowPrintToFile    := True;
 end
  //Antonio M F Souza 10.20.2011 - begin
 else begin
    sMessage := 'Receipt specified in client parameters is not present. Default receipt will be used instead';
    application.MessageBox(Pchar(sMessage), 'File not found', mb_OK + mb_IconStop);
    ppReport.Template.Filename := saveDefaultTemplate;
 end;
  //Antonio M F Souza 10.20.2011 - end

 if DM.fPrintReceipt.StoreAccReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := dm.fPrintReceipt.StoreAccReportPrinter; //DM.fPrintReceipt.InvoiceReportPrinter;

 if DM.fPrintReceipt.Preview then begin
    ppReport.DeviceType := dtScreen
 end else begin
          ppReport.DeviceType      := dtPrinter;
          ppReport.ShowPrintDialog := False;
     end;

  {
  if DM.fPrintReceipt.UseUSBPrinter then
    ppReport.BeforePrint := ehReport_BeforePrint;
  }

  LoadLogoImage;
end;


function TFrmPrintStoreAccount.DesignReport: Boolean;
begin
  Result := True;
  try
    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

procedure TFrmPrintStoreAccount.LoadLogoImage;
begin
  //Nada
end;

function TFrmPrintStoreAccount.PrintReport: Boolean;
begin

  try
    ppReport.PrinterSetup.Copies :=  DM.fPrintReceipt.StoreAccReportNumCopy;
    loadReport(dm.fPrintReceipt.StoreAccReportPath);
    ppReport.Print;

//    fPrintFooter := true;

    if ( FPrintFooter ) then begin
      //Footer
        ppReport.PrinterSetup.Copies := 2; //DM.fPrintReceipt.StoreAccReportNumCopy;
        LoadReport(dm.fPrintReceipt.StoreAccFooterPath);
        try
          ppReport.Print;
        except
          raise;
        end;
    end;

    Result := True;
  except
    Result := False;
  end;

end;

function TFrmPrintStoreAccount.Start(AIDStoreAccount: Integer): Boolean;
begin

  FIDStoreAccount := AIDStoreAccount;
  OpenStoreAccInfo;
  OpenStorePayments();
  PrintReport;

  Self.Close;

end;

procedure TFrmPrintStoreAccount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  CloseStoreAccInfo;
  Action := caFree;

end;

procedure TFrmPrintStoreAccount.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPrintStoreAccount.CloseStoreAccInfo;
begin
  with quStoreAccInfo do
    if Active then
      Close;
end;

procedure TFrmPrintStoreAccount.OpenStoreAccInfo;
begin

   quStoreAccInfo.close();
   quStoreAccInfo.Parameters.ParamByName('IDStoreAccount').Value := FIDStoreAccount;
   quStoreAccInfo.Open();



end;

procedure TFrmPrintStoreAccount.ehReport_OnEndPage(Sender, aPage: TObject);
begin
  if (DM.fPrintReceipt.USBCutCode <> '') then
    DM.SendPrinterCommands(ppReport.Printer.Canvas, DM.GetPrinterCode(DM.fPrintReceipt.USBCutCode));

end;

procedure TFrmPrintStoreAccount.ehReport_OnStartPage(Sender,
  aPage: TObject);
begin
  (*
  if (DM.fCashRegister.Open) and FPaymentDrawKick and (DM.fPrintReceipt.USBOpenDraw <> '') then
    DM.SendPrinterCommands(ppReport.Printer.Canvas, DM.GetPrinterCode(DM.fPrintReceipt.USBOpenDraw));
  *)
end;

procedure TFrmPrintStoreAccount.CloseStorePayments;
begin
    quPayments.close;
end;

procedure TFrmPrintStoreAccount.OpenStorePayments;
begin
   quPayments.Close;
   quPayments.Parameters.ParamByName('IDLancamento').Value := quStoreAccInfo.fieldByName('IdLancamento').Value;
   quPayments.Open;
end;


procedure TFrmPrintStoreAccount.quPaymentsCalcFields(DataSet: TDataSet);
var
  cvmValue, CardInfo : String;
  tempString : String;
begin
  inherited;
  case quPaymentsPaymentPlace.AsInteger of
    0: quPaymentsPaymentPlaceDesc.AsString  := sPayStore;
    1: quPaymentsPaymentPlaceDesc.AsString  := sPayOuter;
    else quPaymentsPaymentPlaceDesc.AsString := sPayOther;
  end;

  if quPaymentsPayType.AsInteger = PAY_TYPE_CASH then begin

    //controle criado pois a impressao do relatorio chama o evento vairias vezes
    if Assigned(FChangeList) and (FChangeList.IndexOf(quPaymentsIDLancamento.AsString) = -1) then
    begin
      FChangeList.Add(quPaymentsIDLancamento.AsString);
      MyChange := MyChange + quPaymentsValorNominal.AsFloat;
    end;

    {
    if ((quPaymentsCashReceived.AsFloat - MyChange) > 0) then
      quPaymentsChange.AsFloat := quPaymentsCashReceived.AsFloat - MyChange
    else
      quPaymentsChange.AsFloat := 0;
     }
  end;

  CardInfo := quPaymentsNumMeioQuitPreVisto.AsString;
  if CardInfo <> '' then
     if PosEx('A:', CardInfo) > 0 then begin
       quPaymentsAuthorization.AsString := Copy(CardInfo, Pos('A:', (CardInfo))+2, Pos(' R:', CardInfo)-2);

        // Antonio 01/29/2016
//        showmessage('Payment authorization ' + quPaymentsAuthorization.AsString);
        FPrintFooter := ( quPaymentsAuthorization.AsString <> '' );

       quPaymentsCardNumber.AsString    := '************' + Copy(CardInfo, Pos('L:', CardInfo)+2, 4);
       // Alex 09/30/2015
       // Antonio 09/28/2015
       //quPaymentsMerchantID.AsString := copy(cardInfo, pos('M:', (cardInfo))+2, pos(' E:', cardInfo)-2);

       tempString := copy(cardInfo, Pos('M:',cardInfo)+2, Length(cardinfo));
       tempString := copy(tempString, 0, Pos('E:',(tempString) ) -1);
       quPaymentsMerchantID.AsString := Trim(tempString);

//       quPaymentsNumMeioQuitPreVisto.AsString := BuildExtraInformationText( cardInfo );
//       showMessage('NumMeioQuitPrevisto ' + quPaymentsNumMeioQuitPreVisto.AsString );


       tempString := copy(cardInfo, Pos('CVM:',cardInfo)+4, Length(cardinfo));
       tempString := copy(tempString, 0, Pos('TC:',(tempString) ) -1);
       cvmValue := Trim(tempString);
       If ( cvmValue = 'PIN VERIFIED') Then
         quPaymentsMessageField1.AsString := 'BY ENTERING A VERIFIED PIN, CARDHOLDER AGREES TO PAY ISSUER SUCH '+
                                             'TOTAL IN ACCORDANCE WITH ISSUER''S AGREEMENT WITH CARDHOLDER'
       Else
         quPaymentsMessageField1.AsString := 'I AGREE TO PAY THE ABOVE TOTAL AMOUNT ACCORDING '+
                                             'TO CARD ISSUER AGREEMENT (MERCHANT AGREEMENT IF CREDIT VOUCHER)';


       tempString := copy(cardInfo, Pos('C:',cardInfo)+2, Length(cardinfo));
       tempString := Trim(copy(tempString, 0, Pos('P:',(tempString) ) -1));

       quPaymentsIsChip.Value := ( tempString = 'chip');

       //Alex 10/01/2015
       if ( quPaymentsIsChip.Value = True ) then begin
          // TODO: Change this to a label os a proper field
          quPaymentsCustomerDocument.AsString := IfThen( reprint = True, 'Customer Copy', 'Merchant Copy' );
       end;

     end
     else
       begin
       quPaymentsAuthorization.AsString := quPaymentsNumMeioQuitPreVisto.AsString;
       quPaymentsCardNumber.AsString    := getGCNumberMasked(cardInfo);
       // Antonio M F Souza 13, 2012 - quPaymentsCardNumber.AsString    := '************0000';
       end;

end;


procedure TFrmPrintStoreAccount.FormCreate(Sender: TObject);
begin
  inherited;
  FChangeList := TStringList.Create;
//  FLayawayPayments := TStringList.Create;
end;

procedure TFrmPrintStoreAccount.quPaymentsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  MyChange := 0;
  if Assigned(FChangeList) then begin
    FChangeList.Clear;
  end;

  {
  //Antonio M F Souza 10.29.2010 : To layaway remains to each sale item.
  FSumLayawayPaid := 0;
  if Assigned(FLayawayPayments) then begin
    FLayawayPayments.Clear;
  end;
  }
end;

procedure TFrmPrintStoreAccount.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FChangeList);
  freeAndNil(FLayawayPayments);
end;

function TFrmPrintStoreAccount.BuildExtraInformationText(
  originalText: String): String;
Var
  cmvPosition : Integer;
  tempString : String;
  List: TStringList;
begin
  originalText := StringReplace(originalText, 'Visa Credit', 'Visa_Credit', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'PIN VERIFIED', 'PIN_VERIFIED', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'NO CVM', 'NO_CVM', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'OFFLINE PIN', 'OFFLINE_PIN', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'ONLINE PIN', 'ONLINE_PIN', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'EMV', '', [rfReplaceAll]);

  cmvPosition := IfThen( Pos( 'CVM:', originalText ) > 0, Pos( 'CVM:', originalText ), Length( originalText ) );
  tempString := Copy( originalText, 0, cmvPosition );

  List := TStringList.Create;
  ExtractStrings([' '], [], PChar(originalText), List);

  If ( Pos('chip',originalText ) > 0 ) Then Begin
    If ( Pos('CHIP',List[4] ) > 0 ) Then Begin
      Result := StringReplace(List[8], 'P:', 'Application Label:', [rfReplaceAll, rfIgnoreCase]) + #13 +
                StringReplace(List[1], 'R:', 'Reference:', [rfReplaceAll, rfIgnoreCase]) + #13 +
                StringReplace(List[4], 'E:', 'Entry Method:', [rfReplaceAll, rfIgnoreCase]) + #13 +
                List[9]  + #13 +
                List[10] + #13 +
                List[11] + #13 +
                List[12] + #13 +
                List[13] + #13 +
                StringReplace(List[14], '_', ' ', [rfReplaceAll, rfIgnoreCase]) + #13 +
                StringReplace(List[15], 'TC:', 'Transaction Type:', [rfReplaceAll, rfIgnoreCase]);
    End Else Begin
      Result := StringReplace(List[1], 'R:', 'Reference:', [rfReplaceAll, rfIgnoreCase]) + #13 +
                StringReplace(List[4], 'E:', 'Entry Method:', [rfReplaceAll, rfIgnoreCase]) + #13 +
                StringReplace(List[15],'TC:', 'Transaction Type:', [rfReplaceAll, rfIgnoreCase]);
    End;
  End;
end;

function TFrmPrintStoreAccount.getGCNumberMasked(
  pGCNumber: String): String;
var
   i: Integer;
   gcNumberMasked: String;
   posPoundChar: Integer;
begin
   //Antonio M F Souza October 31, 2012
   gcNumberMasked := pGCNumber;

   if ( (length(pGCNumber) - 1) > 4 ) then begin
       for i:= length(pGCNumber) downto 0 do begin
           if ( i <= (length(pGCNumber)- 4) ) then begin
              pGCNumber[i] := '*';
           end;
       end;
       gcNumberMasked := pGCNumber;
   end;
//   posPoundChar := pos('#', gcNumberMasked);
//   delete(gcNumberMasked, posPoundChar, 1);
   result := gcNumberMasked;
end;

end.
