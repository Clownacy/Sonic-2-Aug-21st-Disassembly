;===============================================================================
; Objeto 0x24 - Bolhas de oxigênio na Neo Green Hill
; ->>>
;===============================================================================
; Offset_0x0149CC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0149DA(PC, D0), D1
                jmp     Offset_0x0149DA(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x0149DA:
                dc.w    Offset_0x0149E6-Offset_0x0149DA
                dc.w    Offset_0x014A48-Offset_0x0149DA
                dc.w    Offset_0x014A62-Offset_0x0149DA
                dc.w    Offset_0x014AC2-Offset_0x0149DA
                dc.w    Offset_0x014AE0-Offset_0x0149DA
                dc.w    Offset_0x014AE4-Offset_0x0149DA   
;-------------------------------------------------------------------------------
Offset_0x0149E6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Sonic_Underwater_Mappings, Obj_Map(A0) ; Offset_0x014CFC, $0004
                move.w  #$855B, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$84, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x014A2E
                addq.b  #$08, Obj_Routine(A0)                            ; $0024
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_06(A0)                       ; $0032
                move.b  D0, Obj_Control_Var_07(A0)                       ; $0033
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                bra     Offset_0x014AE4
Offset_0x014A2E:
                move.b  D0, Obj_Ani_Number(A0)                           ; $001C
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  #$FF78, Obj_Speed_Y(A0)                          ; $0012
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                move.b  D0, Obj_Angle(A0)                                ; $0026 
;------------------------------------------------------------------------------- 
Offset_0x014A48:
                lea     (Oxygen_Bubbles_Animate_Data), A1      ; Offset_0x014CD2
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                cmpi.b  #$06, Obj_Map_Id(A0)                             ; $001A
                bne.s   Offset_0x014A62
                move.b  #$01, Obj_Control_Var_02(A0)                     ; $002E 
;------------------------------------------------------------------------------- 
Offset_0x014A62:
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs.s   Offset_0x014A7A
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                addq.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                bra     Offset_0x014AC2
Offset_0x014A7A:
                move.b  Obj_Angle(A0), D0                                ; $0026
                addq.b  #$01, Obj_Angle(A0)                              ; $0026
                andi.w  #$007F, D0
                lea     (Offset_0x0126EC), A1
                move.b  $00(A1, D0), D0
                ext.w   D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0008
                tst.b   Obj_Control_Var_02(A0)                           ; $002E
                beq.s   Offset_0x014AAC
                bsr     Offset_0x014C26
                cmpi.b  #$06, Obj_Routine(A0)                            ; $0024
                beq.s   Offset_0x014AC2
Offset_0x014AAC:
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x014ABC
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x014ABC:
                jmp     (DeleteObject)                         ; Offset_0x00D314   
;-------------------------------------------------------------------------------
Offset_0x014AC2:
                lea     (Oxygen_Bubbles_Animate_Data), A1      ; Offset_0x014CD2
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x014ADA
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x014ADA:
                jmp     (DeleteObject)                         ; Offset_0x00D314  
;-------------------------------------------------------------------------------
Offset_0x014AE0:
                bra     DeleteObject                           ; Offset_0x00D314  
;-------------------------------------------------------------------------------
Offset_0x014AE4:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                bne.s   Offset_0x014B46
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc     Offset_0x014BF2
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Offset_0x014BF2
                subq.w  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bpl     Offset_0x014BE6
                move.w  #$0001, Obj_Control_Var_0A(A0)                   ; $0036
Offset_0x014B0C:
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                move.w  D0, D1
                andi.w  #$0007, D0
                cmpi.w  #$0006, D0
                bcc.s   Offset_0x014B0C
                move.b  D0, Obj_Control_Var_08(A0)                       ; $0034
                andi.w  #$000C, D1
                lea     (Offset_0x014C14), A1
                adda.w  D1, A1
                move.l  A1, Obj_Control_Var_10(A0)                       ; $003C
                subq.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x014B44
                move.b  Obj_Control_Var_07(A0), Obj_Control_Var_06(A0); $0032, $0033
                bset    #$07, Obj_Control_Var_0A(A0)                     ; $0036
Offset_0x014B44:
                bra.s   Offset_0x014B4E
Offset_0x014B46:
                subq.w  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bpl     Offset_0x014BE6
Offset_0x014B4E:
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$001F, D0
                move.w  D0, Obj_Control_Var_0C(A0)                       ; $0038
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne.s   Offset_0x014BCA
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$000F, D0
                subq.w  #$08, D0
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                move.l  Obj_Control_Var_10(A0), A2                       ; $003C
                move.b  $00(A2, D0), Obj_Subtype(A1)                     ; $0028
                btst    #$07, Obj_Control_Var_0A(A0)                     ; $0036
                beq.s   Offset_0x014BCA
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$0003, D0
                bne.s   Offset_0x014BB6
                bset    #$06, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x014BCA
                move.b  #$02, Obj_Subtype(A1)                            ; $0028
Offset_0x014BB6:
                tst.b   Obj_Control_Var_08(A0)                           ; $0034
                bne.s   Offset_0x014BCA
                bset    #$06, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x014BCA
                move.b  #$02, Obj_Subtype(A1)                            ; $0028
Offset_0x014BCA:
                subq.b  #$01, Obj_Control_Var_08(A0)                     ; $0034
                bpl.s   Offset_0x014BE6
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.w  #$007F, D0
                addi.w  #$0080, D0
                add.w   D0, Obj_Control_Var_0C(A0)                       ; $0038
                clr.w   Obj_Control_Var_0A(A0)                           ; $0036
Offset_0x014BE6:
                lea     (Oxygen_Bubbles_Animate_Data), A1      ; Offset_0x014CD2
                jsr     (AnimateSprite)                        ; Offset_0x00D372
Offset_0x014BF2:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x00D314
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs     DisplaySprite                          ; Offset_0x00D322
                rts            
;------------------------------------------------------------------------------- 
Offset_0x014C14:
                dc.w    $0001, $0000, $0000, $0100, $0000, $0001, $0001, $0000
                dc.w    $0100                                                
;-------------------------------------------------------------------------------     
Offset_0x014C26:
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x014C30
                lea     (Player_Two).w, A1                           ; $FFFFB040
Offset_0x014C30:
                tst.b   Obj_Timer(A1)                                    ; $002A
                bmi     Offset_0x014CD0
                move.w  Obj_X(A1), D0                                    ; $0008
                move.w  Obj_X(A0), D1                                    ; $0008
                subi.w  #$0010, D1
                cmp.w   D0, D1
                bcc     Offset_0x014CD0
                addi.w  #$0020, D1
                cmp.w   D0, D1
                bcs.s   Offset_0x014CD0
                move.w  Obj_Y(A1), D0                                    ; $000C
                move.w  Obj_Y(A0), D1                                    ; $000C
                cmp.w   D0, D1
                bcc.s   Offset_0x014CD0
                addi.w  #$0010, D1
                cmp.w   D0, D1
                bcs.s   Offset_0x014CD0
                bsr     Resume_Music                           ; Offset_0x012A30
                move.w  #$00AD, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                clr.w   Obj_Speed(A1)                                    ; $0010
                clr.w   Obj_Speed_Y(A1)                                  ; $0012
                clr.w   Obj_Inertia(A1)                                  ; $0014
                move.b  #$15, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$0023, Obj_Control_Var_02(A1)                   ; $002E
                move.b  #$00, Obj_Control_Var_10(A1)                     ; $003C
                bclr    #$05, Obj_Status(A1)                             ; $0022
                bclr    #$04, Obj_Status(A1)                             ; $0022
                btst    #$02, Obj_Status(A1)                             ; $0022
                beq     Offset_0x014CBE
                bclr    #$02, Obj_Status(A1)                             ; $0022
                move.b  #$13, Obj_Height_2(A1)                           ; $0016
                move.b  #$09, Obj_Width_2(A1)                            ; $0017
                subq.w  #$05, Obj_Y(A1)                                  ; $000C
Offset_0x014CBE:
                cmpi.b  #$06, Obj_Routine(A0)                            ; $0024
                beq.s   Offset_0x014CD0
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                addq.b  #$03, Obj_Ani_Number(A0)                         ; $001C
Offset_0x014CD0:
                rts         
;------------------------------------------------------------------------------- 
Oxygen_Bubbles_Animate_Data:                                   ; Offset_0x014CD2
                dc.w    Offset_0x014CE0-Oxygen_Bubbles_Animate_Data
                dc.w    Offset_0x014CE5-Oxygen_Bubbles_Animate_Data
                dc.w    Offset_0x014CEB-Oxygen_Bubbles_Animate_Data
                dc.w    Offset_0x014CF2-Oxygen_Bubbles_Animate_Data
                dc.w    Offset_0x014CF2-Oxygen_Bubbles_Animate_Data
                dc.w    Offset_0x014CF4-Oxygen_Bubbles_Animate_Data
                dc.w    Offset_0x014CF8-Oxygen_Bubbles_Animate_Data
Offset_0x014CE0:
                dc.b    $0E, $00, $01, $02, $FC
Offset_0x014CE5:
                dc.b    $0E, $01, $02, $03, $04, $FC
Offset_0x014CEB:
                dc.b    $0E, $02, $03, $04, $05, $06, $FC
Offset_0x014CF2:
                dc.b    $04, $FC
Offset_0x014CF4:
                dc.b    $04, $06, $07, $FC
Offset_0x014CF8:
                dc.b    $0F, $0E, $0F, $FF
;===============================================================================
; Objeto 0x24 - Bolhas de oxigênio na Neo Green Hill
; <<<-
;===============================================================================