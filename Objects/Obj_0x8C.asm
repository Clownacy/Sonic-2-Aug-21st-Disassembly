;===============================================================================
; Objeto 0x8C -> Moscas na Neo Green Hill
; ->>>
;===============================================================================
; Offset_0x027F84:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x027F92(PC, D0), D1
                jmp     Offset_0x027F92(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x027F92:
                dc.w    Offset_0x027F9A-Offset_0x027F92
                dc.w    Offset_0x027FAC-Offset_0x027F92
                dc.w    Offset_0x027FF0-Offset_0x027F92
                dc.w    Offset_0x028056-Offset_0x027F92   
;-------------------------------------------------------------------------------
Offset_0x027F9A:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.b  #$10, Obj_Timer(A0)                              ; $002A
                move.b  #$06, Obj_Player_Status(A0)                      ; $002B
                rts     
;-------------------------------------------------------------------------------
Offset_0x027FAC:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x027FC0
                lea     (Whisp_Animate_Data), A1               ; Offset_0x028072
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x027FC0:
                subq.b  #$01, Obj_Player_Status(A0)                      ; $002B
                bpl.s   Offset_0x027FE0
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                bclr    #$00, Obj_Status(A0)                             ; $0022
                clr.w   Obj_Speed_Y(A0)                                  ; $0012
                move.w  #$FE00, Obj_Speed(A0)                            ; $0010
                bra     Offset_0x028056
Offset_0x027FE0:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$FF00, Obj_Speed_Y(A0)                          ; $0012
                move.b  #$60, Obj_Timer(A0)                              ; $002A 
;-------------------------------------------------------------------------------
Offset_0x027FF0:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x02803A
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                bclr    #$00, Obj_Status(A0)                             ; $0022
                tst.w   D0
                beq.s   Offset_0x02800A
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x02800A:
                move.w  Offset_0x028036(PC, D0), D2
                add.w   D2, Obj_Speed(A0)                                ; $0010
                move.w  Offset_0x028036(PC, D1), D2
                add.w   D2, Obj_Speed_Y(A0)                              ; $0012
                move.w  #$0200, D0
                move.w  D0, D1
                bsr     Offset_0x027F3E
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Whisp_Animate_Data), A1               ; Offset_0x028072
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;------------------------------------------------------------------------------- 
Offset_0x028036:
                dc.w    $FFF0, $0010          
;-------------------------------------------------------------------------------
Offset_0x02803A:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$10, Obj_Timer(A0)                              ; $002A
                bsr     Offset_0x027F78
                lea     (Whisp_Animate_Data), A1               ; Offset_0x028072
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028056:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Whisp_Animate_Data), A1               ; Offset_0x028072
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Obj_0x8C_Ptr:                                                  ; Offset_0x028068
                dc.l    Whisp_Mappings                         ; Offset_0x028078
                dc.w    $2500
                dc.b    $04, $04, $0C, $0B          
;-------------------------------------------------------------------------------      
Whisp_Animate_Data:                                            ; Offset_0x028072
                dc.w    Offset_0x028074-Whisp_Animate_Data
Offset_0x028074:
                dc.b    $01, $00, $01, $FF     
;-------------------------------------------------------------------------------   
Whisp_Mappings:                                                ; Offset_0x028078
                dc.w    Offset_0x02807C-Whisp_Mappings
                dc.w    Offset_0x02808E-Whisp_Mappings
Offset_0x02807C:
                dc.w    $0002
                dc.l    $F8080000, $0000FFF4
                dc.l    $00080003, $0001FFF4
Offset_0x02808E:
                dc.w    $0002
                dc.l    $F8080006, $0003FFF4
                dc.l    $00080003, $0001FFF4 
;===============================================================================
; Objeto 0x8C -> Moscas na Neo Green Hill
; <<<-
;===============================================================================