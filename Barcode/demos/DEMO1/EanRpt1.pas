unit EanRpt1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, EanQr, ExtCtrls;

type
  TRpt1 = class(TForm)
    QR1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QrEan6: TQrEan;
    QrEan3: TQrEan;
    QrEan4: TQrEan;
    QrEan5: TQrEan;
    QrEan7: TQrEan;
    QRShape4: TQRShape;
    QrEan1: TQrEan;
    QrEan9: TQrEan;
    QrEan10: TQrEan;
    QrEan2: TQrEan;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QrEan8: TQrEan;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rpt1: TRpt1;

implementation

{$R *.DFM}


end.
