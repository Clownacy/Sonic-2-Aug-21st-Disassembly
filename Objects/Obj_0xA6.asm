;===============================================================================
; Object 0xA6 - Inimigo Lander na Chemical Plant
; ->>>
;===============================================================================
; Offset_0x02A0A0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A0AE(PC, D0), D1
                jmp     Offset_0x02A0AE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A0AE:
                dc.w    Offset_0x02A0B4-Offset_0x02A0AE
                dc.w    Offset_0x02A0C6-Offset_0x02A0AE
                dc.w    Offset_0x02A118-Offset_0x02A0AE   
;-------------------------------------------------------------------------------
Offset_0x02A0B4:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FFC0, Obj_Speed_Y(A0)                          ; $0012
                move.w  #$0080, Obj_Timer(A0)                            ; $002A
                rts  
;-------------------------------------------------------------------------------
Offset_0x02A0C6:
                tst.b   Obj_Player_Status(A0)                            ; $002B
                beq.s   Offset_0x02A0D4
                subq.b  #$01, Obj_Player_Status(A0)                      ; $002B
                bra     Offset_0x02A0E2
Offset_0x02A0D4:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0060, D2
                cmpi.w  #$00C0, D2
                bcs.s   Offset_0x02A104
Offset_0x02A0E2:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bne.s   Offset_0x02A0F2
                move.w  #$0080, Obj_Timer(A0)                            ; $002A
                neg.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x02A0F2:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Vertical_Spiny_Animate_Data), A1      ; Offset_0x02A1D8
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A104:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$28, Obj_Player_Status(A0)                      ; $002B
                move.b  #$05, Obj_Map_Id(A0)                             ; $001A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0    
;-------------------------------------------------------------------------------
Offset_0x02A118:
                subq.b  #$01, Obj_Player_Status(A0)                      ; $002B
                bmi.s   Offset_0x02A12E
                cmpi.b  #$14, Obj_Player_Status(A0)                      ; $002B
                bne.s   Offset_0x02A12A
                bsr     Load_Spiny_Vertical_Shot_Obj           ; Offset_0x02A188
Offset_0x02A12A:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A12E:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$40, Obj_Player_Status(A0)                      ; $002B
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------                
Load_Spiny_Horizontal_Shot_Obj:                                ; Offset_0x02A13C
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x02A186
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Map_Id(A1)                             ; $001A
                move.b  #$34, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$FD00, Obj_Speed_Y(A1)                          ; $0012
                move.w  #$0100, D1
                lea     (Player_One).w, A2                           ; $FFFFB000
                move.w  Obj_X(A0), D0                                    ; $0008
                cmp.w   Obj_X(A2), D0                                    ; $0008
                bcs.s   Offset_0x02A17A
                neg.w   D1
Offset_0x02A17A:
                move.w  D1, Obj_Speed(A1)                                ; $0010
                lea     Spiny_Weapon(PC), A2                   ; Offset_0x028D3E
                move.l  A2, Obj_Timer(A1)                                ; $002A
Offset_0x02A186:
                rts
;-------------------------------------------------------------------------------                
Load_Spiny_Vertical_Shot_Obj:                                  ; Offset_0x02A188
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x02A1C6
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Map_Id(A1)                             ; $001A
                move.b  #$34, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$0300, D1
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x02A1BA
                neg.w   D1
Offset_0x02A1BA:
                move.w  D1, Obj_Speed(A1)                                ; $0010
                lea     Spiny_Weapon(PC), A2                   ; Offset_0x028D3E
                move.l  A2, Obj_Timer(A1)                                ; $002A
Offset_0x02A1C6:
                rts     
;-------------------------------------------------------------------------------
Obj_0xA5_Ptr:                                                  ; Offset_0x02A1C8
                dc.l    Spiny_Mappings                         ; Offset_0x02A1E4
                dc.w    $252D
                dc.b    $04, $04, $08, $0B       
;-------------------------------------------------------------------------------  
Horizontal_Spiny_Animate_Data:                                 ; Offset_0x02A1D2
                dc.w    Offset_0x02A1D4-Horizontal_Spiny_Animate_Data
Offset_0x02A1D4:
                dc.b    $09, $00, $01, $FF    
;-------------------------------------------------------------------------------
Vertical_Spiny_Animate_Data:                                   ; Offset_0x02A1D8
                dc.w    Offset_0x02A1DA-Vertical_Spiny_Animate_Data
Offset_0x02A1DA:
                dc.b    $09, $03, $04, $FF      
;------------------------------------------------------------------------------- 
Spiny_Weapon_Animate_Data:                                     ; Offset_0x02A1DE
                dc.w    Offset_0x02A1E0-Spiny_Weapon_Animate_Data
Offset_0x02A1E0:
                dc.b    $03, $06, $07, $FF                  
;-------------------------------------------------------------------------------
Spiny_Mappings:                                                ; Offset_0x02A1E4
                dc.w    Offset_0x02A1F4-Spiny_Mappings
                dc.w    Offset_0x02A216-Spiny_Mappings
                dc.w    Offset_0x02A238-Spiny_Mappings
                dc.w    Offset_0x02A25A-Spiny_Mappings
                dc.w    Offset_0x02A27C-Spiny_Mappings
                dc.w    Offset_0x02A29E-Spiny_Mappings
                dc.w    Offset_0x02A2C0-Spiny_Mappings
                dc.w    Offset_0x02A2CA-Spiny_Mappings
Offset_0x02A1F4:
                dc.w    $0004
                dc.l    $F4000000, $0000FFF8
                dc.l    $FC090001, $0000FFE8
                dc.l    $F4000800, $08000000
                dc.l    $FC090801, $08000000
Offset_0x02A216:
                dc.w    $0004
                dc.l    $F4000000, $0000FFF8
                dc.l    $FC090007, $0003FFE8
                dc.l    $F4000800, $08000000
                dc.l    $FC090807, $08030000
Offset_0x02A238:
                dc.w    $0004
                dc.l    $F404000D, $0006FFF0
                dc.l    $FC090001, $0000FFE8
                dc.l    $F404080D, $08060000
                dc.l    $FC090801, $08000000
Offset_0x02A25A:
                dc.w    $0004
                dc.l    $E806000F, $0007FFF4
                dc.l    $F8000015, $000A0004
                dc.l    $0006100F, $1007FFF4
                dc.l    $00001015, $100A0004
Offset_0x02A27C:
                dc.w    $0004
                dc.l    $E8060016, $000BFFF4
                dc.l    $F8000015, $000A0004
                dc.l    $00061016, $100BFFF4
                dc.l    $00001015, $100A0004
Offset_0x02A29E:
                dc.w    $0004
                dc.l    $E806000F, $0007FFF4
                dc.l    $F001001C, $000E0004
                dc.l    $0006100F, $1007FFF4
                dc.l    $0001101C, $100E0004
Offset_0x02A2C0:
                dc.w    $0001
                dc.l    $FC00001E, $000FFFFC
Offset_0x02A2CA:
                dc.w    $0001
                dc.l    $FC00001F, $000FFFFC 
;===============================================================================
; Object 0xA6 - Inimigo Lander na Chemical Plant
; <<<-
;===============================================================================