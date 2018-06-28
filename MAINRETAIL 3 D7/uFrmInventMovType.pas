unit uFrmInventMovType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, 
  LblEffct, ExtCtrls, FormConfig, Buttons, ADODB, RCADOQuery, PowerADOQuery,
  ComCtrls, siComp, siLangRT;

type
  TbrwFrmInventMovType = class(TbrwFrmParent)
    quFormIDInventMovType: TIntegerField;
    quFormName: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFormSystem: TBooleanField;
    quFormEntrando: TBooleanField;
    quFormUpdateOnHand: TBooleanField;
    quFormUpdateOnOrder: TBooleanField;
    quFormUpdateOnRepair: TBooleanField;
    quFormUpdateOnPrePurchase: TBooleanField;
    quFormUpdateOnPreSale: TBooleanField;
    pgInvType: TPageControl;
    tsInventory: TTabSheet;
    pnlModel: TPanel;
    Label7: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    cbxQtyOnHand: TComboBox;
    cbxQtyOnRepair: TComboBox;
    cbxQtyOnOrder: TComboBox;
    cbxQtyOnPreSale: TComboBox;
    cbxQtyOnPrePurchase: TComboBox;
    tsPreInventory: TTabSheet;
    Panel5: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cbxPreQtyOnHand: TComboBox;
    cbxPreQtyOnRepair: TComboBox;
    cbxPreQtyOnOrder: TComboBox;
    cbxPreQtyOnPreSale: TComboBox;
    cbxPreQtyOnPurchase: TComboBox;
    quFormUpdatePreOnHand: TBooleanField;
    quFormUpdatePreOnOrder: TBooleanField;
    quFormUpdatePreOnRepair: TBooleanField;
    quFormUpdatePreOnPrePurchase: TBooleanField;
    quFormUpdatePreOnPreSale: TBooleanField;
    Label21: TLabel;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure SetEditMode(Sender: TObject);
  private
    { Private declarations }
    procedure SetUpdateInvType(iUpdate : Integer; fField : TField);
    procedure GetUpdateInvType(fField : TField; Combo: TComboBox);
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

procedure TbrwFrmInventMovType.GetUpdateInvType(fField : TField; Combo: TComboBox);
begin

   if fField.AsString = '' then
      Combo.ItemIndex := 2
   else if UpperCase(fField.AsString) = 'TRUE' then
      Combo.ItemIndex := 1
   else if UpperCase(fField.AsString) = 'FALSE' then
      Combo.ItemIndex := 0;


end;

procedure TbrwFrmInventMovType.SetUpdateInvType(iUpdate : Integer; fField : TField);
begin

 If not (quForm.State in dsEditModes) then
    quForm.Edit;

 //Update Type
 // 0 - Debit, 1 - Credit, 2 - NoChange
 Case iUpdate of

    0 : fField.AsBoolean := False;

    1 : fField.AsBoolean := True;

    2 : fField.Clear;

 end;


end;

procedure TbrwFrmInventMovType.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormSystem.AsBoolean := False;
end;

procedure TbrwFrmInventMovType.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1750);
end;

procedure TbrwFrmInventMovType.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  //Get so Updates do inventory
  GetUpdateInvType(quFormUpdateOnHand, cbxQtyOnHand);
  GetUpdateInvType(quFormUpdateOnOrder, cbxQtyOnOrder);
  GetUpdateInvType(quFormUpdateOnRepair, cbxQtyOnRepair);
  GetUpdateInvType(quFormUpdateOnPrePurchase, cbxQtyOnPrePurchase);
  GetUpdateInvType(quFormUpdateOnPreSale, cbxQtyOnPreSale);


  //Get os Updates do Pre inventory Mov
  GetUpdateInvType(quFormUpdatePreOnHand, cbxPreQtyOnHand);
  GetUpdateInvType(quFormUpdatePreOnOrder, cbxPreQtyOnOrder);
  GetUpdateInvType(quFormUpdatePreOnRepair, cbxPreQtyOnRepair);
  GetUpdateInvType(quFormUpdatePreOnPrePurchase, cbxPreQtyOnPurchase);
  GetUpdateInvType(quFormUpdatePreOnPreSale, cbxPreQtyOnPreSale);

end;

procedure TbrwFrmInventMovType.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;


  //Set os valores para o Inventory
  SetUpdateInvType(cbxQtyOnHand.ItemIndex, quFormUpdateOnHand);
  SetUpdateInvType(cbxQtyOnOrder.ItemIndex, quFormUpdateOnOrder);
  SetUpdateInvType(cbxQtyOnRepair.ItemIndex, quFormUpdateOnRepair);
  SetUpdateInvType(cbxQtyOnPrePurchase.ItemIndex, quFormUpdateOnPrePurchase);
  SetUpdateInvType(cbxQtyOnPreSale.ItemIndex, quFormUpdateOnPreSale);

  //SetosValores para p Pre Invenotry
  SetUpdateInvType(cbxPreQtyOnHand.ItemIndex, quFormUpdatePreOnHand);
  SetUpdateInvType(cbxPreQtyOnOrder.ItemIndex, quFormUpdatePreOnOrder);
  SetUpdateInvType(cbxPreQtyOnRepair.ItemIndex, quFormUpdatePreOnRepair);
  SetUpdateInvType(cbxPreQtyOnPurchase.ItemIndex, quFormUpdatePreOnPrePurchase);
  SetUpdateInvType(cbxPreQtyOnPreSale.ItemIndex, quFormUpdatePreOnPreSale);


end;

procedure TbrwFrmInventMovType.SetEditMode(Sender: TObject);
begin
  inherited;
  quForm.Edit;
end;

end.
