; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -cost-model -analyze -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve < %s | FileCheck %s --check-prefixes=CHECK,CHECK-MVE
; RUN: opt -cost-model -analyze -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve.fp < %s | FileCheck %s --check-prefixes=CHECK,CHECK-MVEFP

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"

define void @icmp() {
; CHECK-LABEL: 'icmp'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %v2i8 = icmp slt <2 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i8 = icmp slt <4 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v8i8 = icmp slt <8 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v16i8 = icmp slt <16 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 132 for instruction: %v32i8 = icmp slt <32 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %v2i16 = icmp slt <2 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i16 = icmp slt <4 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v8i16 = icmp slt <8 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 68 for instruction: %v16i16 = icmp slt <16 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %v2i32 = icmp slt <2 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4i32 = icmp slt <4 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 36 for instruction: %v8i32 = icmp slt <8 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 72 for instruction: %v16i32 = icmp slt <16 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 36 for instruction: %v2i64 = icmp slt <2 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 72 for instruction: %v4i64 = icmp slt <4 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 144 for instruction: %v8i64 = icmp slt <8 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %v2i8 = icmp slt <2 x i8> undef, undef
  %v4i8 = icmp slt <4 x i8> undef, undef
  %v8i8 = icmp slt <8 x i8> undef, undef
  %v16i8 = icmp slt <16 x i8> undef, undef
  %v32i8 = icmp slt <32 x i8> undef, undef

  %v2i16 = icmp slt <2 x i16> undef, undef
  %v4i16 = icmp slt <4 x i16> undef, undef
  %v8i16 = icmp slt <8 x i16> undef, undef
  %v16i16 = icmp slt <16 x i16> undef, undef

  %v2i32 = icmp slt <2 x i32> undef, undef
  %v4i32 = icmp slt <4 x i32> undef, undef
  %v8i32 = icmp slt <8 x i32> undef, undef
  %v16i32 = icmp slt <16 x i32> undef, undef

  %v2i64 = icmp slt <2 x i64> undef, undef
  %v4i64 = icmp slt <4 x i64> undef, undef
  %v8i64 = icmp slt <8 x i64> undef, undef

  ret void
}

define void @fcmp() {
; CHECK-MVE-LABEL: 'fcmp'
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2f16 = fcmp olt <2 x half> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4f16 = fcmp olt <4 x half> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v8f16 = fcmp olt <8 x half> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v16f16 = fcmp olt <16 x half> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2f32 = fcmp olt <2 x float> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4f32 = fcmp olt <4 x float> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v8f32 = fcmp olt <8 x float> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %v16f32 = fcmp olt <16 x float> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %v2f64 = fcmp olt <2 x double> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %v4f64 = fcmp olt <4 x double> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %v8f64 = fcmp olt <8 x double> undef, undef
; CHECK-MVE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-MVEFP-LABEL: 'fcmp'
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f16 = fcmp olt <2 x half> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4f16 = fcmp olt <4 x half> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v8f16 = fcmp olt <8 x half> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 68 for instruction: %v16f16 = fcmp olt <16 x half> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v2f32 = fcmp olt <2 x float> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %v4f32 = fcmp olt <4 x float> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 36 for instruction: %v8f32 = fcmp olt <8 x float> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 72 for instruction: %v16f32 = fcmp olt <16 x float> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %v2f64 = fcmp olt <2 x double> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %v4f64 = fcmp olt <4 x double> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 32 for instruction: %v8f64 = fcmp olt <8 x double> undef, undef
; CHECK-MVEFP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %v2f16 = fcmp olt <2 x half> undef, undef
  %v4f16 = fcmp olt <4 x half> undef, undef
  %v8f16 = fcmp olt <8 x half> undef, undef
  %v16f16 = fcmp olt <16 x half> undef, undef

  %v2f32 = fcmp olt <2 x float> undef, undef
  %v4f32 = fcmp olt <4 x float> undef, undef
  %v8f32 = fcmp olt <8 x float> undef, undef
  %v16f32 = fcmp olt <16 x float> undef, undef

  %v2f64 = fcmp olt <2 x double> undef, undef
  %v4f64 = fcmp olt <4 x double> undef, undef
  %v8f64 = fcmp olt <8 x double> undef, undef

  ret void
}
