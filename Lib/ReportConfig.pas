unit ReportConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uRptParentIn;

type
  TOnSelectReport = procedure (Sender : TObject; ReportIndex : integer) of object;
  TOnLoadReport   = procedure (Sender : TObject;
                                    ReportIndex : integer;
                                    var ActualReport : TRptParentIn) of object;
  TOnValidateParameter = function  (Sender : TObject) : Boolean of object;

  TReportConfig = class(TComponent)
  private
    { Private declarations }
    FOnValidateParameter : TOnValidateParameter;
    FOnLoadReport        : TOnLoadReport;
    FOnSelectReport      : TOnSelectReport;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property OnSelectReport      : TOnSelectReport read FOnSelectReport write FOnSelectReport;
    property OnLoadReport        : TOnLoadReport read FOnLoadReport write FOnLoadReport;
    property OnValidateParameter : TOnValidateParameter read FOnValidateParameter write FOnValidateParameter;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TReportConfig]);
end;

end.
