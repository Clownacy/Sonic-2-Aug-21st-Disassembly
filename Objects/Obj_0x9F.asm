;===============================================================================
; Objeto 0x9F - Inimigo Shellcracker na Metropolis
; ->>>
;===============================================================================
; Offset_0x0295B2:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0295C0(PC, D0), D1
                jmp     Offset_0x0295C0(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0295C0:
                dc.w    Offset_0x0295C8-Offset_0x0295C0
                dc.w    Offset_0x0295E6-Offset_0x0295C0
                dc.w    Offset_0x029654-Offset_0x0295C0
                dc.w    Offset_0x02967E-Offset_0x0295C0         
;-------------------------------------------------------------------------------
Offset_0x0295C8:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FFC0, Obj_Speed(A0)                            ; $0010
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$18, Obj_Width_2(A0)                            ; $0017
                move.w  #$0140, Obj_Timer(A0)                            ; $002A
                rts    
;-------------------------------------------------------------------------------
Offset_0x0295E6:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D0
                bne.s   Offset_0x0295F8
                addi.w  #$0060, D2
                cmpi.w  #$00C0, D2
                bcs.s   Offset_0x02963E
Offset_0x0295F8:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFF8, D1
                blt.s   Offset_0x029626
                cmpi.w  #$000C, D1
                bge.s   Offset_0x029626
                add.w   D1, Obj_Y(A0)                                    ; $000C
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x02962A
                lea     (Shellcracker_Animate_Data), A1        ; Offset_0x029856
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029626:
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x02962A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$003B, Obj_Timer(A0)                            ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02963E:
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0008, Obj_Timer(A0)                            ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x029654:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D0
                bne.s   Offset_0x029666
                addi.w  #$0060, D2
                cmpi.w  #$00C0, D2
                bcs.s   Offset_0x02963E
Offset_0x029666:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x029670
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029670:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0140, Obj_Timer(A0)                            ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x02967E:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x029690(PC, D0), D1
                jsr     Offset_0x029690(PC, D1)
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x029690:
                dc.w    Offset_0x029696-Offset_0x029690
                dc.w    Offset_0x0296AC-Offset_0x029690
                dc.w    Offset_0x0296C0-Offset_0x029690     
;-------------------------------------------------------------------------------
Offset_0x029696:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x02969E
                rts
Offset_0x02969E:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$03, Obj_Map_Id(A0)                             ; $001A
                bra     Load_Sheelcracker_Craw_Obj             ; Offset_0x0297F8         
;-------------------------------------------------------------------------------
Offset_0x0296AC:
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x0296B4
                rts
Offset_0x0296B4:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0020, Obj_Timer(A0)                            ; $002A
                rts 
;-------------------------------------------------------------------------------
Offset_0x0296C0:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x0296C8
                rts
Offset_0x0296C8:
                clr.b   Obj_Routine_2(A0)                                ; $0025
                clr.b   Obj_Control_Var_00(A0)                           ; $002C
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0140, Obj_Timer(A0)                            ; $002A
                rts
;===============================================================================
; Objeto 0x9F - Inimigo Shellcracker na Metropolis
; <<<-
;===============================================================================