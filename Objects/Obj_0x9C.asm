;===============================================================================
; Objeto 0x9C - Fogo da turbina usada pelos inimigos Tutloid e Balkiry
; ->>>          Objeto utilizado pelo 0x9A e 0xAC
;===============================================================================
; Offset_0x029060:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02906E(PC, D0), D1
                jmp     Offset_0x02906E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x02906E:
                dc.w    Offset_0x029072-Offset_0x02906E
                dc.w    Offset_0x029076-Offset_0x02906E        
;-------------------------------------------------------------------------------
Offset_0x029072:
                bra     Object_Settings                        ; Offset_0x027EA4 
;-------------------------------------------------------------------------------
Offset_0x029076:
                move.w  Obj_Timer(A0), A1                                ; $002A
                move.b  Obj_Control_Var_06(A0), D0                       ; $0032
                cmp.b   (A1), D0
                bne     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.l  Obj_Control_Var_02(A0), A1                       ; $002E
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------
Load_Enemy_Boost_Sub_Obj_0x9C:                                 ; Offset_0x02909C
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x0290CE
                move.b  #$9C, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Map_Id(A1)                             ; $001A
                move.b  #$1A, Obj_Subtype(A1)                            ; $0028
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.l  Obj_Control_Var_02(A0), Obj_Control_Var_02(A1); $002E, $002E
                move.b  (A0), Obj_Control_Var_06(A1)                     ; $0032
Offset_0x0290CE:
                rts
;-------------------------------------------------------------------------------
Load_Turtloid_Weapon:                                          ; Offset_0x0290D0
                bsr     Jmp_10_To_SingleObjectLoad             ; Offset_0x02A79A
                bne.s   Offset_0x02910E
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Map_Id(A1)                             ; $001A
                move.b  #$1C, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                subi.w  #$0014, Obj_X(A1)                                ; $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$000A, Obj_Y(A1)                                ; $000C
                move.w  #$FF00, Obj_Speed(A1)                            ; $0010
                lea     Turtloid_Weapon(PC), A2                ; Offset_0x028D16
                move.l  A2, Obj_Timer(A1)                                ; $002A
Offset_0x02910E:
                rts            
;-------------------------------------------------------------------------------  
Obj_0x9A_Ptr:                                                  ; Offset_0x029110
                dc.l    Turtloid_Mappings                      ; Offset_0x029140
                dc.w    $2500
                dc.b    $04, $05, $18, $00
;-------------------------------------------------------------------------------  
Obj_0x9B_Ptr:                                                  ; Offset_0x02911A
                dc.l    Turtloid_Mappings                      ; Offset_0x029140
                dc.w    $2500
                dc.b    $04, $04, $0C, $1A  
;-------------------------------------------------------------------------------  
Obj_0x9C_Ptr:                                                  ; Offset_0x029124
                dc.l    Turtloid_Mappings                      ; Offset_0x029140
                dc.w    $2500
                dc.b    $04, $05, $08, $00     
;-------------------------------------------------------------------------------
Turtloid_Weapon_Animate_Data:                                  ; Offset_0x02912E
                dc.w    Offset_0x029130-Turtloid_Weapon_Animate_Data
Offset_0x029130:
                dc.b    $01, $04, $05, $FF
;-------------------------------------------------------------------------------
Turtloid_Animate_Data:                                         ; Offset_0x029134
                dc.w    Offset_0x029136-Turtloid_Animate_Data
Offset_0x029136:
                dc.b    $01, $06, $07, $FF    
;-------------------------------------------------------------------------------
Enemy_Boost_Animate_Data:                                      ; Offset_0x02913A
                dc.w    Offset_0x02913C-Enemy_Boost_Animate_Data
Offset_0x02913C:
                dc.b    $01, $08, $09, $FF                      
;-------------------------------------------------------------------------------
Turtloid_Mappings:                                             ; Offset_0x029140
                dc.w    Offset_0x029154-Turtloid_Mappings
                dc.w    Offset_0x02916E-Turtloid_Mappings
                dc.w    Offset_0x029188-Turtloid_Mappings
                dc.w    Offset_0x029192-Turtloid_Mappings
                dc.w    Offset_0x02919C-Turtloid_Mappings
                dc.w    Offset_0x0291A6-Turtloid_Mappings
                dc.w    Offset_0x0291B0-Turtloid_Mappings
                dc.w    Offset_0x0291BA-Turtloid_Mappings
                dc.w    Offset_0x0291C4-Turtloid_Mappings
                dc.w    Offset_0x0291CE-Turtloid_Mappings
Offset_0x029154:
                dc.w    $0003
                dc.l    $F0090000, $0000FFE4
                dc.l    $F00F0006, $0003FFFC
                dc.l    $00090016, $000BFFE4
Offset_0x02916E:
                dc.w    $0003
                dc.l    $F0090000, $0000FFE4
                dc.l    $0009001C, $000EFFE4
                dc.l    $F00F0006, $0003FFFC
Offset_0x029188:
                dc.w    $0001
                dc.l    $F40A0022, $0011FFF4
Offset_0x029192:
                dc.w    $0001
                dc.l    $F40A002B, $0015FFF4
Offset_0x02919C:
                dc.w    $0001
                dc.l    $FC000034, $001AFFFC
Offset_0x0291A6:
                dc.w    $0001
                dc.l    $FC000035, $001AFFFC
Offset_0x0291B0:
                dc.w    $0001
                dc.l    $06040036, $001B001C
Offset_0x0291BA:
                dc.w    $0001
                dc.l    $06000038, $001C001C
Offset_0x0291C4:
                dc.w    $0001
                dc.l    $FB040036, $001B001B
Offset_0x0291CE:
                dc.w    $0001
                dc.l    $FB000038, $001C001B
;===============================================================================
; Objeto 0x9C - Fogo da turbina usada pelos inimigos Tutloid e Balkiry
; <<<-          Objeto utilizado pelo 0x9A e 0xAC
;===============================================================================