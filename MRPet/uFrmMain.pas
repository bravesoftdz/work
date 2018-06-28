unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxNavBarStyles, dxNavBarCollns, dxNavBarBase, ExtCtrls,
  dxNavBar, ImgList, dxBar, ComCtrls, XiButton, StdCtrls, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, Menus, uConfigFrm, Shellapi;

const
  WM_ICONMESSAGE = WM_USER + 1;
  MR_SYSTEM_TIP  = 'MRPet Server';
  REG_PATH       = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';
  MR_IMP_EXP     = 'MRImportExport.exe';
  MR_REPORT      = 'MRReport.exe';

type
  TFrmMain = class(TForm)
    dxBarManager: TdxBarManager;
    btnExit: TdxBarButton;
    subSystem: TdxBarSubItem;
    imgSmall: TImageList;
    imgLarge: TImageList;
    nbMain: TdxNavBar;
    bgPetCenter: TdxNavBarGroup;
    bgNews: TdxNavBarGroup;
    biMedicalCondition: TdxNavBarItem;
    biTreatments: TdxNavBarItem;
    biOrderSupplies: TdxNavBarItem;
    biPuppy: TdxNavBarItem;
    bbMicrochip: TdxBarButton;
    bsPetCenter: TdxBarSubItem;
    bbMedicalCondition: TdxBarButton;
    bbTreatments: TdxBarButton;
    bbBreed: TdxBarButton;
    bbRegistry: TdxBarButton;
    bbPuppy: TdxBarButton;
    bsPuppyAction: TdxBarSubItem;
    bbPuppyTreatment: TdxBarButton;
    bbPuppyMedicalCondition: TdxBarButton;
    bsImport: TdxBarSubItem;
    bbImportTabFile: TdxBarButton;
    bsReport: TdxBarSubItem;
    bbReports: TdxBarButton;
    stPetCenter: TdxNavBarStyleItem;
    StatusBar: TStatusBar;
    stMain: TdxNavBarStyleItem;
    stHeader: TdxNavBarStyleItem;
    Bevel1: TBevel;
    pnlTab: TPanel;
    AOTStyler: TAdvOfficeTabSetOfficeStyler;
    AOTabSet: TAdvOfficeMDITabSet;
    popUpMenuList: TPopupMenu;
    lbDateTime: TLabel;
    bbBreeder: TdxBarButton;
    bsFiles: TdxBarSubItem;
    bsPetReports: TdxBarSubItem;
    Timer: TTimer;
    bbConnection: TdxBarButton;
    biOnlineHelp: TdxNavBarItem;
    bbPetCenterConfig: TdxBarButton;
    bbPetSale: TdxBarButton;
    biPetSale: TdxNavBarItem;
    bbSearchSale: TdxBarButton;
    biSearchSale: TdxNavBarItem;
    subSecurity: TdxBarSubItem;
    bbUsers: TdxBarButton;
    popTaskBar: TPopupMenu;
    mExit: TMenuItem;
    bgLogin: TdxNavBarGroup;
    biLogout: TdxNavBarItem;
    bbSendData: TdxBarButton;
    bsTransfer: TdxBarSubItem;
    bbTransfer: TdxBarButton;
    ibTransfer: TdxNavBarItem;
    biHome: TdxNavBarItem;
    procedure bbMicrochipClick(Sender: TObject);
    procedure bbTreatmentsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AOTabSetTabClose(Sender: TObject; TabIndex: Integer;
      var Allow: Boolean);
    procedure FormShow(Sender: TObject);
    procedure bbMedicalConditionClick(Sender: TObject);
    procedure bbBreedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure bbRegistryClick(Sender: TObject);
    procedure biOrderSuppliesClick(Sender: TObject);
    procedure bbBreederClick(Sender: TObject);
    procedure bbConnectionClick(Sender: TObject);
    procedure biOnlineHelpClick(Sender: TObject);
    procedure bbPuppyClick(Sender: TObject);
    procedure bbPuppyTreatmentClick(Sender: TObject);
    procedure bbPuppyMedicalConditionClick(Sender: TObject);
    procedure bbPetCenterConfigClick(Sender: TObject);
    procedure bbPetSaleClick(Sender: TObject);
    procedure bbSearchSaleClick(Sender: TObject);
    procedure bbUsersClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure IconHandler(var msg: TMessage); message WM_ICONMESSAGE;
    procedure bbImportTabFileClick(Sender: TObject);
    procedure bbReportsClick(Sender: TObject);
    procedure biLogoutClick(Sender: TObject);
    procedure bbSendDataClick(Sender: TObject);
    procedure bbTransferClick(Sender: TObject);
    procedure biHomeClick(Sender: TObject);
  private
    AExit : Boolean;
    NIcon : TNotifyIconData; //Icon Tray
    FMenuControl : TStringList;
    FCanSendData : Boolean;

    procedure LoadParams;

    procedure SetMenu(sClassName, sParam : String);
    procedure StartFch(sClassName, sParam : String);
    procedure RefreshInfo;
    procedure RefreshWebInfo;
    procedure CreateMainForm;
    procedure OpenWeb(Web: String);
    procedure CloseAllForms;
    procedure PrintInvoice(AInvNum : String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uDMPet, uParentCustomList, uClasseFunctions, uParentSearchForm,
  uParentModalForm, uMainWebFrm, uDMMaintenance, uParentCustomFch,
  Registry, uDMPetCenter, uFileFunctions, uSystemConst, mrMsgBox,
  uSendDataFrm;

{$R *.dfm}

procedure TFrmMain.bbMicrochipClick(Sender: TObject);
var
  Form : TForm;
begin
  Form := CreateForm(Self, 'TPctMicrochipFrm');
  try
    TParentModalForm(Form).ShowFrm;
  finally
    FreeAndNil(Form);
  end;
end;

procedure TFrmMain.bbTreatmentsClick(Sender: TObject);
begin
  SetMenu('TPctTreatmentList', 'MenuDisplay=Treatment;');
end;

procedure TFrmMain.SetMenu(sClassName, sParam: String);
var
  Form : TForm;
  iIndex : Integer;
begin

  if DMPet.Login then
  begin
    StatusBar.Panels.Items[1].Text := DMPet.SystemUser.UserName;

    if DMPet.DataSetControl.SoftwareExpired then
      StatusBar.Panels.Items[2].Text := 'License expired since ' + FormatDateTime('ddddd', DMPet.DataSetControl.SoftwareExpirationDate)
    else if ((DMPet.DataSetControl.SoftwareExpirationDate - 10) < Trunc(Now)) then
      StatusBar.Panels.Items[2].Text := 'License will expire on ' + FormatDateTime('ddddd', DMPet.DataSetControl.SoftwareExpirationDate);

    LockWindowUpdate(Self.Handle);
    try
      iIndex := FMenuControl.IndexOf(sClassName);
      if iIndex = -1 then
      begin
        Form := CreateForm(Self, sClassName);
        FMenuControl.Add(Form.ClassName);
        Screen.Cursor := crHourglass;
        with TParentCustomList(Form) do
        try
          Init(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, sParam);
          ShowList;
          AOTabSet.AddTab(Form);
        finally
          Screen.Cursor := crDefault;
        end;
      end
      else
      begin
        AOTabSet.ActiveTabIndex := iIndex;
      end;
    finally
      LockWindowUpdate(0);
      end;
  end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  PrinterServerIP : String;
  Reg : TRegistry;
begin
  FMenuControl := TStringList.Create;
  AExit := True;

  {
  PrinterServerIP := DMPet.GetAppProperty('PrintServer', 'ServerIP');

  if PrinterServerIP <> '' then
  begin
    AExit := False;
    //Adding the icon to the system tray
    with NIcon do
    begin
      Wnd              := Handle;
      cbSize           := sizeof(NIcon);
      uCallbackMessage := WM_ICONMESSAGE;
      uID              := 1;
      uFlags           := NIF_MESSAGE or NIF_ICON or NIF_TIP;
      szTip            := MR_SYSTEM_TIP;
      hIcon            := Application.Icon.Handle;
      Shell_NotifyIcon(NIM_ADD,@NICON);
    end;

    //Inicializa o Servidor TCP/IP
    DMPetCenter.StartPrinterServer;
  end;
  }

  Reg := TRegistry.Create;
  try
    with Reg Do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey(REG_PATH, False);
      try
        if PrinterServerIP <> '' then
        begin
          if not ValueExists('MRPet') then
            WriteString('MRPet', Application.ExeName);
        end
        else
        begin
          if ValueExists('MRPet') then
            DeleteKey('MRPet');
        end;
      finally
        Reg.CloseKey;
      end;
    end;
  finally
    FreeAndNil(Reg);
  end;

end;

procedure TFrmMain.AOTabSetTabClose(Sender: TObject; TabIndex: Integer;
  var Allow: Boolean);
var
  FClassName : String;
  iIndex : Integer;
begin
  FClassName := AOTabSet.GetChildForm(AOTabSet.AdvOfficeTabs[TabIndex]).ClassName;
  if (FClassName <> 'TMainWebFrm') then
  begin
    iIndex := FMenuControl.IndexOf(FClassName);
    if iIndex <> -1 then
      FMenuControl.Delete(iIndex);
    Allow := True;
  end
  else
    Allow := False;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  FCanSendData := True;
  RefreshWebInfo;
  RefreshInfo;
  Timer.Enabled := True;
  CreateMainForm;
  LoadParams;
end;

procedure TFrmMain.bbMedicalConditionClick(Sender: TObject);
begin
  SetMenu('TPctMedicalConditionList', 'MenuDisplay=Medical Condition;');
end;

procedure TFrmMain.bbBreedClick(Sender: TObject);
begin
  SetMenu('TPctBreedList', 'MenuDisplay=Breed;');
end;

procedure TFrmMain.RefreshInfo;
begin
  lbDateTime.Caption := FormatDateTime('ddddd hh:mm', Now);
  lbDateTime.Hint := FormatDateTime('dddddd', Now);
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   if DMPet.GetAppProperty('PrintServer', 'ServerIP') <> '' then
   begin
     CloseAllForms;
     ShowWindow(handle,0);
     ShowWindow(Application.Handle, SW_HIDE);
   end;

   if AExit then
   begin
     DMPetCenter.StopPrinterServer;
     Action := caFree;
     Timer.Enabled := False;
     FreeAndNil(FMenuControl);
   end
   else
     Action := caNone;

end;

procedure TFrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.bbRegistryClick(Sender: TObject);
begin
  SetMenu('TPctRegistryList', 'MenuDisplay=Registry;');
end;

procedure TFrmMain.CreateMainForm;
var
  Form : TForm;
begin
  Form := CreateForm(Self, 'TMainWebFrm');
  FMenuControl.Add(Form.ClassName);
  AOTabSet.AddTab(Form);
  OpenWeb(DMPet.WebMain + DMPet.MRKey);
end;

procedure TFrmMain.biOrderSuppliesClick(Sender: TObject);
begin
  OpenWeb(DMPet.WebNews);
end;

procedure TFrmMain.bbBreederClick(Sender: TObject);
begin
  SetMenu('TMntEntityList', 'MenuDisplay=Breeder;EntityType='+IntToStr(PT_BREEDER)+';');
end;

procedure TFrmMain.bbConnectionClick(Sender: TObject);
begin
  with TConfigFrm.Create(Self) do
  try
     Start(TYPE_TAB_CONFIG);
  finally
    Free;
    end;
end;

procedure TFrmMain.biOnlineHelpClick(Sender: TObject);
begin
  OpenWeb(DMPet.OnlineHelp);
end;

procedure TFrmMain.OpenWeb(Web: String);
begin
  TMainWebFrm(AOTabSet.GetChildForm((AOTabSet.AdvOfficeTabs[0]))).DisplayWeb(Web);
  AOTabSet.ActiveTabIndex := 0;
end;

procedure TFrmMain.bbPuppyClick(Sender: TObject);
begin
  SetMenu('TPctPetList', 'MenuDisplay=Puppy;');
end;

procedure TFrmMain.bbPuppyTreatmentClick(Sender: TObject);
begin
  StartFch('TPctPetTreatmentFch', 'MenuDisplay=Apply Treatment;');
end;

procedure TFrmMain.bbPuppyMedicalConditionClick(Sender: TObject);
begin
  StartFch('TPctPetMedicalConditionFch', 'MenuDisplay=Apply Medical Condition;');
end;

procedure TFrmMain.StartFch(sClassName, sParam: String);
var
  Form : TForm;
begin

  if DMPet.Login then
  begin
    Form := CreateForm(Self, sClassName);
    try
      TParentCustomFch(Form).Init(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, nil, DMPet.SystemUser, sParam);
      TParentCustomFch(Form).Append('');
      TParentCustomFch(Form).ShowFch;
    finally
      Form.Free;
    end;
  end;

end;

procedure TFrmMain.bbPetCenterConfigClick(Sender: TObject);
begin
  if DMPet.Login then
    if (DMPet.SystemUser.IDUserType = USER_TYPE_ADMINISTRATOR) then
    begin
      with TConfigFrm.Create(Self) do
      try
         Start(TYPE_TAB_PETCENTER);
      finally
        Free;
        end;
    end
    else
    begin
      MsgBox('Only Administrator can access this feature!', vbInformation + vbOKOnly);
      DMPet.SystemUser.ID := 0;
    end;
end;

procedure TFrmMain.bbPetSaleClick(Sender: TObject);
var
  Form : TForm;
begin
  inherited;
  if DMPet.Login then
  begin
    if DMPet.PetIntegration then
    begin
      MsgBox('This function is deactivated when used with POS', vbInformation + vbOKOnly);
      Exit;
    end;
    Form := CreateForm(Self, 'TPctPetSaleFrm');
    try
      TParentModalForm(Form).ShowFrm;
    finally
      FreeAndNil(Form);
    end;
  end;
end;

procedure TFrmMain.RefreshWebInfo;
begin
  biOrderSupplies.Hint := DMPet.WebNews;
  biOnlineHelp.Hint    := DMPet.OnlineHelp;
end;

procedure TFrmMain.bbSearchSaleClick(Sender: TObject);
var
  Form : TForm;
begin

  if DMPet.Login then
  begin
    Form := CreateForm(Self, 'TPctPetSaleSearch');
    try
      TParentSearchForm(Form).Search('MenuDisplay=Search Puppy Sale;');
    finally
      FreeAndNil(Form);
    end;
  end;

end;

procedure TFrmMain.bbUsersClick(Sender: TObject);
begin

  if DMPet.Login then
    if (DMPet.SystemUser.IDUserType = USER_TYPE_ADMINISTRATOR) then
      SetMenu('TMntSystemUserList', 'MenuDisplay=User;')
    else
      MsgBox('Only Administrator can access this feature!', vbInformation + vbOKOnly);
      
end;

procedure TFrmMain.mExitClick(Sender: TObject);
begin
  AExit := True;
  Close;
end;

procedure TFrmMain.IconHandler(var msg: TMessage);
var
  Pt: TPoint;
begin

   if msg.LParam = WM_RBUTTONdown then
      begin
      GetCursorPos(Pt);
      SetforegroundWindow(handle);
      popTaskBar.popup(Pt.X, Pt.Y); // Ur popmenu here..
      end;

   if msg.LParam = wm_lbuttondblclk then
      begin
      ShowWindow(Handle, SW_SHOW);
      SetForeGroundWindow(Handle);
      Show;
      end;

   if msg.LParam = WM_MOUSEMOVE then
      begin
      StrPCopy(Nicon.szTip, MR_SYSTEM_TIP);
      Nicon.uID := 1;
      Shell_Notifyicon(NIM_MODIFY, @Nicon);
      end;

end;

procedure TFrmMain.bbImportTabFileClick(Sender: TObject);
begin
  if DMPet.Login then
    if FileExists(DMPet.LocalPath + MR_IMP_EXP) then
      ExecuteFile(DMPet.LocalPath + MR_IMP_EXP, 'PET ' + DMPet.SystemUser.Password, '', SW_SHOW);
end;

procedure TFrmMain.bbReportsClick(Sender: TObject);
var
  fReportParam : String;
begin
  if DMPet.Login then
  begin
    if (DMPet.SystemUser.Password <> '') then
       fReportParam := 'PW='+DMPet.SystemUser.Password+';';

    if FileExists(DMPet.LocalPath + MR_REPORT) then
      ExecuteFile(DMPet.LocalPath + MR_REPORT, fReportParam, '', SW_SHOW);
  end;
end;

procedure TFrmMain.biLogoutClick(Sender: TObject);
begin
  DMPet.SystemUser.ID := 0;
  StatusBar.Panels.Items[1].Text := '';
  CloseAllForms;
end;

procedure TFrmMain.bbSendDataClick(Sender: TObject);
begin

  if DMPet.Login then
    with TSendDataFrm.Create(Self) do
    try
      Init(False);
    finally
      Free;
    end;

end;

procedure TFrmMain.CloseAllForms;
var
  i : Integer;
  bAllow : Boolean;
begin

  i := AOTabSet.AdvOfficeTabCount-1;

  while i > 0 do
  begin
    if AOTabSet.GetChildForm(AOTabSet.AdvOfficeTabs[i]).ClassName <> 'TMainWebFrm' then
    begin
      AOTabSet.OnTabClose(AOTabSet.AdvOfficeTabs[i], i, bAllow);
      AOTabSet.GetChildForm(AOTabSet.AdvOfficeTabs[i]).Free;
    end;
    Dec(i);
  end;

end;

procedure TFrmMain.bbTransferClick(Sender: TObject);
begin
  SetMenu('TPctPetTransferList', 'MenuDisplay=Transfer Puppy;');
end;

procedure TFrmMain.biHomeClick(Sender: TObject);
begin
 OpenWeb(DMPet.WebMain + DMPet.MRKey);
end;

procedure TFrmMain.LoadParams;
begin

  if ParamCount > 0 then
  begin
    if ParamStr(1) = 'SALE' then
     if (ParamCount > 1) and (ParamStr(2) <> '') then
     begin
       PrintInvoice(ParamStr(2));
     end;
  end;

end;

procedure TFrmMain.PrintInvoice(AInvNum: String);
begin

  if StrToIntDef(AInvNum, 0) <> 0 then
  begin
    DMPetCenter.StartPrinterServer;
    if DMPetCenter.PrintSale(StrToInt(AInvNum)) then
      Close;
  end;

end;

end.
