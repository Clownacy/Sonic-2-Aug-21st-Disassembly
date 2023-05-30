;===============================================================================
; Objeto 0xAB - Inimigo Grabber na Chemical Plant
; ->>>          Objeto vinculado ao 0xA7
;===============================================================================
; Offset_0x02A33C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A34A(PC, D0), D1
                jmp     Offset_0x02A34A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A34A:
                dc.w    Offset_0x02A34E-Offset_0x02A34A
                dc.w    Offset_0x02A352-Offset_0x02A34A     
;-------------------------------------------------------------------------------
Offset_0x02A34E:
                bra     Object_Settings                        ; Offset_0x027EA4 
;-------------------------------------------------------------------------------
Offset_0x02A352:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;------------------------------------------------------------------------------- 
Obj_0xA7_Ptr:                                                  ; Offset_0x02A356
                dc.l    Grabber_Mappings                       ; Offset_0x02A374
                dc.w    $2500
                dc.b    $04, $04, $10, $0B      
;-------------------------------------------------------------------------------
Obj_0xA8_Ptr:                                                  ; Offset_0x02A360
                dc.l    Grabber_Mappings                       ; Offset_0x02A374
                dc.w    $2500
                dc.b    $04, $02, $10, $CB     
;-------------------------------------------------------------------------------
Obj_0xA9_Ptr:                                                  ; Offset_0x02A36A
                dc.l    Grabber_Mappings                       ; Offset_0x02A374
                dc.w    $2500
                dc.b    $04, $04, $04, $00      
;------------------------------------------------------------------------------- 
Grabber_Mappings:                                              ; Offset_0x02A374
                dc.w    Offset_0x02A384-Grabber_Mappings
                dc.w    Offset_0x02A39E-Grabber_Mappings
                dc.w    Offset_0x02A3B8-Grabber_Mappings
                dc.w    Offset_0x02A3C2-Grabber_Mappings
                dc.w    Offset_0x02A3CC-Grabber_Mappings
                dc.w    Offset_0x02A3D6-Grabber_Mappings
                dc.w    Offset_0x02A3E0-Grabber_Mappings
                dc.w    Offset_0x02A3EA-Grabber_Mappings
Offset_0x02A384:
                dc.w    $0003
                dc.l    $F8010000, $0000FFEC
                dc.l    $F80D0002, $0001FFF4
                dc.l    $0809001D, $000EFFF0
Offset_0x02A39E:
                dc.w    $0003
                dc.l    $F8010000, $0000FFEC
                dc.l    $F80D0002, $0001FFF4
                dc.l    $080D0023, $0011FFF0
Offset_0x02A3B8:
                dc.w    $0001
                dc.l    $FC00000A, $0005FFFC
Offset_0x02A3C2:
                dc.w    $0001
                dc.l    $F003000B, $0005FFFC
Offset_0x02A3CC:
                dc.w    $0001
                dc.l    $F809000F, $0007FFF0
Offset_0x02A3D6:
                dc.w    $0001
                dc.l    $F80D0015, $000AFFF0
Offset_0x02A3E0:
                dc.w    $0001
                dc.l    $FC00002B, $0015FFFC
Offset_0x02A3EA:
                dc.w    $0001
                dc.l    $FC00002C, $0016FFFC 
;===============================================================================
; Objeto 0xAB - Inimigo Grabber na Chemical Plant
; <<<-          Objeto vinculado ao 0xA7
;===============================================================================