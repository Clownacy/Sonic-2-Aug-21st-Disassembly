;===============================================================================
; Objeto 0x05 - Rabo do Miles
; ->>> 
;===============================================================================   
; Offset_0x012442:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x012450(PC, D0), D1
                jmp     Offset_0x012450(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x012450:
                dc.w    Offset_0x012454-Offset_0x012450
                dc.w    Offset_0x01247C-Offset_0x012450  
;-------------------------------------------------------------------------------
Offset_0x012454:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Miles_Mappings, Obj_Map(A0)    ; Offset_0x0739E2, $0004
                move.w  #$07B0, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Flags(A0)                              ; $0001   
;-------------------------------------------------------------------------------
Offset_0x01247C:                
                move.b  ($FFFFB066).w, Obj_Angle(A0)                     ; $0026
                move.b  ($FFFFB062).w, Obj_Status(A0)                    ; $0022
                move.w  (Player_Two_Position_X).w, Obj_X(A0)         ; $FFFFB048; $0008
                move.w  (Player_Two_Position_Y).w, Obj_Y(A0)         ; $FFFFB04C; $000C
                moveq   #$00, D0
                move.b  ($FFFFB05C).w, D0
                btst    #$05, ($FFFFB062).w
                beq.s   Offset_0x0124A4
                moveq   #$04, D0
Offset_0x0124A4:
                cmp.b   Obj_P_Invunerblt_Time(A0), D0                    ; $0030
                beq.s   Offset_0x0124B4
                move.b  D0, Obj_P_Invunerblt_Time(A0)                    ; $0030
                move.b  Offset_0x0124CA(PC, D0), Obj_Ani_Number(A0)      ; $001C
Offset_0x0124B4:
                lea     (Offset_0x0124EC), A1
                bsr     Miles_Animate_A1                       ; Offset_0x012016
                bsr     Load_Miles_Tail_Dynamic_PLC            ; Offset_0x0123C6
                jsr     (DisplaySprite)                        ; Offset_0x00D322
                rts              
;-------------------------------------------------------------------------------
Offset_0x0124CA:
                dc.b    $00, $00, $03, $03, $09, $01, $00, $02
                dc.b    $01, $07, $00, $00, $00, $08, $00, $00
                dc.b    $00, $00, $00, $00, $0A, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00    
;-------------------------------------------------------------------------------
Offset_0x0124EC:
                dc.w    Offset_0x012502-Offset_0x0124EC
                dc.w    Offset_0x012505-Offset_0x0124EC
                dc.w    Offset_0x01250C-Offset_0x0124EC
                dc.w    Offset_0x012514-Offset_0x0124EC
                dc.w    Offset_0x01251A-Offset_0x0124EC
                dc.w    Offset_0x012520-Offset_0x0124EC
                dc.w    Offset_0x012526-Offset_0x0124EC
                dc.w    Offset_0x01252C-Offset_0x0124EC
                dc.w    Offset_0x012532-Offset_0x0124EC
                dc.w    Offset_0x012538-Offset_0x0124EC
                dc.w    Offset_0x01253E-Offset_0x0124EC
Offset_0x012502:
                dc.b    $20, $00, $FF
Offset_0x012505:
                dc.b    $07, $09, $0A, $0B, $0C, $0D, $FF
Offset_0x01250C:
                dc.b    $03, $09, $0A, $0B, $0C, $0D, $FD, $01
Offset_0x012514:
                dc.b    $FC, $49, $4A, $4B, $4C, $FF
Offset_0x01251A:
                dc.b    $03, $4D, $4E, $4F, $50, $FF
Offset_0x012520:
                dc.b    $03, $51, $52, $53, $54, $FF
Offset_0x012526:
                dc.b    $03, $55, $56, $57, $58, $FF
Offset_0x01252C:
                dc.b    $02, $81, $82, $83, $84, $FF
Offset_0x012532:
                dc.b    $02, $87, $88, $89, $8A, $FF
Offset_0x012538:
                dc.b    $09, $87, $88, $89, $8A, $FF
Offset_0x01253E:
                dc.b    $09, $81, $82, $83, $84, $FF            
;===============================================================================
; Objeto 0x05 - Rabo do Miles
; <<<- 
;===============================================================================