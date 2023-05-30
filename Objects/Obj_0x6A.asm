;===============================================================================
; Objeto 0x6A - Três caixas rodando na Dust Hill / Plataformas na Metropolis
; ->>> 
;===============================================================================  
; Offset_0x01C850:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01C85E(PC, D0), D1
                jmp     Offset_0x01C85E(PC, D1)  
;-------------------------------------------------------------------------------  
Offset_0x01C85E:
                dc.w    Offset_0x01C864-Offset_0x01C85E
                dc.w    Offset_0x01C97E-Offset_0x01C85E
                dc.w    Offset_0x01CA06-Offset_0x01C85E       
;-------------------------------------------------------------------------------  
Offset_0x01C864:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Mz_Platform_Mappings, Obj_Map(A0) ; Offset_0x01BC64, $0004
                move.w  #$6000, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.l  #Offset_0x01CA7C, Obj_Control_Var_00(A0)         ; $002C
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$0B, (Level_Id).w                           ; $FFFFFE10
                bne     Offset_0x01C964
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Rotating_Boxes_Mappings, Obj_Map(A0) ; Offset_0x01CAD0, $0004
                move.w  #$63D4, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$20, Obj_Height_2(A0)                           ; $0016
                move.l  #Offset_0x01CA94, Obj_Control_Var_00(A0)         ; $002C
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01C8DC
                move.l  #Offset_0x01CAB2, Obj_Control_Var_00(A0)         ; $002C
Offset_0x01C8DC:
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$18, Obj_Subtype(A0)                            ; $0028
                bne     Offset_0x01C970
                bsr     Jmp_0A_To_SingleObjectLoad_2           ; Offset_0x01CAF4
                bne.s   Offset_0x01C93C
                bsr.s   Offset_0x01C93E
                addi.w  #$0040, Obj_X(A1)                                ; $0008
                addi.w  #$0040, Obj_Y(A1)                                ; $000C
                move.b  #$06, Obj_Subtype(A1)                            ; $0028
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01C914
                move.b  #$0C, Obj_Subtype(A1)                            ; $0028
Offset_0x01C914:
                bsr     Jmp_0A_To_SingleObjectLoad_2           ; Offset_0x01CAF4
                bne.s   Offset_0x01C93C
                bsr.s   Offset_0x01C93E
                subi.w  #$0040, Obj_X(A1)                                ; $0008
                addi.w  #$0040, Obj_Y(A1)                                ; $000C
                move.b  #$0C, Obj_Subtype(A1)                            ; $0028
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01C93C
                move.b  #$06, Obj_Subtype(A1)                            ; $0028
Offset_0x01C93C:
                bra.s   Offset_0x01C964
Offset_0x01C93E:
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_X(A0), Obj_Control_Var_06(A1)         ; $0008, $0032
                move.w  Obj_Y(A0), Obj_Control_Var_04(A1)         ; $000C, $0030
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                rts
Offset_0x01C964:
                move.w  Obj_X(A0), Obj_Control_Var_06(A0)         ; $0008, $0032
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
Offset_0x01C970:
                bsr     Jmp_15_To_ModifySpriteAttr_2P          ; Offset_0x01CAFA
                move.b  Obj_Subtype(A0), Obj_Control_Var_0C(A0)   ; $0028, $0038
                bra     Offset_0x01CA42   
;-------------------------------------------------------------------------------  
Offset_0x01C97E:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                bne.s   Offset_0x01C9CE
                move.b  Obj_Control_Var_10(A0), D1                       ; $003C
                move.b  Obj_Status(A0), D0                               ; $0022
                btst    #$03, D0
                bne.s   Offset_0x01C9AA
                btst    #$03, D1
                beq.s   Offset_0x01C9AE
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                move.b  #$00, Obj_Control_Var_10(A0)                     ; $003C
                bra.s   Offset_0x01C9DE
Offset_0x01C9AA:
                move.b  D0, Obj_Control_Var_10(A0)                       ; $003C
Offset_0x01C9AE:
                btst    #$04, D0
                bne.s   Offset_0x01C9C8
                btst    #$04, D1
                beq.s   Offset_0x01C9DE
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                move.b  #$00, Obj_Control_Var_10(A0)                     ; $003C
                bra.s   Offset_0x01C9DE
Offset_0x01C9C8:
                move.b  D0, Obj_Control_Var_10(A0)                       ; $003C
                bra.s   Offset_0x01C9DE
Offset_0x01C9CE:
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                subq.w  #$01, Obj_Control_Var_08(A0)                     ; $0034
                bne.s   Offset_0x01C9DE
                bsr     Offset_0x01CA42
Offset_0x01C9DE:
                move.w  (A7)+, D4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01C9FE
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_0A_To_SolidObject                  ; Offset_0x01CB00
Offset_0x01C9FE:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                bra     Jmp_02_To_MarkObjGone_2                ; Offset_0x01CB06 
;-------------------------------------------------------------------------------  
Offset_0x01CA06:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                jsr     (SpeedToPos)                           ; Offset_0x00D1DA
                subq.w  #$01, Obj_Control_Var_08(A0)                     ; $0034
                bne.s   Offset_0x01CA1A
                bsr     Offset_0x01CA42
Offset_0x01CA1A:
                move.w  (A7)+, D4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01CA3A
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_0A_To_SolidObject                  ; Offset_0x01CB00
Offset_0x01CA3A:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                bra     Jmp_02_To_MarkObjGone_2                ; Offset_0x01CB06
Offset_0x01CA42:
                moveq   #$00, D0
                move.b  Obj_Control_Var_0C(A0), D0                       ; $0038
                move.l  Obj_Control_Var_00(A0), A1                       ; $002C
                lea     $00(A1, D0), A1
                move.w  (A1)+, Obj_Speed(A0)                             ; $0010
                move.w  (A1)+, Obj_Speed_Y(A0)                           ; $0012
                move.w  (A1)+, Obj_Control_Var_08(A0)                    ; $0034
                move.w  #$0007, Obj_Control_Var_0E(A0)                   ; $003A
                move.b  #$00, Obj_Control_Var_0A(A0)                     ; $0036
                addq.b  #$06, Obj_Control_Var_0C(A0)                     ; $0038
                cmpi.b  #$18, Obj_Control_Var_0C(A0)                     ; $0038
                bcs.s   Offset_0x01CA7A
                move.b  #$00, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01CA7A:
                rts      
;-------------------------------------------------------------------------------
Offset_0x01CA7C:
                dc.w    $0000, $0400, $0010, $0400, $FE00, $0020, $0000, $0400
                dc.w    $0010, $FC00, $FE00, $0020          
;-------------------------------------------------------------------------------  
Offset_0x01CA94:
                dc.w    $0000, $0100, $0040, $FF00, $0000, $0080, $0000, $FF00
                dc.w    $0040, $0100, $0000, $0080, $0100, $0000, $0040
;-------------------------------------------------------------------------------
Offset_0x01CAB2:
                dc.w    $0000, $0100, $0040, $0100, $0000, $0080, $0000, $FF00
                dc.w    $0040, $FF00, $0000, $0080, $FF00, $0000, $0040  
;-------------------------------------------------------------------------------    
Rotating_Boxes_Mappings:                                       ; Offset_0x01CAD0
                dc.w    Offset_0x01CAD2-Rotating_Boxes_Mappings
Offset_0x01CAD2:
                dc.w    $0004
                dc.l    $E00F0000, $0000FFE0
                dc.l    $E00F0010, $00080000
                dc.l    $000F1810, $1808FFE0
                dc.l    $000F1800, $18000000 
;===============================================================================
; Objeto 0x6A - Três caixas rodando na Dust Hill / Plataformas na Metropolis
; <<<- 
;===============================================================================