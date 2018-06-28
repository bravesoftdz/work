unit uFinBancoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, FormConfig, Db, DBTables, ExtCtrls, Grids,
  Buttons, StdCtrls, Mask, DBCtrls, ComCtrls, dxBar, uParentFchList,
  dxDBGrid, dxCntner, dxTL, ImgList, dxDBCtrl, ADODB, PowerADOQuery,
  siComp, siLangRT;

type
  TFinBancoFch = class(TParentFchList)
    quFormIDBanco: TIntegerField;
    quFormCodigoBanco: TStringField;
    quFormBanco: TStringField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFchBrwIDBancoAgencia: TIntegerField;
    quFchBrwCodigoBancoAgencia: TStringField;
    quFchBrwBancoAgencia: TStringField;
    quFchBrwIDBanco: TIntegerField;
    Label7: TLabel;
    Label3: TLabel;
    grbFchBrwCodigoBancoAgencia: TdxDBGridMaskColumn;
    grbFchBrwBancoAgencia: TdxDBGridMaskColumn;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

uses uFinBancoAgenciaFch;

procedure TFinBancoFch.FormCreate(Sender: TObject);
begin
  inherited;
  FchBrwForm := TFinBancoAgenciaFch.Create(self);
end;

procedure TFinBancoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormCodigoBanco.AsString := '#Auto#';
end;

Initialization
  RegisterClass(TFinBancoFch);


end.
