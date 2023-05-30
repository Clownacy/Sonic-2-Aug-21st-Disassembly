;===============================================================================
; Objeto 0x2E - Conteúdo dos monitores
; ->>>
;===============================================================================    
; Offset_0x00B2D2:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00B2E0(PC, D0), D1
                jmp     Offset_0x00B2E0(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x00B2E0:
                dc.w    Offset_0x00B2E6-Offset_0x00B2E0
                dc.w    Offset_0x00B32A-Offset_0x00B2E0
                dc.w    Offset_0x00B492-Offset_0x00B2E0     
;-------------------------------------------------------------------------------  
Offset_0x00B2E6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0680, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$24, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.w  #$FD00, Obj_Speed_Y(A0)                          ; $0012
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $001C
                addq.b  #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.l  #Monitors_Mappings, A1                 ; Offset_0x00B580
                add.b   D0, D0
                adda.w  $00(A1, D0), A1
                addq.w  #$02, A1
                move.l  A1, Obj_Map(A0)                                  ; $0004
;-------------------------------------------------------------------------------  
Offset_0x00B32A:
                bsr.s   Offset_0x00B330
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00B330:
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bpl     Offset_0x00B344
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                rts
Offset_0x00B344:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$001D, Obj_Ani_Time(A0)                         ; $001E
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $001C
                add.w   D0, D0
                move.w  Monitor_Subroutines(PC, D0), D0        ; Offset_0x00B35E
                jmp     Monitor_Subroutines(PC, D0)            ; Offset_0x00B35E
;-------------------------------------------------------------------------------
Monitor_Subroutines:                                           ; Offset_0x00B35E
                dc.w    Monitor_Empty-Monitor_Subroutines      ; Offset_0x00B372
                dc.w    Monitor_SonicLife-Monitor_Subroutines  ; Offset_0x00B374
                dc.w    Monitor_MilesLife-Monitor_Subroutines  ; Offset_0x00B386
                dc.w    Monitor_Robotnik-Monitor_Subroutines   ; Offset_0x00B372
                dc.w    Monitor_Rings-Monitor_Subroutines      ; Offset_0x00B398
                dc.w    Monitor_Shoes-Monitor_Subroutines      ; Offset_0x00B3D2
                dc.w    Monitor_Shield-Monitor_Subroutines     ; Offset_0x00B3FA
                dc.w    Monitor_Invincibility-Monitor_Subroutines ; Offset_0x00B410
                dc.w    Monitor_Question_Mark-Monitor_Subroutines ; Offset_0x00B43C
                dc.w    Monitor_Spring-Monitor_Subroutines     ; Offset_0x00B372
;-------------------------------------------------------------------------------
Monitor_Empty:                                                 ; Offset_0x00B372
Monitor_Robotnik:                                              ; Offset_0x00B372
Monitor_Spring:                                                ; Offset_0x00B372
                rts
;-------------------------------------------------------------------------------                    
Monitor_SonicLife:                                             ; Offset_0x00B374
                addq.b  #$01, (Life_Count).w                         ; $FFFFFE12
                addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
                move.w  #$0098, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
;-------------------------------------------------------------------------------
Monitor_MilesLife:                                             ; Offset_0x00B386
                addq.b  #$01, (Life_Count).w                         ; $FFFFFE12
                addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
                move.w  #$0098, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
;-------------------------------------------------------------------------------
Monitor_Rings:                                                 ; Offset_0x00B398
                addi.w  #$000A, (Ring_Count).w                       ; $FFFFFE20
                ori.b   #$01, (HUD_Rings_Refresh_Flag).w             ; $FFFFFE1D
                cmpi.w  #$0064, (Ring_Count).w                       ; $FFFFFE20
                bcs.s   Offset_0x00B3C8
                bset    #$01, (Ring_Life_Flag).w                     ; $FFFFFE1B
                beq     Monitor_SonicLife                      ; Offset_0x00B374
                cmpi.w  #$00C8, (Ring_Count).w                       ; $FFFFFE20
                bcs.s   Offset_0x00B3C8
                bset    #$02, (Ring_Life_Flag).w                     ; $FFFFFE1B
                beq     Monitor_SonicLife                      ; Offset_0x00B374
Offset_0x00B3C8:
                move.w  #$00B5, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
;-------------------------------------------------------------------------------    
Monitor_Shoes:                                                 ; Offset_0x00B3D2
                move.b  #$01, (Hi_Speed_Flag).w                      ; $FFFFFE2E
                move.w  #$04B0, ($FFFFB034).w
                move.w  #$0C00, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0018, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0080, (Sonic_Deceleration).w               ; $FFFFF764
                move.w  #$00FB, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
;-------------------------------------------------------------------------------
Monitor_Shield:                                                ; Offset_0x00B3FA
                move.b  #$01, (Shield_Flag).w                        ; $FFFFFE2C
                move.b  #$38, ($FFFFB180).w
                move.w  #$00AF, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
;-------------------------------------------------------------------------------
Monitor_Invincibility:                                         ; Offset_0x00B410
                move.b  #$01, (Invincibility_Flag).w                 ; $FFFFFE2D
                move.w  #$04B0, ($FFFFB032).w
                move.b  #$35, ($FFFFB200).w
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                bne.s   Offset_0x00B43A
                cmpi.b  #$0C, ($FFFFB028).w
                bls.s   Offset_0x00B43A
                move.w  #$0097, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
Offset_0x00B43A:
                rts
;-------------------------------------------------------------------------------
Monitor_Question_Mark:                                         ; Offset_0x00B43C
                move.b  #$01, ($FFFFF65F).w
                move.b  #$0F, ($FFFFF65E).w
                move.b  #$01, (Super_Sonic_Flag).w                   ; $FFFFFE19
                move.b  #$81, ($FFFFB02A).w
                move.b  #$1F, ($FFFFB01C).w
                move.b  #$7E, ($FFFFB540).w
                move.w  #$0A00, (Sonic_Max_Speed).w                  ; $FFFFF760
                move.w  #$0030, (Sonic_Acceleration).w               ; $FFFFF762
                move.w  #$0100, (Sonic_Deceleration).w               ; $FFFFF764
                move.w  #$0000, ($FFFFB032).w
                move.b  #$01, (Invincibility_Flag).w                 ; $FFFFFE2D
                move.w  #$00DF, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                move.w  #$0096, D0
                jmp     (Play_Music)                           ; Offset_0x00150C
;-------------------------------------------------------------------------------
Offset_0x00B492:
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bmi     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322  
;===============================================================================
; Objeto 0x2E - Conteúdo dos monitores
; <<<-
;===============================================================================