program MRPet;

uses
  Windows,
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uDMGlobal in '..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uDMGlobalNTier in '..\RepositoryD7\uDMGlobalNTier.pas' {DMGlobalNTier: TDataModule},
  uDMPet in 'uDMPet.pas' {DMPet: TDataModule},
  uDMPetCenter in 'uDMPetCenter.pas' {DMPetCenter: TDataModule},
  uParentForm in '..\ParentNT\uParentForm.pas' {ParentForm},
  uParentCustomList in '..\ParentNT\uParentCustomList.pas' {ParentCustomList},
  uParentList in '..\ParentNT\uParentList.pas' {ParentList},
  uParentToolBarList in '..\ParentNT\uParentToolBarList.pas' {ParentToolBarList},
  uParentCustomFch in '..\ParentNT\uParentCustomFch.pas' {ParentCustomFch},
  uParentButtonFch in '..\ParentNT\uParentButtonFch.pas' {ParentButtonFch},
  uParentModalForm in '..\ParentNT\uParentModalForm.pas' {ParentModalForm},
  uPctMicrochipFrm in 'uPctMicrochipFrm.pas' {PctMicrochipFrm},
  uPctTreatmentList in 'uPctTreatmentList.pas' {PctTreatmentList},
  uPctTreatmentFch in 'uPctTreatmentFch.pas' {PctTreatmentFch},
  uPctMedicalConditionList in 'uPctMedicalConditionList.pas' {PctMedicalConditionList},
  uPctMedicalConditionFch in 'uPctMedicalConditionFch.pas' {PctMedicalConditionFch},
  uPctBreedList in 'uPctBreedList.pas' {PctBreedList},
  uPctBreedFch in 'uPctBreedFch.pas' {PctBreedFch},
  uPctRegistryFch in 'uPctRegistryFch.pas' {PctRegistryFch},
  uPctRegistryList in 'uPctRegistryList.pas' {PctRegistryList},
  uMainWebFrm in 'uMainWebFrm.pas' {MainWebFrm},
  uMntStateFch in 'uMntStateFch.pas' {MntStateFch},
  uDMMaintenance in 'uDMMaintenance.pas' {DMMaintenance: TDataModule},
  uMntEntityList in 'uMntEntityList.pas' {MntEntityList},
  uMntEntityFch in 'uMntEntityFch.pas' {MntEntityFch},
  uConfigFrm in 'uConfigFrm.pas' {ConfigFrm},
  uMntCountryFch in 'uMntCountryFch.pas' {MntCountryFch},
  uPctPetList in 'uPctPetList.pas' {PctPetList},
  uPctPetFch in 'uPctPetFch.pas' {PctPetFch},
  uParentCustomSubList in '..\ParentNT\uParentCustomSubList.pas' {ParentCustomSubList},
  uParentButtonSubList in '..\ParentNT\uParentButtonSubList.pas' {ParentButtonSubList},
  uPctPetRegistrySubList in 'uPctPetRegistrySubList.pas' {PctPetRegistrySubList},
  uPctPetRegistryFch in 'uPctPetRegistryFch.pas' {PctPetRegistryFch},
  uPctPetMicrochipSubList in 'uPctPetMicrochipSubList.pas' {PctPetMicrochipSubList},
  uPctPetMicrochipFch in 'uPctPetMicrochipFch.pas' {PctPetMicrochipFch},
  uPctPetWeightSubList in 'uPctPetWeightSubList.pas' {PctPetWeightSubList},
  uPctPetWeightFch in 'uPctPetWeightFch.pas' {PctPetWeightFch},
  uPctSpeciesFch in 'uPctSpeciesFch.pas' {PctSpeciesFch},
  uPctMedicalConditionSpeciesSubList in 'uPctMedicalConditionSpeciesSubList.pas' {PctMedicalConditionSpeciesSubList},
  uPctMedicalConditionSpeciesFch in 'uPctMedicalConditionSpeciesFch.pas' {PctMedicalConditionSpeciesFch},
  uPctTreatmentSpeciesSubList in 'uPctTreatmentSpeciesSubList.pas' {PctTreatmentSpeciesSubList},
  uPctTreatmentSpeciesFch in 'uPctTreatmentSpeciesFch.pas' {PctTreatmentSpeciesFch},
  uPctRegistrySpeciesSubList in 'uPctRegistrySpeciesSubList.pas' {PctRegistrySpeciesSubList},
  uPctRegistrySpeciesFch in 'uPctRegistrySpeciesFch.pas' {PctRegistrySpeciesFch},
  uPctTreatmentLotSubList in 'uPctTreatmentLotSubList.pas' {PctTreatmentLotSubList},
  uPctTreatmentLotFch in 'uPctTreatmentLotFch.pas' {PctTreatmentLotFch},
  uPctPetTreatmentSubList in 'uPctPetTreatmentSubList.pas' {PctPetTreatmentSubList},
  uPctPetTreatmentFch in 'uPctPetTreatmentFch.pas' {PctPetTreatmentFch},
  uParentSearchForm in '..\ParentNT\uParentSearchForm.pas' {ParentSearchForm},
  uPctPetSearch in 'uPctPetSearch.pas' {PctPetSearch},
  uPctPetMedicalConditionSubList in 'uPctPetMedicalConditionSubList.pas' {PctPetMedicalConditionSubList},
  uPctPetMedicalConditionFch in 'uPctPetMedicalConditionFch.pas' {PctPetMedicalConditionFch},
  uPctPetTreatmentSearch in 'uPctPetTreatmentSearch.pas' {PctPetTreatmentSearch},
  uPctMicrochipAddFrm in 'uPctMicrochipAddFrm.pas' {PctMicrochipAddFrm},
  uParentPrintForm in '..\ParentNT\uParentPrintForm.pas' {ParentPrintForm},
  uPctWarrantyPrintForm in 'uPctWarrantyPrintForm.pas' {PctWarrantyPrintForm},
  uPctPetSaleFrm in 'uPctPetSaleFrm.pas' {PctPetSaleFrm},
  uPctPetSaleSearch in 'uPctPetSaleSearch.pas' {PctPetSaleSearch},
  uPctColorFch in 'uPctColorFch.pas' {PctColorFch},
  uPctColorSpeciesSubList in 'uPctColorSpeciesSubList.pas' {PctColorSpeciesSubList},
  uPctColorSpeciesFch in 'uPctColorSpeciesFch.pas' {PctColorSpeciesFch},
  uMntSystemUserList in 'uMntSystemUserList.pas' {MntSystemUserList},
  uMntSystemUserFch in 'uMntSystemUserFch.pas' {MntSystemUserFch},
  uLoginForm in 'uLoginForm.pas' {LoginForm},
  uDMWarrantyPrintThread in 'uDMWarrantyPrintThread.pas' {DMWarrantyPrintThread: TDataModule},
  uNTierClasses in '..\ParentNT\uNTierClasses.pas',
  uNTierConsts in '..\ParentNT\uNTierConsts.pas',
  uMainRetailTransferData in '..\RepositoryD7\uMainRetailTransferData.pas',
  uSendDataFrm in 'uSendDataFrm.pas' {SendDataFrm},
  uPctPetTransferList in 'uPctPetTransferList.pas' {PctPetTransferList},
  uPctPetTransferFch in 'uPctPetTransferFch.pas' {PctPetTransferFch};

//var
//  Mutex : THandle;
{$R *.res}

begin
  //Mutex := CreateMutex(nil, True, 'MRPet');
  //if (Mutex <> 0) and (GetLastError = 0) then
  begin
    Application.Initialize;
    Application.Title := 'MRPet';
    Application.CreateForm(TDMPet, DMPet);
    Application.CreateForm(TDMPetCenter, DMPetCenter);
    Application.CreateForm(TFrmMain, FrmMain);
    Application.Run;
    //  if Mutex <> 0 then
    //    CloseHandle(Mutex);
  end;

end.
