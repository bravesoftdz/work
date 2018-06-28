unit uBrwPromo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeBrowses, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxGridCustomPopupMenu, cxGridPopupMenu, dxPSCore,
  dxPScxGridLnk, ExtCtrls, BrowseConfig, ADODB, PowerADOQuery, siComp,
  siLangRT, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  PanelRights, StdCtrls, Buttons, LblEffct, DateBox, Mask, SuperComboADO;

type
  TbrwPromo = class(TbrwParent)
    Label3: TLabel;
    scStore: TSuperComboADO;
    Label2: TLabel;
    Button1: TButton;
    Button3: TButton;
    cbxPromoType: TComboBox;
    lblType: TLabel;
    cbxDayofWeek: TComboBox;
    Button2: TButton;
    grdBrowseDBDBColumn1: TcxGridDBColumn;
    grdBrowseDBDBColumn2: TcxGridDBColumn;
    grdBrowseDBDBColumn3: TcxGridDBColumn;
    grdBrowseDBDBColumn4: TcxGridDBColumn;
    grdBrowseDBDBColumn5: TcxGridDBColumn;
    grdBrowseDBDBColumn6: TcxGridDBColumn;
    grdBrowseDBDBColumn7: TcxGridDBColumn;
    grdBrowseDBDBColumn8: TcxGridDBColumn;
    statusPromo: TRadioGroup;
    grdBrowseDBDBColumn9: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure CommandClick(Sender: TObject);
  private
    sPercentual,
    sValue,
    sQty,
    sSale,
    sFrequentBuyer,
    sCoupon,
    sLoyalty,
    sTotal: String;
    sqlNoFilter: String;


    // discarded
    procedure addPromo();
    procedure editPromo();
    procedure removePromo();
    procedure preview();
    procedure exportTo();
    procedure grouping();
    procedure addRemoveColumns();
    procedure showFilters();
    // discarded
  public
    procedure start();
  end;

implementation

uses uFchPromo, uDM, uDateTimeFunctions, uDMGlobal, uSystemConst, PromoDAO;

{$R *.dfm}

procedure TbrwPromo.FormCreate(Sender: TObject);
begin

//  inherited;
  brwForm := TFchPromo.Create(self);

  //scStore.LookUpValue := intToStr(DM.fStore.ID);
  scStore.LookUpValue := '';
  scStore.Text        := '<'+Button3.Caption+'>';

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sPercentual    := 'Percent Off';
      sValue         := 'Value';
      sQty           := 'Qty';
      sSale          := 'Sale';
      sFrequentBuyer := 'FrequentBuyer';
      sCoupon        := 'Coupon';
      sLoyalty       := 'Loyalty';
      sTotal         := 'Sale Total';
    end;

    LANG_PORTUGUESE :
    begin
      sPercentual    := 'Percentagem';
      sValue         := 'Valor';
      sQty           := 'Qtd';
      sSale          := 'Venda';
      sFrequentBuyer := 'Freq. de Compra';
      sCoupon        := 'Cupom';
      sLoyalty       := 'Fidelização';
      sTotal         := 'Desc. na Venda';
    end;

    LANG_SPANISH :
    begin
      sPercentual    := 'Percentual';
      sValue         := 'Valor';
      sQty           := 'Qtd';
      sSale          := 'Venta';
      sFrequentBuyer := 'Compra Frecuente';
      sCoupon        := 'Cupón';
      sLoyalty       := 'Lealtad';
      sTotal         := 'Desc. na Venta';
    end;
  end;

  // Antonio 2014 Aug 25
  sqlNoFilter := quBrowse.CommandText;

end;

procedure TbrwPromo.Button2Click(Sender: TObject);
begin
  cbxPromoType.ItemIndex := 0;
  AtivaAviso;
end;

procedure TbrwPromo.Button3Click(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text        := '<'+Button3.Caption+'>';

  AtivaAviso;
end;

procedure TbrwPromo.Button1Click(Sender: TObject);
begin
  inherited;
  cbxDayofWeek.ItemIndex := 0;
  AtivaAviso;
end;

procedure TbrwPromo.btnExecClick(Sender: TObject);
var
  i: Integer;
  sDate, eDate: String;
begin
  inherited;

  if ( quBrowse.Active ) then begin
     quBrowse.close;
     quBrowse.CommandText := sqlNoFilter;
  end;

  for i := 0 to 3 do
    aWhereBasicFilters[i] := '';

  quBrowse.ClearSuggest;

  if cbxPromoType.ItemIndex > 0 then
  begin
    quBrowse.AddSuggest('PromoType', cbxPromoType.Text);
    aWhereBasicFilters[0] := 'd.DiscType = ' + QuotedStr(cbxPromoType.Text);
  end;

  // status selected
  if ( statusPromo.ItemIndex in [0..2]) then begin
    aWhereBasicFilters[1] := '(';
    if ( statusPromo.ItemIndex = 0 ) then begin // active
      aWhereBasicFilters[1] :=  aWhereBasicFilters[1] + ' d.startOn <= GETDATE() and d.EndOn >= cast(GETDATE() as date)';
    end else if (statusPromo.ItemIndex = 1) then begin  // future
            aWhereBasicFilters[1] := aWhereBasicFilters[1] + ' d.StartOn > GETDATE()';
        end else if (statusPromo.ItemIndex = 2) then begin  // expired
                 aWhereBasicFilters[1] := aWhereBasicFilters[1] + ' d.EndOn < GETDATE() - 1';
            end;

    aWhereBasicFilters[1] := aWhereBasicFilters[1] + ')';
  end;

{
  if (chkAtivo.Checked) or (chkFuturo.Checked) or (chkExprirado.Checked) then
  begin
    aWhereBasicFilters[1] := '(';
    if (chkAtivo.Checked) then begin
      aWhereBasicFilters[1] :=  aWhereBasicFilters[1] + ' d.startOn <= GETDATE() and d.EndOn >= GETDATE() ';
    end else if (chkFuturo.Checked) then begin
//      if (Length(aWhereBasicFilters[1]) > 1) then
            aWhereBasicFilters[1] := aWhereBasicFilters[1] + ' d.StartOn > GETDATE()';
        end else if (chkExprirado.Checked) then begin
                 aWhereBasicFilters[1] := aWhereBasicFilters[1] + ' d.EndOn < GETDATE() - 1';
            end;

    aWhereBasicFilters[1] := aWhereBasicFilters[1] + ')';
    showmessage(aWhereBasicFilters[1]);
  end;
 }
  if scStore.LookUpValue <> '' then
  begin
    quBrowse.AddSuggest('IDStore', scStore.LookUpValue);
    aWhereBasicFilters[3] := 'd.IDStore = ' + scStore.LookUpValue;
  end;

  ExecBrowseSQL(True, quBrowse.CommandText);
  DesativaAviso;
end;

procedure TbrwPromo.quBrowseCalcFields(DataSet: TDataSet);
begin
(*
  case quBrowseDiscountType.AsInteger of
   DISCOUNT_PROMO_TYPE_PERCENTUAL : quBrowseNewDiscountType.AsString := sPercentual;
   DISCOUNT_PROMO_TYPE_VALUE      : quBrowseNewDiscountType.AsString := sValue;
   DISCOUNT_PROMO_TYPE_QTY        : quBrowseNewDiscountType.AsString := sQty;
   DISCOUNT_PROMO_TYPE_SALE       : quBrowseNewDiscountType.AsString := sTotal;
  end;

  case quBrowsePromoType.AsInteger of
   PROMO_TYPE_SALE          : quBrowseNewPromoType.AsString := sSale;
   PROMO_TYPE_FREQUENTBUYER : quBrowseNewPromoType.AsString := sFrequentBuyer;
   PROMO_TYPE_COUPON        : quBrowseNewPromoType.AsString := sCoupon;
   PROMO_TYPE_LOYALTY       : quBrowseNewPromoType.AsString := sLoyalty;
  end;
  *)
end;

procedure TbrwPromo.addPromo;
begin
 //
end;

procedure TbrwPromo.addRemoveColumns;
begin
 //
end;

procedure TbrwPromo.editPromo;
begin
 //
end;

procedure TbrwPromo.exportTo;
begin
 //
end;

procedure TbrwPromo.grouping;
begin
 //
end;

procedure TbrwPromo.preview;
begin
 //
end;

procedure TbrwPromo.removePromo;
begin
//
end;

procedure TbrwPromo.showFilters;
begin
//
end;

procedure TbrwPromo.start;
begin
   DM.imgSmall.GetBitmap(BTN18_NEW, btAdd.Glyph);

  pnlPage.Caption := '';

  showModal;
end;

procedure TbrwPromo.CommandClick(Sender: TObject);
var
  objdao: TPromoDAO;
begin
  inherited;

  if ( (sender as TSpeedButton).Tag = 2 ) then begin // remove button was pressed

      try
         try
           objdao := TPromoDAO.create();
           objdao.setConnection(dm.ADODBConnect);
           objdao.removePromo(quBrowse.fieldByName('idDiscount').Value);
         except
           on e: Exception do begin
              raise Exception.Create(format('Cannot remove that promo: %s', [e.Message]));
           end;
         end;
      finally
         freeAndNil(objdao);
      end;

  end;

  btnExecClick(sender);

end;

end.
