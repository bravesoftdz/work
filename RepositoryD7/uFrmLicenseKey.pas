unit uFrmLicenseKey;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, Db, ADODB,
  uSystemObj;

type
  TFrmLicenseKey = class(TFrmParentAll)
    quLicense: TADOQuery;
    btnFreeTrial: TButton;
    pnlValidate: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    edtNumber: TEdit;
    edtKey: TEdit;
    edtModule: TEdit;
    edtDay: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtDate: TEdit;
    Label8: TLabel;
    edtMonth: TEdit;
    Label9: TLabel;
    edtYear: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnFreeTrialClick(Sender: TObject);
  private
    { Private declarations }
    fExpiredDate : Integer;
    function ValidateKey:Boolean;
    function SaveLicense(License:String):Boolean;
  public
    { Public declarations }
    function Start(Expiration:Integer):Boolean;
  end;

implementation

uses uEncryptFunctions, uDM, uDateTimeFunctions;

{$R *.DFM}

function TFrmLicenseKey.Start(Expiration:Integer):Boolean;
var
  i : Integer;
begin

   Randomize;
   i:= Random(6);

   case i of
      0 : edtNumber.Text := FormatDateTime('ddyyyymmhhmmsszz',now);
      1 : edtNumber.Text := FormatDateTime('mmyyyyddmmzzhhss',now);
      2 : edtNumber.Text := FormatDateTime('yyyymmddhhmmzzss',now);
      3 : edtNumber.Text := FormatDateTime('zzddmmyyyymmhhss',now);
      4 : edtNumber.Text := FormatDateTime('ddmmhhmmzzssyyyy',now);
      5 : edtNumber.Text := FormatDateTime('hhyyyyssmmddmmzz',now);
      6 : edtNumber.Text := FormatDateTime('ssyyyyhhddmmzzmm',now);
   end;

   edtDate.Text   := FormatDateTime('mmmm d, yyyy', Now);
   edtKey.Text    := '';
   edtModule.Text := '';
   edtDay.Text    := '';
   edtMonth.Text  := '';
   edtYear.Text   := '';

   fExpiredDate := Expiration;

   pnlValidate.Visible := ((fExpiredDate < Trunc(Now)) or ((fExpiredDate-30) < Trunc(Now)));

   btnFreeTrial.Visible := not DM.fSystem.ValidLicense;

   ShowModal;

   Result := ValidateKey;

end;

function TFrmLicenseKey.ValidateKey:Boolean;
var
  Key : String;
  Module : String;
  sLicense : String;
  iNewExpiration : Integer;
  sDate : String;
  sDay, sMonth, sYear : String;
begin

   sDate := edtDay.Text + edtMonth.Text + edtYear.Text;

   if ((not pnlValidate.Visible) and (fExpiredDate > DM.fSystem.SystemDate)) and (Trim(sDate) = '') then
      begin
      Result := True;
      Exit;
      end;

   Result := False;

   if (Trim(edtKey.Text) = '') or (Trim(edtModule.Text) = '')
      or (Trim(sDate) = '') then
      Exit;

   Try

       Key    := Copy(EncodeServerInfo(edtNumber.Text, 'LK', CIPHER_BLOCK_CHAINING, FMT_HEX),20,Length(edtNumber.Text));
       Module := DecodeServerInfo(Trim(edtModule.Text), 'M', CIPHER_BLOCK_CHAINING, FMT_HEX)[1];
       Result := (edtKey.Text = Key);

       sDay   := DecodeServerInfo(Trim(edtDay.Text), 'XD', CIPHER_BLOCK_CHAINING, FMT_HEX);
       sMonth := DecodeServerInfo(Trim(edtMonth.Text), 'XM', CIPHER_BLOCK_CHAINING, FMT_HEX);
       sYear  := DecodeServerInfo(Trim(edtYear.Text), 'XY', CIPHER_BLOCK_CHAINING, FMT_HEX);

       iNewExpiration := Trunc(BuildDate(sDay, sMonth, '20'+sYear));

       if DM.fSystem.ExpirationDate < iNewExpiration then
          DM.fSystem.ExpirationDate := iNewExpiration;

       if (Length(Module)>1) or (not ((Module[1]) in [SYS_MODULE_1..SYS_MODULE_5])) then
          Module := SYS_MODULE_TRIAL;

       DM.fSystem.StartMode := Module[1];

       //Get info from current module
       sLicense := '#Module#='+Module[1]+';#Date#='+DateTimeToStr(now)+';'+
                   '#Expire#='+IntToStr(iNewExpiration)+';';

       If Result then
          sLicense := sLicense + '#Key#=Y;'
       else
          sLicense := sLicense + '#Key#=N;';

       //Save to DB
       SaveLicense(sLicense);
          
   Except
     Result := False;
   end;
end;

function TFrmLicenseKey.SaveLicense(License:String):Boolean;
begin

   Result := True;

   try
     //Save to DB
     with quLicense do
        begin
        Parameters.ParamByName('ModuleInfo').Value:=
            EncodeServerInfo(License, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU);
        ExecSQL;
        end;
   except
      Result := False;
      raise;
      end;

end;

procedure TFrmLicenseKey.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmLicenseKey.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmLicenseKey.btnFreeTrialClick(Sender: TObject);
begin
  inherited;
  edtKey.Text := '';
  SaveLicense('#Module#=D;#Key#=N;#Date#='+DateTimeToStr(now)+';');
  Close;
end;

end.
