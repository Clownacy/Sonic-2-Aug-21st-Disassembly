;===============================================================================
; Objeto 0x11 - Pontes na Green Hill / Hidden Palace
; ->>> 
;===============================================================================
; Offset_0x008468:
                btst    #$06, Obj_Flags(A0)                              ; $0001
                bne     Offset_0x008480
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x008488(PC, D0), D1
                jmp     Offset_0x008488(PC, D1)
;-------------------------------------------------------------------------------                
Offset_0x008480:
                move.w  #$0180, D0
                bra     DisplaySprite_Param                    ; Offset_0x00D35E    
;-------------------------------------------------------------------------------
Offset_0x008488:
                dc.w    Offset_0x008490-Offset_0x008488
                dc.w    Offset_0x008576-Offset_0x008488
                dc.w    Offset_0x008608-Offset_0x008488
                dc.w    Offset_0x00860C-Offset_0x008488       
;-------------------------------------------------------------------------------
Offset_0x008490:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #GHz_Bridge_Mappings, Obj_Map(A0) ; Offset_0x008A6C, $0004
                move.w  #$43B6, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                cmpi.b  #$08, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x0084C2
                addq.b  #$04, Obj_Routine(A0)                            ; $0024
                move.l  #HPz_Bridge_Mappings, Obj_Map(A0) ; Offset_0x008A24, $0004
                move.w  #$6300, Obj_Art_VRAM(A0)                         ; $0002
Offset_0x0084C2:
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$80, Obj_Width(A0)                              ; $0019
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, Obj_Control_Var_10(A0)                       ; $003C
                move.w  Obj_X(A0), D3                                    ; $0008
                lea     Obj_Subtype(A0), A2                              ; $0028
                moveq   #$00, D1
                move.b  (A2), D1
                move.w  D1, D0
                lsr.w   #$01, D0
                lsl.w   #$04, D0
                sub.w   D0, D3
                swap.w  D1
                move.w  #$0008, D1
                bsr.s   Offset_0x008524
                move.w  Obj_Subtype(A1), D0                              ; $0028
                subq.w  #$08, D0
                move.w  D0, Obj_X(A1)                                    ; $0008
                move.l  A1, Obj_Control_Var_04(A0)                       ; $0030
                swap.w  D1
                subq.w  #$08, D1
                bls.s   Offset_0x008522
                move.w  D1, D4
                bsr.s   Offset_0x008524
                move.l  A1, Obj_Control_Var_08(A0)                       ; $0034
                move.w  D4, D0
                add.w   D0, D0
                add.w   D4, D0
                move.w  $10(A1, D0), D0
                subq.w  #$08, D0
                move.w  D0, Obj_X(A1)                                    ; $0008
Offset_0x008522:
                bra.s   Offset_0x008576
Offset_0x008524:
                bsr     SingleObjectLoad_2                     ; Offset_0x00E714
                bne.s   Offset_0x008574
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                bset    #$06, Obj_Flags(A1)                              ; $0001
                move.b  #$40, $000E(A1)
                move.b  D1, $000F(A1)                       
                subq.b  #$01, D1
                lea     Obj_Speed(A1), A2                                ; $0010
Offset_0x008564:
                move.w  D3, (A2)+
                move.w  D2, (A2)+
                move.w  #$0000, (A2)+
                addi.w  #$0010, D3
                dbra    D1, Offset_0x008564
Offset_0x008574:
                rts  
;------------------------------------------------------------------------------- 
Offset_0x008576:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x00858C
                tst.b   Obj_Control_Var_12(A0)                           ; $003E
                beq.s   Offset_0x0085B8
                subq.b  #$04, Obj_Control_Var_12(A0)                     ; $003E
                bra.s   Offset_0x0085B4
Offset_0x00858C:
                andi.b  #$10, D0
                beq.s   Offset_0x0085A8
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                sub.b   Obj_Control_Var_0F(A0), D0                       ; $003B
                beq.s   Offset_0x0085A8
                bcc.s   Offset_0x0085A4
                addq.b  #$01, Obj_Control_Var_13(A0)                     ; $003F
                bra.s   Offset_0x0085A8
Offset_0x0085A4:
                subq.b  #$01, Obj_Control_Var_13(A0)                     ; $003F
Offset_0x0085A8:
                cmpi.b  #$40, Obj_Control_Var_12(A0)                     ; $003E
                beq.s   Offset_0x0085B4
                addq.b  #$04, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x0085B4:
                bsr     Offset_0x0087E4
Offset_0x0085B8:
                moveq   #$00, D1
                move.b  Obj_Subtype(A0), D1                              ; $0028
                lsl.w   #$03, D1
                move.w  D1, D2
                addq.w  #$08, D1
                add.w   D2, D2
                moveq   #$08, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Offset_0x00866E
Offset_0x0085D0:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x0085D8
                rts
Offset_0x0085D8:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x0085EC
                rts
Offset_0x0085EC:
                move.l  Obj_Control_Var_04(A0), A1                       ; $0030
                bsr     DeleteObject_A1                        ; Offset_0x00D316
                cmpi.b  #$08, Obj_Subtype(A0)                            ; $0028
                bls.s   Offset_0x008604
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                bsr     DeleteObject_A1                        ; Offset_0x00D316
Offset_0x008604:
                bra     DeleteObject                           ; Offset_0x00D314  
;------------------------------------------------------------------------------- 
Offset_0x008608:
                bra     DisplaySprite                          ; Offset_0x00D322 
;------------------------------------------------------------------------------- 
Offset_0x00860C:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x008622
                tst.b   Obj_Control_Var_12(A0)                           ; $003E
                beq.s   Offset_0x00864E
                subq.b  #$04, Obj_Control_Var_12(A0)                     ; $003E
                bra.s   Offset_0x00864A
Offset_0x008622:
                andi.b  #$10, D0
                beq.s   Offset_0x00863E
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                sub.b   Obj_Control_Var_0F(A0), D0                       ; $003B
                beq.s   Offset_0x00863E
                bcc.s   Offset_0x00863A
                addq.b  #$01, Obj_Control_Var_13(A0)                     ; $003F
                bra.s   Offset_0x00863E
Offset_0x00863A:
                subq.b  #$01, Obj_Control_Var_13(A0)                     ; $003F
Offset_0x00863E:
                cmpi.b  #$40, Obj_Control_Var_12(A0)                     ; $003E
                beq.s   Offset_0x00864A
                addq.b  #$04, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x00864A:
                bsr     Offset_0x0087E4
Offset_0x00864E:
                moveq   #$00, D1
                move.b  Obj_Subtype(A0), D1                              ; $0028
                lsl.w   #$03, D1
                move.w  D1, D2
                addq.w  #$08, D1
                add.w   D2, D2
                moveq   #$08, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Offset_0x00866E
                bsr     Offset_0x00870E
                bra     Offset_0x0085D0
Offset_0x00866E:
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                moveq   #$3B, D5
                movem.l D1-D4, -(A7)
                bsr.s   Offset_0x008688
                movem.l (A7)+, D1-D4
                lea     (Player_One).w, A1                           ; $FFFFB000
                subq.b  #$01, D6
                moveq   #$3F, D5
Offset_0x008688:
                btst    D6, Obj_Status(A0)                               ; $0022
                beq.s   Offset_0x0086EC
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x0086A8
                moveq   #$00, D0
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                add.w   D1, D0
                bmi.s   Offset_0x0086A8
                cmp.w   D2, D0
                bcs.s   Offset_0x0086B6
Offset_0x0086A8:
                bclr    #$03, Obj_Status(A1)                             ; $0022
                bclr    D6, Obj_Status(A0)                               ; $0022
                moveq   #$00, D4
                rts
Offset_0x0086B6:
                lsr.w   #$04, D0
                move.b  D0, $00(A0, D5)
                move.l  Obj_Control_Var_04(A0), A2                       ; $0030
                cmpi.w  #$0008, D0
                bcs.s   Offset_0x0086CE
                move.l  Obj_Control_Var_08(A0), A2                       ; $0034
                subi.w  #$0008, D0
Offset_0x0086CE:
                add.w   D0, D0
                move.w  D0, D1
                add.w   D0, D0
                add.w   D1, D0
                move.w  $12(A2, D0), D0
                subq.w  #$08, D0
                moveq   #$00, D1
                move.b  Obj_Height_2(A1), D1                             ; $0016
                sub.w   D1, D0
                move.w  D0, Obj_Y(A1)                                    ; $000C
                moveq   #$00, D4
                rts
Offset_0x0086EC:
                move.w  D1, -(A7)
                bsr     Offset_0x00F922
                move.w  (A7)+, D1
                btst    D6, Obj_Status(A0)                               ; $0022
                beq.s   Offset_0x00870C
                moveq   #$00, D0
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                add.w   D1, D0
                lsr.w   #$04, D0
                move.b  D0, $00(A0, D5)
Offset_0x00870C:
                rts
Offset_0x00870E:
                moveq   #$00, D0
                tst.w   (Player_One+Obj_Speed).w                     ; $FFFFB010
                bne.s   Offset_0x008720
                move.b  ($FFFFFE0F).w, D0
                andi.w  #$001C, D0
                lsr.w   #$01, D0
Offset_0x008720:
                moveq   #$00, D2
                move.b  Offset_0x00874C+$01(PC, D0), D2
                swap.w  D2
                move.b  Offset_0x00874C(PC, D0), D2
                moveq   #$00, D0
                tst.w   (Player_Two+Obj_Speed).w                     ; $FFFFB050
                bne.s   Offset_0x00873E
                move.b  ($FFFFFE0F).w, D0
                andi.w  #$001C, D0
                lsr.w   #$01, D0
Offset_0x00873E:
                moveq   #$00, D6
                move.b  Offset_0x00874C+$01(PC, D0), D6
                swap.w  D6
                move.b  Offset_0x00874C(PC, D0), D6
                bra.s   Offset_0x00875C 
;-------------------------------------------------------------------------------       
Offset_0x00874C:
                dc.b    $01, $02, $01, $02, $01, $02, $01, $02
                dc.b    $00, $01, $00, $00, $00, $00, $00, $01
;-------------------------------------------------------------------------------
Offset_0x00875C:
                moveq   #-$02, D3
                moveq   #-$02, D4
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$08, D0
                beq.s   Offset_0x00876E
                move.b  Obj_Control_Var_13(A0), D3                       ; $003F
Offset_0x00876E:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$10, D0
                beq.s   Offset_0x00877C
                move.b  Obj_Control_Var_0F(A0), D4                       ; $003B
Offset_0x00877C:
                move.l  Obj_Control_Var_04(A0), A1                       ; $0030
                lea     $0045(A1), A2
                lea     $0015(A1), A1
                moveq   #$00, D1
                move.b  Obj_Subtype(A0), D1                              ; $0028
                subq.b  #$01, D1
                moveq   #$00, D5
Offset_0x008792:
                moveq   #$00, D0
                subq.w  #$01, D3
                cmp.b   D3, D5
                bne.s   Offset_0x00879C
                move.w  D2, D0
Offset_0x00879C:
                addq.w  #$02, D3
                cmp.b   D3, D5
                bne.s   Offset_0x0087A4
                move.w  D2, D0
Offset_0x0087A4:
                subq.w  #$01, D3
                subq.w  #$01, D4
                cmp.b   D4, D5
                bne.s   Offset_0x0087AE
                move.w  D6, D0
Offset_0x0087AE:
                addq.w  #$02, D4
                cmp.b   D4, D5
                bne.s   Offset_0x0087B6
                move.w  D6, D0
Offset_0x0087B6:
                subq.w  #$01, D4
                cmp.b   D3, D5
                bne.s   Offset_0x0087C2
                swap.w  D2
                move.w  D2, D0
                swap.w  D2
Offset_0x0087C2:
                cmp.b   D4, D5
                bne.s   Offset_0x0087CC
                swap.w  D6
                move.w  D6, D0
                swap.w  D6
Offset_0x0087CC:
                move.b  D0, (A1)
                addq.w  #$01, D5
                addq.w  #$06, A1
                cmpa.w  A2, A1
                bne.s   Offset_0x0087DE
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                lea     $0015(A1), A1
Offset_0x0087DE:
                dbra    D1, Offset_0x008792
                rts
Offset_0x0087E4:
                move.b  Obj_Control_Var_12(A0), D0                       ; $003E
                bsr     CalcSine                               ; Offset_0x003282
                move.w  D0, D4
                lea     (Offset_0x008924), A4
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsl.w   #$04, D0
                moveq   #$00, D3
                move.b  Obj_Control_Var_13(A0), D3                       ; $003F
                move.w  D3, D2
                add.w   D0, D3
                moveq   #$00, D5
                lea     (Offset_0x008894-$80), A5
                move.b  $00(A5, D3), D5
                andi.w  #$000F, D3
                lsl.w   #$04, D3
                lea     $00(A4, D3), A3
                move.l  Obj_Control_Var_04(A0), A1                       ; $0030
                lea     $0042(A1), A2
                lea     Obj_Speed_Y(A1), A1                              ; $0012
Offset_0x008828:
                moveq   #$00, D0
                move.b  (A3)+, D0
                addq.w  #$01, D0
                mulu.w  D5, D0
                mulu.w  D4, D0
                swap.w  D0
                add.w   Obj_Control_Var_10(A0), D0                       ; $003C
                move.w  D0, (A1)
                addq.w  #$06, A1
                cmpa.w  A2, A1
                bne.s   Offset_0x008848
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                lea     Obj_Speed_Y(A1), A1                              ; $0012
Offset_0x008848:
                dbra    D2, Offset_0x008828
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                moveq   #$00, D3
                move.b  Obj_Control_Var_13(A0), D3                       ; $003F
                addq.b  #$01, D3
                sub.b   D0, D3
                neg.b   D3
                bmi.s   Offset_0x008892
                move.w  D3, D2
                lsl.w   #$04, D3
                lea     $00(A4, D3), A3
                adda.w  D2, A3
                subq.w  #$01, D2
                bcs.s   Offset_0x008892
Offset_0x00886E:
                moveq   #$00, D0
                move.b  -(A3), D0
                addq.w  #$01, D0
                mulu.w  D5, D0
                mulu.w  D4, D0
                swap.w  D0
                add.w   Obj_Control_Var_10(A0), D0                       ; $003C
                move.w  D0, (A1)
                addq.w  #$06, A1
                cmpa.w  A2, A1
                bne.s   Offset_0x00888E
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                lea     Obj_Speed_Y(A1), A1                              ; $0012
Offset_0x00888E:
                dbra    D2, Offset_0x00886E
Offset_0x008892:
                rts  
;-------------------------------------------------------------------------------
Offset_0x008894:
                dc.b    $02, $04, $06, $08, $08, $06, $04, $02
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $08, $06, $04
                dc.b    $02, $00, $00, $00, $00, $00, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $0A, $08, $06
                dc.b    $04, $02, $00, $00, $00, $00, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $0C, $0A, $08
                dc.b    $06, $04, $02, $00, $00, $00, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $0C, $0C, $0A
                dc.b    $08, $06, $04, $02, $00, $00, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $0C, $0E, $0C
                dc.b    $0A, $08, $06, $04, $02, $00, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $0C, $0E, $0E
                dc.b    $0C, $0A, $08, $06, $04, $02, $00, $00
                dc.b    $02, $04, $06, $08, $0A, $0C, $0E, $10
                dc.b    $0E, $0C, $0A, $08, $06, $04, $02, $00
                dc.b    $02, $04, $06, $08, $0A, $0C, $0E, $10
                dc.b    $10, $0E, $0C, $0A, $08, $06, $04, $02
;-------------------------------------------------------------------------------
Offset_0x008924:  
                dc.b    $FF, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $B5, $FF, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $7E, $DB, $FF, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $61, $B5, $EC, $FF, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $4A, $93, $CD, $F3, $FF, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $3E, $7E, $B0, $DB, $F6, $FF, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $38, $6D, $9D, $C5, $E4, $F8, $FF, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $31, $61, $8E, $B5, $D4, $EC, $FB, $FF
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $2B, $56, $7E, $A2, $C1, $DB, $EE, $FB
                dc.b    $FF, $00, $00, $00, $00, $00, $00, $00
                dc.b    $25, $4A, $73, $93, $B0, $CD, $E1, $F3
                dc.b    $FC, $FF, $00, $00, $00, $00, $00, $00
                dc.b    $1F, $44, $67, $88, $A7, $BD, $D4, $E7
                dc.b    $F4, $FD, $FF, $00, $00, $00, $00, $00
                dc.b    $1F, $3E, $5C, $7E, $98, $B0, $C9, $DB
                dc.b    $EA, $F6, $FD, $FF, $00, $00, $00, $00
                dc.b    $19, $38, $56, $73, $8E, $A7, $BD, $D1
                dc.b    $E1, $EE, $F8, $FE, $FF, $00, $00, $00
                dc.b    $19, $38, $50, $6D, $83, $9D, $B0, $C5
                dc.b    $D8, $E4, $F1, $F8, $FE, $FF, $00, $00
                dc.b    $19, $31, $4A, $67, $7E, $93, $A7, $BD
                dc.b    $CD, $DB, $E7, $F3, $F9, $FE, $FF, $00
                dc.b    $19, $31, $4A, $61, $78, $8E, $A2, $B5
                dc.b    $C5, $D4, $E1, $EC, $F4, $FB, $FE, $FF
;-------------------------------------------------------------------------------
HPz_Bridge_Mappings:                                           ; Offset_0x008A24
                dc.w    Offset_0x008A30-HPz_Bridge_Mappings
                dc.w    Offset_0x008A3A-HPz_Bridge_Mappings
                dc.w    Offset_0x008A44-HPz_Bridge_Mappings
                dc.w    Offset_0x008A4E-HPz_Bridge_Mappings
                dc.w    Offset_0x008A58-HPz_Bridge_Mappings
                dc.w    Offset_0x008A62-HPz_Bridge_Mappings
Offset_0x008A30:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8
Offset_0x008A3A:
                dc.w    $0001
                dc.l    $F8050004, $0002FFF8
Offset_0x008A44:
                dc.w    $0001
                dc.l    $F8050008, $0004FFF8
Offset_0x008A4E:
                dc.w    $0001
                dc.l    $F402000C, $0006FFFC
Offset_0x008A58:
                dc.w    $0001
                dc.l    $F402000F, $0007FFFC
Offset_0x008A62:
                dc.w    $0001
                dc.l    $F4020012, $0009FFFC        
;-------------------------------------------------------------------------------    
GHz_Bridge_Mappings:                                           ; Offset_0x008A6C
                dc.w    Offset_0x008A70-GHz_Bridge_Mappings
                dc.w    Offset_0x008A7A-GHz_Bridge_Mappings
Offset_0x008A70:
                dc.w    $0001
                dc.l    $F8050004, $0002FFF8
Offset_0x008A7A:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8                    
;===============================================================================
; Objeto 0x11 - Pontes na Green Hill / Hidden Palace
; <<<- 
;===============================================================================