;===============================================================================
; Objeto 0x4C - Batbot - Inimigo Morcego na Hidden Palace
; ->>> 
;===============================================================================   
; Offset_0x01FA18:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01FA26(PC, D0), D1
                jmp     Offset_0x01FA26(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01FA26:
                dc.w    Offset_0x01FA2C-Offset_0x01FA26
                dc.w    Offset_0x01FA6A-Offset_0x01FA26
                dc.w    Offset_0x01FAD8-Offset_0x01FA26   
;-------------------------------------------------------------------------------
Offset_0x01FA2C:
                move.l  #Batbot_Mappings, Obj_Map(A0)   ; Offset_0x01FCB6, $0004
                move.w  #$2530, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  Obj_Y(A0), Obj_Control_Var_02(A0)         ; $000C, $002E
                rts         
;-------------------------------------------------------------------------------
Offset_0x01FA6A:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x01FA8A(PC, D0), D1
                jsr     Offset_0x01FA8A(PC, D1)
                bsr     Offset_0x01FA90
                lea     (Batbot_Animate_Data), A1              ; Offset_0x01FC82
                bsr     Jmp_06_To_AnimateSprite                ; Offset_0x01FE92
                bra     Jmp_19_To_MarkObjGone                  ; Offset_0x01FE8C   
;-------------------------------------------------------------------------------  
Offset_0x01FA8A:
                dc.w    Offset_0x01FBF6-Offset_0x01FA8A
                dc.w    Offset_0x01FC2E-Offset_0x01FA8A
                dc.w    Offset_0x01FC3A-Offset_0x01FA8A      
;-------------------------------------------------------------------------------
Offset_0x01FA90:
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                jsr     (CalcSine)                             ; Offset_0x003282
                asr.w   #$06, D0
                add.w   Obj_Control_Var_02(A0), D0                       ; $002E
                move.w  D0, Obj_Y(A0)                                    ; $000C
                addq.b  #$04, Obj_Control_Var_13(A0)                     ; $003F
                rts   
;-------------------------------------------------------------------------------
Offset_0x01FAAA:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   ($FFFFB008).w, D0
                cmpi.w  #$0080, D0
                bgt.s   Offset_0x01FAD6
                cmpi.w  #$FF80, D0
                blt.s   Offset_0x01FAD6
                move.b  #$04, Obj_Routine_2(A0)                          ; $0025
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0008, Obj_Timer(A0)                            ; $002A
                move.b  #$00, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x01FAD6:
                rts    
;-------------------------------------------------------------------------------
Offset_0x01FAD8:
                bsr     Offset_0x01FBD6
                bsr     Offset_0x01FB78
                bsr     Offset_0x01FAF8
                bsr     Jmp_0D_To_SpeedToPos                   ; Offset_0x01FE98
                lea     (Batbot_Animate_Data), A1              ; Offset_0x01FC82
                bsr     Jmp_06_To_AnimateSprite                ; Offset_0x01FE92
                bra     Jmp_19_To_MarkObjGone                  ; Offset_0x01FE8C     
;-------------------------------------------------------------------------------
; Offset_0x01FAF6:
                rts 
;-------------------------------------------------------------------------------
Offset_0x01FAF8:
                tst.b   Obj_Control_Var_11(A0)                           ; $003D
                beq.s   Offset_0x01FB0A
                bset    #$00, Obj_Flags(A0)                              ; $0001
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x01FB0A:
                rts        
;-------------------------------------------------------------------------------
Offset_0x01FB0C:
                subi.w  #$0001, Obj_Control_Var_00(A0)                   ; $002C
                bpl.s   Offset_0x01FB56
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                cmpi.w  #$0060, D0
                bgt.s   Offset_0x01FB58
                cmpi.w  #$FFA0, D0
                blt.s   Offset_0x01FB58
                tst.w   D0
                bpl.s   Offset_0x01FB30
                st      Obj_Control_Var_11(A0)                           ; $003D
Offset_0x01FB30:
                move.b  #$40, Obj_Control_Var_13(A0)                     ; $003F
                move.w  #$0400, Obj_Inertia(A0)                          ; $0014
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$000C, Obj_Timer(A0)                            ; $002A
                move.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                moveq   #$00, D0
Offset_0x01FB56:
                rts
Offset_0x01FB58:
                cmpi.w  #$0080, D0
                bgt.s   Offset_0x01FB64
                cmpi.w  #$FF80, D0
                bgt.s   Offset_0x01FB56
Offset_0x01FB64:
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0018, Obj_Timer(A0)                            ; $002A
                rts
Offset_0x01FB78:
                tst.b   Obj_Control_Var_11(A0)                           ; $003D
                bne.s   Offset_0x01FB92
                moveq   #$00, D0
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                cmpi.w  #$00C0, D0
                bge.s   Offset_0x01FBA6
                addq.b  #$02, D0
                move.b  D0, Obj_Control_Var_13(A0)                       ; $003F
                rts
Offset_0x01FB92:
                moveq   #$00, D0
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                cmpi.w  #$00C0, D0
                beq.s   Offset_0x01FBA6
                subq.b  #$02, D0
                move.b  D0, Obj_Control_Var_13(A0)                       ; $003F
                rts
Offset_0x01FBA6:
                sf      Obj_Control_Var_11(A0)                           ; $003D
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0018, Obj_Timer(A0)                            ; $002A
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                bclr    #$00, Obj_Status(A0)                             ; $0022
                rts
Offset_0x01FBD6:
                move.b  Obj_Control_Var_13(A0), D0                       ; $003F
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  Obj_Inertia(A0), D1                              ; $0014
                asr.l   #$08, D1
                move.w  D1, Obj_Speed(A0)                                ; $0010
                muls.w  Obj_Inertia(A0), D0                              ; $0014
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A0)                              ; $0012
                rts         
;-------------------------------------------------------------------------------
Offset_0x01FBF6:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bpl.s   Offset_0x01FC2C
                bsr     Offset_0x01FAAA
                beq.s   Offset_0x01FC2C
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                andi.b  #$FF, D0
                bne.s   Offset_0x01FC2C
                move.w  #$0018, Obj_Timer(A0)                            ; $002A
                move.w  #$001E, Obj_Control_Var_00(A0)                   ; $002C
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$00, Obj_Control_Var_12(A0)                     ; $003E
Offset_0x01FC2C:
                rts  
;-------------------------------------------------------------------------------
Offset_0x01FC2E:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bpl.s   Offset_0x01FC38
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x01FC38:
                rts 
;-------------------------------------------------------------------------------
Offset_0x01FC3A:
                bsr     Offset_0x01FB0C
                beq.s   Offset_0x01FC80
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bne.s   Offset_0x01FC80
                move.b  Obj_Control_Var_12(A0), D0                       ; $003E
                beq.s   Offset_0x01FC68
                move.b  #$00, Obj_Control_Var_12(A0)                     ; $003E
                move.w  #$0008, Obj_Timer(A0)                            ; $002A
                bset    #$00, Obj_Flags(A0)                              ; $0001
                bset    #$00, Obj_Status(A0)                             ; $0022
                rts
Offset_0x01FC68:
                move.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
                move.w  #$000C, Obj_Timer(A0)                            ; $002A
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                bclr    #$00, Obj_Status(A0)                             ; $0022
Offset_0x01FC80:
                rts          
;-------------------------------------------------------------------------------    
Batbot_Animate_Data:                                           ; Offset_0x01FC82
                dc.w    Offset_0x01FC8A-Batbot_Animate_Data
                dc.w    Offset_0x01FC8E-Batbot_Animate_Data
                dc.w    Offset_0x01FC9D-Batbot_Animate_Data
                dc.w    Offset_0x01FCAE-Batbot_Animate_Data
Offset_0x01FC8A:
                dc.b    $01, $00, $05, $FF
Offset_0x01FC8E:
                dc.b    $01, $01, $06, $01, $06, $02, $07, $02
                dc.b    $07, $01, $06, $01, $06, $FD, $00
Offset_0x01FC9D:
                dc.b    $01, $01, $06, $01, $06, $02, $07, $03
                dc.b    $08, $04, $09, $04, $09, $03, $08, $FE
                dc.b    $0A
Offset_0x01FCAE:
                dc.b    $03, $0A, $0B, $0C, $0D, $0E, $FF, $00    
;------------------------------------------------------------------------------- 
Batbot_Mappings:                                               ; Offset_0x01FCB6
                dc.w    Offset_0x01FCD4-Batbot_Mappings
                dc.w    Offset_0x01FCF6-Batbot_Mappings
                dc.w    Offset_0x01FD18-Batbot_Mappings
                dc.w    Offset_0x01FD3A-Batbot_Mappings
                dc.w    Offset_0x01FD5C-Batbot_Mappings
                dc.w    Offset_0x01FD76-Batbot_Mappings
                dc.w    Offset_0x01FD98-Batbot_Mappings
                dc.w    Offset_0x01FDBA-Batbot_Mappings
                dc.w    Offset_0x01FDDC-Batbot_Mappings
                dc.w    Offset_0x01FDFE-Batbot_Mappings
                dc.w    Offset_0x01FE18-Batbot_Mappings
                dc.w    Offset_0x01FE32-Batbot_Mappings
                dc.w    Offset_0x01FE4C-Batbot_Mappings
                dc.w    Offset_0x01FE5E-Batbot_Mappings
                dc.w    Offset_0x01FE70-Batbot_Mappings
Offset_0x01FCD4:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050004, $0002FFF8
                dc.l    $F00B0008, $00040005
                dc.l    $F00B0808, $0804FFE3
Offset_0x01FCF6:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050004, $0002FFF8
                dc.l    $F60D0014, $000A0005
                dc.l    $F60D0814, $080AFFDB
Offset_0x01FD18:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050004, $0002FFF8
                dc.l    $F80D001C, $000E0004
                dc.l    $F80D081C, $080EFFDC
Offset_0x01FD3A:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050004, $0002FFF8
                dc.l    $F8050024, $0012FFEC
                dc.l    $F8050028, $00140004
Offset_0x01FD5C:
                dc.w    $0003
                dc.l    $F801002C, $00160000
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050004, $0002FFF8
Offset_0x01FD76:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $0005002E, $0017FFF8
                dc.l    $F00B0008, $00040005
                dc.l    $F00B0808, $0804FFE3
Offset_0x01FD98:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $0005002E, $0017FFF8
                dc.l    $F60D0014, $000A0005
                dc.l    $F60D0814, $080AFFDB
Offset_0x01FDBA:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $0005002E, $0017FFF8
                dc.l    $F80D001C, $000E0004
                dc.l    $F80D081C, $080EFFDC
Offset_0x01FDDC:
                dc.w    $0004
                dc.l    $F0050000, $0000FFF8
                dc.l    $0005002E, $0017FFF8
                dc.l    $F8050028, $00140004
                dc.l    $F8050024, $0012FFEC
Offset_0x01FDFE:
                dc.w    $0003
                dc.l    $F801002C, $00160000
                dc.l    $F0050000, $0000FFF8
                dc.l    $0005002E, $0017FFF8
Offset_0x01FE18:
                dc.w    $0003
                dc.l    $F0070032, $0019FFF8
                dc.l    $F80D001C, $000E0004
                dc.l    $F80D081C, $080EFFDC
Offset_0x01FE32:
                dc.w    $0003
                dc.l    $F0070032, $0019FFF8
                dc.l    $F8050028, $00140004
                dc.l    $F8050024, $0012FFEC
Offset_0x01FE4C:
                dc.w    $0002
                dc.l    $F801002C, $00160000
                dc.l    $F0070032, $0019FFF8
Offset_0x01FE5E:
                dc.w    $0002
                dc.l    $F801082C, $0816FFF8
                dc.l    $F0070032, $0019FFF8
Offset_0x01FE70:
                dc.w    $0003
                dc.l    $F0070032, $0019FFF8
                dc.l    $F8050828, $0814FFEC
                dc.l    $F8050824, $08120004
;===============================================================================
; Objeto 0x4C - Batbot - Inimigo Morcego na Hidden Palace
; <<<- 
;===============================================================================