unit uBrwListOpenPOs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxCheckBox, DBClient, Provider;

type
  TfrmListOpenPO = class(TForm)
    cxGridOpenPOsDBTableView: TcxGridDBTableView;
    cxGridOpenPOsLevel: TcxGridLevel;
    cxGridOpenPOs: TcxGrid;
    cxGridOpenPOsDBTableViewDBColumn1: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn2: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn3: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn4: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn5: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn6: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn7: TcxGridDBColumn;
    dsOpenPO: TDataSource;
    Panel5: TPanel;
    chkUpdate: TcxCheckBox;
    procedure chkUpdateClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCds: TClientDataSet;
  public
    { Public declarations }
    property cdsList: TClientDataSet read FCds write FCds;
  end;

var
  frmListOpenPO: TfrmListOpenPO;

implementation
uses uDM;

{$R *.dfm}

{ TfrmListOpenPO }

procedure TfrmListOpenPO.chkUpdateClick(Sender: TObject);
begin
  if ( chkUpdate.Checked ) then begin
    if ( Fcds.State = dsEdit ) then begin
       Fcds.first;
       FCds.DisableControls;
       while (  not Fcds.Eof ) do begin
          Fcds.Edit;
          FCds.FieldByName('Upd').Value := 1;
          FCds.Post;
          FCds.Next;
       end;
       FCds.EnableControls;
    end;
  end;
end;

procedure TfrmListOpenPO.btCloseClick(Sender: TObject);
var
  qUpdate: TADOQuery;
  sqlText: String;
begin
  try
    qUpdate := TADOQuery.Create(nil);
    qUpdate.Connection := dm.ADODBConnect;
    sqlText := 'Update Pur_PurchaseItem set NewSalePrice = :newsaleprice ' +
               'where IdPurchaseItem = :id ';
    qUpdate.SQL.Text := sqlText;
    Fcds.First;
    Fcds.DisableControls;
    while ( not Fcds.Eof ) do begin
       qUpdate.Parameters.ParamByName('newsaleprice').Value   := FCds.fieldByname('NewPrice').Value;
       qUpdate.Parameters.ParamByName('id').Value := FCds.fieldByName('IdPurchaseItem').Value;
       qUpdate.ExecSQL;
       Fcds.Next;
    end;
    Fcds.EnableControls;

  finally
    FreeAndNil(qUpdate);
  end;

  inherited;

end;

procedure TfrmListOpenPO.FormCreate(Sender: TObject);
begin
  inherited;
  dsOpenPO.DataSet := Fcds;
  Fcds.Edit;
end;

end.
