;===============================================================================
; Objeto 0x4A - Inimigo Octus na Oil Ocean
; ->>> 
;===============================================================================   
; Offset_0x021704:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x021712(PC, D0), D1
                jmp     Offset_0x021712(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x021712:
                dc.w    Offset_0x021742-Offset_0x021712
                dc.w    Offset_0x0217A8-Offset_0x021712
                dc.w    Offset_0x021736-Offset_0x021712
                dc.w    Offset_0x02171A-Offset_0x021712      
;-------------------------------------------------------------------------------
Offset_0x02171A:
                subi.w  #$0001, Obj_Control_Var_00(A0)                   ; $002C
                bmi.s   Offset_0x021724
                rts
Offset_0x021724:
                bsr     Jmp_05_To_ObjectFall                   ; Offset_0x0219AC
                lea     (Octus_AnimateData), A1                ; Offset_0x0218F6
                bsr     Jmp_0C_To_AnimateSprite                ; Offset_0x0219A6
                bra     Jmp_1F_To_MarkObjGone                  ; Offset_0x0219A0      
;-------------------------------------------------------------------------------
Offset_0x021736:
                subq.w  #$01, Obj_Control_Var_00(A0)                     ; $002C
                beq     Jmp_18_To_DeleteObject                 ; Offset_0x02199A
                bra     Jmp_15_To_DisplaySprite                ; Offset_0x021994   
;-------------------------------------------------------------------------------
Offset_0x021742:
                move.l  #Octus_Mappings, Obj_Map(A0)    ; Offset_0x021908, $0004
                move.w  #$238A, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                bsr     Jmp_05_To_ObjectFall                   ; Offset_0x0219AC
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bpl.s   Offset_0x0217A0
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                bpl.s   Offset_0x0217A0
                bchg    #00, Obj_Status(A0)                              ; $0022
Offset_0x0217A0:
                move.w  Obj_Y(A0), Obj_Timer(A0)                  ; $000C, $002A
                rts        
;-------------------------------------------------------------------------------
Offset_0x0217A8:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0217C4(PC, D0), D1
                jsr     Offset_0x0217C4(PC, D1)
                lea     (Octus_AnimateData), A1                ; Offset_0x0218F6
                bsr     Jmp_0C_To_AnimateSprite                ; Offset_0x0219A6
                bra     Jmp_1F_To_MarkObjGone                  ; Offset_0x0219A0     
;-------------------------------------------------------------------------------
Offset_0x0217C4:
                dc.w    Offset_0x0217CC-Offset_0x0217C4
                dc.w    Offset_0x0217EC-Offset_0x0217C4
                dc.w    Offset_0x02180E-Offset_0x0217C4
                dc.w    Offset_0x0218E0-Offset_0x0217C4    
;-------------------------------------------------------------------------------
Offset_0x0217CC:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   (Player_One_Position_X).w, D0                ; $FFFFB008
                cmpi.w  #$0080, D0
                bgt.s   Offset_0x0217EA
                cmpi.w  #$FF80, D0
                blt.s   Offset_0x0217EA
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
Offset_0x0217EA:
                rts  
;-------------------------------------------------------------------------------
Offset_0x0217EC:
                subi.l  #$00018000, Obj_Y(A0)                            ; $000C
                move.w  Obj_Timer(A0), D0                                ; $002A
                sub.w   Obj_Y(A0), D0                                    ; $000C
                cmpi.w  #$0020, D0
                ble.s   Offset_0x02180C
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0000, Obj_Control_Var_00(A0)                   ; $002C
Offset_0x02180C:
                rts  
;-------------------------------------------------------------------------------
Offset_0x02180E:
                subi.w  #$0001, Obj_Control_Var_00(A0)                   ; $002C
                beq     Offset_0x0218DA
                bpl     Offset_0x0218D8
                move.w  #$001E, Obj_Control_Var_00(A0)                   ; $002C
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne.s   Offset_0x021874
                move.b  #$4A, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.l  #Octus_Mappings, Obj_Map(A1)    ; Offset_0x021908, $0004
                move.b  #$04, Obj_Map_Id(A1)                             ; $001A
                move.w  #$24C6, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$001E, Obj_Control_Var_00(A1)                   ; $002C
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
Offset_0x021874:
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne.s   Offset_0x0218D8
                move.b  #$4A, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  #Octus_Mappings, Obj_Map(A1)    ; Offset_0x021908, $0004
                move.w  #$24C6, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$000F, Obj_Control_Var_00(A1)                   ; $002C
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$FA80, Obj_Speed(A1)                            ; $0010
                btst    #$00, Obj_Flags(A1)                              ; $0001
                beq.s   Offset_0x0218D8
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x0218D8:
                rts
Offset_0x0218DA:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                rts   
;-------------------------------------------------------------------------------
Offset_0x0218E0:
                move.w  #$FFFA, D0
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x0218EE
                neg.w   D0
Offset_0x0218EE:
                add.w   D0, Obj_X(A0)                                    ; $0008
                bra     Jmp_1F_To_MarkObjGone                  ; Offset_0x0219A0            
;-------------------------------------------------------------------------------
Octus_AnimateData:                                             ; Offset_0x0218F6
                dc.w    Offset_0x0218FC-Octus_AnimateData
                dc.w    Offset_0x0218FF-Octus_AnimateData
                dc.w    Offset_0x021904-Octus_AnimateData
Offset_0x0218FC:
                dc.b    $0F, $00, $FF
Offset_0x0218FF:
                dc.b    $03, $01, $02, $03, $FF
Offset_0x021904:
                dc.b    $02, $05, $06, $FF         
;-------------------------------------------------------------------------------
Octus_Mappings:                                                ; Offset_0x021908
                dc.w    Offset_0x021916-Octus_Mappings
                dc.w    Offset_0x021928-Octus_Mappings
                dc.w    Offset_0x021942-Octus_Mappings
                dc.w    Offset_0x02195C-Octus_Mappings
                dc.w    Offset_0x021976-Octus_Mappings
                dc.w    Offset_0x021980-Octus_Mappings
                dc.w    Offset_0x02198A-Octus_Mappings
Offset_0x021916:
                dc.w    $0002
                dc.l    $F00D0000, $0000FFF0
                dc.l    $000D0008, $0004FFF0
Offset_0x021928:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $00090010, $0008FFE8
                dc.l    $00090016, $000B0000
Offset_0x021942:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $0009001C, $000EFFE8
                dc.l    $00090022, $00110000
Offset_0x02195C:
                dc.w    $0003
                dc.l    $F00D0000, $0000FFF0
                dc.l    $00090028, $0014FFE8
                dc.l    $0009002E, $00170000
Offset_0x021976:
                dc.w    $0001
                dc.l    $F0010034, $001AFFF7
Offset_0x021980:
                dc.w    $0001
                dc.l    $F2010036, $001BFFF0
Offset_0x02198A:
                dc.w    $0001
                dc.l    $F2010038, $001CFFF0
;===============================================================================
; Objeto 0x4A - Inimigo Octus na Oil Ocean
; <<<- 
;===============================================================================