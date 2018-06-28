unit uFinHoraFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, ImgList, dxBar, FormConfig, Db, DBTables,
  ExtCtrls, StdCtrls, Buttons, dxDateEdit,
  dxDBDateEdit, Mask, ADODB, PowerADOQuery, SuperComboADO, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxDBELib, siComp, siLangRT, DateBox;

type
  TFinHoraFch = class(TParentFch)
    meEnter: TMaskEdit;
    quFormIDTime: TIntegerField;
    quFormEnterDate: TDateTimeField;
    quFormExitDate: TDateTimeField;
    quFormIDPessoa: TIntegerField;
    quFormIDStore: TIntegerField;
    meExit: TMaskEdit;
    scStore: TDBSuperComboADO;
    scPessoa: TDBSuperComboADO;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    deEnter: TDBDateBox;
    deExit: TDBDateBox;
    procedure meEnterChange(Sender: TObject);
    procedure meExitChange(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    UserTime: Boolean;

    procedure HoraGet;
    procedure HoraSet;
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.DFM}

procedure TFinHoraFch.meEnterChange(Sender: TObject);
begin
  inherited;
  if UserTime then
    TocaFicha;
end;

procedure TFinHoraFch.meExitChange(Sender: TObject);
begin
  inherited;
  if UserTime then
    TocaFicha;

end;

procedure TFinHoraFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  UserTime := True;
  HoraGet;
end;

procedure TFinHoraFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  UserTime := False;
end;

procedure TFinHoraFch.FormCreate(Sender: TObject);
begin
  inherited;
  UserTime := False;
end;

procedure TFinHoraFch.HoraGet;
begin
  meEnter.Text := FormatDateTime('hh:mm', quFormEnterDate.AsDateTime);
  meExit.Text :=  FormatDateTime('hh:mm', quFormExitDate.AsDateTime);
end;

procedure TFinHoraFch.HoraSet;
begin

  quFormEnterDate.AsDateTime :=
        StrToDateTime(  FormatDateTime('ddddd', quFormEnterDate.AsDateTime) + ' ' +
                        meEnter.Text);

  quFormExitDate.AsDateTime :=
        StrToDateTime(  FormatDateTime('ddddd', quFormExitDate.AsDateTime) + ' ' +
                        meExit.Text);
end;

procedure TFinHoraFch.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quForm.UpdateRecord;
  HoraSet;
end;

Initialization
  RegisterClass(TFinHoraFch);


end.
