;===============================================================================
; Objeto 0x51 - Robotnik na Casino Night
; ->>>
;===============================================================================
; Offset_0x0271CC:
                bsr     Offset_0x0272C0
                moveq   #$00, D0
                move.b  Obj_Boss_Routine(A0), D0                         ; $000A
                move.w  Offset_0x0271DE(PC, D0), D1
                jmp     Offset_0x0271DE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0271DE:
                dc.w    Offset_0x0271E4-Offset_0x0271DE
                dc.w    Offset_0x027384-Offset_0x0271DE
                dc.w    Offset_0x02773C-Offset_0x0271DE     
;-------------------------------------------------------------------------------
Offset_0x0271E4:
                move.l  #CNz_Boss_Mappings, Obj_Map(A0) ; Offset_0x02792C, $0004
                move.w  #$03A7, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.w  #$2850, Obj_X(A0)                                ; $0008
                move.w  #$0600, Obj_Y(A0)                                ; $000C
                move.b  #$00, Obj_Boss_Ani_Map(A0)                       ; $000B
                addq.b  #$02, Obj_Boss_Routine(A0)                       ; $000A
                bset    #$06, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Boss_Hit_2(A0)                         ; $0032
                move.w  Obj_X(A0), (Boss_Move_Buffer).w              ; $FFFFF750; $0008
                move.w  Obj_Y(A0), (Boss_Move_Buffer+$04).w          ; $FFFFF754; $000C
                move.w  Obj_X(A0), CNz_R_Catcher_Pos_X(A0)        ; $0008, $0010
                move.w  Obj_Y(A0), CNz_R_Catcher_Pos_Y(A0)        ; $000C, $0012
                move.b  #$05, Obj_Ani_Boss_Frame(A0)                     ; $0015
                move.w  Obj_X(A0), CNz_Boss_Ship_Pos_X(A0)        ; $0008, $0016
                move.w  Obj_Y(A0), CNz_Boss_Ship_Pos_Y(A0)        ; $000C, $0018
                move.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
                move.w  Obj_X(A0), CNz_Robotnik_Pos_X(A0)         ; $0008, $001C
                move.w  Obj_Y(A0), CNz_Robotnik_Pos_Y(A0)         ; $000C, $001E
                move.b  #$06, Obj_Col_Prop(A0)                           ; $0021
                move.w  Obj_X(A0), CNz_L_Catcher_Pos_X(A0)        ; $0008, $0022
                move.w  Obj_Y(A0), CNz_L_Catcher_Pos_Y(A0)        ; $000C, $0024
                move.b  #$02, Obj_Flip_Angle(A0)                         ; $0027
                move.b  #$02, Obj_Control_Var_0C(A0)                     ; $0038
                move.w  #$E800, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                bsr     Offset_0x027292
                rts
Offset_0x027292:
                lea     (Boss_Animate_Buffer).w, A2                  ; $FFFFF740
                move.b  #$04, (A2)+
                move.b  #$00, (A2)+
                move.b  #$01, (A2)+
                move.b  #$00, (A2)+
                move.b  #$10, (A2)+
                move.b  #$00, (A2)+
                move.b  #$03, (A2)+
                move.b  #$00, (A2)+
                move.b  #$02, (A2)+
                move.b  #$00, (A2)+
                rts
Offset_0x0272C0:
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$03, D0
                beq.s   Offset_0x0272CC
                rts
Offset_0x0272CC:
                lea     ($FFFFFB20).w, A1
                move.w  Obj_Map(A1), D0                                  ; $0004
                move.w  $0006(A1), $0004(A1) 
                move.w  $0008(A1), $0006(A1) 
                move.w  D0, Obj_Map(A1)                                  ; $0004
                move.b  ($FFFFF75E).w, D0
                andi.w  #$007F, D0
                move.w  Offset_0x02730E(PC, D0), CNz_Robotnik_Pos_X(A1)  ; $001C
                move.b  ($FFFFF75E).w, D0
                bmi.s   Offset_0x02731A
                addi.b  #$02, ($FFFFF75E).w
                cmpi.b  #$0C, ($FFFFF75E).w
                blt.s   Offset_0x027334
                move.b  #$88, ($FFFFF75E).w
                bra.s   Offset_0x027334     
;-------------------------------------------------------------------------------
Offset_0x02730E:
                dc.w    $0A0E, $0C0C, $0EA0, $00AE, $00EA, $0AE0  
;-------------------------------------------------------------------------------
Offset_0x02731A:
                andi.b  #$7F, D0
                subi.b  #$02, D0
                bpl.s   Offset_0x02732C
                move.b  #$02, ($FFFFF75E).w
                bra.s   Offset_0x027334
Offset_0x02732C:
                ori.b   #$80, D0
                move.b  D0, ($FFFFF75E).w
Offset_0x027334:
                move.b  ($FFFFF75F).w, D0
                andi.w  #$007F, D0
                move.w  Offset_0x02735E(PC, D0), CNz_Robotnik_Pos_Y(A1)  ; $001E
                move.b  ($FFFFF75F).w, D0
                bmi.s   Offset_0x027368
                addi.b  #$02, ($FFFFF75F).w
                cmpi.b  #$0A, ($FFFFF75F).w
                blt.s   Offset_0x027382
                move.b  #$86, ($FFFFF75F).w
                rts           
;-------------------------------------------------------------------------------
Offset_0x02735E:
                dc.w    $000E, $000C, $000A, $0008, $0006 
;-------------------------------------------------------------------------------
Offset_0x027368:
                andi.b  #$7F, D0
                subi.b  #$02, D0
                bpl.s   Offset_0x02737A
                move.b  #$02, ($FFFFF75F).w
                rts
Offset_0x02737A:
                ori.b   #$80, D0
                move.b  D0, ($FFFFF75F).w
;------------------------------------------------------------------------------- 
Offset_0x027382:               
                rts        
;-------------------------------------------------------------------------------
Offset_0x027384:
                moveq   #$00, D0
                move.b  Obj_Ani_Boss_Routine(A0), D0                     ; $0026
                move.w  Offset_0x027392(PC, D0), D1
                jmp     Offset_0x027392(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x027392:
                dc.w    Offset_0x0273A0-Offset_0x027392
                dc.w    Offset_0x0273BE-Offset_0x027392
                dc.w    Offset_0x0273FC-Offset_0x027392
                dc.w    Offset_0x027464-Offset_0x027392
                dc.w    Offset_0x0274C2-Offset_0x027392
                dc.w    Offset_0x027510-Offset_0x027392
                dc.w    Offset_0x027566-Offset_0x027392    
;-------------------------------------------------------------------------------
Offset_0x0273A0:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                bsr     Offset_0x0275B6
                bsr     Offset_0x02768E
                lea     (CNz_Boss_Animate_Data), A1            ; Offset_0x0278EA
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
;-------------------------------------------------------------------------------
Offset_0x0273BE:
                move.b  Obj_Control_Var_12(A0), D0                       ; $003E
                andi.b  #$01, D0
                beq.s   Offset_0x0273E4
                subi.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                move.b  #$00, Obj_Boss_Ani_Map(A0)                       ; $000B
                addq.b  #$04, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bsr     Offset_0x0274AC
                move.w  #$00DC, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bra.s   Offset_0x0273A0
Offset_0x0273E4:
                addi.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                move.b  #$0C, Obj_Boss_Ani_Map(A0)                       ; $000B
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$00C8, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bra.s   Offset_0x0273A0        
;-------------------------------------------------------------------------------
Offset_0x0273FC:
                subi.w  #$0001, ($FFFFF75C).w
                bmi.s   Offset_0x02744A
                beq.s   Offset_0x027434
                cmpi.w  #$004B, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bne.s   Offset_0x0273A0
Offset_0x02740E:
                move.b  #$20, (Boss_Animate_Buffer+$03).w            ; $FFFFF743
                move.b  #$20, (Boss_Animate_Buffer+$09).w            ; $FFFFF749
                move.b  #$40, (Boss_Animate_Buffer+$01).w            ; $FFFFF741
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0006(A1)
                ori.b   #$05, $0006(A1)
                bra     Offset_0x0273A0
Offset_0x027434:
                move.b  #$00, (Boss_Animate_Buffer+$03).w            ; $FFFFF743
                move.b  #$00, (Boss_Animate_Buffer+$09).w            ; $FFFFF749
                move.b  #$00, (Boss_Animate_Buffer+$01).w            ; $FFFFF741
                bra     Offset_0x0273A0
Offset_0x02744A:
                cmpi.w  #$FFB5, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                beq.s   Offset_0x02740E
                cmpi.w  #$FF6A, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bne     Offset_0x0273A0
                move.b  #$00, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bra.s   Offset_0x027434  
;-------------------------------------------------------------------------------
Offset_0x027464:
                subi.w  #$0001, ($FFFFF75C).w
                bne.s   Offset_0x02748C
                move.b  #$20, (Boss_Animate_Buffer+$03).w            ; $FFFFF743
                move.b  #$20, (Boss_Animate_Buffer+$09).w            ; $FFFFF749
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0006(A1)
                ori.b   #$05, $0006(A1)
                bra     Offset_0x0273A0
Offset_0x02748C:
                cmpi.w  #$FFEC, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt     Offset_0x0273A0
                move.b  #$00, (Boss_Animate_Buffer+$03).w            ; $FFFFF743
                move.b  #$00, (Boss_Animate_Buffer+$09).w            ; $FFFFF749
                move.b  #$00, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bra     Offset_0x0273A0
Offset_0x0274AC:
                bsr     Jmp_0E_To_SingleObjectLoad             ; Offset_0x027A84
                bne.s   Offset_0x0274C0
                move.b  #$51, (A1)
                move.b  #$04, Obj_Boss_Routine(A1)                       ; $000A
                move.l  A0, CNz_R_Catcher_Fall_Y(A1)                     ; $0034
Offset_0x0274C0:
                rts    
;-------------------------------------------------------------------------------
Offset_0x0274C2:
                st      Obj_Control_Var_00(A0)                           ; $002C
                move.b  #$00, ($FFFFEEBD).w
                subq.w  #$01, (Boss_Move_Buffer+$0C).w               ; $FFFFF75C
                bmi.s   Offset_0x0274D8
                bsr     Boss_Defeated                          ; Offset_0x023AEC
                bra.s   Offset_0x0274FC
Offset_0x0274D8:
                move.b  #$0B, Obj_Col_Prop(A0)                           ; $0021
                move.b  #$00, Obj_Boss_Ani_Map(A0)                       ; $000B
                bset    #$00, Obj_Flags(A0)                              ; $0001
                clr.w   (Boss_Move_Buffer+$08).w                     ; $FFFFF758
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$FFEE, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
Offset_0x0274FC:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x02768E
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78  
;-------------------------------------------------------------------------------
Offset_0x027510:
                addq.w  #$01, (Boss_Move_Buffer+$0C).w               ; $FFFFF75C
                beq.s   Offset_0x027520
                bpl.s   Offset_0x027526
                addi.w  #$0018, ($FFFFF75A).w
                bra.s   Offset_0x02754A
Offset_0x027520:
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
                bra.s   Offset_0x02754A
Offset_0x027526:
                cmpi.w  #$0018, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bcs.s   Offset_0x02753E
                beq.s   Offset_0x027546
                cmpi.w  #$0020, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bcs.s   Offset_0x02754A
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bra.s   Offset_0x02754A
Offset_0x02753E:
                subi.w  #$0008, ($FFFFF75A).w
                bra.s   Offset_0x02754A
Offset_0x027546:
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
Offset_0x02754A:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x02768E
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78     
;-------------------------------------------------------------------------------
Offset_0x027566:
                move.w  #$0400, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  #$FFC0, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                cmpi.w  #$2980, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
                beq.s   Offset_0x027580
                addq.w  #$02, (Sonic_Level_Limits_Max_X).w           ; $FFFFEECA
                bra.s   Offset_0x027586
Offset_0x027580:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x0275A2
Offset_0x027586:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x02768E
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
Offset_0x0275A2:
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
                bne.s   Offset_0x0275AE
                move.b  #$01, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
Offset_0x0275AE:
                addq.l  #$04, A7
                jmp     (DeleteObject)                         ; Offset_0x00D314
Offset_0x0275B6:
                moveq   #$00, D0
                move.b  Obj_Control_Var_0C(A0), D0                       ; $0038
                move.w  Offset_0x0275C4(PC, D0), D0
                jmp     Offset_0x0275C4(PC, D0)          
;-------------------------------------------------------------------------------
Offset_0x0275C4:
                dc.w    Offset_0x0275CC-Offset_0x0275C4
                dc.w    Offset_0x0275EE-Offset_0x0275C4
                dc.w    Offset_0x027624-Offset_0x0275C4
                dc.w    Offset_0x02765E-Offset_0x0275C4    
;-------------------------------------------------------------------------------
Offset_0x0275CC:
                cmpi.w  #$2850, (Boss_Move_Buffer).w                 ; $FFFFF750
                blt.s   Offset_0x0275EC
                move.w  #$2850, (Boss_Move_Buffer).w                 ; $FFFFF750
                move.w  #$0000, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  #$FE80, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.b  #$02, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x0275EC:
                rts      
;-------------------------------------------------------------------------------
Offset_0x0275EE:
                cmpi.w  #$05D0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bgt.s   Offset_0x027622
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                cmpi.w  #$05A0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bgt.s   Offset_0x027622
                move.w  #$05A0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                move.w  #$0000, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.w  #$FE80, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.b  #$04, Obj_Control_Var_0C(A0)                     ; $0038
                andi.b  #$7F, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x027622:
                rts    
;-------------------------------------------------------------------------------
Offset_0x027624:
                cmpi.w  #$27C0, (Boss_Move_Buffer).w                 ; $FFFFF750
                bgt.s   Offset_0x02765C
                tst.b   Obj_Control_Var_12(A0)                           ; $003E
                bmi.s   Offset_0x02763C
                ori.b   #$80, Obj_Control_Var_12(A0)                     ; $003E
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
Offset_0x02763C:
                cmpi.w  #$2730, (Boss_Move_Buffer).w                 ; $FFFFF750
                bgt.s   Offset_0x02765C
                move.w  #$2730, (Boss_Move_Buffer).w                 ; $FFFFF750
                move.w  #$0000, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  #$0180, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.b  #$06, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x02765C:
                rts    
;-------------------------------------------------------------------------------
Offset_0x02765E:
                cmpi.w  #$05D0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x02768C
                bset    #$00, Obj_Flags(A0)                              ; $0001
                cmpi.w  #$0600, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x02768C
                move.w  #$0600, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                move.w  #$0000, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.w  #$0180, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.b  #$00, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x02768C:
                rts
Offset_0x02768E:
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  Obj_Y(A0), D1                                    ; $000C
                move.w  D0, CNz_Boss_Ship_Pos_X(A0)                      ; $0016
                move.w  D1, CNz_Boss_Ship_Pos_Y(A0)                      ; $0018
                move.w  D0, CNz_Robotnik_Pos_X(A0)                       ; $001C
                move.w  D1, CNz_Robotnik_Pos_Y(A0)                       ; $001E
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x0276C6
                move.w  D0, CNz_L_Catcher_Pos_X(A0)                      ; $0022
                move.w  D1, CNz_L_Catcher_Pos_Y(A0)                      ; $0024
                move.w  D0, CNz_R_Catcher_Pos_X(A0)                      ; $0010
                move.w  D1, CNz_R_Catcher_Pos_Y(A0)                      ; $0012
                move.w  D1, CNz_L_Catcher_Fall_Y(A0)                     ; $003A
                move.w  D1, CNz_R_Catcher_Fall_Y(A0)                     ; $0034
                rts
Offset_0x0276C6:
                cmpi.w  #$0078, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt.s   Offset_0x02773A
                subi.w  #$0001, CNz_L_Catcher_Pos_X(A0)                  ; $0022
                move.l  CNz_L_Catcher_Fall_Y(A0), D0                     ; $003A
                move.w  CNz_L_Catcher_Pos_Y_1(A0), D1                    ; $002E
                addi.w  #$0038, CNz_L_Catcher_Pos_Y_1(A0)                ; $002E
                ext.l   D1
                asl.l   #$08, D1
                add.l   D1, D0
                move.l  D0, CNz_L_Catcher_Fall_Y(A0)                     ; $003A
                move.w  CNz_L_Catcher_Fall_Y(A0), CNz_L_Catcher_Pos_Y(A0); $0024, $003A
                cmpi.w  #$06F0, CNz_L_Catcher_Pos_Y(A0)                  ; $0024
                blt.s   Offset_0x027700
                move.w  #$0000, CNz_L_Catcher_Pos_Y_1(A0)                ; $002E
Offset_0x027700:
                cmpi.w  #$003C, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt.s   Offset_0x02773A
                addi.w  #$0001, CNz_R_Catcher_Pos_X(A0)                  ; $0010
                move.l  CNz_R_Catcher_Fall_Y(A0), D0                     ; $0034
                move.w  Obj_Control_Var_04(A0), D1                       ; $0030
                addi.w  #$0038, Obj_Control_Var_04(A0)                   ; $0030
                ext.l   D1
                asl.l   #$08, D1
                add.l   D1, D0
                move.l  D0, CNz_R_Catcher_Fall_Y(A0)                     ; $0034
                move.w  CNz_R_Catcher_Fall_Y(A0), CNz_R_Catcher_Pos_Y(A0); $0012, $0034
                cmpi.w  #$06F0, CNz_R_Catcher_Pos_Y(A0)                  ; $0012
                blt.s   Offset_0x02773A
                move.w  #$0000, Obj_Control_Var_04(A0)                   ; $0030
Offset_0x02773A:
                rts         
;-------------------------------------------------------------------------------
Offset_0x02773C:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x02774A(PC, D0), D1
                jmp     Offset_0x02774A(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x02774A:
                dc.w    Offset_0x027754-Offset_0x02774A
                dc.w    Offset_0x0277A2-Offset_0x02774A
                dc.w    Offset_0x0277EE-Offset_0x02774A
                dc.w    Offset_0x027816-Offset_0x02774A
                dc.w    Offset_0x02786A-Offset_0x02774A   
;-------------------------------------------------------------------------------
Offset_0x027754:
                move.l  #CNz_Boss_Mappings, Obj_Map(A0) ; Offset_0x02792C, $0004
                move.w  #$03A7, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$05, Obj_Priority(A0)                           ; $0018
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.l  CNz_R_Catcher_Fall_Y(A0), A1                     ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_X(A1), Obj_Timer(A0)                  ; $0008, $002A
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addi.w  #$0030, Obj_Y(A0)                                ; $000C
                move.b  #$08, CNz_Boss_Ship_Pos_X(A0)                    ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                move.b  #$12, Obj_Map_Id(A0)                             ; $001A
                rts       
;-------------------------------------------------------------------------------
Offset_0x0277A2:
                move.l  CNz_R_Catcher_Fall_Y(A0), A1                     ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_X(A1), Obj_Timer(A0)                  ; $0008, $002A
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.w  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, Obj_Y(A0)                                    ; $000C
                addi.w  #$0001, D0
                cmpi.w  #$002E, D0
                blt.s   Offset_0x0277CE
                move.w  #$002E, D0
Offset_0x0277CE:
                move.w  D0, Obj_Subtype(A0)                              ; $0028
                tst.w   (Boss_Move_Buffer+$0C).w                     ; $FFFFF75C
                bne     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  (Boss_Move_Buffer+$08).w, CNz_R_Catcher_Pos_X(A0)          ; $FFFFF758; $0010
                move.w  #$0258, Obj_Control_Var_04(A0)                   ; $0030
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78  
;-------------------------------------------------------------------------------
Offset_0x0277EE:
                bsr     Offset_0x0278B8
                subi.w  #$0008, CNz_R_Catcher_Pos_X(A0)                  ; $0010
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, CNz_R_Catcher_Pos_Y(A0)                  ; $0012
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78    
;-------------------------------------------------------------------------------
Offset_0x027816:
                subi.w  #$0001, Obj_Control_Var_04(A0)                   ; $0030
                bpl.s   Offset_0x027822
                bra     Jmp_22_To_DeleteObject                 ; Offset_0x027A7E
Offset_0x027822:
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$0F, D0
                bne     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
                bsr     Jmp_04_To_PseudoRandomNumber           ; Offset_0x027A8A
                andi.w  #$0007, D0
                add.w   D0, D0
                move.w  Offset_0x02785A(PC, D0), CNz_R_Catcher_Pos_X(A0) ; $0010
                swap.w  D0
                andi.w  #$0007, D0
                add.w   D0, D0
                move.w  Offset_0x02785A(PC, D0), D0
                bmi.s   Offset_0x02784E
                neg.w   D0
Offset_0x02784E:
                move.w  D0, CNz_R_Catcher_Pos_Y(A0)                      ; $0012
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78    
;-------------------------------------------------------------------------------
Offset_0x02785A:
                dc.w    $0100, $FCE0, $FF40, $0240, $FF80, $0320, $FEE0, $0210  
;-------------------------------------------------------------------------------
Offset_0x02786A:
                subi.w  #$0001, Obj_Control_Var_04(A0)                   ; $0030
                bpl.s   Offset_0x027876
                bra     Jmp_22_To_DeleteObject                 ; Offset_0x027A7E
Offset_0x027876:
                bsr     Offset_0x0278B8
                bsr     Offset_0x02789C
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, CNz_R_Catcher_Pos_Y(A0)                  ; $0012
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra     Jmp_1D_To_DisplaySprite                ; Offset_0x027A78
Offset_0x02789C:
                cmpi.w  #$2700, Obj_X(A0)                                ; $0008
                bgt.s   Offset_0x0278AA
                neg.w   CNz_R_Catcher_Pos_X(A0)                          ; $0010
                rts
Offset_0x0278AA:
                cmpi.w  #$2880, Obj_X(A0)                                ; $0008
                blt.s   Offset_0x0278B6
                neg.w   CNz_R_Catcher_Pos_X(A0)                          ; $0010
Offset_0x0278B6:
                rts
Offset_0x0278B8:
                move.l  Obj_Timer(A0), D2                                ; $002A
                move.l  Obj_Y(A0), D3                                    ; $000C
                move.w  CNz_R_Catcher_Pos_X(A0), D0                      ; $0010
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                move.w  CNz_R_Catcher_Pos_Y(A0), D0                      ; $0012
                addi.w  #$0038, CNz_R_Catcher_Pos_Y(A0)                  ; $0012
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D2, Obj_Timer(A0)                                ; $002A
                move.w  Obj_Timer(A0), Obj_X(A0)                  ; $0008, $002A
                move.l  D3, Obj_Y(A0)                                    ; $000C
                rts                                       
;-------------------------------------------------------------------------------
CNz_Boss_Animate_Data:                                         ; Offset_0x0278EA
                dc.w    Offset_0x0278F8-CNz_Boss_Animate_Data
                dc.w    Offset_0x0278FB-CNz_Boss_Animate_Data
                dc.w    Offset_0x027901-CNz_Boss_Animate_Data
                dc.w    Offset_0x027907-CNz_Boss_Animate_Data
                dc.w    Offset_0x02790B-CNz_Boss_Animate_Data
                dc.w    Offset_0x027915-CNz_Boss_Animate_Data
                dc.w    Offset_0x027920-CNz_Boss_Animate_Data
Offset_0x0278F8:
                dc.b    $0F, $01, $FF
Offset_0x0278FB:
                dc.b    $0F, $04, $FF, $05, $FC, $02
Offset_0x027901:
                dc.b    $0F, $02, $FF, $03, $FC, $02
Offset_0x027907:
                dc.b    $07, $06, $07, $FF
Offset_0x02790B:
                dc.b    $01, $0C, $0D, $0E, $FF, $0F, $10, $11
                dc.b    $FC, $04
Offset_0x027915:
                dc.b    $07, $08, $09, $08, $09, $08, $09, $08
                dc.b    $09, $FD, $03
Offset_0x027920:
                dc.b    $07, $06, $0A, $06, $0A, $06, $0A, $06
                dc.b    $0A, $FD, $03, $00 
;-------------------------------------------------------------------------------
CNz_Boss_Mappings:                                             ; Offset_0x02792C
                dc.w    CNz_Boss_Mappings-CNz_Boss_Mappings
                dc.w    Offset_0x027952-CNz_Boss_Mappings
                dc.w    Offset_0x02797C-CNz_Boss_Mappings
                dc.w    Offset_0x027986-CNz_Boss_Mappings
                dc.w    Offset_0x027990-CNz_Boss_Mappings
                dc.w    Offset_0x02799A-CNz_Boss_Mappings
                dc.w    Offset_0x0279AC-CNz_Boss_Mappings
                dc.w    Offset_0x0279BE-CNz_Boss_Mappings
                dc.w    Offset_0x0279D0-CNz_Boss_Mappings
                dc.w    Offset_0x0279E2-CNz_Boss_Mappings
                dc.w    Offset_0x0279F4-CNz_Boss_Mappings
                dc.w    Offset_0x027A06-CNz_Boss_Mappings
                dc.w    Offset_0x027A18-CNz_Boss_Mappings
                dc.w    Offset_0x027A22-CNz_Boss_Mappings
                dc.w    Offset_0x027A2C-CNz_Boss_Mappings
                dc.w    Offset_0x027A36-CNz_Boss_Mappings
                dc.w    Offset_0x027A48-CNz_Boss_Mappings
                dc.w    Offset_0x027A5A-CNz_Boss_Mappings
                dc.w    Offset_0x027A6C-CNz_Boss_Mappings
Offset_0x027952:
                dc.w    $0005
                dc.l    $F0050024, $00120010
                dc.l    $D80E2060, $2030FFF9
                dc.l    $000F206C, $2036FFD8
                dc.l    $000F207C, $203EFFF8
                dc.l    $0006208C, $20460018
Offset_0x02797C:
                dc.w    $0001
                dc.l    $180620AA, $2055FFE4
Offset_0x027986:
                dc.w    $0001
                dc.l    $100620B0, $2058FFDB
Offset_0x027990:
                dc.w    $0001
                dc.l    $100B2092, $20490008
Offset_0x02799A:
                dc.w    $0002
                dc.l    $1009209E, $204F0008
                dc.l    $100620A4, $20520020
Offset_0x0279AC:
                dc.w    $0002
                dc.l    $F00D0030, $0018FFF0
                dc.l    $F0050028, $0014FFE0
Offset_0x0279BE:
                dc.w    $0002
                dc.l    $F00D0038, $001CFFF0
                dc.l    $F0050028, $0014FFE0
Offset_0x0279D0:
                dc.w    $0002
                dc.l    $F00D0040, $0020FFF0
                dc.l    $F005002C, $0016FFE0
Offset_0x0279E2:
                dc.w    $0002
                dc.l    $F00D0048, $0024FFF0
                dc.l    $F005002C, $0016FFE0
Offset_0x0279F4:
                dc.w    $0002
                dc.l    $F00D0050, $0028FFF0
                dc.l    $F005002C, $0016FFE0
Offset_0x027A06:
                dc.w    $0002
                dc.l    $F00D0058, $002CFFF0
                dc.l    $F005002C, $0016FFE0
Offset_0x027A18:
                dc.w    $0001
                dc.l    $280C20B6, $205BFFF0
Offset_0x027A22:
                dc.w    $0001
                dc.l    $280C20BA, $205DFFF0
Offset_0x027A2C:
                dc.w    $0001
                dc.l    $280C20BE, $205FFFF0
Offset_0x027A36:
                dc.w    $0002
                dc.l    $200C20C2, $2061FFE4
                dc.l    $200C20C6, $20630004
Offset_0x027A48:
                dc.w    $0002
                dc.l    $200C20CA, $2065FFE4
                dc.l    $200C20CE, $20670004
Offset_0x027A5A:
                dc.w    $0002
                dc.l    $200C20D2, $2069FFE4
                dc.l    $200C20D6, $206B0004
Offset_0x027A6C:
                dc.w    $0001
                dc.l    $F40A00DA, $006DFFF4 
;===============================================================================
; Objeto 0x51 - Robotnik na Casino Night
; <<<-
;===============================================================================