unit uFrmAskDepartment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, Grids, DBGrids, siComp, siLangRT, StdCtrls, Buttons,
  ExtCtrls, DB;

type
  TFrmAskDepartment = class(TFrmPai)
    btnOK: TButton;
    grdDepartment: TDBGrid;
    dtsDepartment: TDataSource;
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(var AIDDepartment: Integer): Boolean;
  end;

var
  FrmAskDepartment: TFrmAskDepartment;

implementation

uses uDMPDV;

{$R *.dfm}

{ TFrmAskDepartment }

function TFrmAskDepartment.Start(var AIDDepartment: Integer): Boolean;
begin
  dtsDepartment.DataSet := DMPDV.cdsInvModelDepartment;
  ShowModal;
  Result := (ModalResult = mrOk);
  if Result then
    AIDDepartment := dtsDepartment.DataSet.FieldByName('IDDepartment').AsInteger;
  dtsDepartment.DataSet := nil;
end;

procedure TFrmAskDepartment.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
