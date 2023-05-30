;===============================================================================
; Objeto 0x98 - Armas usadas pelos inimigos. Ex: Coco atirado pelo Coconuts
; ->>>
;===============================================================================
; Offset_0x028CE4:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x028CF2(PC, D0), D1
                jmp     Offset_0x028CF2(PC, D1)        
;-------------------------------------------------------------------------------  
Offset_0x028CF2:
                dc.w    Offset_0x028CF6-Offset_0x028CF2
                dc.w    Offset_0x028CFA-Offset_0x028CF2            
;-------------------------------------------------------------------------------
Offset_0x028CF6:
                bra     Object_Settings                        ; Offset_0x027EA4 
;-------------------------------------------------------------------------------
Offset_0x028CFA:
                tst.b   Obj_Flags(A0)                                    ; $0001
                bpl     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                move.l  Obj_Timer(A0), A1                                ; $002A
                jsr     (A1)
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0 
;-------------------------------------------------------------------------------  
Nebula_Weapon:                                                 ; Offset_0x028D0C
                bchg    #06, Obj_Art_VRAM(A0)                            ; $0002
                bra     Jmp_0E_To_ObjectFall                   ; Offset_0x02A7BE     
;-------------------------------------------------------------------------------
Turtloid_Weapon:                                               ; Offset_0x028D16
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Turtloid_Weapon_Animate_Data), A1     ; Offset_0x02912E
                bra     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC  
;-------------------------------------------------------------------------------   
Coconuts_Weapon:                                               ; Offset_0x028D24
                addi.w  #$0020, Obj_Speed_Y(A0)                          ; $0012
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                rts             
;-------------------------------------------------------------------------------
Clucker_Weapon:                                                ; Offset_0x028D30
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Clucker_Weapon_Animate_Data), A1      ; Offset_0x02A610
                bra     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC    
;-------------------------------------------------------------------------------                
Spiny_Weapon:                                                  ; Offset_0x028D3E
                addi.w  #$0020, Obj_Speed_Y(A0)                          ; $0012
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                lea     (Spiny_Weapon_Animate_Data), A1        ; Offset_0x02A1DE
                bra     Jmp_17_To_AnimateSprite                ; Offset_0x02A7AC  
;-------------------------------------------------------------------------------  
Rexon_Fireball_Map_Ptr:                                        ; Offset_0x028D52
                dc.l    Rexon_Mappings                         ; Offset_0x028C74
                dc.w    $237E
                dc.b    $84, $04, $04, $98
;------------------------------------------------------------------------------- 
Nebula_Bomb_Map_Ptr:                                           ; Offset_0x028D5C
                dc.l    Nebula_Mappings                        ; Offset_0x028E6C
                dc.w    $243C
                dc.b    $84, $04, $08, $8B                          
;-------------------------------------------------------------------------------  
Turtloid_Bullet_Map_Ptr:                                       ; Offset_0x028D66
                dc.l    Turtloid_Mappings                      ; Offset_0x029140
                dc.w    $2500
                dc.b    $84, $04, $04, $98      
;-------------------------------------------------------------------------------
Coconuts_Coconut_Map_Ptr:                                      ; Offset_0x028D70
                dc.l    Coconuts_Mappings                      ; Offset_0x029374
                dc.w    $03EE
                dc.b    $84, $04, $08, $8B  
;-------------------------------------------------------------------------------
Asteron_Spikes_Map_Ptr:                                        ; Offset_0x028D7A
                dc.l    Asteron_Mappings                       ; Offset_0x029FB0
                dc.w    $8368
                dc.b    $84, $05, $04, $98 
;-------------------------------------------------------------------------------
Spiny_Shot_Map_Ptr:                                            ; Offset_0x028D84
                dc.l    Spiny_Mappings                         ; Offset_0x02A1E4
                dc.w    $252D
                dc.b    $84, $05, $04, $98  
;-------------------------------------------------------------------------------
Grabber_Unk_Map_Ptr:                                           ; Offset_0x028D8E
                dc.l    Grabber_Mappings                       ; Offset_0x02A374
                dc.w    $2500
                dc.b    $84, $04, $04, $98  
;-------------------------------------------------------------------------------
Clucker_Bullet_Map_Ptr:                                        ; Offset_0x028D98
                dc.l    Clucker_Mappings                       ; Offset_0x02A61C
                dc.w    $23EE
                dc.b    $84, $05, $04, $98
;===============================================================================
; Objeto 0x98 - Armas usadas pelos inimigos. Ex: Coco atirado pelo Coconuts
; <<<-
;===============================================================================