{
----------------------------------------------------------------
   Eduardo Costa, 23 agosto 1999

   Componete de impressão para o DevExpress DB Grid.

   Aproveita e suporta as caracteristicas unicas do dxDBGrid,
   Suporta grupo, ordenacao e customizacao de colunas.

   Não usa o dataset, faz uso somente das estrututas do proprio
   grid.

   Com suporte a memo

----------------------------------------------------------------
}


unit dxDBGridPrint;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, StdCtrls, dxTL, dxCntner,
  ExtCtrls, ComCtrls, Buttons, Printers, dxDBGrid, uMsgBox, dxGrClms;

procedure Register;

type
  TProgressForm = class(TForm)
    BitBtn1: TBitBtn;
    pb1: TProgressBar;
    lblPagina: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

  TdxDBGridPrint = class(TComponent)
  private
    { Private declarations }
    FImpGrid : TdxDBGrid;

    slMemo                  : TStringList;

    Items, Widths,
    FieldAlign              : TStringList;

    Linhas                  : Integer;

    FTitle,
    FFilterText,
    FUserName               : String;

    aMax,
    aMin,
    aSum                    : Array [0..50] of Double;

    FSumCols,
    FMinCols,
    FMaxCols,
    FAvgCols,
    FCustomTot              : TStringList;

    FMarginBottom,
    FMarginTop,
    FMarginLeft,
    FMarginRight,
    FItemLines              : Integer;

    FTitleFont,
    FItemFont,
    FColumnFont,
    FFooterFont             : TFont;

    FTitleColor,
    FColumnColor,
    FFooterColor            : TColor;

    FFirstPageHeader,
    FFirstPageFooter,
    FFirstPageColumn,
    FOthersPagesHeader,
    FOthersPagesFooter,
    FOthersPagesColumn,
    FTotals                 : Boolean;

    FBandsColorEnabled      : Boolean;

    FBandsColor1,
    FBandsColor2            : TColor;

    FPreview                : Boolean;   // Somente preview
    FPreviewPaintBox        : TPaintBox; // Paint box onde sera desenhado o preview

    AmountPrinted,
    AmountItemPrinted       : integer;

    Fator                   : Double;

    TotalPaginas,
    PaginaAtual             : Integer;
    ParaTudo                : Boolean;

    FreeOnFirstPage,
    FreeOnOthersPages       : integer;

    PageWidth, PageHeight       : integer;

    GroupXY: Integer;

    procedure SetTitleFont(Value : TFont);
    procedure SetItemFont(Value : TFont);
    procedure SetColumnFont(Value : TFont);
    procedure SetFooterFont(Value : TFont);

    procedure SetSumCols(Value : TStringList);
    procedure SetMaxCols(Value : TStringList);
    procedure SetMinCols(Value : TStringList);
    procedure SetAvgCols(Value : TStringList);
    procedure SetCustomTot(Value : TStringList);

    function TestPageBreak: boolean;
    procedure PageBreak;

    function DrawEndEllepsis(NodeColString: String; NodeColWidth: Integer): String;

    function PrintLine(ActualNode: TdxTreeListNode; OnlyCalc: Boolean): Integer;
    function PrintGroup(ActualNode: TdxTreeListNode; OnlyCalc:Boolean): Integer;
    function PrintHeader(OnlyCalc: Boolean): Integer;
    function PrintFooter(OnlyCalc: Boolean): Integer;
    function PrintColumnNames(OnlyCalc: Boolean): Integer;

    procedure GetFieldsWithSum(var MyFields: TStringList);
    procedure PrintTotal;

    procedure CalculaTotalPaginas(Linhas: integer);

  protected
    OutCanvas: TCanvas;

    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    procedure Print;

  published
    property ImpGrid      : TdxDBGrid    read FImpGrid      write FImpGrid;

    // Fontes
    property ItemLines    : integer      read FItemLines    write FItemLines  default 1;

    property ItemFont     : TFont        read FItemFont     write SetItemFont;
    property TitleFont    : TFont        read FTitleFont    write SetTitleFont;
    property ColumnFont   : TFont        read FColumnFont   write SetColumnFont;
    property FooterFont   : TFont        read FFooterFont   write SetFooterFont;

    // Cores
    property TitleColor   : TColor       read FTitleColor   write FTitleColor;
    property ColumnColor  : TColor       read FColumnColor  write FColumnColor;
    property FooterColor  : TColor       read FFooterColor  write FFooterColor;

    // Textos fixos
    property Title        : String       read FTitle        write FTitle;
    property FilterText   : String       read FFilterText   write FFilterText;
    property UserName     : String       read FUserName     write FUserName;

    // Totais
    property SumCols      : TStringList  read FSumCols      write SetSumCols;
    property MaxCols      : TStringList  read FMaxCols      write SetMaxCols;
    property MinCols      : TStringList  read FMinCols      write SetMinCols;
    property AvgCols      : TStringList  read FAvgCols      write SetAvgCols;
    property CustomTot    : TStringList  read FCustomTot    write SetCustomTot;

    // Margens
    property MarginRight  : Integer      read FMarginRight  write FMarginRight;
    property MarginLeft   : Integer      read FMarginLeft   write FMarginLeft;
    property MarginTop    : Integer      read FMarginTop    write FMarginTop;
    property MarginBotton : Integer      read FMarginBottom write FMarginBottom;

    // Preview
    property Preview         : Boolean    read FPreview            write FPreview;
    property PreviewPaintBox : TPaintBox  read FPreviewPaintBox    write FPreviewPaintBox;

    // Aparencia da primeira página
    property FirstPageHeader   : Boolean read FFirstPageHeader write FFirstPageHeader default True;
    property FirstPageColumn   : Boolean read FFirstPageColumn write FFirstPageColumn default True;
    property FirstPageFooter   : Boolean read FFirstPageFooter write FFirstPageFooter default True;

    // Outras páginas
    property OthersPagesHeader  : Boolean read FOthersPagesHeader  write FOthersPagesHeader default False;
    property OthersPagesColumn  : Boolean read FOthersPagesColumn  write FOthersPagesColumn default False;
    property OthersPagesFooter  : Boolean read FOthersPagesFooter  write FOthersPagesFooter default False;
    property Totals             : Boolean read FTotals             write FTotals            default False;

    // Linhas
    property BandsEnabled   : Boolean     read FBandsColorEnabled  write FBandsColorEnabled default True;
    property BandsColor1    : TColor      read FBandsColor1        write FBandsColor1       default clWhite;
    property BandsColor2    : TColor      read FBandsColor2        write FBandsColor2       default cl3DLight;
  end;

var
  ProgressForm: TProgressForm;

implementation

uses xBase;

{$R *.DFM}

{----- Form Abort Printing -----}

procedure TProgressForm.BitBtn1Click(Sender: TObject);
begin
  Printer.Abort;  // This procedure is supposed to call the above
  Close;
end;

{----- TdxDBGridPrint ------}

constructor TdxDBGridPrint.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ParaTudo := False;

  FColumnFont := TFont.Create;
  FFooterFont := TFont.Create;
  FTitleFont  := TFont.Create;
  FItemFont   := TFont.Create;
  FSumCols    := TStringList.Create;
  FMaxCols    := TStringList.Create;
  FMinCols    := TStringList.Create;
  FAvgCols    := TStringList.Create;
  FCustomTot  := TstringLIst.Create;
  FItemLines := 1;

  FFirstPageHeader   := True;
  FFirstPageFooter   := True;
  FFirstPageColumn   := True;
  FOthersPagesHeader := False;
  FOthersPagesFooter := False;
  FOthersPagesColumn := False;
  FTotals            := False;

  FBandsColorEnabled   := True;
  FBandsColor1         := clWhite;
  FBandsColor2         := cl3DLight;

end;

destructor TdxDBGridPrint.Destroy;
begin
  FColumnFont.Free;
  FFooterFont.Free;
  FTitleFont.Free;
  FItemFont.Free;
  FSumCols.Free;
  FMaxCols.Free;
  FMinCols.Free;
  FAvgCols.Free;
  FCustomTot.Destroy;

  inherited Destroy;
end;

procedure TdxDBGridPrint.SetSumCols(Value : TStringList);
begin
  if FSumCols <> Value then
     FSumCols.Assign(Value);
end;

procedure TdxDBGridPrint.SetMaxCols(Value : TStringList);
begin
  if FMaxCols <> Value then
     FMaxCols.Assign(Value);
end;

procedure TdxDBGridPrint.SetMinCols(Value : TStringList);
begin
  if FMinCols <> Value then
     FMinCols.Assign(Value);
end;

procedure TdxDBGridPrint.SetAvgCols(Value : TStringList);
begin
  if FAvgCols <> Value then
     FAvgCols.Assign(Value);
end;

procedure TdxDBGridPrint.SetCustomTot(Value : TStringList);
begin
  if FCustomTot <> Value then
     FCustomTot.Assign(Value);
end;


procedure TdxDBGridPrint.SetTitleFont(Value : TFont);
begin
  if FTitleFont <> Value then
     FTitleFont.Assign(Value);
end;

procedure TdxDBGridPrint.SetItemFont(Value : TFont);
begin
  if FItemFont <> Value then
     FItemFont.Assign(Value);
end;

procedure TdxDBGridPrint.SetColumnFont(Value : TFont);
begin
  if FColumnFont <> Value then
     FColumnFont.Assign(Value);
end;

procedure TdxDBGridPrint.SetFooterFont(Value : TFont);
begin
  if FFooterFont <> Value then
     FFooterFont.Assign(Value);
end;

procedure TdxDBGridPrint.Print;
var
  i               : integer;
  TotWidth        : integer;

begin

  try
    // Crio o stringlist que é usado como buffer para quebrar memos
    slMemo := TStringList.Create;

    // Mostro o form de abort e de andamento
    PaginaAtual := 1;
    ProgressForm := TProgressForm.Create(Self);
    ProgressForm.lblPagina.Caption := 'Incializando Impressora';
    ProgressForm.Show;
    Application.ProcessMessages;

    // Dependendo de onde vai ser impresso, seta qual o canvas de saida
    if FPreview then
      begin
        if PreviewPaintBox <> nil then
          OutCanvas := PreviewPaintBox.Canvas
        else
          begin
            MsgBox('Não foi setado o PaintBox de Preview!', vbCritical + vbOkOnly);
            Exit;
          end;
      end
    else
      OutCanvas := Printer.Canvas;

    // Preparo o canvas de saida, ou inicializo a impressora
    if FPreview then
      begin
        // Limpa o canvas
        OutCanvas.Brush.Style := bsSolid;
        OutCanvas.Brush.Color := clWhite;
        OutCanvas.FillRect(PreviewPaintBox.ClientRect);
      end
    else
      begin
        // Inicializa o documento na printer
        Printer.Title := Application.Title + ' - ' + FTitle;
        Printer.BeginDoc;
      end;

    // Seta as dimenções maximas da página
    PageWidth  := Printer.PageWidth;
    PageHeight := Printer.PageHeight;

    // Calcula o tamanho total dos campos para usar no calculo do media ponderada
    // Atenção para quando o grid estiver agrupado
    TotWidth := 0;
    with FImpGrid do
      for i := 0 to VisibleColumnCount - 1 do
        TotWidth := TotWidth + VisibleColumns[i].Width;

    // Calculo a largura e a altura do grupo
    OutCanvas.Font.Assign(FImpGrid.Font);
    GroupXY := OutCanvas.TextHeight('X');

    Fator := ( PageWidth -
               FMarginLeft -
               FMarginRight -
               (FImpGrid.GroupColumnCount * GroupXY) ) / TotWidth;

    // Seta no abort form o quantas linhas seram processadas
    // Atenção: ainda não estou contando com os agrupamentos
    ProgressForm.pb1.Max := FImpGrid.Count;

    // Calculo o total de paginas, e o quantas linhas cabem em cada pagina
    CalculaTotalPaginas(FImpGrid.Count);

    // Reseta o quanto ja foi impresso
    AmountPrinted := 0;
    AmountItemPrinted := 0;

    // ---------------------------------------------------------------
    // Começo a impressão

    if FFirstPageHeader then
      PrintHeader(False);

    if FFirstPageColumn then
      PrintColumnNames(False);

    if FFirstPageFooter then
      PrintFooter(False);

    // Laço pelos Nodes
    for i := 0 to FImpGrid.Count - 1 do
      begin
        // Imprimo a Linha (ou o grupo)
        PrintGroup(FImpGrid.Items[i], False);

        // Testo se foi fim de página
        if NOT TestPageBreak then
          Break;

        // Atualiza o barra de progresso no form de abort
        ProgressForm.pb1.Position := i;

        // Indica qual página esta sendo impressa
        ProgressForm.lblPagina.Caption := 'Enviando página ' + IntToStr(PaginaAtual);

        // Permito a atulizacao do form de abort
        Application.ProcessMessages;
      end;

    // Neste momento todos os nodes foram impressos
    // Caso esteja setado, imprimo os totais
    if FTotals then
      PrintTotal;

    // Se estou imprimindo para a printer, Finalizo a impressao
    if not FPreview then
      Printer.EndDoc;

    // Sumo com o form de abort
    ProgressForm.Hide;

  finally
    // Destruo o stringlist que é usado como buffer
    slMemo.Free;

    // Destruo o form de abort
    ProgressForm.Free;
  end;
end;



function TdxDBGridPrint.TestPageBreak: boolean;
begin
  Result := True;
  // Testa se já ocupou todo o canvas, caso tenha ocupado, começa uma nova
  // pagina
  if FPreview then
    begin
      // Esta imprimindo para um cavas de preview
      if AmountItemPrinted > FreeOnFirstPage then
        begin
          // Acabou o espaço no canvas, para a impressao
          Result := False;
        end;
    end
  else
    begin
      // Esta imprimindo para a Printer
      if (( AmountItemPrinted  >= FreeOnFirstPage ) and (PaginaAtual = 1))
         or
         (( AmountItemPrinted  >= FreeOnOthersPages ) and (PaginaAtual <> 1)) then
            begin
              PageBreak;
            end;
    end;
end;

procedure TdxDBGridPrint.PageBreak;
begin
   AmountPrinted := 0;
   AmountItemPrinted := 0;
   Inc(PaginaAtual);

   Printer.NewPage;

   if FOthersPagesHeader then
     PrintHeader(False);

   AmountPrinted := AmountPrinted + FMarginTop;

   if FOthersPagesColumn then
     PrintColumnNames(False);

   if FOthersPagesFooter then
     PrintFooter(False);
end;



function TdxDBGridPrint.PrintHeader(OnlyCalc: Boolean): Integer;
var
  HeaderHeight: Integer;
  FilterLines: TStringList;
  FiltroRestante, LinhaDuvidosa, LinhaConfirmada: String;
  FreeWidth: Integer;
  i: integer;

begin

  with OutCanvas do begin
    if not Printer.Aborted then
      begin
        Font.Assign(FTitleFont);
        HeaderHeight := OutCanvas.TextHeight('X') * 2;
        Font.Assign(FFooterFont);
        FreeWidth := PageWidth - FMarginLeft - FMarginRight;

        // Calculo quantas linhas serão necessárias para o FilterText
        // e as coloco no FilterLines
        FilterLines := TStringList.Create;
        if OutCanvas.TextWidth(FilterText) >= FreeWidth then
          begin
            // Devo quebrar em várias linhas
            FiltroRestante := Trim(FilterText) + ' ';
            LinhaDuvidosa := '';

            while (FiltroRestante <> '') do
              begin
                LinhaDuvidosa := LinhaDuvidosa + Copy(FiltroRestante, 1, Pos(' ', FiltroRestante));

                if OutCanvas.TextWidth(LinhaDuvidosa) < FreeWidth then
                  // Se ainda couber tente colocar outra palavra
                  LinhaConfirmada := LinhaDuvidosa
                else
                  // Se não couber, a linha já está definida
                  begin
                    // Incluio no string list
                    FilterLines.Add(LinhaConfirmada);
                    LinhaDuvidosa := Copy(FiltroRestante, 1, Pos(' ', FiltroRestante));
                  end;

                // Retiro do que falta ser processado
                FiltroRestante := RightStr(FiltroRestante, Length(FiltroRestante) - Pos(' ', FiltroRestante));
              end;

            if LinhaDuvidosa <> '' then
              FilterLines.Add(LinhaDuvidosa);

          end
        else
          begin
            // Cabe tudo em uma linha só
            FilterLines.Add(Trim(FilterText));
          end;

        HeaderHeight := HeaderHeight + (OutCanvas.TextHeight('X') * (FilterLines.Count + 2));

        if OnlyCalc then
          begin
            Result := HeaderHeight;
            Exit;
          end;

        // Pinta o fundo
        Brush.Style   := bsSolid;
        Pen.Color     := FTitleColor;
        Brush.Color   := FTitleColor;
        Rectangle(FMarginLeft, FMarginTop, PageWidth - FMarginRight, FMarginTop + HeaderHeight);

        Font.Assign(FTitleFont);

        AmountPrinted := FMarginTop;

        TextOut(((PageWidth - FMarginRight - FMarginLeft) div 2)-(OutCanvas.TextWidth(Application.Title)
                div 2) + FMarginLeft, AmountPrinted, Application.Title);

        AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X');

        TextOut(((PageWidth - FMarginRight - FMarginLeft) div 2)-(OutCanvas.TextWidth(FTitle)
                div 2) + FMarginLeft, AmountPrinted , FTitle);

        AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X');

        Font.Assign(FFooterFont);

        TextOut( FMarginLeft,
                 AmountPrinted,
                 IntToStr(Linhas) + ' Linha(s).' );

        AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X');

        if FFilterText <> '' then
          begin
            for i := 0 to FilterLines.Count - 1 do
              begin
                TextOut( FMarginLeft, AmountPrinted, FilterLines[i]);
                AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X');
              end;
          end;
        AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X');

      end;
   end;
end;

function TdxDBGridPrint.PrintFooter(OnlyCalc: Boolean): Integer;
var
  PageText: String;
  FooterHeight: Integer;

begin
  with OutCanvas do begin
    if not Printer.Aborted then
      begin
        Font.Assign(FFooterFont);
        FooterHeight := OutCanvas.TextHeight('X');

        if OnlyCalc then
          begin
            Result := FooterHeight;
            Exit;
          end;


        // Pinta o fundo
        Pen.Color   := FFooterColor;
        Brush.Style := bsSolid;
        Brush.Color := FFooterColor;
        Rectangle(FMarginLeft, PageHeight - FooterHeight - FMarginBottom, PageWidth - FMarginRight, PageHeight - FMarginBottom);

        Font.Assign(FFooterFont);

        TextOut( FMarginLeft,
                 PageHeight - FooterHeight - FMarginBottom,
                 'Emitido por ' + FUserName + ' em ' + DateTimeToStr(Now));

        PageText := 'Página ' + IntToStr(PaginaAtual) + ' de ' + IntToStr(TotalPaginas);

        TextOut( PageWidth - FMarginRight - OutCanvas.TextWidth(PageText),
                 PageHeight - FooterHeight - FMarginBottom,
                 PageText);
      end;
   end;
end;

function TdxDBGridPrint.PrintColumnNames(OnlyCalc: Boolean): Integer;

   function DivideColuna(CC: String; ActualRow: Integer; var MaxRows: integer; NodeColWidth: Integer): String;

      function OthersRows(CC: String): String;
      begin
        Result := RightStr(CC, Length(CC) - Pos('~', CC));
      end;

   var
     LinhaAtual, i: integer;
     S: String;
   begin
     LinhaAtual := 0;
     Result := '';
     // Existem dois casos distintos para o titulo ter mais de uma linha:
     //   Explicito pelo nome da coluna usando um caracter de quebara ex.: ~
     //   Implicito quando o titulo não couber na largura da coluna

     if Pos('~', CC) <> 0 then
       begin
         // A quebra já esta definida

         // Conto quantas quebras existem
         i := 0;
         S := CC;
         while Pos('~', S) <> 0 do
           begin
             S := OthersRows(S);
             Inc(i);
           end;
         if MaxRows < i then
           MaxRows := i;

         // Retorno a quebra da vez
         case ActualRow of
           0: Result := LeftStr(CC, Pos('~', CC) - 1);
           1: Result := LeftStr(OthersRows(CC), Pos('~', CC)-1);
           2: Result := LeftStr(OthersRows(OthersRows(CC)), Pos('~', CC)-1);
           3: Result := LeftStr(OthersRows(OthersRows(OthersRows(CC))), Pos('~', CC)-1);
         end;
       end
     else if OutCanvas.TextWidth(CC) <= NodeColWidth then
       begin
         // Ótimo o caption cabe no Width, so imprimo a primeira linha
         Result := CC;
       end
     else
       begin
         // Faço a quebra automática
         Result := 'RUNTIME';
       end;
   end;

var
  i : integer;
  MaxNumLinhas, LinhaAtual: integer;
  OutRect: TRect;
  ColumnSeparator: Integer;
  ColumnLineString: String;
begin
  try

    OutCanvas.Font.Assign(FimpGrid.HeaderFont);
    OutCanvas.Brush.Color := FColumnColor;

    ColumnSeparator := OutCanvas.TextWidth('I');

    MaxNumLinhas := 0;
    LinhaAtual := 0;
    repeat
      begin
        with FImpGrid do
          begin
            // Seto a posicao do Rect da coluna do node
            OutRect.Left := FMarginLeft;
            OutRect.Top := AmountPrinted;
            OutRect.Bottom := OutRect.Top + OutCanvas.TextHeight('X');

            for i := 0 to VisibleColumnCount - 1 do
              begin
                // Determino a largura da Coluna, como sendo a lagura do grid
                // vezez o fator pre calculado
                OutRect.Right := OutRect.Left + Round(VisibleColumns[i].Width * Fator) + (GroupColumnCount * GroupXY);

                // Preencho todo o espaço com a cor de fundo
                if not OnlyCalc then
                   OutCanvas.FillRect(OutRect);

                // Diminuo o espaco disponível para garantir um espaço entre as colunas
                OutRect.Right := OutRect.Right - ColumnSeparator;

                if i = 0 then
                  OutRect.Left := OutRect.Left + (GroupColumnCount * GroupXY);

                // Divide o string da coluna um um ou mais linhas
{               ColumnLineString := DivideColuna( VisibleColumns[i].Caption,
                                                  LinhaAtual,
                                                  MaxNumLinhas,
                                                  OutRect.Right - OutRect.Left);
}
                ColumnLineString := DrawEndEllepsis( VisibleColumns[i].Caption,
                                                   OutRect.Right - OutRect.Left);

                // Pinto o titulo da coluna
                if not OnlyCalc then
                  OutCanvas.TextRect( OutRect,
                                      OutRect.Left,
                                      OutRect.Top,
                                      ColumnLineString);

                // Ajusto o Left para a próxima coluna
                OutRect.Left := OutRect.Right + ColumnSeparator;
              end;
           end;
        Inc(LinhaAtual);
      end;
    until (LinhaAtual > MaxNumLinhas);
  finally
    AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X') * (LinhaAtual);
    Result := OutCanvas.TextHeight('X') * (LinhaAtual);
  end;
end;

function TdxDBGridPrint.DrawEndEllepsis(NodeColString: String; NodeColWidth: Integer): String;
var
  EndEllepsisWidth: Integer;
  i: integer;

begin
    // Função que caso texto não vá caber no NodeColWidth, trunca e coloca ...
    if OutCanvas.TextWidth(NodeColString) > NodeColWidth then
      begin
        // Tenho que truncar
        i := Length(NodeColString);
        EndEllepsisWidth := OutCanvas.TextWidth('...');

        while (i > 0)
              AND
              ((OutCanvas.TextWidth(LeftStr(NodeColString, i)) + EndEllepsisWidth) > NodeColWidth) do
          Dec(i);

        Result := LeftStr(NodeColString, i) + '...';

      end
    else
      begin
        // Tudo Ok, a string cabe na width
        Result := NodeColString;
      end;
end;

function TdxDBGridPrint.PrintGroup(ActualNode: TdxTreeListNode; OnlyCalc:Boolean): Integer;

  procedure PrintGroupHeader(GroupHeader: String; Level: Integer);
  var
    OutRect: TRect;
  begin

    OutCanvas.Font.Assign(FImpGrid.Font);
    OutCanvas.Font.Style := OutCanvas.Font.Style + [fsBold];
//    OutCanvas.Font.Size := OutCanvas.Font.Size + 2;

    GroupXY := OutCanvas.TextHeight('X') + 3;
    OutCanvas.Brush.Color := clSilver;

    OutRect.Left := FMarginLeft + (GroupXY * Level);

    OutRect.Top := AmountPrinted + 5;

    OutRect.Bottom        := OutRect.Top + GroupXY;
    OutRect.Right         := PageWidth - FMarginRight;
    OutCanvas.FillRect(OutRect);
    OutCanvas.TextRect( OutRect,
                        OutRect.Left,
                        OutRect.Top,
                        GroupHeader );

    AmountPrinted := AmountPrinted + GroupXY + 4;
    AmountItemPrinted := AmountItemPrinted + GroupXY + 4;


    TestPageBreak;

  end;

var
  i: integer;

begin
   with ActualNode do
     begin
       if HasChildren then
         begin
           // Tem sub itens, devo imprimir o header do grupo
           // devo abrir um laço e ir imprimindo item a item
           PrintGroupHeader(ActualNode.Values[0], ActualNode.Level);

           Result := 0;
           if ActualNode.Expanded then
             for i := 0 to ActualNode.Count - 1 do
               Result := Result + PrintGroup(ActualNode.Items[i], OnlyCalc);

         end
       else
         begin
           // Não tem sub itens
           Result := PrintLine(ActualNode, OnlyCalc);
           TestPageBreak;
         end;
     end;
end;


function TdxDBGridPrint.PrintLine(ActualNode: TdxTreeListNode; OnlyCalc: Boolean): Integer;
var
  OutRect: TRect;
  MaxMemoHeight, MemoHeight, NodeTop, NodeHeight: integer;
  MaxMemoLines: Integer;
  ColumnSeparator: integer;
  NodeColString: String;
  i, j: integer;
begin
  // Seta a fonte da linha
  OutCanvas.Font.Assign(FImpGrid.Font);

  // Calculo a separacao das colunas
  ColumnSeparator := OutCanvas.TextWidth('I');

  // Se o objeto é so saber o tamanho da linha, paro por aqui
  if OnlyCalc then
    begin
      Result := OutCanvas.TextHeight('X');
      Exit;
    end;


  // Antes de imprimir qualquer coisa, devo pesquisar por campos memos, e descobrir o maior deles
  with FImpGrid do
    begin
      MaxMemoLines := 1;
      OutRect.Left := FMarginLeft + (GroupColumnCount * GroupXY);
      for i := 0 to VisibleColumnCount - 1 do
        begin
          OutRect.Right := OutRect.Left + Round(VisibleColumns[i].Width * Fator) - ColumnSeparator;
          (*if (VisibleColumns[i] is TdxDBGridBlobColumn) then
            begin
              slMemo.Clear;
              SplitMemoCanvas( ActualNode.Values[VisibleColumns[i].Index],
                               (OutRect.Right - OutRect.Left),
                               OutCanvas,
                               slMemo);
            end;*)
          OutRect.Left := OutRect.Right + ColumnSeparator;
          if slMemo.Count > MaxMemoLines then
            MaxMemoLines := slMemo.Count;
        end;
    end;

  // Calculo a altura do node
  NodeHeight := MaxMemoLines * OutCanvas.TextHeight('X');
  Result := NodeHeight;


  // Coloco o top onde parou o anterior
  NodeTop := AmountPrinted;


  // Seta a cor da linha
  if Odd(ActualNode.Index) AND FBandsColorEnabled then
    OutCanvas.Brush.Color := FBandsColor2
  else
    OutCanvas.Brush.Color := FBandsColor1;

  // Laço pelas coluna visiveis
  with FImpGrid do
    begin
      // Seto a posicao do Rect da coluna do node
      OutRect.Left := FMarginLeft + (GroupColumnCount * GroupXY);

      for i := 0 to VisibleColumnCount - 1 do
        begin
          // Determino a largura da Coluna, como sendo a lagura do grid
          // vezez o fator pre calculado
          OutRect.Right := OutRect.Left + Round(VisibleColumns[i].Width * Fator);

          // Defino o top e botton
          OutRect.Top := NodeTop;
          OutRect.Bottom := NodeTop + NodeHeight;

          // Preencho todo o espaço com a cor de fundo
          OutCanvas.FillRect(OutRect);

          // Diminuo o espaco disponível para garantir um espaço entre as colunas
          OutRect.Right := OutRect.Left + Round(VisibleColumns[i].Width * Fator) - ColumnSeparator;

          // Tratamento especial para o memo, que pode ter várias linhas
          (*com if (VisibleColumns[i] is TdxDBGridBlobColumn) then
            begin
              // Tratamento especial para memo
              slMemo.Clear;
              SplitMemoCanvas( ActualNode.Values[VisibleColumns[i].Index],
                               (OutRect.Right - OutRect.Left),
                               OutCanvas,
                               slMemo);

              // Agora imprimo cada uma das linhas do string list;
              for j := 0 to (slMemo.Count-1) do
                begin
                  OutRect.Top := NodeTop + (OutCanvas.TextHeight('X') * j);
                  OutRect.Bottom := OutRect.Top + OutCanvas.TextHeight('X');

                  // Imprimo a linha atual,
                  OutCanvas.TextRect( OutRect,
                                      OutRect.Left,
                                      OutRect.Top,
                                      slMemo[j]);
                end;
            end
          else*)
            begin
              // Se o campo não cabe, corto e coloco ...
              NodeColString := DrawEndEllepsis( ActualNode.Values[VisibleColumns[i].Index],
                                                OutRect.Right - OutRect.Left );

              // Pinto a coluna com o alinhamento do grid
              case VisibleColumns[i].Alignment of
                taLeftJustify:  OutCanvas.TextRect( OutRect,
                                                    OutRect.Left,
                                                    OutRect.Top,
                                                    NodeColString);

                taCenter:       OutCanvas.TextRect( OutRect,
                                                    OutRect.Left + Round((OutRect.Right - OutRect.Left - OutCanvas.TextWidth(NodeColString)) / 2),
                                                    OutRect.Top,
                                                    NodeColString);

                taRightJustify: OutCanvas.TextRect( OutRect,
                                                    OutRect.Right - OutCanvas.TextWidth(NodeColString),
                                                    OutRect.Top,
                                                    NodeColString);
              end;
            end;

          // Ajusto o Left para a próxima coluna
          OutRect.Left := OutRect.Right + ColumnSeparator;
        end;

      // Atualizo os totais de impressao
      AmountItemPrinted := AmountItemPrinted + NodeHeight;
      AmountPrinted := AmountPrinted + NodeHeight;
    end;

  Result := NodeHeight;
end;


procedure Register;
begin
  RegisterComponents('NewPower', [TdxDBGridPrint]);
end;

procedure TdxDBGridPrint.CalculaTotalPaginas(Linhas: integer);
var
  ItensOnFirstPage,
  ItensOnOthersPages: integer;

begin
    // Qual o espaço live na primeira página
    FreeOnFirstPage := Printer.PageHeight - MarginTop - MarginBotton;

    if FFirstPageHeader then
      FreeOnFirstPage := FreeOnFirstPage - PrintHeader(True);

    if FFirstPageColumn then
      FreeOnFirstPage := FreeOnFirstPage - PrintColumnNames(True);

    if FFirstPageFooter then
      FreeOnFirstPage := FreeOnFirstPage - PrintFooter(True) * 2;

    // Qual o espaço live nas páginas seguintes
    FreeOnOthersPages := Printer.PageHeight - MarginTop - MarginBotton;

    if FOthersPagesHeader then
      FreeOnOthersPages := FreeOnOthersPages - PrintHeader(True);

    if FOthersPagesColumn then
      FreeOnOthersPages := FreeOnOthersPages - PrintColumnNames(True);

    if FOthersPagesFooter then
      FreeOnOthersPages := FreeOnOthersPages - PrintFooter(True) * 2;

    // Calcula quantos itens cabem na primeira e nas outras paginas

    ItensOnFirstPage    := Trunc(FreeOnFirstPage / PrintLine(nil, True));
    ItensOnOthersPages  := Trunc(FreeOnOthersPages / PrintLine(nil, True));

    if Linhas <= ItensOnFirstPage then
      TotalPaginas := 1
    else
      begin
        TotalPaginas := 1 + Trunc((Linhas - ItensOnFirstPage) / ItensOnOthersPages);
        if ((Linhas - ItensOnFirstPage) mod ItensOnOthersPages) <> 0 then
          TotalPaginas := TotalPaginas + 1;
      end;

end;

procedure TdxDBGridPrint.GetFieldsWithSum(var MyFields: TStringList);
var
  i: integer;

begin
  for i := 0 to FSumCols.Count -1 do
    begin
      if MyFields.IndexOf(FSumCols.Strings[i]) = -1 then
        MyFields.Add(FSumCols.Strings[i]);
    end;

  for i := 0 to FMaxCols.Count - 1 do
    begin
      if MyFields.IndexOf(FMaxCols.Strings[i]) = -1 then
        MyFields.Add(FMaxCols.Strings[i]);
    end;

  for i := 0 to FMinCols.Count - 1 do
    begin
      if MyFields.IndexOf(FMinCols.Strings[i]) = -1 then
        MyFields.Add(FMinCols.Strings[i]);
    end;

  for i := 0 to FAvgCols.Count - 1 do
    begin
      if MyFields.IndexOf(FAvgCols.Strings[i]) = -1 then
        MyFields.Add(FAvgCols.Strings[i]);
    end;
end;

procedure TdxDBGridPrint.PrintTotal;
var
  i: Integer;
  FreeOnPage: Integer;
  OutRect: TRect;

begin
  // Imprime os totais customizados
  with OutCanvas do
    begin
      OutCanvas.Font.Assign(FFooterFont);
      OutCanvas.Pen.Color   := FFooterColor;
      Brush.Style := bsSolid;
      Brush.Color := FFooterColor;
    end;

  // Testa se tem espaco sobrando na página
  if PaginaAtual = 1 then
    FreeOnPage := FreeOnFirstPage - AmountItemPrinted
  else
    FreeOnPage := FreeOnOthersPages - AmountItemPrinted;

  if ((FCustomTot.Count/2 + 2) * OutCanvas.TextHeight('X')) > FreeOnPage then
    begin
      // Quebra a pagina
      PageBreak;
    end;

  AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X')*2;

  for i := 0 to Trunc(FCustomTot.Count/2) - 1 do
    begin
      // Imprime o nome do campo
      OutRect.Left    := FMarginLeft;
      OutRect.Top     := AmountPrinted;
      OutRect.Bottom  := OutRect.Top + OutCanvas.TextHeight('X');
      OutRect.Right   := FMarginLeft + OutCanvas.TextWidth('O CAMPOS MAIS LONGO');
      OutCanvas.TextRect( OutRect,
                          OutRect.Left,
                          OutRect.Top,
                          FCustomTot[i*2] );

      // Caso o Total
      OutRect.Left  := OutRect.Right;
      OutRect.Right := OutRect.Left + OutCanvas.TextWidth('99/99/9999 and 123465');
      OutCanvas.TextRect( OutRect,
                          OutRect.Right - OutCanvas.TextWidth(FCustomTot[i*2 + 1]),
                          OutRect.Top,
                          FCustomTot[i*2 + 1] );

      AmountPrinted := AmountPrinted + OutCanvas.TextHeight('X');
    end;

end;


end.
