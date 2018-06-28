unit DBPopUpMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, TypInfo;

type
  TaPopUpItem = array[0..200] of TMenuItem;

  TDBPopUpMenu = class(TPopUpMenu)
  private
    { Private declarations }
    IsFirst : boolean;
    aMyPopUpItem : TaPopUpItem;
    aMyFixedItem : TaPopUpItem;
    FquMenu     : TQuery;
    FFieldPath, FFieldHint, FFieldMenu : String;
    FPathLength : integer;
    FOnItemsClick : TNotifyEvent;
    PathList : TStringList;
    FixedItems : TMenuItem;
    procedure MyMenuClick(Sender : TObject);
    procedure MenuItemAssign(FixedItems, Items : TMenuItem;
                             IniPos : integer; aPopUpItem : TaPopUpItem);
  protected
    { Protected declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    LastClickedPath : String;
    procedure LoadMenu;
  published
    { Published declarations }
    property quMenu     : TQuery  read FquMenu write FquMenu;
    property FieldPath  : String  read FFieldPath  write FFieldPath;
    property FieldMenu  : String  read FFieldMenu  write FFieldMenu;
    property FieldHint  : String  read FFieldHint  write FFieldHint;
    property PathLength : integer read FPathLength write FPathLength default 2;
    property OnItemsClick : TNotifyEvent read FOnItemsClick write FOnItemsClick;
  end;

procedure Register;

implementation

uses xBase;

procedure Register;
begin
  RegisterComponents('NewPower', [TDBPopUpMenu]);
end;

constructor TDBPopUpMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPathLength := 2;
  PathList   := TStringList.Create;
  FixedItems := TMenuItem.Create(Self);
  IsFirst := True;
end;

destructor TDBPopUpMenu.Destroy;
begin
  PathList.Free;
  inherited Destroy;
end;

procedure TDBPopUpMenu.LoadMenu;
var
  Index, i : Integer;
  MenuPos  : Integer;
begin
  if not Assigned(FquMenu) then
     raise exception.create('quMenu não foi definido');

  if (FFieldMenu = '') then
     raise exception.create('Nome do campo Menu nao foi definido');

  if (FFieldPath = '') then
     raise exception.create('Nome do campo Path nao foi definido');

  if (FFieldHint = '') then
     raise exception.create('Nome do campo Hint nao foi definido');

  if IsFirst then
    begin
     // Preenche o FixedItems com os itens do Items
     MenuItemAssign(FixedItems, Items, 0, aMyFixedItem);
     IsFirst := False;
    end;

  // Carrega o Tree View com os dados do Query
  Screen.Cursor := crHourGlass;
  PathList.Clear;

  while Items.Count > 0 do
     Items.Delete(Items.Count-1);

  FquMenu.Open;
  FquMenu.First;

  MenuPos := 0;

  while not FquMenu.Eof do
    begin
      // descobre o no pai
      aMyPopUpItem[MenuPos] := TMenuItem.Create(Self);
      if not PathList.Find(LeftStr(FquMenu.FieldByName(FFieldPath).AsString,
                           Length(FquMenu.FieldByName(FFieldPath).AsString)-(FPathLength+1)), Index) then
         // e o primeiro
         Items.Add(aMyPopUpItem[MenuPos])
      else
        begin
         aMyPopUpItem[Index].Add(aMyPopUpItem[MenuPos]);
         aMyPopUpItem[Index].OnClick := nil;
        end;

      // Inclue na lista de Path
      PathList.Add(FquMenu.FieldByName(FFieldPath).AsString);

      aMyPopUpItem[MenuPos].Caption := FquMenu.FieldByName(FFieldMenu).AsString;
      aMyPopUpItem[MenuPos].Hint    := FquMenu.FieldByName(FFieldHint).AsString;
      aMyPopUpItem[MenuPos].Tag     := MenuPos;
      aMyPopUpItem[MenuPos].OnClick := MyMenuClick;

      FquMenu.Next;
      Inc(MenuPos);
    end;

  FquMenu.Close;

  MenuItemAssign(Items, FixedItems, MenuPos+1, aMyPopUpItem);

  Screen.Cursor := crDefault;
end;

procedure TDBPopUpMenu.MyMenuClick(Sender : TObject);
begin
 LastClickedPath := PathList.Strings[TMenuItem(Sender).Tag];
 if Assigned(OnItemsClick) then
   FOnItemsClick(Sender);
end;

procedure TDBPopUpMenu.MenuItemAssign(FixedItems, Items : TMenuItem;
                                      IniPos : integer; aPopUpItem : TaPopUpItem);
var
 i : integer;
begin
  for i := 0 to Items.Count - 1 do
    begin
      aPopUpItem[IniPos] := TMenuItem.Create(Self);
      aPopUpItem[IniPos].Caption := Items[i].Caption;
      aPopUpItem[IniPos].Hint    := Items[i].Hint;
      aPopUpItem[IniPos].Tag     := Items[i].Tag;
      aPopUpItem[IniPos].OnClick := Items[i].OnClick;
      FixedItems.Add(aPopUpItem[IniPos]);
      Inc(IniPos);
      MenuItemAssign(FixedItems[i], Items[i], IniPos, aPopUpItem);
    end;
end;

end.
