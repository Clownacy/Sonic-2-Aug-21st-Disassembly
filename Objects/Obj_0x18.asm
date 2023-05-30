;===============================================================================
; Objeto 0x18 - Plataformas
; ->>> 
;===============================================================================
; Offset_0x0091E0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0091EE(PC, D0), D1
                jmp     Offset_0x0091EE(PC, D1)   
;-------------------------------------------------------------------------------  
Offset_0x0091EE:
                dc.w    Offset_0x009202-Offset_0x0091EE
                dc.w    Offset_0x00929E-Offset_0x0091EE
                dc.w    Offset_0x009304-Offset_0x0091EE
                dc.w    Offset_0x0092DC-Offset_0x0091EE
                dc.w    Offset_0x009308-Offset_0x0091EE
;-------------------------------------------------------------------------------
Offset_0x0091F8:
                dc.b    $20, $00
                dc.b    $20, $01
                dc.b    $20, $02
                dc.b    $40, $03
                dc.b    $30, $04    
;-------------------------------------------------------------------------------  
Offset_0x009202:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$03, D0
                andi.w  #$000E, D0
                lea     Offset_0x0091F8(PC, D0), A2
                move.b  (A2)+, Obj_Width(A0)                             ; $0019
                move.b  (A2)+, Obj_Map_Id(A0)                            ; $001A
                move.l  #GHz_HTz_Platforms_Mappings, Obj_Map(A0) ; Offset_0x00952A, $0004
                move.w  #$4000, Obj_Art_VRAM(A0)                         ; $0002
                cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x009242
                move.l  #NGHz_Platforms_Mappings, Obj_Map(A0) ; Offset_0x009582, $0004
                move.w  #$4000, Obj_Art_VRAM(A0)                         ; $0002
Offset_0x009242:
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_Y(A0), Obj_Control_Var_00(A0)         ; $000C, $002C
                move.w  Obj_Y(A0), Obj_Control_Var_08(A0)         ; $000C, $0034
                move.w  Obj_X(A0), Obj_Control_Var_06(A0)         ; $0008, $0032
                move.w  #$0080, Obj_Angle(A0)                            ; $0026
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bpl.s   Offset_0x009298
                addq.b  #$06, Obj_Routine(A0)                            ; $0024
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028
                move.b  #$30, Obj_Height_2(A0)                           ; $0016
                cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x00928E
                move.b  #$28, Obj_Height_2(A0)                           ; $0016
Offset_0x00928E:
                bset    #$04, Obj_Flags(A0)                              ; $0001
                bra     Offset_0x009308
Offset_0x009298:
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028 
;-------------------------------------------------------------------------------  
Offset_0x00929E:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x0092B4
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x0092C0
                subq.b  #$04, Obj_Control_Var_0C(A0)                     ; $0038
                bra.s   Offset_0x0092C0
Offset_0x0092B4:
                cmpi.b  #$40, Obj_Control_Var_0C(A0)                     ; $0038
                beq.s   Offset_0x0092C0
                addq.b  #$04, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x0092C0:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x00936C
                bsr     Offset_0x009352
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                moveq   #$08, D3
                move.w  (A7)+, D4
                bsr     Platform_Object                        ; Offset_0x00F82C
                bra.s   Offset_0x0092E4    
;-------------------------------------------------------------------------------  
Offset_0x0092DC:
                bsr     Offset_0x00936C
                bsr     Offset_0x009352
Offset_0x0092E4:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x0092EE
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x0092EE:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x009304
                bra     DisplaySprite                          ; Offset_0x00D322 
;-------------------------------------------------------------------------------  
Offset_0x009304:
                bra     DeleteObject                           ; Offset_0x00D314  
;-------------------------------------------------------------------------------  
Offset_0x009308:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x00931E
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x00932A
                subq.b  #$04, Obj_Control_Var_0C(A0)                     ; $0038
                bra.s   Offset_0x00932A
Offset_0x00931E:
                cmpi.b  #$40, Obj_Control_Var_0C(A0)                     ; $0038
                beq.s   Offset_0x00932A
                addq.b  #$04, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x00932A:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x00936C
                bsr     Offset_0x009352
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  (A7)+, D4
                bsr     SolidObject                            ; Offset_0x00F344
                bra.s   Offset_0x0092E4
Offset_0x009352:
                move.b  Obj_Control_Var_0C(A0), D0                       ; $0038
                bsr     CalcSine                               ; Offset_0x003282
                move.w  #$0400, D1
                muls.w  D1, D0
                swap.w  D0
                add.w   Obj_Control_Var_00(A0), D0                       ; $002C
                move.w  D0, Obj_Y(A0)                                    ; $000C
                rts
Offset_0x00936C:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                add.w   D0, D0
                move.w  Offset_0x009380(PC, D0), D1
                jmp     Offset_0x009380(PC, D1)     
;-------------------------------------------------------------------------------  
Offset_0x009380:
                dc.w    Offset_0x00939C-Offset_0x009380
                dc.w    Offset_0x0093AE-Offset_0x009380
                dc.w    Offset_0x0093F4-Offset_0x009380
                dc.w    Offset_0x00940C-Offset_0x009380
                dc.w    Offset_0x009436-Offset_0x009380
                dc.w    Offset_0x00939E-Offset_0x009380
                dc.w    Offset_0x0093E4-Offset_0x009380
                dc.w    Offset_0x0094AC-Offset_0x009380
                dc.w    Offset_0x0094D8-Offset_0x009380
                dc.w    Offset_0x00939C-Offset_0x009380
                dc.w    Offset_0x0094F0-Offset_0x009380
                dc.w    Offset_0x00950A-Offset_0x009380
                dc.w    Offset_0x0093D6-Offset_0x009380
                dc.w    Offset_0x0093C6-Offset_0x009380  
;-------------------------------------------------------------------------------
Offset_0x00939C:
                rts    
;-------------------------------------------------------------------------------
Offset_0x00939E:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                move.b  Obj_Angle(A0), D1                                ; $0026
                neg.b   D1
                addi.b  #$40, D1
                bra.s   Offset_0x0093BA
;-------------------------------------------------------------------------------
Offset_0x0093AE:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                move.b  Obj_Angle(A0), D1                                ; $0026
                subi.b  #$40, D1
Offset_0x0093BA:
                ext.w   D1
                add.w   D1, D0
                move.w  D0, Obj_X(A0)                                    ; $0008
                bra     Offset_0x009522    
;-------------------------------------------------------------------------------
Offset_0x0093C6:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.b  ($FFFFFE6C).w, D1
                neg.b   D1
                addi.b  #$30, D1
                bra.s   Offset_0x009400     
;-------------------------------------------------------------------------------
Offset_0x0093D6:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.b  ($FFFFFE6C).w, D1
                subi.b  #$30, D1
                bra.s   Offset_0x009400   
;-------------------------------------------------------------------------------
Offset_0x0093E4:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.b  Obj_Angle(A0), D1                                ; $0026
                neg.b   D1
                addi.b  #$40, D1
                bra.s   Offset_0x009400   
;-------------------------------------------------------------------------------
Offset_0x0093F4:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.b  Obj_Angle(A0), D1                                ; $0026
                subi.b  #$40, D1
Offset_0x009400:
                ext.w   D1
                add.w   D1, D0
                move.w  D0, Obj_Control_Var_00(A0)                       ; $002C
                bra     Offset_0x009522     
;-------------------------------------------------------------------------------
Offset_0x00940C:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                bne.s   Offset_0x009424
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x009422
                move.w  #$001E, Obj_Control_Var_0E(A0)                   ; $003A
Offset_0x009422:
                rts
Offset_0x009424:
                subq.w  #$01, Obj_Control_Var_0E(A0)                     ; $003A
                bne.s   Offset_0x009422
                move.w  #$0020, Obj_Control_Var_0E(A0)                   ; $003A
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                rts       
;-------------------------------------------------------------------------------
Offset_0x009436:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x009464
                subq.w  #$01, Obj_Control_Var_0E(A0)                     ; $003A
                bne.s   Offset_0x009464
                bclr    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x009450
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x009492
Offset_0x009450:
                bclr    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00945E
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr.s   Offset_0x009492
Offset_0x00945E:
                move.b  #$06, Obj_Routine(A0)                            ; $0024
Offset_0x009464:
                move.l  Obj_Control_Var_00(A0), D3                       ; $002C
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D3, Obj_Control_Var_00(A0)                       ; $002C
                addi.w  #$0038, Obj_Speed_Y(A0)                          ; $0012
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$0120, D0
                cmp.w   Obj_Control_Var_00(A0), D0                       ; $002C
                bcc.s   Offset_0x009490
                move.b  #$04, Obj_Routine(A0)                            ; $0024
Offset_0x009490:
                rts
Offset_0x009492:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.w  Obj_Speed_Y(A0), Obj_Speed_Y(A1)          ; $0012, $0012
                rts   
;-------------------------------------------------------------------------------
Offset_0x0094AC:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                bne.s   Offset_0x0094CC
                lea     ($FFFFF7E0).w, A2
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$04, D0
                tst.b   $00(A2, D0)
                beq.s   Offset_0x0094CA
                move.w  #$003C, Obj_Control_Var_0E(A0)                   ; $003A
Offset_0x0094CA:
                rts
Offset_0x0094CC:
                subq.w  #$01, Obj_Control_Var_0E(A0)                     ; $003A
                bne.s   Offset_0x0094CA
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                rts 
;-------------------------------------------------------------------------------
Offset_0x0094D8:
                subq.w  #$02, Obj_Control_Var_00(A0)                     ; $002C
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                subi.w  #$0200, D0
                cmp.w   Obj_Control_Var_00(A0), D0                       ; $002C
                bne.s   Offset_0x0094EE
                clr.b   Obj_Subtype(A0)                                  ; $0028
Offset_0x0094EE:
                rts   
;-------------------------------------------------------------------------------
Offset_0x0094F0:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.b  Obj_Angle(A0), D1                                ; $0026
                subi.b  #$40, D1
                ext.w   D1
                asr.w   #$01, D1
                add.w   D1, D0
                move.w  D0, Obj_Control_Var_00(A0)                       ; $002C
                bra     Offset_0x009522  
;-------------------------------------------------------------------------------
Offset_0x00950A:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.b  Obj_Angle(A0), D1                                ; $0026
                neg.b   D1
                addi.b  #$40, D1
                ext.w   D1
                asr.w   #$01, D1
                add.w   D1, D0
                move.w  D0, Obj_Control_Var_00(A0)                       ; $002C
Offset_0x009522:
                move.b  ($FFFFFE78).w, Obj_Angle(A0)                     ; $0026
                rts
;-------------------------------------------------------------------------------
GHz_HTz_Platforms_Mappings:                                    ; Offset_0x00952A
                dc.w    Offset_0x00952E-GHz_HTz_Platforms_Mappings
                dc.w    Offset_0x009540-GHz_HTz_Platforms_Mappings
Offset_0x00952E:
                dc.w    $0002
                dc.l    $F40F0056, $002BFFE0
                dc.l    $F40F0856, $082B0000
Offset_0x009540:
                dc.w    $0008
                dc.l    $CC07000A, $0005FFE0
                dc.l    $CC0D0012, $0009FFF0
                dc.l    $DC0D001A, $000DFFF0
                dc.l    $CC070022, $00110010
                dc.l    $EC0F002A, $0015FFE0
                dc.l    $EC0F082A, $08150000
                dc.l    $0C0F003A, $001DFFE0
                dc.l    $0C0F083A, $081D0000   
;-------------------------------------------------------------------------------
NGHz_Platforms_Mappings:                                       ; Offset_0x009582
                dc.w    Offset_0x009586-NGHz_Platforms_Mappings
                dc.w    Offset_0x0095A8-NGHz_Platforms_Mappings
Offset_0x009586:
                dc.w    $0004
                dc.l    $F00E0001, $0000FFE0
                dc.l    $F00E0801, $08000000
                dc.l    $080E002D, $0016FFE0
                dc.l    $080E0039, $001C0000
Offset_0x0095A8:
                dc.w    $0006
                dc.l    $D00E0001, $0000FFE0
                dc.l    $D00E0801, $08000000
                dc.l    $E80F000D, $0006FFE0
                dc.l    $E80F001D, $000E0000
                dc.l    $080F000D, $0006FFE0
                dc.l    $080F001D, $000E0000            
;===============================================================================
; Objeto 0x18 - Plataformas
; <<<- 
;===============================================================================