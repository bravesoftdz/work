unit uSisMunicipio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, ImgList, dxBar, FormConfig, Db, ADODB, PowerADOQuery, siComp,
  siLangRT, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls;

type
  TSisMunicipio = class(TParentFch)
    quFormIDMunicipio: TIntegerField;
    quFormCodigo: TStringField;
    quFormDescricao: TStringField;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.DFM}


Initialization
  RegisterClass(TSisMunicipio);


end.
