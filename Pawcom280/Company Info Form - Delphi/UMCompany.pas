{ This example uses Delphi 5 and PawCom Version 1

Develped by:

DataSoft Corporation Minneapolis
12 South Sixth Street, Ste 323
Minneapolis, MN  55402  USA

Main: 612-399-0115
Email: sales@dscorp.com
http://www.dscorp.com
http://www.softseekers.com

Copyright (C) 2000 DataSoft Corporation. All rights reserved.
}
unit UMCompany;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, PAW_TLB, OleServer;

type
  TFMCompany = class(TForm)
    BTNClose: TBitBtn;
    BTNOk: TBitBtn;
    Label1: TLabel;
    lblPeachtreeVersionNo: TLabel;
    Label2: TLabel;
    EditCompanyName: TEdit;
    Label3: TLabel;
    EditAddrLine1: TEdit;
    EditAddrLine2: TEdit;
    Label5: TLabel;
    EditAddrCity: TEdit;
    EditAddrState: TEdit;
    EditAddrPostalCode: TEdit;
    Label4: TLabel;
    EditAddrCountry: TEdit;
    Label6: TLabel;
    EditFein: TEdit;
    Label7: TLabel;
    EditTelephone: TEdit;
    Label8: TLabel;
    EditSein: TEdit;
    Label9: TLabel;
    EditFax: TEdit;
    Label10: TLabel;
    EditSuin: TEdit;
    Shape1: TShape;
    Label11: TLabel;
    CBoBusinessType: TComboBox;
    Label12: TLabel;
    CBoPostingMethod: TComboBox;
    Label13: TLabel;
    LblCashBasis: TLabel;
    Label15: TLabel;
    CBUseAuditTrail: TCheckBox;
    Btrieve1: TBtrieve;
    CompanyInformation1: TCompanyInformation;
    SelectCompany1: TSelectCompany;
    procedure FormCreate(Sender: TObject);
    procedure BTNCloseClick(Sender: TObject);
    procedure BTNOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Status:Integer;
    CompanyPath:String;
    PeachtreeVersion:Double;

  public
    { Public declarations }
  end;

var
  FMCompany: TFMCompany;

implementation

{$R *.DFM}

procedure TFMCompany.FormCreate(Sender: TObject);
begin
{ Opens PawCom's Select Company Dialog }
{ Assigns DOS Name path (ex:  C:\PEACHW\BCS ) }
SelectCompany1.ShowOpen;
CompanyPath:=SelectCompany1.CompanyPath;

{ Checks CompanyPath make sure user selected a Company and
  pressed the Ok Button }
If CompanyPath = '' then exit; // exit this subroutine

{ PawCom documentation use Connect
 Connect method already exists with Delphi's
 base class for objects, so Delphi changes the name
 from Connect to Connect1 }

Status:=Btrieve1.Connect1(CompanyPath);

{ Always call Reset after Connect1, Without Reset some file operations
  will not function correctly }

BTrieve1.Reset;
If Status <> 0 then Begin
Messagebeep(MB_ICONHAND);
Messagedlg('Open Company failed.'+#10+#13+
   'Status = '+Inttostr(Status),mtwarning,[mbok],0);
exit;
end;  // Status <> 0 BTrieve1

{ Open the Company Information File }
CompanyInformation1.OpenFile;
{ Position to first (only) record in file }
Status:=CompanyInformation1.StepFirst;
{ Check to make sure file was opened }
If Status <> 0 then begin
Messagebeep(MB_ICONHAND);
Messagedlg('Unable to read Company Information.'+#10+#13+
   'Status = '+Inttostr(Status),mtwarning,[mbok],0);
exit;
end; // Status <> 0 CompanyInformation1

{ All files are open, read the field information into screen fields
  Using with statement is a shorthand for referencing CompanyInformation1 }
With CompanyInformation1 do begin
PeachtreeVersion := Version;
lblPeachtreeVersionNo.Caption := FloattoStr(PeachtreeVersion);
EditCompanyName.Text := CompanyName;
EditAddrLine1.Text := AddrLine1;
EditAddrLine2.Text := AddrLine2;
EditAddrCity.Text := AddrCity;
EditAddrState.Text := AddrState;
EditAddrPostalCode.Text := AddrPostalCode;
EditAddrCountry.Text := AddrCountry;
EditTelephone.Text := Telephone;
EditFax.Text := Fax;
EditFein.Text := Fein;
EditSein.Text := Sein;
EditSuin.Text := Suin;

{ Set values in ComboBox Business Type }
{ Value of 5 = Not Assigned }
Case BusinessTypeCode of
0:CBoBusinessType.ItemIndex := 0;
1:CBoBusinessType.ItemIndex := 1;
2:CBoBusinessType.ItemIndex := 2;
3:CBoBusinessType.ItemIndex := 3;
4:CBoBusinessType.ItemIndex := 4;
Else CBoBusinessType.ItemIndex := 5;
end; // Case BusinessTypeCode

If RealTime then
   CBoPostingMethod.ItemIndex := 0 else
    CBoPostingMethod.ItemIndex := 1;
If CashBasis then
    LblCashBasis.Caption := 'Cash' else
    LblCashBasis.Caption := 'Accrual';

{ Set Values for CheckBox }
CBUseAuditTrail.Checked:=UseAuditTrail;

end; // With CompanyInformation1

{Close the file we are all done getting field information }
CompanyInformation1.CloseFile;

{ Disconnect is already assigned by Delphi so use Disconnect1
  to access PawCom's Discconect method }
Btrieve1.Disconnect1; // Disconnect Btrieve1



end;

procedure TFMCompany.BTNCloseClick(Sender: TObject);
begin
{ Close Form, Exit Program }
Close;
end;

procedure TFMCompany.BTNOkClick(Sender: TObject);
begin
{ Reconnect to BTrieve1 and CompanyInformation1 }
Status:=Btrieve1.Connect1(CompanyPath);

{ Always call Reset after Connect1, Without Reset some file operations
  will not function correctly }

BTrieve1.Reset;
If Status <> 0 then Begin
Messagebeep(MB_ICONHAND);
Messagedlg('Open Company failed.'+#10+#13+
   'Status = '+Inttostr(Status),mtwarning,[mbok],0);
exit;
end;  // Status <> 0 BTrieve1

{ Open the Company Information File }
CompanyInformation1.OpenFile;
{ Position to first (only) record in file }
Status:=CompanyInformation1.StepFirst;
If Status <> 0 then begin
Messagebeep(MB_ICONHAND);
Messagedlg('Unable to read Company Information.'+#10+#13+
   'Status = '+Inttostr(Status),mtwarning,[mbok],0);
exit;
end; // Status <> 0 CompanyInformation1

{ Files are now open, write changed data back to data files }
{ Using with again, makes it easier }
With CompanyInformation1 do begin
CompanyName := EditCompanyName.Text;
AddrLine1 := EditAddrLine1.Text;
AddrLine2 := EditAddrLine2.Text;
AddrCity := EditAddrCity.Text;
AddrState := EditAddrState.Text;
AddrPostalCode := EditAddrPostalCode.Text;
AddrCountry := EditAddrCountry.Text;
Telephone := EditTelephone.Text;
Fax := EditFax.Text;
Fein := EditFein.Text;
Sein := EditSein.Text;
Suin := EditSuin.Text;
BusinessTypeCode := CBoBusinessType.ItemIndex;
RealTime := CBOPostingMethod.ItemIndex = 0;
UseAuditTrail := CBUseAuditTrail.Checked;
end; // With

{ Update the Peachtree Company File }
Status := CompanyInformation1.Update;
If Status <> 0 then begin
Messagebeep(MB_ICONHAND);
Messagedlg('Unable to write Company Information.'+#10+#13+
   'Status = '+Inttostr(Status),mtwarning,[mbok],0);
end;
{ Close the Company Information File }
Status := CompanyInformation1.CloseFile;
If Status <> 0 then begin
Messagebeep(MB_ICONHAND);
Messagedlg('Unable to Close Company Information.'+#10+#13+
   'Status = '+Inttostr(Status),mtwarning,[mbok],0);
end;

BTrieve1.Disconnect1; // Close BTrieve
Close; // Close Application
end;

procedure TFMCompany.FormShow(Sender: TObject);
begin
{ Test to see if user selected company and OK button }
{ If no company Selected Close down application }
If CompanyPath = '' then Close;
end;

end.
