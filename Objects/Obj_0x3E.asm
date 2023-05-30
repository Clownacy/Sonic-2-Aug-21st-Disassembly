;===============================================================================
; Objeto 0x3E - Container de animais nas fases que contém chefe
; ->>>
;===============================================================================
; Offset_0x02AEE8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02AF14(PC, D0), D1
                jsr     Offset_0x02AF14(PC, D1)
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x02AF0E
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x02AF0E:
                jmp     (DeleteObject)                         ; Offset_0x00D314
;------------------------------------------------------------------------------- 
Offset_0x02AF14:
                dc.w    Offset_0x02AF34-Offset_0x02AF14
                dc.w    Offset_0x02AF82-Offset_0x02AF14
                dc.w    Offset_0x02AFBE-Offset_0x02AF14
                dc.w    Offset_0x02B026-Offset_0x02AF14
                dc.w    Offset_0x02B026-Offset_0x02AF14
                dc.w    Offset_0x02B026-Offset_0x02AF14
                dc.w    Offset_0x02B0BE-Offset_0x02AF14
                dc.w    Offset_0x02B10E-Offset_0x02AF14       
;-------------------------------------------------------------------------------  
Offset_0x02AF24:
                dc.b    $02, $20, $04, $00
                dc.b    $04, $0C, $05, $01
                dc.b    $06, $10, $04, $03
                dc.b    $08, $10, $03, $05       
;-------------------------------------------------------------------------------
Offset_0x02AF34:
                move.l  #Egg_Prison_Mappings, Obj_Map(A0) ; Offset_0x02B138, $0004
                move.w  #$049D, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_31_To_ModifySpriteAttr_2P          ; Offset_0x02B1E4
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsl.w   #$02, D0
                lea     Offset_0x02AF24(PC, D0), A1
                move.b  (A1)+, Obj_Routine(A0)                           ; $0024
                move.b  (A1)+, Obj_Width(A0)                             ; $0019
                move.b  (A1)+, Obj_Priority(A0)                          ; $0018
                move.b  (A1)+, Obj_Map_Id(A0)                            ; $001A
                cmpi.w  #$0008, D0
                bne.s   Offset_0x02AF80
                move.b  #$06, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Col_Prop(A0)                           ; $0021
Offset_0x02AF80:
                rts   
;-------------------------------------------------------------------------------
Offset_0x02AF82:
                cmpi.b  #$02, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
                beq.s   Offset_0x02AFA0
                move.w  #$002B, D1
                move.w  #$0018, D2
                move.w  #$0018, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                jmp     (SolidObject)                          ; Offset_0x00F344
Offset_0x02AFA0:
                tst.b   Obj_Routine_2(A0)                                ; $0025
                beq.s   Offset_0x02AFB6
                clr.b   Obj_Routine_2(A0)                                ; $0025
                bclr    #$03, ($FFFFB022).w
                bset    #$01, ($FFFFB022).w
Offset_0x02AFB6:
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                rts   
;-------------------------------------------------------------------------------
Offset_0x02AFBE:
                move.w  #$0017, D1
                move.w  #$0008, D2
                move.w  #$0008, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                jsr     (SolidObject)                          ; Offset_0x00F344
                lea     (Egg_Prison_Animate_Data), A1          ; Offset_0x02B130
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                move.w  Obj_Control_Var_04(A0), Obj_Y(A0)         ; $000C, $0030
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x02B024
                addq.w  #$08, Obj_Y(A0)                                  ; $000C
                move.b  #$0A, Obj_Routine(A0)                            ; $0024
                move.w  #$003C, Obj_Ani_Time(A0)                         ; $001E
                clr.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
                clr.b   (Boss_Flag).w                                ; $FFFFF7AA
                move.b  #$01, ($FFFFF7CC).w
                move.w  #$0800, ($FFFFF602).w
                clr.b   Obj_Routine_2(A0)                                ; $0025
                bclr    #$03, ($FFFFB022).w
                bset    #$01, ($FFFFB022).w
Offset_0x02B024:
                rts 
;-------------------------------------------------------------------------------
Offset_0x02B026:
                moveq   #$07, D0
                and.b   ($FFFFFE0F).w, D0
                bne.s   Offset_0x02B064
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne.s   Offset_0x02B064
                move.b  #$27, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                moveq   #$00, D1
                move.b  D0, D1
                lsr.b   #$02, D1
                subi.w  #$0020, D1
                add.w   D1, Obj_X(A1)                                    ; $0008
                lsr.w   #$08, D0
                lsr.b   #$03, D0
                add.w   D0, Obj_Y(A1)                                    ; $000C
Offset_0x02B064:
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                beq.s   Offset_0x02B06C
                rts
Offset_0x02B06C:
                move.b  #$02, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
                move.b  #$0C, Obj_Routine(A0)                            ; $0024
                move.b  #$06, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0096, Obj_Ani_Time(A0)                         ; $001E
                addi.w  #$0020, Obj_Y(A0)                                ; $000C
                moveq   #$07, D6
                move.w  #$009A, D5
                moveq   #-$1C, D4
Offset_0x02B092:
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne.s   Offset_0x02B0BC
                move.b  #$28, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                add.w   D4, Obj_X(A1)                                    ; $0008
                addq.w  #$07, D4
                move.w  D5, Obj_Control_Var_0A(A1)                       ; $0036
                subq.w  #$08, D5
                dbra    D6, Offset_0x02B092
Offset_0x02B0BC:
                rts  
;-------------------------------------------------------------------------------
Offset_0x02B0BE:
                moveq   #$07, D0
                and.b   ($FFFFFE0F).w, D0
                bne.s   Offset_0x02B0FC
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne.s   Offset_0x02B0FC
                move.b  #$28, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$001F, D0
                subq.w  #$06, D0
                tst.w   D1
                bpl.s   Offset_0x02B0F2
                neg.w   D0
Offset_0x02B0F2:
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.w  #$000C, Obj_Control_Var_0A(A1)                   ; $0036
Offset_0x02B0FC:
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bne.s   Offset_0x02B10C
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $001E
Offset_0x02B10C:
                rts   
;-------------------------------------------------------------------------------
Offset_0x02B10E:
                moveq   #$3E, D0
                moveq   #$28, D1
                moveq   #$40, D2
                lea     (Player_Two).w, A1                           ; $FFFFB040
Offset_0x02B118:
                cmp.b   (A1), D1
                beq.s   Offset_0x02B12E
                adda.w  D2, A1
                dbra    D0, Offset_0x02B118
                jsr     (Load_Level_Results)                   ; Offset_0x00F1F6
                jmp     (DeleteObject)                         ; Offset_0x00D314
Offset_0x02B12E:
                rts   
;------------------------------------------------------------------------------- 
Egg_Prison_Animate_Data:                                       ; Offset_0x02B130
                dc.w    Offset_0x02B134-Egg_Prison_Animate_Data
                dc.w    Offset_0x02B134-Egg_Prison_Animate_Data
Offset_0x02B134:
                dc.b    $02, $01, $03, $FF        
;-------------------------------------------------------------------------------
Egg_Prison_Mappings:                                           ; Offset_0x02B138
                dc.w    Offset_0x02B146-Egg_Prison_Mappings
                dc.w    Offset_0x02B180-Egg_Prison_Mappings
                dc.w    Offset_0x02B18A-Egg_Prison_Mappings
                dc.w    Offset_0x02B1BC-Egg_Prison_Mappings
                dc.w    Offset_0x02B1C6-Egg_Prison_Mappings
                dc.w    Offset_0x02B1D8-Egg_Prison_Mappings
                dc.w    Offset_0x02B1E2-Egg_Prison_Mappings
Offset_0x02B146:
                dc.w    $0007
                dc.l    $E00C2000, $2000FFF0
                dc.l    $E80D2004, $2002FFE0
                dc.l    $E80D200C, $20060000
                dc.l    $F80E2014, $200AFFE0
                dc.l    $F80E2020, $20100000
                dc.l    $100D202C, $2016FFE0
                dc.l    $100D2034, $201A0000
Offset_0x02B180:
                dc.w    $0001
                dc.l    $F809003C, $001EFFF4
Offset_0x02B18A:
                dc.w    $0006
                dc.l    $00082042, $2021FFE0
                dc.l    $080C2045, $2022FFE0
                dc.l    $00042049, $20240010
                dc.l    $080C204B, $20250000
                dc.l    $100D202C, $2016FFE0
                dc.l    $100D2034, $201A0000
Offset_0x02B1BC:
                dc.w    $0001
                dc.l    $F809004F, $0027FFF4
Offset_0x02B1C6:
                dc.w    $0002
                dc.l    $E80E2055, $202AFFF0
                dc.l    $000E2061, $2030FFF0
Offset_0x02B1D8:
                dc.w    $0001
                dc.l    $F007206D, $2036FFF8
Offset_0x02B1E2:
                dc.w    $0000 
;===============================================================================
; Objeto 0x3E - Container de animais nas fases que contém chefe
; <<<-
;===============================================================================