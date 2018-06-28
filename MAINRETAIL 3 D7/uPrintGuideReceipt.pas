unit uPrintGuideReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, siComp, siLangRT,
  PaiDeForms;

type
  TPrintGuideReceipt = class(TFrmParentForms)
    lblPrint: TLabel;
    pnlPrinter: TPanel;
    AniPrint: TAnimate;
    btOk: TButton;
    quTourGroup: TADOQuery;
    quLancamento: TADOQuery;
    quTourGroupEnterDate: TDateTimeField;
    quTourGroupNumTourist: TIntegerField;
    quTourGroupNumInvoices: TIntegerField;
    quLancamentoDataLancamento: TDateTimeField;
    quLancamentoTotalQuitado: TFloatField;
    quLancamentoIDLancamento: TIntegerField;
    quLancamentoGuide: TStringField;
    quLancamentoAgency: TStringField;
    quLancamentoGuideLastName: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sCommReceipt,
    sReprint,
    sNoPayable,
    sGuide,
    sAgenci,
    sDate,
    sAmount,
    sTourGroup,
    sPax,
    sInvoice,
    sSignature,
    sNome,
    sPayBy,
    sEndTicket,
    sRecImpresso,
    sClickOK : String;


    MyIDLancamento : Integer;
    ActualTime     : TDateTime;
    Quit           : Boolean;

    procedure ImpHeaderReceipt(Date: TDateTime; Valor: Currency ; Guide, Agency: String; Reprint: Boolean);
    procedure ImpLine(NumPax, NumInvoices: Integer; EnterDate: TDateTime);
    procedure ImpFooter;

  public
    { Public declarations }
    procedure Start(IDLancamento : Integer; Reprint: Boolean);

  end;


implementation

uses uDM, uPassword, uNumericFunctions, XBase, uMsgBox, uMsgConstant,
     uSqlFunctions, uDateTimeFunctions, uDMGlobal;

{$R *.DFM}

procedure TPrintGuideReceipt.Start(IDLancamento : Integer; Reprint: Boolean);
var
  NotOk: Boolean;

begin
     Quit := False;

     MyIDLancamento := IDLancamento;
     with quLancamento do
       begin
         Parameters.ParambyName('IDLancamento').Value := MyIDLancamento;
         Open;
       end;

     with quTourGroup do
       begin
         Parameters.ParambyName('IDLancamento').Value := MyIDLancamento;
         Open;
       end;

     Show;
     Update;

     Application.ProcessMessages;

     NotOk := True;

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

     // -----------------------------------------------------------------
     // Impressão do cabecalho do ticket


     ImpHeaderReceipt( quLancamentoDataLancamento.AsDateTime,
                       quLancamentoTotalQuitado.AsCurrency,
                       quLancamentoGuide.AsString + ','+ quLancamentoGuideLastName.AsString,
                       quLancamentoAgency.AsString, Reprint);

     // -----------------------------------------------------------------
     // Impressão dos tourgroups

     with quTourGroup do
       begin
          DisableControls;
          First;
          while not Eof do
            begin
              ImpLine( quTourGroupNumTourist.AsInteger,
                       quTourGroupNumInvoices.AsInteger,
                       quTourGroupEnterDate.AsDateTime);
              Next;
            end;
          EnableControls;
       end;

     // -----------------------------------------------------------------
     // Impressão dos Totais
     ImpFooter;

   DM.PrintLine(Chr(27)+Chr(12));
   DM.PrinterStop; 

   lblPrint.Caption := sRecImpresso;
   btOk.Visible     := True;
   AniPrint.Active  := False;
   AniPrint.Visible  := False;
   pnlPrinter.Caption := sClickOK;
   Close;
end;

procedure TPrintGuideReceipt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TPrintGuideReceipt.ImpHeaderReceipt( Date: TDateTime;
                                               Valor: Currency;
                                               Guide, Agency: String;
                                               Reprint: Boolean);
begin
  DM.PrintLine('========================================');
  DM.PrintLine(sCommReceipt);
  DM.PrintLine('   ----------------------------------   ');
  DM.PrintLine('');
  if Reprint then
    begin
      DM.PrintLine('');
      DM.PrintLine('   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   ');
      DM.PrintLine(sReprint);
      DM.PrintLine(sNoPayable);
      DM.PrintLine('   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   ');
      DM.PrintLine('');
    end;
  DM.PrintLine(sGuide  + Guide);
  DM.PrintLine(sAgenci + Agency);
  DM.PrintLine('');
  DM.PrintLine(sDate   + DateToStr(Date) );
  DM.PrintLine(sAmount + FloatToStrF(Valor, ffCurrency, 20, 2));
  DM.PrintLine('');
  DM.PrintLine(sTourGroup);
  DM.PrintLine('');
end;


procedure TPrintGuideReceipt.ImpLine(NumPax, NumInvoices: Integer; EnterDate: TDateTime);
begin
  DM.PrintLine('   ' + DateToStr(EnterDate)+ ' ' +sPax + RightStr('    ' + IntToStr(NumPax) ,3) + sInvoice + RightStr('    ' + IntToStr(NumInvoices) ,3) );
  DM.PrintLine('');
end;

procedure TPrintGuideReceipt.ImpFooter();
begin
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('  ------------------------------------  ');
  DM.PrintLine(sSignature);
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('  ------------------------------------  ');
  DM.PrintLine(sNome);
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('  ------------------------------------  ');
  DM.PrintLine(sPayBy);
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine(sEndTicket);
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
end;

procedure TPrintGuideReceipt.FormShow(Sender: TObject);
begin
  // Associa o fileName do Avi
  AniPrint.Active   := True;
  btOk.Visible := False;
end;

procedure TPrintGuideReceipt.btOkClick(Sender: TObject);
begin
  Close;
end;


procedure TPrintGuideReceipt.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sCommReceipt := '   C O M M I S S I O N  R E C E I P T   ';
           sReprint     := '   !!         R E P R I N T        !!   ';
           sNoPayable   := '   !!    N O T    P A Y A B L E    !!   ';
           sGuide       := '  Guide: ';
           sAgenci      := ' Agency: ';
           sDate        := '   Date: ';
           sAmount      := ' Amount: ';
           sTourGroup   := '-------------- Tour Groups -------------';
           sPax         := ' Pax:';
           sInvoice     := '  Invoices:';
           sSignature   := '                Signature';
           sNome        := '                  Name';
           sPayBy       := '                Payed By';
           sEndTicket   := '===============END OF TICKET============';

           sRecImpresso := 'Receipt Printed';
           sClickOK     := 'Click OK to continue';
           end;

     LANG_PORTUGUESE :
           begin
           sCommReceipt := '   R E C I B O   DE   C O M I S S A O   ';
           sReprint     := '   !!     R E - I M P R E S S O    !!   ';
           sNoPayable   := '   !!       N Ã O    P A G A R     !!   ';
           sGuide       := '  Guia : ';
           sAgenci      := 'Agencia: ';
           sDate        := '   Data: ';
           sAmount      := '  Valor: ';
           sTourGroup   := '----------- Grupo de Turísmo -----------';
           sPax         := 'Pasg:';
           sInvoice     := '     Notas:';
           sSignature   := '                Assinatura';
           sNome        := '                   Nome';
           sPayBy       := '                 Pago por';
           sEndTicket   := '=============FINAL DO RECEBO============';

           sRecImpresso := 'Recibo Impresso';
           sClickOK     := 'Clique OK para continuar';
           end;

     LANG_SPANISH :
           begin
           sCommReceipt := '   R E C I B O   DE   C O M I S I O N   ';
           sReprint     := '   !!      D U P L I C A D O       !!   ';
           sNoPayable   := '   !!      N O    P A G A R        !!   ';
           sGuide       := '  Guia : ';
           sAgenci      := 'Agencia: ';
           sDate        := ' Fecha : ';
           sAmount      := '  Valor: ';
           sTourGroup   := '-------------- Grupo Turismo -----------';
           sPax         := 'Pasj:';
           sInvoice     := '   Boletas:';
           sSignature   := '                 Firma';
           sNome        := '                 Nombre';
           sPayBy       := '               Pagado por';
           sEndTicket   := '==============FINAL DEL RECIBO==========';

           sRecImpresso := 'Recibo Imprimido';
           sClickOK     := 'Clic OK para continuar';
           end;
   end;


end;

end.
