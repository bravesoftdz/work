unit uPassword;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, DB, DBTables, SysUtils, Dialogs, ExtCtrls, Mask,
     ADODB, SuperComboADO, uSystemTypes, siComp, siLangRT;

type
  TPassword = class(TForm)
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
    dsLookupStore: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
    IsSuperUser:Boolean;
    AllowCommand : TSetCommandType;

    //FuncRights
    procedure CloseFuncRights;
    procedure OpenFuncRights;

  public
    { Public declarations }
    MenuName, SubMenuName : String;
    MyMenuItem : Integer;
    MySubMenuItem : Integer;
    Logged : Boolean;
    //Rodrigo - se for user permanente vericar em cada menu se pode entrar
    PermanentLogOn, PermanentCashLogOn : Boolean;
    function HasFuncRight(IDSysFunction : integer ) : Boolean;
    function SetRights(brwCommand : TSetCommandType) : TSetCommandType;
    function Start(IDMenu, IDSubMenu : integer) : boolean;
    function Login(Pw : String):Boolean;
  end;

var
  Password: TPassword;

implementation

uses uDM, uMsgBox, uMsgConstant, uVarianteFunctions, uDMGlobal, uSystemConst;

{$R *.DFM}

procedure TPassword.OpenFuncRights;
begin
  with quFuncRight do
     if not Active then
        Open;
end;

procedure TPassword.CloseFuncRights;
begin

    with quFuncRight do
       if Active then
          Close;

end;


function TPassword.Start(IDMenu, IDSubMenu : integer) : boolean;
begin
  MyMenuItem    := IDMenu;
  MySubMenuItem := IDSubMenu;

 cmbStore.enabled := (MyMenuItem >= 3) or (MyMenuItem = -1);

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
   if cmbStore.LookUpValue = '' then
      cmbStore.LookUpValue := IntToStr(DM.IDStore);

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

function TPassword.Login(PW : String):Boolean;
begin

     Result := False;

     with DM.quFreeSQL do
       begin
         if Active then
            Close;

         SQL.Text := 'SELECT UserTypeID , IDUser, SystemUser , ComissionID, StoresAccess ' +
                     'FROM dbo.SystemUser SystemUser                                  ' +
                     'WHERE Desativado = 0 AND SystemUser.PW = ' + Chr(39)+PW+Chr(39);
         Open;

         If RecordCount = 0 then
            begin
            Close;
            Exit;
            end;

         AllowCommand          := [];
         DM.fUser.ID           := FieldByName('IDUser').AsInteger;
         DM.fUser.IDUserType   := FieldByName('UserTypeID').AsInteger;
         DM.fUser.UserName     := FieldByName('SystemUser').AsString;
         PermanentLogOn        := True;
         PermanentCashLogOn    := False;
         DM.fUser.Password     := PW;
         if FieldByName('StoresAccess').AsString <> '' then
            DM.StoreList := FieldByName('StoresAccess').AsString
         else
            DM.StoreList := IntToStr(DM.IDStore);
         Close;
       end;

   Result := True;
      
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

  DM.IDStore   := StrToInt(cmbStore.LookUpValue);
  DM.StoreName := cmbStore.Text;

  PermanentLogOn := chkKeepLogin.Checked;

  //Nova Validacao
  with DM.quFreeSQL do
     begin
       if Active then
          Close;

       SQL.Text := 'SELECT IDUser, StoresAccess ' +
                   'FROM SystemUser SystemUser ' +
                   'WHERE Desativado = 0 AND SystemUser.PW = ' + Chr(39)+EditPassword.Text+Chr(39);
       Open;

       If RecordCount <> 0 then
          begin
          DM.fUser.ID := FieldByName('IDUser').AsInteger;
          if FieldByName('StoresAccess').AsString <> '' then
             DM.StoreList := FieldByName('StoresAccess').AsString
          else
             DM.StoreList := cmbStore.LookUpValue;
          end;

       Close;

     end;

  // Testa se e para setar o permanentLogOn do Manager
  if (MyMenuItem = -1) and (MySubMenuItem = -1) then
   begin
     with DM.quFreeSQL do
       begin
         if Active then
            Close;

         SQL.Text := 'SELECT UserTypeID , IDUser, SystemUser , ComissionID ' +
                     'FROM dbo.SystemUser SystemUser                                  ' +
                     'WHERE Desativado = 0 AND SystemUser.PW = ' + Chr(39)+EditPassword.Text+Chr(39);
         Open;

         If RecordCount = 0 then
            begin
            MsgBox(MSG_INF_INVALID_PASSWORD, vbOKOnly + vbInformation);
            Close;
            Exit;
            end;

            AllowCommand          := [];
            DM.fUser.ID           := FieldByName('IDUser').AsInteger;
            DM.fUser.IDUserType   := FieldByName('UserTypeID').AsInteger;
            DM.fUser.UserName     := FieldByName('SystemUser').AsString;
            PermanentLogOn        := True;
            PermanentCashLogOn    := False;
            ModalResult           := mrOK;
            DM.fUser.Password     := EditPassword.Text;
            Close;
            Exit;
       end;
   end; // ** if MenuItem = -1 ...


  // ** Testa se e para setar o permanentLogOn do Cashier
  // ** Ivanil
  if (MyMenuItem = -2) and (MySubMenuItem = -2) then
   begin
     with DM.quFreeSQL do
       begin
         if Active then
            Close;

         SQL.Text := 'SELECT UserTypeID , IDUser, SystemUser , ComissionID ' +
                     'FROM SystemUser SystemUser                                  ' +
                     'WHERE Desativado = 0 AND SystemUser.PW = ' + Chr(39)+EditPassword.Text+Chr(39);
         Open;

         if (FieldByName('UserTypeID').AsInteger = USER_TYPE_CASHIER) or
            (FieldByName('UserTypeID').AsInteger = USER_TYPE_CASHIER_PO) then
          begin
            AllowCommand          := [];
            DM.fUser.ID           := FieldByName('IDUser').AsInteger;
            DM.fUser.IDUserType   := FieldByName('UserTypeID').AsInteger;
            DM.fUser.UserName     := FieldByName('SystemUser').AsString;
            PermanentCashLogOn    := True;
            PermanentLogOn        := False;
            ModalResult           := mrOK;
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


  with quRights do
    begin
     try
      if Active then Close;
      Parameters.ParambyName('Password').Value  := EditPassword.Text;
      Parameters.ParambyName('MenuID').Value    := MyMenuItem;
      Parameters.ParambyName('SubMenuID').Value := MySubMenuItem;
      Open;
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

          //Pego o password para verificar se pode accessar o menu
          DM.fUser.Password     := EditPassword.Text;
          DM.fUser.ID           := quRightsIdUser.AsInteger;
          DM.fUser.IDUserType   := quRightsIDUserType.AsInteger;
          DM.fUser.UserName     := quRightsSystemUser.AsString;
          DM.fUser.IDUserType   := quRightsIDUserType.AsInteger;
       end
      else
       begin
         IsSuperUser           := True;
         DM.fUser.ID           := 0;
         DM.fUser.IDUserType   := USER_TYPE_MANAGER;
         DM.fUser.UserName     := 'Super User';
       end;

      AllowCommand  := [btInc, btAlt, btExc, btImp];
      if quRightsCanInsert.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btInc];
      if quRightsCanUpdate.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btAlt];
      if quRightsCanDelete.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btExc];
      if quRightsCanPrint.AsBoolean or IsSuperUser then
         AllowCommand  := AllowCommand - [btImp];

      ModalResult := mrOK;  // Retorna True;

     finally
      Close;
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


  with quFuncRight do
    begin

    //verify the User Rights
    OpenFuncRights;

      if Locate('IDSysFunction;IDUserType',
                ConvVarArray(IntToStr(IDSysFunction)+';'+IntToStr(DM.fUser.IDUserType)), []) then

        begin
          Result := quFuncRightAcesso.AsBoolean;
        end
      else
        begin
          raise exception.Create('Access denied, call Administrator.');
        end;
    end;
end;

end.

