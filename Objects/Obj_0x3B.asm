;===============================================================================
; Objeto 0x3B - Pedra roxa na Green Hill do Sonic 1 não usado (Left over)
; ->>>
;===============================================================================  
; Offset_0x00CBD4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00CBE2(PC, D0), D1
                jmp     Offset_0x00CBE2(PC, D1)      
;-------------------------------------------------------------------------------  
Offset_0x00CBE2:
                dc.w    Offset_0x00CBE6-Offset_0x00CBE2
                dc.w    Offset_0x00CC0E-Offset_0x00CBE2                 
;------------------------------------------------------------------------------- 
Offset_0x00CBE6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Rock_Mappings, Obj_Map(A0)     ; Offset_0x00CC3A, $0004
                move.w  #$66C0, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$13, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018   
;------------------------------------------------------------------------------- 
Offset_0x00CC0E:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject                            ; Offset_0x00F344
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322    
;-------------------------------------------------------------------------------  
Rock_Mappings:                                                 ; Offset_0x00CC3A
                dc.w    Offset_0x00CC3C-Rock_Mappings
Offset_0x00CC3C:
                dc.w    $0002
                dc.l    $F00B0000, $0000FFE8
                dc.l    $F00B000C, $00060000
;===============================================================================
; Objeto 0x3B - Pedra roxa na Green Hill do Sonic 1 não usado (Left over)
; <<<-
;===============================================================================