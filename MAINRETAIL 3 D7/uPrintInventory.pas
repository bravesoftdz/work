unit uPrintInventory;

// QuickReport simple list
// - Connect a datasource to the QuickReport component
// - Put QRDBText components on the Detail band

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, DBTables, quickrpt, Qrctrls;

type
  TInventoryReport = class(TForm)
    Report: TQuickRep;
    Title: TQRBand;
    PageHeader: TQRBand;
    Detail: TQRBand;
    PageNumber: TQRSysData;
    PageFooter: TQRBand;
    QRDateTime: TQRSysData;
    QRSysData1: TQRSysData;
    dsInventory: TDataSource;
    quInventory: TQuery;
    quInventoryIDModel: TIntegerField;
    quInventoryModel: TStringField;
    quInventoryDescription: TStringField;
    quInventoryCurrentCost: TFloatField;
    quInventorySellingPrice: TFloatField;
    quInventoryMarkUp: TFloatField;
    quInventoryVendorCost: TFloatField;
    quInventoryOtherCost: TFloatField;
    quInventoryWeight: TFloatField;
    quInventoryGroupName: TStringField;
    quInventoryQtyOnHold: TIntegerField;
    quInventoryQtyOnHand: TIntegerField;
    quInventoryQtyOnOrder: TIntegerField;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRLabel4: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel10: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
