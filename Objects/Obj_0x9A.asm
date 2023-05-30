;===============================================================================
; Objeto 0x9A - Inimigo tartaruga na Sky Chase (Atira bolas de fogo no jogador)
; ->>> 
;===============================================================================   
; Offset_0x028F08:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x028F16(PC, D0), D1
                jmp     Offset_0x028F16(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x028F16:
                dc.w    Offset_0x028F1A-Offset_0x028F16
                dc.w    Offset_0x028F28-Offset_0x028F16         
;-------------------------------------------------------------------------------
Offset_0x028F1A:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                bra     Load_Turtloid_Sub_Obj_0x9B             ; Offset_0x029028     
;-------------------------------------------------------------------------------
Offset_0x028F28:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x028F3E(PC, D0), D1
                jsr     Offset_0x028F3E(PC, D1)
                bsr     Offset_0x028F48
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x028F3E:
                dc.w    Offset_0x028F62-Offset_0x028F3E
                dc.w    Offset_0x028F7E-Offset_0x028F3E
                dc.w    Offset_0x028FA8-Offset_0x028F3E
                dc.w    Offset_0x028FC8-Offset_0x028F3E
                dc.w    Offset_0x028FE2-Offset_0x028F3E         
;-------------------------------------------------------------------------------
Offset_0x028F48:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                move.w  #$0023, D1
                move.w  #$0008, D2
                move.w  #$000E, D3
                move.w  (A7)+, D4
                bra     Jmp_16_To_SolidObject                  ; Offset_0x02A7B8 
;-------------------------------------------------------------------------------
Offset_0x028F62:
                cmpi.w  #$0240, Obj_X(A0)                                ; $0008
                bcc     Return_to_sub_routine                  ; Offset_0x029026
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                lea     (Turtloid_Animate_Data), A1            ; Offset_0x029134
                move.l  A1, Obj_Control_Var_02(A0)                       ; $002E
                bra     Load_Enemy_Boost_Sub_Obj_0x9C          ; Offset_0x02909C                     
;-------------------------------------------------------------------------------
Offset_0x028F7E:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D0
                bmi     Return_to_sub_routine                  ; Offset_0x029026
                cmpi.w  #$0080, D2
                bcc     Return_to_sub_routine                  ; Offset_0x029026
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.b  #$04, Obj_Timer(A0)                              ; $002A
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                rts               
;-------------------------------------------------------------------------------
Offset_0x028FA8:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bpl     Return_to_sub_routine                  ; Offset_0x029026
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$08, Obj_Timer(A0)                              ; $002A
                move.w  Obj_Control_Var_00(A0), A1                       ; $002C
                move.b  #$03, Obj_Map_Id(A1)                             ; $001A
                bra     Load_Turtloid_Weapon                   ; Offset_0x0290D0   
;-------------------------------------------------------------------------------
Offset_0x028FC8:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bpl.s   Offset_0x028FE0
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                clr.b   Obj_Map_Id(A0)                                   ; $001A
                move.w  Obj_Control_Var_00(A0), A1                       ; $002C
Offset_0x028FE0:
                rts   
;-------------------------------------------------------------------------------
Offset_0x028FE2:
                rts
;===============================================================================
; Objeto 0x9A - Inimigo tartaruga na Sky Chase (Atira bolas de fogo no jogador)
; <<<- 
;===============================================================================