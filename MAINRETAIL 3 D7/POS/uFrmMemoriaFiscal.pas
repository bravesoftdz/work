unit uFrmMemoriaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, Mask,
  DateBox;

type
  TFrmMemoriaFiscal = class(TFrmPai)
    GroupNumber: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    optSimplificada: TRadioButton;
    optCompleta: TRadioButton;
    GroupDate: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    rbComplete: TRadioButton;
    rbSimple: TRadioButton;
    btnOK: TButton;
    dt1: TDateBox;
    dt2: TDateBox;
    procedure btnOKClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    fResult : Boolean;
    fStartType : Integer;
    function ValidateFields : Boolean;
  public
    function StartDate(var sDate1,  sDate2, sOpt: String; bShowOpt : Boolean) : Boolean;
    function StartReducao(var sRet1,  sRet2, sOpt: String; bShowOpt : Boolean) : Boolean;
    function StartCOO(var sRet1,  sRet2, sOpt: String; bShowOpt : Boolean) : Boolean;
  end;

implementation

{$R *.dfm}

{ TFrmMemoriaFiscal }

function TFrmMemoriaFiscal.StartDate(var sDate1, sDate2, sOpt: String; bShowOpt : Boolean): Boolean;
begin
  fResult := False;
  GroupDate.Visible := True;
  fStartType := 1;

  rbComplete.Visible := bShowOpt;
  rbSimple.Visible := bShowOpt;

  ShowModal;

  Result := fResult;

  if Result then
  begin
    sDate1 := FormatDatetime('dd/mm/yyyy', dt1.Date);
    sDate2 := FormatDatetime('dd/mm/yyyy', dt2.Date);
    if rbComplete.Checked = true then
      sOpt := 'c'
    else
      sOpt := 's';
  end;

end;

procedure TFrmMemoriaFiscal.btnOKClick(Sender: TObject);
begin
  inherited;

  if not ValidateFields then
    ModalResult := mrNone
  else
    fResult := True;
    
end;

procedure TFrmMemoriaFiscal.btCloseClick(Sender: TObject);
begin
  inherited;
  fResult := False;
  Close;
end;

function TFrmMemoriaFiscal.ValidateFields: Boolean;
begin

  Result := True;

  if fStartType = 1 then
  begin
  end;
  
end;

function TFrmMemoriaFiscal.StartReducao(var sRet1,  sRet2, sOpt: String;
  bShowOpt: Boolean): Boolean;
begin

  fResult := False;
  GroupNumber.Visible := True;
  fStartType := 2;

  optCompleta.Visible := bShowOpt;
  optSimplificada.Visible := bShowOpt;

  ShowModal;

  Result := fResult;

  if Result then
  begin
    sRet1 := Edit1.Text;
    sRet2 := Edit2.Text;
    if optCompleta.Checked = true then
      sOpt := 'c'
    else
      sOpt := 's';
  end;

end;

function TFrmMemoriaFiscal.StartCOO(var sRet1, sRet2, sOpt: String;
  bShowOpt: Boolean): Boolean;
begin

  fResult := False;
  GroupNumber.Visible := True;
  fStartType := 2;

  optCompleta.Visible := bShowOpt;
  optSimplificada.Visible := bShowOpt;

  Label1.Caption := 'COO Inicial:';
  Label2.Caption := 'COO Final:';

  ShowModal;

  Result := fResult;

  if Result then
  begin
    sRet1 := Edit1.Text;
    sRet2 := Edit2.Text;
    if optCompleta.Checked = true then
      sOpt := 'c'
    else
      sOpt := 's';
  end;

end;

end.
