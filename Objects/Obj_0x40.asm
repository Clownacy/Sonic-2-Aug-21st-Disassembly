;===============================================================================
; Objeto 0x40 - Molas tipo sanfona na Dust Hill, Chemical Plant e Neo Green Hill
; ->>>
;===============================================================================    
; Offset_0x01B12C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01B13E(PC, D0), D1
                jsr     Offset_0x01B13E(PC, D1)
                bra     Jmp_0E_To_MarkObjGone                  ; Offset_0x01B3D4       
;------------------------------------------------------------------------------- 
Offset_0x01B13E:
                dc.w    Offset_0x01B148-Offset_0x01B13E
                dc.w    Offset_0x01B184-Offset_0x01B13E   
;------------------------------------------------------------------------------- 
Offset_0x01B142:
                dc.w    $FC00, $F600, $F800           
;-------------------------------------------------------------------------------
Offset_0x01B148:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Diagonal_Spring_Mappings, Obj_Map(A0) ; Offset_0x01B3AA, $0004
                move.w  #$0440, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_0E_To_ModifySpriteAttr_2P          ; Offset_0x01B3E0
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$1C, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                bset    #$07, Obj_Status(A0)                             ; $0022
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$0002, D0
                move.w  Offset_0x01B142(PC, D0), Obj_Control_Var_04(A0)  ; $0030  
;-------------------------------------------------------------------------------
Offset_0x01B184:
                lea     (Diagonal_Spring_Animate_Data), A1     ; Offset_0x01B39E
                bsr     Jmp_02_To_AnimateSprite                ; Offset_0x01B3DA
                move.w  #$0027, D1
                move.w  #$0008, D2
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     Offset_0x01B34E(PC), A2
                tst.b   Obj_Map_Id(A0)                                   ; $001A
                beq.s   Offset_0x01B1A8
                lea     Offset_0x01B376(PC), A2
Offset_0x01B1A8:
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Jmp_00_To_SolidObject_3_A1             ; Offset_0x01B3E6
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01B1C0
                bsr.s   Offset_0x01B1DA
Offset_0x01B1C0:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     Jmp_00_To_SolidObject_3_A1             ; Offset_0x01B3E6
                btst    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01B1D8
                bsr.s   Offset_0x01B1DA
Offset_0x01B1D8:
                rts
Offset_0x01B1DA:
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01B1F2
                move.w  Obj_X(A0), D0                                    ; $0008
                subi.w  #$0010, D0
                cmp.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x01B202
                rts
Offset_0x01B1F2:
                move.w  Obj_X(A0), D0                                    ; $0008
                addi.w  #$0010, D0
                cmp.w   Obj_X(A1), D0                                    ; $0008
                bcc.s   Offset_0x01B202
                rts
Offset_0x01B202:
                cmpi.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                beq.s   Offset_0x01B212
                move.w  #$0100, Obj_Ani_Number(A0)                       ; $001C
                rts
Offset_0x01B212:
                tst.b   Obj_Map_Id(A0)                                   ; $001A
                beq.s   Offset_0x01B21A
                rts
Offset_0x01B21A:
                move.w  Obj_X(A0), D0                                    ; $0008
                subi.w  #$001C, D0
                sub.w   Obj_X(A1), D0                                    ; $0008
                neg.w   D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01B236
                not.w   D0
                addi.w  #$0027, D0
Offset_0x01B236:
                tst.w   D0
                bpl.s   Offset_0x01B23C
                moveq   #$00, D0
Offset_0x01B23C:
                lea     (Offset_0x01B306), A3
                move.b  $00(A3, D0), D0
                move.w  #$FC00, Obj_Speed_Y(A1)                          ; $0012
                sub.b   D0, Obj_Speed_Y(A1)                              ; $0012
                bset    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01B266
                bclr    #$00, Obj_Status(A1)                             ; $0022
                neg.b   D0
Offset_0x01B266:
                move.w  Obj_Speed(A1), D1                                ; $0010
                bpl.s   Offset_0x01B26E
                neg.w   D1
Offset_0x01B26E:
                cmpi.w  #$0400, D1
                bcs.s   Offset_0x01B278
                sub.b   D0, Obj_Speed(A1)                                ; $0010
Offset_0x01B278:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$10, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                btst    #$00, D0
                beq.s   Offset_0x01B2D4
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $002C
                move.b  #$08, Obj_Player_Flip_Speed(A1)                  ; $002D
                btst    #$01, D0
                bne.s   Offset_0x01B2C4
                move.b  #$03, Obj_P_Flips_Remaining(A1)                  ; $002C
Offset_0x01B2C4:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01B2D4
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x01B2D4:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01B2EA
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $003E
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $003F
Offset_0x01B2EA:
                cmpi.b  #$08, D0
                bne.s   Offset_0x01B2FC
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $003E
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $003F
Offset_0x01B2FC:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512   
;-------------------------------------------------------------------------------
Offset_0x01B306:
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $01, $01, $01, $01, $01, $01, $01, $01
                dc.b    $02, $02, $02, $02, $02, $02, $02, $02
                dc.b    $03, $03, $03, $03, $03, $03, $04, $04
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00     
;-------------------------------------------------------------------------------
Offset_0x01B34E:
                dc.b    $08, $08, $08, $08, $08, $08, $08, $09
                dc.b    $0A, $0B, $0C, $0D, $0E, $0F, $10, $10
                dc.b    $11, $12, $13, $14, $14, $15, $15, $16
                dc.b    $17, $18, $18, $18, $18, $18, $18, $18
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18  
;-------------------------------------------------------------------------------   
Offset_0x01B376:
                dc.b    $08, $08, $08, $08, $08, $08, $08, $09
                dc.b    $0A, $0B, $0C, $0C, $0C, $0C, $0D, $0D
                dc.b    $0D, $0D, $0D, $0D, $0E, $0E, $0F, $0F
                dc.b    $10, $10, $10, $10, $0F, $0F, $0E, $0E
                dc.b    $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D  
;-------------------------------------------------------------------------------
Diagonal_Spring_Animate_Data:                                  ; Offset_0x01B39E
                dc.w    Offset_0x01B3A2-Diagonal_Spring_Animate_Data
                dc.w    Offset_0x01B3A5-Diagonal_Spring_Animate_Data
Offset_0x01B3A2:
                dc.b    $0F, $00, $FF
Offset_0x01B3A5:
                dc.b    $03, $01, $00, $FD, $00       
;-------------------------------------------------------------------------------
Diagonal_Spring_Mappings:                                      ; Offset_0x01B3AA
                dc.w    Offset_0x01B3AE-Diagonal_Spring_Mappings
                dc.w    Offset_0x01B3C0-Diagonal_Spring_Mappings
Offset_0x01B3AE:
                dc.w    $0002
                dc.l    $E8090000, $0000FFE4
                dc.l    $E80D0006, $0003FFFC
Offset_0x01B3C0:
                dc.w    $0002
                dc.l    $E809000E, $0007FFE4
                dc.l    $E80D0014, $000AFFFC                                    
;===============================================================================
; Objeto 0x40 - Molas tipo sanfona na Dust Hill, Chemical Plant e Neo Green Hill
; <<<-
;===============================================================================