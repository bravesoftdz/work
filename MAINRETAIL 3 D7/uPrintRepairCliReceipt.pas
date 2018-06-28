unit uPrintRepairCliReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, siComp, siLangRT,
  PaiDeForms, PaidePrinter;

type
  TPrintRepairCliReceipt = class(TFrmParentPrint)
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
  private
    { Private declarations }
    sHeader,
    sRepairN,
    sDate,
    sTime,
    sReceivedBy,
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
  public
    { Public declarations }
    procedure Start(IDRepairCli : Integer);
  end;

implementation

uses uDM, uPassword, xBase, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

procedure TPrintRepairCliReceipt.Start(IDRepairCli : Integer);
var
   NotOk: Boolean;
begin

     Quit := False;

     with quRepair do
       begin
         Parameters.ParambyName('IDRepairCli').Value := IDRepairCLi;
         Open;
       end;

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

     ImpMemoDBInfo(quRepairTicketHeader.AsString);
     DM.PrintLine('');
     DM.PrintLine(sHeader);
     DM.PrintLine('   ----------------------------------');
     DM.PrintLine('');
     DM.PrintLine(sRepairN    + quRepairIDRepair.AsString);
     DM.PrintLine(sDate       + DateToStr(quRepairReceiveDate.AsDateTime));
     DM.PrintLine(sTime       + TimeToStr(Now));
     DM.PrintLine(sReceivedBy + quRepairSysUser.AsString);
     DM.PrintLine('');
     DM.PrintLine(sModel      + quRepairModel.AsString);
     DM.PrintLine(sSerial     + quRepairSerialNumber.AsString);
     DM.PrintLine(sDesc       + quRepairDescription.AsString);
     DM.PrintLine(sQty        + quRepairQty.AsString);
     DM.PrintLine('');
     DM.PrintLine(sCustomer   + quRepairCustomer.AsString);
     DM.PrintLine(sAddress    + quRepairAddress.AsString);
     DM.PrintLine('');
     DM.PrintLine(sOBS        + quRepairOBSLine1.AsString);
     DM.PrintLine('            ' + quRepairOBSLine2.AsString);
     DM.PrintLine('            ' + quRepairOBSLine3.AsString);
     DM.PrintLine('            ' + quRepairOBSLine4.AsString);
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

   quRepair.Close;

   Close;
end;

procedure TPrintRepairCliReceipt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintRepairCliReceipt.FormShow(Sender: TObject);
begin
  AniPrint.Active   := True;
  btOk.Visible      := False;
end;

procedure TPrintRepairCliReceipt.btOkClick(Sender: TObject);
begin
  Close;
end;


procedure TPrintRepairCliReceipt.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sHeader     := '     R E P A I R      R E C E I P T';
           sRepairN    := 'Repair # ';
           sDate       := 'Date       : ';
           sTime       := 'Time       : ';
           sReceivedBy := 'Returned by: ';
           sModel      := 'Model      : ';
           sSerial     := 'Serial #   : ';
           sDesc       := 'Description: ';
           sQty        := 'Qty        : ';
           sCustomer   := 'Customer   : ';
           sAddress    := 'Address    : ';
           sOBS        := 'OBS        : ';
           sFooter     := '===============END OF TICKET============';
           sRecImpresso:= 'Receipt Printed';
           sClickOK    := 'Click OK to continue';
           end;

     LANG_PORTUGUESE :
           begin
           sHeader     := '     R E C I B O  D E  R E P A R O  ';
           sRepairN    := 'N. Reparo ';
           sDate       := 'Data       : ';
           sTime       := 'Hora       : ';
           sReceivedBy := 'Usuário    : ';
           sModel      := 'Modelo     : ';
           sSerial     := 'N. Série   : ';
           sDesc       := 'Descrição  : ';
           sQty        := 'Qtd        : ';
           sCustomer   := 'Cliente    : ';
           sAddress    := 'Endereço   : ';
           sOBS        := 'OBS        : ';
           sFooter     := '===============FINAL DO RECIBO==========';
           sRecImpresso:= 'Recibo Impresso';
           sClickOK    := 'Clique OK para continuar';
           end;

     LANG_SPANISH :
           begin
           sHeader     := 'R E C I B O  D E  R E P A R A C I O N';
           sRepairN    := 'N. Reparación ';
           sDate       := 'Fecha      : ';
           sTime       := 'Hora       : ';
           sReceivedBy := 'Usuario    : ';
           sModel      := 'Modelo     : ';
           sSerial     := 'N. Série   : ';
           sDesc       := 'Descripción: ';
           sQty        := 'Ctd        : ';
           sCustomer   := 'Cliente    : ';
           sAddress    := 'Dirección  : ';
           sOBS        := 'OBS        : ';
           sFooter     := '===============FINAL DEL RECIBO==========';
           sRecImpresso:= 'Recibo Imprimido';
           sClickOK    := 'Clic OK para continuar';
           end;
   end;


end;

end.
