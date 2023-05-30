;===============================================================================
; Objeto 0x34 - Tela com o nome das fases conhecido também conhecido como:
; ->>>        - Splash Screen, Title Cards, etc...
;===============================================================================
; Offset_0x00BA00:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00BA0E(PC, D0), D1
                jmp     Offset_0x00BA0E(PC, D1) 
;-------------------------------------------------------------------------------    
Offset_0x00BA0E:
                dc.w    Offset_0x00BA16-Offset_0x00BA0E
                dc.w    Offset_0x00BA88-Offset_0x00BA0E
                dc.w    Offset_0x00BAB0-Offset_0x00BA0E
                dc.w    Offset_0x00BAB0-Offset_0x00BA0E  
;-------------------------------------------------------------------------------
Offset_0x00BA16:
                move.l  A0, A1
                moveq   #$00, D0
                move.b  (Level_Id).w, D0                             ; $FFFFFE10
                move.w  D0, D2
                lea     (Title_Cards_Config), A3               ; Offset_0x00BB34
                lsl.w   #$04, D0
                adda.w  D0, A3
                lea     (Title_Cards_Main_Position), A2        ; Offset_0x00BB24
                moveq   #$03, D1
Title_Card_Loop:                                               ; Offset_0x00BA32
                move.b  #$34, Obj_Id(A1)                                 ; $0000
                move.w  (A3), Obj_X(A1)                                  ; $0008
                move.w  (A3)+, Obj_Control_Var_06(A1)                    ; $0032
                move.w  (A3)+, Obj_Control_Var_04(A1)                    ; $0030
                move.w  (A2)+, Obj_Sub_Y(A1)                             ; $000A
                move.b  (A2)+, Obj_Routine(A1)                           ; $0024
                move.b  (A2)+, D0
                bne.s   Title_Cards_MakeSprite                 ; Offset_0x00BA52
                move.b  D2, D0
Title_Cards_MakeSprite:                                        ; Offset_0x00BA52
                move.b  D0, Obj_Map_Id(A1)                               ; $001A
                move.l  #Title_Cards_Mappings, Obj_Map(A1) ; Offset_0x00C176, $0004
                move.w  #$8580, Obj_Art_VRAM(A1)                         ; $0002
                bsr     ModifySpriteAttr_2P_A1                 ; Offset_0x00DBDA
                move.b  #$78, Obj_Width(A1)                              ; $0019
                move.b  #$00, Obj_Flags(A1)                              ; $0001
                move.b  #$00, Obj_Priority(A1)                           ; $0018
                move.w  #$003C, Obj_Ani_Time(A1)                         ; $001E
                lea     Obj_Size(A1), A1                                 ; $0040
                dbra    D1, Title_Card_Loop                    ; Offset_0x00BA32
;-------------------------------------------------------------------------------  
Offset_0x00BA88:
                moveq   #$10, D1
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x00BA9C
                bge.s   Offset_0x00BA98
                neg.w   D1
Offset_0x00BA98:
                add.w   D1, Obj_X(A0)                                    ; $0008
Offset_0x00BA9C:
                move.w  Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x00BAAE
                cmpi.w  #$0200, D0
                bcc.s   Offset_0x00BAAE
                rts                     
;-------------------------------------------------------------------------------
; Offset_0x00BAAA:
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00BAAE:
                rts     
;-------------------------------------------------------------------------------
Offset_0x00BAB0:
                tst.w   Obj_Ani_Time(A0)                                 ; $001E
                beq.s   Offset_0x00BAC0
                subq.w  #$01, Obj_Ani_Time(A0)                           ; $001E
                rts                                                            
;-------------------------------------------------------------------------------  
; Offset_0x00BABC:
                bra     DisplaySprite                          ; Offset_0x00D322 
;------------------------------------------------------------------------------- 
Offset_0x00BAC0:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl.s   Offset_0x00BAEE
                moveq   #$20, D1
                move.w  Obj_Control_Var_06(A0), D0                       ; $0032
                cmp.w   Obj_X(A0), D0                                    ; $0008
                beq.s   Offset_0x00BAEE
                bge.s   Offset_0x00BAD6
                neg.w   D1
Offset_0x00BAD6:
                add.w   D1, Obj_X(A0)                                    ; $0008
                move.w  Obj_X(A0), D0                                    ; $0008
                bmi.s   Offset_0x00BAEC
                cmpi.w  #$0200, D0
                bcc.s   Offset_0x00BAEC
                rts                                  
;-------------------------------------------------------------------------------     
; Offset_0x00BAE8:
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00BAEC:
                rts
Offset_0x00BAEE:
                cmpi.b  #$04, Obj_Routine(A0)                            ; $0024
                bne.s   Offset_0x00BB0E
                moveq   #$02, D0
                jsr     (LoadPLC)                              ; Offset_0x001794
                moveq   #$00, D0
                move.b  (Level_Id).w, D0                             ; $FFFFFE10
                move.b  Flickies_Select_Array(PC, D0), D0      ; Offset_0x00BB12
                jsr     (LoadPLC)                              ; Offset_0x001794
Offset_0x00BB0E:
                bra     DeleteObject                           ; Offset_0x00D314 
;-------------------------------------------------------------------------------  
Flickies_Select_Array:                                         ; Offset_0x00BB12
                dc.b    $32, $32, $32, $32, $34, $34, $34, $34
                dc.b    $36, $36, $37, $33, $39, $3A, $35, $3B
                dc.b    $38, $38                             
;------------------------------------------------------------------------------- 
Title_Cards_Main_Position:                                     ; Offset_0x00BB24
                dc.w    $00D0, $0200  ; Level Name Position X / Y
                dc.w    $00E4, $0206  ; "Zone" word Position X / Y
                dc.w    $00EA, $0207  ; "Act x" word Position X / Y
                dc.w    $00E0, $020A  ; Oval Position X / Y  
;------------------------------------------------------------------------------- 
Title_Cards_Config:                                            ; Offset_0x00BB34                
                dc.w    $0000, $0120, $FEFC, $013C, $0414, $0154, $0214, $0154
                dc.w    $0000, $0120, $FEF4, $0134, $040C, $014C, $020C, $014C
                dc.w    $0000, $0120, $FEE0, $0120, $03F8, $0138, $01F8, $0138
                dc.w    $0000, $0120, $FEFC, $013C, $0414, $0154, $0214, $0154
                dc.w    $0000, $0120, $FF04, $0144, $041C, $015C, $021C, $015C
                dc.w    $0000, $0120, $FF04, $0144, $041C, $015C, $021C, $015C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
                dc.w    $0000, $0120, $FEE4, $0124, $03EC, $03EC, $01EC, $012C
;===============================================================================
; Objeto 0x34 - Tela com o nome das fases conhecido também conhecido como:
; <<<-        - Splash Screen, Title Cards, etc...
;===============================================================================