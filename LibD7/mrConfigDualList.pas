unit mrConfigDualList;

interface

uses
  SysUtils, Classes, uSystemTypes, uNTUpdateControl;

type
  TmrDualListButton = (tbbAdd, tbbAddAll,tbbRemove, tbbRemoveAll);
  TmrDualListButtons = set of TmrDualListButton;

  TmrConfigDualList = class(TComponent)
  private
    FConnectionListName : string;
    FConnectionSourceName : string;
    FProviderSourceName : string;
    FProviderListName : string;
    FDualListButtons : TmrDualListButtons;
    FOnAfterStart : TNotifyEvent;
    FOnBeforeGetRecords : TOnBeforegetRecords;
    FOnBeforeGetRecordSource : TOnBeforeGetRecords;
    FOnGetFilter : TOnGetFilter;
    FOnGetForeignKeyValue : TOnGetForeignKeyValue;
    FOnGetTransaction : TOnGetTransaction;
    FOnStateChange : TNotifyEvent;
    FOnTestAddItem : TOnTestAddItem;
    FOnTestRemoveItem : TOnTestRemoveItem;
  published
    property ConnectionListName : string read FConnectionListName write FConnectionListName;
    property ConnectionSourceName : string read FConnectionSourceName write FConnectionSourceName;
    property DualListButtons : TmrDualListButtons read FDualListButtons write FDualListButtons;
    property ProviderListName : string read FProviderListName write FProviderListName;
    property ProviderSourceName : string read FProviderSourceName write FProviderSourceName;
    property OnAfterStart : TNotifyEvent read FOnAfterStart write FOnAfterStart;
    property OnBeforegetRecordList : TOnBeforegetRecords read FOnBeforeGetRecords write FOnBeforeGetRecords;
    property OnBeforeGetRecordSource : TOnBeforeGetRecords read FOnBeforeGetRecordSource write FOnBeforeGetRecordSource;
    property OnGetFilter : TOnGetFilter read FOnGetFilter write FOnGetFilter;
    property OnGetForeingKeyValue : TOnGetForeignKeyValue read FOnGetForeignKeyValue write FOnGetForeignKeyValue;
    property OnGetTransaction : TOnGetTransaction read FOnGetTransaction write FOnGetTransaction;
    property OnStateChange : TNotifyEvent read FOnStateChange write FOnStateChange;
    property OnTestAddItem : TOnTestAddItem read FOnTestAddItem write FOnTestAddItem;
    property OnTestRemoveItem : TOnTestRemoveItem read FOnTestRemoveItem write FOnTestRemoveItem;
  end;

procedure Register;

implementation

{ TmrConfigDualList }

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrConfigDualList]);
end;

end.
