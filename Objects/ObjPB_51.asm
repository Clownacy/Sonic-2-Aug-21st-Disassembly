;===============================================================================
; Objeto 0x51 - Imimigo cavalo marinho (Aquis) na Oil Ocean
; ->>> 
;===============================================================================
; Offset_0x0223C8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0223D6(PC, D0), D1
                jmp     Offset_0x0223D6(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x0223D6:
                dc.w    Offset_0x0223E2-Offset_0x0223D6
                dc.w    Offset_0x022440-Offset_0x0223D6
                dc.w    Offset_0x022464-Offset_0x0223D6      
;------------------------------------------------------------------------------- 
Offset_0x0223DC:
                dc.w    $0000, $FCE0, $FD1C              
;-------------------------------------------------------------------------------  
Offset_0x0223E2:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Aquis_Mappings, Obj_Map(A0)    ; Offset_0x02227C, $0004
                move.w  #$2570, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                move.w  D0, D1
                lsl.w   #$05, D1
                subq.w  #$01, D1
                move.w  D1, Obj_Control_Var_06(A0)                       ; $0032
                move.w  D1, Obj_Control_Var_08(A0)                       ; $0034
                move.w  Obj_Y(A0), Obj_Timer(A0)                  ; $000C, $002A
                move.w  Obj_Y(A0), Obj_Control_Var_02(A0)         ; $000C, $002E
                addi.w  #$0060, Obj_Control_Var_02(A0)                   ; $002E
                move.w  #$FF00, Obj_Speed(A0)                            ; $0010  
;-------------------------------------------------------------------------------  
Offset_0x022440:
                lea     Aquis_Animate_Data(PC), A1             ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                move.w  #$039C, (Water_Level).w                      ; $FFFFF646
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x022460(PC, D0), D1
                jsr     Offset_0x022460(PC, D1)
                bra     Jmp_21_To_MarkObjGone                  ; Offset_0x02261E    
;-------------------------------------------------------------------------------  
Offset_0x022460:
                dc.w    Offset_0x022478-Offset_0x022460
                dc.w    Offset_0x02248E-Offset_0x022460  
;-------------------------------------------------------------------------------     
Offset_0x022464:
                bsr     Offset_0x0221A0
                bsr     Jmp_13_To_SpeedToPos                   ; Offset_0x022630
                lea     Aquis_Animate_Data(PC), A1             ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                bra     Jmp_21_To_MarkObjGone                  ; Offset_0x02261E   
;-------------------------------------------------------------------------------  
Offset_0x022478:
                bsr     Jmp_13_To_SpeedToPos                   ; Offset_0x022630
                bsr     Offset_0x022182
                bsr     Offset_0x0224CA
                bsr     Offset_0x0225AC
                bsr     Offset_0x02251C
                rts          
;-------------------------------------------------------------------------------  
Offset_0x02248E:
                bsr     Jmp_13_To_SpeedToPos                   ; Offset_0x022630
                bsr     Offset_0x022182
                bsr     Offset_0x0224CA
                bsr     Offset_0x0225AC
                bsr     Offset_0x0224A4
                rts
Offset_0x0224A4:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                beq.s   Offset_0x0224B8
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                cmpi.w  #$0012, D0
                beq     Offset_0x022542
                rts
Offset_0x0224B8:
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$00B4, Obj_Control_Var_04(A0)                   ; $0030
                rts
Offset_0x0224CA:
                sf      Obj_Control_Var_01(A0)                           ; $002D
                sf      Obj_Control_Var_00(A0)                           ; $002C
                sf      Obj_Control_Var_0A(A0)                           ; $0036
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                bpl.s   Offset_0x0224EA
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0224F2
                bra.s   Offset_0x0224F6
Offset_0x0224EA:
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0224F6
Offset_0x0224F2:
                st      Obj_Control_Var_00(A0)                           ; $002C
Offset_0x0224F6:
                move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
                sub.w   Obj_Y(A0), D0                                    ; $000C
                cmpi.w  #$FFFC, D0
                blt.s   Offset_0x02251A
                cmpi.w  #$0004, D0
                bgt.s   Offset_0x022516
                st      Obj_Control_Var_01(A0)                           ; $002D
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                rts
Offset_0x022516:
                st      Obj_Control_Var_0A(A0)                           ; $0036
Offset_0x02251A:
                rts
Offset_0x02251C:
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x022540
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bgt.s   Offset_0x022540
                tst.b   Obj_Control_Var_01(A0)                           ; $002D
                beq.s   Offset_0x022540
                move.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0024, Obj_Control_Var_04(A0)                   ; $0030
                addi.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x022540:
                rts
Offset_0x022542:
                bsr     Jmp_0A_To_SingleObjectLoad             ; Offset_0x022618
                bne.s   Offset_0x0225AA
                move.b  #$51, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  #Aquis_Mappings, Obj_Map(A1)    ; Offset_0x02227C, $0004
                move.w  #$24E0, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$E5, Obj_Col_Flags(A1)                          ; $0020
                move.w  #$000C, D0
                move.w  #$0010, D1
                move.w  #$FD00, D2
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x02259E
                neg.w   D1
                neg.w   D2
Offset_0x02259E:
                sub.w   D0, Obj_Y(A1)                                    ; $000C
                sub.w   D1, Obj_X(A1)                                    ; $0008
                move.w  D2, Obj_Speed(A1)                                ; $0010
Offset_0x0225AA:
                rts
Offset_0x0225AC:
                tst.b   Obj_Control_Var_01(A0)                           ; $002D
                bne.s   Offset_0x02260A
                tst.b   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x0225DC
                move.w  Obj_Control_Var_02(A0), D0                       ; $002E
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                ble.s   Offset_0x022600
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                beq.s   Offset_0x0225D4
                move.w  Obj_Timer(A0), D0                                ; $002A
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bge.s   Offset_0x022600
                rts
Offset_0x0225D4:
                move.w  #$0180, Obj_Speed_Y(A0)                          ; $0012
                rts
Offset_0x0225DC:
                move.w  Obj_Timer(A0), D0                                ; $002A
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bge.s   Offset_0x022600
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                beq.s   Offset_0x0225F8
                move.w  Obj_Control_Var_02(A0), D0                       ; $002E
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                ble.s   Offset_0x022600
                rts
Offset_0x0225F8:
                move.w  #$FE80, Obj_Speed_Y(A0)                          ; $0012
                rts
Offset_0x022600:
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x02260A:
                rts
;===============================================================================
; Objeto 0x51 - Imimigo cavalo marinho (Aquis) na Oil Ocean
; <<<- 
;===============================================================================