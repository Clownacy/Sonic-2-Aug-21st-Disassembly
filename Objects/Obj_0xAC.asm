;===============================================================================
; Objeto 0xAC - Inimigo Balkiry na Sky Chase
; ->>>
;===============================================================================
; Offset_0x02A3F4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A402(PC, D0), D1
                jmp     Offset_0x02A402(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A402:
                dc.w    Offset_0x02A406-Offset_0x02A402
                dc.w    Offset_0x02A41C-Offset_0x02A402      
;-------------------------------------------------------------------------------
Offset_0x02A406:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FFE0, Obj_Speed(A0)                            ; $0010
                lea     Enemy_Boost_Animate_Data(PC), A1       ; Offset_0x02913A
                move.l  A1, Obj_Control_Var_02(A0)                       ; $002E
                bra     Load_Enemy_Boost_Sub_Obj_0x9C          ; Offset_0x02909C 
;-------------------------------------------------------------------------------
Offset_0x02A41C:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Obj_0xAC_Ptr:                                                  ; Offset_0x02A424
                dc.l    Balkiry_Mappings                       ; Offset_0x02A42E
                dc.w    $2500
                dc.b    $04, $04, $20, $08
;-------------------------------------------------------------------------------
Balkiry_Mappings:                                              ; Offset_0x02A42E
                dc.w    Offset_0x02A432-Balkiry_Mappings
                dc.w    Offset_0x02A454-Balkiry_Mappings
Offset_0x02A432:
                dc.w    $0004
                dc.l    $F40D0000, $0000FFDC
                dc.l    $EC040008, $0004000C
                dc.l    $F40D000A, $0005FFFC
                dc.l    $04080012, $0009FFFC
Offset_0x02A454:
                dc.w    $0005
                dc.l    $F40D0000, $0000FFDC
                dc.l    $EC040008, $0004000C
                dc.l    $F40D000A, $0005FFFC
                dc.l    $04080015, $000A000C
                dc.l    $0C000018, $000C001C         
;===============================================================================
; Objeto 0xAC - Inimigo Balkiry na Sky Chase
; <<<-
;===============================================================================