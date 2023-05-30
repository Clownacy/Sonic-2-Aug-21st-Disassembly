;===============================================================================
; Object 0x0C
; ->>> 
;===============================================================================   
; Offset_0x01531C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01532A(PC, D0), D1
                jmp     Offset_0x01532A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01532A:
                dc.w    Offset_0x01532E-Offset_0x01532A
                dc.w    Offset_0x01538E-Offset_0x01532A   
;------------------------------------------------------------------------------- 
Offset_0x01532E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Unk_Platform_Mappings, Obj_Map(A0) ; Offset_0x015406, $0004
                move.w  #$E418, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_Y(A0), D0                                    ; $000C
                subi.w  #$0010, D0
                move.w  D0, Obj_Control_Var_0E(A0)                       ; $003A
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$00F0, D0
                addi.w  #$0010, D0
                move.w  D0, D1
                subq.w  #$01, D0
                move.w  D0, Obj_Control_Var_04(A0)                       ; $0030
                move.w  D0, Obj_Control_Var_06(A0)                       ; $0032
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                move.b  D0, Obj_Control_Var_12(A0)                       ; $003E
                move.b  D0, Obj_Control_Var_13(A0)                       ; $003F  
;-------------------------------------------------------------------------------  
Offset_0x01538E:                
                move.b  Obj_Control_Var_10(A0), D0                       ; $003C   
                beq.s   Offset_0x0153CC
                cmpi.b  #$80, D0
                bne.s   Offset_0x0153DC
                move.b  Obj_Control_Var_11(A0), D1                       ; $003D
                bne.s   Offset_0x0153AE
                subq.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                bpl.s   Offset_0x0153AE
                move.b  Obj_Control_Var_13(A0), Obj_Control_Var_12(A0); $003E, $003F
                bra.s   Offset_0x0153DC
Offset_0x0153AE:
                addq.b  #$01, Obj_Control_Var_11(A0)                     ; $003D
                move.b  D1, D0
                bsr     Jmp_00_To_CalcSine                     ; Offset_0x01541A
                addi.w  #$0008, D0
                asr.w   #$06, D0
                subi.w  #$0010, D0
                add.w   Obj_Control_Var_0E(A0), D0                       ; $003A
                move.w  D0, Obj_Y(A0)                                    ; $000C
                bra.s   Offset_0x0153F2
Offset_0x0153CC:
                move.w  ($FFFFFE0E).w, D1
                andi.w  #$03FF, D1
                bne.s   Offset_0x0153E0
                move.b  #$01, Obj_Control_Var_11(A0)                     ; $003D
Offset_0x0153DC:
                addq.b  #$01, Obj_Control_Var_10(A0)                     ; $003C
Offset_0x0153E0:
                bsr     Jmp_00_To_CalcSine                     ; Offset_0x01541A
                addi.w  #$0008, D1
                asr.w   #$04, D1
                add.w   Obj_Control_Var_0E(A0), D1                       ; $003A
                move.w  D1, Obj_Y(A0)                                    ; $000C
Offset_0x0153F2:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                moveq   #$09, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Platform_Object                        ; Offset_0x00F82C
                bra     Jmp_01_To_MarkObjGone                  ; Offset_0x015414
;-------------------------------------------------------------------------------
Unk_Platform_Mappings:                                         ; Offset_0x015406
                dc.w    Offset_0x015408-Unk_Platform_Mappings
Offset_0x015408:
                dc.w    $0001
                dc.l    $F80D0000, $0000FFF0          
;===============================================================================
; Object 0x0C
; <<<- 
;===============================================================================