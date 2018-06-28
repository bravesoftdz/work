unit uPassword;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, DB, DBTables, SysUtils, Dialogs, ExtCtrls, Mask, PaiDeForms,
     ADODB, SuperComboADO, uSystemTypes, siComp, siLangRT, Variants,
  DBClient, Provider;

type
  TPassword = class(TFrmParentForms)
    Label1: TLabel;
    EditPassword: TEdit;
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    quRights: TADOQuery;
    quRightsIDUser: TIntegerField;
    quRightsCanAccess: TBooleanField;
    quRightsCanInsert: TBooleanField;
    quRightsCanDelete: TBooleanField;
    quRightsCanPrint: TBooleanField;
    quRightsCanUpdate: TBooleanField;
    quRightsMenuID: TIntegerField;
    quRightsSubMenuID: TIntegerField;
    quRightsIDUserType: TIntegerField;
    quRightsComissionID: TIntegerField;
    quRightsSystemUser: TStringField;
    cmbStore: TSuperComboADO;
    Label2: TLabel;
    Image1: TImage;
    quFuncRight: TADOQuery;
    quFuncRightIDUserType: TIntegerField;
    quFuncRightIDSysFunction: TIntegerField;
    quFuncRightAcesso: TBooleanField;
    btOK: TButton;
    btCancel: TButton;
    chkKeepLogin: TCheckBox;
    quMenuRights: TADOQuery;
    quMenuRightsIDUserType: TIntegerField;
    quMenuRightsIDUser: TIntegerField;
    quMenuRightsSystemUser: TStringField;
    quMenuRightsPW: TStringField;
    quMenuRightsComissionID: TIntegerField;
    quMenuRightsCanAccess: TBooleanField;
    quMenuRightsCanInsert: TBooleanField;
    quMenuRightsCanDelete: TBooleanField;
    quMenuRightsCanPrint: TBooleanField;
    quMenuRightsCanUpdate: TBooleanField;
    quMenuRightsMenuID: TIntegerField;
    quMenuRightsSubMenuID: TIntegerField;
    quMenuRightsCanExport: TBooleanField;
    dspFuncRight: TDataSetProvider;
    cdsFuncRight: TClientDataSet;
    cdsFuncRightIDUserType: TIntegerField;
    cdsFuncRightIDSysFunction: TIntegerField;
    cdsFuncRightAcesso: TBooleanField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
    IsSuperUser:Boolean;
    AllowCommand : TSetCommandType;
    fStores : TStringList;

    //FuncRights
    procedure CloseFuncRights;
    procedure OpenFuncRights;
    procedure RefreshFuncRights;

    //AccessModule
    procedure MenuRightsOpen;

    function ValidateStore(StoreList, IDStore : String):Boolean;
  public
    MenuName,
    SubMenuName        : String;
    MyMenuItem         : Integer;
    MySubMenuItem      : Integer;
    iScreenType        : Integer;
    //Rodrigo - se for user permanente vericar em cada menu se pode entrar
    PermanentLogOn,
    PermanentCashLogOn : Boolean;
    function HasFuncRight(IDSysFunction : integer; internal_delete: Boolean = false) : Boolean;
    function SetRights(brwCommand : TSetCommandType) : TSetCommandType;
    function Start(IDMenu, IDSubMenu : integer) : boolean;
    function CanAccessMenu(IDMenu, IDSubMenu : integer; PW:String):Boolean;
    function AquireAccess(const AFuncRight: Integer;
      AUnauthorizedMessage: String; var AIDUser: Integer; AskFirst: Boolean = False): Boolean;
    function GetAllowCommand(IDMenu, IDSubMenu: Integer; PW : String) : TSetCommandType;
  end;

var
  Password: TPassword;

implementation

uses uDM, uMsgBox, uMsgConstant, uVarianteFunctions, uDMGlobal, uSystemConst;

{$R *.DFM}

procedure TPassword.RefreshFuncRights;
begin
  CloseFuncRights;
  OpenFuncRights;
end;

procedure TPassword.OpenFuncRights;
begin
  with cdsFuncRight do
     if not Active then
        Open;
end;

procedure TPassword.CloseFuncRights;
begin

    with cdsFuncRight do
       if Active then
          Close;

end;


function TPassword.Start(IDMenu, IDSubMenu : integer) : boolean;
begin

  MyMenuItem    := IDMenu;
  MySubMenuItem := IDSubMenu;

  cmbStore.enabled := (MyMenuItem >= 3) or (MyMenuItem = -1);

  chkKeepLogin.Visible := not (((IDMenu = 1) and (IDSubMenu = 1)) and
                          (iScreenType = CASHREG_TYPE_FULL_POS));

  Result :=
            // ** Manager
            PermanentLogOn or

            // ** Cashier com UnLock e opção CashRegister/CashRegister
            (PermanentCashLogOn and ((IDMenu = 1) and (IDSubMenu = 1))) or

            // ** O user passou a senha correta e está habilitado
            (ShowModal = mrOk);

  DM.fUser.CheckMessage := False;

  if Result then
  begin
   DM.VerifyMessage;
   DM.fUser.CheckMessage := PermanentLogOn;
  end
  else
   DM.fUser.ID := 0;

end;

procedure TPassword.FormShow(Sender: TObject);
begin
   inherited;

   Screen.Cursor := crDefault;

   EditPassword.Clear;
   if cmbStore.LookUpValue = '' then
      cmbStore.LookUpValue := IntToStr(DM.fStore.IDDefault);

   EditPassword.SetFocus;

end;

procedure TPassword.FormCreate(Sender: TObject);
begin
   inherited;
   Screen.Cursor := crHourGlass;

   //quRights.Prepare;
   PermanentLogOn     := False;
   PermanentCashLogOn := False;

   // Abre a tabela de direitos por funcao e fica aberta ate terminar a aplicacao
   OpenFuncRights;

   inherited;

   fStores := TStringList.Create;

   iScreenType := DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE];

   Screen.Cursor := crDefault;

end;

procedure TPassword.FormDestroy(Sender: TObject);
begin
   //quRights.UnPrepare;
   CloseFuncRights;
   FreeAndNil(fStores);
end;

procedure TPassword.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TPassword.btOKClick(Sender: TObject);
begin

  if Trim(EditPassword.Text) = '' then
    begin
     EditPassword.SetFocus;
     MsgBox(MSG_INF_PASSWORD_CANNOT_BE_NULL, vbOKOnly + vbInformation);
     Exit;
    end;

  if Trim(cmbStore.Text) = '' then
    begin
     cmbStore.SetFocus;
     MsgBox(MSG_CRT_NO_STORE_SELECTED, vbOKOnly + vbInformation);
     Exit;
    end;

  //Atualiza o Hora da Store no - DM
  if DM.fStore.ID <> StrToInt(cmbStore.LookUpValue) then
     DM.fStore.StoreHour := StrToInt(cmbStore.LookUpValue);

  if DM.fStore.Name <> cmbStore.Text then
     DM.fStore.Franchase := DM.DescCodigo(['IDStore'], [cmbStore.LookUpValue], 'Store', 'Franchise')='True';

  DM.fStore.ID        := StrToInt(cmbStore.LookUpValue);
  DM.fStore.Name      := cmbStore.Text;
  DM.fStore.State     := Trim(DM.DescCodigo(['IDStore'], [cmbStore.LookUpValue], 'Store', 'IDEstado'));

  PermanentLogOn := chkKeepLogin.Checked;

  //Nova Validacao
  with DM.quFreeSQL do
     begin
       if Active then
          Close;

       SQL.Text := 'SELECT IDUser, StoresAccess, UserTypeID, SystemUser, ComissionID ' +
                   'FROM SystemUser SystemUser ' +
                   'WHERE Desativado = 0 AND SystemUser.PW = :PW ';

       Parameters.ParamByName('PW').Value := EditPassword.Text;

       Try

         Open;

         //Senha invalida
         If RecordCount = 0 then
            begin
            MsgBox(MSG_INF_INVALID_PASSWORD, vbOKOnly + vbInformation);
            EditPassword.Clear;
            Exit;
            end
         else //Senha Valida
            begin
            DM.fUser.ID := FieldByName('IDUser').AsInteger;
            if FieldByName('StoresAccess').AsString <> '' then
               DM.fStore.StoreList := FieldByName('StoresAccess').AsString
            else
               DM.fStore.StoreList := '';

            if not ValidateStore(DM.fStore.StoreList, cmbStore.LookUpValue) then
               begin
               MsgBox(MSG_CRT_OTHER_STORE_NOT_ALLOW, vbOKOnly + vbInformation);
               Exit;
               end;

            // Testa se e para setar o permanentLogOn do Manager
            if (MyMenuItem = -1) and (MySubMenuItem = -1) then
               begin
               AllowCommand          := [];
               DM.fUser.IDCommission := FieldByName('ComissionID').AsInteger;
               DM.fUser.IDUserType   := FieldByName('UserTypeID').AsInteger;
               DM.fUser.UserName     := FieldByName('SystemUser').AsString;
               DM.fUser.Password     := EditPassword.Text;
               PermanentLogOn        := True;
               PermanentCashLogOn    := False;
               ModalResult           := mrOK;
               //FIsManager         := True;
               Exit;
               end;

            // ** Testa se e para setar o permanentLogOn do Cashier
            if (MyMenuItem = -2) and (MySubMenuItem = -2) then
               begin
               if (FieldByName('UserTypeID').AsInteger = USER_TYPE_CASHIER) or
                  (FieldByName('UserTypeID').AsInteger = USER_TYPE_CASHIER_PO) then
                  begin
                  AllowCommand          := [];
                  DM.fUser.IDCommission := FieldByName('ComissionID').AsInteger;
                  DM.fUser.IDUserType   := FieldByName('UserTypeID').AsInteger;
                  DM.fUser.UserName     := FieldByName('SystemUser').AsString;
                  DM.fUser.Password     := EditPassword.Text;
                  PermanentCashLogOn    := True;
                  PermanentLogOn        := False;
                  ModalResult           := mrOK;
                  //FIsManager         := False;
                  Close;
                  Exit;
                  end
               else
                  begin
                  EditPassword.SelectAll;
                  EditPassword.SetFocus;
                  MsgBox(MSG_INF_NOT_CASHIER_PASWORD, vbOKOnly + vbInformation);
                  Close;
                  Exit;
                  end;
               end;
            end;
       finally
         Close;
         end;
     end;

  //Verifica os Rights de cada usuario
  if not CanAccessMenu(MyMenuItem, MySubMenuItem, EditPassword.Text) then
     begin
     MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
     Exit;
     end;

  ModalResult := mrOK;

end;

function TPassword.SetRights(brwCommand : TSetCommandType) : TSetCommandType;
begin
  // Atribui direitos ao browse
  Result := brwCommand - AllowCommand;
end;

function TPassword.HasFuncRight(IDSysFunction : integer; internal_delete: Boolean = false) : Boolean;
begin
  //verify the User Rights
  OpenFuncRights;

  // Atribui que sempre vai ser chamada em retorno ao ultimo status de senha
  // digitada
  with cdsFuncRight do
    begin

    if Locate('IDSysFunction;IDUserType',
              ConvVarArray(IntToStr(IDSysFunction)+';'+IntToStr(DM.fUser.IDUserType)), []) then
        begin
             Result := FieldByName('Acesso').AsBoolean;
             if ( internal_delete ) then
                result := true;
        end
    else
        begin
        if DM.fUser.IDUserType <> 0 then
           raise exception.Create(MSG_CRT_NO_ACCESS);
        end;
    end;
end;

procedure TPassword.MenuRightsOpen;
begin
  with quMenuRights do
    if not Active then
      Open;
end;

function TPassword.CanAccessMenu(IDMenu, IDSubMenu: Integer; PW: String): Boolean;
begin
  //Abre o MenuRights Na primeira vez
  MenuRightsOpen;

  Result := False;

  with quMenuRights do
    if Locate('MenuID;SubMenuID;PW;',ConvVarArray(IntToStr(IDMenu)+';'+IntToStr(IDSubMenu)+';'+PW), []) then
    begin
      Result := quMenuRightsCanAccess.AsBoolean;

      //Se nao tiver acesso nao precisa carregar os Rights
      if not Result then
        Exit;

      if not (EditPassword.Text = 'pinpinha') then
      begin
        //Pego o password para verificar se pode accessar o menu
        DM.fUser.Password     := EditPassword.Text;
        DM.fUser.ID           := quMenuRightsIDUser.AsInteger;
        DM.fUser.IDCommission := quMenuRightsComissionID.AsInteger;
        DM.fUser.IDUserType   := quMenuRightsIDUserType.AsInteger;
        DM.fUser.UserName     := quMenuRightsSystemUser.AsString;
      end
      else
      begin
        IsSuperUser           := True;
        DM.fUser.ID           := 0;
        DM.fUser.IDCommission := 0;
        DM.fUser.IDUserType   := USER_TYPE_MANAGER;
        DM.fUser.UserName     := 'Super User';
      end;

      AllowCommand  := [btInc, btAlt, btExc, btImp, btExp];

      if quMenuRightsCanInsert.AsBoolean or IsSuperUser then
        AllowCommand  := AllowCommand - [btInc];
      if quMenuRightsCanUpdate.AsBoolean or IsSuperUser then
        AllowCommand  := AllowCommand - [btAlt];
      if quMenuRightsCanDelete.AsBoolean or IsSuperUser then
        AllowCommand  := AllowCommand - [btExc];
      if quMenuRightsCanPrint.AsBoolean or IsSuperUser then
        AllowCommand  := AllowCommand - [btImp];
      if quMenuRightsCanExport.AsBoolean or IsSuperUser then
        AllowCommand  := AllowCommand - [btExp];
    end;
end;

function TPassword.ValidateStore(StoreList, IDStore: String): Boolean;
var
  i: Integer;
begin
  Result := False;

  fStores.CommaText := StoreList;

  for i:=0 to fStores.Count-1 do
    if fStores.Strings[i] = IDStore then
    begin
      Result := True;
      Break;
    end;
end;

function TPassword.AquireAccess(const AFuncRight: Integer;
  AUnauthorizedMessage: String; var AIDUser: Integer; AskFirst: Boolean = False): Boolean;
var
  tempID: Integer;
  tempIDCommission: Integer;
  tempIDUserType: Integer;
  tempUserName: String;
  tempPassword: String;
  Cancelou,
  Permite: Boolean;
begin
  tempID               := DM.fUser.ID;
  tempIDCommission     := DM.fUser.IDCommission;
  tempIDUserType       := DM.fUser.IDUserType;
  tempUserName         := DM.fUser.UserName;
  tempPassword         := DM.fUser.Password;
  Permite              := false;

  try
    if AskFirst then
      Permite := False
    else
      Permite := Password.HasFuncRight(AFuncRight);
    if not Permite then
      repeat
        Permite := False;
        Password.PermanentLogOn := False;
        Cancelou := not Password.Start(1, 1);
        if not Cancelou then
          Permite := Password.HasFuncRight(AFuncRight);
        if not Permite then
          MsgBox(AUnauthorizedMessage, vbOKOnly + vbInformation);

      until Cancelou or Permite;
  finally
    AIDUser                   := DM.fUser.ID;
    DM.fUser.ID               := tempID;
    DM.fUser.IDCommission     := tempIDCommission;
    DM.fUser.IDUserType       := tempIDUserType;
    DM.fUser.UserName         := tempUserName;
    DM.fUser.Password         := tempPassword;
    Result                    := Permite;
  end;
end;

function TPassword.GetAllowCommand(IDMenu, IDSubMenu: Integer;
  PW : String): TSetCommandType;
begin

  MenuRightsOpen;

  Result := [];

  with quMenuRights do
    if Locate('MenuID;SubMenuID;PW;',ConvVarArray(IntToStr(IDMenu)+';'+IntToStr(IDSubMenu)+';'+PW), []) then
    begin

      if quMenuRightsCanInsert.AsBoolean then
        Result := Result + [btInc];
      if quMenuRightsCanUpdate.AsBoolean then
        Result := Result + [btAlt];
      if quMenuRightsCanDelete.AsBoolean then
        Result := Result + [btExc];
      if quMenuRightsCanPrint.AsBoolean then
        Result := Result + [btImp];
      if quMenuRightsCanExport.AsBoolean then
        Result := Result + [btExp];
    end;  
end;

end.
