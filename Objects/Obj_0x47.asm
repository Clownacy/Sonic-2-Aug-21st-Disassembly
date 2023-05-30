;===============================================================================
; Objeto 0x47 - Interruptor usado para abrir certas portas nas fases
; ->>> 
;===============================================================================
; Offset_0x019B1C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x019B2A(PC, D0), D1
                jmp     Offset_0x019B2A(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x019B2A:
                dc.w    Offset_0x019B2E-Offset_0x019B2A
                dc.w    Offset_0x019B5A-Offset_0x019B2A        
;-------------------------------------------------------------------------------  
Offset_0x019B2E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Switch_Mappings, Obj_Map(A0)   ; Offset_0x019BBE, $0004
                move.w  #$0424, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_09_To_ModifySpriteAttr_2P          ; Offset_0x019BEA
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                addq.w  #$04, Obj_Y(A0)                                  ; $000C  
;-------------------------------------------------------------------------------  
Offset_0x019B5A:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x019BBA
                move.w  #$001B, D1
                move.w  #$0004, D2
                move.w  #$0005, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Jmp_03_To_SolidObject                  ; Offset_0x019BF0
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lea     ($FFFFF7E0).w, A3
                lea     $00(A3, D0), A3
                moveq   #$00, D3
                btst    #$06, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x019B96
                moveq   #$07, D3
Offset_0x019B96:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                bne.s   Offset_0x019BA4
                bclr    D3, (A3)
                bra.s   Offset_0x019BBA
Offset_0x019BA4:
                tst.b   (A3)
                bne.s   Offset_0x019BB2
                move.w  #$00CD, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x019BB2:
                bset    D3, (A3)
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x019BBA:
                bra     Jmp_09_To_MarkObjGone                  ; Offset_0x019BE4          
;-------------------------------------------------------------------------------
Switch_Mappings:                                               ; Offset_0x019BBE
                dc.w    Offset_0x019BC4-Switch_Mappings
                dc.w    Offset_0x019BCE-Switch_Mappings
                dc.w    Offset_0x019BD8-Switch_Mappings
Offset_0x019BC4:
                dc.w    $0001
                dc.l    $F40D0000, $0000FFF0
Offset_0x019BCE:
                dc.w    $0001
                dc.l    $F40D0008, $0004FFF0
Offset_0x019BD8:
                dc.w    $0001
                dc.l    $F80D0000, $0000FFF0
;===============================================================================
; Objeto 0x47 - Interruptor usado para abrir certas portas nas fases
; <<<- 
;===============================================================================