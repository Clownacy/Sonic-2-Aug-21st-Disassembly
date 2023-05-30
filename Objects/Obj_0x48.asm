;===============================================================================
; Objeto 0x48 - Canhões na Oil Ocean
; ->>> 
;===============================================================================   
; Offset_0x01A03C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01A05A(PC, D0), D1
                jsr     Offset_0x01A05A(PC, D1)
                move.b  Obj_Control_Var_00(A0), D0                       ; $002C
                add.b   Obj_Control_Var_0A(A0), D0                       ; $0036
                beq     Jmp_0B_To_MarkObjGone                  ; Offset_0x01A43E
                bra     Jmp_06_To_DisplaySprite                ; Offset_0x01A438
;-------------------------------------------------------------------------------
Offset_0x01A05A:
                dc.w    Offset_0x01A06E-Offset_0x01A05A
                dc.w    Offset_0x01A0BE-Offset_0x01A05A       
;-------------------------------------------------------------------------------  
Offset_0x01A05E:
                dc.b    $04, $00, $06, $07, $07, $00, $05, $07
                dc.b    $05, $00, $04, $07, $06, $00, $07, $07     
;------------------------------------------------------------------------------- 
Offset_0x01A06E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Cannon_Mappings, Obj_Map(A0)   ; Offset_0x01A2B6, $0004
                move.w  #$6368, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_0B_To_ModifySpriteAttr_2P          ; Offset_0x01A444
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01A096
                addq.w  #$04, D0
Offset_0x01A096:
                add.w   D0, D0
                move.b  Offset_0x01A05E(PC, D0), Obj_Flags(A0)           ; $0001
                move.b  Offset_0x01A05E+$01(PC, D0), Obj_Control_Var_13(A0) ; $003F
                beq.s   Offset_0x01A0AC
                move.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x01A0AC:
                move.b  Obj_Control_Var_13(A0), Obj_Map_Id(A0)    ; $001A, $003F
                move.b  #$28, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018  
;-------------------------------------------------------------------------------
Offset_0x01A0BE:
                lea     (Player_One).w, A1                           ; $FFFFB000
                lea     Obj_Control_Var_00(A0), A4                       ; $002C
                moveq   #$2C, D2
                bsr.s   Offset_0x01A0D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                lea     Obj_Control_Var_0A(A0), A4                       ; $0036
                moveq   #$36, D2
Offset_0x01A0D4:
                moveq   #$00, D0
                move.b  (A4), D0
                move.w  Offset_0x01A0E0(PC, D0), D0
                jmp     Offset_0x01A0E0(PC, D0)   
;-------------------------------------------------------------------------------
Offset_0x01A0E0:
                dc.w    Offset_0x01A0E8-Offset_0x01A0E0
                dc.w    Offset_0x01A19C-Offset_0x01A0E0
                dc.w    Offset_0x01A24A-Offset_0x01A0E0
                dc.w    Offset_0x01A2AA-Offset_0x01A0E0  
;-------------------------------------------------------------------------------   
Offset_0x01A0E8:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x01A19A
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc     Offset_0x01A19A
                move.w  Obj_Y(A1), D1                                    ; $000C
                sub.w   Obj_Y(A0), D1                                    ; $000C
                addi.w  #$0010, D1
                cmpi.w  #$0020, D1
                bcc     Offset_0x01A19A
                btst    #$03, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01A136
                moveq   #$00, D0
                move.b  Obj_Control_Var_11(A1), D0                       ; $003D
                lsl.w   #$06, D0
                addi.l  #Obj_Memory_Address, D0                      ; $FFFFB000
                move.l  D0, A3
                move.b  #$00, $00(A3, D2)
Offset_0x01A136:
                move.w  A0, D0
                subi.w  #$B000, D0
                lsr.w   #$06, D0
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_11(A1)                       ; $003D
                addq.b  #$02, (A4)
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$81, Obj_Timer(A1)                              ; $002A
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$1000, Obj_Inertia(A1)                          ; $0014
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                bset    #$01, Obj_Status(A1)                             ; $0022
                bset    #$03, Obj_Status(A1)                             ; $0022
                move.b  Obj_Control_Var_13(A0), Obj_Map_Id(A0)    ; $001A, $003F
                move.w  #$00BE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x01A19A:
                rts  
;-------------------------------------------------------------------------------
Offset_0x01A19C:
                tst.b   Obj_Control_Var_12(A0)                           ; $003E
                bne.s   Offset_0x01A1C4
                cmpi.b  #$07, Obj_Map_Id(A0)                             ; $001A
                beq.s   Offset_0x01A1DE
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01A1C2
                move.w  #$0007, Obj_Ani_Time(A0)                         ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$07, Obj_Map_Id(A0)                             ; $001A
                beq.s   Offset_0x01A1DE
Offset_0x01A1C2:
                rts
Offset_0x01A1C4:
                tst.b   Obj_Map_Id(A0)                                   ; $001A
                beq.s   Offset_0x01A1DE
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01A1C2
                move.w  #$0007, Obj_Ani_Time(A0)                         ; $001E
                subq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                beq.s   Offset_0x01A1DE
                rts
Offset_0x01A1DE:
                addq.b  #$02, (A4)
                move.b  Obj_Subtype(A0), D0                              ; $0028
                addq.b  #$01, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01A1F0
                subq.b  #$02, D0
Offset_0x01A1F0:
                andi.w  #$0003, D0
                add.w   D0, D0
                add.w   D0, D0
                move.w  Offset_0x01A23A(PC, D0), Obj_Speed(A1)           ; $0010
                move.w  Offset_0x01A23A+$02(PC, D0), Obj_Speed_Y(A1)     ; $0012
                move.w  #$0003, Obj_Ani_Time(A0)                         ; $001E
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bpl.s   Offset_0x01A238
                move.b  #$00, Obj_Timer(A1)                              ; $002A
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$00, Obj_Control_Var_10(A1)                     ; $003C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  #$06, (A4)
                move.w  #$0007, Obj_Control_Var_10(A0)                   ; $003C
Offset_0x01A238:
                rts
;-------------------------------------------------------------------------------
Offset_0x01A23A:
                dc.w    $0000, $F000, $1000, $0000, $0000, $1000, $F000, $0000 
;-------------------------------------------------------------------------------
Offset_0x01A24A:
                cmpi.b  #$02, Obj_P_Flips_Remaining(A0)                  ; $002C
                beq.s   Offset_0x01A284
                cmpi.b  #$02, Obj_Player_Next_Tilt(A0)                   ; $0036
                beq.s   Offset_0x01A284
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01A284
                move.w  #$0001, Obj_Ani_Time(A0)                         ; $001E
                tst.b   Obj_Player_Top_Solid(A0)                         ; $003E
                beq.s   Offset_0x01A27A
                cmpi.b  #$07, Obj_Map_Id(A0)                             ; $001A
                beq.s   Offset_0x01A284
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                bra.s   Offset_0x01A284
Offset_0x01A27A:
                tst.b   Obj_Map_Id(A0)                                   ; $001A
                beq.s   Offset_0x01A284
                subq.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x01A284:
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
Offset_0x01A2AA:
                subq.w  #$01, Obj_Player_Jump(A0)                        ; $003C
                bpl.s   Offset_0x01A2B4
                move.b  #$00, (A4)
Offset_0x01A2B4:
                rts      
;-------------------------------------------------------------------------------  
Cannon_Mappings:                                               ; Offset_0x01A2B6
                dc.w    Offset_0x01A2C6-Cannon_Mappings
                dc.w    Offset_0x01A308-Cannon_Mappings
                dc.w    Offset_0x01A33A-Cannon_Mappings
                dc.w    Offset_0x01A35C-Cannon_Mappings
                dc.w    Offset_0x01A37E-Cannon_Mappings
                dc.w    Offset_0x01A3A0-Cannon_Mappings
                dc.w    Offset_0x01A3C2-Cannon_Mappings
                dc.w    Offset_0x01A3F4-Cannon_Mappings
Offset_0x01A2C6:
                dc.w    $0008
                dc.l    $D8040000, $0000FFF0
                dc.l    $D8040800, $08000000
                dc.l    $E0040002, $0001FFF0
                dc.l    $E0040802, $08010000
                dc.l    $E80A0011, $0008FFE8
                dc.l    $E80A0811, $08080000
                dc.l    $000A1008, $1004FFE8
                dc.l    $000A1808, $18040000
Offset_0x01A308:
                dc.w    $0006
                dc.l    $E0040000, $0000FFF0
                dc.l    $E0040800, $08000000
                dc.l    $E80A0011, $0008FFE8
                dc.l    $E80A0811, $08080000
                dc.l    $000A1008, $1004FFE8
                dc.l    $000A1808, $18040000
Offset_0x01A33A:
                dc.w    $0004
                dc.l    $E80A0011, $0008FFE8
                dc.l    $E80A0811, $08080000
                dc.l    $000A1008, $1004FFE8
                dc.l    $000A1808, $18040000
Offset_0x01A35C:
                dc.w    $0004
                dc.l    $E80A001A, $000DFFE8
                dc.l    $E80A1823, $18110000
                dc.l    $000A0023, $0011FFE8
                dc.l    $000A181A, $180D0000
Offset_0x01A37E:
                dc.w    $0004
                dc.l    $E80A1023, $1011FFE8
                dc.l    $E80A081A, $080D0000
                dc.l    $000A101A, $100DFFE8
                dc.l    $000A0823, $08110000
Offset_0x01A3A0:
                dc.w    $0004
                dc.l    $E80A0008, $0004FFE8
                dc.l    $E80A102C, $10160000
                dc.l    $000A1008, $1004FFE8
                dc.l    $000A002C, $00160000
Offset_0x01A3C2:
                dc.w    $0006
                dc.l    $E80A0008, $0004FFE8
                dc.l    $E80A102C, $10160000
                dc.l    $000A1008, $1004FFE8
                dc.l    $000A002C, $00160000
                dc.l    $F0010006, $00030018
                dc.l    $00011006, $10030018
Offset_0x01A3F4:
                dc.w    $0008
                dc.l    $E80A0008, $0004FFE8
                dc.l    $E80A102C, $10160000
                dc.l    $000A1008, $1004FFE8
                dc.l    $000A002C, $00160000
                dc.l    $F0010004, $00020018
                dc.l    $00011004, $10020018
                dc.l    $F0010006, $00030020
                dc.l    $00011006, $10030020         
;===============================================================================
; Objeto 0x48 - Canhões na Oil Ocean
; <<<- 
;===============================================================================