;===============================================================================
; Object 0xA5 - Inimigo Lander na Chemical Plant
; ->>>
;===============================================================================
; Offset_0x02A004:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A012(PC, D0), D1
                jmp     Offset_0x02A012(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A012:
                dc.w    Offset_0x02A018-Offset_0x02A012
                dc.w    Offset_0x02A02A-Offset_0x02A012
                dc.w    Offset_0x02A07C-Offset_0x02A012   
;-------------------------------------------------------------------------------
Offset_0x02A018:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FFC0, Obj_Speed(A0)                            ; $0010
                move.w  #$0080, Obj_Timer(A0)                            ; $002A
                rts  
;-------------------------------------------------------------------------------
Offset_0x02A02A:
                tst.b   Obj_Player_Status(A0)                            ; $002B
                beq.s   Offset_0x02A038
                subq.b  #$01, Obj_Player_Status(A0)                      ; $002B
                bra     Offset_0x02A046
Offset_0x02A038:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0060, D2
                cmpi.w  #$00C0, D2
                bcs.s   Offset_0x02A068
Offset_0x02A046:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bne.s   Offset_0x02A056
                move.w  #$0080, Obj_Timer(A0)                            ; $002A
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x02A056:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Horizontal_Spiny_Animate_Data), A1    ; Offset_0x02A1D2
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A068:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$28, Obj_Player_Status(A0)                      ; $002B
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0    
;-------------------------------------------------------------------------------
Offset_0x02A07C:
                subq.b  #$01, Obj_Player_Status(A0)                      ; $002B
                bmi.s   Offset_0x02A092
                cmpi.b  #$14, Obj_Player_Status(A0)                      ; $002B
                bne.s   Offset_0x02A08E
                bsr     Load_Spiny_Horizontal_Shot_Obj         ; Offset_0x02A13C
Offset_0x02A08E:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A092:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$40, Obj_Player_Status(A0)                      ; $002B
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0             
;===============================================================================
; Object 0xA5 - Inimigo Lander na Chemical Plant
; <<<-
;===============================================================================