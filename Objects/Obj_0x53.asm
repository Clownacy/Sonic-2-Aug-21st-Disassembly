;===============================================================================
; Objeto 0x53 - Bolas e mini Robotniks a partir das bolas na Metropolis
; ->>>
;===============================================================================
; Offset_0x027B80:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x027B8E(PC, D0), D1
                jmp     Offset_0x027B8E(PC, D1) 
;-------------------------------------------------------------------------------
Offset_0x027B8E:
                dc.w    Offset_0x027B96-Offset_0x027B8E
                dc.w    Offset_0x027C08-Offset_0x027B8E
                dc.w    Offset_0x027D1E-Offset_0x027B8E
                dc.w    Offset_0x027D56-Offset_0x027B8E      
;-------------------------------------------------------------------------------
Offset_0x027B96:
                move.l  A0, A1
                moveq   #$06, D3
                moveq   #$00, D2
                bra.s   Offset_0x027BA4     
;-------------------------------------------------------------------------------
Offset_0x027B9E:
                bsr     Jmp_0F_To_SingleObjectLoad             ; Offset_0x027E92
                bne.s   Offset_0x027BFE   
;-------------------------------------------------------------------------------
Offset_0x027BA4:
                move.l  Obj_Control_Var_08(A0), Obj_Control_Var_08(A1); $0034, $0034
                move.b  #$53, (A1)
                move.l  #Mz_Boss_Mappings, Obj_Map(A1)  ; Offset_0x027DAA, $0004
                move.w  #$038C, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                addq.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  #$05, Obj_Map_Id(A1)                             ; $001A
                move.b  Offset_0x027C00(PC, D2), Obj_Player_Flip_Flag(A1); $0029
                cmpi.b  #$02, D2
                ble.s   Offset_0x027BEC
                move.b  #$01, Obj_Control_Var_0E(A1)                     ; $003A
                move.b  #$80, Obj_Subtype(A1)                            ; $0028
                bra.s   Offset_0x027BF8
Offset_0x027BEC:
                move.b  #$00, Obj_Control_Var_0E(A1)                     ; $003A
                move.b  #$00, Obj_Subtype(A1)                            ; $0028
Offset_0x027BF8:
                addq.w  #$01, D2
                dbra    D3, Offset_0x027B9E
Offset_0x027BFE:
                rts
;-------------------------------------------------------------------------------
Offset_0x027C00:
                dc.b    $24, $48, $6C, $70, $4C, $28, $04, $00 
;-------------------------------------------------------------------------------
Offset_0x027C08:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_Y(A1), Obj_Timer(A0)                  ; $000C, $002A
                subi.w  #$0004, Obj_Timer(A0)                            ; $002A
                move.w  Obj_X(A1), Obj_Control_Var_0C(A0)         ; $0008, $0038
                tst.b   Obj_Control_Var_0C(A1)                           ; $0038
                beq.s   Offset_0x027C46
                move.b  #$00, Obj_Control_Var_0C(A1)                     ; $0038
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$FE80, Obj_Speed_Y(A0)                          ; $0012
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                move.b  #$06, Obj_Col_Flags(A0)                          ; $0020
Offset_0x027C46:
                bsr     Offset_0x027C54
                bsr     Offset_0x027CD4
                bra     Jmp_1E_To_DisplaySprite                ; Offset_0x027E8C  
;-------------------------------------------------------------------------------
; Offset_0x027C52:
                rts  
;-------------------------------------------------------------------------------
Offset_0x027C54:
                move.w  Obj_Control_Var_0C(A0), D2                       ; $0038
                move.w  Obj_Timer(A0), D3                                ; $002A
                move.b  Obj_Player_Flip_Flag(A0), D0                     ; $0029
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$0024, D1
                asr.w   #$08, D1
                move.w  D1, Obj_Y(A0)                                    ; $000C
                add.w   D3, Obj_Y(A0)                                    ; $000C
                muls.w  #$0024, D0
                move.l  D0, D5
                move.l  D0, D4
                move.b  Obj_Subtype(A0), D0                              ; $0028
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  D0, D5
                move.l  D5, Obj_Control_Var_00(A0)                       ; $002C
                add.w   D2, Obj_Control_Var_00(A0)                       ; $002C
                muls.w  D1, D4
                move.l  D4, Obj_Control_Var_04(A0)                       ; $0030
                move.w  Obj_Control_Var_00(A0), Obj_X(A0)         ; $0008, $002C
                addq.b  #$04, Obj_Subtype(A0)                            ; $0028
                tst.b   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x027CBA
                subq.b  #$02, Obj_Player_Flip_Flag(A0)                   ; $0029
                bpl.s   Offset_0x027CD2
                move.b  #$02, Obj_Player_Flip_Flag(A0)                   ; $0029
                move.b  #$00, Obj_Control_Var_0E(A0)                     ; $003A
                rts
Offset_0x027CBA:
                addq.b  #$02, Obj_Player_Flip_Flag(A0)                   ; $0029
                cmpi.b  #$82, Obj_Player_Flip_Flag(A0)                   ; $0029
                bne.s   Offset_0x027CD2
                move.b  #$7E, Obj_Player_Flip_Flag(A0)                   ; $0029
                move.b  #$01, Obj_Control_Var_0E(A0)                     ; $003A
Offset_0x027CD2:
                rts
Offset_0x027CD4:
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bmi.s   Offset_0x027CFC
                cmpi.w  #$000C, D0
                blt.s   Offset_0x027CEE
                move.b  #$03, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                rts
Offset_0x027CEE:
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                rts
Offset_0x027CFC:
                cmpi.w  #$FFF4, D0
                blt.s   Offset_0x027D10
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                rts
Offset_0x027D10:
                move.b  #$05, Obj_Map_Id(A0)                             ; $001A
                move.b  #$05, Obj_Priority(A0)                           ; $0018
                rts 
;-------------------------------------------------------------------------------
Offset_0x027D1E:
                bsr     Jmp_0D_To_ObjectFall                   ; Offset_0x027E9E
                subi.w  #$0030, Obj_Speed_Y(A0)                          ; $0012
                cmpi.w  #$0080, Obj_Speed_Y(A0)                          ; $0012
                blt.s   Offset_0x027D36
                move.w  #$0080, Obj_Speed_Y(A0)                          ; $0012
Offset_0x027D36:
                cmpi.w  #$01AC, Obj_Y(A0)                                ; $000C
                blt.s   Offset_0x027D48
                move.w  #$01AC, Obj_Y(A0)                                ; $000C
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x027D48:
                lea     (Mz_Boss_Animate_Data), A1             ; Offset_0x027D88
                bsr     Jmp_16_To_AnimateSprite                ; Offset_0x027E98
                bra     Jmp_1E_To_DisplaySprite                ; Offset_0x027E8C   
;-------------------------------------------------------------------------------
Offset_0x027D56:
                bsr     Offset_0x027D6E
                moveq   #-$01, D0
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x027D66
                neg.w   D0
Offset_0x027D66:
                add.w   D0, Obj_X(A0)                                    ; $0008
                bra     Jmp_1E_To_DisplaySprite                ; Offset_0x027E8C
Offset_0x027D6E:
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                bpl.s   Offset_0x027D80
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                rts
Offset_0x027D80:
                bset    #$00, Obj_Flags(A0)                              ; $0001
                rts                            
;-------------------------------------------------------------------------------
Mz_Boss_Animate_Data:                                          ; Offset_0x027D88
                dc.w    Offset_0x027D8E-Mz_Boss_Animate_Data
                dc.w    Offset_0x027D91-Mz_Boss_Animate_Data
                dc.w    Offset_0x027D95-Mz_Boss_Animate_Data
Offset_0x027D8E:
                dc.b    $0F, $02, $FF
Offset_0x027D91:
                dc.b    $01, $00, $01, $FF
Offset_0x027D95:
                dc.b    $03, $05, $05, $05, $05, $05, $05, $05
                dc.b    $05, $06, $07, $06, $07, $06, $07, $08
                dc.b    $09, $0A, $0B, $FE, $01     
;-------------------------------------------------------------------------------
Mz_Boss_Mappings:                                              ; Offset_0x027DAA
                dc.w    Offset_0x027DC2-Mz_Boss_Mappings
                dc.w    Offset_0x027DCC-Mz_Boss_Mappings
                dc.w    Offset_0x027DD6-Mz_Boss_Mappings
                dc.w    Offset_0x027E18-Mz_Boss_Mappings
                dc.w    Offset_0x027E22-Mz_Boss_Mappings
                dc.w    Offset_0x027E2C-Mz_Boss_Mappings
                dc.w    Offset_0x027E36-Mz_Boss_Mappings
                dc.w    Offset_0x027E40-Mz_Boss_Mappings
                dc.w    Offset_0x027E4A-Mz_Boss_Mappings
                dc.w    Offset_0x027E54-Mz_Boss_Mappings
                dc.w    Offset_0x027E5E-Mz_Boss_Mappings
                dc.w    Offset_0x027E68-Mz_Boss_Mappings
Offset_0x027DC2:
                dc.w    $0001
                dc.l    $00050174, $00BA001C
Offset_0x027DCC:
                dc.w    $0001
                dc.l    $00050178, $00BC001C
Offset_0x027DD6:
                dc.w    $0008
                dc.l    $D8050020, $00100002
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0030, $0018FFF0
                dc.l    $E8050024, $00120010
                dc.l    $F80F0008, $0004FFF0
                dc.l    $F8070018, $000C0010
                dc.l    $F8020060, $0030FFE0
                dc.l    $F8020063, $0031FFE8
Offset_0x027E18:
                dc.w    $0001
                dc.l    $F40A006E, $0037FFF4
Offset_0x027E22:
                dc.w    $0001
                dc.l    $F40A00CF, $0067FFF4
Offset_0x027E2C:
                dc.w    $0001
                dc.l    $F80500D8, $006CFFF8
Offset_0x027E36:
                dc.w    $0001
                dc.l    $F4060077, $003BFFF8
Offset_0x027E40:
                dc.w    $0001
                dc.l    $F809007D, $003EFFF4
Offset_0x027E4A:
                dc.w    $0001
                dc.l    $F4060083, $0041FFF8
Offset_0x027E54:
                dc.w    $0001
                dc.l    $F40A0089, $0044FFF4
Offset_0x027E5E:
                dc.w    $0001
                dc.l    $F00F0092, $0049FFF0
Offset_0x027E68:
                dc.w    $0004
                dc.l    $E80A00A2, $0051FFE8
                dc.l    $E80A00AB, $00550000
                dc.l    $000A00B4, $005AFFE8
                dc.l    $000A00BD, $005E0000 
;===============================================================================
; Objeto 0x53 - Bolas e mini Robotniks a partir das bolas na Metropolis
; <<<-
;===============================================================================