;===============================================================================
; Objeto 0xA4 - Inimigo Asteron na Metropolis
; ->>>
;===============================================================================
; Offset_0x029E94:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x029EA2(PC, D0), D1
                jmp     Offset_0x029EA2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x029EA2:
                dc.w    Offset_0x029EA8-Offset_0x029EA2
                dc.w    Offset_0x029EAC-Offset_0x029EA2
                dc.w    Offset_0x029EFE-Offset_0x029EA2       
;-------------------------------------------------------------------------------
Offset_0x029EA8:
                bra     Object_Settings                        ; Offset_0x027EA4    
;-------------------------------------------------------------------------------
Offset_0x029EAC:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                tst.w   D2
                bpl.s   Offset_0x029EB6
                neg.w   D2
Offset_0x029EB6:
                cmpi.w  #$0010, D2
                bcs.s   Offset_0x029ECC
                cmpi.w  #$0060, D2
                bcc.s   Offset_0x029ECC
                move.w  Offset_0x029EEC(PC, D0), Obj_Speed(A0)           ; $0010
                bsr     Offset_0x029EF0
Offset_0x029ECC:
                tst.w   D3
                bpl.s   Offset_0x029ED2
                neg.w   D3
Offset_0x029ED2:
                cmpi.w  #$0010, D3
                bcs.s   Offset_0x029EE8
                cmpi.w  #$0060, D3
                bcc.s   Offset_0x029EE8
                move.w  Offset_0x029EEC(PC, D1), Obj_Speed_Y(A0)         ; $0012
                bsr     Offset_0x029EF0
Offset_0x029EE8:
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x029EEC:
                dc.w    $FFC0, $0040                                           
;-------------------------------------------------------------------------------
Offset_0x029EF0:
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.b  #$40, Obj_Timer(A0)                              ; $002A
                rts      
;-------------------------------------------------------------------------------
Offset_0x029EFE:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x029F16
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Asteron_Animate_Data), A1             ; Offset_0x029FAA
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029F16:
                move.b  #$27, Obj_Id(A0)                                 ; $0000
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Enemy_Weapon                           ; Offset_0x029F2A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------  
Enemy_Weapon:                                                  ; Offset_0x029F2A
                moveq   #$00, D1
                moveq   #$04, D6
Loop_Load_Weapon:                                              ; Offset_0x029F2E
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x029F80
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$30, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                lea     (SpeedToPos), A2                       ; Offset_0x00D1DA
                move.l  A2, Obj_Timer(A1)                                ; $002A
                lea     Enemy_Weapon_Data(PC, D1), A2          ; Offset_0x029F82
                move.b  (A2)+, D0
                ext.w   D0
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.b  (A2)+, D0
                ext.w   D0
                add.w   D0, Obj_Y(A1)                                    ; $000C
                move.b  (A2)+, Obj_Speed(A1)                             ; $0010
                move.b  (A2)+, Obj_Speed_Y(A1)                           ; $0012
                move.b  (A2)+, Obj_Map_Id(A1)                            ; $001A
                move.b  (A2)+, Obj_Flags(A1)                             ; $0001
                addq.w  #$06, D1
                dbra    D6, Loop_Load_Weapon                   ; Offset_0x029F2E
Offset_0x029F80:
                rts
;-------------------------------------------------------------------------------
Enemy_Weapon_Data:                                             ; Offset_0x029F82
                dc.b    $00, $F8, $00, $FC, $02, $00
                dc.b    $08, $FC, $03, $FF, $03, $01
                dc.b    $08, $08, $03, $03, $04, $01
                dc.b    $F8, $08, $FD, $03, $04, $00
                dc.b    $F8, $FC, $FD, $FF, $03, $00     
;-------------------------------------------------------------------------------
Obj_0xA4_Ptr:                                                  ; Offset_0x029FA0
                dc.l    Asteron_Mappings                       ; Offset_0x029FB0
                dc.w    $8368
                dc.b    $04, $04, $10, $0B
;-------------------------------------------------------------------------------
Asteron_Animate_Data:                                          ; Offset_0x029FAA
                dc.w    Offset_0x029FAC-Asteron_Animate_Data
Offset_0x029FAC:
                dc.b    $01, $00, $01, $FF          
;-------------------------------------------------------------------------------
Asteron_Mappings:                                              ; Offset_0x029FB0
                dc.w    Offset_0x029FBA-Asteron_Mappings
                dc.w    Offset_0x029FCC-Asteron_Mappings
                dc.w    Offset_0x029FE6-Asteron_Mappings
                dc.w    Offset_0x029FF0-Asteron_Mappings
                dc.w    Offset_0x029FFA-Asteron_Mappings
Offset_0x029FBA:
                dc.w    $0002
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070800, $08000000
Offset_0x029FCC:
                dc.w    $0003
                dc.l    $FD00200E, $2007FFFC
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070800, $08000000
Offset_0x029FE6:
                dc.w    $0001
                dc.l    $F8010008, $0004FFFC
Offset_0x029FF0:
                dc.w    $0001
                dc.l    $FC04000A, $0005FFF8
Offset_0x029FFA:
                dc.w    $0001
                dc.l    $F801000C, $0006FFFC 
;===============================================================================
; Objeto 0xA4 - Inimigo Asteron na Metropolis
; <<<-
;===============================================================================