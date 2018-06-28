unit uFrmPrintShippingOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmPrintShippingOption = class(TFrmParentAll)
    btnPrint: TButton;
    lbReport: TLabel;
    cbxReport: TComboBox;
    lbNumCopies: TLabel;
    edtNumCopy: TEdit;
    chkPreview: TCheckBox;
    cbxPrinter: TComboBox;
    lbPrinter: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPrintClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    FReceiptType,
    FIDPreSale : Integer;
    procedure FillDefaultPrinter;
  public
    function Start(IDPreSale, ReceiptType : Integer):Boolean;
  end;

implementation

uses uDM, uPrintReceipt, Printers, Registry;

{$R *.dfm}

procedure TFrmPrintShippingOption.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPrintShippingOption.btnPrintClick(Sender: TObject);
var
  AReport : String;
  APrinter : String;
  NumCopy : Integer;
  APreview : Boolean;
begin
  inherited;

  case cbxReport.ItemIndex of
    0 : AReport := DM.fCashRegister.ShippingPackingRep;
    1 : AReport := DM.fCashRegister.ShippingPickRep;
    2 : AReport := DM.fPrintReceipt.ReportPath;
  end;

  NumCopy  := StrToIntDef(edtNumCopy.Text, 1);
  APrinter := cbxPrinter.Text;
  APreview := chkPreview.Checked;

  with TPrintReceipt.Create(Self) do
    StartShipping(FIDPreSale, FReceiptType, NumCopy, AReport, APrinter, APreview, 0);

  Close;  

end;

function TFrmPrintShippingOption.Start(IDPreSale, ReceiptType : Integer): Boolean;
begin
  FReceiptType     := ReceiptType;
  FIDPreSale       := IDPreSale;
  cbxPrinter.Items := Printer.Printers;
  FillDefaultPrinter;
  ShowModal;
end;

procedure TFrmPrintShippingOption.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPrintShippingOption.FillDefaultPrinter;
var
  Reg : TRegistry;
  s : String;
  p : Integer;
begin

  try
    Reg := Tregistry.create;
    Reg.access := KEY_READ;
    Reg.rootKey := HKEY_CURRENT_USER;
    if Reg.openKey('\Software\Microsoft\Windows NT\CurrentVersion\Windows', False) then
      s := Reg.readString('device');
    if s <> '' then
    begin
      p := pos(',',s);
      cbxPrinter.Text := copy(s,0,p-1);
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;

end;

end.
