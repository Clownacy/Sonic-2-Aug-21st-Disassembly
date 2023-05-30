;===============================================================================
; Objeto 0x3A - Tela com a pontuação e bonificação da fase
; ->>> 
;===============================================================================  
; Offset_0x00BD06:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00BD14(PC, D0), D1
                jmp     Offset_0x00BD14(PC, D1)       
;-------------------------------------------------------------------------------
Offset_0x00BD14:
                dc.w    Offset_0x00BD1C-Offset_0x00BD14
                dc.w    Offset_0x00BD78-Offset_0x00BD14
                dc.w    Offset_0x00BDC4-Offset_0x00BD14
                dc.w    Offset_0x00BE34-Offset_0x00BD14    
;-------------------------------------------------------------------------------
Offset_0x00BD1C:
                tst.l   (PLC_Buffer).w                               ; $FFFFF680
                beq.s   Offset_0x00BD24
                rts
Offset_0x00BD24:
                move.l  A0, A1
                lea     (Level_Results_Screen_Pos), A2         ; Offset_0x00BF06
                moveq   #$06, D1
Offset_0x00BD2E:
                move.b  #$3A, Obj_Id(A1)                                 ; $0000
                move.w  (A2), Obj_X(A1)                                  ; $0008
                move.w  (A2)+, Obj_Control_Var_06(A1)                    ; $0032
                move.w  (A2)+, Obj_Control_Var_04(A1)                    ; $0030
                move.w  (A2)+, Obj_Sub_Y(A1)                             ; $000A
                move.b  (A2)+, Obj_Routine(A1)                           ; $0024
                move.b  (A2)+, D0
                cmpi.b  #$06, D0
                bne.s   Offset_0x00BD54
                add.b   (Act_Id).w, D0                               ; $FFFFFE11
Offset_0x00BD54:
                move.b  D0, Obj_Map_Id(A1)                               ; $001A
                move.l  #Level_Results_Mappings, Obj_Map(A1) ; Offset_0x00C47E, $0004
                move.w  #$8580, Obj_Art_VRAM(A1)                         ; $0002
                bsr     ModifySpriteAttr_2P_A1                 ; Offset_0x00DBDA
                move.b  #$00, Obj_Flags(A1)                              ; $0001
                lea     Obj_Size(A1), A1                                 ; $0040
                dbra    D1, Offset_0x00BD2E           
;-------------------------------------------------------------------------------
Offset_0x00BD78:
                moveq   #$10, D1
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x00BDAA
                bge.s   Offset_0x00BD88
                neg.w   D1
Offset_0x00BD88:
                add.w   D1, Obj_X(A0)                                    ; $0008
Offset_0x00BD8C:                
                move.w  Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x00BD9E
                cmpi.w  #$0200, D0
                bcc.s   Offset_0x00BD9E
                rts                 
;------------------------------------------------------------------------------- 
; Offset_0x00BD9A:
                bra     DisplaySprite                          ; Offset_0x00D322 
;------------------------------------------------------------------------------- 
Offset_0x00BD9E:
                rts                                                     
;-------------------------------------------------------------------------------  
Offset_0x00BDA0:
                move.b  #$0E, Obj_Routine(A0)                            ; $0024
                bra     Offset_0x00BEB4           
;-------------------------------------------------------------------------------  
Offset_0x00BDAA:
                cmpi.b  #$0E, ($FFFFB724).w
                beq.s   Offset_0x00BDA0
                cmpi.b  #$04, Obj_Map_Id(A0)                             ; $001A
                bne.s   Offset_0x00BD8C
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $001E
Offset_0x00BDC4:
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bne.s   Offset_0x00BDCE
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x00BDCE:
                rts       
;-------------------------------------------------------------------------------
; Offset_0x00BDD0:
                bra     DisplaySprite                          ; Offset_0x00D322 
;-------------------------------------------------------------------------------  
; Offset_0x00BDD4:
                bsr     DisplaySprite                          ; Offset_0x00D322
                move.b  #$01, ($FFFFF7D6).w
                moveq   #$00, D0
                tst.w   ($FFFFF7D2).w
                beq.s   Offset_0x00BDF0
                addi.w  #$000A, D0
                subi.w  #$000A, ($FFFFF7D2).w
Offset_0x00BDF0:
                tst.w   ($FFFFF7D4).w
                beq.s   Offset_0x00BE00
                addi.w  #$000A, D0
                subi.w  #$000A, ($FFFFF7D4).w
Offset_0x00BE00:
                tst.w   D0
                bne.s   Offset_0x00BE1A
                move.w  #$00C5, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$00B4, Obj_Ani_Time(A0)                         ; $001E
Offset_0x00BE18:
                rts
Offset_0x00BE1A:
                jsr     (AddPoints)                            ; Offset_0x02D2D4
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$03, D0
                bne.s   Offset_0x00BE18
                move.w  #$00CD, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x00BE34:
                moveq   #$00, D0
                move.b  (Level_Id).w, D0                             ; $FFFFFE10
                add.w   D0, D0                      
                add.b   (Act_Id).w, D0                               ; $FFFFFE11
                add.w   D0, D0
                move.w  Level_Sequence_List(PC, D0), D0        ; Offset_0x00BE70
                move.w  D0, (Level_Id).w                             ; $FFFFFE10
                tst.w   D0
                bne.s   Offset_0x00BE56
                move.b  #gm_SEGALogo, (Game_Mode).w             ; $00, $FFFFF600
                bra.s   Offset_0x00BE6E
Offset_0x00BE56:
                clr.b   (Saved_Level_Flag).w                         ; $FFFFFE30
                tst.b   ($FFFFF7CD).w
                beq.s   Offset_0x00BE68
                move.b  #gm_SpecialStage, (Game_Mode).w         ; $10, $FFFFF600
                bra.s   Offset_0x00BE6E
Offset_0x00BE68:
                move.w  #$0001, ($FFFFFE02).w
Offset_0x00BE6E:
                rts
;-------------------------------------------------------------------------------
Level_Sequence_List:                                           ; Offset_0x00BE70
                dc.w    $0001, $0D00
                dc.w    $0000, $0000
                dc.w    $0201, $0400
                dc.w    $0000, $0000
                dc.w    $0401, $0500
                dc.w    $0F00, $0000
                dc.w    $0000, $0000
                dc.w    $0701, $0B00
                dc.w    $0801, $0A00
                dc.w    $0000, $0000
                dc.w    $0A01, $0B00
                dc.w    $0B01, $0400
                dc.w    $0C01, $0D00
                dc.w    $0D01, $0700
                dc.w    $0E01, $0F00
                dc.w    $0F01, $0000
                dc.w    $1001, $0000       
;-------------------------------------------------------------------------------   
Offset_0x00BEB4:
                moveq   #$20, D1
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x00BEDA
                bge.s   Offset_0x00BEC4
                neg.w   D1
Offset_0x00BEC4:
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x00BED8
                cmpi.w  #$0200, D0
                bcc.s   Offset_0x00BED8
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00BED8:
                rts
Offset_0x00BEDA:
                cmpi.b  #$04, Obj_Map_Id(A0)                             ; $001A
                bne     DeleteObject                           ; Offset_0x00D314
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                clr.b   ($FFFFF7CC).w
                move.w  #$009A, D0
                jmp     (Play_Music)                           ; Offset_0x00150C    
;-------------------------------------------------------------------------------
; Offset_0x00BEF6:
                addq.w  #$02, (Sonic_Level_Limits_Max_X).w           ; $FFFFEECA
                cmpi.w  #$2100, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
                beq     DeleteObject                           ; Offset_0x00D314
                rts                                                     
;-------------------------------------------------------------------------------
Level_Results_Screen_Pos:                                      ; Offset_0x00BF06
                dc.w    $0004, $0124, $00BC, $0200
                dc.w    $FEE0, $0120, $00D0, $0201
                dc.w    $040C, $014C, $00D6, $0206
                dc.w    $0520, $0120, $00EC, $0202
                dc.w    $0540, $0120, $00FC, $0203
                dc.w    $0560, $0120, $010C, $0204
                dc.w    $020C, $014C, $00CC, $0205
;===============================================================================
; Objeto 0x3A - Tela com a pontuação e bonificação da fase
; <<<- 
;===============================================================================