unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XiButton, ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmMain = class(TForm)
    pnlBottom: TPanel;
    btnOk: TXiButton;
    btnCancel: TXiButton;
    Notebook: TNotebook;
    edtPetDate: TcxDateEdit;
    lbSaleDate: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    chkSaledata: TCheckBox;
    chkInventoryData: TCheckBox;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure chkSaledataClick(Sender: TObject);
  private
    procedure SaleControl;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  edtPetDate.Date := Trunc(Now);
  Notebook.PageIndex := 1;
  DM.FEnableLog := False;

  if ParamCount > 0 then
  begin
    if ParamStr(1) <> '' then
    try
      edtPetDate.Date := StrToDate(ParamStr(1));
    except
      edtPetDate.Date := Trunc(Now-1);
    end;

    if ParamCount > 1 then
    try
      chkInventoryData.Checked := (ParamStr(2) = '1');
    except
      chkInventoryData.Checked := True;
    end;

    if ParamCount > 2 then
      DM.FEnableLog := (ParamStr(3) = '1');

    btnOkClick(Self);
    Close;
  end;

end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnOkClick(Sender: TObject);
begin

  try
    Screen.Cursor := crHourGlass;
    btnOk.Enabled := False;
    btnCancel.Enabled := False;
    Notebook.PageIndex := 0;
    Application.ProcessMessages;
    Sleep(0);

//    DM.SendPetDate(edtPetDate.Date, chkSaledata.Checked, chkInventoryData.Checked);
    DM.SendPetDate(edtPetDate.Date, chkSaledata.Checked, false);


  finally
    Screen.Cursor := crDefault;
    btnOk.Enabled := True;
    btnCancel.Enabled := True;
    Notebook.PageIndex := 1;
    Application.ProcessMessages;
  end;

end;

procedure TfrmMain.SaleControl;
begin

  lbSaleDate.Visible := chkSaledata.Checked;
  edtPetDate.Visible := chkSaledata.Checked;

end;

procedure TfrmMain.chkSaledataClick(Sender: TObject);
begin
   SaleControl;
end;

end.
