; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu < %s |\
; RUN:   FileCheck %s --check-prefix=CHECK-PWR8
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mattr=-vsx < %s | FileCheck %s --check-prefix=CHECK-NOVSX
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s --check-prefix=CHECK-PWR7
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix -mcpu=pwr7 \
; RUN:   < %s | FileCheck %s --check-prefix=CHECK-PWR7
; RUN: llc -verify-machineinstrs -mtriple=powerpc-unknown-aix -mcpu=pwr8 < %s |\
; RUN:   FileCheck %s --check-prefix=CHECK-PWR8

define dso_local double @fmsub_t0(double %d, double %d2, double %d3) {
; CHECK-PWR8-LABEL: fmsub_t0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsmsubmdp 1, 2, 3
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fmsub_t0:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fmsub 1, 1, 2, 3
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fmsub_t0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    xsmsubmdp 1, 2, 3
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call double @llvm.ppc.fmsub(double %d, double %d2, double %d3)
  ret double %0
}

declare double @llvm.ppc.fmsub(double, double, double)

define dso_local float @fmsubs_t0(float %f, float %f2, float %f3) {
; CHECK-PWR8-LABEL: fmsubs_t0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsmsubmsp 1, 2, 3
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fmsubs_t0:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fmsubs 1, 1, 2, 3
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fmsubs_t0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    fmsubs 1, 1, 2, 3
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call float @llvm.ppc.fmsubs(float %f, float %f2, float %f3)
  ret float %0
}

declare float @llvm.ppc.fmsubs(float, float, float)

define dso_local double @fnmadd_t0(double %d, double %d2, double %d3) {
; CHECK-PWR8-LABEL: fnmadd_t0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsnmaddmdp 1, 2, 3
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fnmadd_t0:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fnmadd 1, 1, 2, 3
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fnmadd_t0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    xsnmaddmdp 1, 2, 3
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call double @llvm.ppc.fnmadd(double %d, double %d2, double %d3)
  ret double %0
}

declare double @llvm.ppc.fnmadd(double, double, double)

define dso_local float @fnmadds_t0(float %f, float %f2, float %f3) {
; CHECK-PWR8-LABEL: fnmadds_t0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsnmaddmsp 1, 2, 3
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fnmadds_t0:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fnmadds 1, 1, 2, 3
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fnmadds_t0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    fnmadds 1, 1, 2, 3
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call float @llvm.ppc.fnmadds(float %f, float %f2, float %f3)
  ret float %0
}

declare float @llvm.ppc.fnmadds(float, float, float)

define dso_local double @fnmsub_t0(double %d, double %d2, double %d3) {
; CHECK-PWR8-LABEL: fnmsub_t0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsnmsubmdp 1, 2, 3
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fnmsub_t0:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fnmsub 1, 1, 2, 3
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fnmsub_t0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    xsnmsubmdp 1, 2, 3
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call double @llvm.ppc.fnmsub(double %d, double %d2, double %d3)
  ret double %0
}

declare double @llvm.ppc.fnmsub(double, double, double)

define dso_local float @fnmsubs_t0(float %f, float %f2, float %f3) {
; CHECK-PWR8-LABEL: fnmsubs_t0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsnmsubmsp 1, 2, 3
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fnmsubs_t0:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fnmsubs 1, 1, 2, 3
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fnmsubs_t0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    fnmsubs 1, 1, 2, 3
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call float @llvm.ppc.fnmsubs(float %f, float %f2, float %f3)
  ret float %0
}

declare float @llvm.ppc.fnmsubs(float, float, float)

define dso_local double @fre(double %d) {
; CHECK-PWR8-LABEL: fre:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsredp 1, 1
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fre:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fre 1, 1
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fre:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    xsredp 1, 1
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call double @llvm.ppc.fre(double %d)
  ret double %0
}

declare double @llvm.ppc.fre(double)

define dso_local float @fres(float %f) {
; CHECK-PWR8-LABEL: fres:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    xsresp 1, 1
; CHECK-PWR8-NEXT:    blr
;
; CHECK-NOVSX-LABEL: fres:
; CHECK-NOVSX:       # %bb.0: # %entry
; CHECK-NOVSX-NEXT:    fres 1, 1
; CHECK-NOVSX-NEXT:    blr
;
; CHECK-PWR7-LABEL: fres:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    fres 1, 1
; CHECK-PWR7-NEXT:    blr
entry:
  %0 = tail call float @llvm.ppc.fres(float %f)
  ret float %0
}

declare float @llvm.ppc.fres(float)
