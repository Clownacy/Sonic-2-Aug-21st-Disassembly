;===============================================================================
; Object 0x29 - Pontos obtidos ao destruir alguns objetos
; ->>> 
;===============================================================================
; Offset_0x00A922:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00A930(PC, D0), D1
                jmp     Offset_0x00A930(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x00A930:
                dc.w    Offset_0x00A934-Offset_0x00A930
                dc.w    Offset_0x00A962-Offset_0x00A930           
;-------------------------------------------------------------------------------  
Offset_0x00A934:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Enemy_Points_Mappings, Obj_Map(A0) ; Offset_0x00AA2C, $0004
                move.w  #$04AC, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.w  #$FD00, Obj_Speed_Y(A0)                          ; $0012 
;-------------------------------------------------------------------------------  
Offset_0x00A962:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl     DeleteObject                           ; Offset_0x00D314
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                bra     DisplaySprite                          ; Offset_0x00D322
;===============================================================================
; Object 0x29 - Pontos obtidos ao destruir alguns objetos
; <<<- 
;===============================================================================