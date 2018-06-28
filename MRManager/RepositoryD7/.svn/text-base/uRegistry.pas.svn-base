unit uRegistry;

interface

uses Registry, Windows;

type
  TDefaulRegistry = class
     private
        FRootKey : HKEY;
        FOpenKey : String;
        FKey     : String;
     public
        property RookKey : HKEY   read FRootKey write FRootKey;
        property OpenKey : String read FOpenKey write FOpenKey;
        property Key     : String read FKey     write FKey;
  end;

  TStringRegistry = class(TDefaulRegistry)
     private
        FValue : String;
     public
        property Value : String read FValue write FValue;
        procedure SaveStringRegistry(Value : String);
        function GetStringRegistry:String;
  end;


  TWinRegistry = class(TDefaulRegistry)
     private
        FStringReg : TStringRegistry;
     public
        property StringRegistry : TStringRegistry read FStringReg write FStringReg;

        Constructor Create;
        Destructor Destroy; override;
  end;

implementation

{--------- TWinRegistry ----------}


Constructor TWinRegistry.Create;
begin
   inherited Create;
   FStringReg := TStringRegistry.Create;
end;

Destructor TWinRegistry.Destroy;
begin
  FStringReg.Free;
  inherited Destroy;
end;


{--------- TStringRegistry ----------}
procedure TStringRegistry.SaveStringRegistry(Value : String);
var
  Reg : TRegistry;
begin

  Try
    Reg := TRegistry.Create;
    Reg.RootKey := Self.FRootKey;
    Reg.OpenKey(Self.FOpenKey, True);
    Reg.WriteString(Self.Key, Value);
  Finally
    Reg.CloseKey;
    Reg.Free;
    end;

end;

function TStringRegistry.GetStringRegistry:String;
var
  Reg : TRegistry;
begin

  Try
    Reg := TRegistry.Create;
    Reg.RootKey := Self.FRootKey;
    Reg.OpenKey(Self.FOpenKey, True);
    Result := Reg.ReadString(Self.Key);
  Finally
    Reg.CloseKey;
    Reg.Free;
    end;

end;


end.
