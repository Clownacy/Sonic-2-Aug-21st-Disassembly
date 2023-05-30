;===============================================================================
; Objeto 0x82 -> Pilar cai ao pisar em cima na Neo Green Hill
; ->>>
;===============================================================================
; Offset_0x01F018:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01F026(PC, D0), D1
                jmp     Offset_0x01F026(PC, D1)
;-------------------------------------------------------------------------------      
Offset_0x01F026:
                dc.w    Offset_0x01F032-Offset_0x01F026
                dc.w    Offset_0x01F09A-Offset_0x01F026    
;------------------------------------------------------------------------------- 
Offset_0x01F02A:
                dc.b    $20, $08, $1C, $30, $10, $10, $10, $10 
;-------------------------------------------------------------------------------
Offset_0x01F032:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Falling_Pillar_Mappings, Obj_Map(A0) ; Offset_0x01F1FE, $0004
                move.w  #$0000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_23_To_ModifySpriteAttr_2P          ; Offset_0x01F266
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$03, D0
                andi.w  #$000E, D0
                lea     Offset_0x01F02A(PC, D0), A2
                move.b  (A2)+, Obj_Width(A0)                             ; $0019
                move.b  (A2), Obj_Height_2(A0)                           ; $0016
                lsr.w   #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.b  #$0F, D0
                beq.s   Offset_0x01F094
                cmpi.b  #$07, D0
                beq.s   Offset_0x01F094
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01F094:
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028    
;-------------------------------------------------------------------------------
Offset_0x01F09A:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, D0
                move.w  Offset_0x01F0E0(PC, D0), D1
                jsr     Offset_0x01F0E0(PC, D1)
                move.w  (A7)+, D4
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01F0D8
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_14_To_SolidObject                  ; Offset_0x01F272
                swap.w  D6
                move.b  D6, Obj_Control_Var_13(A0)                       ; $003F
                bsr     Offset_0x01F1BA
Offset_0x01F0D8:
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                bra     Jmp_06_To_MarkObjGone_2                ; Offset_0x01F278                                           
;-------------------------------------------------------------------------------
Offset_0x01F0E0:
                dc.w    Offset_0x01F0F0-Offset_0x01F0E0
                dc.w    Offset_0x01F0F2-Offset_0x01F0E0
                dc.w    Offset_0x01F11A-Offset_0x01F0E0
                dc.w    Offset_0x01F0F2-Offset_0x01F0E0
                dc.w    Offset_0x01F13E-Offset_0x01F0E0
                dc.w    Offset_0x01F160-Offset_0x01F0E0
                dc.w    Offset_0x01F11A-Offset_0x01F0E0
                dc.w    Offset_0x01F174-Offset_0x01F0E0          
;-------------------------------------------------------------------------------     
Offset_0x01F0F0:
                rts     
;-------------------------------------------------------------------------------   
Offset_0x01F0F2:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                bne.s   Offset_0x01F10A
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x01F108
                move.w  #$001E, Obj_Control_Var_0A(A0)                   ; $0036
Offset_0x01F108:
                rts
Offset_0x01F10A:
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x01F108
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                clr.b   Obj_Control_Var_0C(A0)                           ; $0038
                rts  
;-------------------------------------------------------------------------------   
Offset_0x01F11A:
                bsr     Jmp_0C_To_SpeedToPos                   ; Offset_0x01F27E
                addi.w  #$0008, Obj_Speed_Y(A0)                          ; $0012
                bsr     Jmp_01_To_ObjHitFloor                  ; Offset_0x01F260
                tst.w   D1
                bpl     Offset_0x01F13C
                addq.w  #$01, D1
                add.w   D1, Obj_Y(A0)                                    ; $000C
                clr.w   Obj_Speed_Y(A0)                                  ; $0012
                clr.b   Obj_Subtype(A0)                                  ; $0028
Offset_0x01F13C:
                rts   
;-------------------------------------------------------------------------------   
Offset_0x01F13E:
                bsr     Jmp_0C_To_SpeedToPos                   ; Offset_0x01F27E
                subi.w  #$0008, Obj_Speed_Y(A0)                          ; $0012
                bsr     Jmp_00_To_Object_HitCeiling            ; Offset_0x01F26C
                tst.w   D1
                bpl     Offset_0x01F15E
                sub.w   D1, Obj_Y(A0)                                    ; $000C
                clr.w   Obj_Speed_Y(A0)                                  ; $0012
                clr.b   Obj_Subtype(A0)                                  ; $0028
Offset_0x01F15E:
                rts 
;-------------------------------------------------------------------------------   
Offset_0x01F160:
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                andi.b  #$03, D0
                beq.s   Offset_0x01F172
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                clr.b   Obj_Control_Var_0C(A0)                           ; $0038
Offset_0x01F172:
                rts   
;-------------------------------------------------------------------------------   
Offset_0x01F174:
                move.w  (Water_Level).w, D0                          ; $FFFFF646
                sub.w   Obj_Y(A0), D0                                    ; $000C
                beq.s   Offset_0x01F1B8
                bcc.s   Offset_0x01F19C
                cmpi.w  #$FFFE, D0
                bge.s   Offset_0x01F188
                moveq   #-$02, D0
Offset_0x01F188:
                add.w   D0, Obj_Y(A0)                                    ; $000C
                bsr     Jmp_00_To_Object_HitCeiling            ; Offset_0x01F26C
                tst.w   D1
                bpl     Offset_0x01F19A
                sub.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x01F19A:
                rts
Offset_0x01F19C:
                cmpi.w  #$0002, D0
                ble.s   Offset_0x01F1A4
                moveq   #$02, D0
Offset_0x01F1A4:
                add.w   D0, Obj_Y(A0)                                    ; $000C
                bsr     Jmp_01_To_ObjHitFloor                  ; Offset_0x01F260
                tst.w   D1
                bpl     Offset_0x01F1B8
                addq.w  #$01, D1
                add.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x01F1B8:
                rts
Offset_0x01F1BA:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x01F1FC
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x01F1D6
                tst.b   Obj_Control_Var_12(A0)                           ; $003E
                beq.s   Offset_0x01F1FC
                subq.b  #$04, Obj_Control_Var_12(A0)                     ; $003E
                bra.s   Offset_0x01F1E2
Offset_0x01F1D6:
                cmpi.b  #$40, Obj_Control_Var_12(A0)                     ; $003E
                beq.s   Offset_0x01F1FC
                addq.b  #$04, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x01F1E2:
                move.b  Obj_Control_Var_12(A0), D0                       ; $003E
                jsr     (CalcSine)                             ; Offset_0x003282
                move.w  #$0400, D1
                muls.w  D1, D0
                swap.w  D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
Offset_0x01F1FC:
                rts         
;-------------------------------------------------------------------------------
Falling_Pillar_Mappings:                                       ; Offset_0x01F1FE
                dc.w    Offset_0x01F202-Falling_Pillar_Mappings
                dc.w    Offset_0x01F214-Falling_Pillar_Mappings
Offset_0x01F202:
                dc.w    $0002
                dc.l    $F80D6055, $602AFFE0
                dc.l    $F80D6055, $602A0000
Offset_0x01F214:
                dc.w    $0009
                dc.l    $D005205D, $202EFFE0
                dc.l    $D005285D, $282E0010
                dc.l    $D00D2061, $2030FFF0
                dc.l    $E00D2069, $2034FFF0
                dc.l    $F00D2069, $2034FFF0
                dc.l    $000D2071, $2038FFF0
                dc.l    $100D2069, $2034FFF0
                dc.l    $200D2079, $203CFFF0
                dc.l    $30042081, $2040FFF0
;===============================================================================
; Objeto 0x82 -> Pilar cai ao pisar em cima na Neo Green Hill
; <<<-
;===============================================================================