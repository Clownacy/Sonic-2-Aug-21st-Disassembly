;===============================================================================
; Objeto 0x4B - Anel gigante usado para acesso ao Estágio Especial, não usado
; ->>>          Left over do Sonic 1
;===============================================================================
; Offset_0x00AD26:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00AD34(PC, D0), D1
                jmp     Offset_0x00AD34(PC, D1)   
;-------------------------------------------------------------------------------  
Offset_0x00AD34:
                dc.w    Offset_0x00AD3C-Offset_0x00AD34
                dc.w    Offset_0x00AD8A-Offset_0x00AD34
                dc.w    Offset_0x00ADA8-Offset_0x00AD34
                dc.w    Offset_0x00ADE6-Offset_0x00AD34       
;-------------------------------------------------------------------------------
Offset_0x00AD3C:
                move.l  #Big_Ring_Mappings, Obj_Map(A0) ; Offset_0x00AF04, $0004
                move.w  #$2400, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$40, Obj_Width(A0)                              ; $0019
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x00AD8A
                cmpi.b  #$06, (Emerald_Count).w                      ; $FFFFFE57
                beq     Offset_0x00ADE6
                cmpi.w  #$0032, (Ring_Count).w                       ; $FFFFFE20
                bcc.s   Offset_0x00AD74
                rts
Offset_0x00AD74:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                move.b  #$52, Obj_Col_Flags(A0)                          ; $0020
                move.w  #$0C40, ($FFFFF7BE).w      
;-------------------------------------------------------------------------------
Offset_0x00AD8A:
                move.b  (Object_Frame_Buffer+$0003).w, Obj_Map_Id(A0)     ; $FFFFFEA3; $001A
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322       
;-------------------------------------------------------------------------------
Offset_0x00ADA8:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne     Offset_0x00ADDA
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  A0, Obj_Control_Var_10(A1)                       ; $003C
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                cmp.w   Obj_X(A0), D0                                    ; $0008
                bcs.s   Offset_0x00ADDA
                bset    #$00, Obj_Flags(A1)                              ; $0001
Offset_0x00ADDA:
                move.w  #$00C3, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                bra.s   Offset_0x00AD8A        
;-------------------------------------------------------------------------------
Offset_0x00ADE6:
                bra     DeleteObject                           ; Offset_0x00D314 
;===============================================================================
; Objeto 0x4B - Anel gigante usado para acesso ao Estágio Especial, não usado
; <<<-          Left over do Sonic 1
;===============================================================================