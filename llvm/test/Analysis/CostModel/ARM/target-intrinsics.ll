; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -cost-model -analyze -mtriple=thumbv8.1m.main -mattr=+mve | FileCheck %s --check-prefix=CHECK-THUMB2-RECIP
; RUN: opt < %s -cost-model -analyze -cost-kind=throughput -mtriple=thumbv8.1m.main -mattr=+mve | FileCheck %s --check-prefix=CHECK-THUMB2-RECIP
; RUN: opt < %s -cost-model -analyze -cost-kind=latency -mtriple=thumbv8.1m.main -mattr=+mve | FileCheck %s --check-prefix=CHECK-THUMB2-LAT
; RUN: opt < %s -cost-model -analyze -cost-kind=code-size -mtriple=thumbv8.1m.main -mattr=+mve | FileCheck %s --check-prefix=CHECK-THUMB2-SIZE

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"

define void @intrinsics() {
; CHECK-THUMB2-RECIP-LABEL: 'intrinsics'
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t1 = call i32 @llvm.arm.ssat(i32 undef, i32 undef)
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t2 = tail call { <8 x half>, <8 x half> } @llvm.arm.mve.vld2q.v8f16.p0f16(half* undef)
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t3 = call { i32, i32 } @llvm.arm.mve.sqrshrl(i32 undef, i32 undef, i32 undef, i32 48)
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t4 = tail call { i32, i32 } @llvm.arm.mve.vmlldava.v8i16(i32 0, i32 0, i32 0, i32 0, i32 0, <8 x i16> undef, <8 x i16> undef)
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-THUMB2-LAT-LABEL: 'intrinsics'
; CHECK-THUMB2-LAT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t1 = call i32 @llvm.arm.ssat(i32 undef, i32 undef)
; CHECK-THUMB2-LAT-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %t2 = tail call { <8 x half>, <8 x half> } @llvm.arm.mve.vld2q.v8f16.p0f16(half* undef)
; CHECK-THUMB2-LAT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t3 = call { i32, i32 } @llvm.arm.mve.sqrshrl(i32 undef, i32 undef, i32 undef, i32 48)
; CHECK-THUMB2-LAT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t4 = tail call { i32, i32 } @llvm.arm.mve.vmlldava.v8i16(i32 0, i32 0, i32 0, i32 0, i32 0, <8 x i16> undef, <8 x i16> undef)
; CHECK-THUMB2-LAT-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB2-SIZE-LABEL: 'intrinsics'
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t1 = call i32 @llvm.arm.ssat(i32 undef, i32 undef)
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t2 = tail call { <8 x half>, <8 x half> } @llvm.arm.mve.vld2q.v8f16.p0f16(half* undef)
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t3 = call { i32, i32 } @llvm.arm.mve.sqrshrl(i32 undef, i32 undef, i32 undef, i32 48)
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %t4 = tail call { i32, i32 } @llvm.arm.mve.vmlldava.v8i16(i32 0, i32 0, i32 0, i32 0, i32 0, <8 x i16> undef, <8 x i16> undef)
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %t1 = call i32 @llvm.arm.ssat(i32 undef, i32 undef)
  %t2 = tail call { <8 x half>, <8 x half> } @llvm.arm.mve.vld2q.v8f16.p0f16(half* undef)
  %t3 = call { i32, i32 } @llvm.arm.mve.sqrshrl(i32 undef, i32 undef, i32 undef, i32 48)
  %t4 = tail call { i32, i32 } @llvm.arm.mve.vmlldava.v8i16(i32 0, i32 0, i32 0, i32 0, i32 0, <8 x i16> undef, <8 x i16> undef)
  ret void
}

declare i32 @llvm.arm.ssat(i32, i32)
declare { <8 x half>, <8 x half> } @llvm.arm.mve.vld2q.v8f16.p0f16(half*)
declare { i32, i32 } @llvm.arm.mve.sqrshrl(i32, i32, i32, i32)
declare { i32, i32 } @llvm.arm.mve.vmlldava.v8i16(i32, i32, i32, i32, i32, <8 x i16>, <8 x i16>)
