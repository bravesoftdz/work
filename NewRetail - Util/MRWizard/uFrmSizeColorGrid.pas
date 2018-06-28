unit uFrmSizeColorGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, Grids;

const
    COL_SPACE = 10;

type
  TFrmSizeColorGrid = class(TForm)
    pnlBotton: TPanel;
    imgBotton: TImage;
    btnClose: TBitBtn;
    sgGrid: TStringGrid;
    pnlValues: TPanel;
    rdQtd: TRadioButton;
    rbSalePrice: TRadioButton;
    edtValue: TEdit;
    btnApplyLine: TButton;
    btnApplyColumn: TButton;
    btCreateGrid: TButton;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure rdQtdClick(Sender: TObject);
    procedure sgGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edtValueExit(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnApplyLineClick(Sender: TObject);
    procedure btnApplyColumnClick(Sender: TObject);
    procedure btCreateGridClick(Sender: TObject);
  private
    FRow, FCol : Integer;
    FModel : String;
    procedure GridPaint(Column : String);
    procedure UpdateValue(Row, Col : Integer; Value : String);
    procedure RefreshOption;
  public
    function Start(Model : String): Boolean;
  end;

implementation

uses uDMExport, DBClient, uCharFunctions, uMsgBox, uFrmBuildGrid;

{$R *.dfm}

{ TFrmSizeColorGrid }

function TFrmSizeColorGrid.Start(Model : String): Boolean;
begin
  FModel := Model;
  with DMExport.cdsGrid do
     begin
      Filtered := False;
      Filter := 'Model = ' + QuotedStr(FModel);
      Filtered := True;
     end;

  GridPaint('Qty');
  Caption := DMExport.cdsGrid.FieldByName('Model').AsString;
  ShowModal;
  DMExport.cdsGrid.Filtered := False;
  DMExport.cdsGrid.Filter   := '';
  Result := True;

end;

procedure TFrmSizeColorGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmSizeColorGrid.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSizeColorGrid.GridPaint(Column : String);
var
  slColor,
  slSize: TStringList;
  iMaxSizeWidth, iMaxColorWidth: integer;
  i, j: integer;
  CelValue : String;

// ----------------------
// Sub
// ----------------------
   function IndexOfColor(sColor: String): integer;
   begin
     Result := slColor.IndexOf(sColor);
     if Result = -1 then
       begin
         Result := slColor.Add(sColor);
         sgGrid.RowCount := slColor.Count + 1;
       end;
     Result := Result + 1;
   end;

   function IndexOfSize(sSize: String): integer;
   begin
     Result := slSize.IndexOf(sSize);
     if Result = -1 then
       begin
         Result := slSize.Add(sSize);
         sgGrid.ColCount := slSize.Count + 1;
       end;
     Result := Result + 1;
   end;
// ----------------------
// Main
// ----------------------
begin
  // Utilizo dois StringList para incluir e recuperar os Index
  slColor        := TStringList.Create;
  slSize         := TStringList.Create;
  iMaxSizeWidth  := 0;
  iMaxColorWidth := 0;

  try
    with sgGrid do
      begin
        ColCount := 0;
        RowCount := 0;

        DMExport.cdsGrid.First;
        while not DMExport.cdsGrid.EOF do
        begin
          if rdQtd.Checked then
            CelValue := DMExport.cdsGrid.FieldByName(Column).AsString
          else
            CelValue := FormatFloat('#,##0.00', DMExport.cdsGrid.FieldByName(Column).AsFloat);

          Cells[ IndexOfSize(DMExport.cdsGrid.FieldByName('MSize').AsString),
                 IndexOfColor(DMExport.cdsGrid.FieldByName('MColor').AsString) ] := CelValue;
          DMExport.cdsGrid.Next;
        end;

        // Ajusto as Larguras das cell
        for i := 0 to slColor.Count-1 do
          begin
            j := Canvas.TextWidth(slColor[i]);
            if iMaxColorWidth < j then
              iMaxColorWidth := j;
          end;
        ColWidths[0] := iMaxColorWidth + COL_SPACE;

        for i := 0 to slSize.Count-1 do
          begin
            j := Canvas.TextWidth(slSize[i]);
            if iMaxSizeWidth < j then
              iMaxSizeWidth := j;
          end;
        if iMaxSizeWidth < 30 then
          iMaxSizeWidth := iMaxSizeWidth + 30;

        for i := 1 to ColCount-1 do
          ColWidths[i] := iMaxSizeWidth + COL_SPACE;

        // Pinto os titulos das colunas e das linhas
        if ColCount > 1 then
          FixedCols := 1;

        if RowCount > 1 then
          FixedRows := 1;

        for i := 0 to slColor.Count-1 do
          Cells[0, i+1] := slColor[i];

        for i := 0 to slSize.Count-1 do
          Cells[i+1, 0] := slSize[i];

      end;

  finally
    slColor.Free;
    slSize.Free;
    end;
  
end;


procedure TFrmSizeColorGrid.rdQtdClick(Sender: TObject);
begin
  RefreshOption;
end;

procedure TFrmSizeColorGrid.sgGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin

  //Somente na Coluna desejada
  if ((ACol <> 0) AND (ARow <> 0)) then
  begin
    FRow := ARow;
    FCol := ACol;
   {Size and position the combo box to fit the cell}
    R := sgGrid.CellRect(ACol, ARow);
    R.Left := R.Left + sgGrid.Left;
    R.Right := R.Right + sgGrid.Left;
    R.Top := R.Top + sgGrid.Top;
    R.Bottom := R.Bottom + sgGrid.Top;
    edtValue.Left := R.Left + 1;
    edtValue.Top := R.Top + 1;
    edtValue.Width := (R.Right + 1) - R.Left;
    edtValue.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    edtValue.Text := sgGrid.Cells[ACol, ARow];
    edtValue.Visible := True;
    edtValue.SetFocus;
  end;

  CanSelect := True;

end;

procedure TFrmSizeColorGrid.UpdateValue(Row, Col: Integer; Value: String);
var
  Qty: Double;
  Sale : Currency;
begin
  if Trim(Value) <> '' then
  begin

    Qty := 0;
    Sale := 0;

    if rdQtd.Checked then
      Qty := StrToFloat(Trim(Value))
    else
      Sale := StrToCurr(Trim(Value));

    with DMExport.cdsGrid do
      if Locate('MColor;MSize', VarArrayOf([sgGrid.Cells[0, Row], sgGrid.Cells[Col, 0]]), []) then
      begin
        Edit;
        if rdQtd.Checked then
          FieldByName('Qty').AsFloat := Qty
        else
          FieldByName('SalePrice').AsFloat := Sale;
        Post;
      end;
  end;

end;

procedure TFrmSizeColorGrid.edtValueExit(Sender: TObject);
begin
  edtValue.Visible := False;

  if (edtValue.Text <> '') and (sgGrid.Cells[FCol, FRow] <> edtValue.Text) then
  begin
    if rdQtd.Checked then
      sgGrid.Cells[FCol, FRow] := edtValue.Text
    else
      sgGrid.Cells[FCol, FRow] := FormatFloat('##0.00', StrToCurr(edtValue.Text));
    UpdateValue(FRow, FCol, edtValue.Text);
  end;

end;

procedure TFrmSizeColorGrid.edtValueKeyPress(Sender: TObject;
  var Key: Char);
begin

  if key <> #13 then
    Key := ValidatePositiveCurrency(Key)
  else
    sgGrid.SetFocus;

end;

procedure TFrmSizeColorGrid.btnApplyLineClick(Sender: TObject);
var
  Value : Double;
  Col, i : integer;
begin

  Col := sgGrid.Col;
  Value := StrToFloatDef(sgGrid.Cells[Col, sgGrid.Row],0);

  if (Value <> 0) then
    if MsgBox(Format('Aplicar %f para os itens da mesma linha?', [Value]), vbYesNo + vbQuestion) = vbYes then
    begin
      for i := 0 to sgGrid.ColCount-1 do
       if (i <> Col) then
         UpdateValue(sgGrid.Row, i, FloatToStr(Value));
      RefreshOption;
    end;
end;

procedure TFrmSizeColorGrid.RefreshOption;
begin
  if rdQtd.Checked then
    GridPaint('Qty')
  else
    GridPaint('SalePrice');
end;

procedure TFrmSizeColorGrid.btnApplyColumnClick(Sender: TObject);
var
  Value : Double;
  Row, i : integer;
begin

  Row := sgGrid.Row;
  Value := StrToFloatDef(sgGrid.Cells[sgGrid.Col, Row], 0);

  if (Value <> 0) then
    if MsgBox(Format('Aplicar %f para os itens da mesma coluna?', [Value]), vbYesNo + vbQuestion) = vbYes then
    begin
      for i := 0 to sgGrid.RowCount-1 do
       if (i <> Row) then
         UpdateValue(i, sgGrid.Col, FloatToStr(Value));
      RefreshOption;
    end;
end;

procedure TFrmSizeColorGrid.btCreateGridClick(Sender: TObject);
begin
  with TFrmBuildGrid.Create(Self) do
    if Start(FModel) then
      RefreshOption;
end;

end.
