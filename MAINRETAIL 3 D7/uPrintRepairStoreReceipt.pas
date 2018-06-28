unit uPrintRepairStoreReceipt;

interface                                   
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, siComp, PaiDeForms,
  siLangRT, PaidePrinter;

type
  TRepairReceipt = class
    TicketHeader : String;
    RepairNumber : String;
    Model        : String;
    Description  : String;
    RecDate      : TDateTime;
    ReturnedBy   : String;
    SerialNum    : String;
    Qty          : Double;
    Customer     : String;
    Address      : String;
    Obs          : String;
    Vendor       : String;
    Store        : String;
    DefectType   : String;
  end;


  TPrintRepairStoreReceipt = class(TFrmParentPrint)
    lblPrint: TLabel;
    pnlPrinter: TPanel;
    AniPrint: TAnimate;
    btOk: TButton;
    quRepair: TADOQuery;
    quRepairCustomer: TStringField;
    quRepairAddress: TStringField;
    quRepairReceiveDate: TDateTimeField;
    quRepairModel: TStringField;
    quRepairDescription: TStringField;
    quRepairOBSReceive: TStringField;
    quRepairIDRepair: TIntegerField;
    quRepairSysUser: TStringField;
    quRepairSerialNumber: TStringField;
    quRepairBackDate: TDateTimeField;
    quRepairOBSLine1: TStringField;
    quRepairOBSLine2: TStringField;
    quRepairOBSLine3: TStringField;
    quRepairOBSLine4: TStringField;
    quRepairTicketHeader: TMemoField;
    quRepairQty: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quRepairAfterOpen(DataSet: TDataSet);
  private
    RepairReceipt : TRepairReceipt;

    //Translation
    sHeader,
    sRepairN,
    sDate,
    sVendor,
    sTime,
    sReturnedBy,
    sModel,
    sSerial,
    sDesc,
    sQty,
    sCustomer,
    sAddress,
    sOBS,
    sFooter,
    sRecImpresso,
    sClickOK : String;

    MyIDLancamento : Integer;
    Quit           : Boolean;
    procedure PrintReceipt;
    procedure PrintSaleRepairReceipt(ARepairtList : TStringList);
  public
    procedure Start(IDRepairCli : Integer); overload;
    procedure Start(ARepairReceiptList : TStringList); overload;
  end;

implementation

uses uDM, uPassword, xBase, uMsgBox, uMsgConstant, uDMGlobal, Math;

{$R *.DFM}

procedure TPrintRepairStoreReceipt.PrintReceipt;
var
  NotOk: Boolean;
begin
   Quit := False;

   Show;
   Update;

   NotOk := True;

   Application.ProcessMessages;

   while NotOk do
     begin
       try
         DM.PrinterStart;
         NotOk := False;
       except
         if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
           NotOk := True
         else
           begin
             Exit;
           end;
       end;
     end;

   DM.PrintLine(RepairReceipt.TicketHeader);
   DM.PrintLine('');
   DM.PrintLine(sHeader);
   DM.PrintLine('   ----------------------------------');
   DM.PrintLine('');
   DM.PrintLine(sRepairN    + RepairReceipt.RepairNumber);
   DM.PrintLine(sDate       + FormatDateTime('ddddd', RepairReceipt.RecDate));
   DM.PrintLine(sTime       + TimeToStr(RepairReceipt.RecDate));
   DM.PrintLine(sReturnedBy + RepairReceipt.ReturnedBy);
   DM.PrintLine('');
   DM.PrintLine(sModel      + RepairReceipt.Model);
   DM.PrintLine(sSerial     + RepairReceipt.SerialNum);
   DM.PrintLine(sDesc       + RepairReceipt.Description);
   DM.PrintLine(sQty        + FormatFloat('0.##', RepairReceipt.Qty));
   DM.PrintLine('');
   DM.PrintLine(sCustomer   + RepairReceipt.Customer);
   DM.PrintLine(sAddress    + RepairReceipt.Address);
   DM.PrintLine('');
   DM.PrintLine(sOBS        + RepairReceipt.Obs);
   DM.PrintLine('');
   DM.PrintLine('');
   DM.PrintLine(sFooter);
   DM.PrintLine('');
   DM.PrintLine('');
   DM.PrintLine('');
   DM.PrintLine('');
   DM.PrintLine('');
   DM.PrintLine('.');

   DM.PrintLine(Chr(27)+Chr(12));
   DM.PrinterStop;

   lblPrint.Caption   := sRecImpresso;
   btOk.Visible       := True;
   AniPrint.Active    := False;
   AniPrint.Visible   := False;
   pnlPrinter.Caption := sClickOK;

   Close;

end;


procedure TPrintRepairStoreReceipt.Start(IDRepairCli : Integer);
begin

  try
    with quRepair do
     begin
       Parameters.ParambyName('IDRepairCli').Value := IDRepairCLi;
       Open;
     end;
    PrintReceipt;
  finally
    quRepair.Close;
    end;

end;

procedure TPrintRepairStoreReceipt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  if Assigned(RepairReceipt) then
    FreeAndNil(RepairReceipt); 
end;

procedure TPrintRepairStoreReceipt.FormShow(Sender: TObject);
begin
  AniPrint.Active   := True;
  btOk.Visible      := False;
end;

procedure TPrintRepairStoreReceipt.btOkClick(Sender: TObject);
begin
  Close;
end;


procedure TPrintRepairStoreReceipt.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sHeader     := '     R E P A I R      R E C E I P T';
           sRepairN    := 'Repair # ';
           sDate       := 'Date       : ';
           sVendor     := 'Vendor     : ';
           sTime       := 'Time       : ';
           sReturnedBy := 'Returned by: ';
           sModel      := 'Model      : ';
           sSerial     := 'Serial #   : ';
           sDesc       := 'Description: ';
           sQty        := 'Qty        : ';
           sCustomer   := 'Customer   : ';
           sAddress    := 'Address    : ';
           sOBS        := 'OBS        : ';
           sFooter     := '============= END OF TICKET ==========';
           sRecImpresso:= 'Receipt Printed';
           sClickOK    := 'Click OK to continue';
           end;

     LANG_PORTUGUESE :
           begin
           sHeader     := '     R E C I B O  D E  R E P A R O ';
           sRepairN    := 'N. Reparo ';
           sDate       := 'Data       : ';
           sVendor     := 'Fornecedor : ';
           sTime       := 'Hora       : ';
           sReturnedBy := 'Usuario    : ';
           sModel      := 'Modelo     : ';
           sSerial     := 'N. Série   : ';
           sDesc       := 'Descrição  : ';
           sQty        := 'Qtd        : ';
           sCustomer   := 'Cliente    : ';
           sAddress    := 'Endereco   : ';
           sOBS        := 'OBS        : ';
           sFooter     := '============ FINAL DO RECIBO =========';
           sRecImpresso:= 'Recibo Impresso';
           sClickOK    := 'Clique OK para continuar';
           end;

     LANG_SPANISH :
           begin
           sHeader     := 'R E C I B O  DE  R E P A R A C I O N';
           sRepairN    := 'N. Reparación ';
           sDate       := 'Fecha      : ';
           sVendor     := 'Fornecedor : ';
           sTime       := 'Hora       : ';
           sReturnedBy := 'Usuario    : ';
           sModel      := 'Modelo     : ';
           sSerial     := 'N. Serie   : ';
           sDesc       := 'Descripcion: ';
           sQty        := 'Ctd        : ';
           sCustomer   := 'Cliente    : ';
           sAddress    := 'Dirección  : ';
           sOBS        := 'OBS        : ';
           sFooter     := '============ FINAL DEL RECIBO =========';
           sRecImpresso:= 'Recibo Imprimido';
           sClickOK    := 'Clic OK para continuar';
           end;
   end;

   RepairReceipt := TRepairReceipt.Create;

end;

procedure TPrintRepairStoreReceipt.quRepairAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RepairReceipt.RepairNumber := quRepairIDRepair.AsString;
  RepairReceipt.Model        := quRepairModel.AsString;
  RepairReceipt.Description  := quRepairDescription.AsString;
  RepairReceipt.RecDate      := quRepairBackDate.AsDateTime;
  RepairReceipt.ReturnedBy   := quRepairSysUser.AsString;
  RepairReceipt.SerialNum    := quRepairSerialNumber.AsString;
  RepairReceipt.Qty          := quRepairQty.AsFloat;
  RepairReceipt.Customer     := quRepairCustomer.AsString;
  RepairReceipt.Address      := quRepairAddress.AsString;
  RepairReceipt.Obs          := quRepairOBSLine1.AsString + ' ' + quRepairOBSLine2.AsString + ' ' +
                                quRepairOBSLine3.AsString + ' ' + quRepairOBSLine4.AsString;
  RepairReceipt.Vendor       := '';
  RepairReceipt.TicketHeader := quRepairTicketHeader.AsString;
end;


procedure TPrintRepairStoreReceipt.Start(ARepairReceiptList : TStringList);
begin
  PrintSaleRepairReceipt(ARepairReceiptList);
end;

procedure TPrintRepairStoreReceipt.PrintSaleRepairReceipt(ARepairtList : TStringList);
var
  NotOk: Boolean;
  i : Integer;
begin
   Quit := False;

   Show;
   Update;

   NotOk := True;

   Application.ProcessMessages;

    for i := 0 to ARepairtList.Count-1 do
    begin
      while NotOk do
      begin
        try
          DM.PrinterStart;
          NotOk := False;
        except
          if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
            NotOk := True
          else
            Exit;
        end;
      end;

      RepairReceipt.RepairNumber := TRepairReceipt(ARepairtList.Objects[i]).RepairNumber;
      RepairReceipt.Model        := TRepairReceipt(ARepairtList.Objects[i]).Model;
      RepairReceipt.Description  := TRepairReceipt(ARepairtList.Objects[i]).Description;
      RepairReceipt.RecDate      := TRepairReceipt(ARepairtList.Objects[i]).RecDate;
      RepairReceipt.ReturnedBy   := TRepairReceipt(ARepairtList.Objects[i]).ReturnedBy;
      RepairReceipt.SerialNum    := TRepairReceipt(ARepairtList.Objects[i]).SerialNum;
      RepairReceipt.Qty          := TRepairReceipt(ARepairtList.Objects[i]).Qty;
      RepairReceipt.Customer     := TRepairReceipt(ARepairtList.Objects[i]).Customer;
      RepairReceipt.Address      := TRepairReceipt(ARepairtList.Objects[i]).Address;
      RepairReceipt.Obs          := TRepairReceipt(ARepairtList.Objects[i]).Obs;
      RepairReceipt.Vendor       := TRepairReceipt(ARepairtList.Objects[i]).Vendor;
      RepairReceipt.Store        := TRepairReceipt(ARepairtList.Objects[i]).Store;
      RepairReceipt.DefectType   := TRepairReceipt(ARepairtList.Objects[i]).DefectType;

      DM.PrintLine(sHeader);
      DM.PrintLine('   ----------------------------------');
      if RepairReceipt.RepairNumber <> '' then
       DM.PrintLine(sRepairN    + RepairReceipt.RepairNumber);
      DM.PrintLine(sVendor     + RepairReceipt.Vendor);
      DM.PrintLine(sDate       + FormatDateTime('ddddd', RepairReceipt.RecDate) + ' ' + TimeToStr(RepairReceipt.RecDate));
      DM.PrintLine(sReturnedBy + RepairReceipt.ReturnedBy);
      DM.PrintLine(sModel      + RepairReceipt.Model);
      DM.PrintLine(sSerial     + RepairReceipt.SerialNum);
      DM.PrintLine(sDesc       + RepairReceipt.Description);
      DM.PrintLine(sQty        + FormatFloat('0.##', RepairReceipt.Qty));
      DM.PrintLine(sOBS        + RepairReceipt.Obs);
      DM.PrintLine(sFooter);
      DM.PrintLine('');
      DM.PrintLine('');
      DM.PrintLine('');
      DM.PrintLine('');

      DM.PrintLine(Chr(27)+Chr(12));

      DM.PrinterStop;
      NotOk := True;
   end;




   lblPrint.Caption   := sRecImpresso;
   btOk.Visible       := True;
   AniPrint.Active    := False;
   AniPrint.Visible   := False;
   pnlPrinter.Caption := sClickOK;

   Close;

end;

end.
