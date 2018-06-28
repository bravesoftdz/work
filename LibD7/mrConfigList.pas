unit mrConfigList;

interface

uses
  SysUtils, Classes, uSystemTypes;

type
  TmrCommandOption = (tcoInsert, tcoOpen, tcoDelete, tcoRestore, tcoClassification,
                    tcoPrint, tcoGroup, tcoColumn, tcoExport, tcoReport);
  TmrCommandOptions = set of TmrCommandOption;

  TmrConfigList = class(TComponent)
  private
    FAutoOpen: Boolean;
    FConnection: String;
    FProviderName: String;
    FAutCreateGridColumns: Boolean;
    FFchClassName: String;
    FLogicalDelete: Boolean;
    FCommandOptions: TmrCommandOptions;
    {Eventos}
    FOnLastRecord: TNotifyEvent;
    FOnGetParams: TOnGetParams;
    FOnGetProviderName: TOnGetProviderName;
    FOnBeforeStart: TNotifyEvent;
    FOnPriorRecord: TNotifyEvent;
    FOnGetFilterText: TOnGetFilterText;
    FOnSetGridColumns: TNotifyEvent;
    FOnAfterRefresh: TNotifyEvent;
    FOnGetTransaction: TOnGetTransaction;
    FOnCanNextRecord: TOnCanNavigate;
    FOnAfterStart: TNotifyEvent;
    FOnGetFilter: TOnGetFilter;
    FOnSelectChange: TOnSelectChange;
    FOnFirstRecord: TNotifyEvent;
    FOnTestFilter: TOnTestFilter;
    FOnNextRecord: TNotifyEvent;
    FOnGetTaskRequest: TOnGetTaskRequest;
    FOnCanPriorRecord: TOnCanNavigate;
    FOnBeforeDeleteRecord: TOnBeforeDeleteRecord;
    FOnCreateCommandControls: TNotifyEvent;
    FOnGetForeignKeyValue: TOnGetForeignKeyValue;
    FPreviewGridField: String;
  protected
    { Protected declarations }
  public
    function DoBeforeDeleteRecord: Boolean;
    property OnGetForeignKeyValue: TOnGetForeignKeyValue read FOnGetForeignKeyValue write FOnGetForeignKeyValue;
  published
    property AutoOpen: Boolean read FAutoOpen write FAutoOpen;
    property Connection: String read FConnection write FConnection;
    property ProviderName: String read FProviderName write FProviderName;
    property AutCreateGridColumns : Boolean read FAutCreateGridColumns write FAutCreateGridColumns;
    property FchClassName : String read FFchClassName write FFchClassName;
    property LogicalDelete : Boolean read FLogicalDelete write FLogicalDelete;
    property CommandOptions : TmrCommandOptions read FCommandOptions write FCommandOptions;
    property PreviewGridField : String read FPreviewGridField write FPreviewGridField;
    {Declaração eventos}
    property OnAfterRefresh : TNotifyEvent read FOnAfterRefresh write FOnAfterRefresh;
    property OnAfterStart : TNotifyEvent read FOnAfterStart write FOnAfterStart;
    property OnBeforeDeleteRecord : TOnBeforeDeleteRecord read FOnBeforeDeleteRecord write FOnBeforeDeleteRecord;
    property OnBeforeStart : TNotifyEvent read FOnBeforeStart write FOnBeforeStart;
    property OnCanNextRecord : TOnCanNavigate read FOnCanNextRecord write FOnCanNextRecord;
    property OnCanPriorRecord : TOnCanNavigate read FOnCanPriorRecord write FOnCanPriorRecord;
    property OnCreateCommandControls : TNotifyEvent read FOnCreateCommandControls write FOnCreateCommandControls;
    property OnFirstRecord : TNotifyEvent read FOnFirstRecord write FOnFirstRecord;
    property OnGetFilter : TOnGetFilter read FOnGetFilter write FOnGetFilter;
    property OnGetFilterText : TOnGetFilterText read FOnGetFilterText write FOnGetFilterText;
    property OnGetParams : TOnGetParams read FOnGetParams write FOnGetParams;
    property OnGetProviderName : TOnGetProviderName read FOnGetProviderName write FOnGetProviderName;
    property OnGetTaskRequest : TOnGetTaskRequest read FOnGetTaskRequest write FOnGetTaskRequest;
    property OnGetTransaction : TOnGetTransaction read FOnGetTransaction write FOnGetTransaction;
    property OnLastRecord : TNotifyEvent read FOnLastRecord write FOnLastRecord;
    property OnNextRecord : TNotifyEvent read FOnNextRecord write FOnNextRecord;
    property OnPriorRecord : TNotifyEvent read FOnPriorRecord write FOnPriorRecord;
    property OnSelectChange : TOnSelectChange read FOnSelectChange write FOnSelectChange;
    property OnSetGridColumns : TNotifyEvent read FOnSetGridColumns write FOnSetGridColumns;
    property OnTestFilter : TOnTestFilter read FOnTestFilter write FOnTestFilter;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MultiTierLib', [TmrConfigList]);
end;

{ TmrConfigList }

{ TmrConfigList }

function TmrConfigList.DoBeforeDeleteRecord: Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeDeleteRecord) then
    OnBeforeDeleteRecord(Self, Result);
end;

end.
