unit uPOSSalesExplorer;

interface

uses SysUtils, Forms, Variants, Classes, Windows, DBClient, DB, uFilePersistence;

const
  IDX_NAME = 'IDX_Line';

type
  TPOSSalesExplorer = class
    private
      FCashList: TStringlist;
      FBeginDate: TDateTime;
      FEndDate: TDateTime;
      FBasePath: TStringList;
      FCDSSales: TClientDataSet;
      FCDStore: TClientDataSet;
      FCDModel: TClientDataSet;
      FSaleLineType: TSaleLineType;
      FStoreFile: String;
      FModelFile: String;
      procedure GetSaleFilesNames(const SubDir: String; var AFileList: TStringList);
      procedure InitializeClientDataset;
      procedure ProcessSaleFiles(AFileList: TStringList);
      procedure ProcessLines(ALineList: TStringList);
      procedure ProcessSaleLines(ALineList: TStringList);
      procedure AddSaleLine(RAI: TRegAddItem);
      procedure AddSaleRemovedLine(RRI: TRegRemovedItem);
      procedure LoadModelFile(const Value: String);
      procedure LoadStoreFile(const Value: String);
    public
      constructor Create;
      destructor Destroy; override;

      property CashList:     TStringlist   read FCashList     write FCashList;
      property BeginDate:    TDateTime     read FBeginDate    write FBeginDate;
      property EndDate:      TDateTime     read FEndDate      write FEndDate;
      property BasePath:     TStringList   read FBasePath     write FBasePath;
      property SaleLineType: TSaleLineType read FSaleLineType write FSaleLineType;
      property StoreFile:    String        read FStoreFile    write LoadStoreFile;
      property ModelFile:    String        read FModelFile    write LoadModelFile;

      function GetSaleItems: OleVariant;
  end;

implementation

uses uFileFunctions;

{ TPOSSalesExplorer }

procedure TPOSSalesExplorer.AddSaleLine(RAI: TRegAddItem);
var
  dtMovDate: TDateTime;
begin
  dtMovDate := Trunc(RAI.AMovDate);

  if FCDSSales.Locate('IDStore;SaleDate;IDModel', VarArrayOf([RAI.AIDStore, dtMovDate, RAI.AIDModel]), []) then
    begin
      FCDSSales.Edit;
    end
  else
    begin
      FCDSSales.Append;
      FCDSSales.FieldByName('IDStore').Value := RAI.AIDStore;
      FCDSSales.FieldByName('SaleDate').Value := Trunc(RAI.AMovDate);
      FCDSSales.FieldByName('SaleTime').Value := Trunc(Frac(RAI.AMovDate) * 24) /24;
      FCDSSales.FieldByName('IDModel').Value := RAI.AIDModel;

      if FCDStore.Active and FCDStore.Locate('IDStore', RAI.AIDStore, []) then
        FCDSSales.FieldByName('Store').Value := FCDStore.FieldByName('Name').AsString;

      if FCDModel.Active and FCDModel.Locate('IDModel', RAI.AIDModel, []) then
      begin
        FCDSSales.FieldByName('Category').Value    := FCDModel.FieldByName('TabGroup').Value;
        FCDSSales.FieldByName('Vendor').Value      := FCDModel.FieldByName('Fornecedor').Value;
        FCDSSales.FieldByName('Model').Value       := FCDModel.FieldByName('Model').Value;
        FCDSSales.FieldByName('Description').Value := FCDModel.FieldByName('Description').Value;
        FCDSSales.FieldByName('Manufacture').Value := FCDModel.FieldByName('Fabricante').Value;
      end;
    end;

  FCDSSales.FieldByName('Venda').AsCurrency :=
    FCDSSales.FieldByName('Venda').AsCurrency + (RAI.ASale * RAI.AQty) - RAI.ADiscount;

  FCDSSales.FieldByName('Custo').AsCurrency :=
    FCDSSales.FieldByName('Custo').AsCurrency + (RAI.ACost * RAI.AQty);

  FCDSSales.FieldByName('Qtd').AsFloat := FCDSSales.FieldByName('Qtd').AsFloat + RAI.AQty;

  FCDSSales.Post;

end;

procedure TPOSSalesExplorer.AddSaleRemovedLine(RRI: TRegRemovedItem);
var
  dtMovDate: TDateTime;
begin
  dtMovDate := Trunc(RRI.AMovDate);

  {if FCDSSales.Locate('IDStore;SaleDate;IDModel', VarArrayOf([RRI.AIDStore, dtMovDate, RRI.AIDModel]), []) then
    begin
      FCDSSales.Edit;
    end
  else
    begin}
      FCDSSales.Append;
      FCDSSales.FieldByName('IDStore').Value := RRI.AIDStore;
      FCDSSales.FieldByName('SaleDate').Value := Trunc(RRI.AMovDate);
      FCDSSales.FieldByName('SaleTime').Value := Trunc(Frac(RRI.AMovDate) * 24) / 24;
      FCDSSales.FieldByName('IDModel').Value := RRI.AIDModel;
    {end;}

  FCDSSales.FieldByName('Venda').AsCurrency :=
    FCDSSales.FieldByName('Venda').AsCurrency + (RRI.ASale * RRI.AQty) - RRI.ADiscount;

  FCDSSales.FieldByName('Custo').AsCurrency :=
    FCDSSales.FieldByName('Custo').AsCurrency + (RRI.ACost * RRI.AQty);

  FCDSSales.FieldByName('Qtd').AsFloat := FCDSSales.FieldByName('Qtd').AsFloat + RRI.AQty;

  if FCDStore.Active and FCDStore.Locate('IDStore', RRI.AIDStore, []) then
    FCDSSales.FieldByName('Store').Value := FCDStore.FieldByName('Name').AsString;

  if FCDModel.Active and FCDModel.Locate('IDModel', RRI.AIDModel, []) then
  begin
    FCDSSales.FieldByName('Category').Value    := FCDModel.FieldByName('TabGroup').Value;
    FCDSSales.FieldByName('Vendor').Value      := FCDModel.FieldByName('Fornecedor').Value;
    FCDSSales.FieldByName('Model').Value       := FCDModel.FieldByName('Model').Value;
    FCDSSales.FieldByName('Description').Value := FCDModel.FieldByName('Description').Value;
    FCDSSales.FieldByName('Manufacture').Value := FCDModel.FieldByName('Fabricante').Value;
  end;


  FCDSSales.Post;
end;

constructor TPOSSalesExplorer.Create;
begin
  inherited Create;
  FCashList := TStringlist.Create;
  FCDSSales := TClientDataSet.Create(nil);
  FCDStore  := TClientDataSet.Create(nil);
  FCDModel  := TClientDataSet.Create(nil);
end;

destructor TPOSSalesExplorer.Destroy;
begin
  FCashList.Free;
  FCDSSales.Free;
  FCDStore.Free;
  FCDModel.Free;
  inherited Destroy;
end;

procedure TPOSSalesExplorer.GetSaleFilesNames(const SubDir: String; var AFileList: TStringList);
var
  SR: TSearchRec;
  strFileDate: String;
  dtFiledate: TDateTime;
  Year, Month, Day: Word;
  i : Integer;
begin
  AFileList.Clear;

  for i := 0 to FBasePath.Count-1 do
    if FindFirst(FBasePath.Strings[i] + SubDir + '\*.ven', faAnyFile, SR) = 0 then
    begin
      repeat
        if ((SR.Attr and faDirectory) <> SR.Attr) then
        begin
          strFileDate := Copy(SR.Name, Length(SR.Name) - 18, 15);

          Year  := StrToInt(Copy(strFileDate, 1, 4));
          Month := StrToInt(Copy(strFileDate, 5, 2));
          Day   := StrToInt(Copy(strFileDate, 7, 2));

          dtFiledate := EncodeDate(Year, Month, Day);

          if (dtFiledate >= FBeginDate) and (dtFiledate <= FEndDate) then
            AFileList.Add(FBasePath.Strings[i] + SubDir + '\' + SR.Name);
        end;
      until (FindNext(SR) <> 0);
      SysUtils.FindClose(SR);
    end;
end;

function TPOSSalesExplorer.GetSaleItems: OleVariant;
var
  I : Integer;
  stlFiles: TStringList;
begin
  Result := Null;
  try
    if not (SaleLineType in [sltAddItem, sltRemovedItem]) then
      raise Exception.Create('Invalid Sale Line Type Parameter'); 
    stlFiles := TStringList.Create;
    try
      InitializeClientDataset;
      try

        for I := 0 to Pred(FCashList.Count) do
        begin
          GetSaleFilesNames(FCashList[I], stlFiles);
          ProcessSaleFiles(stlFiles);
        end;

        Result := FCDSSales.Data;
      finally
        FCDSSales.Close;
      end;
    finally
      stlFiles.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar(E.message), 'Erro processando', MB_ICONERROR + MB_OK);
  end;
end;

procedure TPOSSalesExplorer.InitializeClientDataset;
var
  TimeField: TDateTimeField;
  CurrencyField: TCurrencyField;
begin
  FCDSSales.IndexName := '';
  FCDSSales.Close;

  FCDSSales.FieldDefs.Clear;
  FCDSSales.FieldDefs.Add('IDStore', ftInteger);
  FCDSSales.FieldDefs.Add('IDModel', ftInteger);
  FCDSSales.FieldDefs.Add('Custo', ftCurrency);
  FCDSSales.FieldDefs.Add('Venda', ftCurrency);
  FCDSSales.FieldDefs.Add('SaleDate', ftDate);
  FCDSSales.FieldDefs.Add('SaleTime', ftTime);
  FCDSSales.FieldDefs.Add('Qtd', ftFloat);

  FCDSSales.FieldDefs.Add('Store', ftString, 30);

  FCDSSales.FieldDefs.Add('Category', ftString, 50);
  FCDSSales.FieldDefs.Add('Vendor', ftString, 50);
  FCDSSales.FieldDefs.Add('Model', ftString, 30);
  FCDSSales.FieldDefs.Add('Description', ftString, 60);
  FCDSSales.FieldDefs.Add('Manufacture', ftString, 50);

  FCDSSales.CreateDataSet;

  TimeField := TDateTimeField(FCDSSales.FieldByName('SaleTime'));
  TimeField.DisplayFormat := 'hh:nn:ss';

  CurrencyField := TCurrencyField(FCDSSales.FieldByName('Custo'));
  CurrencyField.DisplayFormat := '#,##0.00';

  CurrencyField := TCurrencyField(FCDSSales.FieldByName('Venda'));
  CurrencyField.DisplayFormat := '#,##0.00';

  FCDSSales.AddIndex(IDX_NAME, 'IDStore;SaleDate;IDModel', [ixPrimary]);
  FCDSSales.IndexName := IDX_NAME;
end;

procedure TPOSSalesExplorer.LoadModelFile(const Value: String);
begin
  FModelFile := Value;

  if FModelFile <> '' then
    FCDModel.LoadFromFile(FModelFile);
end;

procedure TPOSSalesExplorer.LoadStoreFile(const Value: String);
begin
  FStoreFile := Value;

  if FStoreFile <> '' then
    FCDStore.LoadFromFile(FStoreFile);
end;

procedure TPOSSalesExplorer.ProcessLines(ALineList: TStringList);
var
  I, j, iCancelItem, iCanceledItems: Integer;
  sltLinha: TSaleLineType;
  slpArquivo: TSaleLineParser;
  stlSalesLines: TStringList;
  stlCancelItems : TStringList;
begin
  slpArquivo := TSaleLineParser.Create;
  stlSalesLines := TStringList.Create;
  stlCancelItems := TStringList.Create;
  try
    for I := 0 to Pred(ALineList.Count) do
    begin
      sltLinha := slpArquivo.LineType(ALineList[I]);

      case sltLinha of
        sltAddItem, sltRemovedItem:
          stlSalesLines.Add(ALineList[I]);

        sltCancelItem:
        begin
          slpArquivo.GetItemCanceled(ALineList[I], iCancelItem);
          stlCancelItems.Add(IntToStr(iCancelItem-1));
          Inc(iCanceledItems);
        end;

        sltOpenSale, sltAbortSale, sltCancelSale:
        begin
          iCanceledItems := 0;
          stlSalesLines.Clear;
          stlCancelItems.Clear;
        end;

        sltCloseSale:
        begin
          if stlCancelItems.Count > 0 then
          begin
            stlCancelItems.Sort;
            for j := stlCancelItems.Count-1 downto 0 do
              stlSalesLines.Delete(StrToInt(stlCancelItems.Strings[j]));
            stlCancelItems.Clear;
          end;

          ProcessSaleLines(stlSalesLines);
        end;
      end;
    end;
  finally
    slpArquivo.Free;
    stlSalesLines.Free;
    stlCancelItems.Free;
  end;
end;

procedure TPOSSalesExplorer.ProcessSaleFiles(AFileList: TStringList);
var
  I : Integer;
  stlLines: TStringList;
begin
  for I := 0 to Pred(AFileList.Count) do
  begin
    stlLines := TStringList.Create;
    try
      LoadFileNoLock(stlLines, AFileList[I]);
      ProcessLines(stlLines);

    finally
      FreeAndNil(stlLines);
    end;
  end;
end;


procedure TPOSSalesExplorer.ProcessSaleLines(ALineList: TStringList);
var
  I : Integer;
  sltLinha: TSaleLineType;
  slpArquivo: TSaleLineParser;
  RAI: TRegAddItem;
  RRI: TRegRemovedItem;
begin
  slpArquivo := TSaleLineParser.Create;
  try
    for I := 0 to Pred(ALineList.Count) do
    begin
      sltLinha := slpArquivo.LineType(ALineList[I]);

      if sltLinha = FSaleLineType then
      begin
        case sltLinha of
          sltAddItem:
          begin
            slpArquivo.GetAddItem(ALineList[I], RAI);
            AddSaleLine(RAI);
          end;
          sltRemovedItem:
          begin
            slpArquivo.GetRemovedItem(ALineList[I], RRI);
            AddSaleRemovedLine(RRI);
          end;
        end;
      end;
    end;
  finally
    slpArquivo.Free;
  end;
end;

end.
