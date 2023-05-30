;===============================================================================
; Objeto 0x4D - Rhinobot - Inimigo rinoceronte na Hidden Palace
; ->>> 
;===============================================================================   
; Offset_0x0228EC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0228FA(PC, D0), D1
                jmp     Offset_0x0228FA(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0228FA:
                dc.w    Offset_0x0228FE-Offset_0x0228FA
                dc.w    Offset_0x02294E-Offset_0x0228FA               
;-------------------------------------------------------------------------------
Offset_0x0228FE:
                move.l  #Rhinobot_Mappings, Obj_Map(A0) ; Offset_0x022A56, $0004
                move.w  #$23B2, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$18, Obj_Width_2(A0)                            ; $0017
                bsr     Jmp_09_To_ObjectFall                   ; Offset_0x022BB4
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x02294C
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x02294C:
                rts    
;-------------------------------------------------------------------------------
Offset_0x02294E:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x02296A(PC, D0), D1
                jsr     Offset_0x02296A(PC, D1)
                lea     (Rhinobot_Animate_Data), A1            ; Offset_0x022A3A
                bsr     Jmp_11_To_AnimateSprite                ; Offset_0x022BAE
                bra     Jmp_22_To_MarkObjGone                  ; Offset_0x022BA8    
;-------------------------------------------------------------------------------
Offset_0x02296A:
                dc.w    Offset_0x02296E-Offset_0x02296A
                dc.w    Offset_0x022992-Offset_0x02296A             
;-------------------------------------------------------------------------------
Offset_0x02296E:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bpl.s   Offset_0x022990
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                bchg    #00, Obj_Status(A0)                              ; $0022
                bne.s   Offset_0x022990
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x022990:
                rts   
;-------------------------------------------------------------------------------
Offset_0x022992:
                bsr     Offset_0x0229DC
                bsr     Jmp_09_To_ObjectFall                   ; Offset_0x022BB4
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFF8, D1
                blt.s   Offset_0x0229B8
                cmpi.w  #$000C, D1
                bge.s   Offset_0x0229B6
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                add.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x0229B6:
                rts
Offset_0x0229B8:
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$003B, Obj_Control_Var_04(A0)                   ; $0030
                move.w  Obj_Speed(A0), D0                                ; $0010
                ext.l   D0
                asl.l   #$08, D0
                sub.l   D0, Obj_X(A0)                                    ; $0008
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                rts
Offset_0x0229DC:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bmi.s   Offset_0x022A10
                cmpi.w  #$0060, D0
                bgt.s   Offset_0x022A00
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x022A02
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$FE00, Obj_Speed(A0)                            ; $0010
Offset_0x022A00:
                rts
Offset_0x022A02:
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0080, Obj_Speed(A0)                            ; $0010
                rts
Offset_0x022A10:
                cmpi.w  #$FFA0, D0
                blt.s   Offset_0x022A00
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x022A2C
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0200, Obj_Speed(A0)                            ; $0010
                rts
Offset_0x022A2C:
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                rts                               
;-------------------------------------------------------------------------------
Rhinobot_Animate_Data:                                         ; Offset_0x022A3A
                dc.w    Offset_0x022A40-Rhinobot_Animate_Data
                dc.w    Offset_0x022A4E-Rhinobot_Animate_Data
                dc.w    Offset_0x022A51-Rhinobot_Animate_Data
Offset_0x022A40:
                dc.b    $02, $00, $00, $00, $03, $03, $04, $01
                dc.b    $01, $02, $05, $05, $05, $FF
Offset_0x022A4E:
                dc.b    $0F, $00, $FF
Offset_0x022A51:
                dc.b    $02, $06, $07, $FF, $00       
;------------------------------------------------------------------------------- 
Rhinobot_Mappings:                                             ; Offset_0x022A56
                dc.w    Offset_0x022A66-Rhinobot_Mappings
                dc.w    Offset_0x022A90-Rhinobot_Mappings
                dc.w    Offset_0x022ABA-Rhinobot_Mappings
                dc.w    Offset_0x022AE4-Rhinobot_Mappings
                dc.w    Offset_0x022B0E-Rhinobot_Mappings
                dc.w    Offset_0x022B38-Rhinobot_Mappings
                dc.w    Offset_0x022B62-Rhinobot_Mappings
                dc.w    Offset_0x022B84-Rhinobot_Mappings
Offset_0x022A66:
                dc.w    $0005
                dc.l    $F0050000, $0000FFF0
                dc.l    $F0050004, $00020000
                dc.l    $F8010008, $0004FFE8
                dc.l    $0005000A, $0005FFF0
                dc.l    $00090022, $00110000
Offset_0x022A90:
                dc.w    $0005
                dc.l    $F0050000, $0000FFF0
                dc.l    $F0050004, $00020000
                dc.l    $F8010008, $0004FFE8
                dc.l    $0005000E, $0007FFF0
                dc.l    $00090022, $00110000
Offset_0x022ABA:
                dc.w    $0005
                dc.l    $F0050000, $0000FFF0
                dc.l    $F0050004, $00020000
                dc.l    $F8010008, $0004FFE8
                dc.l    $00050012, $0009FFF0
                dc.l    $00090022, $00110000
Offset_0x022AE4:
                dc.w    $0005
                dc.l    $F0050000, $0000FFF0
                dc.l    $F0050004, $00020000
                dc.l    $F8010008, $0004FFE8
                dc.l    $0005000A, $0005FFF0
                dc.l    $00090028, $00140000
Offset_0x022B0E:
                dc.w    $0005
                dc.l    $F0050000, $0000FFF0
                dc.l    $F0050004, $00020000
                dc.l    $F8010008, $0004FFE8
                dc.l    $0005000E, $0007FFF0
                dc.l    $00090028, $00140000
Offset_0x022B38:
                dc.w    $0005
                dc.l    $F0050000, $0000FFF0
                dc.l    $F0050004, $00020000
                dc.l    $F8010008, $0004FFE8
                dc.l    $00050012, $0009FFF0
                dc.l    $00090028, $00140000
Offset_0x022B62:
                dc.w    $0004
                dc.l    $F00B0016, $000BFFE8
                dc.l    $F0050004, $00020000
                dc.l    $00090022, $00110000
                dc.l    $FB01002E, $0017001A
Offset_0x022B84:
                dc.w    $0004
                dc.l    $F00B0016, $000BFFE8
                dc.l    $F0050004, $00020000
                dc.l    $00090028, $00140000
                dc.l    $FB010030, $0018001A
;===============================================================================
; Objeto 0x4D - Rhinobot - Inimigo rinoceronte na Hidden Palace
; <<<- 
;===============================================================================