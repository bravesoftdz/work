unit frmCardNumberDialogView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, ComCtrls,
  uCCMercuryIntegration;

type
  TCardNumberDlgView = class(TDialogParent)
    lblValue: TLabel;
    lblSerialType: TLabel;
    edtSerialNumber: TEdit;
    Panel3: TPanel;
    Animate1: TAnimate;
    procedure FormShow(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
  private
    { Private declarations }
    // Antonio, September 16, 2013
    fMercuryInjected: TCCWidget;

    // Antonio, August 21, 2013
    FOnlyCardNumber: Boolean;
    FKeepCard: Boolean;
    FTrack: WideString;
    FIDMeioPag: Integer;
    FInvoice: Integer;
    FIssued: Integer;
    objMercuryTransaction: TCPrePaid;
    FSecureSerialNumber: String;
    FSerialNumber: String;
    FInternal: Boolean;
    FIdModel: Integer;
    FIdStore: Integer;
    FIdItem: Integer;
    FMaxQty: Integer;
    FIniQty: Integer;
    FBalance: Double;
    FcountQty: Integer;
    FMsg: String;
    procedure setIdModel(const Value: Integer);
    procedure setIdMov(const Value: Integer);
    procedure setIdStore(const Value: Integer);
    procedure refreshLabel();

    // Antonio July 19, 2013
    function getSecureSerialNumber(arg_serialNumber: String): String;
  public
    { Public declarations }
     property IdModel: Integer write setIdModel;
     property IdStore: Integer write setIdStore;
     property IdMov: Integer write setIdMov;

     function Start(var atrack: WideString; idmeiopag: Integer;
     msg_gift: String; ini_qty, end_qty, idmodel, iditem: Integer;
     balance: Double; invoice: Integer): Boolean; overload;

     // Antonio, August 21, 2013
     function start(var arg_cardNumber: String): Boolean; overload;

     // Antonio, September 16, 2013
     procedure setMercuryObject(arg_object: TCCWidget);

  end;

implementation

uses uDM, SerialNumberCls, uDebugFunctions;

{$R *.dfm}

procedure TCardNumberDlgView.FormShow(Sender: TObject);
var
  appDir: string;
begin
  appDir := ExtractFilePath(Application.ExeName);
  if FileExists(appDir + 'swipe.avi') then
  begin
    Animate1.FileName := appDir + 'swipe.avi';
    Animate1.Active := True;
  end;
end;

procedure TCardNumberDlgView.setIdModel(const Value: Integer);
begin
  FIdModel := value;
end;

procedure TCardNumberDlgView.setIdMov(const Value: Integer);
begin
  FIdItem := value;
end;

procedure TCardNumberDlgView.setIdStore(const Value: Integer);
begin
  FIdStore := value;
end;

function TCardNumberDlgView.Start(var atrack: WideString; idmeiopag: Integer;
msg_gift: String; ini_qty, end_qty, idmodel, iditem: Integer;
balance: Double; invoice: Integer): Boolean;
begin
  FBalance  := balance;
  FMaxQty   := end_qty;
  FMsg      := msg_gift;
  FCountQty := ini_qty;

  refreshLabel;

  FTrack := '';
  FIDMeioPag := -1;
  showModal;

  debugToFile('ATrack = ' + atrack);
  debugtofile('FTrack = ' + FTrack);

  Result     := True;
  atrack     := FTrack;
  FSerialNumber := atrack;
  FSecureSerialNumber := getSecureSerialNumber(FSerialNumber);

  idmeiopag  := FIDMeioPag;
end;

procedure TCardNumberDlgView.AplicarClick(Sender: TObject);
begin
  inherited;
  // Antonio, August 21, 2013

  if ( trim(edtSerialNumber.Text) = '' ) then begin
     Application.MessageBox('Content can not be blank.', 'Warning Message', mb_OK + mb_IconWarning);
     edtSerialNumber.setfocus;
     exit;
  end;

  FKeepCard := true;
  FTrack := edtSerialNumber.Text;


  // Antonio, September 16, 2013
  try
    fMercuryInjected.setCardNumber(edtSerialNumber.Text);
  except
    on e: Exception do begin
       fTrack := '';
       raise Exception.Create('Card number already entered');
    end;
  end;
  

  // Antonio July 19, 2013
  FSecureSerialNumber := getSecureSerialNumber(edtSerialNumber.Text);
  //WriteSerialNumber(FSecureSerialNumber);
  refreshLabel();
end;

procedure TCardNumberDlgView.refreshLabel;
var
    msg: String;
begin
    if ( not FOnlyCardNumber ) then begin
      msg := format(FMsg + '%d of %d', [FcountQty, FMaxQty]);
      lblSerialType.Caption := msg;
      lblValue.Caption := '($' + formatFloat('#,##0.00', FBalance) + ')';
    end;
end;

procedure TCardNumberDlgView.CancelarClick(Sender: TObject);
begin
  inherited;
  fKeepCard := false;
  FTrack := '';
  close;
end;

function TCardNumberDlgView.getSecureSerialNumber(
  arg_serialNumber: String): String;
var
  serialSubPart: String;
begin
  serialSubPart := copy(arg_serialNumber, ( length(arg_serialNumber) - 6), 6);
  FSecureSerialNumber := stringReplace(arg_serialNumber, serialSubPart, 'XXXXXX', [rfReplaceAll, rfIgnoreCase]);
  result := FSecureSerialNumber;
end;

function TCardNumberDlgView.Start(var arg_cardNumber: String): Boolean;
begin
   FOnlyCardNumber := true;
   Panel3.Visible := false;
   lblSerialType.Caption := 'Gift Card Number:';
   lblValue.visible := false;
   Result := false;
   showModal;
   arg_cardNumber := FTrack;

   result := true;
end;

procedure TCardNumberDlgView.setMercuryObject(arg_object: TCCWidget);
begin
   fMercuryInjected := arg_object;
end;

end.
