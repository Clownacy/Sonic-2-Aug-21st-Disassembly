;===============================================================================
; Objeto 0x3F - Ventiladores na Oil Ocean
; ->>>
;===============================================================================  
; Offset_0x01F538:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01F546(PC, D0), D1
                jmp     Offset_0x01F546(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01F546:
                dc.w    Offset_0x01F54C-Offset_0x01F546
                dc.w    Offset_0x01F58A-Offset_0x01F546
                dc.w    Offset_0x01F678-Offset_0x01F546         
;-------------------------------------------------------------------------------
Offset_0x01F54C:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Vertical_Fan_Mappings, Obj_Map(A0) ; Offset_0x01F77E, $0004
                move.w  #$6403, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_25_To_ModifySpriteAttr_2P          ; Offset_0x01F8EA
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                tst.b   Obj_Subtype(A0)                                  ; $0028
                bpl.s   Offset_0x01F58A
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Horizontal_Fan_Mappings, Obj_Map(A0) ; Offset_0x01F830, $0004
                bra     Offset_0x01F678            
;-------------------------------------------------------------------------------
Offset_0x01F58A:
                btst    #$01, Obj_Subtype(A0)                            ; $0028
                bne.s   Offset_0x01F5B2
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bpl.s   Offset_0x01F5B2
                move.w  #$0000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0078, Obj_Control_Var_04(A0)                   ; $0030
                bchg    #00, Obj_Control_Var_06(A0)                      ; $0032
                beq.s   Offset_0x01F5B2
                move.w  #$00B4, Obj_Control_Var_04(A0)                   ; $0030
Offset_0x01F5B2:
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                beq     Offset_0x01F5D6
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01F618
                cmpi.w  #$0400, Obj_Control_Var_08(A0)                   ; $0034
                bcc.s   Offset_0x01F618
                addi.w  #$002A, Obj_Control_Var_08(A0)                   ; $0034
                move.b  Obj_Control_Var_08(A0), Obj_Ani_Time(A0)  ; $001E, $0034
                bra.s   Offset_0x01F5F2
Offset_0x01F5D6:
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr     Offset_0x01F61C
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr     Offset_0x01F61C
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01F618
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
Offset_0x01F5F2:
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
                cmpi.b  #$06, Obj_Ani_Frame(A0)                          ; $001B
                bcs.s   Offset_0x01F604
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x01F604:
                moveq   #$00, D0
                btst    #$00, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x01F610
                moveq   #$05, D0
Offset_0x01F610:
                add.b   Obj_Ani_Frame(A0), D0                            ; $001B
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
Offset_0x01F618:
                bra     Jmp_17_To_MarkObjGone                  ; Offset_0x01F8E4
Offset_0x01F61C:
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01F62E
                neg.w   D0
Offset_0x01F62E:
                addi.w  #$0050, D0
                cmpi.w  #$00F0, D0
                bcc.s   Offset_0x01F676
                move.w  Obj_Y(A1), D1                                    ; $000C
                addi.w  #$0060, D1
                sub.w   Obj_Y(A0), D1                                    ; $000C
                bcs.s   Offset_0x01F676
                cmpi.w  #$0070, D1
                bcc.s   Offset_0x01F676
                subi.w  #$0050, D0
                bcc.s   Offset_0x01F656
                not.w   D0
                add.w   D0, D0
Offset_0x01F656:
                addi.w  #$0060, D0
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01F664
                neg.w   D0
Offset_0x01F664:
                neg.w   D0
                asr.w   #$04, D0
                btst    #$00, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x01F672
                neg.w   D0
Offset_0x01F672:
                add.w   D0, Obj_X(A1)                                    ; $0008
Offset_0x01F676:
                rts 
;-------------------------------------------------------------------------------
Offset_0x01F678:
                btst    #$01, Obj_Subtype(A0)                            ; $0028
                bne.s   Offset_0x01F6A0
                subq.w  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bpl.s   Offset_0x01F6A0
                move.w  #$0000, Obj_Control_Var_08(A0)                   ; $0034
                move.w  #$0078, Obj_Control_Var_04(A0)                   ; $0030
                bchg    #00, Obj_Control_Var_06(A0)                      ; $0032
                beq.s   Offset_0x01F6A0
                move.w  #$00B4, Obj_Control_Var_04(A0)                   ; $0030
Offset_0x01F6A0:
                tst.b   Obj_Control_Var_06(A0)                           ; $0032
                beq     Offset_0x01F6C4
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01F706
                cmpi.w  #$0400, Obj_Control_Var_08(A0)                   ; $0034
                bcc.s   Offset_0x01F706
                addi.w  #$002A, Obj_Control_Var_08(A0)                   ; $0034
                move.b  Obj_Control_Var_08(A0), Obj_Ani_Time(A0)  ; $001E, $0034
                bra.s   Offset_0x01F6E0
Offset_0x01F6C4:
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr     Offset_0x01F70A
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr     Offset_0x01F70A
                subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x01F706
                move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
Offset_0x01F6E0:
                addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
                cmpi.b  #$06, Obj_Ani_Frame(A0)                          ; $001B
                bcs.s   Offset_0x01F6F2
                move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x01F6F2:
                moveq   #$00, D0
                btst    #$00, Obj_Subtype(A0)                            ; $0028
                beq.s   Offset_0x01F6FE
                moveq   #$05, D0
Offset_0x01F6FE:
                add.b   Obj_Ani_Frame(A0), D0                            ; $001B
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
Offset_0x01F706:
                bra     Jmp_17_To_MarkObjGone                  ; Offset_0x01F8E4
Offset_0x01F70A:
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$0040, D0
                cmpi.w  #$0080, D0
                bcc.s   Offset_0x01F77C
                moveq   #$00, D1
                move.b  ($FFFFFE74).w, D1
                add.w   Obj_Y(A1), D1                                    ; $000C
                addi.w  #$0060, D1
                sub.w   Obj_Y(A0), D1                                    ; $000C
                bcs.s   Offset_0x01F77C
                cmpi.w  #$0090, D1
                bcc.s   Offset_0x01F77C
                subi.w  #$0060, D1
                bcs.s   Offset_0x01F740
                not.w   D1
                add.w   D1, D1
Offset_0x01F740:
                addi.w  #$0060, D1
                neg.w   D1
                asr.w   #$04, D1
                add.w   D1, Obj_Y(A1)                                    ; $000C
                bset    #$01, Obj_Status(A1)                             ; $0022
                move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
                move.w  #$0001, Obj_Inertia(A1)                          ; $0014
                tst.b   Obj_Flip_Angle(A1)                               ; $0027
                bne.s   Offset_0x01F77C
                move.b  #$01, Obj_Flip_Angle(A1)                         ; $0027
                move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$7F, Obj_Control_Var_00(A1)                     ; $002C
                move.b  #$08, Obj_Control_Var_01(A1)                     ; $002D
Offset_0x01F77C:
                rts   
;-------------------------------------------------------------------------------
Vertical_Fan_Mappings:                                         ; Offset_0x01F77E
                dc.w    Offset_0x01F794-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7AE-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7C8-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7E2-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7FC-Vertical_Fan_Mappings
                dc.w    Offset_0x01F816-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7FC-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7E2-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7C8-Vertical_Fan_Mappings
                dc.w    Offset_0x01F7AE-Vertical_Fan_Mappings
                dc.w    Offset_0x01F794-Vertical_Fan_Mappings
Offset_0x01F794:
                dc.w    $0003
                dc.l    $F3020000, $0000FFF4
                dc.l    $F0050007, $0003FFFC
                dc.l    $00051007, $1003FFFC
Offset_0x01F7AE:
                dc.w    $0003
                dc.l    $F5021000, $1000FFF4
                dc.l    $F0050007, $0003FFFC
                dc.l    $00051007, $1003FFFC
Offset_0x01F7C8:
                dc.w    $0003
                dc.l    $F0030003, $0001FFF4
                dc.l    $F0050007, $0003FFFC
                dc.l    $00051007, $1003FFFC
Offset_0x01F7E2:
                dc.w    $0003
                dc.l    $F3020000, $0000FFF4
                dc.l    $F005000B, $0005FFFC
                dc.l    $0005100B, $1005FFFC
Offset_0x01F7FC:
                dc.w    $0003
                dc.l    $F5021000, $1000FFF4
                dc.l    $F005000B, $0005FFFC
                dc.l    $0005100B, $1005FFFC
Offset_0x01F816:
                dc.w    $0003
                dc.l    $F0030003, $0001FFF4
                dc.l    $F005000B, $0005FFFC
                dc.l    $0005100B, $1005FFFC  
;-------------------------------------------------------------------------------
Horizontal_Fan_Mappings:                                       ; Offset_0x01F830
                dc.w    Offset_0x01F846-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F860-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F87A-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F894-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F8AE-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F8C8-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F8AE-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F894-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F87A-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F860-Horizontal_Fan_Mappings
                dc.w    Offset_0x01F846-Horizontal_Fan_Mappings
Offset_0x01F846:
                dc.w    $0003
                dc.l    $F408000F, $0007FFF3
                dc.l    $FC050016, $000BFFF0
                dc.l    $FC050816, $080B0000
Offset_0x01F860:
                dc.w    $0003
                dc.l    $F408080F, $0807FFF5
                dc.l    $FC050016, $000BFFF0
                dc.l    $FC050816, $080B0000
Offset_0x01F87A:
                dc.w    $0003
                dc.l    $F40C0012, $0009FFF0
                dc.l    $FC050016, $000BFFF0
                dc.l    $FC050816, $080B0000
Offset_0x01F894:
                dc.w    $0003
                dc.l    $F408000F, $0007FFF3
                dc.l    $FC05001A, $000DFFF0
                dc.l    $FC05081A, $080D0000
Offset_0x01F8AE:
                dc.w    $0003
                dc.l    $F408080F, $0807FFF5
                dc.l    $FC05001A, $000DFFF0
                dc.l    $FC05081A, $080D0000
Offset_0x01F8C8:
                dc.w    $0003
                dc.l    $F40C0012, $0009FFF0
                dc.l    $FC05001A, $000DFFF0
                dc.l    $FC05081A, $080D0000  
;===============================================================================
; Objeto 0x3F - Ventiladores na Oil Ocean
; <<<-
;===============================================================================