;===============================================================================
; Objeto 0x13 - Cachoeiras na Hidden Palace
; ->>> 
;===============================================================================  
; Offset_0x0154A8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0154B6(PC, D0), D1
                jmp     Offset_0x0154B6(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0154B6:
                dc.w    Offset_0x0154BC-Offset_0x0154B6
                dc.w    Offset_0x015582-Offset_0x0154B6
                dc.w    Offset_0x01560C-Offset_0x0154B6   
;-------------------------------------------------------------------------------
Offset_0x0154BC:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #HPz_Waterfalls_Mappings, Obj_Map(A0) ; Offset_0x015624, $0004
                move.w  #$E315, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$12, Obj_Map_Id(A0)                             ; $001A
                bsr.s   Offset_0x015524
                move.b  #$A0, Obj_Height_2(A1)                           ; $0016
                bset    #$04, Obj_Flags(A1)                              ; $0001
                move.l  A1, Obj_Control_Var_0C(A0)                       ; $0038
                move.w  Obj_Y(A0), Obj_Control_Var_08(A0)         ; $000C, $0034
                move.w  Obj_Y(A0), Obj_Control_Var_0A(A0)         ; $000C, $0036
                cmpi.b  #$10, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x015568
                bsr.s   Offset_0x015524
                move.l  A1, Obj_Control_Var_10(A0)                       ; $003C
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0098, Obj_Y(A1)                                ; $000C
                bra.s   Offset_0x015568
Offset_0x015524:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x015566
                move.b  #$13, Obj_Id(A1)                                 ; $0000
                addq.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  #HPz_Waterfalls_Mappings, Obj_Map(A1) ; Offset_0x015624, $0004
                move.w  #$E315, Obj_Art_VRAM(A1)                         ; $0002
                bsr     ModifySpriteAttr_2P_A1                 ; Offset_0x00DBDA
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  #$01, Obj_Priority(A1)                           ; $0018
Offset_0x015566:
                rts
Offset_0x015568:
                moveq   #$00, D1
                move.b  Obj_Subtype(A0), D1                              ; $0028
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                subi.w  #$0078, D0
                lsl.w   #$04, D1
                add.w   D1, D0
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034 
;-------------------------------------------------------------------------------
Offset_0x015582:
                move.l  Obj_Control_Var_0C(A0), A1                       ; $0038
                move.b  #$12, Obj_Map_Id(A0)                             ; $001A
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                move.w  (Water_Level).w, D1                          ; $FFFFF646
                cmp.w   D0, D1
                bcc.s   Offset_0x01559A
                move.w  D1, D0
Offset_0x01559A:
                move.w  D0, Obj_Y(A0)                                    ; $000C
                sub.w   Obj_Control_Var_0A(A0), D0                       ; $0036
                addi.w  #$0080, D0
                bmi.s   Offset_0x0155EC
                lsr.w   #$04, D0
                move.w  D0, D1
                cmpi.w  #$000F, D0
                bcs.s   Offset_0x0155B4
                moveq   #$0F, D0
Offset_0x0155B4:
                move.b  D0, Obj_Map_Id(A1)                               ; $001A
                cmpi.b  #$10, Obj_Subtype(A0)                            ; $0028
                bcs.s   Offset_0x0155D4
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                subi.w  #$000F, D1
                bcc.s   Offset_0x0155CC
                moveq   #$00, D1
Offset_0x0155CC:
                addi.w  #$0013, D1
                move.b  D1, Obj_Map_Id(A1)                               ; $001A
Offset_0x0155D4:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_01_To_DeleteObject                 ; Offset_0x0159C6
                bra     Jmp_01_To_DisplaySprite                ; Offset_0x0159C0
Offset_0x0155EC:
                moveq   #$13, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  D0, Obj_Map_Id(A1)                               ; $001A
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_01_To_DeleteObject                 ; Offset_0x0159C6
                rts   
;-------------------------------------------------------------------------------
Offset_0x01560C:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_01_To_DeleteObject                 ; Offset_0x0159C6
                bra     Jmp_01_To_DisplaySprite                ; Offset_0x0159C0     
;-------------------------------------------------------------------------------
HPz_Waterfalls_Mappings:                                       ; Offset_0x015624
                dc.w    Offset_0x01565E-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015668-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01567A-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01568C-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0156A6-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0156C0-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0156E2-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015704-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01572E-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015758-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01578A-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0157BC-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0157F6-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015830-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015872-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0158B4-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0158FE-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0158FE-HPz_Waterfalls_Mappings
                dc.w    Offset_0x0158FE-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01565C-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015910-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01591A-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015924-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015936-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015948-HPz_Waterfalls_Mappings
                dc.w    Offset_0x015962-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01597C-HPz_Waterfalls_Mappings
                dc.w    Offset_0x01599E-HPz_Waterfalls_Mappings
Offset_0x01565C:
                dc.w    $0000
Offset_0x01565E:
                dc.w    $0001
                dc.l    $800C0010, $0008FFF0
Offset_0x015668:
                dc.w    $0002
                dc.l    $800C0010, $0008FFF0
                dc.l    $880D002D, $0016FFF0
Offset_0x01567A:
                dc.w    $0002
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
Offset_0x01568C:
                dc.w    $0003
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80D002D, $0016FFF0
Offset_0x0156A6:
                dc.w    $0003
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
Offset_0x0156C0:
                dc.w    $0004
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80D002D, $0016FFF0
Offset_0x0156E2:
                dc.w    $0004
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
Offset_0x015704:
                dc.w    $0005
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80D002D, $0016FFF0
Offset_0x01572E:
                dc.w    $0005
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
Offset_0x015758:
                dc.w    $0006
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080D002D, $0016FFF0
Offset_0x01578A:
                dc.w    $0006
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080F0000, $0000FFF0
Offset_0x0157BC:
                dc.w    $0007
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080F0000, $0000FFF0
                dc.l    $280D002D, $0016FFF0
Offset_0x0157F6:
                dc.w    $0007
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080F0000, $0000FFF0
                dc.l    $280F0000, $0000FFF0
Offset_0x015830:
                dc.w    $0008
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080F0000, $0000FFF0
                dc.l    $280F0000, $0000FFF0
                dc.l    $480D002D, $0016FFF0
Offset_0x015872:
                dc.w    $0008
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080F0000, $0000FFF0
                dc.l    $280F0000, $0000FFF0
                dc.l    $480F0000, $0000FFF0
Offset_0x0158B4:
                dc.w    $0009
                dc.l    $800C0010, $0008FFF0
                dc.l    $880F0000, $0000FFF0
                dc.l    $A80F0000, $0000FFF0
                dc.l    $C80F0000, $0000FFF0
                dc.l    $E80F0000, $0000FFF0
                dc.l    $080F0000, $0000FFF0
                dc.l    $280F0000, $0000FFF0
                dc.l    $480F0000, $0000FFF0
                dc.l    $680D002D, $0016FFF0
Offset_0x0158FE:
                dc.w    $0002
                dc.l    $F00A0018, $000CFFE8
                dc.l    $F00A0818, $080C0000
Offset_0x015910:
                dc.w    $0001
                dc.l    $E00D002D, $0016FFF0
Offset_0x01591A:
                dc.w    $0001
                dc.l    $E00F0000, $0000FFF0
Offset_0x015924:
                dc.w    $0002
                dc.l    $E00F0000, $0000FFF0
                dc.l    $000D002D, $0016FFF0
Offset_0x015936:
                dc.w    $0002
                dc.l    $E00F0000, $0000FFF0
                dc.l    $000F0000, $0000FFF0
Offset_0x015948:
                dc.w    $0003
                dc.l    $E00F0000, $0000FFF0
                dc.l    $000F0000, $0000FFF0
                dc.l    $200D002D, $0016FFF0
Offset_0x015962:
                dc.w    $0003
                dc.l    $E00F0000, $0000FFF0
                dc.l    $000F0000, $0000FFF0
                dc.l    $200F0000, $0000FFF0
Offset_0x01597C:
                dc.w    $0004
                dc.l    $E00F0000, $0000FFF0
                dc.l    $000F0000, $0000FFF0
                dc.l    $200F0000, $0000FFF0
                dc.l    $400D002D, $0016FFF0
Offset_0x01599E:
                dc.w    $0004
                dc.l    $E00F0000, $0000FFF0
                dc.l    $000F0000, $0000FFF0
                dc.l    $200F0000, $0000FFF0
                dc.l    $400F0000, $0000FFF0          
;===============================================================================
; Objeto 0x13 - Cachoeiras na Hidden Palace
; <<<- 
;===============================================================================