unit StoreDAO;

interface
uses
   StoreCls, Classes, DB, ADODb, SysUtils;

type
   TStoreDAO = class
   private
     connection: TADOConnection;
   public
     constructor create(connection: TADOConnection);
     function insert(store: TStoreRegistry): Boolean;
     function update(store: TStoreRegistry): Boolean;
     function delete(id: Integer): Boolean;
     function getStores(): TList;
     function getStore(i: Integer): TStoreRegistry;
   end;


implementation

{ TStoreDAO }

constructor TStoreDAO.create(connection: TADOConnection);
begin
  self.connection := connection;
end;

function TStoreDAO.delete(id: Integer): Boolean;
begin

end;

function TStoreDAO.getStore(i: Integer): TStoreRegistry;
begin

end;

function TStoreDAO.getStores: TList;
var
  qry: TADOQuery;
  stores: TList;
  store: TStoreRegistry;
begin
  try
     try
        stores := TList.Create;
        qry := TADOQuery.Create(nil);
        qry.Connection := connection;
        qry.SQL.Add('select * from Store');
        qry.open;

        qry.First;
        while ( not qry.Eof ) do begin
           store := TStoreRegistry.Create;
           store.IdStore := (qry.fieldByName('IDStore').Value);
           store.Name := (qry.fieldByName('Name').Value);
           stores.Add(store);
           qry.Next();
        end;

        result := stores;

     except
        on e: Exception do begin
           raise Exception.create('Failed to read stores: '+e.Message);
        end;
     end;
  finally
     freeAndNil(qry);
  end;
end;

function TStoreDAO.insert(store: TStoreRegistry): Boolean;
begin

end;

function TStoreDAO.update(store: TStoreRegistry): Boolean;
begin

end;

end.
