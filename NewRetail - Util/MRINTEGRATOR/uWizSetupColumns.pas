unit uWizSetupColumns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizard, ImgList, StdCtrls, ExtCtrls, ComCtrls, Grids, uMas90, DB,
  ADODB, Buttons, dxDBTLCl, dxGrClms, dxTL,
  dxDBCtrl, dxDBGrid, dxCntner, siComp, uRegistry;


type
  TWizSetupColumns = class(TParentWizard)
    tsSoftware: TTabSheet;
    tsOption: TTabSheet;
    tsColumn: TTabSheet;
    treeSoftware: TTreeView;
    Label20: TLabel;
    sgColumns: TStringGrid;
    cbColumns: TComboBox;
    lbColumnInfo: TLabel;
    lbSoftware: TLabel;
    OD: TOpenDialog;
    Panel2: TPanel;
    sbOpenFile: TSpeedButton;
    edtPath: TEdit;
    Label2: TLabel;
    cbxFileType: TComboBox;
    Label3: TLabel;
    Label1: TLabel;
    procedure sbOpenFileClick(Sender: TObject);
    procedure sgColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure treeSoftwareClick(Sender: TObject);
    procedure cbColumnsChange(Sender: TObject);
    procedure cbColumnsExit(Sender: TObject);
    procedure cbxFileTypeChange(Sender: TObject);
  private
    { Private declarations }
    fMas90             : TMas90;
    procedure AddMas90ColumnsToImportExport;
    procedure FillMas90ColumnsGrid;
    procedure FillColumnGrid;
    procedure SaveGridColumn;
    procedure GetGridColumn;
    function HasValidHeader:Boolean;
  protected
    procedure OnAfterDoFinish; override;
    procedure OnBeforeBackClick; override;
    function TestBeforeNavigate:Boolean; override;
    function DoFinish:Integer; override;
    function OnAfterChangePage:Boolean; override;
    procedure ClearColumns;
  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uNumericFunctions, uParamFunctions, uDM; //uMsgConstant;

{$R *.DFM}

{ TWizSetupColumns }

procedure TWizSetupColumns.AddMas90ColumnsToImportExport;
begin
  if not Assigned(fMas90) then
     fMas90 := fMas90.Create;                  

  with fMas90 do
     begin

     ClearColumnsToImport;

      case DM.iEntityType of

       ENTITY_CUSTOMER :
              begin
              //AddColumnToImport(Mas90_COL_ENTITY_Division_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_No);
              AddColumnToImport(Mas90_COL_ENTITY_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Address_1);
              AddColumnToImport(Mas90_COL_ENTITY_Address_2);
              AddColumnToImport(Mas90_COL_ENTITY_City);
              AddColumnToImport(Mas90_COL_ENTITY_State);
              AddColumnToImport(Mas90_COL_ENTITY_Zip_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Phone_No);
              //AddColumnToImport(Mas90_COL_ENTITY_Terms_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Country_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Schedule);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Exempt_No);
              AddColumnToImport(Mas90_COL_ENTITY_Shipping_Method);
              AddColumnToImport(Mas90_COL_ENTITY_Fax_Number);
              AddColumnToImport(Mas90_COL_ENTITY_Email_Address);
              //AddColumnToImport(Mas90_COL_ENTITY_Salesprsn_No);
              AddColumnToImport(Mas90_COL_ENTITY_Default_SLS_CD);
              AddColumnToImport(Mas90_COL_ENTITY_Cust_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Price_Level);
              end;

       ENTITY_PAYMENT :
              begin
              AddColumnToImport(Mas90_COL_ENTITY_Bank_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Deposit_Number);
              //AddColumnToImport(Mas90_COL_ENTITY_Division_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Batch_Number);
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_No);
              AddColumnToImport(Mas90_COL_ENTITY_Amount_Posted);
              AddColumnToImport(Mas90_COL_ENTITY_Dep_Post_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Document_No);
              AddColumnToImport(Mas90_COL_ENTITY_Deposit_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Payment_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Deposit_Balance);
              AddColumnToImport(Mas90_COL_ENTITY_Cust_Post_Amt);
              end;

       ENTITY_SALE_INVOICE :
              begin
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_No);
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_Date);
              //AddColumnToImport(Mas90_COL_ENTITY_Division_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_No);
              //AddColumnToImport(Mas90_COL_ENTITY_Default_Whse);
              //AddColumnToImport(Mas90_COL_ENTITY_Tax_Schedule);
              //AddColumnToImport(Mas90_COL_ENTITY_Terms_Code);
              //AddColumnToImport(Mas90_COL_ENTITY_Salesprsn);
              AddColumnToImport(Mas90_COL_ENTITY_Line_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Item_Number);
              AddColumnToImport(Mas90_COL_ENTITY_Discount);
              //AddColumnToImport(Mas90_COL_ENTITY_Subj_to_Exempt);
              //AddColumnToImport(Mas90_COL_ENTITY_WareHouse_Code);
              //AddColumnToImport(Mas90_COL_ENTITY_Cost_Type);
              //AddColumnToImport(Mas90_COL_ENTITY_Product_Line);
              //AddColumnToImport(Mas90_COL_ENTITY_Unit_of_Measure);
              AddColumnToImport(Mas90_COL_ENTITY_Lot_Serno_Dist);
              //AddColumnToImport(Mas90_COL_ENTITY_Cogs_Account);
              //AddColumnToImport(Mas90_COL_ENTITY_Reg_Sales_Acnt);
              //AddColumnToImport(Mas90_COL_ENTITY_Price_Ovrrddn);
              //AddColumnToImport(Mas90_COL_ENTITY_Kit_Item);
              //AddColumnToImport(Mas90_COL_ENTITY_Bkord_Comp_LN);
              //AddColumnToImport(Mas90_COL_ENTITY_Skip_Comp);
              //AddColumnToImport(Mas90_COL_ENTITY_Um_Conv_Factor);
              //AddColumnToImport(Mas90_COL_ENTITY_GL_Sales_Accnt);
              //AddColumnToImport(Mas90_COL_ENTITY_Misc_Item_Flag);
              //AddColumnToImport(Mas90_COL_ENTITY_Misc_Item);
              //AddColumnToImport(Mas90_COL_ENTITY_Stand_Kit_Bill);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Class);
              AddColumnToImport(Mas90_COL_ENTITY_Qty_Ordered);
              AddColumnToImport(Mas90_COL_ENTITY_Qty_Shipped);
              //AddColumnToImport(Mas90_COL_ENTITY_Qty_Backordered);
              AddColumnToImport(Mas90_COL_ENTITY_Unit_Price);
              AddColumnToImport(Mas90_COL_ENTITY_Extension);
              AddColumnToImport(Mas90_COL_ENTITY_Taxable_Amt);
              AddColumnToImport(Mas90_COL_ENTITY_Non_Tax_Amt);
              AddColumnToImport(Mas90_COL_ENTITY_Sales_Tax);
              AddColumnToImport(Mas90_COL_ENTITY_Line_Disc_Perct);
              AddColumnToImport(Mas90_COL_ENTITY_Unit_Cost);
              AddColumnToImport(Mas90_COL_ENTITY_Item_Desc);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Order_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_due_dt);
              AddColumnToImport(Mas90_COL_ENTITY_Discount_Due_Dt);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Addrs1);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Addrs2);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_City);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_State);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Zip_CD);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Addrs1);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Addrs2);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_City);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_State);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Zip_CD);
              AddColumnToImport(Mas90_COL_ENTITY_Comm_Desc_Line1);
              //AddColumnToImport(Mas90_COL_ENTITY_Comm_Desc_Line2);
              //AddColumnToImport(Mas90_COL_ENTITY_Misc_Slash);
              //AddColumnToImport(Mas90_COL_ENTITY_Charge_AMT);
              //AddColumnToImport(Mas90_COL_ENTITY_Misc_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Description);
              AddColumnToImport(Mas90_COL_ENTITY_Freight);
              end;
       end;
     end;
end;

procedure TWizSetupColumns.FillMas90ColumnsGrid;
begin

  if not Assigned(fMas90) then
     fMas90 := TMas90.Create;

  AddMas90ColumnsToImportExport;

  FMas90.GetColumnsToImport(sgColumns, nil);

  sgColumns.Cells[COLUMN_ID,0]        := 'Col';
  sgColumns.Cells[COLUMN_OTHER_ACC,0] := 'Mas90';
  sgColumns.Cells[COLUMN_OFFICEM,0]   := 'Main Retail';

end;

procedure TWizSetupColumns.GetGridColumn;
var
  sColumn : String;
  sResult : String;
  i : integer;
begin
   sColumn := DM.GetIniFile('ColumnSetup', ACC_SOFTWARE_MAS90 + IntToStr(DM.iEntityType));

  if sColumn = '' then
     Exit;

  for i:=1 to sgColumns.RowCount-1 do
      begin
      sResult := ParseParam(sColumn, Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]));
      if sResult <> '' then
         sgColumns.Cells[COLUMN_OFFICEM,i] := sResult;
      end;
end;

function TWizSetupColumns.HasValidHeader: Boolean;
var
  i : integer;
begin

  //Verify if the column to import has an valida header
  Result := False;
  for i:=1 to sgColumns.RowCount-1 do
      if {MyStrToInt}StrtoInt(sgColumns.Cells[COLUMN_ID,i]) <> 0 then
         begin
         Result := True;
         Break;
         end;
end;

function TWizSetupColumns.OnAfterChangePage: Boolean;
begin
 if pgOption.ActivePage.Name = 'tsColumn' then
     begin
     DM.fLocalPath := edtPath.Text;
     DM.SetIniFileString('Setup',InttoStr(DM.iSoftware)+'_FilePath',edtPath.Text);
     ClearColumns;

     cbColumns.Clear;

     case DM.iEntityType of
       ENTITY_CUSTOMER     : DM.OpenCustomer;
       ENTITY_PAYMENT      : DM.OpenPaymentTotal('10/01/2004','10/01/2005');
       ENTITY_SALE_INVOICE : DM.OpenSaleInvoice('10/01/2004','10/01/2005');
      end;

     SaveGridColumn;
     FillColumnGrid;
     //Fill system columns from Registry
     GetGridColumn;
     end
 else if pgOption.ActivePage.Name = 'tsOption' then
  begin
   edtPath.Text := DM.fLocalPath;
   DM.SetIniFileString('Setup','SoftwareDefault',InttoStr(DM.iSoftware));
  end;
end;

procedure TWizSetupColumns.OnBeforeBackClick;
begin
if pgOption.ActivePage.Name = 'tsColumn' then
     SaveGridColumn;
end;

procedure TWizSetupColumns.SaveGridColumn;
var
  sColumn : String;
  i : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then
         if Pos(Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]), sColumn) = 0 then
            sColumn := sColumn + sgColumns.Cells[COLUMN_OTHER_ACC,i]+'='+
                                 sgColumns.Cells[COLUMN_OFFICEM,i]+';';

  if sColumn = '' then
     Exit;

  DM.SetIniFileString('ColumnSetup', ACC_SOFTWARE_MAS90 + IntToStr(DM.iEntityType), sColumn);

end;

function TWizSetupColumns.TestBeforeNavigate: Boolean;
begin
 Result := True;

  if pgOption.ActivePage.Name = 'tsSoftware' then
     begin
     if treeSoftware.Selected.Index = -1 then
        begin
        MsgBox('Select Software to Export', vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;
     end
  else if pgOption.ActivePage.Name = 'tsOption' then
     begin
     if cbxFileType.Text = '' then
        begin
        MsgBox('Select File Type', vbInformation + vbOKOnly);
        cbxFileType.SetFocus;
        Result := False;
        Exit;
        end;
     end
  else if pgOption.ActivePage.Name = 'tsColumn' then
     begin
     SaveGridColumn;
     DM.CloseQuerys;
     end;
end;

procedure TWizSetupColumns.sbOpenFileClick(Sender: TObject);
var
  sFile : String;
begin
  if OD.Execute then
     begin
     sFile := LowerCase(OD.FileName);
     edtPath.Text := sFile;
     end;
end;

procedure TWizSetupColumns.sgColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin

  //Somente na Coluna desejada
  if ((ACol = COLUMN_OFFICEM) AND (ARow <> 0)) then
  begin
   {Size and position the combo box to fit the cell}
    R := sgColumns.CellRect(ACol, ARow);
    R.Left := R.Left + sgColumns.Left;
    R.Right := R.Right + sgColumns.Left;
    R.Top := R.Top + sgColumns.Top;
    R.Bottom := R.Bottom + sgColumns.Top;
    cbColumns.Left := R.Left + 1;
    cbColumns.Top := R.Top + 1;
    cbColumns.Width := (R.Right + 1) - R.Left;
    cbColumns.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cbColumns.Text := sgColumns.Cells[ACol, ARow];
    cbColumns.Visible := True;
    cbColumns.SetFocus;
  end;
  CanSelect := True;

end;

procedure TWizSetupColumns.FillColumnGrid;
var
   i : integer;
begin

    //System Columns
    case DM.iEntityType of
     ENTITY_CUSTOMER :
      begin
       if cbColumns.Items.Count <> DM.quCustomer.FieldCount then
        begin
        cbColumns.Clear;
        cbColumns.Items.Add('');

        for i:=0 to DM.quCustomer.FieldCount-1 do
           if DM.quCustomer.Fields.Fields[i].Visible then
              cbColumns.Items.Add(DM.quCustomer.Fields.Fields[i].FieldName);
        end;
      end;

     ENTITY_PAYMENT  :
      begin
       DM.OpenPaymentDetail(1,'01/01/2005','01/01/2005');
       if cbColumns.Items.Count <> DM.quPaymentDetail.FieldCount then
        begin
        cbColumns.Clear;
        cbColumns.Items.Add('');

        for i:=0 to DM.quPaymentDetail.FieldCount-1 do
           if DM.quPaymentDetail.Fields.Fields[i].Visible then
              cbColumns.Items.Add(DM.quPaymentDetail.Fields.Fields[i].FieldName);
        end;
      end;

     ENTITY_SALE_INVOICE :
      begin
       DM.OpenSaleInvoice('01/01/2005','01/01/2005');
       if cbColumns.Items.Count <> DM.quSaleInvoice.FieldCount then
        begin
        cbColumns.Clear;
        cbColumns.Items.Add('');

        for i:=0 to DM.quSaleInvoice.FieldCount-1 do
           if DM.quSaleInvoice.Fields.Fields[i].Visible then
              cbColumns.Items.Add(DM.quSaleInvoice.Fields.Fields[i].FieldName);
        end;
      end;
    end;



     case DM.iSoftware of
        SOFTWARE_MAS90: FillMAS90ColumnsGrid;
        end;
end;

function TWizSetupColumns.DoFinish: Integer;
begin
   //Finish
end;

procedure TWizSetupColumns.treeSoftwareClick(Sender: TObject);
begin
  lbSoftware.Visible := True;

  case treeSoftware.Selected.Index of
       0 : begin
           DM.iSoftware := SOFTWARE_MAS90;
           lbSoftware.Caption := 'The data will exported to MAS90.';
           end;
  end;
end;

procedure TWizSetupColumns.cbColumnsChange(Sender: TObject);
begin
  {Get the ComboBox selection and place in the grid}
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];

  cbColumns.Visible := False;
  sgColumns.SetFocus;

end;

procedure TWizSetupColumns.cbColumnsExit(Sender: TObject);
begin
  {Get the ComboBox selection and place in the grid}
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];
  cbColumns.Visible := False;
  sgColumns.SetFocus;
end;

procedure TWizSetupColumns.OnAfterDoFinish;
begin
  inherited;
  SaveGridColumn;
end;

procedure TWizSetupColumns.cbxFileTypeChange(Sender: TObject);
begin
  inherited;
  DM.iEntityType := cbxFileType.ItemIndex;
end;

procedure TWizSetupColumns.ClearColumns;
var i: integer;
begin
 for i:=1 to sgColumns.RowCount-1 do
  begin
  sgColumns.Cells[COLUMN_OTHER_ACC,i] := '';
  sgColumns.Cells[COLUMN_OFFICEM,i] := '';
  end;
end;

end.
