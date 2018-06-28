unit uSystemObj;

interface

const
  SYS_MODULE_TRIAL = 'D';
  SYS_MODULE_1     = '1';
  SYS_MODULE_2     = '2';
  SYS_MODULE_3     = '3';
  SYS_MODULE_4     = '4';
  SYS_MODULE_5     = '5';
  SYS_ERROR        = 'E';

type
  TSystem = Class
    private
      fStartMode      : Char;
      fShutDownOnExit : Boolean;
      fValidLicense   : Boolean;
      fVersion        : Integer;
      fBuild          : Integer;
      fShowTip        : Boolean;
      fModule         : String;
      fVerBuild       : String;
    public
      property StartMode      : Char    read fStartMode      write fStartMode;
      property ShutDownOnExit : Boolean read fShutDownOnExit write fShutDownOnExit;
      property ValidLicense   : Boolean read fValidLicense   write fValidLicense;
      property Version        : Integer read fVersion        write fVersion;
      property Build          : Integer read fBuild          write fBuild;
      property ShowTip        : Boolean read fShowTip        write fShowTip;
      property Module         : String  read fModule         write fModule;
      property VerBuild       : String  read fVerBuild       write fVerBuild;
  end;


implementation


end.
