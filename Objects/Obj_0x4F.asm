;===============================================================================
; Objeto 0x4F - Dinobot - Inimigo dinossauro na Hidden Palace
; ->>> 
;===============================================================================
; Offset_0x0219B4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0219C2(PC, D0), D1
                jmp     Offset_0x0219C2(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x0219C2:
                dc.w    Offset_0x0219C8-Offset_0x0219C2
                dc.w    Offset_0x021A1E-Offset_0x0219C2
                dc.w    Offset_0x021AC0-Offset_0x0219C2            
;-------------------------------------------------------------------------------  
Offset_0x0219C8:
                move.l  #Dinobot_Mappings, Obj_Map(A0)  ; Offset_0x021AD2, $0004
                move.w  #$0500, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$06, Obj_Width_2(A0)                            ; $0017
                move.b  #$0C, Obj_Col_Flags(A0)                          ; $0020
                bsr     Jmp_06_To_ObjectFall                   ; Offset_0x021B0A
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x021A1C
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bchg    #00, Obj_Status(A0)                              ; $0022
Offset_0x021A1C:
                rts  
;-------------------------------------------------------------------------------  
Offset_0x021A1E:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x021A64(PC, D0), D1
                jsr     Offset_0x021A64(PC, D1)
                lea     (Dinobot_Animate_Data), A1             ; Offset_0x021AC4
                bsr     Jmp_0D_To_AnimateSprite                ; Offset_0x021B04
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Offset_0x021A4E
                bra     Jmp_16_To_DisplaySprite                ; Offset_0x021AF8
Offset_0x021A4E:
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x021A60
                bclr    #$07, $02(A2, D0)
Offset_0x021A60:
                bra     Jmp_19_To_DeleteObject                 ; Offset_0x021AFE      
;------------------------------------------------------------------------------- 
Offset_0x021A64:
                dc.w    Offset_0x021A68-Offset_0x021A64
                dc.w    Offset_0x021A8C-Offset_0x021A64           
;-------------------------------------------------------------------------------  
Offset_0x021A68:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bpl.s   Offset_0x021A8A
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$FF80, Obj_Speed(A0)                            ; $0010
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                bchg    #00, Obj_Status(A0)                              ; $0022
                bne.s   Offset_0x021A8A
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x021A8A:
                rts  
;-------------------------------------------------------------------------------  
Offset_0x021A8C:
                bsr     Jmp_12_To_SpeedToPos                   ; Offset_0x021B10
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                cmpi.w  #$FFF8, D1
                blt.s   Offset_0x021AA8
                cmpi.w  #$000C, D1
                bge.s   Offset_0x021AA8
                add.w   D1, Obj_Y(A0)                                    ; $000C
                rts
Offset_0x021AA8:
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$003B, Obj_Control_Var_04(A0)                   ; $0030
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts    
;-------------------------------------------------------------------------------  
Offset_0x021AC0:
                bra     Jmp_19_To_DeleteObject                 ; Offset_0x021AFE               
;-------------------------------------------------------------------------------
Dinobot_Animate_Data:                                          ; Offset_0x021AC4
                dc.w    Offset_0x021AC8-Dinobot_Animate_Data
                dc.w    Offset_0x021ACB-Dinobot_Animate_Data
Offset_0x021AC8:
                dc.b    $09, $01, $FF
Offset_0x021ACB:
                dc.b    $09, $00, $01, $02, $01, $FF, $00   
;-------------------------------------------------------------------------------
Dinobot_Mappings:                                              ; Offset_0x021AD2
                dc.w    Offset_0x021AD8-Dinobot_Mappings
                dc.w    Offset_0x021AE2-Dinobot_Mappings
                dc.w    Offset_0x021AEC-Dinobot_Mappings
Offset_0x021AD8:
                dc.w    $0001
                dc.l    $F00F0000, $0000FFF0
Offset_0x021AE2:
                dc.w    $0001
                dc.l    $F00F0010, $0008FFF0
Offset_0x021AEC:
                dc.w    $0001
                dc.l    $F00F0020, $0010FFF0
;===============================================================================
; Objeto 0x4F - Dinobot - Inimigo dinossauro na Hidden Palace
; <<<- 
;===============================================================================