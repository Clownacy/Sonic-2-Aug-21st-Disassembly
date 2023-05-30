;===============================================================================
; Objeto 0x93 - Broca lançada pelo inimigo Spiker na Hill Top
; ->>>
;===============================================================================
; Offset_0x0285F8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x028606(PC, D0), D1
                jmp     Offset_0x028606(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x028606:
                dc.w    Offset_0x02860A-Offset_0x028606
                dc.w    Offset_0x028634-Offset_0x028606      
;-------------------------------------------------------------------------------
Offset_0x02860A:
                bsr     Object_Settings                        ; Offset_0x027EA4
                ori.b   #$80, Obj_Flags(A0)                              ; $0001
                move.w  Obj_Timer(A0), A1                                ; $002A
                move.b  Obj_Flags(A1), D0                                ; $0001
                andi.b  #$03, D0
                or.b    D0, Obj_Flags(A0)                                ; $0001
                moveq   #$02, D1
                btst    #$01, D0
                bne.s   Offset_0x02862E
                neg.w   D1
Offset_0x02862E:
                move.b  D1, Obj_Speed_Y(A0)                              ; $0012
                rts         
;-------------------------------------------------------------------------------
Offset_0x028634:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                bchg    #00, Obj_Flags(A0)                               ; $0001
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------
Spiker_Sub: ; Usado pelo objeto 0x92 - Spiker                  ; Offset_0x02864A
                tst.b   Obj_Player_Status(A0)                            ; $002B
                bne.s   Offset_0x02865E
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0020, D2
                cmpi.w  #$0040, D2
                bcs.s   Offset_0x028662
Offset_0x02865E:
                moveq   #$00, D0
                rts
Offset_0x028662:
                move.b  Obj_Routine(A0), Obj_Control_Var_01(A0)   ; $0024, $002D
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                move.b  #$10, Obj_Control_Var_00(A0)                     ; $002C
                moveq   #$01, D0
                rts                            
;-------------------------------------------------------------------------------  
Obj_0x92_Ptr:                                                  ; Offset_0x028678
                dc.l    Spiker_Mappings                        ; Offset_0x02868E
                dc.w    $0000
                dc.b    $04, $04, $10, $12
;-------------------------------------------------------------------------------
Spiker_Animate_Data:                                           ; Offset_0x028682
                dc.w    Offset_0x028686-Spiker_Animate_Data
                dc.w    Offset_0x02868A-Spiker_Animate_Data
Offset_0x028686:
                dc.b    $09, $00, $01, $FF
Offset_0x02868A:
                dc.b    $09, $02, $03, $FF           
;------------------------------------------------------------------------------- 
Spiker_Mappings:                                               ; Offset_0x02868E
                dc.w    Offset_0x028698-Spiker_Mappings
                dc.w    Offset_0x0286B2-Spiker_Mappings
                dc.w    Offset_0x0286CC-Spiker_Mappings
                dc.w    Offset_0x0286DE-Spiker_Mappings
                dc.w    Offset_0x0286F0-Spiker_Mappings
Offset_0x028698:
                dc.w    $0003
                dc.l    $08090520, $0290FFF4
                dc.l    $E807252C, $22A2FFF8
                dc.l    $000503DE, $01EFFFF8
Offset_0x0286B2:
                dc.w    $0003
                dc.l    $08090526, $0299FFF4
                dc.l    $E807252C, $22A2FFF8
                dc.l    $000503DE, $01EFFFF8
Offset_0x0286CC:
                dc.w    $0002
                dc.l    $08090520, $0290FFF4
                dc.l    $000503DE, $01EFFFF8
Offset_0x0286DE:
                dc.w    $0002
                dc.l    $08090526, $0299FFF4
                dc.l    $000503DE, $01EFFFF8
Offset_0x0286F0:
                dc.w    $0001
                dc.l    $EC07252C, $22A2FFF8
;===============================================================================
; Objeto 0x93 - Broca lançada pelo inimigo Spiker na Hill Top
; <<<-
;===============================================================================