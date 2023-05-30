;===============================================================================
; Objeto 0x74 - Barreira invisível utilizada para bloquear passagens nas fases
; ->>>
;===============================================================================   
; Offset_0x015FBA:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x015FC8(PC, D0), D1
                jmp     Offset_0x015FC8(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x015FC8:
                dc.w    Offset_0x015FCC-Offset_0x015FC8
                dc.w    Offset_0x016008-Offset_0x015FC8        
;-------------------------------------------------------------------------------
Offset_0x015FCC:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Invisible_Block_Mappings, Obj_Map(A0) ; Offset_0x016052, $0004
                move.w  #$8680, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_00_To_ModifySpriteAttr_2P          ; Offset_0x01639C
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.b  D0, D1
                andi.w  #$00F0, D0
                addi.w  #$0010, D0
                lsr.w   #$01, D0
                move.b  D0, Obj_Width(A0)                                ; $0019
                andi.w  #$000F, D1
                addq.w  #$01, D1
                lsl.w   #$03, D1
                move.b  D1, Obj_Height_2(A0)                             ; $0016    
;-------------------------------------------------------------------------------
Offset_0x016008:
                bsr     Jmp_00_To_Check_Object_On_Screen       ; Offset_0x0163A2
                bne.s   Offset_0x01602A
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject_2                          ; Offset_0x00F39E
Offset_0x01602A:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x016044
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_02_To_DeleteObject                 ; Offset_0x016396
Offset_0x016044:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Offset_0x016050
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x016050:
                rts                 
;-------------------------------------------------------------------------------
Invisible_Block_Mappings:                                      ; Offset_0x016052
                dc.w    Offset_0x016058-Invisible_Block_Mappings
                dc.w    Offset_0x01607A-Invisible_Block_Mappings
                dc.w    Offset_0x01609C-Invisible_Block_Mappings
Offset_0x016058:
                dc.w    $0004
                dc.l    $F005001C, $000EFFF0
                dc.l    $F005001C, $000E0000
                dc.l    $0005001C, $000EFFF0
                dc.l    $0005001C, $000E0000
Offset_0x01607A:
                dc.w    $0004
                dc.l    $E005001C, $000EFFC0
                dc.l    $E005001C, $000E0030
                dc.l    $1005001C, $000EFFC0
                dc.l    $1005001C, $000E0030
Offset_0x01609C:
                dc.w    $0004
                dc.l    $E005001C, $000EFF80
                dc.l    $E005001C, $000E0070
                dc.l    $1005001C, $000EFF80
                dc.l    $1005001C, $000E0070
;===============================================================================
; Objeto 0x74 - Barreira invisível utilizada para bloquear passagens nas fases
; <<<-
;===============================================================================