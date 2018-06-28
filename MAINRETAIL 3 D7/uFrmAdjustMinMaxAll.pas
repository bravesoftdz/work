unit uFrmAdjustMinMaxAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmAdjustMinMaxAll = class(TFrmParentAll)
    lbMin: TLabel;
    edtMin: TEdit;
    lbMax: TLabel;
    edtMax: TEdit;
    btnApply: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    function ValidateFields : Boolean;
  public
    function Start(var Min, Max: Double):Boolean;
  end;

implementation

uses uNumericFunctions;

{$R *.dfm}

{ TFrmAdjustMinMaxAll }

function TFrmAdjustMinMaxAll.Start(var Min, Max: Double): Boolean;
begin
  Result := (ShowModal = mrOK);
  if edtMin.Text <> '' then
     Min := MyStrToDouble(edtMin.Text);
  if edtMax.Text <> '' then
     Max := MyStrToDouble(edtMax.Text);
end;

procedure TFrmAdjustMinMaxAll.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmAdjustMinMaxAll.btCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
  Close;
end;

procedure TFrmAdjustMinMaxAll.btnApplyClick(Sender: TObject);
begin
  inherited;
  if not ValidateFields then
     ModalResult := mrNone;
end;

function TFrmAdjustMinMaxAll.ValidateFields: Boolean;
begin

 Result := True;

 if (edtMin.Text <> '') and (edtMax.Text <> '') then
   if MyStrToDouble(edtMin.Text) >= MyStrToDouble(edtMax.Text) then
      begin
      Result := False;
      end;

 if (MyStrToDouble(edtMin.Text) < 0) or
    (MyStrToDouble(edtMax.Text) < 0) then
    begin
    Result := False;
    end;

end;

end.
