;===============================================================================
; Objeto 0x6B - Plataformas na Metropolis / Blocos na Chemical Plant
; ->>> 
;===============================================================================   
; Offset_0x01CB0C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01CB1A(PC, D0), D1
                jmp     Offset_0x01CB1A(PC, D1) 
;-------------------------------------------------------------------------------                     
Offset_0x01CB1A:
                dc.w    Offset_0x01CB26-Offset_0x01CB1A
                dc.w    Offset_0x01CBA8-Offset_0x01CB1A        
;-------------------------------------------------------------------------------    
Offset_0x01CB1E:
                dc.b    $20, $0C, $01, $00, $10, $10, $00, $00   
;-------------------------------------------------------------------------------
Offset_0x01CB26:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Mz_Platform_Mappings, Obj_Map(A0) ; Offset_0x01BC64, $0004
                move.w  #$6000, Obj_Art_VRAM(A0)                         ; $0002
                cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x01CB4E
                move.l  #CPz_Block_Mappings, Obj_Map(A0) ; Offset_0x01CDA2, $0004
                move.w  #$6418, Obj_Art_VRAM(A0)                         ; $0002
Offset_0x01CB4E:
                bsr     Jmp_16_To_ModifySpriteAttr_2P          ; Offset_0x01CDB0
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$02, D0
                andi.w  #$001C, D0
                lea     Offset_0x01CB1E(PC, D0), A2
                move.b  (A2)+, Obj_Width(A0)                             ; $0019
                move.b  (A2)+, Obj_Height_2(A0)                          ; $0016
                move.b  (A2)+, Obj_Map_Id(A0)                            ; $001A
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                subq.w  #$08, D0
                bcs.s   Offset_0x01CBA8
                lsl.w   #$02, D0
                lea     ($FFFFFE8A).w, A2
                lea     $00(A2, D0), A2
                tst.w   (A2)
                bpl.s   Offset_0x01CBA8
                bchg    #00, Obj_Status(A0)                              ; $0022  
;-------------------------------------------------------------------------------
Offset_0x01CBA8:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                add.w   D0, D0
                move.w  Offset_0x01CBE8(PC, D0), D1
                jsr     Offset_0x01CBE8(PC, D1)
                move.w  (A7)+, D4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01CBE0
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_0B_To_SolidObject                  ; Offset_0x01CDB6
Offset_0x01CBE0:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                bra     Jmp_03_To_MarkObjGone_2                ; Offset_0x01CDBC                                     
;------------------------------------------------------------------------------- 
Offset_0x01CBE8:
                dc.w    Offset_0x01CC00-Offset_0x01CBE8
                dc.w    Offset_0x01CC02-Offset_0x01CBE8
                dc.w    Offset_0x01CC0E-Offset_0x01CBE8
                dc.w    Offset_0x01CC30-Offset_0x01CBE8
                dc.w    Offset_0x01CC3C-Offset_0x01CBE8
                dc.w    Offset_0x01CC5E-Offset_0x01CBE8
                dc.w    Offset_0x01CC7C-Offset_0x01CBE8
                dc.w    Offset_0x01CCAA-Offset_0x01CBE8
                dc.w    Offset_0x01CCE2-Offset_0x01CBE8
                dc.w    Offset_0x01CCF4-Offset_0x01CBE8
                dc.w    Offset_0x01CD04-Offset_0x01CBE8
                dc.w    Offset_0x01CD14-Offset_0x01CBE8    
;-------------------------------------------------------------------------------    
Offset_0x01CC00:
                rts      
;------------------------------------------------------------------------------- 
Offset_0x01CC02:
                move.w  #$0040, D1
                moveq   #$00, D0
                move.b  ($FFFFFE68).w, D0
                bra.s   Offset_0x01CC18  
;------------------------------------------------------------------------------- 
Offset_0x01CC0E:
                move.w  #$0080, D1
                moveq   #$00, D0
                move.b  ($FFFFFE7C).w, D0
Offset_0x01CC18:
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01CC24
                neg.w   D0
                add.w   D1, D0
Offset_0x01CC24:
                move.w  Obj_Control_Var_08(A0), D1                       ; $0034
                sub.w   D0, D1
                move.w  D1, Obj_X(A0)                                    ; $0008
                rts     
;------------------------------------------------------------------------------- 
Offset_0x01CC30:
                move.w  #$0040, D1
                moveq   #$00, D0
                move.b  ($FFFFFE68).w, D0
                bra.s   Offset_0x01CC46     
;------------------------------------------------------------------------------- 
Offset_0x01CC3C:
                move.w  #$0080, D1
                moveq   #$00, D0
                move.b  ($FFFFFE7C).w, D0
Offset_0x01CC46:
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01CC52
                neg.w   D0
                add.w   D1, D0
Offset_0x01CC52:
                move.w  Obj_Control_Var_04(A0), D1                       ; $0030
                sub.w   D0, D1
                move.w  D1, Obj_Y(A0)                                    ; $000C
                rts    
;------------------------------------------------------------------------------- 
Offset_0x01CC5E:
                move.b  ($FFFFFE60).w, D0
                lsr.w   #$01, D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$18, D1
                beq.s   Offset_0x01CC7A
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
Offset_0x01CC7A:
                rts    
;------------------------------------------------------------------------------- 
Offset_0x01CC7C:
                move.l  Obj_Y(A0), D3                                    ; $000C
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D3, Obj_Y(A0)                                    ; $000C
                addi.w  #$0008, Obj_Speed_Y(A0)                          ; $0012
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x01CCA8
                move.b  #$00, Obj_Subtype(A0)                            ; $0028
Offset_0x01CCA8:
                rts  
;------------------------------------------------------------------------------- 
Offset_0x01CCAA:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01CCC0
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x01CCE0
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01CCC0:
                bsr     Jmp_0A_To_SpeedToPos                   ; Offset_0x01CDC2
                moveq   #$08, D1
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                addi.w  #$0070, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x01CCD6
                neg.w   D1
Offset_0x01CCD6:
                add.w   D1, Obj_Speed_Y(A0)                              ; $0012
                bne.s   Offset_0x01CCE0
                clr.b   Obj_Subtype(A0)                                  ; $0028
Offset_0x01CCE0:
                rts  
;------------------------------------------------------------------------------- 
Offset_0x01CCE2:
                move.w  #$0010, D1
                moveq   #$00, D0
                move.b  ($FFFFFE88).w, D0
                lsr.w   #$01, D0
                move.w  ($FFFFFE8A).w, D3
                bra.s   Offset_0x01CD22    
;------------------------------------------------------------------------------- 
Offset_0x01CCF4:
                move.w  #$0030, D1
                moveq   #$00, D0
                move.b  ($FFFFFE8C).w, D0
                move.w  ($FFFFFE8E).w, D3
                bra.s   Offset_0x01CD22 
;------------------------------------------------------------------------------- 
Offset_0x01CD04:
                move.w  #$0050, D1
                moveq   #$00, D0
                move.b  ($FFFFFE90).w, D0
                move.w  ($FFFFFE92).w, D3
                bra.s   Offset_0x01CD22   
;------------------------------------------------------------------------------- 
Offset_0x01CD14:
                move.w  #$0070, D1
                moveq   #$00, D0
                move.b  ($FFFFFE94).w, D0
                move.w  ($FFFFFE96).w, D3
Offset_0x01CD22:
                tst.w   D3
                bne.s   Offset_0x01CD30
                addq.b  #$01, Obj_Status(A0)                             ; $0022
                andi.b  #$03, Obj_Status(A0)                             ; $0022
Offset_0x01CD30:
                move.b  Obj_Status(A0), D2                               ; $0022
                andi.b  #$03, D2
                bne.s   Offset_0x01CD50
                sub.w   D1, D0
                add.w   Obj_Control_Var_08(A0), D0                       ; $0034
                move.w  D0, Obj_X(A0)                                    ; $0008
                neg.w   D1
                add.w   Obj_Control_Var_04(A0), D1                       ; $0030
                move.w  D1, Obj_Y(A0)                                    ; $000C
                rts
Offset_0x01CD50:
                subq.b  #$01, D2
                bne.s   Offset_0x01CD6E
                subq.w  #$01, D1
                sub.w   D1, D0
                neg.w   D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
                addq.w  #$01, D1
                add.w   Obj_Control_Var_08(A0), D1                       ; $0034
                move.w  D1, Obj_X(A0)                                    ; $0008
                rts
Offset_0x01CD6E:
                subq.b  #$01, D2
                bne.s   Offset_0x01CD8C
                subq.w  #$01, D1
                sub.w   D1, D0
                neg.w   D0
                add.w   Obj_Control_Var_08(A0), D0                       ; $0034
                move.w  D0, Obj_X(A0)                                    ; $0008
                addq.w  #$01, D1
                add.w   Obj_Control_Var_04(A0), D1                       ; $0030
                move.w  D1, Obj_Y(A0)                                    ; $000C
                rts
Offset_0x01CD8C:
                sub.w   D1, D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
                neg.w   D1
                add.w   Obj_Control_Var_08(A0), D1                       ; $0034
                move.w  D1, Obj_X(A0)                                    ; $0008
                rts              
;-------------------------------------------------------------------------------
CPz_Block_Mappings:                                            ; Offset_0x01CDA2
                dc.w    Offset_0x01CDA4-CPz_Block_Mappings
Offset_0x01CDA4:
                dc.w    $0001
                dc.l    $F00F0000, $0000FFF0
;===============================================================================
; Objeto 0x6B - Plataformas na Metropolis / Blocos na Chemical Plant
; <<<- 
;===============================================================================