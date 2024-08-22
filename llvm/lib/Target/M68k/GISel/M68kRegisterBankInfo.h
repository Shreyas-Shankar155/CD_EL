//===-- M68kRegisterBankInfo.h ----------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
/// \file
/// This file declares the targeting of the RegisterBankInfo class for M68k.
/// \todo This should be generated by TableGen.
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_M68K_GLSEL_M68KREGISTERBANKINFO_H
#define LLVM_LIB_TARGET_M68K_GLSEL_M68KREGISTERBANKINFO_H

#include "llvm/CodeGen/GlobalISel/RegisterBankInfo.h"

#define GET_REGBANK_DECLARATIONS
#include "M68kGenRegisterBank.inc"
#undef GET_REGBANK_DECLARATIONS

namespace llvm {

class TargetRegisterInfo;

class M68kGenRegisterBankInfo : public RegisterBankInfo {
protected:
#define GET_TARGET_REGBANK_CLASS
#include "M68kGenRegisterBank.inc"
#undef GET_TARGET_REGBANK_CLASS
};

/// This class provides the information for the target register banks.
class M68kRegisterBankInfo final : public M68kGenRegisterBankInfo {
public:
  M68kRegisterBankInfo(const TargetRegisterInfo &TRI);

  const RegisterBank &getRegBankFromRegClass(const TargetRegisterClass &RC,
                                             LLT) const override;

  const InstructionMapping &
  getInstrMapping(const MachineInstr &MI) const override;
};
} // end namespace llvm
#endif // LLVM_LIB_TARGET_M68K_GLSEL_M68KREGISTERBANKINFO_H
