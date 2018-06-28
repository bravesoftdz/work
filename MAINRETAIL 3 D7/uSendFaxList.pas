unit uSendFaxList;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, siComp, siLangRT, PaiDeForms;

type
  TFrmSendFaxList = class(TFrmParentForms)
    OD: TOpenDialog;
    Label3: TLabel;
    flPhoneNumber: TEdit;
    flFileName: TEdit;
    sbOpenFile: TSpeedButton;
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    flAction: TButton;
    flCancel: TButton;
    procedure flActionClick(Sender: TObject);
    procedure flCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sbOpenFileClick(Sender: TObject);
  private
    { Private declarations }
    function GetFaxName : String;
    procedure SetFaxName(const NewName : String);
    function GetCoverName : String;
    procedure SetCoverName(const NewName : String);
    function GetPhoneNumber : String;
    procedure SetPhoneNumber(const NewNumber : String);

  public
    property FaxName : String
      read GetFaxName write SetFaxName;
    property CoverName : String
      read GetCoverName write SetCoverName;
    property PhoneNumber : String
      read GetPhoneNumber write SetPhoneNumber;

    { Public declarations }
  end;

var
  FrmSendFaxList: TFrmSendFaxList;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}

procedure TFrmSendFaxList.flActionClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TFrmSendFaxList.flCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TFrmSendFaxList.GetFaxName : String;
begin
  Result := flFileName.Text;
end;

procedure TFrmSendFaxList.SetFaxName(const NewName : String);
begin
  flFileName.Text := NewName;
end;

function TFrmSendFaxList.GetCoverName : String;
begin
  Result := '';
end;

procedure TFrmSendFaxList.SetCoverName(const NewName : String);
begin
  //flCover.Text := NewName;
end;

function TFrmSendFaxList.GetPhoneNumber : String;
begin
  Result := flPhoneNumber.Text;
end;

procedure TFrmSendFaxList.SetPhoneNumber(const NewNumber : String);
begin
  flPhoneNumber.Text := NewNumber;
end;

procedure TFrmSendFaxList.FormActivate(Sender: TObject);
begin
  flPhoneNumber.SetFocus;
end;

procedure TFrmSendFaxList.sbOpenFileClick(Sender: TObject);
begin
if OD.Execute = True then
   If OD.FileName <> '' then
      flFileName.Text := OD.FileName;
end;

end.
