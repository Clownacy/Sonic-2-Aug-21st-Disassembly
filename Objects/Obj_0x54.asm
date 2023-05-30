;===============================================================================
; Objeto 0x54 - Robotnik na Metropolis
; ->>>          Rotinas adicionais deste objeto no objeto 0x53 ( obj_0x53.asm )
;===============================================================================
; Offset_0x027A90:
                moveq   #$00, D0
                move.b  Obj_Boss_Routine(A0), D0                         ; $000A
                move.w  Offset_0x027A9E(PC, D0), D1
                jmp     Offset_0x027A9E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x027A9E:
                dc.w    Offset_0x027AA2-Offset_0x027A9E
                dc.w    Offset_0x027B36-Offset_0x027A9E     
;-------------------------------------------------------------------------------
Offset_0x027AA2:
                move.l  #Mz_Boss_Mappings, Obj_Map(A0)  ; Offset_0x027DAA, $0004
                move.w  #$038C, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.w  #$1EA0, Obj_X(A0)                                ; $0008
                move.w  #$0178, Obj_Y(A0)                                ; $000C
                move.b  #$02, Obj_Boss_Ani_Map(A0)                       ; $000B
                addq.b  #$02, Obj_Boss_Routine(A0)                       ; $000A
                bset    #$06, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Ani_Boss_Cnt(A0)                       ; $000F
                move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Control_Var_06(A0)                     ; $0032
                move.w  Obj_X(A0), (Boss_Move_Buffer).w       ; $FFFFF750; $0008
                move.w  Obj_Y(A0), (Boss_Move_Buffer+$04).w   ; $FFFFF754; $000C
                move.w  #$FE00, (Boss_Move_Buffer+$08).w             ; $FFFFF758
                move.w  Obj_X(A0), Obj_Speed(A0)                  ; $0008, $0010
                move.w  Obj_Y(A0), Obj_Speed_Y(A0)                ; $000C, $0012
                move.b  #$00, Obj_Ani_Boss_Frame(A0)                     ; $0015
                bsr     Jmp_0F_To_SingleObjectLoad             ; Offset_0x027E92
                bne.s   Offset_0x027B1C
                move.b  #$53, (A1)
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
Offset_0x027B1C:
                bsr     Offset_0x027B22
                rts
Offset_0x027B22:
                lea     (Boss_Animate_Buffer).w, A2                  ; $FFFFF740
                move.b  #$10, (A2)+
                move.b  #$00, (A2)+
                move.b  #$01, (A2)+
                move.b  #$00, (A2)+     
;-------------------------------------------------------------------------------
Offset_0x027B36:
                moveq   #$00, D0
                move.b  Obj_Ani_Boss_Routine(A0), D0                     ; $0026
                move.w  Offset_0x027B44(PC, D0), D1
                jmp     Offset_0x027B44(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x027B44:
                dc.w    Offset_0x027B48-Offset_0x027B44
                dc.w    Obj_0x53_Mz_Boss_Balls_Robotniks-Offset_0x027B44 ; Offset_0x027B80   
;-------------------------------------------------------------------------------  
Offset_0x027B48:
                bsr     Boss_Move                              ; Offset_0x0245FA
                bsr     Offset_0x024580
                cmpi.b  #$1F, Obj_Inertia(A0)                            ; $0014
                bne.s   Offset_0x027B5C
                st      Obj_Control_Var_0C(A0)                           ; $0038
Offset_0x027B5C:
                lea     (Mz_Boss_Animate_Data), A1             ; Offset_0x027D88
                bsr     Boss_AnimateSprite                     ; Offset_0x026312
                bsr     Offset_0x027B6E
                bra     Jmp_1E_To_DisplaySprite                ; Offset_0x027E8C
Offset_0x027B6E:
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  Obj_Y(A0), D1                                    ; $000C
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  D1, Obj_Speed_Y(A0)                              ; $0012
                rts
;===============================================================================
; Objeto 0x54 - Robotnik na Metropolis
; <<<-          Rotinas adicionais deste objeto no objeto 0x53 ( obj_0x53.asm )
;===============================================================================