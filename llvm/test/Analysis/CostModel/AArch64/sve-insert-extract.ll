; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -cost-model -analyze -S < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"


define void @ins_el0() #0 {
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v0 = insertelement <vscale x 16 x i8> zeroinitializer, i8 0, i64 0
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v1 = insertelement <vscale x 8 x i16> zeroinitializer, i16 0, i64 0
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v2 = insertelement <vscale x 4 x i32> zeroinitializer, i32 0, i64 0
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v3 = insertelement <vscale x 2 x i64> zeroinitializer, i64 0, i64 0
  %v0 = insertelement <vscale x 16 x i8> zeroinitializer, i8 0, i64 0
  %v1 = insertelement <vscale x 8 x i16> zeroinitializer, i16 0, i64 0
  %v2 = insertelement <vscale x 4 x i32> zeroinitializer, i32 0, i64 0
  %v3 = insertelement <vscale x 2 x i64> zeroinitializer, i64 0, i64 0
  ret void
}

define void @ins_el1() #0 {
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v0 = insertelement <vscale x 16 x i8> zeroinitializer, i8 0, i64 1
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v1 = insertelement <vscale x 8 x i16> zeroinitializer, i16 0, i64 1
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v2 = insertelement <vscale x 4 x i32> zeroinitializer, i32 0, i64 1
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v3 = insertelement <vscale x 2 x i64> zeroinitializer, i64 0, i64 1
  %v0 = insertelement <vscale x 16 x i8> zeroinitializer, i8 0, i64 1
  %v1 = insertelement <vscale x 8 x i16> zeroinitializer, i16 0, i64 1
  %v2 = insertelement <vscale x 4 x i32> zeroinitializer, i32 0, i64 1
  %v3 = insertelement <vscale x 2 x i64> zeroinitializer, i64 0, i64 1
  ret void
}


define void @ext_el0() #0 {
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v0 = extractelement <vscale x 16 x i8> zeroinitializer, i64 0
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v1 = extractelement <vscale x 8 x i16> zeroinitializer, i64 0
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v2 = extractelement <vscale x 4 x i32> zeroinitializer, i64 0
; CHECK: Cost Model: Found an estimated cost of 0 for instruction:   %v3 = extractelement <vscale x 2 x i64> zeroinitializer, i64 0
  %v0 = extractelement <vscale x 16 x i8> zeroinitializer, i64 0
  %v1 = extractelement <vscale x 8 x i16> zeroinitializer, i64 0
  %v2 = extractelement <vscale x 4 x i32> zeroinitializer, i64 0
  %v3 = extractelement <vscale x 2 x i64> zeroinitializer, i64 0
  ret void
}

define void @ext_el1() #0 {
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v0 = extractelement <vscale x 16 x i8> zeroinitializer, i64 1
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v1 = extractelement <vscale x 8 x i16> zeroinitializer, i64 1
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v2 = extractelement <vscale x 4 x i32> zeroinitializer, i64 1
; CHECK: Cost Model: Found an estimated cost of 3 for instruction:   %v3 = extractelement <vscale x 2 x i64> zeroinitializer, i64 1
  %v0 = extractelement <vscale x 16 x i8> zeroinitializer, i64 1
  %v1 = extractelement <vscale x 8 x i16> zeroinitializer, i64 1
  %v2 = extractelement <vscale x 4 x i32> zeroinitializer, i64 1
  %v3 = extractelement <vscale x 2 x i64> zeroinitializer, i64 1
  ret void
}


attributes #0 = { "target-features"="+sve" vscale_range(1, 16) }
