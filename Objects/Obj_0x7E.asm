;===============================================================================
; Objeto 0x7E - Estrelas do Super Sonic
; ->>>
;===============================================================================
; Offset_0x013552:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x013560(PC, D0), D1
                jmp     Offset_0x013560(PC, D1)
;-------------------------------------------------------------------------------    
Offset_0x013560:
                dc.w    Offset_0x013564-Offset_0x013560
                dc.w    Offset_0x01359A-Offset_0x013560            
;-------------------------------------------------------------------------------  
Offset_0x013564:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Super_Sonic_Stars_Mappings, Obj_Map(A0) ; Offset_0x013620, $0004
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.w  #$05F2, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                btst    #$07, ($FFFFB002).w
                beq.s   Offset_0x01359A
                bset    #$07, Obj_Art_VRAM(A0)                           ; $0002  
;------------------------------------------------------------------------------- 
Offset_0x01359A:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x01361A
                tst.b   Obj_Control_Var_04(A0)                           ; $0030
                beq.s   Offset_0x0135EA
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x0135D2
                move.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$06, Obj_Map_Id(A0)                             ; $001A
                bcs.s   Offset_0x0135D2
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.b  #$00, Obj_Control_Var_04(A0)                     ; $0030
                move.b  #$01, Obj_Control_Var_05(A0)                     ; $0031
                rts
Offset_0x0135D2:
                tst.b   Obj_Control_Var_05(A0)                           ; $0031
                bne.s   Offset_0x0135E4
Offset_0x0135D8:
                move.w  (Player_One_Position_X).w, Obj_X(A0)         ; $FFFFB008; $0008
                move.w  (Player_One_Position_Y).w, Obj_Y(A0)         ; $FFFFB00C; $000C
Offset_0x0135E4:
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x0135EA:
                tst.b   ($FFFFB02A).w
                bne.s   Offset_0x01360C
                move.w  ($FFFFB014).w, D0
                bpl.s   Offset_0x0135F8
                neg.w   D0
Offset_0x0135F8:
                cmpi.w  #$0800, D0
                bcs.s   Offset_0x01360C
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bra.s   Offset_0x0135D8
Offset_0x01360C:
                move.b  #$00, Obj_Control_Var_04(A0)                     ; $0030
                move.b  #$00, Obj_Control_Var_05(A0)                     ; $0031
                rts
Offset_0x01361A:
                jmp     (DeleteObject)                         ; Offset_0x00D314
;-------------------------------------------------------------------------------
Super_Sonic_Stars_Mappings:                                    ; Offset_0x013620
                dc.w    Offset_0x01362C-Super_Sonic_Stars_Mappings
                dc.w    Offset_0x01364E-Super_Sonic_Stars_Mappings
                dc.w    Offset_0x013670-Super_Sonic_Stars_Mappings
                dc.w    Offset_0x01364E-Super_Sonic_Stars_Mappings
                dc.w    Offset_0x01362C-Super_Sonic_Stars_Mappings
                dc.w    Offset_0x013692-Super_Sonic_Stars_Mappings
Offset_0x01362C:
                dc.w    $0004
                dc.l    $F8000000, $0000FFF8
                dc.l    $F8000800, $08000000
                dc.l    $00001000, $1000FFF8
                dc.l    $00001800, $18000000
Offset_0x01364E:
                dc.w    $0004
                dc.l    $F0050001, $0000FFF0
                dc.l    $F0050801, $08000000
                dc.l    $00051001, $1000FFF0
                dc.l    $00051801, $18000000
Offset_0x013670:
                dc.w    $0004
                dc.l    $E80A0005, $0002FFE8
                dc.l    $E80A0805, $08020000
                dc.l    $000A1005, $1002FFE8
                dc.l    $000A1805, $18020000
Offset_0x013692:
                dc.w    $0000
;===============================================================================
; Objeto 0x7E - Estrelas do Super Sonic
; <<<-
;===============================================================================