;===============================================================================
; Objeto 0x89 - Robotnik na Neo Green Hill
; ->>> 
;===============================================================================
; Offset_0x025FE0:
                moveq   #$00, D0
                move.b  Obj_Boss_Routine(A0), D0                         ; $000A
                move.w  Offset_0x025FEE(PC, D0), D1
                jmp     Offset_0x025FEE(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x025FEE:
                dc.w    Offset_0x025FF4-Offset_0x025FEE
                dc.w    Offset_0x026152-Offset_0x025FEE
                dc.w    Offset_0x0264C8-Offset_0x025FEE           
;-------------------------------------------------------------------------------  
Offset_0x025FF4:
                cmpi.w  #$2A40, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
                bne     Offset_0x026126
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                cmpi.w  #$2A68, D0
                blt     Offset_0x026126
                cmpi.w  #$2B48, D0
                bgt     Offset_0x026126
                move.b  #$01, ($FFFFEEBD).w
                move.w  #$03E0, Obj_Art_VRAM(A0)                         ; $0002
                move.l  #NGHz_Boss_Ship_Mappings, Obj_Map(A0) ; Offset_0x026824, $0004
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, $000E(A0)
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                move.b  #$02, Obj_Boss_Routine(A0)                       ; $000A
                move.w  #$2AD8, Obj_X(A0)                                ; $0008
                move.w  #$0388, Obj_Y(A0)                                ; $000C
                move.w  #$2AD8, (Boss_Move_Buffer).w                 ; $FFFFF750
                move.w  #$0388, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bset    #$06, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Control_Var_06(A0)                     ; $0032
                move.b  #$08, Obj_Boss_Ani_Map(A0)                       ; $000B
                move.w  #$FC80, Obj_Control_Var_02(A0)                   ; $002E
                move.w  #$2AD8, NGHz_Robotnik_Pos_X(A0)                  ; $0010
                move.w  #$0488, NGHz_Robotnik_Pos_Y(A0)                  ; $0012
                move.b  #$00, Obj_Ani_Boss_Frame(A0)                     ; $0015
                move.w  #$2AD8, NGHz_Hammer_Pos_X(A0)                    ; $0016
                move.w  #$0488, NGHz_Hammer_Pos_Y(A0)                    ; $0018
                move.b  #$09, Obj_Ani_Frame(A0)                          ; $001B
                move.w  #$2AD8, NGHz_Ship_Boost_Pos_X(A0)                ; $001C
                move.w  #$0488, NGHz_Ship_Boost_Pos_Y(A0)                ; $001E
                move.b  #$06, Obj_Col_Prop(A0)                           ; $0021
                move.w  #$0100, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                bsr     Jmp_0C_To_SingleObjectLoad             ; Offset_0x026978
                bne     Offset_0x026126
                move.b  #$89, (A1)
                move.l  #NGHz_Boss_Arrows_Launcher_Mappings, Obj_Map(A1) ; Offset_0x026752, $0004
                move.w  #$03E0, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$90, $000E(A1)
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.w  #$2AD8, Obj_X(A1)                                ; $0008
                move.w  #$0488, Obj_Y(A1)                                ; $000C
                move.b  #$00, Obj_Boss_Ani_Map(A1)                       ; $000B
                addq.b  #$04, Obj_Boss_Routine(A1)                       ; $000A
                bset    #$06, Obj_Flags(A1)                              ; $0001
                move.b  #$02, Obj_Ani_Boss_Cnt(A1)                       ; $000F
                move.w  #$2A58, NGHz_Robotnik_Pos_X(A1)                  ; $0010
                move.w  #$0510, NGHz_Robotnik_Pos_Y(A1)                  ; $0012
                move.b  #$00, Obj_Ani_Boss_Frame(A1)                     ; $0015
                move.w  #$2B58, NGHz_Hammer_Pos_X(A1)                    ; $0016
                move.w  #$0510, NGHz_Hammer_Pos_Y(A1)                    ; $0018
                move.b  #$01, Obj_Ani_Frame(A1)                          ; $001B
                move.l  A0, Obj_Timer(A1)                                ; $002A
Offset_0x026126:
                bsr     Offset_0x02612C
                rts
Offset_0x02612C:
                lea     (Boss_Animate_Buffer).w, A2                  ; $FFFFF740
                move.b  #$04, (A2)+
                move.b  #$00, (A2)+
                move.b  #$10, (A2)+
                move.b  #$00, (A2)+
                move.b  #$02, (A2)+
                move.b  #$00, (A2)+
                move.b  #$01, (A2)+
                move.b  #$00, (A2)+
                rts       
;-------------------------------------------------------------------------------  
Offset_0x026152:
                moveq   #$00, D0
                move.b  Obj_Ani_Boss_Routine(A0), D0                     ; $0026
                move.w  Offset_0x026160(PC, D0), D1
                jmp     Offset_0x026160(PC, D1)       
;------------------------------------------------------------------------------- 
Offset_0x026160:
                dc.w    Offset_0x02616E-Offset_0x026160
                dc.w    Offset_0x0261AC-Offset_0x026160
                dc.w    Offset_0x026206-Offset_0x026160
                dc.w    Offset_0x02623A-Offset_0x026160
                dc.w    Offset_0x0263DA-Offset_0x026160
                dc.w    Offset_0x026422-Offset_0x026160
                dc.w    Offset_0x026478-Offset_0x026160   
;------------------------------------------------------------------------------- 
Offset_0x02616E:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x02628C
                bsr     Offset_0x0262AA
                cmpi.w  #$0430, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x02619E
                move.w  #$0430, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                addi.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$0000, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.w  #$FF9C, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                st      Obj_Control_Var_0C(A0)                           ; $0038
Offset_0x02619E:
                lea     (NGHz_Boss_Animate_Data), A1           ; Offset_0x0267E6
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C  
;-------------------------------------------------------------------------------  
Offset_0x0261AC:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x02628C
                bsr     Offset_0x0262AA
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x0261D4
                cmpi.w  #$2B08, (Boss_Move_Buffer).w                 ; $FFFFF750
                blt.s   Offset_0x0261F8
                addi.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$0000, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                bra.s   Offset_0x0261E8
Offset_0x0261D4:
                cmpi.w  #$2AA8, (Boss_Move_Buffer).w                 ; $FFFFF750
                bgt.s   Offset_0x0261F8
                addi.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$0000, (Boss_Move_Buffer+$08).w             ; $FFFFF758
Offset_0x0261E8:
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0002(A1) 
                ori.b   #$05, $0002(A1) 
Offset_0x0261F8:
                lea     (NGHz_Boss_Animate_Data), A1           ; Offset_0x0267E6
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C  
;-------------------------------------------------------------------------------  
Offset_0x026206:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x02628C
                bsr     Offset_0x0262AA
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                cmpi.b  #$C0, D0
                bne.s   Offset_0x02622C
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0004(A1) 
                ori.b   #$03, $0004(A1) 
Offset_0x02622C:
                lea     (NGHz_Boss_Animate_Data), A1           ; Offset_0x0267E6
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C 
;-------------------------------------------------------------------------------  
Offset_0x02623A:
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0004(A1) 
                ori.b   #$02, $0004(A1) 
                bset    #$00, Obj_Control_Var_12(A0)                     ; $003E
                move.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bchg    #00, Obj_Flags(A0)                               ; $0001
                eori.b  #$FF, Obj_Control_Var_0C(A0)                     ; $0038
                beq.s   Offset_0x02626C
                move.w  #$FF9C, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                bra.s   Offset_0x026272
Offset_0x02626C:
                move.w  #$0064, (Boss_Move_Buffer+$08).w             ; $FFFFF758
Offset_0x026272:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x02628C
                bsr     Offset_0x0262AA
                lea     (NGHz_Boss_Animate_Data), A1           ; Offset_0x0267E6
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C
Offset_0x02628C:
                bsr     Offset_0x024580
                cmpi.b  #$1F, Obj_Inertia(A0)                            ; $0014
                bne.s   Offset_0x0262A8
                lea     (Boss_Animate_Buffer).w, A1                  ; $FFFFF740
                andi.b  #$F0, $0002(A1) 
                ori.b   #$06, $0002(A1) 
Offset_0x0262A8:
                rts
Offset_0x0262AA:
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  Obj_Y(A0), D1                                    ; $000C
                move.w  D0, NGHz_Robotnik_Pos_X(A0)                      ; $0010
                move.w  D1, NGHz_Robotnik_Pos_Y(A0)                      ; $0012
                move.w  D0, NGHz_Ship_Boost_Pos_X(A0)                    ; $001C
                move.w  D1, NGHz_Ship_Boost_Pos_Y(A0)                    ; $001E
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x0262D6
                move.w  D0, NGHz_Hammer_Pos_X(A0)                        ; $0016
                move.w  D1, NGHz_Hammer_Pos_Y(A0)                        ; $0018
                move.w  D1, Obj_Control_Var_0E(A0)                       ; $003A
                rts
Offset_0x0262D6:
                cmpi.w  #$0078, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt.s   Offset_0x026310
                subi.w  #$0001, NGHz_Hammer_Pos_X(A0)                    ; $0016
                move.l  Obj_Control_Var_0E(A0), D0                       ; $003A
                move.w  Obj_Control_Var_02(A0), D1                       ; $002E
                addi.w  #$0038, Obj_Control_Var_02(A0)                   ; $002E
                ext.l   D1
                asl.l   #$08, D1
                add.l   D1, D0
                move.l  D0, Obj_Control_Var_0E(A0)                       ; $003A
                move.w  Obj_Control_Var_0E(A0), NGHz_Hammer_Pos_Y(A0) ; $003A, $0018
                cmpi.w  #$0540, NGHz_Hammer_Pos_Y(A0)                    ; $0018
                blt.s   Offset_0x026310
                move.w  #$0000, Obj_Control_Var_02(A0)                   ; $002E
Offset_0x026310:
                rts
;-------------------------------------------------------------------------------  
; Boss_AnimateSprite               
; ->>>>
;-------------------------------------------------------------------------------  
Boss_AnimateSprite:                                            ; Offset_0x026312
                moveq   #$00, D6
                move.l  A1, A4
                lea     (Boss_Animate_Buffer).w, A2                  ; $FFFFF740
                lea     Obj_Boss_Ani_Map(A0), A3                         ; $000B
                tst.b   (A3)
                bne.s   Offset_0x026326
                addq.w  #$02, A2
                bra.s   Offset_0x02632A
Offset_0x026326:
                bsr     Offset_0x026338
Offset_0x02632A:
                moveq   #$00, D6
                move.b  Obj_Ani_Boss_Cnt(A0), D6                         ; $000F
                subq.w  #$01, D6
                bmi.s   Offset_0x02639E
                lea     Obj_Ani_Boss_Frame(A0), A3                       ; $0015
Offset_0x026338:
                move.l  A4, A1
                moveq   #$00, D0
                moveq   #$00, D1
                moveq   #$00, D2
                moveq   #$00, D4
                move.b  (A2)+, D0
                move.b  D0, D1
                lsr.b   #$04, D1
                andi.b  #$0F, D0
                move.b  D0, D2
                cmp.b   D0, D1
                beq.s   Offset_0x026354
                st      D4
Offset_0x026354:
                move.b  D0, D5
                lsl.b   #$04, D5
                or.b    D0, D5
                move.b  (A2)+, D0
                move.b  D0, D1
                lsr.b   #$04, D1
                tst.b   D4
                beq.s   Offset_0x026368
                moveq   #$00, D0
                moveq   #$00, D1
Offset_0x026368:
                andi.b  #$0F, D0
                subi.b  #$01, D0
                bpl.s   Offset_0x02638A
                add.w   D2, D2
                adda.w  $00(A1, D2), A1
                move.b  (A1), D0
                move.b  $01(A1, D1), D2
                bmi.s   Offset_0x0263A0
Offset_0x026380:
                andi.b  #$7F, D2
                move.b  D2, (A3)
                addi.b  #$01, D1
Offset_0x02638A:
                lsl.b   #$04, D1
                or.b    D1, D0
                move.b  D0, $FFFFFFFF(A2)
                move.b  D5, $FFFFFFFE(A2)
                adda.w  #$0006, A3
                dbra    D6, Offset_0x026338
Offset_0x02639E:
                rts
Offset_0x0263A0:
                addq.b  #$01, D2
                bne.s   Offset_0x0263AE
                move.b  #$00, D1
                move.b  $0001(A1), D2                                ; 
                bra.s   Offset_0x026380
Offset_0x0263AE:
                addq.b  #$01, D2
                bne.s   Offset_0x0263BA
                addi.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                rts
Offset_0x0263BA:
                addq.b  #$01, D2
                bne.s   Offset_0x0263C8
                andi.b  #$F0, D5
                or.b    $02(A1, D1), D5
                bra.s   Offset_0x02638A
Offset_0x0263C8:
                addq.b  #$01, D2
                bne.s   Offset_0x0263D8
                moveq   #$00, D3
                move.b  $02(A1, D1), D1
                move.b  $01(A1, D1), D2
                bra.s   Offset_0x026380
Offset_0x0263D8:
                rts
;-------------------------------------------------------------------------------
; Boss_AnimateSprite
; <<<-                                                                                
;-------------------------------------------------------------------------------                
Offset_0x0263DA:
                st      Obj_Control_Var_00(A0)                           ; $002C
                subq.w  #$01, (Boss_Move_Buffer+$0C).w               ; $FFFFF75C
                bmi.s   Offset_0x0263EA
                bsr     Boss_Defeated                          ; Offset_0x023AEC
                bra.s   Offset_0x02640E
Offset_0x0263EA:
                move.b  #$02, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                move.b  #$05, Obj_Ani_Boss_Frame(A0)                     ; $0015
                bset    #$00, Obj_Flags(A0)                              ; $0001
                clr.w   (Boss_Move_Buffer+$08).w                     ; $FFFFF758
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.w  #$FFEE, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
Offset_0x02640E:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x0262AA
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C  
;-------------------------------------------------------------------------------  
Offset_0x026422:
                addq.w  #$01, (Boss_Move_Buffer+$0C).w               ; $FFFFF75C
                beq.s   Offset_0x026432
                bpl.s   Offset_0x026438
                addi.w  #$0018, ($FFFFF75A).w
                bra.s   Offset_0x02645C
Offset_0x026432:
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
                bra.s   Offset_0x02645C
Offset_0x026438:
                cmpi.w  #$0018, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bcs.s   Offset_0x026450
                beq.s   Offset_0x026458
                cmpi.w  #$0020, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bcs.s   Offset_0x02645C
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bra.s   Offset_0x02645C
Offset_0x026450:
                subi.w  #$0008, ($FFFFF75A).w
                bra.s   Offset_0x02645C
Offset_0x026458:
                clr.w   (Boss_Move_Buffer+$0A).w                     ; $FFFFF75A
Offset_0x02645C:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x0262AA
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C   
;-------------------------------------------------------------------------------  
Offset_0x026478:
                move.w  #$0400, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  #$FFC0, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                cmpi.w  #$2180, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
                beq.s   Offset_0x026492
                addq.w  #$02, (Sonic_Level_Limits_Max_X).w           ; $FFFFEECA
                bra.s   Offset_0x026498
Offset_0x026492:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x0264B4
Offset_0x026498:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                move.w  (Boss_Move_Buffer).w, Obj_X(A0)              ; $FFFFF750; $0008
                bsr     Offset_0x0262AA
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C
Offset_0x0264B4:
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
                bne.s   Offset_0x0264C0
                move.b  #$01, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
Offset_0x0264C0:
                addq.l  #$04, A7
                jmp     (DeleteObject)                         ; Offset_0x00D314 
;-------------------------------------------------------------------------------  
Offset_0x0264C8:
                moveq   #$00, D0
                move.l  Obj_Timer(A0), A1                                ; $002A
                cmpi.b  #$08, Obj_Ani_Boss_Routine(A1)                   ; $0026
                blt.s   Offset_0x0264DC
                move.b  #$08, Obj_Ani_Boss_Routine(A0)                   ; $0026
Offset_0x0264DC:
                move.b  Obj_Ani_Boss_Routine(A0), D0                     ; $0026
                move.w  Offset_0x0264E8(PC, D0), D1
                jmp     Offset_0x0264E8(PC, D1)         
;-------------------------------------------------------------------------------   
Offset_0x0264E8:
                dc.w    Offset_0x0264F2-Offset_0x0264E8
                dc.w    Offset_0x026518-Offset_0x0264E8
                dc.w    Offset_0x026530-Offset_0x0264E8
                dc.w    Offset_0x02660A-Offset_0x0264E8
                dc.w    Offset_0x0265B4-Offset_0x0264E8     
;-------------------------------------------------------------------------------  
Offset_0x0264F2:
                bsr     Offset_0x0265DC
                subi.w  #$0002, NGHz_Robotnik_Pos_Y(A0)                  ; $0012
                subi.w  #$0002, NGHz_Hammer_Pos_Y(A0)                    ; $0018
                cmpi.w  #$0488, NGHz_Robotnik_Pos_Y(A0)                  ; $0012
                bgt.s   Offset_0x026514
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.b  #$00, ($FFFFEEBD).w
Offset_0x026514:
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C  
;-------------------------------------------------------------------------------  
Offset_0x026518:
                bsr     Offset_0x0265DC
                move.l  Obj_Timer(A0), A1                                ; $002A
                bclr    #$00, Obj_Control_Var_12(A1)                     ; $003E
                beq.s   Offset_0x02652C
                bsr     Offset_0x02654C
Offset_0x02652C:
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C  
;-------------------------------------------------------------------------------  
Offset_0x026530:
                bsr     Offset_0x0265DC
                subi.w  #$0001, Obj_Control_Var_04(A0)                   ; $0030
                bpl.s   Offset_0x026548
                move.b  #$00, Obj_Boss_Ani_Map(A0)                       ; $000B
                move.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
Offset_0x026548:
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C
Offset_0x02654C:
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                moveq   #$00, D6
                tst.b   Obj_Control_Var_0C(A1)                           ; $0038
                bne.s   Offset_0x026566
                move.b  #$02, Obj_Boss_Ani_Map(A0)                       ; $000B
                move.w  #$2A62, Obj_X(A0)                                ; $0008
                bra.s   Offset_0x026574
Offset_0x026566:
                st      D6
                move.b  #$03, Obj_Boss_Ani_Map(A0)                       ; $000B
                move.w  #$2B4E, Obj_X(A0)                                ; $0008
Offset_0x026574:
                bsr     Jmp_0C_To_SingleObjectLoad             ; Offset_0x026978
                bne.s   Offset_0x026594
                move.b  #$89, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Boss_Routine(A1)                       ; $000A
                move.b  #$06, Obj_Ani_Boss_Routine(A1)                   ; $0026
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.b  D6, Obj_Subtype(A1)                              ; $0028
Offset_0x026594:
                move.w  #$0028, Obj_Control_Var_04(A0)                   ; $0030
                bsr     Jmp_02_To_PseudoRandomNumber           ; Offset_0x026984
                andi.w  #$0003, D0
                add.w   D0, D0
                move.w  Arrows_Target(PC, D0), Obj_Y(A0) ; Offset_0x0265AC, $000C
                rts
;-------------------------------------------------------------------------------
Arrows_Target:                                                 ; Offset_0x0265AC
                dc.w    $0458, $0478, $0498, $04B8      
;-------------------------------------------------------------------------------  
Offset_0x0265B4:
                move.b  #$01, ($FFFFEEBD).w
                addi.w  #$0002, NGHz_Robotnik_Pos_Y(A0)                  ; $0012
                addi.w  #$0002, NGHz_Hammer_Pos_Y(A0)                    ; $0018
                cmpi.w  #$0510, NGHz_Robotnik_Pos_Y(A0)                  ; $0012
                blt.s   Offset_0x0265D8
                move.b  #$00, ($FFFFEEBD).w
                bra     Jmp_20_To_DeleteObject                 ; Offset_0x026972
Offset_0x0265D8:
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C
Offset_0x0265DC:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0011, D3
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                move.w  Obj_Y(A0), -(A7)                                 ; $000C
                move.w  #$2A68, Obj_X(A0)                                ; $0008
                move.w  #$0498, Obj_Y(A0)                                ; $000C
                bsr     Jmp_15_To_SolidObject                  ; Offset_0x02698A
                move.w  (A7)+, Obj_Y(A0)                                 ; $000C
                move.w  (A7)+, Obj_X(A0)                                 ; $0008
                rts   
;-------------------------------------------------------------------------------  
Offset_0x02660A:
                moveq   #$00, D0
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Timer(A1), A1                                ; $002A
                cmpi.b  #$08, Obj_Ani_Boss_Routine(A1)                   ; $0026
                blt.s   Offset_0x026620
                bra     Jmp_20_To_DeleteObject                 ; Offset_0x026972
Offset_0x026620:
                move.b  Obj_Timer(A0), D0                                ; $002A
                move.w  Offset_0x02662C(PC, D0), D1
                jmp     Offset_0x02662C(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x02662C:
                dc.w    Offset_0x026636-Offset_0x02662C
                dc.w    Offset_0x02669E-Offset_0x02662C
                dc.w    Offset_0x0266DE-Offset_0x02662C
                dc.w    Offset_0x0266FA-Offset_0x02662C
                dc.w    Offset_0x026712-Offset_0x02662C   
;-------------------------------------------------------------------------------   
Offset_0x026636:
                move.l  #NGHz_Boss_Arrows_Launcher_Mappings, Obj_Map(A0) ; Offset_0x026752, $0004
                move.w  #$03E0, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$90, $000E(A0)
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                addq.b  #$02, Obj_Timer(A0)                              ; $002A
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.w  #$0004, NGHz_Robotnik_Pos_Y(A0)                  ; $0012
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                addi.w  #$0005, Obj_Y(A0)                                ; $000C
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq.s   Offset_0x026696
                bset    #$00, Obj_Status(A0)                             ; $0022
                bset    #$00, Obj_Flags(A0)                              ; $0001
                move.w  #$FFFC, NGHz_Robotnik_Pos_X(A0)                  ; $0010
                bra.s   Offset_0x02669C
Offset_0x026696:
                move.w  #$0004, NGHz_Robotnik_Pos_X(A0)                  ; $0010
Offset_0x02669C:
                rts      
;-------------------------------------------------------------------------------  
Offset_0x02669E:
                btst    #$07, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0266AC
                move.b  #$08, Obj_Timer(A0)                              ; $002A
Offset_0x0266AC:
                move.w  Obj_X(A0), D0                                    ; $0008
                add.w   NGHz_Robotnik_Pos_X(A0), D0                      ; $0010
                tst.w   NGHz_Robotnik_Pos_X(A0)                          ; $0010
                bpl.s   Offset_0x0266C6
                cmpi.w  #$2A76, D0
                bgt.s   Offset_0x0266D6
                move.w  #$2A76, D0
                bra.s   Offset_0x0266D0
Offset_0x0266C6:
                cmpi.w  #$2B3A, D0
                blt.s   Offset_0x0266D6
                move.w  #$2B3A, D0
Offset_0x0266D0:
                addi.b  #$02, Obj_Timer(A0)                              ; $002A
Offset_0x0266D6:
                move.w  D0, Obj_X(A0)                                    ; $0008
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C    
;-------------------------------------------------------------------------------  
Offset_0x0266DE:
                btst    #$07, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0266EC
                addi.b  #$02, Obj_Timer(A0)                              ; $002A
Offset_0x0266EC:
                lea     (Pillars_Animate_Data), A1             ; Offset_0x026716
                bsr     Jmp_15_To_AnimateSprite                ; Offset_0x02697E
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C 
;-------------------------------------------------------------------------------  
Offset_0x0266FA:
                move.w  Obj_Y(A0), D0                                    ; $000C
                add.w   NGHz_Robotnik_Pos_Y(A0), D0                      ; $0012
                cmpi.w  #$04F0, D0
                bgt     Jmp_20_To_DeleteObject                 ; Offset_0x026972
                move.w  D0, Obj_Y(A0)                                    ; $000C
                bra     Jmp_1B_To_DisplaySprite                ; Offset_0x02696C   
;-------------------------------------------------------------------------------  
Offset_0x026712:
                bra     Jmp_20_To_DeleteObject                 ; Offset_0x026972    
;-------------------------------------------------------------------------------
Pillars_Animate_Data:                                          ; Offset_0x026716
                dc.w    Offset_0x02671A-Pillars_Animate_Data
                dc.w    Offset_0x026731-Pillars_Animate_Data
Offset_0x02671A:
                dc.b    $01, $04, $06, $05, $04, $06, $04, $05
                dc.b    $04, $06, $04, $04, $06, $05, $04, $06
                dc.b    $04, $05, $04, $06, $04, $FD, $01
Offset_0x026731:
                dc.b    $0F, $04, $04, $04, $04, $04, $04, $04
                dc.b    $04, $04, $04, $04, $04, $04, $04, $04
                dc.b    $04, $04, $04, $04, $04, $04, $04, $04
                dc.b    $04, $04, $04, $04, $04, $04, $04, $F9
                dc.b    $00
;-------------------------------------------------------------------------------
NGHz_Boss_Arrows_Launcher_Mappings:                            ; Offset_0x026752
                dc.w    Offset_0x026760-NGHz_Boss_Arrows_Launcher_Mappings
                dc.w    Offset_0x02678A-NGHz_Boss_Arrows_Launcher_Mappings
                dc.w    Offset_0x0267B4-NGHz_Boss_Arrows_Launcher_Mappings
                dc.w    Offset_0x0267BE-NGHz_Boss_Arrows_Launcher_Mappings
                dc.w    Offset_0x0267C8-NGHz_Boss_Arrows_Launcher_Mappings
                dc.w    Offset_0x0267D2-NGHz_Boss_Arrows_Launcher_Mappings
                dc.w    Offset_0x0267DC-NGHz_Boss_Arrows_Launcher_Mappings
Offset_0x026760:
                dc.w    $0005
                dc.l    $280F208B, $2045FFF0
                dc.l    $080F208B, $2045FFF0
                dc.l    $E80F208B, $2045FFF0
                dc.l    $C80F208B, $2045FFF0
                dc.l    $C00C2087, $2043FFF0
Offset_0x02678A:
                dc.w    $0005
                dc.l    $280F288B, $2845FFF0
                dc.l    $080F288B, $2845FFF0
                dc.l    $E80F288B, $2845FFF0
                dc.l    $C80F288B, $2845FFF0
                dc.l    $C00C2887, $2843FFF0
Offset_0x0267B4:
                dc.w    $0001
                dc.l    $FC04209B, $204DFFF8
Offset_0x0267BE:
                dc.w    $0001
                dc.l    $FC04289B, $284DFFF8
Offset_0x0267C8:
                dc.w    $0001
                dc.l    $FC0C209D, $204EFFF0
Offset_0x0267D2:
                dc.w    $0001
                dc.l    $FC0C20A1, $2050FFF0
Offset_0x0267DC:
                dc.w    $0001
                dc.l    $FC0C20A5, $2052FFF0     
;-------------------------------------------------------------------------------   
NGHz_Boss_Animate_Data:                                        ; Offset_0x0267E6
                dc.w    NGHz_Robotnik_Faces-NGHz_Boss_Animate_Data ; Offset_0x0267F4
                dc.w    NGHz_Ship_Boost-NGHz_Boss_Animate_Data     ; Offset_0x0267F8
                dc.w    NGHz_Hammer_Start-NGHz_Boss_Animate_Data   ; Offset_0x0267FC
                dc.w    NGHz_Hammer_Usage-NGHz_Boss_Animate_Data   ; Offset_0x0267FF
                dc.w    NGHz_Hammer_Fall-NGHz_Boss_Animate_Data    ; Offset_0x02680A
                dc.w    Offset_0x02680D-NGHz_Boss_Animate_Data
                dc.w    Offset_0x026818-NGHz_Boss_Animate_Data
NGHz_Robotnik_Faces:                                           ; Offset_0x0267F4
                dc.b    $07, $00, $01, $FF
NGHz_Ship_Boost:                                               ; Offset_0x0267F8
                dc.b    $01, $06, $07, $FF
NGHz_Hammer_Start:                                             ; Offset_0x0267FC
                dc.b    $0F, $09, $FF
NGHz_Hammer_Usage:                                             ; Offset_0x0267FF
                dc.b    $02, $0A, $0A, $0B, $0B, $0B, $0B, $0B
                dc.b    $0A, $0A, $FE
NGHz_Hammer_Fall:                                              ; Offset_0x02680A
                dc.b    $0F, $08, $FF
Offset_0x02680D:
                dc.b    $07, $02, $03, $02, $03, $02, $03, $02
                dc.b    $03, $FD, $00
Offset_0x026818:
                dc.b    $07, $00, $04, $00, $04, $00, $04, $00
                dc.b    $04, $FD, $00, $00   
;-------------------------------------------------------------------------------
NGHz_Boss_Ship_Mappings:                                       ; Offset_0x026824
                dc.w    Offset_0x02683C-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x02684E-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x026860-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x026872-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x026884-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x026896-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x0268A8-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x0268BA-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x0268CC-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x0268FE-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x026928-NGHz_Boss_Ship_Mappings
                dc.w    Offset_0x026952-NGHz_Boss_Ship_Mappings
Offset_0x02683C:
                dc.w    $0002
                dc.l    $E80D0150, $00A8FFE8
                dc.l    $E8050148, $00A4FFD8
Offset_0x02684E:
                dc.w    $0002
                dc.l    $E80D0158, $00ACFFE8
                dc.l    $E8050148, $00A4FFD8
Offset_0x026860:
                dc.w    $0002
                dc.l    $E80D0160, $00B0FFE8
                dc.l    $E805014C, $00A6FFD8
Offset_0x026872:
                dc.w    $0002
                dc.l    $E80D0168, $00B4FFE8
                dc.l    $E805014C, $00A6FFD8
Offset_0x026884:
                dc.w    $0002
                dc.l    $E80D0170, $00B8FFE8
                dc.l    $E805014C, $00A6FFD8
Offset_0x026896:
                dc.w    $0002
                dc.l    $E80D0178, $00BCFFE8
                dc.l    $E805014C, $00A6FFD8
Offset_0x0268A8:
                dc.w    $0002
                dc.l    $18050081, $0040FFE8
                dc.l    $18050081, $00400008
Offset_0x0268BA:
                dc.w    $0002
                dc.l    $18040085, $0042FFE8
                dc.l    $18040085, $00420008
Offset_0x0268CC:
                dc.w    $0006
                dc.l    $D8050140, $00A0FFFA
                dc.l    $E8050144, $00A20008
                dc.l    $F80A2070, $2038FFD0
                dc.l    $F80F2128, $2094FFE8
                dc.l    $F8072079, $203CFFE8
                dc.l    $F8072079, $203C0008
Offset_0x0268FE:
                dc.w    $0005
                dc.l    $EA0F2000, $2000FF9C
                dc.l    $D20A2010, $2008FFA4
                dc.l    $D20B2019, $200CFFBC
                dc.l    $F2052025, $2012FFBC
                dc.l    $F8052064, $2032FFC0
Offset_0x026928:
                dc.w    $0005
                dc.l    $F10F2029, $2014FF9D
                dc.l    $D90E2039, $201CFFA5
                dc.l    $E1022045, $2022FFC5
                dc.l    $F1032048, $2024FFBD
                dc.l    $F8052068, $2034FFC0
Offset_0x026952:
                dc.w    $0003
                dc.l    $EC0F204C, $2026FFA0
                dc.l    $0C0D205C, $202EFFA0
                dc.l    $F805206C, $2036FFC0
;===============================================================================
; Objeto 0x89 - Robotnik na Neo Green Hill
; <<<- 
;===============================================================================