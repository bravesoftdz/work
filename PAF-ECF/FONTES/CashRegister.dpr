program CashRegister;

uses
  Windows,
  Forms,
  MidasLib,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uDMParent in '..\..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  uDM in 'uDM.pas' {DM: TDataModule},
  PaiCashRegOpen in '..\FrmParentsCashReg\PaiCashRegOpen.pas' {FrmPaiCashRegOpen},
  ufrmServerInfo in '..\..\RepositoryD7\ufrmServerInfo.pas' {FrmServerInfo},
  uCashRegOpen in 'uCashRegOpen.pas' {CashRegOpen},
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uItemsCalc in 'uItemsCalc.pas' {FrmItemsCalc},
  uPrintCashReg in 'uPrintCashReg.pas' {PrintCashReg},
  uPassword in 'uPassword.pas' {Password},
  PaiCashRegClose in '..\FrmParentsCashReg\PaiCashRegClose.pas' {FrmPaiCashRegClose},
  uCashRegEnvelop in 'uCashRegEnvelop.pas' {CashRegEnvelop},
  uCashRegClose in 'uCashRegClose.pas' {CashRegClose},
  PaiCashRegWidraw in '..\FrmParentsCashReg\PaiCashRegWidraw.pas' {FrmPaiCashRegWidraw},
  uCashRegWidraw in 'uCashRegWidraw.pas' {CashRegWidraw},
  PaiCashRegPetty in '..\FrmParentsCashReg\PaiCashRegPetty.pas' {FrmPaiCashRegPetty},
  uCashRegPetty in 'uCashRegPetty.pas' {CashRegPetty},
  uCashRegManager in 'uCashRegManager.pas' {CashRegManager},
  uMsgBox in '..\..\RepositoryD7\uMsgBox.pas' {FrmMsgBox},
  uPai in '..\FrmParentsCashReg\uPai.pas' {FrmPai},
  PaiDeFichas in '..\FrmParentsCashReg\PaiDeFichas.pas' {FrmPaiDeFch},
  PaidePrinter in '..\FrmParentsCashReg\PaidePrinter.pas' {FrmParentPrint},
  uPrintReceipt in 'uPrintReceipt.pas' {PrintReceipt},
  uFchParam in 'uFchParam.pas' {FchParameter},
  uCashRegConfig in 'uCashRegConfig.pas' {FrmCashRegConfig},
  uFrmPOSFunctions in 'uFrmPOSFunctions.pas' {FrmPOSFunctions},
  uMsgConstant in '..\..\RepositoryD7\uMsgConstant.pas' {FrmMsgConstant},
  uParentAll in '..\FrmParentsCashReg\uParentAll.pas' {FrmParentAll},
  uQueryInventory in 'uQueryInventory.pas' {QueryInventory},
  uFrmModelImage in 'uFrmModelImage.pas' {SubModelImage},
  uFisPersistence in 'uFisPersistence.pas',
  uFrmPOSSQL in 'uFrmPOSSQL.pas' {FrmPOSSQL},
  uFrmTEFDialConfig in 'uFrmTEFDialConfig.pas' {frmTEFDialConfig},
  uFrmTaxPaymentConfig in 'uFrmTaxPaymentConfig.pas' {FrmTaxPaymentConfig},
  uMRPDV in 'uMRPDV.pas' {FrmMRPDV},
  PaiCashRegManager in '..\FrmParentsCashReg\PaiCashRegManager.pas' {FrmPaiCashRegManager},
  uMRPDVConfigKey in 'uMRPDVConfigKey.pas' {FrmMRDPVConfigKey},
  uDMPDV in 'uDMPDV.pas' {DMPDV: TDataModule},
  uFrmPDVPayments in 'uFrmPDVPayments.pas' {FrmPDVPayments},
  uFrmSearchFor in 'uFrmSearchFor.pas' {FrmSearchFor},
  uFrmSearchOption in 'uFrmSearchOption.pas' {FrmSearchOption},
  uFrmMsgTEF in 'uFrmMsgTEF.pas' {FrmMsgTEF},
  uFrmEnterPayments in 'uFrmEnterPayments.pas' {FrmEnterPayments},
  uFrmNewCustomer in 'uFrmNewCustomer.pas' {FrmNewCustomer},
  uFilePersistence in '..\..\libD7\uFilePersistence.pas',
  UFrmAskPrice in 'UFrmAskPrice.pas' {FrmAskPrice},
  uFrmImport in 'uFrmImport.pas' {FrmImport},
  uFrmInvoiceObs in 'uFrmInvoiceObs.pas' {FrmInvoiceObs},
  uFrmImportPreSale in 'uFrmImportPreSale.pas' {FrmImportPreSale},
  uTXTCashInfo in 'uTXTCashInfo.pas',
  uFrmAskSalesPerson in 'uFrmAskSalesPerson.pas' {FrmAskSalesPerson},
  uFrmPDVLog in 'uFrmPDVLog.pas' {FrmPDVLog},
  uFrmAskDepartment in 'uFrmAskDepartment.pas' {FrmAskDepartment},
  uMRTraceControl in '..\..\RepositoryD7\uMRTraceControl.pas',
  uTransferFile in 'uTransferFile.pas',
  uExecuteFileTransfer in 'uExecuteFileTransfer.pas',
  uTEFConsts in '..\..\RepositoryD7\uTEFConsts.pas',
  uFrmImput in 'uFrmImput.pas' {FrmImput},
  uFrmOption in 'uFrmOption.pas' {FrmOption},
  uTEFTypes in '..\..\RepositoryD7\uTEFTypes.pas',
  uTefDedicadoInterface in '..\..\LibD7\uTefDedicadoInterface.pas',
  uFrmMsgScroll in 'uFrmMsgScroll.pas' {FrmMsgScroll},
  uFrmTEFOptions in 'uFrmTEFOptions.pas' {FrmTEFOptions},
  uFrmTEFCheque in 'uFrmTEFCheque.pas' {FrmTEFCheque},
  uFrmAskDocument in 'uFrmAskDocument.pas' {FrmAskDocument},
  uBalanca in '..\..\LibD7\uBalanca.pas',
  uFrmScaleInfo in 'uFrmScaleInfo.pas' {FrmScaleInfo},
  uFrmMemoriaFiscal in 'uFrmMemoriaFiscal.pas' {FrmMemoriaFiscal},
  uFrmSintegra in 'uFrmSintegra.pas' {FrmSintegra},
  uFrmWait in 'uFrmWait.pas' {FrmWait},
  uFrmMenufiscal in 'uFrmMenufiscal.pas' {FrmMenufiscal};

{$R *.res}
var
  AMutex: Cardinal;
  hJanela: THandle;
begin
  AMutex := CreateMutex(nil, True, PChar('MRPDV'));
  if (AMutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
    begin
      hJanela := FindWindow('TFrmMain', nil);
      if hJanela > 0 then
        SetForegroundWindow(hJanela);
    end
  else
    begin
      Application.Initialize;
      Application.Title := 'Main Retail - Cash Register';
      Application.HelpFile := 'C:\work\output\HelpFile.hlp';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TPassword, Password);
  Application.CreateForm(TFrmMsgBox, FrmMsgBox);
  Application.CreateForm(TDMPDV, DMPDV);
  Application.Run;
    end;
end.
