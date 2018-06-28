unit uSetDelPreSaleDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, Db, DBTables, StdCtrls, Mask,
  DateBox, ExtCtrls, Buttons, ADODB, siComp, siLangRT;

type
  TSetDelPreSaleDate = class(TFrmParentAll)
    Panel10: TPanel;
    Image6: TImage;
    Image7: TImage;
    lblTip: TLabel;
    Label1: TLabel;
    EditRetation: TDBDateBox;
    btCancel: TButton;
    quPreSale: TADOQuery;
    dsPreSale: TDataSource;
    quPreSaleestimatedpay: TDateTimeField;
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(IDPreSale : integer);
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

procedure TSetDelPreSaleDate.Start(IDPreSale : integer);
begin
  with quPreSale do
    begin
      Parameters.ParambyName('IDPreSale').Value := IDPreSale;
      Open;
    end;

  ShowModal;
end;


procedure TSetDelPreSaleDate.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TSetDelPreSaleDate.btCloseClick(Sender: TObject);
begin
  inherited;

  // Grava a nova data
  if quPreSale.State in dsEditModes then
    begin
     quPreSale.UpdateRecord;
     quPreSale.Post;
    end;

  quPreSale.Close;

  ModalResult := mrOK;
end;

procedure TSetDelPreSaleDate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
