;===============================================================================
; Objeto 0x5C - Inimigo Masher (Piranha) na Green Hill
; ->>> 
;===============================================================================   
; Offset_0x024294:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0242A6(PC, D0), D1
                jsr     Offset_0x0242A6(PC, D1)
                bra     Jmp_24_To_MarkObjGone                  ; Offset_0x02437C
;------------------------------------------------------------------------------- 
Offset_0x0242A6:
                dc.w    Offset_0x0242AA-Offset_0x0242A6
                dc.w    Offset_0x0242E4-Offset_0x0242A6              
;-------------------------------------------------------------------------------  
Offset_0x0242AA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Masher_Mappings, Obj_Map(A0)   ; Offset_0x024342, $0004
                move.w  #$0414, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_2C_To_ModifySpriteAttr_2P          ; Offset_0x024388
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$09, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.w  #$FC00, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030  
;------------------------------------------------------------------------------- 
Offset_0x0242E4:
                lea     (Masher_Animate_Data), A1              ; Offset_0x024330
                bsr     Jmp_13_To_AnimateSprite                ; Offset_0x024382
                bsr     Jmp_17_To_SpeedToPos                   ; Offset_0x02438E
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x02430C
                move.w  D0, Obj_Y(A0)                                    ; $000C
                move.w  #$FB00, Obj_Speed_Y(A0)                          ; $0012
Offset_0x02430C:
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                subi.w  #$00C0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x02432E
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x02432E
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
Offset_0x02432E:
                rts             
;------------------------------------------------------------------------------- 
Masher_Animate_Data:                                           ; Offset_0x024330
                dc.w    Offset_0x024336-Masher_Animate_Data
                dc.w    Offset_0x02433A-Masher_Animate_Data
                dc.w    Offset_0x02433E-Masher_Animate_Data
Offset_0x024336:
                dc.b    $07, $00, $01, $FF
Offset_0x02433A:
                dc.b    $03, $00, $01, $FF
Offset_0x02433E:
                dc.b    $07, $00, $FF, $00    
;-------------------------------------------------------------------------------    
Masher_Mappings:                                               ; Offset_0x024342
                dc.w    Offset_0x024346-Masher_Mappings
                dc.w    Offset_0x024360-Masher_Mappings
Offset_0x024346:
                dc.w    $0003
                dc.l    $F0050000, $0000FFF4
                dc.l    $F0010004, $00020004
                dc.l    $0009000A, $0005FFF4
Offset_0x024360:
                dc.w    $0003
                dc.l    $F0050000, $0000FFF4
                dc.l    $F0050006, $00030002
                dc.l    $00090010, $0008FFF4
;===============================================================================
; Objeto 0x5C - Inimigo Masher (Piranha) na Green Hill
; <<<- 
;===============================================================================