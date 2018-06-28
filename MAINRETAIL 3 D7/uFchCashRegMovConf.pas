unit uFchCashRegMovConf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, DBCtrls, StdCtrls, Mask, Db, FormConfig,
  DBTables, Buttons, LblEffct, ExtCtrls, ADODB, RCADOQuery, PowerADOQuery,
  SuperComboADO, siComp, siLangRT;

type
  TFchCashRegMovConf = class(TbrwFrmParent)
    quFormIDUser: TIntegerField;
    quFormLogTime: TDateTimeField;
    quFormTotalCard: TFloatField;
    quFormTotalCheck: TFloatField;
    quFormTotalOther: TFloatField;
    quFormTotalCash: TFloatField;
    quFormTotalCashConf: TFloatField;
    quFormTotalOtherConf: TFloatField;
    quFormTotalCheckConf: TFloatField;
    quFormTotalCardConf: TFloatField;
    Label1: TLabel;
    DBSuperCombo1: TDBSuperComboADO;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Panel5: TPanel;
    LabelEffect2: TLabelEffect;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Panel6: TPanel;
    LabelEffect1: TLabelEffect;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    quFormTotalCardPre: TFloatField;
    quFormTotalCardPreConf: TFloatField;
    Label13: TLabel;
    DBEdit7: TDBEdit;
    Label16: TLabel;
    DBEdit12: TDBEdit;
    quFormTotalGeralConf: TCurrencyField;
    quFormTotalGeralCashier: TCurrencyField;
    btDetCash: TSpeedButton;
    quCashDep: TADOQuery;
    quFormBill100: TIntegerField;
    quFormBill50: TIntegerField;
    quFormBill20: TIntegerField;
    quFormBill10: TIntegerField;
    quFormBill5: TIntegerField;
    quFormBill2: TIntegerField;
    quFormBill1: TIntegerField;
    quFormCoin1: TIntegerField;
    quFormCoin050: TIntegerField;
    quFormCoin025: TIntegerField;
    quFormCoin010: TIntegerField;
    quFormCoin005: TIntegerField;
    quFormCoin001: TIntegerField;
    quFormIDCashRegLog: TIntegerField;
    EditCashConf: TDBEdit;
    btnCash: TSpeedButton;
    btnCreditCart: TSpeedButton;
    dxDBButtonEdit1: TDBEdit;
    dxDBButtonEdit2: TDBEdit;
    btnPostDate: TSpeedButton;
    dxDBButtonEdit3: TDBEdit;
    SpeedButton2: TSpeedButton;
    dxDBButtonEdit4: TDBEdit;
    SpeedButton3: TSpeedButton;
    quFormTotalDebit: TBCDField;
    quFormTotalDebitConf: TBCDField;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    Label17: TLabel;
    edtDebitConf: TDBEdit;
    btnDebitCard: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure quFormCalcFields(DataSet: TDataSet);
    procedure btDetCashClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure EditCashConfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCashClick(Sender: TObject);
    procedure btnCreditCartClick(Sender: TObject);
    procedure btnPostDateClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnDebitCardClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uItemsCalc, uCalcCash, uDMGlobal;

{$R *.DFM}

procedure TFchCashRegMovConf.FormShow(Sender: TObject);
begin
  inherited;
  Case DMGlobal.IDLanguage of
       LANG_ENGLISH :
             begin
             Caption := 'Cash Register - Deposit Conference';
             end;

       LANG_PORTUGUESE :
             begin
             Caption := 'Caixa - Conferência de Depósito';
             end;

       LANG_SPANISH :
             begin
             Caption := 'Caixa';
             end;
     end;
  EditCashConf.SetFocus;
end;

procedure TFchCashRegMovConf.quFormCalcFields(DataSet: TDataSet);
begin
  inherited;
  quFormTotalGeralConf.AsFloat    := quFormTotalCardConf.AsFloat + quFormTotalCheckConf.AsFloat +
                                     quFormTotalCashConf.AsFloat + quFormTotalCardPreConf.AsFloat +
                                     quFormTotalOtherConf.AsFloat + quFormTotalDebitConf.AsFloat;

  quFormTotalGeralCashier.AsFloat := quFormTotalCard.AsFloat + quFormTotalCheck.AsFloat +
                                     quFormTotalCash.AsFloat + quFormTotalCardPre.AsFloat +
                                     quFormTotalOther.AsFloat + quFormTotalDebit.AsFloat;
end;

procedure TFchCashRegMovConf.btDetCashClick(Sender: TObject);
begin
  inherited;
  // Abre Log de Deposito do Cashier
  with TCalcCash.Create(self) do
  begin
    with Edit100 do
    begin
      Text := quFormBill100.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit50 do
    begin
      Text := quFormBill50.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit20 do
    begin
      Text := quFormBill20.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit10 do
    begin
      Text := quFormBill10.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit5 do
    begin
      Text := quFormBill5.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit2 do
    begin
      Text := quFormBill2.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit1 do
    begin
      Text := quFormBill1.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit0100 do
    begin
      Text := quFormCoin1.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit050 do
    begin
      Text := quFormCoin050.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit025 do
    begin
      Text := quFormCoin025.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit010 do
    begin
      Text := quFormCoin010.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit005 do
    begin
      Text := quFormCoin005.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    with Edit001 do
    begin
      Text := quFormCoin001.AsString;
      Color    := clBtnFace;
      ReadOnly := True;
    end;
    ShowModal;
    Free;
  end;
end;

procedure TFchCashRegMovConf.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1100);
end;

procedure TFchCashRegMovConf.EditCashConfKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F2 then
    btnCashClick(Self);

end;

procedure TFchCashRegMovConf.btnCashClick(Sender: TObject);
begin
  inherited;
  with TCalcCash.Create(self) do
  begin
    if ShowModal = mrOK then
    begin
      quForm.Edit;
      quFormTotalCashConf.AsFloat := TotCashGeral;
    end;
    Free;
  end;
end;

procedure TFchCashRegMovConf.btnCreditCartClick(Sender: TObject);
begin
  inherited;
  with TfrmItemsCalc.Create(self) do
  begin
    if ShowModal = mrOK then
    begin
      quForm.Edit;
      quFormTotalCardConf.AsFloat := TotGeral;
    end;
    Free;
  end;
end;

procedure TFchCashRegMovConf.btnPostDateClick(Sender: TObject);
begin
  inherited;

 with TfrmItemsCalc.Create(self) do
  begin
    if ShowModal = mrOK then
    begin
      quForm.Edit;
      quFormTotalCardPreConf.AsFloat := TotGeral;
    end;
    Free;
  end;

end;

procedure TFchCashRegMovConf.SpeedButton2Click(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
  begin
    if ShowModal = mrOK then
    begin
      quForm.Edit;
      quFormTotalOtherConf.AsFloat := TotGeral;
    end;
    Free;
  end;

end;

procedure TFchCashRegMovConf.SpeedButton3Click(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
  begin
    if ShowModal = mrOK then
    begin
      quForm.Edit;
      quFormTotalCheckConf.AsFloat := TotGeral;
    end;
    Free;
  end;

end;

procedure TFchCashRegMovConf.btnDebitCardClick(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
  begin
    if ShowModal = mrOK then
    begin
      quForm.Edit;
      quFormTotalDebitConf.AsFloat := TotGeral;
    end;
    Free;
  end;

end;

end.
