unit uSisFeriadoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, StdCtrls, Mask, DBCtrls, Db, FormConfig,
  DBTables, ExtCtrls, Buttons, dxBar, dxDateEdit, dxDBDateEdit,
  ImgList, ADODB, PowerADOQuery, dxCntner, dxEditor, dxExEdtr, dxEdLib,
  dxDBELib, siComp, siLangRT, DateBox;

type
  TSisFeriadoFch = class(TParentFch)
    quFormIDFeriado: TIntegerField;
    quFormFeriado: TStringField;
    quFormData: TDateTimeField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormSystem: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    dxDBDateEdit1: TDBDateBox;
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TSisFeriadoFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  // Limpa a hora do data
  quFormData.AsDateTime := Trunc(quFormData.AsDateTime);
end;

procedure TSisFeriadoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
 // Coloca a data default
 quFormData.AsDateTime := Date();
end;

Initialization
  RegisterClass(TSisFeriadoFch);


end.
