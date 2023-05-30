;===============================================================================
; Objeto 0x99 - Inimigo Nebula na Sky Chase  (Joga bombas no jogador)
; ->>>
;===============================================================================
; Offset_0x028DA2:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x028DB0(PC, D0), D1
                jmp     Offset_0x028DB0(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x028DB0:
                dc.w    Offset_0x028DB6-Offset_0x028DB0
                dc.w    Offset_0x028DC2-Offset_0x028DB0
                dc.w    Offset_0x028DF2-Offset_0x028DB0         
;-------------------------------------------------------------------------------
Offset_0x028DB6:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FFC0, Obj_Speed(A0)                            ; $0010
                rts       
;-------------------------------------------------------------------------------
Offset_0x028DC2:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D0
                bne.s   Offset_0x028DD4
                cmpi.w  #$0080, D0
                bcc.s   Offset_0x028DD4
                bsr     Offset_0x028DE6
Offset_0x028DD4:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Nebula_Animate_Data), A1              ; Offset_0x028E64
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028DE6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$FF40, Obj_Speed_Y(A0)                          ; $0012
                rts    
;-------------------------------------------------------------------------------
Offset_0x028DF2:
                tst.b   Obj_Timer(A0)                                    ; $002A
                bne.s   Offset_0x028E0A
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                addi.w  #$0008, D2
                cmpi.w  #$0010, D2
                bcc.s   Offset_0x028E0A
                bsr     Offset_0x028E22
Offset_0x028E0A:
                addi.w  #$0001, Obj_Speed_Y(A0)                          ; $0012
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Nebula_Animate_Data), A1              ; Offset_0x028E64
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x028E22:
                st      Obj_Timer(A0)                                    ; $002A
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x028E58
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Map_Id(A1)                             ; $001A
                move.b  #$14, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0018, Obj_Y(A1)                                ; $000C
                lea     Nebula_Weapon(PC), A2                  ; Offset_0x028D0C
                move.l  A2, Obj_Timer(A1)                                ; $002A
Offset_0x028E58:
                rts       
;-------------------------------------------------------------------------------
Obj_0x99_Ptr:                                                  ; Offset_0x028E5A
                dc.l    Nebula_Mappings                        ; Offset_0x028E6C
                dc.w    $243C
                dc.b    $04, $04, $10, $06                           
;-------------------------------------------------------------------------------  
Nebula_Animate_Data:                                           ; Offset_0x028E64
                dc.w    Offset_0x028E66-Nebula_Animate_Data
Offset_0x028E66:
                dc.b    $03, $00, $01, $02, $03, $FF     
;-------------------------------------------------------------------------------  
Nebula_Mappings:                                               ; Offset_0x028E6C
                dc.w    Offset_0x028E76-Nebula_Mappings
                dc.w    Offset_0x028E98-Nebula_Mappings
                dc.w    Offset_0x028EBA-Nebula_Mappings
                dc.w    Offset_0x028EDC-Nebula_Mappings
                dc.w    Offset_0x028EFE-Nebula_Mappings
Offset_0x028E76:
                dc.w    $0004
                dc.l    $EC080012, $0009FFE8
                dc.l    $EC081812, $18090000
                dc.l    $EC040000, $0000FFF8
                dc.l    $F40F0002, $0001FFF0
Offset_0x028E98:
                dc.w    $0004
                dc.l    $EC040015, $000AFFF0
                dc.l    $EC041815, $180A0000
                dc.l    $EC040000, $0000FFF8
                dc.l    $F40F0002, $0001FFF0
Offset_0x028EBA:
                dc.w    $0004
                dc.l    $EC000017, $000BFFF8
                dc.l    $EC000817, $080B0000
                dc.l    $EC040000, $0000FFF8
                dc.l    $F40F0002, $0001FFF0
Offset_0x028EDC:
                dc.w    $0004
                dc.l    $EC041015, $100AFFF0
                dc.l    $EC040815, $080A0000
                dc.l    $EC040000, $0000FFF8
                dc.l    $F40F0002, $0001FFF0
Offset_0x028EFE:
                dc.w    $0001
                dc.l    $F8050018, $000CFFF8  
;===============================================================================
; Objeto 0x99 - Inimigo Nebula na Sky Chase  (Joga bombas no jogador)
; <<<-
;===============================================================================