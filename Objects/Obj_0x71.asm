;===============================================================================
; Objeto 0x71 - Miscelânea de objetos - Suporte das pontes na Hidden Palace,
; ->>>          Orbs na Hidden Palace, bolhas de lava na Metropolis, etc...
;===============================================================================
; Offset_0x009FA0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x009FAE(PC, D0), D1
                jmp     Offset_0x009FAE(PC, D1)      
;-------------------------------------------------------------------------------
Offset_0x009FAE:
                dc.w    Offset_0x009FCA-Offset_0x009FAE
                dc.w    Offset_0x00A00C-Offset_0x009FAE    
;-------------------------------------------------------------------------------   
Misc_Object_Definitions_List_2:                                ; Offset_0x009FB2
                dc.l    ($03<<$18)|HPz_Bridge_Mappings         ; Offset_0x008A24
                dc.w    $6300
                dc.b    $04, $01
                dc.l    Hpz_Orbs_Mappings                      ; Offset_0x00A046
                dc.w    $E35A
                dc.b    $10, $01
                dc.l    Mz_Lava_Bubble_Mappings                ; Offset_0x00A10A
                dc.w    $4536
                dc.b    $10, $01                                 
;------------------------------------------------------------------------------- 
Offset_0x009FCA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lsl.w   #$03, D0
                lea     Misc_Object_Definitions_List_2(PC), A1 ; Offset_0x009FB2
                lea     $00(A1, D0), A1
                move.b  (A1), Obj_Map_Id(A0)                             ; $001A
                move.l  (A1)+, Obj_Map(A0)                               ; $0004
                move.w  (A1)+, Obj_Art_VRAM(A0)                          ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  (A1)+, Obj_Width(A0)                             ; $0019
                move.b  (A1)+, Obj_Priority(A0)                          ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$00F0, D0
                lsr.b   #$04, D0
                move.b  D0, Obj_Ani_Number(A0)                           ; $001C
;-------------------------------------------------------------------------------  
Offset_0x00A00C:
                lea     (Mz_Hpz_Misc_Animate_Data), A1         ; Offset_0x00A01A
                bsr     AnimateSprite                          ; Offset_0x00D372
                bra     MarkObjGone                            ; Offset_0x00D200  
;-------------------------------------------------------------------------------
Mz_Hpz_Misc_Animate_Data:                                      ; Offset_0x00A01A
                dc.w    Offset_0x00A022-Mz_Hpz_Misc_Animate_Data
                dc.w    Offset_0x00A02A-Mz_Hpz_Misc_Animate_Data
                dc.w    Offset_0x00A039-Mz_Hpz_Misc_Animate_Data
                dc.w    Offset_0x00A042-Mz_Hpz_Misc_Animate_Data
Offset_0x00A022:
                dc.b    $08, $03, $03, $04, $05, $05, $04, $FF
Offset_0x00A02A:
                dc.b    $05, $00, $00, $00, $01, $02, $03, $03
                dc.b    $02, $01, $02, $03, $03, $01, $FF
Offset_0x00A039:
                dc.b    $0B, $00, $01, $02, $03, $04, $05, $FD
                dc.b    $03
Offset_0x00A042:
                dc.b    $7F, $06, $FD, $02  
;-------------------------------------------------------------------------------
Hpz_Orbs_Mappings:                                             ; Offset_0x00A046
                dc.w    Offset_0x00A04E-Hpz_Orbs_Mappings
                dc.w    Offset_0x00A058-Hpz_Orbs_Mappings
                dc.w    Offset_0x00A062-Hpz_Orbs_Mappings
                dc.w    Offset_0x00A074-Hpz_Orbs_Mappings
Offset_0x00A04E:
                dc.w    $0001
                dc.l    $F40A0000, $0000FFF4                                      
Offset_0x00A058:
                dc.w    $0001
                dc.l    $F40A0009, $0004FFF4
Offset_0x00A062:
                dc.w    $0002
                dc.l    $F00D0012, $0009FFF0
                dc.l    $000D1812, $1809FFF0
Offset_0x00A074:
                dc.w    $0002
                dc.l    $F00D001A, $000DFFF0
                dc.l    $000D181A, $180DFFF0
;===============================================================================
; Objeto 0x71 - Miscelânea de objetos - Suporte das pontes na Hidden Palace,
; <<<-          Orbs na Hidden Palace, bolhas de lava na Metropolis, etc...
;===============================================================================