;===============================================================================
; Objeto 0x5B - Robotnik na Green Hill
; ->>>
;===============================================================================
; Offset_0x020786:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x020794(PC, D0), D1
                jmp     Offset_0x020794(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x020794:
                dc.w    Offset_0x0207C2-Offset_0x020794
                dc.w    Offset_0x020848-Offset_0x020794
                dc.w    Offset_0x02089A-Offset_0x020794
                dc.w    Offset_0x02097C-Offset_0x020794
                dc.w    Offset_0x02079E-Offset_0x020794    
;-------------------------------------------------------------------------------
Offset_0x02079E:
                subi.w  #$0001, Obj_Y(A0)                                ; $000C
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bpl     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                move.b  #$00, Obj_Routine(A0)                            ; $0024
                lea     (GHz_Boss_Animate_Data_01), A1         ; Offset_0x020CAA
                bsr     Jmp_08_To_AnimateSprite                ; Offset_0x020E70
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58      
;-------------------------------------------------------------------------------
Offset_0x0207C2:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0207D0(PC, D0), D1
                jmp     Offset_0x0207D0(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x0207D0:
                dc.w    Offset_0x0207D4-Offset_0x0207D0
                dc.w    Offset_0x02081E-Offset_0x0207D0  
;-------------------------------------------------------------------------------
Offset_0x0207D4:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                cmpi.b  #$56, (A1)
                bne     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
                btst    #$00, Obj_Control_Var_01(A1)                     ; $002D
                beq.s   Offset_0x0207F8
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0018, Obj_Timer(A0)                            ; $002A
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x0207F8:
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                lea     (GHz_Boss_Animate_Data_01), A1         ; Offset_0x020CAA
                bsr     Jmp_08_To_AnimateSprite                ; Offset_0x020E70
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58        
;-------------------------------------------------------------------------------
Offset_0x02081E:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bpl.s   Offset_0x02083A
                cmpi.w  #$FFF0, Obj_Timer(A0)                            ; $002A
                ble     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
                addi.w  #$0001, Obj_Y(A0)                                ; $000C
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
Offset_0x02083A:
                lea     (GHz_Boss_Animate_Data_01), A1         ; Offset_0x020CAA
                bsr     Jmp_08_To_AnimateSprite                ; Offset_0x020E70
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58     
;-------------------------------------------------------------------------------
Offset_0x020848:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                cmpi.b  #$56, (A1)
                bne     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
                btst    #$01, Obj_Control_Var_01(A1)                     ; $002D
                beq     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                btst    #$02, Obj_Control_Var_01(A1)                     ; $002D
                bne     Offset_0x02088A
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addi.w  #$0008, Obj_Y(A0)                                ; $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
Offset_0x02088A:
                move.b  #$08, Obj_Map_Id(A0)                             ; $001A
                move.b  #$00, Obj_Priority(A0)                           ; $0018
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58  
;-------------------------------------------------------------------------------
Offset_0x02089A:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0208A8(PC, D0), D1
                jmp     Offset_0x0208A8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0208A8:
                dc.w    Offset_0x0208B0-Offset_0x0208A8
                dc.w    Offset_0x0208CE-Offset_0x0208A8
                dc.w    Offset_0x02092E-Offset_0x0208A8
                dc.w    Offset_0x02095A-Offset_0x0208A8      
;-------------------------------------------------------------------------------
Offset_0x0208B0:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                cmpi.b  #$56, (A1)
                bne     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
                btst    #$01, Obj_Control_Var_01(A1)                     ; $002D
                beq     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58    
;-------------------------------------------------------------------------------
Offset_0x0208CE:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                cmpi.b  #$56, (A1)
                bne     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                tst.b   Obj_Status(A0)                                   ; $0022
                bpl.s   Offset_0x0208F0
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x0208F0:
                bsr     Offset_0x020702
                bsr     Jmp_02_To_ObjectFall                   ; Offset_0x020E88
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x020906
                add.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x020906:
                move.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
                cmpi.b  #$01, Obj_Priority(A0)                           ; $0018
                bne.s   Offset_0x020920
                move.w  Obj_Y(A0), D0                                    ; $000C
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                add.w   D0, Obj_Control_Var_02(A1)                       ; $002E
Offset_0x020920:
                lea     (GHz_Boss_Animate_Data_02), A1         ; Offset_0x020DB8
                bsr     Jmp_08_To_AnimateSprite                ; Offset_0x020E70
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58     
;-------------------------------------------------------------------------------
Offset_0x02092E:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bpl     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$000A, Obj_Timer(A0)                            ; $002A
                move.w  #$FD00, Obj_Speed_Y(A0)                          ; $0012
                cmpi.b  #$01, Obj_Priority(A0)                           ; $0018
                beq     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                neg.w   Obj_Speed(A0)                                    ; $0010
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58      
;-------------------------------------------------------------------------------
Offset_0x02095A:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bpl     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                bsr     Jmp_02_To_ObjectFall                   ; Offset_0x020E88
                bsr     Jmp_03_To_ObjHitFloor                  ; Offset_0x020E7C
                tst.w   D1
                bpl.s   Offset_0x020978
                move.w  #$FE00, Obj_Speed_Y(A0)                          ; $0012
                add.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x020978:
                bra     Jmp_1B_To_MarkObjGone                  ; Offset_0x020E64     
;-------------------------------------------------------------------------------
Offset_0x02097C:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                cmpi.b  #$56, (A1)
                bne     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
                btst    #$03, Obj_Control_Var_01(A1)                     ; $002D
                bne.s   Offset_0x0209E2
                bsr     Offset_0x020A02
                btst    #$01, Obj_Control_Var_01(A1)                     ; $002D
                beq     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
                move.b  #$8B, Obj_Col_Flags(A0)                          ; $0020
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                addi.w  #$0010, Obj_Y(A0)                                ; $000C
                move.w  #$FFCA, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0209D0
                neg.w   D0
Offset_0x0209D0:
                add.w   D0, Obj_X(A0)                                    ; $0008
                lea     (GHz_Boss_Animate_Data_02), A1         ; Offset_0x020DB8
                bsr     Jmp_08_To_AnimateSprite                ; Offset_0x020E70
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
Offset_0x0209E2:
                move.w  #$FFFD, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0209F0
                neg.w   D0
Offset_0x0209F0:
                add.w   D0, Obj_X(A0)                                    ; $0008
                lea     (GHz_Boss_Animate_Data_02), A1         ; Offset_0x020DB8
                bsr     Jmp_08_To_AnimateSprite                ; Offset_0x020E70
                bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
Offset_0x020A02:
                cmpi.b  #$01, Obj_Col_Prop(A1)                           ; $0021
                beq.s   Offset_0x020A0C
                rts
Offset_0x020A0C:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   ($FFFFB008).w, D0
                bpl.s   Offset_0x020A20
                btst    #$00, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x020A2A
                rts
Offset_0x020A20:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x020A2A
                rts
Offset_0x020A2A:
                bset    #$03, Obj_Control_Var_01(A1)                     ; $002D
                rts          
;===============================================================================
; Objeto 0x5B - Robotnik na Green Hill
; <<<-
;===============================================================================