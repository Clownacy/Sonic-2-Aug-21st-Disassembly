;===============================================================================
; Objeto 0x5D - ???
; ->>> 
;===============================================================================
; Offset_0x024394:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0243A2(PC, D0), D1
                jmp     Offset_0x0243A2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0243A2:
                dc.w    Offset_0x0243B0-Offset_0x0243A2
                dc.w    Offset_0x0244A0-Offset_0x0243A2
                dc.w    Offset_0x024620-Offset_0x0243A2
                dc.w    Offset_0x02464E-Offset_0x0243A2
                dc.w    Offset_0x024A12-Offset_0x0243A2      
                dc.w    Offset_0x0243A2-Offset_0x0243A2
                dc.w    Offset_0x0246FA-Offset_0x0243A2                             
;------------------------------------------------------------------------------- 
Offset_0x0243B0:
                move.l  #Offset_0x024AB4, Obj_Map(A0)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Boss_Hit(A0)                           ; $0021
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  Obj_X(A0), (Boss_Move_Buffer).w              ; $FFFFF750; $0008
                move.w  Obj_Y(A0), (Boss_Move_Buffer+$04).w          ; $FFFFF754; $000C
                move.b  #$10, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                bsr     Jmp_2D_To_ModifySpriteAttr_2P          ; Offset_0x02584C
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x02449E
                move.b  #$5D, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  A1, Obj_Control_Var_08(A0)                       ; $0034
                move.l  #Offset_0x024AB4, Obj_Map(A1)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                bsr     Jmp_07_To_ModifySpriteAttr_2P_A1       ; Offset_0x025840
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x02449E
                move.b  #$5D, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  #Offset_0x024DAE, Obj_Map(A1)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
Offset_0x02449E:
                rts  
;-------------------------------------------------------------------------------
Offset_0x0244A0:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0244AE(PC, D0), D1
                jmp     Offset_0x0244AE(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x0244AE:
                dc.w    Offset_0x0244B6-Offset_0x0244AE
                dc.w    Offset_0x0244EC-Offset_0x0244AE
                dc.w    Offset_0x024514-Offset_0x0244AE
                dc.w    Offset_0x024564-Offset_0x0244AE  
;-------------------------------------------------------------------------------      
Offset_0x0244B6:
                move.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
                bsr     Boss_Move                              ; Offset_0x0245FA
                cmpi.w  #$0400, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bne.s   Offset_0x0244DE
                move.w  #$0400, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bsr     Offset_0x024A54
Offset_0x0244DE:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)   ; $FFFFF754, $000C
                bsr     Offset_0x024580
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834  
;-------------------------------------------------------------------------------
Offset_0x0244EC:
                bclr    #$04, Obj_Control_Var_00(A0)                     ; $002C
                beq.s   Offset_0x02450C
                addi.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$FF00, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x024508
                neg.w   D0
Offset_0x024508:
                move.w  D0, Obj_Speed(A0)                                ; $0010
Offset_0x02450C:
                bsr     Offset_0x024580
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834  
;-------------------------------------------------------------------------------
Offset_0x024514:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                bsr     Offset_0x024526
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x024526:
                btst    #$05, Obj_Control_Var_00(A0)                     ; $002C
                bne.s   Offset_0x024552
                move.w  Obj_X(A0), D0                                    ; $0008
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x024546
                addi.w  #$0034, D0
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bpl.s   Offset_0x024552
                rts
Offset_0x024546:
                subi.w  #$0034, D0
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bmi.s   Offset_0x024552
                rts
Offset_0x024552:
                bset    #$01, Obj_Control_Var_00(A0)                     ; $002C
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                rts    
;-------------------------------------------------------------------------------
Offset_0x024564:
                btst    #$04, Obj_Control_Var_00(A0)                     ; $002C
                beq.s   Offset_0x024576
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra     Offset_0x0244EC
Offset_0x024576:
                bsr     Offset_0x024580
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x024580:
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                jsr     (CalcSine)                             ; Offset_0x003282
                asr.w   #$06, D0
                add.w   (Boss_Move_Buffer+$04).w, D0                 ; $FFFFF754
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                addq.b  #$02, Obj_Map_Id(A0)                             ; $001A
;-------------------------------------------------------------------------------                
Boss_Hit:     ; Referenciado por chefe da Hill Top             ; Offset_0x02459E                
                cmpi.b  #$08, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bcc.s   Offset_0x0245E4
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                beq.s   Offset_0x0245E6
                tst.b   Obj_Col_Flags(A0)                                ; $0020
                bne.s   Offset_0x0245E4
                tst.b   Obj_Inertia(A0)                                  ; $0014
                bne.s   Offset_0x0245C8
                move.b  #$20, Obj_Inertia(A0)                            ; $0014
                move.w  #$00AC, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x0245C8:
                lea     ($FFFFFB22).w, A1
                moveq   #$00, D0
                tst.w   (A1)
                bne.s   Offset_0x0245D6
                move.w  #$0EEE, D0
Offset_0x0245D6:
                move.w  D0, (A1)
                subq.b  #$01, Obj_Inertia(A0)                            ; $0014
                bne.s   Offset_0x0245E4
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
Offset_0x0245E4:
                rts
Offset_0x0245E6:
                moveq   #$64, D0
                bsr     Jmp_02_To_AddPoints                    ; Offset_0x025846
                move.w  #$00B3, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                move.b  #$08, Obj_Ani_Boss_Routine(A0)                   ; $0026
                rts
;-------------------------------------------------------------------------------    
Boss_Move:                                                     ; Offset_0x0245FA
                move.l  (Boss_Move_Buffer).w, D2                     ; $FFFFF750
                move.l  (Boss_Move_Buffer+$04).w, D3                 ; $FFFFF754
                move.w  (Boss_Move_Buffer+$08).w, D0                 ; $FFFFF758
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                move.w  (Boss_Move_Buffer+$0A).w, D0                 ; $FFFFF75A
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D2, (Boss_Move_Buffer).w                     ; $FFFFF750
                move.l  D3, (Boss_Move_Buffer+$04).w                 ; $FFFFF754
                rts  
;-------------------------------------------------------------------------------
Offset_0x024620:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                move.l  #Offset_0x024AA2, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322 
;-------------------------------------------------------------------------------
Offset_0x02464E:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x024678(PC, D0), D1
                jmp     Offset_0x024678(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x024678:
                dc.w    Offset_0x02467E-Offset_0x024678
                dc.w    Offset_0x0246AA-Offset_0x024678
                dc.w    Offset_0x0246CE-Offset_0x024678       
;------------------------------------------------------------------------------- 
Offset_0x02467E:
                bclr    #$00, Obj_Control_Var_00(A1)                     ; $002C
                beq     Jmp_19_To_DisplaySprite                ; Offset_0x025834
                bset    #$02, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                addi.b  #$02, Obj_Routine_2(A0)                          ; $0025
                lea     (Offset_0x024D80), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834     
;-------------------------------------------------------------------------------
Offset_0x0246AA:
                bclr    #$01, Obj_Control_Var_00(A1)                     ; $002C
                beq.s   Offset_0x0246BE
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                bset    #$03, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x0246BE:
                lea     (Offset_0x024D80), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834  
;-------------------------------------------------------------------------------
Offset_0x0246CE:
                addq.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
                andi.b  #$03, Obj_Control_Var_00(A1)                     ; $002C
                bne.s   Offset_0x0246E6
                move.l  A0, A2
                move.l  A1, A0
                bsr     Offset_0x024A54
                move.l  A2, A0
                bra.s   Offset_0x0246EA
Offset_0x0246E6:
                bsr     Offset_0x024964
Offset_0x0246EA:
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834                                
;-------------------------------------------------------------------------------
Offset_0x0246FA:
                move.l  Obj_X(A0), D5                                    ; $0008
                move.l  Obj_Y(A0), D6                                    ; $000C
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x02472C(PC, D0), D1
                jmp     Offset_0x02472C(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x02472C:
                dc.w    Offset_0x02473C-Offset_0x02472C
                dc.w    Offset_0x02474E-Offset_0x02472C
                dc.w    Offset_0x02477E-Offset_0x02472C
                dc.w    Offset_0x0247AE-Offset_0x02472C
                dc.w    Offset_0x0247BC-Offset_0x02472C
                dc.w    Offset_0x02481A-Offset_0x02472C
                dc.w    Offset_0x02492C-Offset_0x02472C
                dc.w    Offset_0x02480A-Offset_0x02472C  
;-------------------------------------------------------------------------------
Offset_0x02473C:
                move.l  #Offset_0x024F76, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322   
;-------------------------------------------------------------------------------
Offset_0x02474E:
                bset    #$00, Obj_Control_Var_00(A1)                     ; $002C
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bmi.s   Offset_0x02476E
                bset    #$00, Obj_Status(A1)                             ; $0022
                bset    #$00, Obj_Flags(A1)                              ; $0001
                bra     Jmp_1E_To_DeleteObject                 ; Offset_0x02583A
Offset_0x02476E:
                bclr    #$00, Obj_Status(A1)                             ; $0022
                bclr    #$00, Obj_Flags(A1)                              ; $0001
                bra     Jmp_1E_To_DeleteObject                 ; Offset_0x02583A                 
;-------------------------------------------------------------------------------
Offset_0x02477E:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                ble.s   Offset_0x024788
                rts
Offset_0x024788:
                bclr    #$02, Obj_Control_Var_00(A1)                     ; $002C
                beq.s   Offset_0x024796
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
Offset_0x024796:
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.l  #Offset_0x024F76, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x0247AE:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bset    #$04, Obj_Control_Var_00(A1)                     ; $002C
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834             
;-------------------------------------------------------------------------------
Offset_0x0247BC:
                bclr    #$03, Obj_Control_Var_00(A1)                     ; $002C
                beq     Jmp_19_To_DisplaySprite                ; Offset_0x025834
                move.w  #$000B, Obj_Timer(A0)                            ; $002A
                move.w  #$0400, Obj_Speed_Y(A0)                          ; $0012
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$0C, Obj_Width_2(A0)                            ; $0017
                move.b  #$1A, Obj_Col_Flags(A0)                          ; $0020
                subi.w  #$0018, Obj_Y(A0)                                ; $000C
                move.w  #$0034, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0247F8
                neg.w   D0
Offset_0x0247F8:
                sub.w   D0, Obj_X(A0)                                    ; $0008
                addi.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                rts          
;-------------------------------------------------------------------------------
Offset_0x02480A:
                move.l  #Offset_0x024F76, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834     
;-------------------------------------------------------------------------------
Offset_0x02481A:
                move.l  D5, Obj_X(A0)                                    ; $0008
                move.l  D6, Obj_Y(A0)                                    ; $000C
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                ble.s   Offset_0x02482C
                rts
Offset_0x02482C:
                bclr    #$05, Obj_Control_Var_00(A1)                     ; $002C
                beq.s   Offset_0x024842
                move.b  #$0E, Obj_Routine_2(A0)                          ; $0025
                move.b  #$04, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x02480A
Offset_0x024842:
                bsr     Jmp_18_To_SpeedToPos                   ; Offset_0x025858
                cmpi.w  #$0460, Obj_Y(A0)                                ; $000C
                bgt     Jmp_1E_To_DeleteObject                 ; Offset_0x02583A
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x024866
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                bra.s   Offset_0x024878
Offset_0x024866:
                move.l  #Offset_0x024F76, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x024878:
                moveq   #$02, D2
                move.l  A0, A1
                addi.w  #$0008, Obj_Y(A1)                                ; $000C
                bra.s   Offset_0x02488E   
;-------------------------------------------------------------------------------   
Offset_0x024884:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x024926             
;------------------------------------------------------------------------------- 
Offset_0x02488E:
                move.b  #$5D, Obj_Id(A1)                                 ; $0000
                move.l  #Offset_0x02500C, Obj_Map(A1)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$0C, Obj_Routine(A1)                            ; $0024
                move.b  #$0C, Obj_Routine_2(A1)                          ; $0025
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.l  Obj_Control_Var_08(A0), Obj_Control_Var_08(A1); $0034, $0034
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.b   #$04, D1
                ext.w   D1
                add.w   D1, Obj_X(A1)                                    ; $0008
                asr.b   #$04, D0
                bset    #$02, D0
                ext.w   D0
                asl.w   #$06, D0
                move.w  D0, Obj_Speed_Y(A1)                              ; $0012
                swap.w  D0
                asr.b   #$04, D0
                bset    #$02, D0
                ext.w   D0
                asl.w   #$06, D0
                move.w  D0, Obj_Speed(A1)                                ; $0010
                move.b  #$1A, Obj_Map_Id(A1)                             ; $001A
                move.b  #$04, Obj_Height_2(A1)                           ; $0016
                move.b  #$04, Obj_Width_2(A1)                            ; $0017
                move.b  #$18, Obj_Col_Flags(A1)                          ; $0020
                move.w  #$005A, Obj_Timer(A1)                            ; $002A
                dbra    D2, Offset_0x024884
Offset_0x024926:
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x02492C:
                move.l  D5, Obj_X(A0)                                    ; $0008
                move.l  D6, Obj_Y(A0)                                    ; $000C
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bmi     Jmp_1E_To_DeleteObject                 ; Offset_0x02583A
                bsr     Jmp_0B_To_ObjectFall                   ; Offset_0x025852
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl     Jmp_19_To_DisplaySprite                ; Offset_0x025834
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  Obj_Speed_Y(A0), D0                              ; $0012
                lsr.b   #$01, D0
                move.b  D0, Obj_Speed_Y(A0)                              ; $0012
                neg.w   Obj_Speed_Y(A0)                                  ; $0012
                bra     Jmp_19_To_DisplaySprite                ; Offset_0x025834
Offset_0x024964:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x0249B2
                move.b  #$5D, Obj_Id(A1)                                 ; $0000
                move.l  Obj_Control_Var_08(A0), Obj_Control_Var_08(A1); $0034, $0034
                move.l  #Offset_0x02500C, Obj_Map(A1)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$0C, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
Offset_0x0249B2:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x024A10
                move.b  #$5D, Obj_Id(A1)                                 ; $0000
                move.l  Obj_Control_Var_08(A0), Obj_Control_Var_08(A1); $0034, $0034
                move.l  #Offset_0x02500C, Obj_Map(A1)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$0C, Obj_Routine(A1)                            ; $0024
                move.b  #$04, Obj_Routine_2(A1)                          ; $0025
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.w  #$0018, Obj_Timer(A1)                            ; $002A
                move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
Offset_0x024A10:
                rts
Offset_0x024A12:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x024A20(PC, D0), D1
                jmp     Offset_0x024A20(PC, D1)       
;-------------------------------------------------------------------------------
Offset_0x024A20:
                dc.w    Offset_0x024A24-Offset_0x024A20
                dc.w    Offset_0x024A4C-Offset_0x024A20          
;-------------------------------------------------------------------------------
Offset_0x024A24:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                move.l  #Offset_0x025234, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x024A4C:
                bsr     Offset_0x024964
                bra     Jmp_1E_To_DeleteObject                 ; Offset_0x02583A
Offset_0x024A54:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x024AA0
                move.b  #$5D, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  #Offset_0x0252B2, Obj_Map(A1)                    ; $0004
                move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$08, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
Offset_0x024AA0:
                rts                            
;-------------------------------------------------------------------------------
Offset_0x024AA2:
                dc.w    Offset_0x024AA6-Offset_0x024AA2
                dc.w    Offset_0x024AB0-Offset_0x024AA2
Offset_0x024AA6:
                dc.b    $01, $00, $01, $00, $02, $03, $04, $03
                dc.b    $05, $FF
Offset_0x024AB0:
                dc.b    $0F, $10, $FF, $00              
;-------------------------------------------------------------------------------
Offset_0x024AB4:
                dc.w    Offset_0x024AD6-Offset_0x024AB4
                dc.w    Offset_0x024AF8-Offset_0x024AB4
                dc.w    Offset_0x024B22-Offset_0x024AB4
                dc.w    Offset_0x024B4C-Offset_0x024AB4
                dc.w    Offset_0x024B6E-Offset_0x024AB4
                dc.w    Offset_0x024B98-Offset_0x024AB4
                dc.w    Offset_0x024BC2-Offset_0x024AB4
                dc.w    Offset_0x024BE4-Offset_0x024AB4
                dc.w    Offset_0x024C0E-Offset_0x024AB4
                dc.w    Offset_0x024C38-Offset_0x024AB4
                dc.w    Offset_0x024C5A-Offset_0x024AB4
                dc.w    Offset_0x024C84-Offset_0x024AB4
                dc.w    Offset_0x024CAE-Offset_0x024AB4
                dc.w    Offset_0x024CD0-Offset_0x024AB4
                dc.w    Offset_0x024CFA-Offset_0x024AB4
                dc.w    Offset_0x024D24-Offset_0x024AB4
                dc.w    Offset_0x024D46-Offset_0x024AB4
Offset_0x024AD6:
                dc.w    $0004
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0030, $0018FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x024AF8:
                dc.w    $0005
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0030, $0018FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D0, $0068001C
Offset_0x024B22:
                dc.w    $0005
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0030, $0018FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D4, $006A001C
Offset_0x024B4C:
                dc.w    $0004
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0038, $001CFFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x024B6E:
                dc.w    $0005
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0038, $001CFFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D0, $0068001C
Offset_0x024B98:
                dc.w    $0005
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0038, $001CFFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D4, $006A001C
Offset_0x024BC2:
                dc.w    $0004
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0040, $0020FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x024BE4:
                dc.w    $0005
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0040, $0020FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D0, $0068001C
Offset_0x024C0E:
                dc.w    $0005
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0040, $0020FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D4, $006A001C
Offset_0x024C38:
                dc.w    $0004
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0048, $0024FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x024C5A:
                dc.w    $0005
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0048, $0024FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D0, $0068001C
Offset_0x024C84:
                dc.w    $0005
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0048, $0024FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D4, $006A001C
Offset_0x024CAE:
                dc.w    $0004
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0050, $0028FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x024CD0:
                dc.w    $0005
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0050, $0028FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D0, $0068001C
Offset_0x024CFA:
                dc.w    $0005
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0050, $0028FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
                dc.l    $000500D4, $006A001C
Offset_0x024D24:
                dc.w    $0004
                dc.l    $E805002C, $0016FFE0
                dc.l    $E80D0058, $002CFFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x024D46:
                dc.w    $0007
                dc.l    $F8052000, $2000FFE0
                dc.l    $08052004, $2002FFE0
                dc.l    $F80F2008, $2004FFF0
                dc.l    $F8072018, $200C0010
                dc.l    $B80D2060, $2030FFF8
                dc.l    $C80A2068, $20340008
                dc.l    $E0052071, $20380010
;-------------------------------------------------------------------------------
Offset_0x024D80:
                dc.w    Offset_0x024D88-Offset_0x024D80
                dc.w    Offset_0x024D8B-Offset_0x024D80
                dc.w    Offset_0x024D99-Offset_0x024D80
                dc.w    Offset_0x024DA5-Offset_0x024D80
Offset_0x024D88:
                dc.b    $0F, $00, $FF
Offset_0x024D8B:
                dc.b    $02, $00, $00, $00, $00, $00, $01, $02
                dc.b    $03, $04, $05, $06, $FE, $01
Offset_0x024D99:
                dc.b    $03, $07, $08, $09, $0A, $0A, $0A, $0A
                dc.b    $0B, $0B, $FD, $03
Offset_0x024DA5:
                dc.b    $02, $06, $05, $04, $03, $02, $01, $FA
                dc.b    $00        
;-------------------------------------------------------------------------------   
Offset_0x024DAE:
                dc.w    Offset_0x024DC6-Offset_0x024DAE
                dc.w    Offset_0x024DD8-Offset_0x024DAE
                dc.w    Offset_0x024DF2-Offset_0x024DAE
                dc.w    Offset_0x024E0C-Offset_0x024DAE
                dc.w    Offset_0x024E26-Offset_0x024DAE
                dc.w    Offset_0x024E48-Offset_0x024DAE
                dc.w    Offset_0x024E6A-Offset_0x024DAE
                dc.w    Offset_0x024E8C-Offset_0x024DAE
                dc.w    Offset_0x024EBE-Offset_0x024DAE
                dc.w    Offset_0x024EF0-Offset_0x024DAE
                dc.w    Offset_0x024F22-Offset_0x024DAE
                dc.w    Offset_0x024F4C-Offset_0x024DAE
Offset_0x024DC6:
                dc.w    $0002
                dc.l    $C80E2075, $203AFFF0
                dc.l    $E0082089, $2044FFF0
Offset_0x024DD8:
                dc.w    $0003
                dc.l    $C80E2075, $203AFFE8
                dc.l    $E0082089, $2044FFE8
                dc.l    $D0082081, $20400000
Offset_0x024DF2:
                dc.w    $0003
                dc.l    $C80E2075, $203AFFE0
                dc.l    $E0082089, $2044FFE0
                dc.l    $D0082081, $2040FFF8
Offset_0x024E0C:
                dc.w    $0003
                dc.l    $C80E2075, $203AFFD8
                dc.l    $E0082089, $2044FFD8
                dc.l    $D0082081, $2040FFF0
Offset_0x024E26:
                dc.w    $0004
                dc.l    $C80E2075, $203AFFD0
                dc.l    $E0082089, $2044FFD0
                dc.l    $D0082081, $2040FFE8
                dc.l    $D0082081, $20400000
Offset_0x024E48:
                dc.w    $0004
                dc.l    $C80E2075, $203AFFC8
                dc.l    $E0082089, $2044FFC8
                dc.l    $D0082081, $2040FFE0
                dc.l    $D0082081, $2040FFF8
Offset_0x024E6A:
                dc.w    $0004
                dc.l    $C80E2075, $203AFFC0
                dc.l    $E0082089, $2044FFC0
                dc.l    $D0082081, $2040FFD8
                dc.l    $D0082081, $2040FFF0
Offset_0x024E8C:
                dc.w    $0006
                dc.l    $C80E2075, $203AFFC0
                dc.l    $D0082081, $2040FFD8
                dc.l    $D0082081, $2040FFF0
                dc.l    $E008208C, $2046FFC0
                dc.l    $CC0B609E, $604FFFC0
                dc.l    $E0042092, $2049FFBC
Offset_0x024EBE:
                dc.w    $0006
                dc.l    $C80E2075, $203AFFC0
                dc.l    $D0082081, $2040FFD8
                dc.l    $D0082081, $2040FFF0
                dc.l    $E008208C, $2046FFC0
                dc.l    $D00B609E, $604FFFC0
                dc.l    $E0042092, $2049FFBC
Offset_0x024EF0:
                dc.w    $0006
                dc.l    $C80E2075, $203AFFC0
                dc.l    $D0082081, $2040FFD8
                dc.l    $D0082081, $2040FFF0
                dc.l    $E008208F, $2047FFC8
                dc.l    $D40B609E, $604FFFC0
                dc.l    $E0042094, $204AFFBC
Offset_0x024F22:
                dc.w    $0005
                dc.l    $C80E2075, $203AFFC0
                dc.l    $D0082081, $2040FFD8
                dc.l    $D0082081, $2040FFF0
                dc.l    $E008208F, $2047FFC8
                dc.l    $E0042094, $204AFFBC
Offset_0x024F4C:
                dc.w    $0005
                dc.l    $C80E2075, $203AFFC0
                dc.l    $D0082081, $2040FFD8
                dc.l    $D0082081, $2040FFF0
                dc.l    $E008208C, $2046FFC0
                dc.l    $E0042092, $2049FFBC
;-------------------------------------------------------------------------------  
Offset_0x024F76:
                dc.w    Offset_0x024F80-Offset_0x024F76
                dc.w    Offset_0x024FBA-Offset_0x024F76
                dc.w    Offset_0x024FF0-Offset_0x024F76
                dc.w    Offset_0x024FFD-Offset_0x024F76
                dc.w    Offset_0x025001-Offset_0x024F76
Offset_0x024F80:
                dc.b    $03, $00, $01, $02, $03, $04, $05, $00
                dc.b    $01, $02, $03, $04, $05, $00, $01, $02
                dc.b    $03, $04, $05, $00, $01, $02, $03, $04
                dc.b    $05, $00, $01, $02, $03, $04, $00, $01
                dc.b    $02, $03, $04, $00, $01, $02, $03, $04
                dc.b    $00, $01, $02, $03, $04, $00, $01, $02
                dc.b    $03, $00, $01, $02, $00, $01, $02, $00
                dc.b    $01, $FA
Offset_0x024FBA:
                dc.b    $03, $06, $06, $06, $06, $06, $06, $07
                dc.b    $07, $07, $07, $07, $07, $08, $08, $08
                dc.b    $08, $08, $08, $09, $09, $09, $09, $09
                dc.b    $0A, $0A, $0A, $0A, $0A, $0B, $0B, $0B
                dc.b    $0B, $0B, $0C, $0C, $0C, $0C, $0C, $0D
                dc.b    $0D, $0D, $0D, $0E, $0E, $0E, $0F, $0F
                dc.b    $0F, $10, $10, $11, $FE, $01
Offset_0x024FF0:
                dc.b    $02, $11, $11, $11, $11, $11, $12, $13
                dc.b    $14, $15, $16, $17, $FA
Offset_0x024FFD:
                dc.b    $01, $18, $19, $FF
Offset_0x025001:
                dc.b    $03, $1B, $1B, $1C, $1C, $1D, $1D, $1D
                dc.b    $1D, $1D, $FF      
;-------------------------------------------------------------------------------    
Offset_0x02500C:
                dc.w    Offset_0x025048-Offset_0x02500C
                dc.w    Offset_0x025052-Offset_0x02500C
                dc.w    Offset_0x02505C-Offset_0x02500C
                dc.w    Offset_0x025066-Offset_0x02500C
                dc.w    Offset_0x025070-Offset_0x02500C
                dc.w    Offset_0x02507A-Offset_0x02500C
                dc.w    Offset_0x025084-Offset_0x02500C
                dc.w    Offset_0x02508E-Offset_0x02500C
                dc.w    Offset_0x025098-Offset_0x02500C
                dc.w    Offset_0x0250A2-Offset_0x02500C
                dc.w    Offset_0x0250AC-Offset_0x02500C
                dc.w    Offset_0x0250BE-Offset_0x02500C
                dc.w    Offset_0x0250D0-Offset_0x02500C
                dc.w    Offset_0x0250E2-Offset_0x02500C
                dc.w    Offset_0x0250F4-Offset_0x02500C
                dc.w    Offset_0x02510E-Offset_0x02500C
                dc.w    Offset_0x025128-Offset_0x02500C
                dc.w    Offset_0x025142-Offset_0x02500C
                dc.w    Offset_0x02515C-Offset_0x02500C
                dc.w    Offset_0x025176-Offset_0x02500C
                dc.w    Offset_0x025190-Offset_0x02500C
                dc.w    Offset_0x0251AA-Offset_0x02500C
                dc.w    Offset_0x0251C4-Offset_0x02500C
                dc.w    Offset_0x0251DE-Offset_0x02500C
                dc.w    Offset_0x0251F8-Offset_0x02500C
                dc.w    Offset_0x025202-Offset_0x02500C
                dc.w    Offset_0x02520C-Offset_0x02500C
                dc.w    Offset_0x025216-Offset_0x02500C
                dc.w    Offset_0x025220-Offset_0x02500C
                dc.w    Offset_0x02522A-Offset_0x02500C
Offset_0x025048:
                dc.w    $0001
                dc.l    $C4006096, $604BFFFB
Offset_0x025052:
                dc.w    $0001
                dc.l    $C4006097, $604BFFFB
Offset_0x02505C:
                dc.w    $0001
                dc.l    $C4006098, $604CFFFB
Offset_0x025066:
                dc.w    $0001
                dc.l    $C4016099, $604CFFFB
Offset_0x025070:
                dc.w    $0001
                dc.l    $C401609B, $604DFFFB
Offset_0x02507A:
                dc.w    $0001
                dc.l    $D400609D, $604EFFFB
Offset_0x025084:
                dc.w    $0001
                dc.l    $D70860C3, $6061FFF0
Offset_0x02508E:
                dc.w    $0001
                dc.l    $D80860C6, $6063FFF0
Offset_0x025098:
                dc.w    $0001
                dc.l    $D80860C9, $6064FFF0
Offset_0x0250A2:
                dc.w    $0001
                dc.l    $D80860CC, $6066FFF0
Offset_0x0250AC:
                dc.w    $0002
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860C3, $6061FFF0
Offset_0x0250BE:
                dc.w    $0002
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860C6, $6063FFF0
Offset_0x0250D0:
                dc.w    $0002
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860C9, $6064FFF0
Offset_0x0250E2:
                dc.w    $0002
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860CC, $6066FFF0
Offset_0x0250F4:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860CC, $6066FFF0
                dc.l    $C80860C3, $6061FFF0
Offset_0x02510E:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860CC, $6066FFF0
                dc.l    $C80860C6, $6063FFF0
Offset_0x025128:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860CC, $6066FFF0
                dc.l    $C80860C9, $6064FFF0
Offset_0x025142:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFF0
                dc.l    $D00860CC, $6066FFF0
                dc.l    $C80860CC, $6066FFF0
Offset_0x02515C:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFE8
                dc.l    $D00860CC, $6066FFE8
                dc.l    $C80860CC, $6066FFE8
Offset_0x025176:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFE0
                dc.l    $D00860CC, $6066FFE0
                dc.l    $C80860CC, $6066FFE0
Offset_0x025190:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFD8
                dc.l    $D00860CC, $6066FFD8
                dc.l    $C80860CC, $6066FFD8
Offset_0x0251AA:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFD0
                dc.l    $D00860CC, $6066FFD0
                dc.l    $C80860CC, $6066FFD0
Offset_0x0251C4:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFC8
                dc.l    $D00860CC, $6066FFC8
                dc.l    $C80860CC, $6066FFC8
Offset_0x0251DE:
                dc.w    $0003
                dc.l    $D80860CC, $6066FFC0
                dc.l    $D00860CC, $6066FFC0
                dc.l    $C80860CC, $6066FFC0
Offset_0x0251F8:
                dc.w    $0001
                dc.l    $F00B609E, $604FFFF4
Offset_0x025202:
                dc.w    $0001
                dc.l    $F00B689E, $684FFFF4
Offset_0x02520C:
                dc.w    $0001
                dc.l    $FC00609D, $604EFFFC
Offset_0x025216:
                dc.w    $0001
                dc.l    $F40A004A, $0025FFF4
Offset_0x025220:
                dc.w    $0001
                dc.l    $F80D0053, $0029FFF0
Offset_0x02522A:
                dc.w    $0001
                dc.l    $F80D005B, $002DFFF0           
;-------------------------------------------------------------------------------
Offset_0x025234:
                dc.w    Offset_0x02523A-Offset_0x025234
                dc.w    Offset_0x025245-Offset_0x025234
                dc.w    Offset_0x0252A8-Offset_0x025234
Offset_0x02523A:
                dc.b    $02, $00, $01, $02, $03, $04, $05, $06
                dc.b    $07, $FD, $01
Offset_0x025245:
                dc.b    $03, $08, $09, $08, $0A, $0B, $0A, $0C
                dc.b    $0D, $0C, $0E, $0F, $0E, $10, $11, $10
                dc.b    $12, $13, $12, $14, $15, $14, $16, $17
                dc.b    $16, $08, $09, $08, $0A, $0B, $0A, $0C
                dc.b    $0D, $0C, $0E, $0F, $0E, $10, $11, $10
                dc.b    $12, $13, $12, $14, $15, $14, $16, $17
                dc.b    $16, $08, $09, $08, $0A, $0B, $0A, $0C
                dc.b    $0D, $0C, $0E, $0F, $0E, $10, $11, $10
                dc.b    $12, $13, $12, $14, $15, $14, $16, $17
                dc.b    $16, $08, $09, $08, $0A, $0B, $0A, $0C
                dc.b    $0D, $0C, $0E, $0F, $0E, $10, $11, $10
                dc.b    $12, $13, $12, $14, $15, $14, $16, $17
                dc.b    $16, $FD, $02
Offset_0x0252A8:
                dc.b    $02, $07, $06, $05, $04, $03, $02, $01
                dc.b    $00, $FA              
;-------------------------------------------------------------------------------   
Offset_0x0252B2:
                dc.w    Offset_0x0252E2-Offset_0x0252B2
                dc.w    Offset_0x0252EC-Offset_0x0252B2
                dc.w    Offset_0x0252FE-Offset_0x0252B2
                dc.w    Offset_0x025318-Offset_0x0252B2
                dc.w    Offset_0x02533A-Offset_0x0252B2
                dc.w    Offset_0x025364-Offset_0x0252B2
                dc.w    Offset_0x025396-Offset_0x0252B2
                dc.w    Offset_0x0253D0-Offset_0x0252B2
                dc.w    Offset_0x025412-Offset_0x0252B2
                dc.w    Offset_0x025454-Offset_0x0252B2
                dc.w    Offset_0x025496-Offset_0x0252B2
                dc.w    Offset_0x0254D8-Offset_0x0252B2
                dc.w    Offset_0x02551A-Offset_0x0252B2
                dc.w    Offset_0x02555C-Offset_0x0252B2
                dc.w    Offset_0x02559E-Offset_0x0252B2
                dc.w    Offset_0x0255E0-Offset_0x0252B2
                dc.w    Offset_0x025622-Offset_0x0252B2
                dc.w    Offset_0x025664-Offset_0x0252B2
                dc.w    Offset_0x0256A6-Offset_0x0252B2
                dc.w    Offset_0x0256E8-Offset_0x0252B2
                dc.w    Offset_0x02572A-Offset_0x0252B2
                dc.w    Offset_0x02576C-Offset_0x0252B2
                dc.w    Offset_0x0257AE-Offset_0x0252B2
                dc.w    Offset_0x0257F0-Offset_0x0252B2
Offset_0x0252E2:
                dc.w    $0001
                dc.l    $10002084, $20420000
Offset_0x0252EC:
                dc.w    $0002
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
Offset_0x0252FE:
                dc.w    $0003
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
Offset_0x025318:
                dc.w    $0004
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
Offset_0x02533A:
                dc.w    $0005
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
Offset_0x025364:
                dc.w    $0006
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
Offset_0x025396:
                dc.w    $0007
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
Offset_0x0253D0:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x025412:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48042085, $2042FFF9
Offset_0x025454:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48042087, $2043FFFA
Offset_0x025496:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40042085, $2042FFF9
                dc.l    $48002084, $20420000
Offset_0x0254D8:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40042087, $2043FFFA
                dc.l    $48002084, $20420000
Offset_0x02551A:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38042085, $2042FFF9
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x02555C:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38042087, $2043FFFA
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x02559E:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30042085, $2042FFF9
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x0255E0:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30042087, $2043FFFA
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x025622:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28042085, $2042FFF9
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x025664:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28042087, $2043FFFA
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x0256A6:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20042085, $2042FFF9
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x0256E8:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18002084, $20420000
                dc.l    $20042087, $2043FFFA
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x02572A:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18042085, $2042FFF9
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x02576C:
                dc.w    $0008
                dc.l    $10002084, $20420000
                dc.l    $18042087, $2043FFFA
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x0257AE:
                dc.w    $0008
                dc.l    $10042085, $2042FFF9
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
Offset_0x0257F0:
                dc.w    $0008
                dc.l    $10042087, $2043FFFA
                dc.l    $18002084, $20420000
                dc.l    $20002084, $20420000
                dc.l    $28002084, $20420000
                dc.l    $30002084, $20420000
                dc.l    $38002084, $20420000
                dc.l    $40002084, $20420000
                dc.l    $48002084, $20420000
;===============================================================================
; Objeto 0x5D - ???
; <<<- 
;===============================================================================