unit uFchPurchaseItemNewBarCode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DB, DBTables, Grids, PaiDeForms,
  ADODB, SuperComboADO, siComp, siLangRT, DBGrids, SMDBGrid, mrBarCodeEdit;

type
  TFchPurchaseItemNewBarCode = class(TFrmParentForms)
    Panel1: TPanel;
    //Panel9: TPanel;
    Panel3: TPanel;
    scModel: TSuperComboADO;
    quBarCode: TADOQuery;
    quBarCodeIDModel: TIntegerField;
    quBarCodeIDBarcode: TStringField;
    quBarCodeData: TDateTimeField;
    dsBarCode: TDataSource;
    Label7: TLabel;
    Label6: TLabel;
    Informacao: TImage;
    Titulo: TLabel;
    Label1: TLabel;
    grdHistory: TSMDBGrid;
    btOK: TButton;
    btCancel: TButton;
    lbBarcode: TLabel;
    edtBarCode: TmrBarCodeEdit;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure scModelSelectItem(Sender: TObject);
    procedure edtBarCodeAfterSearchBarcode(Sender: TObject);
    procedure edtBarCodeEnter(Sender: TObject);
    procedure edtBarCodeExit(Sender: TObject);
  private
    { Private declarations }
    ModelID : Integer;
    MyNewBarCode : String;

  public
    { Public declarations }
    function Start(NewBarCode : String)  : integer;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uNumericFunctions, uDMGlobal;

{$R *.DFM}

function TFchPurchaseItemNewBarCode.Start(NewBarCode : String)  : integer;
begin
  MyNewBarCode := NewBarCode;

  if (ShowModal=mrOk) then
    Result := StrToInt(scModel.LookUpValue)
  else
    Result := -1;

end;

procedure TFchPurchaseItemNewBarCode.btOKClick(Sender: TObject);
begin
   ModalResult := mrNone;

   if scModel.LookUpValue = '' then
     begin
       MsgBox(MSG_CRT_NO_MODEL_SELECTED, vbCritical + vbOkOnly);
       scModel.SetFocus;
       Exit;
     end;

   ModalResult := mrOk;
end;

procedure TFchPurchaseItemNewBarCode.btCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TFchPurchaseItemNewBarCode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFchPurchaseItemNewBarCode.FormShow(Sender: TObject);
begin
   inherited;
   edtBarCode.SetFocus;
end;

procedure TFchPurchaseItemNewBarCode.scModelSelectItem(Sender: TObject);
begin
   with quBarcode do
     begin
       Close;
       Parameters.ParamByName('IDModel').Value := MyStrToInt(scModel.LookUpValue);
       Open;
     end;
end;

procedure TFchPurchaseItemNewBarCode.edtBarCodeAfterSearchBarcode(
  Sender: TObject);
begin
  inherited;

  with edtBarcode do
    if SearchResult then
      begin
        scModel.LookUpValue := GetFieldValue('IDModel');
        scModelSelectItem(self);
        Clear;
        btOK.SetFocus; 
      end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);

end;

procedure TFchPurchaseItemNewBarCode.edtBarCodeEnter(Sender: TObject);
begin
  inherited;
  btOK.Default := False;
end;

procedure TFchPurchaseItemNewBarCode.edtBarCodeExit(Sender: TObject);
begin
  inherited;
  btOK.Default := True;
end;

end.
