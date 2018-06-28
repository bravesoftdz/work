unit ubrwFrmColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, FormConfig, Db, DBTables,
  LblEffct, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TbrwFrmColor = class(TbrwFrmParent)
    Label3: TLabel;
    DBEdit3: TDBEdit;
    quFormIDColor: TAutoIncField;
    quFormCodColor: TStringField;
    quFormColor: TStringField;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
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
