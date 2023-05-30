;===============================================================================
; Objeto 0x30 - Atributos dos tiles usados durante os terremotos na Hill Top
; ->>> 
;===============================================================================   
; Offset_0x01870C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01871A(PC, D0), D1
                jmp     Offset_0x01871A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01871A:
                dc.w    Offset_0x018728-Offset_0x01871A
                dc.w    Offset_0x018774-Offset_0x01871A     
;-------------------------------------------------------------------------------
Offset_0x01871E:
                dc.b    $C0, $00, $C0, $00, $C0, $00, $E0, $00
                dc.b    $C0, $00                              
;-------------------------------------------------------------------------------
Offset_0x018728:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.b  Offset_0x01871E(PC, D0), Obj_Width(A0)           ; $0019
                cmpi.b  #$06, D0
                bcs.s   Offset_0x018774
                bne.s   Offset_0x018756
                cmpi.w  #$0380, (Camera_Y).w                         ; $FFFFEE04
                bcc.s   Offset_0x018774
                bra.s   Offset_0x01875E
Offset_0x018756:
                cmpi.w  #$0380, (Camera_Y).w                         ; $FFFFEE04
                bcs.s   Offset_0x018774
Offset_0x01875E:
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x018770
                bclr    #$07, $02(A2, D0)
Offset_0x018770:
                bra     Jmp_07_To_DeleteObject                 ; Offset_0x018900    
;-------------------------------------------------------------------------------
Offset_0x018774:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                add.w   ($FFFFEEE4).w, D0
                move.w  D0, Obj_Y(A0)                                    ; $000C
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.w  Offset_0x018798(PC, D0), D1
                jsr     Offset_0x018798(PC, D1)
                tst.b   ($FFFFEEBC).w
                beq     Jmp_01_To_MarkObjGone_3                ; Offset_0x01890C
                rts       
;-------------------------------------------------------------------------------
Offset_0x018798:
                dc.w    Offset_0x0187A2-Offset_0x018798
                dc.w    Offset_0x0187A2-Offset_0x018798
                dc.w    Offset_0x0187BA-Offset_0x018798
                dc.w    Offset_0x018800-Offset_0x018798
                dc.w    Offset_0x01881A-Offset_0x018798  
;-------------------------------------------------------------------------------
Offset_0x0187A2:
                move.w  #$00CB, D1
                move.w  #$0080, D2
                move.w  #$0081, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_00_To_SolidObject_2                ; Offset_0x018918
                bra     Offset_0x018912    
;-------------------------------------------------------------------------------
Offset_0x0187BA:
                move.w  #$00CB, D1
                move.w  #$0078, D2
                move.w  #$0079, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_00_To_SolidObject_2                ; Offset_0x018918
                bsr     Offset_0x018912
Offset_0x0187D2:
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0187E8
                move.l  A0, -(A7)
                move.l  A0, A1
                lea     (Player_One).w, A0                           ; $FFFFB000
                bsr     Offset_0x018906
                move.l  (A7)+, A0
Offset_0x0187E8:
                btst    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0187FE
                move.l  A0, -(A7)
                move.l  A0, A1
                lea     (Player_Two).w, A0                           ; $FFFFB040
                bsr     Offset_0x018906
                move.l  (A7)+, A0
Offset_0x0187FE:
                rts    
;-------------------------------------------------------------------------------
Offset_0x018800:
                move.w  #$00EB, D1
                move.w  #$0078, D2
                move.w  #$0079, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_00_To_SolidObject_2                ; Offset_0x018918
                bsr     Offset_0x018912
                bra.s   Offset_0x0187D2  
;-------------------------------------------------------------------------------
Offset_0x01881A:
                move.w  #$00CB, D1
                move.w  #$002E, D2
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Offset_0x018834), A2
                bsr     Jmp_00_To_SolidObject_3                ; Offset_0x01891E
                bra     Offset_0x018912          
;------------------------------------------------------------------------------- 
Offset_0x018834:
                dc.b    $30, $30, $30, $30, $30, $30, $30, $30
                dc.b    $2F, $2F, $2E, $2E, $2D, $2D, $2C, $2C
                dc.b    $2B, $2B, $2A, $2A, $29, $29, $28, $28
                dc.b    $27, $27, $26, $26, $25, $25, $24, $24
                dc.b    $23, $23, $22, $22, $21, $21, $20, $20
                dc.b    $1F, $1F, $1E, $1E, $1D, $1D, $1C, $1C
                dc.b    $1B, $1B, $1A, $1A, $19, $19, $18, $18
                dc.b    $17, $17, $16, $16, $15, $15, $14, $14
                dc.b    $13, $13, $12, $12, $11, $11, $10, $10
                dc.b    $0F, $0F, $0E, $0E, $0D, $0D, $0C, $0C
                dc.b    $0B, $0B, $0A, $0A, $09, $09, $08, $08
                dc.b    $07, $07, $06, $06, $05, $05, $04, $04
                dc.b    $03, $03, $02, $02, $01, $01, $00, $00
                dc.b    $FF, $FF, $FE, $FE, $FD, $FD, $FC, $FC
                dc.b    $FB, $FB, $FA, $FA, $F9, $F9, $F8, $F8
                dc.b    $F7, $F7, $F6, $F6, $F5, $F5, $F4, $F4
                dc.b    $F3, $F3, $F2, $F2, $F1, $F1, $F0, $F0
                dc.b    $EF, $EF, $EE, $EE, $ED, $ED, $EC, $EC
                dc.b    $EB, $EB, $EA, $EA, $E9, $E9, $E8, $E8
                dc.b    $E7, $E7, $E6, $E6, $E5, $E5, $E4, $E4
                dc.b    $E3, $E3, $E2, $E2, $E1, $E1, $E0, $E0
                dc.b    $DF, $DF, $DE, $DE, $DD, $DD, $DC, $DC
                dc.b    $DB, $DB, $DA, $DA, $D9, $D9, $D8, $D8
                dc.b    $D7, $D7, $D6, $D6, $D5, $D5, $D4, $D4
                dc.b    $D3, $D3, $D2, $D2, $D1, $D1, $D0, $D0
                dc.b    $D0, $D0, $D0, $D0
;===============================================================================
; Objeto 0x30 - Atributos dos tiles usados durante os terremotos na Hill Top
; <<<- 
;===============================================================================