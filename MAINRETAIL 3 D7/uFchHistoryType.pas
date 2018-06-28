unit uFchHistoryType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchHistoryType = class(TbrwFrmParent)
    quFormIDHistoryType: TIntegerField;
    quFormHistoryType: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
