;===============================================================================
; Objeto 0x09 - Sonic no Special Stage - Left over do Sonic 1
; ->>>
;===============================================================================
; Offset_0x02BF70:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Player_In_SS_Normal                    ; Offset_0x02BF7E
                bsr     S1SS_FixCamera                         ; Offset_0x02C1A6
                bra     Debug_Mode                             ; Offset_0x02DE64
;-------------------------------------------------------------------------------                
Player_In_SS_Normal:                                           ; Offset_0x02BF7E
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Player_In_SS_Idx(PC, D0), D1           ; Offset_0x02BF8C
                jmp     Player_In_SS_Idx(PC, D1)               ; Offset_0x02BF8C        
;-------------------------------------------------------------------------------
Player_In_SS_Idx:                                              ; Offset_0x02BF8C
                dc.w    Player_In_SS_Main-Player_In_SS_Idx      ; Offset_0x02BF94
                dc.w    Player_In_SS_Control-Player_In_SS_Idx   ; Offset_0x02BFD4
                dc.w    Player_In_SS_Animate-Player_In_SS_Idx   ; Offset_0x02C1D0
                dc.w    Player_In_SS_Exit_Test-Player_In_SS_Idx ; Offset_0x02C224
;-------------------------------------------------------------------------------
Player_In_SS_Main:                                             ; Offset_0x02BF94
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.l  #Sonic_Mappings, Obj_Map(A0)    ; Offset_0x06FBE0, $0004
                move.w  #$0780, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_32_To_ModifySpriteAttr_2P          ; Offset_0x02C614
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$00, Obj_Priority(A0)                           ; $0018
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                bset    #$02, Obj_Status(A0)                             ; $0022
                bset    #$01, Obj_Status(A0)                             ; $0022  
;-------------------------------------------------------------------------------                   
Player_In_SS_Control:                                          ; Offset_0x02BFD4
                tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
                beq.s   Offset_0x02BFE8
                btst    #$04, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Offset_0x02BFE8
                move.w  #$0001, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
Offset_0x02BFE8:
                move.b  #$00, Obj_P_Invunerblt_Time(A0)                  ; $0030
                moveq   #$00, D0
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.w  #$0002, D0
                move.w  Player_In_SS_Modes(PC, D0), D1         ; Offset_0x02C00C
                jsr     Player_In_SS_Modes(PC, D1)             ; Offset_0x02C00C
                jsr     (Load_Sonic_Dynamic_PLC)               ; Offset_0x0110D4
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Player_In_SS_Modes:                                            ; Offset_0x02C00C
                dc.w    Player_In_SS_OnWall-Player_In_SS_Modes ; Offset_0x02C010
                dc.w    Player_In_SS_InAir-Player_In_SS_Modes  ; Offset_0x02C01E       
;-------------------------------------------------------------------------------
Player_In_SS_OnWall:                                           ; Offset_0x02C010
                bsr     Player_In_SS_Jump                      ; Offset_0x02C146
                bsr     Player_In_SS_Move                      ; Offset_0x02C050
                bsr     Player_In_SS_Fall                      ; Offset_0x02C246
                bra.s   Player_In_SS_Display                   ; Offset_0x02C02A       
;-------------------------------------------------------------------------------
Player_In_SS_InAir                                             ; Offset_0x02C01E
                bsr     Player_In_SS_Null                      ; Offset_0x02C18A
                bsr     Player_In_SS_Move                      ; Offset_0x02C050
                bsr     Player_In_SS_Fall                      ; Offset_0x02C246      
;-------------------------------------------------------------------------------
Player_In_SS_Display:                                          ; Offset_0x02C02A
                bsr     Player_In_SS_ChkItems                  ; Offset_0x02C342
                bsr     Player_In_SS_ChkItems2                 ; Offset_0x02C47E
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                bsr     S1SS_FixCamera                         ; Offset_0x02C1A6
                move.w  (Boss_Move_Buffer).w, D0                     ; $FFFFF750
                add.w   (Boss_Move_Buffer+$02).w, D0                 ; $FFFFF752
                move.w  D0, (Boss_Move_Buffer).w                     ; $FFFFF750
                jsr     (Sonic_Animate)                        ; Offset_0x010BF2
                rts
;-------------------------------------------------------------------------------                
Player_In_SS_Move:                                             ; Offset_0x02C050
                btst    #$02, ($FFFFF602).w
                beq.s   Offset_0x02C05C
                bsr     Player_In_SS_MoveLeft                  ; Offset_0x02C0E8
Offset_0x02C05C:
                btst    #$03, ($FFFFF602).w
                beq.s   Offset_0x02C068
                bsr     Player_In_SS_MoveRight                 ; Offset_0x02C118
Offset_0x02C068:
                move.b  ($FFFFF602).w, D0
                andi.b  #$0C, D0
                bne.s   Offset_0x02C098
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x02C098
                bmi.s   Offset_0x02C08A
                subi.w  #$000C, D0
                bcc.s   Offset_0x02C084
                move.w  #$0000, D0
Offset_0x02C084:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                bra.s   Offset_0x02C098
Offset_0x02C08A:
                addi.w  #$000C, D0
                bcc.s   Offset_0x02C094
                move.w  #$0000, D0
Offset_0x02C094:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
Offset_0x02C098:
                move.b  (Boss_Move_Buffer).w, D0                     ; $FFFFF750
                addi.b  #$20, D0
                andi.b  #$C0, D0
                neg.b   D0
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  Obj_Inertia(A0), D1                              ; $0014
                add.l   D1, Obj_X(A0)                                    ; $0008
                muls.w  Obj_Inertia(A0), D0                              ; $0014
                add.l   D0, Obj_Y(A0)                                    ; $000C
                movem.l D0/D1, -(A7)
                move.l  Obj_Y(A0), D2                                    ; $000C
                move.l  Obj_X(A0), D3                                    ; $0008
                bsr     Player_In_SS_Sub                       ; Offset_0x02C2D8
                beq.s   Offset_0x02C0E2
                movem.l (A7)+, D0/D1
                sub.l   D1, Obj_X(A0)                                    ; $0008
                sub.l   D0, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                rts
Offset_0x02C0E2:
                movem.l (A7)+, D0/D1
                rts
;-------------------------------------------------------------------------------                
Player_In_SS_MoveLeft:                                         ; Offset_0x02C0E8
                bset    #$00, Obj_Status(A0)                             ; $0022
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x02C0F6
                bpl.s   Offset_0x02C10A
Offset_0x02C0F6:
                subi.w  #$000C, D0
                cmpi.w  #$F800, D0
                bgt.s   Offset_0x02C104
                move.w  #$F800, D0
Offset_0x02C104:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                rts
Offset_0x02C10A:
                subi.w  #$0040, D0
                bcc.s   Offset_0x02C112
                nop
Offset_0x02C112:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                rts
;-------------------------------------------------------------------------------                
Player_In_SS_MoveRight:                                        ; Offset_0x02C118
                bclr    #$00, Obj_Status(A0)                             ; $0022
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bmi.s   Offset_0x02C138
                addi.w  #$000C, D0
                cmpi.w  #$0800, D0
                blt.s   Offset_0x02C132
                move.w  #$0800, D0
Offset_0x02C132:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                bra.s   Offset_0x02C144
Offset_0x02C138:
                addi.w  #$0040, D0
                bcc.s   Offset_0x02C140
                nop
Offset_0x02C140:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
Offset_0x02C144:
                rts  
;-------------------------------------------------------------------------------  
Player_In_SS_Jump:                                             ; Offset_0x02C146
                move.b  ($FFFFF603).w, D0
                andi.b  #$70, D0
                beq.s   Offset_0x02C188
                move.b  (Boss_Move_Buffer).w, D0                     ; $FFFFF750
                andi.b  #$FC, D0
                neg.b   D0
                subi.b  #$40, D0
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$0680, D1
                asr.l   #$08, D1
                move.w  D1, Obj_Speed(A0)                                ; $0010
                muls.w  #$0680, D0
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                bset    #$01, Obj_Status(A0)                             ; $0022
                move.w  #$00A0, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02C188:
                rts       
;-------------------------------------------------------------------------------
Player_In_SS_Null:                                             ; Offset_0x02C18A
                rts   ; Rotina desativada por este rts
; Offset_0x02C18C:
                move.w  #$FC00, D1
                cmp.w   Obj_Speed_Y(A0), D1                              ; $0012
                ble.s   Offset_0x02C1A4
                move.b  ($FFFFF602).w, D0
                andi.b  #$70, D0
                bne.s   Offset_0x02C1A4
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
Offset_0x02C1A4:
                rts    
;-------------------------------------------------------------------------------
S1SS_FixCamera:                                                ; Offset_0x02C1A6
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  Obj_X(A0), D3                                    ; $0008
                move.w  (Camera_X).w, D0                             ; $FFFFEE00
                subi.w  #$00A0, D3
                bcs.s   Offset_0x02C1BE
                sub.w   D3, D0
                sub.w   D0, ($FFFFEE00).w
Offset_0x02C1BE:
                move.w  (Camera_Y).w, D0                             ; $FFFFEE04
                subi.w  #$0070, D2
                bcs.s   Offset_0x02C1CE
                sub.w   D2, D0
                sub.w   D0, ($FFFFEE04).w
Offset_0x02C1CE:
                rts
;-------------------------------------------------------------------------------                
Player_In_SS_Animate:                                          ; Offset_0x02C1D0
                addi.w  #$0040, (Boss_Move_Buffer+$02).w             ; $FFFFF752
                cmpi.w  #$1800, (Boss_Move_Buffer+$02).w             ; $FFFFF752
                bne.s   Offset_0x02C1E4
                move.b  #gm_PlayMode, (Game_Mode).w             ; $0C, $FFFFF600
Offset_0x02C1E4:
                cmpi.w  #$3000, (Boss_Move_Buffer+$02).w             ; $FFFFF752
                blt.s   Offset_0x02C202
                move.w  #$0000, (Boss_Move_Buffer+$02).w             ; $FFFFF752
                move.w  #$4000, (Boss_Move_Buffer).w                 ; $FFFFF750
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$003C, Obj_Player_St_Convex(A0)                 ; $0038
Offset_0x02C202:
                move.w  (Boss_Move_Buffer).w, D0                     ; $FFFFF750
                add.w   (Boss_Move_Buffer+$02).w, D0                 ; $FFFFF752
                move.w  D0, (Boss_Move_Buffer).w                     ; $FFFFF750
                jsr     (Sonic_Animate)                        ; Offset_0x010BF2
                jsr     (Load_Sonic_Dynamic_PLC)               ; Offset_0x0110D4
                bsr     S1SS_FixCamera                         ; Offset_0x02C1A6
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------                 
Player_In_SS_Exit_Test:                                        ; Offset_0x02C224
                subq.w  #$01, Obj_Player_St_Convex(A0)                   ; $0038
                bne.s   Offset_0x02C230
                move.b  #gm_PlayMode, (Game_Mode).w             ; $0C, $FFFFF600
Offset_0x02C230:
                jsr     (Sonic_Animate)                        ; Offset_0x010BF2
                jsr     (Load_Sonic_Dynamic_PLC)               ; Offset_0x0110D4
                bsr     S1SS_FixCamera                         ; Offset_0x02C1A6
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------                
Player_In_SS_Fall:                                             ; Offset_0x02C246
                move.l  Obj_Y(A0), D2                                    ; $000C
                move.l  Obj_X(A0), D3                                    ; $0008
                move.b  (Boss_Move_Buffer).w, D0                     ; $FFFFF750
                andi.b  #$FC, D0
                jsr     (CalcSine)                             ; Offset_0x003282
                move.w  Obj_Speed(A0), D4                                ; $0010
                ext.l   D4
                asl.l   #$08, D4
                muls.w  #$002A, D0
                add.l   D4, D0
                move.w  Obj_Speed_Y(A0), D4                              ; $0012
                ext.l   D4
                asl.l   #$08, D4
                muls.w  #$002A, D1
                add.l   D4, D1
                add.l   D0, D3
                bsr     Player_In_SS_Sub                       ; Offset_0x02C2D8
                beq.s   Offset_0x02C2A0
                sub.l   D0, D3
                moveq   #$00, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                bclr    #$01, Obj_Status(A0)                             ; $0022
                add.l   D1, D2
                bsr     Player_In_SS_Sub                       ; Offset_0x02C2D8
                beq.s   Offset_0x02C2B6
                sub.l   D1, D2
                moveq   #$00, D1
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
                rts
Offset_0x02C2A0:
                add.l   D1, D2
                bsr     Player_In_SS_Sub                       ; Offset_0x02C2D8
                beq.s   Offset_0x02C2C4
                sub.l   D1, D2
                moveq   #$00, D1
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
                bclr    #$01, Obj_Status(A0)                             ; $0022
Offset_0x02C2B6:
                asr.l   #$08, D0
                asr.l   #$08, D1
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
                rts
Offset_0x02C2C4:
                asr.l   #$08, D0
                asr.l   #$08, D1
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
                bset    #$01, Obj_Status(A0)                             ; $0022
                rts  
;-------------------------------------------------------------------------------
Player_In_SS_Sub:                                              ; Offset_0x02C2D8
                lea     (M68K_RAM_Start), A1                         ; $FFFF0000
                moveq   #$00, D4
                swap.w  D2
                move.w  D2, D4
                swap.w  D2
                addi.w  #$0044, D4
                divu.w  #$0018, D4
                mulu.w  #$0080, D4
                adda.l  D4, A1
                moveq   #$00, D4
                swap.w  D3
                move.w  D3, D4
                swap.w  D3
                addi.w  #$0014, D4
                divu.w  #$0018, D4
                adda.w  D4, A1
                moveq   #$00, D5
                move.b  (A1)+, D4
                bsr.s   Offset_0x02C320
                move.b  (A1)+, D4
                bsr.s   Offset_0x02C320
                adda.w  #$007E, A1
                move.b  (A1)+, D4
                bsr.s   Offset_0x02C320
                move.b  (A1)+, D4
                bsr.s   Offset_0x02C320
                tst.b   D5
                rts
Offset_0x02C320:
                beq.s   Offset_0x02C334
                cmpi.b  #$28, D4
                beq.s   Offset_0x02C334
                cmpi.b  #$3A, D4
                bcs.s   Offset_0x02C336
                cmpi.b  #$4B, D4
                bcc.s   Offset_0x02C336
Offset_0x02C334:
                rts
Offset_0x02C336:
                move.b  D4, Obj_P_Invunerblt_Time(A0)                    ; $0030
                move.l  A1, Obj_P_Invcbility_Time(A0)                    ; $0032
                moveq   #-$01, D5
                rts
;-------------------------------------------------------------------------------                
Player_In_SS_ChkItems: ; Touch_Rings                           ; Offset_0x02C342
                lea     (M68K_RAM_Start), A1                         ; $FFFF0000
                moveq   #$00, D4
                move.w  Obj_Y(A0), D4                                    ; $000C
                addi.w  #$0050, D4
                divu.w  #$0018, D4
                mulu.w  #$0080, D4
                adda.l  D4, A1
                moveq   #$00, D4
                move.w  Obj_X(A0), D4                                    ; $0008
                addi.w  #$0020, D4
                divu.w  #$0018, D4
                adda.w  D4, A1
                move.b  (A1), D4
                bne.s   Offset_0x02C37C
                tst.b   Obj_Player_Spdsh_Cnt(A0)                         ; $003A
                bne     Offset_0x02C44C
                moveq   #$00, D4
                rts
Offset_0x02C37C:
                cmpi.b  #$3A, D4
                bne.s   Offset_0x02C3B8
                bsr     Offset_0x02BAA4
                bne.s   Offset_0x02C390
                move.b  #$01, (A2)
                move.l  A1, Obj_Map(A2)                                  ; $0004
Offset_0x02C390:
                jsr     (Add_Rings)                            ; Offset_0x00AB92
                cmpi.w  #$0032, (Ring_Count).w                       ; $FFFFFE20
                bcs.s   Offset_0x02C3B4
                bset    #$00, (Ring_Life_Flag).w                     ; $FFFFFE1B
                bne.s   Offset_0x02C3B4
                addq.b  #$01, ($FFFFFE18).w
                move.w  #$00BF, D0
                jsr     (Play_Music)                           ; Offset_0x00150C
Offset_0x02C3B4:
                moveq   #$00, D4
                rts
Offset_0x02C3B8:
                cmpi.b  #$28, D4
                bne.s   Offset_0x02C3E2
                bsr     Offset_0x02BAA4
                bne.s   Offset_0x02C3CC
                move.b  #$03, (A2)
                move.l  A1, Obj_Map(A2)                                  ; $0004
Offset_0x02C3CC:
                addq.b  #$01, (Life_Count).w                         ; $FFFFFE12
                addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
                move.w  #$0088, D0
                jsr     (Play_Music)                           ; Offset_0x00150C
                moveq   #$00, D4
                rts
Offset_0x02C3E2:
                cmpi.b  #$3B, D4
                bcs.s   Offset_0x02C428
                cmpi.b  #$40, D4
                bhi.s   Offset_0x02C428
                bsr     Offset_0x02BAA4
                bne.s   Offset_0x02C3FC
                move.b  #$05, (A2)
                move.l  A1, Obj_Map(A2)                                  ; $0004
Offset_0x02C3FC:
                cmpi.b  #$06, (Emerald_Count).w                      ; $FFFFFE57
                beq.s   Offset_0x02C41A
                subi.b  #$3B, D4
                moveq   #$00, D0
                move.b  (Emerald_Count).w, D0                        ; $FFFFFE57
                lea     (Emerald_Collected_Flag_List).w, A2          ; $FFFFFE58
                move.b  D4, $00(A2, D0)
                addq.b  #$01, (Emerald_Count).w                      ; $FFFFFE57
Offset_0x02C41A:
                move.w  #$0093, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                moveq   #$00, D4
                rts
Offset_0x02C428:
                cmpi.b  #$41, D4
                bne.s   Offset_0x02C434
                move.b  #$01, Obj_Player_Spdsh_Cnt(A0)                   ; $003A
Offset_0x02C434:
                cmpi.b  #$4A, D4
                bne.s   Offset_0x02C448
                cmpi.b  #$01, Obj_Player_Spdsh_Cnt(A0)                   ; $003A
                bne.s   Offset_0x02C448
                move.b  #$02, Obj_Player_Spdsh_Cnt(A0)                   ; $003A
Offset_0x02C448:
                moveq   #-$01, D4
                rts
Offset_0x02C44C:
                cmpi.b  #$02, Obj_Player_Spdsh_Cnt(A0)                   ; $003A
                bne.s   Offset_0x02C476
                lea     ($FFFF1020), A1
                moveq   #$3F, D1
Offset_0x02C45C:
                moveq   #$3F, D2
Offset_0x02C45E:
                cmpi.b  #$41, (A1)
                bne.s   Offset_0x02C468
                move.b  #$2C, (A1)
Offset_0x02C468:
                addq.w  #$01, A1
                dbra    D2, Offset_0x02C45E
                lea     Obj_Size(A1), A1                                 ; $0040
                dbra    D1, Offset_0x02C45C
Offset_0x02C476:
                clr.b   Obj_Player_Spdsh_Cnt(A0)                         ; $003A
                moveq   #$00, D4
                rts
;-------------------------------------------------------------------------------                
Player_In_SS_ChkItems2:                                        ; Offset_0x02C47E
                move.b  Obj_P_Invunerblt_Time(A0), D0                    ; $0030
                bne.s   Offset_0x02C49E
                subq.b  #$01, Obj_Player_Next_Tilt(A0)                   ; $0036
                bpl.s   Offset_0x02C490
                move.b  #$00, Obj_Player_Next_Tilt(A0)                   ; $0036
Offset_0x02C490:
                subq.b  #$01, Obj_Player_Tilt(A0)                        ; $0037
                bpl.s   Offset_0x02C49C
                move.b  #$00, Obj_Player_Tilt(A0)                        ; $0037
Offset_0x02C49C:
                rts
Offset_0x02C49E:
                cmpi.b  #$25, D0
                bne.s   Offset_0x02C516
                move.l  Obj_P_Invcbility_Time(A0), D1                    ; $0032
                subi.l  #$FFFF0001, D1
                move.w  D1, D2
                andi.w  #$007F, D1
                mulu.w  #$0018, D1
                subi.w  #$0014, D1
                lsr.w   #$07, D2
                andi.w  #$007F, D2
                mulu.w  #$0018, D2
                subi.w  #$0044, D2
                sub.w   Obj_X(A0), D1                                    ; $0008
                sub.w   Obj_Y(A0), D2                                    ; $000C
                jsr     (CalcAngle)                            ; Offset_0x00351A
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$F900, D1
                asr.l   #$08, D1
                move.w  D1, Obj_Speed(A0)                                ; $0010
                muls.w  #$F900, D0
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                bset    #$01, Obj_Status(A0)                             ; $0022
                bsr     Offset_0x02BAA4
                bne.s   Offset_0x02C50C
                move.b  #$02, (A2)
                move.l  Obj_P_Invcbility_Time(A0), D0                    ; $0032
                subq.l  #$01, D0
                move.l  D0, Obj_Map(A2)                                  ; $0004
Offset_0x02C50C:
                move.w  #$00B4, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02C516:
                cmpi.b  #$27, D0
                bne.s   Offset_0x02C52C
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$00A8, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                rts
Offset_0x02C52C:
                cmpi.b  #$29, D0
                bne.s   Offset_0x02C560
                tst.b   Obj_Player_Next_Tilt(A0)                         ; $0036
                bne     Offset_0x02C610
                move.b  #$1E, Obj_Player_Next_Tilt(A0)                   ; $0036
                btst    #$06, (Boss_Move_Buffer+$03).w               ; $FFFFF753
                beq.s   Offset_0x02C556
                asl.w   (Boss_Move_Buffer+$02).w                     ; $FFFFF752
                move.l  Obj_P_Invcbility_Time(A0), A1                    ; $0032
                subq.l  #$01, A1
                move.b  #$2A, (A1)
Offset_0x02C556:
                move.w  #$00A9, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02C560:
                cmpi.b  #$2A, D0
                bne.s   Offset_0x02C594
                tst.b   Obj_Player_Next_Tilt(A0)                         ; $0036
                bne     Offset_0x02C610
                move.b  #$1E, Obj_Player_Next_Tilt(A0)                   ; $0036
                btst    #$06, (Boss_Move_Buffer+$03).w               ; $FFFFF753
                bne.s   Offset_0x02C58A
                asr.w   (Boss_Move_Buffer+$02).w                     ; $FFFFF752
                move.l  Obj_P_Invcbility_Time(A0), A1                    ; $0032
                subq.l  #$01, A1
                move.b  #$29, (A1)
Offset_0x02C58A:
                move.w  #$00A9, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02C594:
                cmpi.b  #$2B, D0
                bne.s   Offset_0x02C5CA
                tst.b   Obj_Player_Tilt(A0)                              ; $0037
                bne     Offset_0x02C610
                move.b  #$1E, Obj_Player_Tilt(A0)                        ; $0037
                bsr     Offset_0x02BAA4
                bne.s   Offset_0x02C5BC
                move.b  #$04, (A2)
                move.l  Obj_P_Invcbility_Time(A0), D0                    ; $0032
                subq.l  #$01, D0
                move.l  D0, Obj_Map(A2)                                  ; $0004
Offset_0x02C5BC:
                neg.w   (Boss_Move_Buffer+$02).w                     ; $FFFFF752
                move.w  #$00A9, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02C5CA:
                cmpi.b  #$2D, D0
                beq.s   Offset_0x02C5E2
                cmpi.b  #$2E, D0
                beq.s   Offset_0x02C5E2
                cmpi.b  #$2F, D0
                beq.s   Offset_0x02C5E2
                cmpi.b  #$30, D0
                bne.s   Offset_0x02C610
Offset_0x02C5E2:
                bsr     Offset_0x02BAA4
                bne.s   Offset_0x02C606
                move.b  #$06, (A2)
                move.l  Obj_P_Invcbility_Time(A0), A1                    ; $0032
                subq.l  #$01, A1
                move.l  A1, Obj_Map(A2)                                  ; $0004
                move.b  (A1), D0
                addq.b  #$01, D0
                cmpi.b  #$30, D0
                bls.s   Offset_0x02C602
                clr.b   D0
Offset_0x02C602:
                move.b  D0, Obj_Map(A2)                                  ; $0004
Offset_0x02C606:
                move.w  #$00BA, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02C610:
                rts                
;===============================================================================
; Objeto 0x09 - Sonic no Special Stage - Left over do Sonic 1
; <<<-
;===============================================================================