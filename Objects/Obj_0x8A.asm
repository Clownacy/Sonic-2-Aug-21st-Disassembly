;===============================================================================
; Object 0x8A - Sonic 1 Credits
; ->>>
;===============================================================================
; Offset_0x02A7CC:
                moveq   #$00, D0
                move.b  Obj_Routine(A0), D0                              ; $0024
                move.w  Offset_0x02A7DA(PC, D0), D1
                jmp     Offset_0x02A7DA(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x02A7DA:
                dc.w    Offset_0x02A7DE-Offset_0x02A7DA
                dc.w    Offset_0x02A84C-Offset_0x02A7DA    
;-------------------------------------------------------------------------------  
Offset_0x02A7DE:
                addq.b  #$02, Obj_Routine(A0)                            ; $0024
                move.w  #$0120, Obj_X(A0)                                ; $0008
                move.w  #$00F0, Obj_Sub_Y(A0)                            ; $000A
                move.l  #S1_Credits_Mappings, Obj_Map(A0) ; Offset_0x02A852, $0004
                move.w  #$05A0, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_30_To_ModifySpriteAttr_2P          ; Offset_0x02AEE0
                move.w  ($FFFFFFF4).w, D0
                move.b  D0, Obj_Map_Id(A0)                               ; $001A
                move.b  #$00, Obj_Flags(A0)                              ; $0001
                move.b  #$00, Obj_Priority(A0)                           ; $0018
                cmpi.b  #gm_TitleScreen, (Game_Mode).w          ; $04, $FFFFF600
                bne.s   Offset_0x02A84C
                move.w  #$0300, Obj_Art_VRAM(A0)                         ; $0002
                bsr     Jmp_30_To_ModifySpriteAttr_2P          ; Offset_0x02AEE0
                move.b  #$0A, Obj_Map_Id(A0)                             ; $001A
                tst.b   ($FFFFFFD3).w
                beq.s   Offset_0x02A84C
                cmpi.b  #$72, (Control_Ports_Buffer_Data).w          ; $FFFFF604
                bne.s   Offset_0x02A84C
                move.w  #$0EEE, (Palette_Buffer+$00C0).w             ; $FFFFFBC0
                move.w  #$0880, (Palette_Buffer+$00C2).w             ; $FFFFFBC2
                jmp     (DeleteObject)                         ; Offset_0x00D314 
;-------------------------------------------------------------------------------  
Offset_0x02A84C:
                jmp     (DisplaySprite)                        ; Offset_0x00D322 
;-------------------------------------------------------------------------------    
S1_Credits_Mappings:                                           ; Offset_0x02A852
                dc.w    Offset_0x02A868-S1_Credits_Mappings
                dc.w    Offset_0x02A8DA-S1_Credits_Mappings
                dc.w    Offset_0x02A95C-S1_Credits_Mappings
                dc.w    Offset_0x02A9AE-S1_Credits_Mappings
                dc.w    Offset_0x02AA70-S1_Credits_Mappings
                dc.w    Offset_0x02AB12-S1_Credits_Mappings
                dc.w    Offset_0x02ABE4-S1_Credits_Mappings
                dc.w    Offset_0x02AC9E-S1_Credits_Mappings
                dc.w    Offset_0x02AD98-S1_Credits_Mappings
                dc.w    Offset_0x02AE12-S1_Credits_Mappings
                dc.w    Offset_0x02AE54-S1_Credits_Mappings
Offset_0x02A868:  ; "SONIC TEAM STAFF"
                dc.w    $000E
                dc.l    $F805002E, $0017FF88  ; S
                dc.l    $F8050026, $0013FF98  ; O
                dc.l    $F805001A, $000DFFA8  ; N
                dc.l    $F8010046, $0023FFB8  ; I
                dc.l    $F805001E, $000FFFC0  ; C
                dc.l    $F805003E, $001FFFD8  ; T
                dc.l    $F805000E, $0007FFE8  ; E
                dc.l    $F8050004, $0002FFF8  ; A
                dc.l    $F8090008, $00040008  ; M
                dc.l    $F805002E, $00170028  ; S
                dc.l    $F805003E, $001F0038  ; T
                dc.l    $F8050004, $00020048  ; A
                dc.l    $F805005C, $002E0058  ; F
                dc.l    $F805005C, $002E0068  ; F
Offset_0x02A8DA:  ; "GAME PLAN CAROL YAS"
                dc.w    $0010
                dc.l    $D8050000, $0000FF80
                dc.l    $D8050004, $0002FF90
                dc.l    $D8090008, $0004FFA0
                dc.l    $D805000E, $0007FFB4
                dc.l    $D8050012, $0009FFD0
                dc.l    $D8050016, $000BFFE0
                dc.l    $D8050004, $0002FFF0
                dc.l    $D805001A, $000D0000
                dc.l    $0805001E, $000FFFC8
                dc.l    $08050004, $0002FFD8
                dc.l    $08050022, $0011FFE8
                dc.l    $08050026, $0013FFF8
                dc.l    $08050016, $000B0008
                dc.l    $0805002A, $00150020
                dc.l    $08050004, $00020030
                dc.l    $0805002E, $00170044
Offset_0x02A95C:  ; "PROGRAM YU 2"
                dc.w    $000A
                dc.l    $D8050012, $0009FF80
                dc.l    $D8050022, $0011FF90
                dc.l    $D8050026, $0013FFA0
                dc.l    $D8050000, $0000FFB0
                dc.l    $D8050022, $0011FFC0
                dc.l    $D8050004, $0002FFD0
                dc.l    $D8090008, $0004FFE0
                dc.l    $0805002A, $0015FFE8
                dc.l    $08050032, $0019FFF8
                dc.l    $08050036, $001B0008
Offset_0x02A9AE:  ; "CHARACTER DESIGN BIGISLAND"
                dc.w    $0018
                dc.l    $D805001E, $000FFF88
                dc.l    $D805003A, $001DFF98
                dc.l    $D8050004, $0002FFA8
                dc.l    $D8050022, $0011FFB8
                dc.l    $D8050004, $0002FFC8
                dc.l    $D805001E, $000FFFD8
                dc.l    $D805003E, $001FFFE8
                dc.l    $D805000E, $0007FFF8
                dc.l    $D8050022, $00110008
                dc.l    $D8050042, $00210020
                dc.l    $D805000E, $00070030
                dc.l    $D805002E, $00170040
                dc.l    $D8010046, $00230050
                dc.l    $D8050000, $00000058
                dc.l    $D805001A, $000D0068
                dc.l    $08050048, $0024FFC0
                dc.l    $08010046, $0023FFD0
                dc.l    $08050000, $0000FFD8
                dc.l    $08010046, $0023FFE8
                dc.l    $0805002E, $0017FFF0
                dc.l    $08050016, $000B0000
                dc.l    $08050004, $00020010
                dc.l    $0805001A, $000D0020
                dc.l    $08050042, $00210030
Offset_0x02AA70:  ; "DESIGN JINYA PHENIX RIE"
                dc.w    $0014
                dc.l    $D0050042, $0021FFA0
                dc.l    $D005000E, $0007FFB0
                dc.l    $D005002E, $0017FFC0
                dc.l    $D0010046, $0023FFD0
                dc.l    $D0050000, $0000FFD8
                dc.l    $D005001A, $000DFFE8
                dc.l    $0005004C, $0026FFE8
                dc.l    $00010046, $0023FFF8
                dc.l    $0005001A, $000D0004
                dc.l    $0005002A, $00150014
                dc.l    $00050004, $00020024
                dc.l    $20050012, $0009FFD0
                dc.l    $2005003A, $001DFFE0
                dc.l    $2005000E, $0007FFF0
                dc.l    $2005001A, $000D0000
                dc.l    $20010046, $00230010
                dc.l    $20050050, $00280018
                dc.l    $20050022, $00110030
                dc.l    $20010046, $00230040
                dc.l    $2005000E, $00070048
Offset_0x02AB12:  ; "SOUND PRODUCE MASATO NAKAMURA"
                dc.w    $001A
                dc.l    $D805002E, $0017FF98
                dc.l    $D8050026, $0013FFA8
                dc.l    $D8050032, $0019FFB8
                dc.l    $D805001A, $000DFFC8
                dc.l    $D8050054, $002AFFD8
                dc.l    $D8050012, $0009FFF8
                dc.l    $D8050022, $00110008
                dc.l    $D8050026, $00130018
                dc.l    $D8050042, $00210028
                dc.l    $D8050032, $00190038
                dc.l    $D805001E, $000F0048
                dc.l    $D805000E, $00070058
                dc.l    $08090008, $0004FF88
                dc.l    $08050004, $0002FF9C
                dc.l    $0805002E, $0017FFAC
                dc.l    $08050004, $0002FFBC
                dc.l    $0805003E, $001FFFCC
                dc.l    $08050026, $0013FFDC
                dc.l    $0805001A, $000DFFF8
                dc.l    $08050004, $00020008
                dc.l    $08050058, $002C0018
                dc.l    $08050004, $00020028
                dc.l    $08090008, $00040038
                dc.l    $08050032, $0019004C
                dc.l    $08050022, $0011005C
                dc.l    $08050004, $0002006C
Offset_0x02ABE4:  ; "SOUND PROGRAM JIMITA MACKY"
                dc.w    $0017
                dc.l    $D005002E, $0017FF98
                dc.l    $D0050026, $0013FFA8
                dc.l    $D0050032, $0019FFB8
                dc.l    $D005001A, $000DFFC8
                dc.l    $D0050054, $002AFFD8
                dc.l    $D0050012, $0009FFF8
                dc.l    $D0050022, $00110008
                dc.l    $D0050026, $00130018
                dc.l    $D0050000, $00000028
                dc.l    $D0050022, $00110038
                dc.l    $D0050004, $00020048
                dc.l    $D0090008, $00040058
                dc.l    $0005004C, $0026FFD0
                dc.l    $00010046, $0023FFE0
                dc.l    $00090008, $0004FFE8
                dc.l    $00010046, $0023FFFC
                dc.l    $0005003E, $001F0004
                dc.l    $00050004, $00020014
                dc.l    $20090008, $0004FFD0
                dc.l    $20050004, $0002FFE4
                dc.l    $2005001E, $000FFFF4
                dc.l    $20050058, $002C0004
                dc.l    $2005002A, $00150014
Offset_0x02AC9E:  ; "SPECIAL TANKS FUJIO MINEGISHI PAPA"
                dc.w    $001F
                dc.l    $D805002E, $0017FF80
                dc.l    $D8050012, $0009FF90
                dc.l    $D805000E, $0007FFA0
                dc.l    $D805001E, $000FFFB0
                dc.l    $D8010046, $0023FFC0
                dc.l    $D8050004, $0002FFC8
                dc.l    $D8050016, $000BFFD8
                dc.l    $D805003E, $001FFFF8
                dc.l    $D805003A, $001D0008
                dc.l    $D8050004, $00020018
                dc.l    $D805001A, $000D0028
                dc.l    $D8050058, $002C0038
                dc.l    $D805002E, $00170048
                dc.l    $0005005C, $002EFFB0
                dc.l    $00050032, $0019FFC0
                dc.l    $0005004C, $0026FFD0
                dc.l    $00010046, $0023FFE0
                dc.l    $00050026, $0013FFE8
                dc.l    $00090008, $00040000
                dc.l    $00010046, $00230014
                dc.l    $0005001A, $000D001C
                dc.l    $0005000E, $0007002C
                dc.l    $00050000, $0000003C
                dc.l    $00010046, $0023004C
                dc.l    $0005002E, $00170054
                dc.l    $0005003A, $001D0064
                dc.l    $00010046, $00230074
                dc.l    $20050012, $0009FFF8
                dc.l    $20050004, $00020008
                dc.l    $20050012, $00090018
                dc.l    $20050004, $00020028
Offset_0x02AD98:  ; "PRESENTED BY SEGA"
                dc.w    $000F
                dc.l    $F8050012, $0009FF80
                dc.l    $F8050022, $0011FF90
                dc.l    $F805000E, $0007FFA0
                dc.l    $F805002E, $0017FFB0
                dc.l    $F805000E, $0007FFC0
                dc.l    $F805001A, $000DFFD0
                dc.l    $F805003E, $001FFFE0
                dc.l    $F805000E, $0007FFF0
                dc.l    $F8050042, $00210000
                dc.l    $F8050048, $00240018
                dc.l    $F805002A, $00150028
                dc.l    $F805002E, $00170040
                dc.l    $F805000E, $00070050
                dc.l    $F8050000, $00000060
                dc.l    $F8050004, $00020070
Offset_0x02AE12:  ; "TRY AGAIN"
                dc.w    $0008
                dc.l    $3005003E, $001FFFC0
                dc.l    $30050022, $0011FFD0
                dc.l    $3005002A, $0015FFE0
                dc.l    $30050004, $0002FFF8
                dc.l    $30050000, $00000008
                dc.l    $30050004, $00020018
                dc.l    $30010046, $00230028
                dc.l    $3005001A, $000D0030
Offset_0x02AE54:  ; "SONIC TEAM PRESENTS"
                dc.w    $0011
                dc.l    $E805002E, $0017FFB4
                dc.l    $E8050026, $0013FFC4
                dc.l    $E805001A, $000DFFD4
                dc.l    $E8010046, $0023FFE4
                dc.l    $E805001E, $000FFFEC
                dc.l    $E805003E, $001F0004
                dc.l    $E805000E, $00070014
                dc.l    $E8050004, $00020024
                dc.l    $E8090008, $00040034
                dc.l    $00050012, $0009FFC0
                dc.l    $00050022, $0011FFD0
                dc.l    $0005000E, $0007FFE0
                dc.l    $0005002E, $0017FFF0
                dc.l    $0005000E, $00070000
                dc.l    $0005001A, $000D0010
                dc.l    $0005003E, $001F0020
                dc.l    $0005002E, $00170030
;===============================================================================
; Object 0x8A - Sonic 1 Credits
; <<<-
;===============================================================================