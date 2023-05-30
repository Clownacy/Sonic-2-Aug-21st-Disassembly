;===============================================================================
; Objeto - Inimigo "Blink"
; ->>>
;===============================================================================
; Offset_0x021458:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x021466(PC, D0), D1
                jmp     Offset_0x021466(PC, D1)            
;-------------------------------------------------------------------------------    
Offset_0x021466:
                dc.w    Offset_0x02146E-Offset_0x021466
                dc.w    Offset_0x021558-Offset_0x021466
                dc.w    Offset_0x021586-Offset_0x021466
                dc.w    Offset_0x021516-Offset_0x021466         
;-------------------------------------------------------------------------------
Offset_0x02146E:
                move.l  #Blink_Mappings, Obj_Map(A0)    ; Offset_0x021678, $0004
                move.w  #$24E1, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_29_To_ModifySpriteAttr_2P          ; Offset_0x0216F0
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$14, Obj_Width(A0)                              ; $0019
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                move.b  #$0C, Obj_Col_Flags(A0)                          ; $0020
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$000F, Obj_Timer(A0)                            ; $002A
                move.w  #$FF00, Obj_Speed(A0)                            ; $0010
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0214C0
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x0214C0:
                bsr     Jmp_08_To_SingleObjectLoad             ; Offset_0x0216D2
                bne.s   Offset_0x021514
                move.b  (A0), (A1)
                move.l  #Blink_Mappings, Obj_Map(A1)    ; Offset_0x021678, $0004
                move.w  #$04E1, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_29_To_ModifySpriteAttr_2P          ; Offset_0x0216F0
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$14, Obj_Width(A1)                              ; $0019
                move.b  #$0C, Obj_Height_2(A1)                           ; $0016
                move.b  #$08, Obj_Width_2(A1)                            ; $0017
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.l  A0, Obj_Control_Var_00(A1)                       ; $002C
Offset_0x021514:
                rts   
;-------------------------------------------------------------------------------
Offset_0x021516:
                move.l  Obj_Control_Var_00(A0), A1                       ; $002C
                tst.b   (A1)
                beq     Jmp_17_To_DeleteObject                 ; Offset_0x0216CC
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addi.w  #$0001, Obj_Y(A0)                                ; $000C
                move.w  #$0015, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x021546
                neg.w   D0
Offset_0x021546:
                add.w   D0, Obj_X(A0)                                    ; $0008
                lea     (Blink_Animate_Data), A1               ; Offset_0x02166A
                bsr     Jmp_0B_To_AnimateSprite                ; Offset_0x0216DE
                bra     Jmp_1E_To_MarkObjGone                  ; Offset_0x0216D8 
;-------------------------------------------------------------------------------
Offset_0x021558:
                bsr     Jmp_11_To_SpeedToPos                   ; Offset_0x0216FC
                bsr     Offset_0x021564
                bra     Jmp_1E_To_MarkObjGone                  ; Offset_0x0216D8
Offset_0x021564:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bne.s   Offset_0x021584
                bsr     Jmp_08_To_SingleObjectLoad             ; Offset_0x0216D2
                bne.s   Offset_0x021584
                move.b  (A0), (A1)
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  #$0078, Obj_Timer(A1)                            ; $002A
                move.l  A0, Obj_Control_Var_00(A1)                       ; $002C
Offset_0x021584:
                rts
;-------------------------------------------------------------------------------
Offset_0x021586:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x021594(PC, D0), D1
                jmp     Offset_0x021594(PC, D1)     
;-------------------------------------------------------------------------------
Offset_0x021594:
                dc.w    Offset_0x021598-Offset_0x021594
                dc.w    Offset_0x02163A-Offset_0x021594       
;-------------------------------------------------------------------------------  
Offset_0x021598:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bmi     Offset_0x02162C
                bsr     Jmp_01_To_PseudoRandomNumber           ; Offset_0x0216E4
                andi.w  #$007F, D0
                bne     Offset_0x02162A
                bsr     Jmp_08_To_SingleObjectLoad             ; Offset_0x0216D2
                bne.s   Offset_0x02162A
                move.b  (A0), (A1)
                move.l  #Blink_Mappings, Obj_Map(A1)    ; Offset_0x021678, $0004
                move.w  #$64E1, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                addi.b  #$02, Obj_Routine_2(A1)                          ; $0025
                bsr     Jmp_29_To_ModifySpriteAttr_2P          ; Offset_0x0216F0
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$04, Obj_Height_2(A1)                           ; $0016
                move.b  #$08, Obj_Width_2(A1)                            ; $0017
                move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
                move.l  Obj_Control_Var_00(A0), A2                       ; $002C
                tst.b   (A2)
                beq.s   Offset_0x02162C
                move.b  Obj_Status(A2), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A2), Obj_Flags(A1)              ; $0001, $0001
                move.w  Obj_X(A2), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A2), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0007, Obj_Y(A1)                                ; $000C
                addi.w  #$0007, Obj_X(A1)                                ; $0008
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x02162A
                subi.w  #$000E, Obj_X(A1)                                ; $0008
Offset_0x02162A:
                rts
Offset_0x02162C:
                move.l  Obj_Control_Var_00(A0), A1                       ; $002C
                move.w  #$003C, Obj_Timer(A1)                            ; $002A
                bra     Jmp_17_To_DeleteObject                 ; Offset_0x0216CC    
;-------------------------------------------------------------------------------  
Offset_0x02163A:
                bsr     Jmp_04_To_ObjectFall                   ; Offset_0x0216F6
                bsr     Jmp_04_To_ObjHitFloor                  ; Offset_0x0216EA
                tst.w   D1
                bpl.s   Offset_0x02165C
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  #$55, Obj_Id(A0)                                 ; $0000
                move.b  #$00, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Routine(A0)                            ; $0024
Offset_0x02165C:
                lea     (Blink_Animate_Data), A1               ; Offset_0x02166A
                bsr     Jmp_0B_To_AnimateSprite                ; Offset_0x0216DE
                bra     Jmp_1E_To_MarkObjGone                  ; Offset_0x0216D8       
;-------------------------------------------------------------------------------
Blink_Animate_Data:                                            ; Offset_0x02166A
                dc.w    Offset_0x02166E-Blink_Animate_Data
                dc.w    Offset_0x021672-Blink_Animate_Data
Offset_0x02166E:
                dc.b    $03, $01, $06, $FF
Offset_0x021672:
                dc.b    $03, $02, $05, $03, $04, $FF     
;-------------------------------------------------------------------------------
Blink_Mappings:                                                ; Offset_0x021678
                dc.w    Offset_0x021686-Blink_Mappings
                dc.w    Offset_0x021690-Blink_Mappings
                dc.w    Offset_0x02169A-Blink_Mappings
                dc.w    Offset_0x0216A4-Blink_Mappings
                dc.w    Offset_0x0216AE-Blink_Mappings
                dc.w    Offset_0x0216B8-Blink_Mappings
                dc.w    Offset_0x0216C2-Blink_Mappings
Offset_0x021686:
                dc.w    $0001
                dc.l    $F00F0000, $0000FFF0
Offset_0x021690:
                dc.w    $0001
                dc.l    $F8010012, $0009FFFC
Offset_0x02169A:
                dc.w    $0001
                dc.l    $FC000014, $000AFFFC
Offset_0x0216A4:
                dc.w    $0001
                dc.l    $FC000015, $000AFFFC
Offset_0x0216AE:
                dc.w    $0001
                dc.l    $FC000016, $000BFFFC
Offset_0x0216B8:
                dc.w    $0001
                dc.l    $FC000017, $000BFFFC
Offset_0x0216C2:
                dc.w    $0001
                dc.l    $F8010010, $0008FFFC
;===============================================================================
; Objeto - Inimigo "Blink"
; <<<-
;===============================================================================