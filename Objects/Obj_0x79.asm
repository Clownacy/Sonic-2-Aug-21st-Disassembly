;===============================================================================
; Objeto 0x79 - Poste de reinício, utilizado para salvar a posição do jogador
; ->>>          na fase
;===============================================================================
; Offset_0x0144C0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0144D4(PC, D0), D1
                jsr     Offset_0x0144D4(PC, D1)
                jmp     (MarkObjGone)                          ; Offset_0x00D200
;-------------------------------------------------------------------------------
Offset_0x0144D4:
                dc.w    Offset_0x0144DA-Offset_0x0144D4
                dc.w    Offset_0x01453C-Offset_0x0144D4
                dc.w    Offset_0x0145C4-Offset_0x0144D4     
;-------------------------------------------------------------------------------
Offset_0x0144DA:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Lamp_Post_Mappings, Obj_Map(A0) ; Offset_0x0146FA, $0004
                move.w  #$047C, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.b  #$05, Obj_Priority(A0)                           ; $0018
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                bclr    #$07, $02(A2, D0)
                btst    #$00, $02(A2, D0)
                bne.s   Offset_0x01452E
                move.b  (Saved_Level_Flag).w, D1                     ; $FFFFFE30
                andi.b  #$7F, D1
                move.b  Obj_Subtype(A0), D2                              ; $0028
                andi.b  #$7F, D2
                cmp.b   D2, D1
                bcs.s   Offset_0x01453C
Offset_0x01452E:
                bset    #$00, $02(A2, D0)
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                rts                    
;-------------------------------------------------------------------------------
Offset_0x01453C:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x0145C2
                tst.b   ($FFFFB02A).w
                bmi     Offset_0x0145C2
                move.b  (Saved_Level_Flag).w, D1                     ; $FFFFFE30
                andi.b  #$7F, D1
                move.b  Obj_Subtype(A0), D2                              ; $0028
                andi.b  #$7F, D2
                cmp.b   D2, D1
                bcs.s   Offset_0x01457A
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                bset    #$00, $02(A2, D0)
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                bra     Offset_0x0145C2
Offset_0x01457A:
                move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
                sub.w   Obj_X(A0), D0                                    ; $0008
                addi.w  #$0008, D0
                cmpi.w  #$0010, D0
                bcc     Offset_0x0145C2
                move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
                sub.w   Obj_Y(A0), D0                                    ; $000C
                addi.w  #$0040, D0
                cmpi.w  #$0068, D0
                bcc.s   Offset_0x0145C2
                move.w  #$00A1, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                bsr     Level_Save_Info                        ; Offset_0x0145D6
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                bset    #$00, $02(A2, D0)
Offset_0x0145C2:
                rts    
;-------------------------------------------------------------------------------
Offset_0x0145C4:
                move.b  ($FFFFFE0F).w, D0
                andi.b  #$02, D0
                lsr.b   #$01, D0
                addq.b  #$01, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                rts
;-------------------------------------------------------------------------------                
Level_Save_Info:                                               ; Offset_0x0145D6
                move.b  Obj_Subtype(A0), (Saved_Level_Flag).w              ; $FFFFFE30; $0028
                move.b  (Saved_Level_Flag).w, ($FFFFFE31).w          ; $FFFFFE30
                move.w  Obj_X(A0), ($FFFFFE32).w                         ; $0008
                move.w  Obj_Y(A0), ($FFFFFE34).w                         ; $000C
                move.w  (Ring_Count).w, ($FFFFFE36).w                ; $FFFFFE20
                move.b  (Ring_Life_Flag).w, ($FFFFFE54).w            ; $FFFFFE1B
                move.l  (Time_Count).w, ($FFFFFE38).w                ; $FFFFFE22
                move.b  (Dyn_Resize_Routine).w, ($FFFFFE3C).w        ; $FFFFEEDF
                move.w  (Sonic_Level_Limits_Max_Y).w, ($FFFFFE3E).w  ; $FFFFEECE
                move.w  (Camera_X).w, ($FFFFFE40).w                  ; $FFFFEE00
                move.w  (Camera_Y).w, ($FFFFFE42).w                  ; $FFFFEE04
                move.w  (Camera_X_x2).w, ($FFFFFE44).w               ; $FFFFEE08
                move.w  (Camera_Y_x4).w, ($FFFFFE46).w               ; $FFFFEE0C
                move.w  (Camera_X_x8).w, ($FFFFFE48).w               ; $FFFFEE10
                move.w  (Camera_Y_x4_Mod_10).w, ($FFFFFE4A).w        ; $FFFFEE14
                move.w  (Camera_X_x4).w, ($FFFFFE4C).w               ; $FFFFEE18
                move.w  (Camera_Y_x4_Mod_10_2).w, ($FFFFFE4E).w      ; $FFFFEE1C
                move.w  (Water_Level_Change).w, ($FFFFFE50).w        ; $FFFFF648
                move.b  ($FFFFF64D).w, ($FFFFFE52).w
                move.b  ($FFFFF64E).w, ($FFFFFE53).w
                rts        
;-------------------------------------------------------------------------------                                   
Level_Restore_Info:                                            ; Offset_0x014650
                move.b  ($FFFFFE31).w, (Saved_Level_Flag).w          ; $FFFFFE30
                move.w  ($FFFFFE32).w, (Player_One_Position_X).w     ; $FFFFB008
                move.w  ($FFFFFE34).w, (Player_One_Position_Y).w     ; $FFFFB00C
                move.w  ($FFFFFE36).w, (Ring_Count).w                ; $FFFFFE20
                move.b  ($FFFFFE54).w, (Ring_Life_Flag).w            ; $FFFFFE1B
                clr.w   (Ring_Count).w                               ; $FFFFFE20
                clr.b   (Ring_Life_Flag).w                           ; $FFFFFE1B
                move.l  ($FFFFFE38).w, (Time_Count).w                ; $FFFFFE22
                move.b  #$3B, (Time_Count_CentiSeconds).w            ; $FFFFFE25
                subq.b  #$01, (Time_Count_Seconds).w                 ; $FFFFFE24
                move.b  ($FFFFFE3C).w, (Dyn_Resize_Routine).w        ; $FFFFEEDF
                move.b  ($FFFFFE52).w, ($FFFFF64D).w
                move.w  ($FFFFFE3E).w, (Sonic_Level_Limits_Max_Y).w  ; $FFFFEECE
                move.w  ($FFFFFE3E).w, ($FFFFEEC6).w
                move.w  ($FFFFFE40).w, (Camera_X).w                  ; $FFFFEE00
                move.w  ($FFFFFE42).w, (Camera_Y).w                  ; $FFFFEE04
                move.w  ($FFFFFE44).w, (Camera_X_x2).w               ; $FFFFEE08
                move.w  ($FFFFFE46).w, (Camera_Y_x4).w               ; $FFFFEE0C
                move.w  ($FFFFFE48).w, (Camera_X_x8).w               ; $FFFFEE10
                move.w  ($FFFFFE4A).w, (Camera_Y_x4_Mod_10).w        ; $FFFFEE14
                move.w  ($FFFFFE4C).w, (Camera_X_x4).w               ; $FFFFEE18
                move.w  ($FFFFFE4E).w, (Camera_Y_x4_Mod_10_2).w      ; $FFFFEE1C
                tst.b   (Water_Level_Flag).w                         ; $FFFFF730
                beq.s   Offset_0x0146E6
                move.w  ($FFFFFE50).w, (Water_Level_Change).w        ; $FFFFF648
                move.b  ($FFFFFE52).w, ($FFFFF64D).w
                move.b  ($FFFFFE53).w, ($FFFFF64E).w
Offset_0x0146E6:
                tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
                bpl.s   Offset_0x0146F8
                move.w  ($FFFFFE32).w, D0
                subi.w  #$00A0, D0
                move.w  D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEEC8
Offset_0x0146F8:
                rts        
;-------------------------------------------------------------------------------
Lamp_Post_Mappings:                                            ; Offset_0x0146FA
                dc.w    Offset_0x014700-Lamp_Post_Mappings
                dc.w    Offset_0x014722-Lamp_Post_Mappings
                dc.w    Offset_0x014744-Lamp_Post_Mappings
Offset_0x014700:
                dc.w    $0004
                dc.l    $E8012000, $2000FFF8
                dc.l    $E8012800, $28000000
                dc.l    $F8030006, $0003FFF8
                dc.l    $F8030806, $08030000
Offset_0x014722:
                dc.w    $0004
                dc.l    $E8010002, $0001FFF8
                dc.l    $E8010802, $08010000
                dc.l    $F8030006, $0003FFF8
                dc.l    $F8030806, $08030000
Offset_0x014744:
                dc.w    $0004
                dc.l    $E8012004, $2002FFF8
                dc.l    $E8012804, $28020000
                dc.l    $F8030006, $0003FFF8
                dc.l    $F8030806, $08030000
;===============================================================================
; Objeto 0x79 - Poste de reinício, utilizado para salvar a posição do jogador
; <<<-          na fase
;===============================================================================