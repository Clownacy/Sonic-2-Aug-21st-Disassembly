;===============================================================================
; Objeto 0x80 - Corrente com gancho na Sky Fortress.
; ->>>          Raízes que pode se pendurar na Dust Hill.
;===============================================================================
; Offset_0x01EA30:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01EA3E(PC, D0), D1
                jmp     Offset_0x01EA3E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01EA3E:
                dc.w    Offset_0x01EA42-Offset_0x01EA3E
                dc.w    Offset_0x01EAAC-Offset_0x01EA3E        
;-------------------------------------------------------------------------------  
Offset_0x01EA42:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Vines_Mappings, Obj_Map(A0)    ; Offset_0x01EC14, $0004
                move.w  #$641E, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_21_To_ModifySpriteAttr_2P          ; Offset_0x01ED86
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$80, Obj_Height_2(A0)                           ; $0016
                bset    #$04, Obj_Flags(A0)                              ; $0001
                move.w  Obj_Y(A0), Obj_Control_Var_10(A0)         ; $000C, $003C
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x01EA88
                move.b  #$01, Obj_Control_Var_08(A0)                     ; $0034
Offset_0x01EA88:
                move.w  #$0002, Obj_Control_Var_0E(A0)                   ; $003A
                andi.b  #$70, D0
                beq.s   Offset_0x01EAAC
                move.w  #$00B0, Obj_Control_Var_0C(A0)                   ; $0038
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                addi.w  #$00B0, Obj_Y(A0)                                ; $000C
                move.b  #$06, Obj_Map_Id(A0)                             ; $001A 
;------------------------------------------------------------------------------- 
Offset_0x01EAAC:
                tst.b   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01EABA
                tst.w   Obj_Control_Var_04(A0)                           ; $0030
                bne.s   Offset_0x01EAD0
                bra.s   Offset_0x01EAC0
Offset_0x01EABA:
                tst.w   Obj_Control_Var_04(A0)                           ; $0030
                beq.s   Offset_0x01EAD0
Offset_0x01EAC0:
                move.w  Obj_Control_Var_0C(A0), D2                       ; $0038
                cmpi.w  #$00B0, D2
                beq.s   Offset_0x01EAF4
                add.w   Obj_Control_Var_0E(A0), D2                       ; $003A
                bra.s   Offset_0x01EADA
Offset_0x01EAD0:
                move.w  Obj_Control_Var_0C(A0), D2                       ; $0038
                beq.s   Offset_0x01EAF4
                sub.w   Obj_Control_Var_0E(A0), D2                       ; $003A
Offset_0x01EADA:
                move.w  D2, Obj_Control_Var_0C(A0)                       ; $0038
                move.w  Obj_Control_Var_10(A0), D0                       ; $003C
                add.w   D2, D0
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.w  D2, D0
                beq.s   Offset_0x01EAF0
                lsr.w   #$05, D0
                addq.w  #$01, D0
Offset_0x01EAF0:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
Offset_0x01EAF4:
                lea     Obj_Control_Var_04(A0), A2                       ; $0030
                lea     (Player_One).w, A1                           ; $FFFFB000
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                bsr.s   Offset_0x01EB12
                lea     (Player_Two).w, A1                           ; $FFFFB040
                addq.w  #$01, A2
                move.w  ($FFFFF606).w, D0
                bsr.s   Offset_0x01EB12
                bra     Jmp_16_To_MarkObjGone                  ; Offset_0x01ED80
Offset_0x01EB12:
                tst.b   (A2)
                beq.s   Offset_0x01EB8A
                andi.b  #$70, D0
                beq     Offset_0x01EB7A
                clr.b   Obj_Timer(A1)                                    ; $002A
                clr.b   (A2)
                move.b  #$12, $0002(A2) 
                andi.w  #$0F00, D0
                beq     Offset_0x01EB38
                move.b  #$3C, $0002(A2) 
Offset_0x01EB38:
                btst    #$0A, D0
                beq.s   Offset_0x01EB44
                move.w  #$FE00, Obj_Speed(A1)                            ; $0010
Offset_0x01EB44:
                btst    #$0B, D0
                beq.s   Offset_0x01EB50
                move.w  #$0200, Obj_Speed(A1)                            ; $0010
Offset_0x01EB50:
                move.w  #$FC80, Obj_Speed_Y(A1)                          ; $0012
                bset    #$01, Obj_Status(A1)                             ; $0022
                tst.b   Obj_Control_Var_08(A0)                           ; $0034
                beq.s   Offset_0x01EB76
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lea     ($FFFFF7E0).w, A3
                lea     $00(A3, D0), A3
                bclr    #$00, (A3)
Offset_0x01EB76:
                bra     Offset_0x01EC12
Offset_0x01EB7A:
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0094, Obj_Y(A1)                                ; $000C
                bra     Offset_0x01EC12
Offset_0x01EB8A:
                tst.b   $0002(A2) 
                beq.s   Offset_0x01EB98
                subq.b  #$01, $0002(A2) 
                bne     Offset_0x01EC12
Offset_0x01EB98:
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc     Offset_0x01EC12
                move.w  Obj_Y(A1), D1                                    ; $000C
                sub.w   Obj_Y(A0), D1                                    ; $000C
                subi.w  #$0088, D1
                cmpi.w  #$0018, D1
                bcc     Offset_0x01EC12
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0024
                bcc.s   Offset_0x01EC12
                clr.w   Obj_Speed(A1)                                    ; $0010
                clr.w   Obj_Speed_Y(A1)                                  ; $0012
                clr.w   Obj_Inertia(A1)                                  ; $0014
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0094, Obj_Y(A1)                                ; $000C
                move.b  #$14, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_Timer(A1)                              ; $002A
                move.b  #$01, (A2)
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lea     ($FFFFF7E0).w, A3
                bset    #$00, $00(A3, D0)
                move.w  #$00CD, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x01EC12:
                rts     
;-------------------------------------------------------------------------------  
Vines_Mappings:                                                ; Offset_0x01EC14
                dc.w    Offset_0x01EC22-Vines_Mappings
                dc.w    Offset_0x01EC3C-Vines_Mappings
                dc.w    Offset_0x01EC5E-Vines_Mappings
                dc.w    Offset_0x01EC88-Vines_Mappings
                dc.w    Offset_0x01ECBA-Vines_Mappings
                dc.w    Offset_0x01ECF4-Vines_Mappings
                dc.w    Offset_0x01ED36-Vines_Mappings
Offset_0x01EC22:
                dc.w    $0003
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4
Offset_0x01EC3C:
                dc.w    $0004
                dc.l    $10030000, $0000FFFC
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4
Offset_0x01EC5E:
                dc.w    $0005
                dc.l    $F0030000, $0000FFFC
                dc.l    $10030000, $0000FFFC
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4
Offset_0x01EC88:
                dc.w    $0006
                dc.l    $D0030000, $0000FFFC
                dc.l    $F0030000, $0000FFFC
                dc.l    $10030000, $0000FFFC
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4
Offset_0x01ECBA:
                dc.w    $0007
                dc.l    $B0030000, $0000FFFC
                dc.l    $D0030000, $0000FFFC
                dc.l    $F0030000, $0000FFFC
                dc.l    $10030000, $0000FFFC
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4
Offset_0x01ECF4:
                dc.w    $0008
                dc.l    $90030000, $0000FFFC
                dc.l    $B0030000, $0000FFFC
                dc.l    $D0030000, $0000FFFC
                dc.l    $F0030000, $0000FFFC
                dc.l    $10030000, $0000FFFC
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4
Offset_0x01ED36:
                dc.w    $0009
                dc.l    $80010002, $0001FFFC
                dc.l    $90030000, $0000FFFC
                dc.l    $B0030000, $0000FFFC
                dc.l    $D0030000, $0000FFFC
                dc.l    $F0030000, $0000FFFC
                dc.l    $10030000, $0000FFFC
                dc.l    $30030000, $0000FFFC
                dc.l    $50030000, $0000FFFC
                dc.l    $70090004, $0002FFF4 
;===============================================================================
; Objeto 0x80 - Corrente com gancho na Sky Fortress.
; <<<-          Raízes que pode se pendurar na Dust Hill.
;===============================================================================