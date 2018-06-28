unit uDMMaintenance;

interface

uses
  SysUtils, Classes, cxContainer, cxEdit;

const
   PT_CUSTOMER    = 1;
   PT_VENDOR      = 2;
   PT_COMMISSION  = 3;
   PT_SALESPERSON = 4;
   PT_GUIDE       = 5;
   PT_AGENCY      = 6;
   PT_MANUFACTURE = 7;
   PT_OTHER       = 9;
   PT_BREEDER     = 100;

   PT_PATH_CUSTOMER    = '.001';
   PT_PATH_VENDOR      = '.002';
   PT_PATH_COMMISSION  = '.003';
   PT_PATH_SALESPERSON = '.003.001';
   PT_PATH_GUIDE       = '.003.002';
   PT_PATH_AGENCY      = '.003.003';
   PT_PATH_OTHER       = '.003.004';
   PT_PATH_MANUFACTURE = '.004';


type
  TDMMaintenance = class(TDataModule)
    cxStyleController: TcxEditStyleController;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
