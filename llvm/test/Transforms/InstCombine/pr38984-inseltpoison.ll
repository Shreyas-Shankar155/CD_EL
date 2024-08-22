; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s
target datalayout = "p:16:16"

@a = external global [21 x i16], align 1
@offsets = external global [4 x i16], align 1

; The "same gep" optimization should work with vector icmp.
define <4 x i1> @PR38984_1() {
; CHECK-LABEL: @PR38984_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret <4 x i1> <i1 true, i1 true, i1 true, i1 true>
;
entry:
  %0 = load i16, i16* getelementptr ([4 x i16], [4 x i16]* @offsets, i16 0, i16 undef), align 1
  %1 = insertelement <4 x i16> poison, i16 %0, i32 3
  %2 = getelementptr i32, i32* null, <4 x i16> %1
  %3 = getelementptr i32, i32* null, <4 x i16> %1
  %4 = icmp eq <4 x i32*> %2, %3
  ret <4 x i1> %4
}

; The "compare base pointers" optimization should not kick in for vector icmp.
define <4 x i1> @PR38984_2() {
; CHECK-LABEL: @PR38984_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i16, i16* getelementptr ([4 x i16], [4 x i16]* @offsets, i16 0, i16 undef), align 2
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i16> poison, i16 [[TMP0]], i64 3
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i16, i16* getelementptr inbounds ([21 x i16], [21 x i16]* @a, i16 1, i16 0), <4 x i16> [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i16, i16* null, <4 x i16> [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq <4 x i16*> [[TMP2]], [[TMP3]]
; CHECK-NEXT:    ret <4 x i1> [[TMP4]]
;
entry:
  %0 = load i16, i16* getelementptr ([4 x i16], [4 x i16]* @offsets, i16 0, i16 undef)
  %1 = insertelement <4 x i16> poison, i16 %0, i32 3
  %2 = getelementptr i16, i16* getelementptr ([21 x i16], [21 x i16]* @a, i64 1, i32 0), <4 x i16> %1
  %3 = getelementptr i16, i16* null, <4 x i16> %1
  %4 = icmp eq <4 x i16*> %2, %3
  ret <4 x i1> %4
}
