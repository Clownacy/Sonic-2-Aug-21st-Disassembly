;===============================================================================
; Objeto 0x92 - Inimigo Spiker na Hill Top                              
; ->>>
;===============================================================================
; Offset_0x02851E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02852C(PC, D0), D1
                jmp     Offset_0x02852C(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02852C:
                dc.w    Offset_0x028534-Offset_0x02852C
                dc.w    Offset_0x02854C-Offset_0x02852C
                dc.w    Offset_0x028576-Offset_0x02852C
                dc.w    Offset_0x02859C-Offset_0x02852C      
;-------------------------------------------------------------------------------  
Offset_0x028534:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.b  #$40, Obj_Timer(A0)                              ; $002A
                move.w  #$0080, Obj_Speed(A0)                            ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                rts  
;------------------------------------------------------------------------------- 
Offset_0x02854C:
                bsr     Spiker_Sub                             ; Offset_0x02864A
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x028568
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Spiker_Animate_Data), A1              ; Offset_0x028682
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028568:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$10, Obj_Timer(A0)                              ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;------------------------------------------------------------------------------- 
Offset_0x028576:
                bsr     Spiker_Sub                             ; Offset_0x02864A
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x028584
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028584:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$40, Obj_Timer(A0)                              ; $002A
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;------------------------------------------------------------------------------- 
Offset_0x02859C:
                move.b  Obj_Control_Var_00(A0), D0                       ; $002C
                cmpi.b  #$08, D0
                beq.s   Offset_0x0285B0
                subq.b  #$01, D0
                move.b  D0, Obj_Control_Var_00(A0)                       ; $002C
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x0285B0:
                bsr     Jmp_10_To_SingleObjectLoad             ; Offset_0x02A79A
                bne.s   Offset_0x0285EE
                st      Obj_Player_Status(A0)                            ; $002B
                move.b  #$93, Obj_Id(A1)                                 ; $0000
                move.b  Obj_Subtype(A0), Obj_Subtype(A1)          ; $0028, $0028
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                ori.b   #$80, Obj_Col_Flags(A1)                          ; $0020
                move.b  #$04, Obj_Map_Id(A1)                             ; $001A
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
Offset_0x0285EE:
                move.b  Obj_Control_Var_01(A0), Obj_Routine(A0)   ; $0024, $002D
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0        
;===============================================================================
; Objeto 0x92 - Inimigo Spiker na Hill Top
; <<<-
;===============================================================================