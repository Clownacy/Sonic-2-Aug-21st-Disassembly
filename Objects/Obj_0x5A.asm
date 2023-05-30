;===============================================================================
; Objeto 0x5A 
; ->>> 
;===============================================================================   
; Offset_0x021B18:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x021B26(PC, D0), D1
                jmp     Offset_0x021B26(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x021B26:
                dc.w    Offset_0x021B2C-Offset_0x021B26
                dc.w    Offset_0x021BD4-Offset_0x021B26
                dc.w    Offset_0x021BE2-Offset_0x021B26            
;------------------------------------------------------------------------------- 
Offset_0x021B2C:
                subi.b  #$01, Obj_Subtype(A0)                            ; $0028
                bpl     Offset_0x021BD2
                move.l  #Offset_0x021CA4, Obj_Map(A0)                    ; $0004
                move.w  #$03C4, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$10, Obj_Height_2(A0)                           ; $0016
                move.b  #$08, Obj_Width_2(A0)                            ; $0017
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Jmp_09_To_SingleObjectLoad             ; Offset_0x021D98
                bne.s   Offset_0x021BD2
                move.b  #$5A, Obj_Id(A1)                                 ; $0000
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.l  #Offset_0x021CA4, Obj_Map(A1)                    ; $0004
                move.w  #$03C4, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$0A, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                subi.w  #$0008, Obj_Y(A1)                                ; $000C
                move.w  #$0072, Obj_Timer(A1)                            ; $002A
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bmi.s   Offset_0x021BD2
                bset    #$00, Obj_Status(A1)                             ; $0022
                bset    #$00, Obj_Flags(A1)                              ; $0001
Offset_0x021BD2:
                rts     
;------------------------------------------------------------------------------- 
Offset_0x021BD4:
                lea     (Offset_0x021C7A), A1
                bsr     Jmp_0E_To_AnimateSprite                ; Offset_0x021DA4
                bra     Jmp_20_To_MarkObjGone                  ; Offset_0x021D9E  
;------------------------------------------------------------------------------- 
Offset_0x021BE2:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x021BF0(PC, D0), D1
                jmp     Offset_0x021BF0(PC, D1)              
;-------------------------------------------------------------------------------  
Offset_0x021BF0:
                dc.w    Offset_0x021BF6-Offset_0x021BF0
                dc.w    Offset_0x021C12-Offset_0x021BF0
                dc.w    Offset_0x021C2E-Offset_0x021BF0      
;-------------------------------------------------------------------------------   
Offset_0x021BF6:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bne     Offset_0x021C10
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0020, Obj_Timer(A0)                            ; $002A
Offset_0x021C10:
                rts       
;-------------------------------------------------------------------------------  
Offset_0x021C12:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bmi.s   Offset_0x021C28
Offset_0x021C1A:
                lea     (Offset_0x021C7A), A1
                bsr     Jmp_0E_To_AnimateSprite                ; Offset_0x021DA4
                bra     Jmp_20_To_MarkObjGone                  ; Offset_0x021D9E
Offset_0x021C28:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                bra.s   Offset_0x021C1A    
;-------------------------------------------------------------------------------  
Offset_0x021C2E:
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x021C46
                bset    #$00, Obj_Status(A0)                             ; $0022
                bset    #$00, Obj_Flags(A0)                              ; $0001
                bra.s   Offset_0x021C52
Offset_0x021C46:
                bclr    #$00, Obj_Status(A0)                             ; $0022
                bclr    #$00, Obj_Flags(A0)                              ; $0001
Offset_0x021C52:
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.w  Obj_Y(A0), D0                                    ; $000C
                sub.w   ($FFFFB00C).w, D0
                cmpi.w  #$001E, D0
                blt.s   Offset_0x021C6C
                addi.b  #$01, Obj_Ani_Number(A0)                         ; $001C
Offset_0x021C6C:
                lea     (Offset_0x021C7A), A1
                bsr     Jmp_0E_To_AnimateSprite                ; Offset_0x021DA4
                bra     Jmp_20_To_MarkObjGone                  ; Offset_0x021D9E           
;-------------------------------------------------------------------------------  
Offset_0x021C7A:
                dc.w    Offset_0x021C82-Offset_0x021C7A
                dc.w    Offset_0x021C96-Offset_0x021C7A
                dc.w    Offset_0x021C9D-Offset_0x021C7A
                dc.w    Offset_0x021CA0-Offset_0x021C7A
Offset_0x021C82:
                dc.b    $05, $00, $00, $00, $00, $00, $00, $00
                dc.b    $01, $01, $01, $01, $02, $02, $02, $02
                dc.b    $02, $03, $FE, $01
Offset_0x021C96:
                dc.b    $07, $04, $05, $06, $07, $FD, $02
Offset_0x021C9D:
                dc.b    $0F, $07, $FF
Offset_0x021CA0:
                dc.b    $0F, $08, $FF, $00       
;-------------------------------------------------------------------------------  
Offset_0x021CA4:
                dc.w    Offset_0x021CB6-Offset_0x021CA4
                dc.w    Offset_0x021CC0-Offset_0x021CA4
                dc.w    Offset_0x021CCA-Offset_0x021CA4
                dc.w    Offset_0x021CE4-Offset_0x021CA4
                dc.w    Offset_0x021CFE-Offset_0x021CA4
                dc.w    Offset_0x021D08-Offset_0x021CA4
                dc.w    Offset_0x021D22-Offset_0x021CA4
                dc.w    Offset_0x021D4C-Offset_0x021CA4
                dc.w    Offset_0x021D86-Offset_0x021CA4
Offset_0x021CB6:
                dc.w    $0001
                dc.l    $F8010000, $0000FFFC
Offset_0x021CC0:
                dc.w    $0001
                dc.l    $F8050002, $0001FFF8
Offset_0x021CCA:
                dc.w    $0003
                dc.l    $F8050002, $0001FFF4
                dc.l    $F8050002, $0001FFFC
                dc.l    $F5010000, $0000FFFC
Offset_0x021CE4:
                dc.w    $0003
                dc.l    $F8050002, $0001FFF0
                dc.l    $F8050002, $00010000
                dc.l    $F7050002, $0001FFF8
Offset_0x021CFE:
                dc.w    $0001
                dc.l    $08040006, $0003FFFC
Offset_0x021D08:
                dc.w    $0003
                dc.l    $00040006, $0003FFFC
                dc.l    $080C0008, $0004FFEC
                dc.l    $0800000C, $0006000C
Offset_0x021D22:
                dc.w    $0005
                dc.l    $F8040006, $0003FFFC
                dc.l    $000C0008, $0004FFEC
                dc.l    $0000000C, $0006000C
                dc.l    $080C000D, $0006FFEC
                dc.l    $08000011, $0008000C
Offset_0x021D4C:
                dc.w    $0007
                dc.l    $F0040006, $0003FFFC
                dc.l    $F80C0008, $0004FFEC
                dc.l    $F800000C, $0006000C
                dc.l    $000C000D, $0006FFEC
                dc.l    $00000011, $0008000C
                dc.l    $080C0012, $0009FFEC
                dc.l    $08000016, $000B000C
Offset_0x021D86:
                dc.w    $0002
                dc.l    $F00F0017, $000BFFEC
                dc.l    $F8020027, $0013000C
;===============================================================================
; Objeto 0x5A
; <<<- 
;===============================================================================