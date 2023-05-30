;===============================================================================
; Objeto 0x81 - Ponte que abre ao puxar as raizes na Dust Hill
; ->>>
;===============================================================================
; Offset_0x01ED8C:
                btst    #$06, Obj_Flags(A0)                              ; $0001
                bne     Offset_0x01EDA4
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01EDAC(PC, D0), D1
                jmp     Offset_0x01EDAC(PC, D1)
Offset_0x01EDA4:
                move.w  #$0280, D0
                bra     Jmp_01_To_DisplaySprite_Param          ; Offset_0x01EFE8
;-------------------------------------------------------------------------------
Offset_0x01EDAC:
                dc.w    Offset_0x01EDB2-Offset_0x01EDAC
                dc.w    Offset_0x01EE8A-Offset_0x01EDAC
                dc.w    Offset_0x01EF12-Offset_0x01EDAC              
;-------------------------------------------------------------------------------
Offset_0x01EDB2:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Vertical_Bridge_Mappings, Obj_Map(A0) ; Offset_0x01EFD6, $0004
                move.w  #$643C, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_22_To_ModifySpriteAttr_2P          ; Offset_0x01F006
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$05, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                ori.b   #$80, Obj_Status(A0)                             ; $0022
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                subi.w  #$0048, Obj_Y(A0)                                ; $000C
                move.b  #$C0, Obj_Angle(A0)                              ; $0026
                moveq   #-$10, D4
                btst    #$01, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01EE10
                addi.w  #$0090, Obj_Y(A0)                                ; $000C
                move.b  #$40, Obj_Angle(A0)                              ; $0026
                neg.w   D4
Offset_0x01EE10:
                move.w  #$0100, D1
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01EE1E
                neg.w   D1
Offset_0x01EE1E:
                move.w  D1, Obj_Control_Var_08(A0)                       ; $0034
                bsr     Jmp_0F_To_SingleObjectLoad_2           ; Offset_0x01F000
                bne.s   Offset_0x01EE8A
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                bset    #$06, Obj_Flags(A1)                              ; $0001
                move.b  #$40, $000E(A1)
                move.w  Obj_Control_Var_04(A0), D2                       ; $0030
                move.w  Obj_Control_Var_06(A0), D3                       ; $0032
                moveq   #$08, D1
                move.b  D1, Obj_Ani_Boss_Cnt(A1)                         ; $000F
                subq.w  #$01, D1
                lea     Obj_Speed(A1), A2                                ; $0010
Offset_0x01EE60:
                add.w   D4, D3
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  #$0001, (A2)+
                dbra    D1, Offset_0x01EE60
                move.w  Obj_Subtype(A1), Obj_X(A1)                ; $0008, $0028
                move.w  Obj_Timer(A1), Obj_Y(A1)                  ; $000C, $002A
                move.l  A1, Obj_Control_Var_10(A0)                       ; $003C
                move.b  #$40, Obj_Inertia(A1)                            ; $0014
                bset    #$04, Obj_Flags(A1)                              ; $0001    
;-------------------------------------------------------------------------------
Offset_0x01EE8A:
                lea     ($FFFFF7E0).w, A2
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                btst    #$00, $00(A2, D0)
                beq.s   Offset_0x01EEC2
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x01EEC2
                move.w  #$00E7, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                cmpi.b  #$81, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01EEC2
                move.w  Obj_Control_Var_04(A0), Obj_X(A0)         ; $0008, $0030
                subi.w  #$0048, Obj_X(A0)                                ; $0008
Offset_0x01EEC2:
                tst.b   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01EF10
                move.w  #$0048, D1
                tst.b   Obj_Angle(A0)                                    ; $0026
                beq.s   Offset_0x01EEDC
                cmpi.b  #$80, Obj_Angle(A0)                              ; $0026
                bne.s   Offset_0x01EF08
                neg.w   D1
Offset_0x01EEDC:
                move.w  Obj_Control_Var_06(A0), Obj_Y(A0)         ; $000C, $0032
                move.w  Obj_Control_Var_04(A0), Obj_X(A0)         ; $0008, $0030
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.b  #$40, Obj_Width(A0)                              ; $0019
                move.b  #$00, Obj_Control_Var_0A(A0)                     ; $0036
                move.w  #$00E9, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bra.s   Offset_0x01EF10
Offset_0x01EF08:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                add.w   D0, Obj_Angle(A0)                                ; $0026
Offset_0x01EF10:
                bsr.s   Offset_0x01EF72         
;-------------------------------------------------------------------------------
Offset_0x01EF12:
                move.w  #$0013, D1
                move.w  #$0040, D2
                move.w  #$0041, D3
                move.b  Obj_Angle(A0), D0                                ; $0026
                beq.s   Offset_0x01EF30
                cmpi.b  #$40, D0
                beq.s   Offset_0x01EF3C
                cmpi.b  #$C0, D0
                bcc.s   Offset_0x01EF3C
Offset_0x01EF30:
                move.w  #$004B, D1
                move.w  #$0008, D2
                move.w  #$0009, D3
Offset_0x01EF3C:
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_13_To_SolidObject                  ; Offset_0x01F012
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x01EF4E
                bra     Jmp_11_To_DisplaySprite                ; Offset_0x01EFEE
Offset_0x01EF4E:
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Offset_0x01EF66
                bra     Jmp_11_To_DisplaySprite                ; Offset_0x01EFEE
Offset_0x01EF66:
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                bsr     Jmp_02_To_DeleteObject_A1              ; Offset_0x01EFFA
                bra     Jmp_12_To_DeleteObject                 ; Offset_0x01EFF4
Offset_0x01EF72:
                tst.b   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01EFD4
                moveq   #$00, D0
                moveq   #$00, D1
                move.b  Obj_Angle(A0), D0                                ; $0026
                bsr     Jmp_04_To_CalcSine                     ; Offset_0x01F00C
                move.w  Obj_Control_Var_06(A0), D2                       ; $0032
                move.w  Obj_Control_Var_04(A0), D3                       ; $0030
                moveq   #$00, D6
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                move.b  Obj_Ani_Boss_Cnt(A1), D6                         ; $000F
                subq.w  #$01, D6
                bcs.s   Offset_0x01EFD4
                swap.w  D0
                swap.w  D1
                asr.l   #$04, D0
                asr.l   #$04, D1
                move.l  D0, D4
                move.l  D1, D5
                lea     Obj_Speed(A1), A2                                ; $0010
Offset_0x01EFAA:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                add.l   D0, D4
                add.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x01EFAA
                move.w  Obj_Subtype(A1), Obj_X(A1)                ; $0008, $0028
                move.w  Obj_Timer(A1), Obj_Y(A1)                  ; $000C, $002A
Offset_0x01EFD4:
                rts                       
;-------------------------------------------------------------------------------     
Vertical_Bridge_Mappings:                                      ; Offset_0x01EFD6
                dc.w    Offset_0x01EFDA-Vertical_Bridge_Mappings
                dc.w    Offset_0x01EFDC-Vertical_Bridge_Mappings
Offset_0x01EFDA:
                dc.w    $0000
Offset_0x01EFDC:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8 
;===============================================================================
; Objeto 0x81 - Ponte que abre ao puxar as raizes na Dust Hill
; <<<-
;===============================================================================