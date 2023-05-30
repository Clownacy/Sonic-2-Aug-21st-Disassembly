;===============================================================================
; Objeto - Inimigo "Bubble Moster"
; ->>>
;===============================================================================
; Offset_0x020E90:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x020E9E(PC, D0), D1
                jmp     Offset_0x020E9E(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x020E9E:
                dc.w    Offset_0x020EA4-Offset_0x020E9E
                dc.w    Offset_0x020EFC-Offset_0x020E9E
                dc.w    Offset_0x020F48-Offset_0x020E9E          
;------------------------------------------------------------------------------- 
Offset_0x020EA4:
                move.l  #Bubble_Monster_Mappings, Obj_Map(A0) ; Offset_0x02106C, $0004
                move.w  #$24F9, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_28_To_ModifySpriteAttr_2P          ; Offset_0x021154
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$14, Obj_Width(A0)                              ; $0019
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                move.b  #$0C, Obj_Col_Flags(A0)                          ; $0020
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$00B5, Obj_Timer(A0)                            ; $002A
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x020EFA
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x020EFA:
                rts   
;------------------------------------------------------------------------------- 
Offset_0x020EFC:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bmi.s   Offset_0x020F2E
                cmpi.w  #$005E, Obj_Timer(A0)                            ; $002A
                bne.s   Offset_0x020F12
                subi.w  #$0004, Obj_Y(A0)                                ; $000C
Offset_0x020F12:
                cmpi.w  #$0054, Obj_Timer(A0)                            ; $002A
                bne.s   Offset_0x020F20
                subi.w  #$0004, Obj_Y(A0)                                ; $000C
Offset_0x020F20:
                lea     (Bubble_Monster_Animate_Data), A1      ; Offset_0x02100C
                bsr     Jmp_09_To_AnimateSprite                ; Offset_0x02114E
                bra     Jmp_1C_To_MarkObjGone                  ; Offset_0x021148
Offset_0x020F2E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.b  #$08, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0004, Obj_Timer(A0)                            ; $002A
                bra     Jmp_1C_To_MarkObjGone                  ; Offset_0x021148  
;------------------------------------------------------------------------------- 
Offset_0x020F48:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x020F56(PC, D0), D1
                jmp     Offset_0x020F56(PC, D1)      
;-------------------------------------------------------------------------------   
Offset_0x020F56:
                dc.w    Offset_0x020F74-Offset_0x020F56
                dc.w    Offset_0x021004-Offset_0x020F56
                dc.w    Offset_0x020FF6-Offset_0x020F56       
;------------------------------------------------------------------------------- 
Offset_0x020F5C:
                dc.w    $FFFC, $FFFC, $0008, $0000, $FFFC, $0004               
;-------------------------------------------------------------------------------  
Offset_0x020F68:
                dc.w    $FFE0, $0020, $FFD0, $0020, $0020, $0020                          
;-------------------------------------------------------------------------------  
Offset_0x020F74:
                move.l  D7, -(A7)
                moveq   #$02, D7
                lea     Offset_0x020F5C(PC), A2
                lea     Offset_0x020F68(PC), A3
Offset_0x020F80:
                bsr     Jmp_07_To_SingleObjectLoad             ; Offset_0x021142
                bne.s   Offset_0x020FEA
                move.b  (A0), (A1)
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  #$02, Obj_Routine_2(A1)                          ; $0025
                move.l  #Bubble_Monster_Mappings, Obj_Map(A1) ; Offset_0x02106C, $0004
                move.w  #$24F9, Obj_Art_VRAM(A1)                         ; $0002
                bsr     Jmp_28_To_ModifySpriteAttr_2P          ; Offset_0x021154
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$14, Obj_Width(A1)                              ; $0019
                move.b  #$0C, Obj_Height_2(A1)                           ; $0016
                move.b  #$08, Obj_Width_2(A1)                            ; $0017
                move.w  Obj_X(A0), D1                                    ; $0008
                add.w   (A2)+, D1
                move.w  D1, Obj_X(A1)                                    ; $0008
                move.w  Obj_Y(A0), D1                                    ; $000C
                add.w   (A2)+, D1
                move.w  D1, Obj_Y(A1)                                    ; $000C
                move.w  (A3)+, Obj_Speed(A1)                             ; $0010
                move.w  (A3)+, Obj_Speed_Y(A1)                           ; $0012
                move.b  #$09, Obj_Map_Id(A1)                             ; $001A
                dbra    D7, Offset_0x020F80   
;-------------------------------------------------------------------------------  
Offset_0x020FEA:
                move.l  (A7)+, D7
                move.b  #$04, Obj_Routine_2(A0)                          ; $0025
                bra     Jmp_1C_To_MarkObjGone                  ; Offset_0x021148
Offset_0x020FF6:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                beq     Jmp_16_To_DeleteObject                 ; Offset_0x02113C
                bra     Jmp_1C_To_MarkObjGone                  ; Offset_0x021148 
;-------------------------------------------------------------------------------  
Offset_0x021004:
                bsr     Jmp_0F_To_SpeedToPos                   ; Offset_0x02115A
                bra     Jmp_1C_To_MarkObjGone                  ; Offset_0x021148                    
;-------------------------------------------------------------------------------
Bubble_Monster_Animate_Data:                                   ; Offset_0x02100C
                dc.w    Offset_0x02100E-Bubble_Monster_Animate_Data
Offset_0x02100E:
                dc.b    $01, $00, $00, $00, $00, $01, $01, $01
                dc.b    $01, $01, $01, $01, $00, $00, $00, $00
                dc.b    $01, $01, $01, $01, $01, $01, $01, $00
                dc.b    $00, $00, $00, $01, $01, $01, $01, $01
                dc.b    $01, $01, $02, $02, $02, $02, $02, $03
                dc.b    $03, $03, $03, $03, $04, $04, $04, $04
                dc.b    $04, $05, $05, $05, $05, $05, $06, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $06, $06, $06, $06, $06
                dc.b    $06, $06, $06, $06, $07, $07, $08, $08
                dc.b    $07, $07, $08, $08, $FF, $00      
;-------------------------------------------------------------------------------
Bubble_Monster_Mappings:                                       ; Offset_0x02106C
                dc.w    Offset_0x021080-Bubble_Monster_Mappings
                dc.w    Offset_0x02108A-Bubble_Monster_Mappings
                dc.w    Offset_0x021094-Bubble_Monster_Mappings
                dc.w    Offset_0x02109E-Bubble_Monster_Mappings
                dc.w    Offset_0x0210B8-Bubble_Monster_Mappings
                dc.w    Offset_0x0210D2-Bubble_Monster_Mappings
                dc.w    Offset_0x0210EC-Bubble_Monster_Mappings
                dc.w    Offset_0x02110E-Bubble_Monster_Mappings
                dc.w    Offset_0x021128-Bubble_Monster_Mappings
                dc.w    Offset_0x021132-Bubble_Monster_Mappings
Offset_0x021080:
                dc.w    $0001
                dc.l    $FC000000, $0000FFFC
Offset_0x02108A:
                dc.w    $0001
                dc.l    $FC000001, $0000FFFC
Offset_0x021094:
                dc.w    $0001
                dc.l    $FC040002, $0001FFF8
Offset_0x02109E:
                dc.w    $0003
                dc.l    $F8000001, $0000FFFC
                dc.l    $FC040002, $0001FFFA
                dc.l    $FC040002, $0001FFF6
Offset_0x0210B8:
                dc.w    $0003
                dc.l    $00040002, $0001FFFC
                dc.l    $00040002, $0001FFF4
                dc.l    $F8050004, $0002FFF8
Offset_0x0210D2:
                dc.w    $0003
                dc.l    $04040002, $0001FFFE
                dc.l    $04040002, $0001FFF2
                dc.l    $F6050004, $0002FFF8
Offset_0x0210EC:
                dc.w    $0004
                dc.l    $02040002, $0001FFF8
                dc.l    $04040002, $00010000
                dc.l    $04040002, $0001FFF0
                dc.l    $F5090008, $0004FFF4
Offset_0x02110E:
                dc.w    $0003
                dc.l    $F809000E, $0007FFF4
                dc.l    $FC09000E, $0007FFF8
                dc.l    $FC09000E, $0007FFF0
Offset_0x021128:
                dc.w    $0001
                dc.l    $F809000E, $0007FFF4
Offset_0x021132:
                dc.w    $0001
                dc.l    $F8050014, $000AFFF8
;===============================================================================
; Objeto - Inimigo "Bubble Moster"
; <<<-
;===============================================================================