;===============================================================================
; Objeto 0x42 - Molas a vapor na Metropolis
; ->>> 
;===============================================================================
; Offset_0x01B3EC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01B3FA(PC, D0), D1
                jmp     Offset_0x01B3FA(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01B3FA:
                dc.w    Offset_0x01B400-Offset_0x01B3FA
                dc.w    Offset_0x01B440-Offset_0x01B3FA
                dc.w    Offset_0x01B5EC-Offset_0x01B3FA          
;-------------------------------------------------------------------------------
Offset_0x01B400:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Steam_Vent_Mappings, Obj_Map(A0) ; Offset_0x01B61E, $0004
                move.w  #$6000, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                bsr     Jmp_0F_To_ModifySpriteAttr_2P          ; Offset_0x01B6C8
                move.b  #$07, Obj_Map_Id(A0)                             ; $001A
                move.w  Obj_Y(A0), Obj_Control_Var_08(A0)         ; $000C, $0034
                move.w  #$0010, Obj_Control_Var_0A(A0)                   ; $0036
                addi.w  #$0010, Obj_Y(A0)                                ; $000C   
;-------------------------------------------------------------------------------
Offset_0x01B440:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Jmp_01_To_SolidObject_2_A1             ; Offset_0x01B6CE
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01B46A
                bsr     Offset_0x01B546
Offset_0x01B46A:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     Jmp_01_To_SolidObject_2_A1             ; Offset_0x01B6CE
                btst    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01B484
                bsr     Offset_0x01B546
Offset_0x01B484:
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                bne.s   Offset_0x01B49C
                subq.w  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x01B500
                move.w  #$007F, Obj_Control_Var_06(A0)                   ; $0032
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra.s   Offset_0x01B500
Offset_0x01B49C:
                subq.b  #$02, D0
                bne.s   Offset_0x01B4CE
                subq.w  #$08, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x01B4C0
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bsr.s   Offset_0x01B504
                addi.w  #$0028, Obj_X(A1)                                ; $0008
                bsr.s   Offset_0x01B504
                subi.w  #$0028, Obj_X(A1)                                ; $0008
                bset    #$00, Obj_Flags(A1)                              ; $0001
Offset_0x01B4C0:
                move.w  Obj_Control_Var_0A(A0), D0                       ; $0036
                add.w   Obj_Control_Var_08(A0), D0                       ; $0034
                move.w  D0, Obj_Y(A0)                                    ; $000C
                bra.s   Offset_0x01B500
Offset_0x01B4CE:
                subq.b  #$02, D0
                bne.s   Offset_0x01B4E4
                subq.w  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x01B500
                move.w  #$007F, Obj_Control_Var_06(A0)                   ; $0032
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra.s   Offset_0x01B500
Offset_0x01B4E4:
                addq.w  #$08, Obj_Control_Var_0A(A0)                     ; $0036
                cmpi.w  #$0010, Obj_Control_Var_0A(A0)                   ; $0036
                bne.s   Offset_0x01B4F4
                clr.b   Obj_Routine_2(A0)                                ; $0025
Offset_0x01B4F4:
                move.w  Obj_Control_Var_0A(A0), D0                       ; $0036
                add.w   Obj_Control_Var_08(A0), D0                       ; $0034
                move.w  D0, Obj_Y(A0)                                    ; $000C
Offset_0x01B500:
                bra     Jmp_0F_To_MarkObjGone                  ; Offset_0x01B6C2
Offset_0x01B504:
                bsr     Jmp_04_To_SingleObjectLoad             ; Offset_0x01B6BC
                bne.s   Offset_0x01B544
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                addq.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Control_Var_08(A0), Obj_Y(A1)         ; $000C, $0034
                move.b  #$07, Obj_Ani_Time(A1)                           ; $001E
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  #$2405, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$18, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
Offset_0x01B544:
                rts
Offset_0x01B546:
                cmpi.b  #$02, Obj_Routine_2(A0)                          ; $0025
                beq.s   Offset_0x01B550
                rts
Offset_0x01B550:
                move.w  #$F600, Obj_Speed_Y(A1)                          ; $0012
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$10, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x01B57A
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
Offset_0x01B57A:
                btst    #$00, D0
                beq.s   Offset_0x01B5BA
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$00, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$04, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x01B5AA
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x01B5AA:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01B5BA
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x01B5BA:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01B5D0
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x01B5D0:
                cmpi.b  #$08, D0
                bne.s   Offset_0x01B5E2
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x01B5E2:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------
Offset_0x01B5EC:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01B61A
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$03, Obj_Map_Id(A0)                             ; $001A
                bne.s   Offset_0x01B610
                move.b  #$A6, Obj_Col_Flags(A0)                          ; $0020
Offset_0x01B610:
                cmpi.b  #$07, Obj_Map_Id(A0)                             ; $001A
                beq     Jmp_0D_To_DeleteObject                 ; Offset_0x01B6B6
Offset_0x01B61A:
                bra     Jmp_09_To_DisplaySprite                ; Offset_0x01B6B0              
;-------------------------------------------------------------------------------
Steam_Vent_Mappings:                                           ; Offset_0x01B61E
                dc.w    Offset_0x01B62E-Steam_Vent_Mappings
                dc.w    Offset_0x01B638-Steam_Vent_Mappings
                dc.w    Offset_0x01B642-Steam_Vent_Mappings
                dc.w    Offset_0x01B64C-Steam_Vent_Mappings
                dc.w    Offset_0x01B65E-Steam_Vent_Mappings
                dc.w    Offset_0x01B670-Steam_Vent_Mappings
                dc.w    Offset_0x01B68A-Steam_Vent_Mappings
                dc.w    Offset_0x01B69C-Steam_Vent_Mappings
Offset_0x01B62E:
                dc.w    $0001
                dc.l    $FF000000, $0000FFE8
Offset_0x01B638:
                dc.w    $0001
                dc.l    $FF040001, $0000FFE8
Offset_0x01B642:
                dc.w    $0001
                dc.l    $FC050003, $0001FFEC
Offset_0x01B64C:
                dc.w    $0002
                dc.l    $FC050007, $0003FFF8
                dc.l    $FC050003, $0001FFF0
Offset_0x01B65E:
                dc.w    $0002
                dc.l    $FC051007, $10030000
                dc.l    $FC01100B, $1005FFF8
Offset_0x01B670:
                dc.w    $0003
                dc.l    $FC01000D, $0006000C
                dc.l    $FC01000B, $00050004
                dc.l    $FC01180D, $1806FFFC
Offset_0x01B68A:
                dc.w    $0002
                dc.l    $FC01000D, $00060010
                dc.l    $FC01180D, $18060008
Offset_0x01B69C:
                dc.w    $0002
                dc.l    $F0070015, $000AFFF0
                dc.l    $F007001D, $000E0000 
;===============================================================================
; Objeto 0x42 - Molas a vapor na Metropolis
; <<<- 
;===============================================================================