{ *********************************************************************** }
{                                                                         }
{ Author: Yanniel Alvarez Alfonso                                         }
{ Description: Miscellaneous routines                                     }
{ Copyright (c) ????-2012 Pinogy Corporation                              }
{                                                                         }
{ *********************************************************************** }

unit uFrmConfigNetworkDrive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmConfigNetworkDrive = class(TForm)
    panHeader: TPanel;
    gbxBody: TGroupBox;
    labUsername: TLabel;
    labPassword: TLabel;
    labFolder: TLabel;
    labExample: TLabel;
    edtFolder: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    panFooter: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    labHeader: TLabel;
    labDescription: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfigNetworkDrive: TFrmConfigNetworkDrive;

implementation

{$R *.dfm}

end.
