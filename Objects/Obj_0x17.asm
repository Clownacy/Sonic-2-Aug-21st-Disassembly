;===============================================================================
; Objeto 0x17 - Espinhos em espiral girando na Green Hill - Left over do Sonic 1
; ->>> 
;===============================================================================
; Offset_0x009044
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x009052(PC, D0), D1
                jmp     Offset_0x009052(PC, D1)    
;-------------------------------------------------------------------------------  
Offset_0x009052:
                dc.w    Offset_0x009058-Offset_0x009052
                dc.w    Offset_0x00911C-Offset_0x009052
                dc.w    Offset_0x00917E-Offset_0x009052   
;-------------------------------------------------------------------------------   
Offset_0x009058:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Log_Spikes_Mappings, Obj_Map(A0) ; Offset_0x009186, $0004
                move.w  #$4398, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  Obj_X(A0), D3                                    ; $0008
                move.b  Obj_Id(A0), D4                                   ; $0000
                lea     Obj_Subtype(A0), A2                              ; $0028
                moveq   #$00, D1
                move.b  (A2), D1
                move.b  #$00, (A2)+
                move.w  D1, D0
                lsr.w   #$01, D0
                lsl.w   #$04, D0
                sub.w   D0, D3
                subq.b  #$02, D1
                bcs.s   Offset_0x00911C
                moveq   #$00, D6
Offset_0x0090A6:
                bsr     SingleObjectLoad_2                     ; Offset_0x00E714
                bne.s   Offset_0x00911C
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                move.w  A1, D5
                subi.w  #Obj_Memory_Address, D5                          ; $B000
                lsr.w   #$06, D5
                andi.w  #$007F, D5
                move.b  D5, (A2)+
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  D4, Obj_Id(A1)                                   ; $0000
                move.w  D2, Obj_Y(A1)                                    ; $000C
                move.w  D3, Obj_X(A1)                                    ; $0008
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  #$4398, Obj_Art_VRAM(A1)                         ; $0002
                bsr     ModifySpriteAttr_2P_A1                 ; Offset_0x00DBDA
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$03, Obj_Priority(A1)                           ; $0018
                move.b  #$08, Obj_Width(A1)                              ; $0019
                move.b  D6, Obj_Control_Var_12(A1)                       ; $003E
                addq.b  #$01, D6
                andi.b  #$07, D6
                addi.w  #$0010, D3
                cmp.w   Obj_X(A0), D3                                    ; $0008
                bne.s   Offset_0x009118
                move.b  D6, Obj_Control_Var_12(A0)                       ; $003E
                addq.b  #$01, D6
                andi.b  #$07, D6
                addi.w  #$0010, D3
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
Offset_0x009118:
                dbra    D1, Offset_0x0090A6    
;-------------------------------------------------------------------------------
Offset_0x00911C:
                bsr     Offset_0x00915E
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Offset_0x009138
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x009138:
                moveq   #$00, D2
                lea     Obj_Subtype(A0), A2                              ; $0028
                move.b  (A2)+, D2
                subq.b  #$02, D2
                bcs.s   Offset_0x00915A
Offset_0x009144:
                moveq   #$00, D0
                move.b  (A2)+, D0
                lsl.w   #$06, D0
                addi.l  #Obj_Memory_Address, D0                      ; $FFFFB000
                move.l  D0, A1
                bsr     DeleteObject_A1                        ; Offset_0x00D316
                dbra    D2, Offset_0x009144
Offset_0x00915A:
                bra     DeleteObject                           ; Offset_0x00D314
Offset_0x00915E:
                move.b  (Object_Frame_Buffer+$0001).w, D0            ; $FFFFFEA1
                move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
                add.b   Obj_Control_Var_12(A0), D0                       ; $003E
                andi.b  #$07, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                bne.s   Offset_0x00917C
                move.b  #$84, Obj_Col_Flags(A0)                          ; $0020
Offset_0x00917C:
                rts   
;------------------------------------------------------------------------------- 
Offset_0x00917E:
                bsr     Offset_0x00915E
                bra     DisplaySprite                          ; Offset_0x00D322   
;-------------------------------------------------------------------------------
Log_Spikes_Mappings:                                           ; Offset_0x009186
                dc.w    Offset_0x009196-Log_Spikes_Mappings
                dc.w    Offset_0x0091A0-Log_Spikes_Mappings
                dc.w    Offset_0x0091AA-Log_Spikes_Mappings
                dc.w    Offset_0x0091B4-Log_Spikes_Mappings
                dc.w    Offset_0x0091BE-Log_Spikes_Mappings
                dc.w    Offset_0x0091C8-Log_Spikes_Mappings
                dc.w    Offset_0x0091DC-Log_Spikes_Mappings
                dc.w    Offset_0x0091D2-Log_Spikes_Mappings
Offset_0x009196:
                dc.w    $0001
                dc.l    $F0010000, $0000FFFC
Offset_0x0091A0:
                dc.w    $0001
                dc.l    $F5050002, $0001FFF8
Offset_0x0091AA:
                dc.w    $0001
                dc.l    $F8050006, $0003FFF8
Offset_0x0091B4:
                dc.w    $0001
                dc.l    $FB05000A, $0005FFF8
Offset_0x0091BE:
                dc.w    $0001
                dc.l    $0001000E, $0007FFFC
Offset_0x0091C8:
                dc.w    $0001
                dc.l    $04000010, $0008FFFD
Offset_0x0091D2:
                dc.w    $0001
                dc.l    $F4000011, $0008FFFD
Offset_0x0091DC:
                dc.w    $0000
;===============================================================================
; Objeto 0x17 - Espinhos em espiral girando na Green Hill - Left over do Sonic 1
; <<<- 
;===============================================================================