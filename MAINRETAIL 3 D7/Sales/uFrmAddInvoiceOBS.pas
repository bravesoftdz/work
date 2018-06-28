unit uFrmAddInvoiceOBS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, StdCtrls, CheckLst, Buttons, siComp, siLangRT,
  LblEffct, ExtCtrls, DB, ADODB, uFrmNewInvoiceOBS;

type
  TFrmAddInvoiceOBS = class(TFrmParent)
    pnlButons: TPanel;
    pnlFilter: TPanel;
    cbxType: TComboBox;
    edtAdditional: TEdit;
    lblType: TLabel;
    lblAdditional: TLabel;
    btnNew: TSpeedButton;
    btnDelete: TSpeedButton;
    clbOBS: TCheckListBox;
    qryDefaultInvoiceOBS: TADODataSet;
    qryDefaultInvoiceOBSDefaultInvoiceOBS: TStringField;
    qryDefaultInvoiceOBSIDDefaultInvoiceOBS: TIntegerField;
    cmdDeleteOBS: TADOCommand;
    procedure btCloseClick(Sender: TObject);
    procedure cbxTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    slOBSIDs: TStringList;
    FrmNewInvoiceOBS: TFrmNewInvoiceOBS;

    procedure LoadOBSList;
    function GetSelectedOBS: String;
  public
    function Start: String;
  end;

implementation

uses uDM, uSystemConst;

{$R *.dfm}

{ TFrmAddInvoiceOBS }

function TFrmAddInvoiceOBS.GetSelectedOBS: String;
var
  i: Integer;
  slOBS: TStringList;
begin
  slOBS := TStringList.Create;
  try
    for i := 0  to Pred(clbOBS.Count) do
      if clbOBS.Checked[i] then
        slOBS.Add(clbOBS.Items[i]);

    Result := slOBS.Text + edtAdditional.Text;
  finally
    FreeAndNil(slOBS);
  end;
end;

procedure TFrmAddInvoiceOBS.LoadOBSList;
begin
  slOBSIDs.Clear;
  clbOBS.Clear;

  with qryDefaultInvoiceOBS do
  begin
    if Active then
      Close;

    if cbxType.ItemIndex = 0 then
      Parameters.ParamByName('OBSType').Value := NULL
    else
      Parameters.ParamByName('OBSType').Value := cbxType.ItemIndex;
    Open;

    while not Eof do
    begin
      clbOBS.AddItem(FieldByName('DefaultInvoiceOBS').AsString, nil);
      slOBSIDs.Add(FieldByName('IDDefaultInvoiceOBS').AsString);
      Next;
    end;
    Close;
  end;

  if clbOBS.Count > 0 then
  begin
    clbOBS.ItemIndex := 0;
    btnDelete.Enabled := True;
  end
  else
    btnDelete.Enabled := False;
end;

function TFrmAddInvoiceOBS.Start: String;
begin
  edtAdditional.Text := '';
  LoadOBSList;
  ShowModal;
  qryDefaultInvoiceOBS.Close;
  Result := GetSelectedOBS;
end;

procedure TFrmAddInvoiceOBS.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmAddInvoiceOBS.cbxTypeChange(Sender: TObject);
begin
  inherited;
  LoadOBSList;
end;

procedure TFrmAddInvoiceOBS.FormCreate(Sender: TObject);
begin
  inherited;
  slOBSIDs := TStringList.Create;
  DM.imgSmall.GetBitmap(BTN18_NEW, btnNew.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDelete.Glyph);
end;

procedure TFrmAddInvoiceOBS.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(slOBSIDs);
  FreeAndNil(FrmNewInvoiceOBS);
end;

procedure TFrmAddInvoiceOBS.btnNewClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmNewInvoiceOBS) then
    FrmNewInvoiceOBS := TFrmNewInvoiceOBS.Create(Self);

  if FrmNewInvoiceOBS.Start then
    LoadOBSList;
end;

procedure TFrmAddInvoiceOBS.btnDeleteClick(Sender: TObject);
begin
  inherited;
  with cmdDeleteOBS do
  begin
    Parameters.ParamByName('IDDefaultInvoiceOBS').Value := slOBSIDs.Strings[clbOBS.ItemIndex];
    Execute;
  end;
  LoadOBSList;
end;

end.
