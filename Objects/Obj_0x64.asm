;===============================================================================
; Objeto 0x64 - Pistões gigantes na Metropolis.
; ->>>
;===============================================================================
; Offset_0x01B6D4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01B6E2(PC, D0), D1
                jmp     Offset_0x01B6E2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01B6E2:
                dc.w    Offset_0x01B6EE-Offset_0x01B6E2
                dc.w    Offset_0x01B756-Offset_0x01B6E2       
;-------------------------------------------------------------------------------
Offset_0x01B6E6:
                dc.b    $40, $0C, $40, $01, $10, $20, $40, $01 
;-------------------------------------------------------------------------------
Offset_0x01B6EE:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$02, D0
                andi.w  #$001C, D0
                lea     Offset_0x01B6E6(PC, D0), A3
                move.b  (A3)+, Obj_Width(A0)                             ; $0019
                move.b  (A3)+, Obj_Control_Var_02(A0)                    ; $002E
                lsr.w   #$02, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                bne.s   Offset_0x01B71E
                move.b  #$6C, Obj_Height_2(A0)                           ; $0016
                bset    #$04, Obj_Flags(A0)                              ; $0001
Offset_0x01B71E:
                move.l  #Pistons_Mappings, Obj_Map(A0)  ; Offset_0x01B810, $0004
                move.w  #$2000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_10_To_ModifySpriteAttr_2P          ; Offset_0x01B888
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                moveq   #$00, D0
                move.b  (A3)+, D0
                move.w  D0, Obj_Control_Var_10(A0)                       ; $003C
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028  
;-------------------------------------------------------------------------------
Offset_0x01B756:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, D0
                move.w  Offset_0x01B7A8(PC, D0), D1
                jsr     Offset_0x01B7A8(PC, D1)
                move.w  (A7)+, D4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01B78A
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Control_Var_02(A0), D2                       ; $002E
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_06_To_SolidObject                  ; Offset_0x01B88E
Offset_0x01B78A:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x01B7A2
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01B7A2:
                jmp     (DeleteObject)                         ; Offset_0x00D314
;------------------------------------------------------------------------------- 
Offset_0x01B7A8:
                dc.w    Offset_0x01B7AC-Offset_0x01B7A8
                dc.w    Offset_0x01B7AE-Offset_0x01B7A8                     
;-------------------------------------------------------------------------------
Offset_0x01B7AC:
                rts     
;-------------------------------------------------------------------------------
Offset_0x01B7AE:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01B7D2
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x01B7C0
                subq.w  #$08, Obj_Control_Var_0E(A0)                     ; $003A
                bra.s   Offset_0x01B7F2
Offset_0x01B7C0:
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bpl.s   Offset_0x01B7F2
                move.w  #$003C, Obj_Control_Var_0A(A0)                   ; $0036
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01B7D2:
                move.w  Obj_Control_Var_0E(A0), D0                       ; $003A
                cmp.w   Obj_Control_Var_10(A0), D0                       ; $003C
                beq.s   Offset_0x01B7E2
                addq.w  #$08, Obj_Control_Var_0E(A0)                     ; $003A
                bra.s   Offset_0x01B7F2
Offset_0x01B7E2:
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bpl.s   Offset_0x01B7F2
                move.w  #$003C, Obj_Control_Var_0A(A0)                   ; $0036
                clr.b   Obj_Control_Var_0C(A0)                           ; $0038
Offset_0x01B7F2:
                move.w  Obj_Control_Var_0E(A0), D0                       ; $003A
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01B804
                neg.w   D0
                addi.w  #$0040, D0
Offset_0x01B804:
                move.w  Obj_Control_Var_04(A0), D1                       ; $0030
                add.w   D0, D1
                move.w  D1, Obj_Y(A0)                                    ; $000C
                rts                      
;-------------------------------------------------------------------------------
Pistons_Mappings:                                              ; Offset_0x01B810
                dc.w    Offset_0x01B814-Pistons_Mappings
                dc.w    Offset_0x01B866-Pistons_Mappings
Offset_0x01B814:
                dc.w    $000A
                dc.l    $F40E0001, $0000FFC0
                dc.l    $F40E0801, $0800FFE0
                dc.l    $F40E0001, $00000000
                dc.l    $F40E0801, $08000020
                dc.l    $0C07000D, $0006FFD8
                dc.l    $2C07000D, $0006FFD8
                dc.l    $4C07000D, $0006FFD8
                dc.l    $0C07000D, $00060018
                dc.l    $2C07000D, $00060018
                dc.l    $4C07000D, $00060018
Offset_0x01B866:
                dc.w    $0004
                dc.l    $E0070057, $002BFFF0
                dc.l    $E0070857, $082B0000
                dc.l    $00071057, $102BFFF0
                dc.l    $00071857, $182B0000 
;===============================================================================
; Objeto 0x64 - Pistões gigantes na Metropolis.
; <<<-
;===============================================================================