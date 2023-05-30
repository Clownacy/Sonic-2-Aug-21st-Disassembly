;===============================================================================
; Objeto 0x8E -> Grounder na Neo Green Hill
; ->>>
;===============================================================================
; Offset_0x0280A0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0280AE(PC, D0), D1
                jmp     Offset_0x0280AE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0280AE:
                dc.w    Offset_0x0280BA-Offset_0x0280AE
                dc.w    Offset_0x0280F2-Offset_0x0280AE
                dc.w    Offset_0x028116-Offset_0x0280AE
                dc.w    Offset_0x028124-Offset_0x0280AE
                dc.w    Offset_0x02814A-Offset_0x0280AE
                dc.w    Offset_0x028180-Offset_0x0280AE     
;-------------------------------------------------------------------------------
Offset_0x0280BA:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.b  #$14, Obj_Height_2(A0)                           ; $0016
                move.b  #$10, Obj_Width_2(A0)                            ; $0017
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x0280DE
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x0280DE:
                move.b  Obj_Id(A0), D0                                   ; $0000
                subi.b  #$8D, D0
                beq     Offset_0x028274
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                rts   
;-------------------------------------------------------------------------------
Offset_0x0280F2:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D2
                bpl.s   Offset_0x0280FC
                neg.w   D2
Offset_0x0280FC:
                cmpi.w  #$0060, D2
                bls.s   Offset_0x028106
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028106:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                st      Obj_Player_Status(A0)                            ; $002B
                bsr     Offset_0x02823C
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028116:
                lea     (Grounder_AnimateData_01), A1          ; Offset_0x0282FA
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028124:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                move.w  Offset_0x028146(PC, D0), Obj_Speed(A0)           ; $0010
                bclr    #$00, Obj_Status(A0)                             ; $0022
                tst.w   D0
                beq.s   Offset_0x028142
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x028142:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028146:
                dc.w    $FF00, $0100 
;-------------------------------------------------------------------------------
Offset_0x02814A:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFFE, D1
                blt.s   Offset_0x028172
                cmpi.w  #$000C, D1
                bge.s   Offset_0x028172
                add.w   D1, Obj_Y(A0)                                    ; $000C
                lea     (Grounder_AnimateData), A1             ; Offset_0x0282F2
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028172:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$3B, Obj_Timer(A0)                              ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0    
;-------------------------------------------------------------------------------
Offset_0x028180:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x02818A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02818A:
                move.b  #$08, Obj_Routine(A0)                            ; $0024
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0       
;===============================================================================
; Objeto 0x8E -> Grounder na Neo Green Hill
; <<<-
;===============================================================================