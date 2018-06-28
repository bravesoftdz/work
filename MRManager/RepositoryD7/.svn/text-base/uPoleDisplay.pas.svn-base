unit uPoleDisplay;

interface

uses SysUtils;

function FormatStation(AStation, AIP : String; APort : Integer):String;
function FormatModelNum(AModel, ARegister : String) : String;
function BuildInput(Campo, Valor : String): String;
function FormatAdvertising(AID, ADescription, AFileName, AStartDate, AEndDate, ADaysOfWeek,
  AType, ADuration, AVideoControl, ADisplayDescription, AHours : String) : String;

implementation

uses uInvoicePollDisplayConst;

function FormatStation(AStation, AIP: String; APort: Integer): String;
begin
  Result := SVR_POLE_DISPLAY_CLIENT + ';' +
           BuildInput(SVR_POLE_DISPLAY_CLIENT_DESCRIPTION, AStation) +
           BuildInput(SVR_POLE_DISPLAY_CLIENT_IP, AIP) +
           BuildInput(SVR_POLE_DISPLAY_CLIENT_PORT, IntToStr(APort));
end;

function FormatModelNum(AModel, ARegister : String) : String;
begin
  Result := CROSS_SELL + ';' +
           BuildInput(CROSS_SELL_ITEM, AModel) +
           BuildInput(CROSS_SELL_REGISTER, ARegister);
end;

function FormatAdvertising(AID, ADescription, AFileName, AStartDate, AEndDate, ADaysOfWeek,
  AType, ADuration, AVideoControl, ADisplayDescription, AHours : String) : String;
begin

  Result := ADVERTISING + ';' +
            BuildInput(ADVERTISING_ID, AID) +
            BuildInput(ADVERTISING_DESCRIPTION, ADescription) +
            BuildInput(ADVERTISING_FILENAME, AFileName) +
            BuildInput(ADVERTISING_STARTDATE, AStartDate) +
            BuildInput(ADVERTISING_ENDDATE, AEndDate) +
            BuildInput(ADVERTISING_DAYS_OF_WEEK, ADaysOfWeek) +
            BuildInput(ADVERTISING_TYPE, AType) +
            BuildInput(ADVERTISING_DURATION, ADuration) +
            BuildInput(ADVERTISING_VIDEO_CONTROL, AVideoControl) +
            BuildInput(ADVERTISING_DISPLAY_DESC, ADisplayDescription) +
            BuildInput(ADVERTISING_HOUR, AHours);

end;


function BuildInput(Campo, Valor : String): String;
begin
  Result := Campo + '=' + Valor + ';';
end;


end.
