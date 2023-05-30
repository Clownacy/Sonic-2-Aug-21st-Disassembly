;===============================================================================
; Objeto 0xA3 - Inimigo vagalume na Dust Hill
; ->>>
;===============================================================================
; Offset_0x029C34:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x029C42(PC, D0), D1
                jmp     Offset_0x029C42(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x029C42:
                dc.w    Offset_0x029C50-Offset_0x029C42
                dc.w    Offset_0x029C5C-Offset_0x029C42
                dc.w    Offset_0x029C8A-Offset_0x029C42
                dc.w    Offset_0x029D28-Offset_0x029C42
                dc.w    Offset_0x029D36-Offset_0x029C42
                dc.w    Offset_0x029D52-Offset_0x029C42
                dc.w    Offset_0x029D60-Offset_0x029C42    
;-------------------------------------------------------------------------------  
Offset_0x029C50:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$0040, Obj_Timer(A0)                            ; $002A
                rts     
;-------------------------------------------------------------------------------
Offset_0x029C5C:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x029C66
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029C66:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$FF00, Obj_Speed(A0)                            ; $0010
                move.w  #$0040, Obj_Speed_Y(A0)                          ; $0012
                move.w  #$0002, Obj_Control_Var_02(A0)                   ; $002E
                clr.w   Obj_Timer(A0)                                    ; $002A
                move.w  #$0080, Obj_Control_Var_04(A0)                   ; $0030
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x029C8A:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bmi.s   Offset_0x029CF2
                move.w  Obj_Timer(A0), D0                                ; $002A
                bmi     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                bclr    #$00, Obj_Status(A0)                             ; $0022
                tst.w   Obj_Speed(A0)                                    ; $0010
                bmi.s   Offset_0x029CB6
                bset    #$00, Obj_Flags(A0)                              ; $0001
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x029CB6:
                addq.w  #$01, D0
                move.w  D0, Obj_Timer(A0)                                ; $002A
                move.w  Obj_Control_Var_00(A0), D1                       ; $002C
                move.w  Offset_0x029D06(PC, D1), D2
                cmp.w   D2, D0
                bcs.s   Offset_0x029CE2
                addq.w  #$02, D1
                move.w  D1, Obj_Control_Var_00(A0)                       ; $002C
                lea     Offset_0x029D16(PC, D1), A1
                tst.b   (A1)+
                beq.s   Offset_0x029CDA
                neg.w   Obj_Control_Var_02(A0)                           ; $002E
Offset_0x029CDA:
                tst.b   (A1)+
                beq.s   Offset_0x029CE2
                neg.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x029CE2:
                move.w  Obj_Control_Var_02(A0), D0                       ; $002E
                add.w   D0, Obj_Speed(A0)                                ; $0010
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029CF2:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0080, Obj_Control_Var_04(A0)                   ; $0030
                ori.b   #$80, Obj_Col_Flags(A0)                          ; $0020
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x029D06:
                dc.w    $0100, $01A0, $0208, $0285, $0300, $0340, $0390, $0440  
;-------------------------------------------------------------------------------    
Offset_0x029D16:
                dc.b    $F0, $00, $01, $01, $00, $01, $01, $01
                dc.b    $00, $01, $00, $01, $01, $00, $00, $01
                dc.b    $00, $01              
;-------------------------------------------------------------------------------
Offset_0x029D28:
                lea     (Flasher_Animate_Data), A1             ; Offset_0x029D80
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x029D36:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bmi.s   Offset_0x029D4A
                lea     (Flasher_Animate_Data_01), A1          ; Offset_0x029DA4
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029D4A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0      
;-------------------------------------------------------------------------------
Offset_0x029D52:
                lea     (Flasher_Animate_Data_02), A1          ; Offset_0x029DAA
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x029D60:
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.w  #$0080, Obj_Control_Var_04(A0)                   ; $0030
                andi.b  #$7F, Obj_Col_Flags(A0)                          ; $0020
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;------------------------------------------------------------------------------- 
Offset_0x029D76:
                dc.l    Flasher_Mappings                       ; Offset_0x029DB4
                dc.w    $83A8
                dc.b    $04, $04, $10, $06      
;-------------------------------------------------------------------------------
Flasher_Animate_Data:                                          ; Offset_0x029D80
                dc.w    Offset_0x029D82-Flasher_Animate_Data
Offset_0x029D82:
                dc.b    $01, $00, $01, $00, $00, $00, $00, $00
                dc.b    $01, $00, $00, $00, $01, $00, $00, $01
                dc.b    $00, $01, $00, $01, $00, $01, $00, $01
                dc.b    $00, $01, $00, $01, $00, $02, $03, $04
                dc.b    $05, $FC     
;-------------------------------------------------------------------------------
Flasher_Animate_Data_01:                                       ; Offset_0x029DA4
                dc.w    Offset_0x029DA6-Flasher_Animate_Data_01
Offset_0x029DA6:
                dc.b    $01, $04, $05, $FF              
;-------------------------------------------------------------------------------
Flasher_Animate_Data_02:                                       ; Offset_0x029DAA
                dc.w    Offset_0x029DAC-Flasher_Animate_Data_02
Offset_0x029DAC:
                dc.b    $03, $05, $04, $03, $02, $01, $00, $FC   
;-------------------------------------------------------------------------------
Flasher_Mappings:                                              ; Offset_0x029DB4
                dc.w    Offset_0x029DC0-Flasher_Mappings
                dc.w    Offset_0x029DCA-Flasher_Mappings
                dc.w    Offset_0x029DDC-Flasher_Mappings
                dc.w    Offset_0x029DFE-Flasher_Mappings
                dc.w    Offset_0x029E30-Flasher_Mappings
                dc.w    Offset_0x029E62-Flasher_Mappings
Offset_0x029DC0:
                dc.w    $0001
                dc.l    $F8090000, $0000FFF0
Offset_0x029DCA:
                dc.w    $0002
                dc.l    $F8052006, $2003FFF8
                dc.l    $F8090000, $0000FFF0
Offset_0x029DDC:
                dc.w    $0004
                dc.l    $F801600A, $6005FFF8
                dc.l    $F801680A, $68050000
                dc.l    $F8052006, $2003FFF8
                dc.l    $F8090000, $0000FFF0
Offset_0x029DFE:
                dc.w    $0006
                dc.l    $F005600C, $6006FFF0
                dc.l    $F005680C, $68060000
                dc.l    $0005700C, $7006FFF0
                dc.l    $0005780C, $78060000
                dc.l    $F8052006, $2003FFF8
                dc.l    $F8090000, $0000FFF0
Offset_0x029E30:
                dc.w    $0006
                dc.l    $F0056010, $6008FFF0
                dc.l    $F0056810, $68080000
                dc.l    $00057010, $7008FFF0
                dc.l    $00057810, $78080000
                dc.l    $F8052006, $2003FFF8
                dc.l    $F8090000, $0000FFF0
Offset_0x029E62:
                dc.w    $0006
                dc.l    $F0056014, $600AFFF0
                dc.l    $F0056814, $680A0000
                dc.l    $00057014, $700AFFF0
                dc.l    $00057814, $780A0000
                dc.l    $F8052006, $2003FFF8
                dc.l    $F8090000, $0000FFF0
;===============================================================================
; Objeto 0xA3 - Inimigo vagalume na Dust Hill
; <<<-
;===============================================================================