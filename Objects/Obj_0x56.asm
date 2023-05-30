;===============================================================================
; Objeto 0x56 - Robotnik na Green Hill
; ->>>
;===============================================================================   
; Offset_0x0200F8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x020106(PC, D0), D1
                jmp     Offset_0x020106(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x020106:
                dc.w    Offset_0x020110-Offset_0x020106
                dc.w    Offset_0x02021A-Offset_0x020106
                dc.w    Offset_0x020258-Offset_0x020106
                dc.w    Offset_0x02028A-Offset_0x020106
                dc.w    Offset_0x02032C-Offset_0x020106   
;-------------------------------------------------------------------------------
Offset_0x020110:
                move.l  #GHz_Boss_Mappings_03, Obj_Map(A0) ; Offset_0x020490, $0004
                move.w  #$23A0, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Boss_Hit(A0)                           ; $0021
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_0C(A0)         ; $000C, $0038
                bsr     Jmp_27_To_ModifySpriteAttr_2P          ; Offset_0x02050E
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x020200
                move.b  #$56, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  A1, Obj_Control_Var_08(A0)                       ; $0034
                move.l  #GHz_Boss_Mappings_03, Obj_Map(A1) ; Offset_0x020490, $0004
                move.w  #$03A0, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addq.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                bsr     Jmp_03_To_ModifySpriteAttr_2P_A1       ; Offset_0x020508
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bmi.s   Offset_0x020200
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x020200
                move.b  #$56, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  #GHz_Boss_Mappings, Obj_Map(A1) ; Offset_0x0203E8, $0004
                move.w  #$04D0, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_03_To_ModifySpriteAttr_2P_A1       ; Offset_0x020508
                move.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addq.b  #$06, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
Offset_0x020200:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$007F, D0
                add.w   D0, D0
                add.w   D0, D0
                move.l  Offset_0x020212(PC, D0), A1
                jmp     (A1)  
;-------------------------------------------------------------------------------
Offset_0x020212:
                dc.l    Offset_0x02385E
                dc.l    Obj_0x56_GHz_Boss_Sub_4                ; Offset_0x020BFC    
;-------------------------------------------------------------------------------
Offset_0x02021A:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$007F, D0
                add.w   D0, D0
                add.w   D0, D0
                move.l  Offset_0x020250(PC, D0), A1
                jsr     (A1)
                lea     (GHz_Boss_Animate_Data), A1            ; Offset_0x020484
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$03, D0
                andi.b  #$FC, Obj_Flags(A0)                              ; $0001
                or.b    D0, Obj_Flags(A0)                                ; $0001
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------
Offset_0x020250:
                dc.l    Offset_0x02393E
                dc.l    Obj_0x56_GHz_Boss_Sub_2                ; Offset_0x020514                          
;-------------------------------------------------------------------------------
Offset_0x020258:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                move.l  #GHz_Boss_Animate_Data, A1             ; Offset_0x020484
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------
Offset_0x020286:
                dc.b    $00, $FF, $01, $00                                    
;-------------------------------------------------------------------------------
Offset_0x02028A:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x0202DE
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x0202D2
                move.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                move.b  Obj_Timer(A0), D0                                ; $002A
                addq.b  #$01, D0
                cmpi.b  #$02, D0
                ble.s   Offset_0x0202C8
                moveq   #$00, D0
Offset_0x0202C8:
                move.b  Offset_0x020286(PC, D0), Obj_Map_Id(A0)          ; $001A
                move.b  D0, Obj_Timer(A0)                                ; $002A
Offset_0x0202D2:
                cmpi.b  #$FF, Obj_Map_Id(A0)                             ; $001A
                bne     Jmp_13_To_DisplaySprite                ; Offset_0x0204FC
                rts
Offset_0x0202DE:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                btst    #$06, Obj_Control_Var_02(A1)                     ; $002E
                bne.s   Offset_0x0202EC
                rts
Offset_0x0202EC:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #GHz_Boss_Mappings_01, Obj_Map(A0) ; Offset_0x020400, $0004
                move.w  #$04D8, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_27_To_ModifySpriteAttr_2P          ; Offset_0x02050E
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.b  #$05, Obj_Ani_Time(A0)                           ; $001E
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addi.w  #$0004, Obj_Y(A0)                                ; $000C
                subi.w  #$0028, Obj_X(A0)                                ; $0008
                rts
Offset_0x02032C:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x02036E
                move.b  #$05, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$04, Obj_Map_Id(A0)                             ; $001A
                bne     Offset_0x02036E
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.b  (A1), D0
                beq     Jmp_14_To_DeleteObject                 ; Offset_0x020502
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addi.w  #$0004, Obj_Y(A0)                                ; $000C
                subi.w  #$0028, Obj_X(A0)                                ; $0008
Offset_0x02036E:
                bra     Jmp_13_To_DisplaySprite                ; Offset_0x0204FC     
;===============================================================================
; Objeto 0x56 - Robotnik na Green Hill
; ->>>
;===============================================================================