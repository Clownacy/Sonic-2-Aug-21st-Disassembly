;===============================================================================
; Object 0x03 - Alternates the plane of the scenery relative to the player
; ->>> 
;===============================================================================   
; Offset_0x014DC8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x014DE4(PC, D0), D1
                jsr     Offset_0x014DE4(PC, D1)
                tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
                beq     MarkObjGone_3                          ; Offset_0x00D26C
                jmp     (MarkObjGone)                          ; Offset_0x00D200
;-------------------------------------------------------------------------------  
Offset_0x014DE4:
                dc.w    Offset_0x014DEA-Offset_0x014DE4
                dc.w    Offset_0x014E50-Offset_0x014DE4
                dc.w    Offset_0x014F74-Offset_0x014DE4           
;------------------------------------------------------------------------------- 
Offset_0x014DEA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Layer_Switch_Mappings, Obj_Map(A0) ; Offset_0x0150E8, $0004
                move.w  #$26BC, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$05, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                btst    #$02, D0
                beq.s   Offset_0x014E40
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                andi.w  #$0007, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                andi.w  #$0003, D0
                add.w   D0, D0
                move.w  Layer_Switch_Conf(PC, D0), Obj_Control_Var_06(A0) ; Offset_0x014E38 ,$0032
                bra     Offset_0x014F74 
;-------------------------------------------------------------------------------    
Layer_Switch_Conf:                                             ; Offset_0x014E38
                dc.w    $0020, $0040, $0080, $0100 
;-------------------------------------------------------------------------------
Offset_0x014E40:
                andi.w  #$0003, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                add.w   D0, D0
                move.w  Layer_Switch_Conf(PC, D0), Obj_Control_Var_06(A0) ; Offset_0x014E38, $0032  
;-------------------------------------------------------------------------------
Offset_0x014E50:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x014F72
                move.b  #$00, Obj_Control_Var_08(A0)                     ; $0034
                move.w  Obj_Control_Var_04(A0), D5                       ; $0030
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  D0, D1
                subq.w  #$08, D0
                addq.w  #$08, D1
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, D3
                move.w  Obj_Control_Var_06(A0), D4                       ; $0032
                sub.w   D4, D2
                add.w   D4, D3
                lea     (Offset_0x015098), A2
                moveq   #$07, D6
Offset_0x014E82:
                move.l  (A2)+, D4
                beq     Offset_0x014F62
                move.l  D4, A1
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   D0, D4
                bcs     Offset_0x014EB2
                cmp.w   D1, D4
                bcc     Offset_0x014EB2
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   D2, D4
                bcs     Offset_0x014EB2
                cmp.w   D3, D4
                bcc     Offset_0x014EB2
                ori.w   #$8000, D5
                bra     Offset_0x014F62
Offset_0x014EB2:
                tst.w   D5
                bpl     Offset_0x014F62
                swap.w  D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x014ECA
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne     Offset_0x014F5C
Offset_0x014ECA:
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   Obj_X(A0), D4                                    ; $0008
                bcs.s   Offset_0x014F0E
                btst    #$00, Obj_Flags(A0)                              ; $0001
                bne.s   Offset_0x014EFA
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
                btst    #$03, D0
                beq.s   Offset_0x014EFA
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x014EFA:
                bclr    #$07, Obj_Art_VRAM(A1)                           ; $0002
                btst    #$05, D0
                beq.s   Offset_0x014F46
                bset    #$07, Obj_Art_VRAM(A1)                           ; $0002
                bra.s   Offset_0x014F46
Offset_0x014F0E:
                btst    #$00, Obj_Flags(A0)                              ; $0001
                bne.s   Offset_0x014F34
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
                btst    #$04, D0
                beq.s   Offset_0x014F34
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x014F34:
                bclr    #$07, Obj_Art_VRAM(A1)                           ; $0002
                btst    #$06, D0
                beq.s   Offset_0x014F46
                bset    #$07, Obj_Art_VRAM(A1)                           ; $0002
Offset_0x014F46:
                move.b  #$01, Obj_Control_Var_08(A0)                     ; $0034
                tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
                beq.s   Offset_0x014F5C
                move.w  #$00A1, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x014F5C:
                swap.w  D0
                andi.w  #$7FFF, D5
Offset_0x014F62:
                add.l   D5, D5
                dbra    D6, Offset_0x014E82
                swap.w  D5
                move.b  D5, Obj_Control_Var_04(A0)                       ; $0030
                bsr     Offset_0x0150B8
Offset_0x014F72:
                rts
;-------------------------------------------------------------------------------                
Offset_0x014F74:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x015096
                move.b  #$00, Obj_Control_Var_08(A0)                     ; $0034
                move.w  Obj_Control_Var_04(A0), D5                       ; $0030
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  D0, D1
                move.w  Obj_Control_Var_06(A0), D4                       ; $0032
                sub.w   D4, D0
                add.w   D4, D1
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, D3
                subq.w  #$08, D2
                addq.w  #$08, D3
                lea     (Offset_0x015098), A2
                moveq   #$07, D6
Offset_0x014FA6:
                move.l  (A2)+, D4
                beq     Offset_0x015086
                move.l  D4, A1
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   D0, D4
                bcs     Offset_0x014FD6
                cmp.w   D1, D4
                bcc     Offset_0x014FD6
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   D2, D4
                bcs     Offset_0x014FD6
                cmp.w   D3, D4
                bcc     Offset_0x014FD6
                ori.w   #$8000, D5
                bra     Offset_0x015086
Offset_0x014FD6:
                tst.w   D5
                bpl     Offset_0x015086
                swap.w  D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x014FEE
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne     Offset_0x015080
Offset_0x014FEE:
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   Obj_Y(A0), D4                                    ; $000C
                bcs.s   Offset_0x015032
                btst    #$00, Obj_Flags(A0)                              ; $0001
                bne.s   Offset_0x01501E
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
                btst    #$03, D0
                beq.s   Offset_0x01501E
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x01501E:
                bclr    #$07, Obj_Art_VRAM(A1)                           ; $0002
                btst    #$05, D0
                beq.s   Offset_0x01506A
                bset    #$07, Obj_Art_VRAM(A1)                           ; $0002
                bra.s   Offset_0x01506A
Offset_0x015032:
                btst    #$00, Obj_Flags(A0)                              ; $0001
                bne.s   Offset_0x015058
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
                btst    #$04, D0
                beq.s   Offset_0x015058
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x015058:
                bclr    #$07, Obj_Art_VRAM(A1)                           ; $0002
                btst    #$06, D0
                beq.s   Offset_0x01506A
                bset    #$07, Obj_Art_VRAM(A1)                           ; $0002
Offset_0x01506A:
                move.b  #$01, Obj_Control_Var_08(A0)                     ; $0034
                tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
                beq.s   Offset_0x015080
                move.w  #$00A1, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x015080:
                swap.w  D0
                andi.w  #$7FFF, D5
Offset_0x015086:
                add.l   D5, D5
                dbra    D6, Offset_0x014FA6
                swap.w  D5
                move.b  D5, Obj_Control_Var_04(A0)                       ; $0030
                bsr     Offset_0x0150B8
Offset_0x015096:
                rts 
;-------------------------------------------------------------------------------
Offset_0x015098:  
                dc.l    Player_One                                   ; $FFFFB000
                dc.l    Player_Two                                   ; $FFFFB040
                dc.l    $00000000
                dc.l    $00000000
                dc.l    $00000000
                dc.l    $00000000
                dc.l    $00000000
                dc.l    $00000000   
;-------------------------------------------------------------------------------
Offset_0x0150B8:
                tst.b   Obj_Control_Var_08(A0)                           ; $0034
                beq.s   Offset_0x0150E6
                tst.w   ($FFFFB002).w
                bpl.s   Offset_0x0150CC
                bset    #$07, ($FFFFB182).w
                bra.s   Offset_0x0150D2
Offset_0x0150CC:
                bclr    #$07, ($FFFFB182).w
Offset_0x0150D2:
                tst.w   ($FFFFB042).w
                bpl.s   Offset_0x0150E0
                bset    #$07, ($FFFFB1C2).w
                bra.s   Offset_0x0150E6
Offset_0x0150E0:
                bclr    #$07, ($FFFFB1C2).w
Offset_0x0150E6:
                rts 
;-------------------------------------------------------------------------------   
Layer_Switch_Mappings:                                         ; Offset_0x0150E8
                dc.w    Offset_0x0150F8-Layer_Switch_Mappings
                dc.w    Offset_0x01511A-Layer_Switch_Mappings
                dc.w    Offset_0x01513C-Layer_Switch_Mappings
                dc.w    Offset_0x01513C-Layer_Switch_Mappings
                dc.w    Offset_0x01515E-Layer_Switch_Mappings
                dc.w    Offset_0x015180-Layer_Switch_Mappings
                dc.w    Offset_0x0151A2-Layer_Switch_Mappings
                dc.w    Offset_0x0151A2-Layer_Switch_Mappings
Offset_0x0150F8:
                dc.w    $0004
                dc.l    $E0050000, $0000FFF8
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050000, $0000FFF8
                dc.l    $10050000, $0000FFF8
Offset_0x01511A:
                dc.w    $0004
                dc.l    $C0050000, $0000FFF8
                dc.l    $E0050000, $0000FFF8
                dc.l    $00050000, $0000FFF8
                dc.l    $30050000, $0000FFF8
Offset_0x01513C:
                dc.w    $0004
                dc.l    $80050000, $0000FFF8
                dc.l    $E0050000, $0000FFF8
                dc.l    $00050000, $0000FFF8
                dc.l    $70050000, $0000FFF8
Offset_0x01515E:
                dc.w    $0004
                dc.l    $F8050000, $0000FFE0
                dc.l    $F8050000, $0000FFF0
                dc.l    $F8050000, $00000000
                dc.l    $F8050000, $00000010
Offset_0x015180:
                dc.w    $0004
                dc.l    $F8050000, $0000FFC0
                dc.l    $F8050000, $0000FFE0
                dc.l    $F8050000, $00000000
                dc.l    $F8050000, $00000030
Offset_0x0151A2:
                dc.w    $0004
                dc.l    $F8050000, $0000FF80
                dc.l    $F8050000, $0000FFE0
                dc.l    $F8050000, $00000000
                dc.l    $F8050000, $00000070                
;===============================================================================
; Object 0x03 - Alternates the plane of the scenery relative to the player
; <<<- 
;===============================================================================