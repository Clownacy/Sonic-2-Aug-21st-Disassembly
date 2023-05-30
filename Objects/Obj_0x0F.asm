;===============================================================================
; Objeto 0x0F
; ->>> 
;===============================================================================
; Offset_0x00B6E6:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00B6F8(PC, D0), D1
                jsr     Offset_0x00B6F8(PC, D1)
                bra     DisplaySprite                          ; Offset_0x00D322  
;------------------------------------------------------------------------------- 
Offset_0x00B6F8:
                dc.w    Offset_0x00B6FE-Offset_0x00B6F8
                dc.w    Offset_0x00B720-Offset_0x00B6F8
                dc.w    Offset_0x00B720-Offset_0x00B6F8      
;-------------------------------------------------------------------------------
Offset_0x00B6FE:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0090, Obj_X(A0)                                ; $0008
                move.w  #$0090, Obj_Sub_Y(A0)                            ; $000A
                move.l  #Obj_0x0F_Mappings, Obj_Map(A0) ; Offset_0x00B742, $0004
                move.w  #$0680, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE  
;-------------------------------------------------------------------------------
Offset_0x00B720:
                move.b  (Control_Ports_Buffer_Data+$0001).w, D0      ; $FFFFF605
                btst    #$05, D0
                beq.s   Offset_0x00B734
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$0F, Obj_Map_Id(A0)                             ; $001A
Offset_0x00B734:
                btst    #$04, D0
                beq.s   Offset_0x00B740
                bchg    #00, ($FFFFFFD9).w
Offset_0x00B740:
                rts
;-------------------------------------------------------------------------------
Obj_0x0F_Mappings:                                             ; Offset_0x00B742
                dc.w    Offset_0x00B762-Obj_0x0F_Mappings
                dc.w    Offset_0x00B76C-Obj_0x0F_Mappings
                dc.w    Offset_0x00B776-Obj_0x0F_Mappings
                dc.w    Offset_0x00B780-Obj_0x0F_Mappings
                dc.w    Offset_0x00B78A-Obj_0x0F_Mappings
                dc.w    Offset_0x00B794-Obj_0x0F_Mappings
                dc.w    Offset_0x00B79E-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7A8-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7B2-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7BC-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7C6-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7D0-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7DA-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7E4-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7EE-Obj_0x0F_Mappings
                dc.w    Offset_0x00B7F8-Obj_0x0F_Mappings
Offset_0x00B762:
                dc.w    $0001
                dc.l    $00000000, $00000000
Offset_0x00B76C:
                dc.w    $0001
                dc.l    $00010000, $00000000
Offset_0x00B776:
                dc.w    $0001
                dc.l    $00020000, $00000000
Offset_0x00B780:
                dc.w    $0001
                dc.l    $00030000, $00000000
Offset_0x00B78A:
                dc.w    $0001
                dc.l    $00040000, $00000000
Offset_0x00B794:
                dc.w    $0001
                dc.l    $00050000, $00000000
Offset_0x00B79E:
                dc.w    $0001
                dc.l    $00060000, $00000000
Offset_0x00B7A8:
                dc.w    $0001
                dc.l    $00070000, $00000000
Offset_0x00B7B2:
                dc.w    $0001
                dc.l    $00080000, $00000000
Offset_0x00B7BC:
                dc.w    $0001
                dc.l    $00090000, $00000000
Offset_0x00B7C6:
                dc.w    $0001
                dc.l    $000A0000, $00000000
Offset_0x00B7D0:
                dc.w    $0001
                dc.l    $000B0000, $00000000
Offset_0x00B7DA:
                dc.w    $0001
                dc.l    $000C0000, $00000000
Offset_0x00B7E4:
                dc.w    $0001
                dc.l    $000D0000, $00000000
Offset_0x00B7EE:
                dc.w    $0001
                dc.l    $000E0000, $00000000
Offset_0x00B7F8:
                dc.w    $0001
                dc.l    $000F0000, $00000000          
;===============================================================================
; Objeto 0x0F
; <<<- 
;===============================================================================