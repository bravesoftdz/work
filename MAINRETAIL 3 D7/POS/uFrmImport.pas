unit uFrmImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, ComCtrls, ExtCtrls, StdCtrls;

type
  TFrmImport = class(TFrmParentAll)
    pb: TProgressBar;
    ImportTimer: TTimer;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ImportTimerTimer(Sender: TObject);
  private
    procedure ImportPOS;
    procedure IncPB;
  public
    function UpdatePOS: Boolean;
  end;

implementation

uses uDM, uDMPDV, uFilePersistence;

{$R *.dfm}

{ TFrmImport }

procedure TFrmImport.ImportPOS;
begin

  pb.Max := 18;
  pb.Position := 0;

  try
    DM.PrepareCDS(DM.cdsBanco, 'Fin_Banco', 'Banco', True);
    IncPB;
    DM.PrepareCDS(DM.cdsMedia, 'Media', 'Media', True);
    IncPB;
    DM.PrepareCDS(DM.cdsCashRegister, 'CashRegister', 'Name', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsOtherCommission, 'OtherCommission', 'Pessoa', False);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsModel, 'Model', 'Model', False);
    IncPB;
    DMPDV.cdsMDescription.Data := DMPDV.cdsModel.Data;
    SetCDSIndex(DMPDV.cdsMDescription, 'Description');
    IncPB;
    DM.PrepareCDS(DMPDV.cdsSystemUser, 'SystemUser', 'SystemUser', False);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsCustomer, 'Customer', 'Pessoa', False);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsModelAccessory, 'ModelAccessory', 'Model', False);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsBarcodeSearch, 'Barcode', 'IDBarcode');
    IncPB;
    DMPDV.cdsBarcode.Data := DMPDV.cdsBarcodeSearch.Data;
    IncPB;
    DM.PrepareCDS(DMPDV.cdsDiscRange, 'DiscRange', 'TotVendaMin', True);
    IncPB;
    DM.PrepareCDS(DM.cdsKitModel, 'KitModel', 'IDModel', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsInvDepartment, 'InvDepartment', 'IDDepartment', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsInvModelDepartment, 'InvModelDepartment', 'Department', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsInvSerial, 'InventorySerial', 'Serial', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsStoreTablePrice, 'InvStoreTablePrice', 'IDModel', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsModelTablePrice, 'InvModelTablePrice', 'IDModel', True);
    IncPB;
    DM.PrepareCDS(DM.cdsCashRegLogReason, 'CashRegLogReason', 'IDCashRegLogReason', True);
    IncPB;
    DM.PrepareCDS(DMPDV.cdsMeioPagMinSale, 'MeioPagMinSale', 'IDMeioPag;DifDay', True);
    IncPB;
  finally;
    pb.Position := 0;
  end;
end;

procedure TFrmImport.IncPB;
begin
  pb.Position := pb.Position + 1;
  Application.ProcessMessages;
end;


function TFrmImport.UpdatePOS: Boolean;
begin
  ShowModal;
end;

procedure TFrmImport.FormShow(Sender: TObject);
begin
  inherited;
  Sleep(0);
  ImportTimer.Enabled := True;
end;

procedure TFrmImport.ImportTimerTimer(Sender: TObject);
begin
  inherited;
  ImportTimer.Enabled := False;
  DM.CopyServerFiles;
  ImportPOS;
  DM.fPOSImportFiles.LastImportDate := DM.GetServerTXTDate;
  Close;
end;

end.
