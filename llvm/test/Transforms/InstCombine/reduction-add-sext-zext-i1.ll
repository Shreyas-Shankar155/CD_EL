; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define i1 @reduce_add_self(<8 x i1> %x) {
; CHECK-LABEL: @reduce_add_self(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.ctpop.i8(i8 [[TMP1]]), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = and i8 [[TMP2]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ne i8 [[TMP3]], 0
; CHECK-NEXT:    ret i1 [[TMP4]]
;
  %res = call i1 @llvm.vector.reduce.add.v8i32(<8 x i1> %x)
  ret i1 %res
}

define i32 @reduce_add_sext(<4 x i1> %x) {
; CHECK-LABEL: @reduce_add_sext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i1> [[X:%.*]] to i4
; CHECK-NEXT:    [[TMP2:%.*]] = call i4 @llvm.ctpop.i4(i4 [[TMP1]]), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i4 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = sub nsw i32 0, [[TMP3]]
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %sext = sext <4 x i1> %x to <4 x i32>
  %res = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %sext)
  ret i32 %res
}

define i64 @reduce_add_zext(<8 x i1> %x) {
; CHECK-LABEL: @reduce_add_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.ctpop.i8(i8 [[TMP1]]), !range [[RNG0]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i8 [[TMP2]] to i64
; CHECK-NEXT:    ret i64 [[TMP3]]
;
  %zext = zext <8 x i1> %x to <8 x i64>
  %res = call i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %zext)
  ret i64 %res
}

define i16 @reduce_add_sext_same(<16 x i1> %x) {
; CHECK-LABEL: @reduce_add_sext_same(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <16 x i1> [[X:%.*]] to i16
; CHECK-NEXT:    [[TMP2:%.*]] = call i16 @llvm.ctpop.i16(i16 [[TMP1]]), !range [[RNG2:![0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = sub nsw i16 0, [[TMP2]]
; CHECK-NEXT:    ret i16 [[TMP3]]
;
  %sext = sext <16 x i1> %x to <16 x i16>
  %res = call i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %sext)
  ret i16 %res
}

define i8 @reduce_add_zext_long(<128 x i1> %x) {
; CHECK-LABEL: @reduce_add_zext_long(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <128 x i1> [[X:%.*]] to i128
; CHECK-NEXT:    [[TMP2:%.*]] = call i128 @llvm.ctpop.i128(i128 [[TMP1]]), !range [[RNG3:![0-9]+]]
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i128 [[TMP2]] to i8
; CHECK-NEXT:    [[TMP4:%.*]] = sub i8 0, [[TMP3]]
; CHECK-NEXT:    ret i8 [[TMP4]]
;
  %sext = sext <128 x i1> %x to <128 x i8>
  %res = call i8 @llvm.vector.reduce.add.v128i8(<128 x i8> %sext)
  ret i8 %res
}

@glob = external global i8, align 1
define i8 @reduce_add_zext_long_external_use(<128 x i1> %x) {
; CHECK-LABEL: @reduce_add_zext_long_external_use(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <128 x i1> [[X:%.*]] to i128
; CHECK-NEXT:    [[TMP2:%.*]] = call i128 @llvm.ctpop.i128(i128 [[TMP1]]), !range [[RNG3]]
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i128 [[TMP2]] to i8
; CHECK-NEXT:    [[TMP4:%.*]] = sub i8 0, [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <128 x i1> [[X]], i64 0
; CHECK-NEXT:    [[EXT:%.*]] = sext i1 [[TMP5]] to i8
; CHECK-NEXT:    store i8 [[EXT]], i8* @glob, align 1
; CHECK-NEXT:    ret i8 [[TMP4]]
;
  %sext = sext <128 x i1> %x to <128 x i8>
  %res = call i8 @llvm.vector.reduce.add.v128i8(<128 x i8> %sext)
  %ext = extractelement <128 x i8> %sext, i32 0
  store i8 %ext, i8* @glob, align 1
  ret i8 %res
}

@glob1 = external global i64, align 8
define i64 @reduce_add_zext_external_use(<8 x i1> %x) {
; CHECK-LABEL: @reduce_add_zext_external_use(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.ctpop.i8(i8 [[TMP1]]), !range [[RNG0]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i8 [[TMP2]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <8 x i1> [[X]], i64 0
; CHECK-NEXT:    [[EXT:%.*]] = zext i1 [[TMP4]] to i64
; CHECK-NEXT:    store i64 [[EXT]], i64* @glob1, align 8
; CHECK-NEXT:    ret i64 [[TMP3]]
;
  %zext = zext <8 x i1> %x to <8 x i64>
  %res = call i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %zext)
  %ext = extractelement <8 x i64> %zext, i32 0
  store i64 %ext, i64* @glob1, align 8
  ret i64 %res
}

declare i1 @llvm.vector.reduce.add.v8i32(<8 x i1> %a)
declare i32 @llvm.vector.reduce.add.v4i32(<4 x i32> %a)
declare i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %a)
declare i16 @llvm.vector.reduce.add.v16i16(<16 x i16> %a)
declare i8 @llvm.vector.reduce.add.v128i8(<128 x i8> %a)
