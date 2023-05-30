;===============================================================================
; Objeto 0x7F - Raízes usadas como interruptores para levantar as pontes na
; ->>>          Dust Hill
;===============================================================================
; Offset_0x01E8A4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01E8B2(PC, D0), D1
                jmp     Offset_0x01E8B2(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x01E8B2:
                dc.w    Offset_0x01E8B6-Offset_0x01E8B2
                dc.w    Offset_0x01E8DE-Offset_0x01E8B2           
;-------------------------------------------------------------------------------
Offset_0x01E8B6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Vines_Switch_Mappings, Obj_Map(A0) ; Offset_0x01E9EC, $0004
                move.w  #$640E, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_20_To_ModifySpriteAttr_2P          ; Offset_0x01EA2A
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018  
;-------------------------------------------------------------------------------
Offset_0x01E8DE:
                lea     Obj_Control_Var_04(A0), A2                       ; $0030
                lea     (Player_One).w, A1                           ; $FFFFB000
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
                bsr.s   Offset_0x01E8FC
                lea     (Player_Two).w, A1                           ; $FFFFB040
                addq.w  #$01, A2
                move.w  ($FFFFF606).w, D0
                bsr.s   Offset_0x01E8FC
                bra     Jmp_15_To_MarkObjGone                  ; Offset_0x01EA24
Offset_0x01E8FC:
                tst.b   (A2)
                beq.s   Offset_0x01E950
                andi.b  #$70, D0
                beq     Offset_0x01E9EA
                clr.b   Obj_Timer(A1)                                    ; $002A
                clr.b   (A2)
                move.b  #$12, Obj_Art_VRAM(A2)                           ; $0002
                andi.w  #$0F00, D0
                beq.s   Offset_0x01E920
                move.b  #$3C, Obj_Art_VRAM(A2)                           ; $0002
Offset_0x01E920:
                move.w  #$FD00, Obj_Speed_Y(A1)                          ; $0012
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lea     ($FFFFF7E0).w, A3
                lea     $00(A3, D0), A3
                bclr    #$00, (A3)
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                tst.w   Obj_Control_Var_04(A0)                           ; $0030
                beq.s   Offset_0x01E94C
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x01E94C:
                bra     Offset_0x01E9EA
Offset_0x01E950:
                tst.b   Obj_Art_VRAM(A2)                                 ; $0002
                beq.s   Offset_0x01E95E
                subq.b  #$01, Obj_Art_VRAM(A2)                           ; $0002
                bne     Offset_0x01E9EA
Offset_0x01E95E:
                move.w  Obj_X(A1), D0                                    ; $0008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$000C, D0
                cmpi.w  #$0018, D0
                bcc     Offset_0x01E9EA
                move.w  Obj_Y(A1), D1                                    ; $000C
                sub.w   Obj_Y(A0), D1                                    ; $000C
                subi.w  #$0028, D1
                cmpi.w  #$0010, D1
                bcc     Offset_0x01E9EA
                cmpi.b  #$04, Obj_Routine(A1)                            ; $0024
                bcc.s   Offset_0x01E9EA
                clr.w   Obj_Speed(A1)                                    ; $0010
                clr.w   Obj_Speed_Y(A1)                                  ; $0012
                clr.w   Obj_Inertia(A1)                                  ; $0014
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0030, Obj_Y(A1)                                ; $000C
                move.b  #$14, Obj_Ani_Number(A1)                         ; $001C
                move.b  #$01, Obj_Timer(A1)                              ; $002A
                move.b  #$01, (A2)
                move.b  Obj_Subtype(A0), D0                              ; $0028
                andi.w  #$000F, D0
                lea     ($FFFFF7E0).w, A3
                bset    #$00, $00(A3, D0)
                move.w  #$00CD, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                tst.w   Obj_Control_Var_04(A0)                           ; $0030
                beq.s   Offset_0x01E9EA
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
Offset_0x01E9EA:
                rts                   
;-------------------------------------------------------------------------------
Vines_Switch_Mappings:                                         ; Offset_0x01E9EC
                dc.w    Offset_0x01E9F0-Vines_Switch_Mappings
                dc.w    Offset_0x01EA0A-Vines_Switch_Mappings
Offset_0x01E9F0:
                dc.w    $0003
                dc.l    $D0070000, $0000FFF8
                dc.l    $F0070000, $0000FFF8
                dc.l    $10070008, $0004FFF8
Offset_0x01EA0A:
                dc.w    $0003
                dc.l    $D4070000, $0000FFF8
                dc.l    $F4070000, $0000FFF8
                dc.l    $14070008, $0004FFF8
;===============================================================================
; Objeto 0x7F - Raízes usadas como interruptores para levantar as pontes na
; <<<-          Dust Hill
;===============================================================================