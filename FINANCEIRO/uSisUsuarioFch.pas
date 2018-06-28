unit uSisUsuarioFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormConfig, Db, uParentFch, DBTables,
  StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls, Grids,
  uParentFchTab, ComCtrls, dxBar, dxDBGrid, uClasseFunctions,
  dxCntner, dxTL, ImgList, dxDBCtrl, ADODB, PowerADOQuery, RCADOQuery,
  siComp, siLangRT, SuperComboADO;

type
  TSisUsuarioFch = class(TParentFchTab)
    quFormCodigoUsuario: TStringField;
    quFormUsuario: TStringField;
    quFormSenha: TStringField;
    quMembro: TRCADOQuery;
    quNaoMembro: TRCADOQuery;
    dsMembro: TDataSource;
    dsNaoMembro: TDataSource;
    quMembroIDGrupo: TIntegerField;
    quMembroGrupo: TStringField;
    quMembroHidden: TBooleanField;
    quMembroDesativado: TBooleanField;
    quNaoMembroIDGrupo: TIntegerField;
    quNaoMembroGrupo: TStringField;
    tsCadastro: TTabSheet;
    tsGrupo: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label25: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    EditSenha: TDBEdit;
    EditSenhaConf: TEdit;
    Label9: TLabel;
    btInclui: TButton;
    btExclui: TButton;
    Label10: TLabel;
    grdMembro: TdxDBGrid;
    grdMembroGrupo: TdxDBGridMaskColumn;
    dxDBGrid1: TdxDBGrid;
    dxDBGridMaskColumn1: TdxDBGridMaskColumn;
    tsQuickInfo: TTabSheet;
    quFormContadorClasse: TIntegerField;
    cbxTotalSales: TCheckBox;
    cbxItemHold: TCheckBox;
    cbxItemsBuy: TCheckBox;
    cbxBK: TCheckBox;
    cbxRecApp: TCheckBox;
    cbxPayApp: TCheckBox;
    cbxPastDue: TCheckBox;
    quFormIDUser: TAutoIncField;
    quFormUserTypeID: TIntegerField;
    Label11: TLabel;
    Label12: TLabel;
    scUserType: TDBSuperComboADO;
    procedure FormShow(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure dsNaoMembroDataChange(Sender: TObject; Field: TField);
    procedure dsMembroDataChange(Sender: TObject; Field: TField);
    procedure btIncluiClick(Sender: TObject);
    procedure btExcluiClick(Sender: TObject);
    procedure PPageControlChange(Sender: TObject);
    procedure grdMembroDblClick(Sender: TObject);
    procedure dxDBGrid1DblClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure cbxTotalSalesClick(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    bEnableInfo : Boolean;
    aClass : Array [0..9] of Boolean;

    function TestOnBeforeSave : boolean; override;

    procedure FormEdit;
    procedure SaveQuickInfo;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uMsgBox, uDM, uSisMain, uSystemTypes, uMsgConstant;


procedure TSisUsuarioFch.FormEdit;
begin
  with quForm do
    if Active then
       if not (State in dsEditModes) then
          Edit;
end;

procedure TSisUsuarioFch.FormShow(Sender: TObject);
begin
  inherited;
  if frmCommand = btInc then
    begin
      EditSenhaConf.Text := '';
    end
  else
    begin
      EditSenhaConf.Text := quFormSenha.AsString;
    end;

  PPageControl.ActivePage := tsCadastro;

end;

function TSisUsuarioFch.TestOnBeforeSave : boolean;
begin
  Result := inherited TestOnBeforeSave;

  if EditSenhaCOnf.Text <> EditSenha.Text then
    begin
      MsgBox(MSG_CRT_ERROR_PW_NOT_CONFIRM, vbOkOnly + vbInformation);
      EditSenhaConf.SetFocus;
      Result := False;
    end;
end;


procedure TSisUsuarioFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  quMembro.Close;
  quNaoMembro.Close;

end;

procedure TSisUsuarioFch.dsNaoMembroDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  with quNaoMembro do
    btInclui.Enabled := NOT (EOF and BOF);

end;

procedure TSisUsuarioFch.dsMembroDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  with quMembro do
    btExclui.Enabled := NOT (EOF and BOF);

end;

procedure TSisUsuarioFch.btIncluiClick(Sender: TObject);
begin
  inherited;
  Self.TocaFicha;
  DM.RunSQL( 'INSERT Sis_UsuarioGrupo (IDUsuario, IDGrupo) VALUES (' +
          quFormIDUser.AsString + ' , ' +
          quNaoMembroIDGrupo.AsString + ')');

  quMembro.Requery;
  quNaoMembro.Requery;

end;

procedure TSisUsuarioFch.btExcluiClick(Sender: TObject);
begin
  inherited;
  Self.TocaFicha;
  DM.RunSQL( 'DELETE Sis_UsuarioGrupo WHERE IDUsuario = ' +
          quFormIDUser.AsString + ' AND IDGrupo = ' +
          quMembroIDGrupo.AsString );

  quMembro.Requery;
  quNaoMembro.Requery;

end;


procedure TSisUsuarioFch.PPageControlChange(Sender: TObject);
begin
  inherited;
  if PPageControl.ActivePage = tsCadastro then
    begin
    end
  else if PPageControl.ActivePage = tsGrupo then
    begin
      quMembro.Open;
      quNaoMembro.Open;
    end
  else if PPageControl.ActivePage = tsQuickInfo then
    begin
    end;

end;

procedure TSisUsuarioFch.grdMembroDblClick(Sender: TObject);
begin
  inherited;
  if btExclui.Enabled then
    btExcluiClick(nil);

end;

procedure TSisUsuarioFch.dxDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if btInclui.Enabled then
    btIncluiClick(nil);

end;

procedure TSisUsuarioFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  bEnableInfo := False;

  aClass[CONTADOR_OCORRENCIA_SALES_TODAY] := ClasseTem(CONTADOR_OCORRENCIA_SALES_TODAY, quFormContadorClasse.AsInteger);
  cbxTotalSales.Checked := aClass[CONTADOR_OCORRENCIA_SALES_TODAY];

  aClass[CONTADOR_OCORRENCIA_ITEM_ON_HOLD] := ClasseTem(CONTADOR_OCORRENCIA_ITEM_ON_HOLD, quFormContadorClasse.AsInteger);
  cbxItemHold.Checked   := aClass[CONTADOR_OCORRENCIA_ITEM_ON_HOLD];

  aClass[CONTADOR_OCORRENCIA_ITEM_ON_PO] := ClasseTem(CONTADOR_OCORRENCIA_ITEM_ON_PO, quFormContadorClasse.AsInteger);
  cbxItemsBuy.Checked   := aClass[CONTADOR_OCORRENCIA_ITEM_ON_PO];

  aClass[CONTADOR_OCORRENCIA_BREAK_EVEN] := ClasseTem(CONTADOR_OCORRENCIA_BREAK_EVEN, quFormContadorClasse.AsInteger);
  cbxBK.Checked         := aClass[CONTADOR_OCORRENCIA_BREAK_EVEN];

  aClass[CONTADOR_CONTARECEVER_APROVAR] := ClasseTem(CONTADOR_CONTARECEVER_APROVAR, quFormContadorClasse.AsInteger);
  cbxRecApp.Checked     := aClass[CONTADOR_CONTARECEVER_APROVAR];

  aClass[CONTADOR_CONTAPAGAR_APROVAR] := ClasseTem(CONTADOR_CONTAPAGAR_APROVAR, quFormContadorClasse.AsInteger);
  cbxPayApp.Checked     := aClass[CONTADOR_CONTAPAGAR_APROVAR];

  aClass[CONTADOR_PAYABLE_DUE_DATE_PAST] := ClasseTem(CONTADOR_PAYABLE_DUE_DATE_PAST, quFormContadorClasse.AsInteger);
  cbxPastDue.Checked    := aClass[CONTADOR_PAYABLE_DUE_DATE_PAST];

  bEnableInfo := True;

end;

procedure TSisUsuarioFch.SaveQuickInfo;
begin

  //Total SAles
  if cbxTotalSales.Checked <> aClass[CONTADOR_OCORRENCIA_SALES_TODAY] then
     quFormContadorClasse.AsInteger :=
                    GetClasse(CONTADOR_OCORRENCIA_SALES_TODAY,
                              quFormContadorClasse.AsInteger,
                              cbxTotalSales.Checked);

  //Items Order
  if cbxItemHold.Checked <> aClass[CONTADOR_OCORRENCIA_ITEM_ON_HOLD] then
     quFormContadorClasse.AsInteger :=
                  GetClasse(CONTADOR_OCORRENCIA_ITEM_ON_HOLD,
                            quFormContadorClasse.AsInteger,
                            cbxItemHold.Checked);

  //Items to Buy
  if cbxItemsBuy.Checked <> aClass[CONTADOR_OCORRENCIA_ITEM_ON_PO] then
     quFormContadorClasse.AsInteger :=
                  GetClasse(CONTADOR_OCORRENCIA_ITEM_ON_PO,
                            quFormContadorClasse.AsInteger,
                            cbxItemsBuy.Checked);

  //Break Even
  if cbxBK.Checked <> aClass[CONTADOR_OCORRENCIA_BREAK_EVEN] then
     quFormContadorClasse.AsInteger :=
                  GetClasse(CONTADOR_OCORRENCIA_BREAK_EVEN,
                            quFormContadorClasse.AsInteger,
                            cbxBK.Checked);

  //Acc Received
  if cbxRecApp.Checked <> aClass[CONTADOR_CONTARECEVER_APROVAR] then
     quFormContadorClasse.AsInteger :=
                  GetClasse(CONTADOR_CONTARECEVER_APROVAR,
                            quFormContadorClasse.AsInteger,
                            cbxRecApp.Checked);

  //Acc Pay
  if cbxPayApp.Checked <> aClass[CONTADOR_CONTAPAGAR_APROVAR] then
     quFormContadorClasse.AsInteger :=
                  GetClasse(CONTADOR_CONTAPAGAR_APROVAR,
                            quFormContadorClasse.AsInteger,
                            cbxPayApp.Checked);

  //Pay Past Due                          
  if cbxPastDue.Checked <> aClass[CONTADOR_PAYABLE_DUE_DATE_PAST] then
     quFormContadorClasse.AsInteger :=
                  GetClasse(CONTADOR_PAYABLE_DUE_DATE_PAST,
                            quFormContadorClasse.AsInteger,
                            cbxPastDue.Checked);



end;

procedure TSisUsuarioFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  SaveQuickInfo;

end;

procedure TSisUsuarioFch.cbxTotalSalesClick(Sender: TObject);
begin
  inherited;
  if bEnableInfo then
     FormEdit;
end;


procedure TSisUsuarioFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  //Main Retail UserType is required
  quFormUserTypeID.AsInteger := 2;
end;

Initialization
  RegisterClass(TSisUsuarioFch);


end.
