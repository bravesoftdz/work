unit uWzdPetCenter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentWizard, StdCtrls, Buttons, ExtCtrls, ComCtrls, jpeg;

type
  TWzdPetCenter = class(TFrmParentWizard)
    tsPetConfig: TTabSheet;
    imgLogo: TImage;
    Label1: TLabel;
    tsLicense: TTabSheet;
    tsCustomer: TTabSheet;
    Label17: TLabel;
    edtLoja: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtCEP: TLabeledEdit;
    edtTel: TLabeledEdit;
    edtFax: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtWeb: TLabeledEdit;
    imgStore: TImage;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbTipoNegocio: TLabel;
    cbxBreeder: TComboBox;
    Image2: TImage;
    Label6: TLabel;
    Image3: TImage;
    tsDatabase: TTabSheet;
    edtHostName: TLabeledEdit;
    edtDatabase: TLabeledEdit;
    edtUser: TLabeledEdit;
    Image4: TImage;
    Label8: TLabel;
    edtPassword: TLabeledEdit;
    Label9: TLabel;
    cbxMicrochip: TComboBox;
    Label10: TLabel;
    cbxPet: TComboBox;
    Label11: TLabel;
    cbxPetKit: TComboBox;
    edtPetUser: TLabeledEdit;
    edtPetPW: TLabeledEdit;
    rbDoNotAgree: TRadioButton;
    rbIAgree: TRadioButton;
    lbSimplesHelp: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lbFailConnection: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label50: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    reLicense: TRichEdit;
    edtContact1: TLabeledEdit;
    edtPhone1: TLabeledEdit;
    edtEmail1: TLabeledEdit;
    Bevel1: TBevel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    EdtEndreco2: TLabeledEdit;
    edtCountry: TLabeledEdit;
    Label26: TLabel;
    Label39: TLabel;
    Image6: TImage;
    Image5: TImage;
    Label40: TLabel;
    TimerGetKey: TTimer;
    Label27: TLabel;
    Label44: TLabel;
    Label29: TLabel;
    Label28: TLabel;
    Label36: TLabel;
    Label16: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Image1: TImage;
    Image7: TImage;
    Label30: TLabel;
    procedure TimerGetKeyTimer(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edtPetPWKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmailExit(Sender: TObject);
  private
    FIDMicrochipCategory : Integer;
    FCustomerKey : string;

    function OpenConnection : Boolean;
    procedure FillBreeder;
    procedure FillCategory;
    function ValidateCategory(AName : String; AType : Integer) : Boolean;
    function ValidateEqualCategories : Boolean;
    function ValidateUser : Boolean;

    function CreateStore : Boolean;
    function CreateBreeder : Boolean;
    function CreateCategory : Boolean;
    function CreateUser : Boolean;
    function CreateIniFiles : Boolean;
    function ApplicationSetup : Boolean;
    function CreateCustomerInfo : Boolean;
    procedure CompletingWizard;
    procedure LauchApplication;

    //Pet Files
    function AddBreed(ABreed : String) : Boolean;
    function AddMedicalCondition(AMedical, ASubMedical : String):Boolean;
    function AddTreatment(ATreatment: String; AType : Integer; AManu : String):Boolean;
    function AddMicrochip(AModel, ADescription : String; ASalePrice : Currency):Boolean;
    function AddColor(AColor : String) : Boolean;

    function AddBreedList : Boolean;
    function AddColorList : Boolean;
    function AddMedicalConditionList : Boolean;
    function AddTreatmentList : Boolean;
    function AddMicrochipList : Boolean;

    function CreatePetData : Boolean;
  protected
    procedure OnMovePriorPage; override;
    procedure OnMoveNextPage; override;
    function ValidatePage : Boolean; override;
    procedure Finish; override;
  public
    procedure Start; override;
  end;

implementation

uses uDMExport, uSQLObj, uMsgBox, uOperationSystem, ADODB, DB, IniFiles,
     uEncryptFunctions, DBClient, uMainRetailKey, shellapi, uWebFunctions,
     uCharFunctions;

{$R *.dfm}

{ TWzdPetCenter }

procedure TWzdPetCenter.CompletingWizard;
begin
  btnPrior.Visible    := False;
  btnNext.Visible     := False;
  //TimerGetKey.Enabled := True;
  Close;
end;

function TWzdPetCenter.CreateBreeder: Boolean;
begin

  Result := True;

  try
    with DMExport.quFreeSQL do
    try
      SQL.Clear;
      SQL.Add('SELECT TipoPessoa');
      SQL.Add('FROM TipoPessoa');
      SQL.Add('WHERE Desativado = 0 AND Hidden = 0 AND TipoPessoa = ' + QuotedStr(cbxBreeder.Text));
      Open;
      if not IsEmpty then
        Exit;
    finally
      Close;
      SQL.Clear;
    end;

    with TPessoaTipo.Create do
    try
      IDTipoPessoaRoot := 7;
      TipoPessoa := cbxBreeder.Text;
      if Insert then
      begin
        DMExport.RunSQL('UPDATE Sis_PropertyDomain Set PropertyValue = '+QuotedStr(IntToStr(IDTipoPessoa))+ ' WHERE Property = ' + QuotedStr('PctBreederDefaultEntityType'));
        DMExport.RunSQL('UPDATE Sis_PropertyDomain Set PropertyValue = '+QuotedStr(Path)+ ' WHERE Property = ' + QuotedStr('PctBreederDefaultEntityTypePath'));
      end;
    finally
      Free;
    end;

  except
    on E: Exception do
    begin
      DMExport.AddLog('CreateBreeder : ' + E.Message);
      Result := False;
    end;
  end;

end;

function TWzdPetCenter.CreateCategory: Boolean;
var
 ID : Integer;
 sSQL : String;
begin

  Result := True;

  DMExport.FTax.BrazilMode := False;

  try
    with TCategory.Create do
    try
      Category := cbxMicrochip.Text;
      if not Find then
        Insert;
      ID := IDCategory;
      FIDMicrochipCategory := IDCategory;
    finally
      Free;
    end;

    sSQL := 'UPDATE Sis_PropertyDomain Set PropertyValue = ' + QuotedStr(IntToStr(ID)) + ' WHERE Property = ' + QuotedStr('PctMicrochipCategory');
    DMExport.cmdFree.CommandText := sSQL;
    DMExport.cmdFree.Execute;

    with TCategory.Create do
    try
      Category := cbxPet.Text;
      PuppyTracker := True;
      if not Find then
        Insert;
      ID := IDCategory;
    finally
      Free;
    end;

    sSQL := 'UPDATE Sis_PropertyDomain Set PropertyValue = '+QuotedStr(IntToStr(ID))+ ' WHERE Property = ' + QuotedStr('PctPetCategory');
    DMExport.cmdFree.CommandText := sSQL;
    DMExport.cmdFree.Execute;

    with TCategory.Create do
    try
      Category := cbxPetKit.Text;
      PuppyTracker := False;
      PackModel := True;
      PackModelAddItems := True;
      if not Find then
        Insert;
      ID := IDCategory;
    finally
      Free;
    end;

    sSQL := 'UPDATE Sis_PropertyDomain Set PropertyValue = '+QuotedStr(IntToStr(ID))+ ' WHERE Property = ' + QuotedStr('PctPetKitCategory');
    DMExport.cmdFree.CommandText := sSQL;
    DMExport.cmdFree.Execute;

  except
    on E: Exception do
    begin
      DMExport.AddLog('CreateCategory : ' + E.Message);
      Result := False;
    end;
  end;

end;

function TWzdPetCenter.CreateCustomerInfo: Boolean;
var
  MRKey : TMRKey;
  MRStore : TMRStore;
begin

  Result := False;

  try
    MRStore := TMRStore.Create;

    with MRStore do
    try
      FStore    := edtLoja.Text;
      FAddress1 := edtEndereco.Text;
      FAddress2 := EdtEndreco2.Text;
      FCity     := edtCidade.Text;
      FState    := edtEstado.Text;
      FZip      := edtCEP.Text;
      FCountry  := edtCountry.Text;
      FPhone    := edtTel.Text;
      FFax      := edtFax.Text;
      FEmail    := edtEmail.Text;
      FWebsite  := edtWeb.Text;
      FContact1 := edtContact1.Text;
      FC1Phone  := edtPhone1.Text;
      FC1Email  := edtEmail1.Text;

      MRKey := TMRKey.Create(DMExport.ADODBConnect);
      try
        MRKey.FMRStore := MRStore;
        MRKey.VerifyKey('ALL');
        FCustomerKey := MRKey.FKey;
      finally
        FreeAndNil(MRKey);
      end;

    finally
      FreeAndNil(MRStore);
    end;

    Result := True;

  except
    on E: Exception do
      DMExport.AddLog('CreateCustomerInfo : ' + E.Message);
  end;

end;

function TWzdPetCenter.CreateIniFiles: Boolean;
var
  ClientID : String;
begin

  Result := True;

  ClientID := edtLoja.Text;

  try

    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'MRAppServer.ini') do
    try
      WriteString(ClientID, 'DriverName', 'SQLOLEDB.1');
      WriteString(ClientID, 'BlobSize', '-1');
      WriteString(ClientID, 'HostName', edtHostName.Text);
      WriteString(ClientID, 'DataBase', edtDatabase.Text);
      WriteString(ClientID, 'User', EncodeServerInfo(edtUser.Text, 'User', CIPHER_TEXT_STEALING, FMT_UU));
      WriteString(ClientID, 'Password', EncodeServerInfo(edtPassword.Text, 'PW', CIPHER_TEXT_STEALING, FMT_UU));
      WriteBool(ClientID, 'UseNetLib', False);
    finally
      Free;
    end;

    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'MRImportExport.ini') do
    try
      WriteString('Connection', 'Type', 'SOCKET');
      WriteString('Connection', 'ClientID', ClientID);
      WriteString('Connection', 'Host', edtHostName.Text);
      WriteString('Connection', 'Port', '211');
    finally
      Free;
    end;

    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'MRPet.ini') do
    try
      WriteString('Connection', 'Type', 'SOCKET');
      WriteString('Connection', 'ClientID', ClientID);
      WriteString('Connection', 'Host', edtHostName.Text);
      WriteString('Connection', 'Port', '211');
    finally
      Free;
    end;

    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'MRReport.ini') do
    try
      WriteString('Connection', 'Type', 'SOCKET');
      WriteString('Connection', 'ClientID', ClientID);
      WriteString('Connection', 'Host', edtHostName.Text);
      WriteString('Connection', 'Port', '211');

      WriteString('Default', 'ReportPath', DMExport.LocalPath + 'Reports\');
      WriteString('Default', 'LogoPath', '');
      WriteString('Default', 'UpdateFile', 'http://www.mainretail.com/download/reports_en/versioncontrol.ini');
      WriteInteger('Default', 'IDLanguage', 0);
    finally
      Free;
    end;

  except
    on E: Exception do
    begin
      DMExport.AddLog('CreateIniFiles : ' + E.Message);
      Result := False;
    end;
  end;

end;

function TWzdPetCenter.CreateStore: Boolean;
begin

  Result := True;

  try
    with DMExport.quFreeSQL do
    try
      SQL.Clear;
      SQL.Add('SELECT TOP 1 IDStore');
      SQL.Add('FROM Store WHERE Desativado = 0 AND System = 0');
      Open;
      if not IsEmpty then
      begin
        DMExport.FStore.ID := FieldByName('IDStore').AsInteger;
        Exit;
      end;
    finally
      Close;
      SQL.Clear;
    end;

    with DMExport.FStore do
    begin
      StoreName := edtLoja.Text;
      Address := edtEndereco.Text;
      City := edtCidade.Text;
      Zip := edtCEP.Text;
      IDState := edtEstado.Text;
      Tel := edtTel.Text;
      Fax := edtFax.Text;
      Email := edtEmail.Text;
      Web := edtWeb.Text;
      //StoreState : String;
      //TicketHeader : String;
      //TicketLayawayFooter : String;
      //TicketTaxIsemptFooter : String;
      //Contat : String;
      Insert;
    end;

    DMExport.FTax.SaleTaxName := edtEstado.Text;
    DMExport.FTax.Insert;

    //Pet default store
    DMExport.RunSQL('UPDATE Sis_PropertyDomain Set PropertyValue = '+QuotedStr(IntToStr(DMExport.FStore.ID))+ ' WHERE Property = ' + QuotedStr('PctDefaultStore'));

  except
    on E: Exception do
    begin
      DMExport.AddLog('CreateStore : ' + E.Message);
      Result := False;
    end;
  end;

end;

function TWzdPetCenter.CreateUser: Boolean;
begin

  Result := True;

  if ValidateUser then
  try
    with DMExport do
    begin
      if not cdsUser.Active then
        cdsUser.CreateDataSet;

      with cdsUser do
      begin
        Append;
        FieldByName('UserName').Value   := edtPetUser.Text;
        FieldByName('Password').Value   := edtPetPW.Text;
        FieldByName('IDUserType').Value := 1;
        Post;
      end;

      BuildUsers;
      CloseUser;
    end;

  except
    on E: Exception do
    begin
      DMExport.AddLog('CreateUser : ' + E.Message);
      Result := False;
    end;
  end;

end;

procedure TWzdPetCenter.FillBreeder;
begin
  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT IDTipoPessoa, TipoPessoa');
    SQL.Add('FROM TipoPessoa');
    SQL.Add('WHERE Desativado = 0 AND Hidden = 0 AND Path Like ' + QuotedStr('.004%'));
    Open;
    First;
    cbxBreeder.Clear;
    While not EOF do
    begin
      cbxBreeder.AddItem(FieldByName('TipoPessoa').AsString, nil);
      Next;
    end;
    cbxBreeder.Text := 'Breeder';
  finally
    Close;
    SQL.Clear;
  end;
end;

procedure TWzdPetCenter.FillCategory;
begin
  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT Name, PackModel, PuppyTracker');
    SQL.Add('FROM TabGroup');
    SQL.Add('WHERE Desativado = 0 AND Hidden = 0');
    Open;
    First;
    cbxMicrochip.Clear;
    cbxPet.Clear;
    cbxPetKit.Clear;

    While not EOF do
    begin
      if FieldByName('PackModel').AsBoolean then
        cbxPetKit.AddItem(FieldByName('Name').AsString, nil)
      else if FieldByName('PuppyTracker').AsBoolean then
        cbxPet.AddItem(FieldByName('Name').AsString, nil)
      else
        cbxMicrochip.AddItem(FieldByName('Name').AsString, nil);
      Next;
    end;
    cbxMicrochip.Text := 'Microchips';
    cbxPet.Text := 'Pets';
    cbxPetKit.Text := 'Pet Kits';
  finally
    Close;
    SQL.Clear;
  end;
end;

procedure TWzdPetCenter.Finish;
begin
  inherited;

  Screen.Cursor := crHourGlass;

  try

    if CreateCustomerInfo then
      if CreateStore then
        if CreateBreeder then
          if CreateCategory then
            if CreateUser then
              if CreateIniFiles then
                if ApplicationSetup then
                  if CreatePetData then
                  begin
                    DMExport.SaveRegistryInfo;
                    LauchApplication;
                    CompletingWizard;
                  end;

  finally
    Screen.Cursor := crDefault;
    DMExport.DeletePetWrdFile;
  end;

end;

procedure TWzdPetCenter.OnMoveNextPage;
begin
  inherited;

  btnClose.Visible := True;

  if pgWizard.ActivePage = tsLicense then
  begin
  end else if pgWizard.ActivePage = tsCustomer then
  begin
  end else if pgWizard.ActivePage = tsDatabase then
  begin
    btnNextClick(self);
  end
  else if pgWizard.ActivePage = tsPetConfig then
  begin
    OpenConnection;
  end
  else if pgWizard.ActivePage = tsFinish then
  begin
    btnNext.Caption := 'Finish';
    btnClose.Visible := False;
  end;
    
end;

procedure TWzdPetCenter.OnMovePriorPage;
begin
  inherited;
  
  btnNext.Caption := 'Next >>';
  btnClose.Visible := True;

  if pgWizard.ActivePage = tsDatabase then
  begin
    btnPriorClick(self);
  end

end;

function TWzdPetCenter.OpenConnection: Boolean;
begin

  Result := False;
  Screen.Cursor := crHourGlass;
  try
    lbFailConnection.Visible := False;
    if not DMExport.ADODBConnect.Connected then
    begin
      if not DMExport.StartDatabaseConnection then
      begin
        lbFailConnection.Visible := True;
        Exit;
      end
      else
      begin
        FillBreeder;
        FillCategory;
      end;
    end;

    if (DMExport.fSQLConnectParam.Server <> '.') and (DMExport.fSQLConnectParam.Server <> '(local)') then
      edtHostName.Text := DMExport.fSQLConnectParam.Server
    else
      edtHostName.Text := ReturnComputerName;
      
    edtDatabase.Text := DMExport.fSQLConnectParam.DBAlias;
    edtUser.Text     := DMExport.fSQLConnectParam.UserName;
    edtPassword.Text := DMExport.fSQLConnectParam.PW;

    Result := True;
  finally
    Screen.Cursor := crDefault;
  end;

end;

function TWzdPetCenter.ValidateCategory(AName: String;
  AType: Integer): Boolean;
begin

  Result := False;

  if AType = 1 then //Simples
  begin
    if (cbxPet.Items.IndexOf(AName) <> -1) or (cbxPetKit.Items.IndexOf(AName) <> -1) then
      Exit;
  end
  else if AType = 2 then //Pet
  begin
    if (cbxMicrochip.Items.IndexOf(AName) <> -1) or (cbxPetKit.Items.IndexOf(AName) <> -1) then
      Exit;
  end
  else if AType = 3 then //Pet Kir
    if (cbxMicrochip.Items.IndexOf(AName) <> -1) or (cbxPet.Items.IndexOf(AName) <> -1) then
      Exit;

  Result := True;

end;

function TWzdPetCenter.ValidateEqualCategories: Boolean;
begin
  Result := False;

  if (cbxMicrochip.Text = cbxPet.Text) or (cbxMicrochip.Text = cbxPetKit.Text) or
    (cbxPet.Text = cbxPetKit.Text) then
    Exit;

  Result := True;
end;

function TWzdPetCenter.ValidatePage: Boolean;
begin
  inherited ValidatePage;
  Result := False;

  if pgWizard.ActivePage = tsIntro then
  begin
  end else if pgWizard.ActivePage = tsLicense then
  begin
    if (not rbIAgree.Checked) then
    begin
      MsgBox('Select "I Agree" to proceed', vbOkOnly + vbInformation);
      Exit;
    end;
  end else if pgWizard.ActivePage = tsCustomer then
  begin

    if (edtLoja.Text = '') then
    begin
      MsgBox('Enter store', vbOkOnly + vbInformation);
      edtLoja.SetFocus;
      Exit;
    end else if (edtEndereco.Text = '') then
    begin
      MsgBox('Enter address 1', vbOkOnly + vbInformation);
      edtEndereco.SetFocus;
      Exit;
    end else if (edtCidade.Text = '') then
    begin
      MsgBox('Enter city', vbOkOnly + vbInformation);
      edtCidade.SetFocus;
      Exit;
    end else if (edtCEP.Text = '') then
    begin
      MsgBox('Enter ZIP', vbOkOnly + vbInformation);
      edtCEP.SetFocus;
      Exit;
    end else if (edtEstado.Text = '') then
    begin
      MsgBox('Enter state', vbOkOnly + vbInformation);
      edtEstado.SetFocus;
      Exit;
    end else if (edtTel.Text = '') then
    begin
      MsgBox('Enter phone', vbOkOnly + vbInformation);
      edtTel.SetFocus;
      Exit;
    end else if (edtEmail.Text = '') then
    begin
      MsgBox('Enter Store e-mail', vbOkOnly + vbInformation);
      edtEmail.SetFocus;
      Exit;
    end else if (edtContact1.Text = '') then
    begin
      MsgBox('Enter contact', vbOkOnly + vbInformation);
      edtContact1.SetFocus;
      Exit;
    end else if (edtPhone1.Text = '') then
    begin
      MsgBox('Enter phone', vbOkOnly + vbInformation);
      edtPhone1.SetFocus;
      Exit;
    end else if (edtEmail1.Text = '') then
    begin
      MsgBox('Enter E-mail', vbOkOnly + vbInformation);
      edtEmail1.SetFocus;
      Exit;
    end;

  end else if pgWizard.ActivePage = tsDatabase then
  begin
    if not OpenConnection then
      Exit;

    if (edtHostName.Text = '') then
    begin
      MsgBox('Enter host name', vbOkOnly + vbInformation);
      edtHostName.SetFocus;
      Exit;
    end else if (edtDatabase.Text = '') then
    begin
      MsgBox('Enter database name', vbOkOnly + vbInformation);
      edtDatabase.SetFocus;
      Exit;
    end else if (edtUser.Text = '') then
    begin
      MsgBox('Enter user name', vbOkOnly + vbInformation);
      edtUser.SetFocus;
      Exit;
    end else if (edtPassword.Text = '') then
    begin
      MsgBox('Enter password', vbOkOnly + vbInformation);
      edtPassword.SetFocus;
      Exit;
    end;
  end
  else if pgWizard.ActivePage = tsPetConfig then
  begin

    if (cbxBreeder.Text = '') then
    begin
      MsgBox('Enter breeder', vbOkOnly + vbInformation);
      cbxBreeder.SetFocus;
      Exit;
    end else if (cbxMicrochip.Text = '') then
    begin
      MsgBox('Enter microchip category', vbOkOnly + vbInformation);
      cbxMicrochip.SetFocus;
      Exit;
    end else if (cbxPet.Text = '') then
    begin
      MsgBox('Enter pets category', vbOkOnly + vbInformation);
      cbxPet.SetFocus;
      Exit;
    end else if (cbxPetKit.Text = '') then
    begin
      MsgBox('Enter pet kits category', vbOkOnly + vbInformation);
      cbxPetKit.SetFocus;
      Exit;
    end else if (edtPetUser.Text = '') then
    begin
      MsgBox('Enter user', vbOkOnly + vbInformation);
      edtPetUser.SetFocus;
      Exit;
    end else if (edtPetPW.Text = '') then
    begin
      MsgBox('Enter password', vbOkOnly + vbInformation);
      edtPetPW.SetFocus;
      Exit;
    end else if not ValidateCategory(cbxMicrochip.Text,  1) then
    begin
      MsgBox('Microchip category already exist', vbOkOnly + vbInformation);
      cbxMicrochip.SetFocus;
      Exit;
    end else if not ValidateCategory(cbxPet.Text,  2) then
    begin
      MsgBox('Pets category already exist', vbOkOnly + vbInformation);
      cbxPet.SetFocus;
      Exit;
    end else if not ValidateCategory(cbxPetKit.Text,  3) then
    begin
      MsgBox('Pet Kits category already exist', vbOkOnly + vbInformation);
      cbxPetKit.SetFocus;
      Exit;
    end else if not ValidateEqualCategories then
    begin
      MsgBox('Category names cannot be equal', vbOkOnly + vbInformation);
      Exit;
    end;
  end;


 Result := True;

end;

function TWzdPetCenter.ValidateUser: Boolean;
begin

  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT TOP 1 IDUser');
    SQL.Add('FROM SystemUser ');
    SQL.Add('WHERE PW = ' + QuotedStr(edtPetPW.Text) );
    Open;
    Result := IsEmpty;
  finally
    Close;
    SQL.Clear;
  end;

end;

procedure TWzdPetCenter.TimerGetKeyTimer(Sender: TObject);
var
  MRKey : TMRKey;
  bResult : Boolean;
begin
  inherited;

  TimerGetKey.Enabled := False;

  MRKey := TMRKey.Create(DMExport.ADODBConnect);
  try
    bResult := MRKey.CheckKey('ALL');
  finally
    FreeAndNil(MRKey);
  end;

  if not bResult then
    TimerGetKey.Enabled := True
  else
    Close;

end;

function TWzdPetCenter.ApplicationSetup: Boolean;
var
  sFileName, sCmd : String;
begin

  Result := False;

  try
    //Create report folder
    if not DirectoryExists(DMExport.LocalPath + 'Reports\') then
      CreateDir(DMExport.LocalPath + 'Reports\');

    //Open and save socket info
    sFileName := DMExport.LocalPath + 'scktsrvr.exe';
    if FileExists(sFileName) then
    begin
      DMExport.SaveWinStartUp('SocketServer', sFileName);
      ShellExecute(handle, 'open', PChar(sFileName), nil, nil, 1);
    end;

    //create task manager for MRPetDate
    sFileName := DMExport.LocalPath + 'PCMaintSvc.exe';
    if FileExists(sFileName) then
    begin
      //sCmd := Format('schtasks /create /tn "Pet Center" /tr "%S" /ru System /sc daily /st 14:58:00', [sFileName + ' 1']);
      //ExecuteShellCommand(sCmd, true);
      ShellExecute(handle, 'open', PChar(sFileName), ' --install auto', nil, 1);
    end;

    //Create Shortcuts
    sFileName := DMExport.LocalPath + 'MRPet.exe';
    if FileExists(sFileName) then
    begin
       //Create a Shortcut on the Desktop
       CreateShortcut(sFileName, _DESKTOP, '','','','PetCenter', 'PetCenter');

       //Create a Shortcut in the Startmenu /"Programs"-Folder
       CreateShortcut(sFileName, _OTHERFOLDER, GetProgramDir,'','','PetCenter', 'PetCenter');
    end;

    if FCustomerKey <> '' then
    begin
      sFileName := 'https://www.pinogy.com/cgi-bin/PCAuth/ord/checkout.html?mv_pc='+FCustomerKey;
      OpenURL(sFileName);
    end;

    Result := True;

  except
    on E: Exception do
    begin
      DMExport.AddLog('ApplicationSetup : ' + E.Message);
      Result := False;
    end;
  end;


end;

procedure TWzdPetCenter.Start;
begin
  inherited;
  DMExport.CreatePetWrdFile;
end;

function TWzdPetCenter.AddBreed(ABreed: String): Boolean;
begin
  if not DMExport.ValueExist('Pet_Breed', 'Breed', '', ABreed, '') then
    DMExport.InsertBreed(ABreed);
  Result := True;
end;

function TWzdPetCenter.AddMedicalCondition(AMedical,
  ASubMedical: String): Boolean;
begin
  if not DMExport.ValueExist('Pet_MedicalCondition', 'MedicalCondition', 'SubMedicalCondition', AMedical, ASubMedical) then
    DMExport.InsertMedicalCondition(AMedical, ASubMedical);
  Result := True;
end;

function TWzdPetCenter.AddTreatment(ATreatment: String; AType : Integer;
  AManu : String): Boolean;
begin
  if not DMExport.ValueExist('Pet_Treatment', 'Treatment', '', ATreatment, '') then
    DMExport.InsertTreamtne(ATreatment, AManu, AType);
  Result := True;
end;

function TWzdPetCenter.AddBreedList: Boolean;
begin
  AddBreed('Akita');
  AddBreed('American Bulldog');
  AddBreed('American Eskimo');
  AddBreed('Australian Shepard');
  AddBreed('Basset Hound');
  AddBreed('Beagle');
  AddBreed('Bernese Mnt. Dog');
  AddBreed('Bichon Frise');
  AddBreed('Bichon-Poo');
  AddBreed('Bloodhound');
  AddBreed('Border Collie');
  AddBreed('Boston Terrier');
  AddBreed('Boxer');
  AddBreed('Brittany Spaniel');
  AddBreed('Brussels Griffon');
  AddBreed('Bull Terrier');
  AddBreed('Bullmastiff');
  AddBreed('Cairn Terrier');
  AddBreed('Cavalier King Charles');
  AddBreed('Chihuahua');
  AddBreed('Cock-a-Poo');
  AddBreed('Cocker Spaniel');
  AddBreed('Coton de Tulear');
  AddBreed('Dachshund');
  AddBreed('Doberman Pinscher');
  AddBreed('Dogue de Bordeaux');
  AddBreed('Domestic Kitten');
  AddBreed('English Bulldog');
  AddBreed('English Mastiff');
  AddBreed('English Springer Spaniel');
  AddBreed('French Bulldog');
  AddBreed('German Shepherd Dog');
  AddBreed('Golden Retriever');
  AddBreed('Great Dane');
  AddBreed('Great Pyrenees');
  AddBreed('Havanese');
  AddBreed('Irish Terrier');
  AddBreed('Italian Greyhound');
  AddBreed('Jack Russell Terrier');
  AddBreed('Japanese Chin');
  AddBreed('Keeshond');
  AddBreed('Labrador Retriever');
  AddBreed('Lhasa Apso');
  AddBreed('Maltese');
  AddBreed('Maltese-Poodle');
  AddBreed('Miniature Pinscher');
  AddBreed('Miniature Schauzer');
  AddBreed('Mix Breed');
  AddBreed('Neapolitan Mastiff');
  AddBreed('Newfoundland');
  AddBreed('Norwegian Elkhound');
  AddBreed('Norwich Terrier');
  AddBreed('Old English Sheepdog');
  AddBreed('Papillon');
  AddBreed('Pekingese');
  AddBreed('Pembroke Welsh Corgi');
  AddBreed('Pomeranian');
  AddBreed('Poodle');
  AddBreed('Pug');
  AddBreed('Puggle');
  AddBreed('Rat Terrier');
  AddBreed('Rottweiler');
  AddBreed('Saint Bernard');
  AddBreed('Schipperke');
  AddBreed('Scottish Terrier');
  AddBreed('Shetland Sheepdog');
  AddBreed('Shiba Inu');
  AddBreed('Shih Tzu');
  AddBreed('Siberian Husky');
  AddBreed('Silky Terrier');
  AddBreed('Skye Terrier');
  AddBreed('Soft Coated Wheaton Terrier');
  AddBreed('Soilky Terrier');
  AddBreed('Standard Poodle');
  AddBreed('Toy Fox Terrier');
  AddBreed('Weimaraner');
  AddBreed('West Highland Wh Tr');
  AddBreed('Wirehair Fox Terrier');
  AddBreed('Yorkshire Terrier');

  Result := True;
end;

function TWzdPetCenter.CreatePetData: Boolean;
begin

  try

    AddMicrochipList;
    AddBreedList;
    AddColorList;
    AddMedicalConditionList;
    AddTreatmentList;

    Result := True;

  except
    on E: Exception do
    begin
      DMExport.AddLog('CreatePetData : ' + E.Message);
      Result := False;
    end;
  end;

end;

function TWzdPetCenter.AddMedicalConditionList: Boolean;
begin

  AddMedicalCondition('Abdominal' , 'Inguinal Weakness-Right');
  AddMedicalCondition('Abdominal' , 'Inguinal Weakness-Left');
  AddMedicalCondition('Coat', 'Broken Collar');
  AddMedicalCondition('Coat', 'Cream on Back');
  AddMedicalCondition('Coat', 'Cream on Ears');
  AddMedicalCondition('Coat', 'Cream on Head');
  AddMedicalCondition('Coat', 'Haircoat');
  AddMedicalCondition('Coat', 'Hairloss');
  AddMedicalCondition('Coat', 'Hock Callus');
  AddMedicalCondition('Coat', 'Hock Hairloss');
  AddMedicalCondition('Coat', 'Hock Sores');
  AddMedicalCondition('Coat', 'Long Hair');
  AddMedicalCondition('Confirmation', 'Not Representative of the Breed.');
  AddMedicalCondition('Confirmation', 'Elbow Sores');
  AddMedicalCondition('Confirmation', 'Flowered Tongue');
  AddMedicalCondition('Confirmation', 'Dew Claws-Front');
  AddMedicalCondition('Confirmation', 'Bi-Inguinal Weakness');
  AddMedicalCondition('Confirmation', 'Kink in tail');
  AddMedicalCondition('Confirmation', 'Natural Screwtail');
  AddMedicalCondition('Confirmation', 'Pink Eye Rim-Partial');
  AddMedicalCondition('Confirmation', 'Pink Eye Rim');
  AddMedicalCondition('Confirmation', 'Pronounced Sternum');
  AddMedicalCondition('Confirmation', 'Dew Claws-Rear');
  AddMedicalCondition('Confirmation', 'Short');
  AddMedicalCondition('Confirmation', 'Short Hair');
  AddMedicalCondition('Confirmation', 'Short Haircoat');
  AddMedicalCondition('Confirmation', 'Dew Claws-Rear');
  AddMedicalCondition('Confirmation', 'Slight');
  AddMedicalCondition('Confirmation', 'Small');
  AddMedicalCondition('Confirmation', 'Tail Knob');
  AddMedicalCondition('Confirmation', 'THIN HAIRCOAT');
  AddMedicalCondition('Ears', 'Discolored Eye-Green Eyes');
  AddMedicalCondition('Ears', 'Discolored Eye-Left Blue Eye');
  AddMedicalCondition('Ears', 'Discolored Eye-Right Blue Eye');
  AddMedicalCondition('Ears', 'Confirmation');
  AddMedicalCondition('Ears', 'Ear Infection-Both Ears');
  AddMedicalCondition('Ears', 'Ear Infection-Left Ear');
  AddMedicalCondition('Ears', 'Ear Infection-Right Ear');
  AddMedicalCondition('Ears', 'Ears 1/2 Up-Both Ears');
  AddMedicalCondition('Ears', 'Ear 1/2 Up-Left Ear');
  AddMedicalCondition('Ears', 'Ear 1/2 Up-Right Ear');
  AddMedicalCondition('Ears', 'Ears Down-Both Ears');
  AddMedicalCondition('Ears', 'Ear Down-Right Ear');
  AddMedicalCondition('Ears', 'Ear Down-Left Ear');
  AddMedicalCondition('Ears', 'Ears Up');
  AddMedicalCondition('Eye', 'Entropian Repair-Right Eye');
  AddMedicalCondition('Eye', 'Entropian Repair-Left Eye');
  AddMedicalCondition('Eye', 'Entropian Repair-Both Eyes');
  AddMedicalCondition('Eye', 'Green Eyes');
  AddMedicalCondition('Eye', 'WALL-EYED');
  AddMedicalCondition('Head', 'Open Font 1/16""');
  AddMedicalCondition('Head', 'Open Font 1/8""');
  AddMedicalCondition('Head', 'Open Font 3/16""');
  AddMedicalCondition('Head', 'Open Font 1/4""');
  AddMedicalCondition('Head', 'Open Font 1/16""x1/8""');
  AddMedicalCondition('Head', 'Open Font 1/8.x3/16.');
  AddMedicalCondition('Head', 'Open Font 3/16.x1/4.');
  AddMedicalCondition('Head', 'Open Font 1/16.x3/16.');
  AddMedicalCondition('Head', 'Open Font 1/8.x1/4.');
  AddMedicalCondition('Head', 'Open Font 1/16.x1/4.');
  AddMedicalCondition('Heart Murmur', 'Systolic Heart Murmur I/VI');
  AddMedicalCondition('Heart Murmur', 'Systolic Heart Murmur II/VI');
  AddMedicalCondition('Heart Murmur', 'Systolic Heart Murmur III/VI');
  AddMedicalCondition('Heart Murmur', 'Systolic Heart Murmur IV/VI');
  AddMedicalCondition('Heart Murmur', 'Systolic Heart Murmur V/VI');
  AddMedicalCondition('Knee', 'Grade 1 Knee-Right');
  AddMedicalCondition('Knee', 'Grade 1 Knee-Left');
  AddMedicalCondition('Knee', 'Grade 1 Knee-Both');
  AddMedicalCondition('Knee', 'Grade 2 Knee-Right');
  AddMedicalCondition('Knee', 'Grade 2 Knee-Left');
  AddMedicalCondition('Knee', 'Grade 2 Knee-Both');
  AddMedicalCondition('Knee', 'Grade 3 Knee-Right');
  AddMedicalCondition('Knee', 'Grade 3 Knee-Left');
  AddMedicalCondition('Knee', 'Grade 3 Knee- Both');
  AddMedicalCondition('Knee', 'Grade 4 Knee-Right');
  AddMedicalCondition('Knee', 'Grade 4 Knee-Left');
  AddMedicalCondition('Knee', 'Grade 4 Knee- Both');
  AddMedicalCondition('Markings', 'Full Collar');
  AddMedicalCondition('Markings', 'Liver Points');
  AddMedicalCondition('Markings', 'Mask');
  AddMedicalCondition('Markings', 'Mismarked');
  AddMedicalCondition('Markings', 'Pink on Nose');
  AddMedicalCondition('Markings', 'WHITE ON BACK TOES');
  AddMedicalCondition('Markings', 'WHITE ON CHEST AND TOES');
  AddMedicalCondition('Markings', 'WHITE ON CHIN');
  AddMedicalCondition('Markings', 'WHITE ON CHST');
  AddMedicalCondition('Markings', 'WHITE ON FRONT TOES');
  AddMedicalCondition('Markings', 'WHITE ON TOES');
  AddMedicalCondition('Other', 'OFA Dam');
  AddMedicalCondition('Other', 'OFA Sire');
  AddMedicalCondition('Other', 'Swelling');
  AddMedicalCondition('Other', 'Swollen Lymph Node');
  AddMedicalCondition('Other', 'Tear Stain');
  AddMedicalCondition('Registry', 'AM BULLDOG ASSOCIATION');
  AddMedicalCondition('Registry', 'AMERICAN BORDER COLLIE ASSOC.');
  AddMedicalCondition('Registry', 'AMERICAN CANINE ASSOCIATION');
  AddMedicalCondition('Registry', 'AMERICAN CANINE HYBRIDS');
  AddMedicalCondition('Registry', 'AMERICAN KENNEL CLUB');
  AddMedicalCondition('Registry', 'AMERICAN PET RECORDS');
  AddMedicalCondition('Registry', 'AMERICAN REG. OF RARE BREEDS');
  AddMedicalCondition('Registry', 'AMERICAS PET REGISTRY INC.');
  AddMedicalCondition('Registry', 'AUST SHEP CLUB OF AMERICA');
  AddMedicalCondition('Registry', 'CANINE KENNEL CLUB');
  AddMedicalCondition('Registry', 'CANINE REGIS/ CERTIF.SERVICE');
  AddMedicalCondition('Registry', 'CAVACHON CLUB OF AMERICA');
  AddMedicalCondition('Registry', 'CONTINENTAL KENNEL CLUB');
  AddMedicalCondition('Registry', 'DOG REGISTRY OF AMERICA');
  AddMedicalCondition('Registry', 'FEDERAL INTERNATIONAL CANINE');
  AddMedicalCondition('Registry', 'FIELD DOG STUB BOOK APPLICATIO');
  AddMedicalCondition('Registry', 'FIELD DOG STUD BOOK REGISTRY');
  AddMedicalCondition('Registry', 'INTERNATIONAL ENGLISH SHEPHERD');
  AddMedicalCondition('Registry', 'INTER-NATIONAL KENNEL CLUB');
  AddMedicalCondition('Registry', 'INTERNATIONAL PET SERVICES CORPORATION');
  AddMedicalCondition('Registry', 'JACK RUSSELL TERRIER REGISTRY');
  AddMedicalCondition('Registry', 'NATIONAL KENNEL CLUB, INC');
  AddMedicalCondition('Registry', 'NATIONAL STOCK DOG REGISTRY');
  AddMedicalCondition('Registry', 'NATL ASSC OF LOUISANA CATAHUL');
  AddMedicalCondition('Registry', 'NORTH AMER SHEEP DOG SOCIETY');
  AddMedicalCondition('Registry', 'NORTH AMERICAN PURE BREED DOG REGISTRY');
  AddMedicalCondition('Registry', 'THE AMERICAN RABBIT HOUND ASSC');
  AddMedicalCondition('Registry', 'THE BOYKIN SPANIEL SOCIETY');
  AddMedicalCondition('Registry', 'THE REGISTRY');
  AddMedicalCondition('Registry', 'UNITED ALL BREED REGISTRY');
  AddMedicalCondition('Registry', 'UNITED KENNEL CLUB');
  AddMedicalCondition('Registry', 'UNITED PET REGISTRY');
  AddMedicalCondition('Registry', 'UNIVERSAL KENNEL CLUB');
  AddMedicalCondition('Registry', 'UNREGISTERED');
  AddMedicalCondition('Registry', 'WORLD KENNEL CLUB');
  AddMedicalCondition('Registry', 'WORLD WIDE KENNEL CLUB');
  AddMedicalCondition('Respiratory', 'Nose Clips');
  AddMedicalCondition('Respiratory', 'Stenotic Nares');
  AddMedicalCondition('Respiratory', 'Tight Nostrils');
  AddMedicalCondition('Respiratory', 'NARROW NOSTRILS');
  AddMedicalCondition('Surgical Procedure', 'Bi-Inguinal Hernia Repair');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Hernia Repair-Left');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Hernia Repair-Right');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Hernia Repair-Middle');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Repair-Right');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Herna Repair-Left');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Hernia Repair-Midline');
  AddMedicalCondition('Surgical Procedure', 'Inguinal Weakness-Right');
  AddMedicalCondition('Surgical Procedure', 'Neutered');
  AddMedicalCondition('Teeth', 'Open Bite 1/16""');
  AddMedicalCondition('Teeth', 'Open Bite 1/8""');
  AddMedicalCondition('Teeth', 'Open Bite 3/16""');
  AddMedicalCondition('Teeth', 'Open Bite 1/4""');
  AddMedicalCondition('Teeth', 'Open Bite 1/2""');
  AddMedicalCondition('Teeth', 'Open Bite 3/4""');
  AddMedicalCondition('Teeth', 'Open Bite 3/8""');
  AddMedicalCondition('Teeth', 'Even Bite');
  AddMedicalCondition('Teeth', 'Incissors');
  AddMedicalCondition('Teeth', 'Normal Bite');
  AddMedicalCondition('Teeth', 'Scissors Overbite');
  AddMedicalCondition('Teeth', 'Scissors Underbite');
  AddMedicalCondition('Teeth', 'Level Bite');
  AddMedicalCondition('Teeth', 'Malocclusion');
  AddMedicalCondition('Teeth', 'Wry Bite');
  AddMedicalCondition('Teeth', 'Under Bite 1/16""');
  AddMedicalCondition('Teeth', 'Under Bite 1/8""');
  AddMedicalCondition('Teeth', 'Under Bite 3/16""');
  AddMedicalCondition('Teeth', 'Under Bite 1/4""');
  AddMedicalCondition('Teeth', 'Under Bite 1/2""');
  AddMedicalCondition('Teeth', 'Under Bite 3/4""');
  AddMedicalCondition('Teeth', 'Under Bite 3/8""');
  AddMedicalCondition('Hernia', 'Inguinal Hernia Repair');
  AddMedicalCondition('Hernia', 'Umbilical Hernia Repair');
  AddMedicalCondition('Alter', 'Neutered');
  AddMedicalCondition('Check Up', 'Routine');
  AddMedicalCondition('Test', 'Feline Leukemia Test-Negative');
  AddMedicalCondition('Test', 'Giardia Test-Negative');
  AddMedicalCondition('Test', 'Giardia Test-Positive');

  Result := True;
end;

function TWzdPetCenter.AddTreatmentList: Boolean;
begin

  AddTreatment('Nutrient Gel', 3, '');
  AddTreatment('Albon', 3, '');
  AddTreatment('Anthelcide', 2, '');
  AddTreatment('Bactrovet', 3, '');
  AddTreatment('Evict', 2, '');
  AddTreatment('Bordettella', 1, '');
  AddTreatment('Eclipse 3', 1, '');
  AddTreatment('Bronchicine', 1, '');
  AddTreatment('DA2PL', 1, '');
  AddTreatment('Fulvici', 3, '');
  AddTreatment('Coughguard B', 1, '');
  AddTreatment('Corona', 1, '');
  AddTreatment('CPV 11', 1, '');
  AddTreatment('Cestex', 2, '');
  AddTreatment('CVK', 1, '');
  AddTreatment('DA2P', 1, '');
  AddTreatment('DHL', 1, '');
  AddTreatment('DA2P+CPV', 1, '');
  AddTreatment('DA2PL+CPV', 1, '');
  AddTreatment('DA2PLPV+CVK', 1, '');
  AddTreatment('DA2PP+CVK', 1, '');
  AddTreatment('DHLP+PV', 1, '');
  AddTreatment('Imathal Equine', 2, '');
  AddTreatment('DA2MP', 1, '');
  AddTreatment('Droncit', 2, '');
  AddTreatment('Eclipse 4', 1, '');
  AddTreatment('Flagyl', 3, '');
  AddTreatment('Felocell 4', 1, '');
  AddTreatment('Felocell 3', 1, '');
  AddTreatment('Fel-O-Vax IV', 1, '');
  AddTreatment('FeloVac PCT', 1, '');
  AddTreatment('FVR-C-P', 1, '');
  AddTreatment('Intra Trac II', 1, '');
  AddTreatment('Imrab 1', 1, '');
  AddTreatment('Ivomec', 2, '');
  AddTreatment('Casey', 3, '');
  AddTreatment('KF 11', 1, '');
  AddTreatment('Lepto', 1, '');
  AddTreatment('DA2PL+PV', 1, '');
  AddTreatment('Leukocell', 1, '');
  AddTreatment('Metronidazole', 3, '');
  AddTreatment('CPV MOD. LIVE', 1, '');
  AddTreatment('Norden', 1, '');
  AddTreatment('Neopar', 1, '');
  AddTreatment('Nasaguard-B', 1, '');
  AddTreatment('Nemex II', 2, '');
  AddTreatment('Nutri-Drops', 3, '');
  AddTreatment('Nutrient Gel ', 3, '');
  AddTreatment('Nolvamite', 3, '');
  AddTreatment('NUTRIENT GEL=', 3, '');
  AddTreatment('Oxfendazole', 2, '');
  AddTreatment('DA2P+PV', 1, '');
  AddTreatment('Panacur', 2, '');
  AddTreatment('Parvo & Corona', 1, '');
  AddTreatment('Puppy Aid', 3, '');
  AddTreatment('Progard-KC', 1, '');
  AddTreatment('Parvo-Live', 1, '');
  AddTreatment('Pamoate', 2, '');
  AddTreatment('Panacine', 1, '');
  AddTreatment('PROGRAM', 3, '');
  AddTreatment('Pyrantel Pamoate', 2, '');
  AddTreatment('Parvo', 1, '');
  AddTreatment('Pyran-50', 2, '');
  AddTreatment('Ponazuril', 3, '');
  AddTreatment('Quantum 4', 1, '');
  AddTreatment('Quantum 6', 1, '');
  AddTreatment('Rabies', 1, '');
  AddTreatment('Recombitek C4', 1, '');
  AddTreatment('Revolution', 2, '');
  AddTreatment('RFD', 2, '');
  AddTreatment('Rintal', 2, '');
  AddTreatment('Emathal', 2, '');
  AddTreatment('Schein', 1, '');
  AddTreatment('Safeguard', 2, '');
  AddTreatment('Solojec7', 1, '');
  AddTreatment('Febantel', 2, '');
  AddTreatment('SMZT-Albon', 3, '');
  AddTreatment('Sentry Par', 1, '');
  AddTreatment('Styquine', 2, '');
  AddTreatment('Strongid T', 2, '');
  AddTreatment('Sulphatrimethoprin', 3, '');
  AddTreatment('Target', 2, '');
  AddTreatment('Telmin', 2, '');
  AddTreatment('Task 10', 2, '');
  AddTreatment('Vovax', 1, '');
  AddTreatment('DA2P+PV+B', 1, '');
  AddTreatment('Vercom', 2, '');
  AddTreatment('Vanguard Plus 5', 1, '');
  AddTreatment('Vanguard 5-L', 1, '');
  AddTreatment('Fenbendazole', 2, '');
  AddTreatment('Sulfadiazine/Trimeth', 3, '');
  AddTreatment('Hepatitis (cav)', 1, '');
  AddTreatment('Drontal', 2, '');
  AddTreatment('Galaxy DA2PPv', 1, 'Schering Plough');
  
  Result := True;
end;

function TWzdPetCenter.AddMicrochipList: Boolean;
begin

  AddMicrochip('Implant', 'Implant Fee', 0);
  AddMicrochip('ChipEnroll', 'Microchip Enrollment', 39.99);

  Result := True;

end;

function TWzdPetCenter.AddMicrochip(AModel, ADescription: String;
  ASalePrice: Currency): Boolean;
var
  Microchip : TMicrochip;
  Model : TModel;
begin

  Microchip := TMicrochip.Create;
  try
    Model := TModel.Create;
    try
      Model.IDCategory    := FIDMicrochipCategory;
      Model.Barcode       := AModel;
      Model.Model         := AModel;
      Model.Description   := ADescription;
      Model.Qty           := 0;
      Model.CostPrice     := 0;
      Model.SalePrice     := ASalePrice;
      Model.ModelType     := 'R';
      Model.Insert;

      Microchip.Amount    := ASalePrice;
      Microchip.Microchip := ADescription;
      Microchip.IDModel   := Model.IDModel;
      Microchip.Insert;

      Result := True;

    finally
      FreeAndNil(Model);
    end;
  finally
    FreeAndNil(Microchip);
  end;
end;

procedure TWzdPetCenter.LauchApplication;
var
  sFileName : String;
begin
  sFileName := DMExport.LocalPath + 'MRAppServer.exe';
  if FileExists(sFileName) then
    ShellExecute(handle, 'open', PChar(sFileName), nil, nil, 1);
end;

procedure TWzdPetCenter.btnCloseClick(Sender: TObject);
begin

  if MsgBox('Do you wish to continue the Pet Center install?', vbYesNo + vbQuestion) = mrNo then
    inherited;

end;

procedure TWzdPetCenter.edtPetPWKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if not (Key in ['0'..'9','a'..'z',#8]) then
  begin
    Key := #0;
    MessageBeep($FFFFFFFF);
  end;


end;

procedure TWzdPetCenter.edtEmailExit(Sender: TObject);
begin
  inherited;
  if edtEmail.Text <> '' then
    edtEmail1.Text := edtEmail.Text;
end;

function TWzdPetCenter.AddColor(AColor: String): Boolean;
begin
  if not DMExport.ValueExist('Pet_Color', 'Color', '', AColor, '') then
    DMExport.InsertColor(AColor);
  Result := True;
end;

function TWzdPetCenter.AddColorList: Boolean;
begin
  //AddColor('');



end;

end.
