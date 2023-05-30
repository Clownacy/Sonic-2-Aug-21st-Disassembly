;===============================================================================
; Objeto 0x19 - Platformas rotatórias - Oil Ocean...
; ->>> 
;===============================================================================  
; Offset_0x016EB8:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x016EC6(PC, D0), D1
                jmp     Offset_0x016EC6(PC, D1)  
;-------------------------------------------------------------------------------
Offset_0x016EC6:
                dc.w    Offset_0x016ED4-Offset_0x016EC6
                dc.w    Offset_0x016F3C-Offset_0x016EC6    
;-------------------------------------------------------------------------------
Offset_0x016ECA:
                dc.b    $20, $00
                dc.b    $18, $01
                dc.b    $40, $02
                dc.b    $40, $03
                dc.b    $30, $04
;------------------------------------------------------------------------------- 
Offset_0x016ED4:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Rotating_Platforms_Mappings, Obj_Map(A0) ; Offset_0x0170AE, $0004
                move.w  #$63A0, Obj_Art_VRAM(A0)                         ; $0002
                cmpi.b  #$0A, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x016EF4
                move.w  #$62F4, Obj_Art_VRAM(A0)                         ; $0002
Offset_0x016EF4:
                bsr     Jmp_03_To_ModifySpriteAttr_2P          ; Offset_0x017108
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$03, D0
                andi.w  #$001E, D0
                lea     Offset_0x016ECA(PC, D0), A2
                move.b  (A2)+, Obj_Width(A0)                             ; $0019
                move.b  (A2)+, Obj_Map_Id(A0)                            ; $001A
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028
                cmpi.b  #$07, Obj_Subtype(A0)                            ; $0028
                bne.s   Offset_0x016F3C
                subi.w  #$00C0, Obj_Y(A0)                                ; $000C  
;------------------------------------------------------------------------------- 
Offset_0x016F3C:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x016F6C
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                move.w  #$0010, D3
                move.w  (A7)+, D4
                bsr     Platform_Object                        ; Offset_0x00F82C
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_04_To_DeleteObject                 ; Offset_0x017102
                bra     Jmp_03_To_DisplaySprite                ; Offset_0x0170FC
Offset_0x016F6C:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                add.w   D0, D0
                move.w  Offset_0x016F80(PC, D0), D1
                jmp     Offset_0x016F80(PC, D1)           
;-------------------------------------------------------------------------------
Offset_0x016F80:
                dc.w    Offset_0x016FA0-Offset_0x016F80
                dc.w    Offset_0x016FAA-Offset_0x016F80
                dc.w    Offset_0x016FCA-Offset_0x016F80
                dc.w    Offset_0x016FEA-Offset_0x016F80
                dc.w    Offset_0x016FFA-Offset_0x016F80
                dc.w    Offset_0x01701A-Offset_0x016F80
                dc.w    Offset_0x01701C-Offset_0x016F80
                dc.w    Offset_0x01701C-Offset_0x016F80
                dc.w    Offset_0x017038-Offset_0x016F80
                dc.w    Offset_0x017038-Offset_0x016F80
                dc.w    Offset_0x017038-Offset_0x016F80
                dc.w    Offset_0x017038-Offset_0x016F80
                dc.w    Offset_0x017072-Offset_0x016F80
                dc.w    Offset_0x017072-Offset_0x016F80
                dc.w    Offset_0x017072-Offset_0x016F80
                dc.w    Offset_0x017072-Offset_0x016F80  
;-------------------------------------------------------------------------------  
Offset_0x016FA0:
                move.b  ($FFFFFE68).w, D0
                move.w  #$0040, D1
                bra.s   Offset_0x016FB2   
;-------------------------------------------------------------------------------  
Offset_0x016FAA:
                move.b  ($FFFFFE6C).w, D0
                move.w  #$0060, D1
Offset_0x016FB2:
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x016FBE
                neg.w   D0
                add.w   D1, D0
Offset_0x016FBE:
                move.w  Obj_Control_Var_04(A0), D1                       ; $0030
                sub.w   D0, D1
                move.w  D1, Obj_X(A0)                                    ; $0008
                rts           
;-------------------------------------------------------------------------------  
Offset_0x016FCA:
                move.b  ($FFFFFE7C).w, D0
                move.w  #$0080, D1
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x016FDE
                neg.w   D0
                add.w   D1, D0
Offset_0x016FDE:
                move.w  Obj_Control_Var_06(A0), D1                       ; $0032
                sub.w   D0, D1
                move.w  D1, Obj_Y(A0)                                    ; $000C
                rts     
;-------------------------------------------------------------------------------  
Offset_0x016FEA:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x016FF8
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
Offset_0x016FF8:
                rts    
;-------------------------------------------------------------------------------  
Offset_0x016FFA:
                bsr     Jmp_01_To_SpeedToPos                   ; Offset_0x01710E
                moveq   #$08, D1
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                subi.w  #$0060, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x017010
                neg.w   D1
Offset_0x017010:
                add.w   D1, Obj_Speed_Y(A0)                              ; $0012
                bne.s   Offset_0x01701A
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028 
;-------------------------------------------------------------------------------  
Offset_0x01701A:
                rts       
;-------------------------------------------------------------------------------  
Offset_0x01701C:
                bsr     Jmp_01_To_SpeedToPos                   ; Offset_0x01710E
                moveq   #$08, D1
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                subi.w  #$0060, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcc.s   Offset_0x017032
                neg.w   D1
Offset_0x017032:
                add.w   D1, Obj_Speed_Y(A0)                              ; $0012
                rts          
;-------------------------------------------------------------------------------  
Offset_0x017038:
                move.b  ($FFFFFE98).w, D1
                subi.b  #$40, D1
                ext.w   D1
                move.b  ($FFFFFE9C).w, D2
                subi.b  #$40, D2
                ext.w   D2
                btst    #$02, D0
                beq.s   Offset_0x017056
                neg.w   D1
                neg.w   D2
Offset_0x017056:
                btst    #$01, D0
                beq.s   Offset_0x017060
                neg.w   D1
                exg.l   D1, D2
Offset_0x017060:
                add.w   Obj_Control_Var_04(A0), D1                       ; $0030
                move.w  D1, Obj_X(A0)                                    ; $0008
                add.w   Obj_Control_Var_06(A0), D2                       ; $0032
                move.w  D2, Obj_Y(A0)                                    ; $000C
                rts     
;-------------------------------------------------------------------------------  
Offset_0x017072:
                move.b  ($FFFFFE98).w, D1
                subi.b  #$40, D1
                ext.w   D1
                move.b  ($FFFFFE9C).w, D2
                subi.b  #$40, D2
                ext.w   D2
                btst    #$02, D0
                beq.s   Offset_0x017090
                neg.w   D1
                neg.w   D2
Offset_0x017090:
                btst    #$01, D0
                beq.s   Offset_0x01709A
                neg.w   D1
                exg.l   D1, D2
Offset_0x01709A:
                neg.w   D1
                add.w   Obj_Control_Var_04(A0), D1                       ; $0030
                move.w  D1, Obj_X(A0)                                    ; $0008
                add.w   Obj_Control_Var_06(A0), D2                       ; $0032
                move.w  D2, Obj_Y(A0)                                    ; $000C
                rts             
;-------------------------------------------------------------------------------
Rotating_Platforms_Mappings:                                   ; Offset_0x0170AE
                dc.w    Offset_0x0170B4-Rotating_Platforms_Mappings
                dc.w    Offset_0x0170C6-Rotating_Platforms_Mappings
                dc.w    Offset_0x0170D8-Rotating_Platforms_Mappings
Offset_0x0170B4:
                dc.w    $0002
                dc.l    $F00F0000, $0000FFE0
                dc.l    $F00F0800, $08000000
Offset_0x0170C6:
                dc.w    $0002
                dc.l    $F00B0000, $0000FFE8
                dc.l    $F00B0800, $08000000
Offset_0x0170D8:
                dc.w    $0004
                dc.l    $F00E0000, $0000FFC0
                dc.l    $F00E000C, $0006FFE0
                dc.l    $F00E080C, $08060000
                dc.l    $F00E0800, $08000020
;===============================================================================
; Objeto 0x19 - Platformas rotatórias - Oil Ocean...
; <<<- 
;===============================================================================