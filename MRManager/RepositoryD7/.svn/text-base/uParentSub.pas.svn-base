unit uParentSub;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  siComp, siLangRT;

type
  TOnDataChange = procedure of object;
  TOnSelectData = procedure (AParams: String) of object;
  TOnParamChange = procedure of object;
  TOnGetSQLEvent = function(): String of object;
  TOnGetFchParam = function(): String of object;
  TOnTestFillEvent = function(): boolean of object;

  TParentSub = class(TForm)
    siLang: TsiLangRT;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FOnSelectData: TOnSelectData;
  protected
    fLangLoaded : Boolean;
    FOnGetSQL: TOnGetSQLEvent;
    FParam: String;
    FButtonNewEnabled,
    FButtonOpenEnabled,
    FButtonRemoveEnabled: Boolean;
    FOnDataChange: TOnDataChange;
    FOnGetFchParam:  TOnGetFchParam;
    FOnTestFillEvent:  TOnTestFillEvent;
    FFilterFields : TStringList; { campos do filtro }
    FFilterValues : TStringList; { valores do filtro }
    procedure SetFilterFields(Value : TStringList);
    procedure SetFilterValues(Value : TStringList);
    procedure AfterSetParam; virtual;
    procedure SetLock(AReadOnly: boolean); virtual;
    procedure NotifyChanges(Changes: String); virtual;
  public
    procedure SetButtonNewEnabled(Value : boolean);
    procedure SetButtonOpenEnabled(Value : boolean);
    procedure SetButtonRemoveEnabled(Value : boolean);
    procedure SetLayoutProperties; virtual;
    procedure GetLayoutProperties; virtual;
    procedure SetParam(Value: String);
    function GetDatasetIsEmpty: boolean; virtual;
    function GetRecordCount: integer; virtual;
    function GetCurrentKey: integer; virtual;
    procedure DataSetOpen; virtual;
    procedure DataSetClose; virtual;
    procedure DataSetNew; virtual;
    procedure SubListRefresh; virtual;
    function GiveInfo(InfoString: String): String; virtual; abstract;
  published
    property Param               : String read FParam write SetParam;
    property OnGetSQL            : TOnGetSQLEvent read FOnGetSQL write FOnGetSQL;
    property OnDataChange        : TOnDataChange read FOnDataChange write FOnDataChange;
    property OnSelectData        : TOnSelectData read FOnSelectData write FOnSelectData;
    property OnGetFchParam       : TOnGetFchParam read FOnGetFchParam write FOnGetFchParam;
    property OnTestFillEvent     : TOnTestFillEvent read FOnTestFillEvent write FOnTestFillEvent;
    property FilterFields        : TStringList read FFilterFields write SetFilterFields;
    property FilterValues        : TStringList read FFilterValues write SetFilterValues;
  end;

implementation

uses uMsgBox, uMsgConstant, uDMGlobal, SubListPanel;

{$R *.DFM}

procedure TParentSub.DataSetOpen;
begin
  // Para ser sobrescrito
end;

procedure TParentSub.DataSetClose;
begin
  // Para ser sobrescrito
end;


procedure TParentSub.SetFilterFields(Value : TStringList);
begin
  FFilterFields := Value;
end;

procedure TParentSub.SetFilterValues(Value : TStringList);
begin
  FFilterValues := Value;
end;


procedure TParentSub.FormCreate(Sender: TObject);
begin
//  FFilterFields := TStringList.Create;
//  FFilterValues := TStringList.Create;
  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);
end;

procedure TParentSub.FormDestroy(Sender: TObject);
begin
//  FFilterFields.Free;
//  FFilterValues.Free;

end;

procedure TParentSub.SetLock(AReadOnly: boolean);
begin
  // para ser herdado
end;

procedure TParentSub.DataSetNew;
begin
  // Pare ser herdado
end;

function TParentSub.GetDatasetIsEmpty: boolean;
begin
 // Para ser herdado
 Result := False;
end;

function TParentSub.GetRecordCount: integer;
begin
 // Para ser escrino nos descendentes
 Result := -1;
end;

function TParentSub.GetCurrentKey: integer;
begin
 // Para ser escrino nos descendentes
 Result := -1;
end;

procedure TParentSub.SetButtonNewEnabled(Value: boolean);
begin
  if FButtonNewEnabled <> Value then
    FButtonNewEnabled := Value;
end;

procedure TParentSub.SetButtonOpenEnabled(Value: boolean);
begin
  if FButtonOpenEnabled <> Value then
    FButtonOpenEnabled := Value;

end;

procedure TParentSub.SetButtonRemoveEnabled(Value: boolean);
begin
  if FButtonRemoveEnabled <> Value then
    FButtonRemoveEnabled := Value;

end;

procedure TParentSub.SetParam(Value: String);
begin
  FParam := Value;
  AfterSetParam;
end;

procedure TParentSub.AfterSetParam;
begin
  // Para ser Herdado
end;

procedure TParentSub.SubListRefresh;
begin
  // Para ser herdado
end;

procedure TParentSub.FormShow(Sender: TObject);
begin

  //Load Translation
  if (not fLangLoaded) and (siLang.StorageFile <> '') and (DMGlobal.IDLanguage <> LANG_ENGLISH) then
      begin
      if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
         siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
         MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);

      fLangLoaded := True;
      end;

end;

procedure TParentSub.NotifyChanges(Changes: String);
begin
  if Parent is TSubListPanel then
    TSubListPanel(Parent).DoParamChanged(Changes);
end;

procedure TParentSub.SetLayoutProperties;
begin
  // para ser herdado
end;

procedure TParentSub.GetLayoutProperties;
begin
  // para ser herdado
end;

end.
