(*
-----------------------------------------------------------
 Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/UCrpeReg.pas $
 Version:            $Revision: #3 $
 Last Modified Date: $Date: 2003/07/15 $

 Copyright (c) 2001-2003 Crystal Decisions, Inc.
 895 Emerson St., Palo Alto, California, USA 94301.

 All rights reserved.

 This file contains confidential, proprietary information, trade secrets and copyrighted expressions
 that are the property of Crystal Decisions, Inc., 895 Emerson St., Palo Alto, California, USA 94301.

 Any disclosure, reproduction, sale or license of all or any part of the information or expression
 contained in this file is prohibited by California law and the United States copyright law, and may
 be subject to criminal penalties.

 If you are not an employee of Crystal Decisions or otherwise authorized in writing by Crystal Decisions
 to possess this file, please contact Crystal Decisions immediately at the address listed above.
-----------------------------------------------------------

Crystal Reports VCL Component - Registration Unit & Design Dialogs
*)
unit UCrpeReg;

{$I UCRPEDEF.INC}

interface

uses
  Classes, DesignIntf, DesignEditors;

type
{------------------------------------------------------------------------------}
{ Class TCrpeEditor Declaration                                                }
{------------------------------------------------------------------------------}
   TCrpeEditor = class(TComponentEditor)
      function GetVerbCount: Integer; override;
      function GetVerb(Index: Integer): string; override;
      procedure ExecuteVerb(Index: Integer); override;
      procedure Edit; override;
   end; { Class TCrpeEditor }

{------------------------------------------------------------------------------}
{ Class TCrpeDSEditor Declaration                                              }
{------------------------------------------------------------------------------}
   TCrpeDSEditor = class(TComponentEditor)
      function GetVerbCount: Integer; override;
      function GetVerb(Index: Integer): string; override;
      procedure ExecuteVerb(Index: Integer); override;
      procedure Edit; override;
   end; { Class TCrpeDSEditor }

{******************************************************************************}
{ Property Editors                                                             }
{******************************************************************************}

{------------------------------------------------------------------------------}
{ Class TCrAboutBoxProperty Declaration                                        }
{------------------------------------------------------------------------------}
   TCrAboutBoxProperty = class(TStringProperty)
   public
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrAboutBoxProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeDSAboutBoxProperty Declaration                                    }
{------------------------------------------------------------------------------}
   TCrpeDSAboutBoxProperty = class(TStringProperty)
   public
     procedure Edit; override;
     function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeDSAboutBoxProperty }
   
{------------------------------------------------------------------------------}
{ Class TCrExportAppNameProperty Declaration                                   }
{------------------------------------------------------------------------------}
   TCrExportAppNameProperty = class(TStringProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrExportAppNameProperty }

{------------------------------------------------------------------------------}
{ Class TCrLookupStringProperty                                                }
{  Sets up a custom class for the Property Editor for Lookup String properties }
{------------------------------------------------------------------------------}
  TCrLookupStringProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrLookupStringProperty                                                }
{  Sets up a custom class for the Property Editor for Lookup Number properties }
{------------------------------------------------------------------------------}
  TCrLookupNumberProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{------------------------------------------------------------------------------}
{ Class TCrExportFileNameProperty Declaration                                  }
{------------------------------------------------------------------------------}
   TCrExportFileNameProperty = class(TStringProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { Class TCrExportFileNameProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeDesignControlsProperty                                            }
{------------------------------------------------------------------------------}
   TCrpeDesignControlsProperty = class(TStringProperty)
   public
     procedure Edit; override;
     function GetAttributes : TPropertyAttributes; override;
   end; { Class TCrpeDesignControlsProperty }

{------------------------------------------------------------------------------}
{ Class TCrReportNameProperty Declaration                                      }
{------------------------------------------------------------------------------}
   TCrReportNameProperty = class(TStringProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrReportNameProperty }

{------------------------------------------------------------------------------}
{ Class TCrWinControlProperty                                                  }
{  Sets up a custom class for the Property Editor for WindowParent             }
{------------------------------------------------------------------------------}
  TCrWinControlProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;


{******************************************************************************}
{ Class Property Editors                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Class TCrpeAreaFormatProperty                                                }
{------------------------------------------------------------------------------}
   TCrpeAreaFormatProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeAreaFormatProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeBoxesProperty                                                     }
{------------------------------------------------------------------------------}
   TCrpeBoxesProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeBoxesProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeConnectProperty                                                   }
{------------------------------------------------------------------------------}
   TCrpeConnectProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeConnectProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeCrossTabsProperty                                                 }
{------------------------------------------------------------------------------}
   TCrpeCrossTabsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeCrossTabsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeCrossTabSummariesProperty                                         }
{------------------------------------------------------------------------------}
   TCrpeCrossTabSummariesProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeCrossTabSummariesProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeDatabaseFieldsProperty                                            }
{------------------------------------------------------------------------------}
   TCrpeDatabaseFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeDatabaseFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportExcelProperty Declaration                                   }
{------------------------------------------------------------------------------}
   TCrpeExportExcelProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportExcelProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportHTMLProperty Declaration                                    }
{------------------------------------------------------------------------------}
   TCrpeExportHTMLProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportHTMLProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportRTFProperty Declaration                                     }
{------------------------------------------------------------------------------}
   TCrpeExportRTFProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportRTFProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportPDFProperty Declaration                                     }
{------------------------------------------------------------------------------}
   TCrpeExportPDFProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportPDFProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportXMLProperty Declaration                                     }
{------------------------------------------------------------------------------}
   TCrpeExportXMLProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportXMLProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportODBCProperty Declaration                                    }
{------------------------------------------------------------------------------}
   TCrpeExportODBCProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportODBCProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeExportOptionsProperty Declaration                                 }
{------------------------------------------------------------------------------}
   TCrpeExportOptionsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeExportOptionsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeFontProperty                                                      }
{------------------------------------------------------------------------------}
   TCrpeFontProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeFontProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeFormatProperty                                                    }
{------------------------------------------------------------------------------}
   TCrpeFormatProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeFormatProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeBorderProperty                                                    }
{------------------------------------------------------------------------------}
   TCrpeBorderProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeBorderProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeHiliteConditionsProperty                                          }
{------------------------------------------------------------------------------}
   TCrpeHiliteConditionsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeHiliteConditionsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeFormulasProperty Declaration                                      }
{------------------------------------------------------------------------------}
   TCrpeFormulasProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeFormulasProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeGroupNameFieldsProperty                                           }
{------------------------------------------------------------------------------}
   TCrpeGroupNameFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeGroupNameFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeGroupsProperty Declaration                                        }
{------------------------------------------------------------------------------}
   TCrpeGroupsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeGroupsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeGraphsProperty Declaration                                        }
{------------------------------------------------------------------------------}
   TCrpeGraphsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeGraphsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeGroupSelectionProperty Declaration                                }
{------------------------------------------------------------------------------}
   TCrpeGroupSelectionProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeGroupSelectionProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeGroupSortFieldsProperty Declaration                               }
{------------------------------------------------------------------------------}
   TCrpeGroupSortFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeGroupSortFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeLogOnInfoProperty Declaration                                     }
{------------------------------------------------------------------------------}
   TCrpeLogOnInfoProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeLogOnInfoProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeLogOnServerProperty Declaration                                   }
{------------------------------------------------------------------------------}
   TCrpeLogOnServerProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeLogOnServerProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeLinesProperty                                                     }
{------------------------------------------------------------------------------}
   TCrpeLinesProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeLinesProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeMapsProperty                                                      }
{------------------------------------------------------------------------------}
   TCrpeMapsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeMapsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeMarginsProperty                                                   }
{------------------------------------------------------------------------------}
   TCrpeMarginsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeMarginProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeOLAPCubesProperty                                                 }
{------------------------------------------------------------------------------}
   TCrpeOLAPCubesProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeOLAPCubesProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeOleObjectsProperty                                                }
{------------------------------------------------------------------------------}
   TCrpeOleObjectsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeOleObjectsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeParamFieldsProperty                                               }
{------------------------------------------------------------------------------}
   TCrpeParamFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeParamFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpePicturesProperty                                                  }
{------------------------------------------------------------------------------}
   TCrpePicturesProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpePicturesProperty }

{------------------------------------------------------------------------------}
{ Class TCrpePrintDateProperty Declaration                                     }
{------------------------------------------------------------------------------}
   TCrpePrintDateProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpePrintDateProperty }

{------------------------------------------------------------------------------}
{ Class TCrpePrinterProperty Declaration                                       }
{------------------------------------------------------------------------------}
   TCrpePrinterProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpePrinterProperty }

{------------------------------------------------------------------------------}
{ Class TCrpePrintOptionsProperty Declaration                                  }
{------------------------------------------------------------------------------}
   TCrpePrintOptionsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpePrintOptionsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeReportOptionsProperty                                             }
{------------------------------------------------------------------------------}
   TCrpeReportOptionsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeReportOptionsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeRunningTotalsProperty Declaration                                 }
{------------------------------------------------------------------------------}
   TCrpeRunningTotalsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes: TPropertyAttributes; override;
   end; { Class TCrpeRunningTotalsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSectionFormatProperty                                             }
{------------------------------------------------------------------------------}
   TCrpeSectionFormatProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSectionFormatProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSectionFontProperty                                               }
{------------------------------------------------------------------------------}
   TCrpeSectionFontProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSectionFontProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSectionSizeProperty                                               }
{------------------------------------------------------------------------------}
   TCrpeSectionSizeProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSectionSizeProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSelectionProperty                                                 }
{------------------------------------------------------------------------------}
   TCrpeSelectionProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSelectionProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSessionInfoProperty                                               }
{------------------------------------------------------------------------------}
   TCrpeSessionInfoProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSessionInfoProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSortFieldsProperty                                                }
{------------------------------------------------------------------------------}
   TCrpeSortFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSortFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSpecialFieldsProperty                                             }
{------------------------------------------------------------------------------}
   TCrpeSpecialFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSpecialFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSQLProperty                                                       }
{------------------------------------------------------------------------------}
   TCrpeSQLProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSQLProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSQLExpressionsProperty                                            }
{------------------------------------------------------------------------------}
   TCrpeSQLExpressionsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSQLExpressionsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSummaryFieldsProperty                                             }
{------------------------------------------------------------------------------}
   TCrpeSummaryFieldsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSummaryFieldsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSummaryInfoProperty                                               }
{------------------------------------------------------------------------------}
   TCrpeSummaryInfoProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSummaryInfoProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeTablesProperty                                                    }
{------------------------------------------------------------------------------}
   TCrpeTablesProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeTablesProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeTextObjectsProperty                                                    }
{------------------------------------------------------------------------------}
   TCrpeTextObjectsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeTextObjectsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeSubreportsProperty                                                }
{------------------------------------------------------------------------------}
   TCrpeSubreportsProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeSubreportsProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeVersionProperty                                                   }
{------------------------------------------------------------------------------}
   TCrpeVersionProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeVersionProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeWindowButtonBarProperty                                           }
{------------------------------------------------------------------------------}
   TCrpeWindowButtonBarProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeWindowButtonBarProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeWindowCursorProperty                                              }
{------------------------------------------------------------------------------}
   TCrpeWindowCursorProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeWindowCursorProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeWindowSizeProperty                                                }
{------------------------------------------------------------------------------}
   TCrpeWindowSizeProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeWindowSizeProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeWindowStyleProperty                                               }
{------------------------------------------------------------------------------}
   TCrpeWindowStyleProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeWindowStyleProperty }

{------------------------------------------------------------------------------}
{ Class TCrpeWindowZoomProperty                                                }
{------------------------------------------------------------------------------}
   TCrpeWindowZoomProperty = class(TClassProperty)
   public
      procedure Edit; override;
      function GetAttributes : TPropertyAttributes; override;
   end; { TCrpeWindowZoomProperty }

procedure Register;

implementation

uses
  Printers, Messages, TypInfo, SysUtils, Graphics, Registry,
  Forms, Buttons, StdCtrls, ExtCtrls, Menus, Dialogs,
  UCrpe32, UCrpeClasses, UCrpeUtl, UDAbout, 
  UCrpeDS, UCrpeDSAbout,
  {Dialogs}
  UDAreaFormat, UDBorder, UDBoxes,
  UDConnect, UDCrossTabs, UDCrossTabSummaries, UDDatabaseFields,
  UDDesignControls, UDExportOptions, UDExportSepVal, UDExportExcel,
  UDExportRTF, UDExportHTML4, UDExportODBC, UDExportPagText,
  UDExportPDF, UDExportWord, UDExportXML, UDFont, UDFormat,
  UDFormulas, UDFormulaEdit, UDGraphs,
  UDGroups, UDGroupSelection, UDGroupSortFields, UDGroupNameFields,
  UDHiliteConditions, UDLines, UDLogOnInfo, UDLogOnServer, UDMargins,
  UDMaps, UDOLAPCubes, UDOleObjects, UDPages,
  UDParamFields, UDPFAsDate, UDPFPValues, UDPFCValues, UDPFRanges,
  UDPathEdit, UDPictures, UDPrintDate, UDPrinter, UDPrintOptions,
  UDRecords, UDReportOptions, UDRunningTotals,
  UDSectionFormat, UDSectionFont, UDSectionSize, UDSelection,
  UDSessionInfo, UDSortFields, UDSortFieldBuild, UDSpecialFields,
  UDSQLExpressions, UDSQLQuery, UDSummaryFields, UDSummaryInfo,
  UDTables, UDTableFields, UDTextObjects, UDSubreports, UDVersion,
  UDWindowButtonBar, UDWindowCursor, UDWindowSize, UDWindowStyle,
  UDWindowZoom;

{******************************************************************************}
{ Class TCrpeEditor                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetVerbCount method                                                          }
{------------------------------------------------------------------------------}
function TCrpeEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;
{------------------------------------------------------------------------------}
{ GetVerb method                                                               }
{------------------------------------------------------------------------------}
function TCrpeEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Crystal Reports VCL...';
    1: Result := 'ReportName...';
  end;
end;
{------------------------------------------------------------------------------}
{ ExecuteVerb method                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeEditor.ExecuteVerb(Index: Integer);
var
  dlgOpen : TOpenDialog;
begin
  with Component as TCrpe do
  begin
    case Index of
      0: begin
           Application.CreateForm(TCrpeAboutBox, CrpeAboutBox);
           CrpeAboutBox.lblLanguage.Caption := TCRPE_LANGUAGE;
           CrpeAboutBox.lblCopyright.Caption := TCRPE_COPYRIGHT;
           CrpeAboutBox.lblVersion.Caption := 'Version ' + TCRPE_VERSION;
           CrpeAboutBox.lblCompany.Caption := TCRPE_COMPANY_NAME;
           CrpeAboutBox.lblAddress1.Caption := TCRPE_COMPANY_ADDRESS1;
           CrpeAboutBox.lblAddress2.Caption := TCRPE_COMPANY_ADDRESS2;
           CrpeAboutBox.lblVCLEmail.Caption := TCRPE_VCL_EMAIL;
           CrpeAboutBox.lblVCLWebSite.Caption := TCRPE_VCL_WEBSITE;
           CrpeAboutBox.lblCRPhone.Caption := TCRPE_CR_PHONE;
           CrpeAboutBox.lblCREmail.Caption := TCRPE_CR_EMAIL;
           CrpeAboutBox.lblCRWebSite.Caption := TCRPE_CR_WEBSITE;
           CrpeAboutBox.ShowModal;
         end;
      1: begin
           dlgOpen := TOpenDialog.Create(Application);
           dlgOpen.FileName := '*.rpt';
           dlgOpen.Title := 'Choose a Crystal Report...';
           dlgOpen.Filter := 'Report Files (*.rpt) | *.rpt';
           dlgOpen.DefaultExt := 'rpt';
           dlgOpen.Options := dlgOpen.Options + [ofPathMustExist, ofFileMustExist];
           if dlgOpen.Execute then
             ReportName := dlgOpen.FileName;
           dlgOpen.Free;
         end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ Edit method                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeEditor.Edit;
begin
  ExecuteVerb(1);
end;

{******************************************************************************}
{ Class TCrpeDSEditor                                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetVerbCount method                                                          }
{------------------------------------------------------------------------------}
function TCrpeDSEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;
{------------------------------------------------------------------------------}
{ GetVerb method                                                               }
{------------------------------------------------------------------------------}
function TCrpeDSEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Crystal Reports DataSource VCL...';
  end;
end;
{------------------------------------------------------------------------------}
{ ExecuteVerb method                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeDSEditor.ExecuteVerb(Index: Integer);
begin
  with Component as TCrpeDS do
  begin
    case Index of
      0: begin
           Application.CreateForm(TCrpeDSAboutDlg, CrpeDSAboutDlg);
           CrpeDSAboutDlg.ShowModal;
         end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ Edit method                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeDSEditor.Edit;
begin
  ExecuteVerb(1);
end;

{******************************************************************************}
{ TCrAboutBoxProperty Definition                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrAboutBoxProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Member Edit                                                                  }
{------------------------------------------------------------------------------}
procedure TCrAboutBoxProperty.Edit;
begin
  Application.CreateForm(TCrpeAboutBox, CrpeAboutBox);
  CrpeAboutBox.lblLanguage.Caption := TCRPE_LANGUAGE;
  CrpeAboutBox.lblCopyright.Caption := TCRPE_COPYRIGHT;
  CrpeAboutBox.lblVersion.Caption := 'Version ' + TCRPE_VERSION;
  CrpeAboutBox.lblCompany.Caption := TCRPE_COMPANY_NAME;
  CrpeAboutBox.lblAddress1.Caption := TCRPE_COMPANY_ADDRESS1;
  CrpeAboutBox.lblAddress2.Caption := TCRPE_COMPANY_ADDRESS2;
  CrpeAboutBox.lblVCLEmail.Caption := TCRPE_VCL_EMAIL;
  CrpeAboutBox.lblVCLWebSite.Caption := TCRPE_VCL_WEBSITE;
  CrpeAboutBox.lblCRPhone.Caption := TCRPE_CR_PHONE;
  CrpeAboutBox.lblCREmail.Caption := TCRPE_CR_EMAIL;
  CrpeAboutBox.lblCRWebSite.Caption := TCRPE_CR_WEBSITE;
  CrpeAboutBox.ShowModal;
end; { TCrAboutBoxProperty }


{******************************************************************************}
{ TCrpeDSAboutBoxProperty Definition                                           }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeDSAboutBoxProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Member Edit                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeDSAboutBoxProperty.Edit;
begin
  Application.CreateForm(TCrpeDSAboutDlg, CrpeDSAboutDlg);
  CrpeDSAboutDlg.ShowModal;
end; { TDSAboutDlgProperty }

{******************************************************************************}
{ TCrReportNameProperty Definition                                             }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrReportNameProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrReportNameProperty.Edit;
var
  dlgOpen : TOpenDialog;
begin
  dlgOpen := TOpenDialog.Create(Application);
  dlgOpen.FileName := GetValue;
  dlgOpen.Title := 'Choose a Crystal Report...';
  dlgOpen.Filter := 'Report Files (*.rpt) | *.rpt';
  dlgOpen.DefaultExt := 'rpt';
  dlgOpen.Options := dlgOpen.Options + [ofPathMustExist, ofFileMustExist];
  try
    if dlgOpen.Execute then
      SetValue(dlgOpen.FileName);
  finally
    dlgOpen.Free;
  end;
end; { Edit }


{******************************************************************************}
{ TCrExportAppNameProperty Definition                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrExportAppNameProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrExportAppNameProperty.Edit;
var
  dlgOpen : TOpenDialog;
begin
  dlgOpen := TOpenDialog.Create(Application);
  dlgOpen.FileName := GetValue;
  dlgOpen.Title := 'Choose Export Application...';
  dlgOpen.Filter := 'Application Files (*.exe) | *.exe';
  dlgOpen.DefaultExt := 'exe';
  dlgOpen.Options := dlgOpen.Options + [ofPathMustExist, ofFileMustExist];
  try
    if dlgOpen.Execute then
      SetValue(dlgOpen.FileName);
  finally
    dlgOpen.Free;
  end;
end; { Edit }


{******************************************************************************}
{ TCrExportFileNameProperty                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrExportFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrExportFileNameProperty.Edit;
const
  FileExtensions : array [0..22] of string = ('*.rec', '*.tsv', '*.txt',
    '*.dif', '*.csv', '*.chr', '*.ttx', '*.rpt', '*.wk1', '*.wk3', '*.wks',
    '*.rtf', '*.doc', '*.xls', '*.htm', '*.htm', '*.htm', '*.htm', '*.*',
    '*.txt', '*.txt', '*.pdf', '*.xml');
  FileTypes : array [0..22] of string = ('Record style', 'Tab-separated',
    'Text', 'Data Interchange Format', 'Comma-separated', 'Character-separated',
    'Tab-separated', 'Crystal Report', 'Lotus 1-2-3', 'Lotus 1-2-3', 'Lotus 1-2-3',
    'Rich Text Format', 'Word for Windows', 'Excel', 'HTML 3.0 (Draft Standard)',
    'HTML 3.2 (Extended)', 'HTML 3.2 (Standard)', 'HTML 4 (dHTML)',
    'Not applicable to ODBC', 'Paginated Text', 'Report Definition',
    'Adobe Acrobat', 'Extensible Markup Language');
var
  Crx     : TCrpeExportOptions;
  dlgSave : TSaveDialog;
  ext     : string;
begin
  dlgSave := TSaveDialog.Create(Application);
  dlgSave.Title := 'Set Export FileName';
  dlgSave.FileName := GetValue;
  ext := 'Text (*.txt) | *.txt|All Files (*.*) | *.*';
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Crx := TCrpeExportOptions(GetComponent(0));
    ext := FileExtensions[Ord(Crx.FileType)];
    ext := FileTypes[Ord(Crx.FileType)] +
    ' (' + ext + ')|' + ext + '|All files (*.*) | *.*';
  end;
  dlgSave.Filter := ext;
  dlgSave.Options := [ofPathMustExist, ofHideReadOnly, ofNoReadOnlyReturn];
  try
    if dlgSave.Execute then SetValue(dlgSave.FileName);
  finally
    dlgSave.Free;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeAreaFormatProperty                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeAreaFormatProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bAreaFormat then
    begin
      Application.CreateForm(TCrpeAreaFormatDlg, CrpeAreaFormatDlg);
      CrpeAreaFormatDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeAreaFormatDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeBoxesProperty                                                           }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeBoxesProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeBoxesProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bBoxes then
    begin
      Application.CreateForm(TCrpeBoxesDlg, CrpeBoxesDlg);
      CrpeBoxesDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeBoxesDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeConnectProperty                                                         }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeConnectProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeConnectProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bConnect then
    begin
      Application.CreateForm(TCrpeConnectDlg, CrpeConnectDlg);
      CrpeConnectDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeConnectDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeCrossTabsProperty                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeCrossTabsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bCrossTabs then
    begin
      Application.CreateForm(TCrpeCrossTabsDlg, CrpeCrossTabsDlg);
      CrpeCrossTabsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeCrossTabsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeCrossTabSummariesProperty                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeCrossTabSummariesProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeCrossTabSummariesProperty.Edit;
begin
  if TPersistent(GetComponent(0)) is TCrpeCrossTabSummaries then
  begin
    if not BCrossTabSummaries then
    begin
      Application.CreateForm(TCrpeCrossTabSummariesDlg, CrpeCrossTabSummariesDlg);
      CrpeCrossTabSummariesDlg.Crs := TCrpeCrossTabSummaries(GetComponent(0));
    end;
    CrpeCrossTabSummariesDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeDatabaseFieldsProperty                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeDatabaseFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeDatabaseFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bDatabaseFields then
    begin
      Application.CreateForm(TCrpeDatabaseFieldsDlg, CrpeDatabaseFieldsDlg);
      CrpeDatabaseFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeDatabaseFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeDesignControlsProperty                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeDesignControlsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect, paReadOnly];
end;
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeDesignControlsProperty.Edit;
var
  Cr    : TCrpe;
  OnOff : boolean;
begin
  if GetComponent(0) is TCrpe then
  begin
    Cr := TCrpe(GetComponent(0));
    if not bDesignControls then
    begin
      CrpeDesignControlsDlg := TCrpeDesignControlsDlg.Create(Application);
      CrpeDesignControlsDlg.Cr := Cr;
      {Enable/Disable buttons}
      OnOff := Trim(Cr.ReportName) <> '';
      CrpeDesignControlsDlg.SetButtonState(1,OnOff);
      OnOff := (Cr.ReportWindowHandle > 0);
      CrpeDesignControlsDlg.SetButtonState(2,OnOff);
      CrpeDesignControlsDlg.SetButtonState(3,(not Cr.PrintEnded));
      CrpeDesignControlsDlg.Show;
    end
    else
      CrpeDesignControlsDlg.SetFocus;
  end;
end;


{******************************************************************************}
{ TCrpeExportExcelProperty Definition                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportExcelProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportExcelProperty.Edit;
var
  xExport : TCrpeExportOptions;
begin
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Application.CreateForm(TCrpeExcelDlg, CrpeExcelDlg);
    xExport := TCrpeExportOptions(GetComponent(0));
    CrpeExcelDlg.Cr := xExport.Cr;
    CrpeExcelDlg.ShowModal;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeExportOptionsHTMLProperty Definition                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportHTMLProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportHTMLProperty.Edit;
var
  xExport : TCrpeExportOptions;
begin
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Application.CreateForm(TCrpeHTML4Dlg, CrpeHTML4Dlg);
    xExport := TCrpeExportOptions(GetComponent(0));
    CrpeHTML4Dlg.Cr := xExport.Cr;
    CrpeHTML4Dlg.ShowModal;
  end;
end; { Edit }

{******************************************************************************}
{ TCrpeExportOptionsRTFProperty Definition                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportRTFProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportRTFProperty.Edit;
var
  xExport : TCrpeExportOptions;
begin
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Application.CreateForm(TCrpeRichTextFormatDlg, CrpeRichTextFormatDlg);
    xExport := TCrpeExportOptions(GetComponent(0));
    CrpeRichTextFormatDlg.Cr := xExport.Cr;
    CrpeRichTextFormatDlg.ShowModal;
  end;
end; { Edit }

{******************************************************************************}
{ TCrpeExportOptionsPDFProperty Definition                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportPDFProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportPDFProperty.Edit;
var
  xExport : TCrpeExportOptions;
begin
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Application.CreateForm(TCrpeAdobeAcrobatPDFDlg, CrpeAdobeAcrobatPDFDlg);
    xExport := TCrpeExportOptions(GetComponent(0));
    CrpeAdobeAcrobatPDFDlg.Cr := xExport.Cr;
    CrpeAdobeAcrobatPDFDlg.ShowModal;
  end;
end; { Edit }

{******************************************************************************}
{ TCrpeExportOptionsXMLProperty Definition                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportXMLProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportXMLProperty.Edit;
var
  xExport : TCrpeExportOptions;
begin
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Application.CreateForm(TCrpeXML1Dlg, CrpeXML1Dlg);
    xExport := TCrpeExportOptions(GetComponent(0));
    CrpeXML1Dlg.Cr := xExport.Cr;
    CrpeXML1Dlg.ShowModal;
  end;
end; { Edit }

{******************************************************************************}
{ TCrpeExportOptionsODBCProperty Definition                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportODBCProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportODBCProperty.Edit;
var
  xExport : TCrpeExportOptions;
begin
  if TPersistent(GetComponent(0)) is TCrpeExportOptions then
  begin
    Application.CreateForm(TCrpeODBCDlg, CrpeODBCDlg);
    xExport := TCrpeExportOptions(GetComponent(0));
    CrpeODBCDlg.Cr := xExport.Cr;
    CrpeODBCDlg.ShowModal;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeExportOptionsProperty Definition                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeExportOptionsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Member procedure Edit                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bExportOptions then
    begin
      Application.CreateForm(TCrpeExportOptionsDlg, CrpeExportOptionsDlg);
      CrpeExportOptionsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeExportOptionsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeFontProperty                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeFontProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFontProperty.Edit;
begin
  Application.CreateForm(TCrpeFontDlg, CrpeFontDlg);
  CrpeFontDlg.Crf := TCrpeFont(GetOrdValue);
  CrpeFontDlg.ShowModal;
  SetOrdValue(LongInt(CrpeFontDlg.Crf));
end; { Edit }


{******************************************************************************}
{ TCrpeFormatProperty                                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeFormatProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormatProperty.Edit;
var
  xCr : TPersistent;
begin
  xCr := GetComponent(0);
  if (xCr is TCrpeObjectItemA) then
  begin
    Application.CreateForm(TCrpeFormatDlg, CrpeFormatDlg);
    CrpeFormatDlg.Format := TCrpeObjectItemA(xCr).Format;
    CrpeFormatDlg.ShowModal;
  end;
  if (xCr is TCrpeObjectItemB) then
  begin
    Application.CreateForm(TCrpeFormatDlg, CrpeFormatDlg);
    CrpeFormatDlg.Format := TCrpeObjectItemB(xCr).Format;
    CrpeFormatDlg.ShowModal;
  end;
  if (xCr is TCrpeFieldObjectItem) then
  begin
    Application.CreateForm(TCrpeFormatDlg, CrpeFormatDlg);
    CrpeFormatDlg.Format := TCrpeFieldObjectItem(xCr).Format;
    CrpeFormatDlg.ShowModal;
  end;
  if (xCr is TCrpeEmbeddedFieldsItem) then
  begin
    Application.CreateForm(TCrpeFormatDlg, CrpeFormatDlg);
    CrpeFormatDlg.Format := TCrpeEmbeddedFieldsItem(xCr).Format;
    CrpeFormatDlg.ShowModal;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeBorderProperty                                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeBorderProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeBorderProperty.Edit;
var
  Cr : TPersistent;
begin
  Cr := GetComponent(0);
  if Cr is TCrpeObjectItem then
  begin
    Application.CreateForm(TCrpeBorderDlg, CrpeBorderDlg);
    CrpeBorderDlg.Border := TCrpeObjectItem(Cr).Border;
    CrpeBorderDlg.ShowModal;
  end;
  if Cr is TCrpeEmbeddedFieldsItem then
  begin
    Application.CreateForm(TCrpeBorderDlg, CrpeBorderDlg);
    CrpeBorderDlg.Border := TCrpeEmbeddedFieldsItem(Cr).Border;
    CrpeBorderDlg.ShowModal;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeHiliteConditionsProperty                                                }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeHiliteConditionsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeHiliteConditionsProperty.Edit;
var
  Cr : TPersistent;
begin
  Cr := GetComponent(0);
  if Cr is TCrpeFieldObjectItem then
  begin
    Application.CreateForm(TCrpeHiliteConditionsDlg, CrpeHiliteConditionsDlg);
    CrpeHiliteConditionsDlg.Crh := TCrpeFieldObjectItem(Cr).HiliteConditions;
    CrpeHiliteConditionsDlg.ShowModal;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeFormulasProperty Definition                                             }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeFormulasProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFormulasProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bFormulas then
    begin
      Application.CreateForm(TCrpeFormulasDlg, CrpeFormulasDlg);
      CrpeFormulasDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeFormulasDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeGroupNameFieldsProperty                                                 }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeGroupNameFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupNameFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bGroupNameFields then
    begin
      Application.CreateForm(TCrpeGroupNameFieldsDlg, CrpeGroupNameFieldsDlg);
      CrpeGroupNameFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeGroupNameFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeGroupsProperty Definition                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeGroupsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Member procedure Edit                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bGroups then
    begin
      Application.CreateForm(TCrpeGroupsDlg, CrpeGroupsDlg);
      CrpeGroupsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeGroupsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeGraphsProperty Definition                                               }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeGraphsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Member procedure Edit                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeGraphsProperty.Edit;
var
  Cr : TPersistent;
begin
  Cr := GetComponent(0);
  if Cr is TCrpe then
  begin
    if not TCrpe(Cr).OpenEngine then
      Exit;
    if not bGraphs then
    begin
      Application.CreateForm(TCrpeGraphsDlg, CrpeGraphsDlg);
      CrpeGraphsDlg.Cr := TCrpe(Cr);
    end;
    CrpeGraphsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeGroupSelectionProperty Definition                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeGroupSelectionProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSelectionProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bGroupSelection then
    begin
      Application.CreateForm(TCrpeGroupSelectionDlg, CrpeGroupSelectionDlg);
      CrpeGroupSelectionDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeGroupSelectionDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeGroupSortFieldsProperty Definition                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeGroupSortFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bGroupSortFields then
    begin
      Application.CreateForm(TCrpeGroupSortFieldsDlg, CrpeGroupSortFieldsDlg);
      CrpeGroupSortFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeGroupSortFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeLinesProperty                                                           }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeLinesProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLinesProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bLines then
    begin
      Application.CreateForm(TCrpeLinesDlg, CrpeLinesDlg);
      CrpeLinesDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeLinesDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeLogOnInfoProperty Definition                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeLogOnInfoProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bLogOnInfo then
    begin
      Application.CreateForm(TCrpeLogOnInfoDlg, CrpeLogOnInfoDlg);
      CrpeLogOnInfoDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeLogOnInfoDlg.ShowModal;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeLogOnServerProperty Definition                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeLogOnServerProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bLogOnServer then
    begin
      Application.CreateForm(TCrpeLogOnServerDlg, CrpeLogOnServerDlg);
      CrpeLogOnServerDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeLogOnServerDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeMapsProperty                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeMapsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeMapsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bMaps then
    begin
      Application.CreateForm(TCrpeMapsDlg, CrpeMapsDlg);
      CrpeMapsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeMapsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeMarginsProperty                                                         }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeMarginsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bMargins then
    begin
      Application.CreateForm(TCrpeMarginsDlg, CrpeMarginsDlg);
      CrpeMarginsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeMarginsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeOLAPCubesProperty                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeOLAPCubesProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bOLAPCubes then
    begin
      Application.CreateForm(TCrpeOLAPCubesDlg, CrpeOLAPCubesDlg);
      CrpeOLAPCubesDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeOLAPCubesDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeOleObjectsProperty                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeOleObjectsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bOleObjects then
    begin
      Application.CreateForm(TCrpeOleObjectsDlg, CrpeOleObjectsDlg);
      CrpeOleObjectsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeOleObjectsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeParamFieldsProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeParamFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeParamFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bParamFields then
    begin
      Application.CreateForm(TCrpeParamFieldsDlg, CrpeParamFieldsDlg);
      CrpeParamFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeParamFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpePicturesProperty                                                        }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpePicturesProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePicturesProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bPictures then
    begin
      Application.CreateForm(TCrpePicturesDlg, CrpePicturesDlg);
      CrpePicturesDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpePicturesDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpePrintDateProperty Definition                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpePrintDateProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrintDateProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bPrintDate then
    begin
      Application.CreateForm(TCrpePrintDateDlg, CrpePrintDateDlg);
      CrpePrintDateDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpePrintDateDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpePrinterProperty Definition                                              }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpePrinterProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrinterProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bPrinter then
    begin
      Application.CreateForm(TCrpePrinterDlg, CrpePrinterDlg);
      CrpePrinterDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpePrinterDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpePrintOptionsProperty                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpePrintOptionsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bPrintOptions then
    begin
      Application.CreateForm(TCrpePrintOptionsDlg, CrpePrintOptionsDlg);
      CrpePrintOptionsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpePrintOptionsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeRunningTotalsProperty                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeRunningTotalsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeRunningTotalsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bRunningTotals then
    begin
      Application.CreateForm(TCrpeRunningTotalsDlg, CrpeRunningTotalsDlg);
      CrpeRunningTotalsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeRunningTotalsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSessionInfoProperty Definition                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSessionInfoProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paSubProperties, paDialog, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSessionInfo then
    begin
      Application.CreateForm(TCrpeSessionInfoDlg, CrpeSessionInfoDlg);
      CrpeSessionInfoDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSessionInfoDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSQLProperty                                                             }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSQLProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSQLProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSQLQuery then
    begin
      Application.CreateForm(TCrpeSQLQueryDlg, CrpeSQLQueryDlg);
      CrpeSQLQueryDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSQLQueryDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSQLExpressionsProperty                                                  }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSQLExpressionsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSQLExpressions then
    begin
      Application.CreateForm(TCrpeSQLExpressionsDlg, CrpeSQLExpressionsDlg);
      CrpeSQLExpressionsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSQLExpressionsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSummaryFieldsProperty                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSummaryFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSummaryFields then
    begin
      Application.CreateForm(TCrpeSummaryFieldsDlg, CrpeSummaryFieldsDlg);
      CrpeSummaryFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSummaryFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeReportOptionsProperty                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeReportOptionsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeReportOptionsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bReportOptions then
    begin
      Application.CreateForm(TCrpeReportOptionsDlg, CrpeReportOptionsDlg);
      CrpeReportOptionsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeReportOptionsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSectionFormatProperty                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSectionFormatProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSectionFormat then
    begin
      Application.CreateForm(TCrpeSectionFormatDlg, CrpeSectionFormatDlg);
      CrpeSectionFormatDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSectionFormatDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSectionFontProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSectionFontProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFontProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSectionFont then
    begin
      Application.CreateForm(TCrpeSectionFontDlg, CrpeSectionFontDlg);
      CrpeSectionFontDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSectionFontDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSectionSizeProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSectionSizeProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSectionSize then
    begin
      Application.CreateForm(TCrpeSectionSizeDlg, CrpeSectionSizeDlg);
      CrpeSectionSizeDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSectionSizeDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSelectionProperty                                                       }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSelectionProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSelectionProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSelection then
    begin
      Application.CreateForm(TCrpeSelectionDlg, CrpeSelectionDlg);
      CrpeSelectionDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSelectionDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSortFieldsProperty                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSortFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSortFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSortFields then
    begin
      Application.CreateForm(TCrpeSortFieldsDlg, CrpeSortFieldsDlg);
      CrpeSortFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSortFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSpecialFieldsProperty                                                   }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSpecialFieldsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSpecialFieldsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSpecialFields then
    begin
      Application.CreateForm(TCrpeSpecialFieldsDlg, CrpeSpecialFieldsDlg);
      CrpeSpecialFieldsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSpecialFieldsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSubreportsProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSubreportsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSubreports then
    begin
      Application.CreateForm(TCrpeSubreportsDlg, CrpeSubreportsDlg);
      CrpeSubreportsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSubreportsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeSummaryInfoProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeSummaryInfoProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSummaryInfoProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bSummaryInfo then
    begin
      Application.CreateForm(TCrpeSummaryInfoDlg, CrpeSummaryInfoDlg);
      CrpeSummaryInfoDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeSummaryInfoDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeTablesProperty                                                          }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeTablesProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeTablesProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bTables then
    begin
      Application.CreateForm(TCrpeTablesDlg, CrpeTablesDlg);
      CrpeTablesDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeTablesDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeTextObjectsProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeTextObjectsProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bTextObjects then
    begin
      Application.CreateForm(TCrpeTextObjectsDlg, CrpeTextObjectsDlg);
      CrpeTextObjectsDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeTextObjectsDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeVersionProperty                                                         }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeVersionProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeVersionProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bVersion then
    begin
      Application.CreateForm(TCrpeVersionDlg, CrpeVersionDlg);
      CrpeVersionDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeVersionDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeWindowButtonBarProperty                                                 }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeWindowButtonBarProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowButtonBarProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bWindowButtonBar then
    begin
      Application.CreateForm(TCrpeWindowButtonBarDlg, CrpeWindowButtonBarDlg);
      CrpeWindowButtonBarDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeWindowButtonBarDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeWindowCursorProperty                                                    }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeWindowCursorProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bWindowCursor then
    begin
      Application.CreateForm(TCrpeWindowCursorDlg, CrpeWindowCursorDlg);
      CrpeWindowCursorDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeWindowCursorDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeWindowSizeProperty                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeWindowSizeProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bWindowSize then
    begin
      Application.CreateForm(TCrpeWindowSizeDlg, CrpeWindowSizeDlg);
      CrpeWindowSizeDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeWindowSizeDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeWindowStyleProperty                                                     }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeWindowStyleProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bWindowStyle then
    begin
      Application.CreateForm(TCrpeWindowStyleDlg, CrpeWindowStyleDlg);
      CrpeWindowStyleDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeWindowStyleDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{ TCrpeWindowZoomProperty                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ GetAttributes                                                                }
{------------------------------------------------------------------------------}
function TCrpeWindowZoomProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly, paMultiSelect];
end; { GetAttributes }
{------------------------------------------------------------------------------}
{ Edit                                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomProperty.Edit;
begin
  if GetComponent(0) is TCrpe then
  begin
    if not bWindowZoom then
    begin
      Application.CreateForm(TCrpeWindowZoomDlg, CrpeWindowZoomDlg);
      CrpeWindowZoomDlg.Cr := TCrpe(GetComponent(0));
    end;
    CrpeWindowZoomDlg.Show;
  end;
end; { Edit }


{******************************************************************************}
{*********** Custom Property Editor Fields ************************************}
{******************************************************************************}
{ TCrLookupStringProperty }
function TCrLookupStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;
procedure TCrLookupStringProperty.GetValues(Proc: TGetStrProc);
var
  i  : integer;
  Cx : TPersistent;
begin
  Cx := GetComponent(0);
  if Cx is TCrpeAreaFormat then
  begin
    for i := 0 to (TCrpeAreaFormat(Cx).Count-1) do
      Proc(TCrpeAreaFormat(Cx)[i].Area);
  end;

  if Cx is TCrpeSubreports then
  begin
    for i := 0 to (TCrpeSubreports(Cx).Count-1) do
      Proc(TCrpeSubreports(Cx)[i].Name);
  end;

  if Cx is TCrpeFormulas then
  begin
    for i := 0 to (TCrpeFormulas(Cx).Count-1) do
      Proc(TCrpeFormulas(Cx)[i].Name);
  end;

  if Cx is TCrpeRunningTotals then
  begin
    for i := 0 to (TCrpeRunningTotals(Cx).Count-1) do
      Proc(TCrpeRunningTotals(Cx)[i].Name);
  end;

  if Cx is TCrpeSectionFont then
  begin
    for i := 0 to (TCrpeSectionFont(Cx).Count-1) do
      Proc(TCrpeSectionFont(Cx)[i].Section);
  end;

  if Cx is TCrpeSectionFormat then
  begin
    for i := 0 to (TCrpeSectionFormat(Cx).Count-1) do
      Proc(TCrpeSectionFormat(Cx)[i].Section);
  end;

  if Cx is TCrpeSectionSize then
  begin
    for i := 0 to (TCrpeSectionSize(Cx).Count-1) do
      Proc(TCrpeSectionSize(Cx)[i].Section);
  end;

  if Cx is TCrpeSQLExpressions then
  begin
    for i := 0 to (TCrpeSQLExpressions(Cx).Count-1) do
      Proc(TCrpeSQLExpressions(Cx)[i].Name);
  end;
end;

{ TCrLookupNumberProperty }
function TCrLookupNumberProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;
procedure TCrLookupNumberProperty.GetValues(Proc: TGetStrProc);
var
  i  : integer;
  Cx : TPersistent;
begin
  Cx := GetComponent(0);
  if Cx is TCrpeContainer then
  begin
    for i := 0 to (TCrpeContainer(Cx).Count-1) do
      Proc(IntToStr(i));
  end;
end;

{ TCrWinControlProperty }
procedure TCrWinControlProperty.GetValues(Proc: TGetStrProc);
begin
  {Add Form name to the list}
  Proc(Designer.Root.Name);
  {Add other WinControls}
  inherited GetValues(Proc);
end;

{******************************************************************************}
{ Registration of Component and Property Editors                               }
{******************************************************************************}
procedure Register;
begin
  {Register Component}
  RegisterComponents('Data Access', [TCrpe]);
  RegisterComponents('Data Access', [TCrpeDS]);
  {Register Property Editors}
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeAreaFormat, 'Area', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeSubreports, 'Name', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeFormulas, 'Name', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeRunningTotals, 'Name', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeSectionFont, 'Section', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeSectionFormat, 'Section', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeSectionSize, 'Section', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupString), TCrpeSQLExpressions, 'Name', TCrLookupStringProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupNumber), TCrpeContainer, 'Number', TCrLookupNumberProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupNumber), TCrpeLogOnInfo, 'Table', TCrLookupNumberProperty);
  RegisterPropertyEditor(TypeInfo(TCrLookupNumber), TCrpeSessionInfo, 'Table', TCrLookupNumberProperty);
  RegisterPropertyEditor(TypeInfo(TCrWinControl), TCrpe, '', TCrWinControlProperty);
  {SubClass Property Editors}
  RegisterPropertyEditor(TypeInfo(TCrpeAreaFormat), TCrpe, 'AreaFormat', TCrpeAreaFormatProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeBoxes), TCrpe, 'Boxes', TCrpeBoxesProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeConnect), TCrpe, 'Connect', TCrpeConnectProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeCrossTabs), TCrpe, 'CrossTabs', TCrpeCrossTabsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeCrossTabSummaries), TCrpeCrossTabs, 'Summaries', TCrpeCrossTabSummariesProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeDatabaseFields), TCrpe, 'DatabaseFields', TCrpeDatabaseFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportOptions), TCrpe, 'ExportOptions', TCrpeExportOptionsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportExcel), TCrpeExportOptions, 'Excel', TCrpeExportExcelProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportHTML), TCrpeExportOptions, 'HTML', TCrpeExportHTMLProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportRTF), TCrpeExportOptions, 'RTF', TCrpeExportRTFProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportPDF), TCrpeExportOptions, 'PDF', TCrpeExportPDFProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportXML), TCrpeExportOptions, 'XML', TCrpeExportXMLProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeExportODBC), TCrpeExportOptions, 'ODBC', TCrpeExportODBCProperty);
  RegisterPropertyEditor(TypeInfo(TCrpePersistent), TCrpePersistent, 'Format', TCrpeFormatProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeFont), TCrpePersistent, 'Font', TCrpeFontProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeBorder), TCrpePersistent, 'Border', TCrpeBorderProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeHiliteConditions), TCrpePersistent, 'HiliteConditions', TCrpeHiliteConditionsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeFormulas), TCrpe, 'Formulas', TCrpeFormulasProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeGraphs), TCrpe, 'Graphs', TCrpeGraphsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeGroupNameFields), TCrpe, 'GroupNameFields', TCrpeGroupNameFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeGroupSelection), TCrpe, 'GroupSelection', TCrpeGroupSelectionProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeGroupSortFields), TCrpe, 'GroupSortFields', TCrpeGroupSortFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeGroups), TCrpe, 'Groups', TCrpeGroupsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeLines), TCrpe, 'Lines', TCrpeLinesProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeLogOnInfo), TCrpe, 'LogOnInfo', TCrpeLogOnInfoProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeLogOnServer), TCrpe, 'LogOnServer', TCrpeLogOnServerProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeMaps), TCrpe, 'Maps', TCrpeMapsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeMargins), TCrpe, 'Margins', TCrpeMarginsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeOLAPCubes), TCrpe, 'OLAPCubes', TCrpeOLAPCubesProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeOleObjects), TCrpe, 'OleObjects', TCrpeOleObjectsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeParamFields), TCrpe, 'ParamFields', TCrpeParamFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpePictures), TCrpe, 'Pictures', TCrpePicturesProperty);
  RegisterPropertyEditor(TypeInfo(TCrpePrintDate), TCrpe, 'PrintDate', TCrpePrintDateProperty);
  RegisterPropertyEditor(TypeInfo(TCrpePrinter), TCrpe, 'Printer', TCrpePrinterProperty);
  RegisterPropertyEditor(TypeInfo(TCrpePrintOptions), TCrpe, 'PrintOptions', TCrpePrintOptionsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeRunningTotals), TCrpe, 'RunningTotals', TCrpeRunningTotalsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeReportOptions), TCrpe, 'ReportOptions', TCrpeReportOptionsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSectionFormat), TCrpe, 'SectionFormat', TCrpeSectionFormatProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSectionFont), TCrpe, 'SectionFont', TCrpeSectionFontProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSelection), TCrpe, 'Selection', TCrpeSelectionProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSectionSize), TCrpe, 'SectionSize', TCrpeSectionSizeProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSessionInfo), TCrpe, 'SessionInfo', TCrpeSessionInfoProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSortFields), TCrpe, 'SortFields', TCrpeSortFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSpecialFields), TCrpe, 'SpecialFields', TCrpeSpecialFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSQL), TCrpe, 'SQL', TCrpeSQLProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSQLExpressions), TCrpe, 'SQLExpressions', TCrpeSQLExpressionsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSubreports), TCrpe, 'Subreports', TCrpeSubreportsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSummaryFields), TCrpe, 'SummaryFields', TCrpeSummaryFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeSummaryInfo), TCrpe, 'SummaryInfo', TCrpeSummaryInfoProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeTables), TCrpe, 'Tables', TCrpeTablesProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeTextObjects), TCrpe, 'TextObjects', TCrpeTextObjectsProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeVersion), TCrpe, 'Version', TCrpeVersionProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeWindowButtonBar), TCrpe, 'WindowButtonBar', TCrpeWindowButtonBarProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeWindowCursor), TCrpe, 'WindowCursor', TCrpeWindowCursorProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeWindowStyle), TCrpe, 'WindowStyle', TCrpeWindowStyleProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeWindowSize), TCrpe, 'WindowSize', TCrpeWindowSizeProperty);
  RegisterPropertyEditor(TypeInfo(TCrpeWindowZoom), TCrpe, 'WindowZoom', TCrpeWindowZoomProperty);
  {Open Dialog properties}
  RegisterPropertyEditor(TypeInfo(TCrAboutBox), TCrpe, 'About', TCrAboutBoxProperty);
  RegisterPropertyEditor(TypeInfo(TCrDesignControls), TCrpe, 'DesignControls', TCrpeDesignControlsProperty);
  RegisterPropertyEditor(TypeInfo(TCrExportAppName), TCrpeExportOptions, 'AppName', TCrExportAppNameProperty);
  RegisterPropertyEditor(TypeInfo(TCrExportFileName), TCrpeExportOptions, 'FileName', TCrExportFileNameProperty);
  RegisterPropertyEditor(TypeInfo(TCrReportName), TCrpe, 'ReportName', TCrReportNameProperty);
  RegisterPropertyEditor(TypeInfo(TCrDSAbout), TCrpeDS, 'About', TCrpeDSAboutBoxProperty);
  {Component Editor for Right-click menu}
  RegisterComponentEditor(TCrpe, TCrpeEditor);
  RegisterComponentEditor(TCrpeDS, TCrpeDSEditor);
end;


end.
