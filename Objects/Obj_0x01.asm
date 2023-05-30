;===============================================================================
; Object 0x01 - Sonic
; ->>>
;===============================================================================  
; Offset_0x00FAF0:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Obj_Sonic                              ; Offset_0x00FAFC
                jmp     (Debug_Mode)                           ; Offset_0x02DE64
;-------------------------------------------------------------------------------                
Obj_Sonic                                                      ; Offset_0x00FAFC
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Sonic_Index(PC, D0), D1                ; Offset_0x00FB0A
                jmp     Sonic_Index(PC, D1)                    ; Offset_0x00FB0A
;-------------------------------------------------------------------------------
Sonic_Index:                                                   ; Offset_0x00FB0A  
                dc.w    Sonic_Main-Sonic_Index                 ; Offset_0x00FB14
                dc.w    Sonic_Control-Sonic_Index              ; Offset_0x00FB96
                dc.w    Sonic_Hurt-Sonic_Index                 ; Offset_0x010AAA
                dc.w    Sonic_Death-Sonic_Index                ; Offset_0x010B3E
                dc.w    Sonic_ResetLevel-Sonic_Index           ; Offset_0x010BDE   
;-------------------------------------------------------------------------------  
Sonic_Main:                                                    ; Offset_0x00FB14
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$13, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                move.l  #Sonic_Mappings, Obj_Map(A0)    ; Offset_0x06FBE0, $0004
                move.w  #$0780, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.w  #$0600, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$000C, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0080, (Sonic_Deceleration).w               ; $FFFFF764
                move.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
                move.b  #$0D, Obj_Player_LRB_Solid(A0)                   ; $003F
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                move.b  #$04, Obj_Player_Flip_Speed(A0)                  ; $002D
                move.b  #$00, (Super_Sonic_Flag).w                   ; $FFFFFE19
                move.b  #$1E, Obj_Subtype(A0)                            ; $0028
                move.w  #$0000, ($FFFFEED2).w
                move.w  #$003F, D2
Offset_0x00FB88:
                bsr     CopySonicMovesForMiles                 ; Offset_0x00FCD4
                move.w  #$0000, $00(A1, D0)
                dbra    D2, Offset_0x00FB88   
;-------------------------------------------------------------------------------                
Sonic_Control:                                                 ; Offset_0x00FB96
                tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
                beq.s   Offset_0x00FBB0
                btst    #$04, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Offset_0x00FBB0
                move.w  #$0001, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
                clr.b   ($FFFFF7CC).w
                rts
Offset_0x00FBB0:
                tst.b   ($FFFFF7CC).w
                bne.s   Offset_0x00FBBC
                move.w  (Control_Ports_Buffer_Data).w, ($FFFFF602).w ; $FFFFF604
Offset_0x00FBBC:
                btst    #$00, Obj_Timer(A0)                              ; $002A
                bne.s   Offset_0x00FBD6
                moveq   #$00, D0
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.w  #$0006, D0
                move.w  Sonic_Modes(PC, D0), D1               ; $Offset_0x00FC20
                jsr     Sonic_Modes(PC, D1)                   ; $Offset_0x00FC20
Offset_0x00FBD6:
                cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEECC
                bne.s   Offset_0x00FBE4
                andi.w  #$07FF, Obj_Y(A0)                                ; $000C
Offset_0x00FBE4:
                bsr.s   Sonic_Display                          ; Offset_0x00FC38
                bsr     CopySonicMovesForMiles                 ; Offset_0x00FCD4
                bsr     Sonic_Water                            ; Offset_0x00FCF8
                move.b  ($FFFFF768).w, Obj_Player_Next_Tilt(A0)          ; $0036
                move.b  ($FFFFF76A).w, Obj_Player_Tilt(A0)               ; $0037
                tst.b   ($FFFFF7C7).w
                beq.s   Offset_0x00FC0C
                tst.b   Obj_Ani_Number(A0)                               ; $001C
                bne.s   Offset_0x00FC0C
                move.b  Obj_Ani_Flag(A0), Obj_Ani_Number(A0)      ; $001C, $001D
Offset_0x00FC0C:
                bsr     Sonic_Animate                          ; Offset_0x010BF2
                tst.b   Obj_Timer(A0)                                    ; $002A
                bmi.s   Offset_0x00FC1C
                jsr     (TouchResponse)                        ; Offset_0x02B1EC
Offset_0x00FC1C:
                bra     Load_Sonic_Dynamic_PLC                 ; Offset_0x0110D4 
;-------------------------------------------------------------------------------
Sonic_Modes:                                                   ; Offset_0x00FC20
                dc.w    Sonic_MdNormal-Sonic_Modes             ; Offset_0x00FDE0
                dc.w    Sonic_MdJump-Sonic_Modes               ; Offset_0x00FE52
                dc.w    Sonic_MdRoll-Sonic_Modes               ; Offset_0x00FE7C
                dc.w    Sonic_MdJump2-Sonic_Modes              ; Offset_0x00FE9C 
;-------------------------------------------------------------------------------   
Sonic_PlayList:                                                ; Offset_0x00FC28
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
Sonic_Display:                                                 ; Offset_0x00FC38
                move.w  Obj_P_Invunerblt_Time(A0), D0                    ; $0030
                beq.s   Offset_0x00FC46
                subq.w  #$01, Obj_P_Invunerblt_Time(A0)                  ; $0030
                lsr.w   #$03, D0
                bcc.s   Offset_0x00FC4C
Offset_0x00FC46:
                jsr     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x00FC4C:
                tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
                beq.s   Offset_0x00FC86
                tst.w   Obj_P_Invcbility_Time(A0)                        ; $0032
                beq.s   Offset_0x00FC86
                subq.w  #$01, Obj_P_Invcbility_Time(A0)                  ; $0032
                bne.s   Offset_0x00FC86
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x00FC80
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x00FC80
                moveq   #$00, D0
                move.b  (Level_Id).w, D0                             ; $FFFFFE10
                lea     Sonic_PlayList(PC), A1                 ; Offset_0x00FC28
                move.b  $00(A1, D0), D0
                jsr     (Play_Music)                           ; Offset_0x00150C
Offset_0x00FC80:
                move.b  #$00, (Invincibility_Flag).w                 ; $FFFFFE2D
Offset_0x00FC86:
                tst.b   (Hi_Speed_Flag).w                            ; $FFFFFE2E
                beq.s   Offset_0x00FCD2
                tst.w   Obj_P_Spd_Shoes_Time(A0)                         ; $0034
                beq.s   Offset_0x00FCD2
                subq.w  #$01, Obj_P_Spd_Shoes_Time(A0)                   ; $0034
                bne.s   Offset_0x00FCD2
                move.w  #$0600, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$000C, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0080, (Sonic_Deceleration).w               ; $FFFFF764
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00FCC2
                move.w  #$0A00, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0030, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0100, (Sonic_Deceleration).w               ; $FFFFF764
Offset_0x00FCC2:
                move.b  #$00, (Hi_Speed_Flag).w                      ; $FFFFFE2E
                move.w  #$00FC, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
Offset_0x00FCD2:
                rts
;-------------------------------------------------------------------------------
CopySonicMovesForMiles:                                        ; Offset_0x00FCD4
                move.w  ($FFFFEED2).w, D0
                lea     ($FFFFE500).w, A1
                lea     $00(A1, D0), A1
                move.w  Obj_X(A0), (A1)+                                 ; $0008
                move.w  Obj_Y(A0), (A1)+                                 ; $000C
                addq.b  #$04, ($FFFFEED3).w
                lea     ($FFFFE400).w, A1
                move.w  (Control_Ports_Buffer_Data).w, $00(A1, D0)   ; $FFFFF604
                rts   
;-------------------------------------------------------------------------------
Sonic_Water:                                                   ; Offset_0x00FCF8
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                bne.s   Sonic_InLevelWithWater                 ; Offset_0x00FD00
Offset_0x00FCFE:
                rts 
;-------------------------------------------------------------------------------
Sonic_InLevelWithWater:                                        ; Offset_0x00FD00
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bge.s   Sonic_NotInWater                       ; Offset_0x00FD70
                bset    #$06, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00FCFE
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                move.b  #$0A, ($FFFFB340).w
                move.b  #$81, ($FFFFB368).w
                move.l  A0, ($FFFFB37C).w
                move.w  #$0300, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0006, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0040, (Sonic_Deceleration).w               ; $FFFFF764
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00FD52
                move.w  #$0500, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0018, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0080, (Sonic_Deceleration).w               ; $FFFFF764
Offset_0x00FD52:
                asr.w   Obj_Speed(A0)                                    ; $0010
                asr.w   Obj_Speed_Y(A0)                                  ; $0012
                asr.w   Obj_Speed_Y(A0)                                  ; $0012
                beq.s   Offset_0x00FCFE
                move.w  #$0100, ($FFFFB41C).w
                move.w  #$00AA, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------                
Sonic_NotInWater:                                              ; Offset_0x00FD70
                bclr    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00FCFE
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                move.w  #$0600, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$000C, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0080, (Sonic_Deceleration).w               ; $FFFFF764
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x00FDA8
                move.w  #$0A00, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0030, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0100, (Sonic_Deceleration).w               ; $FFFFF764
Offset_0x00FDA8:
                cmpi.b  #$04, Obj_Routine(A0)                            ; $0024
                beq.s   Offset_0x00FDB4
                asl.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x00FDB4:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                beq     Offset_0x00FCFE
                move.w  #$0100, ($FFFFB41C).w
                move.l  A0, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                cmpi.w  #$F000, Obj_Speed_Y(A0)                          ; $0012
                bgt.s   Offset_0x00FDD6
                move.w  #$F000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x00FDD6:
                move.w  #$00AA, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512    
;-------------------------------------------------------------------------------
Sonic_MdNormal:                                                ; Offset_0x00FDE0
                move.b  (Control_Ports_Buffer_Data+$0001).w, D0      ; $FFFFF605
                andi.b  #$70, D0
                bne.s   Offset_0x00FE2A
                cmpi.b  #$0A, Obj_Ani_Number(A0)                         ; $001C
                beq.s   Offset_0x00FE50
                cmpi.b  #$0B, Obj_Ani_Number(A0)                         ; $001C
                beq.s   Offset_0x00FE50
                cmpi.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                bne.s   Offset_0x00FE2A
                cmpi.b  #$1E, Obj_Ani_Frame(A0)                          ; $001B
                bcs.s   Offset_0x00FE2A
                move.b  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                andi.b  #$7F, D0
                beq.s   Offset_0x00FE50
                move.b  #$0A, Obj_Ani_Number(A0)                         ; $001C
                cmpi.b  #$AC, Obj_Ani_Frame(A0)                          ; $001B
                bcs.s   Offset_0x00FE50
                move.b  #$0B, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x00FE50
Offset_0x00FE2A:
                bsr     Sonic_Spindash                         ; Offset_0x01060E
                bsr     Sonic_Jump                             ; Offset_0x01051A
                bsr     Sonic_SlopeResist                      ; Offset_0x010726
                bsr     Sonic_Move                             ; Offset_0x00FEC6
                bsr     Sonic_Roll                             ; Offset_0x0104B4
                bsr     Sonic_LevelBoundaries                  ; Offset_0x010456
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                bsr     Player_AnglePos                        ; Offset_0x013694
                bsr     Sonic_SlopeRepel                       ; Offset_0x010798
Offset_0x00FE50:
                rts     
;-------------------------------------------------------------------------------
Sonic_MdJump:                                                  ; Offset_0x00FE52
                bsr     Sonic_JumpHeight                       ; Offset_0x0105D2
                bsr     Sonic_ChgJumpDir                       ; Offset_0x0103CA
                bsr     Sonic_LevelBoundaries                  ; Offset_0x010456
                jsr     (ObjectFall)                           ; Offset_0x00D1AE
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00FE72
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $0012
Offset_0x00FE72:
                bsr     Sonic_JumpAngle                        ; Offset_0x0107DA
                bsr     Sonic_Floor                            ; Offset_0x01083A
                rts             
;-------------------------------------------------------------------------------    
Sonic_MdRoll:                                                  ; Offset_0x00FE7C
                bsr     Sonic_Jump                             ; Offset_0x01051A
                bsr     Sonic_RollRepel                        ; Offset_0x01075C
                bsr     Sonic_RollSpeed                        ; Offset_0x0102D4
                bsr     Sonic_LevelBoundaries                  ; Offset_0x010456
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                bsr     Player_AnglePos                        ; Offset_0x013694
                bsr     Sonic_SlopeRepel                       ; Offset_0x010798
                rts     
;-------------------------------------------------------------------------------      
Sonic_MdJump2:                                                 ; Offset_0x00FE9C
                bsr     Sonic_JumpHeight                       ; Offset_0x0105D2
                bsr     Sonic_ChgJumpDir                       ; Offset_0x0103CA
                bsr     Sonic_LevelBoundaries                  ; Offset_0x010456
                jsr     (ObjectFall)                           ; Offset_0x00D1AE
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00FEBC
                subi.w  #$0028, Obj_Speed_Y(A0)                          ; $0012
Offset_0x00FEBC:
                bsr     Sonic_JumpAngle                        ; Offset_0x0107DA
                bsr     Sonic_Floor                            ; Offset_0x01083A
                rts      
;-------------------------------------------------------------------------------  
Sonic_Move:                                                    ; Offset_0x00FEC6
                move.w  (Sonic_Max_Speed).w, D6                      ; $FFFFF760
                move.w  (Sonic_Acceleration).w, D5                   ; $FFFFF762
                move.w  (Sonic_Deceleration).w, D4                   ; $FFFFF764
                tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
                bne     Offset_0x01013E
                tst.w   Obj_Player_Control(A0)                           ; $002E
                bne     Offset_0x010106
                btst    #$02, ($FFFFF602).w
                beq.s   Offset_0x00FEEE
                bsr     Offset_0x0101CE
Offset_0x00FEEE:
                btst    #$03, ($FFFFF602).w
                beq.s   Offset_0x00FEFA
                bsr     Offset_0x010254
Offset_0x00FEFA:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne     Offset_0x010106
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bne     Offset_0x010106
                bclr    #$05, Obj_Status(A0)                             ; $0022
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq     Offset_0x00FFF8
                moveq   #$00, D0
                move.b  Obj_Player_Last(A0), D0                          ; $003D
                lsl.w   #$06, D0
                lea     (Player_One).w, A1                           ; $FFFFB000
                lea     $00(A1, D0), A1
                tst.b   Obj_Status(A1)                                   ; $0022
                bmi     Offset_0x0100E8
                moveq   #$00, D1
                move.b  Obj_Width(A1), D1                                ; $0019
                move.w  D1, D2
                add.w   D2, D2
                subq.w  #$02, D2
                add.w   Obj_X(A0), D1                                    ; $0008
                sub.w   Obj_X(A1), D1                                    ; $0008
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne     Offset_0x00FF6A
                cmpi.w  #$0002, D1
                blt.s   Offset_0x00FFBA
                cmp.w   D2, D1
                bge.s   Offset_0x00FF7C
                bra     Offset_0x0100E8
Offset_0x00FF6A:
                cmpi.w  #$0002, D1
                blt     Offset_0x0100DA
                cmp.w   D2, D1
                bge     Offset_0x0100CA
                bra     Offset_0x0100E8
Offset_0x00FF7C:
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00FF9C
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                addq.w  #$06, D2
                cmp.w   D2, D1
                blt     Offset_0x010106
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $001C
                bra     Offset_0x010106
Offset_0x00FF9C:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $001C
                addq.w  #$06, D2
                cmp.w   D2, D1
                blt     Offset_0x010106
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $001C
                bclr    #$00, Obj_Status(A0)                             ; $0022
                bra     Offset_0x010106
Offset_0x00FFBA:
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00FFDA
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                cmpi.w  #$FFFC, D1
                bge     Offset_0x010106
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $001C
                bra     Offset_0x010106
Offset_0x00FFDA:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $001C
                cmpi.w  #$FFFC, D1
                bge     Offset_0x010106
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $001C
                bset    #$00, Obj_Status(A0)                             ; $0022
                bra     Offset_0x010106
Offset_0x00FFF8:
                jsr     (Player_HitFloor)                      ; Offset_0x014160
                cmpi.w  #$000C, D1
                blt     Offset_0x0100E8
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne     Offset_0x0100C2
                cmpi.b  #$03, Obj_Player_Next_Tilt(A0)                   ; $0036
                bne.s   Offset_0x01006C
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x010042
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                move.w  Obj_X(A0), D3                                    ; $0008
                subq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x014164
                cmpi.w  #$000C, D1
                blt     Offset_0x010106
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $001C
                bra     Offset_0x010106
Offset_0x010042:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $001C
                move.w  Obj_X(A0), D3                                    ; $0008
                subq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x014164
                cmpi.w  #$000C, D1
                blt     Offset_0x010106
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $001C
                bclr    #$00, Obj_Status(A0)                             ; $0022
                bra     Offset_0x010106
Offset_0x01006C:
                cmpi.b  #$03, Obj_Player_Tilt(A0)                        ; $0037
                bne.s   Offset_0x0100E8
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01009C
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                move.w  Obj_X(A0), D3                                    ; $0008
                addq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x014164
                cmpi.w  #$000C, D1
                blt.s   Offset_0x010106
                move.b  #$0C, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x010106
Offset_0x01009C:
                move.b  #$1D, Obj_Ani_Number(A0)                         ; $001C
                move.w  Obj_X(A0), D3                                    ; $0008
                addq.w  #$06, D3
                jsr     (Player_HitFloor_D3)                   ; Offset_0x014164
                cmpi.w  #$000C, D1
                blt.s   Offset_0x010106
                move.b  #$1E, Obj_Ani_Number(A0)                         ; $001C
                bset    #$00, Obj_Status(A0)                             ; $0022
                bra.s   Offset_0x010106
Offset_0x0100C2:
                cmpi.b  #$03, Obj_Player_Next_Tilt(A0)                   ; $0036
                bne.s   Offset_0x0100D2
Offset_0x0100CA:
                bclr    #$00, Obj_Status(A0)                             ; $0022
                bra.s   Offset_0x0100E0
Offset_0x0100D2:
                cmpi.b  #$03, Obj_Player_Tilt(A0)                        ; $0037
                bne.s   Offset_0x0100E8
Offset_0x0100DA:
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x0100E0:
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x010106
Offset_0x0100E8:
                btst    #$00, ($FFFFF602).w
                beq.s   Offset_0x0100F8
                move.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x010106
Offset_0x0100F8:
                btst    #$01, ($FFFFF602).w
                beq.s   Offset_0x010106
                move.b  #$08, Obj_Ani_Number(A0)                         ; $001C
Offset_0x010106:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq     Offset_0x010112
                move.w  #$000C, D5
Offset_0x010112:
                move.b  ($FFFFF602).w, D0
                andi.b  #$0C, D0
                bne.s   Offset_0x01013E
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x01013E
                bmi.s   Offset_0x010132
                sub.w   D5, D0
                bcc.s   Offset_0x01012C
                move.w  #$0000, D0
Offset_0x01012C:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                bra.s   Offset_0x01013E
Offset_0x010132:
                add.w   D5, D0
                bcc.s   Offset_0x01013A
                move.w  #$0000, D0
Offset_0x01013A:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
Offset_0x01013E:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  Obj_Inertia(A0), D1                              ; $0014
                asr.l   #$08, D1
                move.w  D1, Obj_Speed(A0)                                ; $0010
                muls.w  Obj_Inertia(A0), D0                              ; $0014
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
Offset_0x01015C:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$40, D0
                bmi.s   Offset_0x0101CC
                move.b  #$40, D1
                tst.w   Obj_Inertia(A0)                                  ; $0014
                beq.s   Offset_0x0101CC
                bmi.s   Offset_0x010174
                neg.w   D1
Offset_0x010174:
                move.b  Obj_Angle(A0), D0                                ; $0026
                add.b   D1, D0
                move.w  D0, -(A7)
                bsr     Player_WalkSpeed                       ; Offset_0x013FD8
                move.w  (A7)+, D0
                tst.w   D1
                bpl.s   Offset_0x0101CC
                asl.w   #$08, D1
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x0101C8
                cmpi.b  #$40, D0
                beq.s   Offset_0x0101B6
                cmpi.b  #$80, D0
                beq.s   Offset_0x0101B0
                add.w   D1, Obj_Speed(A0)                                ; $0010
                bset    #$05, Obj_Status(A0)                             ; $0022
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                rts
Offset_0x0101B0:
                sub.w   D1, Obj_Speed_Y(A0)                              ; $0012
                rts
Offset_0x0101B6:
                sub.w   D1, Obj_Speed(A0)                                ; $0010
                bset    #$05, Obj_Status(A0)                             ; $0022
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                rts
Offset_0x0101C8:
                add.w   D1, Obj_Speed_Y(A0)                              ; $0012
Offset_0x0101CC:
                rts
Offset_0x0101CE:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x0101D6
                bpl.s   Offset_0x010208
Offset_0x0101D6:
                bset    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0101EA
                bclr    #$05, Obj_Status(A0)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
Offset_0x0101EA:
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x0101FC
                add.w   D5, D0
                cmp.w   D1, D0
                ble.s   Offset_0x0101FC
                move.w  D1, D0
Offset_0x0101FC:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x010208:
                sub.w   D4, D0
                bcc.s   Offset_0x010210
                move.w  #$FF80, D0
Offset_0x010210:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x010252
                cmpi.w  #$0400, D0
                blt.s   Offset_0x010252
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $001C
                bclr    #$00, Obj_Status(A0)                             ; $0022
                move.w  #$00A4, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x010252
                move.b  #$06, ($FFFFB424).w
                move.b  #$15, ($FFFFB41A).w
Offset_0x010252:
                rts
Offset_0x010254:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bmi.s   Offset_0x010288
                bclr    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01026E
                bclr    #$05, Obj_Status(A0)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
Offset_0x01026E:
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x01027C
                sub.w   D5, D0
                cmp.w   D6, D0
                bge.s   Offset_0x01027C
                move.w  D6, D0
Offset_0x01027C:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x010288:
                add.w   D4, D0
                bcc.s   Offset_0x010290
                move.w  #$0080, D0
Offset_0x010290:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                bne.s   Offset_0x0102D2
                cmpi.w  #$FC00, D0
                bgt.s   Offset_0x0102D2
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $001C
                bset    #$00, Obj_Status(A0)                             ; $0022
                move.w  #$00A4, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x0102D2
                move.b  #$06, ($FFFFB424).w
                move.b  #$15, ($FFFFB41A).w
Offset_0x0102D2:
                rts
;-------------------------------------------------------------------------------                
Sonic_RollSpeed:                                               ; Offset_0x0102D4
                move.w  (Sonic_Max_Speed).w, D6                      ; $FFFFF760
                asl.w   #$01, D6
                move.w  (Sonic_Acceleration).w, D5                   ; $FFFFF762
                asr.w   #$01, D5
                move.w  #$0020, D4
                tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
                bne     Offset_0x01034E
                tst.w   Obj_Player_Control(A0)                           ; $002E
                bne.s   Offset_0x01030A
                btst    #$02, ($FFFFF602).w
                beq.s   Offset_0x0102FE
                bsr     Offset_0x010384
Offset_0x0102FE:
                btst    #$03, ($FFFFF602).w
                beq.s   Offset_0x01030A
                bsr     Offset_0x0103A8
Offset_0x01030A:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x01032C
                bmi.s   Offset_0x010320
                sub.w   D5, D0
                bcc.s   Offset_0x01031A
                move.w  #$0000, D0
Offset_0x01031A:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                bra.s   Offset_0x01032C
Offset_0x010320:
                add.w   D5, D0
                bcc.s   Offset_0x010328
                move.w  #$0000, D0
Offset_0x010328:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
Offset_0x01032C:
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bne.s   Offset_0x01034E
                bclr    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$13, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                subq.w  #$05, Obj_Y(A0)                                  ; $000C
Offset_0x01034E:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  Obj_Inertia(A0), D0                              ; $0014
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                muls.w  Obj_Inertia(A0), D1                              ; $0014
                asr.l   #$08, D1
                cmpi.w  #$1000, D1
                ble.s   Offset_0x010372
                move.w  #$1000, D1
Offset_0x010372:
                cmpi.w  #$F000, D1
                bge.s   Offset_0x01037C
                move.w  #$F000, D1
Offset_0x01037C:
                move.w  D1, Obj_Speed(A0)                                ; $0010
                bra     Offset_0x01015C
Offset_0x010384:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                beq.s   Offset_0x01038C
                bpl.s   Offset_0x01039A
Offset_0x01038C:
                bset    #$00, Obj_Status(A0)                             ; $0022
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x01039A:
                sub.w   D4, D0
                bcc.s   Offset_0x0103A2
                move.w  #$FF80, D0
Offset_0x0103A2:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                rts
Offset_0x0103A8:
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bmi.s   Offset_0x0103BC
                bclr    #$00, Obj_Status(A0)                             ; $0022
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x0103BC:
                add.w   D4, D0
                bcc.s   Offset_0x0103C4
                move.w  #$0080, D0
Offset_0x0103C4:
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                rts
;-------------------------------------------------------------------------------                
Sonic_ChgJumpDir:                                              ; Offset_0x0103CA
                move.w  (Sonic_Max_Speed).w, D6                      ; $FFFFF760
                move.w  (Sonic_Acceleration).w, D5                   ; $FFFFF762
                asl.w   #$01, D5
                btst    #$04, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x010414
                move.w  Obj_Speed(A0), D0                                ; $0010
                btst    #$02, ($FFFFF602).w
                beq.s   Offset_0x0103FA
                bset    #$00, Obj_Status(A0)                             ; $0022
                sub.w   D5, D0
                move.w  D6, D1
                neg.w   D1
                cmp.w   D1, D0
                bgt.s   Offset_0x0103FA
                move.w  D1, D0
Offset_0x0103FA:
                btst    #$03, ($FFFFF602).w
                beq.s   Offset_0x010410
                bclr    #$00, Obj_Status(A0)                             ; $0022
                add.w   D5, D0
                cmp.w   D6, D0
                blt.s   Offset_0x010410
                move.w  D6, D0
Offset_0x010410:
                move.w  D0, Obj_Speed(A0)                                ; $0010
Offset_0x010414:
                cmpi.w  #$0060, ($FFFFEED8).w
                beq.s   Offset_0x010426
                bcc.s   Offset_0x010422
                addq.w  #$04, ($FFFFEED8).w
Offset_0x010422:
                subq.w  #$02, ($FFFFEED8).w
Offset_0x010426:
                cmpi.w  #$FC00, Obj_Speed_Y(A0)                          ; $0012
                bcs.s   Offset_0x010454
                move.w  Obj_Speed(A0), D0                                ; $0010
                move.w  D0, D1
                asr.w   #$05, D1
                beq.s   Offset_0x010454
                bmi.s   Offset_0x010448
                sub.w   D1, D0
                bcc.s   Offset_0x010442
                move.w  #$0000, D0
Offset_0x010442:
                move.w  D0, Obj_Speed(A0)                                ; $0010
                rts
Offset_0x010448:
                sub.w   D1, D0
                bcs.s   Offset_0x010450
                move.w  #$0000, D0
Offset_0x010450:
                move.w  D0, Obj_Speed(A0)                                ; $0010
Offset_0x010454:
                rts
;-------------------------------------------------------------------------------                
Sonic_LevelBoundaries:                                         ; Offset_0x010456
                move.l  Obj_X(A0), D1                                    ; $0008
                move.w  Obj_Speed(A0), D0                                ; $0010
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D1
                swap.w  D1
                move.w  (Sonic_Level_Limits_Min_X).w, D0             ; $FFFFEEC8
                addi.w  #$0010, D0
                cmp.w   D1, D0
                bhi.s   Offset_0x01049C
                move.w  (Sonic_Level_Limits_Max_X).w, D0             ; $FFFFEECA
                addi.w  #$0128, D0
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x010484
                addi.w  #$0040, D0
Offset_0x010484:
                cmp.w   D1, D0
                bls.s   Offset_0x01049C
Offset_0x010488:
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                blt.s   Offset_0x010498
                rts
Offset_0x010498:
                bra     Kill_Sonic                             ; Offset_0x011128
Offset_0x01049C:
                move.w  D0, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Sub_Y(A0)                            ; $000A
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                bra.s   Offset_0x010488  
;-------------------------------------------------------------------------------                
Sonic_Roll:                                                    ; Offset_0x0104B4
                tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
                bne.s   Offset_0x0104DA
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bpl.s   Offset_0x0104C2
                neg.w   D0
Offset_0x0104C2:
                cmpi.w  #$0080, D0
                bcs.s   Offset_0x0104DA
                move.b  ($FFFFF602).w, D0
                andi.b  #$0C, D0
                bne.s   Offset_0x0104DA
                btst    #$01, ($FFFFF602).w
                bne.s   Offset_0x0104DC
Offset_0x0104DA:
                rts
Offset_0x0104DC:
                btst    #$02, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0104E6
                rts
Offset_0x0104E6:
                bset    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                addq.w  #$05, Obj_Y(A0)                                  ; $000C
                move.w  #$00BE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bne.s   Offset_0x010518
                move.w  #$0200, Obj_Inertia(A0)                          ; $0014
Offset_0x010518:
                rts   
;-------------------------------------------------------------------------------                
Sonic_Jump:                                                    ; Offset_0x01051A:
                move.b  ($FFFFF603).w, D0
                andi.b  #$70, D0
                beq     Offset_0x0105C8
                moveq   #$00, D0
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$80, D0
                bsr     CalcRoomOverHead                       ; Offset_0x01405E
                cmpi.w  #$0006, D1
                blt     Offset_0x0105C8
                move.w  #$0680, D2
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x01054A
                move.w  #$0800, D2
Offset_0x01054A:
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x010556
                move.w  #$0380, D2
Offset_0x010556:
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
                move.b  #$13, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                btst    #$02, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0105CA
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                bset    #$02, Obj_Status(A0)                             ; $0022
                addq.w  #$05, Obj_Y(A0)                                  ; $000C
Offset_0x0105C8:
                rts
Offset_0x0105CA:
                bset    #$04, Obj_Status(A0)                             ; $0022
                rts    
;-------------------------------------------------------------------------------                
Sonic_JumpHeight:                                              ; Offset_0x0105D2
                tst.b   Obj_Player_Jump(A0)                              ; $003C
                beq.s   Offset_0x0105FE
                move.w  #$FC00, D1
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0105E8
                move.w  #$FE00, D1
Offset_0x0105E8:
                cmp.w   Obj_Speed_Y(A0), D1                              ; $0012
                ble.s   Offset_0x0105FC
                move.b  ($FFFFF602).w, D0
                andi.b  #$70, D0
                bne.s   Offset_0x0105FC
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
Offset_0x0105FC:
                rts
Offset_0x0105FE:
                cmpi.w  #$F040, Obj_Speed_Y(A0)                          ; $0012
                bge.s   Offset_0x01060C
                move.w  #$F040, Obj_Speed_Y(A0)                          ; $0012
Offset_0x01060C:
                rts    
;-------------------------------------------------------------------------------                
Sonic_Spindash:                                                ; Offset_0x01060E
                tst.b   Obj_Player_Spdsh_Flag(A0)                        ; $0039
                bne.s   Offset_0x010656
                cmpi.b  #$08, Obj_Ani_Number(A0)                         ; $001C
                bne.s   Offset_0x010654
                move.b  ($FFFFF603).w, D0
                andi.b  #$70, D0
                beq     Offset_0x010654
                move.b  #$09, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$00E0, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.l  #$04, A7
                move.b  #$01, Obj_Player_Spdsh_Flag(A0)                  ; $0039
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x010654
                move.b  #$02, ($FFFFB41C).w
Offset_0x010654:
                rts
Offset_0x010656:
                move.b  ($FFFFF602).w, D0
                btst    #$01, D0
                bne.s   Offset_0x0106DA
                move.b  #$0E, Obj_Height_2(A0)                           ; $0016
                move.b  #$07, Obj_Width_2(A0)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                addq.w  #$05, Obj_Y(A0)                                  ; $000C
                move.b  #$00, Obj_Player_Spdsh_Flag(A0)                  ; $0039
                move.w  #$2000, ($FFFFEED0).w
                moveq   #$00, D0
                move.b  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003A
                add.w   D0, D0
                move.w  Sonic_Spindash_Speed(PC, D0), Obj_Inertia(A0) ; Offset_0x0106B6, $0014
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x01069C
                move.w  Super_Sonic_Spindash_Speed(PC, D0), Obj_Inertia(A0) ; Offset_0x0106C8, $0014
Offset_0x01069C:
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0106A8
                neg.w   Obj_Inertia(A0)                                  ; $0014
Offset_0x0106A8:
                bset    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$00, ($FFFFB41C).w
                bra.s   Offset_0x010722   
;-------------------------------------------------------------------------------
Sonic_Spindash_Speed:                                          ; Offset_0x0106B6
                dc.w    $0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
                dc.w    $0C00
;-------------------------------------------------------------------------------
Super_Sonic_Spindash_Speed:                                    ; Offset_0x0106C8
                dc.w    $0B00, $0B80, $0C00, $0C80, $0D00, $0D80, $0E00, $0E80
                dc.w    $0F00   
;-------------------------------------------------------------------------------  
Offset_0x0106DA:
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003A
                beq.s   Offset_0x0106F2
                move.w  Obj_Player_Spdsh_Cnt(A0), D0                     ; $003A
                lsr.w   #$05, D0
                sub.w   D0, Obj_Player_Spdsh_Cnt(A0)                     ; $003A
                bcc.s   Offset_0x0106F2
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
Offset_0x0106F2:
                move.b  ($FFFFF603).w, D0
                andi.b  #$70, D0
                beq     Offset_0x010722
                move.w  #$0900, Obj_Ani_Number(A0)                       ; $001C
                move.w  #$00E0, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addi.w  #$0200, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                cmpi.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                bcs.s   Offset_0x010722
                move.w  #$0800, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
Offset_0x010722:
                addq.l  #$04, A7
                rts       
;-------------------------------------------------------------------------------                
Sonic_SlopeResist:                                             ; Offset_0x010726
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x01075A
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$0020, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $0014
                beq.s   Offset_0x01075A
                bmi.s   Offset_0x010756
                tst.w   D0
                beq.s   Offset_0x010754
                add.w   D0, Obj_Inertia(A0)                              ; $0014
Offset_0x010754:
                rts
Offset_0x010756:
                add.w   D0, Obj_Inertia(A0)                              ; $0014
Offset_0x01075A:
                rts    
;-------------------------------------------------------------------------------                
Sonic_RollRepel:                                               ; Offset_0x01075C
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$60, D0
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x010796
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$0050, D0
                asr.l   #$08, D0
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bmi.s   Offset_0x01078C
                tst.w   D0
                bpl.s   Offset_0x010786
                asr.l   #$02, D0
Offset_0x010786:
                add.w   D0, Obj_Inertia(A0)                              ; $0014
                rts
Offset_0x01078C:
                tst.w   D0
                bmi.s   Offset_0x010792
                asr.l   #$02, D0
Offset_0x010792:
                add.w   D0, Obj_Inertia(A0)                              ; $0014
Offset_0x010796:
                rts    
;-------------------------------------------------------------------------------                
Sonic_SlopeRepel:                                              ; Offset_0x010798
                nop
                tst.b   Obj_Player_St_Convex(A0)                         ; $0038
                bne.s   Offset_0x0107D2
                tst.w   Obj_Player_Control(A0)                           ; $002E
                bne.s   Offset_0x0107D4
                move.b  Obj_Angle(A0), D0                                ; $0026
                addi.b  #$20, D0
                andi.b  #$C0, D0
                beq.s   Offset_0x0107D2
                move.w  Obj_Inertia(A0), D0                              ; $0014
                bpl.s   Offset_0x0107BC
                neg.w   D0
Offset_0x0107BC:
                cmpi.w  #$0280, D0
                bcc.s   Offset_0x0107D2
                clr.w   Obj_Inertia(A0)                                  ; $0014
                bset    #$01, Obj_Status(A0)                             ; $0022
                move.w  #$001E, Obj_Player_Control(A0)                   ; $002E
Offset_0x0107D2:
                rts
Offset_0x0107D4:
                subq.w  #$01, Obj_Player_Control(A0)                     ; $002E
                rts     
;-------------------------------------------------------------------------------                 
Sonic_JumpAngle:                                               ; Offset_0x0107DA
                move.b  Obj_Angle(A0), D0                                ; $0026
                beq.s   Offset_0x0107F4
                bpl.s   Offset_0x0107EA
                addq.b  #$02, D0
                bcc.s   Offset_0x0107E8
                moveq   #$00, D0
Offset_0x0107E8:
                bra.s   Offset_0x0107F0
Offset_0x0107EA:
                subq.b  #$02, D0
                bcc.s   Offset_0x0107F0
                moveq   #$00, D0
Offset_0x0107F0:
                move.b  D0, Obj_Angle(A0)                                ; $0026
Offset_0x0107F4:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                beq.s   Offset_0x010838
                tst.w   Obj_Inertia(A0)                                  ; $0014
                bmi.s   Offset_0x010818
Offset_0x010800:
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $002D
                add.b   D1, D0
                bcc.s   Offset_0x010816
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $002C
                bcc.s   Offset_0x010816
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                moveq   #$00, D0
Offset_0x010816:
                bra.s   Offset_0x010834
Offset_0x010818:
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $0029
                bne.s   Offset_0x010800
                move.b  Obj_Player_Flip_Speed(A0), D1                    ; $002D
                sub.b   D1, D0
                bcc.s   Offset_0x010834
                subq.b  #$01, Obj_P_Flips_Remaining(A0)                  ; $002C
                bcc.s   Offset_0x010834
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                moveq   #$00, D0
Offset_0x010834:
                move.b  D0, Obj_Flip_Angle(A0)                           ; $0027
Offset_0x010838:
                rts              
;-------------------------------------------------------------------------------                
Sonic_Floor:                                                   ; Offset_0x01083A
                move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
                cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
                beq.s   Offset_0x010852
                move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x010852:
                move.b  Obj_Player_LRB_Solid(A0), D5                     ; $003F
                move.w  Obj_Speed(A0), D1                                ; $0010
                move.w  Obj_Speed_Y(A0), D2                              ; $0012
                jsr     (CalcAngle)                            ; Offset_0x00351A
                move.b  D0, Obj_Player_Status(A0)                        ; $002B
                subi.b  #$20, D0
                andi.b  #$C0, D0
                cmpi.b  #$40, D0
                beq     Offset_0x010926
                cmpi.b  #$80, D0
                beq     Offset_0x010988
                cmpi.b  #$C0, D0
                beq     Offset_0x0109E4
                bsr     Player_HitWall                         ; Offset_0x014468
                tst.w   D1
                bpl.s   Offset_0x01089A
                sub.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x01089A:
                bsr     Offset_0x0142E6
                tst.w   D1
                bpl.s   Offset_0x0108AC
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x0108AC:
                bsr     Offset_0x0140A2
                tst.w   D1
                bpl.s   Offset_0x010924
                move.b  Obj_Speed_Y(A0), D2                              ; $0012
                addq.b  #$08, D2
                neg.b   D2
                cmp.b   D2, D1
                bge.s   Offset_0x0108C4
                cmp.b   D2, D0
                blt.s   Offset_0x010924
Offset_0x0108C4:
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Sonic_ResetOnFloor                     ; Offset_0x010A46
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x010902
                move.b  D3, D0
                addi.b  #$10, D0
                andi.b  #$20, D0
                beq.s   Offset_0x0108F4
                asr.w   Obj_Speed_Y(A0)                                  ; $0012
                bra.s   Offset_0x010916
Offset_0x0108F4:
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Speed(A0), Obj_Inertia(A0)            ; $0010, $0014
                rts
Offset_0x010902:
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                cmpi.w  #$0FC0, Obj_Speed_Y(A0)                          ; $0012
                ble.s   Offset_0x010916
                move.w  #$0FC0, Obj_Speed_Y(A0)                          ; $0012
Offset_0x010916:
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                tst.b   D3
                bpl.s   Offset_0x010924
                neg.w   Obj_Inertia(A0)                                  ; $0014
Offset_0x010924:
                rts
Offset_0x010926:
                bsr     Player_HitWall                         ; Offset_0x014468
                tst.w   D1
                bpl.s   Offset_0x010940
                sub.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                rts
Offset_0x010940:
                bsr     Player_DontRunOnWalls                  ; Offset_0x014338
                tst.w   D1
                bpl.s   Offset_0x01095A
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl.s   Offset_0x010958
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x010958:
                rts
Offset_0x01095A:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x010986
                bsr     Offset_0x0140A2
                tst.w   D1
                bpl.s   Offset_0x010986
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Sonic_ResetOnFloor                     ; Offset_0x010A46
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Speed(A0), Obj_Inertia(A0)            ; $0010, $0014
Offset_0x010986:
                rts
Offset_0x010988:
                bsr     Player_HitWall                         ; Offset_0x014468
                tst.w   D1
                bpl.s   Offset_0x01099A
                sub.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x01099A:
                bsr     Offset_0x0142E6
                tst.w   D1
                bpl.s   Offset_0x0109AC
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
Offset_0x0109AC:
                bsr     Player_DontRunOnWalls                  ; Offset_0x014338
                tst.w   D1
                bpl.s   Offset_0x0109E2
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, D0
                addi.b  #$20, D0
                andi.b  #$40, D0
                bne.s   Offset_0x0109CC
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                rts
Offset_0x0109CC:
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Sonic_ResetOnFloor                     ; Offset_0x010A46
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                tst.b   D3
                bpl.s   Offset_0x0109E2
                neg.w   Obj_Inertia(A0)                                  ; $0014
Offset_0x0109E2:
                rts
Offset_0x0109E4:
                bsr     Offset_0x0142E6
                tst.w   D1
                bpl.s   Offset_0x0109FE
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  Obj_Speed_Y(A0), Obj_Inertia(A0)          ; $0012, $0014
                rts
Offset_0x0109FE:
                bsr     Player_DontRunOnWalls                  ; Offset_0x014338
                tst.w   D1
                bpl.s   Offset_0x010A18
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl.s   Offset_0x010A16
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
Offset_0x010A16:
                rts
Offset_0x010A18:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x010A44
                bsr     Offset_0x0140A2
                tst.w   D1
                bpl.s   Offset_0x010A44
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  D3, Obj_Angle(A0)                                ; $0026
                bsr     Sonic_ResetOnFloor                     ; Offset_0x010A46
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Speed(A0), Obj_Inertia(A0)            ; $0010, $0014
Offset_0x010A44:
                rts
;-------------------------------------------------------------------------------                
Sonic_ResetOnFloor:                                            ; Offset_0x010A46
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$01, Obj_Status(A0)                             ; $0022
                bclr    #$04, Obj_Status(A0)                             ; $0022
                btst    #$02, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x010A7C
                bclr    #$02, Obj_Status(A0)                             ; $0022
                move.b  #$13, Obj_Height_2(A0)                           ; $0016
                move.b  #$09, Obj_Width_2(A0)                            ; $0017
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                subq.w  #$05, Obj_Y(A0)                                  ; $000C
Offset_0x010A7C:
                move.b  #$00, Obj_Player_Jump(A0)                        ; $003C
                move.w  #$0000, ($FFFFF7D0).w
                move.b  #$00, Obj_Flip_Angle(A0)                         ; $0027
                move.b  #$00, Obj_Player_Flip_Flag(A0)                   ; $0029
                move.b  #$00, Obj_P_Flips_Remaining(A0)                  ; $002C
                cmpi.b  #$14, Obj_Ani_Number(A0)                         ; $001C
                bne.s   Offset_0x010AA8
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
Offset_0x010AA8:
                rts   
;-------------------------------------------------------------------------------
Sonic_Hurt:                                                    ; Offset_0x010AAA
                tst.b   Obj_Routine_2(A0)                                ; $0025
                bmi     Offset_0x010B22
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                addi.w  #$0030, Obj_Speed_Y(A0)                          ; $0012
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x010ACC
                subi.w  #$0020, Obj_Speed_Y(A0)                          ; $0012
Offset_0x010ACC:
                bsr     Sonic_HurtStop                         ; Offset_0x010AE6
                bsr     Sonic_LevelBoundaries                  ; Offset_0x010456
                bsr     CopySonicMovesForMiles                 ; Offset_0x00FCD4
                bsr     Sonic_Animate                          ; Offset_0x010BF2
                bsr     Load_Sonic_Dynamic_PLC                 ; Offset_0x0110D4
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Sonic_HurtStop:                                                ; Offset_0x010AE6
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs     Kill_Sonic                             ; Offset_0x011128
                bsr     Sonic_Floor                            ; Offset_0x01083A
                btst    #$01, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x010B20
                moveq   #$00, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D0, Obj_Inertia(A0)                              ; $0014
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0078, Obj_P_Invunerblt_Time(A0)                ; $0030
Offset_0x010B20:
                rts   
;-------------------------------------------------------------------------------
Offset_0x010B22:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                bsr     CopySonicMovesForMiles                 ; Offset_0x00FCD4
                bsr     Sonic_Animate                          ; Offset_0x010BF2
                bsr     Load_Sonic_Dynamic_PLC                 ; Offset_0x0110D4
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Sonic_Death:                                                   ; Offset_0x010B3E
                bsr     Sonic_GameOver                         ; Offset_0x010B5A
                jsr     (ObjectFall)                           ; Offset_0x00D1AE
                bsr     CopySonicMovesForMiles                 ; Offset_0x00FCD4
                bsr     Sonic_Animate                          ; Offset_0x010BF2
                bsr     Load_Sonic_Dynamic_PLC                 ; Offset_0x0110D4
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;-------------------------------------------------------------------------------                
Sonic_GameOver:                                                ; Offset_0x010B5A
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$0100, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc     Offset_0x010BDC
                move.w  #$FFC8, Obj_Speed_Y(A0)                          ; $0012
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                clr.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
                subq.b  #$01, (Life_Count).w                         ; $FFFFFE12
                bne.s   Offset_0x010BB0
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                move.b  #$39, ($FFFFB080).w
                move.b  #$39, ($FFFFB0C0).w
                move.b  #$01, ($FFFFB0DA).w
                clr.b   ($FFFFFE1A).w
Offset_0x010B9E:
                move.w  #$009B, D0
                jsr     (Play_Music)                           ; Offset_0x00150C
                moveq   #$03, D0
                jmp     (LoadPLC)                              ; Offset_0x001794
Offset_0x010BB0:
                move.w  #$003C, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                tst.b   ($FFFFFE1A).w
                beq.s   Offset_0x010BDC
                move.w  #$0000, Obj_Player_Spdsh_Cnt(A0)                 ; $003A
                move.b  #$39, ($FFFFB080).w
                move.b  #$39, ($FFFFB0C0).w
                move.b  #$02, ($FFFFB09A).w
                move.b  #$03, ($FFFFB0DA).w
                bra.s   Offset_0x010B9E
Offset_0x010BDC:
                rts    
;-------------------------------------------------------------------------------
Sonic_ResetLevel:                                              ; Offset_0x010BDE
                tst.w   Obj_Player_Spdsh_Cnt(A0)                         ; $003A
                beq.s   Offset_0x010BF0
                subq.w  #$01, Obj_Player_Spdsh_Cnt(A0)                   ; $003A
                bne.s   Offset_0x010BF0
                move.w  #$0001, ($FFFFFE02).w
Offset_0x010BF0:
                rts
;-------------------------------------------------------------------------------
Sonic_Animate:                                                 ; Offset_0x010BF2
                lea     (Offset_0x010EB0), A1
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x010C04
                lea     (Offset_0x011052), A1
Offset_0x010C04:
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $001C
                cmp.b   Obj_Ani_Flag(A0), D0                             ; $001D
                beq.s   Offset_0x010C26
                move.b  D0, Obj_Ani_Flag(A0)                             ; $001D
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
                bclr    #$05, Obj_Status(A0)                             ; $0022
Offset_0x010C26:
                add.w   D0, D0
                adda.w  $00(A1, D0), A1
                move.b  (A1), D0
                bmi.s   Offset_0x010C96
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D1, Obj_Flags(A0)                                ; $0001
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x010C64
                move.b  D0, Obj_Ani_Time(A0)                             ; $001E
Offset_0x010C4C:
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $001B
                move.b  $01(A1, D1), D0
                cmpi.b  #$F0, D0
                bcc.s   Offset_0x010C66
Offset_0x010C5C:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x010C64:
                rts
Offset_0x010C66:
                addq.b  #$01, D0
                bne.s   Offset_0x010C76
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                move.b  Obj_Flags(A1), D0                                ; $0001
                bra.s   Offset_0x010C5C
Offset_0x010C76:
                addq.b  #$01, D0
                bne.s   Offset_0x010C8A
                move.b  $02(A1, D1), D0
                sub.b   D0, Obj_Ani_Frame(A0)                            ; $001B
                sub.b   D0, D1
                move.b  $01(A1, D1), D0
                bra.s   Offset_0x010C5C
Offset_0x010C8A:
                addq.b  #$01, D0
                bne.s   Offset_0x010C94
                move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $001C
Offset_0x010C94:
                rts
Offset_0x010C96:
                addq.b  #$01, D0
                bne     Offset_0x010E1E
                moveq   #$00, D0
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                bne     Offset_0x010DB8
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bmi.s   Offset_0x010CB2
                beq.s   Offset_0x010CB2
                subq.b  #$01, D0
Offset_0x010CB2:
                move.b  Obj_Status(A0), D2                               ; $0022
                andi.b  #$01, D2
                bne.s   Offset_0x010CBE
                not.b   D0
Offset_0x010CBE:
                addi.b  #$10, D0
                bpl.s   Offset_0x010CC6
                moveq   #$03, D1
Offset_0x010CC6:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                eor.b   D1, D2
                or.b    D2, Obj_Flags(A0)                                ; $0001
                btst    #$05, Obj_Status(A0)                             ; $0022
                bne     Offset_0x010E6A
                lsr.b   #$04, D0
                andi.b  #$06, D0
                move.w  Obj_Inertia(A0), D2                              ; $0014
                bpl.s   Offset_0x010CEA
                neg.w   D2
Offset_0x010CEA:
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                bne.s   Offset_0x010D46
                lea     (Offset_0x010EFA), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x010D04
                lea     (Offset_0x010EF0), A1
                add.b   D0, D0
Offset_0x010D04:
                add.b   D0, D0
                move.b  D0, D3
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $001B
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x010D22
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                move.b  Obj_Flags(A1), D0                                ; $0001
Offset_0x010D22:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                add.b   D3, Obj_Map_Id(A0)                               ; $001A
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x010D44
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x010D3A
                moveq   #$00, D2
Offset_0x010D3A:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x010D44:
                rts
Offset_0x010D46:
                lea     (Offset_0x01109C), A1
                cmpi.w  #$0800, D2
                bcc.s   Offset_0x010D5E
                lea     (Offset_0x011092), A1
                add.b   D0, D0
                add.b   D0, D0
                bra.s   Offset_0x010D60
Offset_0x010D5E:
                lsr.b   #$01, D0
Offset_0x010D60:
                move.b  D0, D3
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $001B
                move.b  $01(A1, D1), D0
                cmpi.b  #$FF, D0
                bne.s   Offset_0x010D7C
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                move.b  Obj_Flags(A1), D0                                ; $0001
Offset_0x010D7C:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                add.b   D3, Obj_Map_Id(A0)                               ; $001A
                move.b  ($FFFFFE05).w, D1
                andi.b  #$03, D1
                bne.s   Offset_0x010D9C
                cmpi.b  #$B5, Obj_Map_Id(A0)                             ; $001A
                bcc.s   Offset_0x010D9C
                addi.b  #$20, Obj_Map_Id(A0)                             ; $001A
Offset_0x010D9C:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x010DB6
                neg.w   D2
                addi.w  #$0800, D2
                bpl.s   Offset_0x010DAC
                moveq   #$00, D2
Offset_0x010DAC:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x010DB6:
                rts
Offset_0x010DB8:
                move.b  Obj_Flip_Angle(A0), D0                           ; $0027
                moveq   #$00, D1
                move.b  Obj_Status(A0), D2                               ; $0022
                andi.b  #$01, D2
                bne.s   Offset_0x010DE6
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                addi.b  #$0B, D0
                divu.w  #$0016, D0
                addi.b  #$5F, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
                rts
Offset_0x010DE6:
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                tst.b   Obj_Player_Flip_Flag(A0)                         ; $0029
                beq.s   Offset_0x010DFE
                ori.b   #$01, Obj_Flags(A0)                              ; $0001
                addi.b  #$0B, D0
                bra.s   Offset_0x010E0A
Offset_0x010DFE:
                ori.b   #$03, Obj_Flags(A0)                              ; $0001
                neg.b   D0
                addi.b  #$8F, D0
Offset_0x010E0A:
                divu.w  #$0016, D0
                addi.b  #$5F, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
                rts
Offset_0x010E1E:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl     Offset_0x010C64
                addq.b  #$01, D0
                bne.s   Offset_0x010E6A
                move.w  Obj_Inertia(A0), D2                              ; $0014
                bpl.s   Offset_0x010E32
                neg.w   D2
Offset_0x010E32:
                lea     (Offset_0x010F0E), A1
                cmpi.w  #$0600, D2
                bcc.s   Offset_0x010E44
                lea     (Offset_0x010F04), A1
Offset_0x010E44:
                neg.w   D2
                addi.w  #$0400, D2
                bpl.s   Offset_0x010E4E
                moveq   #$00, D2
Offset_0x010E4E:
                lsr.w   #$08, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D1, Obj_Flags(A0)                                ; $0001
                bra     Offset_0x010C4C
Offset_0x010E6A:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl     Offset_0x010C64
                move.w  Obj_Inertia(A0), D2                              ; $0014
                bmi.s   Offset_0x010E7A
                neg.w   D2
Offset_0x010E7A:
                addi.w  #$0800, D2
                bpl.s   Offset_0x010E82
                moveq   #$00, D2
Offset_0x010E82:
                lsr.w   #$06, D2
                move.b  D2, Obj_Ani_Time(A0)                             ; $001E
                lea     (Offset_0x010F18), A1
                tst.b   (Super_Sonic_Flag).w                         ; $FFFFFE19
                beq.s   Offset_0x010E9A
                lea     (Offset_0x0110A6), A1
Offset_0x010E9A:
                move.b  Obj_Status(A0), D1                               ; $0022
                andi.b  #$01, D1
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D1, Obj_Flags(A0)                                ; $0001
                bra     Offset_0x010C4C
;-------------------------------------------------------------------------------
Offset_0x010EB0:
                dc.w    Offset_0x010EF0-Offset_0x010EB0
                dc.w    Offset_0x010EFA-Offset_0x010EB0
                dc.w    Offset_0x010F04-Offset_0x010EB0
                dc.w    Offset_0x010F0E-Offset_0x010EB0
                dc.w    Offset_0x010F18-Offset_0x010EB0
                dc.w    Offset_0x010F22-Offset_0x010EB0
                dc.w    Offset_0x010FD8-Offset_0x010EB0
                dc.w    Offset_0x010FDE-Offset_0x010EB0
                dc.w    Offset_0x010FE3-Offset_0x010EB0
                dc.w    Offset_0x010FE8-Offset_0x010EB0
                dc.w    Offset_0x010FF4-Offset_0x010EB0
                dc.w    Offset_0x010FF8-Offset_0x010EB0
                dc.w    Offset_0x010FFC-Offset_0x010EB0
                dc.w    Offset_0x011002-Offset_0x010EB0
                dc.w    Offset_0x011009-Offset_0x010EB0
                dc.w    Offset_0x01100D-Offset_0x010EB0
                dc.w    Offset_0x011014-Offset_0x010EB0
                dc.w    Offset_0x011018-Offset_0x010EB0
                dc.w    Offset_0x01101C-Offset_0x010EB0
                dc.w    Offset_0x011022-Offset_0x010EB0
                dc.w    Offset_0x011027-Offset_0x010EB0
                dc.w    Offset_0x01102B-Offset_0x010EB0
                dc.w    Offset_0x011032-Offset_0x010EB0
                dc.w    Offset_0x011035-Offset_0x010EB0
                dc.w    Offset_0x011038-Offset_0x010EB0
                dc.w    Offset_0x01103B-Offset_0x010EB0
                dc.w    Offset_0x01103B-Offset_0x010EB0
                dc.w    Offset_0x01103E-Offset_0x010EB0
                dc.w    Offset_0x011042-Offset_0x010EB0
                dc.w    Offset_0x011046-Offset_0x010EB0
                dc.w    Offset_0x01104A-Offset_0x010EB0
                dc.w    Offset_0x0110C3-Offset_0x010EB0
Offset_0x010EF0:
                dc.b    $FF, $0F, $10, $11, $12, $13, $14, $0D
                dc.b    $0E, $FF
Offset_0x010EFA:
                dc.b    $FF, $2D, $2E, $2F, $30, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x010F04:
                dc.b    $FE, $3D, $41, $3E, $41, $3F, $41, $40
                dc.b    $41, $FF
Offset_0x010F0E:
                dc.b    $FE, $3D, $41, $3E, $41, $3F, $41, $40
                dc.b    $41, $FF
Offset_0x010F18:
                dc.b    $FD, $48, $49, $4A, $4B, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x010F22:
                dc.b    $05, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $02
                dc.b    $03, $03, $03, $03, $03, $04, $04, $04
                dc.b    $05, $05, $05, $04, $04, $04, $05, $05
                dc.b    $05, $04, $04, $04, $05, $05, $05, $04
                dc.b    $04, $04, $05, $05, $05, $06, $06, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $04
                dc.b    $04, $04, $05, $05, $05, $04, $04, $04
                dc.b    $05, $05, $05, $04, $04, $04, $05, $05
                dc.b    $05, $04, $04, $04, $05, $05, $05, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $04, $04, $04, $05, $05, $05, $04
                dc.b    $04, $04, $05, $05, $05, $04, $04, $04
                dc.b    $05, $05, $05, $04, $04, $04, $05, $05
                dc.b    $05, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $04, $04, $04, $05, $05
                dc.b    $05, $04, $04, $04, $05, $05, $05, $04
                dc.b    $04, $04, $05, $05, $05, $04, $04, $04
                dc.b    $05, $05, $05, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $06, $06, $07, $08, $08
                dc.b    $08, $09, $09, $09, $FE, $06
Offset_0x010FD8:
                dc.b    $09, $CC, $CD, $CE, $CD, $FF
Offset_0x010FDE:
                dc.b    $05, $0B, $0C, $FE, $01
Offset_0x010FE3:
                dc.b    $05, $4C, $4D, $FE, $01
Offset_0x010FE8:
                dc.b    $00, $42, $43, $42, $44, $42, $45, $42
                dc.b    $46, $42, $47, $FF
Offset_0x010FF4:
                dc.b    $01, $02, $FD, $00
Offset_0x010FF8:
                dc.b    $03, $0A, $FD, $00
Offset_0x010FFC:
                dc.b    $03, $C8, $C9, $CA, $CB, $FF
Offset_0x011002:
                dc.b    $05, $D2, $D3, $D4, $D5, $FD, $00
Offset_0x011009:
                dc.b    $07, $54, $59, $FF
Offset_0x01100D:
                dc.b    $07, $54, $55, $56, $57, $58, $FF
Offset_0x011014:
                dc.b    $2F, $5B, $FD, $00
Offset_0x011018:
                dc.b    $01, $50, $51, $FF
Offset_0x01101C:
                dc.b    $0F, $43, $43, $43, $FE, $01
Offset_0x011022:
                dc.b    $0F, $43, $44, $FE, $01
Offset_0x011027:
                dc.b    $13, $6B, $6C, $FF
Offset_0x01102B:
                dc.b    $0B, $5A, $5A, $11, $12, $FD, $00
Offset_0x011032:
                dc.b    $20, $5E, $FF
Offset_0x011035:
                dc.b    $20, $5D, $FF
Offset_0x011038:
                dc.b    $20, $5C, $FF
Offset_0x01103B:
                dc.b    $40, $4E, $FF
Offset_0x01103E:
                dc.b    $09, $4E, $4F, $FF
Offset_0x011042:
                dc.b    $77, $00, $FD, $00
Offset_0x011046:
                dc.b    $13, $D0, $D1, $FF
Offset_0x01104A:
                dc.b    $03, $CF, $C8, $C9, $CA, $CB, $FE, $04
;-------------------------------------------------------------------------------
Offset_0x011052:
                dc.w    Offset_0x011092-Offset_0x011052
                dc.w    Offset_0x01109C-Offset_0x011052
                dc.w    Offset_0x010F04-Offset_0x011052
                dc.w    Offset_0x010F0E-Offset_0x011052
                dc.w    Offset_0x0110A6-Offset_0x011052
                dc.w    Offset_0x0110B0-Offset_0x011052
                dc.w    Offset_0x0110B6-Offset_0x011052
                dc.w    Offset_0x010FDE-Offset_0x011052
                dc.w    Offset_0x0110C0-Offset_0x011052
                dc.w    Offset_0x010FE8-Offset_0x011052
                dc.w    Offset_0x010FF4-Offset_0x011052
                dc.w    Offset_0x010FF8-Offset_0x011052
                dc.w    Offset_0x010FFC-Offset_0x011052
                dc.w    Offset_0x011002-Offset_0x011052
                dc.w    Offset_0x011009-Offset_0x011052
                dc.w    Offset_0x01100D-Offset_0x011052
                dc.w    Offset_0x011014-Offset_0x011052
                dc.w    Offset_0x011018-Offset_0x011052
                dc.w    Offset_0x01101C-Offset_0x011052
                dc.w    Offset_0x011022-Offset_0x011052
                dc.w    Offset_0x011027-Offset_0x011052
                dc.w    Offset_0x01102B-Offset_0x011052
                dc.w    Offset_0x011032-Offset_0x011052
                dc.w    Offset_0x011035-Offset_0x011052
                dc.w    Offset_0x011038-Offset_0x011052
                dc.w    Offset_0x01103B-Offset_0x011052
                dc.w    Offset_0x01103B-Offset_0x011052
                dc.w    Offset_0x01103E-Offset_0x011052
                dc.w    Offset_0x011042-Offset_0x011052
                dc.w    Offset_0x011046-Offset_0x011052
                dc.w    Offset_0x01104A-Offset_0x011052
                dc.w    Offset_0x0110C3-Offset_0x011052
Offset_0x011092:
                dc.b    $FF, $77, $78, $79, $7A, $7B, $7C, $75
                dc.b    $76, $FF
Offset_0x01109C:
                dc.b    $FF, $B5, $B9, $FF, $FF, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x0110A6:
                dc.b    $FD, $BD, $BE, $BF, $C0, $FF, $FF, $FF
                dc.b    $FF, $FF
Offset_0x0110B0:
                dc.b    $07, $72, $73, $74, $73, $FF
Offset_0x0110B6:
                dc.b    $09, $C2, $C3, $C4, $C3, $C5, $C6, $C7
                dc.b    $C6, $FF
Offset_0x0110C0:
                dc.b    $05, $C1, $FF
Offset_0x0110C3:
                dc.b    $02, $6D, $6D, $6E, $6E, $6F, $70, $71
                dc.b    $70, $71, $70, $71, $70, $71, $FD, $00
                dc.b    $00     
;-------------------------------------------------------------------------------
Load_Sonic_Dynamic_PLC:                                        ; Offset_0x0110D4
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
; Load_Sonic_Dynamic_PLC_D0:                 
                cmp.b   ($FFFFF766).w, D0
                beq.s   Offset_0x011126
                move.b  D0, ($FFFFF766).w
                lea     (Sonic_Dyn_Script), A2                 ; Offset_0x0714E0
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x011126
                move.w  #$F000, D4
Loop_Load_Sonic_Sprites:                                       ; Offset_0x0110FA
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                addi.l  #Art_Sonic, D1                         ; Offset_0x050000
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
                dbra    D5, Loop_Load_Sonic_Sprites            ; Offset_0x0110FA
Offset_0x011126:
                rts           
;===============================================================================
; Object 0x01 - Sonic
; <<<-
;===============================================================================