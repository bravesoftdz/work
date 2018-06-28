unit uFrmSaleRequest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Buttons, Grids, ComCtrls,uInvoice,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, DateBox, RadioButtonAll,
  siComp, siLangRT, SubListPanel, mrBarCodeEdit;

type
  TbrwFrmRequest = class(TbrwFrmParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    quFormIDRequest: TIntegerField;
    quFormModelID: TIntegerField;
    quFormUserID: TIntegerField;
    quFormType: TStringField;
    quFormDateRequest: TDateTimeField;
    quFormStoreID: TIntegerField;
    quFormDescription: TStringField;
    Panel5: TPanel;
    Label19: TLabel;
    Label7: TLabel;
    EditPurcDate: TDBEdit;
    Label8: TLabel;
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    Label3: TLabel;
    ebDesc: TDBEdit;
    scModel: TDBSuperComboADO;
    Label4: TLabel;
    Label2: TLabel;
    ebDate: TDBEdit;
    DBSuperCombo1: TDBSuperComboADO;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    SubListModelDetail: TSubListPanel;
    quFormQtyReq: TFloatField;
    edtBarcode: TmrBarCodeEdit;
    procedure scModelSelectItem(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
  private
    { Private declarations }
    PutDescription : Boolean;
    MyIDModel : Integer;
    MyDate         : TDateTime;
    OriginalHeight : integer;
    FrmInvoice     : TFrmInvoice;
    function  SaveChange : boolean; override;
    procedure NextAppend; override;
    procedure SelectModel;
  public
    { Public declarations }
   IsDetail      : Boolean;
   ShowLookUp    : Boolean;
  end;

implementation

uses uDM, XBase, uMsgBox, uNumericFunctions, uSystemTypes, uDMGlobal, uPassword,
     uSystemConst, PaiDeTodos, uMsgConstant;

{$R *.DFM}

procedure TbrwFrmRequest.scModelSelectItem(Sender: TObject);
begin
  inherited;
  edtBarcode.Text := '';
  SelectModel;
end;

procedure TbrwFrmRequest.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormDateRequest.AsDateTime := Date;
  quFormUserID.AsInteger       := DM.fUser.ID;
  quFormType.AsString          := REQ_TYPE_SALESPERSON;
  quFormQtyReq.AsFloat         := 1;
  quFormStoreID.AsInteger      := DM.fStore.ID;
end;


function TbrwFrmRequest.SaveChange : boolean;
begin
  Result := False;

  if scModel.LookUpValue = '' then
    begin
     Result := True;
     Result := inherited SaveChange;
     Exit;
    end;

  Result := True;

  Result := inherited SaveChange;
end;

procedure TbrwFrmRequest.FormShow(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
     ebDesc.SetFocus
  else
     scModel.SetFocus;

  PutDescription := True;
  
  if frmCommand = btAlt then
    begin
     try
       PutDescription := False;
       scModelSelectItem(nil);
     finally
       PutDescription := True;
     end;
    end
  else
    begin
      scModelSelectItem(nil);
    end;

end;

procedure TbrwFrmRequest.NextAppend;
begin
  inherited;
end;

procedure TbrwFrmRequest.FormCreate(Sender: TObject);
begin
  inherited;
  SubListModelDetail.CreateSubList;
end;

procedure TbrwFrmRequest.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1210);
end;

procedure TbrwFrmRequest.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  scModelSelectItem(nil);
end;

procedure TbrwFrmRequest.edtBarcodeEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TbrwFrmRequest.edtBarcodeExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
end;

procedure TbrwFrmRequest.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel : Integer;
begin
  inherited;

  with edtBarcode do
  begin
    if SearchResult then
    begin
      IDModel := GetFieldValue('IDModel');
      scModel.LookUpValue := IntToStr(IDModel);
      SelectModel;
    end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
  end;
end;

procedure TbrwFrmRequest.SelectModel;
begin
  if scModel.LookUpValue = '' then
    begin
      SubListModelDetail.Visible := False;
      Exit;
    end;

  SubListModelDetail.Visible := Password.HasFuncRight(34);

  if SubListModelDetail.Visible then
     SubListModelDetail.Param := 'IDModel='+scModel.LookUpValue+
                                 ';IDStore='+IntToStr(DM.fStore.ID)+
                                 ';IDVendor=-1';

  if PutDescription then
    begin
      quForm.Edit;
      quFormDescription.AsString := scModel.CodeValue;
    end;
end;

end.

