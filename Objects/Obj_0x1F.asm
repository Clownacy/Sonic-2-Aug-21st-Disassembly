;===============================================================================
; Objeto 0x1F - Plataformas que desmoronam na Dust Hill / Oil Ocean
; ->>> 
;===============================================================================   
; Offset_0x009728:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x009736(PC, D0), D1
                jmp     Offset_0x009736(PC, D1)                     
;-------------------------------------------------------------------------------  
Offset_0x009736:
                dc.w    Offset_0x00973C-Offset_0x009736
                dc.w    Offset_0x0097F6-Offset_0x009736
                dc.w    Offset_0x00982E-Offset_0x009736      
;------------------------------------------------------------------------------- 
Offset_0x00973C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Collapsing_Platforms_Mappings_2, Obj_Map(A0) ; Offset_0x009C2C, $0004
                move.w  #$42B8, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$07, Obj_Control_Var_0C(A0)                     ; $0038
                move.b  #$44, Obj_Width(A0)                              ; $0019
                lea     (Collapsing_Platforms_2_Data), A4      ; Offset_0x009937
                btst    #$00, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x00977A
                lea     (Collapsing_Platforms_2_Data_2), A4    ; Offset_0x00993F
Offset_0x00977A:
                move.l  A4, Obj_Control_Var_08(A0)                       ; $0034
                cmpi.b  #$0A, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x0097A6
                move.l  #OOz_Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x009DE6, $0004
                move.w  #$639D, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$40, Obj_Width(A0)                              ; $0019
                move.l  #OOz_Collapsing_Platforms_Data, Obj_Control_Var_08(A0) ; Offset_0x009947, $0034
Offset_0x0097A6:
                cmpi.b  #$0B, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x0097CE
                move.l  #DHz_Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x009E26, $0004
                move.w  #$63F4, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.l  #DHz_Collapsing_Platforms_Data, Obj_Control_Var_08(A0) ; Offset_0x00994E, 0034
Offset_0x0097CE:
                cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x0097F6
                move.l  #NGHz_Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x009E7E, $0004
                move.w  #$4000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.l  #NGHz_Collapsing_Platforms_Data, Obj_Control_Var_08(A0) ; Offset_0x009954, $0034  
;-------------------------------------------------------------------------------
Offset_0x0097F6:
                tst.b   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x009808
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq     Offset_0x009882
                subq.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x009808:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x009818
                move.b  #$01, Obj_Control_Var_0E(A0)                     ; $003A
Offset_0x009818:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Platform_Object                        ; Offset_0x00F82C
                bra     MarkObjGone                            ; Offset_0x00D200  
;-------------------------------------------------------------------------------
Offset_0x00982E:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x009872
                tst.b   Obj_Control_Var_0E(A0)                           ; $003A
                bne.s   Offset_0x009842
                subq.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x009842:
                bsr     Offset_0x009818
                subq.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bne.s   Offset_0x009870
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x009856
                lea     (Player_Two).w, A1                           ; $FFFFB040
Offset_0x009856:
                btst    #$03, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x009870
                bclr    #$03, Obj_Status(A1)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A1)                           ; $001D
Offset_0x009870:
                rts
Offset_0x009872:
                bsr     ObjectFall                             ; Offset_0x00D1AE
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x009882:
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                bra.s   Offset_0x00988C
Offset_0x009888:
                addq.b  #$02, Obj_Map_Id(A0)                             ; $001A
Offset_0x00988C:
                move.l  Obj_Control_Var_08(A0), A4                       ; $0034
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                add.w   D0, D0
                move.l  Obj_Map(A0), A3                                  ; $0004
                adda.w  $00(A3, D0), A3
                move.w  (A3)+, D1
                subq.w  #$01, D1
                bset    #$05, Obj_Flags(A0)                              ; $0001
                move.b  Obj_Id(A0), D4                                   ; $0000
                move.b  Obj_Flags(A0), D5                                ; $0001
                move.l  A0, A1
                bra.s   Offset_0x0098BE
;-------------------------------------------------------------------------------  
Offset_0x0098B6:
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne.s   Offset_0x009904
                addq.w  #$08, A3
Offset_0x0098BE:
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  D4, Obj_Id(A1)                                   ; $0000
                move.l  A3, Obj_Map(A1)                                  ; $0004
                move.b  D5, Obj_Flags(A1)                                ; $0001
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.b  Obj_Priority(A0), Obj_Priority(A1)        ; $0018, $0018
                move.b  Obj_Width(A0), Obj_Width(A1)              ; $0019, $0019
                move.b  Obj_Height_2(A0), Obj_Height_2(A1)        ; $0016, $0016
                move.b  (A4)+, Obj_Control_Var_0C(A1)                    ; $0038
                cmpa.l  A0, A1
                bcc.s   Offset_0x009900
                bsr     DisplaySprite_A1                       ; Offset_0x00D340
Offset_0x009900:
                dbra    D1, Offset_0x0098B6
Offset_0x009904:
                bsr     DisplaySprite                          ; Offset_0x00D322
                move.w  #$00B9, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512              
;===============================================================================
; Objeto 0x1F - Plataformas que desmoronam na Dust Hill / Oil Ocean
; <<<- 
;===============================================================================