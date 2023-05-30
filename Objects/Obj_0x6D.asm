;===============================================================================
; Objeto 0x6D - Harpões no chão na Metropolis
; ->>> 
;===============================================================================
; Offset_0x01C534:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01C542(PC, D0), D1
                jmp     Offset_0x01C542(PC, D1)
;------------------------------------------------------------------------------- 
Offset_0x01C542:
                dc.w    Offset_0x01C546-Offset_0x01C542
                dc.w    Offset_0x01C580-Offset_0x01C542      
;-------------------------------------------------------------------------------
Offset_0x01C546:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Block_Harpon_Mappings, Obj_Map(A0) ; Offset_0x01C4F0, $0004
                move.w  #$241C, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_13_To_ModifySpriteAttr_2P          ; Offset_0x01C610
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                move.b  #$84, Obj_Col_Flags(A0)                          ; $0020  
;-------------------------------------------------------------------------------
Offset_0x01C580:
                bsr     Offset_0x01C59C
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                neg.w   D0
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bra     Jmp_01_To_MarkObjGone_2                ; Offset_0x01C61C
Offset_0x01C59C:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x01C5A8
                subq.w  #$01, Obj_Control_Var_0E(A0)                     ; $003A
                rts
Offset_0x01C5A8:
                tst.w   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x01C5C0
                move.b  ($FFFFFE05).w, D0
                sub.b   Obj_Subtype(A0), D0                              ; $0028
                andi.b  #$7F, D0
                bne.s   Offset_0x01C602
                clr.w   Obj_Control_Var_0C(A0)                           ; $0038
Offset_0x01C5C0:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01C5E2
                subi.w  #$0400, Obj_Control_Var_08(A0)                   ; $0034
                bcc.s   Offset_0x01C602
                move.w  #$0000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0000, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$0001, Obj_Control_Var_0C(A0)                   ; $0038
                rts
Offset_0x01C5E2:
                addi.w  #$0400, Obj_Control_Var_08(A0)                   ; $0034
                cmpi.w  #$2000, Obj_Control_Var_08(A0)                   ; $0034
                bcs.s   Offset_0x01C602
                move.w  #$2000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0001, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$0003, Obj_Control_Var_0E(A0)                   ; $003A
Offset_0x01C602:
                rts         
;===============================================================================
; Objeto 0x6D - Harpões no chão na Metropolis
; <<<- 
;===============================================================================