;===============================================================================
; Objeto - Partes do chefe da Chemical Plant
; ->>>
;===============================================================================
; Offset_0x022BBC
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x022BCA(PC, D0), D1
                jmp     Offset_0x022BCA(PC, D1)
;------------------------------------------------------------------------------- 
Offset_0x022BCA:
                dc.w    Offset_0x022D16-Offset_0x022BCA
                dc.w    Offset_0x022DE0-Offset_0x022BCA
                dc.w    Offset_0x022F3A-Offset_0x022BCA
                dc.w    Offset_0x023002-Offset_0x022BCA
                dc.w    Offset_0x0235F6-Offset_0x022BCA
                dc.w    Offset_0x022F86-Offset_0x022BCA
                dc.w    Offset_0x02311A-Offset_0x022BCA
                dc.w    Offset_0x022C2A-Offset_0x022BCA
                dc.w    Offset_0x022BDC-Offset_0x022BCA   
;-------------------------------------------------------------------------------
Offset_0x022BDC:
                cmpi.b  #$F9, Obj_Control_Var_04(A0)                     ; $0030
                beq.s   Offset_0x022BFE
                subi.b  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bgt     Jmp_18_To_DisplaySprite                ; Offset_0x023F54
                bsr     Offset_0x023B34
                move.b  #$F9, Obj_Control_Var_04(A0)                     ; $0030
                move.w  #$001E, Obj_Timer(A0)                            ; $002A
Offset_0x022BFE:
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bpl     Jmp_18_To_DisplaySprite                ; Offset_0x023F54
                move.w  Obj_Speed(A0), D0                                ; $0010
                add.w   D0, Obj_X(A0)                                    ; $0008
                move.l  Obj_Y(A0), D3                                    ; $000C
                move.w  Obj_Speed_Y(A0), D0                              ; $0012
                addi.w  #$0038, Obj_Speed_Y(A0)                          ; $0012
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D3, Obj_Y(A0)                                    ; $000C
                bra     Jmp_23_To_MarkObjGone                  ; Offset_0x023F60        
;-------------------------------------------------------------------------------  
Offset_0x022C2A:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x022C60
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.l  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.l  #Offset_0x023C32, A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x022C60:
                moveq   #$22, D3
                move.b  #$78, Obj_Control_Var_04(A0)                     ; $0030
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  D3, Obj_Map_Id(A0)                               ; $001A
                move.b  #$10, Obj_Routine(A0)                            ; $0024
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$08, D0
                asr.w   #$06, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  #$FC80, Obj_Speed_Y(A0)                          ; $0012
                moveq   #$01, D2
                addq.w  #$01, D3
Offset_0x022C9A:
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.b  D3, Obj_Map_Id(A1)                               ; $001A
                move.b  #$10, Obj_Routine(A1)                            ; $0024
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$02, Obj_Priority(A1)                           ; $0018
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$08, D0
                asr.w   #$06, D0
                move.w  D0, Obj_Speed(A1)                                ; $0010
                move.w  #$FC80, Obj_Speed_Y(A1)                          ; $0012
                swap.w  D0
                addi.b  #$1E, D0
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_04(A1)                       ; $0030
                addq.w  #$01, D3
                dbra    D2, Offset_0x022C9A
                rts       
;-------------------------------------------------------------------------------  
Offset_0x022D16:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x022D24(PC, D0), D1
                jmp     Offset_0x022D24(PC, D1)   
;------------------------------------------------------------------------------- 
Offset_0x022D24:
                dc.w    Offset_0x022D28-Offset_0x022D24
                dc.w    Offset_0x022D5C-Offset_0x022D24        
;-------------------------------------------------------------------------------  
Offset_0x022D28:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                btst    #$00, Obj_Control_Var_02(A1)                     ; $002E
                bne.s   Offset_0x022D36
                rts
Offset_0x022D36:
                move.b  #$04, Obj_Control_Var_03(A1)                     ; $002F
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addi.w  #$0018, Obj_Y(A0)                                ; $000C
                move.w  #$000C, Obj_Control_Var_00(A0)                   ; $002C
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.l  A0, A1
                bra.s   Offset_0x022D6A   
;-------------------------------------------------------------------------------  
Offset_0x022D5C:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                beq.s   Offset_0x022D66
                rts
Offset_0x022D66:
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
Offset_0x022D6A:
                subq.w  #$01, Obj_Control_Var_00(A0)                     ; $002C
                blt.s   Offset_0x022DD0
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$05, Obj_Priority(A1)                           ; $0018
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                subi.w  #$000B, D0
                neg.w   D0
                lsl.w   #$03, D0
                move.w  D0, Obj_Control_Var_0C(A1)                       ; $0038
                add.w   D0, Obj_Y(A1)                                    ; $000C
                move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
                cmpi.b  #$02, Obj_Routine_2(A1)                          ; $0025
                beq     Offset_0x022F86
                move.b  #$0A, Obj_Routine(A1)                            ; $0024
                bra     Offset_0x022F86
Offset_0x022DD0:
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.b  #$02, Obj_Routine(A0)                            ; $0024
                bra     Offset_0x022F86     
;-------------------------------------------------------------------------------  
Offset_0x022DE0:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x022DEE(PC, D0), D1
                jmp     Offset_0x022DEE(PC, D1)                     
;------------------------------------------------------------------------------- 
Offset_0x022DEE:
                dc.w    Offset_0x022DF4-Offset_0x022DEE
                dc.w    Offset_0x022E68-Offset_0x022DEE
                dc.w    Offset_0x022ED6-Offset_0x022DEE        
;------------------------------------------------------------------------------- 
Offset_0x022DF4:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x022F86
                move.b  #$0A, Obj_Routine(A0)                            ; $0024
                move.b  #$02, Obj_Routine(A1)                            ; $0024
                move.b  #$02, Obj_Routine_2(A1)                          ; $0025
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.b  #$04, Obj_Control_Var_06(A1)                     ; $0032
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.w  #$0058, D0
                move.b  D0, Obj_Control_Var_05(A1)                       ; $0031
                add.w   D0, Obj_Y(A1)                                    ; $000C
                move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.b  #$12, Obj_Control_Var_04(A1)                     ; $0030
                bra     Offset_0x022F86         
;-------------------------------------------------------------------------------  
Offset_0x022E68:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A2                       ; $0034
                btst    #$07, Obj_Status(A2)                             ; $0022
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                subi.b  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bne.s   Offset_0x022EBA
                move.b  #$12, Obj_Control_Var_04(A0)                     ; $0030
                subi.b  #$08, Obj_Control_Var_05(A0)                     ; $0031
                bgt.s   Offset_0x022EBA
                bmi.s   Offset_0x022EAC
                move.b  #$03, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$0C, Obj_Control_Var_04(A0)                     ; $0030
                bra.s   Offset_0x022EBA
Offset_0x022EAC:
                move.b  #$06, Obj_Control_Var_04(A0)                     ; $0030
                move.b  #$04, Obj_Routine_2(A0)                          ; $0025
                rts
Offset_0x022EBA:
                moveq   #$00, D0
                move.b  Obj_Control_Var_05(A0), D0                       ; $0031
                add.w   D0, Obj_Y(A0)                                    ; $000C
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------  
Offset_0x022ED6:
                subi.b  #$01, Obj_Control_Var_04(A0)                     ; $0030
                beq.s   Offset_0x022EE0
                rts
Offset_0x022EE0:
                subq.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                beq.s   Offset_0x022F26
                cmpi.b  #$01, Obj_Control_Var_06(A0)                     ; $0032
                bne.s   Offset_0x022F0C
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x022F0C
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  Obj_Control_Var_08(A0), A2                       ; $0034
                move.l  Obj_Control_Var_08(A2), Obj_Control_Var_08(A1); $0034, $0034
Offset_0x022F0C:
                move.b  #$02, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$12, Obj_Control_Var_04(A0)                     ; $0030
                move.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$58, Obj_Control_Var_05(A0)                     ; $0031
                rts
Offset_0x022F26:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.b  #$04, Obj_Routine(A1)                            ; $0024
                move.b  #$58, Obj_Control_Var_05(A1)                     ; $0031
                bra     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A               
;-------------------------------------------------------------------------------  
Offset_0x022F3A:
                tst.b   Obj_Control_Var_10(A0)                           ; $003C
                bne.s   Offset_0x022F76
                moveq   #$00, D0
                move.b  Obj_Control_Var_05(A0), D0                       ; $0031
                add.w   Obj_Y(A0), D0                                    ; $000C
                lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
                moveq   #$7F, D1
Offset_0x022F50:
                cmp.w   Obj_Y(A1), D0                                    ; $000C
                beq.s   Offset_0x022F66
                lea     Obj_Size(A1), A1                                 ; $0040
                dbra    D1, Offset_0x022F50
                bra.s   Offset_0x022F86
;-------------------------------------------------------------------------------
Offset_0x022F60:
                st      Obj_Control_Var_10(A0)                           ; $003C
                bra.s   Offset_0x022F86
Offset_0x022F66:
                moveq   #$00, D7
                move.b  #$57, D7
                cmp.b   (A1), D7
                beq.s   Offset_0x022F78
                dbra    D1, Offset_0x022F50
                bra.s   Offset_0x022F86
Offset_0x022F76:
                move.l  A0, A1
Offset_0x022F78:
                bset    #$07, Obj_Status(A1)                             ; $0022
                subi.b  #$08, Obj_Control_Var_05(A0)                     ; $0031
                beq.s   Offset_0x022F60         
;-------------------------------------------------------------------------------  
Offset_0x022F86:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A2                       ; $0034
                btst    #$07, Obj_Status(A2)                             ; $0022
                bne.s   Offset_0x022FD6
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                cmpi.b  #$56, Obj_Id(A1)                                 ; $0000
                bne.s   Offset_0x022FB0
                addi.w  #$0018, Obj_Y(A0)                                ; $000C
Offset_0x022FB0:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x022FD2
                move.w  Obj_Control_Var_0C(A0), D0                       ; $0038
                add.w   D0, Obj_Y(A0)                                    ; $000C
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x022FD2:
                bra     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
Offset_0x022FD6:
                move.b  #$10, Obj_Routine(A0)                            ; $0024
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$08, D0
                asr.w   #$06, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  #$FC80, Obj_Speed_Y(A0)                          ; $0012
                swap.w  D0
                addi.b  #$1E, D0
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_04(A0)                       ; $0030
                bra     Jmp_18_To_DisplaySprite                ; Offset_0x023F54          
;-------------------------------------------------------------------------------  
Offset_0x023002:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x02301A(PC, D0), D1
                jmp     Offset_0x02301A(PC, D1)         
;-------------------------------------------------------------------------------   
Offset_0x02301A:
                dc.w    Offset_0x023020-Offset_0x02301A
                dc.w    Offset_0x023066-Offset_0x02301A
                dc.w    Offset_0x0230B8-Offset_0x02301A      
;------------------------------------------------------------------------------- 
Offset_0x023020:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$57, Obj_Id(A0)                                 ; $0000
                move.l  #Offset_0x023CD2, Obj_Map(A0)                    ; $0004
                move.w  #$6460, Obj_Art_VRAM(A0)                         ; $0002
                move.b  #$04, Obj_Flags(A0)                              ; $0001
                move.b  #$20, Obj_Width(A0)                              ; $0019
                move.b  #$04, Obj_Priority(A0)                           ; $0018
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  #$0F, Obj_Control_Var_04(A0)                     ; $0030
                move.b  #$04, Obj_Ani_Number(A0)                         ; $001C  
;------------------------------------------------------------------------------- 
Offset_0x023066:
                subq.b  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bne.s   Offset_0x02308A
                move.b  #$05, Obj_Ani_Number(A0)                         ; $001C
                move.b  #$04, Obj_Control_Var_04(A0)                     ; $0030
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                subi.w  #$0024, Obj_Y(A0)                                ; $000C
                subi.w  #$0002, Obj_X(A0)                                ; $0008
                rts
Offset_0x02308A:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322  
;------------------------------------------------------------------------------- 
Offset_0x0230B8:
                subq.b  #$01, Obj_Control_Var_04(A0)                     ; $0030
                bne.s   Offset_0x0230DE
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                bset    #$01, Obj_Control_Var_02(A1)                     ; $002E
                addq.b  #$01, Obj_Control_Var_10(A0)                     ; $003C
                cmpi.b  #$0C, Obj_Control_Var_10(A0)                     ; $003C
                bge     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                rts
Offset_0x0230DE:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                subi.w  #$0024, Obj_Y(A0)                                ; $000C
                subi.w  #$0002, Obj_X(A0)                                ; $0008
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x023108
                addi.w  #$0004, Obj_X(A0)                                ; $0008
Offset_0x023108:
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322   
;-------------------------------------------------------------------------------  
Offset_0x02311A:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x023128(PC, D0), D1
                jmp     Offset_0x023128(PC, D1)       
;-------------------------------------------------------------------------------
Offset_0x023128:
                dc.w    Offset_0x023134-Offset_0x023128
                dc.w    Offset_0x0231E4-Offset_0x023128
                dc.w    Offset_0x02358C-Offset_0x023128
                dc.w    Offset_0x023526-Offset_0x023128
                dc.w    Offset_0x0235E2-Offset_0x023128
                dc.w    Offset_0x023270-Offset_0x023128    
;------------------------------------------------------------------------------- 
Offset_0x023134:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                btst    #$07, Obj_Control_Var_02(A1)                     ; $002E
                bne.s   Offset_0x023196
                bset    #$07, Obj_Control_Var_02(A1)                     ; $002E
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x023196
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.b  #$0C, Obj_Routine(A1)                            ; $0024
                move.b  #$04, Obj_Routine_2(A1)                          ; $0025
                move.b  #$09, Obj_Ani_Number(A1)                         ; $001C
Offset_0x023196:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x0231E0
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$6460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.b  #$0C, Obj_Routine(A1)                            ; $0024
                move.b  #$06, Obj_Routine_2(A1)                          ; $0025
Offset_0x0231E0:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025    
;-------------------------------------------------------------------------------  
Offset_0x0231E4:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                subi.w  #$0038, Obj_Y(A0)                                ; $000C
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne.s   Offset_0x023268
                btst    #$02, Obj_Control_Var_02(A1)                     ; $002E
                beq.s   Offset_0x023214
                bsr     Offset_0x023456
                bsr     Offset_0x02337A
                bra.s   Offset_0x023234
Offset_0x023214:
                btst    #$05, Obj_Control_Var_02(A1)                     ; $002E
                beq.s   Offset_0x023234
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                bne.s   Offset_0x023234
                bclr    #$05, Obj_Control_Var_02(A1)                     ; $002E
                bset    #$03, Obj_Control_Var_02(A1)                     ; $002E
                bset    #$04, Obj_Control_Var_02(A1)                     ; $002E
Offset_0x023234:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                move.w  Obj_Control_Var_02(A0), D0                       ; $002E
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x023252
                neg.w   D0
Offset_0x023252:
                add.w   D0, Obj_X(A0)                                    ; $0008
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x023268:
                move.b  #$0A, Obj_Routine_2(A0)                          ; $0025
                bra.s   Offset_0x023234   
;-------------------------------------------------------------------------------  
Offset_0x023270:
                move.l  D7, -(A7)
                move.b  #$1E, Obj_Control_Var_04(A0)                     ; $0030
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                subi.w  #$0038, Obj_Y(A0)                                ; $000C
                move.w  Obj_Control_Var_02(A0), D0                       ; $002E
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x02329C
                neg.w   D0
Offset_0x02329C:
                add.w   D0, Obj_X(A0)                                    ; $0008
                move.b  #$20, Obj_Map_Id(A0)                             ; $001A
                move.b  #$10, Obj_Routine(A0)                            ; $0024
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$08, D0
                asr.w   #$06, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                move.w  #$FC80, Obj_Speed_Y(A0)                          ; $0012
                moveq   #$00, D7
                move.w  Obj_Control_Var_02(A0), D0                       ; $002E
                addi.w  #$0018, D0
                bge.s   Offset_0x0232DE
                addi.w  #$0018, D0
                bge.s   Offset_0x0232DC
                addi.w  #$0018, D0
                bge.s   Offset_0x0232DA
                addq.w  #$01, D7
Offset_0x0232DA:
                addq.w  #$01, D7
Offset_0x0232DC:
                addq.w  #$01, D7
Offset_0x0232DE:
                subq.w  #$01, D7
                bmi     Offset_0x02336E
Offset_0x0232E4:
                jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.b  #$21, Obj_Map_Id(A1)                             ; $001A
                move.b  #$10, Obj_Routine(A1)                            ; $0024
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$02, Obj_Priority(A1)                           ; $0018
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                addi.w  #$0008, Obj_Y(A1)                                ; $000C
                move.w  D7, D2
                add.w   D2, D2
                move.w  Offset_0x023374(PC, D2), D3
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x023344
                neg.w   D3
Offset_0x023344:
                add.w   D3, Obj_X(A1)                                    ; $0008
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$08, D0
                asr.w   #$06, D0
                move.w  D0, Obj_Speed(A1)                                ; $0010
                move.w  #$FC80, Obj_Speed_Y(A1)                          ; $0012
                swap.w  D0
                addi.b  #$1E, D0
                andi.w  #$007F, D0
                move.b  D0, Obj_Control_Var_04(A1)                       ; $0030
                dbra    D7, Offset_0x0232E4
Offset_0x02336E:
                move.l  (A7)+, D7
                bra     Jmp_18_To_DisplaySprite                ; Offset_0x023F54  
;-------------------------------------------------------------------------------  
Offset_0x023374:
                dc.w    $0018, $0030, $0048                           
;-------------------------------------------------------------------------------  
Offset_0x02337A:
                btst    #$03, Obj_Control_Var_02(A1)                     ; $002E
                bne     Offset_0x023454
                btst    #$04, Obj_Control_Var_02(A1)                     ; $002E
                bne     Offset_0x023454
                cmpi.w  #$FFEC, Obj_Control_Var_02(A0)                   ; $002E
                blt.s   Offset_0x0233AE
                btst    #$01, Obj_Control_Var_01(A1)                     ; $002D
                beq     Offset_0x023454
                bclr    #$01, Obj_Control_Var_01(A1)                     ; $002D
                bset    #$02, Obj_Control_Var_01(A1)                     ; $002D
                bra.s   Offset_0x0233EC
Offset_0x0233AE:
                cmpi.w  #$FFC0, Obj_Control_Var_02(A0)                   ; $002E
                bge     Offset_0x023454
                move.w  (Player_One_Position_X).w, D1                ; $FFFFB008
                subi.w  #$0008, D1
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x0233DC
                add.w   Obj_Control_Var_02(A0), D1                       ; $002E
                sub.w   Obj_X(A0), D1                                    ; $0008
                bgt     Offset_0x023454
                cmpi.w  #$FFE8, D1
                bge.s   Offset_0x0233EC
                rts
Offset_0x0233DC:
                sub.w   Obj_Control_Var_02(A0), D1                       ; $002E
                sub.w   Obj_X(A0), D1                                    ; $0008
                blt.s   Offset_0x023454
                cmpi.w  #$0018, D1
                bgt.s   Offset_0x023454
Offset_0x0233EC:
                bset    #$05, Obj_Control_Var_02(A1)                     ; $002E
                bclr    #$02, Obj_Control_Var_02(A1)                     ; $002E
                move.w  #$0012, Obj_Timer(A0)                            ; $002A
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x023454
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.b  #$0C, Obj_Routine(A1)                            ; $0024
                move.b  #$08, Obj_Routine_2(A1)                          ; $0025
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$05, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$0B, Obj_Ani_Number(A1)                         ; $001C
                move.w  #$0024, Obj_Timer(A1)                            ; $002A
Offset_0x023454:
                rts
Offset_0x023456:
                moveq   #$01, D0
                btst    #$04, Obj_Control_Var_02(A1)                     ; $002E
                bne.s   Offset_0x023462
                moveq   #-$01, D0
Offset_0x023462:
                cmpi.w  #$FFF0, Obj_Control_Var_02(A0)                   ; $002E
                bne.s   Offset_0x0234D4
                bclr    #$04, Obj_Control_Var_02(A1)                     ; $002E
                beq.s   Offset_0x0234D4
                bclr    #$02, Obj_Control_Var_02(A1)                     ; $002E
                clr.b   Obj_Routine_2(A0)                                ; $0025
                move.l  A1, A2
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne.s   Offset_0x0234D2
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                subq.b  #$01, Obj_Control_Var_03(A2)                     ; $002F
                bne.s   Offset_0x0234C6
                move.l  Obj_Control_Var_08(A0), Obj_Control_Var_08(A1); $0034, $0034
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                bra.s   Offset_0x0234D2
Offset_0x0234C6:
                move.b  #$06, Obj_Routine(A1)                            ; $0024
                move.l  Obj_Control_Var_08(A0), Obj_Control_Var_08(A1); $0034, $0034
Offset_0x0234D2:
                rts
Offset_0x0234D4:
                move.w  Obj_Control_Var_02(A0), D1                       ; $002E
                cmpi.w  #$FFD8, D1
                bge.s   Offset_0x02351E
                cmpi.w  #$FFC0, D1
                bge.s   Offset_0x023516
                move.b  #$08, Obj_Ani_Number(A0)                         ; $001C
                cmpi.w  #$FFA8, D1
                blt.s   Offset_0x023500
                bgt.s   Offset_0x0234FA
                btst    #$04, Obj_Control_Var_02(A1)                     ; $002E
                beq.s   Offset_0x0234FE
Offset_0x0234FA:
                add.w   D0, Obj_Control_Var_02(A0)                       ; $002E
Offset_0x0234FE:
                rts
Offset_0x023500:
                move.w  #$FFA8, Obj_Control_Var_02(A0)                   ; $002E
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x0234FA
                move.w  #$0058, Obj_Control_Var_02(A0)                   ; $002E
                bra.s   Offset_0x0234FA
Offset_0x023516:
                move.b  #$07, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x0234FA
Offset_0x02351E:
                move.b  #$06, Obj_Ani_Number(A0)                         ; $001C
                bra.s   Offset_0x0234FA                   
;-------------------------------------------------------------------------------  
Offset_0x023526:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), D0                       ; $0034
                beq     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                move.l  D0, A1
                bclr    #$03, Obj_Control_Var_02(A1)                     ; $002E
                beq.s   Offset_0x023554
                move.b  #$08, Obj_Routine(A0)                            ; $0024
                move.b  #$00, Obj_Routine_2(A0)                          ; $0025
                bra.s   Offset_0x0235B4
Offset_0x023554:
                bclr    #$01, Obj_Control_Var_02(A1)                     ; $002E
                bne.s   Offset_0x023564
                tst.b   Obj_Ani_Number(A0)                               ; $001C
                bne.s   Offset_0x0235B4
                rts
Offset_0x023564:
                tst.b   Obj_Ani_Number(A0)                               ; $001C
                bne.s   Offset_0x023570
                move.b  #$0B, Obj_Ani_Number(A0)                         ; $001C
Offset_0x023570:
                addi.b  #$01, Obj_Ani_Number(A0)                         ; $001C
                cmpi.b  #$17, Obj_Ani_Number(A0)                         ; $001C
                blt.s   Offset_0x0235B4
                bclr    #$00, Obj_Control_Var_02(A1)                     ; $002E
                bset    #$02, Obj_Control_Var_02(A1)                     ; $002E
                bra.s   Offset_0x0235B4           
;-------------------------------------------------------------------------------  
Offset_0x02358C:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A1                       ; $0034
                btst    #$05, Obj_Control_Var_02(A1)                     ; $002E
                beq.s   Offset_0x0235B4
                cmpi.b  #$09, Obj_Ani_Number(A0)                         ; $001C
                bne.s   Offset_0x0235B4
                move.b  #$0A, Obj_Ani_Number(A0)                         ; $001C
Offset_0x0235B4:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                move.b  Obj_Flags(A1), Obj_Flags(A0)              ; $0001, $0001
                move.b  Obj_Status(A1), Obj_Status(A0)            ; $0022, $0022
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
;-------------------------------------------------------------------------------  
Offset_0x0235E2:
                btst    #$07, Obj_Status(A0)                             ; $0022
                bne     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                subq.w  #$01, Obj_Timer(A0)                              ; $002A
                beq     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A
                bra.s   Offset_0x0235B4          
;-------------------------------------------------------------------------------  
Offset_0x0235F6:
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x023604(PC, D0), D1
                jmp     Offset_0x023604(PC, D1)     
;-------------------------------------------------------------------------------
Offset_0x023604:
                dc.w    Offset_0x02360E-Offset_0x023604
                dc.w    Offset_0x023646-Offset_0x023604
                dc.w    Offset_0x023744-Offset_0x023604
                dc.w    Offset_0x0236BA-Offset_0x023604
                dc.w    Offset_0x023704-Offset_0x023604    
;-------------------------------------------------------------------------------  
Offset_0x02360E:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$20, Obj_Height_2(A0)                           ; $0016
                move.b  #$19, Obj_Ani_Number(A0)                         ; $001C
                move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A1                       ; $0034
                btst    #$02, Obj_Control_Var_01(A1)                     ; $002D
                beq.s   Offset_0x023646
                bclr    #$02, Obj_Control_Var_01(A1)                     ; $002D
                move.b  #$06, Obj_Routine_2(A0)                          ; $0025
                move.w  #$0009, Obj_Timer(A0)                            ; $002A    
;-------------------------------------------------------------------------------  
Offset_0x023646:
                bsr     Jmp_0A_To_ObjectFall                   ; Offset_0x023F6C
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bmi.s   Offset_0x02366E
                cmpi.w  #$0600, Obj_Y(A0)                                ; $000C
                bge.s   Offset_0x02369C
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x02366E:
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A1                       ; $0034
                bset    #$02, Obj_Control_Var_02(A1)                     ; $002E
                bset    #$04, Obj_Control_Var_02(A1)                     ; $002E
                move.b  #$02, Obj_Routine_2(A1)                          ; $0025
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$00, Obj_Subtype(A0)                            ; $0028
                jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x02369C:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A1                       ; $0034
                bset    #$02, Obj_Control_Var_02(A1)                     ; $002E
                bset    #$04, Obj_Control_Var_02(A1)                     ; $002E
                move.b  #$02, Obj_Routine_2(A1)                          ; $0025
                bra     Jmp_1C_To_DeleteObject                 ; Offset_0x023F5A                    
;-------------------------------------------------------------------------------  
Offset_0x0236BA:
                subi.w  #$0001, Obj_Timer(A0)                            ; $002A
                bpl.s   Offset_0x0236EE
                move.b  #$02, Obj_Priority(A0)                           ; $0018
                move.b  #$25, Obj_Map_Id(A0)                             ; $001A
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$08, Obj_Ani_Time(A0)                           ; $001E
                bra.s   Offset_0x023704
Offset_0x0236EE:
                bsr     Jmp_15_To_SpeedToPos                   ; Offset_0x023F72
                lea     (Offset_0x023C32), A1
                jsr     (AnimateSprite)                        ; Offset_0x00D372
                jmp     (DisplaySprite)                        ; Offset_0x00D322     
;-------------------------------------------------------------------------------  
Offset_0x023704:
                subi.b  #$01, Obj_Ani_Time(A0)                           ; $001E
                bpl.s   Offset_0x02372A
                addi.b  #$01, Obj_Map_Id(A0)                             ; $001A
                move.b  #$08, Obj_Ani_Time(A0)                           ; $001E
                cmpi.b  #$27, Obj_Map_Id(A0)                             ; $001A
                bgt     Offset_0x02369C
                blt.s   Offset_0x02372A
                addi.b  #$0C, Obj_Ani_Time(A0)                           ; $001E     
Offset_0x02372A:
                move.l  Obj_Control_Var_08(A0), A1                       ; $0034
                move.l  Obj_Control_Var_08(A1), A1                       ; $0034
                move.w  Obj_X(A1), Obj_X(A0)                      ; $0008, $0008
                move.w  Obj_Y(A1), Obj_Y(A0)                      ; $000C, $000C
                jmp     (DisplaySprite)                        ; Offset_0x00D322 
;-------------------------------------------------------------------------------  
Offset_0x023744:
                moveq   #$00, D0
                move.b  Obj_Subtype(A0), D0                              ; $0028
                bne     Offset_0x023836
                addi.w  #$0018, Obj_Y(A0)                                ; $000C
                addi.w  #$000C, Obj_X(A0)                                ; $0008
                btst    #$00, Obj_Flags(A0)                              ; $0001
                beq.s   Offset_0x023768
                subi.w  #$0018, Obj_X(A0)                                ; $0008
Offset_0x023768:
                move.b  #$04, Obj_Height_2(A0)                           ; $0016
                move.b  #$04, Obj_Width_2(A0)                            ; $0017
                addq.b  #$01, Obj_Subtype(A0)                            ; $0028
                move.b  #$09, Obj_Map_Id(A0)                             ; $001A
                move.b  Obj_Speed_Y(A0), D0                              ; $0012
                lsr.b   #$01, D0
                move.b  D0, Obj_Speed_Y(A0)                              ; $0012
                neg.w   Obj_Speed_Y(A0)                                  ; $0012
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$06, D0
                bmi.s   Offset_0x02379A
                addi.w  #$0200, D0
Offset_0x02379A:
                addi.w  #$FF00, D0
                move.w  D0, Obj_Speed(A0)                                ; $0010
                moveq   #$01, D3
Offset_0x0237A4:
                jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
                bne     Offset_0x023832
                move.b  #$57, Obj_Id(A1)                                 ; $0000
                move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
                move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
                move.w  #$6460, Obj_Art_VRAM(A1)                         ; $0002
                move.b  #$04, Obj_Flags(A1)                              ; $0001
                move.b  #$20, Obj_Width(A1)                              ; $0019
                move.b  #$02, Obj_Priority(A1)                           ; $0018
                move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                move.b  #$04, Obj_Height_2(A1)                           ; $0016
                move.b  #$04, Obj_Width_2(A1)                            ; $0017
                move.b  #$09, Obj_Map_Id(A1)                             ; $001A
                move.b  #$08, Obj_Routine(A1)                            ; $0024
                move.b  #$04, Obj_Routine_2(A1)                          ; $0025
                move.b  #$01, Obj_Subtype(A1)                            ; $0028
                move.w  Obj_Speed_Y(A0), Obj_Speed_Y(A1)          ; $0012, $0012
                jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
                asr.w   #$06, D0
                bmi.s   Offset_0x02381C
                addi.w  #$0200, D0
Offset_0x02381C:
                addi.w  #$FF00, D0
                move.w  D0, Obj_Speed(A1)                                ; $0010
                swap.w  D0
                andi.w  #$0300, D0
                add.w   D0, Obj_Speed_Y(A1)                              ; $0012
                dbra    D3, Offset_0x0237A4
Offset_0x023832:
                bra     Jmp_18_To_DisplaySprite                ; Offset_0x023F54
Offset_0x023836:
                bsr     Jmp_0A_To_ObjectFall                   ; Offset_0x023F6C
                jsr     (ObjHitFloor)                          ; Offset_0x014204
                tst.w   D1
                bmi.s   Offset_0x023848
                bra     Jmp_23_To_MarkObjGone                  ; Offset_0x023F60
Offset_0x023848:
                add.w   D1, Obj_Y(A0)                                    ; $000C
                move.b  Obj_Speed_Y(A0), D0                              ; $0012
                lsr.b   #$01, D0
                move.b  D0, Obj_Speed_Y(A0)                              ; $0012
                neg.w   Obj_Speed_Y(A0)                                  ; $0012
                bra     Jmp_18_To_DisplaySprite                ; Offset_0x023F54   
;===============================================================================
; Objeto - Partes do chefe da Chemical Plant
; <<<-
;===============================================================================