; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I
; RUN: llc -mtriple=riscv32 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZBB
; RUN: llc -mtriple=riscv64 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64ZBB

declare i8 @llvm.cttz.i8(i8, i1)
declare i16 @llvm.cttz.i16(i16, i1)
declare i32 @llvm.cttz.i32(i32, i1)
declare i64 @llvm.cttz.i64(i64, i1)
declare i32 @llvm.ctlz.i32(i32, i1)
declare i32 @llvm.ctpop.i32(i32)
declare i64 @llvm.ctpop.i64(i64)

define i8 @test_cttz_i8(i8 %a) nounwind {
; RV32I-LABEL: test_cttz_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a1, a0, 255
; RV32I-NEXT:    beqz a1, .LBB0_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    andi a1, a1, 85
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 51
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    andi a0, a0, 51
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 15
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    li a0, 8
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a1, a0, 255
; RV64I-NEXT:    beqz a1, .LBB0_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    addi a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    andi a1, a1, 85
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    andi a1, a0, 51
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    andi a0, a0, 51
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 15
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB0_2:
; RV64I-NEXT:    li a0, 8
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i8:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ori a0, a0, 256
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i8:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ori a0, a0, 256
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i8 @llvm.cttz.i8(i8 %a, i1 false)
  ret i8 %tmp
}

define i16 @test_cttz_i16(i16 %a) nounwind {
; RV32I-LABEL: test_cttz_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    srli a1, a1, 16
; RV32I-NEXT:    beqz a1, .LBB1_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 5
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 3
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    slli a0, a0, 19
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB1_2:
; RV32I-NEXT:    li a0, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a1, a0, 48
; RV64I-NEXT:    srli a1, a1, 48
; RV64I-NEXT:    beqz a1, .LBB1_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    addi a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 5
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    lui a1, 3
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 1
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    slliw a1, a0, 8
; RV64I-NEXT:    addw a0, a1, a0
; RV64I-NEXT:    slli a0, a0, 51
; RV64I-NEXT:    srli a0, a0, 59
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB1_2:
; RV64I-NEXT:    li a0, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i16:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    lui a1, 16
; RV32ZBB-NEXT:    or a0, a0, a1
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i16:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    lui a1, 16
; RV64ZBB-NEXT:    or a0, a0, a1
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i16 @llvm.cttz.i16(i16 %a, i1 false)
  ret i16 %tmp
}

define i32 @test_cttz_i32(i32 %a) nounwind {
; RV32I-LABEL: test_cttz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    beqz a0, .LBB2_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    j .LBB2_3
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:  .LBB2_3: # %cond.end
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a1, a0
; RV64I-NEXT:    beqz a1, .LBB2_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    addiw a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 349525
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    lui a1, 209715
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 61681
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 4112
; RV64I-NEXT:    addiw a1, a1, 257
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srliw a0, a0, 24
; RV64I-NEXT:    j .LBB2_3
; RV64I-NEXT:  .LBB2_2:
; RV64I-NEXT:    li a0, 32
; RV64I-NEXT:  .LBB2_3: # %cond.end
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i32 @llvm.cttz.i32(i32 %a, i1 false)
  ret i32 %tmp
}

define i32 @test_ctlz_i32(i32 %a) nounwind {
; RV32I-LABEL: test_ctlz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    beqz a0, .LBB3_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    j .LBB3_3
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:  .LBB3_3: # %cond.end
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_ctlz_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a1, a0
; RV64I-NEXT:    beqz a1, .LBB3_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    srliw a1, a0, 1
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srliw a1, a0, 2
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srliw a1, a0, 4
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srliw a1, a0, 8
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srliw a1, a0, 16
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 349525
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    lui a1, 209715
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 61681
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 4112
; RV64I-NEXT:    addiw a1, a1, 257
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srliw a0, a0, 24
; RV64I-NEXT:    j .LBB3_3
; RV64I-NEXT:  .LBB3_2:
; RV64I-NEXT:    li a0, 32
; RV64I-NEXT:  .LBB3_3: # %cond.end
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctlz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_ctlz_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    clzw a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i32 @llvm.ctlz.i32(i32 %a, i1 false)
  ret i32 %tmp
}

define i64 @test_cttz_i64(i64 %a) nounwind {
; RV32I-LABEL: test_cttz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s1, a1
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    not a1, s2
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s4, a2, 1365
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s5, a1, 819
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s6, a1, -241
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s3, a1, 257
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    addi a0, s1, -1
; RV32I-NEXT:    not a1, s1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    bnez s2, .LBB4_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    j .LBB4_3
; RV32I-NEXT:  .LBB4_2:
; RV32I-NEXT:    srli a0, s0, 24
; RV32I-NEXT:  .LBB4_3:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    beqz a0, .LBB4_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    addi a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, %hi(.LCPI4_0)
; RV64I-NEXT:    ld a1, %lo(.LCPI4_0)(a1)
; RV64I-NEXT:    lui a2, %hi(.LCPI4_1)
; RV64I-NEXT:    ld a2, %lo(.LCPI4_1)(a2)
; RV64I-NEXT:    srli a3, a0, 1
; RV64I-NEXT:    and a1, a3, a1
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    and a1, a0, a2
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    lui a2, %hi(.LCPI4_2)
; RV64I-NEXT:    ld a2, %lo(.LCPI4_2)(a2)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    lui a1, %hi(.LCPI4_3)
; RV64I-NEXT:    ld a1, %lo(.LCPI4_3)(a1)
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srli a0, a0, 56
; RV64I-NEXT:    j .LBB4_3
; RV64I-NEXT:  .LBB4_2:
; RV64I-NEXT:    li a0, 64
; RV64I-NEXT:  .LBB4_3: # %cond.end
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    bnez a0, .LBB4_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    ctz a0, a1
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB4_2:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i64 @llvm.cttz.i64(i64 %a, i1 false)
  ret i64 %tmp
}

define i8 @test_cttz_i8_zero_undef(i8 %a) nounwind {
; RV32I-LABEL: test_cttz_i8_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    andi a1, a1, 85
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    andi a1, a0, 51
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    andi a0, a0, 51
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 15
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i8_zero_undef:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    andi a1, a1, 85
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    andi a1, a0, 51
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    andi a0, a0, 51
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 15
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i8_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i8_zero_undef:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i8 @llvm.cttz.i8(i8 %a, i1 true)
  ret i8 %tmp
}

define i16 @test_cttz_i16_zero_undef(i16 %a) nounwind {
; RV32I-LABEL: test_cttz_i16_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 5
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 3
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    slli a0, a0, 19
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i16_zero_undef:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 5
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    lui a1, 3
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 1
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    slliw a1, a0, 8
; RV64I-NEXT:    addw a0, a1, a0
; RV64I-NEXT:    slli a0, a0, 51
; RV64I-NEXT:    srli a0, a0, 59
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i16_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i16_zero_undef:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i16 @llvm.cttz.i16(i16 %a, i1 true)
  ret i16 %tmp
}

define i32 @test_cttz_i32_zero_undef(i32 %a) nounwind {
; RV32I-LABEL: test_cttz_i32_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    addi a1, a0, -1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i32_zero_undef:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    addiw a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 349525
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    lui a1, 209715
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 61681
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 4112
; RV64I-NEXT:    addiw a1, a1, 257
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srliw a0, a0, 24
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i32_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i32_zero_undef:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i32 @llvm.cttz.i32(i32 %a, i1 true)
  ret i32 %tmp
}

define i64 @test_cttz_i64_zero_undef(i64 %a) nounwind {
; RV32I-LABEL: test_cttz_i64_zero_undef:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s1, a1
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    not a1, s2
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s4, a2, 1365
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s5, a1, 819
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s6, a1, -241
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s3, a1, 257
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    addi a0, s1, -1
; RV32I-NEXT:    not a1, s1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    bnez s2, .LBB8_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:    j .LBB8_3
; RV32I-NEXT:  .LBB8_2:
; RV32I-NEXT:    srli a0, s0, 24
; RV32I-NEXT:  .LBB8_3:
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_cttz_i64_zero_undef:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    addi a1, a0, -1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, %hi(.LCPI8_0)
; RV64I-NEXT:    ld a1, %lo(.LCPI8_0)(a1)
; RV64I-NEXT:    lui a2, %hi(.LCPI8_1)
; RV64I-NEXT:    ld a2, %lo(.LCPI8_1)(a2)
; RV64I-NEXT:    srli a3, a0, 1
; RV64I-NEXT:    and a1, a3, a1
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    and a1, a0, a2
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    lui a2, %hi(.LCPI8_2)
; RV64I-NEXT:    ld a2, %lo(.LCPI8_2)(a2)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    lui a1, %hi(.LCPI8_3)
; RV64I-NEXT:    ld a1, %lo(.LCPI8_3)(a1)
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srli a0, a0, 56
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_cttz_i64_zero_undef:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    bnez a0, .LBB8_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    ctz a0, a1
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB8_2:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_cttz_i64_zero_undef:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    ret
  %tmp = call i64 @llvm.cttz.i64(i64 %a, i1 true)
  ret i64 %tmp
}

define i32 @test_ctpop_i32(i32 %a) nounwind {
; RV32I-LABEL: test_ctpop_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi a1, a1, 257
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_ctpop_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 349525
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    lui a1, 209715
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 61681
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 4112
; RV64I-NEXT:    addiw a1, a1, 257
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srliw a0, a0, 24
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctpop_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    cpop a0, a0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_ctpop_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    cpopw a0, a0
; RV64ZBB-NEXT:    ret
  %1 = call i32 @llvm.ctpop.i32(i32 %a)
  ret i32 %1
}

define i64 @test_ctpop_i64(i64 %a) nounwind {
; RV32I-LABEL: test_ctpop_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    srli a0, a1, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s2, a2, 1365
; RV32I-NEXT:    and a0, a0, s2
; RV32I-NEXT:    sub a0, a1, a0
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s3, a1, 819
; RV32I-NEXT:    and a1, a0, s3
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s3
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s4, a1, -241
; RV32I-NEXT:    and a0, a0, s4
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s1, a1, 257
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli s5, a0, 24
; RV32I-NEXT:    srli a0, s0, 1
; RV32I-NEXT:    and a0, a0, s2
; RV32I-NEXT:    sub a0, s0, a0
; RV32I-NEXT:    and a1, a0, s3
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s3
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s4
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3@plt
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    add a0, a0, s5
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_ctpop_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lui a1, %hi(.LCPI10_0)
; RV64I-NEXT:    ld a1, %lo(.LCPI10_0)(a1)
; RV64I-NEXT:    lui a2, %hi(.LCPI10_1)
; RV64I-NEXT:    ld a2, %lo(.LCPI10_1)(a2)
; RV64I-NEXT:    srli a3, a0, 1
; RV64I-NEXT:    and a1, a3, a1
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    and a1, a0, a2
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    lui a2, %hi(.LCPI10_2)
; RV64I-NEXT:    ld a2, %lo(.LCPI10_2)(a2)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    lui a1, %hi(.LCPI10_3)
; RV64I-NEXT:    ld a1, %lo(.LCPI10_3)(a1)
; RV64I-NEXT:    call __muldi3@plt
; RV64I-NEXT:    srli a0, a0, 56
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_ctpop_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    cpop a1, a1
; RV32ZBB-NEXT:    cpop a0, a0
; RV32ZBB-NEXT:    add a0, a0, a1
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_ctpop_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    cpop a0, a0
; RV64ZBB-NEXT:    ret
  %1 = call i64 @llvm.ctpop.i64(i64 %a)
  ret i64 %1
}

define i32 @test_parity_i32(i32 %a) {
; RV32I-LABEL: test_parity_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_parity_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a1, a0, 32
; RV64I-NEXT:    srli a1, a1, 32
; RV64I-NEXT:    srliw a0, a0, 16
; RV64I-NEXT:    xor a0, a1, a0
; RV64I-NEXT:    srli a1, a0, 8
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 2
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_parity_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    cpop a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 1
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_parity_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    cpopw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 1
; RV64ZBB-NEXT:    ret
  %1 = call i32 @llvm.ctpop.i32(i32 %a)
  %2 = and i32 %1, 1
  ret i32 %2
}

define i64 @test_parity_i64(i64 %a) {
; RV32I-LABEL: test_parity_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 1
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: test_parity_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srli a1, a0, 32
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 16
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 8
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 2
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 1
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: test_parity_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    xor a0, a0, a1
; RV32ZBB-NEXT:    cpop a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 1
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: test_parity_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    cpop a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 1
; RV64ZBB-NEXT:    ret
  %1 = call i64 @llvm.ctpop.i64(i64 %a)
  %2 = and i64 %1, 1
  ret i64 %2
}
