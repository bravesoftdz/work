unit uPrintInvoice;

// QuickReport simple list 
// - Connect a datasource to the QuickReport component
// - Put QRDBText components on the Detail band

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Quickrep, StdCtrls, ExtCtrls, DB, DBTables;

type
  TQRListForm = class(TForm)
    QuickReport: TQuickReport;
    Title: TQRBand;
    PageHeader: TQRBand;
    Detail: TQRBand;
    PageFooter: TQRBand;
    Query1: TQuery;
    Query1IDStore: TIntegerField;
    Query1Name: TStringField;
    DataSource1: TDataSource;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape1: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRDetailLink1: TQRDetailLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QRListForm: TQRListForm;

implementation

{$R *.DFM}

end.
