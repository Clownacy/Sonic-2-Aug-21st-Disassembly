;===============================================================================
; Objeto 0x4B - Inimigo Buzzer na Green Hill
; ->>> 
;===============================================================================   
; Offset_0x023F78:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x023F86(PC, D0), D1
                jmp     Offset_0x023F86(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x023F86:
                dc.w    Offset_0x023FD8-Offset_0x023F86
                dc.w    Offset_0x024084-Offset_0x023F86
                dc.w    Offset_0x023FA0-Offset_0x023F86
                dc.w    Offset_0x023F8E-Offset_0x023F86   
;-------------------------------------------------------------------------------
Offset_0x023F8E:
                bsr     Jmp_16_To_SpeedToPos                   ; Offset_0x02428C
                lea     (Buzzer_AnimateData), A1               ; Offset_0x0241CE
                bsr     Jmp_12_To_AnimateSprite                ; Offset_0x024274
                bra     Jmp_01_To_MarkObjGone_4                ; Offset_0x024280   
;-------------------------------------------------------------------------------
Offset_0x023FA0:
                move.l  Obj_Timer(A0), A1                                ; $002A
                tst.b   (A1)
                beq     Jmp_1D_To_DeleteObject                 ; Offset_0x024268
                tst.w   Obj_Control_Var_04(A1)                           ; $0030
                bmi.s   Offset_0x023FB2
                rts
Offset_0x023FB2:
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                lea     (Buzzer_AnimateData), A1               ; Offset_0x0241CE
                bsr     Jmp_12_To_AnimateSprite                ; Offset_0x024274
                bra     Jmp_01_To_MarkObjGone_4                ; Offset_0x024280   
;-------------------------------------------------------------------------------
Offset_0x023FD8:
                move.l  #Buzzer_Mappings, Obj_Map(A0)   ; Offset_0x0241EA, $0004
                move.w  #$03D2, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_2B_To_ModifySpriteAttr_2P          ; Offset_0x024286
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$18, Obj_Width_2(A0)                            ; $0017
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Jmp_13_To_SingleObjectLoad_2           ; Offset_0x02426E
                bne.s   Offset_0x024082
                move.b  #$4B, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.l  #Buzzer_Mappings, Obj_Map(A1)   ; Offset_0x0241EA, $0004
                move.w  #$03D2, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_06_To_ModifySpriteAttr_2P_A1       ; Offset_0x02427A
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
                move.l  A0, Obj_Timer(A1)                                ; $002A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$0100, Obj_Control_Var_02(A0)                   ; $002E
                move.w  #$FF00, Obj_Speed(A0)                            ; $0010
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x024082
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x024082:
                rts  
;-------------------------------------------------------------------------------
Offset_0x024084:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0240A0(PC, D0), D1
                jsr     Offset_0x0240A0(PC, D1)
                lea     (Buzzer_AnimateData), A1               ; Offset_0x0241CE
                bsr     Jmp_12_To_AnimateSprite                ; Offset_0x024274
                bra     Jmp_01_To_MarkObjGone_4                ; Offset_0x024280          
;-------------------------------------------------------------------------------
Offset_0x0240A0:
                dc.w    Offset_0x0240A4-Offset_0x0240A0
                dc.w    Offset_0x024134-Offset_0x0240A0              
;-------------------------------------------------------------------------------
Offset_0x0240A4:
                bsr     Offset_0x0240E6
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                cmpi.w  #$000F, D0
                beq.s   Offset_0x0240CA
                tst.w   D0
                bpl.s   Offset_0x0240C8
                subq.w  #$01, Obj_Control_Var_02(A0)                     ; $002E
                bgt     Jmp_16_To_SpeedToPos                   ; Offset_0x02428C
                move.w  #$001E, Obj_Control_Var_04(A0)                   ; $0030
Offset_0x0240C8:
                rts
Offset_0x0240CA:
                sf      Obj_Control_Var_06(A0)                           ; $0032
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
                bchg    #00, Obj_Status(A0)                              ; $0022
                move.w  #$0100, Obj_Control_Var_02(A0)                   ; $002E
                rts
Offset_0x0240E6:
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                bne     Offset_0x024132
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                move.w  D0, D1
                bpl.s   Offset_0x0240FC
                neg.w   D0
Offset_0x0240FC:
                cmpi.w  #$0028, D0
                blt.s   Offset_0x024132
                cmpi.w  #$0030, D0
                bgt.s   Offset_0x024132
                tst.w   D1
                bpl.s   Offset_0x024116
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x024132
                bra.s   Offset_0x02411E
Offset_0x024116:
                btst    #$00, Obj_Flags(A0)                              ; $0001
                bne.s   Offset_0x024132
Offset_0x02411E:
                st      Obj_Control_Var_06(A0)                           ; $0032
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0032, Obj_Control_Var_08(A0)                   ; $0034
Offset_0x024132:
                rts     
;-------------------------------------------------------------------------------
Offset_0x024134:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                subq.w  #$01, D0
                blt.s   Offset_0x024148
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034
                cmpi.w  #$0014, D0
                beq.s   Offset_0x02414E
                rts
Offset_0x024148:
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                rts
Offset_0x02414E:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x0241C8
                move.b  #$4B, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  #Buzzer_Mappings, Obj_Map(A1)   ; Offset_0x0241EA, $0004
                move.w  #$03D2, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_06_To_ModifySpriteAttr_2P_A1       ; Offset_0x02427A
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$98, Obj_Col_Flags(A1)                          ; $0020
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0018, Obj_Y(A1)                                ; $000C
                move.w  #$000D, D0
                move.w  #$0180, Obj_Speed_Y(A1)                          ; $0012
                move.w  #$FE80, Obj_Speed(A1)                            ; $0010
                btst    #$00, Obj_Flags(A1)                              ; $0001
                beq.s   Offset_0x0241C8
                neg.w   Obj_Speed(A1)                                    ; $0010
                neg.w   D0
Offset_0x0241C8:
                add.w   D0, Obj_X(A1)                                    ; $0008
                rts                                   
;-------------------------------------------------------------------------------   
Buzzer_AnimateData:                                            ; Offset_0x0241CE
                dc.w    Offset_0x0241D6-Buzzer_AnimateData
                dc.w    Offset_0x0241D9-Buzzer_AnimateData
                dc.w    Offset_0x0241DD-Buzzer_AnimateData
                dc.w    Offset_0x0241E1-Buzzer_AnimateData
Offset_0x0241D6:
                dc.b    $0F, $00, $FF
Offset_0x0241D9:
                dc.b    $02, $03, $04, $FF
Offset_0x0241DD:
                dc.b    $03, $05, $06, $FF
Offset_0x0241E1:
                dc.b    $09, $01, $01, $01, $01, $01, $FD, $00
                dc.b    $00                   
;-------------------------------------------------------------------------------
Buzzer_Mappings:                                               ; Offset_0x0241EA
                dc.w    Offset_0x0241F8-Buzzer_Mappings
                dc.w    Offset_0x02420A-Buzzer_Mappings
                dc.w    Offset_0x024224-Buzzer_Mappings
                dc.w    Offset_0x02423E-Buzzer_Mappings
                dc.w    Offset_0x024248-Buzzer_Mappings
                dc.w    Offset_0x024252-Buzzer_Mappings
                dc.w    Offset_0x02425C-Buzzer_Mappings
Offset_0x0241F8:
                dc.w    $0002
                dc.l    $F8090000, $0000FFE8
                dc.l    $F8090006, $00030000
Offset_0x02420A:
                dc.w    $0003
                dc.l    $F8090000, $0000FFE8
                dc.l    $F805000C, $00060000
                dc.l    $08050010, $00080002
Offset_0x024224:
                dc.w    $0003
                dc.l    $F8090000, $0000FFE8
                dc.l    $F805000C, $00060000
                dc.l    $08050014, $000A0002
Offset_0x02423E:
                dc.w    $0001
                dc.l    $F0010014, $000A0004
Offset_0x024248:
                dc.w    $0001
                dc.l    $F0010016, $000B0004
Offset_0x024252:
                dc.w    $0001
                dc.l    $F8010018, $000CFFF4
Offset_0x02425C:
                dc.w    $0001
                dc.l    $F801001A, $000DFFF4
;===============================================================================
; Objeto 0x4B - Inimigo Buzzer na Green Hill
; <<<- 
;===============================================================================