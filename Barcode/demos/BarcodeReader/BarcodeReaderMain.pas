unit BarcodeReaderMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EanRead, StdCtrls, ExtCtrls, EanKod, EanSpecs;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Ean: TEan;
    Barcodes: TMemo;
    E_PORT: TRadioGroup;
    E_SPEED: TRadioGroup;
    E_PARITY: TRadioGroup;
    E_DATABITS: TRadioGroup;
    E_STOPBITS: TRadioGroup;
    E_TIMEOUT: TEdit;
    E_REMOVECR: TCheckBox;
    E_REMOVELF: TCheckBox;
    BarcodeReader: TBarcodeReader;
    CB_TYPE: TComboBox;
    procedure BarcodeReaderBarcodeReady(Sender: TObject; Barcode: String);
    procedure FormCreate(Sender: TObject);
    procedure E_REMOVECRClick(Sender: TObject);
    procedure E_REMOVELFClick(Sender: TObject);
    procedure E_TIMEOUTChange(Sender: TObject);
    procedure E_PORTClick(Sender: TObject);
    procedure E_SPEEDClick(Sender: TObject);
    procedure E_PARITYClick(Sender: TObject);
    procedure E_DATABITSClick(Sender: TObject);
    procedure E_STOPBITSClick(Sender: TObject);
    procedure CB_TYPEChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}


procedure TForm2.BarcodeReaderBarcodeReady(Sender: TObject;
  Barcode: String);
begin
        Barcodes.Lines.Add(Barcode);
        Ean.Barcode := Barcode;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
        BarcodeReader.Active := True;
        E_TIMEOUT.Text := IntToStr(BarcodeReader.Timeout);
        E_PORT.ItemIndex   := Integer(BarcodeReader.Port);
        E_PARITY.ItemIndex := Integer(BarcodeReader.Parity);
        E_SPEED.ItemIndex  := Integer(BarcodeReader.BitRate);
        E_DATABITS.ItemIndex := Integer(BarcodeReader.DataBits);
        E_STOPBITS.ItemIndex := Integer(BarcodeReader.StopBits);
        E_REMOVECR.Checked   := boRemoveCR in BarcodeReader.Options;
        E_REMOVELF.Checked   := boRemoveLF in BarcodeReader.Options;

        Ean.AddTypesToList(CB_TYPE.Items, btSymbol);
        CB_TYPE.ItemIndex    := Integer(bcEan13);
end;

procedure TForm2.E_REMOVECRClick(Sender: TObject);
begin
        if E_REMOVECR.Checked then
                BarcodeReader.Options := BarcodeReader.Options + [boRemoveCR]
        else
                BarcodeReader.Options := BarcodeReader.Options - [boRemoveCR];
end;

procedure TForm2.E_REMOVELFClick(Sender: TObject);
begin
        if E_REMOVELF.Checked then
                BarcodeReader.Options := BarcodeReader.Options + [boRemoveLF]
        else
                BarcodeReader.Options := BarcodeReader.Options - [boRemoveLF];
end;

procedure TForm2.E_TIMEOUTChange(Sender: TObject);
begin
        BarcodeReader.TimeOut := StrToIntDef(E_TIMEOUT.Text, 100);
        BarcodeReader.ReConnect;
end;

procedure TForm2.E_PORTClick(Sender: TObject);
begin
        BarcodeReader.Port := TpsComPort(E_PORT.ItemIndex);
        BarcodeReader.ReConnect;
end;

procedure TForm2.E_SPEEDClick(Sender: TObject);
begin
        BarcodeReader.BitRate := TpsComBitRate(E_SPEED.ItemIndex);
        BarcodeReader.ReConnect;
end;

procedure TForm2.E_PARITYClick(Sender: TObject);
begin
        BarcodeReader.Parity := TpsComParity(E_PARITY.ItemIndex);
        BarcodeReader.ReConnect;
end;

procedure TForm2.E_DATABITSClick(Sender: TObject);
begin
        BarcodeReader.DataBits := TpsComdataBits(E_DATABITS.ItemIndex);
        BarcodeReader.ReConnect;
end;

procedure TForm2.E_STOPBITSClick(Sender: TObject);
begin
        BarcodeReader.StopBits := TpsComStopBits(E_STOPBITS.ItemIndex);
        BarcodeReader.ReConnect;
end;

procedure TForm2.CB_TYPEChange(Sender: TObject);
begin
     Ean.TypBarCode := TTypBarcode(CB_TYPE.ItemIndex);
end;

end.
