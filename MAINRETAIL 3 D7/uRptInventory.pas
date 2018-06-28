unit uRptInventory;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TRptInventory = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData2: TQRSysData;
    QRShape2: TQRShape;
    lblPage: TQRLabel;
    QRShape3: TQRShape;
    QRSysData1: TQRSysData;
    lblFiltro: TQRLabel;
    lblTime: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    lblUsuario: TQRLabel;
    DetailBand1: TQRBand;
    Query1: TQuery;
    Query1Model: TStringField;
    Query1Description: TStringField;
    Query1QtyOnHand: TIntegerField;
    Query1QtyOnOrder: TIntegerField;
    Query1SellingPrice: TFloatField;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    ColumnHeaderBand1: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRDBText6: TQRDBText;
    Query1AverageCost: TFloatField;
    procedure RptParentInBeforePrint(Sender: TQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;

implementation


{$R *.DFM}


procedure TRptInventory.RptParentInBeforePrint(Sender: TQuickRep;
  var PrintReport: Boolean);
begin
  // Seta o Usuario
//  lblusuario.Caption := DM.fUser.UserName;
end;













end.
