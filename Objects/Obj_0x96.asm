;===============================================================================
; Objeto 0x96 - Corpo do inimigo Rexon na Hill Top (Inimigo tipo cobra que atira
; ->>>          bolas de fogo no jogador)
;===============================================================================
; Offset_0x02891E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02892C(PC, D0), D1
                jmp     Offset_0x02892C(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x02892C:
                dc.w    Offset_0x028934-Offset_0x02892C
                dc.w    Offset_0x02894C-Offset_0x02892C
                dc.w    Offset_0x028998-Offset_0x02892C
                dc.w    Offset_0x0289C6-Offset_0x02892C       
;-------------------------------------------------------------------------------
Offset_0x028934:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                move.w  #$FFE0, Obj_Speed(A0)                            ; $0010
                move.b  #$80, Obj_Timer(A0)                              ; $002A
                rts   
;-------------------------------------------------------------------------------
Offset_0x02894C:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0060, D2
                cmpi.w  #$0100, D2
                bcc.s   Offset_0x02895E
                bsr     Load_Rexon_Head_Obj                    ; Offset_0x028BA8
Offset_0x02895E:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x02897C
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0011, D3
                move.w  (A7)+, D4
                bsr     Jmp_16_To_SolidObject                  ; Offset_0x02A7B8
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02897C:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bpl.s   Offset_0x028992
                move.b  #$80, Obj_Timer(A0)                              ; $002A
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
Offset_0x028992:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                rts    
;-------------------------------------------------------------------------------
Offset_0x028998:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0060, D2
                cmpi.w  #$0100, D2
                bcc.s   Offset_0x0289AA
                bsr     Load_Rexon_Head_Obj                    ; Offset_0x028BA8
Offset_0x0289AA:
                bsr     Offset_0x0289B2
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x0289B2:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0008, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bra     Jmp_16_To_SolidObject                  ; Offset_0x02A7B8  
;-------------------------------------------------------------------------------
Offset_0x0289C6:
                bsr.s   Offset_0x0289B2
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0         
;===============================================================================
; Objeto 0x96 - Corpo do inimigo Rexon na Hill Top (Inimigo tipo cobra que atira
; <<<-          bolas de fogo no jogador)
;===============================================================================