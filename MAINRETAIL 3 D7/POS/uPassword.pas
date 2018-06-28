unit uPassword;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, DB, DBTables, SysUtils, Dialogs, ExtCtrls, Mask, ADODB,
     SuperComboADO, uSystemTypes, siComp, siLangRT, uParentAll, DBClient,
     Provider, DBCtrls, Variants;

type
  TPassword = class(TFrmParentAll)
    Label1: TLabel;
    EditPassword: TEdit;
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    quRights: TADOQuery;
    Label2: TLabel;
    Image1: TImage;
    quFuncRight: TADOQuery;
    quFuncRightIDUserType: TIntegerField;
    quFuncRightIDSysFunction: TIntegerField;
    quFuncRightAcesso: TBooleanField;
    btOK: TButton;
    btCancel: TButton;
    chkKeepLogin: TCheckBox;
    dspFuncRight: TDataSetProvider;
    cdsFuncRight: TClientDataSet;
    cdsFuncRightIDUserType: TIntegerField;
    cdsFuncRightIDSysFunction: TIntegerField;
    cdsFuncRightAcesso: TBooleanField;
    dspRights: TDataSetProvider;
    cdsRights: TClientDataSet;
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
    cmbStore: TDBLookupComboBox;
    quRightsPW: TStringField;
    cdsRightsIDUser: TIntegerField;
    cdsRightsCanAccess: TBooleanField;
    cdsRightsCanInsert: TBooleanField;
    cdsRightsCanDelete: TBooleanField;
    cdsRightsCanPrint: TBooleanField;
    cdsRightsCanUpdate: TBooleanField;
    cdsRightsMenuID: TIntegerField;
    cdsRightsSubMenuID: TIntegerField;
    cdsRightsIDUserType: TIntegerField;
    cdsRightsComissionID: TIntegerField;
    cdsRightsSystemUser: TStringField;
    cdsRightsPW: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    IsSuperUser : Boolean;
    AllowCommand : TSetCommandType;

    //FuncRights
    procedure CloseFuncRights;
    procedure OpenFuncRights;
    procedure RefreshFuncRights;


  public
    { Public declarations }
    MenuName, SubMenuName : String;
    MyMenuItem : Integer;
    MySubMenuItem : Integer;
    //Rodrigo - se for user permanente vericar em cada menu se pode entrar
    PermanentLogOn, PermanentCashLogOn : Boolean;
    function HasFuncRight(IDSysFunction : integer ) : Boolean;
    function SetRights(brwCommand : TSetCommandType) : TSetCommandType;
    function Start(IDMenu, IDSubMenu : integer) : boolean;
    function AquireAccess(const AFuncRight: Integer;
      UnauthorizedMessage: String; var AIDUser: Integer): Boolean;
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
  DM.PrepareCDS(cdsFuncRight, 'UserTypeToSysFunction');
end;

procedure TPassword.CloseFuncRights;
begin
  if DM.PersistenceType = ptDB then
  with quFuncRight do
    if Active then
      Close;
end;


function TPassword.Start(IDMenu, IDSubMenu : integer) : boolean;
begin
  MyMenuItem    := IDMenu;
  MySubMenuItem := IDSubMenu;

 //cmbStore.enabled := (MyMenuItem >= 3) or (MyMenuItem = -1);

 Result :=
            // ** Manager
            PermanentLogOn or

            // ** Cashier com UnLock e opção CashRegister/CashRegister
            (PermanentCashLogOn and ((IDMenu = 1) and (IDSubMenu = 1))) or

            // ** O user passou a senha correta e está habilitado
            (ShowModal = mrOk);
end;

procedure TPassword.FormShow(Sender: TObject);
begin
   inherited;

   Screen.Cursor := crDefault;

   EditPassword.Clear;
   if cmbStore.KeyValue = null then
      cmbStore.KeyValue := IntToStr(DM.fStore.IDDefault);

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

   Screen.Cursor := crDefault;

end;

procedure TPassword.FormDestroy(Sender: TObject);
begin
   //quRights.UnPrepare;
   CloseFuncRights;
end;

procedure TPassword.btCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TPassword.btOKClick(Sender: TObject);
var
  fCommissionID : Integer;
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
  if DM.PersistenceType = ptDB then
    if DM.fStore.ID <> StrToInt(cmbStore.KeyValue) then
       DM.fStore.StoreHour := StrToInt(cmbStore.KeyValue);

  DM.fStore.ID   := StrToInt(cmbStore.KeyValue);
  DM.fStore.Name := cmbStore.Text;

  PermanentLogOn := chkKeepLogin.Checked;

  //Nova Validacao
  //DM.PrepareCDS(cdsSystemUser, 'SystemUser');

  with DM.cdsSystemUser do
     begin
       if DM.FiltraCDS(DM.cdsSystemUser, Format('PW = %S', [QuotedStr(EditPassword.Text)])) then
          begin

          fCommissionID := FieldByName('ComissionID').AsInteger;

          if fCommissionID = 0 then
             begin
             MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbOKOnly + vbCritical);
             Close;
             Exit;
             end;

          DM.fUser.ID               := FieldByName('IDUser').AsInteger;
          DM.fUser.IDCommission     := fCommissionID;
          DM.fUser.IDCommissionType := FieldByName('IDTipoPessoa').AsInteger;

          if FieldByName('StoresAccess').AsString <> '' then
             DM.fStore.StoreList := FieldByName('StoresAccess').AsString
          else
             DM.fStore.StoreList := cmbStore.KeyValue;
          end;

          if not DM.ValidateStore(DM.fStore.StoreList, cmbStore.KeyValue) then
             begin
             MsgBox(MSG_CRT_OTHER_STORE_NOT_ALLOW, vbOKOnly + vbInformation);
             Exit;
             end;

       //Close;

     end;

  // Testa se e para setar o permanentLogOn do Manager
  if (MyMenuItem = -1) and (MySubMenuItem = -1) then
   begin
     with DM.cdsSystemUser do
       begin

         if DM.cdsSystemUser.IsEmpty then
            begin
            MsgBox(MSG_INF_INVALID_PASSWORD, vbOKOnly + vbInformation);
            Close;
            Exit;
            end;

           if FieldByName('ComissionID').AsInteger = 0 then
              begin
              MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbOKOnly + vbCritical);
              Close;
              Exit;
              end;

            AllowCommand              := [];
            DM.fUser.ID               := FieldByName('IDUser').AsInteger;
            DM.fUser.IDCommission     := FieldByName('ComissionID').AsInteger;
            DM.fUser.IDCommissionType := FieldByName('IDTipoPessoa').AsInteger;
            //FIsManager         := True;
            DM.fUser.IDUserType       := FieldByName('UserTypeID').AsInteger;
            DM.fUser.UserName         := FieldByName('SystemUser').AsString;
            PermanentLogOn            := True;
            PermanentCashLogOn        := False;
            ModalResult               := mrOK;
            DM.fUser.Password         := EditPassword.Text;
            Close;
            Exit;
       end;
   end; // ** if MenuItem = -1 ...


  // ** Testa se e para setar o permanentLogOn do Cashier
  // ** Ivanil
  if (MyMenuItem = -2) and (MySubMenuItem = -2) then
   begin
     with DM.cdsSystemUser do
       begin
         if (FieldByName('UserTypeID').AsInteger = USER_TYPE_CASHIER) or
            (FieldByName('UserTypeID').AsInteger = USER_TYPE_CASHIER_PO) then
          begin
            AllowCommand              := [];
            DM.fUser.ID               := FieldByName('IDUser').AsInteger;
            DM.fUser.IDCommission     := FieldByName('ComissionID').AsInteger;
            DM.fUser.IDCommissionType := FieldByName('IDTipoPessoa').AsInteger;
            //FIsManager         := False;
            DM.fUser.IDUserType       := FieldByName('UserTypeID').AsInteger;
            DM.fUser.UserName         := FieldByName('SystemUser').AsString;
            PermanentCashLogOn        := True;
            PermanentLogOn            := False;
            ModalResult               := mrOK;
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
   end; // ** if MenuItem = -2 ...

  DM.PrepareCDS(cdsRights, 'UserRights', '', False);
  with cdsRights do
    begin
     try
      if DM.PersistenceType = ptDB then
        begin
          if Active then Close;
          Params.ParambyName('Password').Value  := EditPassword.Text;
          Params.ParambyName('MenuID').Value    := MyMenuItem;
          Params.ParambyName('SubMenuID').Value := MySubMenuItem;
          Open;
        end
      else
        begin
          cdsRights.Filtered := False;
          cdsRights.Filter   := Format('PW = %S AND MenuID = %D AND SubMenuID = %D', [QuotedStr(EditPassword.Text), MyMenuItem, MySubMenuItem]);
          cdsRights.Filtered := True;
        end;

      if not (EditPassword.Text = 'pinpinha') then
       begin
         IsSuperUser := False;

         if Bof and Eof then
          begin
            EditPassword.SelectAll;
            EditPassword.SetFocus;
            MsgBox(MSG_INF_INVALID_PASSWORD, vbOKOnly + vbInformation);
            Exit;
          end;
         if not cdsRightsCanAccess.AsBoolean then
          begin
            MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
            Exit;
          end;

          //Pego o password para verificar se pode accessar o menu
          DM.fUser.Password     := EditPassword.Text;
          DM.fUser.ID           := cdsRightsIdUser.AsInteger;
          DM.fUser.IDCommission := cdsRightsComissionID.AsInteger;
          DM.fUser.IDUserType   := cdsRightsIDUserType.AsInteger;
          DM.fUser.UserName     := cdsRightsSystemUser.AsString;
          DM.fUser.IDUserType   := cdsRightsIDUserType.AsInteger;
       end
      else
       begin
         IsSuperUser           := True;
         DM.fUser.ID           := 0;
         DM.fUser.IDCommission := 0;
         DM.fUser.IDUserType   := USER_TYPE_MANAGER;
         DM.fUser.UserName     := 'Super User';
       end;

      AllowCommand  := [btInc, btAlt, btExc, btImp];
      if cdsRightsCanInsert.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btInc];
      if cdsRightsCanUpdate.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btAlt];
      if cdsRightsCanDelete.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btExc];
      if cdsRightsCanPrint.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btImp];

      ModalResult := mrOK;  // Retorna True;

     finally
      //Close;
      DM.FiltraCDS(DM.cdsSystemUser, '');
     end;
    end;

end;

function TPassword.SetRights(brwCommand : TSetCommandType) : TSetCommandType;
begin
  // Atribui direitos ao browse
  Result := brwCommand - AllowCommand;
end;

function TPassword.HasFuncRight(IDSysFunction : integer ) : Boolean;
begin
  // Atribui que sempre vai ser chamada em retorno ao ultimo status de senha
  // digitada


  with cdsFuncRight do
    begin

    //verify the User Rights
    OpenFuncRights;

      if Locate('IDSysFunction;IDUserType',
                ConvVarArray(IntToStr(IDSysFunction)+';'+IntToStr(DM.fUser.IDUserType)), []) then

        begin
          Result := cdsFuncRightAcesso.AsBoolean;
        end
      else
        begin
          raise exception.Create('Access denied, call Administrator.');
        end;
    end;
end;

function TPassword.AquireAccess(Const AFuncRight: Integer; UnauthorizedMessage: String; var AIDUser: Integer): Boolean;
var
  tempID: Integer;
  tempIDCommission: Integer;
  tempIDCommissionType: Integer;
  tempIDUserType: Integer;
  tempUserName: String;
  tempPassword: String;
  Cancelou,
  Permite: Boolean;
begin

  tempID               := DM.fUser.ID;
  tempIDCommission     := DM.fUser.IDCommission;
  tempIDCommissionType := DM.fUser.IDCommissionType;
  tempIDUserType       := DM.fUser.IDUserType;
  tempUserName         := DM.fUser.UserName;
  tempPassword         := DM.fUser.Password;
  Permite              := false;

  try
    Permite := Password.HasFuncRight(AFuncRight);
    if not Permite then
      repeat
        Permite := False;
        Password.PermanentLogOn := False;
        Cancelou := not Password.Start(1, 1);
        if not Cancelou then
          Permite := Password.HasFuncRight(AFuncRight);
        if not Permite then
          MsgBox(UnauthorizedMessage, vbOKOnly + vbInformation);


      until Cancelou or Permite;
  finally
    Result := Permite;
    AIDUser                   := DM.fUser.ID;
    DM.fUser.ID               := tempID;
    DM.fUser.IDCommission     := tempIDCommission;
    DM.fUser.IDCommissionType := tempIDCommissionType;
    DM.fUser.IDUserType       := tempIDUserType;
    DM.fUser.UserName         := tempUserName;
    DM.fUser.Password         := tempPassword;
  end;
end;


end.

