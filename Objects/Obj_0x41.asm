;===============================================================================
; Objeto 0x41 - Molas amarelas / vermelhas - diagonal / horizontal / vertical
; ->>>
;===============================================================================    
; Offset_0x00E744:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00E774(PC, D0), D1
                jsr     Offset_0x00E774(PC, D1)
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x00E75C
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00E75C:
                move.w  Obj_X(A0), D0                                    ; $0008
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------
Offset_0x00E774:
                dc.w    Offset_0x00E780-Offset_0x00E774
                dc.w    Offset_0x00E858-Offset_0x00E774
                dc.w    Offset_0x00E94A-Offset_0x00E774
                dc.w    Offset_0x00EB5C-Offset_0x00E774
                dc.w    Offset_0x00EC48-Offset_0x00E774
                dc.w    Offset_0x00ED7E-Offset_0x00E774        
;-------------------------------------------------------------------------------
Offset_0x00E780:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Springs_Mappings, Obj_Map(A0)  ; Offset_0x00EEFC, $0004
                move.w  #$045C, Obj_Art_VRAM(A0)                         ; $0002
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$03, D0
                andi.w  #$000E, D0
                move.w  Offset_0x00E7B6(PC, D0), D0
                jmp     Offset_0x00E7B6(PC, D0)      
;-------------------------------------------------------------------------------
Offset_0x00E7B6:
                dc.w    Offset_0x00E82C-Offset_0x00E7B6
                dc.w    Offset_0x00E7C0-Offset_0x00E7B6
                dc.w    Offset_0x00E7E0-Offset_0x00E7B6
                dc.w    Offset_0x00E7F4-Offset_0x00E7B6
                dc.w    Offset_0x00E80E-Offset_0x00E7B6      
;-------------------------------------------------------------------------------
Offset_0x00E7C0:
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$03, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0470, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$08, Obj_Width(A0)                              ; $0019
                bra.s   Offset_0x00E82C   
;-------------------------------------------------------------------------------
Offset_0x00E7E0:
                move.b  #$06, Obj_Routine(A0)                            ; $0024
                move.b  #$06, Obj_Map_Id(A0)                             ; $001A
                bset    #$01, Obj_Status(A0)                             ; $0022
                bra.s   Offset_0x00E82C      
;-------------------------------------------------------------------------------
Offset_0x00E7F4:
                move.b  #$08, Obj_Routine(A0)                            ; $0024
                move.b  #$04, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$07, Obj_Map_Id(A0)                             ; $001A
                move.w  #$043C, Obj_Art_VRAM(A0)                         ; $0002
                bra.s   Offset_0x00E82C  
;-------------------------------------------------------------------------------
Offset_0x00E80E:
                move.b  #$0A, Obj_Routine(A0)                            ; $0024
                move.b  #$04, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$0A, Obj_Map_Id(A0)                             ; $001A
                move.w  #$043C, Obj_Art_VRAM(A0)                         ; $0002
                bset    #$01, Obj_Status(A0)                             ; $0022
;-------------------------------------------------------------------------------
Offset_0x00E82C:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$0002, D0
                move.w  Offset_0x00E854(PC, D0), Obj_Control_Var_04(A0)  ; $0030
                btst    #$01, D0
                beq.s   Offset_0x00E84E
                bset    #$05, Obj_Art_VRAM(A0)                           ; $0002
                move.l  #Springs_Mappings_01, Obj_Map(A0) ; Offset_0x00EF12, $0004
Offset_0x00E84E:
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                rts       
;-------------------------------------------------------------------------------  
Offset_0x00E854:
                dc.w    $F000, $F600
;-------------------------------------------------------------------------------
Offset_0x00E858:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     SolidObject_2_A1                       ; Offset_0x00F3B4
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00E880
                bsr.s   Offset_0x00E8A4
Offset_0x00E880:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     SolidObject_2_A1                       ; Offset_0x00F3B4
                btst    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00E898
                bsr.s   Offset_0x00E8A4
Offset_0x00E898:
                lea     (Springs_Animate_Data), A1             ; Offset_0x00EEC2
                bra     AnimateSprite                          ; Offset_0x00D372 
;-------------------------------------------------------------------------------
; Offset_0x00E8A2:
                rts 
;-------------------------------------------------------------------------------
Offset_0x00E8A4:
                move.w  #$0100, Obj_Ani_Number(A0)                       ; $001C
                addq.w  #$08, Obj_Y(A1)                                  ; $000C
                move.w  Obj_Control_Var_04(A0), Obj_Speed_Y(A1)   ; $0012, $0030
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$10, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x00E8D8
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
Offset_0x00E8D8:
                btst    #$00, D0
                beq.s   Offset_0x00E918
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$00, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$04, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x00E908
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x00E908:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x00E918
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x00E918:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x00E92E
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00E92E:
                cmpi.b  #$08, D0
                bne.s   Offset_0x00E940
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00E940:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------                
Offset_0x00E94A:
                move.w  #$0013, D1
                move.w  #$000E, D2
                move.w  #$000F, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     SolidObject_2_A1                       ; Offset_0x00F3B4
                btst    #$05, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00E98A
                move.b  Obj_Status(A0), D1                               ; $0022
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x00E982
                eori.b  #$01, D1
Offset_0x00E982:
                andi.b  #$01, D1
                bne.s   Offset_0x00E98A
                bsr.s   Offset_0x00E9CA
Offset_0x00E98A:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     SolidObject_2_A1                       ; Offset_0x00F3B4
                btst    #$06, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00E9BA
                move.b  Obj_Status(A0), D1                               ; $0022
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x00E9B2
                eori.b  #$01, D1
Offset_0x00E9B2:
                andi.b  #$01, D1
                bne.s   Offset_0x00E9BA
                bsr.s   Offset_0x00E9CA
Offset_0x00E9BA:
                bsr     Offset_0x00EAA2
                lea     (Springs_Animate_Data), A1             ; Offset_0x00EEC2
                bra     AnimateSprite                          ; Offset_0x00D372
;-------------------------------------------------------------------------------
; Offset_0x00E9C8:
                rts   
;-------------------------------------------------------------------------------
Offset_0x00E9CA:
                move.w  #$0300, Obj_Ani_Number(A0)                       ; $001C
                move.w  Obj_Control_Var_04(A0), Obj_Speed(A1)     ; $0010, $0030
                addq.w  #$08, Obj_X(A1)                                  ; $0008
                bset    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00E9F8
                bclr    #$00, Obj_Status(A1)                             ; $0022
                subi.w  #$0010, Obj_X(A1)                                ; $0008
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x00E9F8:
                move.w  #$000F, Obj_Control_Var_02(A1)                   ; $002E
                move.w  Obj_Speed(A1), Obj_Inertia(A1)            ; $0010, $0014
                btst    #$02, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x00EA12
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
Offset_0x00EA12:
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x00EA1E
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
Offset_0x00EA1E:
                btst    #$00, D0
                beq.s   Offset_0x00EA5E
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$08, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x00EA4E
                move.b  #$03, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x00EA4E:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x00EA5E
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x00EA5E:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x00EA74
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00EA74:
                cmpi.b  #$08, D0
                bne.s   Offset_0x00EA86
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00EA86:
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$06, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
Offset_0x00EAA2:
                cmpi.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                beq     Offset_0x00EB5A
                move.w  Obj_X(A0), D0                                    ; $0008
                move.w  D0, D1
                addi.w  #$0028, D1
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00EAC4
                move.w  D0, D1
                subi.w  #$0028, D0
Offset_0x00EAC4:
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, D3
                subi.w  #$0018, D2
                addi.w  #$0018, D3
                lea     (Player_One).w, A1                           ; $FFFFB000
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x00EB18
                move.w  Obj_Inertia(A1), D4                              ; $0014
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00EAEC
                neg.w   D4
Offset_0x00EAEC:
                tst.w   D4
                bmi.s   Offset_0x00EB18
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   D0, D4
                bcs     Offset_0x00EB18
                cmp.w   D1, D4
                bcc     Offset_0x00EB18
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   D2, D4
                bcs     Offset_0x00EB18
                cmp.w   D3, D4
                bcc     Offset_0x00EB18
                move.w  D0, -(A7)
                bsr     Offset_0x00E9CA
                move.w  (A7)+, D0
Offset_0x00EB18:
                lea     (Player_Two).w, A1                           ; $FFFFB040
                btst    #$01, Obj_Status(A1)                             ; $0022
                bne.s   Offset_0x00EB5A
                move.w  Obj_Inertia(A1), D4                              ; $0014
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00EB32
                neg.w   D4
Offset_0x00EB32:
                tst.w   D4
                bmi.s   Offset_0x00EB5A
                move.w  Obj_X(A1), D4                                    ; $0008
                cmp.w   D0, D4
                bcs     Offset_0x00EB5A
                cmp.w   D1, D4
                bcc     Offset_0x00EB5A
                move.w  Obj_Y(A1), D4                                    ; $000C
                cmp.w   D2, D4
                bcs     Offset_0x00EB5A
                cmp.w   D3, D4
                bcc     Offset_0x00EB5A
                bsr     Offset_0x00E9CA
Offset_0x00EB5A:
                rts
;-------------------------------------------------------------------------------                
Offset_0x00EB5C:
                move.w  #$001B, D1
                move.w  #$0008, D2
                move.w  #$0010, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     SolidObject_2_A1                       ; Offset_0x00F3B4
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x00EB82
                bsr.s   Offset_0x00EBA4
Offset_0x00EB82:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     SolidObject_2_A1                       ; Offset_0x00F3B4
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x00EB98
                bsr.s   Offset_0x00EBA4
Offset_0x00EB98:
                lea     (Springs_Animate_Data), A1             ; Offset_0x00EEC2
                bra     AnimateSprite                          ; Offset_0x00D372      
;-------------------------------------------------------------------------------
; Offset_0x00EBA2:
                rts    
;-------------------------------------------------------------------------------
Offset_0x00EBA4:
                move.w  #$0100, Obj_Ani_Number(A0)                       ; $001C
                subq.w  #$08, Obj_Y(A1)                                  ; $000C
                move.w  Obj_Control_Var_04(A0), Obj_Speed_Y(A1)   ; $0012, $0030
                neg.w   Obj_Speed_Y(A1)                                  ; $0012
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl.s   Offset_0x00EBC4
                move.w  #$0000, Obj_Speed(A1)                            ; $0010
Offset_0x00EBC4:
                btst    #$00, D0
                beq.s   Offset_0x00EC04
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$00, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$04, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x00EBF4
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x00EBF4:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x00EC04
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x00EC04:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x00EC1A
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00EC1A:
                cmpi.b  #$08, D0
                bne.s   Offset_0x00EC2C
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00EC2C:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------                
Offset_0x00EC48:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     Offset_0x00EE8A(PC), A2
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     SolidObject_3_A1                       ; Offset_0x00F406
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00EC70
                bsr.s   Offset_0x00EC94
Offset_0x00EC70:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     SolidObject_3_A1                       ; Offset_0x00F406
                btst    #$04, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x00EC88
                bsr.s   Offset_0x00EC94
Offset_0x00EC88:
                lea     (Springs_Animate_Data), A1             ; Offset_0x00EEC2
                bra     AnimateSprite                          ; Offset_0x00D372    
;-------------------------------------------------------------------------------
; Offset_0x00EC92:
                rts                      
;-------------------------------------------------------------------------------
Offset_0x00EC94:
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00ECAA
                move.w  Obj_X(A0), D0                                    ; $0008
                subq.w  #$04, D0
                cmp.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x00ECB8
                rts
Offset_0x00ECAA:
                move.w  Obj_X(A0), D0                                    ; $0008
                addq.w  #$04, D0
                cmp.w   Obj_X(A1), D0                                    ; $0008
                bcc.s   Offset_0x00ECB8
                rts
Offset_0x00ECB8:
                move.w  #$0500, Obj_Ani_Number(A0)                       ; $001C
                move.w  Obj_Control_Var_04(A0), Obj_Speed_Y(A1)   ; $0012, $0030
                move.w  Obj_Control_Var_04(A0), Obj_Speed(A1)     ; $0010, $0030
                addq.w  #$06, Obj_Y(A1)                                  ; $000C
                addq.w  #$06, Obj_X(A1)                                  ; $0008
                bset    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00ECF0
                bclr    #$00, Obj_Status(A1)                             ; $0022
                subi.w  #$000C, Obj_X(A1)                                ; $0008
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x00ECF0:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$10, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                btst    #$00, D0
                beq.s   Offset_0x00ED4C
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$08, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x00ED3C
                move.b  #$03, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x00ED3C:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x00ED4C
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x00ED4C:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x00ED62
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00ED62:
                cmpi.b  #$08, D0
                bne.s   Offset_0x00ED74
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00ED74:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512
;-------------------------------------------------------------------------------
Offset_0x00ED7E:
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  Obj_X(A0), D4                                    ; $0008
                lea     Offset_0x00EEA6(PC), A2
                lea     (Player_One).w, A1                           ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                bsr     SolidObject_3_A1                       ; Offset_0x00F406
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x00EDA4
                bsr.s   Offset_0x00EDC6
Offset_0x00EDA4:
                movem.l (A7)+, D1-D4
                lea     (Player_Two).w, A1                           ; $FFFFB040
                moveq   #$04, D6
                bsr     SolidObject_3_A1                       ; Offset_0x00F406
                cmpi.w  #$FFFE, D4
                bne.s   Offset_0x00EDBA
                bsr.s   Offset_0x00EDC6
Offset_0x00EDBA:
                lea     (Springs_Animate_Data), A1             ; Offset_0x00EEC2
                bra     AnimateSprite                          ; Offset_0x00D372   
;-------------------------------------------------------------------------------
; Offset_0x00EDC4:
                rts             
;-------------------------------------------------------------------------------
Offset_0x00EDC6:
                move.w  #$0500, Obj_Ani_Number(A0)                       ; $001C
                move.w  Obj_Control_Var_04(A0), Obj_Speed_Y(A1)   ; $0012, $0030
                neg.w   Obj_Speed_Y(A1)                                  ; $0012
                move.w  Obj_Control_Var_04(A0), Obj_Speed(A1)     ; $0010, $0030
                subq.w  #$06, Obj_Y(A1)                                  ; $000C
                addq.w  #$06, Obj_X(A1)                                  ; $0008
                bset    #$00, Obj_Status(A1)                             ; $0022
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00EE02
                bclr    #$00, Obj_Status(A1)                             ; $0022
                subi.w  #$000C, Obj_X(A1)                                ; $0008
                neg.w   Obj_Speed(A1)                                    ; $0010
Offset_0x00EE02:
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$03, Obj_Status(A1)                             ; $0022
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  Obj_Subtype(A0), D0                              ; $0028
                btst    #$00, D0
                beq.s   Offset_0x00EE58
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$08, Obj_Control_Var_01(A1)                     ; $002D
                btst    #$01, D0
                bne.s   Offset_0x00EE48
                move.b  #$03, Obj_Control_Var_00(A1)                     ; $002C
Offset_0x00EE48:
                btst    #$00, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x00EE58
                neg.b   Obj_Flip_Angle(A1)                               ; $0027
                neg.w   Obj_Inertia(A1)                                  ; $0014
Offset_0x00EE58:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x00EE6E
                move.b  #$0C, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0D, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00EE6E:
                cmpi.b  #$08, D0
                bne.s   Offset_0x00EE80
                move.b  #$0E, Obj_Control_Var_12(A1)                     ; $003E
                move.b  #$0F, Obj_Control_Var_13(A1)                     ; $003F
Offset_0x00EE80:
                move.w  #$00CC, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512  
;-------------------------------------------------------------------------------  
Offset_0x00EE8A:
                dc.b    $10, $10, $10, $10, $10, $10, $10, $10
                dc.b    $10, $10, $10, $10, $0E, $0C, $0A, $08
                dc.b    $06, $04, $02, $00, $FE, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC           
;-------------------------------------------------------------------------------
Offset_0x00EEA6:
                dc.b    $F4, $F0, $F0, $F0, $F0, $F0, $F0, $F0
                dc.b    $F0, $F0, $F0, $F0, $F2, $F4, $F6, $F8
                dc.b    $FA, $FC, $FE, $00, $02, $04, $04, $04
                dc.b    $04, $04, $04, $04                 
;-------------------------------------------------------------------------------
Springs_Animate_Data:                                          ; Offset_0x00EEC2
                dc.w    Offset_0x00EECE-Springs_Animate_Data
                dc.w    Offset_0x00EED1-Springs_Animate_Data
                dc.w    Offset_0x00EEDD-Springs_Animate_Data
                dc.w    Offset_0x00EEE0-Springs_Animate_Data
                dc.w    Offset_0x00EEEC-Springs_Animate_Data
                dc.w    Offset_0x00EEEF-Springs_Animate_Data
Offset_0x00EECE:
                dc.b    $0F, $00, $FF
Offset_0x00EED1:
                dc.b    $00, $01, $00, $00, $02, $02, $02, $02
                dc.b    $02, $02, $FD, $00
Offset_0x00EEDD:
                dc.b    $0F, $03, $FF
Offset_0x00EEE0:
                dc.b    $00, $04, $03, $03, $05, $05, $05, $05
                dc.b    $05, $05, $FD, $02
Offset_0x00EEEC:
                dc.b    $0F, $07, $FF
Offset_0x00EEEF:
                dc.b    $00, $08, $07, $07, $09, $09, $09, $09
                dc.b    $09, $09, $FD, $04, $00                                   
;-------------------------------------------------------------------------------
Springs_Mappings:                                              ; Offset_0x00EEFC
                dc.w    Offset_0x00EF28-Springs_Mappings
                dc.w    Offset_0x00EF3A-Springs_Mappings
                dc.w    Offset_0x00EF44-Springs_Mappings
                dc.w    Offset_0x00EF56-Springs_Mappings
                dc.w    Offset_0x00EF68-Springs_Mappings
                dc.w    Offset_0x00EF72-Springs_Mappings
                dc.w    Offset_0x00EF84-Springs_Mappings
                dc.w    Offset_0x00EF96-Springs_Mappings
                dc.w    Offset_0x00EFB8-Springs_Mappings
                dc.w    Offset_0x00EFD2-Springs_Mappings
                dc.w    Offset_0x00EFF4-Springs_Mappings               
Springs_Mappings_01:                                           ; Offset_0x00EF12
                dc.w    Offset_0x00EF28-Springs_Mappings_01
                dc.w    Offset_0x00EF3A-Springs_Mappings_01
                dc.w    Offset_0x00EF44-Springs_Mappings_01
                dc.w    Offset_0x00EF56-Springs_Mappings_01
                dc.w    Offset_0x00EF68-Springs_Mappings_01
                dc.w    Offset_0x00EF72-Springs_Mappings_01
                dc.w    Offset_0x00EF84-Springs_Mappings_01
                dc.w    Offset_0x00F016-Springs_Mappings_01
                dc.w    Offset_0x00F038-Springs_Mappings_01
                dc.w    Offset_0x00F052-Springs_Mappings_01
                dc.w    Offset_0x00F074-Springs_Mappings_01                
Offset_0x00EF28:
                dc.w    $0002
                dc.l    $F00D0000, $0000FFF0
                dc.l    $00050008, $0004FFF8
Offset_0x00EF3A:
                dc.w    $0001
                dc.l    $F80D0000, $0000FFF0
Offset_0x00EF44:
                dc.w    $0002
                dc.l    $E00D0000, $0000FFF0
                dc.l    $F007000C, $0006FFF8
Offset_0x00EF56:
                dc.w    $0002
                dc.l    $F0030000, $00000000
                dc.l    $F8010004, $0002FFF8
Offset_0x00EF68:
                dc.w    $0001
                dc.l    $F0030000, $0000FFF8
Offset_0x00EF72:
                dc.w    $0002
                dc.l    $F0030000, $00000010
                dc.l    $F8090006, $0003FFF8
Offset_0x00EF84:
                dc.w    $0002
                dc.l    $000D1000, $1000FFF0
                dc.l    $F0051008, $1004FFF8
Offset_0x00EF96:
                dc.w    $0004
                dc.l    $F00D0000, $0000FFF0
                dc.l    $00050008, $00040000
                dc.l    $FB05000C, $0006FFF6
                dc.l    $0005201C, $200EFFF0
Offset_0x00EFB8:
                dc.w    $0003
                dc.l    $F60D0000, $0000FFEA
                dc.l    $06050008, $0004FFFA
                dc.l    $0005201C, $200EFFF0
Offset_0x00EFD2:
                dc.w    $0004
                dc.l    $E60D0000, $0000FFFB
                dc.l    $F6050008, $0004000B
                dc.l    $F30B0010, $0008FFF6
                dc.l    $0005201C, $200EFFF0
Offset_0x00EFF4:
                dc.w    $0004
                dc.l    $000D1000, $1000FFF0
                dc.l    $F0051008, $10040000
                dc.l    $F505100C, $1006FFF6
                dc.l    $F005301C, $300EFFF0
Offset_0x00F016:
                dc.w    $0004
                dc.l    $F00D0000, $0000FFF0
                dc.l    $00050008, $00040000
                dc.l    $FB05000C, $0006FFF6
                dc.l    $0005001C, $000EFFF0
Offset_0x00F038:
                dc.w    $0003
                dc.l    $F60D0000, $0000FFEA
                dc.l    $06050008, $0004FFFA
                dc.l    $0005001C, $000EFFF0
Offset_0x00F052:
                dc.w    $0004
                dc.l    $E60D0000, $0000FFFB
                dc.l    $F6050008, $0004000B
                dc.l    $F30B0010, $0008FFF6
                dc.l    $0005001C, $000EFFF0
Offset_0x00F074:
                dc.w    $0004
                dc.l    $000D1000, $1000FFF0
                dc.l    $F0051008, $10040000
                dc.l    $F505100C, $1006FFF6
                dc.l    $F005101C, $100EFFF0                                                                          
;===============================================================================
; Objeto 0x41 - Molas amarelas / vermelhas - diagonal / horizontal / vertical
; <<<-
;===============================================================================