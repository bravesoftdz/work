unit uFrmEnterMovDocumet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Mask, SuperComboADO;

type
  TFrmEnterMovDocumet = class(TFrmParent)
    edtDocNumber: TEdit;
    lblDocNumber: TLabel;
    lblDocType: TLabel;
    scDocType: TSuperComboADO;
    procedure btCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FDocumentNumber: String;
    FIDDocumentType: Integer;

    procedure SetDefaultDocument;
    function ValidateFields: Boolean;
  public
    function Start: Boolean;

    property DocumentNumber: String read FDocumentNumber write FDocumentNumber;
    property IDDocumentType: Integer read FIDDocumentType write FIDDocumentType;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmEnterMovDocumet }

function TFrmEnterMovDocumet.Start: Boolean;
begin
  edtDocNumber.Clear;
  SetDefaultDocument;

  ShowModal;

  Result := ModalResult = mrOk;
end;

procedure TFrmEnterMovDocumet.btCloseClick(Sender: TObject);
begin
  if not ValidateFields then
    ModalResult := mrNone
  else
  begin
    FDocumentNumber := edtDocNumber.Text;
    FIDDocumentType := StrToInt(scDocType.LookUpValue);
  end;
end;

function TFrmEnterMovDocumet.ValidateFields: Boolean;
begin
  Result := False;

  if edtDocNumber.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_NUMBER, vbInformation + vbOKOnly);
    edtDocNumber.SetFocus;
    Exit;
  end;

  if scDocType.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_INVALID_DOCUMENT, vbInformation + vbOKOnly);
    scDocType.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmEnterMovDocumet.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if ModalResult <> mrOk then
    CanClose := False;
end;

procedure TFrmEnterMovDocumet.SetDefaultDocument;
begin
  scDocType.LookUpValue := DM.DescCodigo(['DefaultType'], ['1'], 'Mnt_DocumentType', 'IDDocumentType');
end;

end.
