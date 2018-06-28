unit uPctSpeciesFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit, StdCtrls;

type
  TPctSpeciesFch = class(TParentButtonFch)
    edtSpecies: TmrDBEdit;
    btnEditReport: TXiButton;
    procedure btnEditReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uPctWarrantyPrintForm, uClasseFunctions;

{$R *.dfm}

procedure TPctSpeciesFch.btnEditReportClick(Sender: TObject);
var
  Form : TForm;
  WPD: TWarrantyPrintData;
begin
  inherited;
  Form := CreateForm(Self, 'TPctWarrantyPrintForm');
  try
    TPctWarrantyPrintForm(Form).Preview := True;
    WPD := TWarrantyPrintData.Create;
    try
      WPD.IDSpecies := DataSet.FieldByName('IDSpecies').AsInteger;
      TPctWarrantyPrintForm(Form).DesignReport(WPD);
    finally
      WPD.Free;
    end;
  finally
    FreeAndNil(Form);
  end;
end;


initialization
  RegisterClass(TPctSpeciesFch);


end.
