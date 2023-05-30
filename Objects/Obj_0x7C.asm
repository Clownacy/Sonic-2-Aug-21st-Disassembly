;===============================================================================
; Objeto 0x7C - Estrutura de metal no fundo da Chemical Plant
; ->>>
;===============================================================================  
; Offset_0x0160BE:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0160CC(PC, D0), D1
                jmp     Offset_0x0160CC(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x0160CC:
                dc.w    Offset_0x0160D0-Offset_0x0160CC
                dc.w    Offset_0x0160F2-Offset_0x0160CC   
;-------------------------------------------------------------------------------  
Offset_0x0160D0:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Metal_Structure_Mappings, Obj_Map(A0) ; Offset_0x016128, $0004
                move.w  #$C373, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_00_To_ModifySpriteAttr_2P          ; Offset_0x01639C
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$07, Obj_Priority(A0)                           ; $0018  
;------------------------------------------------------------------------------- 
Offset_0x0160F2:
                move.w  (Camera_X).w, D1                             ; $FFFFEE00
                andi.w  #$03FF, D1
                cmpi.w  #$02E0, D1
                bcc.s   Offset_0x016126
                asr.w   #$01, D1
                move.w  D1, D0
                asr.w   #$01, D1
                add.w   D1, D0
                neg.w   D0
                move.w  D0, Obj_X(A0)                                    ; $0008
                move.w  (Camera_Y).w, D1                             ; $FFFFEE04
                asr.w   #$01, D1
                andi.w  #$003F, D1
                neg.w   D1
                addi.w  #$0100, D1
                move.w  D1, Obj_Sub_Y(A0)                                ; $000A
                bra     Jmp_02_To_DisplaySprite                ; Offset_0x016390
Offset_0x016126:
                rts                               
;-------------------------------------------------------------------------------
Metal_Structure_Mappings:                                      ; Offset_0x016128
                dc.w    Offset_0x01612A-Metal_Structure_Mappings
Offset_0x01612A:
                dc.w    $0009
                dc.l    $800FA000, $A000FFF0
                dc.l    $A00FB000, $B000FFF0
                dc.l    $C00FA000, $A000FFF0
                dc.l    $E00FB000, $B000FFF0
                dc.l    $000FA000, $A000FFF0
                dc.l    $200FB000, $B000FFF0
                dc.l    $400FA000, $A000FFF0
                dc.l    $600FB000, $B000FFF0
                dc.l    $7F0FA000, $A000FFF0 
;===============================================================================
; Objeto 0x7C - Estrutura de metal no fundo da Chemical Plant
; <<<-
;===============================================================================