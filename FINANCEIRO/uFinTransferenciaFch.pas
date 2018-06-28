unit uFinTransferenciaFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, ImgList, dxBar, FormConfig, Db, DBTables,
  ExtCtrls, StdCtrls, Buttons, DBCtrls, dxDateEdit,
  dxDBDateEdit, Mask, ADODB, PowerADOQuery, SuperComboADO, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxDBELib, siComp, siLangRT, DateBox;

type
  TFinTransferenciaFch = class(TParentFch)
    quFormIDTransferencia: TIntegerField;
    quFormIDContaCorrenteDebito: TIntegerField;
    quFormIDContaCorrenteCredito: TIntegerField;
    quFormData: TDateTimeField;
    quFormValor: TFloatField;
    quFormObs: TMemoField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    quFormIDUsuario: TIntegerField;
    scUsuario: TDBSuperComboADO;
    scContaCorrenteDebito: TDBSuperComboADO;
    scContaCorrenteCredito: TDBSuperComboADO;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBMemo1: TDBMemo;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dxDBDateEdit1: TDBDateBox;
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    function OnSaveData: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uSisSenha, uDM;

{$R *.DFM}

procedure TFinTransferenciaFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDUsuario.AsInteger := SisSenha.IDUsuario;
  quFormData.AsDateTime := Now;

end;

function TFinTransferenciaFch.OnSaveData: Boolean;
begin
  Result := False;
  DM.RunSQLEx('EXEC sp_Fin_Transferencia_Do ' + quFormIDTransferencia.AsString);
  Result := True;
end;

Initialization
  RegisterClass(TFinTransferenciaFch);


end.
