unit uFinTransferenciaList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentList, Menus, ExtCtrls, dxDBGridPrint, dxBar, BrowseConfig, Db,
  DBTables, ImgList, dxBarExtItems, StdCtrls,
  dxCntner, dxTL, dxDBGrid, Buttons, Mask, dxDateEdit, dxGrClms, dxDBTLCl,
  dxDBCtrl, ADODB, PowerADOQuery, dxEditor, dxExEdtr, dxEdLib, dxPSCore,
  dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT, DateBox;

type
  TFinTransferenciaList = class(TParentList)
    brwGridIDTransferencia: TdxDBGridMaskColumn;
    brwGridContaDebito: TdxDBGridMaskColumn;
    brwGridContaCredito: TdxDBGridMaskColumn;
    brwGridUsuario: TdxDBGridMaskColumn;
    brwGridData: TdxDBGridDateColumn;
    brwGridValor: TdxDBGridMaskColumn;
    brwGridObs: TdxDBGridBlobColumn;
    quBrowseIDTransferencia: TIntegerField;
    quBrowseContaDebito: TStringField;
    quBrowseContaCredito: TStringField;
    quBrowseUsuario: TStringField;
    quBrowseData: TDateTimeField;
    quBrowseValor: TFloatField;
    quBrowseObs: TMemoField;
    Label4: TLabel;
    Label1: TLabel;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    procedure FormCreate(Sender: TObject);
    procedure dbInicioChange(Sender: TObject);
    procedure dbFimChange(Sender: TObject);
  private
    { Private declarations }
    procedure OnAfterStart; override;
  protected
    procedure OnBeforeDeleteItem; override;
  public
    { Public declarations }
    function ListParamRefresh : integer; override;
  end;

implementation

{$R *.DFM}

uses uFinTransferenciaFch, uMsgBox, uDateTimeFunctions, uMsgConstant, uDM;

procedure TFinTransferenciaList.OnBeforeDeleteItem;
begin
  with DM.quFreeSQL do
    try
      Close;
      SQL.Text := 'DELETE FROM Fin_Quitacao WHERE IDTransferencia = ' + quBrowseIDTransferencia.AsString;
      ExecSQL;
    except
      raise;
    end;

end;

function TFinTransferenciaList.ListParamRefresh : integer;
var
  InicioStr, FimStr: String;
begin

  // Testa se das datas de período são válidas
  if not TestDate(dbInicio.Text) then
    begin
      MsgBox(MSG_CRT_NO_VALID_INIDATE, vbCritical + vbOkOnly);
      dbInicio.SetFocus;
      Exit;
    end;

  if not TestDate(dbFim.Text) then
    begin
      MsgBox(MSG_CRT_NO_VALID_FIMDATE, vbCritical + vbOkOnly);
      dbFim.SetFocus;
      Exit;
    end;

  // altera qual o filtro por data
  InicioStr := Chr(39) + FormatDateTime('mm/dd/yyyy', dbInicio.Date) + Chr(39);
  FimStr    := Chr(39) + FormatDateTime('mm/dd/yyyy', dbFim.Date + 1) + Chr(39);

  WhereBasicFilter[1] := ' (T.Data >= ' + InicioStr + ' AND T.Data < ' + FimStr + ') ';

  ListRefresh;

  DesligaAviso;

end;

procedure TFinTransferenciaList.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TFinTransferenciaFch.Create(Self);
end;

procedure TFinTransferenciaList.OnAfterStart;
begin
  // Controla o modo de abertura do Browse
  // A Browse esta configurado para nao abrir automaticamente

  dbInicio.Date := InicioMes(Date());
  dbFim.Date    := FimMes(Date());
end;


procedure TFinTransferenciaList.dbInicioChange(Sender: TObject);
begin
  inherited;
  LigaAviso;
end;

procedure TFinTransferenciaList.dbFimChange(Sender: TObject);
begin
  inherited;
  LigaAviso;
end;

Initialization
  RegisterClass(TFinTransferenciaList);


end.
