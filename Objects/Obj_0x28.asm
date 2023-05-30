;===============================================================================
; Object 0x28 - Flickies (pássaros, esquilos) que aparecem ao destruir iminigos
; ->>> 
;===============================================================================
; Offset_0x00A3E8
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00A3F6(PC, D0), D1
                jmp     Offset_0x00A3F6(PC, D1)            
;-------------------------------------------------------------------------------
Offset_0x00A3F6:
                dc.w    Offset_0x00A51A-Offset_0x00A3F6
                dc.w    Offset_0x00A63A-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A6D0-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A6D0-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A6D0-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A694-Offset_0x00A3F6
                dc.w    Offset_0x00A750-Offset_0x00A3F6
                dc.w    Offset_0x00A770-Offset_0x00A3F6
                dc.w    Offset_0x00A770-Offset_0x00A3F6
                dc.w    Offset_0x00A790-Offset_0x00A3F6
                dc.w    Offset_0x00A7CA-Offset_0x00A3F6
                dc.w    Offset_0x00A824-Offset_0x00A3F6
                dc.w    Offset_0x00A842-Offset_0x00A3F6
                dc.w    Offset_0x00A824-Offset_0x00A3F6
                dc.w    Offset_0x00A842-Offset_0x00A3F6
                dc.w    Offset_0x00A824-Offset_0x00A3F6
                dc.w    Offset_0x00A880-Offset_0x00A3F6
                dc.w    Offset_0x00A7E6-Offset_0x00A3F6
;-------------------------------------------------------------------------------
Offset_0x00A42A:
                dc.b    $06, $05  ; GHz
                dc.b    $06, $05  ; Lvl 1
                dc.b    $06, $05  ; Wz
                dc.b    $06, $05  ; Lvl 3
                dc.b    $09, $07  ; Mz
                dc.b    $09, $07  ; Mz
                dc.b    $09, $07  ; Lvl 6
                dc.b    $09, $07  ; HTz
                dc.b    $08, $03  ; HPz
                dc.b    $08, $03  ; Lvl 9
                dc.b    $02, $03  ; OOz
                dc.b    $08, $01  ; DHz
                dc.b    $0B, $05  ; CNz
                dc.b    $00, $07  ; CPz
                dc.b    $04, $01  ; GCz
                dc.b    $02, $05  ; NGHz
                dc.b    $0A, $01  ; DEz  
;-------------------------------------------------------------------------------  
Offset_0x00A44C:
                dc.w    $FE00, $FC00
                dc.l    Flickies_Mappings_04                   ; Offset_0x00AA08
                dc.w    $FE00, $FD00
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.w    $FE80, $FD00
                dc.l    Flickies_Mappings_04                   ; Offset_0x00AA08
                dc.w    $FEC0, $FE80
                dc.l    Flickies_Mappings_03                   ; Offset_0x00A9E4
                dc.w    $FE40, $FD00
                dc.l    Flickies_Mappings_02                   ; Offset_0x00A9C0
                dc.w    $FD00, $FC00
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.w    $FD80, $FC80
                dc.l    Flickies_Mappings_01                   ; Offset_0x00A99C
                dc.w    $FD80, $FD00
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.w    $FE00, $FC80
                dc.l    Flickies_Mappings_01                   ; Offset_0x00A99C
                dc.w    $FD40, $FD00
                dc.l    Flickies_Mappings_01                   ; Offset_0x00A99C
                dc.w    $FEC0, $FE00
                dc.l    Flickies_Mappings_01                   ; Offset_0x00A99C
                dc.w    $FE00, $FD00
                dc.l    Flickies_Mappings_01                   ; Offset_0x00A99C 
;------------------------------------------------------------------------------- 
Offset_0x00A4AC:
                dc.w    $FBC0, $FC00
                dc.w    $FBC0, $FC00
                dc.w    $FBC0, $FC00
                dc.w    $FD00, $FC00
                dc.w    $FD00, $FC00
                dc.w    $FE80, $FD00
                dc.w    $FE80, $FD00
                dc.w    $FEC0, $FE80
                dc.w    $FE40, $FD00
                dc.w    $FE00, $FD00
                dc.w    $FD80, $FC80
;------------------------------------------------------------------------------- 
Offset_0x00A4D8:
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.l    Flickies_Mappings_04                   ; Offset_0x00AA08
                dc.l    Flickies_Mappings_04                   ; Offset_0x00AA08
                dc.l    Flickies_Mappings_04                   ; Offset_0x00AA08
                dc.l    Flickies_Mappings_04                   ; Offset_0x00AA08
                dc.l    Flickies_Mappings_03                   ; Offset_0x00A9E4
                dc.l    Flickies_Mappings_02                   ; Offset_0x00A9C0
                dc.l    Flickies_Mappings                      ; Offset_0x00A978
                dc.l    Flickies_Mappings_01                   ; Offset_0x00A99C 
;------------------------------------------------------------------------------- 
Offset_0x00A504:
                dc.w    $05A5
                dc.w    $05A5
                dc.w    $05A5
                dc.w    $0553
                dc.w    $0553
                dc.w    $0573
                dc.w    $0573
                dc.w    $0585
                dc.w    $0593
                dc.w    $0565
                dc.w    $05B3
;------------------------------------------------------------------------------- 
Offset_0x00A51A:
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq     Offset_0x00A588
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, D0
                move.b  D0, Obj_Routine(A0)                              ; $0024
                subi.w  #$0014, D0
                move.w  Offset_0x00A504(PC, D0), Obj_Art_VRAM(A0)        ; $0002
                add.w   D0, D0
                move.l  Offset_0x00A4D8(PC, D0), Obj_Map(A0)             ; $0004
                lea     Offset_0x00A4AC(PC), A1
                move.w  $00(A1, D0), Obj_Control_Var_06(A0)              ; $0032
                move.w  $00(A1, D0), Obj_Speed(A0)                       ; $0010
                move.w  $02(A1, D0), Obj_Control_Var_08(A0)              ; $0034
                move.w  $02(A1, D0), Obj_Speed_Y(A0)                     ; $0012
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                bset    #$00, Obj_Flags(A0)                              ; $0001
                move.b  #$06, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00A588:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     PseudoRandomNumber                     ; Offset_0x00325C
                move.w  #$0580, Obj_Art_VRAM(A0)                         ; $0002
                andi.w  #$0001, D0
                beq.s   Offset_0x00A5A2
                move.w  #$0594, Obj_Art_VRAM(A0)                         ; $0002
Offset_0x00A5A2:
                moveq   #$00, D1
                move.b  (Level_Id).w, D1                             ; $FFFFFE10
                add.w   D1, D1
                add.w   D0, D1
                lea     Offset_0x00A42A(PC), A1
                move.b  $00(A1, D1), D0
                move.b  D0, Obj_Control_Var_04(A0)                       ; $0030
                lsl.w   #$03, D0
                lea     Offset_0x00A44C(PC), A1
                adda.w  D0, A1
                move.w  (A1)+, Obj_Control_Var_06(A0)                    ; $0032
                move.w  (A1)+, Obj_Control_Var_08(A0)                    ; $0034
                move.l  (A1)+, Obj_Map(A0)                               ; $0004
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                bset    #$00, Obj_Flags(A0)                              ; $0001
                move.b  #$06, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $0012
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
                bne.s   Offset_0x00A62C
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne.s   Offset_0x00A628
                move.b  #$29, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_Control_Var_12(A0), D0                       ; $003E
                lsr.w   #$01, D0
                move.b  D0, Obj_Map_Id(A1)                               ; $001A
Offset_0x00A628:
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00A62C:
                move.b  #$1C, Obj_Routine(A0)                            ; $0024
                clr.w   Obj_Speed(A0)                                    ; $0010
                bra     DisplaySprite                          ; Offset_0x00D322     
;-------------------------------------------------------------------------------
Offset_0x00A63A:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                bsr     ObjectFall                             ; Offset_0x00D1AE
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A690
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A690
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_06(A0), Obj_Speed(A0)     ; $0010, $0032
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                move.b  Obj_Control_Var_04(A0), D0                       ; $0030
                add.b   D0, D0
                addq.b  #$04, D0
                move.b  D0, Obj_Routine(A0)                              ; $0024
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
                beq.s   Offset_0x00A690
                btst    #$04, ($FFFFFE0F).w
                beq.s   Offset_0x00A690
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
Offset_0x00A690:
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x00A694:
                bsr     ObjectFall                             ; Offset_0x00D1AE
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A6BE
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A6BE
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
Offset_0x00A6BE:
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bne.s   Offset_0x00A734
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322    
;-------------------------------------------------------------------------------
Offset_0x00A6D0:
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A70C
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A70C
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq.s   Offset_0x00A70C
                cmpi.b  #$0A, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x00A70C
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
Offset_0x00A70C:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x00A722
                move.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x00A722:
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bne.s   Offset_0x00A734
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00A734:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bcs.s   Offset_0x00A74C
                subi.w  #$0180, D0
                bpl.s   Offset_0x00A74C
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
Offset_0x00A74C:
                bra     DisplaySprite                          ; Offset_0x00D322   
;-------------------------------------------------------------------------------
Offset_0x00A750:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bne     Offset_0x00A76C
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$03, Obj_Priority(A0)                           ; $0018
Offset_0x00A76C:
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x00A770:
                bsr     Offset_0x00A914
                bcc.s   Offset_0x00A78C
                move.w  Obj_Control_Var_06(A0), Obj_Speed(A0)     ; $0010, $0032
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
                move.b  #$0E, Obj_Routine(A0)                            ; $0024
                bra     Offset_0x00A6D0
Offset_0x00A78C:
                bra     Offset_0x00A734 
;-------------------------------------------------------------------------------
Offset_0x00A790:
                bsr     Offset_0x00A914
                bpl.s   Offset_0x00A7C6
                clr.w   Obj_Speed(A0)                                    ; $0010
                clr.w   Obj_Control_Var_06(A0)                           ; $0032
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                bsr     Offset_0x00A8D4
                bsr     Offset_0x00A8FC
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x00A7C6
                move.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x00A7C6:
                bra     Offset_0x00A734     
;-------------------------------------------------------------------------------
Offset_0x00A7CA:
                bsr     Offset_0x00A914
                bpl.s   Offset_0x00A820
                move.w  Obj_Control_Var_06(A0), Obj_Speed(A0)     ; $0010, $0032
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                bra     Offset_0x00A694   
;-------------------------------------------------------------------------------
Offset_0x00A7E6:
                bsr     ObjectFall                             ; Offset_0x00D1AE
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A820
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A820
                not.b   Obj_Player_Flip_Flag(A0)                         ; $0029
                bne.s   Offset_0x00A816
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
Offset_0x00A816:
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
Offset_0x00A820:
                bra     Offset_0x00A734   
;-------------------------------------------------------------------------------
Offset_0x00A824:
                bsr     Offset_0x00A914
                bpl.s   Offset_0x00A83E
                clr.w   Obj_Speed(A0)                                    ; $0010
                clr.w   Obj_Control_Var_06(A0)                           ; $0032
                bsr     ObjectFall                             ; Offset_0x00D1AE
                bsr     Offset_0x00A8D4
                bsr     Offset_0x00A8FC
Offset_0x00A83E:
                bra     Offset_0x00A734      
;-------------------------------------------------------------------------------
Offset_0x00A842:
                bsr     Offset_0x00A914
                bpl.s   Offset_0x00A87C
                bsr     ObjectFall                             ; Offset_0x00D1AE
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A87C
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A87C
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
Offset_0x00A87C:
                bra     Offset_0x00A734  
;-------------------------------------------------------------------------------
Offset_0x00A880:
                bsr     Offset_0x00A914
                bpl.s   Offset_0x00A8D0
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A8BA
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A8BA
                not.b   Obj_Player_Flip_Flag(A0)                         ; $0029
                bne.s   Offset_0x00A8B0
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Flags(A0)                               ; $0001
Offset_0x00A8B0:
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
Offset_0x00A8BA:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x00A8D0
                move.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x00A8D0:
                bra     Offset_0x00A734
Offset_0x00A8D4:
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x00A8FA
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x00A8FA
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Control_Var_08(A0), Obj_Speed_Y(A0)   ; $0012, $0034
Offset_0x00A8FA:
                rts
Offset_0x00A8FC:
                bset    #$00, Obj_Flags(A0)                              ; $0001
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bcc.s   Offset_0x00A912
                bclr    #$00, Obj_Flags(A0)                              ; $0001
Offset_0x00A912:
                rts
Offset_0x00A914:
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                subi.w  #$00B8, D0
                rts   
;===============================================================================
; Object 0x28 - Flickies (pássaros, esquilos) que aparecem ao destruir iminigos
; <<<- 
;===============================================================================