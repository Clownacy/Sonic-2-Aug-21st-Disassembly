;===============================================================================
; Objeto 0x95 - Inimigo Sol na Hill Top (Possui 4 Bolas de fogo girando em
; ->>>          torno de si e atira no jogador ao se aproximar)
;===============================================================================
; Offset_0x0286FA:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x028708(PC, D0), D1
                jmp     Offset_0x028708(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x028708:
                dc.w    Offset_0x028712-Offset_0x028708
                dc.w    Offset_0x0287D8-Offset_0x028708
                dc.w    Offset_0x028820-Offset_0x028708
                dc.w    Offset_0x028838-Offset_0x028708
                dc.w    Offset_0x0288B4-Offset_0x028708   
;-------------------------------------------------------------------------------
Offset_0x028712:
                move.l  #Sol_Mappings, Obj_Map(A0)      ; Offset_0x0288E2, $0004
                move.w  #$0000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_2F_To_ModifySpriteAttr_2P          ; Offset_0x02A7B2
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$0B, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$0C, Obj_Width(A0)                              ; $0019
                move.w  #$FFC0, Obj_Speed(A0)                            ; $0010
                moveq   #$00, D2
                lea     Obj_Control_Var_0B(A0), A2                       ; $0037
                move.l  A2, A3
                addq.w  #$01, A2
                moveq   #$03, D1
Offset_0x02874E:
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x0287AA
                addq.b  #$01, (A3)
                move.w  A1, D5
                subi.w  #Obj_Memory_Address, D5                          ; $B000
                lsr.w   #$06, D5
                andi.w  #$007F, D5
                move.b  D5, (A2)+
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$08, Obj_Width(A1)                              ; $0019
                move.b  #$03, Obj_Map_Id(A1)                             ; $001A
                move.b  #$98, Obj_Col_Flags(A1)                          ; $0020
                move.b  D2, Obj_Angle(A1)                                ; $0026
                addi.b  #$40, D2
                move.l  A0, Obj_Control_Var_10(A1)                       ; $003C
                dbra    D1, Offset_0x02874E
Offset_0x0287AA:
                moveq   #$01, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0287B6
                neg.w   D0
Offset_0x0287B6:
                move.b  D0, Obj_Control_Var_0A(A0)                       ; $0036
                move.b  Obj_Subtype(A0), Obj_Routine(A0)          ; $0024, $0028
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$FFC0, Obj_Speed(A0)                            ; $0010
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x0287D6
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x0287D6:
                rts 
;-------------------------------------------------------------------------------
Offset_0x0287D8:
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                bcc.s   Offset_0x0287E4
                neg.w   D0
Offset_0x0287E4:
                cmpi.w  #$00A0, D0
                bcc.s   Offset_0x028808
                move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
                sub.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x0287F6
                neg.w   D0
Offset_0x0287F6:
                cmpi.w  #$0050, D0
                bcc.s   Offset_0x028808
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x028808
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
Offset_0x028808:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Sol_Animate_Data), A1                 ; Offset_0x0288CE
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                andi.b  #$03, Obj_Map_Id(A0)                             ; $001A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------
Offset_0x028820:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Sol_Animate_Data_01), A1              ; Offset_0x0288DC
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                andi.b  #$03, Obj_Map_Id(A0)                             ; $001A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------
Offset_0x028838:
                lea     (Sol_Animate_Data_01), A1              ; Offset_0x0288DC
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                cmpi.b  #$95, Obj_Id(A1)                                 ; $0000
                bne     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                cmpi.b  #$02, Obj_Map_Id(A1)                             ; $001A
                bne.s   Offset_0x02888A
                cmpi.b  #$40, Obj_Angle(A0)                              ; $0026
                bne.s   Offset_0x02888A
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                subq.b  #$01, Obj_Control_Var_0B(A1)                     ; $0037
                bne.s   Offset_0x028874
                addq.b  #$02, Obj_Routine(A1)                            ; $0024
Offset_0x028874:
                move.w  #$FE00, Obj_Speed(A0)                            ; $0010
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x028886
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x028886:
                bra     Jmp_1F_To_DisplaySprite                ; Offset_0x02A78E
Offset_0x02888A:
                move.b  Obj_Angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x003282
                asr.w   #$04, D1
                add.w   Obj_X(A1), D1                                    ; $0008
                move.w  D1, Obj_X(A0)                                    ; $0008
                asr.w   #$04, D0
                add.w   Obj_Y(A1), D0                                    ; $000C
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.b  Obj_Control_Var_0A(A1), D0                       ; $0036
                add.b   D0, Obj_Angle(A0)                                ; $0026
                bra     Jmp_1F_To_DisplaySprite                ; Offset_0x02A78E  
;-------------------------------------------------------------------------------
Offset_0x0288B4:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                lea     (Sol_Animate_Data_01), A1              ; Offset_0x0288DC
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_1F_To_DisplaySprite                ; Offset_0x02A78E   
;-------------------------------------------------------------------------------      
Sol_Animate_Data:                                              ; Offset_0x0288CE
                dc.w    Offset_0x0288D2-Sol_Animate_Data
                dc.w    Offset_0x0288D6-Sol_Animate_Data
Offset_0x0288D2:
                dc.b    $0F, $00, $FF, $00
Offset_0x0288D6:
                dc.b    $0F, $01, $02, $FE, $01, $00 
;-------------------------------------------------------------------------------  
Sol_Animate_Data_01:                                           ; Offset_0x0288DC
                dc.w    Offset_0x0288DE-Sol_Animate_Data_01
Offset_0x0288DE:
                dc.b    $05, $03, $04, $FF       
;------------------------------------------------------------------------------- 
Sol_Mappings:                                                  ; Offset_0x0288E2
                dc.w    Offset_0x0288EC-Sol_Mappings
                dc.w    Offset_0x0288F6-Sol_Mappings
                dc.w    Offset_0x028900-Sol_Mappings
                dc.w    Offset_0x02890A-Sol_Mappings
                dc.w    Offset_0x028914-Sol_Mappings
Offset_0x0288EC:
                dc.w    $0001
                dc.l    $F80503DE, $01EFFFF8
Offset_0x0288F6:
                dc.w    $0001
                dc.l    $F80503DE, $01EFFFF8
Offset_0x028900:
                dc.w    $0001
                dc.l    $F80503DE, $01EFFFF8
Offset_0x02890A:
                dc.w    $0001
                dc.l    $F80583AE, $81E7FFF8
Offset_0x028914:
                dc.w    $0001
                dc.l    $F8058BAE, $8DE7FFF8   
;===============================================================================
; Objeto 0x95 - Inimigo Sol na Hill Top (Possui 4 Bolas de fogo girando em
; <<<-          torno de si e atira no jogador ao se aproximar)
;===============================================================================