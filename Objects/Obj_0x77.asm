;===============================================================================
; Objeto 0x77 - Pontes na Dust Hill
; ->>> 
;===============================================================================   
; Offset_0x01E064:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01E072(PC, D0), D1
                jmp     Offset_0x01E072(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01E072:
                dc.w    Offset_0x01E076-Offset_0x01E072
                dc.w    Offset_0x01E098-Offset_0x01E072    
;-------------------------------------------------------------------------------
Offset_0x01E076:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #DHz_Bridge_Mappings, Obj_Map(A0) ; Offset_0x01E140, $0004
                move.w  #$643C, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_1D_To_ModifySpriteAttr_2P          ; Offset_0x01E29A
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$80, Obj_Width(A0)                              ; $0019 
;-------------------------------------------------------------------------------
Offset_0x01E098:
                tst.b   Obj_Control_Var_08(A0)                           ; $0034
                bne.s   Offset_0x01E0CC
                lea     ($FFFFF7E0).w, A2
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                btst    #$00, $00(A2, D0)
                beq.s   Offset_0x01E0CC
                move.b  #$01, Obj_Control_Var_08(A0)                     ; $0034
                bchg    #00, Obj_Ani_Number(A0)                          ; $001C
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01E0CC
                move.w  #$00BB, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x01E0CC:
                lea     (DHz_Bridge_Animate_Data), A1          ; Offset_0x01E12C
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                tst.b   Obj_Map_Id(A0)                                   ; $001A
                bne.s   Offset_0x01E0F6
                move.w  #$004B, D1
                move.w  #$0008, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_11_To_SolidObject                  ; Offset_0x01E2A0
                bra     Jmp_14_To_MarkObjGone                  ; Offset_0x01E294
Offset_0x01E0F6:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x01E128
                move.b  D0, D1
                andi.b  #$08, D0
                beq.s   Offset_0x01E112
                lea     (Player_One).w, A1                           ; $FFFFB000
                bclr    #$03, Obj_Status(A1)                             ; $0022
Offset_0x01E112:
                andi.b  #$10, D1
                beq.s   Offset_0x01E122
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bclr    #$03, Obj_Status(A1)                             ; $0022
Offset_0x01E122:
                andi.b  #$E7, Obj_Status(A0)                             ; $0022
Offset_0x01E128:
                bra     Jmp_14_To_MarkObjGone                  ; Offset_0x01E294        
;-------------------------------------------------------------------------------    
DHz_Bridge_Animate_Data:                                       ; Offset_0x01E12C
                dc.w    Offset_0x01E130-DHz_Bridge_Animate_Data
                dc.w    Offset_0x01E138-DHz_Bridge_Animate_Data
Offset_0x01E130:
                dc.b    $03, $04, $03, $02, $01, $00, $FE, $01
Offset_0x01E138:
                dc.b    $03, $00, $01, $02, $03, $04, $FE, $01     
;-------------------------------------------------------------------------------
DHz_Bridge_Mappings:                                           ; Offset_0x01E140
                dc.w    Offset_0x01E14A-DHz_Bridge_Mappings
                dc.w    Offset_0x01E18C-DHz_Bridge_Mappings
                dc.w    Offset_0x01E1CE-DHz_Bridge_Mappings
                dc.w    Offset_0x01E210-DHz_Bridge_Mappings
                dc.w    Offset_0x01E252-DHz_Bridge_Mappings
Offset_0x01E14A:
                dc.w    $0008
                dc.l    $F8050000, $0000FFC0
                dc.l    $F8050000, $0000FFD0
                dc.l    $F8050000, $0000FFE0
                dc.l    $F8050000, $0000FFF0
                dc.l    $F8050000, $00000000
                dc.l    $F8050000, $00000010
                dc.l    $F8050000, $00000020
                dc.l    $F8050000, $00000030
Offset_0x01E18C:
                dc.w    $0008
                dc.l    $F8050000, $0000FFC0
                dc.l    $FE050000, $0000FFCE
                dc.l    $04050000, $0000FFDD
                dc.l    $0A050000, $0000FFEC
                dc.l    $0A050000, $00000004
                dc.l    $04050000, $00000013
                dc.l    $FE050000, $00000022
                dc.l    $F8050000, $00000030
Offset_0x01E1CE:
                dc.w    $0008
                dc.l    $F8050000, $0000FFC0
                dc.l    $03050000, $0000FFCB
                dc.l    $0E050000, $0000FFD6
                dc.l    $19050000, $0000FFE1
                dc.l    $19050000, $0000000F
                dc.l    $0E050000, $0000001A
                dc.l    $03050000, $00000025
                dc.l    $F8050000, $00000030
Offset_0x01E210:
                dc.w    $0008
                dc.l    $F8050000, $0000FFC0
                dc.l    $06050000, $0000FFC6
                dc.l    $15050000, $0000FFCC
                dc.l    $24050000, $0000FFD2
                dc.l    $24050000, $0000001E
                dc.l    $15050000, $00000024
                dc.l    $06050000, $0000002A
                dc.l    $F8050000, $00000030
Offset_0x01E252:
                dc.w    $0008
                dc.l    $F8050000, $0000FFC0
                dc.l    $08050000, $0000FFC0
                dc.l    $18050000, $0000FFC0
                dc.l    $28050000, $0000FFC0
                dc.l    $F8050000, $00000030
                dc.l    $08050000, $00000030
                dc.l    $18050000, $00000030
                dc.l    $28050000, $00000030    
;===============================================================================
; Objeto 0x77 - Pontes na Dust Hill
; <<<- 
;===============================================================================