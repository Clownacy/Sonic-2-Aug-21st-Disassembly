;===============================================================================
; Objeto 0x76 - Plataforma com espinhos nas laterais na Dust Hill
; ->>> 
;===============================================================================   
; Offset_0x01DED4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01DEE2(PC, D0), D1
                jmp     Offset_0x01DEE2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01DEE2:
                dc.w    Offset_0x01DEEA-Offset_0x01DEE2
                dc.w    Offset_0x01DF3A-Offset_0x01DEE2      
;-------------------------------------------------------------------------------
Platform_Spikes_Config:                                        ; Offset_0x01DEE6
                dc.b    $40, $10            ; Largura / Altura do espinho
                dc.b    $00, $00                                        
;-------------------------------------------------------------------------------
Offset_0x01DEEA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Platform_Spikes_Mappings, Obj_Map(A0) ; Offset_0x01E016, $0004
                move.w  #$0000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_1C_To_ModifySpriteAttr_2P          ; Offset_0x01E052
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$02, D0
                andi.w  #$001C, D0
                lea     Platform_Spikes_Config(PC, D0), A2     ; Offset_0x01DEE6
                move.b  (A2)+, Obj_Width(A0)                             ; $0019
                move.b  (A2)+, Obj_Height_2(A0)                          ; $0016
                move.b  (A2)+, Obj_Map_Id(A0)                            ; $001A
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                andi.w  #$000F, Obj_Subtype(A0)                          ; $0028  
;-------------------------------------------------------------------------------
Offset_0x01DF3A:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.w  Offset_0x01DFA6(PC, D0), D1
                jsr     Offset_0x01DFA6(PC, D1)
                move.w  (A7)+, D4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01DF9E
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_10_To_SolidObject                  ; Offset_0x01E058
                swap.w  D6
                andi.w  #$0003, D6
                beq.s   Offset_0x01DF9E
                move.b  D6, D0
                andi.b  #$01, D0
                beq.s   Offset_0x01DF8A
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr     Jmp_00_To_Hurt_Player_A1               ; Offset_0x01E04C
                bclr    #$05, Obj_Status(A0)                             ; $0022
Offset_0x01DF8A:
                andi.b  #$02, D6
                beq.s   Offset_0x01DF9E
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr     Jmp_00_To_Hurt_Player_A1               ; Offset_0x01E04C
                bclr    #$06, Obj_Status(A0)                             ; $0022
Offset_0x01DF9E:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                bra     Jmp_04_To_MarkObjGone_2                ; Offset_0x01E05E                                         
;-------------------------------------------------------------------------------
Offset_0x01DFA6:
                dc.w    Offset_0x01DFAA-Offset_0x01DFA6
                dc.w    Offset_0x01DFFA-Offset_0x01DFA6                  
;-------------------------------------------------------------------------------
Offset_0x01DFAA:
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x01DFB4
                lea     (Player_Two).w, A1                           ; $FFFFB040
Offset_0x01DFB4:
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x01DFF8
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$00C0, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01DFD4
                subi.w  #$0100, D0
Offset_0x01DFD4:
                cmpi.w  #$0080, D0
                bcc.s   Offset_0x01DFF8
                move.w  Obj_Y(A1), D0                                    ; $000C
                sub.w   Obj_Y(A0), D0                                    ; $000C
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc.s   Offset_0x01DFF8
                move.b  #$02, Obj_Subtype(A0)                            ; $0028
                move.w  #$0080, Obj_Control_Var_0A(A0)                   ; $0036
Offset_0x01DFF8:
                rts  
;-------------------------------------------------------------------------------
Offset_0x01DFFA:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01E014
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                moveq   #-$01, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01E010
                neg.w   D0
Offset_0x01E010:
                add.w   D0, Obj_X(A0)                                    ; $0008
Offset_0x01E014:
                rts        
;-------------------------------------------------------------------------------   
Platform_Spikes_Mappings:                                      ; Offset_0x01E016
                dc.w    Offset_0x01E018-Platform_Spikes_Mappings
Offset_0x01E018:
                dc.w    $0006
                dc.l    $F005242C, $2216FFC0
                dc.l    $0005242C, $2216FFC0
                dc.l    $F0076040, $6020FFD0
                dc.l    $F00F6048, $6024FFE0
                dc.l    $F00F6048, $60240000
                dc.l    $F00F6048, $60240020
;===============================================================================
; Objeto 0x76 - Plataforma com espinhos nas laterais na Dust Hill
; <<<- 
;===============================================================================