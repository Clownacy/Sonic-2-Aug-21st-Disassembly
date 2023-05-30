;===============================================================================
; Objeto 0xA8 - Inimigo Grabber na Chemical Plant
; ->>>          Objeto vinculado ao 0xA7
;===============================================================================
; Offset_0x02A2EE:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A2FC(PC, D0), D1
                jmp     Offset_0x02A2FC(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A2FC:
                dc.w    Offset_0x02A300-Offset_0x02A2FC
                dc.w    Offset_0x02A304-Offset_0x02A2FC  
;-------------------------------------------------------------------------------
Offset_0x02A300:
                bra     Object_Settings                        ; Offset_0x027EA4  
;-------------------------------------------------------------------------------
Offset_0x02A304:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0              
;===============================================================================
; Objeto 0xA8 - Inimigo Grabber na Chemical Plant
; <<<-          Objeto vinculado ao 0xA7
;===============================================================================