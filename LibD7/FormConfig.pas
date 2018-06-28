unit FormConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TFormConfig = class(TComponent)
  private
    { Private declarations }
    FSystemReadOnly    : Boolean;
    FAutoCodeGen       : Boolean;
    FIsAutoIncKey      : Boolean;
    FPostOnInsert      : Boolean;
    FConfirmCancel, FConfirmPost : Boolean;
    FOperacaoDefault   : Boolean;
    FEntidadeNome      : String;
    FAutoIncField      : String;
    FEntidadeMasculina : Boolean;
    FHiddenPostOnInsert : Boolean;
    FUniqueFields, FRequiredFields, FDependentTables, FDependentTableKeys : TStringList;

    procedure SetRequiredFields(Value : TStringList);
    procedure SetUniqueFields(Value : TStringList);
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
    property AutoCodeGen         : Boolean  read FAutoCodeGen write FAutoCodeGen default True;
    property IsAutoIncKey        : Boolean  read FIsAutoIncKey write FIsAutoIncKey;
    property SystemReadOnly      : Boolean  read FSystemReadOnly write FSystemReadOnly default True;
    property PostOnInsert        : Boolean  read FPostOnInsert write FPostOnInsert default False;
    property ConfirmPost         : Boolean  read FConfirmPost  write FConfirmPost default True;
    property ConfirmCancel       : Boolean  read FConfirmCancel write FConfirmCancel default True;
    property OperacaoDefault     : Boolean  read FOperacaoDefault write FOperacaoDefault;
    property EntidadeNome        : String   read FEntidadeNome write FEntidadeNome;
    property AutoIncField        : String   read fAutoIncField write fAutoIncField;
    property EntidadeMasculina   : Boolean   read FEntidadeMasculina write FEntidadeMasculina default True;
    property RequiredFields      : TStringList read FRequiredFields write SetRequiredFields;
    property UniqueFields        : TStringList read FUniqueFields write SetUniqueFields;
    property DependentTables     : TStringList read FDependentTables write SetDependentTables;
    property DependentTableKeys  : TStringList read FDependentTableKeys write SetDependentTableKeys;
    property HiddenPostOnInsert  : Boolean  read FHiddenPostOnInsert write FHiddenPostOnInsert default True;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TFormConfig]);
end;

constructor TFormConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSystemReadOnly     := True;
  FPostOnInsert       := False;
  FConfirmCancel      := True;
  FConfirmPost        := True;
  FAutoCodeGen        := True;
  FEntidadeNome       := '';
  FEntidadeMasculina  := True;
  FRequiredFields     := TStringList.Create;
  FUniqueFields       := TStringList.Create;
  FDependentTables    := TStringList.Create;
  FDependentTableKeys := TStringList.Create;
end;

destructor TFormConfig.Destroy;
begin
  FRequiredFields.Free;
  FUniqueFields.Free;
  FDependentTables.Free;
  FDependentTableKeys.Free;
  inherited Destroy;
end;

procedure TFormConfig.SetRequiredFields(Value : TStringList);
begin
  if FRequiredFields <> Value then
     FRequiredFields.Assign(Value);
end;

procedure TFormConfig.SetUniqueFields(Value : TStringList);
begin
  if FUniqueFields <> Value then
     FUniqueFields.Assign(Value);
end;

procedure TFormConfig.SetDependentTables(Value : TStringList);
begin
  if FDependentTables <> Value then
     FDependentTables.Assign(Value);
end;

procedure TFormConfig.SetDependentTableKeys(Value : TStringList);
begin
  if FDependentTableKeys <> Value then
     FDependentTableKeys.Assign(Value);
end;

end.
