unit MRAppServer_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 05/31/2017 10:47:20 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\work\MRAppServer\MRAppServer.tlb (1)
// LIBID: {7BD6FF66-3B38-46EB-A7B9-0CF10A9E412C}
// LCID: 0
// Helpfile: 
// HelpString: MRAppServer Library
// DepndLst: 
//   (1) v1.0 Midas, (C:\Windows\system32\midas.dll)
//   (2) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, Midas, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MRAppServerMajorVersion = 1;
  MRAppServerMinorVersion = 0;

  LIBID_MRAppServer: TGUID = '{7BD6FF66-3B38-46EB-A7B9-0CF10A9E412C}';

  IID_IRDMApplicationHub: TGUID = '{634D5FA1-BD97-4BC7-B68C-1939CE908BA2}';
  CLASS_RDMApplicationHub: TGUID = '{572F6870-260E-4D79-8E86-63F8F0BA0948}';
  IID_IParentRDM: TGUID = '{404A2BEF-8160-4259-80A2-2E5B263BDF80}';
  IID_IRDMExport: TGUID = '{C40D85B3-F078-4D28-B367-2A466BC05F63}';
  CLASS_RDMExport: TGUID = '{78DD7D09-82DC-460F-8E67-B60271306D44}';
  IID_IRDMImport: TGUID = '{ECEE03EB-F92F-498A-8EBC-753DA1BC91B3}';
  CLASS_RDMImport: TGUID = '{285452ED-651F-4431-9318-8192B2B9394B}';
  IID_IRDMReport: TGUID = '{AA2B9C76-1A7D-4650-AD3A-78DB761D3511}';
  CLASS_RDMReport: TGUID = '{15D15B17-6794-4151-BE7B-32EFE07FF89B}';
  IID_IRDMLookupInventory: TGUID = '{A0CD6F74-FD83-46E6-B0A2-2F0FB8A6561C}';
  CLASS_RDMLookupInventory: TGUID = '{9F9DC85D-7A90-49B7-9062-CBE6DCB94951}';
  IID_IRDMLookupPurchase: TGUID = '{688A3F79-CCAC-4B0B-95A5-BDAEF88A3104}';
  CLASS_RDMLookupPurchase: TGUID = '{D39965AE-3A86-40CF-96B3-CBDA0F6865BD}';
  IID_IRDMLookupMaintenance: TGUID = '{D588C419-D733-4C43-A259-30A234EDD37C}';
  CLASS_RDMLookupMaintenance: TGUID = '{3D20CB0B-125A-4C96-8471-B4A7F843EDC6}';
  IID_IRDMCatalog: TGUID = '{5E3ECD36-193A-401C-B0AD-34522397DF14}';
  CLASS_RDMCatalog: TGUID = '{6EC5F816-8CB7-4D28-A317-CB55F8C3804E}';
  IID_IRDMPetCenter: TGUID = '{7889EBE1-9D25-4FDC-BFE5-23BEB8A2CBEE}';
  CLASS_RDMPetCenter: TGUID = '{1E9B6104-9772-4170-92DE-5CB90C4EB5DD}';
  IID_IRDMMaintenance: TGUID = '{21AC89BC-18E9-4887-A1FE-BA31105A6B94}';
  CLASS_RDMMaintenance: TGUID = '{6CD39B28-3589-4B9D-801D-84771D934F82}';
  IID_IRDMLookUpPet: TGUID = '{13167E6F-AFEE-4872-9180-8619335A08EA}';
  CLASS_RDMLookUpPet: TGUID = '{FFF376AC-4707-4FC7-A2DB-0F87033EBF37}';
  IID_IRDMSearchPet: TGUID = '{2C99F01B-DD77-40DF-9571-8FF1162EFFDB}';
  CLASS_RDMSearchPet: TGUID = '{267DF457-5357-4F90-9A78-0E752A6BEB6D}';
  IID_IRDMLookUpSO: TGUID = '{FFB3DB77-5204-4957-A0C5-198BE10FBD48}';
  CLASS_RDMLookUpSO: TGUID = '{E48A3454-7EEF-4F70-ABFE-E1D8354166EB}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IRDMApplicationHub = interface;
  IRDMApplicationHubDisp = dispinterface;
  IParentRDM = interface;
  IParentRDMDisp = dispinterface;
  IRDMExport = interface;
  IRDMExportDisp = dispinterface;
  IRDMImport = interface;
  IRDMImportDisp = dispinterface;
  IRDMReport = interface;
  IRDMReportDisp = dispinterface;
  IRDMLookupInventory = interface;
  IRDMLookupInventoryDisp = dispinterface;
  IRDMLookupPurchase = interface;
  IRDMLookupPurchaseDisp = dispinterface;
  IRDMLookupMaintenance = interface;
  IRDMLookupMaintenanceDisp = dispinterface;
  IRDMCatalog = interface;
  IRDMCatalogDisp = dispinterface;
  IRDMPetCenter = interface;
  IRDMPetCenterDisp = dispinterface;
  IRDMMaintenance = interface;
  IRDMMaintenanceDisp = dispinterface;
  IRDMLookUpPet = interface;
  IRDMLookUpPetDisp = dispinterface;
  IRDMSearchPet = interface;
  IRDMSearchPetDisp = dispinterface;
  IRDMLookUpSO = interface;
  IRDMLookUpSODisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RDMApplicationHub = IRDMApplicationHub;
  RDMExport = IRDMExport;
  RDMImport = IRDMImport;
  RDMReport = IRDMReport;
  RDMLookupInventory = IRDMLookupInventory;
  RDMLookupPurchase = IRDMLookupPurchase;
  RDMLookupMaintenance = IRDMLookupMaintenance;
  RDMCatalog = IRDMCatalog;
  RDMPetCenter = IRDMPetCenter;
  RDMMaintenance = IRDMMaintenance;
  RDMLookUpPet = IRDMLookUpPet;
  RDMSearchPet = IRDMSearchPet;
  RDMLookUpSO = IRDMLookUpSO;


// *********************************************************************//
// Interface: IRDMApplicationHub
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {634D5FA1-BD97-4BC7-B68C-1939CE908BA2}
// *********************************************************************//
  IRDMApplicationHub = interface(IAppServer)
    ['{634D5FA1-BD97-4BC7-B68C-1939CE908BA2}']
    procedure LogIn(const IDClient: WideString; const Station: WideString); safecall;
    procedure LogOut(const IDClient: WideString; const Station: WideString); safecall;
    procedure StartTransaction; safecall;
    procedure CommitTransaction; safecall;
    procedure RollbackTransaction; safecall;
    function InTransaction: WordBool; safecall;
    function Get_SQLConnection: Integer; safecall;
    function Get_RDMExport: IRDMExport; safecall;
    function Get_RDMImport: IRDMImport; safecall;
    function Get_RDMReport: IRDMReport; safecall;
    function GetConnectionString: WideString; safecall;
    function Get_RDMLookupInventory: IRDMLookupInventory; safecall;
    function Get_RDMLookupPurchase: IRDMLookupPurchase; safecall;
    function Get_RDMLookupMaintenance: IRDMLookupMaintenance; safecall;
    function GetSvrParamValue(IDParam: Integer): OleVariant; safecall;
    function Get_RDMCatalog: IRDMCatalog; safecall;
    function IsClientServer: WordBool; safecall;
    function GetNextCode(const TableName: WideString; const CodeField: WideString): OleVariant; safecall;
    function Get_RDMPetCenter: IRDMPetCenter; safecall;
    function Get_RDMMaintenance: IRDMMaintenance; safecall;
    procedure SaveAppTrace(IdUser: Integer; ErrorLevel: Integer; const FormClass: WideString; 
                           const Method: WideString; const Exception: WideString; 
                           const RecordId: WideString; const Software: WideString); safecall;
    function Get_RDMLookUpPet: IRDMLookUpPet; safecall;
    function Get_RDMSearchPet: IRDMSearchPet; safecall;
    function TestUniqueFields(const TableName: WideString; const Fields: WideString; 
                              const Values: WideString; const KeyFieldName: WideString; 
                              const KeyFieldValue: WideString): WordBool; safecall;
    function SoftwareGetExpDate(const Software: WideString): OleVariant; safecall;
    function SoftwareModuleAccess(const Software: WideString; const Module: WideString): WordBool; safecall;
    function SoftwareAccess(const Software: WideString): WordBool; safecall;
    function SoftwareKey: OleVariant; safecall;
    function SoftwareDelete(const Software: WideString): WordBool; safecall;
    function IsCorpServer: WordBool; safecall;
    function Get_RDMLookUpSO: RDMLookUpSO; safecall;
    property SQLConnection: Integer read Get_SQLConnection;
    property RDMExport: IRDMExport read Get_RDMExport;
    property RDMImport: IRDMImport read Get_RDMImport;
    property RDMReport: IRDMReport read Get_RDMReport;
    property RDMLookupInventory: IRDMLookupInventory read Get_RDMLookupInventory;
    property RDMLookupPurchase: IRDMLookupPurchase read Get_RDMLookupPurchase;
    property RDMLookupMaintenance: IRDMLookupMaintenance read Get_RDMLookupMaintenance;
    property RDMCatalog: IRDMCatalog read Get_RDMCatalog;
    property RDMPetCenter: IRDMPetCenter read Get_RDMPetCenter;
    property RDMMaintenance: IRDMMaintenance read Get_RDMMaintenance;
    property RDMLookUpPet: IRDMLookUpPet read Get_RDMLookUpPet;
    property RDMSearchPet: IRDMSearchPet read Get_RDMSearchPet;
    property RDMLookUpSO: RDMLookUpSO read Get_RDMLookUpSO;
  end;

// *********************************************************************//
// DispIntf:  IRDMApplicationHubDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {634D5FA1-BD97-4BC7-B68C-1939CE908BA2}
// *********************************************************************//
  IRDMApplicationHubDisp = dispinterface
    ['{634D5FA1-BD97-4BC7-B68C-1939CE908BA2}']
    procedure LogIn(const IDClient: WideString; const Station: WideString); dispid 301;
    procedure LogOut(const IDClient: WideString; const Station: WideString); dispid 302;
    procedure StartTransaction; dispid 303;
    procedure CommitTransaction; dispid 304;
    procedure RollbackTransaction; dispid 305;
    function InTransaction: WordBool; dispid 306;
    property SQLConnection: Integer readonly dispid 307;
    property RDMExport: IRDMExport readonly dispid 309;
    property RDMImport: IRDMImport readonly dispid 310;
    property RDMReport: IRDMReport readonly dispid 308;
    function GetConnectionString: WideString; dispid 311;
    property RDMLookupInventory: IRDMLookupInventory readonly dispid 312;
    property RDMLookupPurchase: IRDMLookupPurchase readonly dispid 313;
    property RDMLookupMaintenance: IRDMLookupMaintenance readonly dispid 314;
    function GetSvrParamValue(IDParam: Integer): OleVariant; dispid 315;
    property RDMCatalog: IRDMCatalog readonly dispid 316;
    function IsClientServer: WordBool; dispid 317;
    function GetNextCode(const TableName: WideString; const CodeField: WideString): OleVariant; dispid 318;
    property RDMPetCenter: IRDMPetCenter readonly dispid 319;
    property RDMMaintenance: IRDMMaintenance readonly dispid 320;
    procedure SaveAppTrace(IdUser: Integer; ErrorLevel: Integer; const FormClass: WideString; 
                           const Method: WideString; const Exception: WideString; 
                           const RecordId: WideString; const Software: WideString); dispid 321;
    property RDMLookUpPet: IRDMLookUpPet readonly dispid 322;
    property RDMSearchPet: IRDMSearchPet readonly dispid 323;
    function TestUniqueFields(const TableName: WideString; const Fields: WideString; 
                              const Values: WideString; const KeyFieldName: WideString; 
                              const KeyFieldValue: WideString): WordBool; dispid 324;
    function SoftwareGetExpDate(const Software: WideString): OleVariant; dispid 325;
    function SoftwareModuleAccess(const Software: WideString; const Module: WideString): WordBool; dispid 326;
    function SoftwareAccess(const Software: WideString): WordBool; dispid 327;
    function SoftwareKey: OleVariant; dispid 328;
    function SoftwareDelete(const Software: WideString): WordBool; dispid 329;
    function IsCorpServer: WordBool; dispid 330;
    property RDMLookUpSO: RDMLookUpSO readonly dispid 331;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IParentRDM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {404A2BEF-8160-4259-80A2-2E5B263BDF80}
// *********************************************************************//
  IParentRDM = interface(IAppServer)
    ['{404A2BEF-8160-4259-80A2-2E5B263BDF80}']
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
    property RDMApplicationHub: IRDMApplicationHub read Get_RDMApplicationHub write Set_RDMApplicationHub;
  end;

// *********************************************************************//
// DispIntf:  IParentRDMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {404A2BEF-8160-4259-80A2-2E5B263BDF80}
// *********************************************************************//
  IParentRDMDisp = dispinterface
    ['{404A2BEF-8160-4259-80A2-2E5B263BDF80}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMExport
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C40D85B3-F078-4D28-B367-2A466BC05F63}
// *********************************************************************//
  IRDMExport = interface(IParentRDM)
    ['{C40D85B3-F078-4D28-B367-2A466BC05F63}']
    function ExportPO(AFile: OleVariant; const PONumber: WideString; var AMsgLog: WideString): OleVariant; safecall;
    function InsertConfigExport(IDPessoa: Integer; const DelimiterSeparator: WideString; 
                                const DecimalSeparator: WideString; const HeaderConfig: WideString; 
                                const FileFormat: WideString; HeaderFile: WordBool; 
                                ExportType: Integer; var AMsgLog: WideString): WordBool; safecall;
    function GetConfigExport(IDPessoa: Integer; ExportType: Integer; 
                             var DelimiterSeparator: WideString; var DecimalSeparator: WideString; 
                             var HeaderConfig: WideString; var FileFormat: WideString; 
                             var HeaderFile: WordBool; var AMsgLog: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRDMExportDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C40D85B3-F078-4D28-B367-2A466BC05F63}
// *********************************************************************//
  IRDMExportDisp = dispinterface
    ['{C40D85B3-F078-4D28-B367-2A466BC05F63}']
    function ExportPO(AFile: OleVariant; const PONumber: WideString; var AMsgLog: WideString): OleVariant; dispid 401;
    function InsertConfigExport(IDPessoa: Integer; const DelimiterSeparator: WideString; 
                                const DecimalSeparator: WideString; const HeaderConfig: WideString; 
                                const FileFormat: WideString; HeaderFile: WordBool; 
                                ExportType: Integer; var AMsgLog: WideString): WordBool; dispid 402;
    function GetConfigExport(IDPessoa: Integer; ExportType: Integer; 
                             var DelimiterSeparator: WideString; var DecimalSeparator: WideString; 
                             var HeaderConfig: WideString; var FileFormat: WideString; 
                             var HeaderFile: WordBool; var AMsgLog: WideString): WordBool; dispid 403;
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMImport
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {ECEE03EB-F92F-498A-8EBC-753DA1BC91B3}
// *********************************************************************//
  IRDMImport = interface(IParentRDM)
    ['{ECEE03EB-F92F-498A-8EBC-753DA1BC91B3}']
    function ValidatePOTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                const AImportConfig: WideString; var AMsgLog: WideString; 
                                var APassed: WordBool): OleVariant; safecall;
    procedure ImportPOTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                               const AImportConfig: WideString; var AMsgLog: WideString); safecall;
    function ImportCatalogTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                   const AImportConfig: WideString; var AMsgLog: WideString): WordBool; safecall;
    function ValidatePurchaseNum(const PurchaseNum: WideString; const Vendor: WideString): WordBool; safecall;
    procedure ImportPersonTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                   const AImportConfig: WideString; var AMsgLog: WideString); safecall;
    procedure ImportInventoryTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                      const AImportConfig: WideString; var AMsgLog: WideString); safecall;
    function ValidateInventoryTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                       const AImportConfig: WideString; var AMsgLog: WideString; 
                                       var APassed: WordBool): OleVariant; safecall;
    function ValidateModelsPOTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                      const AImportConfig: WideString; var AMsgLog: WideString; 
                                      var APassed: WordBool): OleVariant; safecall;
    function ExistsPONum(const PONumber: WideString): WordBool; safecall;
    function InsertConfigImport(IDPessoa: Integer; ImportType: Integer; 
                                const CrossColumn: WideString; CaseCost: WordBool; 
                                var AMsgLog: WideString): WordBool; safecall;
    function GetConfigImport(IDPessoa: Integer; ImportType: Integer; var CrossColumn: WideString; 
                             var CaseCost: WordBool; var AMsgLog: WideString): WordBool; safecall;
    function ValidateVCTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                const AImportConfig: WideString; var AMsgLog: WideString; 
                                var APassed: WordBool): OleVariant; safecall;
    procedure ImportVCTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                               const AImportConfig: WideString; var AMsgLog: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IRDMImportDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {ECEE03EB-F92F-498A-8EBC-753DA1BC91B3}
// *********************************************************************//
  IRDMImportDisp = dispinterface
    ['{ECEE03EB-F92F-498A-8EBC-753DA1BC91B3}']
    function ValidatePOTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                const AImportConfig: WideString; var AMsgLog: WideString; 
                                var APassed: WordBool): OleVariant; dispid 401;
    procedure ImportPOTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                               const AImportConfig: WideString; var AMsgLog: WideString); dispid 402;
    function ImportCatalogTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                   const AImportConfig: WideString; var AMsgLog: WideString): WordBool; dispid 403;
    function ValidatePurchaseNum(const PurchaseNum: WideString; const Vendor: WideString): WordBool; dispid 404;
    procedure ImportPersonTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                   const AImportConfig: WideString; var AMsgLog: WideString); dispid 405;
    procedure ImportInventoryTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                      const AImportConfig: WideString; var AMsgLog: WideString); dispid 406;
    function ValidateInventoryTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                       const AImportConfig: WideString; var AMsgLog: WideString; 
                                       var APassed: WordBool): OleVariant; dispid 407;
    function ValidateModelsPOTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                      const AImportConfig: WideString; var AMsgLog: WideString; 
                                      var APassed: WordBool): OleVariant; dispid 408;
    function ExistsPONum(const PONumber: WideString): WordBool; dispid 409;
    function InsertConfigImport(IDPessoa: Integer; ImportType: Integer; 
                                const CrossColumn: WideString; CaseCost: WordBool; 
                                var AMsgLog: WideString): WordBool; dispid 410;
    function GetConfigImport(IDPessoa: Integer; ImportType: Integer; var CrossColumn: WideString; 
                             var CaseCost: WordBool; var AMsgLog: WideString): WordBool; dispid 411;
    function ValidateVCTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                const AImportConfig: WideString; var AMsgLog: WideString; 
                                var APassed: WordBool): OleVariant; dispid 412;
    procedure ImportVCTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                               const AImportConfig: WideString; var AMsgLog: WideString); dispid 413;
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMReport
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AA2B9C76-1A7D-4650-AD3A-78DB761D3511}
// *********************************************************************//
  IRDMReport = interface(IParentRDM)
    ['{AA2B9C76-1A7D-4650-AD3A-78DB761D3511}']
  end;

// *********************************************************************//
// DispIntf:  IRDMReportDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AA2B9C76-1A7D-4650-AD3A-78DB761D3511}
// *********************************************************************//
  IRDMReportDisp = dispinterface
    ['{AA2B9C76-1A7D-4650-AD3A-78DB761D3511}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMLookupInventory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A0CD6F74-FD83-46E6-B0A2-2F0FB8A6561C}
// *********************************************************************//
  IRDMLookupInventory = interface(IParentRDM)
    ['{A0CD6F74-FD83-46E6-B0A2-2F0FB8A6561C}']
  end;

// *********************************************************************//
// DispIntf:  IRDMLookupInventoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A0CD6F74-FD83-46E6-B0A2-2F0FB8A6561C}
// *********************************************************************//
  IRDMLookupInventoryDisp = dispinterface
    ['{A0CD6F74-FD83-46E6-B0A2-2F0FB8A6561C}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMLookupPurchase
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {688A3F79-CCAC-4B0B-95A5-BDAEF88A3104}
// *********************************************************************//
  IRDMLookupPurchase = interface(IParentRDM)
    ['{688A3F79-CCAC-4B0B-95A5-BDAEF88A3104}']
  end;

// *********************************************************************//
// DispIntf:  IRDMLookupPurchaseDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {688A3F79-CCAC-4B0B-95A5-BDAEF88A3104}
// *********************************************************************//
  IRDMLookupPurchaseDisp = dispinterface
    ['{688A3F79-CCAC-4B0B-95A5-BDAEF88A3104}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMLookupMaintenance
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D588C419-D733-4C43-A259-30A234EDD37C}
// *********************************************************************//
  IRDMLookupMaintenance = interface(IParentRDM)
    ['{D588C419-D733-4C43-A259-30A234EDD37C}']
  end;

// *********************************************************************//
// DispIntf:  IRDMLookupMaintenanceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D588C419-D733-4C43-A259-30A234EDD37C}
// *********************************************************************//
  IRDMLookupMaintenanceDisp = dispinterface
    ['{D588C419-D733-4C43-A259-30A234EDD37C}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMCatalog
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5E3ECD36-193A-401C-B0AD-34522397DF14}
// *********************************************************************//
  IRDMCatalog = interface(IParentRDM)
    ['{5E3ECD36-193A-401C-B0AD-34522397DF14}']
    function GetNewCostPriceList(const AFilter: WideString): OleVariant; safecall;
    function UpdatePrices(ModelList: OleVariant; var MsgLog: WideString; 
                          const ACatalogConfig: WideString): WordBool; safecall;
    function GetNewInventoryList(const AFilter: WideString): OleVariant; safecall;
    function UpdateInventory(ModelList: OleVariant; var MsgLog: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRDMCatalogDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5E3ECD36-193A-401C-B0AD-34522397DF14}
// *********************************************************************//
  IRDMCatalogDisp = dispinterface
    ['{5E3ECD36-193A-401C-B0AD-34522397DF14}']
    function GetNewCostPriceList(const AFilter: WideString): OleVariant; dispid 401;
    function UpdatePrices(ModelList: OleVariant; var MsgLog: WideString; 
                          const ACatalogConfig: WideString): WordBool; dispid 402;
    function GetNewInventoryList(const AFilter: WideString): OleVariant; dispid 403;
    function UpdateInventory(ModelList: OleVariant; var MsgLog: WideString): WordBool; dispid 404;
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMPetCenter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7889EBE1-9D25-4FDC-BFE5-23BEB8A2CBEE}
// *********************************************************************//
  IRDMPetCenter = interface(IParentRDM)
    ['{7889EBE1-9D25-4FDC-BFE5-23BEB8A2CBEE}']
    function PetRegistryExist(IDPet: Integer; IDRegistry: Integer): WordBool; safecall;
    function PetSKUExist(const SKU: WideString): WordBool; safecall;
    function PetInsertMicrochip(IDCategory: Integer; const Barcode: WideString; 
                                const Model: WideString; const Description: WideString; 
                                SalePrice: Currency; var MsgError: WideString): WordBool; safecall;
    function PetCreateSale(PetSale: OleVariant; MicrochipSale: OleVariant; 
                           RegistrySale: OleVariant; var MsgError: WideString; 
                           var IDPetSale: Integer): WordBool; safecall;
    function ValidatePetTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                 const AImportConfig: WideString; var AMsgLog: WideString; 
                                 var APassed: WordBool): OleVariant; safecall;
    procedure ImportPetTextFile(AFile: OleVariant; ATreatment: OleVariant; 
                                const ALinkedColumns: WideString; const AImportConfig: WideString; 
                                var AMsgLog: WideString); safecall;
    function MicrochipExist(const Microchip: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRDMPetCenterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7889EBE1-9D25-4FDC-BFE5-23BEB8A2CBEE}
// *********************************************************************//
  IRDMPetCenterDisp = dispinterface
    ['{7889EBE1-9D25-4FDC-BFE5-23BEB8A2CBEE}']
    function PetRegistryExist(IDPet: Integer; IDRegistry: Integer): WordBool; dispid 401;
    function PetSKUExist(const SKU: WideString): WordBool; dispid 402;
    function PetInsertMicrochip(IDCategory: Integer; const Barcode: WideString; 
                                const Model: WideString; const Description: WideString; 
                                SalePrice: Currency; var MsgError: WideString): WordBool; dispid 403;
    function PetCreateSale(PetSale: OleVariant; MicrochipSale: OleVariant; 
                           RegistrySale: OleVariant; var MsgError: WideString; 
                           var IDPetSale: Integer): WordBool; dispid 404;
    function ValidatePetTextFile(AFile: OleVariant; const ALinkedColumns: WideString; 
                                 const AImportConfig: WideString; var AMsgLog: WideString; 
                                 var APassed: WordBool): OleVariant; dispid 405;
    procedure ImportPetTextFile(AFile: OleVariant; ATreatment: OleVariant; 
                                const ALinkedColumns: WideString; const AImportConfig: WideString; 
                                var AMsgLog: WideString); dispid 406;
    function MicrochipExist(const Microchip: WideString): WordBool; dispid 407;
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMMaintenance
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {21AC89BC-18E9-4887-A1FE-BA31105A6B94}
// *********************************************************************//
  IRDMMaintenance = interface(IParentRDM)
    ['{21AC89BC-18E9-4887-A1FE-BA31105A6B94}']
  end;

// *********************************************************************//
// DispIntf:  IRDMMaintenanceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {21AC89BC-18E9-4887-A1FE-BA31105A6B94}
// *********************************************************************//
  IRDMMaintenanceDisp = dispinterface
    ['{21AC89BC-18E9-4887-A1FE-BA31105A6B94}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMLookUpPet
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {13167E6F-AFEE-4872-9180-8619335A08EA}
// *********************************************************************//
  IRDMLookUpPet = interface(IParentRDM)
    ['{13167E6F-AFEE-4872-9180-8619335A08EA}']
  end;

// *********************************************************************//
// DispIntf:  IRDMLookUpPetDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {13167E6F-AFEE-4872-9180-8619335A08EA}
// *********************************************************************//
  IRDMLookUpPetDisp = dispinterface
    ['{13167E6F-AFEE-4872-9180-8619335A08EA}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMSearchPet
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2C99F01B-DD77-40DF-9571-8FF1162EFFDB}
// *********************************************************************//
  IRDMSearchPet = interface(IParentRDM)
    ['{2C99F01B-DD77-40DF-9571-8FF1162EFFDB}']
    function SendPetData(const Key: WideString; SaleDate: TDateTime): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRDMSearchPetDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2C99F01B-DD77-40DF-9571-8FF1162EFFDB}
// *********************************************************************//
  IRDMSearchPetDisp = dispinterface
    ['{2C99F01B-DD77-40DF-9571-8FF1162EFFDB}']
    function SendPetData(const Key: WideString; SaleDate: TDateTime): WordBool; dispid 401;
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// Interface: IRDMLookUpSO
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FFB3DB77-5204-4957-A0C5-198BE10FBD48}
// *********************************************************************//
  IRDMLookUpSO = interface(IParentRDM)
    ['{FFB3DB77-5204-4957-A0C5-198BE10FBD48}']
  end;

// *********************************************************************//
// DispIntf:  IRDMLookUpSODisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FFB3DB77-5204-4957-A0C5-198BE10FBD48}
// *********************************************************************//
  IRDMLookUpSODisp = dispinterface
    ['{FFB3DB77-5204-4957-A0C5-198BE10FBD48}']
    property RDMApplicationHub: IRDMApplicationHub dispid 201;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer; 
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer; 
                           Options: Integer; const CommandText: WideString; var Params: OleVariant; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer; 
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString; 
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoRDMApplicationHub provides a Create and CreateRemote method to          
// create instances of the default interface IRDMApplicationHub exposed by              
// the CoClass RDMApplicationHub. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMApplicationHub = class
    class function Create: IRDMApplicationHub;
    class function CreateRemote(const MachineName: string): IRDMApplicationHub;
  end;

// *********************************************************************//
// The Class CoRDMExport provides a Create and CreateRemote method to          
// create instances of the default interface IRDMExport exposed by              
// the CoClass RDMExport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMExport = class
    class function Create: IRDMExport;
    class function CreateRemote(const MachineName: string): IRDMExport;
  end;

// *********************************************************************//
// The Class CoRDMImport provides a Create and CreateRemote method to          
// create instances of the default interface IRDMImport exposed by              
// the CoClass RDMImport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMImport = class
    class function Create: IRDMImport;
    class function CreateRemote(const MachineName: string): IRDMImport;
  end;

// *********************************************************************//
// The Class CoRDMReport provides a Create and CreateRemote method to          
// create instances of the default interface IRDMReport exposed by              
// the CoClass RDMReport. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMReport = class
    class function Create: IRDMReport;
    class function CreateRemote(const MachineName: string): IRDMReport;
  end;

// *********************************************************************//
// The Class CoRDMLookupInventory provides a Create and CreateRemote method to          
// create instances of the default interface IRDMLookupInventory exposed by              
// the CoClass RDMLookupInventory. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMLookupInventory = class
    class function Create: IRDMLookupInventory;
    class function CreateRemote(const MachineName: string): IRDMLookupInventory;
  end;

// *********************************************************************//
// The Class CoRDMLookupPurchase provides a Create and CreateRemote method to          
// create instances of the default interface IRDMLookupPurchase exposed by              
// the CoClass RDMLookupPurchase. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMLookupPurchase = class
    class function Create: IRDMLookupPurchase;
    class function CreateRemote(const MachineName: string): IRDMLookupPurchase;
  end;

// *********************************************************************//
// The Class CoRDMLookupMaintenance provides a Create and CreateRemote method to          
// create instances of the default interface IRDMLookupMaintenance exposed by              
// the CoClass RDMLookupMaintenance. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMLookupMaintenance = class
    class function Create: IRDMLookupMaintenance;
    class function CreateRemote(const MachineName: string): IRDMLookupMaintenance;
  end;

// *********************************************************************//
// The Class CoRDMCatalog provides a Create and CreateRemote method to          
// create instances of the default interface IRDMCatalog exposed by              
// the CoClass RDMCatalog. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMCatalog = class
    class function Create: IRDMCatalog;
    class function CreateRemote(const MachineName: string): IRDMCatalog;
  end;

// *********************************************************************//
// The Class CoRDMPetCenter provides a Create and CreateRemote method to          
// create instances of the default interface IRDMPetCenter exposed by              
// the CoClass RDMPetCenter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMPetCenter = class
    class function Create: IRDMPetCenter;
    class function CreateRemote(const MachineName: string): IRDMPetCenter;
  end;

// *********************************************************************//
// The Class CoRDMMaintenance provides a Create and CreateRemote method to          
// create instances of the default interface IRDMMaintenance exposed by              
// the CoClass RDMMaintenance. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMMaintenance = class
    class function Create: IRDMMaintenance;
    class function CreateRemote(const MachineName: string): IRDMMaintenance;
  end;

// *********************************************************************//
// The Class CoRDMLookUpPet provides a Create and CreateRemote method to          
// create instances of the default interface IRDMLookUpPet exposed by              
// the CoClass RDMLookUpPet. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMLookUpPet = class
    class function Create: IRDMLookUpPet;
    class function CreateRemote(const MachineName: string): IRDMLookUpPet;
  end;

// *********************************************************************//
// The Class CoRDMSearchPet provides a Create and CreateRemote method to          
// create instances of the default interface IRDMSearchPet exposed by              
// the CoClass RDMSearchPet. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMSearchPet = class
    class function Create: IRDMSearchPet;
    class function CreateRemote(const MachineName: string): IRDMSearchPet;
  end;

// *********************************************************************//
// The Class CoRDMLookUpSO provides a Create and CreateRemote method to          
// create instances of the default interface IRDMLookUpSO exposed by              
// the CoClass RDMLookUpSO. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRDMLookUpSO = class
    class function Create: IRDMLookUpSO;
    class function CreateRemote(const MachineName: string): IRDMLookUpSO;
  end;

implementation

uses ComObj;

class function CoRDMApplicationHub.Create: IRDMApplicationHub;
begin
  Result := CreateComObject(CLASS_RDMApplicationHub) as IRDMApplicationHub;
end;

class function CoRDMApplicationHub.CreateRemote(const MachineName: string): IRDMApplicationHub;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMApplicationHub) as IRDMApplicationHub;
end;

class function CoRDMExport.Create: IRDMExport;
begin
  Result := CreateComObject(CLASS_RDMExport) as IRDMExport;
end;

class function CoRDMExport.CreateRemote(const MachineName: string): IRDMExport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMExport) as IRDMExport;
end;

class function CoRDMImport.Create: IRDMImport;
begin
  Result := CreateComObject(CLASS_RDMImport) as IRDMImport;
end;

class function CoRDMImport.CreateRemote(const MachineName: string): IRDMImport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMImport) as IRDMImport;
end;

class function CoRDMReport.Create: IRDMReport;
begin
  Result := CreateComObject(CLASS_RDMReport) as IRDMReport;
end;

class function CoRDMReport.CreateRemote(const MachineName: string): IRDMReport;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMReport) as IRDMReport;
end;

class function CoRDMLookupInventory.Create: IRDMLookupInventory;
begin
  Result := CreateComObject(CLASS_RDMLookupInventory) as IRDMLookupInventory;
end;

class function CoRDMLookupInventory.CreateRemote(const MachineName: string): IRDMLookupInventory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMLookupInventory) as IRDMLookupInventory;
end;

class function CoRDMLookupPurchase.Create: IRDMLookupPurchase;
begin
  Result := CreateComObject(CLASS_RDMLookupPurchase) as IRDMLookupPurchase;
end;

class function CoRDMLookupPurchase.CreateRemote(const MachineName: string): IRDMLookupPurchase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMLookupPurchase) as IRDMLookupPurchase;
end;

class function CoRDMLookupMaintenance.Create: IRDMLookupMaintenance;
begin
  Result := CreateComObject(CLASS_RDMLookupMaintenance) as IRDMLookupMaintenance;
end;

class function CoRDMLookupMaintenance.CreateRemote(const MachineName: string): IRDMLookupMaintenance;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMLookupMaintenance) as IRDMLookupMaintenance;
end;

class function CoRDMCatalog.Create: IRDMCatalog;
begin
  Result := CreateComObject(CLASS_RDMCatalog) as IRDMCatalog;
end;

class function CoRDMCatalog.CreateRemote(const MachineName: string): IRDMCatalog;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMCatalog) as IRDMCatalog;
end;

class function CoRDMPetCenter.Create: IRDMPetCenter;
begin
  Result := CreateComObject(CLASS_RDMPetCenter) as IRDMPetCenter;
end;

class function CoRDMPetCenter.CreateRemote(const MachineName: string): IRDMPetCenter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMPetCenter) as IRDMPetCenter;
end;

class function CoRDMMaintenance.Create: IRDMMaintenance;
begin
  Result := CreateComObject(CLASS_RDMMaintenance) as IRDMMaintenance;
end;

class function CoRDMMaintenance.CreateRemote(const MachineName: string): IRDMMaintenance;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMMaintenance) as IRDMMaintenance;
end;

class function CoRDMLookUpPet.Create: IRDMLookUpPet;
begin
  Result := CreateComObject(CLASS_RDMLookUpPet) as IRDMLookUpPet;
end;

class function CoRDMLookUpPet.CreateRemote(const MachineName: string): IRDMLookUpPet;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMLookUpPet) as IRDMLookUpPet;
end;

class function CoRDMSearchPet.Create: IRDMSearchPet;
begin
  Result := CreateComObject(CLASS_RDMSearchPet) as IRDMSearchPet;
end;

class function CoRDMSearchPet.CreateRemote(const MachineName: string): IRDMSearchPet;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMSearchPet) as IRDMSearchPet;
end;

class function CoRDMLookUpSO.Create: IRDMLookUpSO;
begin
  Result := CreateComObject(CLASS_RDMLookUpSO) as IRDMLookUpSO;
end;

class function CoRDMLookUpSO.CreateRemote(const MachineName: string): IRDMLookUpSO;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDMLookUpSO) as IRDMLookUpSO;
end;

end.
