;===============================================================================
; Objeto 0x8F -> Parede que oculta o Grounder na Neo Green Hill
; ->>>           Carregado a partir do objeto 0x8D / 0x8E
;===============================================================================
; Offset_0x02819E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0281AC(PC, D0), D1
                jmp     Offset_0x0281AC(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0281AC:
                dc.w    Offset_0x0281B2-Offset_0x0281AC
                dc.w    Offset_0x0281B6-Offset_0x0281AC
                dc.w    Offset_0x02822C-Offset_0x0281AC     
;-------------------------------------------------------------------------------
Offset_0x0281B2:
                bra     Object_Settings                        ; Offset_0x027EA4  
;-------------------------------------------------------------------------------
Offset_0x0281B6:
                move.w  Obj_Timer(A0), A1                                ; $002A
                tst.b   Obj_Player_Status(A1)                            ; $002B
                bne.s   Offset_0x0281C4
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x0281C4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                move.b  Offset_0x0281DC(PC, D0), Obj_Speed(A0)           ; $0010
                move.b  Offset_0x0281DC+$01(PC, D0), Obj_Speed_Y(A0)     ; $0012
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x0281DC:
                dc.b    $01, $FE, $01, $FF, $FF, $FE, $FF, $FF         
;===============================================================================
; Objeto 0x8F -> Parede que oculta o Grounder na Neo Green Hill
; <<<-           Carregado a partir do objeto 0x8D / 0x8E
;===============================================================================