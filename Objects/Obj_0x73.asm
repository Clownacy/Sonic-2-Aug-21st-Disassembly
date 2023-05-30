;===============================================================================
; Objeto 0x73 - Anéis girando, Sonic consegue andar em cima
; ->>>
;===============================================================================   
; Offset_0x01DAB0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01DABE(PC, D0), D1
                jmp     Offset_0x01DABE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01DABE:
                dc.w    Offset_0x01DAC4-Offset_0x01DABE
                dc.w    Offset_0x01DBB2-Offset_0x01DABE
                dc.w    Offset_0x01DC5A-Offset_0x01DABE         
;-------------------------------------------------------------------------------
Offset_0x01DAC4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Rotating_Rings_Mappings, Obj_Map(A0) ; Offset_0x01DC78, $0004
                move.w  #$26BC, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_1A_To_ModifySpriteAttr_2P          ; Offset_0x01DC96
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.w  Obj_X(A0), Obj_Control_Var_0E(A0)         ; $0008, $003A
                move.w  Obj_Y(A0), Obj_Control_Var_0C(A0)         ; $000C, $0038
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                bset    #$07, Obj_Status(A0)                             ; $0022
                move.b  Obj_Subtype(A0), D1                              ; $0028
                andi.b  #$F0, D1
                ext.w   D1
                asl.w   #$03, D1
                move.w  D1, Obj_Control_Var_12(A0)                       ; $003E
                move.b  Obj_Status(A0), D0                               ; $0022
                ror.b   #$02, D0
                andi.b  #$C0, D0
                move.b  D0, Obj_Angle(A0)                                ; $0026
                lea     Obj_Player_Flip_Flag(A0), A2                     ; $0029
                move.b  Obj_Subtype(A0), D1                              ; $0028
                andi.w  #$0007, D1
                move.b  #$00, (A2)+
                move.w  D1, D3
                lsl.w   #$04, D3
                move.b  D3, Obj_Control_Var_10(A0)                       ; $003C
                subq.w  #$01, D1
                bcs.s   Offset_0x01DBA4
                btst    #$03, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x01DB4A
                subq.w  #$01, D1
                bcs.s   Offset_0x01DBA4
Offset_0x01DB4A:
                bsr     Jmp_06_To_SingleObjectLoad             ; Offset_0x01DC8A
                bne.s   Offset_0x01DBA4
                addq.b  #$01, Obj_Player_Flip_Flag(A0)                   ; $0029
                move.w  A1, D5
                subi.w  #$B000, D5
                lsr.w   #$06, D5
                andi.w  #$007F, D5
                move.b  D5, (A2)+
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  Obj_Priority(A0), Obj_Priority(A1)        ; $0018, $0018
                move.b  Obj_Width(A0), Obj_Width(A1)              ; $0019, $0019
                move.b  Obj_Col_Flags(A0), Obj_Col_Flags(A1)      ; $0020, $0020
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                subi.b  #$10, D3
                move.b  D3, Obj_Control_Var_10(A1)                       ; $003C
                dbra    D1, Offset_0x01DB4A
Offset_0x01DBA4:
                move.w  A0, D5
                subi.w  #$B000, D5
                lsr.w   #$06, D5
                andi.w  #$007F, D5
                move.b  D5, (A2)+
Offset_0x01DBB2:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x01DBD0
                move.w  #$0008, D1
                move.w  #$0008, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  (A7)+, D4
                bsr     Jmp_0E_To_SolidObject                  ; Offset_0x01DC9C
                bra     Offset_0x01DC22
Offset_0x01DBD0:
                move.w  Obj_Control_Var_12(A0), D0                       ; $003E
                add.w   D0, Obj_Angle(A0)                                ; $0026
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                move.w  Obj_Control_Var_0C(A0), D2                       ; $0038
                move.w  Obj_Control_Var_0E(A0), D3                       ; $003A
                lea     Obj_Player_Flip_Flag(A0), A2                     ; $0029
                moveq   #$00, D6
                move.b  (A2)+, D6
Offset_0x01DBF2:
                moveq   #$00, D4
                move.b  (A2)+, D4
                lsl.w   #$06, D4
                addi.l  #$FFFFB000, D4
                move.l  D4, A1
                moveq   #$00, D4
                move.b  Obj_Control_Var_10(A1), D4                       ; $003C
                move.l  D4, D5
                muls.w  D0, D4
                asr.l   #$08, D4
                muls.w  D1, D5
                asr.l   #$08, D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D4, Obj_Y(A1)                                    ; $000C
                move.w  D5, Obj_X(A1)                                    ; $0008
                dbra    D6, Offset_0x01DBF2
                rts
Offset_0x01DC22:
                move.w  Obj_Control_Var_0E(A0), D0                       ; $003A
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Offset_0x01DC3A
                bra     Jmp_0D_To_DisplaySprite                ; Offset_0x01DC84
Offset_0x01DC3A:
                moveq   #$00, D2
                lea     Obj_Player_Flip_Flag(A0), A2                     ; $0029
                move.b  (A2)+, D2
Offset_0x01DC42:
                moveq   #$00, D0
                move.b  (A2)+, D0
                lsl.w   #$06, D0
                addi.l  #Obj_Memory_Address, D0                      ; $FFFFB000
                move.l  D0, A1
                bsr     Jmp_00_To_DeleteObject_A1              ; Offset_0x01DC90
                dbra    D2, Offset_0x01DC42
                rts
Offset_0x01DC5A:
                move.w  #$0008, D1
                move.w  #$0008, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_Control_Var_0A(A0), D4                       ; $0036
                bsr     Jmp_0E_To_SolidObject                  ; Offset_0x01DC9C
                move.w  Obj_X(A0), Obj_Control_Var_0A(A0)         ; $0008, $0036
                bra     Jmp_0D_To_DisplaySprite                ; Offset_0x01DC84
;-------------------------------------------------------------------------------   
Rotating_Rings_Mappings:                                       ; Offset_0x01DC78
                dc.w    Offset_0x01DC7A-Rotating_Rings_Mappings
Offset_0x01DC7A:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8        
;===============================================================================
; Objeto 0x73 - Anéis girando, Sonic consegue andar em cima
; <<<-
;===============================================================================