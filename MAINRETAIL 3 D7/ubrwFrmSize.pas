unit ubrwFrmSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, FormConfig, Db, DBTables,
  LblEffct, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, ADODB, RCADOQuery,
  PowerADOQuery, siComp, siLangRT;

type
  TbrwFrmSize = class(TbrwFrmParent)
    quFormIDSize: TIntegerField;
    quFormCodSize: TStringField;
    quFormSizeName: TStringField;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal;

{$R *.DFM}

end.
