;===============================================================================
; Objeto 0x2F - Obstáculo quebravél no chão na Hill Top
; ->>> 
;===============================================================================
; Offset_0x01813C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01814A(PC, D0), D1
                jmp     Offset_0x01814A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01814A:
                dc.w    Offset_0x01815A-Offset_0x01814A
                dc.w    Offset_0x018198-Offset_0x01814A
                dc.w    Offset_0x01830C-Offset_0x01814A  
;-------------------------------------------------------------------------------
Offset_0x018150:
                dc.b    $24, $00, $20, $02, $18, $04, $10, $06
                dc.b    $08, $08  
;-------------------------------------------------------------------------------  
Offset_0x01815A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Breakable_Floor_Mappings, Obj_Map(A0) ; Offset_0x01852A, $0004
                move.w  #$C000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_06_To_ModifySpriteAttr_2P          ; Offset_0x0186F4
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$001E, D0
                lea     Offset_0x018150(PC, D0), A2
                move.b  (A2)+, Obj_Height_2(A0)                          ; $0016
                move.b  (A2)+, Obj_Map_Id(A0)                            ; $001A  
;-------------------------------------------------------------------------------
Offset_0x018198:
                move.w  ($FFFFF7D0).w, Obj_Control_Var_0C(A0)            ; $0038
                move.b  ($FFFFB01C).w, Obj_Control_Var_06(A0)            ; $0032
                move.b  ($FFFFB05C).w, Obj_Control_Var_07(A0)            ; $0033
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_00_To_SolidObject                  ; Offset_0x018700
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x0181D4
Offset_0x0181D0:
                bra     Jmp_06_To_MarkObjGone                  ; Offset_0x0186EE
Offset_0x0181D4:
                cmpi.b  #$18, D0
                bne.s   Offset_0x018238
                cmpi.b  #$02, Obj_Control_Var_06(A0)                     ; $0032
                bne.s   Offset_0x0181F0
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bmi.s   Offset_0x018220
                cmpi.b  #$0E, ($FFFFB03E).w
                beq.s   Offset_0x018220
Offset_0x0181F0:
                move.b  #$0C, ($FFFFB03E).w
                move.b  #$0D, ($FFFFB03F).w
                cmpi.b  #$02, Obj_Control_Var_07(A0)                     ; $0033
                bne.s   Offset_0x018212
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bmi.s   Offset_0x018220
                cmpi.b  #$0E, ($FFFFB07E).w
                beq.s   Offset_0x018220
Offset_0x018212:
                move.b  #$0C, ($FFFFB07E).w
                move.b  #$0D, ($FFFFB07F).w
                bra.s   Offset_0x0181D0
Offset_0x018220:
                lea     (Player_One).w, A1                           ; $FFFFB000
                move.b  Obj_Control_Var_06(A0), D0                       ; $0032
                bsr.s   Offset_0x01826E
                lea     (Player_Two).w, A1                           ; $FFFFB040
                move.b  Obj_Control_Var_07(A0), D0                       ; $0033
                bsr.s   Offset_0x01826E
                bra     Offset_0x0182D4
Offset_0x018238:
                move.b  D0, D1
                andi.b  #$08, D1
                beq.s   Offset_0x0182A0
                cmpi.b  #$02, Obj_Control_Var_06(A0)                     ; $0032
                bne.s   Offset_0x018256
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bmi.s   Offset_0x018266
                cmpi.b  #$0E, ($FFFFB03E).w
                beq.s   Offset_0x018266
Offset_0x018256:
                move.b  #$0C, ($FFFFB03E).w
                move.b  #$0D, ($FFFFB03F).w
                bra     Offset_0x0181D0
Offset_0x018266:
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x018274
                bra.s   Offset_0x0182D4
Offset_0x01826E:
                cmpi.b  #$02, D0
                bne.s   Offset_0x01828C
Offset_0x018274:
                bset    #$02, Obj_Status(A1)                             ; $0022
                move.b  #$0E, Obj_Height_2(A1)                           ; $0016
                move.b  #$07, Obj_Width_2(A1)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
Offset_0x01828C:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                rts
Offset_0x0182A0:
                andi.b  #$10, D0
                beq     Offset_0x0181D0
                cmpi.b  #$02, Obj_Control_Var_07(A0)                     ; $0033
                bne.s   Offset_0x0182BE
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bmi.s   Offset_0x0182CE
                cmpi.b  #$0E, ($FFFFB07E).w
                beq.s   Offset_0x0182CE
Offset_0x0182BE:
                move.b  #$0C, ($FFFFB07E).w
                move.b  #$0D, ($FFFFB07F).w
                bra     Offset_0x0181D0
Offset_0x0182CE:
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr.s   Offset_0x018274
Offset_0x0182D4:
                move.w  Obj_Control_Var_0C(A0), ($FFFFF7D0).w            ; $0038
                andi.b  #$E7, Obj_Status(A0)                             ; $0022
                lea     (Offset_0x018322), A4
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                move.l  D0, D1
                add.w   D0, D0
                add.w   D0, D0
                lea     $00(A4, D0), A4
                neg.w   D1
                addi.w  #$0009, D1
                move.w  #$0018, D2
                bsr     Jmp_00_To_Smash_Object                 ; Offset_0x0186FA
                bsr     Offset_0x0184D8   
;-------------------------------------------------------------------------------
Offset_0x01830C:
                bsr     Jmp_04_To_SpeedToPos                   ; Offset_0x018706
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Jmp_06_To_DeleteObject                 ; Offset_0x0186E2
                bra     Jmp_04_To_DisplaySprite                ; Offset_0x0186DC        
;-------------------------------------------------------------------------------  
Offset_0x018322:
                dc.w    $FF00, $F800, $0100, $F800, $FF20, $F900, $00E0, $F900
                dc.w    $FF40, $FA00, $00C0, $FA00, $FF60, $FB00, $00A0, $FB00
                dc.w    $FF80, $FC00, $0080, $FC00
;===============================================================================
; Objeto 0x2F - Obstáculo quebravél no chão na Hill Top
; <<<- 
;===============================================================================