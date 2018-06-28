unit uFchNCM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchNCM = class(TbrwFrmParent)
    quFormIDNCM: TIntegerField;
    quFormCodigo: TStringField;
    quFormDescricao: TStringField;
    quFormMVAInterno: TBCDField;
    quFormMVAInterestadual: TBCDField;
    quFormIncide: TBooleanField;
    Label1: TLabel;
    DBMemo1: TDBMemo;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label43: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    DBCheckBox1: TDBCheckBox;
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

procedure TFchNCM.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIncide.AsBoolean := False;
end;

end.
