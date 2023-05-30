;===============================================================================
; Objeto 0xA1 - Inimigo Slicer na Metropolis
; ->>>
;===============================================================================
; Offset_0x029906:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x029914(PC, D0), D1
                jmp     Offset_0x029914(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x029914:
                dc.w    Offset_0x02991E-Offset_0x029914
                dc.w    Offset_0x029936-Offset_0x029914
                dc.w    Offset_0x029992-Offset_0x029914
                dc.w    Offset_0x0299AE-Offset_0x029914
                dc.w    Offset_0x0299CA-Offset_0x029914       
;------------------------------------------------------------------------------- 
Offset_0x02991E:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FFC0, Obj_Speed(A0)                            ; $0010
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$10, Obj_Width_2(A0)                            ; $0017
                rts       
;------------------------------------------------------------------------------- 
Offset_0x029936:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D0
                bne.s   Offset_0x029948
                addi.w  #$0080, D2
                cmpi.w  #$0100, D2
                bcs.s   Offset_0x02997E
Offset_0x029948:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFF8, D1
                blt.s   Offset_0x029970
                cmpi.w  #$000C, D1
                bge.s   Offset_0x029970
                add.w   D1, Obj_Y(A0)                                    ; $000C
                lea     (Slicer_Animate_Data), A1              ; Offset_0x029ACA
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029970:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$3B, Obj_Timer(A0)                              ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02997E:
                addq.b  #$04, Obj_Routine(A0)                            ; $0024
                move.b  #$03, Obj_Map_Id(A0)                             ; $001A
                move.b  #$08, Obj_Timer(A0)                              ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;------------------------------------------------------------------------------- 
Offset_0x029992:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x02999C
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02999C:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;------------------------------------------------------------------------------- 
Offset_0x0299AE:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x0299B8
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x0299B8:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                bsr     Load_Slicer_Pincers_Obj                ; Offset_0x029A78
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;------------------------------------------------------------------------------- 
Offset_0x0299CA:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0        
;===============================================================================
; Objeto 0xA1 - Inimigo Slicer na Metropolis
; <<<-
;===============================================================================