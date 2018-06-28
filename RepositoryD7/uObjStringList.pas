unit uObjStringList;

interface

uses classes;

type
  TObjStringList = class(TStringList)
  private
     procedure AutoFreeObject(index:integer); virtual;
  public
     destructor Destroy; override;
     procedure Clear; override;
  end;


implementation

procedure TObjStringList.AutoFreeObject(index : integer );
begin

   // make sure index is in range
   if (Index >= 0) and (index < Count ) then
      begin
      // call destructor of object
      if assigned(objects[index]) then
         objects[index].free;
      end;

end;

procedure TObjStringList.Clear;
var
  i, iTot : integer;
begin
   // remove the objects before clearing
   iTot := count - 1;
   for i := 0 to iTot do
      AutoFreeObject(i);

   inherited Clear;
end;

destructor TObjStringList.Destroy;
begin
   Clear;
   inherited Destroy;
end;


end.
