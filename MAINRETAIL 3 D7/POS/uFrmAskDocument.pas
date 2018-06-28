unit uFrmAskDocument;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, DBCtrls;

type
  TFrmAskDocument = class(TFrmPai)
    lblDocument: TLabel;
    lblNumber: TLabel;
    cmbDocument: TDBLookupComboBox;
    edtNumber: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btCloseClick(Sender: TObject);
  private
    FIDDocumentType: Integer;
    FDocumentNumber: String;

    procedure SetDefaultDocument;
    function ValidateFields: Boolean;    
  public
    function Start: Boolean;

    property DocumentNumber: String read FDocumentNumber write FDocumentNumber;
    property IDDocumentType: Integer read FIDDocumentType write FIDDocumentType;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, DB;

{$R *.dfm}

{ TFrmAskDocument }

function TFrmAskDocument.Start: Boolean;
begin
  edtNumber.Clear;
  SetDefaultDocument;

  ShowModal;

  Result := ModalResult = mrOk;
end;

procedure TFrmAskDocument.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if ModalResult <> mrOk then
    CanClose := False;
end;

procedure TFrmAskDocument.btCloseClick(Sender: TObject);
begin
  if not ValidateFields then
    ModalResult := mrNone
  else
  begin
    FDocumentNumber := edtNumber.Text;
    FIDDocumentType := cmbDocument.KeyValue;
  end;
end;

procedure TFrmAskDocument.SetDefaultDocument;
begin
  DM.cdsDocumentType.Locate('DefaultType', '1', []);
  cmbDocument.KeyValue := DM.cdsDocumentTypeIDDocumentType.AsInteger;
end;

function TFrmAskDocument.ValidateFields: Boolean;
begin
  Result := False;

  if edtNumber.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_NUMBER, vbInformation + vbOKOnly);
    edtNumber.SetFocus;
    Exit;
  end;

  if VarToStr(cmbDocument.KeyValue) = '' then
  begin
    MsgBox(MSG_CRT_INVALID_DOCUMENT, vbInformation + vbOKOnly);
    cmbDocument.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
