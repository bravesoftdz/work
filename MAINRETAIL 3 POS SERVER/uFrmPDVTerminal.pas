unit uFrmPDVTerminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uSystemConst, siComp, Mask,
  SuperComboADO;


type
  TFrmPDVTerminal = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    siLang: TsiLang;
    lstCashReg: TListBox;
    btnAdd: TButton;
    scCashRegister: TSuperComboADO;
    GroupBox1: TGroupBox;
    Image2: TImage;
    Bevel3: TBevel;
    Label3: TLabel;
    scDefaultStore: TSuperComboADO;
    gbxStore: TGroupBox;
    Bevel4: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    lsbStore: TListBox;
    btnAddStore: TButton;
    scStores: TSuperComboADO;
    Image3: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure btnAddStoreClick(Sender: TObject);
  private
    fIsDBConnected : Boolean;
    procedure GetTerminalType;
    procedure SetStoreType;
  public
    function Start:Boolean;
  end;

implementation

uses uMainConf, uParamFunctions, uDMGlobal, uPOSServerConsts, uDMPOS;

{$R *.dfm}

procedure TFrmPDVTerminal.SetStoreType;
var
  sDir       : String;
  sDirCashReg: String;
  i          : Integer;
  iIDCashReg : Integer;
begin

  sDir := ExtractFilePath(Application.ExeName) + POS_DIR_FILES;

  for i:=0 to lstCashReg.Count-1 do
    begin

    iIDCashReg  := Integer((LongInt(lstCashReg.Items.Objects[i])));
    sDirCashReg := sDir + IntToStr(iIDCashReg);

    if not DirectoryExists(sDirCashReg) then
       ForceDirectories(sDirCashReg);

    if not FrmMain.fIniConfig.ValueExists(POS_PDV_KEY, lstCashReg.Items.Strings[i]) then
       FrmMain.fIniConfig.WriteInteger(POS_PDV_KEY, lstCashReg.Items.Strings[i], iIDCashReg);

    if not FrmMain.fIniConfig.ValueExists(IntToStr(iIDCashReg), 'LastImportDate') then
       FrmMain.fIniConfig.WriteString(IntToStr(iIDCashReg), 'LastImportDate', '');
    if not FrmMain.fIniConfig.ValueExists(IntToStr(iIDCashReg), 'LastImportStatus') then
       FrmMain.fIniConfig.WriteString(IntToStr(iIDCashReg), 'LastImportStatus', '');
    if not FrmMain.fIniConfig.ValueExists(IntToStr(iIDCashReg), POS_PDV_KEY_LAST_FILE) then
       FrmMain.fIniConfig.WriteString(IntToStr(iIDCashReg), POS_PDV_KEY_LAST_FILE, '');
    if not FrmMain.fIniConfig.ValueExists(IntToStr(iIDCashReg), POS_PDV_KEY_LAST_DATE) then
       FrmMain.fIniConfig.WriteString(IntToStr(iIDCashReg), POS_PDV_KEY_LAST_DATE, '');
    end;


  //Default Store
  if gbxStore.Visible and (lsbStore.Items.Text <> '') then
    FrmMain.fIniConfig.WriteString('Local', 'IDStoreList', lsbStore.Items.CommaText);

  FrmMain.fIniConfig.WriteString('Local', 'IDDefaultStore', scDefaultStore.LookUpValue);

  //FrmMain.LoadParamServerConnection;

end;

procedure TFrmPDVTerminal.GetTerminalType;
var
 sPDVList   : TStringList;
 i      : integer;
 iIDCashReg : LongInt;
begin
  sPDVList := TStringList.Create;
  lstCashReg.Clear;
  try
    FrmMain.fIniConfig.ReadSection(POS_PDV_KEY, sPDVList);
    For i:=0 to sPDVList.Count-1 do
      begin
      iIDCashReg := LongInt(FrmMain.fIniConfig.ReadInteger(POS_PDV_KEY, sPDVList[i], 0));
      lstCashReg.AddItem(sPDVList.Strings[i], Pointer(iIDCashReg));
      end;
  finally
      FreeAndNil(sPDVList);
    end;

  scDefaultStore.LookUpValue := FrmMain.fLocalSetting.IDDefaulStore;
  gbxStore.Visible := (FrmMain.fServerConnection.ConnectType = CON_TYPE_SERVER);
  if gbxStore.Visible then
  begin
    lsbStore.Items.CommaText := FrmMain.fLocalSetting.IDStoreList;
    Height := 515;
  end
  else
    Height := 370;

end;

function TFrmPDVTerminal.Start:Boolean;
begin

  fIsDBConnected := DMPOS.ADODBConnect.Connected;

  if not fIsDBConnected then
     DMPOS.OpenConnection;


  GetTerminalType;

  scCashRegister.LookUpValue := '';
  scStores.LookUpValue := '';

  ShowModal;

  Result := (ModalResult = mrOK);

  if Result then
     SetStoreType;

end;

procedure TFrmPDVTerminal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  if not fIsDBConnected then
     DMPOS.CloseConnection;


  Action := caFree;
  
end;

procedure TFrmPDVTerminal.btnAddClick(Sender: TObject);
var
  iIDCashReg : LongInt;
begin
  if lstCashReg.Items.IndexOf(scCashRegister.Text) = -1 then
     begin
     iIDCashReg := StrToInt(scCashRegister.LookUpValue);
     lstCashReg.AddItem(scCashRegister.Text, Pointer(iIDCashReg));
     end;
end;

procedure TFrmPDVTerminal.btnAddStoreClick(Sender: TObject);
var
  iIDStore : LongInt;
begin
  if (lsbStore.Items.IndexOf(scStores.LookUpValue) = -1) and
     (scStores.LookUpValue <>  '') and (scStores.LookUpValue <> scDefaultStore.LookUpValue) then
     begin
     iIDStore := StrToInt(scStores.LookUpValue);
     lsbStore.AddItem(scStores.LookUpValue, Pointer(iIDStore));
     end;
end;

end.
