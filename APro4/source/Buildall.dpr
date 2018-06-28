(***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is TurboPower Async Professional
 *
 * The Initial Developer of the Original Code is
 * TurboPower Software
 *
 * Portions created by the Initial Developer are Copyright (C) 1991-2002
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

program BuildAll;

{$DEFINE BuildDesignUnits}

uses
  {$IFDEF BuildDesignUnits}
  AproReg,
  AdPEdit0,
  AdPEditT,
  AdPropEd,
  AdStatE0,                                                              {!!.04}
  AdStatEd,                                                              {!!.04}
  {$ENDIF}
  AdAbout,
  AdExcept,
  AdFax,
  AdFaxCtl,
  AdFaxCvt,
  AdFaxPrn,
  AdFaxSrv,
  AdFiDlg,
  AdFPStat,
  AdFStat,
  AdFtp,
  AdFView,
  AdGsm,
  AdISapi,                                                               {!!.04}
  AdITapi3,                                                              {!!.04}
  AdLibMdm,
  AdMdm,
  AdMdmCfg,
  AdMdmDlg,
  AdMeter,
  AdPackEd,
  AdPacket,
  AdPager,
  AdPgr,                                                                 {!!.04}
  AdPort,
  AdProtcl,
  AdPStat,
  AdRas,
  AdRasUtl,
  AdRStat,
  AdSapiEn,
  AdSapiGr,
  AdSapiPh,
  AdScript,
  AdSelCom,
  AdSocket,
  AdSrmgr,
  AdStatLt,
  AdStDs,                                                                {!!.04}
  AdStFax,                                                               {!!.04}
  AdStMach,
  AdStProt,                                                              {!!.04}
  AdStrMap,                                                              {!!.04}
  AdStSapi,                                                              {!!.04}
  AdStSt,                                                                {!!.04}
  AdTapi,
  AdTrmBuf,
  AdTrmEmu,
  AdTrmMap,
  AdTrmPsr,
  AdTSel,
  AdTStat,
  AdTUtil,
  AdVoIP,
  AdVoIPEd,                                                              {!!.04}
  AdWnPort,
  AdWUtil,
  AdXBase,
  AdXChrFlt,
  AdXDial,
  AdXDown,
  AdXLbMdm,
  AdXParsr,
  AdXPort,
  AdXProt,
  AdXUp,
  AwAbsFax,
  AwAbsPcl,
  AwAscii,
  AwFax,
  AwFaxCvt,
  AwFView,
  AwKermit,
  AwTPcl,
  AwUser,
  AwWin32,
  AwWnsock,
  AwXmodem,
  AwYmodem,
  AwZModem,
  OoMisc,
  PDrvInNt,
  PDrvInst,
  PDrvUni,
  PDrvUnNt;

begin
end.

