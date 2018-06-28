unit uFrmSaleConsult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, SubListPanel, siComp, siLangRT, StdCtrls,
  Buttons, ExtCtrls;

type
  TFrmSaleConsult = class(TFrmParentAll)
    slSubSaleConsult: TSubListPanel;
    btOK: TButton;
    procedure btOKClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure slSubSaleConsultAfterParamChanged(Changes: String);
  private
    { Private declarations }
    bOk: Boolean;
  public
    { Public declarations }
    function Start(IsClosedlAyAway: Boolean): String;
  end;

var
  FrmSaleConsult: TFrmSaleConsult;

implementation

uses uSubSaleConsult,uParamFunctions;

{$R *.dfm}

{ TFrmSaleConsult }

function TFrmSaleConsult.Start(IsClosedlAyAway: Boolean): String;
var
  iLayAwayToClose: Integer;
begin
  iLayAwayToClose := Byte(IsClosedlAyAway);
  bOk := False;
  slSubSaleConsult.Param := Format('ISCLOSEDLAYAWAY=%D;', [iLayAwayToClose]);
  ShowModal;

  Result := slSubSaleConsult.GetSubListInfo('');

  if not (bOk and (ParseParam(Result, 'ISEMPTY')='0')) then
     Result := '';

end;

procedure TFrmSaleConsult.btOKClick(Sender: TObject);
begin
  inherited;
  bOk := True;
  Close;
end;

procedure TFrmSaleConsult.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmSaleConsult.FormCreate(Sender: TObject);
begin
  inherited;
  slSubSaleConsult.CreateSubList;
end;


procedure TFrmSaleConsult.slSubSaleConsultAfterParamChanged(
  Changes: String);
begin
  inherited;
  bOk := True;
  Close;
end;

end.
