;===============================================================================
; Objeto 0x68 - Bloco com harpão na Metropolis
; ->>> 
;===============================================================================
; Offset_0x01C334:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01C342(PC, D0), D1
                jmp     Offset_0x01C342(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01C342:
                dc.w    Offset_0x01C348-Offset_0x01C342
                dc.w    Offset_0x01C3EA-Offset_0x01C342
                dc.w    Offset_0x01C402-Offset_0x01C342       
;-------------------------------------------------------------------------------
Offset_0x01C348:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Block_Harpon_Mappings, Obj_Map(A0) ; Offset_0x01C4F0, $0004
                move.w  #$6414, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_13_To_ModifySpriteAttr_2P          ; Offset_0x01C610
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                bsr     Jmp_09_To_SingleObjectLoad_2           ; Offset_0x01C60A
                bne.s   Offset_0x01C3E4
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                addq.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_X(A1), Obj_Control_Var_04(A1)         ; $0008, $0030
                move.w  Obj_Y(A1), Obj_Control_Var_06(A1)         ; $000C, $0032
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  #$241C, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.w  ($FFFFFE04).w, D0
                lsr.w   #$06, D0
                move.w  D0, D1
                andi.w  #$0001, D0
                move.w  D0, Obj_Control_Var_0A(A1)                       ; $0036
                lsr.w   #$01, D1
                add.b   Obj_Subtype(A0), D1                              ; $0028
                andi.w  #$0003, D1
                move.b  D1, Obj_Routine_2(A1)                            ; $0025
                move.b  D1, Obj_Map_Id(A1)                               ; $001A
                lea     (Offset_0x01C4EC), A2
                move.b  $00(A2, D1), Obj_Col_Flags(A1)                   ; $0020
Offset_0x01C3E4:
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A  
;-------------------------------------------------------------------------------
Offset_0x01C3EA:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  #$0011, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_08_To_SolidObject                  ; Offset_0x01C616
                bra     Jmp_11_To_MarkObjGone                  ; Offset_0x01C604 
;-------------------------------------------------------------------------------
Offset_0x01C402:
                bsr     Offset_0x01C46A
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                add.w   D0, D0
                move.w  Offset_0x01C41E(PC, D0), D1
                jsr     Offset_0x01C41E(PC, D1)
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bra     Jmp_01_To_MarkObjGone_2                ; Offset_0x01C61C            
;-------------------------------------------------------------------------------   
Offset_0x01C41E:
                dc.w    Offset_0x01C426-Offset_0x01C41E
                dc.w    Offset_0x01C438-Offset_0x01C41E
                dc.w    Offset_0x01C448-Offset_0x01C41E
                dc.w    Offset_0x01C458-Offset_0x01C41E         
;------------------------------------------------------------------------------- 
Offset_0x01C426:
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                neg.w   D0
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $000C
                rts     
;------------------------------------------------------------------------------- 
Offset_0x01C438:
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0008
                rts      
;------------------------------------------------------------------------------- 
Offset_0x01C448:
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                add.w   Obj_Control_Var_06(A0), D0                       ; $0032
                move.w  D0, Obj_Y(A0)                                    ; $000C
                rts  
;------------------------------------------------------------------------------- 
Offset_0x01C458:
                moveq   #$00, D0
                move.b  Obj_Control_Var_08(A0), D0                       ; $0034
                neg.w   D0
                add.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_X(A0)                                    ; $0008
                rts
Offset_0x01C46A:
                tst.w   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x01C48E
                move.b  ($FFFFFE05).w, D0
                andi.b  #$3F, D0
                bne.s   Offset_0x01C4EA
                clr.w   Obj_Control_Var_0C(A0)                           ; $0038
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x01C48E
                move.w  #$00B6, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x01C48E:
                tst.w   Obj_Control_Var_0A(A0)                           ; $0036
                beq.s   Offset_0x01C4CA
                subi.w  #$0800, Obj_Control_Var_08(A0)                   ; $0034
                bcc.s   Offset_0x01C4EA
                move.w  #$0000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0000, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$0001, Obj_Control_Var_0C(A0)                   ; $0038
                addq.b  #$01, Obj_Routine_2(A0)                          ; $0025
                andi.b  #$03, Obj_Routine_2(A0)                          ; $0025
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  Offset_0x01C4EC(PC, D0), Obj_Col_Flags(A0)       ; $0020
                rts
Offset_0x01C4CA:
                addi.w  #$0800, Obj_Control_Var_08(A0)                   ; $0034
                cmpi.w  #$2000, Obj_Control_Var_08(A0)                   ; $0034
                bcs.s   Offset_0x01C4EA
                move.w  #$2000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0001, Obj_Control_Var_0A(A0)                   ; $0036
                move.w  #$0001, Obj_Control_Var_0C(A0)                   ; $0038
Offset_0x01C4EA:
                rts 
;-------------------------------------------------------------------------------  
Offset_0x01C4EC:
                dc.b    $84, $A6, $84, $A6       
;-------------------------------------------------------------------------------
Block_Harpon_Mappings:                                         ; Offset_0x01C4F0
                dc.w    Offset_0x01C4FA-Block_Harpon_Mappings
                dc.w    Offset_0x01C504-Block_Harpon_Mappings
                dc.w    Offset_0x01C50E-Block_Harpon_Mappings
                dc.w    Offset_0x01C518-Block_Harpon_Mappings
                dc.w    Offset_0x01C522-Block_Harpon_Mappings
Offset_0x01C4FA:
                dc.w    $0001
                dc.l    $F0031000, $1000FFFC
Offset_0x01C504:
                dc.w    $0001
                dc.l    $FC0C0004, $0002FFF0
Offset_0x01C50E:
                dc.w    $0001
                dc.l    $F0030000, $0000FFFC
Offset_0x01C518:
                dc.w    $0001
                dc.l    $FC0C0804, $0802FFF0
Offset_0x01C522:
                dc.w    $0002
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070800, $08000000       
;===============================================================================
; Objeto 0x68 - Bloco com harpão na Metropolis
; <<<- 
;===============================================================================