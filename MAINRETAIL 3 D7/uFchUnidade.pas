unit uFchUnidade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, 
  LblEffct, ExtCtrls, FormConfig, Buttons, 
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TFchUnidade = class(TbrwFrmParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    quFormIDUnidade: TIntegerField;
    quFormUnidade: TStringField;
    quFormSigla: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

end.
