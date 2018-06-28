unit uParentReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ADODB;

type
  TParentReport = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    ParentDetailBand: TQRBand;
    quReport: TADOQuery;
    lblNomeSistema: TQRLabel;
    Title: TQRLabel;
    QRLabel3: TQRLabel;
    PageFooterBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRSysData1: TQRSysData;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public

  end;


implementation

uses uDM;

{$R *.DFM}


procedure TParentReport.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  // Nunca se esqueca de colocar os itens da banda como transparent
  if Odd(TQuickRep(Self).CurrentY) then
     ParentDetailBand.Color := cl3DLight
  else
     ParentDetailBand.Color := clWhite;

end;

procedure TParentReport.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
lblNomeSistema.Caption := Application.Title;
end;

end.
