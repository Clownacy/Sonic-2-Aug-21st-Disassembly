;===============================================================================
; Objeto 0x9B - Inimigo tartaruga na Sky Chase (Atira bolas de fogo no jogador)
; ->>>          Objeto utilizado pelo 0x9A
;===============================================================================
; Offset_0x028FE4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x028FF2(PC, D0), D1
                jmp     Offset_0x028FF2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x028FF2:
                dc.w    Offset_0x028FF6-Offset_0x028FF2
                dc.w    Offset_0x028FFA-Offset_0x028FF2       
;-------------------------------------------------------------------------------
Offset_0x028FF6:
                bra     Object_Settings                        ; Offset_0x027EA4 
;-------------------------------------------------------------------------------
Offset_0x028FFA:
                move.w  Obj_Timer(A0), A1                                ; $002A
                lea     Offset_0x02900A(PC), A2
                bsr     Offset_0x02900E
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;------------------------------------------------------------------------------- 
Offset_0x02900A:
                dc.w    $0004, $FFE8                                          
;-------------------------------------------------------------------------------
Offset_0x02900E:
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.w  (A2)+, D0
                add.w   D0, Obj_X(A0)                                    ; $0008
                move.w  (A2)+, D0
                add.w   D0, Obj_Y(A0)                                    ; $000C
;-------------------------------------------------------------------------------                
Return_to_sub_routine: ; Usado por vários objetos              ; Offset_0x029026
                rts                                                              
;-------------------------------------------------------------------------------  
Load_Turtloid_Sub_Obj_0x9B:                                    ; Offset_0x029028
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x02905E
                move.b  #$9B, Obj_Id(A1)                                 ; $0000
                move.b  #$02, Obj_Map_Id(A1)                             ; $001A
                move.b  #$18, Obj_Subtype(A1)                            ; $0028
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  A1, Obj_Control_Var_00(A0)                       ; $002C
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                addq.w  #$04, Obj_X(A1)                                  ; $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                subi.w  #$0018, Obj_Y(A1)                                ; $000C
Offset_0x02905E:
                rts 
;===============================================================================
; Objeto 0x9B - Inimigo tartaruga na Sky Chase (Atira bolas de fogo no jogador)
; <<<-          Objeto utilizado pelo 0x9A
;===============================================================================