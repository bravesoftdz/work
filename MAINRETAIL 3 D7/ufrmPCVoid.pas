unit ufrmPCVoid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TfrmPCVoid = class(TFrmParentAll)
    Button1: TButton;
    pnlVoid: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtTroutD: TEdit;
    edtInvoiceNum: TEdit;
    edtAmount: TEdit;
    Label4: TLabel;
    edtAuthcode: TEdit;
    pnlLastDigit: TPanel;
    lbLastDigit: TLabel;
    edtLastDigit: TEdit;
    Label5: TLabel;
    procedure btCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtLastDigitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FTroutD: WideString;
    FInvoiceNo: WideString;
    FAuthNum: WideString;
    FReturntInfo: TStringList;
    function GetCode(ALastDigit : String):String;
    function GetAuthoCode(AResult : String) : String;
    function GetRefNo(AResult : String) : String;
  public
    function Start(AAmount : Currency; var ATroutD, AInvoiceNo, AAuthNum: WideString;
                   AReturntInfo : TStringList): Boolean;
  end;

var
  frmPCVoid: TfrmPCVoid;

implementation

{$R *.dfm}

function TfrmPCVoid.Start(AAmount : Currency; var ATroutD, AInvoiceNo,
   AAuthNum: WideString; AReturntInfo : TStringList): Boolean;
begin
  FInvoiceNo     := '';
  FTroutD        := '';
  FAuthNum       := '';
  FReturntInfo   := AReturntInfo;


  if Assigned(FReturntInfo) then
    if FReturntInfo.Count = 1 then
    begin
      edtAuthcode.Text := GetAuthoCode(FReturntInfo.Strings[0]);
      edtTroutD.Text   := GetRefNo(FReturntInfo.Strings[0]);
    end
    else
      pnlLastDigit.Visible := True;

  edtAmount.Text := FormatFloat('0.00', AAmount);

  if AInvoiceNo <> '' then
  begin
    edtInvoiceNum.Text     := AInvoiceNo;
    edtInvoiceNum.ReadOnly := True;
    edtInvoiceNum.Color    := clSilver;
  end;

  ShowModal;

  ATroutD    := FTroutD;
  AInvoiceNo := FInvoiceNo;
  AAuthNum   := FAuthNum;
  Result     := (FTroutD <> '');
  
end;

procedure TfrmPCVoid.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPCVoid.Button1Click(Sender: TObject);
begin
  inherited;

  if (Trim(edtTroutD.Text) = '') or (Trim(edtInvoiceNum.Text) = '') then
    Exit;

  FTroutD    := edtTroutD.Text;
  FInvoiceNo := edtInvoiceNum.Text;
  FAuthNum   := edtAuthcode.Text;
  Close;
end;

function TfrmPCVoid.GetAuthoCode(AResult : String): String;
var
  i : Integer;
begin
  AResult := Copy(AResult, Pos('A:', AResult) + 2, Length(AResult));
  for i := 1 to Length(AResult) do
    if AResult[i] <> ' ' then
      Result := Result + AResult[i]
    else
      Break;

end;

function TfrmPCVoid.GetCode(ALastDigit: String): String;
var
  i : Integer;
begin

  if ALastDigit <> '' then
    for i := 0 to FReturntInfo.Count-1 do
      if Pos('L:'+ALastDigit, FReturntInfo.Strings[i]) > 0 then
      begin
       edtAuthcode.Text     := GetAuthoCode(FReturntInfo.Strings[i]);
       edtTroutD.Text       := GetRefNo(FReturntInfo.Strings[i]);
       pnlLastDigit.Visible := False;
       Button1.SetFocus;
       Break;
      end;
      
end;

function TfrmPCVoid.GetRefNo(AResult : String): String;
var
  i : Integer;
begin
  AResult := Copy(AResult, Pos('R:', AResult) + 2, Length(AResult));
  for i := 1 to Length(AResult) do
    if AResult[i] <> ' ' then
      Result := Result + AResult[i]
    else
      Break;
end;

procedure TfrmPCVoid.edtLastDigitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    GetCode(edtLastDigit.Text);

end;

procedure TfrmPCVoid.FormShow(Sender: TObject);
begin
  inherited;
  if pnlLastDigit.Visible then
    edtLastDigit.SetFocus;
end;

end.
