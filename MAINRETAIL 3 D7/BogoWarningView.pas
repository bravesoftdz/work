unit BogoWarningView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, ExtCtrls, dbClient;

type
  TvwBogoWarning = class(TForm)
    GrbBuy: TGroupBox;
    grbGet: TGroupBox;
    cxGridPromoConfict: TcxGrid;
    cxGridDBTableViewBogoBuy: TcxGridDBTableView;
    cxGridDBTableViewBogoBuyDBColumn1: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn2: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    pnlBuyWarning: TPanel;
    pnlGetWarning: TPanel;
    dsBuyX: TDataSource;
    dsGetY: TDataSource;
    Panel3: TPanel;
    cbxKeepWarning: TCheckBox;
    cxGridDBTableViewBogoBuyDBColumn3: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn4: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn5: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn6: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn8: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn11: TcxGridDBColumn;
    cxGridDBTableViewBogoBuyDBColumn15: TcxGridDBColumn;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1DBColumn1: TcxGridDBColumn;
    cxGridDBTableView1DBColumn2: TcxGridDBColumn;
    cxGridDBTableView1DBColumn3: TcxGridDBColumn;
    cxGridDBTableView1DBColumn4: TcxGridDBColumn;
    cxGridDBTableView1DBColumn5: TcxGridDBColumn;
    cxGridDBTableView1DBColumn6: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function start(var keepsWarning: boolean; var  IdPromoDiscount: integer; bogoDataset: TClientDataset;
    idModel: Integer; messagePromo: string): boolean;
  end;

var
  vwBogoWarning: TvwBogoWarning;

implementation

uses uDM;

{$R *.dfm}

{ TvwBogoWarning }

function TvwBogoWarning.start(var keepsWarning: boolean; var  IdPromoDiscount: integer; bogoDataset: TClientDataset;
idModel: Integer; messagePromo: string): boolean;
var
  bogoGet: TClientDataset;
begin

  pnlGetWarning.caption := messagePromo;

  if ( IdPromoDiscount > 0 ) then begin
      bogoDataset.Filter := 'BOGO = ' + QuotedStr('Buy') + ' and IdDiscount = ' + IntToStr(IdPromoDiscount);
      bogoDataset.filtered := true;
  end else begin
          bogoDataset.Filter := 'BOGO = ' + QuotedStr('Buy');
          bogoDataset.filtered := true;
      end;

  bogoDataset.Locate('IdModel', IdModel, []);

  pnlBuyWarning.Caption := format('There is a promotion to that item [ %s ] in the cash register. ',[bogoDataset.fieldByName('Model').Value]);
  dsBuyX.DataSet := bogoDataset;
  bogoGet := dm.getCurrentPromoDetails();

  bogoGet.Filter := 'BOGO = ' + QuotedStr('Get') + ' and IdDiscount = ' + bogoDataset.fieldByName('IDDiscount').AsString;
  bogoGet.filtered := true;

  dsGetY.DataSet := bogoGet;
  result := showModal = mrOK;

  keepsWarning := cbxKeepWarning.checked;
  IdPromoDiscount := bogoDataset.fieldByName('IdDiscount').Value;
end;

procedure TvwBogoWarning.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( key = VK_RETURN ) then begin
     close;
  end;

end;

end.
