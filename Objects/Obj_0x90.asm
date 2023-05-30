;===============================================================================
; Objeto 0x90 -> Pedras espirrando quando o Grounder sai da parede na
; ->>>           Neo Green Hill, carregado a partir do objeto 0x8D / 0x8E
;===============================================================================
; Offset_0x0281E4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0281F2(PC, D0), D1
                jmp     Offset_0x0281F2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0281F2:
                dc.w    Offset_0x0281F6-Offset_0x0281F2
                dc.w    Offset_0x02822C-Offset_0x0281F2  
;-------------------------------------------------------------------------------
Offset_0x0281F6:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$4509, Obj_Art_VRAM(A0)                         ; $0002
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                move.b  Offset_0x028222(PC, D0), Obj_Speed(A0)           ; $0010
                move.b  Offset_0x028222+$01(PC, D0), Obj_Speed_Y(A0)     ; $0012
                lsr.w   #$01, D0
                move.b  Offset_0x02821C(PC, D0), Obj_Map_Id(A0)          ; $001A
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------  
Offset_0x02821C:
                dc.b    $00, $02, $00, $01, $00, $00      
;-------------------------------------------------------------------------------
Offset_0x028222:
                dc.b    $FF, $FC, $04, $FD, $02, $00, $FD, $FF
                dc.b    $FD, $FD                    
;-------------------------------------------------------------------------------
Offset_0x02822C:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                bsr     Jmp_0E_To_ObjectFall                   ; Offset_0x02A7BE
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
Offset_0x02823C:
                moveq   #$00, D1
                moveq   #$04, D6
Offset_0x028240:
                bsr     Jmp_10_To_SingleObjectLoad             ; Offset_0x02A79A
                bne.s   Offset_0x02824E
                bsr     Offset_0x028250
                dbra    D6, Offset_0x028240
Offset_0x02824E:
                rts
Offset_0x028250:
                move.b  #$90, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Subtype(A1)                            ; $0028
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  D1, Obj_Control_Var_00(A1)                       ; $002C
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addq.w  #$02, D1
                rts
Offset_0x028274:
                moveq   #$00, D1
                moveq   #$03, D6
Offset_0x028278:
                bsr     Jmp_10_To_SingleObjectLoad             ; Offset_0x02A79A
                bne.s   Offset_0x028286
                bsr     Offset_0x028288
                dbra    D6, Offset_0x028278
Offset_0x028286:
                rts
Offset_0x028288:
                move.b  #$8F, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Subtype(A1)                            ; $0028
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  D1, Obj_Control_Var_00(A1)                       ; $002C
                move.l  Obj_X(A0), D0                                    ; $0008
                swap.w  D0
                moveq   #$00, D2
                move.b  Offset_0x0282CC(PC, D1), D2
                ext.w   D2
                add.w   D2, D0
                swap.w  D0
                move.l  D0, Obj_X(A1)                                    ; $0008
                move.l  Obj_Y(A0), D0                                    ; $000C
                swap.w  D0
                moveq   #$00, D2
                move.b  Offset_0x0282CC+$01(PC, D1), D2
                ext.w   D2
                add.w   D2, D0
                swap.w  D0
                move.l  D0, Obj_Y(A1)                                    ; $000C
                addq.w  #$02, D1
                rts
;------------------------------------------------------------------------------- 
Offset_0x0282CC:
                dc.b    $00, $EC, $10, $00, $00, $0C, $F0, $00      
;-------------------------------------------------------------------------------  
Obj_0x8E_Ptr:                                                  ; Offset_0x0282D4
                dc.l    Grounder_Mappings                      ; Offset_0x028300
                dc.w    $2509
                dc.b    $04, $05, $10, $02   
;-------------------------------------------------------------------------------
Obj_0x8F_Ptr:                                                  ; Offset_0x0282DE
                dc.l    Grounder_Wall_Mappings                 ; Offset_0x028310
                dc.w    $2434
                dc.b    $84, $04, $10, $00     
;-------------------------------------------------------------------------------
Obj_0x90_Ptr:                                                  ; Offset_0x0282E8
                dc.l    Grounder_Rock_Mappings                 ; Offset_0x02830A
                dc.w    $2509
                dc.b    $84, $04, $08, $00              
;-------------------------------------------------------------------------------       
Grounder_AnimateData:                                          ; Offset_0x0282F2
                dc.w    Offset_0x0282F4-Grounder_AnimateData
Offset_0x0282F4:
                dc.b    $03, $02, $03, $04, $FF, $00       
;-------------------------------------------------------------------------------  
Grounder_AnimateData_01:                                       ; Offset_0x0282FA
                dc.w    Offset_0x0282FC-Grounder_AnimateData_01
Offset_0x0282FC:
                dc.b    $07, $00, $01, $FC            
;-------------------------------------------------------------------------------    
Grounder_Mappings:                                             ; Offset_0x028300
                dc.w    Offset_0x028312-Grounder_Mappings
                dc.w    Offset_0x028334-Grounder_Mappings
                dc.w    Offset_0x028356-Grounder_Mappings
                dc.w    Offset_0x028368-Grounder_Mappings
                dc.w    Offset_0x02837A-Grounder_Mappings
Grounder_Rock_Mappings:                                        ; Offset_0x02830A
                dc.w    Offset_0x02838C-Grounder_Rock_Mappings
                dc.w    Offset_0x028396-Grounder_Rock_Mappings
                dc.w    Offset_0x0283A0-Grounder_Rock_Mappings
Grounder_Wall_Mappings:                                        ; Offset_0x028310
                dc.w    Offset_0x0283AA-Grounder_Wall_Mappings                
Offset_0x028312:
                dc.w    $0004
                dc.l    $F4000000, $0000FFF8
                dc.l    $FC060001, $0000FFF0
                dc.l    $F4000800, $08000000
                dc.l    $FC060801, $08000000
Offset_0x028334:
                dc.w    $0004
                dc.l    $EC000007, $0003FFF8
                dc.l    $F4070008, $0004FFF0
                dc.l    $EC000807, $08030000
                dc.l    $F4070808, $08040000
Offset_0x028356:
                dc.w    $0002
                dc.l    $EC0F0010, $0008FFF0
                dc.l    $0C0C0020, $0010FFF0
Offset_0x028368:
                dc.w    $0002
                dc.l    $EC0F0010, $0008FFF0
                dc.l    $0C0C0024, $0012FFF0
Offset_0x02837A:
                dc.w    $0002
                dc.l    $EC0F0010, $0008FFF0
                dc.l    $0C0C0028, $0014FFF0    
Offset_0x02838C:
                dc.w    $0001
                dc.l    $F805002C, $0016FFF8
Offset_0x028396:
                dc.w    $0001
                dc.l    $FC000030, $0018FFFC
Offset_0x0283A0:
                dc.w    $0001
                dc.l    $FC000031, $0018FFFC
Offset_0x0283AA:
                dc.w    $0002
                dc.l    $F8050093, $0049FFF0
                dc.l    $F8050097, $004B0000
;===============================================================================
; Objeto 0x90 -> Pedras espirrando quando o Grounder sai da parede na
; <<<-           Neo Green Hill, carregado a partir do objeto 0x8D / 0x8E
;===============================================================================