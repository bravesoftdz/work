unit StoreCls;

interface
uses Classes;

type
    TStoreRegistry = class
    private
       FidStore: Integer;
       Fname   : String;
    function getName: String;
    procedure setName(value: String);

       // ... other atributtes
    protected
       procedure setIdStore(value: Integer);
       function getIdStore: Integer;

    public
       property IdStore: Integer read getIdStore write setIdStore;
       property Name: String read getName write setName;
       //... other methods
       function getIndex(store: TStoreRegistry): Integer;

    end;

implementation

{ TStoreRegistry }

function TStoreRegistry.getIdStore: Integer;
begin
  result := FIdStore;
end;

function TStoreRegistry.getIndex(store: TStoreRegistry): Integer;
begin
  result := store.idStore;
end;
function TStoreRegistry.getName: String;
begin
  result := FName;
end;

procedure TStoreRegistry.setIdStore(value: Integer);
begin
  FIdStore := value;
end;

procedure TStoreRegistry.setName(value: String);
begin
  FName := value;
end;

end.
