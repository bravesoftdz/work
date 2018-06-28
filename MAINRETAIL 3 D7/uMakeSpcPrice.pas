unit uMakeSpcPrice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DB, DBTables, DBCtrls, Grids, DBGrids,
  ADODB, siComp, siLangRT, PaideForms;

type
  TFrmMakeSpcPrice = class(TFrmParentForms)
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    quSpecialPrice: TADOQuery;
    dsSpecialPrice: TDataSource;
    quSpecialPriceIDSpecialPrice: TIntegerField;
    quSpecialPriceSpecialPrice: TStringField;
    ListPrice: TListBox;
    btOK: TButton;
    btCancel: TButton;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sManagerAuto,
    sSelectSP,
    sNone : String;

    MyIDPreSale, MySpecialPriceID : Integer;
  public
    { Public declarations }
    function Start(IDPreSale, SpecialPriceID : Integer) : Boolean;
  end;

implementation

uses uDM, uPassword, uAskManager, uInvoice, uDMGlobal, uMsgBox, uMsgConstant,
     uSystemConst;


{$R *.DFM}

function TFrmMakeSpcPrice.Start(IDPreSale, SpecialPriceID : Integer ) : Boolean;
begin
  MyIDPreSale := IDPreSale;
  MySpecialPriceID := SpecialPriceID;
  Result   := True;

  // Testa se tem senha de Manager
  if (not Password.HasFuncRight(12)) then
    begin
      with TFrmAskManager.Create(Self) do
         Result := Start(sManagerAuto);
    end;

  if Result then
     Result := (ShowModal = mrOK);
end;

procedure TFrmMakeSpcPrice.btOKClick(Sender: TObject);
var
  frmInvoiceAux : TfrmInvoice;
  bTaxExempt : Boolean;
begin
   if ListPrice.ItemIndex < 0 then
      raise exception.create(sSelectSP);

   // Acha o item selecionado

   bTaxExempt := DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE];

   if ListPrice.ItemIndex > 0 then
      begin
      quSpecialPrice.Locate('SpecialPrice', ListPrice.Items[ListPrice.ItemIndex],
                            [locaseInsensitive]);
      DM.fPOS.AddSpecialPrice(MyIDPreSale, quSpecialPriceIDSpecialPrice.AsInteger, Now, bTaxExempt);
      SpecialPrice := ListPrice.ItemIndex;
      end
   else
      DM.fPOS.DeleteSpecialPrice(MyIDPreSale, Now, bTaxExempt);

   ModalResult := mrOK;
end;

procedure TFrmMakeSpcPrice.FormShow(Sender: TObject);
begin
  inherited;

  quSpecialPrice.Open;
  // carrega o list box
  ListPrice.Items.Clear;
  with quSpecialPrice do
   begin
     First;
     ListPrice.Items.Add(sNone);
     ListPrice.ItemIndex := 0;
     while not eof do
      begin
       ListPrice.Items.Add(quSpecialPriceSpecialPrice.AsString);
       if quSpecialPriceIDSpecialPrice.AsInteger = MySpecialPriceID then
          ListPrice.ItemIndex := ListPrice.Items.Count-1;
       Next;
      end;
   end;

  btOk.SetFocus;
end;

procedure TFrmMakeSpcPrice.btCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TFrmMakeSpcPrice.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  quSpecialPrice.Close;
  Action := caFree;
  Screen.Cursor := crDefault;
end;

procedure TFrmMakeSpcPrice.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sManagerAuto := 'To Make Special Prices you should have the Manager Authorization.';
           sSelectSP    := 'Select a special price.';
           sNone        := '<none>';
           end;

     LANG_PORTUGUESE :
           begin
           sManagerAuto := 'Para aplicar um Desconto Especial você precisa da autorização do Gerente.';
           sSelectSP    := 'Selecione um Preço Especial.';
           sNone        := '<nada>';
           end;

     LANG_SPANISH :
           begin
           sManagerAuto := 'Para aplicar un Descuento Especial usted necesita de la autorización del Gerente.';
           sSelectSP    := 'Seleccione un Precio Especial.';
           sNone        := '<ninguno>';
           end;
           
   end;


end;

end.
