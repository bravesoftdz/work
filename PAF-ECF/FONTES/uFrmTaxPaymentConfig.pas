unit uFrmTaxPaymentConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, ComCtrls, DB, Grids, DBGrids,
  ADODB, StdCtrls, ExtCtrls, uNumericFunctions, DBClient, Provider, Buttons;

type
  TFrmTaxPaymentConfig = class(TFrmParentAll)
    PageControl1: TPageControl;
    tsTax: TTabSheet;
    tsPayment: TTabSheet;
    quTaxCategory: TADOQuery;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    dsTaxCategoryMem: TDataSource;
    Panel1: TPanel;
    btCancel: TButton;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    quMeioPag: TADOQuery;
    dsMeioPagMem: TDataSource;
    cdsTaxCategoryMem: TClientDataSet;
    cdsTaxCategoryMemIDTaxCategory: TIntegerField;
    cdsTaxCategoryMemTaxCategory: TStringField;
    cdsTaxCategoryMemTax: TBCDField;
    cdsTaxCategoryMemECFTaxIndex: TStringField;
    cdsMeioPagMem: TClientDataSet;
    cdsMeioPagMemIDMeioPag: TIntegerField;
    cdsMeioPagMemMeioPag: TStringField;
    cdsMeioPagMemCodFiscal: TStringField;
    cdsMeioPagMemCodVinc: TStringField;
    dspTaxCategory: TDataSetProvider;
    cdsTaxCategory: TClientDataSet;
    cdsTaxCategoryIDTaxCategory: TIntegerField;
    cdsTaxCategoryTaxCategory: TStringField;
    cdsTaxCategoryTax: TBCDField;
    dspMeioPag: TDataSetProvider;
    cdsMeioPag: TClientDataSet;
    cdsMeioPagIDMeioPag: TIntegerField;
    cdsMeioPagMeioPag: TStringField;
    cdsMeioPagMemBandeira: TIntegerField;
    lbTEFDedInfo: TLabel;
    cdsMeioPagMemTipoTEF: TIntegerField;
    spHelp: TSpeedButton;
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsTaxCategoryMemECFTaxIndexSetText(Sender: TField;
      const Text: String);
    procedure cdsMeioPagMemCodFiscalSetText(Sender: TField;
      const Text: String);
    procedure cdsMeioPagMemCodVincSetText(Sender: TField; const Text: String);
    procedure cdsMeioPagMemBandeiraSetText(Sender: TField;
      const Text: String);
    procedure cdsMeioPagMemTipoTEFSetText(Sender: TField;
      const Text: String);
    procedure spHelpClick(Sender: TObject);
  private
    procedure FillTax;
    procedure EnableEditing(AEnabled: Boolean);
    procedure FillPag;
    procedure EnableAllFields(Dataset: TDataSet; AEnable: Boolean);
  public
    procedure Start(Tab: Byte);
  end;

implementation
uses uDM, uDMPDV, uTEFConsts;
{$R *.dfm}

procedure TFrmTaxPaymentConfig.Start(Tab: Byte);
begin
  tsTax.TabVisible     := False;
  tsPayment.TabVisible := False;
  case Tab of
    0: begin
         tsTax.TabVisible     := True;
         FillTax;
       end;
    1: begin
         tsPayment.TabVisible := True;
         FillPag;
       end;
  end;

  lbTEFDedInfo.Visible := (DM.fCashRegister.UseTef = TEF_DEDICADO);
  DBGrid2.Columns[4].Visible := lbTEFDedInfo.Visible;
  DBGrid2.Columns[5].Visible := (DM.fCashRegister.UseTef = TEF_DIAL);
  ShowModal;
end;

procedure TFrmTaxPaymentConfig.FillTax;
begin
  EnableAllFields(cdsTaxCategory, True);
  DM.PrepareCDS(cdsTaxCategory, 'TaxCategory', 'TaxCategory', True);
  try
    if cdsTaxCategoryMem.Active then
      cdsTaxCategoryMem.Close;

    cdsTaxCategoryMem.CreateDataSet;

    EnableAllFields(cdsTaxCategory, False);
    EnableEditing(True);

    cdsTaxCategory.First;
    while not cdsTaxCategory.Eof do
    begin
      cdsTaxCategoryMem.Append;
      cdsTaxCategoryMemIDTaxCategory.Value := cdsTaxCategoryIDTaxCategory.Value;
      cdsTaxCategoryMemTaxCategory.Value   := cdsTaxCategoryTaxCategory.Value;
      cdsTaxCategoryMemTax.Value           := cdsTaxCategoryTax.Value;
      cdsTaxCategoryMemECFTaxIndex.Value   := DMPDV.GetECFTaxIndex(cdsTaxCategoryIDTaxCategory.Value);
      cdsTaxCategoryMem.Post;
      cdsTaxCategory.Next;
    end;
  finally
    cdsTaxCategory.Close;
    EnableEditing(False);
  end;
end;

procedure TFrmTaxPaymentConfig.FillPag;
begin
  EnableAllFields(cdsMeioPag, True);
  DM.PrepareCDS(cdsMeioPag, 'MeioPag', 'MeioPag', True);
  try
    if cdsMeioPagMem.Active then
      cdsMeioPagMem.Close;

    cdsMeioPagMem.CreateDataSet;
    
    EnableAllFields(cdsMeioPag, False);
    EnableEditing(True);

    cdsMeioPag.First;
    while not cdsMeioPag.Eof do
    begin
      cdsMeioPagMem.Append;
      cdsMeioPagMemIDMeioPag.Value := cdsMeioPagIDMeioPag.Value;
      cdsMeioPagMemMeioPag.Value   := cdsMeioPagMeioPag.Value;
      cdsMeioPagMemCodFiscal.Value := DMPDV.GetCodFiscal(cdsMeioPagIDMeioPag.Value);
      cdsMeioPagMemCodVinc.Value   := DMPDV.GetECFVinIndex(cdsMeioPagIDMeioPag.Value);
      cdsMeioPagMemBandeira.Value  := DMPDV.GetBandeira(cdsMeioPagIDMeioPag.Value);
      cdsMeioPagMemTipoTEF.Value   := DMPDV.GetTipoTEF(cdsMeioPagIDMeioPag.Value);
      cdsMeioPagMem.Post;

      cdsMeioPag.Next;
    end;
  finally
    cdsMeioPag.Close;
    EnableEditing(False);
  end;
end;

procedure TFrmTaxPaymentConfig.EnableEditing(AEnabled: Boolean);
begin
  cdsTaxCategoryMemIDTaxCategory.ReadOnly := not AEnabled;
  cdsTaxCategoryMemTaxCategory.ReadOnly   := not AEnabled;
  cdsTaxCategoryMemTax.ReadOnly           := not AEnabled;
  cdsMeioPagMemIDMeioPag.ReadOnly         := not AEnabled;
  cdsMeioPagMemMeioPag.ReadOnly           := not AEnabled;
end;

procedure TFrmTaxPaymentConfig.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmTaxPaymentConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsMeioPag.Close;
  cdsMeioPagMem.Close;
  cdsTaxCategory.Close;
  cdsTaxCategoryMem.Close;

  DMPDV.LoadECFPagList;
  DMPDV.LoadECFTaxList;
  DMPDV.LoadECFVinList;
end;

procedure TFrmTaxPaymentConfig.cdsTaxCategoryMemECFTaxIndexSetText(
  Sender: TField; const Text: String);
begin
  inherited;
  Sender.AsString := Text;
  DMPDV.SetECFTaxIndex(cdsTaxCategoryMemIDTaxCategory.Value, Sender.AsString);
end;

procedure TFrmTaxPaymentConfig.cdsMeioPagMemCodFiscalSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  Sender.AsString := Text;
  DMPDV.SetECFCodFiscal(cdsMeioPagMemIDMeioPag.AsInteger, Sender.AsString);
end;

procedure TFrmTaxPaymentConfig.cdsMeioPagMemCodVincSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  Sender.AsString := Text;
  DMPDV.SetECFVinIndex(cdsMeioPagMemIDMeioPag.AsInteger, Sender.AsString);
end;

procedure TFrmTaxPaymentConfig.EnableAllFields(Dataset: TDataSet; AEnable: Boolean);
var
  I: Integer;
begin
  for I := 0 to Dataset.FieldCount - 1 do
    Dataset.Fields[I].ReadOnly := not AEnable;
end;

procedure TFrmTaxPaymentConfig.cdsMeioPagMemBandeiraSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text = '' then
    Sender.Clear
  else
    Sender.AsString := Text;
  DMPDV.SetECFBandeira(cdsMeioPagMemIDMeioPag.AsInteger, StrToIntDef(Sender.AsString, 0));
end;

procedure TFrmTaxPaymentConfig.cdsMeioPagMemTipoTEFSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text = '' then
    Sender.Clear
  else
    Sender.AsString := Text;
  DMPDV.SetECFTipoTEF(cdsMeioPagMemIDMeioPag.AsInteger, StrToIntDef(Sender.AsString, 0));
end;

procedure TFrmTaxPaymentConfig.spHelpClick(Sender: TObject);
begin
  inherited;
  case PageControl1.ActivePageIndex of
    0: Application.HelpContext(310);
    1: Application.HelpContext(320);
  end;
end;

end.
