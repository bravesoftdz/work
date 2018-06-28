unit uFrmCreateModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient;

type
  TFrmCreateModel = class(TForm)
    Panel1: TPanel;
    btnClose: TBitBtn;
    btnSave: TBitBtn;
    btnOpen: TBitBtn;
    gridModelList: TcxGrid;
    gridModelListDBTableView: TcxGridDBTableView;
    gridModelListLevel1: TcxGridLevel;
    gridModelListDBTableViewCategory: TcxGridDBColumn;
    gridModelListDBTableViewModel: TcxGridDBColumn;
    gridModelListDBTableViewDescription: TcxGridDBColumn;
    gridModelListDBTableViewCostPrice: TcxGridDBColumn;
    gridModelListDBTableViewSalePrice: TcxGridDBColumn;
    gridModelListDBTableViewQty: TcxGridDBColumn;
    gridModelListDBTableViewBarcode: TcxGridDBColumn;
    pnlCategory: TPanel;
    cbxTipoNegocio: TComboBox;
    SV: TSaveDialog;
    OP: TOpenDialog;
    btnCopySave: TButton;
    cdsNewModel: TClientDataSet;
    cdsNewModelCategory: TStringField;
    cdsNewModelModel: TStringField;
    cdsNewModelDescription: TStringField;
    cdsNewModelCostPrice: TCurrencyField;
    cdsNewModelSalePrice: TCurrencyField;
    cdsNewModelQty: TFloatField;
    cdsNewModelBarcode: TStringField;
    cdsNewModelSizeAndColor: TBooleanField;
    Button1: TButton;
    cdsNewModelIDModel: TIntegerField;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxTipoNegocioChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnCopySaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Start;
  end;

implementation

uses uDMExport, uDMParent;

{$R *.dfm}

procedure TFrmCreateModel.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCreateModel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree; 
end;

procedure TFrmCreateModel.Start;
begin
  DMExport.OpenCategory;
  DMExport.OpenModel;
  ShowModal;
end;

procedure TFrmCreateModel.cbxTipoNegocioChange(Sender: TObject);
begin
  DMExport.CloseCategory;
  DMExport.OpenCategory;
  DMExport.LoadCategories(cbxTipoNegocio.Text);
end;

procedure TFrmCreateModel.btnSaveClick(Sender: TObject);
var
  FFileName : String;
  FFileData : TStringList;
begin
  SV.InitialDir := DMExport.LocalPath + 'Category';
  SV.FileName   := cbxTipoNegocio.Text + '.xml';
  if SV.Execute then
  begin
    FFileData := TStringList.Create;
    try
      FFileName := SV.FileName;
      FFileData.Text := DMExport.cdsModel.XMLData;
      FFileData.SaveToFile(FFileName);
    finally
      FreeAndNil(FFileData);
    end;
  end;
end;

procedure TFrmCreateModel.btnOpenClick(Sender: TObject);
var
  FFileName : String;
  FFileData : TStringList;
begin
  OP.InitialDir := DMExport.LocalPath + 'Category';
  if OP.Execute then
  begin
    FFileData := TStringList.Create;
    try
      FFileName := OP.FileName;
      FFileData.LoadFromFile(FFileName);
      DMExport.cdsModel.XMLData := FFileData.Text;
    finally
      FreeAndNil(FFileData);
    end;
  end;
end;

procedure TFrmCreateModel.btnCopySaveClick(Sender: TObject);
var
  FFileName : String;
  FFileData : TStringList;
begin
  SV.InitialDir := DMExport.LocalPath + 'Category';
  SV.FileName   := cbxTipoNegocio.Text + '.xml';

  if SV.Execute then
  begin

    FFileData := TStringList.Create;
    try
      if not cdsNewModel.Active then
        cdsNewModel.CreateDataSet;


      DMExport.cdsModel.First;
      while not DMExport.cdsModel.Eof do
      begin
        cdsNewModel.Append;
        cdsNewModel.FieldByName('Category').Value     := DMExport.cdsModel.FieldByName('Category').Value;
        cdsNewModel.FieldByName('Barcode').Value      := DMExport.cdsModel.FieldByName('Barcode').Value;
        cdsNewModel.FieldByName('Model').Value        := DMExport.cdsModel.FieldByName('Model').Value;
        cdsNewModel.FieldByName('Description').Value  := DMExport.cdsModel.FieldByName('Description').Value;
        cdsNewModel.FieldByName('Qty').Value          := DMExport.cdsModel.FieldByName('Qty').Value;
        cdsNewModel.FieldByName('CostPrice').Value    := DMExport.cdsModel.FieldByName('CostPrice').Value;
        cdsNewModel.FieldByName('SalePrice').Value    := DMExport.cdsModel.FieldByName('SalePrice').Value;
        cdsNewModel.FieldByName('SizeAndColor').Value := DMExport.cdsModel.FieldByName('SizeAndColor').Value;
        //DMExport.SizeAndColorCategory(DMExport.cdsModel.FieldByName('Category').Value,s1, s2);
        cdsNewModel.Post;

        DMExport.cdsModel.Next;
      end;


      FFileName := SV.FileName;
      FFileData.Text := cdsNewModel.XMLData;
      FFileData.SaveToFile(FFileName);
    finally
      FreeAndNil(FFileData);
      cdsNewModel.Close;
    end;

  end;
end;

procedure TFrmCreateModel.Button1Click(Sender: TObject);
begin

  DMExport.cdsModel.Edit;
  DMExport.cdsModel.Delete;


 {

  Categoria := DMExport.cdsModel.FieldByName('Category').AsString;

  DMExport.cdsModel.First;

  while not DMExport.cdsModel.EOF do
  begin
    if DMExport.cdsModel.FieldByName('Category').AsString <> Categoria then
    begin
      DMExport.cdsModel.Edit;
      DMExport.cdsModel.Delete;
    end
    else
      Break;
    DMExport.cdsModel.Next;
  end;
  }
end;

end.
