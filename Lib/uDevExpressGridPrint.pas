unit uDevExpressGridPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, dxDBGrid, DB,
  ppCtrls;

type

  TDevExpressGridPrint = class(TComponent)
  private
    { Private declarations }
    FSeparatorSpace : integer;
    FTitleBackColor : TColor;
    ImpDataSource : TDataSource;
    FGridPrint : TdxDBGrid;
    FTitleFont, FItemFont : TFont;
    FFiltro, FTitle, FUsuario : String;
    procedure SetTitleFont(Value : TFont);
    procedure SetItemFont(Value : TFont);
  protected
    { Protected declarations }
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    procedure Print;
  published
    property GridPrint      : TdxDBGrid    read FGridPrint write FGridPrint;
    property ItemFont       : TFont        read FItemFont  write SetItemFont;
    property TitleFont      : TFont        read FTitleFont write SetTitleFont;
    property TitleBackColor : TColor       read FTitleBackColor write FTitleBackColor default clGray;
    property SeparatorSpace : Integer      read FSeparatorSpace write FSeparatorSpace default 4;
    property Title          : String       read FTitle     write FTitle;
    property Usuario        : String       read FUsuario   write FUsuario;
    property Filtro         : String       read FFiltro    write FFiltro;
  end;

procedure Register;

implementation

uses uRptBuildPrintGrid;

constructor TDevExpressGridPrint.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FTitleFont := TFont.Create;
  FItemFont  := TFont.Create;
  FSeparatorSpace := 4;
  FTitleBackColor := clGray;
end;

destructor TDevExpressGridPrint.Destroy;
begin
  FTitleFont.Free;
  FItemFont.Free;
  inherited Destroy;
end;

procedure TDevExpressGridPrint.SetTitleFont(Value : TFont);
begin
  if FTitleFont <> Value then
     FTitleFont.Assign(Value);
end;

procedure TDevExpressGridPrint.SetItemFont(Value : TFont);
begin
  if FItemFont <> Value then
     FItemFont.Assign(Value);
end;

procedure TDevExpressGridPrint.Print;
var
  i : Integer;
  LeftPos, AdjsutSpace, TotWidth : Double;
  OldBM        : TBookMarkStr;
  MyRptBuildPrintGrid : TFrmRptBuildPrintGrid;
begin

  try
    ImpDataSource := FGridPrint.DataSource;
  except
    raise exception.create('GridPrint not declared');
  end;

  // Calcula o tamanho total dos campos para usar no calculo do media ponderada
  TotWidth := 0;
  with FGridPrint do
    begin
      for i := 0 to VisibleColumnCount- 1 do
        TotWidth := TotWidth + VisibleColumns[i].Width;

      // Diminui o espacamento entre campos
      AdjsutSpace := FSeparatorSpace * (VisibleColumnCount - 1);
    end;

  try

    // Cria formulario de relatorio

    // Guarda posicao atual
    OldBM := ImpDataSource.DataSet.Bookmark;

    ImpDataSource.DataSet.DisableControls;
    ImpDataSource.DataSet.First;

    // Cria formulario de relatorio
    MyRptBuildPrintGrid := TFrmRptBuildPrintGrid.Create(Self);

    with MyRptBuildPrintGrid do
       begin
       // Seta o Title e Usuario
       lbTitle.Caption := FTitle;
       lbUser.Caption  := FUsuario;


       // Seta o DataSet
       DBPipeline.DataSource := ImpDataSource;
       DBPipeline.First;


        // Cria os cabecalhos / Colunas
        LeftPos := 0;
        with FGridPrint do
          begin
            for i := 0 to VisibleColumnCount - 1 do
              begin
                // Column Title
                with TppLabel.Create(MyRptBuildPrintGrid) do
                    begin
                    Band      := RptGrid.HeaderBand;
                    Left      := LeftPos;
                    Height    := RptGrid.HeaderBand.Height;
                    Alignment := VisibleColumns[i].Alignment;
                    Color     := FTitleBackColor;
                    Font.Assign(FTitleFont);
                    AutoSize  := False;
                    Width     := Round( (VisibleColumns[i].Width/TotWidth) * ( shpDetail.Width - AdjsutSpace ) );
                    Caption   := VisibleColumns[i].Caption;
                    end;

                // Nodes
                with TppDBText.Create(MyRptBuildPrintGrid) do
                    begin
                    Band      := RptGrid.DetailBand;
                    Left      := LeftPos;
                    Height    := RptGrid.DetailBand.Height;

                    Alignment := VisibleColumns[i].Alignment;

                    Font.Assign(FItemFont);
                    AutoSize    := False;
                    Width       := Round( (VisibleColumns[i].Width/TotWidth) * ( shpDetail.Width - AdjsutSpace ) );
                    Transparent := True;

                    DataPipeLine := DBPipeline;
                    DataField    := VisibleColumns[i].FieldName;
                    end;

                // Total
                if (VisibleColumns[i].Field.DataType in [ftCurrency, ftFloat, ftInteger, ftSmallInt])
                   and
                   (VisibleColumns[i].Field.Index > 0) then
                  begin
                    with TppDBCalc.Create(MyRptBuildPrintGrid) do
                      begin
                        Band      := RptGrid.SummaryBand;
                        Left      := LeftPos;
                        Height    := RptGrid.DetailBand.Height;

                        Alignment := VisibleColumns[i].Alignment;

                        Font.Assign(FItemFont);
                        Font.Style := Font.Style + [fsBold];

                        if VisibleColumns[i].Field.DataType = ftCurrency then
                          begin
                            if TCurrencyField(VisibleColumns[i].Field).Currency then
                              DisplayFormat := '#,#00.00'
                            else
                              DisplayFormat := TNumericField(VisibleColumns[i].Field).DisplayFormat
                          end
                        else
                          DisplayFormat := TNumericField(VisibleColumns[i].Field).DisplayFormat;

                        AutoSize  := False;
                        Width     := Round( (VisibleColumns[i].Width/TotWidth) * ( shpDetail.Width - AdjsutSpace ) );
                        Transparent := True;

                        DataPipeLine := DBPipeline;

                        //DBCalcType := dcSum;
                        DataField  := VisibleColumns[i].FieldName;
                      end;
                  end;

              // Incrementa a posicao a esquerda
              LeftPos := LeftPos + Round( (VisibleColumns[i].Width/TotWidth) * ( shpDetail.Width - AdjsutSpace )) + FSeparatorSpace;

              end;
          end;

        Start(False);

        Free;

       end;

    { //Antigo no QuRep
    with MyRptPowerGridPrint do
      begin
        // Seta o Title e Usuario
        ReportTitle        := FTitle;
        lblUsuario.Caption := FUsuario;
        lblFiltro.Caption  := FFiltro;

        // Seta o DataSet
        DataSet := ImpDataSet;

        // Cria os cabecalhos / Colunas
        LeftPos := 0;
        with FGridPrint do
          begin
            for i := 0 to VisibleColumnCount - 1 do
              begin
                // Column Title
                with TQRLabel.Create(MyRptPowerGridPrint) do
                  begin
                    Parent    := ColumnHeaderBand;
                    Left      := LeftPos;
                    Height    := ColumnHeaderBand.Height;
                    Alignment := VisibleColumns[i].Alignment;
                    Color     := FTitleBackColor;
                    Font.Assign(FTitleFont);
                    AutoSize  := False;
                    Width     := Round( (VisibleColumns[i].Width/TotWidth) * ( ColumnHeaderBand.Width - AdjsutSpace ) );
                    Caption   := VisibleColumns[i].Caption;
                  end;

                // Nodes
                with TQRDBText.Create(MyRptPowerGridPrint) do
                  begin
                    Parent    := DetailBand;
                    Left      := LeftPos;
                    Height    := DetailBand.Height-3;

                    Alignment := VisibleColumns[i].Alignment;

                    Font.Assign(FItemFont);
                    AutoSize  := False;
                    Width     := Round( (VisibleColumns[i].Width/TotWidth) * ( DetailBand.Width - AdjsutSpace ) );
                    Transparent := True;

                    DataSet   := ImpDataSet;
                    DataField := VisibleColumns[i].FieldName;
                  end;

                // Total
                if (VisibleColumns[i].Field.DataType in [ftCurrency, ftFloat, ftInteger, ftSmallInt])
                   and
                   (VisibleColumns[i].Field.Index > 0) then
                  begin
                    with TQRExpr.Create(MyRptPowerGridPrint) do
                      begin
                        Parent    := SummaryBand;
                        Left      := LeftPos;
                        Height    := DetailBand.Height-3;

                        Alignment := VisibleColumns[i].Alignment;

                        Font.Assign(FItemFont);
                        Font.Style := Font.Style + [fsBold];

                        if VisibleColumns[i].Field.DataType = ftCurrency then
                          begin
                            if TCurrencyField(VisibleColumns[i].Field).Currency then
                              Mask := '#,#00.00'
                            else
                              Mask := TNumericField(VisibleColumns[i].Field).DisplayFormat
                          end
                        else
                          Mask := TNumericField(VisibleColumns[i].Field).DisplayFormat;

                        AutoSize  := False;
                        Width     := Round( (VisibleColumns[i].Width/TotWidth) * ( DetailBand.Width - AdjsutSpace ) );
                        Transparent := True;

                        Expression := 'SUM(' + VisibleColumns[i].FieldName + ')';

                      end;
                  end;

                // Incrementa a posicao a esquerda
                LeftPos := LeftPos + Round( (VisibleColumns[i].Width/TotWidth) * ( DetailBand.Width - AdjsutSpace )) + FSeparatorSpace;
              end;
          end;

        Preview;

        Free;
      end; }

  finally
    // Restaura posicao
    //ImpDataSet.BookMark := OldBM; #Antigo
    ImpDataSource.DataSet.Bookmark := OldBM;

    //ImpDataSet.EnableControls; #Antigo
    ImpDataSource.DataSet.EnableControls;
  end;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TDevExpressGridPrint]);
end;

end.
