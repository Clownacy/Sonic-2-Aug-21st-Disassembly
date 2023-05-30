;===============================================================================
; Objeto 0x7D - Bonus oculto no final das fases.
; ->>>          Left Over do Sonic 1, não usado.
;===============================================================================  
; Offset_0x014768:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x014776(PC, D0), D1
                jmp     Offset_0x014776(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x014776:
                dc.w    Offset_0x01477A-Offset_0x014776
                dc.w    Offset_0x01481E-Offset_0x014776    
;-------------------------------------------------------------------------------  
Offset_0x01477A:
                moveq   #$10, D2
                move.w  D2, D3
                add.w   D3, D3
                lea     (Player_One).w, A1                           ; $FFFFB000
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                add.w   D2, D0
                cmp.w   D3, D0
                bcc.s   Offset_0x0147FC
                move.w  Obj_Y(A1), D1                                    ; $000C
                sub.w   Obj_Y(A0), D1                                    ; $000C
                add.w   D2, D1
                cmp.w   D3, D1
                bcc.s   Offset_0x0147FC
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x0147FC
                tst.b   ($FFFFF7CD).w
                bne.s   Offset_0x0147FC
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Hidden_Bonus_Mappings, Obj_Map(A0) ; Offset_0x014842, $0004
                move.w  #$84B6, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$00, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $001A, $0028
                move.w  #$0077, Obj_Control_Var_04(A0)                   ; $0030
                move.w  #$00C9, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, D0
                move.w  Hidden_Bonus_Points(PC, D0), D0        ; Offset_0x014816
                jsr     (AddPoints)                            ; Offset_0x02D2D4
Offset_0x0147FC:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x014810
                rts
Offset_0x014810:
                jmp     (DeleteObject)                         ; Offset_0x00D314      
;------------------------------------------------------------------------------- 
Hidden_Bonus_Points:                                           ; Offset_0x014816
                dc.w    $0000
                dc.w    $03E8  ; 10000 pontos
                dc.w    $0064  ; 1000  pontos
                dc.w    $0001  ; 10    pontos ( deveria ser $000A  ; 100 pontos) 
;-------------------------------------------------------------------------------
Offset_0x01481E:
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bmi.s   Offset_0x01483C
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x01483C
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01483C:
                jmp     (DeleteObject)                         ; Offset_0x00D314  
;-------------------------------------------------------------------------------
Hidden_Bonus_Mappings:                                         ; Offset_0x014842
                dc.w    Offset_0x01484A-Hidden_Bonus_Mappings
                dc.w    Offset_0x01484C-Hidden_Bonus_Mappings
                dc.w    Offset_0x014856-Hidden_Bonus_Mappings
                dc.w    Offset_0x014860-Hidden_Bonus_Mappings
Offset_0x01484A:
                dc.w    $0000
Offset_0x01484C:
                dc.w    $0001
                dc.l    $F40E0000, $0000FFF0
Offset_0x014856:
                dc.w    $0001
                dc.l    $F40E000C, $0006FFF0
Offset_0x014860:
                dc.w    $0001
                dc.l    $F40E0018, $000CFFF0      
;===============================================================================
; Objeto 0x7D - Bonus oculto no final das fases.
; <<<-          Left Over do Sonic 1, não usado.
;===============================================================================