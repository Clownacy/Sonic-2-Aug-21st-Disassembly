;===============================================================================
; Objeto 0x50 - Imimigo cavalo marinho (Aquis) na Oil Ocean
; ->>>
;===============================================================================
; Offset_0x021DAC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x021DBA(PC, D0), D1
                jmp     Offset_0x021DBA(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x021DBA:
                dc.w    Offset_0x021DC6-Offset_0x021DBA
                dc.w    Offset_0x021E7E-Offset_0x021DBA
                dc.w    Offset_0x021EAA-Offset_0x021DBA
                dc.w    Offset_0x021ED4-Offset_0x021DBA
                dc.w    Offset_0x0220B6-Offset_0x021DBA
                dc.w    Offset_0x0220F2-Offset_0x021DBA        
;------------------------------------------------------------------------------- 
Offset_0x021DC6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Aquis_Mappings, Obj_Map(A0)    ; Offset_0x02227C, $0004
                move.w  #$2570, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.w  #$FF00, Obj_Speed(A0)                            ; $0010
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.b  D0, D1
                andi.w  #$00F0, D1
                lsl.w   #$04, D1
                move.w  D1, Obj_Control_Var_02(A0)                       ; $002E
                move.w  D1, Obj_Control_Var_04(A0)                       ; $0030
                andi.w  #$000F, D0
                lsl.w   #$04, D0
                subq.w  #$01, D0
                move.w  D0, Obj_Control_Var_06(A0)                       ; $0032
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034
                move.w  Obj_Y(A0), Obj_Timer(A0)                  ; $000C, $002A
                bsr     Jmp_0A_To_SingleObjectLoad             ; Offset_0x022618
                bne.s   Offset_0x021E7E
                move.b  #$50, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$000A, Obj_X(A1)                                ; $0008
                addi.w  #$FFFA, Obj_Y(A1)                                ; $000C
                move.l  #Aquis_Mappings, Obj_Map(A1)    ; Offset_0x02227C, $0004
                move.w  #$24E0, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  #$03, Obj_Ani_Number(A1)                         ; $001C
                move.l  A1, Obj_Control_Var_0A(A0)                       ; $0036
                move.l  A0, Obj_Control_Var_0A(A1)                       ; $0036
                bset    #$06, Obj_Status(A0)                             ; $0022   
;------------------------------------------------------------------------------- 
Offset_0x021E7E:
                lea     (Aquis_Animate_Data), A1               ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                move.w  #$039C, (Water_Level).w                      ; $FFFFF646
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x021EA4(PC, D0), D1
                jsr     Offset_0x021EA4(PC, D1)
                bsr     Offset_0x02207C
                bra     Jmp_21_To_MarkObjGone                  ; Offset_0x02261E       
;------------------------------------------------------------------------------- 
Offset_0x021EA4:
                dc.w    Offset_0x021EEA-Offset_0x021EA4
                dc.w    Offset_0x021EFC-Offset_0x021EA4
                dc.w    Offset_0x021F0A-Offset_0x021EA4   
;-------------------------------------------------------------------------------  
Offset_0x021EAA:
                move.l  Obj_Control_Var_0A(A0), A1                       ; $0036
                tst.b   (A1)
                beq     Jmp_1A_To_DeleteObject                 ; Offset_0x022612
                cmpi.b  #$50, (A1)
                bne     Jmp_1A_To_DeleteObject                 ; Offset_0x022612
                btst    #$07, Obj_Status(A1)                             ; $0022
                bne     Jmp_1A_To_DeleteObject                 ; Offset_0x022612
                lea     (Aquis_Animate_Data), A1               ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                bra     Jmp_17_To_DisplaySprite                ; Offset_0x02260C 
;-------------------------------------------------------------------------------  
Offset_0x021ED4:
                bsr     Offset_0x0221A0
                bsr     Jmp_13_To_SpeedToPos                   ; Offset_0x022630
                lea     (Aquis_Animate_Data), A1               ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                bra     Jmp_21_To_MarkObjGone                  ; Offset_0x02261E   
;-------------------------------------------------------------------------------  
Offset_0x021EEA:
                bsr     Jmp_13_To_SpeedToPos                   ; Offset_0x022630
                bsr     Offset_0x022182
                bsr     Offset_0x022028
                bsr     Offset_0x021FC0
                rts    
;-------------------------------------------------------------------------------  
Offset_0x021EFC:
                bsr     Jmp_13_To_SpeedToPos                   ; Offset_0x022630
                bsr     Offset_0x022182
                bsr     Offset_0x02204A
                rts 
;-------------------------------------------------------------------------------  
Offset_0x021F0A:
                bsr     Jmp_07_To_ObjectFall                   ; Offset_0x02262A
                bsr     Offset_0x022182
                bsr     Offset_0x021F1C
                bsr     Offset_0x021F98
                rts
Offset_0x021F1C:
                tst.b   Obj_Control_Var_01(A0)                           ; $002D
                bne.s   Offset_0x021F28
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl.s   Offset_0x021F2A
Offset_0x021F28:
                rts
Offset_0x021F2A:
                st      Obj_Control_Var_01(A0)                           ; $002D
                bsr     Jmp_0A_To_SingleObjectLoad             ; Offset_0x022618
                bne.s   Offset_0x021F96
                move.b  #$50, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  #Aquis_Mappings, Obj_Map(A1)    ; Offset_0x02227C, $0004
                move.w  #$24E0, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$E5, Obj_Col_Flags(A1)                          ; $0020
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$000C, D0
                move.w  #$0010, D1
                move.w  #$FD00, D2
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x021F8A
                neg.w   D1
                neg.w   D2
Offset_0x021F8A:
                sub.w   D0, Obj_Y(A1)                                    ; $000C
                sub.w   D1, Obj_X(A1)                                    ; $0008
                move.w  D2, Obj_Speed(A1)                                ; $0010
Offset_0x021F96:
                rts
Offset_0x021F98:
                move.w  Obj_Y(A0), D0                                    ; $000C
                cmp.w   ($FFFFF646).w, D0
                blt.s   Offset_0x021FBE
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  Obj_Control_Var_04(A0), Obj_Control_Var_02(A0); $002E, $0030
                move.w  #$0040, Obj_Speed_Y(A0)                          ; $0012
                sf      Obj_Control_Var_01(A0)                           ; $002D
Offset_0x021FBE:
                rts
Offset_0x021FC0:
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                beq.s   Offset_0x022026
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                move.w  (Player_One_Position_Y).w, D1                ; $FFFFB00C
                sub.w   Obj_Y(A0), D1                                    ; $000C
                bpl.s   Offset_0x022026
                cmpi.w  #$FFD0, D1
                blt.s   Offset_0x022026
                sub.w   Obj_X(A0), D0                                    ; $0008
                cmpi.w  #$0048, D0
                bgt.s   Offset_0x022026
                cmpi.w  #$FFB8, D0
                blt.s   Offset_0x022026
                tst.w   D0
                bpl.s   Offset_0x021FFE
                cmpi.w  #$FFD8, D0
                bgt.s   Offset_0x022026
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x022026
                bra.s   Offset_0x02200C
Offset_0x021FFE:
                cmpi.w  #$0028, D0
                blt.s   Offset_0x022026
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x022026
Offset_0x02200C:
                moveq   #$20, D0
                cmp.w   Obj_Control_Var_06(A0), D0                       ; $0032
                bgt.s   Offset_0x022026
                move.b  #$04, Obj_Routine_2(A0)                          ; $0025
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $0012
Offset_0x022026:
                rts
Offset_0x022028:
                subq.w  #$01, Obj_Control_Var_02(A0)                     ; $002E
                bne.s   Offset_0x022048
                move.w  Obj_Control_Var_04(A0), Obj_Control_Var_02(A0); $002E, $0030
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$FFC0, D0
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                beq.s   Offset_0x022044
                neg.w   D0
Offset_0x022044:
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
Offset_0x022048:
                rts
Offset_0x02204A:
                move.w  Obj_Y(A0), D0                                    ; $000C
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x022068
                cmp.w   ($FFFFF646).w, D0
                bgt.s   Offset_0x022066
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                st      Obj_Control_Var_00(A0)                           ; $002C
                clr.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x022066:
                rts
Offset_0x022068:
                cmp.w   Obj_Timer(A0), D0                                ; $002A
                blt.s   Offset_0x022066
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                sf      Obj_Control_Var_00(A0)                           ; $002C
                clr.w   Obj_Speed_Y(A0)                                  ; $0012
                rts
Offset_0x02207C:
                moveq   #$0A, D0
                moveq   #-$06, D1
                move.l  Obj_Control_Var_0A(A0), A1                       ; $0036
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Respaw_Ref(A0), Obj_Respaw_Ref(A1)    ; $0023, $0023
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x0220AC
                neg.w   D0
Offset_0x0220AC:
                add.w   D0, Obj_X(A1)                                    ; $0008
                add.w   D1, Obj_Y(A1)                                    ; $000C
                rts 
;-------------------------------------------------------------------------------  
Offset_0x0220B6:
                bsr     Jmp_07_To_ObjectFall                   ; Offset_0x02262A
                bsr     Offset_0x0220CC
                lea     (Aquis_Animate_Data), A1               ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                bra     Jmp_21_To_MarkObjGone                  ; Offset_0x02261E
Offset_0x0220CC:
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x0220E6
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                asr.w   #$01, D0
                neg.w   D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
Offset_0x0220E6:
                subi.b  #$01, Obj_Col_Prop(A0)                           ; $0021
                beq     Jmp_1A_To_DeleteObject                 ; Offset_0x022612
                rts             
;-------------------------------------------------------------------------------  
Offset_0x0220F2:
                bsr     Offset_0x022142
                tst.b   Obj_Routine_2(A0)                                ; $0025
                beq.s   Offset_0x022132
                subi.w  #$0001, Obj_Control_Var_00(A0)                   ; $002C
                beq     Jmp_1A_To_DeleteObject                 ; Offset_0x022612
                move.w  (Player_One_Position_X).w, Obj_X(A0)         ; $FFFFB008; $0008
                move.w  (Player_One_Position_Y).w, Obj_Y(A0)         ; $FFFFB00C; $000C
                addi.w  #$000C, Obj_Y(A0)                                ; $000C
                subi.b  #$01, Obj_Timer(A0)                              ; $002A
                bne.s   Offset_0x022134
                move.b  #$03, Obj_Timer(A0)                              ; $002A
                bchg    #00, Obj_Status(A0)                              ; $0022
                bchg    #00, Obj_Flags(A0)                               ; $0001
Offset_0x022132:
                rts
Offset_0x022134:
                lea     (Aquis_Animate_Data), A1               ; Offset_0x022244
                bsr     Jmp_0F_To_AnimateSprite                ; Offset_0x022624
                bra     Jmp_17_To_DisplaySprite                ; Offset_0x02260C
Offset_0x022142:
                tst.b   Obj_Routine_2(A0)                                ; $0025
                bne.s   Offset_0x022180
                move.b  (Player_One+Obj_Routine).w, D0               ; $FFFFB024
                cmpi.b  #$02, D0
                bne.s   Offset_0x022180
                move.w  (Player_One_Position_X).w, Obj_X(A0)         ; $FFFFB008; $0008
                move.w  (Player_One_Position_Y).w, Obj_Y(A0)         ; $FFFFB00C; $000C
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                st      Obj_Routine_2(A0)                                ; $0025
                move.w  #$012C, Obj_Control_Var_00(A0)                   ; $002C
                move.b  #$03, Obj_Timer(A0)                              ; $002A
Offset_0x022180:
                rts
Offset_0x022182:
                subq.w  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x02219E
                move.w  Obj_Control_Var_08(A0), Obj_Control_Var_06(A0); $0032, $0034
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
Offset_0x02219E:
                rts
Offset_0x0221A0:
                tst.b   Obj_Col_Prop(A0)                                 ; $0021
                beq     Offset_0x022242
                moveq   #$02, D3
Offset_0x0221AA:
                bsr     Jmp_0A_To_SingleObjectLoad             ; Offset_0x022618
                bne.s   Offset_0x02221C
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.b  #$08, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  #$24E0, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.w  #$FF00, Obj_Speed_Y(A1)                          ; $0012
                move.b  #$04, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$78, Obj_Col_Prop(A1)                           ; $0021
                cmpi.w  #$0001, D3
                beq.s   Offset_0x022216
                blt.s   Offset_0x022208
                move.w  #$00C0, Obj_Speed(A1)                            ; $0010
                addi.w  #$FF40, Obj_Speed_Y(A1)                          ; $0012
                bra.s   Offset_0x02221C
Offset_0x022208:
                move.w  #$FF00, Obj_Speed(A1)                            ; $0010
                addi.w  #$FFC0, Obj_Speed_Y(A1)                          ; $0012
                bra.s   Offset_0x02221C
Offset_0x022216:
                move.w  #$0040, Obj_Speed(A1)                            ; $0010
Offset_0x02221C:
                dbra    D3, Offset_0x0221AA
                bsr     Jmp_0A_To_SingleObjectLoad             ; Offset_0x022618
                bne.s   Offset_0x02223E
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.b  #$0A, Obj_Routine(A1)                            ; $0024
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  #$24E0, Obj_Art_VRAM(A1)                         ; $0002
Offset_0x02223E:
                bra     Jmp_1A_To_DeleteObject                 ; Offset_0x022612
Offset_0x022242:
                rts              
;-------------------------------------------------------------------------------
Aquis_Animate_Data:                                            ; Offset_0x022244
                dc.w    Offset_0x022254-Aquis_Animate_Data
                dc.w    Offset_0x022257-Aquis_Animate_Data
                dc.w    Offset_0x02225F-Aquis_Animate_Data
                dc.w    Offset_0x022265-Aquis_Animate_Data
                dc.w    Offset_0x022269-Aquis_Animate_Data
                dc.w    Offset_0x02226C-Aquis_Animate_Data
                dc.w    Offset_0x02226F-Aquis_Animate_Data
                dc.w    Offset_0x022273-Aquis_Animate_Data
Offset_0x022254:
                dc.b    $0E, $00, $FF
Offset_0x022257:
                dc.b    $05, $03, $04, $03, $04, $03, $04, $FF
Offset_0x02225F:
                dc.b    $03, $05, $06, $07, $06, $FF
Offset_0x022265:
                dc.b    $03, $01, $02, $FF
Offset_0x022269:
                dc.b    $01, $05, $FF
Offset_0x02226C:
                dc.b    $0E, $08, $FF
Offset_0x02226F:
                dc.b    $01, $09, $0A, $FF
Offset_0x022273:
                dc.b    $05, $0B, $0C, $0B, $0C, $0B, $0C, $FF
                dc.b    $00     
;-------------------------------------------------------------------------------  
Aquis_Mappings:                                                ; Offset_0x02227C
                dc.w    Offset_0x022296-Aquis_Mappings
                dc.w    Offset_0x0222B0-Aquis_Mappings
                dc.w    Offset_0x0222BA-Aquis_Mappings
                dc.w    Offset_0x0222C4-Aquis_Mappings
                dc.w    Offset_0x0222E6-Aquis_Mappings
                dc.w    Offset_0x022308-Aquis_Mappings
                dc.w    Offset_0x022312-Aquis_Mappings
                dc.w    Offset_0x02231C-Aquis_Mappings
                dc.w    Offset_0x022326-Aquis_Mappings
                dc.w    Offset_0x022330-Aquis_Mappings
                dc.w    Offset_0x022352-Aquis_Mappings
                dc.w    Offset_0x022374-Aquis_Mappings
                dc.w    Offset_0x02239E-Aquis_Mappings
Offset_0x022296:
                dc.w    $0003
                dc.l    $E80D0000, $0000FFF0
                dc.l    $F8090016, $000BFFF8
                dc.l    $08050024, $0012FFF8
Offset_0x0222B0:
                dc.w    $0001
                dc.l    $F8050028, $0014FFF8
Offset_0x0222BA:
                dc.w    $0001
                dc.l    $F805002C, $0016FFF8
Offset_0x0222C4:
                dc.w    $0004
                dc.l    $E8090008, $0004FFF0
                dc.l    $E801000E, $00070008
                dc.l    $F8090016, $000BFFF8
                dc.l    $08050024, $0012FFF8
Offset_0x0222E6:
                dc.w    $0004
                dc.l    $E8090010, $0008FFF0
                dc.l    $E801000E, $00070008
                dc.l    $F8090016, $000BFFF8
                dc.l    $08050024, $0012FFF8
Offset_0x022308:
                dc.w    $0001
                dc.l    $F8010030, $0018FFFC
Offset_0x022312:
                dc.w    $0001
                dc.l    $F8010032, $0019FFFC
Offset_0x02231C:
                dc.w    $0001
                dc.l    $F8010034, $001AFFFC
Offset_0x022326:
                dc.w    $0001
                dc.l    $F80D0036, $001BFFF0
Offset_0x022330:
                dc.w    $0004
                dc.l    $E80D0000, $0000FFF0
                dc.l    $F805001C, $000EFFF8
                dc.l    $F8010020, $00100008
                dc.l    $08050024, $0012FFF8
Offset_0x022352:
                dc.w    $0004
                dc.l    $E80D0000, $0000FFF0
                dc.l    $F805001C, $000EFFF8
                dc.l    $F8010022, $00110008
                dc.l    $08050024, $0012FFF8
Offset_0x022374:
                dc.w    $0005
                dc.l    $E8090008, $0004FFF0
                dc.l    $E801000E, $00070008
                dc.l    $F805001C, $000EFFF8
                dc.l    $F8010020, $00100008
                dc.l    $08050024, $0012FFF8
Offset_0x02239E:
                dc.w    $0005
                dc.l    $E8090010, $0008FFF0
                dc.l    $E801000E, $00070008
                dc.l    $F805001C, $000EFFF8
                dc.l    $F8010022, $00110008
                dc.l    $08050024, $0012FFF8
;===============================================================================
; Objeto 0x50 - Imimigo cavalo marinho (Aquis) na Oil Ocean
; <<<-
;===============================================================================