unit uSendDataFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, Provider, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, XiButton,
  ExtCtrls, StdCtrls;

const
  MR_PET_DATA  = 'MRPetData.exe';

type
  TSendDataFrm = class(TParentForm)
    pnlBottom: TPanel;
    btnOk: TXiButton;
    btnCancel: TXiButton;
    dDate: TcxDateEdit;
    Label1: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    function SendSaleData : Boolean;
  public
    function Init(SilentMode : Boolean) : Boolean;
  end;

implementation

uses uDMPetCenter, uDMPet, uFileFunctions, mrMsgBox;

{$R *.dfm}

{ TSendDataFrm }

function TSendDataFrm.Init(SilentMode : Boolean): Boolean;
begin
  dDate.Date := Trunc(Now-1);
  Result := True;

  if not SilentMode then
    ShowModal
  else
  begin
    SendSaleData;
    Close;
  end;

end;

function TSendDataFrm.SendSaleData: Boolean;
var
  sSaleDate : String;
begin

  Result := False;

  try
    Screen.Cursor := crHourGlass;

    sSaleDate := FormatDateTime('mm/dd/yyyy', Trunc(dDate.Date));

    if FileExists(DMPet.LocalPath + MR_PET_DATA) then
      ExecuteFile(DMPet.LocalPath + MR_PET_DATA, sSaleDate, '', SW_SHOW)
    else
      MsgBox('Send Pet Center data not installed!', vbInformation + vbOKOnly);

  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TSendDataFrm.btnOkClick(Sender: TObject);
begin
  inherited;
  SendSaleData;
end;

procedure TSendDataFrm.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
