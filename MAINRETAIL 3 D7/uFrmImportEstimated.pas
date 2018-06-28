unit uFrmImportEstimated;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DateBox, Mask, SuperComboADO, PowerADOQuery;

type
  TFrmImportEstimated = class(TFrmParentAll)
    btnOK: TButton;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    pnlBasicFilter: TPanel;
    Label3: TLabel;
    lbFrom: TLabel;
    lbTo: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pblGO: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    cmbStore: TSuperComboADO;
    Button2: TButton;
    DateInicio: TDateBox;
    DateFim: TDateBox;
    cbmName: TComboBox;
    edtNames: TEdit;
    edtHoldNumber: TEdit;
    scUser: TSuperComboADO;
    Button1: TButton;
    Label1: TLabel;
    cbmDocs: TComboBox;
    edtDocs: TEdit;
    quEstimated: TPowerADOQuery;
    dsEstimated: TDataSource;
    quEstimatedIDEstimated: TIntegerField;
    quEstimatedEstimatedDate: TDateTimeField;
    quEstimatedTotal: TBCDField;
    quEstimatedOBS: TStringField;
    quEstimatedStore: TStringField;
    quEstimatedIDUser: TIntegerField;
    quEstimatedSystemUser: TStringField;
    quEstimatedCustomer: TStringField;
    grdBrowseDBIDEstimated: TcxGridDBColumn;
    grdBrowseDBEstimatedDate: TcxGridDBColumn;
    grdBrowseDBTotal: TcxGridDBColumn;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    grdBrowseDBCustomer: TcxGridDBColumn;
    chkUpdateSalePrice: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExecClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    fIDPreSale : Integer;
    fIDMidia   : Integer;
    function ValidateFields: Boolean;
    function GetWhereClause: String;

    procedure OpenEstimated;
    procedure CloseEstimated;
    procedure RefreshEstimated;
  public
    function Start(var IDPreSale: Integer; IDMidia: Integer):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uDateTimeFunctions, uMsgBox, uMsgConstant, uSystemConst;

{$R *.dfm}

{ TFrmImportEstimated }

function TFrmImportEstimated.Start(var IDPreSale:Integer; IDMidia:Integer):Boolean;
begin
  DateInicio.Date      := FirstDateMonth;
  DateFim.Date         := LastDateMonth;
  cmbStore.LookUpValue := IntToStr(DM.fStore.ID);
  scUser.LookUpValue   := IntToStr(DM.fUser.ID);
  fIDMidia             := IDMidia;

  ShowModal;
  Result               := (ModalResult=mrOK);
  IDPreSale            := fIDPreSale;
end;

procedure TFrmImportEstimated.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmImportEstimated.ValidateFields: Boolean;
begin
  Result := False;
  if (not quEstimated.Active) or (quEstimatedIDEstimated.AsInteger = 0) then
     Exit;
  Result := True;
end;

function TFrmImportEstimated.GetWhereClause: String;
var
 sField, sField1 : String;
begin
   Result := '';

  Result := ' E.IDPreSale IS NULL ';

  // filtro por Store
  if cmbStore.LookUpValue <> '' then
    Result := Result + ' AND E.IDStore = ' + cmbStore.LookUpValue
  else
    Result := Result + ' AND E.IDStore IN ('+ DM.fStore.StoreList +')';


  if edtHoldNumber.Text <> '' then
     begin
     Result := Result + ' AND E.IDEstimated Like ' + QuotedStr('%' + trim(edtHoldNumber.Text) + '%');
     end
  else
     begin
     if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
        begin
         Result := Result + ' AND (E.EstimatedDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                            ' E.EstimatedDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39) + ') ';
        end
      else
        begin
          MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
          Exit;
        end;
     end;

  if scUser.LookUpValue <> '' then
     Result := Result + ' AND E.IDUser = ' + scUser.LookUpValue;

  //Customer Options
  Case cbmName.ItemIndex of
      0 : sField := '';
      1 : sField := ' P.PessoaFirstName';
      2 : sField := ' P.PessoaLastName';
      3 : sField := ' P.Pessoa';
   end;

   Case cbmDocs.ItemIndex of
      0 : sField1 := '';
      1 : sField1 := ' P.OrgaoEmissor';
      2 : sField1 := ' P.CartTrabalho';
      3 : sField1 := ' P.CustomerCard';
      4 : sField1 := ' P.CPF';
   end;

  case cbmName.ItemIndex of
    0:; //Todos
    else //Add like
      Result := Result + ' AND ' + sField+ ' Like ' + QuotedStr('%' + trim(edtNames.Text) + '%');
  end;

  case cbmDocs.ItemIndex of
    0: ;//Todos
    else //Add like
      Result := Result + ' AND ' + sField1+ ' Like ' + QuotedStr('%' + trim(edtDocs.Text) + '%');
  end;


  if DM.fSystem.SrvParam[PARAM_CONFIRM_BUDGET] then
    Result := Result + ' AND ' + ' IsNull(E.Confirmed,0) = 1 ';

  if Result <> '' then
     Result := 'WHERE ' + Result;

end;

procedure TFrmImportEstimated.CloseEstimated;
begin
  with quEstimated do
    if Active then
       Close;
end;

procedure TFrmImportEstimated.OpenEstimated;
begin
  with quEstimated do
    if not Active then
       begin
       CommandText := 'SELECT E.IDEstimated, E.EstimatedDate, E.OBS, S.Name ' +
                      ' as Store, P.Pessoa as Customer, SU.IDUser, SU.SystemUser, SUM(Qty * SalePrice) as Total ' +
                      'FROM Estimated E '+
                      'JOIN EstimatedItem EI ON (EI.IDEstimated = E.IDEstimated) ' +
                      'LEFT OUTER JOIN Pessoa P ON (P.IDPessoa = E.IDPEssoa) ' +
                      'JOIN Store S ON (S.IDStore = E.IDStore) ' +
                      'JOIN SystemUser SU ON (SU.IDUser = E.IDUser) ' +
                       GetWhereClause +
                      ' GROUP BY E.IDEstimated, E.EstimatedDate,	E.OBS, S.Name, ' +
                      ' SU.IDUser, SU.SystemUser, P.Pessoa ';
       Open;
       end;

end;

procedure TFrmImportEstimated.RefreshEstimated;
begin
  CloseEstimated;
  OpenEstimated;
end;

procedure TFrmImportEstimated.btnExecClick(Sender: TObject);
begin
  inherited;
  RefreshEstimated;
end;

procedure TFrmImportEstimated.Button1Click(Sender: TObject);
begin
  inherited;
  scUser.LookUpValue := '';
  scUser.Text := '<-->';
end;

procedure TFrmImportEstimated.Button2Click(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text := '<-->';
end;

procedure TFrmImportEstimated.btnOKClick(Sender: TObject);
begin

  inherited;
  if not ValidateFields then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  fIDPreSale := DM.fPOS.ImportEstimated(quEstimatedIDEstimated.AsInteger,
                                        fIDMidia,
                                        DM.fStore.IDStoreSale,
                                        quEstimatedIDUser.AsInteger,
                                        (DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE]),
                                        chkUpdateSalePrice.Checked);

  if fIDPreSale = -1 then
    ModalResult := mrNone;

end;

end.
