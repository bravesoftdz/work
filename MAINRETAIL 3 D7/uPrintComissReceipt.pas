unit uPrintComissReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, siComp, siLangRT,
  PaiDeForms;

const
   COMIS_AGENCY     = 1;
   COMIS_SALESPRSON = 2;
   COMIS_OTHER      = 3;

type
  TPrintComissReceipt = class(TFrmParentForms)
    lblPrint: TLabel;
    pnlPrinter: TPanel;
    AniPrint: TAnimate;
    btOk: TButton;
    quLancamento: TADOQuery;
    quLancamentoDataLancamento: TDateTimeField;
    quLancamentoTotalQuitado: TFloatField;
    quLancamentoIDLancamento: TIntegerField;
    quLancamentoPessoa: TStringField;
    quLancamentoValorNominal: TFloatField;
    quLancamentoPessoaLastName: TStringField;
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
    sDate,
    sAmount,
    sAgency,
    sSP,
    sCommis,
    sSignature,
    sNome,
    sPayBy,
    sEndTicket,
    sRecImpresso,
    sClickOK : String;

    MyIDLancamento : Integer;
    Quit           : Boolean;
    procedure ImpHeaderReceipt(Date: TDateTime; Valor: Currency; Title, Pessoa : String; Reprint: Boolean);
    procedure ImpFooter;
  public
    { Public declarations }
    procedure Start(IDLancamento : Integer; Tipo : integer; Reprint: Boolean);
  end;

implementation

uses uDM, uPassword, XBase, uMsgBox, uMsgConstant, uNumericFunctions,
     uSqlFunctions, uDateTimeFunctions, uDMGlobal;

{$R *.DFM}

procedure TPrintComissReceipt.Start( IDLancamento : Integer;
                                     Tipo : integer;
                                     Reprint: Boolean);
var
  Title : String;
  NotOk: Boolean;

begin
     Quit := False;

     MyIDLancamento := IDLancamento;
     with quLancamento do
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

     case Tipo of
          COMIS_AGENCY     :  Title := sAgency;
          COMIS_SALESPRSON :  Title := sSP;
          COMIS_OTHER      :  Title := sCommis;
     end;

     // -----------------------------------------------------------------
     // Impressão do cabecalho do ticket
     ImpHeaderReceipt( quLancamentoDataLancamento.AsDateTime,
                       quLancamentoValorNominal.AsCurrency,
                       Title, quLancamentoPessoa.AsString, Reprint);

     // -----------------------------------------------------------------
     // Impressão dos Totais
     ImpFooter;

   DM.PrintLine(Chr(27)+Chr(12));
   DM.PrinterStop;

   lblPrint.Caption   := sRecImpresso;
   btOk.Visible       := True;
   AniPrint.Active    := False;
   AniPrint.Visible   := False;
   pnlPrinter.Caption := sClickOK;
   Close;
end;

procedure TPrintComissReceipt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TPrintComissReceipt.ImpHeaderReceipt(Date: TDateTime; Valor: Currency ; Title, Pessoa : String; Reprint: Boolean);
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
  DM.PrintLine(Title + ' ' + Pessoa);
  DM.PrintLine('');
  DM.PrintLine(sDate   + DateToStr(Date) );
  DM.PrintLine(sAmount + FormatCurr('#,##0.00', Valor));
  DM.PrintLine('');
  DM.PrintLine('');
end;

procedure TPrintComissReceipt.ImpFooter();
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

procedure TPrintComissReceipt.FormShow(Sender: TObject);
begin
  // Associa o fileName do Avi
  AniPrint.Active   := True;
  btOk.Visible := False;
end;

procedure TPrintComissReceipt.btOkClick(Sender: TObject);
begin
  Close;
end;


procedure TPrintComissReceipt.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sCommReceipt := '   C O M M I S S I O N  R E C E I P T   ';
           sReprint     := '   !!         R E P R I N T        !!   ';
           sNoPayable   := '   !!    N O T    P A Y A B L E    !!   ';
           sDate        := '  Date  : ';
           sAmount      := ' Amount : ';
           sSignature   := '                Signature';
           sNome        := '                  Name';
           sPayBy       := '                Payed By';
           sEndTicket   := '===============END OF TICKET============';
           sAgency      := 'Agency :';
           sSP          := 'Sales Person :';
           sCommis      := 'Commission :';
           sRecImpresso := 'Receipt Printed';
           sClickOK     := 'Click OK to continue';
           end;

     LANG_PORTUGUESE :
           begin
           sCommReceipt := '   R E C I B O  DE  C O M I S S A O     ';
           sReprint     := '   !!     R E  I M P R E S S O     !!   ';
           sNoPayable   := '   !!      N Ã O    P A G A R      !!   ';
           sDate        := '  Data  : ';
           sAmount      := '  Valor : ';
           sSignature   := '                Assinatura';
           sNome        := '                   Nome';
           sPayBy       := '                 Pago por';
           sEndTicket   := '=============FINAL DO RECIBO============';
           sAgency      := 'Agencia :';
           sSP          := 'Vendedor :';
           sCommis      := 'Comissionado :';
           sRecImpresso := 'Recibo Impresso';
           sClickOK     := 'Clique OK para continuar';
           end;

     LANG_SPANISH :
           begin
           sCommReceipt := '   R E C I B O   DE   C O M I S I O N   ';
           sReprint     := '   !!       D U P L I C A D O      !!   ';
           sNoPayable   := '   !!       N O    P A G A R       !!   ';
           sDate        := '  Fecha : ';
           sAmount      := '  Valor : ';
           sSignature   := '                 Firma';
           sNome        := '                 Nombre';
           sPayBy       := '               Pagado por';
           sEndTicket   := '==============FINAL DEL RECIBO==========';
           sAgency      := 'Agencia :';
           sSP          := 'Vendedor :';
           sCommis      := 'Comisión :';
           sRecImpresso := 'Recibo Imprimido';
           sClickOK     := 'Clic OK para continuar';
           end;
   end;


end;

end.
