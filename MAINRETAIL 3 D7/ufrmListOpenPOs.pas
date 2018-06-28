unit ufrmListOpenPOs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  StdCtrls, cxContainer, cxCheckBox, Buttons, LblEffct, ExtCtrls,
  DBClient, Provider, ADODB;

type
  TfrmListOPenPOs = class(TForm)
    Panel2: TPanel;
    Image3: TImage;
    Image1: TImage;
    imgTopIni: TImage;
    lblSubMenu: TLabelEffect;
    lblMenu: TLabel;
    imgMenu: TImage;
    EspacamentoSuperior: TPanel;
    EEE: TPanel;
    pnlAutoInc: TPanel;
    Image2: TImage;
    btLoopInc: TSpeedButton;
    lblModified: TLabel;
    Panel5: TPanel;
    chkUpdate: TcxCheckBox;
    Panel1: TPanel;
    lblUserName: TLabel;
    Label15: TLabel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    btCancel: TButton;
    btClose: TButton;
    pnlNavigation: TPanel;
    btFirstRec: TSpeedButton;
    btPriorRec: TSpeedButton;
    btNextRec: TSpeedButton;
    btLastRec: TSpeedButton;
    cxGridOpenPOs: TcxGrid;
    cxGridOpenPOsDBTableView: TcxGridDBTableView;
    cxGridOpenPOsDBTableViewDBColumn1: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn2: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn3: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn4: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn5: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn6: TcxGridDBColumn;
    cxGridOpenPOsDBTableViewDBColumn7: TcxGridDBColumn;
    cxGridOpenPOsLevel: TcxGridLevel;
    dsOpenPO: TDataSource;
    procedure btCloseClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkUpdateClick(Sender: TObject);
  private
    { Private declarations }
    FCds: TClientDataSet;
    function isVersionTypeClient: Boolean;
  public
    { Public declarations }
    property cdsList: TClientDataSet read FCds write FCds;
  end;

var
  frmListOPenPOs: TfrmListOPenPOs;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmListOPenPOs.btCloseClick(Sender: TObject);
var
  qUpdate: TADOQuery;
  sqlText: String;
  cdsVersionType: TClientDataset;
begin
  try
    qUpdate := TADOQuery.Create(nil);
    qUpdate.Connection := dm.ADODBConnect;
    sqlText := 'Update Pur_PurchaseItem set NewSalePrice = :newsaleprice ' +
               'where IdPurchaseItem = :id ';
    qUpdate.SQL.Text := sqlText;
    Fcds.First;

   // Antonio M F Souza: March 19, 2013
   if ( not isversionTypeClient ) then begin
       Fcds.DisableControls;

        while ( not Fcds.Eof ) do begin
           if ( FCds.FieldByName('Upd').Value = 1 ) then begin
              qUpdate.Parameters.ParamByName('newsaleprice').Value   := FCds.fieldByname('NewPrice').Value;
              qUpdate.Parameters.ParamByName('id').Value := FCds.fieldByName('IdPurchaseItem').Value;
              qUpdate.ExecSQL;
           end;
           Fcds.Next;
        end;
        Fcds.EnableControls;
   end;

  finally
    FreeAndNil(qUpdate);
  end;
  close;
end;

procedure TfrmListOPenPOs.btCancelClick(Sender: TObject);
begin
   Application.MessageBox('PO has been saved. Resave this PO if you want to display the new pricing grid again.','Warning', mb_OK + mb_IconWarning);
   close;
end;

procedure TfrmListOPenPOs.FormShow(Sender: TObject);
begin
  dsOpenPO.DataSet := FCds;
  FCds.Edit;
end;

procedure TfrmListOPenPOs.chkUpdateClick(Sender: TObject);
begin
   if ( FCds <> nil ) then begin
     Fcds.first;
     FCds.DisableControls;
     while (  not Fcds.Eof ) do begin
        Fcds.Edit;
        if ( chkUpdate.Checked ) then
           FCds.FieldByName('Upd').Value := 1
        else
           FCds.FieldByName('Upd').Value := 0;
        FCds.Post;
        FCds.Next;
     end;
     FCds.EnableControls;
   end;

end;

function TfrmListOPenPOs.isVersionTypeClient: Boolean;
var
  cdsVersionType: TClientdataset;
begin
   cdsVersionType := dm.searchSysModule();
   result := ( cdsVersionType.FieldByName('VersionType').Value = quotedStr('CLIENT') );
   freeAndNil(cdsVersionType);
end;

end.
