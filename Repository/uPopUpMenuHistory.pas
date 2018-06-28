unit uPopUpMenuHistory;

interface

uses classes, dxBar;

const
    WEB_PRIOR  = 0;
    WEB_NEXT   = 1;

type

  TMenuItem = class
     FIDMenu   : Integer;
     FMenuName : String;
  end;

  THistoryList = class
     private
        FIDActualMenu      : Integer;
        FMenuHistory       : TStringList;
        FPopUpBackward     : TdxBarPopupMenu;
        FPopUpForward      : TdxBarPopupMenu;
        FButton            : TdxBarButton;
        FHasNext           : Boolean;
        FHasPrior          : Boolean;
        FNewBackHistory    : Boolean;
        FNewForwardHistory : Boolean;
        FMenuItem          : TMenuItem;

        procedure FreeDeleteAllItems;
        procedure FreeDeleteItem(iPos:Integer);
        procedure FreeItem(iPos:Integer);
        procedure DeleteItem(iPos:Integer);
        procedure UpdateControl;
        function GetMenuItemIndex(sItem:String):Integer;
     public
        Constructor Create;
        Destructor Destroy; override;
        //property
        property PopUpBackward        : TdxBarPopupMenu read FPopUpBackward write FPopUpBackward;
        property PopUpForward         : TdxBarPopupMenu read FPopUpForward  write FPopUpForward;
        property Button               : TdxBarButton    read FButton        write FButton;
        property ActualIDMenu         : Integer         read FIDActualMenu;
        property HasNext              : Boolean         read FHasNext;
        property HasPrior             : Boolean         read FHasPrior;
        property IsNewBackwardHistory : Boolean         read FNewBackHistory;
        property IsNewForwardHistory  : Boolean         read FNewForwardHistory;
        //procedures
        procedure SetItemHistory(ID:Integer; MenuName:String);
        procedure DeleteActualItem;
        procedure DeleteAllMenuItems;
        procedure NavigateControl(Action:Integer);
        procedure GetBackHistory;
        procedure GetForwardHistory;
        //functions
        function GetHistoryTotal:integer;
  end;

implementation

uses Sysutils;

{  THistoryList  }

function THistoryList.GetHistoryTotal:integer;
begin
   Result := FMenuHistory.Count; 
end;

procedure THistoryList.GetBackHistory;
var
 iPos, i : Integer;
begin

   iPos := GetMenuItemIndex(IntToStr(FIDActualMenu));

   if iPos <> -1 then
      begin
      FPopUpBackward.ItemLinks.Clear;

      for i := iPos-1 downto 0 do
         with FPopUpBackward.ItemLinks do
             with Add do
               begin
               Item        := FButton;
               Data        := TMenuItem(FMenuHistory.Objects[i]).FIDMenu;
               UserCaption := TMenuItem(FMenuHistory.Objects[i]).FMenuName;
               end;

      FNewBackHistory := False;
      end;

end;

procedure THistoryList.GetForwardHistory;
var
 iPos, i : Integer;
begin

   iPos := GetMenuItemIndex(IntToStr(FIDActualMenu));

   if iPos <> -1 then
      begin
      FPopUpForward.ItemLinks.Clear;

      for i := iPos+1 to FMenuHistory.Count-1 do
         with FPopUpForward.ItemLinks do
             with Add do
               begin
               Item        := FButton;
               Data        := TMenuItem(FMenuHistory.Objects[i]).FIDMenu;
               UserCaption := TMenuItem(FMenuHistory.Objects[i]).FMenuName;
               end;

      FNewForwardHistory := False;
      end;
end;

procedure THistoryList.UpdateControl;
begin

  FHasPrior := (FMenuHistory.IndexOf(IntToStr(FIDActualMenu)) > 0);
  FHasNext  := (FMenuHistory.IndexOf(IntToStr(FIDActualMenu)) < FMenuHistory.Count-1);

  FNewBackHistory    := True;
  FNewForwardHistory := True;

end;

procedure THistoryList.NavigateControl(Action : Integer);
var
   iActual : Integer;
begin

   iActual := GetMenuItemIndex(IntToStr(FIDActualMenu));

   if iActual <> -1 then
      Case Action of
          WEB_PRIOR : begin
                      if iActual-1 >= 0 then
                         FIDActualMenu := StrToInt(FMenuHistory.Strings[iActual-1]);
                      end;

          WEB_NEXT  : begin
                      if iActual+1 <= FMenuHistory.Count-1 then
                         FIDActualMenu := StrToInt(FMenuHistory.Strings[iActual+1]);
                      end;

      end;

    //Next and prior menu
    UpdateControl;

end;

procedure THistoryList.DeleteAllMenuItems;
begin
   FreeDeleteAllItems;
end;

procedure THistoryList.DeleteActualItem;
var
  DelPos : integer;
begin

    DelPos := GetMenuItemIndex(IntToStr(FIDActualMenu));

    if DelPos <> -1 then
       FreeDeleteItem(DelPos);

   if (FMenuHistory.Count > 0) then
       if (DelPos > FMenuHistory.Count-1) then
           FIDActualMenu := TMenuItem(FMenuHistory.Objects[FMenuHistory.Count-1]).FIDMenu
       else
           FIDActualMenu := TMenuItem(FMenuHistory.Objects[DelPos]).FIDMenu 
   else
      FIDActualMenu := 0;

   //Next and prior menu
   UpdateControl;

end;

procedure THistoryList.FreeDeleteAllItems;
var
  i : Integer;
begin

  for i := FMenuHistory.Count-1 downto 0 do
      FreeDeleteItem(i);

end;

procedure THistoryList.FreeDeleteItem(iPos:Integer);
begin
  FreeItem(iPos);
  DeleteItem(iPos);
end;

procedure THistoryList.FreeItem(iPos:Integer);
begin
  if iPos <> -1 then
     if Assigned(FMenuHistory.Objects[iPos]) then
        begin
        FMenuHistory.Objects[iPos] := nil;
        FMenuHistory.Objects[iPos].Free;
        end;
end;

procedure THistoryList.DeleteItem(iPos:Integer);
begin
  if iPos <> -1 then
     FMenuHistory.Delete(iPos);
end;

function THistoryList.GetMenuItemIndex(sItem:String):Integer;
begin
  Result := FMenuHistory.IndexOf(sItem);
end;

procedure THistoryList.SetItemHistory(ID : Integer; MenuName : String);
begin

  if GetMenuItemIndex(IntToStr(ID)) = -1 then
     begin
     FMenuItem           := TMenuItem.Create;
     FMenuItem.FIDMenu   := ID;
     FMenuItem.FMenuName := MenuName;
     FMenuHistory.AddObject(IntToStr(ID), FMenuItem);
     end;

  FIDActualMenu := ID;

  //Next and Prior Menu
  UpdateControl;

end;

Constructor THistoryList.Create;
begin
   inherited Create;
   
   FMenuHistory := TStringList.Create;

end;

Destructor THistoryList.Destroy;
begin

  FreeDeleteAllItems;

  if Assigned(FMenuItem) then
     FreeAndNil(FMenuItem);

  FreeAndNil(FMenuHistory);

  inherited Destroy;
  
end;

end.
