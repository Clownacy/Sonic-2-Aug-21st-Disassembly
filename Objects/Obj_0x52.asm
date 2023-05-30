;===============================================================================
; Objeto 0x52 - Robotnik na Hill Top
; ->>>
;===============================================================================
; Offset_0x025860:
                moveq   #$00, D0
                move.b  Obj_Boss_Routine(A0), D0                         ; $000A
                move.w  Offset_0x02586E(PC, D0), D1
                jmp     Offset_0x02586E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02586E:
                dc.w    Offset_0x025878-Offset_0x02586E
                dc.w    Offset_0x025906-Offset_0x02586E
                dc.w    Offset_0x025AF4-Offset_0x02586E
                dc.w    Offset_0x025B6A-Offset_0x02586E
                dc.w    Offset_0x025D90-Offset_0x02586E          
;-------------------------------------------------------------------------------
Offset_0x025878:
                move.l  #HTz_Boss_Mappings, Obj_Map(A0) ; Offset_0x025E3C, $0004
                move.w  #$03C1, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$90, $000E(A0)
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  #$30A0, Obj_X(A0)                                ; $0008
                move.w  #$0580, Obj_Y(A0)                                ; $000C
                move.b  #$01, Obj_Control_Var_00(A0)                     ; $002C
                move.b  #$01, Obj_Boss_Ani_Map(A0)                       ; $000B
                addq.b  #$02, Obj_Boss_Routine(A0)                       ; $000A
                bset    #$06, Obj_Flags(A0)                              ; $0001
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Boss_Hit_2(A0)                         ; $0032
                move.w  #$FF20, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.w  Obj_X(A0), (Boss_Move_Buffer).w              ; $FFFFF750; $0008
                move.w  Obj_Y(A0), (Boss_Move_Buffer+$04).w          ; $FFFFF754; $000C
                move.w  Obj_X(A0), HTz_Robotnik_Pos_X(A0)         ; $0008, $0010
                move.w  Obj_Y(A0), HTz_Robotnik_Pos_Y(A0)         ; $000C, $0012
                move.b  #$02, Obj_Ani_Boss_Frame(A0)                     ; $0015
                bsr     Offset_0x0258F0
                rts
Offset_0x0258F0:
                lea     (Boss_Animate_Buffer).w, A2                  ; $FFFFF740
                move.b  #$06, (A2)+
                move.b  #$00, (A2)+
                move.b  #$10, (A2)+
                move.b  #$00, (A2)+
                rts 
;-------------------------------------------------------------------------------
Offset_0x025906:
                moveq   #$00, D0
                move.b  Obj_Ani_Boss_Routine(A0), D0                     ; $0026
                move.w  Offset_0x025914(PC, D0), D1
                jmp     Offset_0x025914(PC, D1)                                 
;-------------------------------------------------------------------------------
Offset_0x025914:
                dc.w    Offset_0x02591E-Offset_0x025914
                dc.w    Offset_0x02596A-Offset_0x025914
                dc.w    Offset_0x0259E6-Offset_0x025914
                dc.w    Offset_0x025A1A-Offset_0x025914
                dc.w    Offset_0x025C9E-Offset_0x025914  
;-------------------------------------------------------------------------------
Offset_0x02591E:
                move.b  #$00, ($FFFFF73F).w
                bsr     Boss_Move                              ; Offset_0x0245FA
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x02593E
                cmpi.w  #$0520, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bgt.s   Offset_0x02595C
                move.w  #$0520, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bra.s   Offset_0x02594C
Offset_0x02593E:
                cmpi.w  #$04D8, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bgt.s   Offset_0x02595C
                move.w  #$04D8, (Boss_Move_Buffer+$04).w             ; $FFFFF754
Offset_0x02594C:
                move.w  #$0000, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                move.b  #$3C, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x02595C:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)          ; $FFFFF754; $000C
                bsr     Boss_Hit                               ; Offset_0x02459E
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0   
;-------------------------------------------------------------------------------
Offset_0x02596A:
                subi.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                bpl.s   Offset_0x0259CC
                move.b  #$01, ($FFFFF73F).w
                move.b  #$01, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                cmpi.b  #$E8, Obj_Control_Var_12(A0)                     ; $003E
                bne.s   Offset_0x0259CC
                bsr     Jmp_0B_To_SingleObjectLoad             ; Offset_0x025FBC
                bne.s   Offset_0x0259B6
                move.b  #$52, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Boss_Routine(A1)                       ; $000A
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                andi.b  #$01, Obj_Flags(A1)                              ; $0001
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$2F, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x0259B6:
                bsr     Boss_Hit                               ; Offset_0x02459E
                bsr     Offset_0x025AE2
                lea     (HTz_Boss_Animate_Data), A1            ; Offset_0x025E08
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x0259CC:
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                jsr     (CalcSine)                             ; Offset_0x003282
                asr.w   #$07, D0
                add.w   (Boss_Move_Buffer+$04).w, D0                 ; $FFFFF754
                move.w  D0, Obj_Y(A0)                                    ; $000C
                addq.b  #$04, Obj_Map_Id(A0)                             ; $001A
                bra.s   Offset_0x0259B6    
;-------------------------------------------------------------------------------
Offset_0x0259E6:
                move.b  #$00, ($FFFFF73F).w
                move.b  #$00, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                move.b  #$10, (Boss_Animate_Buffer+$02).w            ; $FFFFF742
                move.b  #$00, (Boss_Animate_Buffer+$03).w            ; $FFFFF743
                subi.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                bne     Offset_0x0259CC
                move.w  #$00E0, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                addq.b  #$02, Obj_Ani_Boss_Routine(A0)                   ; $0026
                bsr     Offset_0x025AE2
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0 
;-------------------------------------------------------------------------------
Offset_0x025A1A:
                bsr     Boss_Move                              ; Offset_0x0245FA
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x025A2E
                cmpi.w  #$0540, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x025A5C
                bra.s   Offset_0x025A36
Offset_0x025A2E:
                cmpi.w  #$04F0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x025A5C
Offset_0x025A36:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x025A5C
                st      Obj_Control_Var_0C(A0)                           ; $0038
                bsr     Jmp_0B_To_SingleObjectLoad             ; Offset_0x025FBC
                bne.s   Offset_0x025A5C
                move.b  #$52, (A1)
                move.b  #$06, Obj_Boss_Routine(A1)                       ; $000A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
Offset_0x025A5C:
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x025A72
                cmpi.w  #$05D0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x025AD4
                move.w  #$05D0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                bra.s   Offset_0x025A80
Offset_0x025A72:
                cmpi.w  #$0580, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                blt.s   Offset_0x025AD4
                move.w  #$0580, (Boss_Move_Buffer+$04).w             ; $FFFFF754
Offset_0x025A80:
                move.w  #$FF20, (Boss_Move_Buffer+$0A).w             ; $FFFFF75A
                move.b  #$00, Obj_Ani_Boss_Routine(A0)                   ; $0026
                sf      Obj_Control_Var_0C(A0)                           ; $0038
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                subi.w  #$2FEC, D0
                bmi.s   Offset_0x025AAC
                move.w  #$0580, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                move.w  #$30A0, Obj_X(A0)                                ; $0008
                st      Obj_Control_Var_00(A0)                           ; $002C
                bra.s   Offset_0x025ABC
Offset_0x025AAC:
                move.w  #$2F38, Obj_X(A0)                                ; $0008
                move.w  #$05D0, (Boss_Move_Buffer+$04).w             ; $FFFFF754
                sf      Obj_Control_Var_00(A0)                           ; $002C
Offset_0x025ABC:
                move.w  Obj_X(A0), D0                                    ; $0008
                cmp.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bgt.s   Offset_0x025ACE
                bset    #$00, Obj_Flags(A0)                              ; $0001
                bra.s   Offset_0x025AD4
Offset_0x025ACE:
                bclr    #$00, Obj_Flags(A0)                              ; $0001
Offset_0x025AD4:
                move.w  (Boss_Move_Buffer+$04).w, Obj_Y(A0)   ; $FFFFF754, $000C
                bsr     Boss_Hit                               ; Offset_0x02459E
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x025AE2:
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  Obj_Y(A0), D1                                    ; $000C
                move.w  D0, HTz_Robotnik_Pos_X(A0)                       ; $0010
                move.w  D1, HTz_Robotnik_Pos_Y(A0)                       ; $0012
                rts      
;-------------------------------------------------------------------------------
Offset_0x025AF4:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x025B02(PC, D0), D1
                jmp     Offset_0x025B02(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x025B02:
                dc.w    Offset_0x025B06-Offset_0x025B02
                dc.w    Offset_0x025B54-Offset_0x025B02         
;-------------------------------------------------------------------------------
Offset_0x025B06:
                move.l  #HTz_Boss_Mappings, Obj_Map(A0) ; Offset_0x025E3C, $0004
                move.w  #$0421, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$98, Obj_Col_Flags(A0)                          ; $0020
                subi.w  #$001C, Obj_Y(A0)                                ; $000C
                move.w  #$FF90, D0
                move.w  #$FFFC, D1
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x025B4A
                neg.w   D0
                neg.w   D1
Offset_0x025B4A:
                add.w   D0, Obj_X(A0)                                    ; $0008
                move.w  D1, HTz_Robotnik_Pos_X(A0)                       ; $0010
                rts    
;-------------------------------------------------------------------------------
Offset_0x025B54:
                move.w  HTz_Robotnik_Pos_X(A0), D1                       ; $0010
                add.w   D1, Obj_X(A0)                                    ; $0008
                lea     (HTz_Boss_Animate_Data), A1            ; Offset_0x025E08
                bsr     Jmp_14_To_AnimateSprite                ; Offset_0x025FC8
                bra     Jmp_25_To_MarkObjGone                  ; Offset_0x025FC2         
;-------------------------------------------------------------------------------
Offset_0x025B6A:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x025B78(PC, D0), D1
                jmp     Offset_0x025B78(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x025B78:
                dc.w    Offset_0x025B7C-Offset_0x025B78
                dc.w    Offset_0x025C0A-Offset_0x025B78    
;-------------------------------------------------------------------------------
Offset_0x025B7C:
                move.l  A0, A1
                moveq   #$00, D2
                moveq   #$01, D1
                bra.s   Offset_0x025B96 
;-------------------------------------------------------------------------------
Offset_0x025B84:
                bsr     Jmp_0B_To_SingleObjectLoad             ; Offset_0x025FBC
                bne.s   Offset_0x025C08
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C    
;-------------------------------------------------------------------------------
Offset_0x025B96:
                move.b  #$52, (A1)
                move.b  #$06, Obj_Boss_Routine(A1)                       ; $000A
                move.l  #HTz_Boss_Mappings, Obj_Map(A1) ; Offset_0x025E3C, $0004
                move.w  #$0421, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                addq.b  #$02, Obj_Routine_2(A1)                          ; $0025
                move.b  #$07, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$8B, Obj_Col_Flags(A1)                          ; $0020
                move.b  D2, Obj_Control_Var_02(A1)                       ; $002E
                move.b  #$08, Obj_Height_2(A1)                           ; $0016
                move.b  #$08, Obj_Width_2(A1)                            ; $0017
                move.w  Obj_X(A1), Obj_Timer(A1)                  ; $0008, $002A
                move.w  #$1C00, D0
                tst.w   D2
                bne.s   Offset_0x025BEA
                neg.w   D0
Offset_0x025BEA:
                move.w  D0, Obj_Speed(A1)                                ; $0010
                move.w  #$AC00, Obj_Speed_Y(A1)                          ; $0012
                cmpi.w  #$2F38, Obj_X(A1)                                ; $0008
                beq.s   Offset_0x025C02
                move.w  #$9C00, Obj_Speed_Y(A1)                          ; $0012
Offset_0x025C02:
                addq.w  #$01, D2
                dbra    D1, Offset_0x025B84
Offset_0x025C08:
                rts     
;-------------------------------------------------------------------------------
Offset_0x025C0A:
                bsr     Offset_0x025C6C
                bsr     Jmp_05_To_ObjHitFloor                  ; Offset_0x025FCE
                tst.w   D1
                bpl.s   Offset_0x025C5E
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  #$20, (A0)
                move.b  #$0A, Obj_Routine(A0)                            ; $0024
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.l  #Fireball_Mappings, Obj_Map(A0) ; Offset_0x0180D0, $0004
                move.w  #$839E, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_2E_To_ModifySpriteAttr_2P          ; Offset_0x025FDA
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0009, Obj_Boss_Hit_2(A0)                       ; $0032
                move.b  #$03, Obj_Control_Var_0A(A0)                     ; $0036
                bra     Jmp_00_To_Obj_0x20_HTz_Boss_FireBall   ; Offset_0x025FD4
Offset_0x025C5E:
                lea     (HTz_Boss_Animate_Data), A1            ; Offset_0x025E08
                bsr     Jmp_14_To_AnimateSprite                ; Offset_0x025FC8
                bra     Jmp_25_To_MarkObjGone                  ; Offset_0x025FC2
Offset_0x025C6C:
                move.l  Obj_Timer(A0), D2                                ; $002A
                move.l  Obj_Y(A0), D3                                    ; $000C
                move.w  Obj_Speed(A0), D0                                ; $0010
                ext.l   D0
                asl.l   #$04, D0
                add.l   D0, D2
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                addi.w  #$0380, Obj_Speed_Y(A0)                          ; $0012
                ext.l   D0
                asl.l   #$04, D0
                add.l   D0, D3
                move.l  D2, Obj_Timer(A0)                                ; $002A
                move.l  D3, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Timer(A0), Obj_X(A0)                  ; $0008, $002A
                rts     
;-------------------------------------------------------------------------------
Offset_0x025C9E:
                move.b  #$00, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                subi.w  #$0001, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bmi.s   Offset_0x025CDA
                cmpi.w  #$001E, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt.s   Offset_0x025CD2
                move.b  #$10, Obj_Boss_Ani_Map(A0)                       ; $000B
                bsr     Boss_Defeated                          ; Offset_0x023AEC
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$1F, D0
                bne     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
                bsr     Offset_0x025D34
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x025CD2:
                bsr     Boss_Defeated                          ; Offset_0x023AEC
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x025CDA:
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$1F, D0
                bne     Offset_0x025CEA
                bsr     Offset_0x025D34
Offset_0x025CEA:
                cmpi.w  #$FFC4, (Boss_Move_Buffer+$0C).w             ; $FFFFF75C
                bgt     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
                addq.w  #$02, Obj_Y(A0)                                  ; $000C
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                bne.s   Offset_0x025D0C
                cmpi.w  #$0540, Obj_Y(A0)                                ; $000C
                bgt     Offset_0x025D1A
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x025D0C:
                cmpi.w  #$04F0, Obj_Y(A0)                                ; $000C
                bgt     Offset_0x025D1A
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x025D1A:
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
                bne.s   Offset_0x025D30
                move.b  #$01, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
                move.w  ($FFFFEEC2).w, (Sonic_Level_Limits_Max_X).w  ; $FFFFEECA
                bra     Jmp_1F_To_DeleteObject                 ; Offset_0x025FB6
Offset_0x025D30:
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
Offset_0x025D34:
                bsr     Jmp_0B_To_SingleObjectLoad             ; Offset_0x025FBC
                bne.s   Offset_0x025D8E
                move.b  #$52, (A1)
                move.b  #$08, Obj_Boss_Routine(A1)                       ; $000A
                move.l  #HTz_Boss_Defeated_Smoke_Mappings, Obj_Map(A1) ; Offset_0x025DD8, $0004
                move.w  #$05E4, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$01, Obj_Priority(A1)                           ; $0018
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_X(A0), Obj_Timer(A1)                  ; $0008, $002A
                subi.w  #$0028, Obj_Y(A1)                                ; $000C
                move.w  #$FFA0, Obj_Speed(A1)                            ; $0010
                move.w  #$FF40, Obj_Speed_Y(A1)                          ; $0012
                move.b  #$00, Obj_Map_Id(A1)                             ; $001A
                move.b  #$11, Obj_Ani_Time(A1)                           ; $001E
Offset_0x025D8E:
                rts 
;-------------------------------------------------------------------------------
Offset_0x025D90:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x025DAA
                move.b  #$11, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$04, Obj_Map_Id(A0)                             ; $001A
                beq     Jmp_1F_To_DeleteObject                 ; Offset_0x025FB6
Offset_0x025DAA:
                move.l  Obj_Timer(A0), D2                                ; $002A
                move.l  Obj_Y(A0), D3                                    ; $000C
                move.w  Obj_Speed(A0), D0                                ; $0010
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D2, Obj_Timer(A0)                                ; $002A
                move.w  Obj_Timer(A0), Obj_X(A0)                  ; $0008, $002A
                move.l  D3, Obj_Y(A0)                                    ; $000C
                bra     Jmp_1A_To_DisplaySprite                ; Offset_0x025FB0
;-------------------------------------------------------------------------------
HTz_Boss_Defeated_Smoke_Mappings:                              ; Offset_0x025DD8
                dc.w    Offset_0x025DE0-HTz_Boss_Defeated_Smoke_Mappings
                dc.w    Offset_0x025DEA-HTz_Boss_Defeated_Smoke_Mappings
                dc.w    Offset_0x025DF4-HTz_Boss_Defeated_Smoke_Mappings
                dc.w    Offset_0x025DFE-HTz_Boss_Defeated_Smoke_Mappings
Offset_0x025DE0:
                dc.w    $0001
                dc.l    $F8052000, $2000FFF8
Offset_0x025DEA:
                dc.w    $0001
                dc.l    $F8052004, $2002FFF8
Offset_0x025DF4:
                dc.w    $0001
                dc.l    $F8052008, $2004FFF8
Offset_0x025DFE:
                dc.w    $0001
                dc.l    $F805200C, $2006FFF8
;-------------------------------------------------------------------------------
HTz_Boss_Animate_Data:                                         ; Offset_0x025E08
                dc.w    Offset_0x025E18-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E1D-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E22-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E27-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E2C-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E30-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E34-HTz_Boss_Animate_Data
                dc.w    Offset_0x025E37-HTz_Boss_Animate_Data
Offset_0x025E18:
                dc.b    $01, $02, $03, $FD, $01
Offset_0x025E1D:
                dc.b    $02, $04, $05, $FD, $02
Offset_0x025E22:
                dc.b    $03, $06, $07, $FD, $03
Offset_0x025E27:
                dc.b    $04, $08, $09, $FD, $04
Offset_0x025E2C:
                dc.b    $05, $0A, $0B, $FE
Offset_0x025E30:
                dc.b    $03, $0C, $0D, $FF
Offset_0x025E34:
                dc.b    $0F, $01, $FF
Offset_0x025E37:
                dc.b    $03, $0E, $0F, $FF, $00   
;-------------------------------------------------------------------------------
HTz_Boss_Mappings:                                             ; Offset_0x025E3C
                dc.w    HTz_Boss_Mappings-HTz_Boss_Mappings
                dc.w    Offset_0x025E5E-HTz_Boss_Mappings
                dc.w    Offset_0x025EA0-HTz_Boss_Mappings
                dc.w    Offset_0x025EAA-HTz_Boss_Mappings
                dc.w    Offset_0x025EB4-HTz_Boss_Mappings
                dc.w    Offset_0x025EBE-HTz_Boss_Mappings
                dc.w    Offset_0x025ED0-HTz_Boss_Mappings
                dc.w    Offset_0x025EE2-HTz_Boss_Mappings
                dc.w    Offset_0x025EFC-HTz_Boss_Mappings
                dc.w    Offset_0x025F16-HTz_Boss_Mappings
                dc.w    Offset_0x025F30-HTz_Boss_Mappings
                dc.w    Offset_0x025F42-HTz_Boss_Mappings
                dc.w    Offset_0x025F4C-HTz_Boss_Mappings
                dc.w    Offset_0x025F56-HTz_Boss_Mappings
                dc.w    Offset_0x025F60-HTz_Boss_Mappings
                dc.w    Offset_0x025F6A-HTz_Boss_Mappings
                dc.w    Offset_0x025F74-HTz_Boss_Mappings
Offset_0x025E5E:
                dc.w    $0008
                dc.l    $04052000, $2000FFE0
                dc.l    $14052004, $2002FFE0
                dc.l    $040F2008, $2004FFF0
                dc.l    $04072018, $200C0010
                dc.l    $F40D0060, $0030FFE0
                dc.l    $F40D0068, $00340000
                dc.l    $DC0A2070, $2038FFE8
                dc.l    $DC062079, $203C0000
Offset_0x025EA0:
                dc.w    $0001
                dc.l    $DF040083, $0041FFD8
Offset_0x025EAA:
                dc.w    $0001
                dc.l    $DF040085, $0042FFD8
Offset_0x025EB4:
                dc.w    $0001
                dc.l    $DF080087, $0043FFD0
Offset_0x025EBE:
                dc.w    $0002
                dc.l    $DF0C008A, $0045FFC0
                dc.l    $DF00008E, $0047FFE0
Offset_0x025ED0:
                dc.w    $0002
                dc.l    $DF0C008F, $0047FFB0
                dc.l    $DF080093, $0049FFD0
Offset_0x025EE2:
                dc.w    $0003
                dc.l    $DF0C0096, $004BFFA0
                dc.l    $DF0C009A, $004DFFC0
                dc.l    $DF00009E, $004FFFE0
Offset_0x025EFC:
                dc.w    $0003
                dc.l    $DF0C009F, $004FFF90
                dc.l    $DF0C00A3, $0051FFB0
                dc.l    $DF0800A7, $0053FFD0
Offset_0x025F16:
                dc.w    $0003
                dc.l    $DF0C00AA, $0055FF88
                dc.l    $DF0C00AE, $0057FFA8
                dc.l    $DF0800B2, $0059FFC8
Offset_0x025F30:
                dc.w    $0002
                dc.l    $DF0C00B5, $005AFF88
                dc.l    $DF0C00B9, $005CFFA8
Offset_0x025F42:
                dc.w    $0001
                dc.l    $DF0C00BD, $005EFF88
Offset_0x025F4C:
                dc.w    $0001
                dc.l    $FC000061, $0030FFFC
Offset_0x025F56:
                dc.w    $0001
                dc.l    $FC000062, $0031FFFC
Offset_0x025F60:
                dc.w    $0001
                dc.l    $F8050063, $0031FFF8
Offset_0x025F6A:
                dc.w    $0001
                dc.l    $F8050067, $0033FFF8
Offset_0x025F74:
                dc.w    $0007
                dc.l    $04052000, $2000FFE0
                dc.l    $14052004, $2002FFE0
                dc.l    $040F2008, $2004FFF0
                dc.l    $04072018, $200C0010
                dc.l    $F40D0060, $0030FFE0
                dc.l    $F40D0068, $00340000
                dc.l    $EC0C007F, $003FFFF0
;===============================================================================
; Objeto 0x52 - Robotnik na Hill Top
; <<<-
;===============================================================================