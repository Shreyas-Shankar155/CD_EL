; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -tailcallopt < %s -mtriple=x86_64-unknown-unknown | FileCheck %s -check-prefix=X64
; RUN: llc -tailcallopt < %s -mtriple=i686-unknown-unknown   | FileCheck %s -check-prefix=X32

; llc -tailcallopt should not enable tail calls from fastcc to tailcc or vice versa

declare tailcc i32 @tailcallee1(i32 %a1, i32 %a2, i32 %a3, i32 %a4)

define fastcc i32 @tailcaller1(i32 %in1, i32 %in2) nounwind {
; X64-LABEL: tailcaller1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pushq %rax
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    movl %esi, %ecx
; X64-NEXT:    callq tailcallee1@PLT
; X64-NEXT:    retq $8
;
; X32-LABEL: tailcaller1:
; X32:       # %bb.0: # %entry
; X32-NEXT:    pushl %edx
; X32-NEXT:    pushl %ecx
; X32-NEXT:    calll tailcallee1@PLT
; X32-NEXT:    retl
entry:
  %tmp11 = tail call tailcc i32 @tailcallee1(i32 %in1, i32 %in2, i32 %in1, i32 %in2)
  ret i32 %tmp11
}

declare fastcc i32 @tailcallee2(i32 %a1, i32 %a2, i32 %a3, i32 %a4)

define tailcc i32 @tailcaller2(i32 %in1, i32 %in2) nounwind {
; X64-LABEL: tailcaller2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    pushq %rax
; X64-NEXT:    movl %edi, %edx
; X64-NEXT:    movl %esi, %ecx
; X64-NEXT:    callq tailcallee2@PLT
; X64-NEXT:    retq $8
;
; X32-LABEL: tailcaller2:
; X32:       # %bb.0: # %entry
; X32-NEXT:    pushl %edx
; X32-NEXT:    pushl %ecx
; X32-NEXT:    calll tailcallee2@PLT
; X32-NEXT:    retl
entry:
  %tmp11 = tail call fastcc i32 @tailcallee2(i32 %in1, i32 %in2, i32 %in1, i32 %in2)
  ret i32 %tmp11
}
