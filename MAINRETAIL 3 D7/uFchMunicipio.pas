unit uFchMunicipio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchMunicipio = class(TbrwFrmParent)
    quFormIDMunicipio: TIntegerField;
    quFormCodigo: TStringField;
    quFormDescricao: TStringField;
    lbCode: TLabel;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

end.
