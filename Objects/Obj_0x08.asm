;===============================================================================
; Objeto 0x08 - Poeira do Spindash / freio e Splash de água
; ->>> 
;===============================================================================
; Offset_0x0131B0:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0131BE(PC, D0), D1
                jmp     Offset_0x0131BE(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0131BE:
                dc.w    Offset_0x0131C6-Offset_0x0131BE
                dc.w    Offset_0x013212-Offset_0x0131BE
                dc.w    Offset_0x0132AE-Offset_0x0131BE
                dc.w    Offset_0x0132B2-Offset_0x0131BE     
;-------------------------------------------------------------------------------
Offset_0x0131C6:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.l  #Dust_Water_Splash_Mappings, Obj_Map(A0) ; Offset_0x0133C0, $0004
                ori.b   #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$01, Obj_Priority(A0)                           ; $0018
                move.b  #$10, Obj_Width(A0)                              ; $0019
                move.w  #$049C, Obj_Art_VRAM(A0)                         ; $0002
                move.w  #$B000, Obj_Control_Var_12(A0)                   ; $003E
                move.w  #$9380, Obj_Control_Var_10(A0)                   ; $003C
                cmpa.w  #$B400, A0
                beq.s   Offset_0x01320E
                move.w  #$048C, Obj_Art_VRAM(A0)                         ; $0002
                move.w  #$B040, Obj_Control_Var_12(A0)                   ; $003E
                move.w  #$9180, Obj_Control_Var_10(A0)                   ; $003C
Offset_0x01320E:
                bsr     ModifySpriteAttr_2P                    ; Offset_0x00DBBE  
;-------------------------------------------------------------------------------
Offset_0x013212:
                move.w  Obj_Control_Var_12(A0), A2                       ; $003E
                moveq   #$00, D0
                move.b  Obj_Ani_Number(A0), D0                           ; $001C
                add.w   D0, D0
                move.w  Offset_0x013226(PC, D0), D1
                jmp     Offset_0x013226(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x013226:
                dc.w    Offset_0x013290-Offset_0x013226
                dc.w    Offset_0x01322E-Offset_0x013226
                dc.w    Offset_0x01324E-Offset_0x013226
                dc.w    Offset_0x013288-Offset_0x013226    
;-------------------------------------------------------------------------------
Offset_0x01322E:
                move.w  (Water_Level).w, Obj_Y(A0)                   ; $FFFFF646; $000C
                tst.b   Obj_Ani_Flag(A0)                                 ; $001D
                bne.s   Offset_0x013290
                move.w  Obj_X(A2), Obj_X(A0)                      ; $0008, $0008
                move.b  #$00, Obj_Status(A0)                             ; $0022
                andi.w  #$7FFF, Obj_Art_VRAM(A0)                         ; $0002
                bra.s   Offset_0x013290     
;-------------------------------------------------------------------------------
Offset_0x01324E:
                cmpi.b  #$0C, Obj_Subtype(A2)                            ; $0028
                bcs.s   Offset_0x0132A6
                tst.b   Obj_Ani_Flag(A0)                                 ; $001D
                bne.s   Offset_0x013290
                move.w  Obj_X(A2), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A2), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A2), Obj_Status(A0)            ; $0022, $0022
                tst.b   Obj_Control_Var_13(A0)                           ; $003F
                beq.s   Offset_0x01327A
                subi.w  #$0004, Obj_Y(A0)                                ; $000C
Offset_0x01327A:
                tst.w   Obj_Art_VRAM(A2)                                 ; $0002
                bpl.s   Offset_0x013290
                ori.w   #$8000, Obj_Art_VRAM(A0)                         ; $0002
                bra.s   Offset_0x013290   
;-------------------------------------------------------------------------------
Offset_0x013288:
                cmpi.b  #$0C, Obj_Subtype(A2)                            ; $0028
                bcs.s   Offset_0x0132A6  
;-------------------------------------------------------------------------------
Offset_0x013290:
                lea     (Dust_Water_Splash_AnimateData), A1    ; Offset_0x01339A
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                bsr     Load_Dust_Water_Splash_Dynamic_PLC     ; Offset_0x013346
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x0132A6:
                move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
                rts   
;-------------------------------------------------------------------------------
Offset_0x0132AE:
                bra     DeleteObject                           ; Offset_0x00D314   
;-------------------------------------------------------------------------------
Offset_0x0132B2:
                move.w  Obj_Control_Var_12(A0), A2                       ; $003E
                cmpi.b  #$0D, Obj_Ani_Number(A2)                         ; $001C
                beq.s   Offset_0x0132CC
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Control_Var_06(A0)                     ; $0032
                rts
Offset_0x0132CC:
                subq.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bpl.s   Offset_0x013342
                move.b  #$03, Obj_Control_Var_06(A0)                     ; $0032
                bsr     SingleObjectLoad                       ; Offset_0x00E6FE
                bne.s   Offset_0x013342
                move.b  Obj_Id(A0), Obj_Id(A1)                    ; $0000, $0000
                move.w  Obj_X(A2), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A2), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0010, Obj_Y(A1)                                ; $000C
                tst.b   Obj_Control_Var_13(A0)                           ; $003F
                beq.s   Offset_0x013302
                subi.w  #$0004, Obj_Y(A1)                                ; $000C
Offset_0x013302:
                move.b  #$00, Obj_Status(A1)                             ; $0022
                move.b  #$03, Obj_Ani_Number(A1)                         ; $001C
                addq.b  #$02, Obj_Routine(A1)                            ; $0024
                move.l  Obj_Map(A0), Obj_Map(A1)                  ; $0004, $0004
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  #$01, Obj_Priority(A1)                           ; $0018
                move.b  #$04, Obj_Width(A1)                              ; $0019
                move.w  Obj_Art_VRAM(A0), Obj_Art_VRAM(A1)        ; $0002, $0002
                move.w  Obj_Control_Var_12(A0), Obj_Control_Var_12(A1); $003E, $003E
                tst.w   Obj_Art_VRAM(A2)                                 ; $0002
                beq.s   Offset_0x013342
                ori.w   #$8000, Obj_Art_VRAM(A1)                         ; $0002
Offset_0x013342:
                bsr.s   Load_Dust_Water_Splash_Dynamic_PLC     ; Offset_0x013346
                rts
;-------------------------------------------------------------------------------                
Load_Dust_Water_Splash_Dynamic_PLC:                            ; Offset_0x013346
                moveq   #$00, D0
                move.b  Obj_Map_Id(A0), D0                               ; $001A
                cmp.b   Obj_Control_Var_04(A0), D0                       ; $0030
                beq.s   Offset_0x013398
                move.b  D0, Obj_Control_Var_04(A0)                       ; $0030
                lea     (Dust_Water_Splash_Dyn_Script), A2     ; Offset_0x0134D6
                add.w   D0, D0
                adda.w  $00(A2, D0), A2
                move.w  (A2)+, D5
                subq.w  #$01, D5
                bmi.s   Offset_0x013398
                move.w  Obj_Control_Var_10(A0), D4                       ; $003C
Loop_Load_Water_Splash_Dust:                                   ; Offset_0x01336C
                moveq   #$00, D1
                move.w  (A2)+, D1
                move.w  D1, D3
                lsr.w   #$08, D3
                andi.w  #$00F0, D3
                addi.w  #$0010, D3
                andi.w  #$0FFF, D1
                lsl.l   #$05, D1
                addi.l  #Art_Water_Splash_Dust, D1             ; Offset_0x071FFC
                move.w  D4, D2
                add.w   D3, D4
                add.w   D3, D4
                jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
                dbra    D5, Loop_Load_Water_Splash_Dust        ; Offset_0x01336C
Offset_0x013398:
                rts         
;-------------------------------------------------------------------------------
Dust_Water_Splash_AnimateData:                                 ; Offset_0x01339A
                dc.w    Offset_0x0133A2-Dust_Water_Splash_AnimateData
                dc.w    Offset_0x0133A5-Dust_Water_Splash_AnimateData
                dc.w    Offset_0x0133B1-Dust_Water_Splash_AnimateData
                dc.w    Offset_0x0133BA-Dust_Water_Splash_AnimateData
Offset_0x0133A2:
                dc.b    $1F, $00, $FF
Offset_0x0133A5:
                dc.b    $03, $01, $02, $03, $04, $05, $06, $07
                dc.b    $08, $09, $FD, $00
Offset_0x0133B1:
                dc.b    $01, $0A, $0B, $0C, $0D, $0E, $0F, $10
                dc.b    $FF
Offset_0x0133BA:
                dc.b    $03, $11, $12, $13, $14, $FC       
;-------------------------------------------------------------------------------
Dust_Water_Splash_Mappings:                                    ; Offset_0x0133C0
                dc.w    Offset_0x0133EC-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0133EE-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0133F8-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013402-Dust_Water_Splash_Mappings
                dc.w    Offset_0x01340C-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013416-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013420-Dust_Water_Splash_Mappings
                dc.w    Offset_0x01342A-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013434-Dust_Water_Splash_Mappings
                dc.w    Offset_0x01343E-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013448-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013452-Dust_Water_Splash_Mappings
                dc.w    Offset_0x01345C-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013466-Dust_Water_Splash_Mappings
                dc.w    Offset_0x013478-Dust_Water_Splash_Mappings
                dc.w    Offset_0x01348A-Dust_Water_Splash_Mappings
                dc.w    Offset_0x01349C-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0134AE-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0134B8-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0134C2-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0134CC-Dust_Water_Splash_Mappings
                dc.w    Offset_0x0133EC-Dust_Water_Splash_Mappings
Offset_0x0133EC:
                dc.w    $0000
Offset_0x0133EE:
                dc.w    $0001
                dc.l    $F20D0000, $0000FFF0
Offset_0x0133F8:
                dc.w    $0001
                dc.l    $E20F0000, $0000FFF0
Offset_0x013402:
                dc.w    $0001
                dc.l    $E20F0000, $0000FFF0
Offset_0x01340C:
                dc.w    $0001
                dc.l    $E20F0000, $0000FFF0
Offset_0x013416:
                dc.w    $0001
                dc.l    $E20F0000, $0000FFF0
Offset_0x013420:
                dc.w    $0001
                dc.l    $E20F0000, $0000FFF0
Offset_0x01342A:
                dc.w    $0001
                dc.l    $F20D0000, $0000FFF0
Offset_0x013434:
                dc.w    $0001
                dc.l    $F20D0000, $0000FFF0
Offset_0x01343E:
                dc.w    $0001
                dc.l    $F20D0000, $0000FFF0
Offset_0x013448:
                dc.w    $0001
                dc.l    $040D0000, $0000FFE0
Offset_0x013452:
                dc.w    $0001
                dc.l    $040D0000, $0000FFE0
Offset_0x01345C:
                dc.w    $0001
                dc.l    $040D0000, $0000FFE0
Offset_0x013466:
                dc.w    $0002
                dc.l    $F4010000, $0000FFE8
                dc.l    $040D0002, $0001FFE0
Offset_0x013478:
                dc.w    $0002
                dc.l    $F4050000, $0000FFE8
                dc.l    $040D0004, $0002FFE0
Offset_0x01348A:
                dc.w    $0002
                dc.l    $F4090000, $0000FFE0
                dc.l    $040D0006, $0003FFE0
Offset_0x01349C:
                dc.w    $0002
                dc.l    $F4090000, $0000FFE0
                dc.l    $040D0006, $0003FFE0
Offset_0x0134AE:
                dc.w    $0001
                dc.l    $F8050000, $0000FFF8
Offset_0x0134B8:
                dc.w    $0001
                dc.l    $F8050004, $0002FFF8
Offset_0x0134C2:
                dc.w    $0001
                dc.l    $F8050008, $0004FFF8
Offset_0x0134CC:
                dc.w    $0001
                dc.l    $F805000C, $0006FFF8    
;-------------------------------------------------------------------------------
Dust_Water_Splash_Dyn_Script:                                  ; Offset_0x0134D6
                dc.w    Offset_0x013502-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013504-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013508-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01350C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013510-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013514-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013518-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01351C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013520-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013524-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013528-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01352C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013530-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013534-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01353A-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013540-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x013546-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01354C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01354C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01354C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01354C-Dust_Water_Splash_Dyn_Script
                dc.w    Offset_0x01354E-Dust_Water_Splash_Dyn_Script
Offset_0x013502:
                dc.w    $0000
Offset_0x013504:
                dc.w    $0001
                dc.w    $7000
Offset_0x013508:
                dc.w    $0001
                dc.w    $F008
Offset_0x01350C:
                dc.w    $0001
                dc.w    $F018
Offset_0x013510:
                dc.w    $0001
                dc.w    $F028
Offset_0x013514:
                dc.w    $0001
                dc.w    $F038
Offset_0x013518:
                dc.w    $0001
                dc.w    $F048
Offset_0x01351C:
                dc.w    $0001
                dc.w    $7058
Offset_0x013520:
                dc.w    $0001
                dc.w    $7060
Offset_0x013524:
                dc.w    $0001
                dc.w    $7068
Offset_0x013528:
                dc.w    $0001
                dc.w    $7070
Offset_0x01352C:
                dc.w    $0001
                dc.w    $7078
Offset_0x013530:
                dc.w    $0001
                dc.w    $7080
Offset_0x013534:
                dc.w    $0002
                dc.w    $1088
                dc.w    $708A
Offset_0x01353A:
                dc.w    $0002
                dc.w    $3092
                dc.w    $7096
Offset_0x013540:
                dc.w    $0002
                dc.w    $509E
                dc.w    $70A4
Offset_0x013546:
                dc.w    $0002
                dc.w    $50AC
                dc.w    $70B2
Offset_0x01354C:
                dc.w    $0000
Offset_0x01354E:
                dc.w    $0001
                dc.w    $F0BA
;===============================================================================
; Objeto 0x08 - Poeira do Spindash / freio e Splash de água
; <<<- 
;===============================================================================