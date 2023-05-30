;===============================================================================
; Objeto 0x27 - Rotina de resposta ao toque nos objetos das fases
; ->>> 
;===============================================================================
; Offset_0x016174:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x016182(PC, D0), D1
                jmp     Offset_0x016182(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x016182:
                dc.w    Offset_0x016188-Offset_0x016182
                dc.w    Offset_0x0161AA-Offset_0x016182
                dc.w    Offset_0x0161EE-Offset_0x016182  
;-------------------------------------------------------------------------------  
Offset_0x016188:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne.s   Offset_0x0161AA
                move.b  #$28, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_Control_Var_12(A0), Obj_Control_Var_12(A1); $003E, $003E 
;-------------------------------------------------------------------------------
Offset_0x0161AA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Object_Hit_Mappings, Obj_Map(A0) ; Offset_0x01620C, $0004
                move.w  #$05A4, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_00_To_ModifySpriteAttr_2P          ; Offset_0x01639C
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$0C, Obj_Width(A0)                              ; $0019
                move.b  #$03, Obj_Ani_Time(A0)                           ; $001E
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$00C1, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512  
;-------------------------------------------------------------------------------
Offset_0x0161EE:
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x016208
                move.b  #$07, Obj_Ani_Time(A0)                           ; $001E
                addq.b  #$01, Obj_Map_Id(A0)                             ; $001A
                cmpi.b  #$05, Obj_Map_Id(A0)                             ; $001A
                beq     Jmp_02_To_DeleteObject                 ; Offset_0x016396
Offset_0x016208:
                bra     Jmp_02_To_DisplaySprite                ; Offset_0x016390    
;-------------------------------------------------------------------------------            
Object_Hit_Mappings:                                           ; Offset_0x01620C
                dc.w    Offset_0x016216-Object_Hit_Mappings
                dc.w    Offset_0x016220-Object_Hit_Mappings
                dc.w    Offset_0x01622A-Object_Hit_Mappings
                dc.w    Offset_0x016234-Object_Hit_Mappings
                dc.w    Offset_0x01623E-Object_Hit_Mappings
Offset_0x016216:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8
Offset_0x016220:
                dc.w    $0001
                dc.l    $F00F2004, $2002FFF0
Offset_0x01622A:
                dc.w    $0001
                dc.l    $F00F2014, $200AFFF0
Offset_0x016234:
                dc.w    $0001
                dc.l    $F00F2024, $2012FFF0
Offset_0x01623E:
                dc.w    $0001
                dc.l    $F00F2034, $201AFFF0        
;===============================================================================
; Objeto 0x27 - Rotina de resposta ao toque nos objetos das fases
; <<<- 
;===============================================================================