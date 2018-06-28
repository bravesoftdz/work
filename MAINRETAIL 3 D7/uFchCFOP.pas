unit uFchCFOP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchCFOP = class(TbrwFrmParent)
    quFormIDCFOP: TIntegerField;
    quFormNumber: TStringField;
    quFormDescription: TStringField;
    lblNumber: TLabel;
    edtNumber: TDBEdit;
    lblNumberReq: TLabel;
    lblDescription: TLabel;
    edtDescription: TDBEdit;
    lblDescriptionReq: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.dfm}

end.
