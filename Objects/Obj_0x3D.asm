;===============================================================================
; Objeto 0x3D - Obstásculo quebre para obter impulso na Oil Ocean
; ->>>
;===============================================================================  
; Offset_0x019BF8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x019C06(PC, D0), D1
                jmp     Offset_0x019C06(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x019C06:
                dc.w    Offset_0x019C0E-Offset_0x019C06
                dc.w    Offset_0x019C4E-Offset_0x019C06
                dc.w    Offset_0x019D64-Offset_0x019C06
                dc.w    Offset_0x019D7A-Offset_0x019C06         
;-------------------------------------------------------------------------------  
Offset_0x019C0E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Break_Boost_Mappings, Obj_Map(A0) ; Offset_0x019EB4, $0004
                move.w  #$6332, Obj_Art_VRAM(A0)                         ; $0002
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq.s   Offset_0x019C32
                move.w  #$63FF, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
Offset_0x019C32:
                bsr     Jmp_0A_To_ModifySpriteAttr_2P          ; Offset_0x01A022
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                bset    #$07, Obj_Status(A0)                             ; $0022
                move.b  #$04, Obj_Priority(A0)                           ; $0018  
;-------------------------------------------------------------------------------  
Offset_0x019C4E:
                move.b  ($FFFFB01C).w, Obj_Control_Var_06(A0)            ; $0032
                move.b  ($FFFFB05C).w, Obj_Control_Var_07(A0)            ; $0033
                move.w  ($FFFFB012).w, Obj_Control_Var_08(A0)            ; $0034
                move.w  ($FFFFB052).w, Obj_Control_Var_0A(A0)            ; $0036
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  #$0011, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_04_To_SolidObject                  ; Offset_0x01A02E
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x019C88
Offset_0x019C84:
                bra     Jmp_0A_To_MarkObjGone                  ; Offset_0x01A010
Offset_0x019C88:
                cmpi.b  #$18, D0
                bne.s   Offset_0x019CBE
                cmpi.b  #$02, Obj_Control_Var_06(A0)                     ; $0032
                beq.s   Offset_0x019C9E
                cmpi.b  #$02, Obj_Control_Var_07(A0)                     ; $0033
                bne.s   Offset_0x019C84
Offset_0x019C9E:
                lea     (Player_One).w, A1                           ; $FFFFB000
                move.b  Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  Obj_Control_Var_08(A0), D1                       ; $0034
                bsr.s   Offset_0x019CDA
                lea     (Player_Two).w, A1                           ; $FFFFB040
                move.b  Obj_Control_Var_07(A0), D0                       ; $0033
                move.w  Obj_Control_Var_0A(A0), D1                       ; $0036
                bsr.s   Offset_0x019CDA
                bra     Offset_0x019D2C
Offset_0x019CBE:
                move.b  D0, D1
                andi.b  #$08, D1
                beq.s   Offset_0x019D10
                cmpi.b  #$02, Obj_Control_Var_06(A0)                     ; $0032
                bne.s   Offset_0x019C84
                lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
                move.w  Obj_Control_Var_08(A0), D1                       ; $0034
                bsr.s   Offset_0x019CE0
                bra.s   Offset_0x019D2C
Offset_0x019CDA:
                cmpi.b  #$02, D0
                bne.s   Offset_0x019CFC
Offset_0x019CE0:
                bset    #$02, Obj_Status(A1)                             ; $0022
                move.b  #$0E, Obj_Height_2(A1)                           ; $0016
                move.b  #$07, Obj_Width_2(A1)                            ; $0017
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  D1, Obj_Speed_Y(A1)                              ; $0012
Offset_0x019CFC:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                rts
Offset_0x019D10:
                andi.b  #$10, D0
                beq     Offset_0x019C84
                cmpi.b  #$02, Obj_Control_Var_07(A0)                     ; $0033
                bne     Offset_0x019C84
                lea     (Player_Two).w, A1                           ; $FFFFB040
                move.w  Obj_Control_Var_0A(A0), D1                       ; $0036
                bsr.s   Offset_0x019CE0
Offset_0x019D2C:
                andi.b  #$E7, Obj_Status(A0)                             ; $0022
                bsr     Jmp_06_To_SingleObjectLoad_2           ; Offset_0x01A016
                bne.s   Offset_0x019D50
                moveq   #$00, D0
                move.w  #$000A, D1
Offset_0x019D3E:
                move.l  $00(A0, D0), $00(A1, D0)
                addq.w  #$04, D0
                dbra    D1, Offset_0x019D3E
                move.b  #$06, Obj_Routine(A1)                            ; $0024
Offset_0x019D50:
                lea     (Break_Boost_Data), A4                 ; Offset_0x019E74
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                moveq   #$0F, D1
                move.w  #$0018, D2
                bsr     Jmp_01_To_Smash_Object                 ; Offset_0x01A028      
;-------------------------------------------------------------------------------  
Offset_0x019D64:
                bsr     Jmp_06_To_SpeedToPos                   ; Offset_0x01A034
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Jmp_09_To_DeleteObject                 ; Offset_0x01A00A
                bra     Jmp_05_To_DisplaySprite                ; Offset_0x01A004      
;-------------------------------------------------------------------------------  
Offset_0x019D7A:
                lea     (Player_One).w, A1                           ; $FFFFB000
                lea     Obj_Control_Var_00(A0), A4                       ; $002C
                bsr.s   Offset_0x019D9C
                lea     (Player_Two).w, A1                           ; $FFFFB040
                lea     Obj_Control_Var_0A(A0), A4                       ; $0036
                bsr.s   Offset_0x019D9C
                move.b  Obj_Control_Var_00(A0), D0                       ; $002C
                add.b   Obj_Control_Var_0A(A0), D0                       ; $0036
                beq     Jmp_02_To_MarkObjGone_3                ; Offset_0x01A01C
                rts
Offset_0x019D9C:
                moveq   #$00, D0
                move.b  (A4), D0
                move.w  Offset_0x019DA8(PC, D0), D0
                jmp     Offset_0x019DA8(PC, D0)
;-------------------------------------------------------------------------------
Offset_0x019DA8:
                dc.w    Offset_0x019DAC-Offset_0x019DA8
                dc.w    Offset_0x019E4E-Offset_0x019DA8    
;-------------------------------------------------------------------------------
Offset_0x019DAC:
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc     Offset_0x019E4C
                move.w  Obj_Y(A1), D1                                    ; $000C
                sub.w   Obj_Y(A0), D1                                    ; $000C
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq.s   Offset_0x019DD2
                addi.w  #$0010, D1
Offset_0x019DD2:
                cmpi.w  #$0010, D1
                bcc     Offset_0x019E4C
                addq.b  #$02, (A4)
                move.b  #$81, Obj_Timer(A1)                              ; $002A
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$0800, Obj_Inertia(A1)                          ; $0014
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq.s   Offset_0x019E08
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
                move.w  #$F800, Obj_Speed_Y(A1)                          ; $0012
                bra.s   Offset_0x019E1A
Offset_0x019E08:
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$0800, Obj_Speed(A1)                            ; $0010
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
Offset_0x019E1A:
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                bset    #$01, Obj_Status(A1)                             ; $0022
                bset    #$03, Obj_Status(A1)                             ; $0022
                move.w  A0, D0
                subi.w  #$B000, D0
                lsr.w   #$06, D0
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_11(A1)                       ; $003D
                move.w  #$00BE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x019E4C:
                rts  
;-------------------------------------------------------------------------------  
Offset_0x019E4E:
                move.l  Obj_X(A1), D2                                    ; $0008
                move.l  Obj_Y(A1), D3                                    ; $000C
                move.w  Obj_Speed(A1), D0                                ; $0010
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                move.w  Obj_Speed_Y(A1), D0                              ; $0012
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D2, Obj_X(A1)                                    ; $0008
                move.l  D3, Obj_Y(A1)                                    ; $000C
                rts               
;-------------------------------------------------------------------------------
Break_Boost_Data:                                              ; Offset_0x019E74
                dc.w    $FC00, $FC00, $FE00, $FC00, $0200, $FC00, $0400, $FC00
                dc.w    $FC40, $FE00, $FE40, $FE00, $01C0, $FE00, $03C0, $FE00
                dc.w    $FC80, $0200, $FE80, $0200, $0180, $0200, $0380, $0200
                dc.w    $FCC0, $0400, $FEC0, $0400, $0140, $0400, $0340, $0400                
;-------------------------------------------------------------------------------  
Break_Boost_Mappings:                                          ; Offset_0x019EB4
                dc.w    Offset_0x019EBC-Break_Boost_Mappings
                dc.w    Offset_0x019EDE-Break_Boost_Mappings
                dc.w    Offset_0x019F60-Break_Boost_Mappings
                dc.w    Offset_0x019F82-Break_Boost_Mappings
Offset_0x019EBC:
                dc.w    $0004
                dc.l    $F0030000, $0000FFF0
                dc.l    $F0030000, $0000FFF8
                dc.l    $F0030000, $00000000
                dc.l    $F0030000, $00000008
Offset_0x019EDE:
                dc.w    $0010
                dc.l    $F0000000, $0000FFF0
                dc.l    $F0000000, $0000FFF8
                dc.l    $F0000000, $00000000
                dc.l    $F0000000, $00000008
                dc.l    $F8000001, $0000FFF0
                dc.l    $F8000001, $0000FFF8
                dc.l    $F8000001, $00000000
                dc.l    $F8000001, $00000008
                dc.l    $00000002, $0001FFF0
                dc.l    $00000002, $0001FFF8
                dc.l    $00000002, $00010000
                dc.l    $00000002, $00010008
                dc.l    $08000003, $0001FFF0
                dc.l    $08000003, $0001FFF8
                dc.l    $08000003, $00010000
                dc.l    $08000003, $00010008
Offset_0x019F60:
                dc.w    $0004
                dc.l    $F00C0000, $0000FFF0
                dc.l    $F80C0000, $0000FFF0
                dc.l    $000C0000, $0000FFF0
                dc.l    $080C0000, $0000FFF0
Offset_0x019F82:
                dc.w    $0010
                dc.l    $F0000000, $0000FFF0
                dc.l    $F0000001, $0000FFF8
                dc.l    $F0000002, $00010000
                dc.l    $F0000003, $00010008
                dc.l    $F8000000, $0000FFF0
                dc.l    $F8000001, $0000FFF8
                dc.l    $F8000002, $00010000
                dc.l    $F8000003, $00010008
                dc.l    $00000000, $0000FFF0
                dc.l    $00000001, $0000FFF8
                dc.l    $00000002, $00010000
                dc.l    $00000003, $00010008
                dc.l    $08000000, $0000FFF0
                dc.l    $08000001, $0000FFF8
                dc.l    $08000002, $00010000
                dc.l    $08000003, $00010008  
;===============================================================================
; Objeto 0x3D - Obstásculo quebre para obter impulso na Oil Ocean
; <<<-
;===============================================================================