unit uFchTrajeto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, FormConfig, Db, DBTables, Buttons,
  LblEffct, ExtCtrls, StdCtrls, Mask, DBCtrls, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TFchTrajeto = class(TbrwFrmParent)
    quFormIDTrajeto: TIntegerField;
    quFormTrajeto: TStringField;
    quFormCustoMotorista: TFloatField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    quFormCustoGasolina: TFloatField;
    quFormMinPax: TIntegerField;
    Label7: TLabel;
    Panel5: TPanel;
    Label19: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label18: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    Label8: TLabel;
    DBEdit5: TDBEdit;
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FchTrajeto: TFchTrajeto;

implementation

uses uDMGlobal;

{$R *.DFM}


procedure TFchTrajeto.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1340);
end;

end.
