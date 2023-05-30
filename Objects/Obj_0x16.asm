;===============================================================================
; Objeto 0x16 - Teleféricos na Hill Top
; ->>> 
;===============================================================================  
; Offset_0x016C8C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x016C9A(PC, D0), D1
                jmp     Offset_0x016C9A(PC, D1) 
;-------------------------------------------------------------------------------  
Offset_0x016C9A:
                dc.w    Offset_0x016C9E-Offset_0x016C9A
                dc.w    Offset_0x016CE4-Offset_0x016C9A             
;-------------------------------------------------------------------------------   
Offset_0x016C9E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Teleferics_Mappings, Obj_Map(A0) ; Offset_0x016DB2, $0004
                move.w  #$43E6, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_02_To_ModifySpriteAttr_2P          ; Offset_0x016EAA
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.w  Obj_X(A0), Obj_Control_Var_04(A0)         ; $0008, $0030
                move.w  Obj_Y(A0), Obj_Control_Var_06(A0)         ; $000C, $0032
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsl.w   #$03, D0
                move.w  D0, Obj_Control_Var_08(A0)                       ; $0034   
;-------------------------------------------------------------------------------  
Offset_0x016CE4:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                bsr     Offset_0x016D00
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                move.w  #$FFD8, D3
                move.w  (A7)+, D4
                bsr     Platform_Object                        ; Offset_0x00F82C
                bra     Jmp_02_To_MarkObjGone                  ; Offset_0x016E9E
Offset_0x016D00:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x016D0E(PC, D0), D1
                jmp     Offset_0x016D0E(PC, D1)                    
;-------------------------------------------------------------------------------
Offset_0x016D0E:
                dc.w    Offset_0x016D14-Offset_0x016D0E
                dc.w    Offset_0x016D3C-Offset_0x016D0E
                dc.w    Offset_0x016D96-Offset_0x016D0E       
;-------------------------------------------------------------------------------  
Offset_0x016D14:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x016D3A
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0200, Obj_Speed(A0)                            ; $0010
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x016D34
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x016D34:
                move.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
Offset_0x016D3A:
                rts  
;-------------------------------------------------------------------------------  
Offset_0x016D3C:
                move.w  ($FFFFFE04).w, D0
                andi.w  #$000F, D0
                bne.s   Offset_0x016D50
                move.w  #$00E4, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x016D50:
                bsr     Jmp_00_To_SpeedToPos                   ; Offset_0x016EB0
                subq.w  #$01, Obj_Control_Var_08(A0)                     ; $0034
                bne.s   Offset_0x016D94
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$02, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0000, Obj_Speed(A0)                            ; $0010
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                bsr     Jmp_01_To_SingleObjectLoad_2           ; Offset_0x016EA4
                bne.s   Offset_0x016D94
                move.b  #$1C, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  #$06, Obj_Subtype(A1)                            ; $0028
Offset_0x016D94:
                rts        
;-------------------------------------------------------------------------------  
Offset_0x016D96:
                bsr     Jmp_00_To_SpeedToPos                   ; Offset_0x016EB0
                addi.w  #$0038, Obj_Speed_Y(A0)                          ; $0012
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
                addi.w  #$00E0, D0
                cmp.w   Obj_Y(A0), D0                                    ; $000C
                bcs     Jmp_03_To_DeleteObject                 ; Offset_0x016E98
                rts               
;-------------------------------------------------------------------------------
Teleferics_Mappings                                            ; Offset_0x016DB2
                dc.w    Offset_0x016DBC-Teleferics_Mappings
                dc.w    Offset_0x016E0E-Teleferics_Mappings
                dc.w    Offset_0x016E50-Teleferics_Mappings
                dc.w    Offset_0x016E62-Teleferics_Mappings
                dc.w    Offset_0x016E7C-Teleferics_Mappings
Offset_0x016DBC:
                dc.w    $000A
                dc.l    $C1050000, $0000FFE4
                dc.l    $D0030004, $0002FFE6
                dc.l    $F0030004, $0002FFE6
                dc.l    $10010008, $0004FFE7
                dc.l    $D505000A, $0005000C
                dc.l    $E003000E, $00070011
                dc.l    $10010012, $00090011
                dc.l    $0003000E, $00070011
                dc.l    $200D0014, $000AFFE0
                dc.l    $200D0814, $080A0000
Offset_0x016E0E:
                dc.w    $0008
                dc.l    $C1050000, $0000FFE4
                dc.l    $D0030004, $0002FFE6
                dc.l    $F0030004, $0002FFE6
                dc.l    $1001002C, $0016FFE6
                dc.l    $D505000A, $0005000C
                dc.l    $E003000E, $00070011
                dc.l    $1801002E, $00170011
                dc.l    $0003000E, $00070011
Offset_0x016E50:
                dc.w    $0002
                dc.l    $200D0014, $000AFFE0
                dc.l    $200D0814, $080A0000
Offset_0x016E62:
                dc.w    $0003
                dc.l    $D805001C, $000EFFF8
                dc.l    $E8070020, $0010FFF8
                dc.l    $08070020, $0010FFF8
Offset_0x016E7C:
                dc.w    $0003
                dc.l    $D8050028, $0014FFF8
                dc.l    $E8070820, $0810FFF8
                dc.l    $08070820, $0810FFF8
;===============================================================================
; Objeto 0x16 - Teleféricos na Hill Top
; <<<- 
;===============================================================================