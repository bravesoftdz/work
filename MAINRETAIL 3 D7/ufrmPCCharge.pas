unit ufrmPCCharge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  uPCCIntegration, uCreditCardFunction;

type
  TfrmPCCharge = class(TFrmParentAll)
    edtCardNumber: TEdit;
    Label1: TLabel;
    edtMemberName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtExpireDate: TEdit;
    Label4: TLabel;
    edtStreetAddress: TEdit;
    Label5: TLabel;
    edtZipCode: TEdit;
    Label6: TLabel;
    edtCVV2: TEdit;
    btnOK: TButton;
    lbProcessing: TLabel;
    Label7: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure edtExpireDateKeyPress(Sender: TObject; var Key: Char);
    procedure edtCardNumberKeyPress(Sender: TObject; var Key: Char);
    procedure edtMemberNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtStreetAddressKeyPress(Sender: TObject; var Key: Char);
    procedure edtZipCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCVV2KeyPress(Sender: TObject; var Key: Char);
  private
    FCardNumber    : String;
    FMemberName    : String;
    FExpireDate    : String;
    FStreetAddress : String;
    FZipCode       : String;
    FCVV2          : String;
    FPCCT          : TPCCTransaction;
    FAmount        : Currency;
    FTicket        : WideString;
    FResult        : Boolean;
  public
    function Start(PCCT: TPCCTransaction; ATicket: WideString; AAmount: Currency): Boolean;
    function StartMercury(var ACardNumber, AMemberName, AExpireDate, AStreetAddress,
                          AZipCode, ACVV2: String):Boolean;
  end;

implementation

uses uDM, uNumericFunctions, uCharFunctions, uSystemConst;

{$R *.dfm}

{ TfrmPCCharge }

function TfrmPCCharge.Start(PCCT: TPCCTransaction; ATicket: WideString; AAmount: Currency): Boolean;
begin

  DM.FTraceControl.TraceIn('TfrmPCCharge.Start');

  try
    FAmount := AAmount;
    FTicket := ATicket;

    FPCCT := PCCT;

    FResult := False;
    ShowModal;

    Result := PCCT.TransactionReturn = ttrSuccessfull;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TfrmPCCharge');
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TfrmPCCharge.btnOKClick(Sender: TObject);
var
  sMsg: String;
begin
  inherited;

  DM.FTraceControl.TraceIn('TfrmPCCharge.btnOKClick');

  if edtCardNumber.Text = '' then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  FCardNumber    := edtCardNumber.Text;
  FMemberName    := edtMemberName.Text;
  FExpireDate    := edtExpireDate.Text;
  FStreetAddress := edtStreetAddress.Text;
  FZipCode       := edtZipCode.Text;
  FCVV2          := edtCVV2.Text;
  FResult        := True;

  (*
  if DM.fPCCharge.ProcessorType = PROCESSOR_PCCHARGE then
  begin
    btnOK.Enabled        := False;
    btClose.Enabled      := False;
    lbProcessing.Visible := True;
    Screen.Cursor        := crHourGlass;

    try

      try

        FPCCT.RetailCreditOrAutorizationCardNotPresent(FCardNumber,
                                                       FMemberName,
                                                       FExpireDate,
                                                       MyFormatCur(Abs(FAmount), '.'),
                                                       FTicket,
                                                       FStreetAddress,
                                                       FZipCode,
                                                       FCVV2, FAmount < 0);
        case FPCCT.TransactionReturn of
          ttrSuccessfull:
            Close;//sMsg := Format('%S'#13#10#13#10'Auth: %S'#13#10'RefNumber: %S'#13#10'TroutD: %S', [PT.PCCResult, PT.Auth, PT.RefNumber, PT.TroutD]);

          ttrNotSuccessfull:
            sMsg := Format('%S'#13#10#13#10'Reason: %S', [FPCCT.PCCResult, FPCCT.Auth]);


          ttrError:
            sMsg := Format('%S'#13#10'Error: %D - %S', [FPCCT.PCCResult, FPCCT.ErrorCode, FPCCT.ErrorDesc]);

          ttrException:
            sMsg := Format(''#13#10'Error: %S', [FPCCT.ErrorDesc]);
        end;

        //if sMsg <> '' then
        //  Application.MessageBox(PChar(sMsg), 'Result of transaction', MB_OK);

        if sMsg <> '' then
          raise Exception.Create(sMsg);

      finally
        btnOK.Enabled        := True;
        btClose.Enabled      := True;
        lbProcessing.Visible := False;
        Screen.Cursor        := crDefault;
        end;

    except
      on E: Exception do
      begin
        DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TfrmPCCharge');
        Application.MessageBox(PChar(E.Message), 'Result of transaction', MB_OK);
      end;
    end;
  end
  else *)  if DM.fPCCharge.ProcessorType in [PROCESSOR_MERCURY] then
    Close;

  DM.FTraceControl.TraceOut;

end;

procedure TfrmPCCharge.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPCCharge.edtExpireDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtStreetAddress.SetFocus
  else
    Key := ValidateNumbers(Key);
end;

function TfrmPCCharge.StartMercury(var ACardNumber, AMemberName,
  AExpireDate, AStreetAddress, AZipCode, ACVV2: String): Boolean;
begin

  DM.FTraceControl.TraceIn('TfrmPCCharge.Start');

  try
    FResult := False;

    ShowModal;

    ACardNumber    := FCardNumber;
    AMemberName    := FMemberName;
    AExpireDate    := FExpireDate;
    AStreetAddress := FStreetAddress;
    AZipCode       := FZipCode;
    ACVV2          := FCVV2;
    Result         := FResult;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TfrmPCCharge');
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TfrmPCCharge.edtCardNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtMemberName.SetFocus;
end;

procedure TfrmPCCharge.edtMemberNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtExpireDate.SetFocus;
end;

procedure TfrmPCCharge.edtStreetAddressKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtZipCode.SetFocus
end;

procedure TfrmPCCharge.edtZipCodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtCVV2.SetFocus
end;

procedure TfrmPCCharge.edtCVV2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnOK.SetFocus
end;

end.
