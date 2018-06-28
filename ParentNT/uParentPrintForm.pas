unit uParentPrintForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, XiButton, ExtCtrls, ppComm, ppRelatv, ppProd,
  ppClass, ppReport, ppEndUsr, StdCtrls, DBClient, PsRBExport_MasterControl;

type
  TParentPrintForm = class(TParentForm)
    pnlBottom: TPanel;
    btnOk: TXiButton;
    ppReport: TppReport;
    ppDesigner: TppDesigner;
    lblPrint: TLabel;
    RBExportrControl: TPsRBExportMasterControl;
    procedure btnOkClick(Sender: TObject);
  private
    FPreview : Boolean;
    FDefaultPrinter : String;
    FRemoteServer: TCustomRemoteServer;
    procedure SetRemoteServer(const Value: TCustomRemoteServer);
  protected
    FParam : TObject;
    FDesignMode : Boolean;
    procedure ShowDesignReport;
    procedure OnBeforePrint; virtual;
    procedure ConfirmFrm; virtual; abstract;
  public
    property Preview : Boolean read FPreview write FPreview;
    property DefaultPrinter : string read FDefaultPrinter write FDefaultPrinter;
    property RemoteServer: TCustomRemoteServer read FRemoteServer write SetRemoteServer;

    function PrintReport(AParam : TObject; ShowForm: Boolean = True) : Boolean; virtual;
    function DesignReport(AParam : TObject = nil) : Boolean; virtual;
  end;

implementation

uses ppTypes;

{$R *.dfm}

{ TParentPrintForm }

function TParentPrintForm.PrintReport(AParam : TObject; ShowForm: Boolean = True): Boolean;
begin
  FDesignMode := False;
  FParam := AParam;
  OnBeforePrint;
  try
    ppReport.Print;
  except
    raise;
    end;

  if ShowForm then
  begin
    ShowModal;
    Result := (ModalResult = mrOK);
  end
  else
    Result := true;
end;

(*
function TParentPrintForm.PrintReport(AParam : String; ShowForm: Boolean = True): Boolean;
begin
  FDesignMode := False;
  FParam := AParam;
  OnBeforePrint;
  try
    ppReport.Print;
  except
    raise;
    end;

  if ShowForm then
  begin
    ShowModal;
    Result := (ModalResult = mrOK);
  end
  else
    Result := true;
end;
*)

procedure TParentPrintForm.btnOkClick(Sender: TObject);
begin
  inherited;
  ConfirmFrm;
end;

function TParentPrintForm.DesignReport(AParam : TObject = nil): Boolean;
begin
  FParam := AParam;
  FDesignMode := True;
  Result := True;
  try
    ShowDesignReport;
  except
    Result := False;
  end;
end;

procedure TParentPrintForm.OnBeforePrint;
begin
  ppReport.AllowPrintToArchive := True;
  ppReport.AllowPrintToFile    := True;

  if FDefaultPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := FDefaultPrinter;

  if FPreview then
    ppReport.DeviceType := dtScreen
  else
  begin
    ppReport.DeviceType      := dtPrinter;
    ppReport.ShowPrintDialog := False;
  end;
end;

procedure TParentPrintForm.SetRemoteServer(
  const Value: TCustomRemoteServer);
var
  i : Integer;
begin

  FRemoteServer := Value;

  for i := 0 to Self.ComponentCount-1 do
    if (Self.Components[i] is TClientDataSet) then
      TClientDataSet(Self.Components[i]).RemoteServer := FRemoteServer;

end;

procedure TParentPrintForm.ShowDesignReport;
begin
  ppDesigner.ShowModal;
end;

end.
