unit uPctMicrochipFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentModalForm, XiButton, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient;

type
  TPctMicrochipFrm = class(TParentModalForm)
    grdMicrochipDB: TcxGridDBTableView;
    grdMicrochipLevel: TcxGridLevel;
    grdMicrochip: TcxGrid;
    cdsMicrochip: TClientDataSet;
    dsMicrochip: TDataSource;
    grdMicrochipDBMicrochip: TcxGridDBColumn;
    grdMicrochipDBAmount: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FFormRestricted : Boolean;
    procedure OpenMicrochip;
    procedure CloseMicrochip;
    procedure SaveMicrochip;
    procedure CancelMicrochip;
    procedure AddMicrochip;
    function FormRestricted : Boolean;
  protected
    procedure ConfirmFrm; override;
    procedure CancelFrm; override;
  public
    { Public declarations }
  end;

implementation

uses uDMPet, Math, uClasseFunctions;

{$R *.dfm}

{ TPctMicrochipFrm }

procedure TPctMicrochipFrm.CancelFrm;
begin
  inherited;
  CancelMicrochip;
end;

procedure TPctMicrochipFrm.CancelMicrochip;
begin
  with cdsMicrochip do
    if Active then
      if State in dsEditModes then
        CancelUpdates;
end;

procedure TPctMicrochipFrm.CloseMicrochip;
begin
  with cdsMicrochip do
    if Active then
      Close;
end;

procedure TPctMicrochipFrm.ConfirmFrm;
begin
  inherited;
  SaveMicrochip;
end;

procedure TPctMicrochipFrm.FormShow(Sender: TObject);
begin
  inherited;
  OpenMicrochip;
  FormRestricted;
end;

procedure TPctMicrochipFrm.OpenMicrochip;
begin
  with cdsMicrochip do
    if not Active then
      Open;
end;

procedure TPctMicrochipFrm.SaveMicrochip;
begin
  with cdsMicrochip do
    if Active then
      if State in dsEditModes then
        ApplyUpdates(0);
end;

procedure TPctMicrochipFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseMicrochip;
end;

procedure TPctMicrochipFrm.AddMicrochip;
var
  Form : TForm;
begin
  Form := CreateForm(Self, 'TPctMicrochipAddFrm');
  try
    if TParentModalForm(Form).ShowFrm then
    begin
      cdsMicrochip.Close;
      cdsMicrochip.Open;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TPctMicrochipFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_RETURN : begin
                  if (ssCtrl in shift) and (not FFormRestricted) then
                    AddMicrochip;
                end;
  end;
  
end;

function TPctMicrochipFrm.FormRestricted: Boolean;
begin
  Result := False;

  if Assigned(DMPet.DataSetControl) then
    if (Pos(Self.Name, DMPet.DataSetControl.RestrictForms) > 0) then
      Result := True;

  FFormRestricted := Result;

end;

initialization
  RegisterClass(TPctMicrochipFrm);

end.
