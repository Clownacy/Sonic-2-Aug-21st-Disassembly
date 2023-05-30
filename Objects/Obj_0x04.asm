;===============================================================================
; Objeto 0x04 - Superfície da água na Hidden Palace, Chemical Plant e
; ->>>          Neo Green Hill
;===============================================================================   
; Offset_0x0159CC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0159DA(PC, D0), D1
                jmp     Offset_0x0159DA(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x0159DA:
                dc.w    Offset_0x0159E0-Offset_0x0159DA
                dc.w    Offset_0x015A20-Offset_0x0159DA
                dc.w    Offset_0x015AB2-Offset_0x0159DA         
;-------------------------------------------------------------------------------
Offset_0x0159E0:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Water_Surface_Mappings, Obj_Map(A0) ; Offset_0x015AFE, $0004
                move.w  #$8400, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_00_To_ModifySpriteAttr_2P          ; Offset_0x01639C
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$80, Obj_Width(A0)                              ; $0019
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x015A20
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #NGHz_Water_Surface_Mappings, Obj_Map(A0) ; Offset_0x015BEE, $0004
                bra     Offset_0x015AB2     
;-------------------------------------------------------------------------------
Offset_0x015A20:
                move.w  (Water_Level).w, D1                          ; $FFFFF646
                move.w  D1, Obj_Y(A0)                                    ; $000C
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                bne.s   Offset_0x015A42
                btst    #$07, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Offset_0x015A52
                addq.b  #$03, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bra.s   Offset_0x015A52
Offset_0x015A42:
                tst.w   (Pause_Status).w                             ; $FFFFF63A
                bne.s   Offset_0x015A52
                move.b  #$00, Obj_Control_Var_06(A0)                     ; $0032
                subq.b  #$03, Obj_Map_Id(A0)                             ; $001A
Offset_0x015A52:
                lea     (Water_Surface_Data), A1               ; Offset_0x015A72
                moveq   #$00, D1
                move.b  Obj_Ani_Frame(A0), D1                            ; $001B
                move.b  $00(A1, D1), Obj_Map_Id(A0)                      ; $001A
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
                andi.b  #$3F, Obj_Ani_Frame(A0)                          ; $001B
                bra     Jmp_02_To_DisplaySprite                ; Offset_0x016390  
;-------------------------------------------------------------------------------
Water_Surface_Data:                                            ; Offset_0x015A72
                dc.b    $00, $01, $00, $01, $00, $01, $00, $01
                dc.b    $00, $01, $00, $01, $00, $01, $00, $01
                dc.b    $01, $02, $01, $02, $01, $02, $01, $02
                dc.b    $01, $02, $01, $02, $01, $02, $01, $02
                dc.b    $02, $01, $02, $01, $02, $01, $02, $01
                dc.b    $02, $01, $02, $01, $02, $01, $02, $01
                dc.b    $01, $00, $01, $00, $01, $00, $01, $00
                dc.b    $01, $00, $01, $00, $01, $00, $01, $00               
;-------------------------------------------------------------------------------
Offset_0x015AB2:
                move.w  (Water_Level).w, D1                          ; $FFFFF646
                move.w  D1, Obj_Y(A0)                                    ; $000C
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                bne.s   Offset_0x015AD4
                btst    #$07, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
                beq.s   Offset_0x015AE4
                addq.b  #$02, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bra.s   Offset_0x015AFA
Offset_0x015AD4:
                tst.w   (Pause_Status).w                             ; $FFFFF63A
                bne.s   Offset_0x015AFA
                move.b  #$00, Obj_Control_Var_06(A0)                     ; $0032
                subq.b  #$02, Obj_Map_Id(A0)                             ; $001A
Offset_0x015AE4:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x015AFA
                move.b  #$05, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x015AFA:
                bra     Jmp_02_To_DisplaySprite                ; Offset_0x016390  
;-------------------------------------------------------------------------------
Water_Surface_Mappings:                                        ; Offset_0x015AFE
                dc.w    Offset_0x015B0A-Water_Surface_Mappings
                dc.w    Offset_0x015B24-Water_Surface_Mappings
                dc.w    Offset_0x015B3E-Water_Surface_Mappings
                dc.w    Offset_0x015B58-Water_Surface_Mappings
                dc.w    Offset_0x015B8A-Water_Surface_Mappings
                dc.w    Offset_0x015BBC-Water_Surface_Mappings
Offset_0x015B0A:
                dc.w    $0003
                dc.l    $F80D0000, $0000FFA0
                dc.l    $F80D0000, $0000FFE0
                dc.l    $F80D0000, $00000020
Offset_0x015B24:
                dc.w    $0003
                dc.l    $F80D0008, $0004FFA0
                dc.l    $F80D0008, $0004FFE0
                dc.l    $F80D0008, $00040020
Offset_0x015B3E:
                dc.w    $0003
                dc.l    $F80D0010, $0008FFA0
                dc.l    $F80D0010, $0008FFE0
                dc.l    $F80D0010, $00080020
Offset_0x015B58:
                dc.w    $0006
                dc.l    $F80D0000, $0000FFA0
                dc.l    $F80D0008, $0004FFC0
                dc.l    $F80D0000, $0000FFE0
                dc.l    $F80D0008, $00040000
                dc.l    $F80D0000, $00000020
                dc.l    $F80D0008, $00040040
Offset_0x015B8A:
                dc.w    $0006
                dc.l    $F80D0008, $0004FFA0
                dc.l    $F80D0010, $0008FFC0
                dc.l    $F80D0008, $0004FFE0
                dc.l    $F80D0010, $00080000
                dc.l    $F80D0008, $00040020
                dc.l    $F80D0010, $00080040
Offset_0x015BBC:
                dc.w    $0006
                dc.l    $F80D0010, $0008FFA0
                dc.l    $F80D0008, $0004FFC0
                dc.l    $F80D0010, $0008FFE0
                dc.l    $F80D0008, $00040000
                dc.l    $F80D0010, $00080020
                dc.l    $F80D0008, $00040040  
;-------------------------------------------------------------------------------
NGHz_Water_Surface_Mappings:                                   ; Offset_0x015BEE
                dc.w    Offset_0x015BF6-NGHz_Water_Surface_Mappings
                dc.w    Offset_0x015C10-NGHz_Water_Surface_Mappings
                dc.w    Offset_0x015C2A-NGHz_Water_Surface_Mappings
                dc.w    Offset_0x015C5C-NGHz_Water_Surface_Mappings
Offset_0x015BF6:
                dc.w    $0003
                dc.l    $FC0D0000, $0000FFA0
                dc.l    $FC0D0000, $0000FFE0
                dc.l    $FC0D0000, $00000020
Offset_0x015C10:
                dc.w    $0003
                dc.l    $FC0D0008, $0004FFA0
                dc.l    $FC0D0008, $0004FFE0
                dc.l    $FC0D0008, $00040020
Offset_0x015C2A:
                dc.w    $0006
                dc.l    $FC0D0000, $0000FFA0
                dc.l    $FC0D0000, $0000FFC0
                dc.l    $FC0D0000, $0000FFE0
                dc.l    $FC0D0000, $00000000
                dc.l    $FC0D0000, $00000020
                dc.l    $FC0D0000, $00000040
Offset_0x015C5C:
                dc.w    $0006
                dc.l    $FC0D0008, $0004FFA0
                dc.l    $FC0D0008, $0004FFC0
                dc.l    $FC0D0008, $0004FFE0
                dc.l    $FC0D0008, $00040000
                dc.l    $FC0D0008, $00040020
                dc.l    $FC0D0008, $00040040 
;===============================================================================
; Objeto 0x04 - Superfície da água na Hidden Palace, Chemical Plant e
; <<<-          Neo Green Hill
;===============================================================================