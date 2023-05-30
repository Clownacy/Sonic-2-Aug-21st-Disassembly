;===============================================================================
; Objeto 0x66 - Objeto para as molas triangulares nas paredes da Metropolis
; ->>>
;===============================================================================
; Offset_0x01BCF4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01BD02(PC, D0), D1
                jmp     Offset_0x01BD02(PC, D1)
;------------------------------------------------------------------------------- 
Offset_0x01BD02:
                dc.w    Offset_0x01BD06-Offset_0x01BD02
                dc.w    Offset_0x01BD4A-Offset_0x01BD02           
;------------------------------------------------------------------------------- 
Offset_0x01BD06:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Springs_Wall_Mappings, Obj_Map(A0) ; Offset_0x01BEBC, $0004
                move.w  #$8680, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_12_To_ModifySpriteAttr_2P          ; Offset_0x01BEF0
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$40, Obj_Height_2(A0)                           ; $0016
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.b   #$04, D0
                andi.b  #$07, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                beq.s   Offset_0x01BD4A
                move.b  #$80, Obj_Height_2(A0)                           ; $0016  
;------------------------------------------------------------------------------- 
Offset_0x01BD4A:
                move.w  #$0013, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     Jmp_02_To_SolidObject_2_A1             ; Offset_0x01BEF6
                cmpi.b  #$01, D4
                bne.s   Offset_0x01BD92
                btst    #$01, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01BD92
                move.b  Obj_Status(A0), D1                               ; $0022
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x01BD8A
                eori.b  #$01, D1
Offset_0x01BD8A:
                andi.b  #$01, D1
                bne.s   Offset_0x01BD92
                bsr.s   Offset_0x01BDE8
Offset_0x01BD92:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     Jmp_02_To_SolidObject_2_A1             ; Offset_0x01BEF6
                cmpi.b  #$01, D4
                bne.s   Offset_0x01BDC8
                btst    #$01, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01BDC8
                move.b  Obj_Status(A0), D1                               ; $0022
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x01BDC0
                eori.b  #$01, D1
Offset_0x01BDC0:
                andi.b  #$01, D1
                bne.s   Offset_0x01BDC8
                bsr.s   Offset_0x01BDE8
Offset_0x01BDC8:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     Jmp_0E_To_DeleteObject                 ; Offset_0x01BEEA
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                beq.s   Offset_0x01BDE6
                bsr     Jmp_0A_To_DisplaySprite                ; Offset_0x01BEE4
Offset_0x01BDE6:
                rts
Offset_0x01BDE8:
                move.w  Obj_Control_Var_04(A0), Obj_Speed(A1)     ; $0010, $0030
                move.w  #$F800, Obj_Speed(A1)                            ; $0010
                move.w  #$F800, Obj_Speed_Y(A1)                          ; $0012
                bset    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01BE12
                bclr    #$00, Obj_Status(A1)                             ; $0022
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x01BE12:
                move.w  #$000F, Obj_Player_Control(A1)                   ; $002E
                move.w  Obj_Speed(A1), Obj_Inertia(A1)            ; $0010, $0014
                btst    #$02, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x01BE2C
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
Offset_0x01BE2C:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x01BE38
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
Offset_0x01BE38:
                btst    #$00, D0
                beq.s   Offset_0x01BE78
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_P_Flips_Remaining(A1)                  ; $002C
                move.b  #$08, Obj_Player_Flip_Speed(A1)                  ; $002D
                btst    #$01, D0
                bne.s   Offset_0x01BE68
                move.b  #$03, Obj_P_Flips_Remaining(A1)                  ; $002C
Offset_0x01BE68:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x01BE78
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x01BE78:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x01BE8E
                move.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $003E
                move.b  #$0D, Obj_Player_LRB_Solid(A1)                   ; $003F
Offset_0x01BE8E:
                cmpi.b  #$08, D0
                bne.s   Offset_0x01BEA0
                move.b  #$0E, Obj_Player_Top_Solid(A1)                   ; $003E
                move.b  #$0F, Obj_Player_LRB_Solid(A1)                   ; $003F
Offset_0x01BEA0:
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$06, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512   
;-------------------------------------------------------------------------------
Springs_Wall_Mappings:                                         ; Offset_0x01BEBC
                dc.w    Offset_0x01BEC0-Springs_Wall_Mappings
                dc.w    Offset_0x01BED2-Springs_Wall_Mappings
Offset_0x01BEC0:
                dc.w    $0002
                dc.l    $C0050034, $001AFFF8
                dc.l    $30050034, $001AFFF8
Offset_0x01BED2:
                dc.w    $0002
                dc.l    $80050034, $001AFFF8
                dc.l    $70050034, $001AFFF8  
;===============================================================================
; Objeto 0x66 - Objeto para as molas triangulares nas paredes da Metropolis
; <<<-
;===============================================================================