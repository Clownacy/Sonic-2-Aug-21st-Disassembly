;===============================================================================
; Object 0x02 - Miles
; ->>>
;===============================================================================  
; Offset_0x011130:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Miles_Index(PC, D0), D1                ; Offset_0x01113E
                jmp     Miles_Index(PC, D1)                    ; Offset_0x01113E
;-------------------------------------------------------------------------------
Miles_Index:                                                   ; Offset_0x01113E                          
                dc.w    Miles_Main-Miles_Index                 ; Offset_0x011148
                dc.w    Miles_Control-Miles_Index              ; Offset_0x0111B2
                dc.w    Miles_Hurt-Miles_Index                 ; Offset_0x011F2A
                dc.w    Miles_Death-Miles_Index                ; Offset_0x011F9C
                dc.w    Miles_ResetLevel-Miles_Index           ; Offset_0x011FFC  
;-------------------------------------------------------------------------------                                           
Miles_Main:                                                    ; Offset_0x011148
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$0F, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                move.l  #Miles_Mappings, Obj_Map(A0)    ; Offset_0x0739E2, $0004                  ; $0004
                move.w  #$07A0, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.b  #$84, Obj_Flags(A0)                              ; $0001
                move.w  #$0600, (Miles_Max_Speed).w                  ; $FFFFFEC0
                move.w  #$000C, (Miles_Acceleration).w               ; $FFFFFEC2
                move.w  #$0080, (Miles_Deceleration).w               ; $FFFFFEC4
                move.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
                move.b  #$0D, Obj_Player_LRB_Solid(A0)                   ; $003F
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                move.b  #$04, Obj_Player_Flip_Speed(A0)                  ; $002D
                move.b  #$1E, Obj_Subtype(A0)                            ; $0028
                move.b  #$05, ($FFFFB1C0).w   
;-------------------------------------------------------------------------------                
Miles_Control:                                                 ; Offset_0x0111B2
                bsr     Miles_CPU_Control                      ; Offset_0x0112B6
                btst    #$00, Obj_Timer(A0)                              ; $002A
                bne.s   Miles_ControlsLock                     ; Offset_0x0111D0
                moveq   #$00, D0
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.w  #$0006, D0
                move.w  Miles_Modes(PC, D0), D1                ; Offset_0x01121A
                jsr     Miles_Modes(PC, D1)                    ; Offset_0x01121A
Miles_ControlsLock:                                            ; Offset_0x0111D0
                cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEECC
                bne.s   Offset_0x0111DE
                andi.w  #$07FF, Obj_Y(A0)                                ; $000C
Offset_0x0111DE:
                bsr.s   Miles_Display                          ; Offset_0x011232
                bsr     Miles_RecordMoves                      ; Offset_0x011376
                bsr     Miles_Water                            ; Offset_0x011390
                move.b  ($FFFFF768).w, Obj_Player_Next_Tilt(A0)          ; $0036
                move.b  ($FFFFF76A).w, Obj_Player_Tilt(A0)               ; $0037
                tst.b   ($FFFFF7C7).w
                beq.s   Offset_0x011206
                tst.b   Obj_Ani_Number(A0)                               ; $001C
                bne.s   Offset_0x011206
                move.b  Obj_Ani_Flag(A0), Obj_Ani_Number(A0)      ; $001C, $001D
Offset_0x011206:
                bsr     Miles_Animate                          ; Offset_0x012010
                tst.b   Obj_Timer(A0)                                    ; $002A
                bmi.s   Offset_0x011216
                jsr     (TouchResponse)                        ; Offset_0x02B1EC
Offset_0x011216:
                bra     Load_Miles_Dynamic_PLC                 ; Offset_0x0123EE  
;-------------------------------------------------------------------------------
Miles_Modes:                                                   ; Offset_0x01121A
                dc.w    Miles_MdNormal-Miles_Modes             ; Offset_0x011448
                dc.w    Miles_MdJump-Miles_Modes               ; Offset_0x011470   
                dc.w    Miles_MdRoll-Miles_Modes               ; Offset_0x01149A
                dc.w    Miles_MdJump2-Miles_Modes              ; Offset_0x0114BA
;-------------------------------------------------------------------------------   
Miles_PlayList:                                                ; Offset_0x011222 
                dc.b    $82  ; GHz
                dc.b    $82
                dc.b    $85  ; Wz
                dc.b    $84
                dc.b    $85  ; Mz
                dc.b    $85  ; Mz
                dc.b    $8C
                dc.b    $86  ; HTz
                dc.b    $83  ; HPz
                dc.b    $8D
                dc.b    $88  ; OOz
                dc.b    $8B  ; DHz
                dc.b    $89  ; CNz
                dc.b    $8E  ; CPz
                dc.b    $8E  ; GCz 
                dc.b    $87  ; NGHz   
;-------------------------------------------------------------------------------
Miles_Display:                                                 ; Offset_0x011232
                move.w  Obj_P_Invunerblt_Time(A0), D0                    ; $0030
                beq.s   Offset_0x011240
                subq.w  #$01, Obj_P_Invunerblt_Time(A0)                  ; $0030
                lsr.w   #$03, D0
                bcc.s   Offset_0x011246
Offset_0x011240:
                jsr     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x011246:
                tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
                beq.s   Offset_0x011280
                tst.w   Obj_P_Invcbility_Time(A0)                        ; $0032
                beq.s   Offset_0x011280
                subq.w  #$01, Obj_P_Invcbility_Time(A0)                  ; $0032
                bne.s   Offset_0x011280
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x01127A
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x01127A
                moveq   #$00, D0
                move.b  (Level_Id).w, D0                             ; $FFFFFE10
                lea     Miles_PlayList(PC), A1                 ; Offset_0x011222
                move.b  $00(A1, D0), D0
                jsr     (Play_Music)                           ; Offset_0x00150C
Offset_0x01127A:
                move.b  #$00, (Invincibility_Flag).w                 ; $FFFFFE2D
Offset_0x011280:
                tst.b   (Hi_Speed_Flag).w                            ; $FFFFFE2E
                beq.s   Offset_0x0112B4
                tst.w   Obj_P_Spd_Shoes_Time(A0)                         ; $0034
                beq.s   Offset_0x0112B4
                subq.w  #$01, Obj_P_Spd_Shoes_Time(A0)                   ; $0034
                bne.s   Offset_0x0112B4
                move.w  #$0600, (Miles_Max_Speed).w                  ; $FFFFFEC0
                move.w  #$000C, (Miles_Acceleration).w               ; $FFFFFEC2
                move.w  #$0080, (Miles_Deceleration).w               ; $FFFFFEC4
                move.b  #$00, (Hi_Speed_Flag).w                      ; $FFFFFE2E
                move.w  #$00FC, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
Offset_0x0112B4:
                rts       
;-------------------------------------------------------------------------------
Miles_CPU_Control:                                             ; Offset_0x0112B6
                move.b  ($FFFFF606).w, D0
                andi.b  #$7F, D0
                beq.s   Offset_0x0112CE
                move.w  #$0000, ($FFFFF700).w
                move.w  #$012C, ($FFFFF702).w
                rts
Offset_0x0112CE:
                tst.w   ($FFFFF702).w
                beq.s   Offset_0x0112DA
                subq.w  #$01, ($FFFFF702).w
                rts
Offset_0x0112DA:
                move.w  ($FFFFF708).w, D0
                move.w  Miles_CPU_States(PC, D0), D0           ; Offset_0x0112E6
                jmp     Miles_CPU_States(PC, D0)               ; Offset_0x0112E6
;-------------------------------------------------------------------------------
Miles_CPU_States:                                              ; Offset_0x0112E6
                dc.w    Miles_CPU_Init-Miles_CPU_States        ; Offset_0x0112EE
                dc.w    Miles_CPU_Spawning-Miles_CPU_States    ; Offset_0x0112F6
                dc.w    Miles_CPU_Normal-Miles_CPU_States      ; Offset_0x01130A
                dc.w    Miles_Copy_Sonic_Moves-Miles_CPU_States  ; Offset_0x011344  
;-------------------------------------------------------------------------------                
Miles_CPU_Init:                                                ; Offset_0x0112EE
                move.w  #$0006, ($FFFFF708).w
                rts
;-------------------------------------------------------------------------------
Miles_CPU_Spawning:                                            ; Offset_0x0112F6
                move.w  #$0006, ($FFFFF708).w
                rts     
;-------------------------------------------------------------------------------  
; Offset_0x0112FE:
                move.w  #$0040, ($FFFFF706).w
                move.w  #$0004, ($FFFFF708).w
;-------------------------------------------------------------------------------
Miles_CPU_Normal:                                              ; Offset_0x01130A
                move.w  #$0006, ($FFFFF708).w
                rts     
;-------------------------------------------------------------------------------
; Offset_0x011312:
                move.w  ($FFFFF706).w, D1
                subq.w  #$01, D1
                cmpi.w  #$0010, D1
                bne.s   Offset_0x011324
                move.w  #$0006, ($FFFFF708).w
Offset_0x011324:
                move.w  D1, ($FFFFF706).w
                lea     ($FFFFE600).w, A1
                lsl.b   #$02, D1
                addq.b  #$04, D1
                move.w  ($FFFFEEE0).w, D0
                sub.b   D1, D0
                move.w  $00(A1, D0), Obj_X(A0)                           ; $0008
                move.w  $02(A1, D0), Obj_Y(A0)                           ; $000C
                rts
;-------------------------------------------------------------------------------    
Miles_Copy_Sonic_Moves:                                        ; Offset_0x011344
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                bpl.s   Offset_0x011350
                neg.w   D0
Offset_0x011350:
                cmpi.w  #$00C0, D0
                bcs.s   Offset_0x011358
                nop
Offset_0x011358:
                lea     ($FFFFE500).w, A1
                move.w  #$0010, D1
                lsl.b   #$02, D1
                addq.b  #$04, D1
                move.w  ($FFFFEED2).w, D0
                sub.b   D1, D0
                lea     ($FFFFE400).w, A1
                move.w  $00(A1, D0), ($FFFFF606).w
                rts 
;-------------------------------------------------------------------------------        
Miles_RecordMoves:                                             ; Offset_0x011376
                move.w  ($FFFFEED6).w, D0
                lea     ($FFFFE700).w, A1
                lea     $00(A1, D0), A1
                move.w  Obj_X(A0), (A1)+                                 ; $0008
                move.w  Obj_Y(A0), (A1)+                                 ; $000C
                addq.b  #$04, ($FFFFEED7).w
                rts  
;-------------------------------------------------------------------------------
Miles_Water:                                                   ; Offset_0x011390
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                bne.s   Miles_InLevelWithWater                 ; Offset_0x011398
Offset_0x011396:
                rts
;-------------------------------------------------------------------------------
Miles_InLevelWithWater:                                        ; Offset_0x011398
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bge.s   Miles_NotInWater                       ; Offset_0x0113F0
                bset    #$06, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x011396
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                move.b  #$0A, ($FFFFB300).w
                move.b  #$81, ($FFFFB328).w
                move.l  A0, ($FFFFB33C).w
                move.w  #$0300, (Miles_Max_Speed).w                  ; $FFFFFEC0
                move.w  #$0006, (Miles_Acceleration).w               ; $FFFFFEC2
                move.w  #$0040, (Miles_Deceleration).w               ; $FFFFFEC4
                asr.w   Obj_Speed(A0)                                    ; $0010
                asr.w   Obj_Speed_Y(A0)                                  ; $0012
                asr.w   Obj_Speed_Y(A0)                                  ; $0012
                beq.s   Offset_0x011396
                move.w  #$0100, ($FFFFB45C).w
                move.w  #$00AA, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------                
Miles_NotInWater:                                              ; Offset_0x0113F0
                bclr    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011396
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                move.w  #$0600, (Miles_Max_Speed).w                  ; $FFFFFEC0
                move.w  #$000C, (Miles_Acceleration).w               ; $FFFFFEC2
                move.w  #$0080, (Miles_Deceleration).w               ; $FFFFFEC4
                cmpi.b  #$04, Obj_Routine(A0)                            ; $0024
                beq.s   Offset_0x01141C
                asl.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x01141C:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                beq     Offset_0x011396
                move.w  #$0100, ($FFFFB45C).w
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                cmpi.w  #$F000, Obj_Speed_Y(A0)                          ; $0012
                bgt.s   Offset_0x01143E
                move.w  #$F000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x01143E:
                move.w  #$00AA, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------
Miles_MdNormal:                                                ; Offset_0x011448
                bsr     Miles_Spindash                         ; Offset_0x011AAC
                bsr     Miles_Jump                             ; Offset_0x0119C2
                bsr     Miles_SlopeResist                      ; Offset_0x011BA6
                bsr     Miles_Move                             ; Offset_0x0114E4
                bsr     Miles_Roll                             ; Offset_0x01195C
                bsr     Miles_LevelBoundaries                  ; Offset_0x0118FE
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                bsr     Player_AnglePos                        ; Offset_0x013694
                bsr     Miles_SlopeRepel                       ; Offset_0x011C18
                rts
;-------------------------------------------------------------------------------
Miles_MdJump:                                                  ; Offset_0x011470
                bsr     Miles_JumpHeight                       ; Offset_0x011A70
                bsr     Miles_ChgJumpDir                       ; Offset_0x011884
                bsr     Miles_LevelBoundaries                  ; Offset_0x0118FE
                jsr     (ObjectFall)                           ; Offset_0x00D1AE
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011490
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $0012
Offset_0x011490:
                bsr     Miles_JumpAngle                        ; Offset_0x011C5A
                bsr     Miles_Floor                            ; Offset_0x011CBA
                rts  
;-------------------------------------------------------------------------------
Miles_MdRoll:                                                  ; Offset_0x01149A
                bsr     Miles_Jump                             ; Offset_0x0119C2
                bsr     Miles_RollRepel                        ; Offset_0x011BDC
                bsr     Miles_RollSpeed                        ; Offset_0x01178C
                bsr     Miles_LevelBoundaries                  ; Offset_0x0118FE
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                bsr     Player_AnglePos                        ; Offset_0x013694
                bsr     Miles_SlopeRepel                       ; Offset_0x011C18
                rts   
;-------------------------------------------------------------------------------
Miles_MdJump2:                                                 ; Offset_0x0114BA
                bsr     Miles_JumpHeight                       ; Offset_0x011A70
                bsr     Miles_ChgJumpDir                       ; Offset_0x011884
                bsr     Miles_LevelBoundaries                  ; Offset_0x0118FE
                jsr     (ObjectFall)                           ; Offset_0x00D1AE
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0114DA
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $0012
Offset_0x0114DA:
                bsr     Miles_JumpAngle                        ; Offset_0x011C5A
                bsr     Miles_Floor                            ; Offset_0x011CBA
                rts      
;-------------------------------------------------------------------------------                
Miles_Move:                                                    ; Offset_0x0114E4
                move.w  (Miles_Max_Speed).w, D6                      ; $FFFFFEC0
                move.w  (Miles_Acceleration).w, D5                   ; $FFFFFEC2
                move.w  (Miles_Deceleration).w, D4                   ; $FFFFFEC4
                tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
                bne     Offset_0x0115F6
                tst.w   Obj_Player_Control(A0)                           ; $002E
                bne     Offset_0x0115CA
                btst    #$02, ($FFFFF606).w
                beq.s   Offset_0x01150C
                bsr     Offset_0x011686
Offset_0x01150C:
                btst    #$03, ($FFFFF606).w
                beq.s   Offset_0x011518
                bsr     Offset_0x01170C
Offset_0x011518:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne     Offset_0x0115CA
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bne     Offset_0x0115CA
                bclr    #$05, Obj_Status(A0)                             ; $0022
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01157A
                moveq   #$00, D0
                move.b  Obj_Player_Last(A0), D0                          ; $003D
                lsl.w   #$06, D0
                lea     (Player_One).w, A1                           ; $FFFFB000
                lea     $00(A1, D0), A1
                tst.b   Obj_Status(A1)                                   ; $0022
                bmi.s   Offset_0x0115AC
                moveq   #$00, D1
                move.b  Obj_Width(A1), D1                                ; $0019
                move.w  D1, D2
                add.w   D2, D2
                subq.w  #$04, D2
                add.w   Obj_X(A0), D1                                    ; $0008
                sub.w   Obj_X(A1), D1                                    ; $0008
                cmpi.w  #$0004, D1
                blt.s   Offset_0x01159E
                cmp.w   D2, D1
                bge.s   Offset_0x01158E
                bra.s   Offset_0x0115AC
Offset_0x01157A:
                jsr     (Player_HitFloor)                      ; Offset_0x014160
                cmpi.w  #$000C, D1
                blt.s   Offset_0x0115AC
                cmpi.b  #$03, Obj_Player_Next_Tilt(A0)                   ; $0036
                bne.s   Offset_0x011596
Offset_0x01158E:
                bclr    #$00, Obj_Status(A0)                             ; $0022
                bra.s   Offset_0x0115A4
Offset_0x011596:
                cmpi.b  #$03, Obj_Player_Tilt(A0)                        ; $0037
                bne.s   Offset_0x0115AC
Offset_0x01159E:
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x0115A4:
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x0115CA
Offset_0x0115AC:
                btst    #$00, ($FFFFF606).w
                beq.s   Offset_0x0115BC
                move.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x0115CA
Offset_0x0115BC:
                btst    #$01, ($FFFFF606).w
                beq.s   Offset_0x0115CA
                move.b  #$08, Obj_Ani_Number(A0)                         ; $001C
Offset_0x0115CA:
                move.b  ($FFFFF606).w, D0
                andi.b  #$0C, D0
                bne.s   Offset_0x0115F6
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x0115F6
                bmi.s   Offset_0x0115EA
                sub.w   D5, D0
                bcc.s   Offset_0x0115E4
                move.w  #$0000, D0
Offset_0x0115E4:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                bra.s   Offset_0x0115F6
Offset_0x0115EA:
                add.w   D5, D0
                bcc.s   Offset_0x0115F2
                move.w  #$0000, D0
Offset_0x0115F2:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
Offset_0x0115F6:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  Obj_Inertia(A0), D1                              ; $0014
                asr.l   #$08, D1
                move.w  D1, Obj_Speed(A0)                                ; $0010
                muls.w  Obj_Inertia(A0), D0                              ; $0014
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
Offset_0x011614:                
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$40, D0
                bmi.s   Offset_0x011684
                move.b  #$40, D1
                tst.w   Obj_Inertia(A0)                                  ; $0014
                beq.s   Offset_0x011684
                bmi.s   Offset_0x01162C
                neg.w   D1
Offset_0x01162C:
                move.b  Obj_Angle(A0), D0                                ; $0026
                add.b   D1, D0
                move.w  D0, -(A7)
                bsr     Player_WalkSpeed                       ; Offset_0x013FD8
                move.w  (A7)+, D0
                tst.w   D1
                bpl.s   Offset_0x011684
                asl.w   #$08, D1
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x011680
                cmpi.b  #$40, D0
                beq.s   Offset_0x01166E
                cmpi.b  #$80, D0
                beq.s   Offset_0x011668
                add.w   D1, Obj_Speed(A0)                                ; $0010
                bset    #$05, Obj_Status(A0)                             ; $0022
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                rts
Offset_0x011668:
                sub.w   D1, Obj_Speed_Y(A0)                              ; $0012
                rts
Offset_0x01166E:
                sub.w   D1, Obj_Speed(A0)                                ; $0010
                bset    #$05, Obj_Status(A0)                             ; $0022
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                rts
Offset_0x011680:
                add.w   D1, Obj_Speed_Y(A0)                              ; $0012
Offset_0x011684:
                rts
Offset_0x011686:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x01168E
                bpl.s   Offset_0x0116C0
Offset_0x01168E:
                bset    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0116A2
                bclr    #$05, Obj_Status(A0)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
Offset_0x0116A2:
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x0116B4
                add.w   D5, D0
                cmp.w   D1, D0
                ble.s   Offset_0x0116B4
                move.w  D1, D0
Offset_0x0116B4:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x0116C0:
                sub.w   D4, D0
                bcc.s   Offset_0x0116C8
                move.w  #$FF80, D0
Offset_0x0116C8:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x01170A
                cmpi.w  #$0400, D0
                blt.s   Offset_0x01170A
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $001C
                bclr    #$00, Obj_Status(A0)                             ; $0022
                move.w  #$00A4, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x01170A
                move.b  #$06, ($FFFFB464).w
                move.b  #$15, ($FFFFB45A).w
Offset_0x01170A:
                rts
Offset_0x01170C:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bmi.s   Offset_0x011740
                bclr    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011726
                bclr    #$05, Obj_Status(A0)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
Offset_0x011726:
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x011734
                sub.w   D5, D0
                cmp.w   D6, D0
                bge.s   Offset_0x011734
                move.w  D6, D0
Offset_0x011734:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x011740:
                add.w   D4, D0
                bcc.s   Offset_0x011748
                move.w  #$0080, D0
Offset_0x011748:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x01178A
                cmpi.w  #$FC00, D0
                bgt.s   Offset_0x01178A
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $001C
                bset    #$00, Obj_Status(A0)                             ; $0022
                move.w  #$00A4, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x01178A
                move.b  #$06, ($FFFFB464).w
                move.b  #$15, ($FFFFB45A).w
Offset_0x01178A:
                rts   
;-------------------------------------------------------------------------------                
Miles_RollSpeed:                                               ; Offset_0x01178C
                move.w  (Miles_Max_Speed).w, D6                      ; $FFFFFEC0
                asl.w   #$01, D6
                move.w  (Miles_Acceleration).w, D5                   ; $FFFFFEC2
                asr.w   #$01, D5
                move.w  (Miles_Deceleration).w, D4                   ; $FFFFFEC4
                asr.w   #$02, D4
                tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
                bne     Offset_0x011808
                tst.w   Obj_Player_Control(A0)                           ; $002E
                bne.s   Offset_0x0117C4
                btst    #$02, ($FFFFF606).w
                beq.s   Offset_0x0117B8
                bsr     Offset_0x01183E
Offset_0x0117B8:
                btst    #$03, ($FFFFF606).w
                beq.s   Offset_0x0117C4
                bsr     Offset_0x011862
Offset_0x0117C4:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x0117E6
                bmi.s   Offset_0x0117DA
                sub.w   D5, D0
                bcc.s   Offset_0x0117D4
                move.w  #$0000, D0
Offset_0x0117D4:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                bra.s   Offset_0x0117E6
Offset_0x0117DA:
                add.w   D5, D0
                bcc.s   Offset_0x0117E2
                move.w  #$0000, D0
Offset_0x0117E2:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
Offset_0x0117E6:
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bne.s   Offset_0x011808
                bclr    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$0F, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                subq.w  #$05, Obj_Y(A0)                                  ; $000C
Offset_0x011808:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  Obj_Inertia(A0), D0                              ; $0014
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                muls.w  Obj_Inertia(A0), D1                              ; $0014
                asr.l   #$08, D1
                cmpi.w  #$1000, D1
                ble.s   Offset_0x01182C
                move.w  #$1000, D1
Offset_0x01182C:
                cmpi.w  #$F000, D1
                bge.s   Offset_0x011836
                move.w  #$F000, D1
Offset_0x011836:
                move.w  D1, Obj_Speed(A0)                                ; $0010
                bra     Offset_0x011614
Offset_0x01183E:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x011846
                bpl.s   Offset_0x011854
Offset_0x011846:
                bset    #$00, Obj_Status(A0)                             ; $0022
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x011854:
                sub.w   D4, D0
                bcc.s   Offset_0x01185C
                move.w  #$FF80, D0
Offset_0x01185C:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                rts
Offset_0x011862:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bmi.s   Offset_0x011876
                bclr    #$00, Obj_Status(A0)                             ; $0022
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x011876:
                add.w   D4, D0
                bcc.s   Offset_0x01187E
                move.w  #$0080, D0
Offset_0x01187E:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                rts
;-------------------------------------------------------------------------------                
Miles_ChgJumpDir:                                              ; Offset_0x011884
                move.w  (Miles_Max_Speed).w, D6                      ; $FFFFFEC0
                move.w  (Miles_Acceleration).w, D5                   ; $FFFFFEC2
                asl.w   #$01, D5
                btst    #$04, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0118CE
                move.w  Obj_Speed(A0), D0                                ; $0010
                btst    #$02, ($FFFFF606).w
                beq.s   Offset_0x0118B4
                bset    #$00, Obj_Status(A0)                             ; $0022
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x0118B4
                move.w  D1, D0
Offset_0x0118B4:
                btst    #$03, ($FFFFF606).w
                beq.s   Offset_0x0118CA
                bclr    #$00, Obj_Status(A0)                             ; $0022
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x0118CA
                move.w  D6, D0
Offset_0x0118CA:
                move.w  D0, Obj_Speed(A0)                                ; $0010
Offset_0x0118CE:
                cmpi.w  #$FC00, Obj_Speed_Y(A0)                          ; $0012
                bcs.s   Offset_0x0118FC
                move.w  Obj_Speed(A0), D0                                ; $0010
                move.w  D0, D1
                asr.w   #$05, D1
                beq.s   Offset_0x0118FC
                bmi.s   Offset_0x0118F0
                sub.w   D1, D0
                bcc.s   Offset_0x0118EA
                move.w  #$0000, D0
Offset_0x0118EA:
                move.w  D0, Obj_Speed(A0)                                ; $0010
                rts
Offset_0x0118F0:
                sub.w   D1, D0
                bcs.s   Offset_0x0118F8
                move.w  #$0000, D0
Offset_0x0118F8:
                move.w  D0, Obj_Speed(A0)                                ; $0010
Offset_0x0118FC:
                rts
;-------------------------------------------------------------------------------                
Miles_LevelBoundaries:                                         ; Offset_0x0118FE
                move.l  Obj_X(A0), D1                                    ; $0008
                move.w  Obj_Speed(A0), D0                                ; $0010
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D1
                swap.w  D1
                move.w  (Miles_Level_Limits_Min_X).w, D0             ; $FFFFEEF8
                addi.w  #$0010, D0
                cmp.w   D1, D0
                bhi.s   Offset_0x011944
                move.w  (Miles_Level_Limits_Max_X).w, D0             ; $FFFFEEFA
                addi.w  #$0128, D0
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x01192C
                addi.w  #$0040, D0
Offset_0x01192C:
                cmp.w   D1, D0
                bls.s   Offset_0x011944
Offset_0x011930:
                move.w  (Miles_Level_Limits_Max_Y).w, D0             ; $FFFFEEFE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                blt.s   Offset_0x011940
                rts
Offset_0x011940:
                bra     Kill_Miles                             ; Offset_0x012544
Offset_0x011944:
                move.w  D0, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Sub_Y(A0)                            ; $000A
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                bra.s   Offset_0x011930 
;-------------------------------------------------------------------------------                
Miles_Roll:                                                    ; Offset_0x01195C
                tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
                bne.s   Offset_0x011982
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bpl.s   Offset_0x01196A
                neg.w   D0
Offset_0x01196A:
                cmpi.w  #$0080, D0
                bcs.s   Offset_0x011982
                move.b  ($FFFFF606).w, D0
                andi.b  #$0C, D0
                bne.s   Offset_0x011982
                btst    #$01, ($FFFFF606).w
                bne.s   Offset_0x011984
Offset_0x011982:
                rts
Offset_0x011984:
                btst    #$02, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01198E
                rts
Offset_0x01198E:
                bset    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                addq.w  #$05, Obj_Y(A0)                                  ; $000C
                move.w  #$00BE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bne.s   Offset_0x0119C0
                move.w  #$0200, Obj_Inertia(A0)                          ; $0014
Offset_0x0119C0:
                rts   
;-------------------------------------------------------------------------------                
Miles_Jump:                                                    ; Offset_0x0119C2
                move.b  ($FFFFF607).w, D0
                andi.b  #$70, D0
                beq     Offset_0x011A66
                moveq   #$00, D0
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$80, D0
                bsr     CalcRoomOverHead                       ; Offset_0x01405E
                cmpi.w  #$0006, D1
                blt     Offset_0x011A66
                move.w  #$0680, D2
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0119F4
                move.w  #$0380, D2
Offset_0x0119F4:
                moveq   #$00, D0
                move.b  Obj_Angle(A0), D0                                ; $0026
                subi.b  #$40, D0
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  D2, D1
                asr.l   #$08, D1
                add.w   D1, Obj_Speed(A0)                                ; $0010
                muls.w  D2, D0
                asr.l   #$08, D0
                add.w   D0, Obj_Speed_Y(A0)                              ; $0012
                bset    #$01, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A0)                             ; $0022
                addq.l  #$04, A7
                move.b  #$01, Obj_Player_Jump(A0)                        ; $003C
                clr.b   Obj_Player_St_Convex(A0)                         ; $0038
                move.w  #$00A0, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                move.b  #$0F, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                btst    #$02, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x011A68
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                bset    #$02, Obj_Status(A0)                             ; $0022
                addq.w  #$05, Obj_Y(A0)                                  ; $000C
Offset_0x011A66:
                rts
Offset_0x011A68:
                bset    #$04, Obj_Status(A0)                             ; $0022
                rts   
;-------------------------------------------------------------------------------                
Miles_JumpHeight:                                              ; Offset_0x011A70
                tst.b   Obj_Player_Jump(A0)                              ; $003C
                beq.s   Offset_0x011A9C
                move.w  #$FC00, D1
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011A86
                move.w  #$FE00, D1
Offset_0x011A86:
                cmp.w   Obj_Speed_Y(A0), D1                              ; $0012
                ble.s   Offset_0x011A9A
                move.b  ($FFFFF606).w, D0
                andi.b  #$70, D0
                bne.s   Offset_0x011A9A
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
Offset_0x011A9A:
                rts
Offset_0x011A9C:
                cmpi.w  #$F040, Obj_Speed_Y(A0)                          ; $0012
                bge.s   Offset_0x011AAA
                move.w  #$F040, Obj_Speed_Y(A0)                          ; $0012
Offset_0x011AAA:
                rts   
;-------------------------------------------------------------------------------                
Miles_Spindash:                                                ; Offset_0x011AAC
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $0039
                bne.s   Offset_0x011AF4
                cmpi.b  #$08, Obj_Ani_Number(A0)                         ; $001C
                bne.s   Offset_0x011AF2
                move.b  ($FFFFF607).w, D0
                andi.b  #$70, D0
                beq     Offset_0x011AF2
                move.b  #$09, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$00E0, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.l  #$04, A7
                move.b  #$01, Obj_Player_Spdsh_Flag(A0)                  ; $0039
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x011AF2
                move.b  #$02, ($FFFFB45C).w
Offset_0x011AF2:
                rts
Offset_0x011AF4:
                move.b  ($FFFFF606).w, D0
                btst    #$01, D0
                bne.s   Offset_0x011B5A
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                addq.w  #$05, Obj_Y(A0)                                  ; $000C
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $0039
                move.w  #$2000, ($FFFFEED4).w
                moveq   #$00, D0
                move.b  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003A
                add.w   D0, D0
                move.w  Miles_Spindash_Speed(PC, D0), Obj_Inertia(A0) ; Offset_0x011B48, $0014
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011B3A
                neg.w   Obj_Inertia(A0)                                  ; $0014
Offset_0x011B3A:
                bset    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$00, ($FFFFB45C).w
                bra.s   Offset_0x011BA2 
;-------------------------------------------------------------------------------
Miles_Spindash_Speed:                                          ; Offset_0x011B48   
                dc.w    $0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
                dc.w    $0C00   
;-------------------------------------------------------------------------------
Offset_0x011B5A:
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003A
                beq.s   Offset_0x011B72
                move.w  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003A
                lsr.w   #$05, D0
                sub.w   D0, Obj_Player_Spdsh_Cnt(A0)                     ; $003A
                bcc.s   Offset_0x011B72
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
Offset_0x011B72:
                move.b  ($FFFFF603).w, D0
                andi.b  #$70, D0
                beq     Offset_0x011BA2
                move.w  #$0900, Obj_Ani_Number(A0)                       ; $001C
                move.w  #$00E0, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addi.w  #$0200, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                cmpi.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                bcs.s   Offset_0x011BA2
                move.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
Offset_0x011BA2:
                addq.l  #$04, A7
                rts     
;-------------------------------------------------------------------------------
Miles_SlopeResist:                                             ; Offset_0x011BA6
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x011BDA
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$0020, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $0014
                beq.s   Offset_0x011BDA
                bmi.s   Offset_0x011BD6
                tst.w   D0
                beq.s   Offset_0x011BD4
                add.w   D0, Obj_Inertia(A0)                              ; $0014
Offset_0x011BD4:
                rts
Offset_0x011BD6:
                add.w   D0, Obj_Inertia(A0)                              ; $0014
Offset_0x011BDA:
                rts   
;-------------------------------------------------------------------------------                
Miles_RollRepel:                                               ; Offset_0x011BDC
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x011C16
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$0050, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bmi.s   Offset_0x011C0C
                tst.w   D0
                bpl.s   Offset_0x011C06
                asr.l   #$02, D0
Offset_0x011C06:
                add.w   D0, Obj_Inertia(A0)                              ; $0014
                rts
Offset_0x011C0C:
                tst.w   D0
                bmi.s   Offset_0x011C12
                asr.l   #$02, D0
Offset_0x011C12:
                add.w   D0, Obj_Inertia(A0)                              ; $0014
Offset_0x011C16:
                rts    
;-------------------------------------------------------------------------------                
Miles_SlopeRepel:                                              ; Offset_0x011C18
                nop
                tst.b   Obj_Player_St_Convex(A0)                         ; $0038
                bne.s   Offset_0x011C52
                tst.w   Obj_Player_Control(A0)                           ; $002E
                bne.s   Offset_0x011C54
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x011C52
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bpl.s   Offset_0x011C3C
                neg.w   D0
Offset_0x011C3C:
                cmpi.w  #$0280, D0
                bcc.s   Offset_0x011C52
                clr.w   Obj_Inertia(A0)                                  ; $0014
                bset    #$01, Obj_Status(A0)                             ; $0022
                move.w  #$001E, Obj_Player_Control(A0)                   ; $002E
Offset_0x011C52:
                rts
Offset_0x011C54:
                subq.w  #$01, Obj_Player_Control(A0)                     ; $002E
                rts      
;-------------------------------------------------------------------------------                
Miles_JumpAngle:                                               ; Offset_0x011C5A
                move.b  Obj_Angle(A0), D0                                ; $0026
                beq.s   Offset_0x011C74
                bpl.s   Offset_0x011C6A
                addq.b  #$02, D0
                bcc.s   Offset_0x011C68
                moveq   #$00, D0
Offset_0x011C68:
                bra.s   Offset_0x011C70
Offset_0x011C6A:
                subq.b  #$02, D0
                bcc.s   Offset_0x011C70
                moveq   #$00, D0
Offset_0x011C70:
                move.b  D0, Obj_Angle(A0)                                ; $0026
Offset_0x011C74:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                beq.s   Offset_0x011CB8
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bmi.s   Offset_0x011C98
Offset_0x011C80:
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $002D
                add.b   D1, D0
                bcc.s   Offset_0x011C96
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $002C
                bcc.s   Offset_0x011C96
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                moveq   #$00, D0
Offset_0x011C96:
                bra.s   Offset_0x011CB4
Offset_0x011C98:
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $0029
                bne.s   Offset_0x011C80
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $002D
                sub.b   D1, D0
                bcc.s   Offset_0x011CB4
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $002C
                bcc.s   Offset_0x011CB4
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                moveq   #$00, D0
Offset_0x011CB4:
                move.b  D0, Obj_Flip_Angle(A0)                           ; $0027
Offset_0x011CB8:
                rts    
;-------------------------------------------------------------------------------                
Miles_Floor:                                                   ; Offset_0x011CBA
                move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
                cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
                beq.s   Offset_0x011CD2
                move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x011CD2:
                move.b  Obj_Player_LRB_Solid(A0), D5                     ; $003F
                move.w  Obj_Speed(A0), D1                                ; $0010
                move.w  Obj_Speed_Y(A0), D2                              ; $0012
                jsr     (CalcAngle)                            ; Offset_0x00351A
                move.b  D0, Obj_Player_Status(A0)                        ; $002B
                subi.b  #$20, D0
                andi.b  #$C0, D0
                cmpi.b  #$40, D0
                beq     Offset_0x011DA6
                cmpi.b  #$80, D0
                beq     Offset_0x011E08
                cmpi.b  #$C0, D0
                beq     Offset_0x011E64
                bsr     Player_HitWall                         ; Offset_0x014468
                tst.w   D1
                bpl.s   Offset_0x011D1A
                sub.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x011D1A:
                bsr     Offset_0x0142E6
                tst.w   D1
                bpl.s   Offset_0x011D2C
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x011D2C:
                bsr     Offset_0x0140A2
                tst.w   D1
                bpl.s   Offset_0x011DA4
                move.b  Obj_Speed_Y(A0), D2                              ; $0012
                addq.b  #$08, D2
                neg.b   D2
                cmp.b   D2, D1
                bge.s   Offset_0x011D44
                cmp.b   D2, D0
                blt.s   Offset_0x011DA4
Offset_0x011D44:
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetOnFloor                     ; Offset_0x011EC6
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x011D82
                move.b  D3, D0
                addi.b  #$10, D0
                andi.b  #$20, D0
                beq.s   Offset_0x011D74
                asr.w   Obj_Speed_Y(A0)                                  ; $0012
                bra.s   Offset_0x011D96
Offset_0x011D74:
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Speed(A0), Obj_Inertia(A0)            ; $0010, $0014
                rts
Offset_0x011D82:
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                cmpi.w  #$0FC0, Obj_Speed_Y(A0)                          ; $0012
                ble.s   Offset_0x011D96
                move.w  #$0FC0, Obj_Speed_Y(A0)                          ; $0012
Offset_0x011D96:
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                tst.b   D3
                bpl.s   Offset_0x011DA4
                neg.w   Obj_Inertia(A0)                                  ; $0014
Offset_0x011DA4:
                rts
Offset_0x011DA6:
                bsr     Player_HitWall                         ; Offset_0x014468
                tst.w   D1
                bpl.s   Offset_0x011DC0
                sub.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                rts
Offset_0x011DC0:
                bsr     Player_DontRunOnWalls                  ; Offset_0x014338
                tst.w   D1
                bpl.s   Offset_0x011DDA
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl.s   Offset_0x011DD8
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x011DD8:
                rts
Offset_0x011DDA:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x011E06
                bsr     Offset_0x0140A2
                tst.w   D1
                bpl.s   Offset_0x011E06
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetOnFloor                     ; Offset_0x011EC6
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Speed(A0), Obj_Inertia(A0)            ; $0010, $0014
Offset_0x011E06:
                rts
Offset_0x011E08:
                bsr     Player_HitWall                         ; Offset_0x014468
                tst.w   D1
                bpl.s   Offset_0x011E1A
                sub.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x011E1A:
                bsr     Offset_0x0142E6
                tst.w   D1
                bpl.s   Offset_0x011E2C
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x011E2C:
                bsr     Player_DontRunOnWalls                  ; Offset_0x014338
                tst.w   D1
                bpl.s   Offset_0x011E62
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x011E4C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                rts
Offset_0x011E4C:
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetOnFloor                     ; Offset_0x011EC6
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                tst.b   D3
                bpl.s   Offset_0x011E62
                neg.w   Obj_Inertia(A0)                                  ; $0014
Offset_0x011E62:
                rts
Offset_0x011E64:
                bsr     Offset_0x0142E6
                tst.w   D1
                bpl.s   Offset_0x011E7E
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                rts
Offset_0x011E7E:
                bsr     Player_DontRunOnWalls                  ; Offset_0x014338
                tst.w   D1
                bpl.s   Offset_0x011E98
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl.s   Offset_0x011E96
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x011E96:
                rts
Offset_0x011E98:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x011EC4
                bsr     Offset_0x0140A2
                tst.w   D1
                bpl.s   Offset_0x011EC4
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Miles_ResetOnFloor                     ; Offset_0x011EC6
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Speed(A0), Obj_Inertia(A0)            ; $0010, $0014
Offset_0x011EC4:
                rts
;-------------------------------------------------------------------------------
Miles_ResetOnFloor:                                            ; Offset_0x011EC6
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$01, Obj_Status(A0)                             ; $0022
                bclr    #$04, Obj_Status(A0)                             ; $0022
                btst    #$02, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011EFC
                bclr    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$0F, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                subq.w  #$01, Obj_Y(A0)                                  ; $000C
Offset_0x011EFC:
                move.b  #$00, Obj_Player_Jump(A0)                        ; $003C
                move.w  #$0000, ($FFFFF7D0).w
                move.b  #$00, Obj_Flip_Angle(A0)                         ; $0027
                move.b  #$00, Obj_Player_Flip_Flag(A0)                   ; $0029
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                cmpi.b  #$14, Obj_Ani_Number(A0)                         ; $001C
                bne.s   Offset_0x011F28
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
Offset_0x011F28:
                rts  
;-------------------------------------------------------------------------------
Miles_Hurt:                                                    ; Offset_0x011F2A
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                addi.w  #$0030, Obj_Speed_Y(A0)                          ; $0012
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x011F44
                subi.w  #$0020, Obj_Speed_Y(A0)                          ; $0012
Offset_0x011F44:
                bsr     Miles_HurtStop                         ; Offset_0x011F5E
                bsr     Miles_LevelBoundaries                  ; Offset_0x0118FE
                bsr     Miles_RecordMoves                      ; Offset_0x011376
                bsr     Miles_Animate                          ; Offset_0x012010
                bsr     Load_Miles_Dynamic_PLC                 ; Offset_0x0123EE
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------                
Miles_HurtStop:                                                ; Offset_0x011F5E
                move.w  (Miles_Level_Limits_Max_Y).w, D0             ; $FFFFEEFE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs     Kill_Miles                             ; Offset_0x012544
                bsr     Miles_Floor                            ; Offset_0x011CBA
                btst    #$01, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x011F9A
                moveq   #$00, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0078, Obj_P_Invunerblt_Time(A0)                ; $0030
Offset_0x011F9A:
                rts      
;-------------------------------------------------------------------------------
Miles_Death:                                                   ; Offset_0x011F9C
                bsr     Miles_GameOver                         ; Offset_0x011FB8
                jsr     (ObjectFall)                           ; Offset_0x00D1AE
                bsr     Miles_RecordMoves                      ; Offset_0x011376
                bsr     Miles_Animate                          ; Offset_0x012010
                bsr     Load_Miles_Dynamic_PLC                 ; Offset_0x0123EE
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------                
Miles_GameOver:                                                ; Offset_0x011FB8
                move.w  (Miles_Level_Limits_Max_Y).w, D0             ; $FFFFEEFE
                addi.w  #$0100, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc     Offset_0x011FFA
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                subi.w  #$0040, D0
                move.w  D0, Obj_X(A0)                                    ; $0008
                move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
                subi.w  #$0080, D0
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                andi.w  #$7FFF, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
                move.b  #$0D, Obj_Player_LRB_Solid(A0)                   ; $003F
                nop
Offset_0x011FFA:
                rts     
;-------------------------------------------------------------------------------  
Miles_ResetLevel:                                              ; Offset_0x011FFC
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003A
                beq.s   Offset_0x01200E
                subq.w  #$01, Obj_Player_Spdsh_Cnt(A0)                   ; $003A
                bne.s   Offset_0x01200E
                move.w  #$0001, ($FFFFFE02).w
Offset_0x01200E:
                rts
;-------------------------------------------------------------------------------                
Miles_Animate:                                                 ; Offset_0x012010
                lea     (Offset_0x01227A), A1
Miles_Animate_A1:                                              ; Offset_0x012016                
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $001C
                cmp.b   Obj_Ani_Flag(A0), D0                             ; $001D
                beq.s   Offset_0x012038
                move.b  D0, Obj_Ani_Flag(A0)                             ; $001D
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
                bclr    #$05, Obj_Status(A0)                             ; $0022
Offset_0x012038:
                add.w   D0, D0
                adda.w  $00(A1, D0), A1
                move.b  (A1), D0
                bmi.s   Offset_0x0120A8
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D1, Obj_Flags(A0)                                ; $0001
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x012076
                move.b  D0, Obj_Ani_Time(A0)                             ; $001E
Offset_0x01205E:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $001B
                move.b  $01(A1, D1), D0
                cmpi.b  #$F0, D0
                bcc.s   Offset_0x012078
Offset_0x01206E:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x012076:
                rts
Offset_0x012078:
                addq.b  #$01, D0
                bne.s   Offset_0x012088
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                move.b  Obj_Flags(A1), D0                                ; $0001
                bra.s   Offset_0x01206E
Offset_0x012088:
                addq.b  #$01, D0
                bne.s   Offset_0x01209C
                move.b  $02(A1, D1), D0
                sub.b   D0, Obj_Ani_Frame(A0)                            ; $001B
                sub.b   D0, D1
                move.b  $01(A1, D1), D0
                bra.s   Offset_0x01206E
Offset_0x01209C:
                addq.b  #$01, D0
                bne.s   Offset_0x0120A6
                move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $001C
Offset_0x0120A6:
                rts
Offset_0x0120A8:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x012076
                addq.b  #$01, D0
                bne     Offset_0x0121B0
                moveq   #$00, D0
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                bne     Offset_0x01214A
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bmi.s   Offset_0x0120CA
                beq.s   Offset_0x0120CA
                subq.b  #$01, D0
Offset_0x0120CA:
                move.b  Obj_Status(A0), D2                               ; $0022
                andi.b  #$01, D2
                bne.s   Offset_0x0120D6
                not.b   D0
Offset_0x0120D6:
                addi.b  #$10, D0
                bpl.s   Offset_0x0120DE
                moveq   #$03, D1
Offset_0x0120DE:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0001
                btst    #$05, Obj_Status(A0)                             ; $0022
                bne     Offset_0x0121F4
                lsr.b   #$04, D0
                andi.b  #$06, D0
                move.w  Obj_Inertia(A0), D2                              ; $0014
                bpl.s   Offset_0x012102
                neg.w   D2
Offset_0x012102:
                move.b  D0, D3
                add.b   D3, D3
                add.b   D3, D3
                lea     (Offset_0x0122BC), A1
                cmpi.w  #$0600, D2
                bcs.s   Offset_0x012130
                lea     (Offset_0x0122C6), A1
                move.b  D0, D1
                lsr.b   #$01, D1
                add.b   D1, D0
                add.b   D0, D0
                move.b  D0, D3
                cmpi.w  #$0700, D2
                bcs.s   Offset_0x012130
                lea     (Offset_0x0123B8), A1
Offset_0x012130:
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x01213A
                moveq   #$00, D2
Offset_0x01213A:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                bsr     Offset_0x01205E
                add.b   D3, Obj_Map_Id(A0)                               ; $001A
                rts
Offset_0x01214A:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $0022
                andi.b  #$01, D2
                bne.s   Offset_0x012178
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                addi.b  #$0B, D0
                divu.w  #$0016, D0
                addi.b  #$75, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
                rts
Offset_0x012178:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $0029
                beq.s   Offset_0x012190
                ori.b   #$01, Obj_Flags(A0)                              ; $0001
                addi.b  #$0B, D0
                bra.s   Offset_0x01219C
Offset_0x012190:
                ori.b   #$03, Obj_Flags(A0)                              ; $0001
                neg.b   D0
                addi.b  #$8F, D0
Offset_0x01219C:
                divu.w  #$0016, D0
                addi.b  #$75, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
                rts
Offset_0x0121B0:
                addq.b  #$01, D0
                bne.s   Offset_0x012226
                move.w  Obj_Inertia(A0), D2                              ; $0014
                bpl.s   Offset_0x0121BC
                neg.w   D2
Offset_0x0121BC:
                lea     (Offset_0x0122D5), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x0121CE
                lea     (Offset_0x0122D0), A1
Offset_0x0121CE:
                neg.w   D2
                addi.w  #$0400, D2
                bpl.s   Offset_0x0121D8
                moveq   #$00, D2
Offset_0x0121D8:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D1, Obj_Flags(A0)                                ; $0001
                bra     Offset_0x01205E
Offset_0x0121F4:
                move.w  Obj_Inertia(A0), D2                              ; $0014
                bmi.s   Offset_0x0121FC
                neg.w   D2
Offset_0x0121FC:
                addi.w  #$0800, D2
                bpl.s   Offset_0x012204
                moveq   #$00, D2
Offset_0x012204:
                lsr.w   #$06, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                lea     (Offset_0x0122DA), A1
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D1, Obj_Flags(A0)                                ; $0001
                bra     Offset_0x01205E
Offset_0x012226:
                move.w  ($FFFFB050).w, D1
                move.w  ($FFFFB052).w, D2
                jsr     (CalcAngle)                            ; Offset_0x00351A
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $0022
                andi.b  #$01, D2
                bne.s   Offset_0x012244
                not.b   D0
                bra.s   Offset_0x012248
Offset_0x012244:
                addi.b  #$80, D0
Offset_0x012248:
                addi.b  #$10, D0
                bpl.s   Offset_0x012250
                moveq   #$03, D1
Offset_0x012250:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0001
                lsr.b   #$03, D0
                andi.b  #$0C, D0
                move.b  D0, D3
                lea     (Offset_0x012514), A1
                move.b  #$03, Obj_Ani_Time(A0)                           ; $001E
                bsr     Offset_0x01205E
                add.b   D3, Obj_Map_Id(A0)                               ; $001A
                rts
;-------------------------------------------------------------------------------
Offset_0x01227A:
                dc.w    Offset_0x0122BC-Offset_0x01227A
                dc.w    Offset_0x0122C6-Offset_0x01227A
                dc.w    Offset_0x0122D0-Offset_0x01227A
                dc.w    Offset_0x0122D5-Offset_0x01227A
                dc.w    Offset_0x0122DA-Offset_0x01227A
                dc.w    Offset_0x0122E4-Offset_0x01227A
                dc.w    Offset_0x012322-Offset_0x01227A
                dc.w    Offset_0x01233A-Offset_0x01227A
                dc.w    Offset_0x01233D-Offset_0x01227A
                dc.w    Offset_0x012340-Offset_0x01227A
                dc.w    Offset_0x012345-Offset_0x01227A
                dc.w    Offset_0x012348-Offset_0x01227A
                dc.w    Offset_0x01234E-Offset_0x01227A
                dc.w    Offset_0x012352-Offset_0x01227A
                dc.w    Offset_0x012359-Offset_0x01227A
                dc.w    Offset_0x01235D-Offset_0x01227A
                dc.w    Offset_0x012364-Offset_0x01227A
                dc.w    Offset_0x012373-Offset_0x01227A
                dc.w    Offset_0x012377-Offset_0x01227A
                dc.w    Offset_0x01237D-Offset_0x01227A
                dc.w    Offset_0x012382-Offset_0x01227A
                dc.w    Offset_0x012386-Offset_0x01227A
                dc.w    Offset_0x01238D-Offset_0x01227A
                dc.w    Offset_0x012390-Offset_0x01227A
                dc.w    Offset_0x012393-Offset_0x01227A
                dc.w    Offset_0x012396-Offset_0x01227A
                dc.w    Offset_0x012399-Offset_0x01227A
                dc.w    Offset_0x01239C-Offset_0x01227A
                dc.w    Offset_0x0123A0-Offset_0x01227A
                dc.w    Offset_0x0123A4-Offset_0x01227A
                dc.w    Offset_0x0123AE-Offset_0x01227A
                dc.w    Offset_0x0123B8-Offset_0x01227A
                dc.w    Offset_0x0123C2-Offset_0x01227A
Offset_0x0122BC:
                dc.b    $FF, $10, $11, $12, $13, $14, $15, $0E
                dc.b    $0F, $FF
Offset_0x0122C6:
                dc.b    $FF, $2E, $2F, $30, $31, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x0122D0:
                dc.b    $01, $48, $47, $46, $FF
Offset_0x0122D5:
                dc.b    $01, $48, $47, $46, $FF
Offset_0x0122DA:
                dc.b    $FD, $63, $64, $65, $66, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x0122E4:
                dc.b    $07, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $03, $02, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $03, $02, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $05, $05, $05, $05, $05, $05, $05, $05
                dc.b    $05, $05, $05, $05, $05, $05, $05, $05
                dc.b    $06, $07, $08, $07, $08, $07, $08, $07
                dc.b    $08, $07, $08, $06, $FE, $1C
Offset_0x012322:
                dc.b    $09, $69, $69, $6A, $6A, $69, $69, $6A
                dc.b    $6A, $69, $69, $6A, $6A, $69, $69, $6A
                dc.b    $6A, $69, $69, $6A, $6A, $69, $6A, $FF
Offset_0x01233A:
                dc.b    $3F, $04, $FF
Offset_0x01233D:
                dc.b    $3F, $5B, $FF
Offset_0x012340:
                dc.b    $00, $60, $61, $62, $FF
Offset_0x012345:
                dc.b    $3F, $82, $FF
Offset_0x012348:
                dc.b    $07, $08, $08, $09, $FD, $05
Offset_0x01234E:
                dc.b    $07, $09, $FD, $05
Offset_0x012352:
                dc.b    $07, $67, $68, $67, $68, $FD, $00
Offset_0x012359:
                dc.b    $09, $6E, $73, $FF
Offset_0x01235D:
                dc.b    $09, $6E, $6F, $70, $71, $72, $FF
Offset_0x012364:
                dc.b    $03, $59, $5A, $59, $5A, $59, $5A, $59
                dc.b    $5A, $59, $5A, $59, $5A, $FD, $00
Offset_0x012373:
                dc.b    $05, $6C, $6D, $FF
Offset_0x012377:
                dc.b    $0F, $01, $02, $03, $FE, $01
Offset_0x01237D:
                dc.b    $0F, $01, $02, $FE, $01
Offset_0x012382:
                dc.b    $13, $85, $86, $FF
Offset_0x012386:
                dc.b    $0B, $74, $74, $12, $13, $FD, $00
Offset_0x01238D:
                dc.b    $20, $5D, $FF
Offset_0x012390:
                dc.b    $2F, $5D, $FF
Offset_0x012393:
                dc.b    $03, $5D, $FF
Offset_0x012396:
                dc.b    $03, $5D, $FF
Offset_0x012399:
                dc.b    $03, $5C, $FF
Offset_0x01239C:
                dc.b    $09, $6B, $5C, $FF
Offset_0x0123A0:
                dc.b    $77, $00, $FD, $00
Offset_0x0123A4:
                dc.b    $03, $01, $02, $03, $04, $05, $06, $07
                dc.b    $08, $FF
Offset_0x0123AE:
                dc.b    $03, $01, $02, $03, $04, $05, $06, $07
                dc.b    $08, $FF
Offset_0x0123B8:
                dc.b    $FF, $32, $33, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x0123C2:
                dc.b    $01, $5E, $5F, $FF   
;-------------------------------------------------------------------------------
Load_Miles_Tail_Dynamic_PLC:                                   ; Offset_0x0123C6
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                cmp.b   ($FFFFF7DF).w, D0
                beq.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x012440
                move.b  D0, ($FFFFF7DF).w
                lea     (Miles_Dyn_Script), A2                 ; Offset_0x07446C
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x012440
                move.w  #$F600, D4
                bra.s   Load_Miles_Dynamic_PLC_Loop            ; Offset_0x012414
;-------------------------------------------------------------------------------                
Load_Miles_Dynamic_PLC:                                        ; Offset_0x0123EE
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
Load_Miles_Dynamic_PLC_D0:                                     ;                 
                cmp.b   ($FFFFF7DE).w, D0
                beq.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x012440
                move.b  D0, ($FFFFF7DE).w
                lea     (Miles_Dyn_Script), A2                 ; Offset_0x07446C
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Exit_Load_Miles_Dynamic_PLC            ; Offset_0x012440
                move.w  #$F400, D4
Load_Miles_Dynamic_PLC_Loop:                                   ; Offset_0x012414
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                addi.l  #Art_Miles, D1                         ; Offset_0x064320
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
                dbra    D5, Load_Miles_Dynamic_PLC_Loop        ; Offset_0x012414
Exit_Load_Miles_Dynamic_PLC:                                   ; Offset_0x012440
                rts               
;===============================================================================
; Object 0x02 - Miles
; <<<-
;===============================================================================