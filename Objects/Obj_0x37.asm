;===============================================================================
; Objeto 0x37 - Perdendo anéis após sofrer algum dano
; ->>> 
;===============================================================================
; Offset_0x00ABD2
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00ABE0(PC, D0), D1
                jmp     Offset_0x00ABE0(PC, D1)           
;-------------------------------------------------------------------------------
Offset_0x00ABE0:
                dc.w    Offset_0x00ABEA-Offset_0x00ABE0
                dc.w    Offset_0x00ACAE-Offset_0x00ABE0
                dc.w    Offset_0x00AD00-Offset_0x00ABE0
                dc.w    Offset_0x00AD14-Offset_0x00ABE0
                dc.w    Offset_0x00AD22-Offset_0x00ABE0     
;-------------------------------------------------------------------------------   
Offset_0x00ABEA:
                move.l  A0, A1
                moveq   #$00, D5
                move.w  (Ring_Count).w, D5                           ; $FFFFFE20
                moveq   #$20, D0
                cmp.w   D0, D5
                bcs.s   Offset_0x00ABFA
                move.w  D0, D5
Offset_0x00ABFA:
                subq.w  #$01, D5
                move.w  #$0288, D4
                bra.s   Offset_0x00AC0A      
;-------------------------------------------------------------------------------
Offset_0x00AC02:
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne     Offset_0x00AC92
Offset_0x00AC0A:
                move.b  #$37, Obj_Id(A1)                                 ; $0000
                addq.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  #$08, Obj_Height_2(A1)                           ; $0016
                move.b  #$08, Obj_Width_2(A1)                            ; $0017
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  #Rings_Mappings, Obj_Map(A1)    ; Offset_0x00AEA0, $0004
                move.w  #$26BC, Obj_Art_VRAM(A1)                         ; $0002
                bsr     ModifySpriteAttr_2P_A1                 ; Offset_0x00DBDA
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$47, Obj_Col_Flags(A1)                          ; $0020
                move.b  #$08, Obj_Width(A1)                              ; $0019
                move.b  #$FF, (Object_Frame_Buffer+$0006).w          ; $FFFFFEA6
                tst.w   D4
                bmi.s   Offset_0x00AC82
                move.w  D4, D0
                bsr     CalcSine                               ; Offset_0x003282
                move.w  D4, D2
                lsr.w   #$08, D2
                asl.w   D2, D0
                asl.w   D2, D1
                move.w  D0, D2
                move.w  D1, D3
                addi.b  #$10, D4
                bcc.s   Offset_0x00AC82
                subi.w  #$0080, D4
                bcc.s   Offset_0x00AC82
                move.w  #$0288, D4
Offset_0x00AC82:
                move.w  D2, Obj_Speed(A1)                                ; $0010
                move.w  D3, Obj_Speed_Y(A1)                              ; $0012
                neg.w   D2
                neg.w   D4
                dbra    D5, Offset_0x00AC02
Offset_0x00AC92:
                move.w  #$0000, (Ring_Count).w                       ; $FFFFFE20
                move.b  #$80, (HUD_Rings_Refresh_Flag).w             ; $FFFFFE1D
                move.b  #$00, (Ring_Life_Flag).w                     ; $FFFFFE1B
                move.w  #$00C6, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512  
;-------------------------------------------------------------------------------
Offset_0x00ACAE:
                move.b  (Object_Frame_Buffer+$0007).w, Obj_Map_Id(A0) ; $FFFFFEA7; $001A
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                bmi.s   Offset_0x00ACE8
                move.b  ($FFFFFE0F).w, D0
                add.b   D7, D0
                andi.b  #$03, D0
                bne.s   Offset_0x00ACE8
                jsr     (Ring_FindFloor)                       ; Offset_0x014260
                tst.w   D1
                bpl.s   Offset_0x00ACE8
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                asr.w   #$02, D0
                sub.w   D0, Obj_Speed_Y(A0)                              ; $0012
                neg.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x00ACE8:
                tst.b   (Object_Frame_Buffer+$0006).w                ; $FFFFFEA6
                beq.s   Offset_0x00AD22
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs.s   Offset_0x00AD22
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x00AD00:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                bsr     Add_Rings                              ; Offset_0x00AB92   
;-------------------------------------------------------------------------------
Offset_0x00AD14:
                lea     (Rings_Animate_Data), A1               ; Offset_0x00AE98
                bsr     AnimateSprite                          ; Offset_0x00D372
                bra     DisplaySprite                          ; Offset_0x00D322 
;-------------------------------------------------------------------------------
Offset_0x00AD22:
                bra     DeleteObject                           ; Offset_0x00D314 
;===============================================================================
; Objeto 0x37 - Perdendo anéis após sofrer algum dano
; <<<- 
;===============================================================================