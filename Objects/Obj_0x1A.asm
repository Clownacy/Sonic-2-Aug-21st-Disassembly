;===============================================================================
; Objeto 0x1A - Plataformas que desmoronam na Hidden Palace / Oil Ocean
; ->>> 
;===============================================================================  
; Offset_0x0095DC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0095EA(PC, D0), D1
                jmp     Offset_0x0095EA(PC, D1)   
;------------------------------------------------------------------------------- 
Offset_0x0095EA:
                dc.w    Offset_0x0095F0-Offset_0x0095EA
                dc.w    Offset_0x00969C-Offset_0x0095EA
                dc.w    Offset_0x0096D4-Offset_0x0095EA 
;-------------------------------------------------------------------------------   
Offset_0x0095F0:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x00998C, $0004
                move.w  #$4000, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$07, Obj_Control_Var_0C(A0)                     ; $0038
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $001A, $0028
                move.l  #Collapsing_Platforms_Data, Obj_Control_Var_08(A0) ; Offset_0x009912, $0034
                cmpi.b  #$08, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x009658
                move.l  #HPz_Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x009D3C, $0004
                move.w  #$434A, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$30, Obj_Width(A0)                              ; $0019
                move.l  #Offset_0x009D0C, Obj_Control_Var_10(A0)         ; $003C
                move.l  #HPz_Collapsing_Platforms_Data, Obj_Control_Var_08(A0) ; Offset_0x00992B, $0034
                bra.s   Offset_0x00969C
Offset_0x009658:
                cmpi.b  #$0A, (Level_Id).w                           ; $FFFFFE10
                bne.s   Offset_0x009682
                move.l  #OOz_Collapsing_Platforms_Mappings, Obj_Map(A0) ; Offset_0x009DE6, $0004
                move.w  #$639D, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$40, Obj_Width(A0)                              ; $0019
                move.l  #Offset_0x009CFC, Obj_Control_Var_10(A0)         ; $003C
                bra.s   Offset_0x00969C
Offset_0x009682:
                move.l  #Offset_0x00995C, Obj_Control_Var_10(A0)         ; $003C
                move.b  #$34, Obj_Width(A0)                              ; $0019
                move.b  #$38, Obj_Height_2(A0)                           ; $0016
                bset    #$04, Obj_Flags(A0)                              ; $0001  
;-------------------------------------------------------------------------------  
Offset_0x00969C:
                tst.b   Obj_Control_Var_0E(A0)                           ; $003A
                beq.s   Offset_0x0096AE
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq     Offset_0x009888
                subq.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
Offset_0x0096AE:
                move.b  Obj_Status(A0), D0                               ; $0022
                andi.b  #$18, D0
                beq.s   Offset_0x0096BE
                move.b  #$01, Obj_Control_Var_0E(A0)                     ; $003A
Offset_0x0096BE:
                moveq   #$00, D1
                move.b  Obj_Width(A0), D1                                ; $0019
                move.l  Obj_Control_Var_10(A0), A2                       ; $003C
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     Platform_Object_2                      ; Offset_0x00F87E
                bra     MarkObjGone                            ; Offset_0x00D200  
;-------------------------------------------------------------------------------  
Offset_0x0096D4:
                tst.b   Obj_Control_Var_0C(A0)                           ; $0038
                beq.s   Offset_0x009718
                tst.b   Obj_Control_Var_0E(A0)                           ; $003A
                bne.s   Offset_0x0096E8
                subq.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x0096E8:
                bsr     Offset_0x0096BE
                subq.b  #$01, Obj_Control_Var_0C(A0)                     ; $0038
                bne.s   Offset_0x009716
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x0096FC
                lea     (Player_Two).w, A1                           ; $FFFFB040
Offset_0x0096FC:
                btst    #$03, Obj_Status(A1)                             ; $0022
                beq.s   Offset_0x009716
                bclr    #$03, Obj_Status(A1)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                move.b  #$01, Obj_Ani_Flag(A1)                           ; $001D
Offset_0x009716:
                rts
Offset_0x009718:
                bsr     ObjectFall                             ; Offset_0x00D1AE
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322  
;===============================================================================
; Objeto 0x1A - Plataformas que desmoronam na Hidden Palace / Oil Ocean
; <<<- 
;===============================================================================