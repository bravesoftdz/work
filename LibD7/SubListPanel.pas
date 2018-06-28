unit SubListPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, uParentSub;

type
  TOnDataChange = procedure of object;
  TOnSelectData = procedure (AParams: String) of object;
  TOnGetFchParam = function(): String of object;
  TOnGetSQLEnvent = function(): String of object;
  TOnTestFillEvent = function(): boolean of object;

  TAfterParamChanged = procedure(Changes: String) of object;

  TSubListPanel = class(TPanel)
  private
    FOnGetSQL: TOnGetSQLEnvent;
    FParam: String;
    FButtonNewEnabled,
    FButtonOpenEnabled,
    FButtonRemoveEnabled: Boolean;
    FOnDataChange: TOnDataChange;
    FOnGetFchParam:  TOnGetFchParam;
    FOnTestFillEvent:  TOnTestFillEvent;
    FFilterFields : TStringList; { campos do filtro }
    FFilterValues : TStringList; { valores do filtro }
    FSubListClassName: String;
    FSubListForm: TForm;
    FAfterParamChanged: TAfterParamChanged;
    FOnSelectData: TOnSelectData;
    function GetDatasetIsEmpty: boolean;
    function GetDatasetCount: integer;
    function GetCurrentKey: integer;
    procedure SetOnGetSQL(Value:TOnGetSQLEnvent);
    procedure SetParam(Value: String);
    procedure SetButtonNewEnabled(Value : boolean);
    procedure SetButtonOpenEnabled(Value : boolean);
    procedure SetButtonRemoveEnabled(Value : boolean);
    procedure SetSubListClassName(Value : String);
    procedure SetCaption;
    procedure SetColor;
    procedure FreeFch;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure CreateSubList;
    procedure DataSetOpen;
    procedure DataSetClose;
    procedure DataSetNew;
    procedure SubListRefresh;
    procedure DoParamChanged(Changes: String);
    procedure SetSubListProperties;
    procedure GetSubListProperties;
    function GetSubListInfo(InfoString: String): String;

  published
    property Param               : String read FParam write SetParam;
    property ButtonNewEnabled    : Boolean read FButtonNewEnabled write SetButtonNewEnabled default True;
    property ButtonOpenEnabled   : Boolean read FButtonOpenEnabled write SetButtonOpenEnabled default True;
    property ButtonRemoveEnabled : Boolean read FButtonRemoveEnabled write SetButtonRemoveEnabled default True;
    property CurrentKey       : integer read GetCurrentKey;
    property DatasetCount     : integer read GetDatasetCount;
    property DatasetIsEmpty   : Boolean read GetDatasetIsEmpty;
    property OnGetSQL         : TOnGetSQLEnvent read FOnGetSQL write SetOnGetSQL;
    property OnDataChange     : TOnDataChange read FOnDataChange write FOnDataChange;
    property OnSelectData     : TOnSelectData read FOnSelectData write FOnSelectData;
    property OnGetFchParam    : TOnGetFchParam read FOnGetFchParam write FOnGetFchParam;
    property OnTestFillEvent  : TOnTestFillEvent read FOnTestFillEvent write FOnTestFillEvent;
    property SubListClassName : String read FSubListClassName write SetSubListClassName;
    property FilterFields     : TStringList read FFilterFields write FFilterFields; //SetFilterFields;
    property FilterValues     : TStringList read FFilterValues write FFilterValues; //SetFilterValues;
    property AfterParamChanged: TAfterParamChanged read FAfterParamChanged write fAfterParamChanged;
  end;

procedure Register;

implementation

uses uCriarForm;

procedure Register;
begin
  RegisterComponents('NewPower', [TSubListPanel]);
end;

constructor TSubListPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFilterFields := TStringList.Create;
  FFilterValues := TStringList.Create;

  FButtonNewEnabled := True;
  FButtonOpenEnabled := True;
  FButtonRemoveEnabled := True;

  BevelOuter := bvNone;
  SetCaption;
  SetColor;
end;

destructor TSubListPanel.Destroy;
begin
  FFilterFields.Free;
  FFilterValues.Free;
  inherited Destroy;
end;

procedure TSubListPanel.SetSubListClassName(Value : String);
begin
  if Value <> FSubListClassName then
  begin
    FSubListClassName := Value;
    FreeFch;
    SetCaption;
    SetColor;
  end;
end;

procedure TSubListPanel.FreeFch;
begin
  if FSubListForm <> nil then
  begin
    FSubListForm.Free;
    FSubListForm := nil;
  end;
end;

procedure TSubListPanel.CreateSubList;
begin
  if FSubListForm = nil then
    FSubListForm := CriaForm(Owner, FSubListClassName);

  if FSubListForm <> nil then
    try
      LockWindowUpdate(Handle);
      with TParentSub(FSubListForm) do
        begin
          Parent := Self;
          Top := 0;
          Left := 0;
          BorderStyle := bsNone;
          Align := alClient;
          FilterFields := FFilterFields;
          FilterValues := FFilterValues;
          SetButtonNewEnabled(FButtonNewEnabled);
          SetButtonOpenEnabled(FButtonOpenEnabled);
          SetButtonRemoveEnabled(FButtonRemoveEnabled);
          Param := FParam;
          if Assigned(Self.FOnGetSQL) then
            OnGetSQL := Self.FOnGetSQL;

          if Assigned(Self.FOnGetFchParam) then
            TParentSub(FSubListForm).OnGetFchParam := Self.FOnGetFchParam;

          if Assigned(Self.FOnTestFillEvent) then
            TParentSub(FSubListForm).OnTestFillEvent := Self.FOnTestFillEvent;

          if Assigned(Self.FOnDataChange) then
            TParentSub(FSubListForm).OnDataChange := Self.FOnDataChange;

          if Assigned(Self.FOnSelectData) then
            TParentSub(FSubListForm).OnSelectData := Self.FOnSelectData;

          Show;
        end;
    finally
      LockWindowUpdate(0);
    end;
end;

procedure TSubListPanel.SetCaption;
begin
  if FSubListClassName <> '' then
    Caption := ''
  else
    Caption := 'SubListClassName Undefined !';

end;
procedure TSubListPanel.SetColor;
begin
  if FSubListClassName = '' then
    Color := clRed;
end;

procedure TSubListPanel.DataSetOpen;
begin
  if FSubListForm <> nil then
    TParentSub(FSubListForm).DataSetOpen;
end;

procedure TSubListPanel.DataSetClose;
begin
  if FSubListForm <> nil then
    TParentSub(FSubListForm).DataSetClose;
end;

function TSubListPanel.GetDatasetIsEmpty: boolean;
begin
  Result := True;
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      Result := TParentSub(FSublistForm).GetDatasetIsEmpty;
end;

procedure TSubListPanel.DataSetNew;
begin
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      TParentSub(FSublistForm).DataSetNew;
end;

function TSubListPanel.GetDatasetCount: integer;
begin
  Result := -1;
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      Result := TParentSub(FSublistForm).GetRecordCount;
end;

function TSubListPanel.GetCurrentKey: integer;
begin
  Result := -1;
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      Result := TParentSub(FSublistForm).GetCurrentKey;
end;

procedure TSubListPanel.SetButtonNewEnabled(Value: boolean);
begin
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      TParentSub(FSublistForm).SetButtonNewEnabled(Value);
end;

procedure TSubListPanel.SetButtonOpenEnabled(Value: boolean);
begin
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      TParentSub(FSublistForm).SetButtonOpenEnabled(Value);
end;

procedure TSubListPanel.SetButtonRemoveEnabled(Value: boolean);
begin
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      TParentSub(FSublistForm).SetButtonRemoveEnabled(Value);
end;

procedure TSubListPanel.SetParam(Value: String);
begin
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      TParentSub(FSubListForm).Param := Value;
end;

procedure TSubListPanel.SetOnGetSQL(Value: TOnGetSQLEnvent);
begin
  FOnGetSQL := Value;
  if FSubListForm <> nil then
    if FSublistForm is TParentSub then
      TParentSub(FSubListForm).OnGetSQL := Value;
end;

procedure TSubListPanel.SubListRefresh;
begin
  if FSubListForm <> nil then
    TParentSub(FSubListForm).SubListRefresh;
end;

procedure TSubListPanel.DoParamChanged(Changes: String);
begin
  if Assigned(FAfterParamChanged) then
    FAfterParamChanged(Changes);
end;

function TSubListPanel.GetSubListInfo(InfoString: String) : String;
begin
  Result := TParentSub(FSubListForm).GiveInfo(InfoString);
end;

procedure TSubListPanel.SetSubListProperties;
begin
  TParentSub(FSubListForm).SetLayoutProperties;
end;

procedure TSubListPanel.GetSubListProperties;
begin
  TParentSub(FSubListForm).GetLayoutProperties;
end;

end.
