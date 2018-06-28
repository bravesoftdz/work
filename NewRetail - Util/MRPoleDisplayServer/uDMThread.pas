unit uDMThread;

interface

uses
  SysUtils, Classes, DB, DBClient, Forms;

const
  ADV_BITMAP = 0;
  ADV_JPG    = 1;
  ADV_VIDEO  = 2;
  ADV_FLASH  = 3;
  ADV_WEB    = 4;

  ADV_BITMAP_EXT = 'Bitmap|*.bmp';
  ADV_JPG_EXT    = 'JPG|*.jpg';
  ADV_VIDEO_EXT  = 'Video|*.mpg|all|*.*';
  ADV_FLASH_EXT  = 'Flash File|*.swf';
  ADV_WEB_EXT    = 'HTML|*.html|ASP|*.asp';

  SVR = 'Settings';
  SVR_IP = 'IP';
  SVR_PORT = 'Port';
  SVR_LANGUAGE = 'Language';

type
  TDMThread = class(TDataModule)
    cdsAdvertising: TClientDataSet;
    cdsAdvertisingDescription: TStringField;
    cdsAdvertisingFileName: TStringField;
    cdsAdvertisingStartDate: TDateTimeField;
    cdsAdvertisingEndDate: TDateTimeField;
    cdsAdvertisingDaysOfWeek: TStringField;
    cdsAdvertisingDaysOfWeekString: TStringField;
    cdsAdvertisingType: TIntegerField;
    cdsAdvertisingTypeString: TStringField;
    cdsAdvertisingDuration: TIntegerField;
    cdsAdvertisingVideoControl: TBooleanField;
    cdsAdvertisingDisplayDescription: TBooleanField;
    cdsAdvertisingHours: TStringField;
    cdsCrossSaleItem: TClientDataSet;
    cdsCrossSaleItemID: TIntegerField;
    cdsCrossSaleItemModelNum: TStringField;
    cdsCrossSaleItemModelCategory: TStringField;
    cdsCrossSaleItemModelSubCategory: TStringField;
    cdsCrossSaleItemModelGroup: TStringField;
    cdsCrossSaleItemFileName: TStringField;
    cdsCrossSaleItemFileType: TIntegerField;
    cdsCrossSaleItemDuration: TIntegerField;
    cdsCrossSaleItemCrossDescription: TStringField;
    cdsCrossSaleItemCrossSalePrice: TCurrencyField;
    cdsCrossSaleItemHistory: TClientDataSet;
    cdsCrossSaleItemHistoryModel: TStringField;
    cdsCrossSaleItemHistoryRegister: TStringField;
    cdsCrossSaleItemHistoryItemDate: TDateTimeField;
    cdsAdvertisingID: TIntegerField;
    procedure cdsAdvertisingCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FLocalPath: String;
    procedure LoadAdvertising;
    procedure LoadCrossSaleItem;
    procedure LoadCrossSaleItemHistory;
    procedure OpenAdvertising;
    procedure OpenCrossSaleItem;
    procedure OpenCrossSaleItemHistory;
    procedure CloseAdvertising;
    procedure CloseCrossSaleItem;
    procedure CloseCrossSaleItemHistory;

  public
    { Public declarations }
    procedure LoadAdvertiseStream(AStream: TStream);
    procedure LoadCrossSaleItemHistoryStream(AStream: TStream);
    procedure LoadCrossSaleItemStream(AStream: TStream);

  end;

var
  DMThread: TDMThread;

implementation

{$R *.dfm}

procedure TDMThread.cdsAdvertisingCalcFields(DataSet: TDataSet);
var
  FWeekDays : String;
begin
  FWeekDays := '';

  if Pos('1,', cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Monday; ';
  if Pos('2,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Tuesday; ';
  if Pos('3,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Wednesday; ';
  if Pos('4,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Thursday; ';
  if Pos('5,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Friday; ';
  if Pos('6,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Saturday; ';
  if Pos('7,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Sunday; ';
  cdsAdvertisingDaysOfWeekString.AsString := FWeekDays;


  case cdsAdvertisingType.AsInteger of
   ADV_BITMAP : cdsAdvertisingTypeString.AsString := 'Bitmap';
   ADV_JPG    : cdsAdvertisingTypeString.AsString := 'JPG';
   ADV_VIDEO  : cdsAdvertisingTypeString.AsString := 'Video';
   ADV_FLASH  : cdsAdvertisingTypeString.AsString := 'Flash';
   ADV_WEB    : cdsAdvertisingTypeString.AsString := 'Website';
  end;
end;

procedure TDMThread.DataModuleCreate(Sender: TObject);
begin
  FLocalPath := ExtractFilePath(Application.ExeName);
  (*
  OpenCrossSaleItem;
  OpenCrossSaleItemHistory;
  OpenAdvertising;
  LoadAdvertising;
  *)
end;

procedure TDMThread.DataModuleDestroy(Sender: TObject);
begin
  CloseAdvertising;
  CloseCrossSaleItem;
  CloseCrossSaleItemHistory;
end;

procedure TDMThread.OpenCrossSaleItem;
begin
  cdsCrossSaleItem.Close;
  LoadCrossSaleItem;
end;

procedure TDMThread.OpenCrossSaleItemHistory;
begin
  cdsCrossSaleItemHistory.Close;
  LoadCrossSaleItemHistory;
end;

procedure TDMThread.OpenAdvertising;
begin
  cdsAdvertising.Close;
  LoadAdvertising;
end;

procedure TDMThread.LoadCrossSaleItem;
begin
  if FileExists(FLocalPath + 'SVR_CrossSaleItem.xml') then
    cdsCrossSaleItem.LoadFromFile(FLocalPath + 'SVR_CrossSaleItem.xml');
end;

procedure TDMThread.LoadCrossSaleItemHistory;
begin
  if FileExists(FLocalPath + 'SVR_CrossSaleItemHistory.xml') then
    cdsCrossSaleItemHistory.LoadFromFile(FLocalPath + 'SVR_CrossSaleItemHistory.xml');
end;

procedure TDMThread.LoadAdvertising;
begin
  if FileExists(FLocalPath + 'SVR_Advertising.xml') then
    cdsAdvertising.LoadFromFile(FLocalPath + 'SVR_Advertising.xml');
end;

procedure TDMThread.CloseAdvertising;
begin
  cdsAdvertising.Close;
end;

procedure TDMThread.CloseCrossSaleItem;
begin
  cdsCrossSaleItem.Close;
end;

procedure TDMThread.CloseCrossSaleItemHistory;
begin
  cdsCrossSaleItemHistory.Close;
end;

procedure TDMThread.LoadCrossSaleItemStream(AStream: TStream);
begin
  AStream.Seek(0, soFromBeginning);
  CloseCrossSaleItem;
  OpenCrossSaleItem;
  cdsCrossSaleItem.SaveToStream(AStream, dfXMLUTF8);
end;

procedure TDMThread.LoadCrossSaleItemHistoryStream(AStream: TStream);
begin
  AStream.Seek(0, soFromBeginning);
  CloseCrossSaleItemHistory;
  OpenCrossSaleItemHistory;
  cdsCrossSaleItemHistory.SaveToStream(AStream, dfXMLUTF8);
end;

procedure TDMThread.LoadAdvertiseStream(AStream: TStream);
begin
  AStream.Seek(0, soFromBeginning);
  CloseAdvertising;
  OpenAdvertising;
  cdsAdvertising.SaveToStream(AStream, dfXMLUTF8);
end;





end.
