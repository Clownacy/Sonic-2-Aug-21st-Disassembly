;===============================================================================
; Objeto 0x3C - Parede quebrável na Green Hill do Sonic 1 não usado (Left over)
; ->>>
;===============================================================================  
; Offset_0x00CC50:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x00CC62(PC, D0), D1
                jsr     Offset_0x00CC62(PC, D1)
                bra     MarkObjGone                            ; Offset_0x00D200  
;-------------------------------------------------------------------------------  
Offset_0x00CC62:
                dc.w    Offset_0x00CC68-Offset_0x00CC62
                dc.w    Offset_0x00CC96-Offset_0x00CC62
                dc.w    Offset_0x00CD0E-Offset_0x00CC62                      
;-------------------------------------------------------------------------------   
Offset_0x00CC68:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #S1_Breakable_Wall_Mappings, Obj_Map(A0) ; Offset_0x00CDD8, $0004
                move.w  #$4590, Obj_Art_VRAM(A0)                         ; $0002
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.b  Obj_Subtype(A0), Obj_Map_Id(A0)           ; $001A, $0028   
;-------------------------------------------------------------------------------  
Offset_0x00CC96:
                move.w  ($FFFFB010).w, Obj_Control_Var_04(A0)            ; $0030
                move.w  #$001B, D1
                move.w  #$0020, D2
                move.w  #$0020, D3
                move.w  Obj_X(A0), D4                                    ; $0008
                bsr     SolidObject                            ; Offset_0x00F344
                btst    #$05, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x00CCBA
Offset_0x00CCB8:
                rts
Offset_0x00CCBA:
                lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
                cmpi.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                bne.s   Offset_0x00CCB8
                move.w  Obj_Control_Var_04(A0), D0                       ; $0030
                bpl.s   Offset_0x00CCCE
                neg.w   D0
Offset_0x00CCCE:
                cmpi.w  #$0480, D0
                bcs.s   Offset_0x00CCB8
                move.w  Obj_Control_Var_04(A0), Obj_Speed(A1)     ; $0010, $0030
                addq.w  #$04, Obj_X(A1)                                  ; $0008
                lea     (Offset_0x00CD98), A4
                move.w  Obj_X(A0), D0                                    ; $0008
                cmp.w   Obj_X(A1), D0                                    ; $0008
                bcs.s   Offset_0x00CCFA
                subi.w  #$0008, Obj_X(A1)                                ; $0008
                lea     (Offset_0x00CDB8), A4
Offset_0x00CCFA:
                move.w  Obj_Speed(A1), Obj_Inertia(A1)            ; $0010, $0014
                bclr    #$05, Obj_Status(A0)                             ; $0022
                bclr    #$05, Obj_Status(A1)                             ; $0022
                bsr.s   Smash_Object                           ; Offset_0x00CD24       
;-------------------------------------------------------------------------------  
Offset_0x00CD0E:
                bsr     SpeedToPos                             ; Offset_0x00D1DA
                addi.w  #$0070, Obj_Speed_Y(A0)                          ; $0012
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     DeleteObject                           ; Offset_0x00D314
                bra     DisplaySprite                          ; Offset_0x00D322  
;-------------------------------------------------------------------------------                
Smash_Object:                                                  ; Offset_0x00CD24
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                add.w   D0, D0
                move.l  Obj_Map(A0), A3                                  ; $0004
                adda.w  $00(A3, D0), A3
                move.w  (A3)+, D1
                subq.w  #$01, D1
                bset    #$05, Obj_Flags(A0)                              ; $0001
                move.b  Obj_Id(A0), D4                                   ; $0000
                move.b  Obj_Flags(A0), D5                                ; $0001
                move.l  A0, A1
                bra.s   Offset_0x00CD52             
;-------------------------------------------------------------------------------   
Offset_0x00CD4A:
                bsr     SingleObjectLoad_2                     ; Offset_0x00E714
                bne.s   Offset_0x00CD8E
                addq.w  #$08, A3      
;-------------------------------------------------------------------------------
Offset_0x00CD52:
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  D4, Obj_Id(A1)                                   ; $0000
                move.l  A3, Obj_Map(A1)                                  ; $0004
                move.b  D5, Obj_Flags(A1)                                ; $0001
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.b  Obj_Priority(A0), Obj_Priority(A1)        ; $0018, $0018
                move.b  Obj_Width(A0), Obj_Width(A1)              ; $0019, $0019
                move.w  (A4)+, Obj_Speed(A1)                             ; $0010
                move.w  (A4)+, Obj_Speed_Y(A1)                           ; $0012
                dbra    D1, Offset_0x00CD4A
Offset_0x00CD8E:
                move.w  #$00CB, D0
                jmp     (Play_Sfx)                             ; Offset_0x001512 
;-------------------------------------------------------------------------------  
Offset_0x00CD98:     
                dc.w    $0400, $FB00, $0600, $FF00, $0600, $0100, $0400, $0500
                dc.w    $0600, $FA00, $0800, $FE00, $0800, $0200, $0600, $0600
;-------------------------------------------------------------------------------
Offset_0x00CDB8: 
                dc.w    $FA00, $FA00, $F800, $FE00, $F800, $0200, $FA00, $0600
                dc.w    $FC00, $FB00, $FA00, $FF00, $FA00, $0100, $FC00, $0500
;-------------------------------------------------------------------------------
S1_Breakable_Wall_Mappings:                                    ; Offset_0x00CDD8
                dc.w    Offset_0x00CDDE-S1_Breakable_Wall_Mappings
                dc.w    Offset_0x00CE20-S1_Breakable_Wall_Mappings
                dc.w    Offset_0x00CE62-S1_Breakable_Wall_Mappings
Offset_0x00CDDE:
                dc.w    $0008
                dc.l    $E0050000, $0000FFF0
                dc.l    $F0050000, $0000FFF0
                dc.l    $00050000, $0000FFF0
                dc.l    $10050000, $0000FFF0
                dc.l    $E0050004, $00020000
                dc.l    $F0050004, $00020000
                dc.l    $00050004, $00020000
                dc.l    $10050004, $00020000
Offset_0x00CE20:
                dc.w    $0008
                dc.l    $E0050004, $0002FFF0
                dc.l    $F0050004, $0002FFF0
                dc.l    $00050004, $0002FFF0
                dc.l    $10050004, $0002FFF0
                dc.l    $E0050004, $00020000
                dc.l    $F0050004, $00020000
                dc.l    $00050004, $00020000
                dc.l    $10050004, $00020000
Offset_0x00CE62:
                dc.w    $0008
                dc.l    $E0050004, $0002FFF0
                dc.l    $F0050004, $0002FFF0
                dc.l    $00050004, $0002FFF0
                dc.l    $10050004, $0002FFF0
                dc.l    $E0050008, $00040000
                dc.l    $F0050008, $00040000
                dc.l    $00050008, $00040000
                dc.l    $10050008, $00040000
;===============================================================================
; Objeto 0x3C - Parede quebrável na Green Hill do Sonic 1 não usado (Left over)
; <<<-
;===============================================================================