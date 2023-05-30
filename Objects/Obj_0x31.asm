;===============================================================================
; Objeto 0x31 - Atributo invisível das lavas na Hill Top / Metropolis
; ->>>
;===============================================================================
; Offset_0x015EDC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x015EEA(PC, D0), D1
                jmp     Offset_0x015EEA(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x015EEA:
                dc.w    Offset_0x015EF2-Offset_0x015EEA
                dc.w    Offset_0x015F28-Offset_0x015EEA       
;-------------------------------------------------------------------------------   
Offset_0x015EEE:
                dc.b    $96, $94, $95, $00                                           
;-------------------------------------------------------------------------------
Offset_0x015EF2:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                move.b  Offset_0x015EEE(PC, D0), Obj_Col_Flags(A0)       ; $0020
                move.l  #Lava_Attributes_Mappings, Obj_Map(A0) ; Offset_0x015F4E, $0004
                move.w  #$8680, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$84, Obj_Flags(A0)                              ; $0001
                move.b  #$80, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $001A, $0028      
;-------------------------------------------------------------------------------
Offset_0x015F28:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne.s   Offset_0x015F42
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_02_To_DeleteObject                 ; Offset_0x016396
Offset_0x015F42:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Offset_0x015F4C
                bsr     Jmp_02_To_DisplaySprite                ; Offset_0x016390
Offset_0x015F4C:
                rts        
;-------------------------------------------------------------------------------
Lava_Attributes_Mappings:                                      ; Offset_0x015F4E
                dc.w    Offset_0x015F54-Lava_Attributes_Mappings
                dc.w    Offset_0x015F76-Lava_Attributes_Mappings
                dc.w    Offset_0x015F98-Lava_Attributes_Mappings
Offset_0x015F54:
                dc.w    $0004
                dc.l    $E0050034, $001AFFE0
                dc.l    $E0050034, $001A0010
                dc.l    $10050034, $001AFFE0
                dc.l    $10050034, $001A0010
Offset_0x015F76:
                dc.w    $0004
                dc.l    $E0050034, $001AFFC0
                dc.l    $E0050034, $001A0030
                dc.l    $10050034, $001AFFC0
                dc.l    $10050034, $001A0030
Offset_0x015F98:
                dc.w    $0004
                dc.l    $E0050034, $001AFF80
                dc.l    $E0050034, $001A0070
                dc.l    $10050034, $001AFF80
                dc.l    $10050034, $001A0070
;===============================================================================
; Objeto 0x31 - Atributo invisível das lavas na Hill Top / Metropolis
; <<<-
;===============================================================================