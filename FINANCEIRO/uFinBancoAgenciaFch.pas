unit uFinBancoAgenciaFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables,
  Buttons, StdCtrls, ExtCtrls, Mask, DBCtrls, dxBar, ImgList,
  ADODB, PowerADOQuery, SuperComboADO, siComp, siLangRT;

type
  TFinBancoAgenciaFch = class(TParentFch)
    quFormIDBancoAgencia: TIntegerField;
    quFormCodigoBancoAgencia: TStringField;
    quFormBancoAgencia: TStringField;
    quFormIDBanco: TIntegerField;
    quFormEndereco: TStringField;
    quFormBairro: TStringField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBSuperCombo1: TDBSuperComboADO;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinBancoAgenciaFch: TFinBancoAgenciaFch;

implementation

uses uDM;

{$R *.DFM}

procedure TFinBancoAgenciaFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormCodigoBancoAgencia.AsString := '#Auto#';
end;

Initialization
  RegisterClass(TFinBancoAgenciaFch);


end.
