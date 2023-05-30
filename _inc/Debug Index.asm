Debug_Mode_Index:                                        ; Offset_0x02E0B2
                dc.w    GHz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E0E6
                dc.w    Lvl1_Debug_Object_List-Debug_Mode_Index ; Offset_0x02E0D4
                dc.w    Wz_Debug_Object_List-Debug_Mode_Index   ; Offset_0x02E0D4
                dc.w    Lvl3_Debug_Object_List-Debug_Mode_Index ; Offset_0x02E0D4
                dc.w    Mz_Debug_Object_List-Debug_Mode_Index   ; Offset_0x02E1C0
                dc.w    Mz_Debug_Object_List-Debug_Mode_Index   ; Offset_0x02E1C0
                dc.w    Lvl6_Debug_Object_List-Debug_Mode_Index ; Offset_0x02E0D4
                dc.w    HTz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E2BA
                dc.w    HPz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E3A4
                dc.w    Lvl9_Debug_Object_List-Debug_Mode_Index ; Offset_0x02E0D4
                dc.w    OOz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E3EE
                dc.w    DHz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E4A0
                dc.w    CNz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E552
                dc.w    CPz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E574
                dc.w    GCz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E0D4
                dc.w    NGHz_Debug_Object_List-Debug_Mode_Index ; Offset_0x02E626
                dc.w    DEz_Debug_Object_List-Debug_Mode_Index  ; Offset_0x02E0D4
;-------------------------------------------------------------------------------
Lvl1_Debug_Object_List:                                        ; Offset_0x02E0D4
Wz_Debug_Object_List:                                          ; Offset_0x02E0D4
Lvl3_Debug_Object_List:                                        ; Offset_0x02E0D4
Lvl6_Debug_Object_List:                                        ; Offset_0x02E0D4
Lvl9_Debug_Object_List                                         ; Offset_0x02E0D4
GCz_Debug_Object_List:                                         ; Offset_0x02E0D4
DEz_Debug_Object_List:                                         ; Offset_0x02E0D4
DOL_00: ; DOL - Debug Object List
                dc.w    ((DOL_00_End-DOL_00-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
DOL_00_End:
;-------------------------------------------------------------------------------
GHz_Debug_Object_List:                                         ; Offset_0x02E0E6
DOL_01: ; DOL - Debug Object List
                dc.w    ((DOL_01_End-DOL_01-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($79<<$18)|Lamp_Post_Mappings          ; Offset_0x0146FA
                dc.b    $01, $00
                dc.w    $047C
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $09, $01
                dc.w    $26BC
                dc.l    ($49<<$18)|Waterfall_Mappings          ; Offset_0x015D40
                dc.b    $00, $00
                dc.w    $239E
                dc.l    ($49<<$18)|Waterfall_Mappings          ; Offset_0x015D40
                dc.b    $02, $03
                dc.w    $239E
                dc.l    ($49<<$18)|Waterfall_Mappings          ; Offset_0x015D40
                dc.b    $04, $05
                dc.w    $239E
                dc.l    ($18<<$18)|GHz_HTz_Platforms_Mappings  ; Offset_0x00952A
                dc.b    $01, $00
                dc.w    $4000
                dc.l    ($18<<$18)|GHz_HTz_Platforms_Mappings  ; Offset_0x00952A
                dc.b    $9A, $01
                dc.w    $4000
                dc.l    ($36<<$18)|Spikes_Mappings             ; Offset_0x00CA74
                dc.b    $00, $00
                dc.w    $2434
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $81, $00
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $90, $03
                dc.w    $0470
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $A0, $06
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $30, $07
                dc.w    $043C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $40, $0A
                dc.w    $043C
                dc.l    ($4B<<$18)|Buzzer_Mappings             ; Offset_0x0241EA
                dc.b    $00, $00
                dc.w    $03D2
                dc.l    ($5C<<$18)|Masher_Mappings             ; Offset_0x024342
                dc.b    $00, $00
                dc.w    $0414
                dc.l    ($9D<<$18)|Coconuts_Mappings           ; Offset_0x029374
                dc.b    $1E, $00
                dc.w    $03EE
DOL_01_End:
; Offset_0x02E178: 
                dc.l    ($4F<<$18)|Dinobot_Mappings            ; Offset_0x021AD2
                dc.b    $00, $00
                dc.w    $0500                               
                dc.l    ($52<<$18)|Piranha_Mappings            ; Offset_0x0200B2
                dc.b    $00, $00
                dc.w    $2530
                dc.l    ($50<<$18)|Aquis_Mappings              ; Offset_0x02227C
                dc.b    $00, $00
                dc.w    $2570
                dc.l    ($51<<$18)|Aquis_Mappings              ; Offset_0x02227C
                dc.b    $00, $00
                dc.w    $2570                   
                dc.l    ($4D<<$18)|Rhinobot_Mappings           ; Offset_0x022A56
                dc.b    $00, $00
                dc.w    $23C4  
                dc.l    ($4B<<$18)|Buzzer_Mappings             ; Offset_0x0241EA
                dc.b    $00, $00
                dc.w    $032C
                dc.l    ($4E<<$18)|Crocobot_Mappings           ; Offset_0x021290
                dc.b    $00, $00
                dc.w    $2300
                dc.l    ($4C<<$18)|Batbot_Mappings             ; Offset_0x01FCB6
                dc.b    $00, $00
                dc.w    $2350                         
                dc.l    ($4A<<$18)|Octus_Mappings              ; Offset_0x021908
                dc.b    $00, $00
                dc.w    $238A
;-------------------------------------------------------------------------------
Mz_Debug_Object_List:                                          ; Offset_0x02E1C0
DOL_02: ; DOL - Debug Object List
                dc.w    ((DOL_02_End-DOL_02-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($79<<$18)|Lamp_Post_Mappings          ; Offset_0x0146FA
                dc.b    $01, $00
                dc.w    $047C
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $09, $01
                dc.w    $26BC
                dc.l    ($42<<$18)|Steam_Vent_Mappings         ; Offset_0x01B61E
                dc.b    $01, $07
                dc.w    $6000
                dc.l    ($64<<$18)|Pistons_Mappings            ; Offset_0x01B810
                dc.b    $01, $00
                dc.w    $2000
                dc.l    ($64<<$18)|Pistons_Mappings            ; Offset_0x01B810
                dc.b    $11, $01
                dc.w    $2000
                dc.l    ($65<<$18)|Mz_Platform_Mappings        ; Offset_0x01BC64
                dc.b    $80, $00
                dc.w    $6000
                dc.l    ($65<<$18)|Mz_Platform_Mappings        ; Offset_0x01BC64
                dc.b    $13, $01
                dc.w    $6000
                dc.l    ($47<<$18)|Switch_Mappings             ; Offset_0x019BBE
                dc.b    $00, $02
                dc.w    $0424
                dc.l    ($2D<<$18)|Automatic_Door_Mappings     ; Offset_0x00A386
                dc.b    $01, $01
                dc.w    $6000
                dc.l    ($66<<$18)|Springs_Wall_Mappings       ; Offset_0x01BEBC
                dc.b    $01, $00
                dc.w    $8680
                dc.l    ($66<<$18)|Springs_Wall_Mappings       ; Offset_0x01BEBC
                dc.b    $11, $01
                dc.w    $8680
                dc.l    ($68<<$18)|Block_Harpon_Mappings       ; Offset_0x01C4F0
                dc.b    $00, $04
                dc.w    $6414
                dc.l    ($69<<$18)|Screw_Nut_Mappings          ; Offset_0x01C7C6
                dc.b    $04, $00
                dc.w    $2500
                dc.l    ($6A<<$18)|Mz_Platform_Mappings        ; Offset_0x01BC64
                dc.b    $00, $01
                dc.w    $6000
                dc.l    ($6B<<$18)|Mz_Platform_Mappings        ; Offset_0x01BC64
                dc.b    $07, $01
                dc.w    $6000
                dc.l    ($6D<<$18)|Block_Harpon_Mappings       ; Offset_0x01C4F0
                dc.b    $00, $00
                dc.w    $241C
                dc.l    ($6E<<$18)|Machine_Mappings            ; Offset_0x01D2C0
                dc.b    $00, $00
                dc.w    $6000
                dc.l    ($6E<<$18)|Machine_Mappings            ; Offset_0x01D2C0
                dc.b    $10, $01
                dc.w    $6000
                dc.l    ($6E<<$18)|Machine_Mappings            ; Offset_0x01D2C0
                dc.b    $20, $02
                dc.w    $6000
                dc.l    ($6F<<$18)|Parallelogram_Elevator_Mappings; Offset_0x01D61A
                dc.b    $00, $00
                dc.w    $653F
                dc.l    ($70<<$18)|Rotating_Gears_Mappings     ; Offset_0x01D872
                dc.b    $10, $00
                dc.w    $E378
                dc.l    ($71<<$18)|Mz_Lava_Bubble_Mappings     ; Offset_0x00A10A
                dc.b    $22, $05
                dc.w    $4536
                dc.l    ($1C<<$18)|Mz_Misc_Mappings            ; Offset_0x00A0E6
                dc.b    $00, $00
                dc.w    $43FD
                dc.l    ($1C<<$18)|Mz_Misc_Mappings            ; Offset_0x00A0E6
                dc.b    $01, $01
                dc.w    $43FD
                dc.l    ($1C<<$18)|Mz_Misc_Mappings            ; Offset_0x00A0E6
                dc.b    $03, $02
                dc.w    $23FD
                dc.l    ($65<<$18)|Mz_Platform_Mappings        ; Offset_0x01BC64
                dc.b    $B0, $00
                dc.w    $6000
                dc.l    ($9F<<$18)|Shellcracker_Mappings       ; Offset_0x029866
                dc.b    $24, $00
                dc.w    $030F
                dc.l    ($A4<<$18)|Asteron_Mappings            ; Offset_0x029FB0
                dc.b    $2E, $00
                dc.w    $8368
                dc.l    ($A1<<$18)|Slicer_Mappings             ; Offset_0x029AD8
                dc.b    $28, $00
                dc.w    $243C
DOL_02_End:
;-------------------------------------------------------------------------------
HTz_Debug_Object_List:                                         ; Offset_0x02E2BA
DOL_03: ; DOL - Debug Object List
                dc.w    ((DOL_03_End-DOL_03-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($79<<$18)|Lamp_Post_Mappings          ; Offset_0x0146FA
                dc.b    $01, $00
                dc.w    $047C
                dc.l    ($84<<$18)|Auto_Spin_Attributes_Mappings; Offset_0x016324
                dc.b    $00, $00
                dc.w    $0680
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $09, $01
                dc.w    $26BC
                dc.l    ($18<<$18)|GHz_HTz_Platforms_Mappings  ; Offset_0x00952A
                dc.b    $01, $00
                dc.w    $4000
                dc.l    ($18<<$18)|GHz_HTz_Platforms_Mappings  ; Offset_0x00952A
                dc.b    $9A, $01
                dc.w    $4000
                dc.l    ($36<<$18)|Spikes_Mappings             ; Offset_0x00CA74
                dc.b    $00, $00
                dc.w    $2434
                dc.l    ($14<<$18)|Seesaw_Mappings             ; Offset_0x016BD0
                dc.b    $00, $00
                dc.w    $03C6
                dc.l    ($2D<<$18)|Automatic_Door_Mappings     ; Offset_0x00A386
                dc.b    $00, $00
                dc.w    $2426
                dc.l    ($2F<<$18)|Breakable_Floor_Mappings    ; Offset_0x01852A
                dc.b    $00, $00
                dc.w    $C000
                dc.l    ($20<<$18)|Lava_Bubble_Mappings        ; Offset_0x018090
                dc.b    $44, $02
                dc.w    $8416
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $81, $00
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $90, $03
                dc.w    $0470
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $A0, $06
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $30, $07
                dc.w    $043C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $40, $0A
                dc.w    $043C
                dc.l    ($16<<$18)|Teleferics_Mappings         ; Offset_0x016DB2
                dc.b    $00, $00
                dc.w    $43E6
                dc.l    ($1C<<$18)|Teleferics_Mappings         ; Offset_0x016DB2
                dc.b    $04, $03
                dc.w    $43E6
                dc.l    ($1C<<$18)|Teleferics_Mappings         ; Offset_0x016DB2
                dc.b    $05, $04
                dc.w    $43E6
                dc.l    ($1C<<$18)|HTz_Misc_Mappings           ; Offset_0x00A086
                dc.b    $07, $00
                dc.w    $4000
                dc.l    ($1C<<$18)|HTz_Misc_Mappings           ; Offset_0x00A086
                dc.b    $08, $01
                dc.w    $4000
                dc.l    ($32<<$18)|HTz_Rock_Mappings           ; Offset_0x018682
                dc.b    $00, $00
                dc.w    $43B2
                dc.l    ($31<<$18)|Lava_Attributes_Mappings    ; Offset_0x015F4E
                dc.b    $00, $00
                dc.w    $8680
                dc.l    ($31<<$18)|Lava_Attributes_Mappings    ; Offset_0x015F4E
                dc.b    $01, $01
                dc.w    $8680
                dc.l    ($31<<$18)|Lava_Attributes_Mappings    ; Offset_0x015F4E
                dc.b    $02, $02
                dc.w    $8680
                dc.l    ($96<<$18)|Rexon_Mappings              ; Offset_0x028C74
                dc.b    $0E, $02
                dc.w    $637E
                dc.l    ($92<<$18)|Spiker_Mappings             ; Offset_0x02868E
                dc.b    $0A, $00
                dc.w    $0000
                dc.l    ($95<<$18)|Sol_Mappings                ; Offset_0x0288E2
                dc.b    $00, $00
                dc.w    $0000
DOL_03_End:
;-------------------------------------------------------------------------------
HPz_Debug_Object_List:                                         ; Offset_0x02E3A4
DOL_04: ; DOL - Debug Object List
                dc.w    ((DOL_04_End-DOL_04-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($71<<$18)|Hpz_Orbs_Mappings           ; Offset_0x00A046
                dc.b    $11, $03
                dc.w    $E35A
                dc.l    ($13<<$18)|HPz_Waterfalls_Mappings     ; Offset_0x015624
                dc.b    $04, $04
                dc.w    $E315
                dc.l    ($1A<<$18)|HPz_Collapsing_Platforms_Mappings; Offset_0x009D3C
                dc.b    $00, $00
                dc.w    $434A
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $09, $01
                dc.w    $26BC
                dc.l    ($4F<<$18)|Dinobot_Mappings            ; Offset_0x021AD2
                dc.b    $00, $00
                dc.w    $0500
                dc.l    ($4C<<$18)|Batbot_Mappings             ; Offset_0x01FCB6
                dc.b    $00, $00
                dc.w    $2530
                dc.l    ($4D<<$18)|Rhinobot_Mappings           ; Offset_0x022A56
                dc.b    $00, $00
                dc.w    $23B2
DOL_04_End:
;-------------------------------------------------------------------------------
OOz_Debug_Object_List:                                         ; Offset_0x02E3EE
DOL_05: ; DOL - Debug Object List
                dc.w    ((DOL_05_End-DOL_05-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($33<<$18)|Touch_Booster_Mappings      ; Offset_0x018C0C
                dc.b    $01, $00
                dc.w    $632C
                dc.l    ($43<<$18)|Giant_Spikeball_Mappings    ; Offset_0x018E10
                dc.b    $00, $00
                dc.w    $C30C
                dc.l    ($19<<$18)|Rotating_Platforms_Mappings ; Offset_0x0170AE
                dc.b    $23, $02
                dc.w    $62F4
                dc.l    ($45<<$18)|Spring_Push_Boost_Mappings  ; Offset_0x019342
                dc.b    $02, $00
                dc.w    $43C5
                dc.l    ($45<<$18)|Spring_Push_Boost_Mappings  ; Offset_0x019342
                dc.b    $12, $0A
                dc.w    $43C5
                dc.l    ($46<<$18)|Spring_Ball_Mappings        ; Offset_0x019A7A
                dc.b    $00, $01
                dc.w    $6354
                dc.l    ($47<<$18)|Switch_Mappings             ; Offset_0x019BBE
                dc.b    $00, $02
                dc.w    $0424
                dc.l    ($15<<$18)|OOz_Swing_Platforms_Mappings; Offset_0x008F82
                dc.b    $88, $01
                dc.w    $43E3
                dc.l    ($3D<<$18)|Break_Boost_Mappings        ; Offset_0x019EB4
                dc.b    $00, $00
                dc.w    $6332
                dc.l    ($48<<$18)|Cannon_Mappings             ; Offset_0x01A2B6
                dc.b    $80, $00
                dc.w    $6368
                dc.l    ($48<<$18)|Cannon_Mappings             ; Offset_0x01A2B6
                dc.b    $81, $01
                dc.w    $6368
                dc.l    ($48<<$18)|Cannon_Mappings             ; Offset_0x01A2B6
                dc.b    $82, $02
                dc.w    $6368
                dc.l    ($48<<$18)|Cannon_Mappings             ; Offset_0x01A2B6
                dc.b    $83, $03
                dc.w    $6368
                dc.l    ($1F<<$18)|OOz_Collapsing_Platforms_Mappings; Offset_0x009DE6
                dc.b    $00, $00
                dc.w    $639D
                dc.l    ($3F<<$18)|Vertical_Fan_Mappings       ; Offset_0x01F77E
                dc.b    $00, $00
                dc.w    $6403
                dc.l    ($3F<<$18)|Horizontal_Fan_Mappings     ; Offset_0x01F830
                dc.b    $80, $00
                dc.w    $6403
DOL_05_End:                
; Offset_0x02E480:
                dc.l    ($1C<<$18)|OOz_Misc_Mappings           ; Offset_0x00A0B6
                dc.b    $0A, $00
                dc.w    $4346
                dc.l    ($1C<<$18)|OOz_Misc_Mappings           ; Offset_0x00A0B6
                dc.b    $0B, $01
                dc.w    $4346
                dc.l    ($1C<<$18)|OOz_Misc_Mappings           ; Offset_0x00A0B6
                dc.b    $0C, $02
                dc.w    $4346
                dc.l    ($1C<<$18)|OOz_Misc_Mappings           ; Offset_0x00A0B6
                dc.b    $0D, $03
                dc.w    $4346
;-------------------------------------------------------------------------------
DHz_Debug_Object_List:                                         ; Offset_0x02E4A0
DOL_06: ; DOL - Debug Object List
                dc.w    ((DOL_06_End-DOL_06-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($15<<$18)|DHz_Swing_Platforms_Mappings; Offset_0x008FF0
                dc.b    $48, $02
                dc.w    $0000
                dc.l    ($1F<<$18)|DHz_Collapsing_Platforms_Mappings; Offset_0x009E26
                dc.b    $00, $00
                dc.w    $63F4
                dc.l    ($73<<$18)|Rotating_Rings_Mappings     ; Offset_0x01DC78
                dc.b    $F5, $00
                dc.w    $26BC
                dc.l    ($6A<<$18)|Rotating_Boxes_Mappings     ; Offset_0x01CAD0
                dc.b    $18, $00
                dc.w    $63D4
                dc.l    ($2A<<$18)|Up_Down_Pillar_Mappings     ; Offset_0x00A1FA
                dc.b    $00, $00
                dc.w    $4000
                dc.l    ($36<<$18)|Spikes_Mappings             ; Offset_0x00CA74
                dc.b    $00, $00
                dc.w    $2434
                dc.l    ($36<<$18)|Spikes_Mappings             ; Offset_0x00CA74
                dc.b    $40, $04
                dc.w    $2434
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $81, $00
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $90, $03
                dc.w    $0470
                dc.l    ($40<<$18)|Diagonal_Spring_Mappings    ; Offset_0x01B3AA
                dc.b    $01, $00
                dc.w    $0440
                dc.l    ($74<<$18)|Invisible_Block_Mappings    ; Offset_0x016052
                dc.b    $11, $00
                dc.w    $8680
                dc.l    ($75<<$18)|Spikeball_Chain_Mappings    ; Offset_0x01DE66
                dc.b    $18, $02
                dc.w    $2000
                dc.l    ($76<<$18)|Platform_Spikes_Mappings    ; Offset_0x01E016
                dc.b    $00, $00
                dc.w    $0000
                dc.l    ($77<<$18)|DHz_Bridge_Mappings         ; Offset_0x01E140
                dc.b    $01, $00
                dc.w    $643C
                dc.l    ($7F<<$18)|Vines_Switch_Mappings       ; Offset_0x01E9EC
                dc.b    $00, $00
                dc.w    $640E
                dc.l    ($80<<$18)|Vines_Mappings              ; Offset_0x01EC14
                dc.b    $00, $00
                dc.w    $641E
                dc.l    ($81<<$18)|Vertical_Bridge_Mappings    ; Offset_0x01EFD6
                dc.b    $00, $01
                dc.w    $643C
                dc.l    ($7A<<$18)|DHz_Swing_Platforms_Mappings; Offset_0x008FF0
                dc.b    $12, $00
                dc.w    $0000
                dc.l    ($A3<<$18)|Flasher_Mappings            ; Offset_0x029DB4
                dc.b    $2C, $00
                dc.w    $83A8
                dc.l    ($9E<<$18)|Crawlton_Mappings           ; Offset_0x029598
                dc.b    $22, $00
                dc.w    $23C0
DOL_06_End:
;-------------------------------------------------------------------------------
CNz_Debug_Object_List:                                         ; Offset_0x02E552
DOL_07: ; DOL - Debug Object List
                dc.w    ((DOL_07_End-DOL_07-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($84<<$18)|Auto_Spin_Attributes_Mappings; Offset_0x016324
                dc.b    $00, $00
                dc.w    $0680
                dc.l    ($44<<$18)|Red_Ball_Bumper_Mappings    ; Offset_0x014994
                dc.b    $00, $00
                dc.w    $439A
DOL_07_End:
;-------------------------------------------------------------------------------
CPz_Debug_Object_List:                                         ; Offset_0x02E574
DOL_08: ; DOL - Debug Object List
                dc.w    ((DOL_08_End-DOL_08-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($0B<<$18)|Open_Close_Platform_Mappings; Offset_0x0152AE
                dc.b    $70, $00
                dc.w    $E3B0
                dc.l    ($1B<<$18)|CPz_Speed_Booster_Mappings  ; Offset_0x017244
                dc.b    $00, $00
                dc.w    $E39C
                dc.l    ($1D<<$18)|Worms_Mappings              ; Offset_0x0173BE
                dc.b    $05, $00
                dc.w    $E43C
                dc.l    ($19<<$18)|Rotating_Platforms_Mappings ; Offset_0x0170AE
                dc.b    $06, $00
                dc.w    $63A0
                dc.l    ($2D<<$18)|Automatic_Door_Mappings     ; Offset_0x00A386
                dc.b    $02, $02
                dc.w    $2394
                dc.l    ($32<<$18)|CPz_Tunel_Obstacle_Mappings ; Offset_0x0186B6
                dc.b    $00, $00
                dc.w    $6430
                dc.l    ($6B<<$18)|CPz_Block_Mappings          ; Offset_0x01CDA2
                dc.b    $10, $00
                dc.w    $6418
                dc.l    ($78<<$18)|CPz_Block_Mappings          ; Offset_0x01CDA2
                dc.b    $00, $00
                dc.w    $6418
                dc.l    ($7A<<$18)|Platform_Horizontal_Mappings; Offset_0x01E640
                dc.b    $00, $00
                dc.w    $E418
                dc.l    ($7B<<$18)|Spring_Tubes_Mappings       ; Offset_0x01E840
                dc.b    $02, $00
                dc.w    $03E0
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $09, $01
                dc.w    $26BC
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $0D, $05
                dc.w    $26BC
                dc.l    ($36<<$18)|Spikes_Mappings             ; Offset_0x00CA74
                dc.b    $00, $00
                dc.w    $2434
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $81, $00
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $90, $03
                dc.w    $0470
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $A0, $06
                dc.w    $045C
                dc.l    ($40<<$18)|Diagonal_Spring_Mappings    ; Offset_0x01B3AA
                dc.b    $01, $00
                dc.w    $0440
                dc.l    ($A5<<$18)|Spiny_Mappings              ; Offset_0x02A1E4
                dc.b    $32, $00
                dc.w    $252D
                dc.l    ($A6<<$18)|Spiny_Mappings              ; Offset_0x02A1E4
                dc.b    $32, $03
                dc.w    $252D
                dc.l    ($A7<<$18)|Grabber_Mappings            ; Offset_0x02A374
                dc.b    $36, $00
                dc.w    $2500
DOL_08_End:
;-------------------------------------------------------------------------------
NGHz_Debug_Object_List:                                        ; Offset_0x02E626
DOL_09: ; DOL - Debug Object List
                dc.w    ((DOL_09_End-DOL_09-$02)/$08) ; Auto Detecção do número de itens na lista por Esrael Neto
                dc.l    ($25<<$18)|Rings_Mappings              ; Offset_0x00AEA0
                dc.b    $00, $00
                dc.w    $26BC
                dc.l    ($26<<$18)|Monitors_Mappings           ; Offset_0x00B580
                dc.b    $08, $00
                dc.w    $0680
                dc.l    ($15<<$18)|NGHz_Swing_Platforms_Mappings; Offset_0x008FB8
                dc.b    $88, $02
                dc.w    $0000
                dc.l    ($18<<$18)|NGHz_Platforms_Mappings     ; Offset_0x009582
                dc.b    $01, $00
                dc.w    $4000
                dc.l    ($18<<$18)|NGHz_Platforms_Mappings     ; Offset_0x009582
                dc.b    $9A, $01
                dc.w    $4000
                dc.l    ($22<<$18)|Arrow_Shooter_Mappings      ; Offset_0x01A5BC
                dc.b    $00, $01
                dc.w    $0417
                dc.l    ($23<<$18)|Pillar_Mappings             ; Offset_0x01A79E
                dc.b    $00, $00
                dc.w    $2000
                dc.l    ($2B<<$18)|Raising_Pillar_Mappings     ; Offset_0x01AA24
                dc.b    $00, $00
                dc.w    $2000
                dc.l    ($2C<<$18)|Lava_Attributes_Mappings    ; Offset_0x015F4E
                dc.b    $00, $00
                dc.w    $8680
                dc.l    ($2C<<$18)|Lava_Attributes_Mappings    ; Offset_0x015F4E
                dc.b    $01, $01
                dc.w    $8680
                dc.l    ($2C<<$18)|Lava_Attributes_Mappings    ; Offset_0x015F4E
                dc.b    $02, $02
                dc.w    $8680
                dc.l    ($40<<$18)|Diagonal_Spring_Mappings    ; Offset_0x01B3AA
                dc.b    $01, $00
                dc.w    $0440
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $81, $00
                dc.w    $045C
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $90, $03
                dc.w    $0470
                dc.l    ($41<<$18)|Springs_Mappings            ; Offset_0x00EEFC
                dc.b    $A0, $06
                dc.w    $045C
                dc.l    ($03<<$18)|Layer_Switch_Mappings       ; Offset_0x0150E8
                dc.b    $09, $01
                dc.w    $26BC
                dc.l    ($36<<$18)|Spikes_Mappings             ; Offset_0x00CA74
                dc.b    $00, $00
                dc.w    $2434
                dc.l    ($2D<<$18)|Automatic_Door_Mappings     ; Offset_0x00A386
                dc.b    $03, $03
                dc.w    $23F8
                dc.l    ($1F<<$18)|NGHz_Collapsing_Platforms_Mappings; Offset_0x009E7E
                dc.b    $00, $00
                dc.w    $4000
                dc.l    ($82<<$18)|Falling_Pillar_Mappings     ; Offset_0x01F1FE
                dc.b    $03, $00
                dc.w    $0000
                dc.l    ($82<<$18)|Falling_Pillar_Mappings     ; Offset_0x01F1FE
                dc.b    $11, $01
                dc.w    $0000
                dc.l    ($83<<$18)|NGHz_Swing_Platforms_Mappings; Offset_0x008FB8
                dc.b    $10, $01
                dc.w    $0000
                dc.l    ($24<<$18)|Sonic_Underwater_Mappings   ; Offset_0x014CFC
                dc.b    $81, $0E
                dc.w    $855B
                dc.l    ($91<<$18)|Chop_Chop_Mappings          ; Offset_0x028506
                dc.b    $08, $00
                dc.w    $253B
                dc.l    ($8C<<$18)|Whisp_Mappings              ; Offset_0x028078
                dc.b    $00, $00
                dc.w    $2500
                dc.l    ($8D<<$18)|Grounder_Mappings           ; Offset_0x028300
                dc.b    $02, $00
                dc.w    $2509
                dc.l    ($8E<<$18)|Grounder_Mappings           ; Offset_0x028300
                dc.b    $02, $00
                dc.w    $2509
DOL_09_End:     
;-------------------------------------------------------------------------------
Jmp_34_To_ModifySpriteAttr_2P:                                 ; Offset_0x02E700
                jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE  
                dc.w    $0000         
;===============================================================================
; Modo de depuração
; <<<-
;===============================================================================