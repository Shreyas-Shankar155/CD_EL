; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -O0 -verify-machineinstrs < %s | FileCheck %s

; FP is in CSR range, modified.
define hidden fastcc void @callee_has_fp() #1 {
; CHECK-LABEL: callee_has_fp:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_mov_b32 s4, s33
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    s_add_i32 s32, s32, 0x200
; CHECK-NEXT:    v_mov_b32_e32 v0, 1
; CHECK-NEXT:    buffer_store_dword v0, off, s[0:3], s33
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_add_i32 s32, s32, 0xfffffe00
; CHECK-NEXT:    s_mov_b32 s33, s4
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %alloca = alloca i32, addrspace(5)
  store volatile i32 1, i32 addrspace(5)* %alloca
  ret void
}

; Has no stack objects, but introduces them due to the CSR spill. We
; see the FP modified in the callee with IPRA. We should not have
; redundant spills of s33 or assert.
define internal fastcc void @csr_vgpr_spill_fp_callee() #0 {
; CHECK-LABEL: csr_vgpr_spill_fp_callee:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_store_dword v1, off, s[0:3], s32 offset:4 ; 4-byte Folded Spill
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    v_writelane_b32 v1, s33, 2
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    s_add_i32 s32, s32, 0x400
; CHECK-NEXT:    buffer_store_dword v40, off, s[0:3], s33 ; 4-byte Folded Spill
; CHECK-NEXT:    v_writelane_b32 v1, s30, 0
; CHECK-NEXT:    v_writelane_b32 v1, s31, 1
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, callee_has_fp@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, callee_has_fp@rel32@hi+12
; CHECK-NEXT:    s_mov_b64 s[10:11], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[8:9], s[0:1]
; CHECK-NEXT:    s_mov_b64 s[0:1], s[8:9]
; CHECK-NEXT:    s_mov_b64 s[2:3], s[10:11]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    v_readlane_b32 s30, v1, 0
; CHECK-NEXT:    v_readlane_b32 s31, v1, 1
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; clobber csr v40
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    buffer_load_dword v40, off, s[0:3], s33 ; 4-byte Folded Reload
; CHECK-NEXT:    s_add_i32 s32, s32, 0xfffffc00
; CHECK-NEXT:    v_readlane_b32 s33, v1, 2
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_load_dword v1, off, s[0:3], s32 offset:4 ; 4-byte Folded Reload
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb:
  call fastcc void @callee_has_fp()
  call void asm sideeffect "; clobber csr v40", "~{v40}"()
  ret void
}

define amdgpu_kernel void @kernel_call() {
; CHECK-LABEL: kernel_call:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_mov_b32 s32, 0
; CHECK-NEXT:    s_add_u32 flat_scratch_lo, s4, s7
; CHECK-NEXT:    s_addc_u32 flat_scratch_hi, s5, 0
; CHECK-NEXT:    s_add_u32 s0, s0, s7
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, csr_vgpr_spill_fp_callee@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, csr_vgpr_spill_fp_callee@rel32@hi+12
; CHECK-NEXT:    s_mov_b64 s[10:11], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[8:9], s[0:1]
; CHECK-NEXT:    s_mov_b64 s[0:1], s[8:9]
; CHECK-NEXT:    s_mov_b64 s[2:3], s[10:11]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    s_endpgm
bb:
  tail call fastcc void @csr_vgpr_spill_fp_callee()
  ret void
}

; Same, except with a tail call.
define internal fastcc void @csr_vgpr_spill_fp_tailcall_callee() #0 {
; CHECK-LABEL: csr_vgpr_spill_fp_tailcall_callee:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_store_dword v1, off, s[0:3], s32 offset:4 ; 4-byte Folded Spill
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    buffer_store_dword v40, off, s[0:3], s32 ; 4-byte Folded Spill
; CHECK-NEXT:    v_writelane_b32 v1, s33, 0
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; clobber csr v40
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, callee_has_fp@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, callee_has_fp@rel32@hi+12
; CHECK-NEXT:    v_readlane_b32 s33, v1, 0
; CHECK-NEXT:    buffer_load_dword v40, off, s[0:3], s32 ; 4-byte Folded Reload
; CHECK-NEXT:    s_or_saveexec_b64 s[6:7], -1
; CHECK-NEXT:    buffer_load_dword v1, off, s[0:3], s32 offset:4 ; 4-byte Folded Reload
; CHECK-NEXT:    s_mov_b64 exec, s[6:7]
; CHECK-NEXT:    s_setpc_b64 s[4:5]
bb:
  call void asm sideeffect "; clobber csr v40", "~{v40}"()
  tail call fastcc void @callee_has_fp()
  ret void
}

define amdgpu_kernel void @kernel_tailcall() {
; CHECK-LABEL: kernel_tailcall:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_mov_b32 s32, 0
; CHECK-NEXT:    s_add_u32 flat_scratch_lo, s4, s7
; CHECK-NEXT:    s_addc_u32 flat_scratch_hi, s5, 0
; CHECK-NEXT:    s_add_u32 s0, s0, s7
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, csr_vgpr_spill_fp_tailcall_callee@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, csr_vgpr_spill_fp_tailcall_callee@rel32@hi+12
; CHECK-NEXT:    s_mov_b64 s[10:11], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[8:9], s[0:1]
; CHECK-NEXT:    s_mov_b64 s[0:1], s[8:9]
; CHECK-NEXT:    s_mov_b64 s[2:3], s[10:11]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    s_endpgm
bb:
  tail call fastcc void @csr_vgpr_spill_fp_tailcall_callee()
  ret void
}

define hidden i32 @tail_call() #1 {
; CHECK-LABEL: tail_call:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_mov_b32 s4, s33
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:    s_mov_b32 s33, s4
; CHECK-NEXT:    s_setpc_b64 s[30:31]
entry:
  ret i32 0
}

define hidden i32 @caller_save_vgpr_spill_fp_tail_call() #0 {
; CHECK-LABEL: caller_save_vgpr_spill_fp_tail_call:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_store_dword v1, off, s[0:3], s32 ; 4-byte Folded Spill
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    v_writelane_b32 v1, s33, 2
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    s_add_i32 s32, s32, 0x400
; CHECK-NEXT:    v_writelane_b32 v1, s30, 0
; CHECK-NEXT:    v_writelane_b32 v1, s31, 1
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, tail_call@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, tail_call@rel32@hi+12
; CHECK-NEXT:    s_mov_b64 s[10:11], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[8:9], s[0:1]
; CHECK-NEXT:    s_mov_b64 s[0:1], s[8:9]
; CHECK-NEXT:    s_mov_b64 s[2:3], s[10:11]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    v_readlane_b32 s30, v1, 0
; CHECK-NEXT:    v_readlane_b32 s31, v1, 1
; CHECK-NEXT:    s_add_i32 s32, s32, 0xfffffc00
; CHECK-NEXT:    v_readlane_b32 s33, v1, 2
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_load_dword v1, off, s[0:3], s32 ; 4-byte Folded Reload
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
entry:
  %call = call i32 @tail_call()
  ret i32 %call
}

define hidden i32 @caller_save_vgpr_spill_fp() #0 {
; CHECK-LABEL: caller_save_vgpr_spill_fp:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_store_dword v2, off, s[0:3], s32 ; 4-byte Folded Spill
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    v_writelane_b32 v2, s33, 2
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    s_add_i32 s32, s32, 0x400
; CHECK-NEXT:    v_writelane_b32 v2, s30, 0
; CHECK-NEXT:    v_writelane_b32 v2, s31, 1
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, caller_save_vgpr_spill_fp_tail_call@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, caller_save_vgpr_spill_fp_tail_call@rel32@hi+12
; CHECK-NEXT:    s_mov_b64 s[10:11], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[8:9], s[0:1]
; CHECK-NEXT:    s_mov_b64 s[0:1], s[8:9]
; CHECK-NEXT:    s_mov_b64 s[2:3], s[10:11]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    v_readlane_b32 s30, v2, 0
; CHECK-NEXT:    v_readlane_b32 s31, v2, 1
; CHECK-NEXT:    s_add_i32 s32, s32, 0xfffffc00
; CHECK-NEXT:    v_readlane_b32 s33, v2, 2
; CHECK-NEXT:    s_or_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_load_dword v2, off, s[0:3], s32 ; 4-byte Folded Reload
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
entry:
  %call = call i32 @caller_save_vgpr_spill_fp_tail_call()
  ret i32 %call
}

define protected amdgpu_kernel void @kernel() {
; CHECK-LABEL: kernel:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_mov_b32 s32, 0
; CHECK-NEXT:    s_add_u32 flat_scratch_lo, s4, s7
; CHECK-NEXT:    s_addc_u32 flat_scratch_hi, s5, 0
; CHECK-NEXT:    s_add_u32 s0, s0, s7
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, caller_save_vgpr_spill_fp@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, caller_save_vgpr_spill_fp@rel32@hi+12
; CHECK-NEXT:    s_mov_b64 s[10:11], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[8:9], s[0:1]
; CHECK-NEXT:    s_mov_b64 s[0:1], s[8:9]
; CHECK-NEXT:    s_mov_b64 s[2:3], s[10:11]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    s_endpgm
entry:
  %call = call i32 @caller_save_vgpr_spill_fp()
  ret void
}

attributes #0 = { "frame-pointer"="none" noinline }
attributes #1 = { "frame-pointer"="all" noinline }
