unit mrConfigFch;

interface

uses
  SysUtils, Classes, uSystemTypes;

type
  TmrConfigFch = class(TComponent)
  private
    FProviderName: String;
    FConnection: String;
    FConfirmApply: Boolean;
    FConfirmCancel: Boolean;
    FOnAfterAppend: TNotifyEvent;
    FOnAfterApplyChanges: TNotifyEvent;
    FOnAfterBrowse: TNotifyEvent;
    FOnAfterEdit: TNotifyEvent;
    FOnAfterNavigation: TNotifyEvent;
    FOnAfterStart: TNotifyEvent;
    FOnBeforeAppend: TNotifyEvent;
    FOnBeforeApplyChanges: TOnBeforeApplyChanges;
    FOnBeforeBrowse: TNotifyEvent;
    FOnBeforeCancelChanges: TNotifyEvent;
    FOnBeforeCommitTransaction: TNotifyEvent;
    FOnBeforeEdit: TNotifyEvent;
    FOnBeforeStart: TNotifyEvent;
    FOnCreateLinks: TNotifyEvent;
    FOnDestroyFch: TNotifyEvent;
    FOnSetActiveTab: TOnSetActiveTab;
    FOnSetPermissions: TNotifyEvent;
    FOnVersionMode: TOnVersionModeEvent;
  protected
    { Protected declarations }
  public
    procedure DoAfterStart;
    procedure DoBeforeStart;
    function DoBeforeApplyChanges: Boolean;
    procedure DoAfterApplyChanges;
    procedure DoBeforeCancelChanges;
    procedure DoBeforeCommitTransaction;
    procedure DoBeforeAppend;
    procedure DoAfterNavigation;
    procedure DoActiveTab(var TabIndex: Integer);
    procedure DoDestroyFch;
  published
    property Connection: String read FConnection write FConnection;
    property ProviderName: String read FProviderName write FProviderName;
    property ConfirmApply: Boolean read FConfirmApply write FConfirmApply default False;
    property ConfirmCancel: Boolean read FConfirmCancel write FConfirmCancel default False;
    property OnAfterAppend: TNotifyEvent read FOnAfterAppend write FOnAfterAppend;
    property OnAfterApplyChanges: TNotifyEvent read FOnAfterApplyChanges write FOnAfterApplyChanges;
    property OnAfterBrowse: TNotifyEvent read FOnAfterBrowse write FOnAfterBrowse;
    property OnAfterEdit: TNotifyEvent read FOnAfterEdit write FOnAfterEdit;
    property OnAfterNavigation: TNotifyEvent read FOnAfterNavigation write FOnAfterNavigation;
    property OnAfterStart: TNotifyEvent read FOnAfterStart write FOnAfterStart;
    property OnBeforeAppend: TNotifyEvent read FOnBeforeAppend write FOnbeforeAppend;
    property OnBeforeApplyChanges: TOnBeforeApplyChanges read FOnBeforeApplyChanges write FOnBeforeApplyChanges;
    property OnBeforeBrowse: TNotifyEvent read FOnBeforeBrowse write FOnbeforeBrowse;
    property OnBeforeCancelChanges: TNotifyEvent read FOnBeforeCancelChanges write FOnBeforeCancelChanges;
    property OnBeforeCommitTransaction: TNotifyEvent read FOnBeforeCommitTransaction write FOnBeforeCommitTransaction;
    property OnBeforeEdit: TNotifyEvent read FOnBeforeEdit write FOnbeforeEdit;
    property OnBeforeStart: TNotifyEvent read FOnBeforeStart write FOnBeforeStart;
    property OnCreateLinks: TNotifyEvent read FOnCreateLinks write FOnCreateLinks;
    property OnDestroyFch: TNotifyEvent read FOnDestroyFch write FOnDestroyFch;
    property OnSetActiveTab: TOnSetActiveTab read FOnSetActiveTab write FOnSetActiveTab;
    property OnSetPermissions: TNotifyEvent read FOnSetPermissions write FOnSetPermissions;
    property OnVersionMode: TOnVersionModeEvent read FOnVersionMode write FOnVersionMode;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrConfigFch]);
end;

{ TmrConfigFch }

procedure TmrConfigFch.DoDestroyFch;
begin
  if Assigned(OnDestroyFch) then
    OnDestroyFch(Self);
end;

procedure TmrConfigFch.DoBeforeCommitTransaction;
begin
  if Assigned(OnBeforeCommitTransaction) then
    OnBeforeCommitTransaction(Self);
end;

procedure TmrConfigFch.DoAfterApplyChanges;
begin
  if Assigned(OnAfterApplyChanges) then
    OnAfterApplyChanges(Self);
end;

procedure TmrConfigFch.DoBeforeStart;
begin
  if Assigned(OnBeforeStart) then
    OnBeforeStart(Self);
end;

procedure TmrConfigFch.DoAfterNavigation;
begin
  if Assigned(OnAfterNavigation) then
    OnAfterNavigation(Self);
end;

procedure TmrConfigFch.DoBeforeCancelChanges;
begin
  if Assigned(OnBeforeCancelChanges) then
    OnBeforeCancelChanges(Self);
end;

procedure TmrConfigFch.DoBeforeAppend;
begin
  if Assigned(OnBeforeAppend) then
    OnBeforeAppend(Self);
end;

function TmrConfigFch.DoBeforeApplyChanges: Boolean;
begin
  Result := True;
  if Assigned(OnBeforeApplyChanges) then
    OnBeforeApplyChanges(Self, Result);
end;

procedure TmrConfigFch.DoAfterStart;
begin
  if Assigned(OnAfterStart) then
    OnAfterStart(Self);
end;

procedure TmrConfigFch.DoActiveTab(var TabIndex: Integer);
begin
  if Assigned(FOnSetActiveTab) then
    OnSetActiveTab(Self, TabIndex);
end;

end.
