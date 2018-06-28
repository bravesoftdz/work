unit uFinLancamentoTrackDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Mask, Buttons, ExtCtrls,
  dxDateEdit, dxDBDateEdit, SuperComboADO, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, dxDBELib, siComp, siLangRT;

type
  TFinLancamentoTrackDlg = class(TParentDialogFrm)
    Label5: TLabel;
    Label6: TLabel;
    DBSuperCombo3: TDBSuperComboADO;
    DBDateBox2: TdxDBDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBSuperCombo1: TDBSuperComboADO;
    DBDateBox1: TdxDBDateEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBSuperCombo2: TDBSuperComboADO;
    DBDateBox5: TdxDBDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinLancamentoTrackDlg: TFinLancamentoTrackDlg;

implementation

uses uFinLancamentoFch;

{$R *.DFM}

end.
