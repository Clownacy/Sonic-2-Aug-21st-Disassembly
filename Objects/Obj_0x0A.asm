;===============================================================================
; Objeto 0x0A - Objeto de controle do Sonic / Miles embaixo da água
; ->>> 
;===============================================================================   
; Offset_0x01254C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01255A(PC, D0), D1
                jmp     Offset_0x01255A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01255A:
                dc.w    Offset_0x01256C-Offset_0x01255A
                dc.w    Offset_0x0125C4-Offset_0x01255A
                dc.w    Offset_0x0125D0-Offset_0x01255A
                dc.w    Offset_0x012646-Offset_0x01255A
                dc.w    Offset_0x01265A-Offset_0x01255A
                dc.w    Offset_0x012832-Offset_0x01255A
                dc.w    Offset_0x012660-Offset_0x01255A
                dc.w    Offset_0x01263A-Offset_0x01255A
                dc.w    Offset_0x01265A-Offset_0x01255A    
;-------------------------------------------------------------------------------
Offset_0x01256C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Sonic_Underwater_Mappings, Obj_Map(A0) ; Offset_0x014CFC, $0004
                tst.b   Obj_Control_Var_13(A0)                           ; $003F
                beq.s   Offset_0x012586
                move.l  #Miles_Underwater_Mappings, Obj_Map(A0) ; Offset_0x014D1E, $0004
Offset_0x012586:
                move.w  #$855B, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$84, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x0125B4
                addq.b  #$08, Obj_Routine(A0)                            ; $0024
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_07(A0)                       ; $0033
                bra     Offset_0x012832
Offset_0x0125B4:
                move.b  D0, Obj_Ani_Number(A0)                           ; $001C
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  #$FF78, Obj_Speed_Y(A0)                          ; $0012  
;-------------------------------------------------------------------------------
Offset_0x0125C4:
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x012A5E
                jsr     (AnimateSprite)                        ; Offset_0x00D372  
;-------------------------------------------------------------------------------
Offset_0x0125D0:
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs.s   Offset_0x0125F6
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                addq.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                cmpi.b  #$0D, Obj_Ani_Number(A0)                         ; $001C
                beq.s   Offset_0x012646
                bcs.s   Offset_0x012646
                move.b  #$0D, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x012646
Offset_0x0125F6:
                tst.b   ($FFFFF7C7).w
                beq.s   Offset_0x012600
                addq.w  #$04, Obj_Control_Var_04(A0)                     ; $0030
Offset_0x012600:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addq.b  #$01, Obj_Angle(A0)                              ; $0026
                andi.w  #$007F, D0
                lea     (Offset_0x0126EC), A1
                move.b  $00(A1, D0), D0
                ext.w   D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0008
                bsr.s   Offset_0x0126A0
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x012634
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x012634:
                jmp     (DeleteObject)                         ; Offset_0x00D314 
;-------------------------------------------------------------------------------
Offset_0x01263A:
                move.l  Obj_Control_Var_10(A0), A2                       ; $003C
                cmpi.b  #$0C, Obj_Subtype(A2)                            ; $0028
                bhi.s   Offset_0x01265A     
;-------------------------------------------------------------------------------
Offset_0x012646:
                bsr.s   Offset_0x0126A0
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x012A5E
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322    
;-------------------------------------------------------------------------------
Offset_0x01265A:
                jmp     (DeleteObject)                         ; Offset_0x00D314   
;-------------------------------------------------------------------------------
Offset_0x012660:
                move.l  Obj_Control_Var_10(A0), A2                       ; $003C
                cmpi.b  #$0C, Obj_Subtype(A2)                            ; $0028
                bhi.s   Offset_0x01269A
                subq.w  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bne.s   Offset_0x01267E
                move.b  #$0E, Obj_Routine(A0)                            ; $0024
                addq.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x012646
Offset_0x01267E:
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x012A5E
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                bsr     Load_Oxygen_Numbers_Dynamic_PLC        ; Offset_0x0127EC
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01269A
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01269A:
                jmp     (DeleteObject)                         ; Offset_0x00D314
Offset_0x0126A0:
                tst.w   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x0126EA
                subq.w  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bne.s   Offset_0x0126EA
                cmpi.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                bcc.s   Offset_0x0126EA
                move.w  #$000F, Obj_Control_Var_0C(A0)                   ; $0038
                clr.w   Obj_Speed_Y(A0)                                  ; $0012
                move.b  #$80, Obj_Flags(A0)                              ; $0001
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   ($FFFFEE00).w, D0
                addi.w  #$0080, D0
                move.w  D0, Obj_X(A0)                                    ; $0008
                move.w  Obj_Y(A0), D0                                    ; $000C
                sub.w   ($FFFFEE04).w, D0
                addi.w  #$0080, D0
                move.w  D0, Obj_Sub_Y(A0)                                ; $000A
                move.b  #$0C, Obj_Routine(A0)                            ; $0024
Offset_0x0126EA:
                rts   
;-------------------------------------------------------------------------------
Offset_0x0126EC:
                dc.b    $00, $00, $00, $00, $00, $00, $01, $01
                dc.b    $01, $01, $01, $02, $02, $02, $02, $02
                dc.b    $02, $02, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $02
                dc.b    $02, $02, $02, $02, $02, $02, $01, $01
                dc.b    $01, $01, $01, $00, $00, $00, $00, $00
                dc.b    $00, $FF, $FF, $FF, $FF, $FF, $FE, $FE
                dc.b    $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD
                dc.b    $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FD
                dc.b    $FD, $FD, $FD, $FD, $FD, $FD, $FE, $FE
                dc.b    $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF
                dc.b    $00, $00, $00, $00, $00, $00, $01, $01
                dc.b    $01, $01, $01, $02, $02, $02, $02, $02
                dc.b    $02, $02, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $02
                dc.b    $02, $02, $02, $02, $02, $02, $01, $01
                dc.b    $01, $01, $01, $00, $00, $00, $00, $00
                dc.b    $00, $FF, $FF, $FF, $FF, $FF, $FE, $FE
                dc.b    $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD
                dc.b    $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FD
                dc.b    $FD, $FD, $FD, $FD, $FD, $FD, $FE, $FE
                dc.b    $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF    
;-------------------------------------------------------------------------------
Load_Oxygen_Numbers_Dynamic_PLC:                               ; Offset_0x0127EC
                moveq   #$00, D1
                move.b  Obj_Map_Id(A0), D1                               ; $001A
                cmpi.b  #$08, D1
                bcs.s   Offset_0x012830
                cmpi.b  #$0E, D1
                bcc.s   Offset_0x012830
                cmp.b   Obj_Control_Var_02(A0), D1                       ; $002E
                beq.s   Offset_0x012830
                move.b  D1, Obj_Control_Var_02(A0)                       ; $002E
                subq.w  #$08, D1
                move.w  D1, D0
                add.w   D1, D1
                add.w   D0, D1
                lsl.w   #$06, D1
                addi.l  #Art_Oxygen_Numbers, D1                ; Offset_0x07ED04
                move.w  #$9380, D2
                tst.b   Obj_Control_Var_13(A0)                           ; $003F
                beq.s   Offset_0x012826
                move.w  #$9180, D2
Offset_0x012826:
                move.w  #$0060, D3
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
Offset_0x012830:
                rts     
;-------------------------------------------------------------------------------
Offset_0x012832:
                move.l  Obj_Control_Var_10(A0), A2                       ; $003C
                tst.w   Obj_Control_Var_00(A0)                           ; $002C
                bne     Offset_0x012922
                cmpi.b  #$06, Obj_Routine(A2)                            ; $0024
                bcc     Offset_0x012A2E
                btst    #$06, Obj_Status(A2)                             ; $0022
                beq     Offset_0x012A2E
                subq.w  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bpl     Offset_0x012946
                move.w  #$003B, Obj_Control_Var_0C(A0)                   ; $0038
                move.w  #$0001, Obj_Control_Var_0A(A0)                   ; $0036
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$0001, D0
                move.b  D0, Obj_Control_Var_08(A0)                       ; $0034
                moveq   #$00, D0
                move.b  Obj_Subtype(A2), D0                              ; $0028
                cmpi.w  #$0019, D0
                beq.s   Offset_0x0128B2
                cmpi.w  #$0014, D0
                beq.s   Offset_0x0128B2
                cmpi.w  #$000F, D0
                beq.s   Offset_0x0128B2
                cmpi.w  #$000C, D0
                bhi.s   Offset_0x0128BC
                bne.s   Offset_0x01289E
                move.w  #$008A, D0
                jsr     (Play_Music)                           ; Offset_0x00150C
Offset_0x01289E:
                subq.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x0128BC
                move.b  Obj_Control_Var_07(A0), Obj_Control_Var_06(A0); $0032, $0033
                bset    #$07, Obj_Control_Var_0A(A0)                     ; $0036
                bra.s   Offset_0x0128BC
Offset_0x0128B2:
                move.w  #$00C2, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x0128BC:
                subq.b  #$01, Obj_Subtype(A2)                            ; $0028
                bcc     Offset_0x012944
                move.b  #$81, Obj_Timer(A2)                              ; $002A
                move.w  #$00B2, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                move.b  #$0A, Obj_Control_Var_08(A0)                     ; $0034
                move.w  #$0001, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$0078, Obj_Control_Var_00(A0)                   ; $002C
                move.l  A2, A1
                bsr     Resume_Music                           ; Offset_0x012A30
                move.l  A0, -(A7)
                move.l  A2, A0
                bsr     Sonic_ResetOnFloor                     ; Offset_0x010A46
                move.b  #$17, Obj_Ani_Number(A0)                         ; $001C
                bset    #$01, Obj_Status(A0)                             ; $0022
                bset    #$07, Obj_Art_VRAM(A0)                           ; $0002
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  #$0000, Obj_Inertia(A0)                          ; $0014
                move.b  #$01, (Level_Scroll_Flag).w                  ; $FFFFEEDC
                move.l  (A7)+, A0
                rts
Offset_0x012922:
                subq.w  #$01, Obj_Control_Var_00(A0)                     ; $002C
                bne.s   Offset_0x012930
                move.b  #$06, Obj_Routine(A2)                            ; $0024
                rts
Offset_0x012930:
                move.l  A0, -(A7)
                move.l  A2, A0
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                addi.w  #$0010, Obj_Speed_Y(A0)                          ; $0012
                move.l  (A7)+, A0
                bra.s   Offset_0x012946
Offset_0x012944:
                bra.s   Offset_0x012956
Offset_0x012946:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                beq     Offset_0x012A2E
                subq.w  #$01, Obj_Control_Var_0E(A0)                     ; $003A
                bpl     Offset_0x012A2E
Offset_0x012956:
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$000F, D0
                move.w  D0, Obj_Control_Var_0E(A0)                       ; $003A
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne     Offset_0x012A2E
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.w  Obj_X(A2), Obj_X(A1)                      ; $0008, $0008
                moveq   #$06, D0
                btst    #$00, Obj_Status(A2)                             ; $0022
                beq.s   Offset_0x01298C
                neg.w   D0
                move.b  #$40, Obj_Angle(A1)                              ; $0026
Offset_0x01298C:
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.w  Obj_Y(A2), Obj_Y(A1)                      ; $000C, $000C
                move.l  Obj_Control_Var_10(A0), Obj_Control_Var_10(A1); $003C, $003C
                move.b  #$06, Obj_Subtype(A1)                            ; $0028
                tst.w   Obj_Control_Var_00(A0)                           ; $002C
                beq     Offset_0x0129DE
                andi.w  #$0007, Obj_Control_Var_0E(A0)                   ; $003A
                addi.w  #$0000, Obj_Control_Var_0E(A0)                   ; $003A
                move.w  Obj_Y(A2), D0                                    ; $000C
                subi.w  #$000C, D0
                move.w  D0, Obj_Y(A1)                                    ; $000C
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                move.b  D0, Obj_Angle(A1)                                ; $0026
                move.w  ($FFFFFE04).w, D0
                andi.b  #$03, D0
                bne.s   Offset_0x012A24
                move.b  #$0E, Obj_Subtype(A1)                            ; $0028
                bra.s   Offset_0x012A24
Offset_0x0129DE:
                btst    #$07, Obj_Control_Var_0A(A0)                     ; $0036
                beq.s   Offset_0x012A24
                moveq   #$00, D2
                move.b  Obj_Subtype(A2), D2                              ; $0028
                lsr.w   #$01, D2
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$0003, D0
                bne.s   Offset_0x012A0C
                bset    #$06, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x012A24
                move.b  D2, Obj_Subtype(A1)                              ; $0028
                move.w  #$001C, Obj_Control_Var_0C(A1)                   ; $0038
Offset_0x012A0C:
                tst.b   Obj_Control_Var_08(A0)                           ; $0034
                bne.s   Offset_0x012A24
                bset    #$06, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x012A24
                move.b  D2, Obj_Subtype(A1)                              ; $0028
                move.w  #$001C, Obj_Control_Var_0C(A1)                   ; $0038
Offset_0x012A24:
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0034
                bpl.s   Offset_0x012A2E
                clr.w   Obj_Control_Var_0A(A0)                           ; $0036
Offset_0x012A2E:
                rts    
;-------------------------------------------------------------------------------
; Rotina para restaurar a música da fase
; ->>>                    
;-------------------------------------------------------------------------------                
Resume_Music:                                                  ; Offset_0x012A30
                cmpi.b  #$0C, Obj_Subtype(A1)                            ; $0028
                bhi.s   Reset_Water_Counter                    ; Offset_0x012A56
                move.w  #$0082, D0
                tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
                beq.s   Try_Resume_Boss                        ; Offset_0x012A46
                move.w  #$0087, D0
Try_Resume_Boss:                                               ; Offset_0x012A46
                tst.b   (Boss_Flag).w                                ; $FFFFF7AA
                beq.s   Resume_Play_Music                      ; Offset_0x012A50
                move.w  #$008C, D0
Resume_Play_Music:                                             ; Offset_0x012A50
                jsr     (Play_Music)                           ; Offset_0x00150C
Reset_Water_Counter:                                           ; Offset_0x012A56
                move.b  #$1E, Obj_Subtype(A1)                            ; $0028
                rts 
;-------------------------------------------------------------------------------
; Rotina para restaurar a música da fase
; <<<-                    
;-------------------------------------------------------------------------------
Bubbles_Animate_Data:                                          ; Offset_0x012A5E
                dc.w    Offset_0x012A7C-Bubbles_Animate_Data
                dc.w    Offset_0x012A85-Bubbles_Animate_Data
                dc.w    Offset_0x012A8E-Bubbles_Animate_Data
                dc.w    Offset_0x012A97-Bubbles_Animate_Data
                dc.w    Offset_0x012AA0-Bubbles_Animate_Data
                dc.w    Offset_0x012AA9-Bubbles_Animate_Data
                dc.w    Offset_0x012AB2-Bubbles_Animate_Data
                dc.w    Offset_0x012AB7-Bubbles_Animate_Data
                dc.w    Offset_0x012ABF-Bubbles_Animate_Data
                dc.w    Offset_0x012AC7-Bubbles_Animate_Data
                dc.w    Offset_0x012ACF-Bubbles_Animate_Data
                dc.w    Offset_0x012AD7-Bubbles_Animate_Data
                dc.w    Offset_0x012ADF-Bubbles_Animate_Data
                dc.w    Offset_0x012AE7-Bubbles_Animate_Data
                dc.w    Offset_0x012AE9-Bubbles_Animate_Data
Offset_0x012A7C:
                dc.b    $05, $00, $01, $02, $03, $04, $08, $08
                dc.b    $FC
Offset_0x012A85:
                dc.b    $05, $00, $01, $02, $03, $04, $09, $09
                dc.b    $FC
Offset_0x012A8E:
                dc.b    $05, $00, $01, $02, $03, $04, $0A, $0A
                dc.b    $FC
Offset_0x012A97:
                dc.b    $05, $00, $01, $02, $03, $04, $0B, $0B
                dc.b    $FC
Offset_0x012AA0:
                dc.b    $05, $00, $01, $02, $03, $04, $0C, $0C
                dc.b    $FC
Offset_0x012AA9:
                dc.b    $05, $00, $01, $02, $03, $04, $0D, $0D
                dc.b    $FC
Offset_0x012AB2:
                dc.b    $0E, $00, $01, $02, $FC
Offset_0x012AB7:
                dc.b    $07, $10, $08, $10, $08, $10, $08, $FC
Offset_0x012ABF:
                dc.b    $07, $10, $09, $10, $09, $10, $09, $FC
Offset_0x012AC7:
                dc.b    $07, $10, $0A, $10, $0A, $10, $0A, $FC
Offset_0x012ACF:
                dc.b    $07, $10, $0B, $10, $0B, $10, $0B, $FC
Offset_0x012AD7:
                dc.b    $07, $10, $0C, $10, $0C, $10, $0C, $FC
Offset_0x012ADF:
                dc.b    $07, $10, $0D, $10, $0D, $10, $0D, $FC
Offset_0x012AE7:
                dc.b    $0E, $FC
Offset_0x012AE9:
                dc.b    $0E, $01, $02, $03, $04, $FC, $00                  
;===============================================================================
; Objeto 0x0A - Objeto de controle do Sonic / Miles embaixo da água
; <<<- 
;===============================================================================