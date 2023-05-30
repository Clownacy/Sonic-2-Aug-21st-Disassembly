;===============================================================================
; Objeto 0x49 - Cachoeiras na Green Hill
; ->>>
;===============================================================================
; Offset_0x015C8E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x015C9C(PC, D0), D1
                jmp     Offset_0x015C9C(PC, D1)
;-------------------------------------------------------------------------------    
Offset_0x015C9C:
                dc.w    Offset_0x015CA0-Offset_0x015C9C
                dc.w    Offset_0x015CDA-Offset_0x015C9C       
;-------------------------------------------------------------------------------
Offset_0x015CA0:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Waterfall_Mappings, Obj_Map(A0) ; Offset_0x015D40, $0004
                move.w  #$239E, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_00_To_ModifySpriteAttr_2P          ; Offset_0x01639C
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.b  #$00, Obj_Priority(A0)                           ; $0018
                move.b  #$80, Obj_Height_2(A0)                           ; $0016
                bset    #$04, Obj_Flags(A0)                              ; $0001  
;-------------------------------------------------------------------------------
Offset_0x015CDA:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x015CF4
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_02_To_DeleteObject                 ; Offset_0x016396
Offset_0x015CF4:
                move.w  Obj_X(A0), D1                                    ; $0008
                move.w  D1, D2
                subi.w  #$0040, D1
                addi.w  #$0040, D2
                move.b  Obj_Subtype(A0), D3                              ; $0028
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                cmp.w   D1, D0
                bcs.s   Offset_0x015D26
                cmp.w   D2, D0
                bcc.s   Offset_0x015D26
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                add.b   D3, Obj_Map_Id(A0)                               ; $001A
                bra     Jmp_02_To_DisplaySprite                ; Offset_0x016390
Offset_0x015D26:
                move.w  (Player_Two_Position_X).w, D0                ; $FFFFB048
                cmp.w   D1, D0
                bcs.s   Offset_0x015D38
                cmp.w   D2, D0
                bcc.s   Offset_0x015D38
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x015D38:
                add.b   D3, Obj_Map_Id(A0)                               ; $001A
                bra     Jmp_02_To_DisplaySprite                ; Offset_0x016390  
;-------------------------------------------------------------------------------
Waterfall_Mappings:                                            ; Offset_0x015D40
                dc.w    Offset_0x015D50-Waterfall_Mappings
                dc.w    Offset_0x015D62-Waterfall_Mappings
                dc.w    Offset_0x015DF4-Waterfall_Mappings
                dc.w    Offset_0x015DF6-Waterfall_Mappings
                dc.w    Offset_0x015DF4-Waterfall_Mappings
                dc.w    Offset_0x015E18-Waterfall_Mappings
                dc.w    Offset_0x015D50-Waterfall_Mappings
                dc.w    Offset_0x015E6A-Waterfall_Mappings
Offset_0x015D50:
                dc.w    $0002
                dc.l    $800D0000, $0000FFE0
                dc.l    $800D0000, $00000000
Offset_0x015D62:
                dc.w    $0012
                dc.l    $800D0000, $0000FFE0
                dc.l    $800D0000, $00000000
                dc.l    $800F0008, $0004FFE0
                dc.l    $800F0008, $00040000
                dc.l    $A00F0008, $0004FFE0
                dc.l    $A00F0008, $00040000
                dc.l    $C00F0008, $0004FFE0
                dc.l    $C00F0008, $00040000
                dc.l    $E00F0008, $0004FFE0
                dc.l    $E00F0008, $00040000
                dc.l    $000F0008, $0004FFE0
                dc.l    $000F0008, $00040000
                dc.l    $200F0008, $0004FFE0
                dc.l    $200F0008, $00040000
                dc.l    $400F0008, $0004FFE0
                dc.l    $400F0008, $00040000
                dc.l    $600F0008, $0004FFE0
                dc.l    $600F0008, $00040000
Offset_0x015DF4:
                dc.w    $0000
Offset_0x015DF6:
                dc.w    $0004
                dc.l    $E00F0008, $0004FFE0
                dc.l    $E00F0008, $00040000
                dc.l    $000F0008, $0004FFE0
                dc.l    $000F0008, $00040000
Offset_0x015E18:
                dc.w    $000A
                dc.l    $C00F0008, $0004FFE0
                dc.l    $C00F0008, $00040000
                dc.l    $E00F0008, $0004FFE0
                dc.l    $E00F0008, $00040000
                dc.l    $000F0008, $0004FFE0
                dc.l    $000F0008, $00040000
                dc.l    $200F0008, $0004FFE0
                dc.l    $200F0008, $00040000
                dc.l    $400F0008, $0004FFE0
                dc.l    $400F0008, $00040000
Offset_0x015E6A:
                dc.w    $000E
                dc.l    $800D0000, $0000FFE0
                dc.l    $800D0000, $00000000
                dc.l    $800F0008, $0004FFE0
                dc.l    $800F0008, $00040000
                dc.l    $A00F0008, $0004FFE0
                dc.l    $A00F0008, $00040000
                dc.l    $C00F0008, $0004FFE0
                dc.l    $C00F0008, $00040000
                dc.l    $E00F0008, $0004FFE0
                dc.l    $E00F0008, $00040000
                dc.l    $000F0008, $0004FFE0
                dc.l    $000F0008, $00040000
                dc.l    $200F0008, $0004FFE0
                dc.l    $200F0008, $00040000
;===============================================================================
; Objeto 0x49 - Cachoeiras na Green Hill
; <<<-
;===============================================================================