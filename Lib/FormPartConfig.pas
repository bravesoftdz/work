unit FormPartConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TFormPartConfig = class(TComponent)
  private
    { Private declarations }
    FPostOnInsert   : Boolean;
    FRequiredFields : TStringList;
    FDependentTables, FDependentTableKeys : TStringList;
    FPrefixoCodigo: String;
    procedure SetRequiredFields(Value : TStringList);
    procedure SetDependentTables(Value : TStringList);
    procedure SetDependentTableKeys(Value : TStringList);
  protected
    { Protected declarations }
    destructor  Destroy; override;
    constructor Create(AOwner: TComponent); override;
  public
    { Public declarations }
  published
    { Published declarations }
    property PrefixoCodigo  : String read FPrefixoCodigo write FPrefixoCodigo;
    property PostOnInsert   : Boolean  read FPostOnInsert write FPostOnInsert default False;
    property RequiredFields : TStringList read FRequiredFields write SetRequiredFields;
    property DependentTables    : TStringList read FDependentTables write SetDependentTables;
    property DependentTableKeys : TStringList read FDependentTableKeys write SetDependentTableKeys;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TFormPartConfig]);
end;

constructor TFormPartConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPostOnInsert   := False;
  FRequiredFields := TStringList.Create;
  FDependentTables    := TStringList.Create;
  FDependentTableKeys := TStringList.Create;
end;

destructor TFormPartConfig.Destroy;
begin
  FRequiredFields.Free;
  FDependentTables.Free;
  FDependentTableKeys.Free;
  inherited Destroy;
end;

procedure TFormPartConfig.SetRequiredFields(Value : TStringList);
begin
  if FRequiredFields <> Value then
     FRequiredFields.Assign(Value);
end;

procedure TFormPartConfig.SetDependentTables(Value : TStringList);
begin
  if FDependentTables <> Value then
     FDependentTables.Assign(Value);
end;

procedure TFormPartConfig.SetDependentTableKeys(Value : TStringList);
begin
  if FDependentTableKeys <> Value then
     FDependentTableKeys.Assign(Value);
end;


end.
