unit UBrwTaxCategory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeBrowses, BrowseConfig, Mask, DateBox,
  Menus, Db, DBTables, Grids, PanelRights, LblEffct, ExtCtrls, StdCtrls, Buttons,
  ImgList, ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TBrwTaxCategory = class(TbrwParent)
    quBrowseIDTaxCategory: TIntegerField;
    quBrowseTaxCategory: TStringField;
    quBrowseTax: TFloatField;
    grdBrowseDBIDTaxCategory: TcxGridDBColumn;
    grdBrowseDBTaxCategory: TcxGridDBColumn;
    grdBrowseDBTax: TcxGridDBColumn;
    Label2: TLabel;
    cbxTaxType: TComboBox;
    Label1: TLabel;
    cbxSaleType: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure cbxTaxTypeChange(Sender: TObject);
    procedure cbxSaleTypeChange(Sender: TObject);
  private
    { Private declarations }
    fOperationType,
    fSaleTaxType : Integer;
  public
    { Public declarations }
  end;

implementation

uses uFchTaxCategory, uDM, uDMGlobal, uSystemConst;

{$R *.DFM}

procedure TBrwTaxCategory.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchTaxCategory.Create(Self);
end;

procedure TBrwTaxCategory.btnExecClick(Sender: TObject);
var
  fParam : String;
begin
  inherited;

  case cbxTaxType.ItemIndex of
    0 : begin
        aWhereBasicFilters[1] := 'T.OperationType='+IntToStr(TAX_OP_TYPE_SALE);
        fParam := 'OPType='+IntToStr(TAX_OP_TYPE_SALE)+';';
        case cbxSaleType.ItemIndex of
          0 : begin
              aWhereBasicFilters[2] := 'T.SaleTaxType='+IntToStr(SALE_TAX_TYPE_CHARGE);
              fParam := fParam + 'STType='+IntToStr(SALE_TAX_TYPE_CHARGE)+ ';';
              end;
          1 : begin
              aWhereBasicFilters[2] := 'T.SaleTaxType='+IntToStr(SALE_TAX_TYPE_GOV);
              fParam := fParam + 'STType='+IntToStr(SALE_TAX_TYPE_GOV)+ ';';
              end;
        end;
        end;
    1 : begin
        aWhereBasicFilters[1] := 'T.OperationType='+IntToStr(TAX_OP_TYPE_PURCHASE);
        aWhereBasicFilters[2] := '';
        fParam := 'OPType='+IntToStr(TAX_OP_TYPE_PURCHASE)+';';
        end;
  end;

  ExecBrowseSQL(True);

  //Desliga o pisca do pnlGo!
  DesativaAviso;

  //Passo os params para a ficha
  TFchTaxCategory(brwForm).sParam := fParam;

end;

procedure TBrwTaxCategory.cbxTaxTypeChange(Sender: TObject);
begin
  inherited;
  Label1.Visible      := (TComboBox(Sender).ItemIndex = 0);
  cbxSaleType.Visible := Label1.Visible;
  AtivaAviso; 
end;

procedure TBrwTaxCategory.cbxSaleTypeChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

end.
