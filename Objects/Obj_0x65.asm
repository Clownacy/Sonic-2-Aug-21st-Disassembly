;===============================================================================
; Objeto 0x65 - Plataformas sobre engrenagens na Metropolis
; ->>>
;===============================================================================
; Offset_0x01B894:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01B8A2(PC, D0), D1
                jmp     Offset_0x01B8A2(PC, D1)
;-------------------------------------------------------------------------------   
Offset_0x01B8A2:
                dc.w    Offset_0x01B8BA-Offset_0x01B8A2
                dc.w    Offset_0x01B9D0-Offset_0x01B8A2
                dc.w    Offset_0x01BC40-Offset_0x01B8A2
                dc.w    Offset_0x01BC5E-Offset_0x01B8A2     
;------------------------------------------------------------------------------- 
Offset_0x01B8AA:
                dc.b    $40, $0C, $80, $01, $20, $0C, $40, $03
                dc.b    $10, $10, $20, $00, $40, $0C, $80, $07 
;-------------------------------------------------------------------------------
Offset_0x01B8BA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Mz_Platform_Mappings, Obj_Map(A0) ; Offset_0x01BC64, $0004
                move.w  #$6000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_11_To_ModifySpriteAttr_2P          ; Offset_0x01BCE8
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                lsr.w   #$02, D0
                andi.w  #$001C, D0
                lea     Offset_0x01B8AA(PC, D0), A3
                move.b  (A3)+, Obj_Width(A0)                             ; $0019
                move.b  (A3)+, Obj_Height_2(A0)                          ; $0016
                lsr.w   #$02, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                cmpi.b  #$01, D0
                bne.s   Offset_0x01B906
                bset    #$07, Obj_Status(A0)                             ; $0022
Offset_0x01B906:
                cmpi.b  #$02, D0
                bne.s   Offset_0x01B922
                addq.b  #$04, Obj_Routine(A0)                            ; $0024
                move.l  #Mini_Gear_Mappings, Obj_Map(A0) ; Offset_0x01BCA0, $0004
                move.w  #$655F, Obj_Art_VRAM(A0)                         ; $0002
                bra     Offset_0x01BC5E
Offset_0x01B922:
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034
                move.w  Obj_Y(A0), Obj_Control_Var_04(A0)         ; $000C, $0030
                moveq   #$00, D0
                move.b  (A3)+, D0
                move.w  D0, Obj_Control_Var_10(A0)                       ; $003C
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bpl     Offset_0x01B9CA
                andi.b  #$0F, D0
                move.b  D0, Obj_Control_Var_12(A0)                       ; $003E
                move.b  (A3), Obj_Subtype(A0)                            ; $0028
                cmpi.b  #$07, (A3)
                bne.s   Offset_0x01B958
                move.w  Obj_Control_Var_10(A0), Obj_Control_Var_0E(A0); $003A, $003C
Offset_0x01B958:
                bsr     Jmp_08_To_SingleObjectLoad_2           ; Offset_0x01BCE2
                bne.s   Offset_0x01B9B8
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                addq.b  #$04, Obj_Routine(A1)                            ; $0024
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$FFB4, Obj_X(A1)                                ; $0008
                addi.w  #$0014, Obj_Y(A1)                                ; $000C
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01B994
                subi.w  #$FFE8, Obj_X(A1)                                ; $0008
                bset    #$00, Obj_Flags(A1)                              ; $0001
Offset_0x01B994:
                move.l  #Mini_Gear_Mappings, Obj_Map(A1) ; Offset_0x01BCA0, $0004
                move.w  #$655F, Obj_Art_VRAM(A1)                         ; $0002
                ori.b   #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$10, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.l  A0, Obj_Control_Var_10(A1)                       ; $003C
Offset_0x01B9B8:
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x01B9CA
                bclr    #$07, $02(A2, D0)
Offset_0x01B9CA:
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028      
;-------------------------------------------------------------------------------
Offset_0x01B9D0:
                move.w  Obj_X(A0), -(A7)                                 ; $0008
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                add.w   D0, D0
                move.w  Offset_0x01BA2E(PC, D0), D1
                jsr     Offset_0x01BA2E(PC, D1)
                move.w  (A7)+, D4
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  Obj_Height_2(A0), D2                             ; $0016
                move.w  D2, D3
                addq.w  #$01, D3
                bsr     Jmp_07_To_SolidObject                  ; Offset_0x01BCEE
                move.w  Obj_Control_Var_08(A0), D0                       ; $0034
                andi.w  #$FF80, D0
                sub.w   ($FFFFF7DA).w, D0
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x01BA16
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x01BA16:
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x01BA28
                bclr    #$07, $02(A2, D0)
Offset_0x01BA28:
                jmp     (DeleteObject)                         ; Offset_0x00D314    
;-------------------------------------------------------------------------------
Offset_0x01BA2E:
                dc.w    Offset_0x01BA3E-Offset_0x01BA2E
                dc.w    Offset_0x01BA54-Offset_0x01BA2E
                dc.w    Offset_0x01BAE0-Offset_0x01BA2E
                dc.w    Offset_0x01BB3C-Offset_0x01BA2E
                dc.w    Offset_0x01BBE0-Offset_0x01BA2E
                dc.w    Offset_0x01BBEE-Offset_0x01BA2E
                dc.w    Offset_0x01BA40-Offset_0x01BA2E
                dc.w    Offset_0x01BAC0-Offset_0x01BA2E    
;-------------------------------------------------------------------------------
Offset_0x01BA3E:
                rts
Offset_0x01BA40:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01BA52
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x01BA80
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01BA52:
                bra.s   Offset_0x01BA72
Offset_0x01BA54:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01BA72
                lea     ($FFFFF7E0).w, A2
                moveq   #$00, D0
                move.b  Obj_Control_Var_12(A0), D0                       ; $003E
                btst    #$00, $00(A2, D0)
                beq.s   Offset_0x01BA80
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01BA72:
                move.w  Obj_Control_Var_10(A0), D0                       ; $003C
                cmp.w   Obj_Control_Var_0E(A0), D0                       ; $003A
                beq.s   Offset_0x01BA9E
                addq.w  #$02, Obj_Control_Var_0E(A0)                     ; $003A
Offset_0x01BA80:
                move.w  Obj_Control_Var_0E(A0), D0                       ; $003A
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01BA92
                neg.w   D0
                addi.w  #$0080, D0
Offset_0x01BA92:
                move.w  Obj_Control_Var_08(A0), D1                       ; $0034
                sub.w   D0, D1
                move.w  D1, Obj_X(A0)                                    ; $0008
                rts
Offset_0x01BA9E:
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                move.w  #$00B4, Obj_Control_Var_0A(A0)                   ; $0036
                clr.b   Obj_Control_Var_0C(A0)                           ; $0038
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x01BA80
                bset    #$00, $02(A2, D0)
                bra.s   Offset_0x01BA80
Offset_0x01BAC0:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01BADE
                lea     ($FFFFF7E0).w, A2
                moveq   #$00, D0
                move.b  Obj_Control_Var_12(A0), D0                       ; $003E
                btst    #$00, $00(A2, D0)
                beq.s   Offset_0x01BAFC
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01BADE:
                bra.s   Offset_0x01BAF2
Offset_0x01BAE0:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01BAF2
                subq.w  #$01, Obj_Control_Var_0A(A0)                     ; $0036
                bne.s   Offset_0x01BAFC
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01BAF2:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x01BB1A
                subq.w  #$02, Obj_Control_Var_0E(A0)                     ; $003A
Offset_0x01BAFC:
                move.w  Obj_Control_Var_0E(A0), D0                       ; $003A
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01BB0E
                neg.w   D0
                addi.w  #$0080, D0
Offset_0x01BB0E:
                move.w  Obj_Control_Var_08(A0), D1                       ; $0034
                sub.w   D0, D1
                move.w  D1, Obj_X(A0)                                    ; $0008
                rts
Offset_0x01BB1A:
                subq.b  #$01, Obj_Subtype(A0)                            ; $0028
                move.w  #$00B4, Obj_Control_Var_0A(A0)                   ; $0036
                clr.b   Obj_Control_Var_0C(A0)                           ; $0038
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x01BAFC
                bclr    #$00, $02(A2, D0)
                bra.s   Offset_0x01BAFC
Offset_0x01BB3C:
                move.w  Obj_Control_Var_08(A0), D4                       ; $0034
                move.w  D4, D5
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01BB54
                subi.w  #$0020, D4
                addi.w  #$0060, D5
                bra.s   Offset_0x01BB5C
Offset_0x01BB54:
                subi.w  #$00A0, D4
                subi.w  #$0020, D5
Offset_0x01BB5C:
                move.w  Obj_Y(A0), D2                                    ; $000C
                move.w  D2, D3
                subi.w  #$0010, D2
                addi.w  #$0040, D3
                moveq   #$00, D1
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                cmp.w   D4, D0
                bcs.s   Offset_0x01BB86
                cmp.w   D5, D0
                bcc.s   Offset_0x01BB86
                move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
                cmp.w   D2, D0
                bcs.s   Offset_0x01BB86
                cmp.w   D3, D0
                bcc.s   Offset_0x01BB86
                moveq   #$01, D1
Offset_0x01BB86:
                move.w  (Player_Two_Position_X).w, D0                ; $FFFFB048
                cmp.w   D4, D0
                bcs.s   Offset_0x01BBA0
                cmp.w   D5, D0
                bcc.s   Offset_0x01BBA0
                move.w  (Player_Two_Position_Y).w, D0                ; $FFFFB04C
                cmp.w   D2, D0
                bcs.s   Offset_0x01BBA0
                cmp.w   D3, D0
                bcc.s   Offset_0x01BBA0
                moveq   #$01, D1
Offset_0x01BBA0:
                tst.b   D1
                beq.s   Offset_0x01BBB6
                move.w  Obj_Control_Var_10(A0), D0                       ; $003C
                cmp.w   Obj_Control_Var_0E(A0), D0                       ; $003A
                beq.s   Offset_0x01BBDE
                addi.w  #$0010, Obj_Control_Var_0E(A0)                   ; $003A
                bra.s   Offset_0x01BBC2
Offset_0x01BBB6:
                tst.w   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x01BBC2
                subi.w  #$0010, Obj_Control_Var_0E(A0)                   ; $003A
Offset_0x01BBC2:
                move.w  Obj_Control_Var_0E(A0), D0                       ; $003A
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01BBD4
                neg.w   D0
                addi.w  #$0040, D0
Offset_0x01BBD4:
                move.w  Obj_Control_Var_08(A0), D1                       ; $0034
                sub.w   D0, D1
                move.w  D1, Obj_X(A0)                                    ; $0008
Offset_0x01BBDE:
                rts
Offset_0x01BBE0:
                btst    #$03, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01BBEC
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
Offset_0x01BBEC:
                rts
Offset_0x01BBEE:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                bne.s   Offset_0x01BC20
                addq.w  #$02, Obj_X(A0)                                  ; $0008
                cmpi.b  #$05, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x01BC10
                cmpi.w  #$2940, Obj_X(A0)                                ; $0008
                bne.s   Offset_0x01BC32
                move.b  #$00, Obj_Subtype(A0)                            ; $0028
                bra.s   Offset_0x01BC32
Offset_0x01BC10:
                cmpi.w  #$1BC0, Obj_X(A0)                                ; $0008
                bne.s   Offset_0x01BC32
                move.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bra.s   Offset_0x01BC32
Offset_0x01BC20:
                subq.w  #$02, Obj_X(A0)                                  ; $0008
                cmpi.w  #$1880, Obj_X(A0)                                ; $0008
                bne.s   Offset_0x01BC32
                move.b  #$00, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x01BC32:
                move.w  Obj_X(A0), Obj_Control_Var_08(A0)         ; $0008, $0034
                move.w  Obj_X(A0), ($FFFFF7B0).w                         ; $0008
                rts   
;------------------------------------------------------------------------------- 
Offset_0x01BC40:
                move.l  Obj_Control_Var_10(A0), A1                       ; $003C
                move.w  Obj_Control_Var_0E(A1), D0                       ; $003A
Offset_0x01BC48:                
                andi.w  #$0007, D0
                move.b  Offset_0x01BC56(PC, D0), Obj_Map_Id(A0)          ; $001A
                bra     Jmp_10_To_MarkObjGone                  ; Offset_0x01BCDC                       
;-------------------------------------------------------------------------------  
Offset_0x01BC56:
                dc.b    $00, $00, $02, $02, $02, $01, $01, $01                                                                
;-------------------------------------------------------------------------------
Offset_0x01BC5E:
                move.w  ($FFFFF7B0).w, D0
                bra.s   Offset_0x01BC48       
;-------------------------------------------------------------------------------   
Mz_Platform_Mappings:                                          ; Offset_0x01BC64
                dc.w    Automatic_Platform_Mappings-Mz_Platform_Mappings ; Offset_0x01BC6C
                dc.w    Platform_Over_Gear_Mappings-Mz_Platform_Mappings ; Offset_0x01BC8E
                dc.w    Automatic_Platform_Mappings-Mz_Platform_Mappings ; Offset_0x01BC6C
                dc.w    Automatic_Platform_Mappings-Mz_Platform_Mappings ; Offset_0x01BC6C
Automatic_Platform_Mappings:                                   ; Offset_0x01BC6C
                dc.w    $0004
                dc.l    $F40E004B, $0025FFC0
                dc.l    $F40E004B, $0025FFE0
                dc.l    $F40E004B, $00250000
                dc.l    $F40E004B, $00250020
Platform_Over_Gear_Mappings:                                   ; Offset_0x01BC8E
                dc.w    $0002
                dc.l    $F40E0039, $001CFFE0
                dc.l    $F40E0839, $081C0000    
;-------------------------------------------------------------------------------
Mini_Gear_Mappings:                                            ; Offset_0x01BCA0
                dc.w    Offset_0x01BCA6-Mini_Gear_Mappings
                dc.w    Offset_0x01BCB8-Mini_Gear_Mappings
                dc.w    Offset_0x01BCCA-Mini_Gear_Mappings
Offset_0x01BCA6:
                dc.w    $0002
                dc.l    $F4060000, $0000FFF0
                dc.l    $F4060800, $08000000
Offset_0x01BCB8:
                dc.w    $0002
                dc.l    $F4060006, $0003FFF0
                dc.l    $F4061806, $18030000
Offset_0x01BCCA:
                dc.w    $0002
                dc.l    $F4061006, $1003FFF0
                dc.l    $F4060806, $08030000
;===============================================================================
; Objeto 0x65 - Plataformas sobre engrenagens na Metropolis
; <<<-
;===============================================================================