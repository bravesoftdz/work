unit BogoWarningViewOrphans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls, StdCtrls, CheckLst, contnrs, BogoPromoCls;

type
  TvwBogoWarningOrphan = class(TForm)
    pnlOrphan: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    btnSelect: TButton;
    GroupBox3: TGroupBox;
    Splitter: TSplitter;
    cxGridItemsSale: TcxGrid;
    cxGridDBTableViewItemsSale: TcxGridDBTableView;
    cxGridLevelItemsSale: TcxGridLevel;
    cxGridOrphan: TcxGrid;
    cxGridDBTableViewOrphan: TcxGridDBTableView;
    cxGridLevelOrphan: TcxGridLevel;
    clbOrphans: TCheckListBox;
    btnOrphansToDelete: TButton;
    dsSaleFromCashRegister: TDataSource;
    dsOrphanSale: TDataSource;
    cxGridDBTableViewItemsSaleDBColumn2: TcxGridDBColumn;
    cxGridDBTableViewItemsSaleDBColumn3: TcxGridDBColumn;
    cxGridDBTableViewItemsSaleDBColumn4: TcxGridDBColumn;
    cxGridDBTableViewItemsSaleDBColumn5: TcxGridDBColumn;
    cxGridDBTableViewOrphanDBColumn1: TcxGridDBColumn;
    cxGridDBTableViewOrphanDBColumn2: TcxGridDBColumn;
    cxGridDBTableViewOrphanDBColumn3: TcxGridDBColumn;
    cxGridDBTableViewOrphanDBColumn4: TcxGridDBColumn;
    cxGridDBTableViewOrphanDBColumn5: TcxGridDBColumn;
    cxGridDBTableViewItemsSaleDBColumn1: TcxGridDBColumn;
    cxGridDBTableViewItemsSaleDBColumn6: TcxGridDBColumn;
    cxGridDBTableViewItemsSaleDBColumn7: TcxGridDBColumn;
    procedure btnOrphansToDeleteClick(Sender: TObject);
    function getOrphanByIdMov(idMov: integer): TBogoPromoDistribution;
    procedure btnSelectClick(Sender: TObject);
    procedure markOrphansToDelete();
  private
    { Private declarations }
    FOrphanList: TObjectList;
  public
    { Public declarations }
    function start(saleDataset: TDataset; orphanFromSale: TDataset; orphanList: TObjectList): boolean;
  end;

var
  vwBogoWarningOrphan: TvwBogoWarningOrphan;

implementation

{$R *.dfm}

procedure TvwBogoWarningOrphan.btnOrphansToDeleteClick(Sender: TObject);
begin
  MarkOrphansToDelete();
  close;

end;

function TvwBogoWarningOrphan.getOrphanByIdMov(
  idMov: integer): TBogoPromoDistribution;
var
  i: integer;
begin
  for i := 0 to FOrphanList.count - 1 do begin
      if ( TBogoPromoDistribution(FOrphanList.Items[i]).IdPreInventory = idMov ) then begin
         TBogoPromoDistribution(FOrphanList.Items[i]).ToDelete := true;
         result := TBogoPromoDistribution(FOrphanList.Items[i]);
         break;
      end;
  end;

end;

function TvwBogoWarningOrphan.start(saleDataset: TDataset; orphanFromSale: TDataset; orphanList: TObjectList): boolean;
begin
  dsSaleFromCashRegister.DataSet := saleDataset;
  dsOrphanSale.dataset := orphanFromSale;
  FOrphanList := orphanList;

  result := ShowModal = mrOK;

end;

procedure TvwBogoWarningOrphan.btnSelectClick(Sender: TObject);
var
  index: integer;
begin
  clbOrphans.Items.AddObject((dsOrphanSale.dataset.fieldByName('IdPreinventoryMov').AsString +  '   ' +
                              dsOrphanSale.dataset.fieldByName('Model').AsString),
                              getOrphanByIdMov(dsOrphanSale.dataset.fieldByName('IdPreInventoryMov').AsInteger));

  index := clbOrphans.Items.IndexOf(dsOrphanSale.dataset.fieldByName('IdPreinventoryMov').AsString);
  if ( index > -1 ) then begin
     clbOrphans.Checked[index] := true;
  end;

end;

procedure TvwBogoWarningOrphan.MarkOrphansToDelete;
var i: integer;
begin
   for i := 0 to clbOrphans.Count - 1 do begin
       if ( not clbOrphans.Checked[i] ) then begin
          TBogoPromoDistribution(clbOrphans.Items[i]).ToDelete := false;
       end;
   end;
end;

end.
