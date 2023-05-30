;===============================================================================
; Objeto 0x36 - Espinhos
; ->>> 
;===============================================================================   
; Offset_0x00C818:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00C826(PC, D0), D1
                jmp     Offset_0x00C826(PC, D1) 
;-------------------------------------------------------------------------------
Offset_0x00C826:
                dc.w    Offset_0x00C83E-Offset_0x00C826
                dc.w    Offset_0x00C8AA-Offset_0x00C826
                dc.w    Offset_0x00C8FA-Offset_0x00C826
                dc.w    Offset_0x00C956-Offset_0x00C826         
;-------------------------------------------------------------------------------    
Spikes_Conf:                                                   ; Offset_0x00C82E
                dc.b    $10, $10  ; Largura / Altura do espinho
                dc.b    $20, $10
                dc.b    $30, $10
                dc.b    $40, $10
                dc.b    $10, $10
                dc.b    $10, $20
                dc.b    $10, $30
                dc.b    $10, $40       
;------------------------------------------------------------------------------- 
Offset_0x00C83E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Spikes_Mappings, Obj_Map(A0)   ; Offset_0x00CA74, $0004
                move.w  #$2434, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028
                andi.w  #$00F0, D0
                lea     Spikes_Conf(PC), A1                    ; Offset_0x00C82E
                lsr.w   #$03, D0
                adda.w  D0, A1
                move.b  (A1)+, Obj_Width(A0)                             ; $0019
                move.b  (A1)+, Obj_Height_2(A0)                          ; $0016
                lsr.w   #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                cmpi.b  #$04, D0
                bcs.s   Offset_0x00C88E
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x00C88E:
                btst    #$01, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00C89C
                move.b  #$06, Obj_Routine(A0)                            ; $0024
Offset_0x00C89C:
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                rts      
;------------------------------------------------------------------------------- 
Offset_0x00C8AA:
                bsr     Offset_0x00C9D2
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject                            ; Offset_0x00F344
                move.b  Obj_Status(A0), D6                               ; $0022
                andi.b  #$18, D6
                beq.s   Offset_0x00C8F2
                move.b  D6, D0
                andi.b  #$08, D0
                beq.s   Offset_0x00C8E4
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x00C9A4
Offset_0x00C8E4:
                andi.b  #$10, D6
                beq.s   Offset_0x00C8F2
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr     Hurt_Player_A1                         ; Offset_0x00C9A4
Offset_0x00C8F2:
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bra     MarkObjGone_2                          ; Offset_0x00D238   
;------------------------------------------------------------------------------- 
Offset_0x00C8FA:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x00C9D2
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  (A7)+, D4
                bsr     SolidObject                            ; Offset_0x00F344
                swap.w  D6
                andi.w  #$0003, D6
                beq.s   Offset_0x00C94E
                move.b  D6, D0
                andi.b  #$01, D0
                beq.s   Offset_0x00C93A
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x00C9A4
                bclr    #$05, Obj_Status(A0)                             ; $0022
Offset_0x00C93A:
                andi.b  #$02, D6
                beq.s   Offset_0x00C94E
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr     Hurt_Player_A1                         ; Offset_0x00C9A4
                bclr    #$06, Obj_Status(A0)                             ; $0022
Offset_0x00C94E:
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bra     MarkObjGone_2                          ; Offset_0x00D238   
;-------------------------------------------------------------------------------    
Offset_0x00C956:
                bsr     Offset_0x00C9D2
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject                            ; Offset_0x00F344
                swap.w  D6
                andi.w  #$000C, D6
                beq.s   Offset_0x00C99C
                move.b  D6, D0
                andi.b  #$04, D0
                beq.s   Offset_0x00C98E
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr     Hurt_Player_A1                         ; Offset_0x00C9A4
Offset_0x00C98E:
                andi.b  #$08, D6
                beq.s   Offset_0x00C99C
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr     Hurt_Player_A1                         ; Offset_0x00C9A4
Offset_0x00C99C:
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bra     MarkObjGone_2                          ; Offset_0x00D238   
;-------------------------------------------------------------------------------  
Hurt_Player_A1:                                                ; Offset_0x00C9A4
                tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
                bne.s   Exit_Hurt_Player_A1                    ; Offset_0x00C9D0
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0024
                bcc.s   Exit_Hurt_Player_A1                    ; Offset_0x00C9D0
                move.l  Obj_Y(A1), D3                                    ; $000C
                move.w  Obj_Speed_Y(A1), D0                              ; $0012
                ext.l   D0
                asl.l   #$08, D0
                sub.l   D0, D3
                move.l  D3, Obj_Y(A1)                                    ; $000C
                move.l  A0, A2
                move.l  A1, A0
                jsr     (Hurt_Player)                          ; Offset_0x02B4DE
                move.l  A2, A0
Exit_Hurt_Player_A1:                                           ; Offset_0x00C9D0
                rts                                                             
;-------------------------------------------------------------------------------  
Offset_0x00C9D2:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, D0
                move.w  Offset_0x00C9E2(PC, D0), D1
                jmp     Offset_0x00C9E2(PC, D1)                 
;-------------------------------------------------------------------------------  
Offset_0x00C9E2:
                dc.w    Offset_0x00C9E8-Offset_0x00C9E2
                dc.w    Offset_0x00C9EA-Offset_0x00C9E2
                dc.w    Offset_0x00C9FE-Offset_0x00C9E2         
;-------------------------------------------------------------------------------  
Offset_0x00C9E8:
                rts 
;-------------------------------------------------------------------------------  
Offset_0x00C9EA:
                bsr     Offset_0x00CA12
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $000C
                rts    
;-------------------------------------------------------------------------------  
Offset_0x00C9FE:
                bsr     Offset_0x00CA12
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0008
                rts
Offset_0x00CA12:
                tst.w   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x00CA30
                subq.w  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bne.s   Offset_0x00CA72
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x00CA72
                move.w  #$00B6, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                bra.s   Offset_0x00CA72
Offset_0x00CA30:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x00CA52
                subi.w  #$0800, Obj_Control_Var_08(A0)                   ; $0034
                bcc.s   Offset_0x00CA72
                move.w  #$0000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0000, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$003C, Obj_Control_Var_0C(A0)                   ; $0038
                bra.s   Offset_0x00CA72
Offset_0x00CA52:
                addi.w  #$0800, Obj_Control_Var_08(A0)                   ; $0034
                cmpi.w  #$2000, Obj_Control_Var_08(A0)                   ; $0034
                bcs.s   Offset_0x00CA72
                move.w  #$2000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0001, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$003C, Obj_Control_Var_0C(A0)                   ; $0038
Offset_0x00CA72:
                rts        
;-------------------------------------------------------------------------------
Spikes_Mappings:                                               ; Offset_0x00CA74
                dc.w    Offset_0x00CA84-Spikes_Mappings
                dc.w    Offset_0x00CA96-Spikes_Mappings
                dc.w    Offset_0x00CAB8-Spikes_Mappings
                dc.w    Offset_0x00CAEA-Spikes_Mappings
                dc.w    Offset_0x00CB2C-Spikes_Mappings
                dc.w    Offset_0x00CB3E-Spikes_Mappings
                dc.w    Offset_0x00CB60-Spikes_Mappings
                dc.w    Offset_0x00CB92-Spikes_Mappings
Offset_0x00CA84:
                dc.w    $0002
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070000, $00000000
Offset_0x00CA96:
                dc.w    $0004
                dc.l    $F0070000, $0000FFE0
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070000, $00000000
                dc.l    $F0070000, $00000010
Offset_0x00CAB8:
                dc.w    $0006
                dc.l    $F0070000, $0000FFD0
                dc.l    $F0070000, $0000FFE0
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070000, $00000000
                dc.l    $F0070000, $00000010
                dc.l    $F0070000, $00000020
Offset_0x00CAEA:
                dc.w    $0008
                dc.l    $F0070000, $0000FFC0
                dc.l    $F0070000, $0000FFD0
                dc.l    $F0070000, $0000FFE0
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070000, $00000000
                dc.l    $F0070000, $00000010
                dc.l    $F0070000, $00000020
                dc.l    $F0070000, $00000030
Offset_0x00CB2C:
                dc.w    $0002
                dc.l    $F00DFFF8, $FBFCFFF0
                dc.l    $000DFFF8, $FBFCFFF0
Offset_0x00CB3E:
                dc.w    $0004
                dc.l    $E00DFFF8, $FBFCFFF0
                dc.l    $F00DFFF8, $FBFCFFF0
                dc.l    $000DFFF8, $FBFCFFF0
                dc.l    $100DFFF8, $FBFCFFF0
Offset_0x00CB60:
                dc.w    $0006
                dc.l    $D00DFFF8, $FBFCFFF0
                dc.l    $E00DFFF8, $FBFCFFF0
                dc.l    $F00DFFF8, $FBFCFFF0
                dc.l    $000DFFF8, $FBFCFFF0
                dc.l    $100DFFF8, $FBFCFFF0
                dc.l    $200DFFF8, $FBFCFFF0
Offset_0x00CB92:
                dc.w    $0008
                dc.l    $C00DFFF8, $FBFCFFF0
                dc.l    $D00DFFF8, $FBFCFFF0
                dc.l    $E00DFFF8, $FBFCFFF0
                dc.l    $F00DFFF8, $FBFCFFF0
                dc.l    $000DFFF8, $FBFCFFF0
                dc.l    $100DFFF8, $FBFCFFF0
                dc.l    $200DFFF8, $FBFCFFF0
                dc.l    $300DFFF8, $FBFCFFF0
;===============================================================================
; Objeto 0x36 - Espinhos
; <<<- 
;===============================================================================