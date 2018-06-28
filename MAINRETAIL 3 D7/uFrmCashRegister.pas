unit uFrmCashRegister;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Buttons, 
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TbrwFrmCashRegister = class(TbrwFrmParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    quFormIDCashRegister: TAutoIncField;
    quFormName: TStringField;
    quFormIsAssociated: TBooleanField;
    pnlModel: TPanel;
    Label7: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label11: TLabel;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

procedure TbrwFrmCashRegister.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet['IsAssociated'] := False;
end;

procedure TbrwFrmCashRegister.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1160);
end;

end.
