;===============================================================================
; Objeto 0x1B - Propulsor automático na Chemical Plant
; ->>> 
;===============================================================================  
; Offset_0x017114:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x017122(PC, D0), D1
                jmp     Offset_0x017122(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x017122:
                dc.w    Offset_0x01712A-Offset_0x017122
                dc.w    Offset_0x017160-Offset_0x017122
;-------------------------------------------------------------------------------                
Offset_0x017126:
                dc.w    $1000, $0A00
;-------------------------------------------------------------------------------
Offset_0x01712A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #CPz_Speed_Booster_Mappings, Obj_Map(A0) ; Offset_0x017244, $0004
                move.w  #$E39C, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_04_To_ModifySpriteAttr_2P          ; Offset_0x017266
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$0002, D0
                move.w  Offset_0x017126(PC, D0), Obj_Control_Var_04(A0)  ; $0030 
;-------------------------------------------------------------------------------
Offset_0x017160:
                move.b  ($FFFFFE05).w, D0
                andi.b  #$02, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  D0, D1
                subi.w  #$0010, D0
                addi.w  #$0010, D1
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, D3
                subi.w  #$0010, D2
                addi.w  #$0010, D3
                lea     (Player_One).w, A1                           ; $FFFFB000
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x0171BC
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   D0, D4
                bcs     Offset_0x0171BC
                cmp.w   D1, D4
                bcc     Offset_0x0171BC
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   D2, D4
                bcs     Offset_0x0171BC
                cmp.w   D3, D4
                bcc     Offset_0x0171BC
                move.w  D0, -(A7)
                bsr     Offset_0x0171F0
                move.w  (A7)+, D0
Offset_0x0171BC:
                lea     (Player_Two).w, A1                           ; $FFFFB040
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x0171EC
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   D0, D4
                bcs     Offset_0x0171EC
                cmp.w   D1, D4
                bcc     Offset_0x0171EC
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   D2, D4
                bcs     Offset_0x0171EC
                cmp.w   D3, D4
                bcc     Offset_0x0171EC
                bsr     Offset_0x0171F0
Offset_0x0171EC:
                bra     Jmp_03_To_MarkObjGone                  ; Offset_0x017260
Offset_0x0171F0:
                move.w  Obj_Speed(A1), D0                                ; $0010
                bpl.s   Offset_0x0171F8
                neg.w   D0
Offset_0x0171F8:
                cmpi.w  #$1000, D0
                bcc.s   Offset_0x01723A
                move.w  Obj_Control_Var_04(A0), Obj_Speed(A1)     ; $0010, $0030
                bclr    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01721C
                bset    #$00, Obj_Status(A1)                             ; $0022
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x01721C:
                move.w  #$000F, Obj_Control_Var_02(A1)                   ; $002E
                move.w  Obj_Speed(A1), Obj_Inertia(A1)            ; $0010, $0014
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$06, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
Offset_0x01723A:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512   
;-------------------------------------------------------------------------------
CPz_Speed_Booster_Mappings:                                    ; Offset_0x017244
                dc.w    Offset_0x01724A-CPz_Speed_Booster_Mappings
                dc.w    Offset_0x01724A-CPz_Speed_Booster_Mappings
                dc.w    Offset_0x01725C-CPz_Speed_Booster_Mappings
Offset_0x01724A:
                dc.w    $0002
                dc.l    $F8050000, $0000FFE8
                dc.l    $F8050000, $00000008
Offset_0x01725C:
                dc.w    $0000 
;===============================================================================
; Objeto 0x1B - Propulsor automático na Chemical Plant
; <<<- 
;===============================================================================