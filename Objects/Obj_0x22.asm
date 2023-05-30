;===============================================================================
; Objeto 0x22 - Atirador de setas na Neo Green Hill
; ->>> 
;===============================================================================
; Offset_0x01A44C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01A45A(PC, D0), D1
                jmp     Offset_0x01A45A(PC, D1)
;-------------------------------------------------------------------------------    
Offset_0x01A45A:
                dc.w    Offset_0x01A464-Offset_0x01A45A
                dc.w    Offset_0x01A498-Offset_0x01A45A
                dc.w    Offset_0x01A4E2-Offset_0x01A45A
                dc.w    Offset_0x01A532-Offset_0x01A45A
                dc.w    Offset_0x01A576-Offset_0x01A45A    
;------------------------------------------------------------------------------- 
Offset_0x01A464:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Arrow_Shooter_Mappings, Obj_Map(A0) ; Offset_0x01A5BC, $0004
                move.w  #$0417, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_0C_To_ModifySpriteAttr_2P          ; Offset_0x01A638
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$03, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Map_Id(A0)                             ; $001A
                andi.b  #$0F, Obj_Subtype(A0)                            ; $0028
;------------------------------------------------------------------------------- 
Offset_0x01A498:
                cmpi.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                beq.s   Offset_0x01A4BE
                moveq   #$00, D2
                lea     (Player_One).w, A1                           ; $FFFFB000
                bsr.s   Offset_0x01A4CC
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bsr.s   Offset_0x01A4CC
                tst.b   D2
                bne.s   Offset_0x01A4BA
                tst.b   Obj_Ani_Number(A0)                               ; $001C
                beq.s   Offset_0x01A4BA
                moveq   #$02, D2
Offset_0x01A4BA:
                move.b  D2, Obj_Ani_Number(A0)                           ; $001C
Offset_0x01A4BE:
                lea     (Arrow_Shooter_Animate_Data), A1       ; Offset_0x01A5A6
                bsr     Jmp_01_To_AnimateSprite                ; Offset_0x01A632
                bra     Jmp_0C_To_MarkObjGone                  ; Offset_0x01A62C
Offset_0x01A4CC:
                move.w  Obj_X(A0), D0                                    ; $0008
                sub.w   Obj_X(A1), D0                                    ; $0008
                bcc.s   Offset_0x01A4D8
                neg.w   D0
Offset_0x01A4D8:
                cmpi.w  #$0040, D0
                bcc.s   Offset_0x01A4E0
                moveq   #$01, D2
Offset_0x01A4E0:
                rts  
;------------------------------------------------------------------------------- 
Offset_0x01A4E2:
                bsr     Jmp_02_To_SingleObjectLoad             ; Offset_0x01A626
                bne.s   Offset_0x01A520
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                addq.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.w  #$00DB, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x01A520:
                subq.b  #$02, Obj_Routine(A0)                            ; $0024
                lea     (Arrow_Shooter_Animate_Data), A1       ; Offset_0x01A5A6
                bsr     Jmp_01_To_AnimateSprite                ; Offset_0x01A632
                bra     Jmp_0C_To_MarkObjGone                  ; Offset_0x01A62C  
;------------------------------------------------------------------------------- 
Offset_0x01A532:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$08, Obj_Height_2(A0)                           ; $0016
                move.b  #$10, Obj_Width_2(A0)                            ; $0017
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  #$9B, Obj_Col_Flags(A0)                          ; $0020
                move.b  #$08, Obj_Width(A0)                              ; $0019
                move.b  #$00, Obj_Map_Id(A0)                             ; $001A
                move.w  #$0400, Obj_Speed(A0)                            ; $0010
                btst    #$00, Obj_Status(A0)                             ; $0022
                beq.s   Offset_0x01A56C
                neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x01A56C:
                move.w  #$00AE, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512   
;------------------------------------------------------------------------------- 
Offset_0x01A576:
                bsr     Jmp_07_To_SpeedToPos                   ; Offset_0x01A63E
                btst    #$00, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x01A596
                moveq   #-$08, D3
                bsr     Object_HitWall_Left                    ; Offset_0x014490
                tst.w   D1
                bmi     Offset_0x01A592
                bra     Jmp_0C_To_MarkObjGone                  ; Offset_0x01A62C
Offset_0x01A592:
                bra     Jmp_0A_To_DeleteObject                 ; Offset_0x01A620
Offset_0x01A596:
                moveq   #$08, D3
                bsr     Object_HitWall_Right                   ; Offset_0x01430A
                tst.w   D1
                bmi     Offset_0x01A592
                bra     Jmp_0C_To_MarkObjGone                  ; Offset_0x01A62C              
;-------------------------------------------------------------------------------  
Arrow_Shooter_Animate_Data:                                    ; Offset_0x01A5A6
                dc.w    Offset_0x01A5AC-Arrow_Shooter_Animate_Data
                dc.w    Offset_0x01A5AF-Arrow_Shooter_Animate_Data
                dc.w    Offset_0x01A5B3-Arrow_Shooter_Animate_Data
Offset_0x01A5AC:
                dc.b    $1F, $01, $FF
Offset_0x01A5AF:
                dc.b    $03, $01, $02, $FF
Offset_0x01A5B3:
                dc.b    $07, $03, $04, $FC, $04, $03, $01, $FD
                dc.b    $00  
;-------------------------------------------------------------------------------   
Arrow_Shooter_Mappings:                                        ; Offset_0x01A5BC
                dc.w    Offset_0x01A5C6-Arrow_Shooter_Mappings
                dc.w    Offset_0x01A5D0-Arrow_Shooter_Mappings
                dc.w    Offset_0x01A5E2-Arrow_Shooter_Mappings
                dc.w    Offset_0x01A5FC-Arrow_Shooter_Mappings
                dc.w    Offset_0x01A60E-Arrow_Shooter_Mappings
Offset_0x01A5C6:
                dc.w    $0001
                dc.l    $FC0C2000, $2000FFF0
Offset_0x01A5D0:
                dc.w    $0002
                dc.l    $F8092004, $2002FFF0
                dc.l    $F801200B, $20050008
Offset_0x01A5E2:
                dc.w    $0003
                dc.l    $FC00000A, $0005FFFC
                dc.l    $F8092004, $2002FFF0
                dc.l    $F801200B, $20050008
Offset_0x01A5FC:
                dc.w    $0002
                dc.l    $F8092004, $2002FFF0
                dc.l    $F801200D, $20060008
Offset_0x01A60E:
                dc.w    $0002
                dc.l    $F8092004, $2002FFF0
                dc.l    $F801200F, $20070008    
;===============================================================================
; Objeto 0x22 - Atirador de setas na Neo Green Hill
; <<<- 
;===============================================================================