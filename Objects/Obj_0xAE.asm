;===============================================================================
; Objeto 0xAE - Galo do inimigo Clucker na Sky Fortress
; ->>>
;===============================================================================
; Offset_0x02A4D0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A4DE(PC, D0), D1
                jmp     Offset_0x02A4DE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02A4DE:
                dc.w    Offset_0x02A4EA-Offset_0x02A4DE
                dc.w    Offset_0x02A4EE-Offset_0x02A4DE
                dc.w    Offset_0x02A51E-Offset_0x02A4DE
                dc.w    Offset_0x02A52C-Offset_0x02A4DE
                dc.w    Offset_0x02A554-Offset_0x02A4DE
                dc.w    Offset_0x02A562-Offset_0x02A4DE     
;-------------------------------------------------------------------------------
Offset_0x02A4EA:
                bra     Object_Settings                        ; Offset_0x027EA4   
;-------------------------------------------------------------------------------
Offset_0x02A4EE:
                move.b  Obj_Routine(A0), D2                              ; $0024
                lea     (Clucker_Animate_Data), A1             ; Offset_0x02A5F2
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                cmp.b   Obj_Routine(A0), D2                              ; $0024
                bne.s   Offset_0x02A506
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A506:
                lea     Obj_Map_Id(A0), A1                               ; $001A
                clr.l   (A1)
                clr.w   Obj_Map(A1)                                      ; $0004
                move.b  #$08, (A1)
                move.b  #$06, Obj_Col_Flags(A0)                          ; $0020
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x02A51E:
                lea     (Clucker_Animate_Data_01), A1          ; Offset_0x02A5FE
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x02A52C:
                tst.b   Obj_Control_Var_00(A0)                           ; $002C
                beq.s   Offset_0x02A53A
                subq.b  #$01, Obj_Control_Var_00(A0)                     ; $002C
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A53A:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                lea     Obj_Map_Id(A0), A1                               ; $001A
                clr.l   (A1)
                clr.w   Obj_Map(A1)                                      ; $0004
                move.b  #$0B, (A1)
                bsr     Load_Clucker_Weapon                    ; Offset_0x02A5A0
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x02A554:
                lea     (Clucker_Animate_Data_02), A1          ; Offset_0x02A60A
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x02A562:
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                move.b  #$20, Obj_Control_Var_00(A0)                     ; $002C
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02A572:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x02A59E
                move.b  #$AE, Obj_Id(A1)                                 ; $0000
                move.b  #$42, Obj_Subtype(A1)                            ; $0028
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                subi.w  #$0018, Obj_Y(A1)                                ; $000C
Offset_0x02A59E:
                rts
;-------------------------------------------------------------------------------
Load_Clucker_Weapon:                                           ; Offset_0x02A5A0
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x02A5DC
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$0D, Obj_Map_Id(A1)                             ; $001A
                move.b  #$44, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                subq.w  #$08, Obj_X(A1)                                  ; $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$000B, Obj_Y(A1)                                ; $000C
                move.w  #$FE00, Obj_Speed(A1)                            ; $0010
                lea     Clucker_Weapon(PC), A2                 ; Offset_0x028D30
                move.l  A2, Obj_Timer(A1)                                ; $002A
Offset_0x02A5DC:
                rts                             
;-------------------------------------------------------------------------------
Obj_0xAD_Ptr:                                                  ; Offset_0x02A5DE
                dc.l    Clucker_Mappings                       ; Offset_0x02A61C
                dc.w    $23EE
                dc.b    $04, $04, $18, $00    
;-------------------------------------------------------------------------------
Obj_0xAE_Ptr:                                                  ; Offset_0x02A5E8
                dc.l    Clucker_Mappings                       ; Offset_0x02A61C
                dc.w    $23EE
                dc.b    $04, $05, $10, $00
;-------------------------------------------------------------------------------
Clucker_Animate_Data:                                          ; Offset_0x02A5F2
                dc.w    Offset_0x02A5F4-Clucker_Animate_Data
Offset_0x02A5F4:
                dc.b    $01, $01, $02, $03, $04, $05, $06, $07
                dc.b    $FC, $00           
;-------------------------------------------------------------------------------
Clucker_Animate_Data_01:                                       ; Offset_0x02A5FE
                dc.w    Offset_0x02A600-Clucker_Animate_Data_01
Offset_0x02A600:
                dc.b    $01, $08, $09, $0A, $0B, $0B, $0B, $0B
                dc.b    $FC, $00
;-------------------------------------------------------------------------------
Clucker_Animate_Data_02:                                       ; Offset_0x02A60A
                dc.w    Offset_0x02A60C-Clucker_Animate_Data_02
Offset_0x02A60C:
                dc.b    $03, $0A, $0B, $FC                  
;------------------------------------------------------------------------------- 
Clucker_Weapon_Animate_Data:                                   ; Offset_0x02A610
                dc.w    Offset_0x02A612-Clucker_Weapon_Animate_Data
Offset_0x02A612:
                dc.b    $03, $0D, $0E, $0F, $10, $11, $12, $13
                dc.b    $14, $FF                              
;-------------------------------------------------------------------------------    
Clucker_Mappings:                                              ; Offset_0x02A61C
                dc.w    Offset_0x02A646-Clucker_Mappings
                dc.w    Offset_0x02A650-Clucker_Mappings
                dc.w    Offset_0x02A65A-Clucker_Mappings
                dc.w    Offset_0x02A664-Clucker_Mappings
                dc.w    Offset_0x02A676-Clucker_Mappings
                dc.w    Offset_0x02A688-Clucker_Mappings
                dc.w    Offset_0x02A69A-Clucker_Mappings
                dc.w    Offset_0x02A6AC-Clucker_Mappings
                dc.w    Offset_0x02A6BE-Clucker_Mappings
                dc.w    Offset_0x02A6D8-Clucker_Mappings
                dc.w    Offset_0x02A6F2-Clucker_Mappings
                dc.w    Offset_0x02A70C-Clucker_Mappings
                dc.w    Offset_0x02A726-Clucker_Mappings
                dc.w    Offset_0x02A738-Clucker_Mappings
                dc.w    Offset_0x02A742-Clucker_Mappings
                dc.w    Offset_0x02A74C-Clucker_Mappings
                dc.w    Offset_0x02A756-Clucker_Mappings
                dc.w    Offset_0x02A760-Clucker_Mappings
                dc.w    Offset_0x02A76A-Clucker_Mappings
                dc.w    Offset_0x02A774-Clucker_Mappings
                dc.w    Offset_0x02A77E-Clucker_Mappings
Offset_0x02A646:
                dc.w    $0001
                dc.l    $0C0D0000, $0000FFF0
Offset_0x02A650:
                dc.w    $0001
                dc.l    $080D0000, $0000FFF0
Offset_0x02A65A:
                dc.w    $0001
                dc.l    $040D0000, $0000FFF0
Offset_0x02A664:
                dc.w    $0002
                dc.l    $000D0000, $0000FFF0
                dc.l    $100D0008, $0004FFF0
Offset_0x02A676:
                dc.w    $0002
                dc.l    $FC0D0000, $0000FFF0
                dc.l    $0C0D0008, $0004FFF0
Offset_0x02A688:
                dc.w    $0002
                dc.l    $F80D0000, $0000FFF0
                dc.l    $080D0008, $0004FFF0
Offset_0x02A69A:
                dc.w    $0002
                dc.l    $F40D0000, $0000FFF0
                dc.l    $040D0008, $0004FFF0
Offset_0x02A6AC:
                dc.w    $0002
                dc.l    $F00D0000, $0000FFF0
                dc.l    $000D0008, $0004FFF0
Offset_0x02A6BE:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $000D0008, $0004FFF0
                dc.l    $07000010, $0008FFEE
Offset_0x02A6D8:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $000D0008, $0004FFF0
                dc.l    $07000010, $0008FFEC
Offset_0x02A6F2:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $000D0008, $0004FFF0
                dc.l    $07000010, $0008FFEA
Offset_0x02A70C:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $000D0008, $0004FFF0
                dc.l    $07000010, $0008FFE8
Offset_0x02A726:
                dc.w    $0002
                dc.l    $F8090011, $0008FFE8
                dc.l    $F8090811, $08080000
Offset_0x02A738:
                dc.w    $0001
                dc.l    $FC000017, $000BFFFC
Offset_0x02A742:
                dc.w    $0001
                dc.l    $FC000018, $000CFFFC
Offset_0x02A74C:
                dc.w    $0001
                dc.l    $FC000019, $000CFFFC
Offset_0x02A756:
                dc.w    $0001
                dc.l    $FC001018, $100CFFFC
Offset_0x02A760:
                dc.w    $0001
                dc.l    $FC001017, $100BFFFC
Offset_0x02A76A:
                dc.w    $0001
                dc.l    $FC001818, $180CFFFC
Offset_0x02A774:
                dc.w    $0001
                dc.l    $FC000819, $080CFFFC
Offset_0x02A77E:
                dc.w    $0001
                dc.l    $FC000818, $080CFFFC 
;===============================================================================
; Objeto 0xAE - Galo do inimigo Clucker na Sky Fortress
; <<<-
;===============================================================================