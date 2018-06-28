unit uFrmBarcodePrintSingle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, Provider, DB, ADODB, DBClient,
  ppDB, raCodMod, ppModule, daDataModule, ppBands, EanRB, EanRBDB, ppCtrls,
  ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe;

type
  TFrmBarcodePrintSingle = class(TForm)
    cdsBarcode: TClientDataSet;
    dsBarcode: TDataSource;
    ppDBPipeline: TppDBPipeline;
    ppReport: TppReport;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    RBDBEan: TRBDBEan;
    ppColumnFooterBand1: TppColumnFooterBand;
    raCodeModule1: TraCodeModule;
    dspBarcode: TDataSetProvider;
    quBarcode: TADODataSet;
    quBarcodemodel: TStringField;
    quBarcodedescription: TStringField;
    quBarcodeBarcode: TStringField;
    quBarcodePrice: TBCDField;
    quBarcodeSuggRetail: TBCDField;
    quBarcodeSizeName: TStringField;
    cdsBarcodemodel: TStringField;
    cdsBarcodedescription: TStringField;
    cdsBarcodeBarcode: TStringField;
    cdsBarcodePrice: TBCDField;
    cdsBarcodeSuggRetail: TBCDField;
    cdsBarcodeSizeName: TStringField;
    procedure ppReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    //amfsouza 05.04.2012 - passing suggestion retail parameter
    function AddBarcode(AModel, ABarcode, ADescription: String;
         NumCopies: Integer; ASellingPrice, sugg_retail: Currency) : Boolean;
    function PrintBarcodes : Boolean;
    function ClearBarcodes : Boolean;
    procedure SetReport(AReport, APrinter : String);
  end;

implementation

uses ppTypes;

{$R *.dfm}

{ TFrmBarcodePrintSingle }

function TFrmBarcodePrintSingle.AddBarcode(AModel, ABarcode,
  ADescription: String; NumCopies: Integer;
  ASellingPrice, sugg_retail: Currency): Boolean;
var
  i : Integer;
begin
  with cdsBarcode do
  begin
    if not Active then
      CreateDataSet;
    for i := 1 to NumCopies do
    begin
      Append;
      FieldByName('Model').Value        := AModel;
      FieldByName('Description').Value  := ADescription;
      FieldByName('Barcode').Value      := ABarcode;
      FieldByName('Price').Value := ASellingPrice;
      FieldByName('SuggRetail').Value   := sugg_retail;
      Post;
    end;
  end;
end;

function TFrmBarcodePrintSingle.ClearBarcodes: Boolean;
begin
  with cdsBarcode do
  if Active then
  begin
    First;
    while not EOF do
    begin
      Edit;
      Delete;
    end;
    Close;
  end;
end;

function TFrmBarcodePrintSingle.PrintBarcodes: Boolean;
begin

  ppReport.DeviceType       := dtPrinter;
  ppReport.ShowPrintDialog  := False;
  ppReport.ShowCancelDialog := False;
  ppReport.Print;

end;

procedure TFrmBarcodePrintSingle.SetReport(AReport, APrinter: String);
begin

  if (AReport <> '') and FileExists(AReport) then
  begin
    ppReport.Template.FileName := AReport;
    ppReport.Template.LoadFromFile;
  end;

  if APrinter <> '' then
    ppReport.PrinterSetup.PrinterName := APrinter;

end;

procedure TFrmBarcodePrintSingle.ppReportPreviewFormCreate(
  Sender: TObject);
begin
  inherited;
  ppReport.PreviewForm.WindowState := wsMaximized;
end;

end.
