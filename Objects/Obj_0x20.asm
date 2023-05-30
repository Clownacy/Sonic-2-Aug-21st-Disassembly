;===============================================================================
; Objeto 0x20 - Bolas de fogo usadas pelo Robotnik na Hill Top
; ->>> 
;===============================================================================   
; Offset_0x017E34:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x017E42(PC, D0), D1
                jmp     Offset_0x017E42(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x017E42:
                dc.w    Offset_0x017E50-Offset_0x017E42
                dc.w    Offset_0x017EB2-Offset_0x017E42
                dc.w    Offset_0x017EC0-Offset_0x017E42
                dc.w    Offset_0x017F5A-Offset_0x017E42
                dc.w    Offset_0x017F80-Offset_0x017E42
                dc.w    Offset_0x01800E-Offset_0x017E42
                dc.w    Offset_0x01806E-Offset_0x017E42     
;------------------------------------------------------------------------------- 
Offset_0x017E50:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$08, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                move.l  #Lava_Bubble_Mappings, Obj_Map(A0) ; Offset_0x018090, $0004
                move.w  #$8416, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_05_To_ModifySpriteAttr_2P          ; Offset_0x018130
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsl.w   #$03, D0
                andi.w  #$0780, D0
                neg.w   D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lsl.w   #$04, D0
                move.w  D0, Obj_Control_Var_06(A0)                       ; $0032
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034    
;-------------------------------------------------------------------------------
Offset_0x017EB2:
                lea     (Fireball_Animate_Data), A1            ; Offset_0x018072
                bsr     Jmp_00_To_AnimateSprite                ; Offset_0x01812A
                bra     Jmp_05_To_MarkObjGone                  ; Offset_0x01811E     
;-------------------------------------------------------------------------------
Offset_0x017EC0:
                cmpi.b  #$05, Obj_Ani_Time(A0)                           ; $001E
                bne.s   Offset_0x017EF0
                bsr     Jmp_03_To_SingleObjectLoad_2           ; Offset_0x018124
                bne.s   Offset_0x017EE2
                bsr.s   Offset_0x017EFE
                bsr     Jmp_03_To_SingleObjectLoad_2           ; Offset_0x018124
                bne.s   Offset_0x017EE2
                bsr.s   Offset_0x017EFE
                neg.w   Obj_Speed(A1)                                    ; $0010
                bset    #$00, Obj_Flags(A1)                              ; $0001
Offset_0x017EE2:
                move.w  #$00AE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x017EF0:
                lea     (Fireball_Animate_Data), A1            ; Offset_0x018072
                bsr     Jmp_00_To_AnimateSprite                ; Offset_0x01812A
                bra     Jmp_05_To_MarkObjGone                  ; Offset_0x01811E
Offset_0x017EFE:
                move.b  #$20, Obj_Id(A1)                                 ; $0000
                move.b  #$08, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_Speed(A0), Obj_Speed(A1)              ; $0010, $0010
                move.w  Obj_Speed_Y(A0), Obj_Speed_Y(A1)          ; $0012, $0012
                move.b  #$08, Obj_Height_2(A1)                           ; $0016
                move.b  #$08, Obj_Width_2(A1)                            ; $0017
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$08, Obj_Width(A1)                              ; $0019
                move.b  #$8B, Obj_Col_Flags(A1)                          ; $0020
                move.w  Obj_Y(A1), Obj_Control_Var_04(A1)         ; $000C, $0030
                rts      
;-------------------------------------------------------------------------------
Offset_0x017F5A:
                subq.w  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x017F72
                move.w  Obj_Control_Var_08(A0), Obj_Control_Var_06(A0); $0032, $0034
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0001, Obj_Ani_Number(A0)                       ; $001C
Offset_0x017F72:
                lea     (Fireball_Animate_Data), A1            ; Offset_0x018072
                bsr     Jmp_00_To_AnimateSprite                ; Offset_0x01812A
                bra     Jmp_05_To_MarkObjGone                  ; Offset_0x01811E   
;-------------------------------------------------------------------------------
Offset_0x017F80:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x017F96
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x017F96:
                bsr     Jmp_03_To_SpeedToPos                   ; Offset_0x018136
                addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x017FB2
                bra     Jmp_05_To_DeleteObject                 ; Offset_0x018118
Offset_0x017FB2:
                bclr    #$01, Obj_Flags(A0)                              ; $0001
                tst.w   Obj_Speed_Y(A0)                                  ; $0012
                bmi.s   Offset_0x01800A
                bset    #$01, Obj_Flags(A0)                              ; $0001
                bsr     ObjHitFloor                            ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x01800A
                add.w   D1, Obj_Y(A0)                                    ; $000C
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.l  #Fireball_Mappings, Obj_Map(A0) ; Offset_0x0180D0, $0004
                move.w  #$839E, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_05_To_ModifySpriteAttr_2P          ; Offset_0x018130
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0009, Obj_Control_Var_06(A0)                   ; $0032
                move.b  #$03, Obj_Control_Var_0A(A0)                     ; $0036
Offset_0x01800A:
                bra     Jmp_05_To_MarkObjGone                  ; Offset_0x01811E   
;-------------------------------------------------------------------------------
Offset_0x01800E:
                subq.w  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x018060
                move.w  #$007F, Obj_Control_Var_06(A0)                   ; $0032
                subq.b  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bmi.s   Offset_0x018060
                bsr     Jmp_03_To_SingleObjectLoad_2           ; Offset_0x018124
                bne.s   Offset_0x018060
                moveq   #$00, D0
                move.w  #$000F, D1
Offset_0x01802C:
                move.l  $00(A0, D0), $00(A1, D0)
                addq.w  #$04, D0
                dbra    D1, Offset_0x01802C
                move.w  #$0009, Obj_Control_Var_06(A1)                   ; $0032
                move.w  #$0200, Obj_Ani_Number(A1)                       ; $001C
                move.w  #$000E, D0
                tst.w   Obj_Speed(A1)                                    ; $0010
                bpl.s   Offset_0x018050
                neg.w   D0
Offset_0x018050:
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.l  A1, -(A7)
                bsr     Fire_FindFloor                         ; Offset_0x01423A
                move.l  (A7)+, A1
                add.w   D1, Obj_Y(A1)                                    ; $000C
Offset_0x018060:
                lea     (Fireball_Animate_Data), A1            ; Offset_0x018072
                bsr     Jmp_00_To_AnimateSprite                ; Offset_0x01812A
                bra     Jmp_05_To_MarkObjGone                  ; Offset_0x01811E   
;-------------------------------------------------------------------------------
Offset_0x01806E:
                bra     Jmp_05_To_DeleteObject                 ; Offset_0x018118     
;-------------------------------------------------------------------------------
Fireball_Animate_Data:                                         ; Offset_0x018072
                dc.w    Offset_0x018078-Fireball_Animate_Data
                dc.w    Offset_0x01807F-Fireball_Animate_Data
                dc.w    Offset_0x018082-Fireball_Animate_Data
Offset_0x018078:
                dc.b    $0B, $02, $03, $FC, $04, $FD, $01
Offset_0x01807F:
                dc.b    $7F, $05, $FF
Offset_0x018082:
                dc.b    $05, $04, $05, $02, $03, $00, $01, $00
                dc.b    $01, $02, $03, $04, $05, $FC       
;-------------------------------------------------------------------------------
Lava_Bubble_Mappings:                                          ; Offset_0x018090
                dc.w    Offset_0x01809C-Lava_Bubble_Mappings
                dc.w    Offset_0x0180A6-Lava_Bubble_Mappings
                dc.w    Offset_0x0180B0-Lava_Bubble_Mappings
                dc.w    Offset_0x0180BA-Lava_Bubble_Mappings
                dc.w    Offset_0x0180C4-Lava_Bubble_Mappings
                dc.w    Offset_0x0180CE-Lava_Bubble_Mappings
Offset_0x01809C:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8
Offset_0x0180A6:
                dc.w    $0001
                dc.l    $F8050004, $0002FFF8
Offset_0x0180B0:
                dc.w    $0001
                dc.l    $F9050008, $0004FFF8
Offset_0x0180BA:
                dc.w    $0001
                dc.l    $F6050008, $0004FFF8
Offset_0x0180C4:
                dc.w    $0001
                dc.l    $F605000C, $0006FFF8
Offset_0x0180CE:
                dc.w    $0000                 
;-------------------------------------------------------------------------------
Fireball_Mappings:                                             ; Offset_0x0180D0
                dc.w    Offset_0x0180DC-Fireball_Mappings
                dc.w    Offset_0x0180E6-Fireball_Mappings
                dc.w    Offset_0x0180F0-Fireball_Mappings
                dc.w    Offset_0x0180FA-Fireball_Mappings
                dc.w    Offset_0x018104-Fireball_Mappings
                dc.w    Offset_0x01810E-Fireball_Mappings
Offset_0x0180DC:
                dc.w    $0001
                dc.l    $F0070000, $0000FFF8
Offset_0x0180E6:
                dc.w    $0001
                dc.l    $F0070800, $0800FFF8
Offset_0x0180F0:
                dc.w    $0001
                dc.l    $F0070008, $0004FFF8
Offset_0x0180FA:
                dc.w    $0001
                dc.l    $F0070808, $0804FFF8
Offset_0x018104:
                dc.w    $0001
                dc.l    $00050010, $0008FFF8
Offset_0x01810E:
                dc.w    $0001
                dc.l    $00050810, $0808FFF8
;===============================================================================
; Objeto 0x20 - Bolas de fogo usadas pelo Robotnik na Hill Top
; <<<- 
;===============================================================================