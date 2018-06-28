unit uFrmCrossSellItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, cxCheckBox, cxDBEdit, CheckLst,
  cxSpinEdit, cxDropDownEdit, cxCalendar, cxContainer, cxTextEdit,
  cxMaskEdit, cxImageComboBox, siComp;

type
  TFrmCrossSellItems = class(TForm)
    pnlButtons: TPanel;
    btnClose: TBitBtn;
    btnSave: TBitBtn;
    pnlNewCrossSell: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnImgLogo: TSpeedButton;
    Label8: TLabel;
    btnAddCrossItem: TButton;
    btnAbortCrossItem: TButton;
    cbxType: TcxDBImageComboBox;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBSpinEdit3: TcxDBSpinEdit;
    grdCrossSellItem: TcxGrid;
    grdCrossSellItemDB: TcxGridDBTableView;
    grdCrossSellItemLevel1: TcxGridLevel;
    OP: TOpenDialog;
    dsCrossSaleItem: TDataSource;
    grdCrossSellItemDBModelNum: TcxGridDBColumn;
    grdCrossSellItemDBModelCategory: TcxGridDBColumn;
    grdCrossSellItemDBModelSubCategory: TcxGridDBColumn;
    grdCrossSellItemDBModelGroup: TcxGridDBColumn;
    grdCrossSellItemDBFileName: TcxGridDBColumn;
    grdCrossSellItemDBFileType: TcxGridDBColumn;
    grdCrossSellItemDBDuration: TcxGridDBColumn;
    grdCrossSellItemDBCrossDescription: TcxGridDBColumn;
    grdCrossSellItemDBCrossSalePrice: TcxGridDBColumn;
    Label4: TLabel;
    Label5: TLabel;
    cxDBTextEdit3: TcxDBTextEdit;
    Label6: TLabel;
    cxDBTextEdit4: TcxDBTextEdit;
    Label7: TLabel;
    cxDBTextEdit5: TcxDBTextEdit;
    Label9: TLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    Label10: TLabel;
    cxDBTextEdit7: TcxDBTextEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    pnlButtoms: TPanel;
    btnNew: TSpeedButton;
    btnDelete: TSpeedButton;
    siLang: TsiLang;
    procedure btnImgLogoClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAddCrossItemClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnAbortCrossItemClick(Sender: TObject);
    procedure cbxTypePropertiesChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Start : Boolean;
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

{ TFrmCrossSellItems }

function TFrmCrossSellItems.Start: Boolean;
begin
  ShowModal;
  Result := True;
end;

procedure TFrmCrossSellItems.btnImgLogoClick(Sender: TObject);
begin
  if OP.Execute then
   if DM.cdsCrossSaleItem.State in [dsEdit, dsInsert] then
     DM.cdsCrossSaleItem.FieldByName('FileName').AsString := OP.FileName;

end;

procedure TFrmCrossSellItems.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCrossSellItems.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCrossSellItems.btnSaveClick(Sender: TObject);
begin
  DM.SaveCrossSaleItem;
  Close;
end;

procedure TFrmCrossSellItems.btnAddCrossItemClick(Sender: TObject);
begin
  with DM.cdsCrossSaleItem do
    if State in [dsEdit, dsInsert] then
    begin
      Post;
      if (btnAddCrossItem.Tag = 0) then
        Append;
    end;

end;

procedure TFrmCrossSellItems.btnNewClick(Sender: TObject);
begin
  pnlButtoms.Visible      := False;
  pnlNewCrossSell.Visible := True;
  btnAddCrossItem.Caption := 'Add';
  btnAddCrossItem.Tag := 0;
  
  with DM.cdsCrossSaleItem do
  begin
    Filtered := False;
    Filter := '';
    Filtered := True;
  end;

  with DM.cdsCrossSaleItem do
    if not (State in [dsEdit, dsInsert]) then
    begin
      Append;
      FieldByName('ID').AsFloat := StrToFloat(FormatDateTime('mmddyyyyhhnnss', now));
    end;

end;

procedure TFrmCrossSellItems.btnAbortCrossItemClick(Sender: TObject);
begin
  pnlButtoms.Visible      := True;
  pnlNewCrossSell.Visible := False;
  if DM.cdsCrossSaleItem.State in [dsEdit, dsInsert] then
    DM.cdsCrossSaleItem.Cancel;
end;

procedure TFrmCrossSellItems.cbxTypePropertiesChange(Sender: TObject);
begin

  if cbxType.ItemIndex = ADV_BITMAP then
    OP.Filter := ADV_BITMAP_EXT
  else if cbxType.ItemIndex = ADV_JPG then
    OP.Filter := ADV_JPG_EXT
  else if cbxType.ItemIndex = ADV_FLASH then
    OP.Filter := ADV_FLASH_EXT
  else if cbxType.ItemIndex = ADV_WEB then
    OP.Filter := ADV_WEB_EXT
  else if cbxType.ItemIndex = ADV_VIDEO then
    OP.Filter := ADV_VIDEO_EXT;

end;

procedure TFrmCrossSellItems.btnDeleteClick(Sender: TObject);
begin

  with DM.cdsCrossSaleItem do
    if not (State in [dsEdit, dsInsert]) then
    begin
      Edit;
      Delete;
    end;

end;

end.
