;===============================================================================
; Objeto 0x58 - Robotnik na Green Hill
; ->>>
;===============================================================================   
; Offset_0x020372:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x020380(PC, D0), D1
                jmp     Offset_0x020380(PC, D1)                           
;-------------------------------------------------------------------------------
Offset_0x020380:
                dc.w    Offset_0x020384-Offset_0x020380
                dc.w    Offset_0x0203CA-Offset_0x020380      
;-------------------------------------------------------------------------------
Offset_0x020384:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #GHz_Boss_Mappings_02, Obj_Map(A0) ; Offset_0x020430, $0004
                move.w  #$0580, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_27_To_ModifySpriteAttr_2P          ; Offset_0x02050E
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$0C, Obj_Width(A0)                              ; $0019
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$00C4, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512  
;-------------------------------------------------------------------------------   
Offset_0x0203C8:
                rts      
;-------------------------------------------------------------------------------
Offset_0x0203CA:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x0203E4
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$07, Obj_Map_Id(A0)                             ; $001A
                beq     Jmp_14_To_DeleteObject                 ; Offset_0x020502
Offset_0x0203E4:
                bra     Jmp_13_To_DisplaySprite                ; Offset_0x0204FC    
;-------------------------------------------------------------------------------
GHz_Boss_Mappings:                                             ; Offset_0x0203E8
                dc.w    Offset_0x0203EC-GHz_Boss_Mappings
                dc.w    Offset_0x0203F6-GHz_Boss_Mappings
Offset_0x0203EC:
                dc.w    $0001
                dc.l    $00050000, $0000001C
Offset_0x0203F6:
                dc.w    $0001
                dc.l    $00050004, $0002001C     
;-------------------------------------------------------------------------------
GHz_Boss_Mappings_01:                                          ; Offset_0x020400
                dc.w    Offset_0x020408-GHz_Boss_Mappings_01
                dc.w    Offset_0x020412-GHz_Boss_Mappings_01
                dc.w    Offset_0x02041C-GHz_Boss_Mappings_01
                dc.w    Offset_0x020426-GHz_Boss_Mappings_01
Offset_0x020408:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8
Offset_0x020412:
                dc.w    $0001
                dc.l    $F8050004, $0002FFF8
Offset_0x02041C:
                dc.w    $0001
                dc.l    $F8050008, $0004FFF8
Offset_0x020426:
                dc.w    $0001
                dc.l    $F805000C, $0006FFF8   
;-------------------------------------------------------------------------------
GHz_Boss_Mappings_02:                                          ; Offset_0x020430
                dc.w    Offset_0x02043E-GHz_Boss_Mappings_02
                dc.w    Offset_0x020448-GHz_Boss_Mappings_02
                dc.w    Offset_0x020452-GHz_Boss_Mappings_02
                dc.w    Offset_0x02045C-GHz_Boss_Mappings_02
                dc.w    Offset_0x020466-GHz_Boss_Mappings_02
                dc.w    Offset_0x020470-GHz_Boss_Mappings_02
                dc.w    Offset_0x02047A-GHz_Boss_Mappings_02
Offset_0x02043E:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8
Offset_0x020448:
                dc.w    $0001
                dc.l    $F00F0004, $0002FFF0
Offset_0x020452:
                dc.w    $0001
                dc.l    $F00F0014, $000AFFF0
Offset_0x02045C:
                dc.w    $0001
                dc.l    $F00F0024, $0012FFF0
Offset_0x020466:
                dc.w    $0001
                dc.l    $F00F0034, $001AFFF0
Offset_0x020470:
                dc.w    $0001
                dc.l    $F00F0044, $0022FFF0
Offset_0x02047A:
                dc.w    $0001
                dc.l    $F00F0054, $002AFFF0   
;-------------------------------------------------------------------------------
GHz_Boss_Animate_Data:                                        ; OOffset_0x020484
                dc.w    Offset_0x020488-GHz_Boss_Animate_Data
                dc.w    Offset_0x02048B-GHz_Boss_Animate_Data
Offset_0x020488:
                dc.b    $0F, $00, $FF
Offset_0x02048B:
                dc.b    $07, $01, $02, $FF, $00   
;-------------------------------------------------------------------------------
GHz_Boss_Mappings_03:                                          ; Offset_0x020490
                dc.w    Offset_0x020496-GHz_Boss_Mappings_03
                dc.w    Offset_0x0204B8-GHz_Boss_Mappings_03
                dc.w    Offset_0x0204DA-GHz_Boss_Mappings_03
Offset_0x020496:
                dc.w    $0004
                dc.l    $F8050000, $0000FFE0
                dc.l    $08050004, $0002FFE0
                dc.l    $F80F0008, $0004FFF0
                dc.l    $F8070018, $000C0010
Offset_0x0204B8:
                dc.w    $0004
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0030, $0018FFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
Offset_0x0204DA:
                dc.w    $0004
                dc.l    $E8050028, $0014FFE0
                dc.l    $E80D0038, $001CFFF0
                dc.l    $E8050024, $00120010
                dc.l    $D8050020, $00100002
;===============================================================================
; Objeto 0x58 - Robotnik na Green Hill
; ->>>
;===============================================================================