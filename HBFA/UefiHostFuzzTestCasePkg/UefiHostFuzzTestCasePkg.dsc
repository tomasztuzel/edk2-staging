## @file UefiHostTestPkg.dsc
# 
# Copyright (c) 2018, Intel Corporation. All rights reserved.<BR>
# SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

[Defines]
  PLATFORM_NAME                  = UefiHostFuzzTestCasePkg
  PLATFORM_GUID                  = 9497CEE4-EEEB-4B38-B0EF-03E01920F040
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/UefiHostFuzzTestCasePkg
  SUPPORTED_ARCHITECTURES        = IA32|X64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT

  DEFINE TEST_WITH_INSTRUMENT = FALSE

[LibraryClasses]
  BaseLib|UefiHostTestPkg/Library/BaseLibHost/BaseLibHost.inf
  CacheMaintenanceLib|UefiHostTestPkg/Library/BaseCacheMaintenanceLibHost/BaseCacheMaintenanceLibHost.inf
  BaseMemoryLib|UefiHostTestPkg/Library/BaseMemoryLibHost/BaseMemoryLibHost.inf
  MemoryAllocationLib|UefiHostTestPkg/Library/MemoryAllocationLibHost/MemoryAllocationLibHost.inf
  DebugLib|UefiHostTestPkg/Library/DebugLibHost/DebugLibHost.inf
  UefiBootServicesTableLib|UefiHostTestPkg/Library/UefiBootServicesTableLibHost/UefiBootServicesTableLibHost.inf
  HobLib|UefiHostTestPkg/Library/HobLibHost/HobLibHost.inf
  SmmMemLib|UefiHostTestPkg/Library/SmmMemLibHost/SmmMemLibHost.inf
  SmmMemLibStubLib|UefiHostTestPkg/Library/SmmMemLibHost/SmmMemLibHost.inf
  DevicePathLib|UefiHostTestPkg/Library/UefiDevicePathLibHost/UefiDevicePathLibHost.inf
  DxeServicesTableLib|UefiHostTestPkg/Library/DxeServicesTableLibHost/DxeServicesTableLibHost.inf
  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf
  SmmServicesTableLib|UefiHostTestPkg/Library/SmmServicesTableLibHost/SmmServicesTableLibHost.inf
  MmServicesTableLib|UefiHostTestPkg/Library/SmmServicesTableLibHost/SmmServicesTableLibHost.inf
  PeiServicesLib|MdePkg/Library/PeiServicesLib/PeiServicesLib.inf
  PeiServicesTablePointerLib|UefiHostTestPkg/Library/PeiServicesTablePointerLibHost/PeiServicesTablePointerLibHost.inf
  UefiDriverEntryPoint|UefiHostTestPkg/Library/UefiDriverEntryPointHost/UefiDriverEntryPointHost.inf
  PeimEntryPoint|UefiHostTestPkg/Library/PeimEntryPointHost/PeimEntryPointHost.inf
  ToolChainHarnessLib|UefiHostFuzzTestPkg/Library/ToolChainHarnessLib/ToolChainHarnessLib.inf

  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  PerformanceLib|MdePkg/Library/BasePerformanceLibNull/BasePerformanceLibNull.inf
  ReportStatusCodeLib|MdePkg/Library/BaseReportStatusCodeLibNull/BaseReportStatusCodeLibNull.inf
  SerialPortLib|MdePkg/Library/BaseSerialPortLibNull/BaseSerialPortLibNull.inf
  SafeIntLib|MdePkg/Library/BaseSafeIntLib/BaseSafeIntLib.inf
  PeCoffGetEntryPointLib|MdePkg/Library/BasePeCoffGetEntryPointLib/BasePeCoffGetEntryPointLib.inf
  DebugAgentLib|MdeModulePkg/Library/DebugAgentLibNull/DebugAgentLibNull.inf
  TimerLib|UefiHostTestPkg/Library/BaseTimerLibHost/BaseTimerLibHost.inf

  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf

  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf

  DiskStubLib|UefiHostFuzzTestCasePkg/TestStub/DiskStubLib/DiskStubLib.inf
  Usb2HcStubLib|UefiHostFuzzTestCasePkg/TestStub/Usb2HcStubLib/Usb2HcStubLib.inf
  Usb2HcPpiStubLib|UefiHostFuzzTestCasePkg/TestStub/Usb2HcPpiStubLib/Usb2HcPpiStubLib.inf
  UsbIoPpiStubLib|UefiHostFuzzTestCasePkg/TestStub/UsbIoPpiStubLib/UsbIoPpiStubLib.inf

  VariablePolicyLib|MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLib.inf
  VariablePolicyHelperLib|MdeModulePkg/Library/VariablePolicyHelperLib/VariablePolicyHelperLib.inf
!if $(TEST_WITH_INSTRUMENT)
  IniParsingLib|UefiInstrumentTestPkg/Library/IniParsingLib/IniParsingLib.inf
  NULL|UefiInstrumentTestPkg/Library/InstrumentLib/InstrumentLib.inf
  InstrumentHookLib|UefiInstrumentTestPkg/Library/InstrumentHookLibNull/InstrumentHookLibNull.inf
!endif

!if $(TEST_WITH_KLEE)
  BaseLib|UefiHostTestPkg/Library/BaseLibHost/BaseLibHostNoAsm.inf
!endif

[LibraryClasses.common.USER_DEFINED]

[Components]
!if $(TEST_WITH_INSTRUMENT)
  UefiHostFuzzTestCasePkg/TestStub/DiskStubLib/DiskStubLib.inf {
    <BuildOptions>
      MSFT:  *_*_*_CC_FLAGS = /Gh /GH /Od /GL-
      GCC:*_*_*_CC_FLAGS = -O0 -finstrument-functions
  }
  UefiHostTestPkg/Library/MemoryAllocationLibHost/MemoryAllocationLibHost.inf {
    <BuildOptions>
      MSFT:  *_*_*_CC_FLAGS = /Gh /GH /Od /GL-
      GCC:*_*_*_CC_FLAGS = -O0 -finstrument-functions
  }
  UefiHostFuzzTestPkg/Library/ToolChainHarnessLib/ToolChainHarnessLib.inf {
    <BuildOptions>
      MSFT:  *_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
      GCC:*_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
  }
!endif

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/Disk/PartitionDxe/TestPartition.inf {
    <LibraryClasses>
      NULL|MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe.inf
!if $(TEST_WITH_INSTRUMENT)
    <BuildOptions>
      MSFT:  *_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
      GCC:*_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
    <LibraryClasses>
      InstrumentHookLib|UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/Disk/PartitionDxe/InstrumentHookLibTestPartition/InstrumentHookLibTestPartition.inf
!endif
  }

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/Disk/UdfDxe/TestUdf.inf {
    <LibraryClasses>
      NULL|MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe.inf
!if $(TEST_WITH_INSTRUMENT)
    <BuildOptions>
      MSFT:  *_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
      GCC:*_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
    <LibraryClasses>
      InstrumentHookLib|UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/Disk/UdfDxe/InstrumentHookLibTestUdf/InstrumentHookLibTestUdf.inf
!endif
  }
  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/Disk/UdfDxe/TestFileName.inf {
    <LibraryClasses>
      NULL|MdeModulePkg/Universal/Disk/UdfDxe/UdfDxe.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Library/BaseBmpSupportLib/TestBmpSupportLib.inf {
    <LibraryClasses>
      BmpSupportLib|MdeModulePkg/Library/BaseBmpSupportLib/BaseBmpSupportLib.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Library/DxeCapsuleLibFmp/TestDxeCapsuleLibFmp.inf {
    <LibraryClasses>
    NULL|MdeModulePkg/Library/DxeCapsuleLibFmp/DxeCapsuleLib.inf
    FileHandleLib|MdePkg/Library/UefiFileHandleLib/UefiFileHandleLib.inf
    UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
    SortLib|MdeModulePkg/Library/BaseSortLib/BaseSortLib.inf
    HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
    DxeServicesLib|MdePkg/Library/DxeServicesLib/DxeServicesLib.inf
    UefiBootManagerLib|MdeModulePkg/Library/UefiBootManagerLib/UefiBootManagerLib.inf
    BmpSupportLib|MdeModulePkg/Library/BaseBmpSupportLib/BaseBmpSupportLib.inf
    DisplayUpdateProgressLib|MdeModulePkg/Library/DisplayUpdateProgressLibGraphics/DisplayUpdateProgressLibGraphics.inf
  }
  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/CapsulePei/Common/TestCapsulePei.inf {
    <LibraryClasses>
    NULL|MdeModulePkg/Universal/CapsulePei/CapsulePei.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Universal/Variable/RuntimeDxe/TestVariableSmm.inf {
    <LibraryClasses>
    NULL|MdeModulePkg/Universal/Variable/RuntimeDxe/VariableSmm.inf
    NULL|UefiHostTestPkg/Library/BaseLibNullCpuid/BaseLibNullCpuid.inf
    AuthVariableLib|MdeModulePkg/Library/AuthVariableLibNull/AuthVariableLibNull.inf
    VarCheckLib|UefiHostTestPkg/Library/VarCheckLibNull/VarCheckLibNull.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/SecurityPkg/Library/Tpm2CommandLib/TestTpm2CommandLib.inf {
    <LibraryClasses>
      Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
      Tpm2DeviceLib|UefiHostFuzzTestCasePkg/TestStub/Tpm2DeviceLibStub/Tpm2DeviceLibStub.inf
      Tpm2DeviceStubLib|UefiHostFuzzTestCasePkg/TestStub/Tpm2DeviceLibStub/Tpm2DeviceLibStub.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Bus/Usb/UsbBusDxe/TestUsb.inf {
    <LibraryClasses>
    NULL|MdeModulePkg/Bus/Usb/UsbBusDxe/UsbBusDxe.inf
  }
  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Bus/Usb/UsbBusPei/TestPeiUsb.inf {
    <LibraryClasses>
    NULL|MdeModulePkg/Bus/Usb/UsbBusPei/UsbBusPei.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/SecurityPkg/Library/FmpAuthenticationLibPkcs7/TestFmpAuthenticationLibPkcs7.inf {
    <LibraryClasses>
    FmpAuthenticationLib|SecurityPkg/Library/FmpAuthenticationLibPkcs7/FmpAuthenticationLibPkcs7.inf
    BaseCryptLib|UefiHostFuzzTestCasePkg/TestCase/SecurityPkg/Library/FmpAuthenticationLibPkcs7/CryptoLibStubPkcs7.inf
  }
  UefiHostFuzzTestCasePkg/TestCase/SecurityPkg/Library/FmpAuthenticationLibRsa2048Sha256/TestFmpAuthenticationLibRsa2048Sha256.inf {
    <LibraryClasses>
    FmpAuthenticationLib|SecurityPkg/Library/FmpAuthenticationLibRsa2048Sha256/FmpAuthenticationLibRsa2048Sha256.inf
    BaseCryptLib|UefiHostFuzzTestCasePkg/TestCase/SecurityPkg/Library/FmpAuthenticationLibRsa2048Sha256/CryptoLibStubRsa2048Sha256.inf
  }

  UefiHostFuzzTestCasePkg/TestCase/FatPkg/FatPei/TestPeiGpt.inf {
    <LibraryClasses>
      NULL|UefiHostFuzzTestCasePkg/TestCase/FatPkg/FatPei/Override/FatPei.inf
!if $(TEST_WITH_INSTRUMENT)
    <BuildOptions>
      MSFT:  *_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
      GCC:*_*_*_CC_FLAGS = "-DTEST_WITH_INSTRUMENT=TRUE"
    <LibraryClasses>
      InstrumentHookLib|UefiHostFuzzTestCasePkg/TestCase/FatPkg/FatPei/InstrumentHookLibTestPeiGpt/InstrumentHookLibTestPeiGpt.inf
!endif
  }

  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Library/SmmLockBoxLib/UpdateLockBoxTestCase/TestUpdateLockBoxFuzzLength.inf {
  <LibraryClasses>
    NULL|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxSmmLib.inf
  }
  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Library/SmmLockBoxLib/UpdateLockBoxTestCase/TestUpdateLockBoxFuzzOffset.inf {
  <LibraryClasses>
    NULL|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxSmmLib.inf
  }
  UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Bus/Ata/AhciPei/TestIdentifyAtaDevice.inf{
  <LibraryClasses>
      NULL|UefiHostFuzzTestCasePkg/TestCase/MdeModulePkg/Bus/Ata/AhciPei/Override/AhciPei.inf
      IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
      PeiServicesLib|MdePkg/Library/PeiServicesLib/PeiServicesLib.inf
      LockBoxLib|MdeModulePkg/Library/LockBoxNullLib/LockBoxNullLib.inf
      PeiServicesTablePointerLib|MdePkg/Library/PeiServicesTablePointerLib/PeiServicesTablePointerLib.inf
  }

!include UefiHostFuzzTestPkg/UefiHostFuzzTestBuildOption.dsc
