unit uRepMonthFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, StdCtrls, siComp;

type
  TRepMonthFilter = class(TRepParentFilter)
    cbxMonth: TcxComboBox;
    procedure FormCreate(Sender: TObject);
  private
    procedure SetMonth(IDLanguage : Integer);
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

uses DateUtils, uDMReport, uDateTimeFunctions;

{$R *.dfm}

function TRepMonthFilter.GetFilterString: String;
begin
  if Trim(cbxMonth.Text) <> '' then
     Result := lblFilter.Caption + ' ' + cbxMonth.Text+'; ';
end;

procedure TRepMonthFilter.SetMonth(IDLanguage: Integer);
var
  i : Integer;
begin
   for i := 0 to cbxMonth.Properties.Items.Count-1 do
    case IDLanguage of
      L_ENGLISH         : cbxMonth.Properties.Items[i] := AEnglishLongMonth[i+1];
      L_PORTUGUESE      : cbxMonth.Properties.Items[i] := APortuguesLongMonth[i+1];
      L_SPANISH         : cbxMonth.Properties.Items[i] := AEspanholLongMonth[i+1];
    end;
end;

function TRepMonthFilter.GetValue: Variant;
begin
  Result := cbxMonth.ItemIndex+1;
end;

procedure TRepMonthFilter.FormCreate(Sender: TObject);
begin
  inherited;
  SetMonth(DMReport.LanguageDispatcher.ActiveLanguage);
  cbxMonth.ItemIndex := MonthOf(Now)-1;
end;

initialization
  RegisterClass(TRepMonthFilter)

end.
