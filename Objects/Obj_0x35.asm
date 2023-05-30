;===============================================================================
; Objeto 0x35 - Invencibilidade do Sonic / Miles
; ->>>
;===============================================================================
; Offset_0x012B72:
                moveq   #$00, D0
                move.b  Obj_Sub_Y(A0), D0                                ; $000A
                move.w  Offset_0x012B80(PC, D0), D1
                jmp     Offset_0x012B80(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x012B80:
                dc.w    Offset_0x012B84-Offset_0x012B80
                dc.w    Offset_0x012BB2-Offset_0x012B80           
;-------------------------------------------------------------------------------  
Offset_0x012B84:
                addq.b  #$02, Obj_Sub_Y(A0)                              ; $000A
                move.l  #Invicibility_Stars_Mappings, Obj_Map(A0) ; Offset_0x01314C, $0004
                move.w  #$04DE, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                bset    #$06, Obj_Flags(A0)                              ; $0001
                move.b  #$10, $000E(A0)
                move.b  #$08, Obj_Ani_Boss_Cnt(A0)                       ; $000F   
;-------------------------------------------------------------------------------
Offset_0x012BB2:
                tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
                beq     DeleteObject                           ; Offset_0x00D314
                lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), D6                               ; $0022
                lea     (Offset_0x012CD4), A2
                move.b  Obj_Angle(A1), D1                                ; $0026
                btst    #$01, D6
                beq.s   Offset_0x012BE4
                move.b  Obj_Player_Status(A1), D1                        ; $002B
                moveq   #$00, D6
Offset_0x012BE4:
                andi.b  #$01, D6
                beq.s   Offset_0x012BEC
                neg.w   D1
Offset_0x012BEC:
                addi.b  #$10, D1
                lsr.b   #$03, D1
                andi.w  #$001C, D1
                lea     $00(A2, D1), A2
                subq.w  #$08, D1
                andi.w  #$0010, D1
                bne.s   Offset_0x012C06
                eori.b  #$01, D6
Offset_0x012C06:
                move.b  ($FFFFFE05).w, D0
                andi.b  #$01, D0
                lea     (Offset_0x012CF4), A3
                beq.s   Offset_0x012C1E
                lea     (Offset_0x012E5C), A3
                addq.w  #$02, A2
Offset_0x012C1E:
                move.w  Obj_X(A1), D4                                    ; $0008
                move.b  (A2)+, D1
                ext.w   D1
                andi.b  #$01, D6
                beq.s   Offset_0x012C2E
                neg.w   D1
Offset_0x012C2E:
                add.w   D1, D4
                move.w  Obj_Y(A1), D5                                    ; $000C
                move.b  (A2)+, D1
                ext.w   D1
                add.w   D1, D5
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                addq.b  #$06, D0
                cmpi.b  #$78, D0
                bcs.s   Offset_0x012C4A
                moveq   #$00, D0
Offset_0x012C4A:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.w  D0, D1
                add.w   D0, D0
                add.w   D1, D0
                lea     $00(A3, D0), A3
                lea     Obj_Speed(A0), A2                                ; $0010
                moveq   #$00, D0
                moveq   #$05, D1
Offset_0x012C60:
                move.b  (A3)+, D0
                move.b  (A3)+, D2
                ext.w   D2
                andi.b  #$01, D6
                beq.s   Offset_0x012C6E
                neg.w   D2
Offset_0x012C6E:
                add.w   D4, D2
                move.b  (A3)+, D3
                ext.w   D3
                add.w   D5, D3
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                addq.w  #$01, A2
                move.b  D0, (A2)+
                dbra    D1, Offset_0x012C60
                move.w  Obj_X(A1), D4                                    ; $0008
                move.w  Obj_Y(A1), D5                                    ; $000C
                moveq   #$00, D0
                move.b  Obj_Map(A0), D0                                  ; $0004
                addq.b  #$06, D0
                cmpi.b  #$A2, D0
                bcs.s   Offset_0x012C9A
                moveq   #$00, D0
Offset_0x012C9A:
                move.b  D0, Obj_Map(A0)                                  ; $0004
                lea     (Offset_0x012FC4), A3
                lea     $00(A3, D0), A3
                moveq   #$01, D1
Offset_0x012CAA:
                move.b  (A3)+, D0
                move.b  (A3)+, D2
                ext.w   D2
                andi.b  #$01, D6
                beq.s   Offset_0x012CB8
                neg.w   D2
Offset_0x012CB8:
                add.w   D4, D2
                move.b  (A3)+, D3
                ext.w   D3
                add.w   D5, D3
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                addq.w  #$01, A2
                move.b  D0, (A2)+
                dbra    D1, Offset_0x012CAA
                move.w  #$0080, D0
                bra     DisplaySprite_Param                    ; Offset_0x00D35E 
;-------------------------------------------------------------------------------
Offset_0x012CD4:
                dc.w    $0000, $0000, $00F8, $00F0, $04F0, $04E0, $00F8, $00F0
                dc.w    $0000, $0000, $0008, $0010, $0410, $0420, $0008, $0010 
;------------------------------------------------------------------------------- 
Offset_0x012CF4:
                dc.b    $02, $F8, $F9, $05, $E5, $F9, $04, $E6
                dc.b    $08, $02, $E8, $FD, $00, $00, $00, $00
                dc.b    $00, $00, $03, $F7, $F9, $02, $F8, $07
                dc.b    $06, $E4, $F9, $05, $E5, $08, $03, $E7
                dc.b    $FD, $00, $00, $00, $04, $F6, $F9, $03
                dc.b    $F7, $07, $05, $E3, $FA, $06, $E4, $09
                dc.b    $04, $E6, $FC, $00, $00, $00, $05, $F5
                dc.b    $F9, $04, $F6, $08, $04, $E2, $FB, $05
                dc.b    $E3, $09, $05, $E5, $FC, $00, $00, $00
                dc.b    $06, $F4, $F9, $05, $F5, $08, $02, $F8
                dc.b    $FD, $03, $E1, $FC, $04, $E2, $0A, $06
                dc.b    $E4, $FB, $05, $F3, $FA, $06, $F4, $09
                dc.b    $03, $F7, $FD, $02, $E0, $FD, $03, $E1
                dc.b    $0A, $05, $E3, $FB, $04, $F2, $FB, $05
                dc.b    $F3, $09, $04, $F6, $FC, $01, $DF, $00
                dc.b    $02, $E0, $0B, $04, $E2, $FA, $03, $F1
                dc.b    $FC, $04, $F2, $0A, $05, $F5, $FC, $02
                dc.b    $F8, $02, $01, $DF, $0B, $03, $E1, $FA
                dc.b    $02, $F0, $FD, $03, $F1, $0A, $06, $F4
                dc.b    $FB, $03, $F7, $02, $02, $E0, $FA, $00
                dc.b    $00, $00, $01, $EF, $00, $02, $F0, $0B
                dc.b    $05, $F3, $FB, $04, $F6, $03, $01, $DF
                dc.b    $FA, $00, $00, $00, $01, $EE, $00, $01
                dc.b    $EF, $0B, $04, $F2, $FA, $05, $F5, $03
                dc.b    $02, $F8, $0E, $00, $00, $00, $01, $ED
                dc.b    $01, $01, $EE, $0C, $03, $F1, $FA, $06
                dc.b    $F4, $03, $03, $F7, $0E, $00, $00, $00
                dc.b    $01, $ED, $03, $01, $ED, $0D, $02, $F0
                dc.b    $FA, $05, $F3, $02, $04, $F6, $0D, $00
                dc.b    $00, $00, $01, $EC, $05, $01, $EC, $0D
                dc.b    $01, $EF, $FA, $04, $F2, $02, $05, $F5
                dc.b    $0D, $02, $F8, $F5, $01, $EB, $07, $01
                dc.b    $EB, $0D, $01, $EE, $F9, $03, $F1, $02
                dc.b    $06, $F4, $0C, $03, $F7, $F5, $01, $EA
                dc.b    $08, $01, $EA, $0D, $01, $ED, $F8, $02
                dc.b    $F0, $01, $05, $F3, $0C, $04, $F6, $F5
                dc.b    $01, $E9, $09, $01, $E9, $0D, $01, $EC
                dc.b    $F8, $01, $EF, $01, $04, $F2, $0B, $05
                dc.b    $F5, $F5, $01, $EB, $F7, $01, $EE, $00
                dc.b    $03, $F1, $0A, $05, $F4, $F6, $02, $E8
                dc.b    $F9, $00, $00, $00, $01, $EA, $F7, $01
                dc.b    $ED, $00, $02, $F0, $0A, $04, $F3, $F6
                dc.b    $03, $E7, $F9, $02, $E8, $07, $01, $E9
                dc.b    $F6, $01, $EC, $00, $01, $EF, $09, $03
                dc.b    $F2, $F6, $04, $E6, $F9, $03, $E7, $07
;-------------------------------------------------------------------------------  
Offset_0x012E5C:
                dc.b    $01, $E6, $00, $01, $E7, $0B, $04, $EA
                dc.b    $FA, $05, $ED, $03, $02, $F0, $0E, $00
                dc.b    $00, $00, $01, $E5, $01, $01, $E6, $0C
                dc.b    $03, $E9, $FA, $06, $EC, $03, $03, $F1
                dc.b    $0E, $00, $00, $00, $01, $E5, $03, $01
                dc.b    $E5, $03, $02, $E8, $FA, $05, $EB, $02
                dc.b    $04, $EE, $0D, $00, $00, $00, $01, $E4
                dc.b    $05, $01, $E4, $0D, $01, $E7, $FA, $04
                dc.b    $EA, $02, $05, $ED, $0D, $02, $F0, $F5
                dc.b    $01, $E3, $07, $01, $E3, $0D, $01, $E6
                dc.b    $F9, $03, $E9, $02, $06, $EC, $0C, $03
                dc.b    $EF, $F5, $01, $E2, $08, $01, $E2, $0D
                dc.b    $01, $E5, $F8, $02, $E8, $01, $05, $EB
                dc.b    $0C, $04, $EE, $F5, $01, $E1, $09, $01
                dc.b    $E1, $0D, $01, $E4, $F8, $01, $E7, $01
                dc.b    $04, $EA, $0B, $05, $ED, $F5, $01, $E3
                dc.b    $F7, $01, $E6, $00, $03, $E9, $0A, $05
                dc.b    $EC, $F6, $02, $E8, $02, $00, $00, $00
                dc.b    $01, $E2, $F7, $01, $E5, $00, $02, $E8
                dc.b    $0A, $04, $EB, $F6, $03, $E7, $02, $02
                dc.b    $E8, $0E, $01, $E1, $F6, $01, $E4, $00
                dc.b    $01, $E7, $09, $03, $EA, $F6, $04, $E6
                dc.b    $03, $03, $E7, $0E, $02, $F0, $F9, $05
                dc.b    $E5, $03, $04, $E6, $0D, $02, $E8, $F5
                dc.b    $00, $00, $00, $00, $00, $00, $03, $EF
                dc.b    $F9, $02, $F0, $07, $06, $E4, $03, $05
                dc.b    $E5, $0D, $03, $E7, $F5, $00, $00, $00
                dc.b    $04, $EE, $F9, $03, $EF, $07, $05, $E3
                dc.b    $02, $06, $E4, $0C, $04, $E6, $F5, $00
                dc.b    $00, $00, $05, $ED, $F9, $04, $EE, $08
                dc.b    $04, $E2, $02, $05, $E3, $0C, $05, $E5
                dc.b    $F5, $00, $00, $00, $06, $EC, $F9, $05
                dc.b    $ED, $08, $02, $F0, $FD, $03, $E1, $02
                dc.b    $04, $E2, $0B, $06, $E4, $F6, $05, $EB
                dc.b    $FA, $06, $EC, $09, $03, $EF, $FD, $02
                dc.b    $E0, $01, $03, $E1, $0A, $05, $E3, $F6
                dc.b    $04, $EA, $FB, $05, $EB, $09, $04, $EE
                dc.b    $FD, $01, $DF, $01, $02, $E0, $0A, $04
                dc.b    $E2, $F6, $03, $E9, $FC, $04, $EA, $0A
                dc.b    $05, $ED, $FC, $02, $F0, $02, $01, $DF
                dc.b    $09, $03, $E1, $F7, $02, $E8, $FD, $03
                dc.b    $E9, $0A, $06, $EC, $FB, $03, $EF, $02
                dc.b    $02, $E0, $F7, $00, $00, $00, $01, $E7
                dc.b    $00, $02, $E8, $0B, $05, $EB, $FB, $04
                dc.b    $EE, $03, $01, $DF, $F8, $00, $00, $00
;-------------------------------------------------------------------------------
Offset_0x012FC4:
                dc.b    $04, $08, $09, $04, $FC, $01, $05, $08
                dc.b    $09, $05, $FC, $01, $06, $08, $09, $06
                dc.b    $FC, $01, $07, $08, $09, $07, $FC, $01
                dc.b    $08, $08, $09, $08, $FC, $01, $07, $08
                dc.b    $09, $07, $FC, $01, $06, $08, $09, $06
                dc.b    $FC, $01, $05, $08, $09, $05, $FC, $01
                dc.b    $04, $08, $09, $04, $FC, $01, $04, $F9
                dc.b    $F7, $04, $0B, $FC, $05, $F9, $F7, $05
                dc.b    $0B, $FC, $06, $F9, $F7, $06, $0B, $FC
                dc.b    $07, $F9, $F7, $07, $0B, $FC, $08, $F9
                dc.b    $F7, $08, $0B, $FC, $07, $F9, $F7, $07
                dc.b    $0B, $FC, $06, $F9, $F7, $06, $0B, $FC
                dc.b    $05, $F9, $F7, $05, $0B, $FC, $04, $F9
                dc.b    $F7, $04, $0B, $FC, $04, $03, $F1, $04
                dc.b    $F4, $09, $05, $03, $F1, $05, $F4, $09
                dc.b    $06, $03, $F1, $06, $F4, $09, $07, $03
                dc.b    $F1, $07, $F4, $09, $08, $03, $F1, $08
                dc.b    $F4, $09, $07, $03, $F1, $07, $F4, $09
                dc.b    $06, $03, $F1, $06, $F4, $09, $05, $03
                dc.b    $F1, $05, $F4, $09, $04, $03, $F1, $04
                dc.b    $F4, $09                            
;===============================================================================
; Objeto 0x35 - Invencibilidade do Sonic / Miles
; <<<-
;===============================================================================