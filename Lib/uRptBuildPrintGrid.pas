unit uRptBuildPrintGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppCtrls, ppBands, ppPrnabl, ppClass, ppVar, ppCache, ppComm, ppRelatv,
  ppProd, ppReport, ppDB, ppDBPipe, ppViewr;

type
  TFrmRptBuildPrintGrid = class(TForm)
    RptGrid: TppReport;
    RtpHeader: TppHeaderBand;
    RepDetail: TppDetailBand;
    RepFooter: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    RtpTitle: TppTitleBand;
    ppLabel2: TppLabel;
    lbUser: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    DBPipeline: TppDBPipeline;
    RepSummary: TppSummaryBand;
    shpDetail: TppShape;
    lbTitle: TppLabel;
    procedure shpDetailPrint(Sender: TObject);
    procedure RptGridPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(Print:Boolean);
  end;

implementation

{$R *.DFM}

procedure TFrmRptBuildPrintGrid.Start(Print:Boolean);
begin

  if Print then
     begin

     //Print
     RptGrid.DeviceType := 'Printer';

     end
  else
     begin

     //Preview
     RptGrid.DeviceType := 'Screen';

     end;

  RptGrid.Print;

end;

procedure TFrmRptBuildPrintGrid.shpDetailPrint(Sender: TObject);
begin

  if Odd(RptGrid.DetailBand.Count) then
    shpDetail.Brush.Color := cl3DLight
  else
    shpDetail.Brush.Color := clWhite;

end;

procedure TFrmRptBuildPrintGrid.RptGridPreviewFormCreate(Sender: TObject);
begin
  RptGrid.PreviewForm.WindowState:= wsMaximized;
  TppViewer(RptGrid.PreviewForm.Viewer).ZoomSetting:= zsPageWidth;
end;

end.
