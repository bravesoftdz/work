unit uLeituraData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ComCtrls;

type
  TFrmLeituraData = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    optCompleta: TRadioButton;
    optSimplificada: TRadioButton;
    dtpInicial: TDateTimePicker;
    dtpFinal: TDateTimePicker;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLeituraData: TFrmLeituraData;

implementation

uses uDM;

{$R *.DFM}

Procedure TFrmLeituraData.btnOkClick(Sender: TObject);
var cParametro3:string;
Begin
   with DM.EFiscal1 do begin
   if Caption = 'Leitura da Memória Fiscal por Datas' then begin
      //Bematech_FI_LeituraMemoriaFiscalData( DateToStr(dtpInicial.date), DateToStr(dtpFinal.date));
   end;
   if Caption = 'Leitura da Memória Fiscal por Datas MFD' then begin
      if optCompleta.Checked = true then
         cParametro3 := 'c'
      else
         cParametro3 := 's';

         //Bematech_FI_LeituraMemoriaFiscalDataMFD( DateToStr(dtpInicial.date), DateToStr(dtpFinal.date), cParametro3);
   end;
   if Caption = 'Leitura da Memória Fiscal Serial por Datas MFD' then begin
      if optCompleta.Checked = true then
         cParametro3 := 'c'
      else
         cParametro3 := 's';

      //Bematech_FI_LeituraMemoriaFiscalSerialDataMFD( DateToStr(dtpInicial.date), DateToStr(dtpFinal.date), cParametro3);
      Application.MessageBox( 'RETORNO.TXT criado com sucesso !', 'Atenção', MB_IconInformation + MB_OK );
   end;
   end;
   Close;
End;

Procedure TFrmLeituraData.btnCancelClick(Sender: TObject);
Begin
Close;
End;

End.
