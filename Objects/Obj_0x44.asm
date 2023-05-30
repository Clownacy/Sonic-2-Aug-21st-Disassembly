;===============================================================================
; Objeto 0x44 - Mola circular com estrela na Casino Night
; ->>>
;===============================================================================
; Offset_0x01486C:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x01487A(PC, D0), D1
                jmp     Offset_0x01487A(PC, D1)
;-------------------------------------------------------------------------------  
Offset_0x01487A:
                dc.w    Offset_0x01487E-Offset_0x01487A
                dc.w    Offset_0x0148AC-Offset_0x01487A       
;-------------------------------------------------------------------------------
Offset_0x01487E:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Red_Ball_Bumper_Mappings, Obj_Map(A0) ; Offset_0x014994, $0004
                move.w  #$439A, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$D7, Obj_Col_Flags(A0)                          ; $0020   
;------------------------------------------------------------------------------- 
Offset_0x0148AC:
                move.b  Obj_Col_Prop(A0), D0                             ; $0021
                beq     Offset_0x014978
                lea     (Player_One).w, A1                           ; $FFFFB000
                bclr    #$00, Obj_Col_Prop(A0)                           ; $0021
                beq.s   Offset_0x0148C2
                bsr.s   Offset_0x0148D8
Offset_0x0148C2:
                lea     (Player_Two).w, A1                           ; $FFFFB040
                bclr    #$01, Obj_Col_Prop(A0)                           ; $0021
                beq.s   Offset_0x0148D0
                bsr.s   Offset_0x0148D8
Offset_0x0148D0:
                clr.b   Obj_Col_Prop(A0)                                 ; $0021
                bra     Offset_0x014978
Offset_0x0148D8:
                move.w  Obj_X(A0), D1                                    ; $0008
                move.w  Obj_Y(A0), D2                                    ; $000C
                sub.w   Obj_X(A1), D1                                    ; $0008
                sub.w   Obj_Y(A1), D2                                    ; $000C
                jsr     (CalcAngle)                            ; Offset_0x00351A
                move.b  ($FFFFFE04).w, D1
                andi.w  #$0003, D1
                add.w   D1, D0
                jsr     (CalcSine)                             ; Offset_0x003282
                muls.w  #$F900, D1
                asr.l   #$08, D1
                move.w  D1, Obj_Speed(A1)                                ; $0010
                muls.w  #$F900, D0
                asr.l   #$08, D0
                move.w  D0, Obj_Speed_Y(A1)                              ; $0012
                bset    #$01, Obj_Status(A1)                             ; $0022
                bclr    #$04, Obj_Status(A1)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                clr.b   Obj_Control_Var_10(A1)                           ; $003C
                move.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$00B4, D0
                jsr     (Play_Sfx)                             ; Offset_0x001512
                lea     ($FFFFFC00).w, A2
                moveq   #$00, D0
                move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
                beq.s   Offset_0x014950
                cmpi.b  #$8A, $02(A2, D0)
                bcc.s   Offset_0x014976
                addq.b  #$01, $02(A2, D0)
Offset_0x014950:
                moveq   #$01, D0
                jsr     (AddPoints)                            ; Offset_0x02D2D4
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne.s   Offset_0x014976
                move.b  #$29, Obj_Id(A1)                                 ; $0000
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$04, Obj_Map_Id(A1)                             ; $001A
Offset_0x014976:
                rts
Offset_0x014978:
                lea     (Red_Ball_Bumper_Animate_Data), A1     ; Offset_0x014986
                bsr     AnimateSprite                          ; Offset_0x00D372
                bra     MarkObjGone                            ; Offset_0x00D200   
;-------------------------------------------------------------------------------
Red_Ball_Bumper_Animate_Data:                                  ; Offset_0x014986
                dc.w    Offset_0x01498A-Red_Ball_Bumper_Animate_Data
                dc.w    Offset_0x01498D-Red_Ball_Bumper_Animate_Data
Offset_0x01498A:
                dc.b    $0F, $00, $FF
Offset_0x01498D:
                dc.b    $03, $01, $00, $01, $FD, $00, $00    
;-------------------------------------------------------------------------------  
Red_Ball_Bumper_Mappings:                                      ; Offset_0x014994
                dc.w    Offset_0x014998-Red_Ball_Bumper_Mappings
                dc.w    Offset_0x0149AA-Red_Ball_Bumper_Mappings
Offset_0x014998:
                dc.w    $0002
                dc.l    $F0070000, $0000FFF0
                dc.l    $F0070800, $08000000
Offset_0x0149AA:
                dc.w    $0004
                dc.l    $EC0B0008, $0004FFE8
                dc.l    $EC0B0808, $08040000
                dc.l    $0C050014, $000AFFF0
                dc.l    $0C050814, $080A0000     
;===============================================================================
; Objeto 0x44 - Mola circular com estrela na Casino Night
; <<<-
;===============================================================================