;===============================================================================
; Objeto 0xA2 - Sub-objeto usado pelo inimigo Slicer na Metropolis.
; ->>>          Facas que são atiradas no jogador
;===============================================================================
; Offset_0x0299CE:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0299DC(PC, D0), D1
                jmp     Offset_0x0299DC(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0299DC:
                dc.w    Offset_0x0299E2-Offset_0x0299DC
                dc.w    Offset_0x029A10-Offset_0x0299DC
                dc.w    Offset_0x029A5E-Offset_0x0299DC        
;-------------------------------------------------------------------------------
Offset_0x0299E2:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  #$FE00, Obj_Speed(A0)                            ; $0010
                move.w  #$0200, Obj_Control_Var_02(A0)                   ; $002E
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                lea     Offset_0x029A0C(PC, D0), A2
                move.b  (A2)+, D0
                ext.w   D0
                add.w   D0, Obj_X(A0)                                    ; $0008
                move.b  (A2)+, D0
                ext.w   D0
                add.w   D0, Obj_Y(A0)                                    ; $000C
                rts   
;-------------------------------------------------------------------------------
Offset_0x029A0C:
                dc.w    $0600, $F000             
;-------------------------------------------------------------------------------  
Offset_0x029A10:
                subq.w  #$01, Obj_Control_Var_02(A0)                     ; $002E
                bmi.s   Offset_0x029A54
                move.w  Obj_Timer(A0), A1                                ; $002A
                cmpi.b  #$A1, (A1)
                bne.s   Offset_0x029A54
                bsr     Object_Check_Player_Position           ; Offset_0x027F1C
                move.w  Offset_0x029A50(PC, D0), D2
                add.w   D2, Obj_Speed(A0)                                ; $0010
                move.w  Offset_0x029A50(PC, D1), D2
                add.w   D2, Obj_Speed_Y(A0)                              ; $0012
                move.w  #$0200, D0
                move.w  D0, D1
                bsr     Offset_0x027F3E
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Slicer_Pincers_Animate_Data), A1      ; Offset_0x029AD0
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x029A50:
                dc.w    $FFF0, $0010                                      
;-------------------------------------------------------------------------------
Offset_0x029A54:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0080, Obj_Control_Var_02(A0)                   ; $002E  
;-------------------------------------------------------------------------------
Offset_0x029A5E:
                subq.w  #$01, Obj_Control_Var_02(A0)                     ; $002E
                bmi     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                bsr     Jmp_0E_To_ObjectFall                   ; Offset_0x02A7BE
                lea     (Slicer_Pincers_Animate_Data), A1      ; Offset_0x029AD0
                bsr     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------                  
Load_Slicer_Pincers_Obj:                                       ; Offset_0x029A78
                moveq   #$00, D1
                moveq   #$01, D6
Offset_0x029A7C:
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x029AB4
                move.b  #$A2, Obj_Id(A1)                                 ; $0000
                move.b  #$2A, Obj_Subtype(A1)                            ; $0028
                move.b  #$05, Obj_Map_Id(A1)                             ; $001A
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  D1, Obj_Control_Var_00(A1)                       ; $002C
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addq.w  #$02, D1
                dbra    D6, Offset_0x029A7C
Offset_0x029AB4:
                rts     
;-------------------------------------------------------------------------------    
Obj_0xA1_Ptr:                                                  ; Offset_0x029AB6
                dc.l    Slicer_Mappings                        ; Offset_0x029AD8
                dc.w    $243C
                dc.b    $04, $05, $10, $06         
;-------------------------------------------------------------------------------    
Obj_0xA2_Ptr:                                                  ; Offset_0x029AC0
                dc.l    Slicer_Mappings                        ; Offset_0x029AD8
                dc.w    $243C
                dc.b    $04, $04, $10, $9A               
;-------------------------------------------------------------------------------
Slicer_Animate_Data:                                           ; Offset_0x029ACA
                dc.w    Offset_0x029ACC-Slicer_Animate_Data
Offset_0x029ACC:
                dc.b    $13, $00, $02, $FF  
;-------------------------------------------------------------------------------
Slicer_Pincers_Animate_Data:                                   ; Offset_0x029AD0
                dc.w    Offset_0x029AD2-Slicer_Pincers_Animate_Data
Offset_0x029AD2:
                dc.b    $03, $05, $06, $07, $08, $FF       
;------------------------------------------------------------------------------- 
Slicer_Mappings:                                               ; Offset_0x029AD8
                dc.w    Offset_0x029AEA-Slicer_Mappings
                dc.w    Offset_0x029B24-Slicer_Mappings
                dc.w    Offset_0x029B5E-Slicer_Mappings
                dc.w    Offset_0x029B98-Slicer_Mappings
                dc.w    Offset_0x029BD2-Slicer_Mappings
                dc.w    Offset_0x029BEC-Slicer_Mappings
                dc.w    Offset_0x029BFE-Slicer_Mappings
                dc.w    Offset_0x029C10-Slicer_Mappings
                dc.w    Offset_0x029C22-Slicer_Mappings
Offset_0x029AEA:
                dc.w    $0007
                dc.l    $F904001A, $000DFFF4
                dc.l    $0100001C, $000EFFF4
                dc.l    $F0090000, $0000FFF0
                dc.l    $00090006, $0003FFF0
                dc.l    $0001000C, $00060008
                dc.l    $F704001A, $000DFFE0
                dc.l    $FF00001C, $000EFFE0
Offset_0x029B24:
                dc.w    $0007
                dc.l    $F804001A, $000DFFF4
                dc.l    $0000001C, $000EFFF4
                dc.l    $F0090000, $0000FFF0
                dc.l    $0009000E, $0007FFF0
                dc.l    $0001000C, $00060008
                dc.l    $F804001A, $000DFFE0
                dc.l    $0000001C, $000EFFE0
Offset_0x029B5E:
                dc.w    $0007
                dc.l    $F704001A, $000DFFF4
                dc.l    $FF00001C, $000EFFF4
                dc.l    $F0090000, $0000FFF0
                dc.l    $00090014, $000AFFF0
                dc.l    $0001000C, $00060008
                dc.l    $F904001A, $000DFFE0
                dc.l    $0100001C, $000EFFE0
Offset_0x029B98:
                dc.w    $0007
                dc.l    $E004181E, $180FFFF4
                dc.l    $E800181D, $180EFFFC
                dc.l    $F0090000, $0000FFF0
                dc.l    $00090006, $0003FFF0
                dc.l    $0001000C, $00060008
                dc.l    $E004181E, $180FFFE0
                dc.l    $E800181D, $180EFFE8
Offset_0x029BD2:
                dc.w    $0003
                dc.l    $F0090000, $0000FFF0
                dc.l    $00090006, $0003FFF0
                dc.l    $0001000C, $00060008
Offset_0x029BEC:
                dc.w    $0002
                dc.l    $F004001A, $000DFFF0
                dc.l    $F800001C, $000EFFF0
Offset_0x029BFE:
                dc.w    $0002
                dc.l    $0000001D, $000EFFF0
                dc.l    $0804001E, $000FFFF0
Offset_0x029C10:
                dc.w    $0002
                dc.l    $0000181C, $180E0008
                dc.l    $0804181A, $180D0000
Offset_0x029C22:
                dc.w    $0002
                dc.l    $F004181E, $180F0000
                dc.l    $F800181D, $180E0008
;===============================================================================
; Objeto 0xA2 - Sub-objeto usado pelo inimigo Slicer na Metropolis.
; <<<-          Facas que são atiradas no jogador
;===============================================================================