;===============================================================================
; Objeto 0x33 - Aceleradores (Toque para ganhar impulso) na Oil Ocean
; ->>>
;===============================================================================
; Offset_0x018924:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x018932(PC, D0), D1
                jmp     Offset_0x018932(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x018932:
                dc.w    Offset_0x018938-Offset_0x018932
                dc.w    Offset_0x0189C0-Offset_0x018932
                dc.w    Offset_0x018BCA-Offset_0x018932     
;-------------------------------------------------------------------------------
Offset_0x018938:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Touch_Booster_Mappings, Obj_Map(A0) ; Offset_0x018C0C, $0004
                move.w  #$632C, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$18, Obj_Width(A0)                              ; $0019
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0078, Obj_Control_Var_0A(A0)                   ; $0036
                tst.b   Obj_Subtype(A0)                                  ; $0028
                beq.s   Offset_0x018978
                move.b  #$04, Obj_Routine_2(A0)                          ; $0025
Offset_0x018978:
                bsr     Jmp_04_To_SingleObjectLoad_2           ; Offset_0x018C62
                bne.s   Offset_0x0189C0
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                subi.w  #$0010, Obj_Y(A1)                                ; $000C
                move.l  #Touch_Booster_Mappings_01, Obj_Map(A1) ; Offset_0x018C20, $0004
                move.w  #$62E2, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.l  A0, Obj_Control_Var_10(A1)                       ; $003C     
;-------------------------------------------------------------------------------
Offset_0x0189C0:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x0189EC(PC, D0), D1
                jsr     Offset_0x0189EC(PC, D1)
                move.w  (A7)+, D4
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$08, D2
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_01_To_SolidObject                  ; Offset_0x018C68
                bra     Jmp_07_To_MarkObjGone                  ; Offset_0x018C5C             
;-------------------------------------------------------------------------------  
Offset_0x0189EC:
                dc.w    Offset_0x0189F6-Offset_0x0189EC
                dc.w    Offset_0x018A1A-Offset_0x0189EC
                dc.w    Offset_0x018A56-Offset_0x0189EC
                dc.w    Offset_0x018B50-Offset_0x0189EC
                dc.w    Offset_0x018BC8-Offset_0x0189EC     
;-------------------------------------------------------------------------------  
Offset_0x0189F6:
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bpl.s   Offset_0x018A18
                move.w  #$0078, Obj_Control_Var_0A(A0)                   ; $0036
                move.l  #$FFF69800, Obj_Control_Var_06(A0)               ; $0032
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$00D4, D0
                jsr     (Play_Sfx_Ex)                          ; Offset_0x00151E
Offset_0x018A18:
                rts  
;------------------------------------------------------------------------------- 
Offset_0x018A1A:
                move.l  Obj_Y(A0), D1                                    ; $000C
                add.l   Obj_Control_Var_06(A0), D1                       ; $0032
                move.l  D1, Obj_Y(A0)                                    ; $000C
                addi.l  #$00003800, Obj_Control_Var_06(A0)               ; $0032
                swap.w  D1
                cmp.w   Obj_Control_Var_04(A0), D1                       ; $0030
                bcs.s   Offset_0x018A54
                move.l  Obj_Control_Var_06(A0), D0                       ; $0032
                cmpi.l  #$00010000, D0
                bcc.s   Offset_0x018A46
                subq.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x018A46:
                lsr.l   #$02, D0
                neg.l   D0
                move.l  D0, Obj_Control_Var_06(A0)                       ; $0032
                move.w  Obj_Control_Var_04(A0), Obj_Y(A0)         ; $000C, $0030
Offset_0x018A54:
                rts   
;------------------------------------------------------------------------------- 
Offset_0x018A56:
                move.w  Obj_X(A0), D2                                    ; $0008
                move.w  D2, D3
                subi.w  #$0010, D2
                addi.w  #$0010, D3
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x018ACE
                cmpi.b  #$18, D0
                beq.s   Offset_0x018AD0
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                bsr.s   Offset_0x018A82
                lea     (Player_Two).w, A1                           ; $FFFFB040
                addq.b  #$01, D6
Offset_0x018A82:
                btst    D6, Obj_Status(A0)                               ; $0022
                beq.s   Offset_0x018ACE
                move.w  Obj_X(A1), D0                                    ; $0008
                cmp.w   D2, D0
                bcs.s   Offset_0x018ACE
                cmp.w   D3, D0
                bcc.s   Offset_0x018ACE
                move.b  #$01, Obj_Timer(A1)                              ; $002A
                move.w  #$0000, Obj_Inertia(A1)                          ; $0014
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
                bclr    #$05, Obj_Status(A1)                             ; $0022
                bclr    #$07, Obj_Art_VRAM(A1)                           ; $0002
                move.l  #$FFF69800, Obj_Control_Var_06(A0)               ; $0032
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$00D4, D0
                jsr     (Play_Sfx_Ex)                          ; Offset_0x00151E
Offset_0x018ACE:
                rts
Offset_0x018AD0:
                lea     (Player_One).w, A1                           ; $FFFFB000
                move.w  Obj_X(A1), D0                                    ; $0008
                cmp.w   D2, D0
                bcs.s   Offset_0x018B4E
                cmp.w   D3, D0
                bcc.s   Offset_0x018B4E
                lea     (Player_Two).w, A2                           ; $FFFFB040
                move.w  Obj_X(A2), D0                                    ; $0008
                cmp.w   D2, D0
                bcs.s   Offset_0x018B4E
                cmp.w   D3, D0
                bcc.s   Offset_0x018B4E
                move.b  #$01, Obj_Timer(A1)                              ; $002A
                move.w  #$0000, Obj_Inertia(A1)                          ; $0014
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
                bclr    #$05, Obj_Status(A1)                             ; $0022
                bclr    #$07, Obj_Art_VRAM(A1)                           ; $0002
                move.b  #$01, Obj_Timer(A2)                              ; $002A
                move.w  #$0000, Obj_Inertia(A2)                          ; $0014
                move.w  #$0000, Obj_Speed(A2)                            ; $0010
                move.w  #$0000, Obj_Speed_Y(A2)                          ; $0012
                bclr    #$05, Obj_Status(A2)                             ; $0022
                bclr    #$07, Obj_Art_VRAM(A2)                           ; $0002
                move.l  #$FFF69800, Obj_Control_Var_06(A0)               ; $0032
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$00D4, D0
                jsr     (Play_Sfx_Ex)                          ; Offset_0x00151E
Offset_0x018B4E:
                rts 
;------------------------------------------------------------------------------- 
Offset_0x018B50:
                move.l  Obj_Y(A0), D1                                    ; $000C
                add.l   Obj_Control_Var_06(A0), D1                       ; $0032
                move.l  D1, Obj_Y(A0)                                    ; $000C
                addi.l  #$00003800, Obj_Control_Var_06(A0)               ; $0032
                swap.w  D1
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                subi.w  #$007D, D0
                cmp.w   D0, D1
                bne.s   Offset_0x018BC6
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$08, D0
                bsr.s   Offset_0x018B90
                lea     (Player_Two).w, A1                           ; $FFFFB040
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$10, D0
Offset_0x018B90:
                beq.s   Offset_0x018BC6
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$0800, Obj_Inertia(A1)                          ; $0014
                bset    #$01, Obj_Status(A1)                             ; $0022
                move.w  #$F000, Obj_Speed_Y(A1)                          ; $0012
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$00, Obj_Timer(A1)                              ; $002A
                move.w  #$00CC, D0
                jsr     (Play_Sfx_Ex)                          ; Offset_0x00151E
Offset_0x018BC6:
                rts      
;------------------------------------------------------------------------------- 
Offset_0x018BC8:
                rts    
;------------------------------------------------------------------------------- 
Offset_0x018BCA:
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                move.w  Obj_Y(A0), D0                                    ; $000C
                sub.w   Obj_Y(A1), D0                                    ; $000C
                cmpi.w  #$0014, D0
                blt.s   Offset_0x018BF2
                move.b  #$9B, Obj_Col_Flags(A0)                          ; $0020
                lea     (Touch_Booster_Animate_Data), A1       ; Offset_0x018C00
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                bra     Jmp_07_To_MarkObjGone                  ; Offset_0x018C5C
Offset_0x018BF2:
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
                rts
;-------------------------------------------------------------------------------                    
Touch_Booster_Animate_Data:                                    ; Offset_0x018C00
                dc.w    Offset_0x018C02-Touch_Booster_Animate_Data
Offset_0x018C02:
                dc.b    $02, $02, $00, $02, $00, $02, $00, $01
                dc.b    $FF, $00        
;-------------------------------------------------------------------------------
Touch_Booster_Mappings:                                        ; Offset_0x018C0C
                dc.w    Offset_0x018C0E-Touch_Booster_Mappings
Offset_0x018C0E:
                dc.w    $0002
                dc.l    $F8090000, $0000FFE8
                dc.l    $F8090800, $08000000       
;-------------------------------------------------------------------------------
Touch_Booster_Mappings_01:                                     ; Offset_0x018C20
                dc.w    Offset_0x018C26-Touch_Booster_Mappings_01
                dc.w    Offset_0x018C38-Touch_Booster_Mappings_01
                dc.w    Offset_0x018C4A-Touch_Booster_Mappings_01
Offset_0x018C26:
                dc.w    $0002
                dc.l    $F8060000, $0000FFF0
                dc.l    $F8060800, $08000000
Offset_0x018C38:
                dc.w    $0002
                dc.l    $F0070006, $0003FFF0
                dc.l    $F0070806, $08030000
Offset_0x018C4A:
                dc.w    $0002
                dc.l    $0005000E, $0007FFF0
                dc.l    $0005080E, $08070000 
;===============================================================================
; Objeto 0x33 - Aceleradores (Toque para ganhar impulso) na Oil Ocean
; <<<-
;===============================================================================