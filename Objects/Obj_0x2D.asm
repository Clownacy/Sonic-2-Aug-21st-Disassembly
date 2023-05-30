;===============================================================================
; Objeto 0x2D - Porta automática na Chemical Plant / Hill Top / Metropolis
; ->>> 
;===============================================================================  
; Offset_0x00A22E
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00A23C(PC, D0), D1
                jmp     Offset_0x00A23C(PC, D1)   
;-------------------------------------------------------------------------------  
Offset_0x00A23C:
                dc.w    Offset_0x00A240-Offset_0x00A23C
                dc.w    Offset_0x00A2DE-Offset_0x00A23C        
;------------------------------------------------------------------------------- 
Offset_0x00A240:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Automatic_Door_Mappings, Obj_Map(A0) ; Offset_0x00A386, $0004
                move.w  #$2426, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$08, Obj_Width(A0)                              ; $0019
                cmpi.b  #$04, (Level_Id).w                           ; $FFFFFE10
                beq.s   Offset_0x00A268
                cmpi.b  #$05, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x00A274
Offset_0x00A268:
                move.w  #$6000, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$0C, Obj_Width(A0)                              ; $0019
Offset_0x00A274:
                cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x00A288
                move.w  #$2394, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$0C, Obj_Width(A0)                              ; $0019
Offset_0x00A288:
                cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x00A29C
                move.w  #$23F8, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$08, Obj_Width(A0)                              ; $0019
Offset_0x00A29C:
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $001A, $0028
                move.w  Obj_X(A0), D2                                    ; $0008
                move.w  D2, D3
                subi.w  #$0200, D2
                addi.w  #$0018, D3
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00A2D6
                subi.w  #$FE18, D2
                addi.w  #$01E8, D3
Offset_0x00A2D6:
                move.w  D2, Obj_Control_Var_0C(A0)                       ; $0038
                move.w  D3, Obj_Control_Var_0E(A0)                       ; $003A    
;------------------------------------------------------------------------------- 
Offset_0x00A2DE:
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00A2FA
                move.w  Obj_Control_Var_0C(A0), D2                       ; $0038
                move.w  Obj_X(A0), D3                                    ; $0008
                tst.b   Obj_Routine_2(A0)                                ; $0025
                beq.s   Offset_0x00A30C
                move.w  Obj_Control_Var_0E(A0), D3                       ; $003A
                bra.s   Offset_0x00A30C
Offset_0x00A2FA:
                move.w  Obj_X(A0), D2                                    ; $0008
                move.w  Obj_Control_Var_0E(A0), D3                       ; $003A
                tst.b   Obj_Routine_2(A0)                                ; $0025
                beq.s   Offset_0x00A30C
                move.w  Obj_Control_Var_0C(A0), D2                       ; $0038
Offset_0x00A30C:
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                cmp.w   D2, D0
                bcs     Offset_0x00A328
                cmp.w   D3, D0
                bcc     Offset_0x00A328
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x00A328:
                move.w  (Player_Two_Position_X).w, D0                ; $FFFFB048
                cmp.w   D2, D0
                bcs     Offset_0x00A33E
                cmp.w   D3, D0
                bcc     Offset_0x00A33E
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x00A33E:
                tst.b   Obj_Routine_2(A0)                                ; $0025
                beq.s   Offset_0x00A352
                cmpi.w  #$0040, Obj_Control_Var_04(A0)                   ; $0030
                beq.s   Offset_0x00A368
                addq.w  #$08, Obj_Control_Var_04(A0)                     ; $0030
                bra.s   Offset_0x00A35C
Offset_0x00A352:
                tst.w   Obj_Control_Var_04(A0)                           ; $0030
                beq.s   Offset_0x00A368
                subq.w  #$08, Obj_Control_Var_04(A0)                     ; $0030
Offset_0x00A35C:
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                sub.w   Obj_Control_Var_04(A0), D0                       ; $0030
                move.w  D0, Obj_Y(A0)                                    ; $000C
Offset_0x00A368:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                move.w  #$0020, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject                            ; Offset_0x00F344
                bra     MarkObjGone                            ; Offset_0x00D200       
;-------------------------------------------------------------------------------
Automatic_Door_Mappings:                                       ; Offset_0x00A386
                dc.w    Offset_0x00A38E-Automatic_Door_Mappings
                dc.w    Offset_0x00A3B0-Automatic_Door_Mappings
                dc.w    Offset_0x00A3C2-Automatic_Door_Mappings
                dc.w    Offset_0x00A3D4-Automatic_Door_Mappings
Offset_0x00A38E:
                dc.w    $0004
                dc.l    $E0050000, $0000FFF8
                dc.l    $F0050000, $0000FFF8
                dc.l    $00050000, $0000FFF8
                dc.l    $10050000, $0000FFF8
Offset_0x00A3B0:
                dc.w    $0002
                dc.l    $E00B005F, $002FFFF4
                dc.l    $000B005F, $002FFFF4
Offset_0x00A3C2:
                dc.w    $0002
                dc.l    $E0070000, $0000FFF8
                dc.l    $00070000, $0000FFF8
Offset_0x00A3D4:
                dc.w    $0002
                dc.l    $E0070000, $0000FFF8
                dc.l    $00070000, $0000FFF8 
;===============================================================================
; Objeto 0x2D - Porta automática na Chemical Plant / Hill Top / Metropolis
; <<<- 
;===============================================================================