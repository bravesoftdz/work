unit uFinCentroCustoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, StdCtrls, Mask, DBCtrls, Db, FormConfig, DBTables,
  Buttons, ExtCtrls, dxBar, ImgList, ADODB, PowerADOQuery, siComp, siLangRT;

type
  TFinCentroCustoFch = class(TParentFch)
    quFormIDCentroCusto: TIntegerField;
    quFormCodigoCentroCusto: TStringField;
    quFormCentroCusto: TStringField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label7: TLabel;
    Label5: TLabel;
    quFormIDCentroCustoParent: TIntegerField;
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinCentroCustoFch: TFinCentroCustoFch;

implementation

uses uDM;

{$R *.DFM}

procedure TFinCentroCustoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormCodigoCentroCusto.AsString := '#Auto#';
end;

Initialization
  RegisterClass(TFinCentroCustoFch);


end.
