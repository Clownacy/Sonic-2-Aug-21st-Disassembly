;===============================================================================
; Objeto 0x9D - Inimigo Coconuts na Green Hill
; ->>>
;=============================================================================== 
; Offset_0x0291D8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0291E6(PC, D0), D1
                jmp     Offset_0x0291E6(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0291E6:
                dc.w    Offset_0x0291EE-Offset_0x0291E6
                dc.w    Offset_0x0291FA-Offset_0x0291E6
                dc.w    Offset_0x02928C-Offset_0x0291E6
                dc.w    Offset_0x0292B2-Offset_0x0291E6       
;-------------------------------------------------------------------------------
Offset_0x0291EE:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.b  #$10, Obj_Timer(A0)                              ; $002A
                rts  
;-------------------------------------------------------------------------------
Offset_0x0291FA:
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                bclr    #$00, Obj_Flags(A0)                              ; $0001
                bclr    #$00, Obj_Status(A0)                             ; $0022
                tst.w   D0
                beq.s   Offset_0x02921A
                bset    #$00, Obj_Flags(A0)                              ; $0001
                bset    #$00, Obj_Status(A0)                             ; $0022
Offset_0x02921A:
                addi.w  #$0060, D2
                cmpi.w  #$00C0, D2
                bcc.s   Offset_0x02922E
                tst.b   Obj_Control_Var_02(A0)                           ; $002E
                beq.s   Offset_0x029244
                subq.b  #$01, Obj_Control_Var_02(A0)                     ; $002E
Offset_0x02922E:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x029238
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029238:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Offset_0x029260
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029244:
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                move.b  #$08, Obj_Timer(A0)                              ; $002A
                move.b  #$20, Obj_Control_Var_02(A0)                     ; $002E
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x029260:
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                cmpi.w  #$000C, D0
                bcs.s   Offset_0x02926C
                moveq   #$00, D0
Offset_0x02926C:
                lea     Offset_0x029280(PC, D0), A1
                addq.w  #$02, D0
                move.w  D0, Obj_Control_Var_00(A0)                       ; $002C
                move.b  (A1)+, Obj_Speed_Y(A0)                           ; $0012
                move.b  (A1)+, Obj_Timer(A0)                             ; $002A
                rts    
;------------------------------------------------------------------------------- 
Offset_0x029280:
                dc.b    $FF, $20, $01, $18, $FF, $10, $01, $28
                dc.b    $FF, $20, $01, $10      
;-------------------------------------------------------------------------------   
Offset_0x02928C:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                beq.s   Offset_0x0292A4
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Coconuts_AnimateData), A1             ; Offset_0x029366
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x0292A4:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$10, Obj_Timer(A0)                              ; $002A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0    
;-------------------------------------------------------------------------------
Offset_0x0292B2:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0292C4(PC, D0), D1
                jsr     Offset_0x0292C4(PC, D1)
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------   
Offset_0x0292C4:
                dc.w    Offset_0x0292C8-Offset_0x0292C4
                dc.w    Offset_0x0292E4-Offset_0x0292C4          
;-------------------------------------------------------------------------------   
Offset_0x0292C8:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x0292D0
                rts
Offset_0x0292D0:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$08, Obj_Timer(A0)                              ; $002A
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                bra     Offset_0x029300        
;-------------------------------------------------------------------------------
Offset_0x0292E4:
                subq.b  #$01, Obj_Timer(A0)                              ; $002A
                bmi.s   Offset_0x0292EC
                rts
Offset_0x0292EC:
                clr.b   Obj_Routine_2(A0)                                ; $0025
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.b  #$08, Obj_Timer(A0)                              ; $002A
                bra     Offset_0x029260
Offset_0x029300:
                bsr     Jmp_10_To_SingleObjectLoad             ; Offset_0x02A79A
                bne.s   Offset_0x029352
                move.b  #$98, Obj_Id(A1)                                 ; $0000
                move.b  #$03, Obj_Map_Id(A1)                             ; $001A
                move.b  #$20, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$FFF3, Obj_Y(A1)                                ; $000C
                ori.b   #$80, Obj_Col_Flags(A1)                          ; $0020
                moveq   #$00, D0
                btst    #$00, Obj_Flags(A0)                              ; $0001
                bne.s   Offset_0x02933C
                moveq   #$04, D0
Offset_0x02933C:
                lea     Offset_0x029354(PC, D0), A2
                move.w  (A2)+, D0
                add.w   D0, Obj_X(A1)                                    ; $0008
                move.w  (A2)+, Obj_Speed(A1)                             ; $0010
                lea     Coconuts_Weapon(PC), A2                ; Offset_0x028D24
                move.l  A2, Obj_Timer(A1)                                ; $002A
Offset_0x029352:
                rts    
;-------------------------------------------------------------------------------  
Offset_0x029354:
                dc.w    $FFF5, $0100, $000B, $FF00         
;------------------------------------------------------------------------------- 
Obj_0x9D_Ptr:                                                  ; Offset_0x02935C
                dc.l    Coconuts_Mappings                      ; Offset_0x029374
                dc.w    $03EE
                dc.b    $04, $05, $0C, $09     
;-------------------------------------------------------------------------------                            
Coconuts_AnimateData:                                          ; Offset_0x029366
                dc.w    Offset_0x02936A-Coconuts_AnimateData
                dc.w    Offset_0x02936E-Coconuts_AnimateData
Offset_0x02936A:
                dc.b    $05, $00, $01, $FF
Offset_0x02936E:
                dc.b    $09, $01, $02, $01, $FF, $00
;------------------------------------------------------------------------------- 
Coconuts_Mappings:                                             ; Offset_0x029374
                dc.w    Offset_0x02937C-Coconuts_Mappings
                dc.w    Offset_0x02939E-Coconuts_Mappings
                dc.w    Offset_0x0293C0-Coconuts_Mappings
                dc.w    Offset_0x0293E2-Coconuts_Mappings
Offset_0x02937C:
                dc.w    $0004
                dc.l    $0005001A, $000DFFFE
                dc.l    $F0090000, $0000FFFC
                dc.l    $000D0006, $0003FFF4
                dc.l    $1001000E, $0007000C
Offset_0x02939E:
                dc.w    $0004
                dc.l    $0005001E, $000FFFFE
                dc.l    $F0090000, $0000FFFC
                dc.l    $000D0010, $0008FFF4
                dc.l    $10010018, $000C000C
Offset_0x0293C0:
                dc.w    $0004
                dc.l    $F8010022, $00110007
                dc.l    $F0090000, $0000FFFC
                dc.l    $000D0010, $0008FFF4
                dc.l    $10010018, $000C000C
Offset_0x0293E2:
                dc.w    $0002
                dc.l    $F8014024, $4012FFF8
                dc.l    $F8014824, $48120000
;===============================================================================
; Objeto 0x9D - Inimigo Coconuts na Green Hill
; <<<-
;===============================================================================