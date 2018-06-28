unit uSisGrupoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables, Buttons, StdCtrls, ExtCtrls,
  DBCtrls, uParentFchTab, ComCtrls, MemoStr, dxBar,
  dxGrClms, dxDBGrid, dxCntner, dxTL, Mask,
  dxtree, dxdbtree, ImgList, dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery,
  RCADOQuery, siComp, siLangRT;

type
  TSisGrupoFch = class(TParentFchTab)
    quFormIDGrupo: TIntegerField;
    quFormGrupo: TStringField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormSystem: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    tsEmpresaEspaco: TTabSheet;
    tsUsuario: TTabSheet;
    Label56: TLabel;
    quEmpresa: TRCADOQuery;
    dsEmpresa: TDataSource;
    Label9: TLabel;
    Label10: TLabel;
    btInclui: TButton;
    btExcluiTodos: TButton;
    btExclui: TButton;
    btIncluiTodos: TButton;
    Label2: TLabel;
    quMembro: TRCADOQuery;
    dsMembro: TDataSource;
    quNaoMembro: TRCADOQuery;
    dsNaoMembro: TDataSource;
    quMembroIDGrupo: TIntegerField;
    quMembroIDUsuario: TIntegerField;
    quMembroCodigoUsuario: TStringField;
    quMembroUsuario: TStringField;
    quNaoMembroIDUsuario: TIntegerField;
    quNaoMembroUsuario: TStringField;
    quEmpresaIDGrupo: TIntegerField;
    quEmpresaIDEmpresa: TIntegerField;
    quEmpresaEmpresa: TStringField;
    quEmpresaPermissao: TBooleanField;
    grdEmpresa: TdxDBGrid;
    grdEmpresaEmpresa: TdxDBGridMaskColumn;
    grdEmpresaPermissao: TdxDBGridCheckColumn;
    grdMembro: TdxDBGrid;
    grdMembroUsuario: TdxDBGridMaskColumn;
    grdNaoMembro: TdxDBGrid;
    grdNaoMembroUsuario: TdxDBGridMaskColumn;
    procedure AutoSave(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure PPageControlChange(Sender: TObject);
    procedure btIncluiClick(Sender: TObject);
    procedure btIncluiTodosClick(Sender: TObject);
    procedure btExcluiTodosClick(Sender: TObject);
    procedure btExcluiClick(Sender: TObject);
    procedure dsNaoMembroDataChange(Sender: TObject; Field: TField);
    procedure dsMembroDataChange(Sender: TObject; Field: TField);
    procedure grdMembroDblClick(Sender: TObject);
    procedure grdNaoMembroDblClick(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quOperacaoBeforeEdit(DataSet: TDataSet);
    procedure quEmpresaBeforeEdit(DataSet: TDataSet);
    procedure quMenuItemBeforeEdit(DataSet: TDataSet);
    procedure quEspacoBeforeEdit(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quPaginaBeforeEdit(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ControlaUsuario(Ativo: boolean);
    procedure ControlaEE(Ativo: boolean);
    procedure ControlaSA(Ativo: boolean);
  public
    { Public declarations }
  end;

implementation

uses uDM, uSisMain;

{$R *.DFM}

procedure TSisGrupoFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  ControlaEE(False);
  ControlaUsuario(False);
  ControlaSA(False);
end;

procedure TSisGrupoFch.FormShow(Sender: TObject);
begin
  inherited;
  PPageControlChange(nil);
end;


procedure TSisGrupoFch.AutoSave(DataSet: TDataSet);
begin
  with DataSet do
    if Active then
      if State in dsEditModes then
        Post;
end;


procedure TSisGrupoFch.ControlaEE(Ativo: boolean);
begin
  // On Before Close, testa se tem post pendente
  quEmpresa.Parameters.ParamByName('IDGrupo').Value := quFormIDGrupo.AsInteger;
  quEmpresa.Active := Ativo;

end;

procedure TSisGrupoFch.ControlaSA(Ativo: boolean);
begin

end;

procedure TSisGrupoFch.ControlaUsuario(Ativo: boolean);
begin
  quMembro.Parameters.ParamByName('IDGrupo').Value := quFormIDGrupo.AsInteger;
  quMembro.Active := Ativo;

  quNaoMembro.Parameters.ParamByName('IDGrupo').Value := quFormIDGrupo.AsInteger;
  quNaoMembro.Active := Ativo;

end;


procedure TSisGrupoFch.PPageControlChange(Sender: TObject);
begin
  inherited;
  if PPageControl.ActivePage = tsUsuario then
    begin
      ControlaUsuario(True);
      ControlaEE(False);
      ControlaSA(False);
    end
  else if PPageControl.ActivePage = tsEmpresaEspaco then
    begin
      ControlaUsuario(False);
      ControlaEE(True);
      ControlaSA(False);
    end

end;


procedure TSisGrupoFch.btIncluiClick(Sender: TObject);
begin
  inherited;
  DM.RunSQL( 'INSERT Sis_UsuarioGrupo (IDGrupo, IDUsuario) VALUES (' +
          quFormIDGrupo.AsString + ' , ' +
          quNaoMembroIDUsuario.AsString + ')');

  Self.TocaFicha;
  quMembro.Requery;
  quNaoMembro.Requery;

end;

procedure TSisGrupoFch.btIncluiTodosClick(Sender: TObject);
begin
  inherited;
  Self.TocaFicha;
  DM.RunSQL( 'INSERT Sis_UsuarioGrupo (IDGrupo, IDUsuario) ' +
             '( SELECT ' + quFormIDGrupo.AsString + ', IDUsuario FROM Sis_Usuario )' );

  quMembro.Requery;
  quNaoMembro.Requery;

end;

procedure TSisGrupoFch.btExcluiTodosClick(Sender: TObject);
begin
  inherited;
  Self.TocaFicha;
  DM.RunSQL( 'DELETE Sis_UsuarioGrupo WHERE IDGrupo = ' +
          quFormIDGrupo.AsString);

  quMembro.Requery;
  quNaoMembro.Requery;

end;

procedure TSisGrupoFch.btExcluiClick(Sender: TObject);
begin
  inherited;
  Self.TocaFicha;
  DM.RunSQL( 'DELETE Sis_UsuarioGrupo WHERE IDGrupo = ' +
          quFormIDGrupo.AsString + ' AND IDUsuario = ' +
          quMembroIDUsuario.AsString );

  quMembro.Requery;
  quNaoMembro.Requery;

end;

procedure TSisGrupoFch.dsNaoMembroDataChange(Sender: TObject;
  Field: TField);
var
  x: Boolean;

begin
  inherited;

  with quNaoMembro do
    x := not (EOF and BOF);

  btInclui.Enabled := x;
  btIncluiTodos.Enabled := x;

end;

procedure TSisGrupoFch.dsMembroDataChange(Sender: TObject; Field: TField);
var
  x: Boolean;

begin
  inherited;

  with quMembro do
    x := not (EOF and BOF);

  btExclui.Enabled := x;
  btExcluiTodos.Enabled := x;

end;

procedure TSisGrupoFch.grdMembroDblClick(Sender: TObject);
begin
  inherited;
  if btExclui.Enabled then
    btExcluiClick(nil);
end;

procedure TSisGrupoFch.grdNaoMembroDblClick(Sender: TObject);
begin
  inherited;
  if btInclui.Enabled then
    btIncluiClick(nil);
end;


procedure TSisGrupoFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  AutoSave(quEmpresa);
end;

procedure TSisGrupoFch.quOperacaoBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  Self.TocaFicha;
end;

procedure TSisGrupoFch.quEmpresaBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  Self.TocaFicha;

end;

procedure TSisGrupoFch.quMenuItemBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  Self.TocaFicha;

end;

procedure TSisGrupoFch.quEspacoBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  Self.TocaFicha;

end;

procedure TSisGrupoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  PPageControlChange(nil);
end;

procedure TSisGrupoFch.quPaginaBeforeEdit(DataSet: TDataSet);
begin
  inherited;

  Self.TocaFicha;
  
end;

Initialization
  RegisterClass(TSisGrupoFch);


end.
