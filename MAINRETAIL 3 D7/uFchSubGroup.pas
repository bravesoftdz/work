unit uFchSubGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchSubGroup = class(TbrwFrmParent)
    quFormIDSubGroup: TIntegerField;
    quFormSubGroup: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label38: TLabel;
    quFormUserCode: TStringField;
    Label2: TLabel;
    DBEdit2: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
