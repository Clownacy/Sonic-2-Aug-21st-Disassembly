; Configuração dos movimentos do chefe    [$01=Broca (nº2) Diagonal]
;                                         [$02=Broca nave movendo]
;                                         [$03=Broca (nº2) Vertical]
;                                         [$04..$0B=Broca (nº2) Horizontal]
;                                         [$0C=Broca (nº2) Subindo]
; $FFFF742 => Configuração da broca nº 1
; $FFFF748 => Configuração da broca nº 2
; $FFFF750 => Posição da tela
; $FFFF75A => Movimento Cima / Baixo
; $FFFF758 => Movimento Esquerda / Direita
; (A0) + 32 => Contagem de toques no chefe
;===============================================================================
; Objeto 0x57 - Robotnik na Dust Hill
; ->>> 
;=============================================================================== 
; Offset_0x026990:
                moveq   #$00, D0
                move.b  Obj_Boss_Routine(A0), D0                         ; $000A
                move.w  Offset_0x02699E(PC, D0), D1
                jmp     Offset_0x02699E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02699E:
                dc.w    Offset_0x0269A4-Offset_0x02699E
                dc.w    Offset_0x026A92-Offset_0x02699E
                dc.w    Offset_0x026F1C-Offset_0x02699E    
;------------------------------------------------------------------------------- 
Offset_0x0269A4:
                move.l  #DHz_Boss_Mappings, Obj_Map(A0) ; Offset_0x027016, $0004
                move.w  #$03C0, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.w  #$21A0, Obj_X(A0)                                ; $0008
                move.w  #$0678, Obj_Y(A0)                                ; $000C
                move.b  #$05, Obj_Boss_Ani_Map(A0)                       ; $000B
                addq.b  #$02, Obj_Boss_Routine(A0)                       ; $000A
                bset    #$06, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Boss_Hit_2(A0)                         ; $0032
                move.w  Obj_X(A0), (Boss_Move_Buffer).w              ; $FFFFF750; $0008
                move.w  Obj_Y(A0), (Boss_Move_Buffer+$04).w          ; $FFFFF754; $000C
                move.w  #$FF40, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.w  Obj_X(A0), DHz_Front_Drill_Pos_X(A0)      ; $0008, $0010
                move.w  Obj_Y(A0), DHz_Front_Drill_Pos_Y(A0)      ; $000C, $0012
                move.b  #$02, Obj_Ani_Boss_Frame(A0)                     ; $0015
                move.w  Obj_X(A0), DHz_Ship_Boost_Pos_X(A0)       ; $0008, $0016
                move.w  Obj_Y(A0), DHz_Ship_Boost_Pos_Y(A0)       ; $000C, $0018
                move.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
                move.w  Obj_X(A0), DHz_Robotnik_Pos_X(A0)         ; $0008, $001C
                move.w  Obj_Y(A0), DHz_Robotnik_Pos_Y(A0)         ; $000C, $001E
                move.b  #$0E, Obj_Col_Prop(A0)                           ; $0021
                move.w  Obj_X(A0), DHz_Back_Drill_Pos_X(A0)       ; $0008, $0022
                move.w  Obj_Y(A0), DHz_Back_Drill_Pos_Y(A0)       ; $000C, $0024
                move.b  #$02, Obj_Flip_Angle(A0)                         ; $0027
                subi.w  #$0028, DHz_Back_Drill_Pos_X(A0)                 ; $0022
                move.w  #$0028, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                move.w  #$FC80, Obj_Control_Var_02(A0)                   ; $002E
                move.w  #$FC80, Obj_Control_Var_04(A0)                   ; $0030
                bsr     Offset_0x026A64
                rts
Offset_0x026A64:
                lea     (Boss_Animate_Buffer).w, A2                  ; $FFFFF740
                move.b  #$02, (A2)+
                move.b  #$00, (A2)+
                move.b  #$03, (A2)+
                move.b  #$00, (A2)+
                move.b  #$10, (A2)+
                move.b  #$00, (A2)+
                move.b  #$0D, (A2)+
                move.b  #$00, (A2)+
                move.b  #$03, (A2)+
                move.b  #$00, (A2)+
                rts 
;-------------------------------------------------------------------------------
Offset_0x026A92:
                moveq   #$00, D0
                move.b  Obj_Ani_Boss_Routine(A0), D0                     ; $0026
                move.w  Offset_0x026AA0(PC, D0), D1
                jmp     Offset_0x026AA0(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x026AA0:
                dc.w    Offset_0x026AAE-Offset_0x026AA0
                dc.w    Offset_0x026B2A-Offset_0x026AA0
                dc.w    Offset_0x026B9A-Offset_0x026AA0
                dc.w    Offset_0x026C1A-Offset_0x026AA0
                dc.w    Offset_0x026E28-Offset_0x026AA0
                dc.w    Offset_0x026E76-Offset_0x026AA0
                dc.w    Offset_0x026ECC-Offset_0x026AA0   
;-------------------------------------------------------------------------------
Offset_0x026AAE:
                subi.w  #$0001, ($FFFFF75C).w
                bpl.s   Offset_0x026AF6
                bsr     Boss_Move                              ; Offset_0x0245FA
                cmpi.w  #$0560, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bgt.s   Offset_0x026AF6
                move.w  #$0100, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.w  (Player_One_Position_X).w, D3                ; $FFFFB008
                bsr     Jmp_03_To_PseudoRandomNumber           ; Offset_0x0271BE
                andi.w  #$00FF, D0
                ext.w   D0
                add.w   D0, D3
                cmpi.w  #$2100, D3
                bgt.s   Offset_0x026AE4
                move.w  #$2100, D3
                bra.s   Offset_0x026AEE
Offset_0x026AE4:
                cmpi.w  #$2218, D3
                blt.s   Offset_0x026AEE
                move.w  #$2218, D3
Offset_0x026AEE:
                move.w  D3, (Boss_Move_Buffer).w                     ; $FFFFF750
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
Offset_0x026AF6:
                cmpi.w  #$0620, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bge.s   Offset_0x026B08
                move.b  #$01, ($FFFFEEBD).w
                bsr     Offset_0x026DB0
Offset_0x026B08:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x026E0A
                lea     (DHz_Boss_Animate_Data), A1            ; Offset_0x026F34
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC   
;-------------------------------------------------------------------------------
Offset_0x026B2A:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x026DB0
                cmpi.w  #$0620, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x026B78
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0002(A1) 
                ori.b   #$06, $0002(A1) 
                andi.b  #$F0, $0008(A1) 
                ori.b   #$06, $0008(A1) 
                andi.b  #$F0, $0006(A1)
                ori.b   #$0D, $0006(A1)
                move.b  #$30, $0007(A1)
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$00C8, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                move.b  #$00, ($FFFFEEBD).w
Offset_0x026B78:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x026E0A
                lea     (DHz_Boss_Animate_Data), A1            ; Offset_0x026F34
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC     
;-------------------------------------------------------------------------------
Offset_0x026B9A:
                subi.w  #$0001, ($FFFFF75C).w
                bgt.s   Offset_0x026BF8
                bmi.s   Offset_0x026BCA
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                move.b  #$30, Obj_Flags(A1)                              ; $0001
                move.w  #$0400, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   ($FFFFF750).w, D0
                bmi.s   Offset_0x026BCA
                bset    #$00, Obj_Flags(A0)                              ; $0001
Offset_0x026BCA:
                bsr     Boss_Move                              ; Offset_0x0245FA
                cmpi.w  #$0650, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x026BF8
                move.w  #$0650, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$FE00, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  #$0000, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x026BF8
                neg.w   (Boss_Move_Buffer+$08).w                     ; $FFFFF758
Offset_0x026BF8:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x026E0A
                lea     (DHz_Boss_Animate_Data), A1            ; Offset_0x026F34
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC    
;-------------------------------------------------------------------------------
Offset_0x026C1A:
                bsr     Boss_Move                              ; Offset_0x0245FA
                cmpi.w  #$2100, (Boss_Move_Buffer).w                 ; $FFFFF750
                bgt.s   Offset_0x026C2E
                move.w  #$2100, (Boss_Move_Buffer).w                 ; $FFFFF750
                bra.s   Offset_0x026C3C
Offset_0x026C2E:
                cmpi.w  #$2218, (Boss_Move_Buffer).w                 ; $FFFFF750
                blt.s   Offset_0x026C88
                move.w  #$2218, (Boss_Move_Buffer).w                 ; $FFFFF750
Offset_0x026C3C:
                move.w  #$0000, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.b  #$00, Obj_Ani_Boss_Routine(A0)                   ; $0026
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0002(A1) 
                ori.b   #$0B, $0002(A1) 
                andi.b  #$F0, $0008(A1) 
                ori.b   #$0B, $0008(A1) 
                move.b  #$00, $0001(A1) 
                andi.b  #$F0, $0006(A1)
                ori.b   #$0D, $0006(A1)
                move.b  #$30, $0007(A1)
                move.w  #$00C8, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                move.w  #$FF40, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
Offset_0x026C88:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x026E0A
                lea     (DHz_Boss_Animate_Data), A1            ; Offset_0x026F34
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC     
;-------------------------------------------------------------------------------   
; Offset_0x026CAA:
                move.w  (Boss_Move_Buffer).w, D0                     ; $FFFFF750
                subi.w  #$1E00, D0
                bmi.s   Offset_0x026CEC
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x026CD4
                cmpi.w  #$0660, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bgt.s   Offset_0x026CCC
                move.w  #$0660, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bra.s   Offset_0x026CEC
Offset_0x026CCC:
                move.w  #$FF40, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                rts
Offset_0x026CD4:
                cmpi.w  #$0690, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x026CE4
                move.w  #$0690, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bra.s   Offset_0x026CEC
Offset_0x026CE4:
                move.w  #$00C0, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                rts
Offset_0x026CEC:
                move.w  #$0000, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                rts
;-------------------------------------------------------------------------------                
Offset_0x026CF4:
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  Obj_Y(A0), D1                                    ; $000C
                move.w  D0, DHz_Ship_Boost_Pos_X(A0)                     ; $0016
                move.w  D1, DHz_Ship_Boost_Pos_Y(A0)                     ; $0018
                move.w  D0, DHz_Robotnik_Pos_X(A0)                       ; $001C
                move.w  D1, DHz_Robotnik_Pos_Y(A0)                       ; $001E
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x026D42
                move.w  D0, DHz_Back_Drill_Pos_X(A0)                     ; $0022
                move.w  D1, DHz_Back_Drill_Pos_Y(A0)                     ; $0024
                move.w  D0, DHz_Front_Drill_Pos_X(A0)                    ; $0010
                move.w  D1, DHz_Front_Drill_Pos_Y(A0)                    ; $0012
                move.w  D1, Obj_Control_Var_0E(A0)                       ; $003A
                move.w  D1, Obj_Control_Var_08(A0)                       ; $0034
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x026D3A
                addi.w  #$0028, DHz_Back_Drill_Pos_X(A0)                 ; $0022
                rts
Offset_0x026D3A:
                subi.w  #$0028, DHz_Back_Drill_Pos_X(A0)                 ; $0022
                rts
Offset_0x026D42:
                cmpi.w  #$0078, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt.s   Offset_0x026DAE
                subi.w  #$0001, DHz_Back_Drill_Pos_X(A0)                 ; $0022
                move.l  Obj_Control_Var_0E(A0), D0                       ; $003A
                move.w  Obj_Control_Var_02(A0), D1                       ; $002E
                addi.w  #$0038, Obj_Control_Var_02(A0)                   ; $002E
                ext.l   D1
                asl.l   #$08, D1
                add.l   D1, D0
                move.l  D0, Obj_Control_Var_0E(A0)                       ; $003A
                move.w  Obj_Control_Var_0E(A0), DHz_Back_Drill_Pos_Y(A0); $0024, $003A
                cmpi.w  #$06F0, DHz_Back_Drill_Pos_Y(A0)                 ; $0024
                blt.s   Offset_0x026D7C
                move.w  #$0000, Obj_Control_Var_02(A0)                   ; $002E
Offset_0x026D7C:
                addi.w  #$0001, DHz_Front_Drill_Pos_X(A0)                ; $0010
                move.l  Obj_Control_Var_08(A0), D0                       ; $0034
                move.w  Obj_Control_Var_04(A0), D1                       ; $0030
                addi.w  #$0038, Obj_Control_Var_04(A0)                   ; $0030
                ext.l   D1
                asl.l   #$08, D1
                add.l   D1, D0
                move.l  D0, Obj_Control_Var_08(A0)                       ; $0034
                move.w  Obj_Control_Var_08(A0), DHz_Front_Drill_Pos_Y(A0); $0012, $0034
                cmpi.w  #$06F0, DHz_Front_Drill_Pos_Y(A0)                ; $0012
                blt.s   Offset_0x026DAE
                move.w  #$0000, Obj_Control_Var_04(A0)                   ; $0030
Offset_0x026DAE:
                rts
Offset_0x026DB0:
                move.b  ($FFFFFE0F).w, D1
                andi.w  #$0007, D1
                bne.s   Offset_0x026E08
Offset_0x026DBA:
                bsr     Jmp_03_To_PseudoRandomNumber           ; Offset_0x0271BE
                swap.w  D1
                andi.w  #$01FF, D1
                addi.w  #$20F0, D1
                cmpi.w  #$2228, D1
                bgt.s   Offset_0x026DBA
                bsr     Jmp_0D_To_SingleObjectLoad             ; Offset_0x0271B8
                bne.s   Offset_0x026E08
                move.b  #$57, (A1)
                move.b  #$04, Obj_Boss_Routine(A1)                       ; $000A
                move.w  D1, Obj_X(A1)                                    ; $0008
                move.w  #$05F0, Obj_Y(A1)                                ; $000C
                move.l  #DHz_Boss_Mappings, Obj_Map(A1) ; Offset_0x027016, $0004
                move.w  #$0560, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$0D, Obj_Map_Id(A1)                             ; $001A
Offset_0x026E08:
                rts
Offset_0x026E0A:
                bsr     Boss_Hit                               ; Offset_0x02459E
                cmpi.b  #$1F, Obj_Inertia(A0)                            ; $0014
                bne.s   Offset_0x026E26
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0006(A1)
                ori.b   #$0E, $0006(A1)
Offset_0x026E26:
                rts   
;------------------------------------------------------------------------------- 
Offset_0x026E28:
                st      Obj_Control_Var_00(A0)                           ; $002C
                move.b  #$00, ($FFFFEEBD).w
                subq.w  #$01, (Boss_Move_Buffer+$0C).w               ; $FFFFF75C
                bmi.s   Offset_0x026E3E
                bsr     Boss_Defeated                          ; Offset_0x023AEC
                bra.s   Offset_0x026E62
Offset_0x026E3E:
                move.b  #$07, Obj_Boss_Ani_Map(A0)                       ; $000B
                move.b  #$13, Obj_Col_Prop(A0)                           ; $0021
                bset    #$00, Obj_Flags(A0)                              ; $0001
                clr.w   (Boss_Move_Buffer+$08).w                     ; $FFFFF758
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$FFEE, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
Offset_0x026E62:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC             
;------------------------------------------------------------------------------- 
Offset_0x026E76:
                addq.w  #$01, (Boss_Move_Buffer+$0C).w               ; $FFFFF75C
                beq.s   Offset_0x026E86
                bpl.s   Offset_0x026E8C
                addi.w  #$0018, ($FFFFF75A).w
                bra.s   Offset_0x026EB0
Offset_0x026E86:
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
                bra.s   Offset_0x026EB0
Offset_0x026E8C:
                cmpi.w  #$0018, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bcs.s   Offset_0x026EA4
                beq.s   Offset_0x026EAC
                cmpi.w  #$0020, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bcs.s   Offset_0x026EB0
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bra.s   Offset_0x026EB0
Offset_0x026EA4:
                subi.w  #$0008, ($FFFFF75A).w
                bra.s   Offset_0x026EB0
Offset_0x026EAC:
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
Offset_0x026EB0:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC     
;------------------------------------------------------------------------------- 
Offset_0x026ECC:
                move.w  #$0400, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  #$FFC0, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                cmpi.w  #$2180, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
                beq.s   Offset_0x026EE6
                addq.w  #$02, (Sonic_Level_Limits_Max_X).w           ; $FFFFEECA
                bra.s   Offset_0x026EEC
Offset_0x026EE6:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x026F08
Offset_0x026EEC:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)   ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)       ; $FFFFF750; $0008
                bsr     Offset_0x026CF4
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC
Offset_0x026F08:
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
                bne.s   Offset_0x026F14
                move.b  #$01, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
Offset_0x026F14:
                addq.l  #$04, A7
                jmp     (DeleteObject)                         ; Offset_0x00D314 
;------------------------------------------------------------------------------- 
Offset_0x026F1C:
                bsr     Jmp_0C_To_ObjectFall                   ; Offset_0x0271C4
                subi.w  #$0014, DHz_Front_Drill_Pos_Y(A0)                ; $0012
                cmpi.w  #$06F0, Obj_Y(A0)                                ; $000C
                bgt     Jmp_21_To_DeleteObject                 ; Offset_0x0271B2
                bra     Jmp_1C_To_DisplaySprite                ; Offset_0x0271AC         
;-------------------------------------------------------------------------------
DHz_Boss_Animate_Data:                                         ; Offset_0x026F34
                dc.w    Offset_0x026F54-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F57-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F5A-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F61-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F72-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F83-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F8A-DHz_Boss_Animate_Data
                dc.w    Offset_0x026F9C-DHz_Boss_Animate_Data
                dc.w    Offset_0x026FAD-DHz_Boss_Animate_Data
                dc.w    Offset_0x026FBE-DHz_Boss_Animate_Data
                dc.w    Offset_0x026FCF-DHz_Boss_Animate_Data
                dc.w    Offset_0x026FD6-DHz_Boss_Animate_Data
                dc.w    Offset_0x026FE8-DHz_Boss_Animate_Data
                dc.w    Offset_0x026FFA-DHz_Boss_Animate_Data
                dc.w    Offset_0x027007-DHz_Boss_Animate_Data
                dc.w    Offset_0x027012-DHz_Boss_Animate_Data
Offset_0x026F54:
                dc.b    $0F, $01, $FF
Offset_0x026F57:
                dc.b    $05, $08, $FF
Offset_0x026F5A:
                dc.b    $01, $05, $06, $FF, $07, $FC, $03
Offset_0x026F61:
                dc.b    $01, $02, $02, $02, $02, $02, $03, $03
                dc.b    $03, $03, $03, $04, $04, $04, $04, $FD
                dc.b    $04
Offset_0x026F72:
                dc.b    $01, $02, $02, $02, $02, $03, $03, $03
                dc.b    $04, $04, $04, $02, $02, $03, $03, $FD
                dc.b    $05
Offset_0x026F83:
                dc.b    $01, $04, $02, $03, $04, $FC, $01
Offset_0x026F8A:
                dc.b    $01, $02, $03, $04, $04, $02, $02, $03
                dc.b    $03, $03, $04, $04, $04, $02, $02, $02
                dc.b    $FD, $07
Offset_0x026F9C:
                dc.b    $01, $02, $03, $03, $03, $03, $04, $04
                dc.b    $04, $04, $04, $02, $08, $08, $08, $FD
                dc.b    $08
Offset_0x026FAD:
                dc.b    $01, $09, $09, $09, $09, $09, $0A, $0A
                dc.b    $0A, $0A, $0A, $0B, $0B, $0B, $0B, $FD
                dc.b    $09
Offset_0x026FBE:
                dc.b    $01, $09, $09, $09, $09, $0A, $0A, $0A
                dc.b    $0B, $0B, $0B, $09, $09, $0A, $0A, $FD
                dc.b    $0A
Offset_0x026FCF:
                dc.b    $01, $0B, $09, $0A, $0B, $FC, $01
Offset_0x026FD6:
                dc.b    $01, $09, $0A, $0B, $0B, $09, $09, $0A
                dc.b    $0A, $0A, $0B, $0B, $0B, $09, $09, $09
                dc.b    $FD, $0C
Offset_0x026FE8:
                dc.b    $01, $09, $0A, $0A, $0A, $0A, $0B, $0B
                dc.b    $0B, $0B, $0B, $09, $08, $08, $08, $08
                dc.b    $FD, $03
Offset_0x026FFA:
                dc.b    $07, $0E, $0F, $FF, $10, $11, $10, $11
                dc.b    $10, $11, $10, $11, $FF
Offset_0x027007:
                dc.b    $07, $0E, $12, $0E, $12, $0E, $12, $0E
                dc.b    $12, $FD, $0D
Offset_0x027012:
                dc.b    $0F, $0C, $FF, $00     
;-------------------------------------------------------------------------------    
DHz_Boss_Mappings:                                             ; Offset_0x027016
                dc.w    DHz_Boss_Mappings-DHz_Boss_Mappings
                dc.w    Offset_0x02703E-DHz_Boss_Mappings
                dc.w    Offset_0x027068-DHz_Boss_Mappings
                dc.w    Offset_0x02707A-DHz_Boss_Mappings
                dc.w    Offset_0x02708C-DHz_Boss_Mappings
                dc.w    Offset_0x02709E-DHz_Boss_Mappings
                dc.w    Offset_0x0270B0-DHz_Boss_Mappings
                dc.w    Offset_0x0270C2-DHz_Boss_Mappings
                dc.w    Offset_0x0270CC-DHz_Boss_Mappings
                dc.w    Offset_0x0270F6-DHz_Boss_Mappings
                dc.w    Offset_0x027108-DHz_Boss_Mappings
                dc.w    Offset_0x02711A-DHz_Boss_Mappings
                dc.w    Offset_0x02712C-DHz_Boss_Mappings
                dc.w    Offset_0x027136-DHz_Boss_Mappings
                dc.w    Offset_0x027140-DHz_Boss_Mappings
                dc.w    Offset_0x027152-DHz_Boss_Mappings
                dc.w    Offset_0x027164-DHz_Boss_Mappings
                dc.w    Offset_0x027176-DHz_Boss_Mappings
                dc.w    Offset_0x027188-DHz_Boss_Mappings
                dc.w    Offset_0x02719A-DHz_Boss_Mappings
Offset_0x02703E:
                dc.w    $0005
                dc.l    $F80F2148, $20A4FFF0
                dc.l    $F8072158, $20AC0010
                dc.l    $E8050164, $00B20010
                dc.l    $F80A2000, $2000FFD8
                dc.l    $D8090021, $0010FFF8
Offset_0x027068:
                dc.w    $0002
                dc.l    $D0072027, $2013000C
                dc.l    $F00B203F, $201F0008
Offset_0x02707A:
                dc.w    $0002
                dc.l    $D007202F, $2017000C
                dc.l    $F00B204B, $20250008
Offset_0x02708C:
                dc.w    $0002
                dc.l    $D0072037, $201B000C
                dc.l    $F00B2057, $202B0008
Offset_0x02709E:
                dc.w    $0002
                dc.l    $12080012, $0009FFF8
                dc.l    $1A080015, $000AFFF8
Offset_0x0270B0:
                dc.w    $0002
                dc.l    $12080012, $0009FFF8
                dc.l    $1A0A0018, $000CFFF8
Offset_0x0270C2:
                dc.w    $0001
                dc.l    $12080012, $0009FFF8
Offset_0x0270CC:
                dc.w    $0005
                dc.l    $E0092063, $2031FFF8
                dc.l    $F0012069, $20340000
                dc.l    $F00F206B, $20350008
                dc.l    $F802207B, $203D0028
                dc.l    $1004207E, $203F0018
Offset_0x0270F6:
                dc.w    $0002
                dc.l    $FC0D2080, $2040FFF0
                dc.l    $F80E2098, $204C0010
Offset_0x027108:
                dc.w    $0002
                dc.l    $FC0D2088, $2044FFF0
                dc.l    $F80E20A4, $20520010
Offset_0x02711A:
                dc.w    $0002
                dc.l    $FC0D2090, $2048FFF0
                dc.l    $F80E20B0, $20580010
Offset_0x02712C:
                dc.w    $0001
                dc.l    $F00F40BC, $405EFFF0
Offset_0x027136:
                dc.w    $0001
                dc.l    $F8054000, $4000FFF8
Offset_0x027140:
                dc.w    $0002
                dc.l    $E80D0170, $00B8FFF0
                dc.l    $E8050168, $00B4FFE0
Offset_0x027152:
                dc.w    $0002
                dc.l    $E80D0178, $00BCFFF0
                dc.l    $E8050168, $00B4FFE0
Offset_0x027164:
                dc.w    $0002
                dc.l    $E80D0180, $00C0FFF0
                dc.l    $E805016C, $00B6FFE0
Offset_0x027176:
                dc.w    $0002
                dc.l    $E80D0188, $00C4FFF0
                dc.l    $E805016C, $00B6FFE0
Offset_0x027188:
                dc.w    $0002
                dc.l    $E80D0190, $00C8FFF0
                dc.l    $E805016C, $00B6FFE0
Offset_0x02719A:
                dc.w    $0002
                dc.l    $E80D0198, $00CCFFF0
                dc.l    $E805016C, $00B6FFE0 
;===============================================================================
; Objeto 0x57 - Robotnik na Dust Hill
; <<<-
;===============================================================================