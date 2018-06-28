unit uFrmStoreType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uSystemConst, ComCtrls, Mask;

type
  TFrmStoreType = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtCustomer: TEdit;
    Label1: TLabel;
    btnAddStore: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    edtStore: TEdit;
    Label3: TLabel;
    edtPW: TEdit;
    treeCustomer: TTreeView;
    btnDel: TSpeedButton;
    Label4: TLabel;
    edtConnection: TEdit;
    Label5: TLabel;
    edtSchedule: TEdit;
    btnOpenConnection: TSpeedButton;
    btnOpenSchedule: TSpeedButton;
    btnTestConnection: TSpeedButton;
    Label6: TLabel;
    edtVersion: TEdit;
    chkDisableSchedule: TCheckBox;
    Label7: TLabel;
    edtRepSince: TEdit;
    btnSaveSchedule: TSpeedButton;
    Label8: TLabel;
    edtMainStore: TEdit;
    pnlProcessor: TPanel;
    Label9: TLabel;
    edtHost: TEdit;
    Label10: TLabel;
    edtPort: TEdit;
    Label11: TLabel;
    edtStoreAuth: TEdit;
    Label12: TLabel;
    edtPassword: TMaskEdit;
    Label13: TLabel;
    edtPacketSize: TEdit;
    Label14: TLabel;
    cmbServerType: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddStoreClick(Sender: TObject);
    procedure edtCustomerKeyPress(Sender: TObject; var Key: Char);
    procedure btnDelClick(Sender: TObject);
    procedure treeCustomerClick(Sender: TObject);
    procedure btnOpenConnectionClick(Sender: TObject);
    procedure btnOpenScheduleClick(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
    procedure edtRepSinceChange(Sender: TObject);
    procedure chkDisableScheduleClick(Sender: TObject);
    procedure btnSaveScheduleClick(Sender: TObject);
    procedure cmbServerTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure GetStores;
    procedure ClearFields;
    function DeleteStore:Boolean;
    function ValitadeFields:Boolean;
    function SetStores(sCustomer, sStore, sPW : String):Boolean;
    procedure SetEnabladpnlProcessor(AEnabled: Boolean);
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uDMServer, uMainConf, ADODB, uFileFunctions, uEncryptFunctions, uFrmSchedule,
  IniFiles, uParamFunctions;

{$R *.dfm}

function TFrmStoreType.Start:Boolean;
begin

   GetStores;

   ShowModal;

   Result := (ModalResult=mrOK);

end;

procedure TFrmStoreType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmStoreType.btnAddStoreClick(Sender: TObject);
begin

  if not ValitadeFields then
     Exit;

  if SetStores(edtCustomer.Text, edtStore.Text, edtPW.Text) then
     begin
     GetStores;
     edtStore.Clear;
     edtPW.Clear;
     edtStore.SetFocus;
     end;

end;

procedure TFrmStoreType.edtCustomerKeyPress(Sender: TObject; var Key: Char);
begin

  if (Key IN [' ','/', '\']) then
     begin
     Key:=#0;
     MessageBeep($FFFFFFFF);
     end
  else
     Key:=Key;

end;

function TFrmStoreType.ValitadeFields: Boolean;
begin

  Result := False;

  if (Trim(edtCustomer.Text) = '') or (Trim(edtStore.Text) = '')
     or (Trim(edtPW.Text) = '') then

  Exit;

  Result := True;
  
end;

procedure TFrmStoreType.GetStores;
var
 sCustomerList,
 sCustomerStores : TStringList;
 fNode: TTreeNode;
 i, j : integer;
begin

   sCustomerList   := TStringList.Create;
   sCustomerStores := TStringList.Create;
   treeCustomer.Items.Clear;
   try
      FrmMain.fIniCustomersConfig.ReadSections(sCustomerList);
      For i:=0 to sCustomerList.Count-1 do
         begin
         fNode := treeCustomer.Items.Add(treeCustomer.Items.GetFirstNode,sCustomerList.Strings[i]);
         FrmMain.fIniCustomersConfig.ReadSection(sCustomerList.Strings[i], sCustomerStores);
         for j:=0 to sCustomerStores.Count-1 do
             if not DMServer.IsSessionToExclude(sCustomerStores.Strings[j]) then
                 treeCustomer.Items.AddChild(fNode, sCustomerStores.Strings[j]);
         end;
   finally
      FreeAndNil(sCustomerList);
      FreeAndNil(sCustomerStores);
      treeCustomer.FullExpand;
   end;

end;

function TFrmStoreType.SetStores(sCustomer, sStore,
  sPW: String): Boolean;
var
  sDir : String;
begin

  sDir := DMServer.LocalPath+sCustomer+'\'+sStore;

  //Create directories
  if not DirectoryExists(sDir) then
     ForceDirectories(sDir);

  FrmMain.fIniCustomersConfig.WriteString(LowerCase(sCustomer), LowerCase(sStore), LowerCase(sPW));

  Result := True;

end;

procedure TFrmStoreType.btnDelClick(Sender: TObject);
begin

  if not ValitadeFields then
     Exit;

  if DeleteStore then
     begin
     ClearFields;
     GetStores;
     end;
     
end;

function TFrmStoreType.DeleteStore: Boolean;
begin
  //Result := False;
  if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, edtStore.Text) then
     begin
     FrmMain.fIniCustomersConfig.DeleteKey(edtCustomer.Text, edtStore.Text);
     end;

  Result := True;
end;

procedure TFrmStoreType.treeCustomerClick(Sender: TObject);
var
  fNode : TTreeNode;
  sUncripted : String;
begin

  fNode := treeCustomer.Selected;

  ClearFields;

  if (fNode <> nil) then
    begin
    if (not fNode.HasChildren) and (fNode.Parent <> nil) then
       begin
       edtCustomer.Text := fNode.Parent.Text;
       edtStore.Text    := fNode.Text;
       edtPW.Text       := FrmMain.fIniCustomersConfig.ReadString(fNode.Parent.Text, fNode.Text, '');
       end
    else
       begin
       edtCustomer.Text := fNode.Text;
       end;

     if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, CONNECTION_STR) then
        edtConnection.Text := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, CONNECTION_STR, '');

     if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, SCHEDULE_STR) then
        edtSchedule.Text := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, SCHEDULE_STR, '');

     if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, VERSION_STR) then
        edtVersion.Text := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, VERSION_STR, '');

     btnSaveSchedule.Tag := 1;
     try
     
       if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, REPSINCE_STR) then
          edtRepSince.Text := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, REPSINCE_STR, '1');

       if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, DISABLESCHEDULE_STR) then
          chkDisableSchedule.Checked := FrmMain.fIniCustomersConfig.ReadBool(edtCustomer.Text, DISABLESCHEDULE_STR, False);

       if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, MAINSTORE_STR) then
          edtMainStore.Text := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, MAINSTORE_STR, '1');



       if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, SERVER_TYPE_STR) then
          cmbServerType.ItemIndex := FrmMain.fIniCustomersConfig.ReadInteger(edtCustomer.Text, SERVER_TYPE_STR, 0);


       SetEnabladpnlProcessor(True);
       Application.ProcessMessages;

       if FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, AUTH_CRIPTO_STR) then
       begin
         sUncripted := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, AUTH_CRIPTO_STR, '');

         sUncripted := DecodeServerInfo(sUncripted, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);

         edtHost.Text       := ParseParam(sUncripted, FILE_SERVER_HOST_STR);

         edtPort.Text       := ParseParam(sUncripted, FILE_SERVER_PORT_STR);

         edtStoreAuth.Text  := ParseParam(sUncripted, AUTH_STORE_NAME_STR);

         edtPassword.Text   := ParseParam(sUncripted, AUTH_PASSWORD_STR);

         edtPacketSize.Text := ParseParam(sUncripted, AUTH_PACKET_SIZE_STR);
       end;

       Application.ProcessMessages;
       SetEnabladpnlProcessor(cmbServerType.ItemIndex = 1);
     finally
       btnSaveSchedule.Tag := 0;
     end;

    end;

end;

procedure TFrmStoreType.ClearFields;
begin
  edtCustomer.Clear;
  edtStore.Clear;
  edtPW.Clear;
end;

procedure TFrmStoreType.btnOpenConnectionClick(Sender: TObject);
var
  sConnection : String;
begin

  if Trim(edtCustomer.Text) = '' then
     Exit;

  if not FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, CONNECTION_STR) then
     FrmMain.fIniCustomersConfig.WriteString(edtCustomer.Text, CONNECTION_STR, '');

  sConnection := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, CONNECTION_STR, '');

  sConnection := DMServer.GetServerConnection(sConnection, True);

  edtConnection.Text := sConnection;

  FrmMain.fIniCustomersConfig.WriteString(edtCustomer.Text, CONNECTION_STR, sConnection);

  GetStores;

end;

procedure TFrmStoreType.btnOpenScheduleClick(Sender: TObject);
var
  Schedule : String;
begin

  if (edtCustomer.Text = '') then
     Exit;

  if not FrmMain.fIniCustomersConfig.ValueExists(edtCustomer.Text, SCHEDULE_STR) then
     FrmMain.fIniCustomersConfig.WriteString(edtCustomer.Text, SCHEDULE_STR, '');

  Schedule := FrmMain.fIniCustomersConfig.ReadString(edtCustomer.Text, SCHEDULE_STR, '');

  with TFrmSchedule.Create(Self) do
     Schedule := BuildSchedule(Schedule);

  FrmMain.fIniCustomersConfig.WriteString(edtCustomer.Text, SCHEDULE_STR, Schedule);

  GetStores;

end;

procedure TFrmStoreType.btnTestConnectionClick(Sender: TObject);
var
  sConnection : String;
begin

  if (edtConnection.Text = '') then
     Exit;

  try
    sConnection := DecodeServerInfo(edtConnection.Text, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
  except
    sConnection := '';
    end;

  if sConnection <> '' then
     if DMServer.TestConnection(sConnection) then
        ShowMessage('Connection OK')
     else
        ShowMessage('Connection ERROR');

end;

procedure TFrmStoreType.edtRepSinceChange(Sender: TObject);
begin
  if btnSaveSchedule.Tag = 0 then
    btnSaveSchedule.Enabled := True;
end;

procedure TFrmStoreType.chkDisableScheduleClick(Sender: TObject);
begin
  if btnSaveSchedule.Tag = 0 then
    btnSaveSchedule.Enabled := True;
end;

procedure TFrmStoreType.btnSaveScheduleClick(Sender: TObject);
var
  sEncodedInfo: String;
begin
  FrmMain.fIniCustomersConfig.WriteInteger(edtCustomer.Text, REPSINCE_STR, StrToInt(edtRepSince.Text));
  FrmMain.fIniCustomersConfig.WriteBool(edtCustomer.Text, DISABLESCHEDULE_STR, chkDisableSchedule.Checked);
  FrmMain.fIniCustomersConfig.WriteInteger(edtCustomer.Text, MAINSTORE_STR, StrToInt(edtMainStore.Text));
  FrmMain.fIniCustomersConfig.WriteInteger(edtCustomer.Text, SERVER_TYPE_STR, cmbServerType.ItemIndex);


  sEncodedInfo := Format(FMT_CLIENT_CONNECTION, [edtHost.Text,
                                                 edtPort.Text,
                                                 edtStoreAuth.Text,
                                                 edtPacketSize.Text,
                                                 edtPassword.Text]);

  sEncodedInfo := EncodeServerInfo(sEncodedInfo, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);

  FrmMain.fIniCustomersConfig.WriteString(edtCustomer.Text, AUTH_CRIPTO_STR, sEncodedInfo);

  btnSaveSchedule.Enabled := False;
end;

procedure TFrmStoreType.cmbServerTypeChange(Sender: TObject);
begin
  SetEnabladpnlProcessor(cmbServerType.ItemIndex = 1);
  edtRepSinceChange(self);
end;

procedure TFrmStoreType.SetEnabladpnlProcessor(AEnabled : Boolean);
var
  AColor: TColor;
  I: Integer;
begin
  if AEnabled then
    AColor := clWhite
  else
    AColor := clSilver;

  for I := 0 to pnlProcessor.ControlCount - 1 do
  begin
    if pnlProcessor.Controls[I] is TEdit then
    begin
      TEdit(pnlProcessor.Controls[I]).Color := AColor;
      TEdit(pnlProcessor.Controls[I]).Enabled := AEnabled;
    end;

    if pnlProcessor.Controls[I] is TMaskEdit then
    begin
      TMaskEdit(pnlProcessor.Controls[I]).Color := AColor;
      TMaskEdit(pnlProcessor.Controls[I]).Enabled := AEnabled;
    end;
  end;
end;


end.
