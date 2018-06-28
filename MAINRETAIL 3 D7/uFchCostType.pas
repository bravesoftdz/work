unit uFchCostType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, Db, StdCtrls, Mask, DBCtrls, FormConfig, DBTables,
  Buttons, LblEffct, ExtCtrls, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TFchCostType = class(TbrwFrmParent)
    quFormIDCostType: TIntegerField;
    quFormCostType: TStringField;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    quFormDefaultValue: TFloatField;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    Label4: TLabel;
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FchCostType: TFchCostType;

implementation

uses uDMGlobal;

{$R *.DFM}

procedure TFchCostType.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1360);
end;

end.
