unit uFinDesdobramentoTipoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, Mask, StdCtrls, DBCtrls, Db, FormConfig,
  DBTables, ExtCtrls, Buttons, dxBar, ImgList, ADODB, PowerADOQuery,
  SuperComboADO, siComp, siLangRT;

type
  TFinDesdobramentoTipoFch = class(TParentFch)
    quFormIDDesdobramentoTipo: TIntegerField;
    quFormIDDocumentoTipo: TIntegerField;
    quFormDesdobramentoTipo: TStringField;
    quFormCodigoDesdobramentoTipo: TStringField;
    quFormIdentificadorDesdobramento: TStringField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    quFormDesativado: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBSuperCombo1: TDBSuperComboADO;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinDesdobramentoTipoFch: TFinDesdobramentoTipoFch;

implementation

uses uDM;

{$R *.DFM}

procedure TFinDesdobramentoTipoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDDocumentoTipo.AsInteger := DM.GetConst('DocumentoTipo_Avulso');
  quFormCodigoDesdobramentoTipo.AsString := '#Auto#';
end;

procedure TFinDesdobramentoTipoFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  with quFormIdentificadorDesdobramento do
    if AsString = '' then
      AsString := '# ' + quFormDesdobramentoTipo.AsString;
end;

end.
