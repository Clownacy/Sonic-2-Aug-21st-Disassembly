;===============================================================================
; Objeto 0x45 - Mola empurre para obter impulso na Oil Ocean
; ->>> 
;===============================================================================   
; Offset_0x018F20:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x018F32(PC, D0), D1
                jsr     Offset_0x018F32(PC, D1)
                bra     Jmp_08_To_MarkObjGone                  ; Offset_0x019AF8
;-------------------------------------------------------------------------------
Offset_0x018F32:
                dc.w    Offset_0x018F38-Offset_0x018F32
                dc.w    Offset_0x018FAE-Offset_0x018F32
                dc.w    Offset_0x0190A2-Offset_0x018F32        
;-------------------------------------------------------------------------------
Offset_0x018F38:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Spring_Push_Boost_Mappings, Obj_Map(A0) ; Offset_0x019342, $0004
                move.w  #$43C5, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$03, D0
                andi.w  #$000E, D0
                move.w  Offset_0x018F6E(PC, D0), D0
                jmp     Offset_0x018F6E(PC, D0)   
;------------------------------------------------------------------------------- 
Offset_0x018F6E:
                dc.w    Offset_0x018F96-Offset_0x018F6E
                dc.w    Offset_0x018F72-Offset_0x018F6E        
;-------------------------------------------------------------------------------
Offset_0x018F72:
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$0A, Obj_Map_Id(A0)                             ; $001A
                move.w  #$43C5, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$14, Obj_Width(A0)                              ; $0019
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034  
;-------------------------------------------------------------------------------
Offset_0x018F96:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$0002, D0
                move.w  Offset_0x018FAA(PC, D0), Obj_Control_Var_04(A0)  ; $0030
                bsr     Jmp_08_To_ModifySpriteAttr_2P          ; Offset_0x019AFE
                rts               
;-------------------------------------------------------------------------------
Offset_0x018FAA:
                dc.w    $F000, $F600   
;-------------------------------------------------------------------------------
Offset_0x018FAE:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x018FC4
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                beq.s   Offset_0x018FD0
                subq.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bra.s   Offset_0x018FD0
Offset_0x018FC4:
                cmpi.b  #$09, Obj_Control_Var_06(A0)                     ; $0032
                beq.s   Offset_0x018FEE
                addq.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
Offset_0x018FD0:
                moveq   #$00, D3
                move.b  Obj_Control_Var_06(A0), D3                       ; $0032
                move.b  D3, Obj_Map_Id(A0)                               ; $001A
                add.w   D3, D3
                move.w  #$001B, D1
                move.w  #$0014, D2
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Offset_0x019B10
                rts
Offset_0x018FEE:
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                bsr.s   Offset_0x018FFC
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
Offset_0x018FFC:
                bclr    D6, Obj_Status(A0)                               ; $0022
                beq     Offset_0x0190A0
                move.w  Obj_Control_Var_04(A0), Obj_Speed_Y(A1)   ; $0012, $0030
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$10, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x01902E
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
Offset_0x01902E:
                btst    #$00, D0
                beq.s   Offset_0x01906E
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$00, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$04, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x01905E
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x01905E:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01906E
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x01906E:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x019084
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x019084:
                cmpi.b  #$08, D0
                bne.s   Offset_0x019096
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x019096:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x0190A0:
                rts       
;-------------------------------------------------------------------------------
Offset_0x0190A2:
                move.b  #$00, Obj_Control_Var_0A(A0)                     ; $0036
                move.w  #$001F, D1
                move.w  #$000C, D2
                move.w  #$000D, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Jmp_00_To_SolidObject_2_A1             ; Offset_0x019B0A
                cmpi.w  #$0001, D4
                bne.s   Offset_0x0190E8
                move.b  Obj_Status(A0), D1                               ; $0022
                move.w  Obj_X(A0), D2                                    ; $0008
                sub.w   Obj_X(A1), D2                                    ; $0008
                bcs.s   Offset_0x0190DE
                eori.b  #$01, D1
Offset_0x0190DE:
                andi.b  #$01, D1
                bne.s   Offset_0x0190E8
                bsr     Offset_0x019164
Offset_0x0190E8:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     Jmp_00_To_SolidObject_2_A1             ; Offset_0x019B0A
                cmpi.w  #$0001, D4
                bne.s   Offset_0x019116
                move.b  Obj_Status(A0), D1                               ; $0022
                move.w  Obj_X(A0), D2                                    ; $0008
                sub.w   Obj_X(A1), D2                                    ; $0008
                bcs.s   Offset_0x01910E
                eori.b  #$01, D1
Offset_0x01910E:
                andi.b  #$01, D1
                bne.s   Offset_0x019116
                bsr.s   Offset_0x019164
Offset_0x019116:
                tst.b   Obj_Control_Var_0A(A0)                           ; $0036
                bne.s   Offset_0x019162
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x019162
                bcc.s   Offset_0x019144
                subq.b  #$04, Obj_Map_Id(A0)                             ; $001A
                subq.w  #$04, Obj_X(A0)                                  ; $0008
                cmp.w   Obj_X(A0), D0                                    ; $0008
                bcs.s   Offset_0x01915E
                move.b  #$0A, Obj_Map_Id(A0)                             ; $001A
                move.w  Obj_Control_Var_08(A0), Obj_X(A0)         ; $0008, $0034
                bra.s   Offset_0x01915E
Offset_0x019144:
                subq.b  #$04, Obj_Map_Id(A0)                             ; $001A
                addq.w  #$04, Obj_X(A0)                                  ; $0008
                cmp.w   Obj_X(A0), D0                                    ; $0008
                bcc.s   Offset_0x01915E
                move.b  #$0A, Obj_Map_Id(A0)                             ; $001A
                move.w  Obj_Control_Var_08(A0), Obj_X(A0)         ; $0008, $0034
Offset_0x01915E:
                bsr     Offset_0x0191F8
Offset_0x019162:
                rts
Offset_0x019164:
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0191A0
                btst    #$00, Obj_Status(A1)                             ; $0022
                bne     Offset_0x0191F6
                tst.w   D0
                bne     Offset_0x019186
                tst.w   Obj_Inertia(A1)                                  ; $0014
                beq.s   Offset_0x0191F6
                bpl.s   Offset_0x0191F0
                bra.s   Offset_0x0191F6
Offset_0x019186:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                addi.w  #$0012, D0
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x0191F0
                addq.w  #$01, Obj_X(A0)                                  ; $0008
                moveq   #$01, D0
                move.w  #$0040, D1
                bra.s   Offset_0x0191CE
Offset_0x0191A0:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x0191F6
                tst.w   D0
                bne     Offset_0x0191B6
                tst.w   Obj_Inertia(A1)                                  ; $0014
                bmi.s   Offset_0x0191F0
                bra.s   Offset_0x0191F6
Offset_0x0191B6:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                subi.w  #$0012, D0
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x0191F0
                subq.w  #$01, Obj_X(A0)                                  ; $0008
                moveq   #-$01, D0
                move.w  #$FFC0, D1
Offset_0x0191CE:
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.w  D1, Obj_Inertia(A1)                              ; $0014
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                sub.w   Obj_X(A0), D0                                    ; $0008
                bcc.s   Offset_0x0191E8
                neg.w   D0
Offset_0x0191E8:
                addi.w  #$000A, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
Offset_0x0191F0:
                move.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
Offset_0x0191F6:
                rts
Offset_0x0191F8:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$60, D0
                beq     Offset_0x0192F8
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$05, D6
                bsr.s   Offset_0x019212
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$06, D6
Offset_0x019212:
                bclr    D6, Obj_Status(A0)                               ; $0022
                beq     Offset_0x0192F8
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                sub.w   Obj_X(A0), D0                                    ; $0008
                bcc.s   Offset_0x019226
                neg.w   D0
Offset_0x019226:
                addi.w  #$000A, D0
                lsl.w   #$07, D0
                neg.w   D0
                move.w  D0, Obj_Speed(A1)                                ; $0010
                subq.w  #$04, Obj_X(A1)                                  ; $0008
                bset    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x019254
                bclr    #$00, Obj_Status(A1)                             ; $0022
                addi.w  #$0008, Obj_X(A1)                                ; $0008
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x019254:
                move.w  #$000F, Obj_Control_Var_02(A1)                   ; $002E
                move.w  Obj_Speed(A1), Obj_Inertia(A1)            ; $0010, $0014
                btst    #$02, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x01926E
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
Offset_0x01926E:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x01927A
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
Offset_0x01927A:
                btst    #$00, D0
                beq.s   Offset_0x0192BA
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$08, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x0192AA
                move.b  #$03, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x0192AA:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x0192BA
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x0192BA:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x0192D0
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x0192D0:
                cmpi.b  #$08, D0
                bne.s   Offset_0x0192E2
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x0192E2:
                bclr    #$05, Obj_Status(A1)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A1)                           ; $001D
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x0192F8:
                rts   
;------------------------------------------------------------------------------- 
Spring_Push_Boost_Animate_Data:; Dados não usados              ; Offset_0x0192FA
                dc.w    Offset_0x0192FE-Spring_Push_Boost_Animate_Data
                dc.w    Offset_0x019320-Spring_Push_Boost_Animate_Data
Offset_0x0192FE:
                dc.b    $00, $00, $01, $02, $03, $04, $05, $06
                dc.b    $07, $08, $09, $09, $09, $09, $09, $09
                dc.b    $09, $09, $08, $07, $06, $05, $04, $03
                dc.b    $02, $01, $00, $00, $00, $00, $00, $00
                dc.b    $00, $FF
Offset_0x019320:
                dc.b    $00, $0A, $0B, $0C, $0D, $0E, $0F, $10
                dc.b    $11, $12, $13, $13, $13, $13, $13, $13
                dc.b    $13, $13, $12, $11, $10, $0F, $0E, $0D
                dc.b    $0C, $0B, $0A, $0A, $0A, $0A, $0A, $0A
                dc.b    $0A, $FF
;------------------------------------------------------------------------------- 
Spring_Push_Boost_Mappings:                                    ; Offset_0x019342:
                dc.w    Offset_0x01937C-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0193A6-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0193D0-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0193FA-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019424-Spring_Push_Boost_Mappings
                dc.w    Offset_0x01944E-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019478-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0194A2-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0194CC-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0194F6-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019520-Spring_Push_Boost_Mappings
                dc.w    Offset_0x01954A-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019574-Spring_Push_Boost_Mappings
                dc.w    Offset_0x01959E-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0195C8-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0195F2-Spring_Push_Boost_Mappings
                dc.w    Offset_0x01961C-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019646-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019670-Spring_Push_Boost_Mappings
                dc.w    Offset_0x01969A-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0196C4-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0196EE-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019718-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019742-Spring_Push_Boost_Mappings
                dc.w    Offset_0x01976C-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019796-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0197C0-Spring_Push_Boost_Mappings
                dc.w    Offset_0x0197EA-Spring_Push_Boost_Mappings
                dc.w    Offset_0x019814-Spring_Push_Boost_Mappings
Offset_0x01937C:
                dc.w    $0005
                dc.l    $EC0C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $04081007, $1003FFF4
                dc.l    $FC08300A, $3005FFF4
                dc.l    $F404100D, $1006FFF8
Offset_0x0193A6:
                dc.w    $0005
                dc.l    $EE0C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $04081007, $1003FFF4
                dc.l    $FC08300A, $3005FFF4
                dc.l    $F604100D, $1006FFF8
Offset_0x0193D0:
                dc.w    $0005
                dc.l    $F00C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $04081007, $1003FFF4
                dc.l    $FE08300A, $3005FFF4
                dc.l    $F804100D, $1006FFF8
Offset_0x0193FA:
                dc.w    $0005
                dc.l    $F20C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $06081007, $1003FFF4
                dc.l    $0008300A, $3005FFF4
                dc.l    $FA04100D, $1006FFF8
Offset_0x019424:
                dc.w    $0005
                dc.l    $F40C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $06081007, $1003FFF4
                dc.l    $0008300A, $3005FFF4
                dc.l    $FC04100D, $1006FFF8
Offset_0x01944E:
                dc.w    $0005
                dc.l    $F60C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $06081007, $1003FFF4
                dc.l    $0208300A, $3005FFF4
                dc.l    $FE04100D, $1006FFF8
Offset_0x019478:
                dc.w    $0005
                dc.l    $F80C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $08081007, $1003FFF4
                dc.l    $0408300A, $3005FFF4
                dc.l    $0004100D, $1006FFF8
Offset_0x0194A2:
                dc.w    $0005
                dc.l    $FA0C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $08081007, $1003FFF4
                dc.l    $0408300A, $3005FFF4
                dc.l    $0204100D, $1006FFF8
Offset_0x0194CC:
                dc.w    $0005
                dc.l    $FC0C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $08081007, $1003FFF4
                dc.l    $0608300A, $3005FFF4
                dc.l    $0404100D, $1006FFF8
Offset_0x0194F6:
                dc.w    $0005
                dc.l    $FE0C3000, $3000FFF0
                dc.l    $0C083004, $3002FFF4
                dc.l    $0A081007, $1003FFF4
                dc.l    $0808300A, $3005FFF4
                dc.l    $0604100D, $1006FFF8
Offset_0x019520:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFEC
                dc.l    $F4020016, $000BFFF4
                dc.l    $F4022019, $200CFFFC
                dc.l    $F801001C, $000E0004
Offset_0x01954A:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFED
                dc.l    $F4020016, $000BFFF5
                dc.l    $F4022019, $200CFFFD
                dc.l    $F801001C, $000E0004
Offset_0x019574:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFEE
                dc.l    $F4020016, $000BFFF6
                dc.l    $F4022019, $200CFFFE
                dc.l    $F801001C, $000E0004
Offset_0x01959E:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFEF
                dc.l    $F4020016, $000BFFF7
                dc.l    $F4022019, $200CFFFF
                dc.l    $F801001C, $000E0004
Offset_0x0195C8:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF0
                dc.l    $F4020016, $000BFFF8
                dc.l    $F4022019, $200CFFFE
                dc.l    $F801001C, $000E0004
Offset_0x0195F2:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF1
                dc.l    $F4020016, $000BFFF9
                dc.l    $F4022019, $200CFFFF
                dc.l    $F801001C, $000E0004
Offset_0x01961C:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF2
                dc.l    $F4020016, $000BFFF8
                dc.l    $F4022019, $200CFFFE
                dc.l    $F801001C, $000E0004
Offset_0x019646:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF3
                dc.l    $F4020016, $000BFFF9
                dc.l    $F4022019, $200CFFFF
                dc.l    $F801001C, $000E0004
Offset_0x019670:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF4
                dc.l    $F4020016, $000BFFFA
                dc.l    $F4022019, $200C0000
                dc.l    $F801001C, $000E0004
Offset_0x01969A:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF5
                dc.l    $F4020016, $000BFFFB
                dc.l    $F4022019, $200C0001
                dc.l    $F801001C, $000E0004
Offset_0x0196C4:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF6
                dc.l    $F4020016, $000BFFFC
                dc.l    $F4022019, $200C0000
                dc.l    $F801001C, $000E0004
Offset_0x0196EE:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF7
                dc.l    $F4020016, $000BFFFD
                dc.l    $F4022019, $200C0001
                dc.l    $F801001C, $000E0004
Offset_0x019718:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF8
                dc.l    $F4020016, $000BFFFC
                dc.l    $F4022019, $200C0000
                dc.l    $F801001C, $000E0004
Offset_0x019742:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFF9
                dc.l    $F4020016, $000BFFFD
                dc.l    $F4022019, $200C0001
                dc.l    $F801001C, $000E0004
Offset_0x01976C:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFFA
                dc.l    $F4020016, $000BFFFE
                dc.l    $F4022019, $200C0002
                dc.l    $F801001C, $000E0004
Offset_0x019796:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFFB
                dc.l    $F4020016, $000BFFFF
                dc.l    $F4022019, $200C0003
                dc.l    $F801001C, $000E0004
Offset_0x0197C0:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFFC
                dc.l    $F4020016, $000B0000
                dc.l    $F4022019, $200C0002
                dc.l    $F801001C, $000E0004
Offset_0x0197EA:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFFD
                dc.l    $F4020016, $000B0001
                dc.l    $F4022019, $200C0003
                dc.l    $F801001C, $000E0004
Offset_0x019814:
                dc.w    $0005
                dc.l    $F003200F, $2007000C
                dc.l    $F4022013, $2009FFFE
                dc.l    $F4020016, $000B0000
                dc.l    $F4022019, $200C0002
                dc.l    $F801001C, $000E0004 
;===============================================================================
; Objeto 0x45 - Mola empurre para obter impulso na Oil Ocean
; <<<- 
;===============================================================================