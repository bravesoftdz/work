unit uFrmUser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Buttons,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, CheckLst, ComCtrls,
  siComp, siLangRT, uMsgBox, uMsgConstant;

type
  TbrwFrmUser = class(TbrwFrmParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    quStore: TADOQuery;
    quStoreIDStore: TAutoIncField;
    quStoreStore: TStringField;
    quFormIDUser: TAutoIncField;
    quFormUserTypeID: TIntegerField;
    quFormComissionID: TIntegerField;
    quFormSystemUser: TStringField;
    quFormPW: TStringField;
    quFormCodSystemUser: TStringField;
    quFormStoresAccess: TStringField;
    Panel5: TPanel;
    Label19: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label43: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edtLogin: TDBEdit;
    edtName: TDBEdit;
    scUserType: TDBSuperComboADO;
    edtPW: TDBEdit;
    scAssociatedCommission: TDBSuperComboADO;
    pnlPassword: TPanel;
    sbShowPW: TSpeedButton;
    edtViewPW: TDBEdit;
    clbStore: TCheckListBox;
    quValidateUser: TADOQuery;
    Label10: TLabel;
    lbEnterAss: TLabel;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormAfterClose(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure clbStoreClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbShowPWClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure StoreOpen;
    procedure StoreClose;

    procedure GetStoresRights;
    procedure SetStoresRights;
    function SetStoreAccess: Boolean;
  protected
    function OnValidadeField: boolean; override;
  end;

implementation

uses uDM, uSystemTypes, uDMGlobal, uSystemConst, DateUtils;

{$R *.DFM}

procedure TbrwFrmUser.StoreClose;
begin
  with quStore do
    if Active then
      Close;
end;

procedure TbrwFrmUser.StoreOpen;
begin
  with quStore do
    if not Active then
      Open;
end;

procedure TBrwFrmUser.GetStoresRights;
var
  i: Integer;
  slSelectStore: TStringList;
begin
  slSelectStore := TStringList.Create;
  slSelectStore.CommaText := quFormStoresAccess.AsString;
  StoreOpen;
  clbStore.Items.Clear;

  with quStore do
    while not EOF do
    begin
      i := clbStore.Items.Add(quStoreStore.AsString);
      clbStore.Checked[i] := (slSelectStore.IndexOf(quStoreIDStore.AsString) <> -1);
      Next;
    end;

  slSelectStore.Free;
end;

procedure TBrwFrmUser.SetStoresRights;
var
  i: Integer;
  sNewIn: String;
begin
  StoreOpen;
  sNewIn := '';

  with clbStore do
    for i := 0 to Items.Count-1 do
      if Checked[i] then
        if quStore.Locate('Store', Items[i], []) then
        begin
          if sNewIn <> '' then
            sNewIn := sNewIn + ', ' + quStoreIDStore.AsString
          else
            sNewIn := quStoreIDStore.AsString;
        end;

  quFormStoresAccess.AsString := sNewIn;
end;

procedure TbrwFrmUser.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //Ler as Stores
  GetStoresRights;
end;

procedure TbrwFrmUser.quFormAfterClose(DataSet: TDataSet);
begin
  inherited;
  StoreClose;
end;

procedure TbrwFrmUser.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  SetStoresRights;
end;

procedure TbrwFrmUser.clbStoreClickCheck(Sender: TObject);
begin
  inherited;
  quForm.Edit;
end;

procedure TbrwFrmUser.FormShow(Sender: TObject);
begin
  inherited;
  pnlPassword.Visible := (dm.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
end;

procedure TbrwFrmUser.sbShowPWClick(Sender: TObject);
begin
  inherited;
  edtViewPW.Visible := (not edtViewPW.Visible);
end;

function TbrwFrmUser.OnValidadeField: boolean;
begin
  with quValidateUser do
  begin
    if Active then
      Close;
    Parameters.ParamByName('SystemUser').Value := quFormSystemUser.AsString;
    Parameters.ParamByName('PW').Value := quFormPW.AsString;
    Parameters.ParamByName('IDUser').Value := quFormIDUser.AsInteger;

    try
      Open;
      Result := IsEmpty;
    finally
      Close;
    end;
  end;

  if not Result then
  begin
    MsgBox(MSG_CRT_USER_ALREADY_EXISTS, vbOKOnly + vbCritical);
    Exit;
  end;

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT IDUser');
    SQL.Add('FROM SystemUser');
    SQL.Add('WHERE CodSystemUser = :CodSystemUser');
    SQL.Add('AND IDUser <> :IDUser');

    Parameters.ParamByName('CodSystemUser').Value := quFormCodSystemUser.AsString;
    Parameters.ParamByName('IDUser').Value := quFormIDUser.AsInteger;

    Open;
    Result := IsEmpty;
  finally
    Close;
  end;

  if not Result then
  begin
    MsgBox(MSG_CRT_EXIST_USERCODE, vbOKOnly + vbCritical);
    Exit;
  end;
end;

procedure TbrwFrmUser.btCloseClick(Sender: TObject);
begin
  if edtLogin.Text = '' then
    MsgBox(MSG_CRT_NOT_EMPTY_USER , vbOKOnly + vbCritical)
  else if edtName.Text = '' then
    MsgBox(MSG_INF_CHOOSE_NAME, vbOKOnly + vbCritical)
  else if scUserType.Text = '' then
    MsgBox((Label3.Caption + ' ' + MSG_CRT_NO_EMPTY_VALUE), vbOKOnly + vbCritical)
  else if edtPW.Text = '' then
    MsgBox(MSG_INF_PASSWORD_CANNOT_BE_NULL, vbOKOnly + vbCritical)
  else if not SetStoreAccess then
    MsgBox(MSG_CRT_NO_STORE_SELECTED, vbOKOnly + vbCritical)
  else
    inherited;
end;

function TbrwFrmUser.SetStoreAccess: Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to quStore.RecordCount -1 do
    if clbStore.Checked[i] then
      Result := True;
end;

procedure TbrwFrmUser.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Usuario.htm';
      sUrlVideo := 'http://www.mainretail.com.br/treinamento/Video/Adicionar_Usuario/Adicionar_Usuario.html';
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;

end;

end.
