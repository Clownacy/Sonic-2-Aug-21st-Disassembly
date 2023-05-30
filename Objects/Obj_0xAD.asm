;===============================================================================
; Objeto 0xAD - Plataforma embaixo do Inimigo Clucker na Sky Fortress
; ->>>
;===============================================================================
; Offset_0x02A47E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A48C(PC, D0), D1
                jmp     Offset_0x02A48C(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A48C:
                dc.w    Offset_0x02A492-Offset_0x02A48C
                dc.w    Offset_0x02A49E-Offset_0x02A48C
                dc.w    Offset_0x02A4CA-Offset_0x02A48C     
;-------------------------------------------------------------------------------
Offset_0x02A492:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.b  #$0C, Obj_Map_Id(A0)                             ; $001A
                rts      
;-------------------------------------------------------------------------------
Offset_0x02A49E:
                bsr     Offset_0x02A4B6
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0060, D2
                cmpi.w  #$00C0, D2
                bcs     Offset_0x02A572
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A4B6:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0008, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bra     Jmp_16_To_SolidObject                  ; Offset_0x02A7B8  
;-------------------------------------------------------------------------------
Offset_0x02A4CA:
                bsr.s   Offset_0x02A4B6
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0           
;===============================================================================
; Objeto 0xAD - Plataforma embaixo do Inimigo Clucker na Sky Fortress
; <<<-
;===============================================================================