unit uSubMovTotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, Grids, StdCtrls, Mask,
  SuperComboADO, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, StrUtils,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TSubMovTotal = class(TParentSub)
    Label29: TLabel;
    Button2: TButton;
    grdModelHist: TStringGrid;
    quModelHistory: TADOQuery;
    quModelHistoryYear: TIntegerField;
    quModelHistoryMonth: TIntegerField;
    quModelHistoryName: TStringField;
    quModelHistoryInventMovTypeID: TIntegerField;
    cmbStoreMovTotal: TcxLookupComboBox;
    quModelHistoryTotQty: TFloatField;
    procedure Button2Click(Sender: TObject);
    procedure cmbStoreMovTotalPropertiesChange(Sender: TObject);
    procedure cmbStoreMovTotalEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sTotalYear,
    sTotalMonth : String;
    fIDModel : Integer;
    fIDStore : Integer;
    procedure RefreshModelHistory;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
  end;

implementation

uses uDM, uParamFunctions, uDMGlobal, uNumericFunctions, uSqlFunctions;

{$R *.dfm}

procedure TSubMovTotal.RefreshModelHistory;
var
   i, j , MyMonth, MyYear,
   MesFim, AnoFim, AtualMovID   : Integer;
   TotYear : Double;
begin

  Screen.Cursor := crHourGlass;

   // Apaga o grid
   with grdModelHist do
    begin
      RowCount := 2;
      for i := 0 to RowCount - 1 do
        for j := 0 to ColCount - 1 do
           Cells[j, i] := '';
    end;

     with quModelHistory do
       begin
         MyMonth := StrToInt(FormatDateTime('m', Date));
         MyYear  := StrToInt(FormatDateTime('yyyy', Date));

         if not Active then
           begin

             SQL.Clear;
             SQL.Add('SELECT Year, Month, InventMovTypeID, Name, SUM(TotQty) as TotQty');
             SQL.Add('FROM InventoryMovTotal InventoryMovTotal (NOLOCK)     ');
             SQL.Add('JOIN InventoryMovType InventoryMovType (NOLOCK) ON ( InventoryMovType.IDInventMovType = InventoryMovTotal.InventMovTypeID )');
             SQL.Add(' WHERE ModelID = ' + IntToStr(fIDModel));

             if fIDStore <> 0 then
                SQL.Add(' AND StoreID = ' + IntToStr(fIDStore))
             else
                SQL.Add(' AND StoreID IN (' + DM.fStore.StoreList + ')');

             SQL.Add(' AND ((Year >=  '+IntToStr(MyYear - 1)+ ' AND Month >= '+ IntToStr(MyMonth-1)+') or ((Year-1) = '+IntToStr(MyYear-1)+')) ');
             SQL.Add(' GROUP BY InventMovTypeID, Year, Month, Name ');
             SQL.Add(' ORDER BY InventMovTypeID, Year, Month ');


             Open;
           end;

         // Cabecalho TotYear e TotMonth
         grdModelHist.Cells[1, 0]  := sTotalMonth;
         grdModelHist.Cells[14, 0] := sTotalYear;

         // Cabeçalho dos meses
         for i := 1 to 12 do
            if i < MyMonth then
               grdModelHist.Cells[(MyMonth-i)+1, 0] := ShortMonthNames[i] + ' ' + RightStr(IntToStr(MyYear),2)
            else
               grdModelHist.Cells[(12-i)+MyMonth+1, 0]   := ShortMonthNames[i] + ' ' + RightStr(IntToStr(MyYear - 1),2);

         TotYear := 0;
         AtualMovID  := quModelHistoryInventMovTypeID.AsInteger;
         grdModelHist.Cells[0 , 1] := quModelHistoryName.AsString;
         for i := 1 to 14 do
           grdModelHist.Cells[i, grdModelHist.RowCount-1] := '0';

         while not EOF do
          begin
            // Quebra por tipo de movimentação
            if AtualMovID <> quModelHistoryInventMovTypeID.AsInteger then
              begin
                TotYear := 0;
                AtualMovID := quModelHistoryInventMovTypeID.AsInteger;
                grdModelHist.RowCount := grdModelHist.RowCount + 1;

                // Limpa a linha inteira
                for i := 1 to 14 do
                  grdModelHist.Cells[i, grdModelHist.RowCount-1] := '0';

                // Coloca  nome da movimentação
                grdModelHist.Cells[0 , grdModelHist.RowCount-1] := quModelHistoryName.AsString;
              end;

            // Se a query estver sobre o mes e ano atual, Preenche o Month To date e YTD
            if (quModelHistoryMonth.AsInteger = MyMonth) and
               (quModelHistoryYear.AsInteger  = MyYear)  then
               grdModelHist.Cells[1, grdModelHist.RowCount-1] := FormatFloat('0.#####',quModelHistoryTotQty.AsFloat);

            // Calcula e atualiza no grid o total do ano
            Totyear := TotYear + quModelHistoryTotQty.AsFloat;
            grdModelHist.Cells[14, grdModelHist.RowCount-1] := FormatFloat('0.#####',TotYear);

            if (quModelHistoryMonth.AsInteger < MyMonth) and
               (quModelHistoryYear.AsInteger  = MyYear)  then
               grdModelHist.Cells[(MyMonth-quModelHistoryMonth.AsInteger)+1, grdModelHist.RowCount-1] := quModelHistoryTotQty.AsString
            else
              if (quModelHistoryMonth.AsInteger >= MyMonth) and
                 (quModelHistoryYear.AsInteger  < MyYear )  then
                 grdModelHist.Cells[(12-quModelHistoryMonth.AsInteger)+MyMonth+1, grdModelHist.RowCount-1] := quModelHistoryTotQty.AsString;

            Next;
          end;
          Close;
       end;

  Screen.Cursor := crDefault;

end;

procedure TSubMovTotal.AfterSetParam;
begin

   fIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
   fIDStore := StrToIntDef(ParseParam(FParam, 'IDStore'),0);

   RefreshModelHistory;

end;


procedure TSubMovTotal.Button2Click(Sender: TObject);
begin
  inherited;
  DM.quLookUpStore.Close;
  fIDStore := 0;
  RefreshModelHistory;
end;

procedure TSubMovTotal.cmbStoreMovTotalPropertiesChange(Sender: TObject);
begin
  inherited;

  with DM.quLookUpStore do
    if Active then
       if DM.quLookUpStore.Locate('Name', cmbStoreMovTotal.Text, []) then
          fIDStore := DM.quLookUpStoreIDStore.AsInteger;

  RefreshModelHistory;
end;

procedure TSubMovTotal.cmbStoreMovTotalEnter(Sender: TObject);
begin
  inherited;
  with DM.quLookUpStore do
    if not Active then
       Open;
end;

procedure TSubMovTotal.FormDestroy(Sender: TObject);
begin
  DM.quLookUpStore.Close;
  quModelHistory.Close;


  inherited;

end;

procedure TSubMovTotal.FormCreate(Sender: TObject);
var
  sSQL, sWhere : String;
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sTotalYear := 'YTD';
           sTotalMonth:= 'MTD';
           end;

     LANG_PORTUGUESE :
           begin
           sTotalYear := 'ANO';
           sTotalMonth:= 'MES';
           end;

     LANG_SPANISH :
           begin
           sTotalYear := 'YTD';
           sTotalMonth:= 'MTD';
           end;
   end;

  DM.quLookUpStore.Close;
  sWhere := ' Desativado = 0 AND IDStore <> 0 ';
  if DM.fStore.StoreList <> '' then
    sWhere := sWhere + ' AND IDStore IN (' + DM.fStore.StoreList + ')';
  sSQL := ChangeWhereClause(DM.quLookUpStore.CommandText, sWhere, True);
  DM.quLookUpStore.CommandText := sSQL;

end;

initialization
   RegisterClass(TSubMovTotal);


end.
