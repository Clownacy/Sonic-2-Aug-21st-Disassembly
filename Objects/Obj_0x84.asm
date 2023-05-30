;===============================================================================
; Objeto 0x84 - Auto Spin - Hill Top, Hidden Palace, Casino Night
; ->>>
;===============================================================================
; Offset_0x016248:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x016256(PC, D0), D1
                jmp     Offset_0x016256(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x016256:
                dc.w    Offset_0x01625E-Offset_0x016256
                dc.w    Offset_0x016294-Offset_0x016256
;-------------------------------------------------------------------------------
Offset_0x01625A:
                dc.b    $C6, $94, $95, $00      
;-------------------------------------------------------------------------------
Offset_0x01625E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.b  Offset_0x01625A(PC, D0), Obj_Col_Flags(A0)       ; $0020
                move.l  #Auto_Spin_Attributes_Mappings, Obj_Map(A0) ; Offset_0x016324, $0004
                move.w  #$8680, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$84, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$07, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $001A, $0028
Offset_0x016294:
                move.b  Obj_Col_Prop(A0), D0                             ; $0021
                beq     Offset_0x0162FE
                lea     (Player_One).w, A1                           ; $FFFFB000
                bclr    #$00, Obj_Col_Prop(A0)                           ; $0021
                beq.s   Offset_0x0162AA
                bsr.s   Offset_0x0162C0
Offset_0x0162AA:
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bclr    #$01, Obj_Col_Prop(A0)                           ; $0021
                beq.s   Offset_0x0162B8
                bsr.s   Offset_0x0162C0
Offset_0x0162B8:
                clr.b   Obj_Col_Prop(A0)                                 ; $0021
                bra     Offset_0x0162FE
Offset_0x0162C0:
                btst    #$02, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x0162CA
                rts
Offset_0x0162CA:
                bset    #$02, Obj_Status(A1)                             ; $0022
                move.b  #$0E, Obj_Height_2(A1)                           ; $0016
                move.b  #$07, Obj_Width_2(A1)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                addq.w  #$05, Obj_Y(A1)                                  ; $000C
                move.w  #$00BE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                tst.w   Obj_Inertia(A1)                                  ; $0014
                bne.s   Offset_0x0162FC
                move.w  #$0200, Obj_Inertia(A1)                          ; $0014
Offset_0x0162FC:
                rts
Offset_0x0162FE:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x016318
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_02_To_DeleteObject                 ; Offset_0x016396
Offset_0x016318:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Offset_0x016322
                bsr     Jmp_02_To_DisplaySprite                ; Offset_0x016390
Offset_0x016322:
                rts     
;-------------------------------------------------------------------------------
Auto_Spin_Attributes_Mappings:                                 ; Offset_0x016324
                dc.w    Offset_0x01632A-Auto_Spin_Attributes_Mappings
                dc.w    Offset_0x01634C-Auto_Spin_Attributes_Mappings
                dc.w    Offset_0x01636E-Auto_Spin_Attributes_Mappings
Offset_0x01632A:
                dc.w    $0004
                dc.l    $F0050038, $001CFFF0
                dc.l    $F0050038, $001C0000
                dc.l    $00050038, $001CFFF0
                dc.l    $00050038, $001C0000
Offset_0x01634C:
                dc.w    $0004
                dc.l    $E0050038, $001CFFC0
                dc.l    $E0050038, $001C0030
                dc.l    $10050038, $001CFFC0
                dc.l    $10050038, $001C0030
Offset_0x01636E:
                dc.w    $0004
                dc.l    $E0050038, $001CFF80
                dc.l    $E0050038, $001C0070
                dc.l    $10050038, $001CFF80
                dc.l    $10050038, $001C0070                    
;===============================================================================
; Objeto 0x84 - Auto Spin - Hill Top, Hidden Palace, Casino Night
; <<<-
;===============================================================================