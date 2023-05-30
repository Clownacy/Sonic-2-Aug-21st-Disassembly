;===============================================================================
; Objeto - Inimigo "Spinning Ball"
; ->>>
;===============================================================================
; Offset_0x01F8F0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01F8FE(PC, D0), D1
                jmp     Offset_0x01F8FE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01F8FE:
                dc.w    Offset_0x01F902-Offset_0x01F8FE
                dc.w    Offset_0x01F950-Offset_0x01F8FE  
;-------------------------------------------------------------------------------
Offset_0x01F902:
                move.l  #Spinning_Ball_Mappings, Obj_Map(A0) ; Offset_0x01F9C8, $0004
                move.w  #$04C6, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_26_To_ModifySpriteAttr_2P          ; Offset_0x01FA04
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$14, Obj_Width(A0)                              ; $0019
                move.b  #$0C, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                move.b  #$0C, Obj_Col_Flags(A0)                          ; $0020
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$40, Obj_Angle(A0)                              ; $0026
                move.w  #$FF00, Obj_Speed(A0)                            ; $0010
                move.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
                rts                                                            
;-------------------------------------------------------------------------------
Offset_0x01F950:
                bsr     Jmp_01_To_ObjectFall                   ; Offset_0x01FA10
                bsr     Offset_0x01F966
                lea     (Spinning_Ball_Animate_Data), A1       ; Offset_0x01F9C0
                bsr     Jmp_05_To_AnimateSprite                ; Offset_0x01F9F2
                bra     Jmp_18_To_MarkObjGone                  ; Offset_0x01F9EC
Offset_0x01F966:
                moveq   #$00, D3
                move.b  Obj_Width(A0), D3                                ; $0019
                tst.w   Obj_Speed(A0)                                    ; $0010
                bpl.s   Offset_0x01F988
                neg.w   D3
                bsr     Jmp_00_To_Object_HitWall_Left          ; Offset_0x01F9FE
                tst.w   D1
                bmi.s   Offset_0x01F99E
                move.w  Obj_X(A0), D1                                    ; $0008
                subi.w  #$000C, D1
                bgt.s   Offset_0x01F9AC
                bra.s   Offset_0x01F99E
Offset_0x01F988:
                bsr     Jmp_01_To_Object_HitWall_Right         ; Offset_0x01FA0A
                tst.w   D1
                bmi.s   Offset_0x01F99E
                move.w  (Sonic_Level_Limits_Max_X).w, D1             ; $FFFFEECA
                subi.w  #$000C, D1
                sub.w   Obj_X(A0), D1                                    ; $0008
                bgt.s   Offset_0x01F9AC
Offset_0x01F99E:
                add.w   D1, Obj_X(A0)                                    ; $0008
                neg.w   Obj_Speed(A0)                                    ; $0010
                bchg    #00, Obj_Status(A0)                              ; $0022
Offset_0x01F9AC:
                bsr     Jmp_02_To_ObjHitFloor                  ; Offset_0x01F9F8
                tst.w   D1
                bpl.s   Offset_0x01F9BE
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$FA00, Obj_Speed_Y(A0)                          ; $0012
Offset_0x01F9BE:
                rts                  
;-------------------------------------------------------------------------------
Spinning_Ball_Animate_Data:                                    ; Offset_0x01F9C0
                dc.w    Offset_0x01F9C2-Spinning_Ball_Animate_Data
Offset_0x01F9C2:
                dc.b    $03, $02, $01, $00, $FF, $00     
;-------------------------------------------------------------------------------
Spinning_Ball_Mappings:                                        ; Offset_0x01F9C8
                dc.w    Offset_0x01F9CE-Spinning_Ball_Mappings
                dc.w    Offset_0x01F9D8-Spinning_Ball_Mappings
                dc.w    Offset_0x01F9E2-Spinning_Ball_Mappings
Offset_0x01F9CE:
                dc.w    $0001
                dc.l    $F40A0000, $0000FFF4
Offset_0x01F9D8:
                dc.w    $0001
                dc.l    $F40A0009, $0004FFF4
Offset_0x01F9E2:
                dc.w    $0001
                dc.l    $F40A0012, $0009FFF4
;===============================================================================
; Objeto - Inimigo "Spinning Ball"
; <<<-
;===============================================================================