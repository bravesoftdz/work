unit uFrmEstado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Buttons, ADODB, RCADOQuery, PowerADOQuery,
  siComp, siLangRT;

type
  TbrwFrmEstado = class(TbrwFrmParent)
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFormIDEstado: TStringField;
    quFormEstado: TStringField;
    Label1: TLabel;
    IDEstado: TLabel;
    DBEdit1: TDBEdit;
    Label21: TLabel;
    quFormTaxPerc: TBCDField;
    lblTaxPerc: TLabel;
    edtTaxPerc: TDBEdit;
    lbCode: TLabel;
    DBEdit3: TDBEdit;
    quFormCodigo: TStringField;
    lbTaxPerc2: TLabel;
    DBEdit4: TDBEdit;
    quFormTaxPerc2: TBCDField;
    procedure edtTaxPercKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal, uCharFunctions;

{$R *.DFM}

procedure TbrwFrmEstado.edtTaxPercKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

procedure TbrwFrmEstado.FormShow(Sender: TObject);
begin
  inherited;
  lbTaxPerc2.Visible := (DMGlobal.IDLanguage = LANG_PORTUGUESE);
  DBEdit4.Visible := lbTaxPerc2.Visible;
end;

end.
