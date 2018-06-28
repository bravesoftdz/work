unit uCashRegTotal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Db, DBTables,
  Grids, Buttons, DBCtrls, ADODB, siComp, siLangRT, DBGrids, SMDBGrid;

type
  TCashRegTotal = class(TFrmParentAll)
    quLancTotal: TADOQuery;
    dsLancTotal: TDataSource;
    quLancTotalPre: TADOQuery;
    dsLancTotalPre: TDataSource;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    lblTitulo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblCash: TLabel;
    lblCard: TLabel;
    lblOther: TLabel;
    lblTotal: TLabel;
    Label8: TLabel;
    lblCardPre: TLabel;
    Label10: TLabel;
    lblOtherPre: TLabel;
    Label12: TLabel;
    lblTotalPre: TLabel;
    Label30: TLabel;
    Shape4: TShape;
    Label34: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Shape1: TShape;
    Label13: TLabel;
    BitBtn1: TBitBtn;
    Panel7: TPanel;
    Panel8: TPanel;
    Label6: TLabel;
    lblCashCheck: TDBText;
    Label15: TLabel;
    Label16: TLabel;
    lblCardCheck: TDBText;
    Label18: TLabel;
    Label19: TLabel;
    lblOtherCheck: TDBText;
    Label21: TLabel;
    Shape2: TShape;
    Label22: TLabel;
    Label23: TDBText;
    Label24: TLabel;
    Label25: TLabel;
    lblPreDateCheck: TDBText;
    Label27: TLabel;
    quCashLog: TADOQuery;
    quCashLogTotCashCheck: TFloatField;
    quCashLogTotCardCheck: TFloatField;
    quCashLogTotCardPreCheck: TFloatField;
    quCashLogTotCheckCheck: TFloatField;
    quCashLogTotOtherCheck: TFloatField;
    Label14: TLabel;
    DBText1: TDBText;
    Label17: TLabel;
    dsCashLogTotal: TDataSource;
    quCashLogTotGeralCheck: TCurrencyField;
    Panel9: TPanel;
    Label20: TLabel;
    lblAvgCash: TDBText;
    Label26: TLabel;
    Label28: TLabel;
    lblAvgCard: TDBText;
    Label29: TLabel;
    Label31: TLabel;
    lblAvgMisc: TDBText;
    Label32: TLabel;
    Shape3: TShape;
    Label33: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    lblAvgPre: TDBText;
    Label37: TLabel;
    Label38: TLabel;
    lblAvgCheck: TDBText;
    Label39: TLabel;
    Panel10: TPanel;
    DBText2: TDBText;
    quCashLogAvgCashCheck: TFloatField;
    quCashLogAvgCardCheck: TFloatField;
    quCashLogAvgCardPreCheck: TFloatField;
    quCashLogAvgCheckCheck: TFloatField;
    quCashLogAvgOtherCheck: TFloatField;
    quCashLogAvgGeralCheck: TCurrencyField;
    quLancTotalTipo: TIntegerField;
    quLancTotalMeioPag: TStringField;
    quLancTotalValor: TFloatField;
    quLancTotalPreTipo: TIntegerField;
    quLancTotalPreMeioPag: TStringField;
    quLancTotalPreValor: TFloatField;
    grdPaymentType: TSMDBGrid;
    dxDBGrid1: TSMDBGrid;
    quCashLogTotDebitCheck: TBCDField;
    quCashLogAvgDebitCheck: TBCDField;
    Label40: TLabel;
    DBText3: TDBText;
    Label41: TLabel;
    Label42: TLabel;
    DBText4: TDBText;
    Label43: TLabel;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quLancTotalAfterOpen(DataSet: TDataSet);
    procedure quLancTotalPreAfterOpen(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure quCashLogCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure sbHelpClick(Sender: TObject);
  private
    sFrom,
    sTo   : String;
    MyIsInvoice : Boolean;
    MyIDInventoryMov, MyIDOldSalesPerson : integer;
  public
    procedure Start(DataIni, DataFim : TDateTime);
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

procedure TCashRegTotal.Start(DataIni, DataFim : TDateTime);
begin
   lblTitulo.Caption := sFrom + DateToStr(DataIni) + sTo +
                        DateToStr(DataFim);
   with quLancTotal do
   begin
     Parameters.ParamByName('DataIni').Value := DataIni;
     Parameters.ParamByName('DataFim').Value := DataFim+1;
     Open;
   end;
   with quLancTotalPre do
   begin
     Parameters.ParamByName('DataIni').Value := DataIni;
     Parameters.ParamByName('DataFim').Value := DataFim+1;
     Open;
   end;
   with quCashLog do
   begin
     Parameters.ParamByName('DataIni0').Value := DataIni;
     Parameters.ParamByName('DataFim0').Value := DataFim+1;
     Parameters.ParamByName('DataIni1').Value := DataIni;
     Parameters.ParamByName('DataFim1').Value := DataFim+1;
     Parameters.ParamByName('DataIni2').Value := DataIni;
     Parameters.ParamByName('DataFim2').Value := DataFim+1;
     Parameters.ParamByName('DataIni3').Value := DataIni;
     Parameters.ParamByName('DataFim3').Value := DataFim+1;
     Parameters.ParamByName('DataIni4').Value := DataIni;
     Parameters.ParamByName('DataFim4').Value := DataFim+1;
     Parameters.ParamByName('DataIni5').Value := DataIni;
     Parameters.ParamByName('DataFim5').Value := DataFim+1;
     Parameters.ParamByName('DataIni6').Value := DataIni;
     Parameters.ParamByName('DataFim6').Value := DataFim+1;
     Open;
   end;

  Screen.Cursor := crDefault;

  ShowModal;
end;

procedure TCashRegTotal.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCashRegTotal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCashRegTotal.quLancTotalAfterOpen(
  DataSet: TDataSet);
var
  TotCash, TotCard, TotOther : Double;
begin
  inherited;
  // Mostra os totais
  TotCash  := 0;
  TotCard  := 0;
  TotOther := 0;

  with quLancTotal do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      case quLancTotalTipo.AsInteger of
        1 :  TotCash  := TotCash  + quLancTotalValor.AsFloat;
        2 :  TotCard  := TotCard  + quLancTotalValor.AsFloat;
        else TotOther := TotOther + quLancTotalValor.AsFloat;
      end;
      Next;
    end;
    First;
    EnableControls;
  end;

  lblCash.Caption  := FloatToStrF(TotCash, ffCurrency, 20, 2);
  lblCard.Caption  := FloatToStrF(TotCard, ffCurrency, 20, 2);
  lblOther.Caption := FloatToStrF(TotOther, ffCurrency, 20, 2);
  lblTotal.Caption  := FloatToStrF(TotCash+TotCard+TotOther, ffCurrency, 20, 2);
end;

procedure TCashRegTotal.quLancTotalPreAfterOpen(DataSet: TDataSet);
var
  TotCard, TotOther : Double;
begin
  inherited;
  // Mostra os totais
  TotCard  := 0;
  TotOther := 0;

  with quLancTotalPre do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      case quLancTotalPreTipo.AsInteger of
        2 : TotCard  := TotCard  + quLancTotalPreValor.AsFloat;
        else TotOther := TotOther + quLancTotalPreValor.AsFloat;
      end;
      Next;
    end;
    First;
    EnableControls;
  end;

  lblCardPre.Caption  := FloatToStrF(TotCard, ffCurrency, 20, 2);
  lblOtherPre.Caption := FloatToStrF(TotOther, ffCurrency, 20, 2);
  lblTotalPre.Caption  := FloatToStrF(TotCard+TotOther, ffCurrency, 20, 2);
end;

procedure TCashRegTotal.BitBtn1Click(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  Print;
  Screen.Cursor := crDefault;
end;

procedure TCashRegTotal.quCashLogCalcFields(DataSet: TDataSet);
begin
  inherited;
  quCashLogTotGeralCheck.AsFloat := quCashLogTotCashCheck.AsFloat  + quCashLogTotCardCheck.AsFloat    +
                                    quCashLogTotCheckCheck.AsFloat + quCashLogTotCardPreCheck.AsFloat +
                                    quCashLogTotOtherCheck.AsFloat + quCashLogTotDebitCheck.AsFloat;

  quCashLogAvgGeralCheck.AsFloat := quCashLogAvgCashCheck.AsFloat  + quCashLogAvgCardCheck.AsFloat    +
                                    quCashLogAvgCheckCheck.AsFloat + quCashLogAvgCardPreCheck.AsFloat +
                                    quCashLogAvgOtherCheck.AsFloat + quCashLogAvgDebitCheck.AsFloat;
end;

procedure TCashRegTotal.FormCreate(Sender: TObject);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sFrom := 'Cash Register Totals from ';
      sTo   := ' to ';
    end;

    LANG_PORTUGUESE :
    begin
      sFrom := 'Totais Caixa Registradora desde ';
      sTo   := ' até ';
    end;

    LANG_SPANISH :
    begin
      sFrom := 'Totales Caja Registradora desde ';
      sTo   := ' hasta ';
    end;
  end;
end;

procedure TCashRegTotal.sbHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1110);
end;

end.
