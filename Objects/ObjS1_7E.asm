;===============================================================================
; Objeto 0x7E - Tela com a pontuação e bonificação do Estágio Especial
; ->>>
;===============================================================================
; Offset_0x00BF3E:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00BF4C(PC, D0), D1
                jmp     Offset_0x00BF4C(PC, D1) 
;-------------------------------------------------------------------------------
Offset_0x00BF4C:
                dc.w    Offset_0x00BF62-Offset_0x00BF4C
                dc.w    Offset_0x00BFDA-Offset_0x00BF4C
                dc.w    Offset_0x00C012-Offset_0x00BF4C
                dc.w    Offset_0x00C020-Offset_0x00BF4C
                dc.w    Offset_0x00C012-Offset_0x00BF4C
                dc.w    Offset_0x00C07A-Offset_0x00BF4C
                dc.w    Offset_0x00C012-Offset_0x00BF4C
                dc.w    Offset_0x00C084-Offset_0x00BF4C
                dc.w    Offset_0x00C012-Offset_0x00BF4C
                dc.w    Offset_0x00C07A-Offset_0x00BF4C
                dc.w    Offset_0x00C0A8-Offset_0x00BF4C  
;-------------------------------------------------------------------------------
Offset_0x00BF62:
                tst.l   (PLC_Buffer).w                               ; $FFFFF680
                beq.s   Offset_0x00BF6A
                rts
Offset_0x00BF6A:
                move.l  A0, A1
                lea     (Special_Stage_Results_Screen_Pos), A2 ; Offset_0x00C0BC
                moveq   #$03, D1
                cmpi.w  #$0032, (Ring_Count).w                       ; $FFFFFE20
                bcs.s   Offset_0x00BF7E
                addq.w  #$01, D1
Offset_0x00BF7E:
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.w  (A2)+, Obj_X(A1)                                 ; $0008
                move.w  (A2)+, Obj_Control_Var_04(A1)                    ; $0030
                move.w  (A2)+, Obj_Sub_Y(A1)                             ; $000A
                move.b  (A2)+, Obj_Routine(A1)                           ; $0024
                move.b  (A2)+, Obj_Map_Id(A1)                            ; $001A
                move.l  #Special_Stage_Results_Mappings, Obj_Map(A1) ; Offset_0x00C5AA, $0004
                move.w  #$8580, Obj_Art_VRAM(A1)                         ; $0002
                bsr     ModifySpriteAttr_2P_A1                 ; Offset_0x00DBDA
                move.b  #$00, Obj_Flags(A1)                              ; $0001
                lea     Obj_Size(A1), A1                                 ; $0040
                dbra    D1, Offset_0x00BF7E
                moveq   #$07, D0
                move.b  (Emerald_Count).w, D1                        ; $FFFFFE57
                beq.s   Offset_0x00BFD6
                moveq   #$00, D0
                cmpi.b  #$06, D1
                bne.s   Offset_0x00BFD6
                moveq   #$08, D0
                move.w  #$0018, Obj_X(A0)                                ; $0008
                move.w  #$0118, Obj_Control_Var_04(A0)                   ; $0030
Offset_0x00BFD6:
                move.b  D0, Obj_Map_Id(A0)                               ; $001A  
;-------------------------------------------------------------------------------
Offset_0x00BFDA:
                moveq   #$10, D1
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x00C000
                bge.s   Offset_0x00BFEA
                neg.w   D1
Offset_0x00BFEA:
                add.w   D1, Obj_X(A0)                                    ; $0008
Offset_0x00BFEE:
                move.w  Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x00BFFE
                cmpi.w  #$0200, D0
                bcc.s   Offset_0x00BFFE
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00BFFE:
                rts
Offset_0x00C000:
                cmpi.b  #$02, Obj_Map_Id(A0)                             ; $001A
                bne.s   Offset_0x00BFEE
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $001E  
;-------------------------------------------------------------------------------
Offset_0x00C012:
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bne.s   Offset_0x00C01C
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x00C01C:
                bra     DisplaySprite                          ; Offset_0x00D322   
;-------------------------------------------------------------------------------
Offset_0x00C020:
                bsr     DisplaySprite                          ; Offset_0x00D322
                move.b  #$01, ($FFFFF7D6).w
                tst.w   ($FFFFF7D4).w
                beq.s   Offset_0x00C052
                subi.w  #$000A, ($FFFFF7D4).w
                moveq   #$0A, D0
                jsr     (AddPoints)                            ; Offset_0x02D2D4
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$03, D0
                bne.s   Offset_0x00C078
                move.w  #$00CD, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x00C052:
                move.w  #$00C5, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $001E
                cmpi.w  #$0032, (Ring_Count).w                       ; $FFFFFE20
                bcs.s   Offset_0x00C078
                move.w  #$003C, Obj_Ani_Time(A0)                         ; $001E
                addq.b  #$04, Obj_Routine(A0)                            ; $0024
Offset_0x00C078:
                rts       
;-------------------------------------------------------------------------------
Offset_0x00C07A:
                move.w  #$0001, ($FFFFFE02).w
                bra     DisplaySprite                          ; Offset_0x00D322   
;-------------------------------------------------------------------------------
Offset_0x00C084:
                move.b  #$04, ($FFFFB6DA).w
                move.b  #$14, ($FFFFB6E4).w
                move.w  #$00BF, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0168, Obj_Ani_Time(A0)                         ; $001E
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x00C0A8:
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$0F, D0
                bne.s   Offset_0x00C0B8
                bchg    #00, Obj_Map_Id(A0)                              ; $001A
Offset_0x00C0B8:
                bra     DisplaySprite                          ; Offset_0x00D322 
;-------------------------------------------------------------------------------
Special_Stage_Results_Screen_Pos:                              ; Offset_0x00C0BC 
                dc.w    $0020, $0120, $00C4, $0200
                dc.w    $0320, $0120, $0118, $0201
                dc.w    $0360, $0120, $0128, $0202
                dc.w    $01EC, $011C, $00C4, $0203
                dc.w    $03A0, $0120, $0138, $0206                   
;===============================================================================
; Objeto 0x7E - Tela com a pontuação e bonificação do Estágio Especial
; <<<-
;===============================================================================