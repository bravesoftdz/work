unit mrSubListPanel;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Forms, Windows, Graphics, uNTUpdateControl,
  uNTDataSetControl, uSystemTypes, uClasseFunctions, uParentCustomList,
  uParentCustomSubList, uMRSQLParam, uNTTraceControl, uUserObj;

type
  TmrSubListPanel = class(TPanel)
  private
    FOnStateChange: TNotifyEvent;
    FSubListClassName: String;
    FFormSubList: TForm;
    FOnGetFilter: TOnGetFilter;
    FOnConfigFilter: TOnGetFilter;
    FOnGetTransaction: TOnGetTransaction;
    FLocked: Boolean;
    FSystemUser : TUser;
    FOnGetForeignKeyValue: TOnGetFilter;
    procedure DoConfigFilter(Sender: TObject; var Filter: TMRSQLParam);
    procedure SetCaption;
    procedure SetColor;
    procedure SetSubListClassName(const Value: String);
  public
    constructor Create(AOwner : TComponent); override;
    procedure CreateSubList(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
      AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser; AParams: String = '');
    procedure FreeSubList;
    procedure LockSubList(ALock: Boolean);
    procedure RefreshSubList;
    property FormSubList: TForm read FFormSubList write FFormSubList;
    property OnConfigFilter: TOnGetFilter read FOnConfigFilter write FOnConfigFilter;
  published
    property SubListClassName: String read FSubListClassName write SetSubListClassName;
    property OnGetFilter: TOnGetFilter read FOnGetFilter write FOnGetFilter;
    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
    property OnGetTransaction: TOnGetTransaction read FOnGetTransaction write FOnGetTransaction;
    property OnGetForeignKeyValue: TOnGetFilter read FOnGetForeignKeyValue write FOnGetForeignKeyValue;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrSubListPanel]);
end;

{ TmrSubListPanel }

constructor TmrSubListPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelOuter := bvNone;
  SetCaption;
  SetColor;
end;

procedure TmrSubListPanel.CreateSubList(ATraceControl: TmrTraceControl; ADataSetControl: TmrDataSetControl;
      AUpdateControl: TmrUpdateControl; ASession: TmrSession; ASystemUser : TUser; AParams: String);
begin

  FSystemUser := ASystemUser;

  LockWindowUpdate(Handle);
  try
    if FormSubList = nil then
    begin
      FormSubList := CreateForm(Owner, SubListClassName);
      with TParentCustomSubList(FormSubList) do
      begin
        Parent := Self;
        Top := 0;
        Left := 0;
        Align := alClient;
        ConfigList.OnGetFilter := Self.DoConfigFilter;
        OnStateChange := Self.OnStateChange;
        ConfigList.OnGetForeignKeyValue := OnGetForeignKeyValue;
        ConfigList.OnGetTransaction := OnGetTransaction;
        Init(ATraceControl, ADataSetControl, AUpdateControl, ASession, Self.FSystemUser, AParams);
      end;
    end
    else
      if AParams <> '' then
        TParentCustomSubList(FormSubList).Params := AParams;
  finally
    LockWindowUpdate(0);
  end;

  TParentCustomSubList(FormSubList).ShowList;

end;

procedure TmrSubListPanel.DoConfigFilter(Sender: TObject; var Filter: TMRSQLParam);
begin
  if Assigned(OnGetFilter) then
  begin
    OnGetFilter(Sender, Filter);
    //if (TParentCustomSubList(FormSubList).ForeignField <> '') and (Filter.KeyByName('ForeignField').AsString <> '') then
    //  Filter := TParentCustomSubList(FormSubList).ForeignField + ' = ' + Filter.KeyByName('ForeignField').AsString;
  end;
end;

procedure TmrSubListPanel.FreeSubList;
begin
  if FormSubList <> nil then
  begin
    FormSubList.Close;
    FormSubList.Free;
    FormSubList := nil;
  end;
end;

procedure TmrSubListPanel.LockSubList(ALock: Boolean);
begin
  FLocked := ALock;
  //if Assigned(FormSubList) then
  //  TParentCustomList(FormSubList).LockActions(FLocked);
end;

procedure TmrSubListPanel.RefreshSubList;
begin
  TParentCustomSubList(FormSubList).RefreshDataSet;
end;

procedure TmrSubListPanel.SetCaption;
begin
  if FSubListClassName <> '' then
    Caption := FSubListClassName
  else
    Caption := 'SubListClassName INDEFINIDO !';
end;

procedure TmrSubListPanel.SetColor;
begin
  if FSubListClassName <> '' then
    Color := clBtnShadow
  else
    Color := clRed;
end;

procedure TmrSubListPanel.SetSubListClassName(const Value: String);
begin
  if Value <> FSubListClassName then
  begin
    FSubListClassName := Value;
    SetCaption;
    SetColor;
  end;
end;

end.
