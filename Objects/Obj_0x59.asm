;===============================================================================
; Objeto 0x59 - Inimigo "Motobug" na Green Hill
; ->>>
;===============================================================================   
; Offset_0x022638:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x022646(PC, D0), D1
                jmp     Offset_0x022646(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x022646:
                dc.w    Offset_0x022650-Offset_0x022646
                dc.w    Offset_0x0226F0-Offset_0x022646
                dc.w    Offset_0x02281C-Offset_0x022646
                dc.w    Offset_0x022854-Offset_0x022646
                dc.w    Offset_0x0227DA-Offset_0x022646         
;-------------------------------------------------------------------------------
Offset_0x022650:
                move.l  #Motobug_Mappings, Obj_Map(A0)  ; Offset_0x022888, $0004
                move.w  #$0402, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_2A_To_ModifySpriteAttr_2P          ; Offset_0x0228DA
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$0E, Obj_Width_2(A0)                            ; $0017
                bsr     Jmp_12_To_SingleObjectLoad_2           ; Offset_0x0228C2
                bne.s   Offset_0x0226D8
                move.b  #$59, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  #Motobug_Mappings, Obj_Map(A1)  ; Offset_0x022888, $0004
                move.w  #$2402, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_05_To_ModifySpriteAttr_2P_A1       ; Offset_0x0228CE
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.l  A0, Obj_Timer(A1)                                ; $002A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$02, Obj_Map_Id(A1)                             ; $001A
Offset_0x0226D8:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$FF80, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0226EA
                neg.w   D0
Offset_0x0226EA:
                move.w  D0, Obj_Speed(A0)                                ; $0010
                rts     
;-------------------------------------------------------------------------------
Offset_0x0226F0:
                bsr     Offset_0x022738
                bsr     Jmp_14_To_SpeedToPos                   ; Offset_0x0228E6
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFF8, D1
                blt.s   Offset_0x02271C
                cmpi.w  #$000C, D1
                bge.s   Offset_0x02271C
                add.w   D1, Obj_Y(A0)                                    ; $000C
                lea     (Motobug_Animate_Data), A1             ; Offset_0x02287C
                bsr     Jmp_10_To_AnimateSprite                ; Offset_0x0228C8
                bra     Jmp_00_To_MarkObjGone_4                ; Offset_0x0228D4
Offset_0x02271C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0014, Obj_Control_Var_04(A0)                   ; $0030
                st      Obj_Control_Var_08(A0)                           ; $0034
                lea     (Motobug_Animate_Data), A1             ; Offset_0x02287C
                bsr     Jmp_10_To_AnimateSprite                ; Offset_0x0228C8
                bra     Jmp_00_To_MarkObjGone_4                ; Offset_0x0228D4
Offset_0x022738:
                tst.b   Obj_Control_Var_09(A0)                           ; $0035
                bne.s   Offset_0x02277A
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                cmpi.w  #$0064, D0
                bgt.s   Offset_0x02277A
                cmpi.w  #$FF9C, D0
                blt.s   Offset_0x02277A
                tst.w   D0
                bmi.s   Offset_0x022760
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x02277A
                bra.s   Offset_0x022768
Offset_0x022760:
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x02277A
Offset_0x022768:
                move.w  Obj_Speed(A0), D0                                ; $0010
                asl.w   #$02, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                st      Obj_Control_Var_09(A0)                           ; $0035
                bsr     Offset_0x02277C
Offset_0x02277A:
                rts
Offset_0x02277C:
                bsr     Jmp_12_To_SingleObjectLoad_2           ; Offset_0x0228C2
                bne.s   Offset_0x0227D8
                move.b  #$59, Obj_Id(A1)                                 ; $0000
                move.b  #$08, Obj_Routine(A1)                            ; $0024
                move.l  #Buzzer_Mappings, Obj_Map(A1)   ; Offset_0x0241EA, $0004
                move.w  #$03E6, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_05_To_ModifySpriteAttr_2P_A1       ; Offset_0x0228CE
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.l  A0, Obj_Timer(A1)                                ; $002A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addq.w  #$07, Obj_Y(A1)                                  ; $000C
                addi.w  #$000D, Obj_X(A1)                                ; $0008
                move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
Offset_0x0227D8:
                rts
;-------------------------------------------------------------------------------
Offset_0x0227DA:
                move.l  Obj_Timer(A0), A1                                ; $002A
                cmpi.b  #$59, (A1)
                bne     Jmp_1B_To_DeleteObject                 ; Offset_0x0228BC
                tst.b   Obj_Control_Var_08(A1)                           ; $0034
                bne     Jmp_1B_To_DeleteObject                 ; Offset_0x0228BC
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addq.w  #$07, Obj_Y(A0)                                  ; $000C
                moveq   #$0D, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x02280A
                neg.w   D0
Offset_0x02280A:
                add.w   D0, Obj_X(A0)                                    ; $0008
                lea     (Buzzer_AnimateData), A1               ; Offset_0x0241CE
                bsr     Jmp_10_To_AnimateSprite                ; Offset_0x0228C8
                bra     Jmp_00_To_MarkObjGone_4                ; Offset_0x0228D4       
;-------------------------------------------------------------------------------
Offset_0x02281C:
                subi.w  #$0001, Obj_Control_Var_04(A0)                   ; $0030
                bpl     Jmp_00_To_MarkObjGone_4                ; Offset_0x0228D4
                neg.w   Obj_Speed(A0)                                    ; $0010
                bsr     Jmp_08_To_ObjectFall                   ; Offset_0x0228E0
                move.w  Obj_Speed(A0), D0                                ; $0010
                asr.w   #$02, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
                bchg    #00, Obj_Flags(A0)                               ; $0001
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                sf      Obj_Control_Var_08(A0)                           ; $0034
                sf      Obj_Control_Var_09(A0)                           ; $0035
                bra     Jmp_00_To_MarkObjGone_4                ; Offset_0x0228D4   
;-------------------------------------------------------------------------------
Offset_0x022854:
                move.l  Obj_Timer(A0), A1                                ; $002A
                cmpi.b  #$59, (A1)
                bne     Jmp_1B_To_DeleteObject                 ; Offset_0x0228BC
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                bra     Jmp_00_To_MarkObjGone_4                ; Offset_0x0228D4              
;-------------------------------------------------------------------------------
Motobug_Animate_Data:                                          ; Offset_0x02287C
                dc.w    Offset_0x022880-Motobug_Animate_Data
                dc.w    Offset_0x022884-Motobug_Animate_Data
Offset_0x022880:
                dc.b    $05, $00, $01, $FF
Offset_0x022884:
                dc.b    $01, $00, $01, $FF      
;-------------------------------------------------------------------------------
Motobug_Mappings:
                dc.w    Offset_0x02288E-Motobug_Mappings
                dc.w    Offset_0x0228A0-Motobug_Mappings
                dc.w    Offset_0x0228B2-Motobug_Mappings
Offset_0x02288E:
                dc.w    $0002
                dc.l    $F00F0000, $0000FFF0
                dc.l    $01090014, $000AFFF4
Offset_0x0228A0:
                dc.w    $0002
                dc.l    $F00F0000, $0000FFF0
                dc.l    $01091014, $100AFFF4
Offset_0x0228B2:
                dc.w    $0001
                dc.l    $FA050010, $0008FFE9
;===============================================================================
; Objeto 0x59 - Inimigo "Motobug" na Green Hill
; ->>>
;===============================================================================