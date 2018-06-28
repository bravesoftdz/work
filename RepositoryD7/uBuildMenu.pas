unit uBuildMenu;

interface

Uses Menus, Forms, ADOdb, db, Classes, extctrls, dxBar, Sysutils, dxBarExtItems;

Type
  TmyBarButton = class(TdxBarButton)
  Public
     Form          : TForm;    // Ponteiro para o TForm
     Title         : String;   // Titulo que o modulo possuira quando aberto
     Loaded        : boolean;  // O TForm esta na memoria
     Ready         : boolean;  // Este IDMenuItem foi incluido no menu do usuario
     IDMenuItem    : integer;  // IDMenuitem que chamou o form
     UserRights    : String;   // Guarda quais operações podem ser executadas pelo usuario
     FormClassName : String;   // Nome da classe do form que será chamado
     Parametro     : String;
     LoaderType    : integer;  //Loader Type
     FormID        : integer;  //Form Number
  end;

  TmyBarButtonControl = class(TdxBarButtonControl);

  TBuildMenu = Class
  Private
     //Menu Normal
     lList          : TStringList;
     FStartUpModulo : TNotifyEvent;
     FConnection    : TADOConnection;
     FBarManager    : TdxBarManager;
     FMenuOwner     : TComponent;
     LocalOwner     : TComponent;
     fIDLanguage    : Integer;
     procedure AddNewMenu(AOwner: TComponent; ALinks: TdxBarItemLinks; aQuery: TDataSet);
     Function  GetButtonByID(aIDMenuItem:Integer):TmyBarButton;
     Function  GetSubItemByID(aIDMenuItem:Integer):TdxBarSubItem;
     Function  GetNewQuery(AFirstIDMenuItem: Integer):TADOQuery;
     Function  CreateSubItem(AOwner: TComponent; ALinks: TdxBarItemLinks; ABeginGroup: Integer): TdxBarSubItem;
     Function  CreateButton(AOwner: TComponent; ALinks: TdxBarItemLinks; ABeginGroup: Integer): TmyBarButton;
  Public
     //Normal Menu
     function GetButton(iIDMenu:Integer):TmyBarButton;
     procedure ConstructMenu(AFirstIDMenuItem, IDLanguage: integer);
     procedure ClearModules;
     procedure ClearModule(Const AIDMenuItem: Integer);
     Constructor Create;  Virtual;
     Destructor Destroy;  Override;
     Property  OnClick       : TNotifyEvent Read FStartUpModulo Write FStartUpModulo;
     Property  Connection    : TADOConnection Read FConnection Write FConnection;
     Property  BarManager    : TdxBarManager Read FBarManager Write FBarManager;
     Property  MenuOwner     : TComponent Read FMenuOwner Write FMenuOwner;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterNoIcon([TMyBarButton]);
end;

Constructor TBuildMenu.Create;
begin
  Inherited Create;
  lList := TStringList.Create;
  LocalOwner := nil;
end;

Destructor TBuildMenu.Destroy;
begin
  lList.Clear;
  FreeAndNil(lList);

  if Assigned(LocalOwner) then
     FreeAndNil(LocalOwner);

  Inherited Destroy;
end;

Function TBuildMenu.GetNewQuery(AFirstIDMenuItem: Integer):TADOQuery;
begin
  Result := TADOQuery.Create(Nil);
  with Result do
    begin
      SQL.Add('SELECT                                                 ');
      SQL.Add('       CAST(M.MenuBarBefore as Integer) as MenuBarBefore,');
      SQL.Add('       M.LoaderType,                                   ');
      SQL.Add('       M.IDMenuItem as IDMenu,                         ');
      SQL.Add('       MML.MenuItem as MenuName,                         ');
      SQL.Add('       M.FormID,                                       ');
      SQL.Add('       M.IDMenuItemParent as IDMenuParent,             ');
      SQL.Add('       M.Priority,                                     ');
      SQL.Add('       M.ClassName,                                    ');
      SQL.Add('       M.Parametro,                                    ');
      SQL.Add('       IsNull(M.ImageIndex,-1) as ImageIndex,          ');
      SQL.Add('       COUNT(MP.IDMenuItem) as CountOfChild            ');
      SQL.Add('FROM                                                   ');
      SQL.Add('       Sis_MainMenu M                                  ');
      SQL.Add('       JOIN Sis_MainMenuLanguage MML                   ');
      SQL.Add('            ON (M.IDMenuItem = MML.IDMenuItem)         ');
      SQL.Add('       LEFT OUTER JOIN Sis_MainMenu MP                 ');
      SQL.Add('            ON (MP.IDMenuItemParent = M.IDMenuItem)    ');
      SQL.Add('WHERE                                                  ');
      SQl.Add('       M.IDMenuItem <> '+ IntToStr(AFirstIDMenuItem)+' ');
      SQl.Add('       AND                                             ');
      SQl.Add('       MML.IDLanguage = '+ IntToStr(fIDlanguage)+'     ');
      SQL.Add('GROUP BY                                               ');
      SQL.Add('       M.IDMenuItemParent,                             ');
      SQL.Add('       M.IDMenuItem,                                   ');
      SQL.Add('       CAST(M.MenuBarBefore as Integer),               ');
      SQL.Add('       M.LoaderType,                                   ');
      SQL.Add('       MML.MenuItem,                                   ');
      SQL.Add('       M.FormID,                                       ');
      SQL.Add('       M.ClassName,                                    ');
      SQL.Add('       M.Parametro,                                    ');
      SQL.Add('       M.ImageIndex,                                   ');
      SQL.Add('       M.Priority                                      ');
      SQL.Add('ORDER BY                                               ');
      SQL.Add('       M.IDMenuItemParent,                             ');
      SQl.Add('       M.Priority                                      ');
    
    end;

  Result.Connection := FConnection;

end;

procedure TBuildMenu.AddNewMenu(AOwner: TComponent; ALinks: TdxBarItemLinks; aQuery: TDataSet);
var
  BarButton: TmyBarButton;
  BarSubItem: TdxBarSubItem;
begin

  if aQuery.FieldByName('CountOfChild').AsInteger > 0 then
    begin
      // E um subMenu
      BarSubItem := CreateSubItem(AOwner, ALinks, aQuery.FieldByName('MenuBarBefore').AsInteger);

      with BarSubItem do
        begin
        Caption       := aQuery.FieldByName('MenuName').AsString;
        ImageIndex    := aQuery.FieldByName('ImageIndex').AsInteger;
        end;

      // Adiciono o SubItem a Lista para facilitar a procura depois
      lList.AddObject(aQuery.FieldByName('IDMenu').AsString, BarSubItem);
    end
  else
    begin
      // E um item de menu
      BarButton := CreateButton(AOwner, ALinks, aQuery.FieldByName('MenuBarBefore').AsInteger);

      with BarButton do
        begin
          OnClick       := FStartUpModulo;
          Caption       := aQuery.FieldByName('MenuName').AsString;
          Title         := aQuery.FieldByName('MenuName').AsString;
          IDMenuItem    := aQuery.FieldByName('IDMenu').AsInteger;
          FormClassName := aQuery.FieldByName('ClassName').AsString;
          LoaderType    := aQuery.FieldByName('LoaderType').AsInteger;
          Parametro     := aQuery.FieldByName('Parametro').AsString;
          FormID        := aQuery.FieldByName('FormID').AsInteger;
          ImageIndex    := aQuery.FieldByName('ImageIndex').AsInteger;
          Ready         := True;
          Loaded        := False;
        end;

      // Adiciono o SubItem a Lista para facilitar a procura depois
      lList.AddObject(aQuery.FieldByName('IDMenu').AsString, BarButton);

    end;

end;

function TBuildMenu.GetButton(iIDMenu:Integer):TmyBarButton;
begin

  Result := GetButtonByID(iIDMenu);

end;

Function TBuildMenu.GetButtonByID(aIDMenuItem:Integer):TmyBarButton;
begin
  with lList do
   if (IndexOf(IntToStr(aIdMenuItem)) <> -1) then
     Result := TMyBarButton(Objects[IndexOf(IntToStr(aIdMenuItem))])
   else
     Result := Nil;
end;

Function TBuildMenu.GetSubItemByID(aIDMenuItem:Integer):TdxBarSubItem;
begin
  with lList do
   if (IndexOf(IntToStr(aIdMenuItem)) <> -1) then
     Result := TdxBarSubItem(Objects[IndexOf(IntToStr(aIdMenuItem))])
   else
     Result := Nil;
end;

function TBuildMenu.CreateSubItem(AOwner: TComponent; ALinks: TdxBarItemLinks; ABeginGroup: Integer): TdxBarSubItem;
var
  NewItemLink : TdxBarItemLink;
begin
  Result           := TdxBarSubItem.Create(AOwner);
  NewItemLink      := ALinks.Add;
  NewItemLink.Item := Result;
  NewItemLink.BeginGroup := (ABeginGroup=1);

end;

function TBuildMenu.CreateButton(AOwner: TComponent; ALinks: TdxBarItemLinks; ABeginGroup: Integer): TmyBarButton;
var
  NewItemLink : TdxBarItemLink;
begin
  Result           := TmyBarButton.Create(AOwner);
  NewItemLink      := ALinks.Add;
  NewItemLink.Item := Result;

  NewItemLink.BeginGroup := (ABeginGroup=1);

end;

procedure TBuildMenu.ConstructMenu(AFirstIDMenuItem, IDLanguage: integer);
var
  fDataSet   : TADOQuery;
  CurrentMenuParent: TdxBarSubItem;

begin
  if (FConnection <> nil) then
  begin

    fIDLanguage := IDLanguage;

    if LocalOwner <> nil then
      begin
        ClearModules;
        LocalOwner.Free;
      end;

    LocalOwner := TPanel.Create(FMenuOwner);
    lList.Clear;

    fDataSet := GetNewQuery(AFirstIDMenuItem);

    // Abre todos os items deste menu
    if fDataSet <> Nil then
      with fDataSet do
        begin
          Close;
          Open;
          Try
            while not fDataSet.eof do
            Try
              BarManager.MainMenuBar.LockUpdate := True;
              // Verifico se existe o Parent
              CurrentMenuParent := GetSubItemByID(fDataSet.FieldByName('IDMenuParent').AsInteger);

              if CurrentMenuParent <> nil then
                AddNewMenu(LocalOwner, CurrentMenuParent.ItemLinks, fDataSet)
              else
                AddNewMenu(LocalOwner, FBarManager.MainMenuBar.ItemLinks, fDataSet);

            Finally
              fDataSet.Next;
            end
          Finally
            // Adiciono Menu Help
            BarManager.MainMenuBar.LockUpdate := False;
            fDataSet.Close;
            fDataSet.Free;
          end;
        end;
  end
  else
    Raise Exception.Create('Property TCreateMenu::ADO Connection not defined');
end;


procedure TBuildMenu.ClearModules;
var Loop : Integer;
begin
  for Loop := 0 to lList.Count - 1 do
     ClearModule(StrToInt(lList[Loop]));
end;

procedure TBuildMenu.ClearModule(Const AIDMenuItem: Integer);
var
  myBarButton : TmyBarButton;
begin
  try
    myBarButton := GetButtonByID(aIDMenuItem);
  except
    myBarButton := nil;
  end;

  if myBarButton <> nil then
    with myBarButton do
      begin
        // Destroi o Form
        try
          if Form <> nil then
          begin
            Form.Close;  (* 001 *)
            Form.Free;
          end;
        finally
          Form := nil;
        end;
        Loaded := False;
      end;

end;

initialization
  dxBarRegisterItem(TmyBarButton, TmyBarButtonControl, True);

finalization
  dxBarUnregisterItem(TMyBarButton);


end.
