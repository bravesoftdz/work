unit uSisDepartamentoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, dxBar, FormConfig, Db, DBTables, 
  ExtCtrls, StdCtrls, Buttons, Mask,
  DBCtrls, ImgList, ADODB, PowerADOQuery, SuperComboADO, siComp, siLangRT;

type
  TSisDepartamentoFch = class(TParentFch)
    quFormIDDepartamento: TIntegerField;
    quFormIDEmpresa: TIntegerField;
    quFormCodigoDepartamento: TStringField;
    quFormDepartamento: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    scEmpresa: TDBSuperComboADO;
    Label3: TLabel;
    Label24: TLabel;
    Label4: TLabel;
    Label5: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SisDepartamentoFch: TSisDepartamentoFch;

implementation

uses uDM;

{$R *.DFM}

end.
