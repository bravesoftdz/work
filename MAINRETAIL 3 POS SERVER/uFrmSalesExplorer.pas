unit uFrmSalesExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DateBox, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, dximctrl, DBClient,
  Buttons, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  CheckLst, siComp, uPOSSalesExplorer, uPOSServerConsts;

type
  TfrmSalesExplorer = class(TForm)
    pnlFilter: TPanel;
    pnlGrid: TPanel;
    grdSaleItemsDBTableView: TcxGridDBTableView;
    grdSaleItemsLevel: TcxGridLevel;
    grdSaleItems: TcxGrid;
    cdsSaleItems: TClientDataSet;
    dsSaleItems: TDataSource;
    clbCashReg: TCheckListBox;
    Label1: TLabel;
    edtBeginDate: TDateBox;
    Label2: TLabel;
    edtEndDate: TDateBox;
    btnRefresh: TBitBtn;
    Label3: TLabel;
    grdSaleItemsDBTableViewIDStore: TcxGridDBColumn;
    grdSaleItemsDBTableViewSaleDate: TcxGridDBColumn;
    grdSaleItemsDBTableViewIDModel: TcxGridDBColumn;
    grdSaleItemsDBTableViewVenda: TcxGridDBColumn;
    grdSaleItemsDBTableViewCusto: TcxGridDBColumn;
    grdSaleItemsDBTableViewQtd: TcxGridDBColumn;
    cdsCashRegister: TClientDataSet;
    grdSaleItemsDBTableViewFabricante: TcxGridDBColumn;
    Panel1: TPanel;
    btnColumn: TSpeedButton;
    btnGroup: TSpeedButton;
    cbxLanguage: TdxImageComboBox;
    SD: TSaveDialog;
    Panel2: TPanel;
    Bevel1: TBevel;
    btnClose: TBitBtn;
    siLang: TsiLang;
    grdSaleItemsDBTableViewVendor: TcxGridDBColumn;
    grdSaleItemsDBTableViewCategory: TcxGridDBColumn;
    lblType: TLabel;
    cmbItemType: TComboBox;
    grdSaleItemsDBTableViewSaleTime: TcxGridDBColumn;
    grdSaleItemsDBTableViewModel: TcxGridDBColumn;
    procedure btnRefreshClick(Sender: TObject);
    procedure cbxLanguageChange(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure btnColumnClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure VerifyItens;
    function VerifyCheckList(Item : Integer): Boolean;
  private
    sPDVFilesPath: String;
    POSSE: TPOSSalesExplorer;
    procedure CreatePOSSalesExplorer;
  public
    procedure Start;
  end;

implementation

uses uDMGlobal, cxExportGrid4Link,
  uFilePersistence;

{$R *.dfm}

procedure TfrmSalesExplorer.Start;
begin
  cmbItemType.ItemIndex := 0;
  sPDVFilesPath := ExtractFilePath(Application.ExeName) + PDV_GLOBAL_DIR;

  edtBeginDate.Date := Date;
  edtEndDate.Date := Date;

  clbCashReg.Clear;

  cdsCashRegister.LoadFromFile(sPDVFilesPath + '\CashRegister.xml');

  try
    while not cdsCashRegister.Eof do
    begin
      clbCashReg.AddItem(cdsCashRegister.FieldByName('Name').AsString, TObject(Pointer(cdsCashRegister.FieldByName('IDCashRegister').AsInteger)));
      cdsCashRegister.Next;
    end;
  finally
    cdsCashRegister.Close;
  end;

  ShowModal;
end;

procedure TfrmSalesExplorer.btnRefreshClick(Sender: TObject);
var
  I: Integer;
  sDirList : TStringList;
begin

  CreatePOSSalesExplorer;
  sDirList := TStringList.Create;
  try
    Screen.Cursor := crHourGlass;

    try
      sDirList.Add(ExtractFilePath(Application.ExeName) + POS_DIR_FILES);
      sDirList.Add(ExtractFilePath(Application.ExeName) + POS_DIR_FILES_HISTORY);

      POSSE.BasePath     := sDirList;
      POSSE.BeginDate    := Trunc(edtBeginDate.Date);
      POSSE.EndDate      := Trunc(edtEndDate.Date);

      case cmbItemType.ItemIndex of
        0: POSSE.SaleLineType := sltAddItem;
        1: POSSE.SaleLineType := sltRemovedItem;
      end;

      for I := 0 to Pred(clbCashReg.Count) do
        if clbCashReg.Checked[I] then
          POSSE.CashList.Add(IntToStr(LongInt(clbCashReg.Items.Objects[I])));

      try
        Screen.Cursor := crHourGlass;
        cdsSaleItems.Data := POSSE.GetSaleItems;
      finally
        Screen.Cursor := crDefault;
        end;

      VerifyItens;

    except
      on E: Exception do
        MessageDlg('Ocorreu um erro ao carregar as vendas. Erro: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(POSSE);
    FreeAndNil(sDirList);
  end;
end;

procedure TfrmSalesExplorer.cbxLanguageChange(Sender: TObject);
var
  sFilter, sExt : String;
begin
  inherited;

  if cbxLanguage.ItemIndex = -1 then
     begin
     MessageDlg('Invalido!!!', mtError, [mbOK], 0);
     cbxLanguage.SetFocus;
     Exit;
     end;

  Case cbxLanguage.ItemIndex of
     0 : begin
         sFilter := 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls';
         sExt    := 'xls';
         end;
     1 : begin
         sFilter := 'HTML File (*.htm; *.html)|*.htm';
         sExt    := 'htm';
         end;
     2 : begin
         sFilter := 'XML File (*.xml)|*.xml';
         sExt    := 'xml';
         end;
     3 : begin
         sFilter := 'Text document (*.txt)|*.txt';
         sExt    := 'txt';
         end;
  end;

  with SD do
    begin
    DefaultExt := sExt;
    Filter     := sFilter;
    FileName   := 'Vendas em '+FormatDateTime('dd-mm-yy', Date)+'.'+sExt;

    if Execute then
      begin
      Case cbxLanguage.ItemIndex of
        0 : ExportGrid4ToExcel(FileName, grdSaleItems, True, True, False);
        1 : ExportGrid4ToHTML(FileName, grdSaleItems, True, True);
        2 : ExportGrid4ToXML(FileName, grdSaleItems, True, True);
        3 : ExportGrid4ToText(FileName, grdSaleItems, True, True, '','','');
        end;
      Close;
      end;
    end;

end;

procedure TfrmSalesExplorer.btnGroupClick(Sender: TObject);
begin
  TcxGridDBTableView(grdSaleItems.FocusedView).OptionsView.GroupByBox := not
      TcxGridDBTableView(grdSaleItems.FocusedView).OptionsView.GroupByBox;
end;

procedure TfrmSalesExplorer.btnColumnClick(Sender: TObject);
begin
  TcxGridDBTableView(grdSaleItems.FocusedView).Controller.Customization := not
       TcxGridDBTableView(grdSaleItems.FocusedView).Controller.Customization;
end;

procedure TfrmSalesExplorer.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSalesExplorer.VerifyItens;
Var
  i : Integer;
begin
  if VerifyCheckList(i) = False then
    MessageDlg('Nenhum caixa selecionado.', mtInformation, [mbOK], 0)
  else if edtBeginDate.Date > edtEndDate.Date then
    MessageDlg('Data inicial não pode ser maior que a final.', mtInformation, [mbOK], 0)
  else if cdsSaleItems.RecordCount = 0 then
    MessageDlg('Nenhuma venda neste período.', mtInformation, [mbOK], 0);
end;

function TfrmSalesExplorer.VerifyCheckList(Item: Integer): Boolean;
begin
  Result := False;
  cdsCashRegister.Open;
  for Item := 0 to cdsCashRegister.RecordCount -1 do
    if clbCashReg.Checked[Item] then
      Result := True;
  cdsCashRegister.Close;
end;

procedure TfrmSalesExplorer.CreatePOSSalesExplorer;
begin

  if POSSE = nil then
    POSSE := TPOSSalesExplorer.Create;

  //Carrego os CDS alternativos
  POSSE.StoreFile := sPDVFilesPath + 'Store.xml';
  POSSE.ModelFile := sPDVFilesPath + 'Model.xml';

end;

end.
