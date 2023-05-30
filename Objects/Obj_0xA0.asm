;===============================================================================
; Objeto 0xA0 - Sub-ojeto do objeto 0x9F - Inimigo Sheelcracker na Metropolis.
; ->>>          Concha do inimigo.
;===============================================================================
; Offset_0x0296DE:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x0296EC(PC, D0), D1
                jmp     Offset_0x0296EC(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x0296EC:
                dc.w    Offset_0x0296F2-Offset_0x0296EC
                dc.w    Offset_0x02971E-Offset_0x0296EC
                dc.w    Offset_0x0297E6-Offset_0x0296EC      
;-------------------------------------------------------------------------------
Offset_0x0296F2:
                bsr     Object_Settings                        ; Offset_0x027EA4
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                beq.s   Offset_0x02970A
                move.b  #$04, Obj_Map_Id(A0)                             ; $001A
                addq.w  #$06, Obj_X(A0)                                  ; $0008
                addq.w  #$06, Obj_Y(A0)                                  ; $000C
Offset_0x02970A:
                lsr.w   #$01, D0
                move.b  Offset_0x029716(PC, D0), Obj_Control_Var_02(A0)  ; $002E
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0    
;-------------------------------------------------------------------------------  
Offset_0x029716:
                dc.b    $00, $03, $05, $07, $09, $0B, $0D, $0F             
;-------------------------------------------------------------------------------
Offset_0x02971E:
                move.w  Obj_Timer(A0), A1                                ; $002A
                cmpi.b  #$9F, (A1)
                bne.s   Offset_0x029742
                moveq   #$00, D0
                move.b  Obj_Routine_2(A0), D0                            ; $0025
                move.w  Offset_0x02973A(PC, D0), D1
                jsr     Offset_0x02973A(PC, D1)
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0  
;-------------------------------------------------------------------------------
Offset_0x02973A:
                dc.w    Offset_0x029752-Offset_0x02973A
                dc.w    Offset_0x029790-Offset_0x02973A
                dc.w    Offset_0x0297AA-Offset_0x02973A
                dc.w    Offset_0x0297BE-Offset_0x02973A           
;-------------------------------------------------------------------------------
Offset_0x029742:
                move.b  #$04, Obj_Routine(A0)                            ; $0024
                move.w  #$0100, Obj_Control_Var_02(A0)                   ; $002E
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0   
;-------------------------------------------------------------------------------
Offset_0x029752:
                subq.b  #$01, Obj_Control_Var_02(A0)                     ; $002E
                beq.s   Offset_0x02975C
                bmi.s   Offset_0x02975C
                rts
Offset_0x02975C:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.w  Obj_Control_Var_00(A0), D0                       ; $002C
                cmpi.w  #$000E, D0
                bcc.s   Offset_0x029780
                move.w  #$FC00, Obj_Speed(A0)                            ; $0010
                lsr.w   #$01, D0
                move.b  Offset_0x029788(PC, D0), D1
                move.b  D1, Obj_Control_Var_02(A0)                       ; $002E
                move.b  D1, Obj_Control_Var_03(A0)                       ; $002F
                rts
Offset_0x029780:
                move.w  #$000B, Obj_Control_Var_02(A0)                   ; $002E
                rts     
;-------------------------------------------------------------------------------  
Offset_0x029788:
                dc.b    $0D, $0C, $0A, $08, $06, $04, $02, $00      
;-------------------------------------------------------------------------------
Offset_0x029790:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                subq.b  #$01, Obj_Control_Var_02(A0)                     ; $002E
                beq.s   Offset_0x02979E
                bmi.s   Offset_0x02979E
                rts
Offset_0x02979E:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                move.b  #$08, Obj_Control_Var_02(A0)                     ; $002E
                rts  
;-------------------------------------------------------------------------------
Offset_0x0297AA:
                subq.b  #$01, Obj_Control_Var_02(A0)                     ; $002E
                beq.s   Offset_0x0297B4
                bmi.s   Offset_0x0297B4
                rts
Offset_0x0297B4:
                addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
                neg.w   Obj_Speed(A0)                                    ; $0010
                rts   
;-------------------------------------------------------------------------------
Offset_0x0297BE:
                bsr     Jmp_19_To_SpeedToPos                   ; Offset_0x02A7C4
                subq.b  #$01, Obj_Control_Var_03(A0)                     ; $002F
                beq.s   Offset_0x0297CC
                bmi.s   Offset_0x0297CC
                rts
Offset_0x0297CC:
                tst.w   Obj_Control_Var_00(A0)                           ; $002C
                bne     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                move.w  Obj_Timer(A0), A1                                ; $002A
                move.b  #$00, Obj_Map_Id(A1)                             ; $001A
                st      Obj_Control_Var_00(A1)                           ; $002C
                bra     Jmp_23_To_DeleteObject                 ; Offset_0x02A794  
;-------------------------------------------------------------------------------
Offset_0x0297E6:
                bsr     Jmp_0E_To_ObjectFall                   ; Offset_0x02A7BE
                subi.w  #$0001, Obj_Control_Var_02(A0)                   ; $002E
                bmi     Jmp_23_To_DeleteObject                 ; Offset_0x02A794
                bra     Jmp_26_To_MarkObjGone                  ; Offset_0x02A7A0
;-------------------------------------------------------------------------------                
Load_Sheelcracker_Craw_Obj:                                    ; Offset_0x0297F8
                moveq   #$00, D1
                moveq   #$07, D6
Offset_0x0297FC:
                bsr     Jmp_14_To_SingleObjectLoad_2           ; Offset_0x02A7A6
                bne.s   Offset_0x029840
                move.b  #$A0, Obj_Id(A1)                                 ; $0000
                move.b  #$26, Obj_Subtype(A1)                            ; $0028
                move.b  #$05, Obj_Map_Id(A1)                             ; $001A
                move.b  #$04, Obj_Priority(A1)                           ; $0018
                move.w  A0, Obj_Timer(A1)                                ; $002A
                move.w  D1, Obj_Control_Var_00(A1)                       ; $002C
                move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
                subi.w  #$0014, Obj_X(A1)                                ; $0008
                move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
                subi.w  #$0008, Obj_Y(A1)                                ; $000C
                addq.w  #$02, D1
                dbra    D6, Offset_0x0297FC
Offset_0x029840:
                rts 
;-------------------------------------------------------------------------------  
Offset_0x029842:
                dc.l    Shellcracker_Mappings                  ; Offset_0x029866
                dc.w    $030F
                dc.b    $04, $05, $18, $0A
;-------------------------------------------------------------------------------  
Offset_0x02984C:
                dc.l    Shellcracker_Mappings                  ; Offset_0x029866
                dc.w    $030F
                dc.b    $04, $04, $0C, $9A          
;-------------------------------------------------------------------------------
Shellcracker_Animate_Data:                                     ; Offset_0x029856
                dc.w    Offset_0x02985A-Shellcracker_Animate_Data
                dc.w    Offset_0x029860-Shellcracker_Animate_Data
Offset_0x02985A:
                dc.b    $0E, $00, $01, $02, $FF, $00
Offset_0x029860:
                dc.b    $0E, $00, $02, $01, $FF, $00   
;-------------------------------------------------------------------------------
Shellcracker_Mappings:                                         ; Offset_0x029866
                dc.w    Offset_0x029872-Shellcracker_Mappings
                dc.w    Offset_0x029894-Shellcracker_Mappings
                dc.w    Offset_0x0298B6-Shellcracker_Mappings
                dc.w    Offset_0x0298D8-Shellcracker_Mappings
                dc.w    Offset_0x0298F2-Shellcracker_Mappings
                dc.w    Offset_0x0298FC-Shellcracker_Mappings
Offset_0x029872:
                dc.w    $0004
                dc.l    $EC0A0018, $000CFFE0
                dc.l    $F8040021, $00100008
                dc.l    $F40A0000, $0000FFE8
                dc.l    $F40A0800, $08000000
Offset_0x029894:
                dc.w    $0004
                dc.l    $EC0A0018, $000CFFE0
                dc.l    $F8040021, $00100008
                dc.l    $F4060812, $0809FFF0
                dc.l    $F40A0809, $08040000
Offset_0x0298B6:
                dc.w    $0004
                dc.l    $EC0A0018, $000CFFE0
                dc.l    $F8040021, $00100008
                dc.l    $F40A0009, $0004FFE8
                dc.l    $F4060012, $00090000
Offset_0x0298D8:
                dc.w    $0003
                dc.l    $F8040021, $00100008
                dc.l    $F40A0000, $0000FFE8
                dc.l    $F40A0800, $08000000
Offset_0x0298F2:
                dc.w    $0001
                dc.l    $FC000023, $0011FFFC
Offset_0x0298FC:
                dc.w    $0001
                dc.l    $F40A0018, $000CFFF4   
;===============================================================================
; Objeto 0xA0 - Sub-ojeto do objeto 0x9F - Inimigo Sheelcracker na Metropolis.
; <<<-          Concha do inimigo.
;===============================================================================