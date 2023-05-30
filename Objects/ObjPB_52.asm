;===============================================================================
; Objeto 0x52 - Piranha
; ->>> 
;===============================================================================
; Offset_0x01FEA0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01FEAE(PC, D0), D1
                jmp     Offset_0x01FEAE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01FEAE:
                dc.w    Offset_0x01FEB4-Offset_0x01FEAE
                dc.w    Offset_0x01FF2C-Offset_0x01FEAE
                dc.w    Offset_0x01FF9C-Offset_0x01FEAE      
;-------------------------------------------------------------------------------
Offset_0x01FEB4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Piranha_Mappings, Obj_Map(A0)  ; Offset_0x0200B2, $0004
                move.w  #$2530, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.b  D0, D1
                andi.w  #$00F0, D1
                add.w   D1, D1
                add.w   D1, D1
                move.w  D1, Obj_Control_Var_0E(A0)                       ; $003A
                move.w  D1, Obj_Control_Var_10(A0)                       ; $003C
                andi.w  #$000F, D0
                lsl.w   #$06, D0
                subq.w  #$01, D0
                move.w  D0, Obj_Control_Var_04(A0)                       ; $0030
                move.w  D0, Obj_Control_Var_06(A0)                       ; $0032
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                move.l  #$FFFB8000, Obj_Control_Var_0A(A0)               ; $0036
                move.w  Obj_Y(A0), Obj_Control_Var_08(A0)         ; $000C, $0034
                bset    #$06, Obj_Status(A0)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01FF2C
                neg.w   Obj_Speed(A0)                                    ; $0010
;-------------------------------------------------------------------------------
Offset_0x01FF2C:
                cmpi.w  #$FFFF, Obj_Control_Var_0E(A0)                   ; $003A
                beq.s   Offset_0x01FF38
                subq.w  #$01, Obj_Control_Var_0E(A0)                     ; $003A
Offset_0x01FF38:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bpl.s   Offset_0x01FF5A
                move.w  Obj_Control_Var_06(A0), Obj_Control_Var_04(A0) ; $0030, $0032
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
                move.w  Obj_Control_Var_10(A0), Obj_Control_Var_0E(A0) ; $003A, $003C
Offset_0x01FF5A:
                lea     (Piranha_Animate_Data), A1             ; Offset_0x02009A
                bsr     Jmp_07_To_AnimateSprite                ; Offset_0x0200EA
                bsr     Jmp_0E_To_SpeedToPos                   ; Offset_0x0200F0
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                bgt     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
                cmpi.w  #$FFFF, Obj_Control_Var_0E(A0)                   ; $003A
                beq     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
                move.l  #$FFFB8000, Obj_Control_Var_0A(A0)               ; $0036
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$FFFF, Obj_Control_Var_0E(A0)                   ; $003A
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0001, Obj_Control_Var_12(A0)                   ; $003E
                bra     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
;-------------------------------------------------------------------------------
Offset_0x01FF9C:
                move.w  #$0390, (Water_Level).w                      ; $FFFFF646
                lea     (Piranha_Animate_Data), A1             ; Offset_0x02009A
                bsr     Jmp_07_To_AnimateSprite                ; Offset_0x0200EA
                move.w  Obj_Control_Var_12(A0), D0                       ; $003E
                sub.w   D0, Obj_Control_Var_04(A0)                       ; $0030
                bsr     Offset_0x02004C
                tst.l   Obj_Control_Var_0A(A0)                           ; $0036
                bpl.s   Offset_0x01FFF4
                move.w  Obj_Y(A0), D0                                    ; $000C
                cmp.w   (Water_Level).w, D0                          ; $FFFFF646
                bgt     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
                move.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                bclr    #$06, Obj_Status(A0)                             ; $0022
                tst.b   Obj_Timer(A0)                                    ; $002A
                bne     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
                move.w  Obj_Speed(A0), D0                                ; $0010
                asl.w   #$01, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                addq.w  #$01, Obj_Control_Var_12(A0)                     ; $003E
                st      Obj_Timer(A0)                                    ; $002A
                bra     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
Offset_0x01FFF4:
                move.w  Obj_Y(A0), D0                                    ; $000C
                cmp.w   (Water_Level).w, D0                          ; $FFFFF646
                bgt.s   Offset_0x020008
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                bra     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
Offset_0x020008:
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                bset    #$06, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x020022
                move.l  Obj_Control_Var_0A(A0), D0                       ; $0036
                asr.l   #$01, D0
                move.l  D0, Obj_Control_Var_0A(A0)                       ; $0036
                nop
Offset_0x020022:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bgt     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                tst.b   Obj_Timer(A0)                                    ; $002A
                beq     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
                move.w  Obj_Speed(A0), D0                                ; $0010
                asr.w   #$01, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                sf      Obj_Timer(A0)                                    ; $002A
                bra     Jmp_1A_To_MarkObjGone                  ; Offset_0x0200E4
Offset_0x02004C:
                move.l  Obj_X(A0), D2                                    ; $0008
                move.l  Obj_Y(A0), D3                                    ; $000C
                move.w  Obj_Speed(A0), D0                                ; $0010
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                add.l   Obj_Control_Var_0A(A0), D3                       ; $0036
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x020088
                tst.l   Obj_Control_Var_0A(A0)                           ; $0036
                bpl.s   Offset_0x020080
                addi.l  #$00001000, Obj_Control_Var_0A(A0)               ; $0036
                addi.l  #$00001000, Obj_Control_Var_0A(A0)               ; $0036
Offset_0x020080:
                subi.l  #$00001000, Obj_Control_Var_0A(A0)               ; $0036
Offset_0x020088:
                addi.l  #$00001800, Obj_Control_Var_0A(A0)               ; $0036
                move.l  D2, Obj_X(A0)                                    ; $0008
                move.l  D3, Obj_Y(A0)                                    ; $000C
                rts           
;-------------------------------------------------------------------------------
Piranha_Animate_Data:                                          ; Offset_0x02009A
                dc.w    Offset_0x0200A2-Piranha_Animate_Data
                dc.w    Offset_0x0200A6-Piranha_Animate_Data
                dc.w    Offset_0x0200AA-Piranha_Animate_Data
                dc.w    Offset_0x0200AE-Piranha_Animate_Data
Offset_0x0200A2:
                dc.b    $0E, $00, $01, $FF
Offset_0x0200A6:
                dc.b    $03, $00, $01, $FF
Offset_0x0200AA:
                dc.b    $0E, $02, $03, $FF
Offset_0x0200AE:
                dc.b    $03, $02, $03, $FF    
;-------------------------------------------------------------------------------
Piranha_Mappings:                                              ; Offset_0x0200B2
                dc.w    Offset_0x0200BA-Piranha_Mappings
                dc.w    Offset_0x0200C4-Piranha_Mappings
                dc.w    Offset_0x0200CE-Piranha_Mappings
                dc.w    Offset_0x0200D8-Piranha_Mappings
Offset_0x0200BA:
                dc.w    $0001
                dc.l    $F00F0000, $0000FFF0
Offset_0x0200C4:
                dc.w    $0001
                dc.l    $F00F0010, $0008FFF0
Offset_0x0200CE:
                dc.w    $0001
                dc.l    $F00F0020, $0010FFF0
Offset_0x0200D8:
                dc.w    $0001
                dc.l    $F00F0030, $0018FFF0
;===============================================================================
; Objeto 0x52 - Piranha
; <<<- 
;===============================================================================