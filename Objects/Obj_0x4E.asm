;===============================================================================
; Objeto 0x4E - Crocobot - Inimigo crocodilo na Hidden Palace
; ->>> 
;===============================================================================
; Offset_0x021160:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02116E(PC, D0), D1
                jmp     Offset_0x02116E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02116E:
                dc.w    Offset_0x021172-Offset_0x02116E
                dc.w    Offset_0x0211C2-Offset_0x02116E       
;-------------------------------------------------------------------------------
Offset_0x021172:
                move.l  #Crocobot_Mappings, Obj_Map(A0) ; Offset_0x021290, $0004
                move.w  #$2300, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                bsr     Jmp_03_To_ObjectFall                   ; Offset_0x02144C
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x0211C0
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x0211C0:
                rts  
;-------------------------------------------------------------------------------
Offset_0x0211C2:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0211DE(PC, D0), D1
                jsr     Offset_0x0211DE(PC, D1)
                lea     (Crocobot_Animate_Data), A1            ; Offset_0x021276
                bsr     Jmp_0A_To_AnimateSprite                ; Offset_0x021446
                bra     Jmp_1D_To_MarkObjGone                  ; Offset_0x021440    
;-------------------------------------------------------------------------------
Offset_0x0211DE:
                dc.w    Offset_0x0211E2-Offset_0x0211DE
                dc.w    Offset_0x021206-Offset_0x0211DE             
;-------------------------------------------------------------------------------
Offset_0x0211E2:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bpl.s   Offset_0x021204
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$FF40, Obj_Speed(A0)                            ; $0010
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                bchg    #00, Obj_Status(A0)                              ; $0022
                bne.s   Offset_0x021204
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x021204:
                rts   
;-------------------------------------------------------------------------------
Offset_0x021206:
                bsr     Offset_0x02123E
                bsr     Jmp_10_To_SpeedToPos                   ; Offset_0x021452
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFF8, D1
                blt.s   Offset_0x021226
                cmpi.w  #$000C, D1
                bge.s   Offset_0x021226
                add.w   D1, Obj_Y(A0)                                    ; $000C
                rts
Offset_0x021226:
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$003B, Obj_Control_Var_04(A0)                   ; $0030
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x02123E:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bmi.s   Offset_0x021258           
                cmpi.w  #$0040, D0
                bgt.s   Offset_0x02126E
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x021266
                rts
Offset_0x021258:
                cmpi.w  #$FFC0, D0
                blt.s   Offset_0x02126E
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x02126E
Offset_0x021266:
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x02126E:
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts                          
;-------------------------------------------------------------------------------
Crocobot_Animate_Data:                                         ; Offset_0x021276
                dc.w    Offset_0x02127C-Crocobot_Animate_Data
                dc.w    Offset_0x021284-Crocobot_Animate_Data
                dc.w    Offset_0x021287-Crocobot_Animate_Data
Offset_0x02127C:
                dc.b    $03, $00, $04, $02, $03, $01, $05, $FF
Offset_0x021284:
                dc.b    $0F, $00, $FF
Offset_0x021287:
                dc.b    $03, $06, $0A, $08, $09, $07, $0B, $FF
                dc.b    $00                                     
;-------------------------------------------------------------------------------
Crocobot_Mappings:                                             ; Offset_0x021290
                dc.w    Offset_0x0212A8-Crocobot_Mappings
                dc.w    Offset_0x0212CA-Crocobot_Mappings
                dc.w    Offset_0x0212EC-Crocobot_Mappings
                dc.w    Offset_0x02130E-Crocobot_Mappings
                dc.w    Offset_0x021330-Crocobot_Mappings
                dc.w    Offset_0x021352-Crocobot_Mappings
                dc.w    Offset_0x021374-Crocobot_Mappings
                dc.w    Offset_0x021396-Crocobot_Mappings
                dc.w    Offset_0x0213B8-Crocobot_Mappings
                dc.w    Offset_0x0213DA-Crocobot_Mappings
                dc.w    Offset_0x0213FC-Crocobot_Mappings
                dc.w    Offset_0x02141E-Crocobot_Mappings
Offset_0x0212A8:
                dc.w    $0004
                dc.l    $F80E0000, $0000FFE4
                dc.l    $F8050018, $000C0004
                dc.l    $0001001C, $000E0004
                dc.l    $00050020, $0010000C
Offset_0x0212CA:
                dc.w    $0004
                dc.l    $F80E0000, $0000FFE4
                dc.l    $F8050018, $000C0004
                dc.l    $0001001C, $000E0004
                dc.l    $00050024, $0012000C
Offset_0x0212EC:
                dc.w    $0004
                dc.l    $F80E0000, $0000FFE4
                dc.l    $F8050018, $000C0004
                dc.l    $0001001C, $000E0004
                dc.l    $00050028, $0014000C
Offset_0x02130E:
                dc.w    $0004
                dc.l    $F80E0000, $0000FFE4
                dc.l    $F8050018, $000C0004
                dc.l    $0001001E, $000F0004
                dc.l    $00050020, $0010000C
Offset_0x021330:
                dc.w    $0004
                dc.l    $F80E0000, $0000FFE4
                dc.l    $F8050018, $000C0004
                dc.l    $0001001E, $000F0004
                dc.l    $00050024, $0012000C
Offset_0x021352:
                dc.w    $0004
                dc.l    $F80E0000, $0000FFE4
                dc.l    $F8050018, $000C0004
                dc.l    $0001001E, $000F0004
                dc.l    $00050028, $0014000C
Offset_0x021374:
                dc.w    $0004
                dc.l    $F00B000C, $0006FFEC
                dc.l    $F8050018, $000C0004
                dc.l    $0001001C, $000E0004
                dc.l    $00050020, $0010000C
Offset_0x021396:
                dc.w    $0004
                dc.l    $F00B000C, $0006FFEC
                dc.l    $F8050018, $000C0004
                dc.l    $0001001C, $000E0004
                dc.l    $00050024, $0012000C
Offset_0x0213B8:
                dc.w    $0004
                dc.l    $F00B000C, $0006FFEC
                dc.l    $F8050018, $000C0004
                dc.l    $0001001C, $000E0004
                dc.l    $00050028, $0014000C
Offset_0x0213DA:
                dc.w    $0004
                dc.l    $F00B000C, $0006FFEC
                dc.l    $F8050018, $000C0004
                dc.l    $0001001E, $000F0004
                dc.l    $00050020, $0010000C
Offset_0x0213FC:
                dc.w    $0004
                dc.l    $F00B000C, $0006FFEC
                dc.l    $F8050018, $000C0004
                dc.l    $0001001E, $000F0004
                dc.l    $00050024, $0012000C
Offset_0x02141E:
                dc.w    $0004
                dc.l    $F00B000C, $0006FFEC
                dc.l    $F8050018, $000C0004
                dc.l    $0001001E, $000F0004
                dc.l    $00050028, $0014000C 
;===============================================================================
; Objeto 0x4E - Crocobot - Inimigo crocodilo na Hidden Palace
; <<<- 
;===============================================================================