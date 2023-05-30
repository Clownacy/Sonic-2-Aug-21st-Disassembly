;===============================================================================
; Objeto 0x2A - Barreira que sobe e desce na Dust Hill
; ->>> 
;===============================================================================  
; Offset_0x00A158:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00A166(PC, D0), D1
                jmp     Offset_0x00A166(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x00A166:
                dc.w    Offset_0x00A16A-Offset_0x00A166
                dc.w    Offset_0x00A1A4-Offset_0x00A166           
;-------------------------------------------------------------------------------  
Offset_0x00A16A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Up_Down_Pillar_Mappings, Obj_Map(A0) ; Offset_0x00A1FA, $0004
                move.w  #$4000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                move.b  #$50, Obj_Height_2(A0)                           ; $0016
                bset    #$04, Obj_Flags(A0)                              ; $0001   
;------------------------------------------------------------------------------- 
Offset_0x00A1A4:
                tst.b   Obj_Routine_2(A0)                                ; $0025
                bne.s   Offset_0x00A1BE
                addq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                cmpi.w  #$0060, Obj_Control_Var_04(A0)                   ; $0030
                bne.s   Offset_0x00A1D0
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra.s   Offset_0x00A1D0
Offset_0x00A1BE:
                subq.w  #$08, Obj_Control_Var_04(A0)                     ; $0030
                bhi.s   Offset_0x00A1D0
                move.w  #$0000, Obj_Control_Var_04(A0)                   ; $0030
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
Offset_0x00A1D0:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                sub.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                move.w  #$0040, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject                            ; Offset_0x00F344
                bra     MarkObjGone                            ; Offset_0x00D200 
;-------------------------------------------------------------------------------
Up_Down_Pillar_Mappings:                                       ; Offset_0x00A1FA
                dc.w    Offset_0x00A1FC-Up_Down_Pillar_Mappings
Offset_0x00A1FC:
                dc.w    $0006
                dc.l    $B009001A, $000DFFF0
                dc.l    $C00F0020, $0010FFF0
                dc.l    $E00F0030, $0018FFF0
                dc.l    $000F1030, $1018FFF0
                dc.l    $200F1020, $1010FFF0
                dc.l    $4009101A, $100DFFF0  
;===============================================================================
; Objeto 0x2A - Barreira que sobe e desce na Dust Hill
; <<<- 
;===============================================================================