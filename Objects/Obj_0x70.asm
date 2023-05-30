;===============================================================================
; Objeto 0x70 - Engrenagens na Metropolis
; ->>>
;===============================================================================
; Offset_0x01D6AC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01D6BA(PC, D0), D1
                jmp     Offset_0x01D6BA(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01D6BA:
                dc.w    Offset_0x01D6BE-Offset_0x01D6BA
                dc.w    Offset_0x01D73E-Offset_0x01D6BA        
;-------------------------------------------------------------------------------
Offset_0x01D6BE:
                moveq   #$07, D1
                moveq   #$00, D4
                lea     (Offset_0x01D812), A2
                move.l  A0, A1
                move.w  Obj_X(A0), D2                                    ; $0008
                move.w  Obj_Y(A0), D3                                    ; $000C
                bset    #$07, Obj_Status(A0)                             ; $0022
                bra.s   Offset_0x01D6E0     
;-------------------------------------------------------------------------------   
Offset_0x01D6DA:
                bsr     Jmp_0B_To_SingleObjectLoad_2           ; Offset_0x01DA14
                bne.s   Offset_0x01D73A 
;-------------------------------------------------------------------------------   
Offset_0x01D6E0:
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                addq.b  #$02, Obj_Routine(A1)                            ; $0024
                move.l  #Rotating_Gears_Mappings, Obj_Map(A1) ; Offset_0x01D872, $0004
                move.w  #$6378, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_01_To_ModifySpriteAttr_2P_A1       ; Offset_0x01DA1A
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.w  D2, Obj_Control_Var_06(A1)                       ; $0032
                move.w  D3, Obj_Control_Var_04(A1)                       ; $0030
                move.b  (A2)+, D0
                ext.w   D0
                add.w   D2, D0
                move.w  D0, Obj_X(A1)                                    ; $0008
                move.b  (A2)+, D0
                ext.w   D0
                add.w   D3, D0
                move.w  D0, Obj_Y(A1)                                    ; $000C
                move.b  (A2)+, Obj_Map_Id(A1)                            ; $001A
                move.w  D4, Obj_Control_Var_08(A1)                       ; $0034
                addq.w  #$03, D4
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
Offset_0x01D73A:
                dbra    D1, Offset_0x01D6DA   
;-------------------------------------------------------------------------------   
Offset_0x01D73E:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                move.b  ($FFFFFE05).w, D0
                move.b  D0, D1
                andi.w  #$000F, D0
                bne.s   Offset_0x01D7B6
                move.w  Obj_Control_Var_0A(A0), D1                       ; $0036
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01D770
                subi.w  #$0018, D1
                bcc.s   Offset_0x01D78E
                moveq   #$48, D1
                subq.w  #$03, Obj_Control_Var_08(A0)                     ; $0034
                bcc.s   Offset_0x01D78E
                move.w  #$0015, Obj_Control_Var_08(A0)                   ; $0034
                bra.s   Offset_0x01D78E
Offset_0x01D770:
                addi.w  #$0018, D1
                cmpi.w  #$0060, D1
                bcs.s   Offset_0x01D78E
                moveq   #$00, D1
                addq.w  #$03, Obj_Control_Var_08(A0)                     ; $0034
                cmpi.w  #$0018, Obj_Control_Var_08(A0)                   ; $0034
                bcs.s   Offset_0x01D78E
                move.w  #$0000, Obj_Control_Var_08(A0)                   ; $0034
Offset_0x01D78E:
                move.w  D1, Obj_Control_Var_0A(A0)                       ; $0036
                add.w   Obj_Control_Var_08(A0), D1                       ; $0034
                lea     Offset_0x01D812(PC, D1), A1
                move.b  (A1)+, D0
                ext.w   D0
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_X(A0)                                    ; $0008
                move.b  (A1)+, D0
                ext.w   D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.b  (A1)+, Obj_Map_Id(A0)                            ; $001A
Offset_0x01D7B6:
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                add.w   D0, D0
                andi.w  #$001E, D0
                moveq   #$00, D1
                moveq   #$00, D2
                move.b  Offset_0x01D7F2(PC, D0), D1
                move.b  Offset_0x01D7F2+$01(PC, D0), D2
                move.w  D2, D3
                move.w  (A7)+, D4
                bsr     Jmp_0D_To_SolidObject                  ; Offset_0x01DA20
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x01D7EC
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01D7EC:
                jmp     (DeleteObject)                         ; Offset_0x00D314
;-------------------------------------------------------------------------------
Offset_0x01D7F2:
                dc.b    $10, $10, $10, $10, $10, $10, $10, $10
                dc.b    $10, $10, $10, $10, $10, $10, $10, $0C
                dc.b    $10, $08, $10, $0C, $10, $10, $10, $10
                dc.b    $10, $10, $10, $10, $10, $10, $10, $10    
;-------------------------------------------------------------------------------  
Offset_0x01D812:
                dc.b    $00, $B8, $00, $32, $CE, $04, $48, $00
                dc.b    $08, $32, $32, $0C, $00, $48, $10, $CE
                dc.b    $32, $14, $B8, $00, $18, $CE, $CE, $1C
                dc.b    $0D, $B8, $01, $3F, $DA, $05, $48, $0C
                dc.b    $09, $27, $3C, $0D, $F3, $48, $11, $C1
                dc.b    $26, $15, $B8, $F4, $19, $D9, $C4, $1D
                dc.b    $19, $BC, $02, $46, $E9, $06, $46, $17
                dc.b    $0A, $19, $44, $0E, $E7, $44, $12, $BA
                dc.b    $17, $16, $BA, $E9, $1A, $E7, $BC, $1E
                dc.b    $27, $C4, $03, $48, $F4, $07, $3F, $26
                dc.b    $0B, $0D, $48, $0F, $D9, $3C, $13, $B8
                dc.b    $0C, $17, $C1, $DA, $1B, $F3, $B8, $1F
;-------------------------------------------------------------------------------
Rotating_Gears_Mappings:                                       ; Offset_0x01D872
                dc.w    Offset_0x01D8B2-Rotating_Gears_Mappings
                dc.w    Offset_0x01D8C4-Rotating_Gears_Mappings
                dc.w    Offset_0x01D8CE-Rotating_Gears_Mappings
                dc.w    Offset_0x01D8D8-Rotating_Gears_Mappings
                dc.w    Offset_0x01D8E2-Rotating_Gears_Mappings
                dc.w    Offset_0x01D8EC-Rotating_Gears_Mappings
                dc.w    Offset_0x01D8F6-Rotating_Gears_Mappings
                dc.w    Offset_0x01D900-Rotating_Gears_Mappings
                dc.w    Offset_0x01D90A-Rotating_Gears_Mappings
                dc.w    Offset_0x01D91C-Rotating_Gears_Mappings
                dc.w    Offset_0x01D926-Rotating_Gears_Mappings
                dc.w    Offset_0x01D930-Rotating_Gears_Mappings
                dc.w    Offset_0x01D93A-Rotating_Gears_Mappings
                dc.w    Offset_0x01D944-Rotating_Gears_Mappings
                dc.w    Offset_0x01D94E-Rotating_Gears_Mappings
                dc.w    Offset_0x01D958-Rotating_Gears_Mappings
                dc.w    Offset_0x01D962-Rotating_Gears_Mappings
                dc.w    Offset_0x01D974-Rotating_Gears_Mappings
                dc.w    Offset_0x01D97E-Rotating_Gears_Mappings
                dc.w    Offset_0x01D988-Rotating_Gears_Mappings
                dc.w    Offset_0x01D992-Rotating_Gears_Mappings
                dc.w    Offset_0x01D99C-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9A6-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9B0-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9BA-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9CC-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9D6-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9E0-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9EA-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9F4-Rotating_Gears_Mappings
                dc.w    Offset_0x01D9FE-Rotating_Gears_Mappings
                dc.w    Offset_0x01DA08-Rotating_Gears_Mappings
Offset_0x01D8B2:
                dc.w    $0002
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070800, $08000000
Offset_0x01D8C4:
                dc.w    $0001
                dc.l    $F00B0808, $0804FFF4
Offset_0x01D8CE:
                dc.w    $0001
                dc.l    $F00F0814, $080AFFF0
Offset_0x01D8D8:
                dc.w    $0001
                dc.l    $F00F0824, $0812FFF0
Offset_0x01D8E2:
                dc.w    $0001
                dc.l    $F00F0834, $081AFFF0
Offset_0x01D8EC:
                dc.w    $0001
                dc.l    $F00F0844, $0822FFF0
Offset_0x01D8F6:
                dc.w    $0001
                dc.l    $F00F0854, $082AFFF0
Offset_0x01D900:
                dc.w    $0001
                dc.l    $F40E0864, $0832FFF0
Offset_0x01D90A:
                dc.w    $0002
                dc.l    $F00D0870, $0838FFF0
                dc.l    $000D1870, $1838FFF0
Offset_0x01D91C:
                dc.w    $0001
                dc.l    $F40E1864, $1832FFF0
Offset_0x01D926:
                dc.w    $0001
                dc.l    $F00F1854, $182AFFF0
Offset_0x01D930:
                dc.w    $0001
                dc.l    $F00F1844, $1822FFF0
Offset_0x01D93A:
                dc.w    $0001
                dc.l    $F00F1834, $181AFFF0
Offset_0x01D944:
                dc.w    $0001
                dc.l    $F00F1824, $1812FFF0
Offset_0x01D94E:
                dc.w    $0001
                dc.l    $F00F1814, $180AFFF0
Offset_0x01D958:
                dc.w    $0001
                dc.l    $F00B1808, $1804FFF4
Offset_0x01D962:
                dc.w    $0002
                dc.l    $F0071000, $1000FFF0
                dc.l    $F0071800, $18000000
Offset_0x01D974:
                dc.w    $0001
                dc.l    $F00B1008, $1004FFF4
Offset_0x01D97E:
                dc.w    $0001
                dc.l    $F00F1014, $100AFFF0
Offset_0x01D988:
                dc.w    $0001
                dc.l    $F00F1024, $1012FFF0
Offset_0x01D992:
                dc.w    $0001
                dc.l    $F00F1034, $101AFFF0
Offset_0x01D99C:
                dc.w    $0001
                dc.l    $F00F1044, $1022FFF0
Offset_0x01D9A6:
                dc.w    $0001
                dc.l    $F00F1054, $102AFFF0
Offset_0x01D9B0:
                dc.w    $0001
                dc.l    $F40E1064, $1032FFF0
Offset_0x01D9BA:
                dc.w    $0002
                dc.l    $F00D0070, $0038FFF0
                dc.l    $000D1070, $1038FFF0
Offset_0x01D9CC:
                dc.w    $0001
                dc.l    $F40E0064, $0032FFF0
Offset_0x01D9D6:
                dc.w    $0001
                dc.l    $F00F0054, $002AFFF0
Offset_0x01D9E0:
                dc.w    $0001
                dc.l    $F00F0044, $0022FFF0
Offset_0x01D9EA:
                dc.w    $0001
                dc.l    $F00F0034, $001AFFF0
Offset_0x01D9F4:
                dc.w    $0001
                dc.l    $F00F0024, $0012FFF0
Offset_0x01D9FE:
                dc.w    $0001
                dc.l    $F00F0014, $000AFFF0
Offset_0x01DA08:
                dc.w    $0001
                dc.l    $F00B0008, $0004FFF4          
;===============================================================================
; Objeto 0x70 - Engrenagens na Metropolis
; <<<-
;===============================================================================