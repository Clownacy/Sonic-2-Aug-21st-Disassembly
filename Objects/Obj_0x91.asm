;===============================================================================
; Objeto 0x91 -> Inimigo Chop Chop na Neo Green Hill
; ->>>
;===============================================================================
; Offset_0x0283BC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0283CA(PC, D0), D1
                jmp     Offset_0x0283CA(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0283CA:
                dc.w    Offset_0x0283D2-Offset_0x0283CA
                dc.w    Offset_0x0283F4-Offset_0x0283CA
                dc.w    Offset_0x028442-Offset_0x0283CA
                dc.w    Offset_0x028476-Offset_0x0283CA    
;-------------------------------------------------------------------------------
Offset_0x0283D2:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$0200, Obj_Timer(A0)                            ; $002A
                move.w  #$0050, Obj_Control_Var_00(A0)                   ; $002C
                moveq   #$40, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0283EE
                neg.w   D0
Offset_0x0283EE:
                move.w  D0, Obj_Speed(A0)                                ; $0010
                rts   
;-------------------------------------------------------------------------------
Offset_0x0283F4:
                subq.b  #$01, Obj_Control_Var_00(A0)                     ; $002C
                bne.s   Offset_0x0283FE
                bsr     Offset_0x028488
Offset_0x0283FE:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bpl.s   Offset_0x02841A
                move.w  #$0200, Obj_Timer(A0)                            ; $002A
                bchg    #00, Obj_Status(A0)                              ; $0022
                bchg    #00, Obj_Flags(A0)                               ; $0001
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x02841A:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                move.w  D2, D4
                move.w  D3, D5
                bsr     Offset_0x0284C2
                bne.s   Offset_0x028430
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028430:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$10, Obj_Timer(A0)                              ; $002A
                clr.w   Obj_Speed(A0)                                    ; $0010
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028442:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x02844C
                bra     Offset_0x02847A
Offset_0x02844C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                lsr.w   #$01, D0
                move.b  Offset_0x028472(PC, D0), Obj_Speed(A0)           ; $0010
                addi.w  #$0010, D3
                cmpi.w  #$0020, D3
                bcs.s   Offset_0x02846E
                lsr.w   #$01, D1
                move.b  Offset_0x028474(PC, D1), $0013(A0)
Offset_0x02846E:
                bra     Offset_0x02847A    
;-------------------------------------------------------------------------------
Offset_0x028472:
                dc.b    $FE, $02         
;------------------------------------------------------------------------------- 
Offset_0x028474:
                dc.b    $80, $80     
;-------------------------------------------------------------------------------
Offset_0x028476:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
Offset_0x02847A:
                lea     (Chop_Chop_Animate_Data), A1           ; Offset_0x028500
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028488:
                move.w  #$0050, Obj_Control_Var_00(A0)                   ; $002C
                bsr     Jmp_10_To_SingleObjectLoad             ; Offset_0x02A79A
                bne.s   Offset_0x0284C0
                move.b  #$0A, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                moveq   #$14, D0
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x0284B2
                neg.w   D0
Offset_0x0284B2:
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addq.w  #$06, Obj_Y(A1)                                  ; $000C
Offset_0x0284C0:
                rts
Offset_0x0284C2:
                addi.w  #$0020, D3
                cmpi.w  #$0040, D3
                bcc.s   Offset_0x0284EE
                tst.w   D2
                bmi.s   Offset_0x0284DA
                tst.w   Obj_Speed(A0)                                    ; $0010
                bpl.s   Offset_0x0284EE
                bra     Offset_0x0284E2
Offset_0x0284DA:
                tst.w   Obj_Speed(A0)                                    ; $0010
                bmi.s   Offset_0x0284EE
                neg.w   D2
Offset_0x0284E2:
                cmpi.w  #$0020, D2
                bcs.s   Offset_0x0284EE
                cmpi.w  #$00A0, D2
                bcs.s   Offset_0x0284F2
Offset_0x0284EE:
                moveq   #$00, D2
                rts
Offset_0x0284F2:
                moveq   #$01, D2
                rts                  
;-------------------------------------------------------------------------------  
Obj_0x91_Ptr:                                                  ; Offset_0x0284F6
                dc.l    Chop_Chop_Mappings                     ; Offset_0x028506
                dc.w    $253B
                dc.b    $04, $04, $10, $02        
;-------------------------------------------------------------------------------                      
Chop_Chop_Animate_Data:                                        ; Offset_0x028500
                dc.w    Offset_0x028502-Chop_Chop_Animate_Data
Offset_0x028502:
                dc.b    $04, $00, $01, $FF   
;-------------------------------------------------------------------------------        
Chop_Chop_Mappings:                                            ; Offset_0x028506
                dc.w    Offset_0x02850A-Chop_Chop_Mappings
                dc.w    Offset_0x028514-Chop_Chop_Mappings
Offset_0x02850A:
                dc.w    $0001
                dc.l    $F40E0000, $0000FFF0
Offset_0x028514:
                dc.w    $0001
                dc.l    $F40E000C, $0006FFF0 
;===============================================================================
; Objeto 0x91 -> Inimigo Chop Chop na Neo Green Hill
; <<<-
;===============================================================================