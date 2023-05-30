;===============================================================================
; Objeto 0x7B - Molas sobre os tubos na Chemical Plant
; ->>>
;===============================================================================
; Offset_0x01E66C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01E69C(PC, D0), D1
                jsr     Offset_0x01E69C(PC, D1)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x01E684
                bra     Jmp_10_To_DisplaySprite                ; Offset_0x01E884
Offset_0x01E684:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_11_To_DeleteObject                 ; Offset_0x01E88A
                bra     Jmp_10_To_DisplaySprite                ; Offset_0x01E884
;-------------------------------------------------------------------------------
Offset_0x01E69C:
                dc.w    Offset_0x01E6A4-Offset_0x01E69C
                dc.w    Offset_0x01E6DA-Offset_0x01E69C  
;-------------------------------------------------------------------------------
Offset_0x01E6A0:
                dc.w    $F000, $F600                    
;-------------------------------------------------------------------------------
Offset_0x01E6A4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Spring_Tubes_Mappings, Obj_Map(A0) ; Offset_0x01E840, $0004
                move.w  #$03E0, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$0002, D0
                move.w  Offset_0x01E6A0(PC, D0), Obj_Control_Var_04(A0)  ; $0030
                bsr     Jmp_1F_To_ModifySpriteAttr_2P          ; Offset_0x01E896               
;-------------------------------------------------------------------------------
Offset_0x01E6DA:
                cmpi.b  #$01, Obj_Map_Id(A0)                             ; $001A
                beq.s   Offset_0x01E722
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Jmp_03_To_SolidObject_2_A1             ; Offset_0x01E89C
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01E70A
                bsr.s   Offset_0x01E782
Offset_0x01E70A:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     Jmp_03_To_SolidObject_2_A1             ; Offset_0x01E89C
                btst    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01E722
                bsr.s   Offset_0x01E782
Offset_0x01E722:
                move.w  Obj_X(A0), D4                                    ; $0008
                move.w  D4, D5
                subi.w  #$0010, D4
                addi.w  #$0010, D5
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, D3
                addi.w  #$0030, D3
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                cmp.w   D4, D0
                bcs.s   Offset_0x01E758
                cmp.w   D5, D0
                bcc.s   Offset_0x01E758
                move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
                cmp.w   D2, D0
                bcs.s   Offset_0x01E758
                cmp.w   D3, D0
                bcc.s   Offset_0x01E758
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
Offset_0x01E758:
                move.w  (Player_Two_Position_X).w, D0                ; $FFFFB048
                cmp.w   D4, D0
                bcs.s   Offset_0x01E776
                cmp.w   D5, D0
                bcc.s   Offset_0x01E776
                move.w  (Player_Two_Position_Y).w, D0                ; $FFFFB04C
                cmp.w   D2, D0
                bcs.s   Offset_0x01E776
                cmp.w   D3, D0
                bcc.s   Offset_0x01E776
                move.b  #$03, Obj_Ani_Number(A0)                         ; $001C
Offset_0x01E776:
                lea     (Spring_Tube_Animate_Data), A1         ; Offset_0x01E828
                bra     Jmp_04_To_AnimateSprite                ; Offset_0x01E890
;-------------------------------------------------------------------------------
; Offset_0x01E780:
                rts    
;-------------------------------------------------------------------------------
Offset_0x01E782:
                move.w  #$0100, Obj_Ani_Number(A0)                       ; $001C
                addq.w  #$04, Obj_Y(A1)                                  ; $000C
                move.w  Obj_Control_Var_04(A0), Obj_Speed_Y(A1)   ; $0012, $0030
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$10, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x01E7B6
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
Offset_0x01E7B6:
                btst    #$00, D0
                beq.s   Offset_0x01E7F6
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$00, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$04, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x01E7E6
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x01E7E6:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01E7F6
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x01E7F6:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01E80C
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x01E80C:
                cmpi.b  #$08, D0
                bne.s   Offset_0x01E81E
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x01E81E:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512  
;-------------------------------------------------------------------------------
Spring_Tube_Animate_Data:                                      ; Offset_0x01E828
                dc.w    Offset_0x01E830-Spring_Tube_Animate_Data
                dc.w    Offset_0x01E833-Spring_Tube_Animate_Data
                dc.w    Offset_0x01E837-Spring_Tube_Animate_Data
                dc.w    Offset_0x01E837-Spring_Tube_Animate_Data
Offset_0x01E830:
                dc.b    $0F, $00, $FF
Offset_0x01E833:
                dc.b    $00, $03, $FD, $00
Offset_0x01E837:
                dc.b    $05, $01, $02, $02, $02, $04, $FD, $00
                dc.b    $00                               
;-------------------------------------------------------------------------------
Spring_Tubes_Mappings:                                         ; Offset_0x01E840
                dc.w    Offset_0x01E84A-Spring_Tubes_Mappings
                dc.w    Offset_0x01E854-Spring_Tubes_Mappings
                dc.w    Offset_0x01E866-Spring_Tubes_Mappings
                dc.w    Offset_0x01E878-Spring_Tubes_Mappings
                dc.w    Offset_0x01E854-Spring_Tubes_Mappings
Offset_0x01E84A:
                dc.w    $0001
                dc.l    $F00D0000, $0000FFF0
Offset_0x01E854:
                dc.w    $0002
                dc.l    $E0070008, $0004FFF0
                dc.l    $E0070808, $08040000
Offset_0x01E866:
                dc.w    $0002
                dc.l    $E0070010, $0008FFF0
                dc.l    $E0070810, $08080000
Offset_0x01E878:
                dc.w    $0001
                dc.l    $F00D0018, $000CFFF0 
;===============================================================================
; Objeto 0x7B - Molas sobre os tubos na Chemical Plant
; <<<-
;===============================================================================