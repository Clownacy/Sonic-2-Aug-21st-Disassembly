;===============================================================================
; Objeto 0x7A - Plataformas com movimentos horizontais na Chemical Plant,
; ->>>          Dust Hill
;===============================================================================
; Offset_0x01E47C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01E48A(PC, D0), D1
                jmp     Offset_0x01E48A(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01E48A:
                dc.w    Offset_0x01E4A8-Offset_0x01E48A
                dc.w    Offset_0x01E56A-Offset_0x01E48A
                dc.w    Offset_0x01E5C6-Offset_0x01E48A          
;-------------------------------------------------------------------------------
Offset_0x01E490:
                dc.b    $00, $68, $FF, $98, $00, $00, $01, $A8
                dc.b    $FF, $50, $00, $40, $01, $E8, $FF, $80
                dc.b    $00, $80, $00, $68, $00, $67, $00, $00    
;-------------------------------------------------------------------------------
Offset_0x01E4A8:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Platform_Horizontal_Mappings, Obj_Map(A0) ; Offset_0x01E640, $0004
                move.w  #$E418, Obj_Art_VRAM(A0)                         ; $0002
                cmpi.b  #$0B, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x01E4D0
                move.l  #DHz_Swing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x008FF0, $0004
                move.w  #$0000, Obj_Art_VRAM(A0)                         ; $0002
Offset_0x01E4D0:
                bsr     Jmp_1E_To_ModifySpriteAttr_2P          ; Offset_0x01E660
                moveq   #$00, D1
                move.b  Obj_Subtype(A0), D1                              ; $0028
                lea     Offset_0x01E490(PC, D1), A2
                move.b  (A2)+, D1
                move.l  A0, A1
                bra.s   Offset_0x01E502      
;-------------------------------------------------------------------------------
Offset_0x01E4E4:
                bsr     Jmp_0E_To_SingleObjectLoad_2           ; Offset_0x01E65A
                bne.s   Offset_0x01E526
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C   
;-------------------------------------------------------------------------------
Offset_0x01E502:
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$18, Obj_Width(A1)                              ; $0019
                move.w  Obj_X(A1), Obj_Control_Var_04(A1)         ; $0008, $0030
Offset_0x01E526:
                dbra    D1, Offset_0x01E4E4
                move.l  A0, Obj_Control_Var_10(A1)                       ; $003C
                move.l  A1, Obj_Control_Var_10(A0)                       ; $003C
                cmpi.b  #$0C, Obj_Subtype(A0)                            ; $0028
                bne.s   Offset_0x01E540
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
Offset_0x01E540:
                moveq   #$00, D1
                move.b  (A2)+, D1
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                sub.w   D1, D0
                move.w  D0, Obj_Control_Var_06(A0)                       ; $0032
                move.w  D0, Obj_Control_Var_06(A1)                       ; $0032
                add.w   D1, D0
                add.w   D1, D0
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034
                move.w  D0, Obj_Control_Var_08(A1)                       ; $0034
                move.w  (A2)+, D0
                add.w   D0, Obj_X(A0)                                    ; $0008
                move.w  (A2)+, D0
                add.w   D0, Obj_X(A1)                                    ; $0008      
;-------------------------------------------------------------------------------
Offset_0x01E56A:
                bsr.s   Offset_0x01E5D0
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x01E576
                bra     Jmp_0F_To_DisplaySprite                ; Offset_0x01E654
Offset_0x01E576:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bls.s   Offset_0x01E59A
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x01E5A0
Offset_0x01E59A:
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01E5A0:
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                cmpa.l  A0, A1
                beq.s   Offset_0x01E5AE
                jsr     (DeleteObject_A1)                      ; Offset_0x00D316
Offset_0x01E5AE:
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x01E5C0
                bclr    #$07, $02(A2, D0)
Offset_0x01E5C0:
                jmp     (DeleteObject)                         ; Offset_0x00D314 
;-------------------------------------------------------------------------------
Offset_0x01E5C6:
                bsr.s   Offset_0x01E5D0
                bsr.s   Offset_0x01E61A
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01E5D0:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                tst.b   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01E5F2
                move.w  Obj_X(A0), D0                                    ; $0008
                subq.w  #$01, D0
                cmp.w   Obj_Control_Var_06(A0), D0                       ; $0032
                bne.s   Offset_0x01E5EC
                move.b  #$00, Obj_Control_Var_0A(A0)                     ; $0036
Offset_0x01E5EC:
                move.w  D0, Obj_X(A0)                                    ; $0008
                bra.s   Offset_0x01E608
Offset_0x01E5F2:
                move.w  Obj_X(A0), D0                                    ; $0008
                addq.w  #$01, D0
                cmp.w   Obj_Control_Var_08(A0), D0                       ; $0034
                bne.s   Offset_0x01E604
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
Offset_0x01E604:
                move.w  D0, Obj_X(A0)                                    ; $0008
Offset_0x01E608:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                move.w  #$0008, D3
                move.w  (A7)+, D4
                bsr     Jmp_01_To_Platform_Object              ; Offset_0x01E666
                rts
Offset_0x01E61A:
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                move.w  Obj_X(A0), D0                                    ; $0008
                subi.w  #$0018, D0
                move.w  Obj_X(A1), D2                                    ; $0008
                addi.w  #$0018, D2
                cmp.w   D0, D2
                bne.s   Offset_0x01E63E
                eori.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                eori.b  #$01, Obj_Control_Var_0A(A1)                     ; $0036
Offset_0x01E63E:
                rts             
;-------------------------------------------------------------------------------
Platform_Horizontal_Mappings:                                  ; Offset_0x01E640
                dc.w    Offset_0x01E642-Platform_Horizontal_Mappings
Offset_0x01E642:
                dc.w    $0002
                dc.l    $F8090010, $0008FFE8
                dc.l    $F8090810, $08080000 
;===============================================================================
; Objeto 0x7A - Plataformas com movimentos horizontais na Chemical Plant,
; <<<-          Dust Hill
;===============================================================================