;===============================================================================
; Objeto 0x38 - Escudo do Sonic / Miles
; ->>>
;===============================================================================
; Offset_0x012AF0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x012AFE(PC, D0), D1
                jmp     Offset_0x012AFE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x012AFE:
                dc.w    Offset_0x012B02-Offset_0x012AFE
                dc.w    Offset_0x012B3A-Offset_0x012AFE   
;-------------------------------------------------------------------------------
Offset_0x012B02:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Shield_Mappings, Obj_Map(A0)   ; Offset_0x013074, $0004
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.w  #$04BE, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                lea     (Obj_Memory_Address).w, A2                   ; $FFFFB000
                tst.w   Obj_Art_VRAM(A2)                                 ; $0002
                beq.s   Offset_0x012B3A
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $0002   
;-------------------------------------------------------------------------------
Offset_0x012B3A:
                tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
                bne.s   Offset_0x012B6A
                tst.b   (Shield_Flag).w                              ; $FFFFFE2C
                beq.s   Offset_0x012B6C
                move.w  (Player_One_Position_X).w, Obj_X(A0)         ; $FFFFB008; $0008
                move.w  (Player_One_Position_Y).w, Obj_Y(A0)         ; $FFFFB00C; $000C
                move.b  ($FFFFB022).w, Obj_Status(A0)                    ; $0022
                lea     (Shield_AnimateData), A1               ; Offset_0x013066
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x012B6A:
                rts
Offset_0x012B6C:
                jmp     (DeleteObject)                         ; Offset_0x00D314               
;===============================================================================
; Objeto 0x38 - Escudo do Sonic / Miles
; <<<-
;===============================================================================