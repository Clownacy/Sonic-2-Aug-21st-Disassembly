;===============================================================================
; Objeto 0x0E - Sonic e Miles na Tela Título
; ->>> 
;===============================================================================
; Offset_0x00B660:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00B66E(PC, D0), D1
                jmp     Offset_0x00B66E(PC, D1)    
;------------------------------------------------------------------------------- 
Offset_0x00B66E:
                dc.w    Offset_0x00B676-Offset_0x00B66E
                dc.w    Offset_0x00B6B8-Offset_0x00B66E
                dc.w    Offset_0x00B6CC-Offset_0x00B66E
                dc.w    Offset_0x00B6E2-Offset_0x00B66E  
;-------------------------------------------------------------------------------   
Offset_0x00B676:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0148, Obj_X(A0)                                ; $0008
                move.w  #$00C4, Obj_Sub_Y(A0)                            ; $000A
                move.l  #Sonic_Miles_Mappings, Obj_Map(A0) ; Offset_0x00B94E, $0004
                move.w  #$4200, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$1D, Obj_Ani_Time_2(A0)                         ; $001F
                tst.b   Obj_Map_Id(A0)                                   ; $001A
                beq.s   Offset_0x00B6B8
                move.w  #$00FC, Obj_X(A0)                                ; $0008
                move.w  #$00CC, Obj_Sub_Y(A0)                            ; $000A
                move.w  #$2200, Obj_Art_VRAM(A0)                         ; $0002   
;------------------------------------------------------------------------------- 
Offset_0x00B6B8:
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------  
; Offset_0x00B6BC:
                subq.b  #$01, Obj_Ani_Time_2(A0)                         ; $001F
                bpl.s   Offset_0x00B6CA
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00B6CA:
                rts                                                             
;-------------------------------------------------------------------------------  
Offset_0x00B6CC:
                subi.w  #$0008, Obj_Sub_Y(A0)                            ; $000A
                cmpi.w  #$0096, Obj_Sub_Y(A0)                            ; $000A
                bne.s   Offset_0x00B6DE
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
Offset_0x00B6DE:
                bra     DisplaySprite                          ; Offset_0x00D322 
;-------------------------------------------------------------------------------  
Offset_0x00B6E2:
                bra     DisplaySprite                          ; Offset_0x00D322
;===============================================================================
; Objeto 0x0E - Sonic e Miles na Tela Título
; <<<- 
;===============================================================================