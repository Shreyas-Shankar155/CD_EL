; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i386-unknown | FileCheck %s --check-prefix=X86

define i128 @foo(i128 %t, i128 %u) {
; X64-LABEL: foo:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %r8
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    imulq %rdi, %rcx
; X64-NEXT:    mulq %rdx
; X64-NEXT:    addq %rcx, %rdx
; X64-NEXT:    imulq %rsi, %r8
; X64-NEXT:    addq %r8, %rdx
; X64-NEXT:    retq
;
; X86-LABEL: foo:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    pushl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    pushl %edi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    pushl %esi
; X86-NEXT:    .cfi_def_cfa_offset 20
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    .cfi_def_cfa_offset 28
; X86-NEXT:    .cfi_offset %esi, -20
; X86-NEXT:    .cfi_offset %edi, -16
; X86-NEXT:    .cfi_offset %ebx, -12
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-NEXT:    imull %ecx, %ebp
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    mull %ecx
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    imull %esi, %edi
; X86-NEXT:    addl %edx, %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl %ebp, %edi
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-NEXT:    imull %ebp, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    mull %esi
; X86-NEXT:    addl %ecx, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    imull %esi, %ecx
; X86-NEXT:    addl %edx, %ecx
; X86-NEXT:    addl %ebx, %eax
; X86-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X86-NEXT:    adcl %edi, %ecx
; X86-NEXT:    movl %esi, %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    mull %esi
; X86-NEXT:    movl %edx, %edi
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %ebp, %eax
; X86-NEXT:    mull %esi
; X86-NEXT:    movl %edx, %ebx
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    addl %edi, %esi
; X86-NEXT:    adcl $0, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    movl %edx, %edi
; X86-NEXT:    movl %eax, %ebp
; X86-NEXT:    addl %esi, %ebp
; X86-NEXT:    adcl %ebx, %edi
; X86-NEXT:    setb %bl
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    mull {{[0-9]+}}(%esp)
; X86-NEXT:    addl %edi, %eax
; X86-NEXT:    movzbl %bl, %esi
; X86-NEXT:    adcl %esi, %edx
; X86-NEXT:    addl (%esp), %eax # 4-byte Folded Reload
; X86-NEXT:    adcl %ecx, %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ebp, 4(%ecx)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X86-NEXT:    movl %esi, (%ecx)
; X86-NEXT:    movl %eax, 8(%ecx)
; X86-NEXT:    movl %edx, 12(%ecx)
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    addl $8, %esp
; X86-NEXT:    .cfi_def_cfa_offset 20
; X86-NEXT:    popl %esi
; X86-NEXT:    .cfi_def_cfa_offset 16
; X86-NEXT:    popl %edi
; X86-NEXT:    .cfi_def_cfa_offset 12
; X86-NEXT:    popl %ebx
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl $4
  %k = mul i128 %t, %u
  ret i128 %k
}

@aaa = external dso_local global i128
@bbb = external dso_local global i128

define void @PR13897() nounwind {
; X64-LABEL: PR13897:
; X64:       # %bb.0: # %"0x0"
; X64-NEXT:    movl bbb(%rip), %eax
; X64-NEXT:    movq %rax, %rcx
; X64-NEXT:    shlq $32, %rcx
; X64-NEXT:    orq %rax, %rcx
; X64-NEXT:    movq %rcx, aaa+8(%rip)
; X64-NEXT:    movq %rcx, aaa(%rip)
; X64-NEXT:    retq
;
; X86-LABEL: PR13897:
; X86:       # %bb.0: # %"0x0"
; X86-NEXT:    movl bbb, %eax
; X86-NEXT:    movl %eax, aaa+12
; X86-NEXT:    movl %eax, aaa+8
; X86-NEXT:    movl %eax, aaa+4
; X86-NEXT:    movl %eax, aaa
; X86-NEXT:    retl
"0x0":
  %0 = load i128, i128* @bbb
  %1 = and i128 %0, 4294967295
  %2 = shl i128 %0, 96
  %3 = mul i128 %1, 18446744078004518913
  %4 = add i128 %3, %2
  store i128 %4, i128* @aaa
  ret void
}
