; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-- -mcpu=generic < %s | FileCheck %s

; Verify that the DAGCombiner doesn't wrongly remove the 'and' from the dag.

define i8 @foo(<4 x i8>* %V) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movb 2(%rdi), %al
; CHECK-NEXT:    andb $95, %al
; CHECK-NEXT:    retq
  %Vp = bitcast <4 x i8>* %V to <3 x i8>*
  %V3i8 = load <3 x i8>, <3 x i8>* %Vp, align 4
  %t0 = and <3 x i8> %V3i8, <i8 undef, i8 undef, i8 95>
  %t1 = extractelement <3 x i8> %t0, i64 2
  ret i8 %t1
}

