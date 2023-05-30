;===============================================================================
; Objeto 0x39 - Objeto de controle de Game Over / Time Over
; ->>>
;===============================================================================
; Offset_0x00BC44:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00BC52(PC, D0), D1
                jmp     Offset_0x00BC52(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x00BC52:
                dc.w    Offset_0x00BC58-Offset_0x00BC52
                dc.w    Offset_0x00BC9C-Offset_0x00BC52
                dc.w    Offset_0x00BCBE-Offset_0x00BC52       
;-------------------------------------------------------------------------------  
Offset_0x00BC58:
                tst.l   (PLC_Buffer).w                               ; $FFFFF680
                beq.s   Offset_0x00BC60
                rts
Offset_0x00BC60:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0050, Obj_X(A0)                                ; $0008
                btst    #$00, Obj_Map_Id(A0)                             ; $001A
                beq.s   Offset_0x00BC78
                move.w  #$01F0, Obj_X(A0)                                ; $0008
Offset_0x00BC78:
                move.w  #$00F0, Obj_Sub_Y(A0)                            ; $000A
                move.l  #Time_Over_Game_Over_Mappings, Obj_Map(A0) ; Offset_0x00C42E, $0004
                move.w  #$855E, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$00, Obj_Flags(A0)                              ; $0001
                move.b  #$00, Obj_Priority(A0)                           ; $0018    
;------------------------------------------------------------------------------- 
Offset_0x00BC9C:
                moveq   #$10, D1
                cmpi.w  #$0120, Obj_X(A0)                                ; $0008
                beq.s   Offset_0x00BCB2
                bcs.s   Offset_0x00BCAA
                neg.w   D1
Offset_0x00BCAA:
                add.w   D1, Obj_X(A0)                                    ; $0008
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00BCB2:
                move.w  #$02D0, Obj_Ani_Time(A0)                         ; $001E
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                rts                          
;------------------------------------------------------------------------------- 
Offset_0x00BCBE:
                move.b  (Control_Ports_Buffer_Data+$0001).w, D0      ; $FFFFF605
                andi.b  #$70, D0
                bne.s   Offset_0x00BCDE
                btst    #$00, Obj_Map_Id(A0)                             ; $001A
                bne.s   Offset_0x00BD02
                tst.w   Obj_Ani_Time(A0)                                 ; $001E
                beq.s   Offset_0x00BCDE
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00BCDE:
                tst.b   ($FFFFFE1A).w
                bne.s   Offset_0x00BCF8
                move.b  #gm_Continue, (Game_Mode).w             ; $14, $FFFFF600
                tst.b   ($FFFFFE18).w
                bne.s   Offset_0x00BD02
                move.b  #gm_SEGALogo, (Game_Mode).w             ; $00, $FFFFF600
                bra.s   Offset_0x00BD02
Offset_0x00BCF8:
                clr.l   ($FFFFFE38).w
                move.w  #$0001, ($FFFFFE02).w
Offset_0x00BD02:
                bra     DisplaySprite                          ; Offset_0x00D322     
;===============================================================================
; Objeto 0x39 - Objeto de controle de Game Over / Time Over
; <<<-
;===============================================================================