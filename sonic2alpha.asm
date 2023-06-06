; +-------------------------------------------------------------------------+
; |                   File dumped by drx. Released by drx.                  |
; |                       Build Date: August 21st, 1992.                    |
; |                             Origin: EPPROMs                             |
; |                       Labels: MD Sonic 2 Alpha 21.8                     |
; |                      Dump method: True-USB PRO GQ-4X.                   |
; +-------------------------------------------------------------------------+
;
; ===========================================================================

;-------------------------------------------------------------------------------
Offset_0x000040 equ $0040 ; Incorrect reference in Crawl ( Obj_0x9E.asm )
;-------------------------------------------------------------------------------

 include 'constants.asm'

StartOfRom:
	dc.l    $FFFFFE00, EntryPoint, BusError, AddressError
	dc.l    IllegalInstr, ZeroDivide, ChkInstr, TrapvInstr
	dc.l    PrivilegeViolation, Trace, Line1010Emu, Line1111Emu
	dc.l    ErrorException, ErrorException, ErrorException, ErrorException
	dc.l    ErrorException, ErrorException, ErrorException, ErrorException
	dc.l    ErrorException, ErrorException, ErrorException, ErrorException
	dc.l    ErrorException, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    HBlank, ErrorTrap, VBlank, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
	dc.l    ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
Console:        dc.b    'SEGA MEGA DRIVE ' ; Hardware system ID
Date:           dc.b    '(C)SEGA 1991.APR' ; Release date (Leftover)
Title_Local:    dc.b    'SONIC THE             HEDGEHOG 2                ' ; Domestic name
Title_Int:      dc.b    'SONIC THE             HEDGEHOG 2                ' ; International name
Serial:         dc.b    'GM 00004049-01' ; Serial/version number (Leftover)
Checksum:       dc.w    $AFC7
IOSupport:      dc.b    'J               '
ROMStart:       dc.l    $00000 ; ROM start
ROMEnd:         dc.l    $7FFFF
RAMStart:       dc.l    $FF0000 ; RAM start
RAMEnd:         dc.l    $FFFFFF ; RAM end
SRAMSupport:    dc.b    '                '
Notes:          dc.b    '                                                '
Region:         dc.b    'JUE             ' ; Region
;-------------------------------------------------------------------------------                                
ErrorTrap:                                                     ; Offset_0x000200
		nop                                                             
		nop                                                             
		bra.s   ErrorTrap                              ; Offset_0x000200
EntryPoint:                                                    ; Offset_0x000206
		tst.l   (IO_Port_0_Control)                          ; $00A10008
		bne.s   PortA_OK                               ; Offset_0x000214                                         
		tst.w   (IO_Expansion_Control)                       ; $00A1000C
PortA_OK:                                                      ; Offset_0x000214
		bne.s   PortC_OK                               ; Offset_0x000292                                         
		lea     InitValues(PC), A5                     ; Offset_0x000294                         
		movem.w (A5)+, D5-D7                                            
		movem.l (A5)+, A0-A4
		move.b  -$10FF(A1), D0
		andi.b  #$0F, D0
		beq.s   SkipSecurity                           ; Offset_0x000234                                         
		move.l  #'SEGA', $2F00(A1)                                   
SkipSecurity:                                                  ; Offset_0x000234
		move.w  (A4), D0                                                
		moveq   #$00, D0                                                
		move.l  D0, A6                                                  
		move.l  A6, USP
		moveq   #$17, D1                                                
VDPInitLoop:                                                   ; Offset_0x00023E
		move.b  (A5)+, D5                                               
		move.w  D5, (A4)
		add.w   D7, D5                                                  
		dbra    D1, VDPInitLoop                        ; Offset_0x00023E                                     
		move.l  (A5)+, (A4)                                             
		move.w  D0, (A3)                                                
		move.w  D7, (A1)                                                
		move.w  D7, (A2)                                                
WaitForZ80:                                                    ; Offset_0x000250
		btst    D0, (A1)                                                
		bne.s   WaitForZ80                             ; Offset_0x000250                                         
		moveq   #$25, D2                                                
Z80InitLoop:                                                   ; Offset_0x000256
		move.b  (A5)+, (A0)+                                            
		dbra    D2, Z80InitLoop                        ; Offset_0x000256                                     
		move.w  D0, (A2)                                                
		move.w  D0, (A1)                                                
		move.w  D7, (A2)                                                
ClearRAMLoop:                                                  ; Offset_0x000262
		move.l  D0, -(A6)                                               
		dbra    D6, ClearRAMLoop                       ; Offset_0x000262                                     
		move.l  (A5)+, (A4)                                             
		move.l  (A5)+, (A4)                                             
		moveq   #$1F, D3                                                
ClearCRAMLoop:                                                 ; Offset_0x00026E
		move.l  D0, (A3)                                                
		dbra    D3, ClearCRAMLoop                      ; Offset_0x00026E                                     
		move.l  (A5)+, (A4)                                             
		moveq   #$13, D4                                                
ClearVSRAMLoop:                                                ; Offset_0x000278
		move.l  D0, (A3)                                                
		dbra    D4, ClearVSRAMLoop                     ; Offset_0x000278                                     
		moveq   #$03, D5                                                
PSGInitLoop:                                                   ; Offset_0x000280
		move.b  (A5)+, $0011(A3)                                        
		dbra    D5, PSGInitLoop                        ; Offset_0x000280                                     
		move.w  D0, (A2)                                                
		movem.l (A6), D0-D7/A0-A6                                       
		move    #$2700, SR                                              
PortC_OK:                                                      ; Offset_0x000292
		bra.s   Game_Program                           ; Offset_0x000300    
;-------------------------------------------------------------------------------
InitValues:                                                    ; Offset_0x000294                 
		dc.w    $8000, $3FFF, $0100 
		dc.l    Z80_RAM_Start               ; $00A00000
		dc.l    Z80_Bus_Request             ; $00A11100
		dc.l    Z80_Reset                   ; $00A11200
		dc.l    VDP_Data_Port               ; $00C00000
		dc.l    VDP_Control_Port            ; $00C00004                      
		dc.b    $04, $14, $30, $3C, $07, $6C, $00, $00
		dc.b    $00, $00, $FF, $00, $81, $37, $00, $01
		dc.b    $01, $00, $00, $FF, $FF, $00, $00, $80
		dc.b    $40, $00, $00, $80, $AF, $01, $D9, $1F 
		dc.b    $11, $27, $00, $21, $26, $00, $F9, $77
		dc.b    $ED, $B0, $DD, $E1, $FD, $E1, $ED, $47 
		dc.b    $ED, $4F, $D1, $E1, $F1, $08, $D9, $C1
		dc.b    $D1, $E1, $F1, $F9, $F3, $ED, $56, $36 
		dc.b    $E9, $E9, $81, $04, $8F, $02
		dc.l    Color_RAM_Address           ; $C0000000
		dc.l    $40000010
		dc.b    $9F, $BF, $DF, $FF          ; PSG Data
;-------------------------------------------------------------------------------                
Game_Program:                                                  ; Offset_0x000300
		tst.w   (VDP_Control_Port)                           ; $00C00004
		btst    #$06, (IO_Expansion_Control+$0001)           ; $00A1000D
		beq.s   ChecksumCheck                          ; Offset_0x00031C                                         
		cmpi.l  #'init', (Init_Flag).w                               
		beq     AlreadyInit                            ; Offset_0x00036A                                         
ChecksumCheck:                                                 ; Offset_0x00031C
		move.l  #ErrorTrap, A0                               ; $00000200                                        
		move.l  #ROMEnd, A1                                 ; $000001A4
		move.l  (A1), D0                                                
		move.l  #$0007FFFF, D0                                          
		moveq   #$00, D1                                                
ChksumChkLoop:                                                 ; Offset_0x000332
		add.w   (A0)+, D1                                               
		cmp.l   A0, D0                                                  
		bcc.s   ChksumChkLoop                          ; Offset_0x000332                                         
		move.l  #Checksum, A1                                          
		cmp.w   (A1), D1                                                
		nop                                                             
		nop                                                             
		lea     ($FFFFFE00).w, A6                                       
		moveq   #$00, D7                                                
		move.w  #$007F, D6                                              
ClearSomeRAMLoop:                                              ; Offset_0x00034E
		move.l  D7, (A6)+                                               
		dbra    D6, ClearSomeRAMLoop                   ; Offset_0x00034E                                     
		move.b  (IO_Hardware_Version), D0                    ; $00A10001
		andi.b  #$C0, D0                                                
		move.b  D0, (Hardware_Id).w                                       
		move.l  #'init', (Init_Flag).w                               
AlreadyInit:                                                   ; Offset_0x00036A
		lea     (M68K_RAM_Start&$00FFFFFF), A6               ; $00FF0000                                    
		moveq   #$00, D7                                                
		move.w  #$3F7F, D6                                              
ClearRemainingRAMLoop:                                         ; Offset_0x000376
		move.l  D7, (A6)+                                               
		dbra    D6, ClearRemainingRAMLoop              ; Offset_0x000376                                     
		bsr     VDPRegSetup                            ; Offset_0x001368                                         
		bsr     Jmp_00_To_SoundDriverLoad              ; Offset_0x0014B8                                         
		bsr     Control_Ports_Init                     ; Offset_0x0012FC                                         
		move.b  #gm_TitleScreen, (Game_Mode).w          ; $00, $FFFFF600
MainGameLoop:                                                  ; Offset_0x00038E
		move.b  (Game_Mode).w, D0                            ; $FFFFF600
		andi.w  #$001C, D0                                              
		jsr     GameModeArray(PC, D0)                  ; Offset_0x00039C                               
		bra.s   MainGameLoop                           ; Offset_0x00038E                                                         
GameModeArray:                                                 ; Offset_0x00039C
		bra     Sega_Screen                            ; Offset_0x003684
		bra     Title_Screen                           ; Offset_0x0037B0
		bra     Level                                  ; Offset_0x0041C8
		bra     Level                                  ; Offset_0x0041C8
		bra     Special_Stage                          ; Offset_0x0052BC
;===============================================================================
; Routine used when the Checksum is incorrect, showing a red screen.
; Left over from Sonic 1
; ->>>
;===============================================================================   
ChecksumError:                                                 ; Offset_0x0003B0 
		bsr     VDPRegSetup                            ; Offset_0x001734
		move.l  #Color_RAM_Address, (VDP_Control_Port) ; $C0000000, $00C00004
		moveq   #$3F, D7                                                
ChksumErr_RedFill:                                             ; Offset_0x0003C0
		move.w  #$000E, (VDP_Data_Port)                      ; $00C00000
		dbra    D7, ChksumErr_RedFill                  ; Offset_0x0003C0                                     
		bra.s   *
;===============================================================================
; Routine used when the Checksum is incorrect, showing a red screen.
; Left over from Sonic 1
; <<<-
;===============================================================================  

;-------------------------------------------------------------------------------  
; Bus error   
;-------------------------------------------------------------------------------   
BusError:                                                      ; Offset_0x0003CE
		move.b  #$02, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMsg_TwoAddresses                  ; Offset_0x000432    
;-------------------------------------------------------------------------------  
; Address error   
;-------------------------------------------------------------------------------          
AddressError:                                                  ; Offset_0x0003D6
		move.b  #$04, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMsg_TwoAddresses                  ; Offset_0x000432                                                                        
;-------------------------------------------------------------------------------  
; Illegal instruction    
;-------------------------------------------------------------------------------                                             
IllegalInstr:                                                  ; Offset_0x0003DE
		move.b  #$06, (Exception_Index).w                    ; $FFFFFC44
		addq.l  #$02, $0002(A7)                                         
		bra.s   ErrorMessage                           ; Offset_0x00045A                                         
;-------------------------------------------------------------------------------  
; Zero division error   
;-------------------------------------------------------------------------------   
ZeroDivide:                                                    ; Offset_0x0003EA
		move.b  #$08, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMessage                           ; Offset_0x00045A                                         
;-------------------------------------------------------------------------------  
; CHK instruction
;-------------------------------------------------------------------------------                  
ChkInstr:                                                      ; Offset_0x0003F2
		move.b  #$0A, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMessage                           ; Offset_0x00045A                                         
;-------------------------------------------------------------------------------  
; TRAPV instruction
;-------------------------------------------------------------------------------    
TrapvInstr:                                                    ; Offset_0x0003FA
		move.b  #$0C, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMessage                           ; Offset_0x00045A                                         
;-------------------------------------------------------------------------------  
; Privilege violation
;-------------------------------------------------------------------------------   
PrivilegeViolation:                                            ; Offset_0x000402
		move.b  #$0E, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMessage                           ; Offset_0x00045A                                         
;-------------------------------------------------------------------------------  
; Trace error
;-------------------------------------------------------------------------------  
Trace:                                                         ; Offset_0x00040A
		move.b  #$10, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMessage                           ; Offset_0x00045A      
;-------------------------------------------------------------------------------  
; Line "A" Emulator
;-------------------------------------------------------------------------------  
Line1010Emu:                                                   ; Offset_0x000412
		move.b  #$12, (Exception_Index).w                    ; $FFFFFC44
		addq.l  #$02, $0002(A7)                                         
		bra.s   ErrorMessage                           ; Offset_0x00045A                                                         
;-------------------------------------------------------------------------------  
; Line "F" Emulator
;-------------------------------------------------------------------------------  
Line1111Emu:                                                   ; Offset_0x00041E
		move.b  #$14, (Exception_Index).w                    ; $FFFFFC44
		addq.l  #$02, $0002(A7)                                         
		bra.s   ErrorMessage                           ; Offset_0x00045A
;-------------------------------------------------------------------------------
; Error Exception
;-------------------------------------------------------------------------------                
ErrorException:                                                ; Offset_0x00042A
		move.b  #$00, (Exception_Index).w                    ; $FFFFFC44
		bra.s   ErrorMessage                           ; Offset_0x00045A           
;===============================================================================                  
; Routine to show error messages
; ->>>                           
;===============================================================================  
ErrorMsg_TwoAddresses:                                         ; Offset_0x000432
		move    #$2700, SR                                              
		addq.w  #$02, A7                                                
		move.l  (A7)+, ($FFFFFC40).w                                    
		addq.w  #$02, A7                                                
		movem.l D0-D7/A0-A7, ($FFFFFC00).w                              
		bsr     ShowErrorMsg                           ; Offset_0x000480                                         
		move.l  $0002(A7), D0                                           
		bsr     ShowErrAddress                         ; Offset_0x0005B2                                         
		move.l  ($FFFFFC40).w, D0                                       
		bsr     ShowErrAddress                         ; Offset_0x0005B2                                         
		bra.s   ErrorMsg_Wait                          ; Offset_0x000470                                         
ErrorMessage:                                                  ; Offset_0x00045A
		move    #$2700, SR                                              
		movem.l D0-D7/A0-A7, ($FFFFFC00).w                              
		bsr     ShowErrorMsg                           ; Offset_0x000480                                         
		move.l  $0002(A7), D0                                           
		bsr     ShowErrAddress                         ; Offset_0x0005B2                                         
ErrorMsg_Wait:                                                 ; Offset_0x000470
		bsr     Error_WaitForC                         ; Offset_0x0005D8                                         
		movem.l ($FFFFFC00).w, D0-D7/A0-A7                              
		move    #$2300, SR                                              
		rte                                                             
ShowErrorMsg:                                                  ; Offset_0x000480
		lea     (VDP_Data_Port), A6                          ; $00C00000
		move.l  #$78000003, (VDP_Control_Port)               ; $00C00004
		lea     (Art_Menu_Text), A0                    ; Offset_0x0005E8
		move.w  #$027F, D1                                              
Error_LoadGfx:                                                 ; Offset_0x00049A
		move.w  (A0)+, (A6)                                             
		dbra    D1, Error_LoadGfx                      ; Offset_0x00049A                                     
		moveq   #$00, D0                                                
		move.b  (Exception_Index).w, D0                      ; $FFFFFC44
		move.w  Error_Text(PC, D0), D0                 ; Offset_0x0004CA                       
		lea     Error_Text(PC, D0), A0                 ; Offset_0x0004CA                         
		move.l  #$46040003, (VDP_Control_Port)               ; $00C00004
		moveq   #$12, D1                                                
Loop_Show_Error_Text:                                          ; Offset_0x0004BA
		moveq   #$00, D0                                                
		move.b  (A0)+, D0                                               
		addi.w  #$0790, D0                                              
		move.w  D0, (A6)                                                
		dbra    D1, Loop_Show_Error_Text               ; Offset_0x0004BA                                     
		rts  
;-------------------------------------------------------------------------------
Error_Text:     dc.w	ErrTxt_Exception-Error_Text
		dc.w	ErrTxt_BusError-Error_Text
		dc.w	ErrTxt_AddressError-Error_Text
		dc.w	ErrTxt_IllegalInstr-Error_Text
		dc.w	ErrTxt_ZeroDivide-Error_Text
		dc.w	ErrTxt_ChkIntruction-Error_Text
		dc.w	ErrTxt_TrapvInstr-Error_Text
		dc.w	ErrTxt_PrivilegeViol-Error_Text
		dc.w	ErrTxt_Trace-Error_Text
		dc.w	ErrTxt_Line1010Emul-Error_Text
		dc.w	ErrTxt_Line1111Emul-Error_Text
ErrTxt_Exception:	dc.b	'ERROR EXCEPTION    '
ErrTxt_BusError: 	dc.b	'BUS ERROR          '
ErrTxt_AddressError: 	dc.b	'ADDRESS ERROR      '
ErrTxt_IllegalInstr: 	dc.b	'ILLEGAL INSTRUCTION'
ErrTxt_ZeroDivide: 	dc.b	'@ERO DIVIDE        '
ErrTxt_ChkIntruction:	dc.b	'CHK INSTRUCTION    '
ErrTxt_TrapvInstr:	dc.b	'TRAPV INSTRUCTION  '
ErrTxt_PrivilegeViol:	dc.b	'PRIVILEGE VIOLATION'
ErrTxt_Trace: 		dc.b	'TRACE              '
ErrTxt_Line1010Emul: 	dc.b	'LINE 1010 EMULATOR '
ErrTxt_Line1111Emul: 	dc.b	'LINE 1111 EMULATOR '
			dc.b    00
ShowErrAddress:                                                ; Offset_0x0005B2
		move.w  #$07CA, (A6)                                            
		moveq   #$07, D2                                                
ShowErrAddress_DigitLoop:                                      ; Offset_0x0005B8
		rol.l   #$04, D0                                                
		bsr.s   ShowErrDigit                           ; Offset_0x0005C2                                         
		dbra    D2, ShowErrAddress_DigitLoop           ; Offset_0x0005B8                                     
		rts                                                             
ShowErrDigit:                                                  ; Offset_0x0005C2
		move.w  D0, D1                                                  
		andi.w  #$000F, D1
		cmpi.w  #$000A, D1                                              
		bcs.s   ShowErrDigit_NoOverflow                ; Offset_0x0005D0                                         
		addq.w  #$07, D1                                                
ShowErrDigit_NoOverflow:                                       ; Offset_0x0005D0
		addi.w  #$07C0, D1                                              
		move.w  D1, (A6)                                                
		rts
Error_WaitForC:                                                ; Offset_0x0005D8
		bsr     Control_Ports_Read                     ; Offset_0x00132C                                         
		cmpi.b  #$20, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605                                   
		bne     Error_WaitForC                         ; Offset_0x0005D8                                         
		rts                                                             
Art_Menu_Text:                                                 ; Offset_0x0005E8 
		incbin  'art/uncompressed/fontmenu.dat'
;===============================================================================                  
; Routine to show error messages
; <<<-                           
;===============================================================================                          
	  
;===============================================================================                  
; Vertical interrupt
; ->>>                           
;===============================================================================         
VBlank:                                                        ; Offset_0x000B08
		movem.l D0-D7/A0-A6, -(A7)
		tst.b   (VBlank_Index).w                             ; $FFFFF62A
		beq     Default_VBlank                         ; Offset_0x000B82
Offset_0x000B14:
		move.w  (VDP_Control_Port), D0                       ; $00C00004
		andi.w  #$0008, D0
		beq.s   Offset_0x000B14
		move.l  #$40000010, (VDP_Control_Port)               ; $00C00004
		move.l  ($FFFFF616).w, (VDP_Data_Port)               ; $00C00000
		btst    #$06, (Hardware_Id).w                        ; $FFFFFFF8
		beq.s   Offset_0x000B42
		move.w  #$0700, D0
Offset_0x000B3E:
		dbra    D0, Offset_0x000B3E
Offset_0x000B42:
		move.b  (VBlank_Index).w, D0                         ; $FFFFF62A
		move.b  #$00, (VBlank_Index).w                       ; $FFFFF62A
		move.w  #$0001, ($FFFFF644).w
		andi.w  #$003E, D0
		move.w  VBlank_List(PC, D0), D0                ; Offset_0x000B68
		jsr     VBlank_List(PC, D0)                    ; Offset_0x000B68
Offset_0x000B5E:                
		addq.l  #$01, ($FFFFFE0C).w
		movem.l (A7)+, D0-D7/A0-A6
		rte         
;-------------------------------------------------------------------------------                
VBlank_List:                                                   ; Offset_0x000B68
		dc.w    VBlank_00-VBlank_List                  ; Offset_0x000B82
		dc.w    VBlank_02-VBlank_List                  ; Offset_0x000CEC
		dc.w    VBlank_04-VBlank_List                  ; Offset_0x000D2A
		dc.w    VBlank_06-VBlank_List                  ; Offset_0x000D40
		dc.w    VBlank_08-VBlank_List                  ; Offset_0x000D50
		dc.w    VBlank_0A-VBlank_List                  ; Offset_0x000E72
		dc.w    VBlank_0C-VBlank_List                  ; Offset_0x000F18
		dc.w    VBlank_0E-VBlank_List                  ; Offset_0x001004
		dc.w    VBlank_10-VBlank_List                  ; Offset_0x000D46
		dc.w    VBlank_12-VBlank_List                  ; Offset_0x001014
		dc.w    VBlank_14-VBlank_List                  ; Offset_0x000CFE
		dc.w    VBlank_16-VBlank_List                  ; Offset_0x001020
		dc.w    VBlank_18-VBlank_List                  ; Offset_0x000F18      
;-------------------------------------------------------------------------------
Default_VBlank:
VBlank_00:                                                     ; Offset_0x000B82
		cmpi.b  #$80|gm_PlayMode, (Game_Mode).w              ; $FFFFF600
		beq.s   Offset_0x000BBC                                         
		cmpi.b  #gm_DemoMode, (Game_Mode).w            ; $08 ; $FFFFF600
		beq.s   Offset_0x000BBC                                         
		cmpi.b  #gm_PlayMode, (Game_Mode).w            ; $0C ; $FFFFF600
		beq.s   Offset_0x000BBC
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000BA2:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000BA2
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		bra.s   Offset_0x000B5E
Offset_0x000BBC:
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq     Offset_0x000C60
		move.w  (VDP_Control_Port), D0                       ; $00C00004
		btst    #$06, (Hardware_Id).w                        ; $FFFFFFF8
		beq.s   Offset_0x000BDA
		move.w  #$0700, D0
Offset_0x000BD6:
		dbra    D0, Offset_0x000BD6
Offset_0x000BDA:
		move.w  #$0001, ($FFFFF644).w
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000BE8:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000BE8
		tst.b   ($FFFFF64E).w
		bne.s   Offset_0x000C1E
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bra.s   Offset_0x000C42
Offset_0x000C1E:
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9540, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
Offset_0x000C42:
		move.w  (Horizontal_Interrupt_Count).w, (A5)         ; $FFFFF624
		move.w  #$8230, (VDP_Control_Port)                   ; $00C00004
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		bra     Offset_0x000B5E
Offset_0x000C60:
		move.w  (VDP_Control_Port), D0                       ; $00C00004
		move.l  #$40000010, (VDP_Control_Port)               ; $00C00004
		move.l  ($FFFFF616).w, (VDP_Data_Port)               ; $00C00000
		btst    #$06, (Hardware_Id).w                        ; $FFFFFFF8
		beq.s   Offset_0x000C88
		move.w  #$0700, D0
Offset_0x000C84:
		dbra    D0, Offset_0x000C84
Offset_0x000C88:
		move.w  #$0001, ($FFFFF644).w
		move.w  (Horizontal_Interrupt_Count).w, (VDP_Control_Port) ; $FFFFF624, $00C00004
		move.w  #$8230, (VDP_Control_Port)                   ; $00C00004
		move.l  ($FFFFF61E).w, ($FFFFEEEC).w
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000CAC:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000CAC
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96FC9500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		bra     Offset_0x000B5E
;-------------------------------------------------------------------------------
VBlank_02:                                                     ; Offset_0x000CEC
		bsr     Offset_0x0010BE
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Offset_0x000CFC
		subq.w  #$01, (Timer_Count_Down).w                   ; $FFFFF614
Offset_0x000CFC:
		rts
;-------------------------------------------------------------------------------
VBlank_14:                                                     ; Offset_0x000CFE
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000D06:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000D06
		bsr     Control_Ports_Read                     ; Offset_0x00132C
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Offset_0x000D28
		subq.w  #$01, (Timer_Count_Down).w                   ; $FFFFF614
Offset_0x000D28:
		rts
;-------------------------------------------------------------------------------
VBlank_04:                                                     ; Offset_0x000D2A
		bsr     Offset_0x0010BE
		bsr     Offset_0x001856
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Offset_0x000D3E
		subq.w  #$01, (Timer_Count_Down).w                   ; $FFFFF614
Offset_0x000D3E:
		rts
;-------------------------------------------------------------------------------
VBlank_06:                                                     ; Offset_0x000D40
		bsr     Offset_0x0010BE
		rts    
;-------------------------------------------------------------------------------
VBlank_10:                                                     ; Offset_0x000D46
		cmpi.b  #gm_SpecialStage, (Game_Mode).w        ; $10 ; $FFFFF600
		beq     VBlank_0A                              ; Offset_0x000E72
;-------------------------------------------------------------------------------
VBlank_08:                                                     ; Offset_0x000D50
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000D58:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000D58
		bsr     Control_Ports_Read                     ; Offset_0x00132C
		tst.b   ($FFFFF64E).w
		bne.s   Offset_0x000D92
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bra.s   Offset_0x000DB6
Offset_0x000D92:
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9540, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
Offset_0x000DB6:
		move.w  (Horizontal_Interrupt_Count).w, (A5)         ; $FFFFF624
		move.w  #$8230, (VDP_Control_Port)                   ; $00C00004
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$940193C0, (A5)
		move.l  #$96F09500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7C00, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96FC9500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bsr     Process_DMA                            ; Offset_0x001622
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		movem.l (Camera_X).w, D0-D7                          ; $FFFFEE00
		movem.l D0-D7, ($FFFFEE60).w
		movem.l (Camera_X_2).w, D0-D7                        ; $FFFFEE20
		movem.l D0-D7, ($FFFFEE80).w
		movem.l (Scroll_Flag_Array).w, D0-D3                 ; $FFFFEE50
		movem.l D0-D3, (Scroll_Flag_Array_2).w               ; $FFFFEEA0
		move.l  ($FFFFF61E).w, ($FFFFEEEC).w
		cmpi.b  #$5C, (Scanlines_Count).w                    ; $FFFFF625
		bcc.s   DemoTime                               ; Offset_0x000E56
		move.b  #$01, ($FFFFF64F).w
		rts
DemoTime:                                                      ; Offset_0x000E56
		bsr     LoadTilesAsYouMove                     ; Offset_0x006F2E
		jsr     (HudUpdate)                            ; Offset_0x02D316
		bsr     Offset_0x001872
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Exit_DemoTime                          ; Offset_0x000E70
		subq.w  #$01, (Timer_Count_Down).w                   ; $FFFFF614
Exit_DemoTime:                                                 ; Offset_0x000E70
		rts
;-------------------------------------------------------------------------------
VBlank_0A:                                                     ; Offset_0x000E72
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000E7A:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000E7A
		bsr     Control_Ports_Read                     ; Offset_0x00132C
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96FC9500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$940193C0, (A5)
		move.l  #$96F09500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7C00, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bsr     Process_DMA                            ; Offset_0x001622
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		bsr     Special_Stage_Pal_Cycle                ; Offset_0x005626
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Offset_0x000F16
		subq.w  #$01, (Timer_Count_Down).w                   ; $FFFFF614
Offset_0x000F16:
		rts
;-------------------------------------------------------------------------------
VBlank_0C:                                                     ; Offset_0x000F18
VBlank_18:                                                     ; Offset_0x000F18
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x000F20:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x000F20
		bsr     Control_Ports_Read                     ; Offset_0x00132C
		tst.b   ($FFFFF64E).w
		bne.s   Offset_0x000F5A
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bra.s   Offset_0x000F7E
Offset_0x000F5A:
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9540, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
Offset_0x000F7E:
		move.w  (Horizontal_Interrupt_Count).w, (A5)         ; $FFFFF624
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$940193C0, (A5)
		move.l  #$96F09500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7C00, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96FC9500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bsr     Process_DMA                            ; Offset_0x001622
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		movem.l (Camera_X).w, D0-D7                          ; $FFFFEE00
		movem.l D0-D7, ($FFFFEE60).w
		movem.l (Scroll_Flag_Array).w, D0/D1                 ; $FFFFEE50
		movem.l D0/D1, (Scroll_Flag_Array_2).w               ; $FFFFEEA0
		bsr     LoadTilesAsYouMove                     ; Offset_0x006F2E
		jsr     (HudUpdate)                            ; Offset_0x02D316
		bsr     Offset_0x001856
		rts
;-------------------------------------------------------------------------------
VBlank_0E:                                                     ; Offset_0x001004
		bsr     Offset_0x0010BE
		addq.b  #$01, ($FFFFF628).w
		move.b  #$0E, (VBlank_Index).w                       ; $FFFFF62A
		rts
;-------------------------------------------------------------------------------
VBlank_12:                                                     ; Offset_0x001014
		bsr     Offset_0x0010BE
		move.w  (Horizontal_Interrupt_Count).w, (A5)         ; $FFFFF624
		bra     Offset_0x001856
;-------------------------------------------------------------------------------
VBlank_16:                                                     ; Offset_0x001020
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x001028:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x001028
		bsr     Control_Ports_Read                     ; Offset_0x00132C
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96FC9500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$940193C0, (A5)
		move.l  #$96F09500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7C00, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Offset_0x0010BC
		subq.w  #$01, (Timer_Count_Down).w                   ; $FFFFF614
Offset_0x0010BC:
		rts
Offset_0x0010BE:
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x0010C6:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x0010C6
		bsr     Control_Ports_Read                     ; Offset_0x00132C
		tst.b   ($FFFFF64E).w
		bne.s   Offset_0x001100
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		bra.s   Offset_0x001124
Offset_0x001100:
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94009340, (A5)
		move.l  #$96FD9540, (A5)
		move.w  #$977F, (A5)
		move.w  #$C000, (A5)
		move.w  #$0080, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
Offset_0x001124:
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96FC9500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$940193C0, (A5)
		move.l  #$96F09500, (A5)
		move.w  #$977F, (A5)
		move.w  #$7C00, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		jsr     (Sound_Driver_Input)                   ; Offset_0x0012AC
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		rts                                       
;===============================================================================                  
; Vertical interrupt
; <<<-                           
;=============================================================================== 
	
;===============================================================================                  
; Horizontal interrupt
; ->>>                           
;=============================================================================== 
HBlank:                                                        ; Offset_0x00117C
		tst.w   ($FFFFF644).w
		beq     Offset_0x001226
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq     Pal_To_ColorRAM                        ; Offset_0x001228
		move.w  #$0000, ($FFFFF644).w
		move.l  A5, -(A7)
		move.l  D0, -(A7)
Offset_0x001196:
		move.w  (VDP_Control_Port), D0                       ; $00C00004
		andi.w  #$0004, D0
		beq.s   Offset_0x001196
		move.w  ($FFFFF60C).w, D0
		andi.b  #$BF, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
		move.w  #$8228, (VDP_Control_Port)                   ; $00C00004
		move.l  #$40000010, (VDP_Control_Port)               ; $00C00004
		move.l  ($FFFFEEEC).w, (VDP_Data_Port)               ; $00C00000
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Offset_0x0011D2:
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Offset_0x0011D2
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.l  #$94019340, (A5)
		move.l  #$96EE9580, (A5)
		move.w  #$977F, (A5)
		move.w  #$7800, (A5)
		move.w  #$0083, ($FFFFF640).w
		move.w  ($FFFFF640).w, (A5)
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
Offset_0x001208:
		move.w  (VDP_Control_Port), D0                       ; $00C00004
		andi.w  #$0004, D0
		beq.s   Offset_0x001208
		move.w  ($FFFFF60C).w, D0
		ori.b   #$40, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
		move.l  (A7)+, D0
		move.l  (A7)+, A5
Offset_0x001226:
		rte
;-------------------------------------------------------------------------------
; Routine to transfer the color palette to CRAM during horizontal blanking 
; ->>> 
;-------------------------------------------------------------------------------                
Pal_To_ColorRAM:                                               ; Offset_0x001228
		move    #$2700, SR
		move.w  #$0000, ($FFFFF644).w
		movem.l A0/A1, -(A7)
		lea     (VDP_Data_Port), A1                          ; $00C00000
		lea     ($FFFFFA80).w, A0
		move.l  #Color_RAM_Address, $0004(A1)                ; $C0000000
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.l  (A0)+, (A1)
		move.w  #$8ADF, $0004(A1)
		movem.l (A7)+, A0/A1
		tst.b   ($FFFFF64F).w
		bne.s   Offset_0x00129A
		rte
Offset_0x00129A:
		clr.b   ($FFFFF64F).w
		movem.l D0-D7/A0-A6, -(A7)
		bsr     DemoTime                               ; Offset_0x000E56
		movem.l (A7)+, D0-D7/A0-A6
		rte
;-------------------------------------------------------------------------------
; Routine to transfer the color palette to CRAM during horizontal blanking 
; <<<- 
;-------------------------------------------------------------------------------    
		
;===============================================================================                  
; Horizontal interrupt
; <<<-                           
;===============================================================================  

;===============================================================================                  
; Routine to transfer the selected sound to play on the Z80
; ->>>                           
;=============================================================================== 
Sound_Driver_Input:                                            ; Offset_0x0012AC
		lea     (Sound_Buffer_Id&$00FFFFFF), A0              ; $00FFFFE0
		lea     ($00A01B80), A1
		cmpi.b  #$80, $0008(A1)
		bne.s   Offset_0x0012E0
		move.b  $0000(A0), D0
		beq.s   Offset_0x0012E0
		clr.b   $0000(A0)
		move.b  D0, D1
		subi.b  #$FE, D1
		bcs.s   Offset_0x0012DC
		addi.b  #$7F, D1
		move.b  D1, $0003(A1)
		bra.s   Offset_0x0012E0
Offset_0x0012DC:
		move.b  D0, $0008(A1)
Offset_0x0012E0:
		moveq   #$03, D1
Offset_0x0012E2:
		move.b  $01(A0, D1), D0
		beq.s   Offset_0x0012F6
		tst.b   $09(A1, D1)
		bne.s   Offset_0x0012F6
		clr.b   $01(A0, D1)
		move.b  D0, $09(A1, D1)
Offset_0x0012F6:
		dbra    D1, Offset_0x0012E2
		rts 
;===============================================================================                  
; Routine to transfer the selected sound to play on the Z80
; <<<-                           
;=============================================================================== 

;===============================================================================                  
; Initialize ports 0, 1, and expansion
; ->>>                           
;===============================================================================  
Control_Ports_Init:                                            ; Offset_0x0012FC
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
Control_Ports_Init_Z80Wait:                                    ; Offset_0x001304
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   Control_Ports_Init_Z80Wait             ; Offset_0x001304
		moveq   #$40, D0
		move.b  D0, (IO_Port_0_Control+$0001)                ; $00A10009
		move.b  D0, (IO_Port_1_Control+$0001)                ; $00A1000B
		move.b  D0, (IO_Expansion_Control+$0001)             ; $00A1000D
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		rts
;===============================================================================                  
; Initialize ports 0, 1, and expansion
; <<<-                           
;===============================================================================  

;===============================================================================                  
; Read ports 0, 1 and expansion
; ->>>                           
;=============================================================================== 
Control_Ports_Read:                                            ; Offset_0x00132C
		lea     (Control_Ports_Buffer_Data).w, A0            ; $FFFFF604
		lea     (IO_Joypad_Port_0), A1                       ; $00A10003
		bsr.s   Control_Ports_Read_Data                ; Offset_0x00133A
		addq.w  #$02, A1
Control_Ports_Read_Data:                                       ; Offset_0x00133A
		move.b  #$00, (A1)
		nop
		nop
		move.b  (A1), D0
		lsl.b   #$02, D0
		andi.b  #$C0, D0
		move.b  #$40, (A1)
		nop
		nop
		move.b  (A1), D1
		andi.b  #$3F, D1
		or.b    D1, D0
		not.b   D0
		move.b  (A0), D1
		eor.b   D0, D1
		move.b  D0, (A0)+
		and.b   D0, D1
		move.b  D1, (A0)+
		rts
;===============================================================================                  
; Read ports 0, 1 and expansion
; <<<-                           
;===============================================================================  
					
;===============================================================================                  
; VDPRegSetup
; ->>>                           
;===============================================================================  
VDPRegSetup:                                                   ; Offset_0x001368
		lea     (VDP_Control_Port), A0                       ; $00C00004
		lea     (VDP_Data_Port), A1                          ; $00C00000
		lea     (VDPRegSetup_Array), A2                ; Offset_0x0013F2
		moveq   #$12, D7
Offset_0x00137C:
		move.w  (A2)+, (A0)
		dbra    D7, Offset_0x00137C
		move.w  (VDPRegSetup_Array+$0002), D0          ; Offset_0x0013F4
		move.w  D0, ($FFFFF60C).w
		move.w  #$8ADF, (Horizontal_Interrupt_Count).w ; 224 linhas ; $FFFFF624
		moveq   #$00, D0
		move.l  #$40000010, (VDP_Control_Port)               ; $00C00004
		move.w  D0, (A1)
		move.w  D0, (A1)
		move.l  #$C0000000, (VDP_Control_Port)               ; $00C00004
		move.w  #$003F, D7
Offset_0x0013B0:
		move.w  D0, (A1)
		dbra    D7, Offset_0x0013B0
		clr.l   ($FFFFF616).w
		clr.l   ($FFFFF61A).w
		move.l  D1, -(A7)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.w  #$8F01, (A5)
		move.l  #$94FF93FF, (A5)
		move.w  #$9780, (A5)
		move.l  #$40000080, (A5)
		move.w  #$0000, (VDP_Data_Port)                      ; $00C00000
Offset_0x0013E2:
		move.w  (A5), D1
		btst    #$01, D1
		bne.s   Offset_0x0013E2
		move.w  #$8F02, (A5)
		move.l  (A7)+, D1
		rts
;-------------------------------------------------------------------------------
VDPRegSetup_Array:                                             ; Offset_0x0013F2  
		dc.w    $8004, $8134, $8230, $8328, $8407, $857C, $8600, $8700
		dc.w    $8800, $8900, $8A00, $8B00, $8C81, $8D3F, $8E00, $8F02
		dc.w    $9001, $9100, $9200                  
;===============================================================================                  
; VDPRegSetup
; <<<-                           
;===============================================================================

;===============================================================================                  
; ClearScreen
; ->>>                           
;===============================================================================  
ClearScreen:                                                   ; Offset_0x001418
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
ClearScreen_Z80Wait:                                           ; Offset_0x001420
		btst    #$00, (Z80_Bus_Request)                      ; $00A11100
		bne.s   ClearScreen_Z80Wait                    ; Offset_0x001420
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.w  #$8F01, (A5)
		move.l  #$940F93FF, (A5)
		move.w  #$9780, (A5)
		move.l  #$40000083, (A5)
		move.w  #$0000, (VDP_Data_Port)                      ; $00C00000
ClearScreen_DMAWait:                                           ; Offset_0x00144C
		move.w  (A5), D1
		btst    #$01, D1
		bne.s   ClearScreen_DMAWait                    ; Offset_0x00144C
		move.w  #$8F02, (A5)
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.w  #$8F01, (A5)
		move.l  #$940F93FF, (A5)
		move.w  #$9780, (A5)
		move.l  #$60000083, (A5)
		move.w  #$0000, (VDP_Data_Port)                      ; $00C00000
ClearScreen_DMAWait_2:                                         ; Offset_0x00147A
		move.w  (A5), D1
		btst    #$01, D1
		bne.s   ClearScreen_DMAWait_2                  ; Offset_0x00147A
		move.w  #$8F02, (A5)
		clr.l   ($FFFFF616).w
		clr.l   ($FFFFF61A).w
		lea     ($FFFFF800).w, A1
		moveq   #$00, D0
		move.w  #$00A0, D1
ClearScreen_ClearBuffer1:                                      ; Offset_0x001498
		move.l  D0, (A1)+
		dbra    D1, ClearScreen_ClearBuffer1           ; Offset_0x001498
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		moveq   #$00, D0
		move.w  #$0100, D1
ClearScreen_ClearBuffer2:                                      ; Offset_0x0014A8
		move.l  D0, (A1)+
		dbra    D1, ClearScreen_ClearBuffer2           ; Offset_0x0014A8
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		rts 
;===============================================================================                  
; ClearScreen
; <<<-                           
;===============================================================================  

Jmp_00_To_SoundDriverLoad                                      ; Offset_0x0014B8
		nop
		jmp     (SoundDriverLoad)                      ; Offset_0x0EC000
;-------------------------------------------------------------------------------
; Z80_Init:   ; Inicialização do z80 não usado                 ; Offset_0x0014C0
		move.w  #$0100, (Z80_Bus_Request)                    ; $00A11100
		move.w  #$0100, (Z80_Reset)                          ; $00A11200
		lea     (Z80_RAM_Start), A1                          ; $00A00000
		move.b  #$F3, (A1)+
		move.b  #$F3, (A1)+
		move.b  #$C3, (A1)+
		move.b  #$00, (A1)+
		move.b  #$00, (A1)+
		move.w  #$0000, (Z80_Reset)                          ; $00A11200
		nop
		nop
		nop
		nop
		move.w  #$0100, (Z80_Reset)                          ; $00A11200
		move.w  #$0000, (Z80_Bus_Request)                    ; $00A11100
		rts                
;-------------------------------------------------------------------------------
Play_Music:                                                    ; Offset_0x00150C
		move.b  D0, (Sound_Buffer_Id).w                      ; $FFFFFFE0
		rts 
;-------------------------------------------------------------------------------                                                                            
Play_Sfx:                                                      ; Offset_0x001512
		move.b  D0, (Sound_Buffer_Id+$0001).w                ; $FFFFFFE1
		rts
;-------------------------------------------------------------------------------                      
Play_Music_Ex:                                                 ; Offset_0x001518
		move.b  D0, (Sound_Buffer_Id+$0002).w                ; $FFFFFFE2
		rts
;-------------------------------------------------------------------------------                                                                         
Play_Sfx_Ex:                                                   ; Offset_0x00151E
		tst.b   $0001(A0)
		bpl.s   Exit_Play_Sfx_Ex                       ; Offset_0x001528
		move.b  D0, (Sound_Buffer_Id+$0001).w                ; $FFFFFFE1
Exit_Play_Sfx_Ex:                                              ; Offset_0x001528
		rts                
;===============================================================================
; Routine to handle pausing
; ->>>
;===============================================================================
Pause:                                                         ; Offset_0x00152A
		nop
		tst.b   (Life_Count).w                               ; $FFFFFE12
		beq     Unpause                                ; Offset_0x00158E
		tst.w   (Pause_Status).w                             ; $FFFFF63A
		bne.s   Pause_AlreadyPaused                    ; Offset_0x001542
		btst    #$07, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Pause_DoNothing                        ; Offset_0x001594
Pause_AlreadyPaused:                                           ; Offset_0x001542
		move.w  #$0001, (Pause_Status).w                     ; $FFFFF63A
		move.b  #$FE, (Sound_Buffer_Id).w                    ; $FFFFFFE0
Pause_Loop:                                                    ; Offset_0x00154E
		move.b  #$10, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		tst.b   ($FFFFFFD1).w
		beq.s   Pause_CheckStart                       ; Offset_0x001580
		btst    #$06, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Pause_CheckBC                          ; Offset_0x001570
		move.b  #gm_TitleScreen, (Game_Mode).w         ; $04 ; $FFFFF600
		nop
		bra.s   Offset_0x001588
Pause_CheckBC:                                                 ; Offset_0x001570
		btst    #$04, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		bne.s   Pause_SlowMotion                       ; Offset_0x001596
		btst    #$05, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		bne.s   Pause_SlowMotion                       ; Offset_0x001596
Pause_CheckStart:                                              ; Offset_0x001580
		btst    #$07, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Pause_Loop                             ; Offset_0x00154E
Offset_0x001588:
		move.b  #$FF, (Sound_Buffer_Id).w                    ; $FFFFFFE0
Unpause:                                                       ; Offset_0x00158E
		move.w  #$0000, (Pause_Status).w                     ; $FFFFF63A
Pause_DoNothing:                                               ; Offset_0x001594
		rts
Pause_SlowMotion:                                              ; Offset_0x001596
		move.w  #$0001, (Pause_Status).w                     ; $FFFFF63A
		move.b  #$FF, (Sound_Buffer_Id).w                    ; $FFFFFFE0
		rts
;===============================================================================
; Routine to handle pausing
; <<<-
;===============================================================================   

;===============================================================================
; Routine for loading mappings into the VDP
; ->>>
;===============================================================================
ShowVDPGraphics:                                               ; Offset_0x0015A4
		lea     (VDP_Data_Port), A6                          ; $00C00000
		move.l  #$00800000, D4
ShowVDPGraphics_LineLoop:                                      ; Offset_0x0015B0
		move.l  D0, $0004(A6)
		move.w  D1, D3
ShowVDPGraphics_TileLoop:                                      ; Offset_0x0015B6
		move.w  (A1)+, (A6)
		dbra    D3, ShowVDPGraphics_TileLoop           ; Offset_0x0015B6
		add.l   D4, D0
		dbra    D2, ShowVDPGraphics_LineLoop           ; Offset_0x0015B0
		rts
;===============================================================================
DMA_68KtoVRAM:                                                 ; Offset_0x0015C4
		include "_inc/DMA68KtoVRAM.asm"
;=============================================================================== 
NemesisDec:                                                    ; Offset_0x001654
		movem.l D0-D7/A0/A1/A3-A5, -(A7)
		lea     (NemesisDec_Output), A3                ; Offset_0x001716
		lea     (VDP_Data_Port), A4                          ; $00C00000
		bra.s   NemesisDec_Main                        ; Offset_0x001670
;-------------------------------------------------------------------------------  
NemesisDecToRAM:                                               ; Offset_0x001666
		movem.l D0-D7/A0/A1/A3-A5, -(A7)
		lea     (NemesisDec_OutputToRAM), A3           ; Offset_0x00172C
NemesisDec_Main:                                               ; Offset_0x001670
		lea     ($FFFFAA00).w, A1
		move.w  (A0)+, D2
		lsl.w   #$01, D2
		bcc.s   Offset_0x00167E
	      ; Point A3 to NemesisDec_Output_XOR if A3 = NemesisDec_Output or
	      ; Point A3 to NemesisDec_OutputRAM_XOR if A3 = NemesisDec_OutputRAM  
		adda.w  #(NemesisDec_Output_XOR-NemesisDec_Output), A3   ; $000A
Offset_0x00167E:
		lsl.w   #$02, D2
		move.w  D2, A5
		moveq   #$08, D3
		moveq   #$00, D2
		moveq   #$00, D4
		bsr     NemesisDec_4                           ; Offset_0x001742
		move.b  (A0)+, D5
		asl.w   #$08, D5
		move.b  (A0)+, D5
		move.w  #$0010, D6
		bsr.s   NemesisDec_2                           ; Offset_0x00169E
		movem.l (A7)+, D0-D7/A0/A1/A3-A5
		rts
;-------------------------------------------------------------------------------                
NemesisDec_2:                                                  ; Offset_0x00169E
		move.w  D6, D7
		subq.w  #$08, D7
		move.w  D5, D1
		lsr.w   D7, D1
		cmpi.b  #$FC, D1
		bcc.s   Offset_0x0016EA
		andi.w  #$00FF, D1
		add.w   D1, D1
		move.b  $00(A1, D1), D0
		ext.w   D0
		sub.w   D0, D6
		cmpi.w  #$0009, D6
		bcc.s   Offset_0x0016C6
		addq.w  #$08, D6
		asl.w   #$08, D5
		move.b  (A0)+, D5
Offset_0x0016C6:
		move.b  $01(A1, D1), D1
		move.w  D1, D0
		andi.w  #$000F, D1
		andi.w  #$00F0, D0
NemesisDec_SubType:                                            ; Offset_0x0016D4                 
		lsr.w   #$04, D0
NemesisDec_Loop_SubType:                                       ; Offset_0x0016D6                 
		lsl.l   #$04, D4
		or.b    D1, D4
		subq.w  #$01, D3
		bne.s   Offset_0x0016E4
	      ; A3 contains one of the decompression routines
	      ; ( NemesisDec_Output_XOR or NemesisDec_OutputRAM_XOR )  
		jmp     (A3)       
;-------------------------------------------------------------------------------
NemesisDec_3                                                   ; Offset_0x0016E0
		moveq   #$00, D4
		moveq   #$08, D3
Offset_0x0016E4:
		dbra    D0, NemesisDec_Loop_SubType            ; Offset_0x0016D6
		bra.s   NemesisDec_2                           ; Offset_0x00169E  
;-------------------------------------------------------------------------------  
Offset_0x0016EA:
		subq.w  #$06, D6
		cmpi.w  #$0009, D6
		bcc.s   Offset_0x0016F8
		addq.w  #$08, D6
		asl.w   #$08, D5
		move.b  (A0)+, D5
Offset_0x0016F8:
		subq.w  #$07, D6
		move.w  D5, D1
		lsr.w   D6, D1
		move.w  D1, D0
		andi.w  #$000F, D1
		andi.w  #$0070, D0
		cmpi.w  #$0009, D6
		bcc.s   NemesisDec_SubType                     ; Offset_0x0016D4
		addq.w  #$08, D6
		asl.w   #$08, D5
		move.b  (A0)+, D5
		bra.s   NemesisDec_SubType                     ; Offset_0x0016D4
;-------------------------------------------------------------------------------
NemesisDec_Output:                                             ; Offset_0x001716
		move.l  D4, (A4)
		subq.w  #$01, A5
		move.w  A5, D4
		bne.s   NemesisDec_3                           ; Offset_0x0016E0
		rts
;-------------------------------------------------------------------------------
NemesisDec_Output_XOR:                                         ; Offset_0x001720
		eor.l   D4, D2
		move.l  D2, (A4)
		subq.w  #$01, A5
		move.w  A5, D4
		bne.s   NemesisDec_3                           ; Offset_0x0016E0
		rts
;-------------------------------------------------------------------------------
NemesisDec_OutputToRAM:                                        ; Offset_0x00172C
		move.l  D4, (A4)+
		subq.w  #$01, A5
		move.w  A5, D4
		bne.s   NemesisDec_3                           ; Offset_0x0016E0
		rts
;-------------------------------------------------------------------------------
NemesisDec_Output_XORToRAM:                                    ; Offset_0x001736
		eor.l   D4, D2
		move.l  D2, (A4)+
		subq.w  #$01, A5
		move.w  A5, D4
		bne.s   NemesisDec_3                           ; Offset_0x0016E0
		rts
;-------------------------------------------------------------------------------
NemesisDec_4:                                                  ; Offset_0x001742:
		move.b  (A0)+, D0
Offset_0x001744:
		cmpi.b  #$FF, D0
		bne.s   Offset_0x00174C
		rts
Offset_0x00174C:
		move.w  D0, D7
Offset_0x00174E:
		move.b  (A0)+, D0
		cmpi.b  #$80, D0
		bcc.s   Offset_0x001744
		move.b  D0, D1
		andi.w  #$000F, D7
		andi.w  #$0070, D1
		or.w    D1, D7
		andi.w  #$000F, D0
		move.b  D0, D1
		lsl.w   #$08, D1
		or.w    D1, D7
		moveq   #$08, D1
		sub.w   D0, D1
		bne.s   Offset_0x00177C
		move.b  (A0)+, D0
		add.w   D0, D0
		move.w  D7, $00(A1, D0)
		bra.s   Offset_0x00174E
Offset_0x00177C:
		move.b  (A0)+, D0
		lsl.w   D1, D0
		add.w   D0, D0
		moveq   #$01, D5
		lsl.w   D1, D5
		subq.w  #$01, D5
Offset_0x001788:
		move.w  D7, $00(A1, D0)
		addq.w  #$02, D0
		dbra    D5, Offset_0x001788
		bra.s   Offset_0x00174E                 
;===============================================================================
; Nemesis format decompression routine
; <<<-
;=============================================================================== 

;===============================================================================
; Routines for loading graphics into the ArtLoadCues array according to D0
; ->>>
;=============================================================================== 
LoadPLC:                                                       ; Offset_0x001794
		movem.l A1/A2, -(A7)
		lea     (ArtLoadCues), A1                      ; Offset_0x02E7D4
		add.w   D0, D0
		move.w  $00(A1, D0), D0
		lea     $00(A1, D0), A1
		lea     (PLC_Buffer).w, A2                           ; $FFFFF680
Offset_0x0017AC:
		tst.l   (A2)
		beq.s   Offset_0x0017B4
		addq.w  #$06, A2
		bra.s   Offset_0x0017AC
Offset_0x0017B4:
		move.w  (A1)+, D0
		bmi.s   Offset_0x0017C0
Offset_0x0017B8:
		move.l  (A1)+, (A2)+
		move.w  (A1)+, (A2)+
		dbra    D0, Offset_0x0017B8
Offset_0x0017C0:
		movem.l (A7)+, A1/A2
		rts 
;-------------------------------------------------------------------------------
LoadPLC2:                                                      ; Offset_0x0017C6
		movem.l A1/A2, -(A7)
		lea     (ArtLoadCues), A1                      ; Offset_0x02E7D4
		add.w   D0, D0
		move.w  $00(A1, D0), D0
		lea     $00(A1, D0), A1
		bsr.s   ClearPLC                               ; Offset_0x0017F2
		lea     (PLC_Buffer).w, A2                           ; $FFFFF680
		move.w  (A1)+, D0
		bmi.s   Offset_0x0017EC
Offset_0x0017E4:
		move.l  (A1)+, (A2)+
		move.w  (A1)+, (A2)+
		dbra    D0, Offset_0x0017E4
Offset_0x0017EC:
		movem.l (A7)+, A1/A2
		rts
;===============================================================================
; Routines for loading graphics into the ArtLoadCues array according to D0
; <<<-
;===============================================================================
		  
;===============================================================================
; Routine for clearing the Pattern Load Cue
; ->>>
;=============================================================================== 
ClearPLC:                                                      ; Offset_0x0017F2
		lea     (PLC_Buffer).w, A2                           ; $FFFFF680
		moveq   #$1F, D0
ClearPLC_Loop:                                                 ; Offset_0x0017F8
		clr.l   (A2)+
		dbra    D0, ClearPLC_Loop                      ; Offset_0x0017F8
		rts 
;===============================================================================
; Routine for clearing the Pattern Load Cue
; <<<-
;===============================================================================                 
   
;===============================================================================
; Routine for unpacking items in the Pattern Load Cue
; ->>>
;=============================================================================== 
RunPLC:                                                        ; Offset_0x001800
		tst.l   (PLC_Buffer).w                               ; $FFFFF680
		beq.s   Exit_RunPLC                            ; Offset_0x001854
		tst.w   ($FFFFF6F8).w
		bne.s   Exit_RunPLC                            ; Offset_0x001854
		move.l  (PLC_Buffer).w, A0                           ; $FFFFF680
		lea     NemesisDec_Output(PC), A3              ; Offset_0x001716
		nop
		lea     ($FFFFAA00).w, A1
		move.w  (A0)+, D2
		bpl.s   Offset_0x001822
		; Point A3 to NemesisDec_Output_XOR if A3 = NemesisDec_Output or
	      	; Point A3 to NemesisDec_OutputRAM_XOR if A3 = NemesisDec_OutputRAM
		adda.w  #(NemesisDec_Output_XOR-NemesisDec_Output), A3   ; $000A
Offset_0x001822:
		andi.w  #$7FFF, D2
		move.w  D2, ($FFFFF6F8).w
		bsr     NemesisDec_4                           ; Offset_0x001742
		move.b  (A0)+, D5
		asl.w   #$08, D5
		move.b  (A0)+, D5
		moveq   #$10, D6
		moveq   #$00, D0
		move.l  A0, (PLC_Buffer).w                           ; $FFFFF680
		move.l  A3, ($FFFFF6E0).w
		move.l  D0, ($FFFFF6E4).w
		move.l  D0, ($FFFFF6E8).w
		move.l  D0, ($FFFFF6EC).w
		move.l  D5, ($FFFFF6F0).w
		move.l  D6, ($FFFFF6F4).w
Exit_RunPLC:                                                   ; Offset_0x001854
		rts   
;===============================================================================
; Routine for unpacking items in the Pattern Load Cue
; <<<-
;===============================================================================
Offset_0x001856:
		tst.w   ($FFFFF6F8).w
		beq     Offset_0x0018EE
		move.w  #$0009, ($FFFFF6FA).w
		moveq   #$00, D0
		move.w  ($FFFFF684).w, D0
		addi.w  #$0120, ($FFFFF684).w
		bra.s   Offset_0x00188A
;-------------------------------------------------------------------------------
Offset_0x001872:
		tst.w   ($FFFFF6F8).w
		beq.s   Offset_0x0018EE
		move.w  #$0003, ($FFFFF6FA).w
		moveq   #$00, D0
		move.w  ($FFFFF684).w, D0
		addi.w  #$0060, ($FFFFF684).w
Offset_0x00188A:
		lea     (VDP_Control_Port), A4                       ; $00C00004
		lsl.l   #$02, D0
		lsr.w   #$02, D0
		ori.w   #$4000, D0
		swap.w  D0
		move.l  D0, (A4)
		subq.w  #$04, A4
		move.l  (PLC_Buffer).w, A0                           ; $FFFFF680
		move.l  ($FFFFF6E0).w, A3
		move.l  ($FFFFF6E4).w, D0
		move.l  ($FFFFF6E8).w, D1
		move.l  ($FFFFF6EC).w, D2
		move.l  ($FFFFF6F0).w, D5
		move.l  ($FFFFF6F4).w, D6
		lea     ($FFFFAA00).w, A1
Offset_0x0018BE:
		move.w  #$0008, A5
		bsr     NemesisDec_3                           ; Offset_0x0016E0
		subq.w  #$01, ($FFFFF6F8).w
		beq.s   Offset_0x0018F0
		subq.w  #$01, ($FFFFF6FA).w
		bne.s   Offset_0x0018BE
		move.l  A0, (PLC_Buffer).w                           ; $FFFFF680
		move.l  A3, ($FFFFF6E0).w
		move.l  D0, ($FFFFF6E4).w
		move.l  D1, ($FFFFF6E8).w
		move.l  D2, ($FFFFF6EC).w
		move.l  D5, ($FFFFF6F0).w
		move.l  D6, ($FFFFF6F4).w
Offset_0x0018EE:
		rts
Offset_0x0018F0:
		lea     (PLC_Buffer).w, A0                           ; $FFFFF680
		moveq   #$15, D0
Offset_0x0018F6:
		move.l  $0006(A0), (A0)+
		dbra    D0, Offset_0x0018F6
		rts   
;===============================================================================
; Load PLC's directly from ROM without queuing     
; ->>>
;=============================================================================== 
RunPLC_ROM:                                                    ; Offset_0x001900
		lea     (ArtLoadCues), A1                      ; Offset_0x02E7D4
		add.w   D0, D0
		move.w  $00(A1, D0), D0
		lea     $00(A1, D0), A1
		move.w  (A1)+, D1
RunPLC_ROM_Loop:                                               ; Offset_0x001912
		move.l  (A1)+, A0
		moveq   #$00, D0
		move.w  (A1)+, D0
		lsl.l   #$02, D0
		lsr.w   #$02, D0
		ori.w   #$4000, D0
		swap.w  D0
		move.l  D0, (VDP_Control_Port)                       ; $00C00004
		bsr     NemesisDec                             ; Offset_0x001654
		dbra    D1, RunPLC_ROM_Loop                    ; Offset_0x001912
		rts
;===============================================================================
; Load PLC's directly from ROM without queuing 
; <<<-
;===============================================================================                              

;===============================================================================
; Enigma format decompression routine
; ->>>
;===============================================================================  
EnigmaDec:                                                     ; Offset_0x001932
		movem.l D0-D7/A1-A5, -(A7)
		move.w  D0, A3
		move.b  (A0)+, D0
		ext.w   D0
		move.w  D0, A5
		move.b  (A0)+, D4
		lsl.b   #$03, D4
		move.w  (A0)+, A2
		adda.w  A3, A2
		move.w  (A0)+, A4
		adda.w  A3, A4
		move.b  (A0)+, D5
		asl.w   #$08, D5
		move.b  (A0)+, D5
		moveq   #$10, D6
Offset_0x001952:                
		moveq   #$07, D0   
		move.w  D6, D7
		sub.w   D0, D7
		move.w  D5, D1
		lsr.w   D7, D1
		andi.w  #$007F, D1
		move.w  D1, D2
		cmpi.w  #$0040, D1
		bcc.s   Offset_0x00196C
		moveq   #$06, D0
		lsr.w   #$01, D2
Offset_0x00196C:
		bsr     Offset_0x001AA0
		andi.w  #$000F, D2
		lsr.w   #$04, D1
		add.w   D1, D1
		jmp     Offset_0x0019C8(PC, D1)   
;-------------------------------------------------------------------------------
Offset_0x00197C:
		move.w  A2, (A1)+
		addq.w  #$01, A2
		dbra    D2, Offset_0x00197C
		bra.s   Offset_0x001952
;-------------------------------------------------------------------------------
Offset_0x001986:
		move.w  A4, (A1)+
		dbra    D2, Offset_0x001986
		bra.s   Offset_0x001952
;-------------------------------------------------------------------------------                
Offset_0x00198E:
		bsr     Offset_0x0019F0
Offset_0x001992:
		move.w  D1, (A1)+
		dbra    D2, Offset_0x001992
		bra.s   Offset_0x001952
;-------------------------------------------------------------------------------
Offset_0x00199A:
		bsr     Offset_0x0019F0
Offset_0x00199E:
		move.w  D1, (A1)+
		addq.w  #$01, D1
		dbra    D2, Offset_0x00199E
		bra.s   Offset_0x001952
;-------------------------------------------------------------------------------                
Offset_0x0019A8:
		bsr     Offset_0x0019F0
Offset_0x0019AC:
		move.w  D1, (A1)+
		subq.w  #$01, D1
		dbra    D2, Offset_0x0019AC
		bra.s   Offset_0x001952         
;-------------------------------------------------------------------------------
Offset_0x0019B6:
		cmpi.w  #$000F, D2
		beq.s   Offset_0x0019D8
Offset_0x0019BC:
		bsr     Offset_0x0019F0
		move.w  D1, (A1)+
		dbra    D2, Offset_0x0019BC
		bra.s   Offset_0x001952       
;------------------------------------------------------------------------------- 
Offset_0x0019C8:
		bra.s   Offset_0x00197C
		bra.s   Offset_0x00197C
		bra.s   Offset_0x001986
		bra.s   Offset_0x001986
		bra.s   Offset_0x00198E
		bra.s   Offset_0x00199A
		bra.s   Offset_0x0019A8
		bra.s   Offset_0x0019B6                
;-------------------------------------------------------------------------------
Offset_0x0019D8:
		subq.w  #$01, A0
		cmpi.w  #$0010, D6
		bne.s   Offset_0x0019E2
		subq.w  #$01, A0
Offset_0x0019E2:
		move.w  A0, D0
		lsr.w   #$01, D0
		bcc.s   Offset_0x0019EA
		addq.w  #$01, A0
Offset_0x0019EA:
		movem.l (A7)+, D0-D7/A1-A5
		rts
Offset_0x0019F0:
		move.w  A3, D3
		move.b  D4, D1
		add.b   D1, D1
		bcc.s   Offset_0x001A02
		subq.w  #$01, D6
		btst    D6, D5
		beq.s   Offset_0x001A02
		ori.w   #$8000, D3
Offset_0x001A02:
		add.b   D1, D1
		bcc.s   Offset_0x001A10
		subq.w  #$01, D6
		btst    D6, D5
		beq.s   Offset_0x001A10
		addi.w  #$4000, D3
Offset_0x001A10:
		add.b   D1, D1
		bcc.s   Offset_0x001A1E
		subq.w  #$01, D6
		btst    D6, D5
		beq.s   Offset_0x001A1E
		addi.w  #$2000, D3
Offset_0x001A1E:
		add.b   D1, D1
		bcc.s   Offset_0x001A2C
		subq.w  #$01, D6
		btst    D6, D5
		beq.s   Offset_0x001A2C
		ori.w   #$1000, D3
Offset_0x001A2C:
		add.b   D1, D1
		bcc.s   Offset_0x001A3A
		subq.w  #$01, D6
		btst    D6, D5
		beq.s   Offset_0x001A3A
		ori.w   #$0800, D3
Offset_0x001A3A:
		move.w  D5, D1
		move.w  D6, D7
		sub.w   A5, D7
		bcc.s   Offset_0x001A6A
		move.w  D7, D6
		addi.w  #$0010, D6
		neg.w   D7
		lsl.w   D7, D1
		move.b  (A0), D5
		rol.b   D7, D5
		add.w   D7, D7
		and.w   Offset_0x001A80-$02(PC, D7), D5
		add.w   D5, D1
Offset_0x001A58:
		move.w  A5, D0
		add.w   D0, D0
		and.w   Offset_0x001A80-$02(PC, D0), D1
		add.w   D3, D1
		move.b  (A0)+, D5
		lsl.w   #$08, D5
		move.b  (A0)+, D5
		rts
Offset_0x001A6A:
		beq.s   Offset_0x001A7C
		lsr.w   D7, D1
		move.w  A5, D0
		add.w   D0, D0
		and.w   Offset_0x001A80-$02(PC, D0), D1
		add.w   D3, D1
		move.w  A5, D0
		bra.s   Offset_0x001AA0
Offset_0x001A7C:
		moveq   #$10, D6
		bra.s   Offset_0x001A58                                                     
;-------------------------------------------------------------------------------
Offset_0x001A80:
		dc.w    $0001, $0003, $0007, $000F, $001F, $003F, $007F, $00FF
		dc.w    $01FF, $03FF, $07FF, $0FFF, $1FFF, $3FFF, $7FFF, $FFFF
;-------------------------------------------------------------------------------  
Offset_0x001AA0:
		sub.w   D0, D6
		cmpi.w  #$0009, D6
		bcc.s   Offset_0x001AAE
		addq.w  #$08, D6
		asl.w   #$08, D5
		move.b  (A0)+, D5
Offset_0x001AAE:
		rts             
;===============================================================================
; Enigma format decompression routine
; <<<-
;===============================================================================
  
;===============================================================================
; Kosinski format decompression routine
; ->>>
;=============================================================================== 
KosinskiDec:                                                   ; Offset_0x001AB0
		subq.l  #$02, A7
		move.b  (A0)+, $0001(A7)
		move.b  (A0)+, (A7)
		move.w  (A7), D5
		moveq   #$0F, D4
Offset_0x001ABC:
		lsr.w   #$01, D5
		move    SR, D6
		dbra    D4, Offset_0x001ACE
		move.b  (A0)+, $0001(A7)
		move.b  (A0)+, (A7)
		move.w  (A7), D5
		moveq   #$0F, D4
Offset_0x001ACE:
		move    D6, CCR
		bcc.s   Offset_0x001AD6
		move.b  (A0)+, (A1)+
		bra.s   Offset_0x001ABC
Offset_0x001AD6:
		moveq   #$00, D3
		lsr.w   #$01, D5
		move    SR, D6
		dbra    D4, Offset_0x001AEA
		move.b  (A0)+, $0001(A7)
		move.b  (A0)+, (A7)
		move.w  (A7), D5
		moveq   #$0F, D4
Offset_0x001AEA:
		move    D6, CCR
		bcs.s   Offset_0x001B1A
		lsr.w   #$01, D5
		dbra    D4, Offset_0x001AFE
		move.b  (A0)+, $0001(A7)
		move.b  (A0)+, (A7)
		move.w  (A7), D5
		moveq   #$0F, D4
Offset_0x001AFE:
		roxl.w  #$01, D3
		lsr.w   #$01, D5
		dbra    D4, Offset_0x001B10
		move.b  (A0)+, $0001(A7)
		move.b  (A0)+, (A7)
		move.w  (A7), D5
		moveq   #$0F, D4
Offset_0x001B10:
		roxl.w  #$01, D3
		addq.w  #$01, D3
		moveq   #-$01, D2
		move.b  (A0)+, D2
		bra.s   Offset_0x001B30
Offset_0x001B1A:
		move.b  (A0)+, D0
		move.b  (A0)+, D1
		moveq   #-$01, D2
		move.b  D1, D2
		lsl.w   #$05, D2
		move.b  D0, D2
		andi.w  #$0007, D1
		beq.s   Offset_0x001B3C
		move.b  D1, D3
		addq.w  #$01, D3
Offset_0x001B30:
		move.b  $00(A1, D2), D0
		move.b  D0, (A1)+
		dbra    D3, Offset_0x001B30
		bra.s   Offset_0x001ABC
Offset_0x001B3C:
		move.b  (A0)+, D1
		beq.s   Offset_0x001B4C
		cmpi.b  #$01, D1
		beq     Offset_0x001ABC
		move.b  D1, D3
		bra.s   Offset_0x001B30
Offset_0x001B4C:
		addq.l  #$02, A7
		rts 
;===============================================================================
; Kosinski format decompression routine
; <<<-
;===============================================================================
Offset_0x001B50:
		moveq   #$00, D0
		move.w  #$07FF, D4
		moveq   #$00, D5
		moveq   #$00, D6
		move.w  A3, D7
		subq.w  #$01, D2
		beq     Offset_0x001EF0
		subq.w  #$01, D2
		beq     Offset_0x001E72
		subq.w  #$01, D2
		beq     Offset_0x001DF4
		subq.w  #$01, D2
		beq     Offset_0x001D76
		subq.w  #$01, D2
		beq     Offset_0x001CFA
		subq.w  #$01, D2
		beq     Offset_0x001C7C
		subq.w  #$01, D2
		beq     Offset_0x001C02
Offset_0x001B86:
		move.b  (A0)+, D1
		add.b   D1, D1
		bcs.s   Offset_0x001C00
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001BA8
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001B9C
		move.b  (A6)+, (A2)+
Offset_0x001B9C:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001BF0
		bra     Offset_0x001CFA
Offset_0x001BA8:
		lsl.w   #$03, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001BBC
		add.b   D1, D1
		bcs.s   Offset_0x001BD2
		bra.s   Offset_0x001BD4
Offset_0x001BBC:
		add.b   D1, D1
		bcc.s   Offset_0x001BD0
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001BE2
		subq.w  #$06, D0
		bmi.s   Offset_0x001BE8
Offset_0x001BCA:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001BCA
Offset_0x001BD0:
		move.b  (A6)+, (A2)+
Offset_0x001BD2:
		move.b  (A6)+, (A2)+
Offset_0x001BD4:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001BF8
		bra     Offset_0x001EF0
Offset_0x001BE2:
		move.w  #$0000, D0
		rts
Offset_0x001BE8:
		move.w  #$FFFF, D0
		moveq   #$01, D2
		rts
Offset_0x001BF0:
		move.w  #$0001, D0
		moveq   #$05, D2
		rts
Offset_0x001BF8:
		move.w  #$0001, D0
		moveq   #$01, D2
		rts
Offset_0x001C00:
		move.b  (A1)+, (A2)+
Offset_0x001C02:
		add.b   D1, D1
		bcs.s   Offset_0x001C7A
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001C22
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001C16
		move.b  (A6)+, (A2)+
Offset_0x001C16:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001C6A
		bra     Offset_0x001D76
Offset_0x001C22:
		lsl.w   #$03, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001C36
		add.b   D1, D1
		bcs.s   Offset_0x001C4C
		bra.s   Offset_0x001C4E
Offset_0x001C36:
		add.b   D1, D1
		bcc.s   Offset_0x001C4A
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001C5C
		subq.w  #$06, D0
		bmi.s   Offset_0x001C62
Offset_0x001C44:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001C44
Offset_0x001C4A:
		move.b  (A6)+, (A2)+
Offset_0x001C4C:
		move.b  (A6)+, (A2)+
Offset_0x001C4E:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001C72
		bra     Offset_0x001B86
Offset_0x001C5C:
		move.w  #$0000, D0
		rts
Offset_0x001C62:
		move.w  #$FFFF, D0
		moveq   #$00, D2
		rts
Offset_0x001C6A:
		move.w  #$0001, D0
		moveq   #$04, D2
		rts
Offset_0x001C72:
		move.w  #$0001, D0
		moveq   #$00, D2
		rts
Offset_0x001C7A:
		move.b  (A1)+, (A2)+
Offset_0x001C7C:
		add.b   D1, D1
		bcs.s   Offset_0x001CF8
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001C9C
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001C90
		move.b  (A6)+, (A2)+
Offset_0x001C90:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001CE8
		bra     Offset_0x001DF4
Offset_0x001C9C:
		lsl.w   #$03, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001CB2
		move.b  (A0)+, D1
		add.b   D1, D1
		bcs.s   Offset_0x001CCA
		bra.s   Offset_0x001CCC
Offset_0x001CB2:
		move.b  (A0)+, D1
		add.b   D1, D1
		bcc.s   Offset_0x001CC8
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001CDA
		subq.w  #$06, D0
		bmi.s   Offset_0x001CE0
Offset_0x001CC2:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001CC2
Offset_0x001CC8:
		move.b  (A6)+, (A2)+
Offset_0x001CCA:
		move.b  (A6)+, (A2)+
Offset_0x001CCC:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001CF0
		bra     Offset_0x001C02
Offset_0x001CDA:
		move.w  #$0000, D0
		rts
Offset_0x001CE0:
		move.w  #$FFFF, D0
		moveq   #$07, D2
		rts
Offset_0x001CE8:
		move.w  #$0001, D0
		moveq   #$03, D2
		rts
Offset_0x001CF0:
		move.w  #$0001, D0
		moveq   #$07, D2
		rts
Offset_0x001CF8:
		move.b  (A1)+, (A2)+
Offset_0x001CFA:
		add.b   D1, D1
		bcs.s   Offset_0x001D74
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001D1A
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001D0E
		move.b  (A6)+, (A2)+
Offset_0x001D0E:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001D64
		bra     Offset_0x001E72
Offset_0x001D1A:
		lsl.w   #$03, D1
		move.b  (A0)+, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001D30
		add.b   D1, D1
		bcs.s   Offset_0x001D46
		bra.s   Offset_0x001D48
Offset_0x001D30:
		add.b   D1, D1
		bcc.s   Offset_0x001D44
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001D56
		subq.w  #$06, D0
		bmi.s   Offset_0x001D5C
Offset_0x001D3E:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001D3E
Offset_0x001D44:
		move.b  (A6)+, (A2)+
Offset_0x001D46:
		move.b  (A6)+, (A2)+
Offset_0x001D48:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001D6C
		bra     Offset_0x001C7C
Offset_0x001D56:
		move.w  #$0000, D0
		rts
Offset_0x001D5C:
		move.w  #$FFFF, D0
		moveq   #$06, D2
		rts
Offset_0x001D64:
		move.w  #$0001, D0
		moveq   #$02, D2
		rts
Offset_0x001D6C:
		move.w  #$0001, D0
		moveq   #$06, D2
		rts
Offset_0x001D74:
		move.b  (A1)+, (A2)+
Offset_0x001D76:
		add.b   D1, D1
		bcs.s   Offset_0x001DF2
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001D96
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001D8A
		move.b  (A6)+, (A2)+
Offset_0x001D8A:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001DE2
		bra     Offset_0x001EF0
Offset_0x001D96:
		lsl.w   #$02, D1
		move.b  (A0)+, D1
		add.w   D1, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001DAE
		add.b   D1, D1
		bcs.s   Offset_0x001DC4
		bra.s   Offset_0x001DC6
Offset_0x001DAE:
		add.b   D1, D1
		bcc.s   Offset_0x001DC2
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001DD4
		subq.w  #$06, D0
		bmi.s   Offset_0x001DDA
Offset_0x001DBC:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001DBC
Offset_0x001DC2:
		move.b  (A6)+, (A2)+
Offset_0x001DC4:
		move.b  (A6)+, (A2)+
Offset_0x001DC6:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001DEA
		bra     Offset_0x001CFA
Offset_0x001DD4:
		move.w  #$0000, D0
		rts
Offset_0x001DDA:
		move.w  #$FFFF, D0
		moveq   #$05, D2
		rts
Offset_0x001DE2:
		move.w  #$0001, D0
		moveq   #$01, D2
		rts
Offset_0x001DEA:
		move.w  #$0001, D0
		moveq   #$05, D2
		rts
Offset_0x001DF2:
		move.b  (A1)+, (A2)+
Offset_0x001DF4:
		add.b   D1, D1
		bcs.s   Offset_0x001E70
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001E14
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001E08
		move.b  (A6)+, (A2)+
Offset_0x001E08:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001E60
		bra     Offset_0x001B86
Offset_0x001E14:
		add.w   D1, D1
		move.b  (A0)+, D1
		lsl.w   #$02, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001E2C
		add.b   D1, D1
		bcs.s   Offset_0x001E42
		bra.s   Offset_0x001E44
Offset_0x001E2C:
		add.b   D1, D1
		bcc.s   Offset_0x001E40
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001E52
		subq.w  #$06, D0
		bmi.s   Offset_0x001E58
Offset_0x001E3A:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001E3A
Offset_0x001E40:
		move.b  (A6)+, (A2)+
Offset_0x001E42:
		move.b  (A6)+, (A2)+
Offset_0x001E44:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001E68
		bra     Offset_0x001D76
Offset_0x001E52:
		move.w  #$0000, D0
		rts
Offset_0x001E58:
		move.w  #$FFFF, D0
		moveq   #$04, D2
		rts
Offset_0x001E60:
		move.w  #$0001, D0
		moveq   #$08, D2
		rts
Offset_0x001E68:
		move.w  #$0001, D0
		moveq   #$04, D2
		rts
Offset_0x001E70:
		move.b  (A1)+, (A2)+
Offset_0x001E72:
		add.b   D1, D1
		bcs.s   Offset_0x001EEE
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001E94
		move.b  (A0)+, D1
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001E88
		move.b  (A6)+, (A2)+
Offset_0x001E88:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001EDE
		bra     Offset_0x001C02
Offset_0x001E94:
		move.b  (A0)+, D1
		lsl.w   #$03, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001EAA
		add.b   D1, D1
		bcs.s   Offset_0x001EC0
		bra.s   Offset_0x001EC2
Offset_0x001EAA:
		add.b   D1, D1
		bcc.s   Offset_0x001EBE
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001ED0
		subq.w  #$06, D0
		bmi.s   Offset_0x001ED6
Offset_0x001EB8:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001EB8
Offset_0x001EBE:
		move.b  (A6)+, (A2)+
Offset_0x001EC0:
		move.b  (A6)+, (A2)+
Offset_0x001EC2:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001EE6
		bra     Offset_0x001DF4
Offset_0x001ED0:
		move.w  #$0000, D0
		rts
Offset_0x001ED6:
		move.w  #$FFFF, D0
		moveq   #$03, D2
		rts
Offset_0x001EDE:
		move.w  #$0001, D0
		moveq   #$07, D2
		rts
Offset_0x001EE6:
		move.w  #$0001, D0
		moveq   #$03, D2
		rts
Offset_0x001EEE:
		move.b  (A1)+, (A2)+
Offset_0x001EF0:
		add.b   D1, D1
		bcs.s   Offset_0x001F6A
		move.b  (A0)+, D1
		move.l  A2, A6
		add.b   D1, D1
		bcs.s   Offset_0x001F12
		move.b  (A1)+, D5
		suba.l  D5, A6
		add.b   D1, D1
		bcc.s   Offset_0x001F06
		move.b  (A6)+, (A2)+
Offset_0x001F06:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001F5A
		bra     Offset_0x001C7C
Offset_0x001F12:
		lsl.w   #$03, D1
		move.w  D1, D6
		and.w   D4, D6
		move.b  (A1)+, D6
		suba.l  D6, A6
		add.b   D1, D1
		bcs.s   Offset_0x001F26
		add.b   D1, D1
		bcs.s   Offset_0x001F3C
		bra.s   Offset_0x001F3E
Offset_0x001F26:
		add.b   D1, D1
		bcc.s   Offset_0x001F3A
		moveq   #$00, D0
		move.b  (A1)+, D0
		beq.s   Offset_0x001F4C
		subq.w  #$06, D0
		bmi.s   Offset_0x001F52
Offset_0x001F34:
		move.b  (A6)+, (A2)+
		dbra    D0, Offset_0x001F34
Offset_0x001F3A:
		move.b  (A6)+, (A2)+
Offset_0x001F3C:
		move.b  (A6)+, (A2)+
Offset_0x001F3E:
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		move.b  (A6)+, (A2)+
		cmp.w   A2, D7
		bls.s   Offset_0x001F62
		bra     Offset_0x001E72
Offset_0x001F4C:
		move.w  #$0000, D0
		rts
Offset_0x001F52:
		move.w  #$FFFF, D0
		moveq   #$02, D2
		rts
Offset_0x001F5A:
		move.w  #$0001, D0
		moveq   #$06, D2
		rts
Offset_0x001F62:
		move.w  #$0001, D0
		moveq   #$02, D2
		rts
Offset_0x001F6A:
		move.b  (A1)+, (A2)+
		bra     Offset_0x001B86 
;===============================================================================
; Rotina de alternação de paleta de cores
; ->>>
;=============================================================================== 
PalCycle_Load:                                                 ; Offset_0x001F70
		bsr     PalCycle_SuperSonic                    ; Offset_0x0024CE
		moveq   #$00, D2
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		move.w  PalCycle_Load_List(PC, D0), D0         ; Offset_0x001F88
		jmp     PalCycle_Load_List(PC, D0)             ; Offset_0x001F88
		rts
;-------------------------------------------------------------------------------                
PalCycle_Load_List:                                            ; Offset_0x001F88
		dc.w    PalCycle_GHz-PalCycle_Load_List        ; Offset_0x001FAC
		dc.w    PalCycle_Lvl1-PalCycle_Load_List       ; Offset_0x001FAA
		dc.w    PalCycle_Wz-PalCycle_Load_List         ; Offset_0x001FDA
		dc.w    PalCycle_Lvl3-PalCycle_Load_List       ; Offset_0x001FAA
		dc.w    PalCycle_Mz-PalCycle_Load_List         ; Offset_0x00200A
		dc.w    PalCycle_Mz-PalCycle_Load_List         ; Offset_0x00200A
		dc.w    PalCycle_Lvl6-PalCycle_Load_List       ; Offset_0x001FAA
		dc.w    PalCycle_HTz-PalCycle_Load_List        ; Offset_0x0020A0
		dc.w    PalCycle_HPz-PalCycle_Load_List        ; Offset_0x0020E4
		dc.w    PalCycle_Lvl9-PalCycle_Load_List       ; Offset_0x001FAA
		dc.w    PalCycle_OOz-PalCycle_Load_List        ; Offset_0x002126
		dc.w    PalCycle_DHz-PalCycle_Load_List        ; Offset_0x002154
		dc.w    PalCycle_CNz-PalCycle_Load_List        ; Offset_0x00217C
		dc.w    PalCycle_CPz-PalCycle_Load_List        ; Offset_0x00221C
		dc.w    PalCycle_GCz-PalCycle_Load_List        ; Offset_0x001FAA
		dc.w    PalCycle_NGHz-PalCycle_Load_List       ; Offset_0x00228E
		dc.w    PalCycle_DEz-PalCycle_Load_List        ; Offset_0x001FAA        
;-------------------------------------------------------------------------------
; Rotina para as fases sem paleta ciclíca
; ->>>
;-------------------------------------------------------------------------------
PalCycle_Lvl1:                                                 ; Offset_0x001FAA
PalCycle_Lvl3:
PalCycle_Lvl6:
PalCycle_Lvl9:
PalCycle_GCz:
PalCycle_DEz: 
		rts
;-------------------------------------------------------------------------------
; Rotina para as fases sem paleta ciclíca
; <<<-
;------------------------------------------------------------------------------- 

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Green Hill
; ->>>
;-------------------------------------------------------------------------------  
PalCycle_GHz:                                                  ; Offset_0x001FAC
		lea     (Pal_GHzCyc), A0                       ; Offset_0x0022DC
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x001FD8
		move.w  #$0007, ($FFFFF634).w
		move.w  ($FFFFF632).w, D0
		addq.w  #$01, ($FFFFF632).w
		andi.w  #$0003, D0
		lsl.w   #$03, D0
		move.l  $00(A0, D0), ($FFFFFB26).w
		move.l  $04(A0, D0), ($FFFFFB3C).w
Offset_0x001FD8:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Green Hill
; <<<-
;-------------------------------------------------------------------------------                
		
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Wood
; ->>>
;-------------------------------------------------------------------------------      
PalCycle_Wz:                                                   ; Offset_0x001FDA
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x002008
		move.w  #$0002, ($FFFFF634).w
		lea     (Pal_WzCyc), A0                        ; Offset_0x00237C
		move.w  ($FFFFF632).w, D0
		subq.w  #$02, ($FFFFF632).w
		bcc.s   Offset_0x001FFC
		move.w  #$0006, ($FFFFF632).w
Offset_0x001FFC:
		lea     ($FFFFFB66).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
Offset_0x002008:
		rts   
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Wood
; <<<-
;-------------------------------------------------------------------------------  

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Metropolis
; ->>>
;-------------------------------------------------------------------------------  
PalCycle_Mz:                                                   ; Offset_0x00200A
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x00203A
		move.w  #$0011, ($FFFFF634).w
		lea     (Pal_MzCyc1), A0                       ; Offset_0x00238C
		move.w  ($FFFFF632).w, D0
		addq.w  #$02, ($FFFFF632).w
		cmpi.w  #$000C, ($FFFFF632).w
		bcs.s   Offset_0x002032
		move.w  #$0000, ($FFFFF632).w
Offset_0x002032:
		lea     ($FFFFFB4A).w, A1
		move.w  $00(A0, D0), (A1)
Offset_0x00203A:
		subq.w  #$01, ($FFFFF666).w
		bpl.s   Offset_0x00206E
		move.w  #$0002, ($FFFFF666).w
		lea     (Pal_MzCyc2), A0                       ; Offset_0x002398
		move.w  ($FFFFF652).w, D0
		addq.w  #$02, ($FFFFF652).w
		cmpi.w  #$0006, ($FFFFF652).w
		bcs.s   Offset_0x002062
		move.w  #$0000, ($FFFFF652).w
Offset_0x002062:
		lea     ($FFFFFB42).w, A1
		move.l  $00(A0, D0), (A1)+
		move.w  $04(A0, D0), (A1)
Offset_0x00206E:
		subq.w  #$01, ($FFFFF668).w
		bpl.s   Offset_0x00209E
		move.w  #$0009, ($FFFFF668).w
		lea     (Pal_MzCyc3), A0                       ; Offset_0x0023A4
		move.w  ($FFFFF654).w, D0
		addq.w  #$02, ($FFFFF654).w
		cmpi.w  #$0014, ($FFFFF654).w
		bcs.s   Offset_0x002096
		move.w  #$0000, ($FFFFF654).w
Offset_0x002096:
		lea     ($FFFFFB5E).w, A1
		move.w  $00(A0, D0), (A1)
Offset_0x00209E:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Metropolis
; <<<-
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Hill Top
; ->>>
;-------------------------------------------------------------------------------
PalCycle_HTz:                                                  ; Offset_0x0020A0
		lea     (Pal_HTzCyc), A0                       ; Offset_0x0022FC
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x0020D2
		move.w  #$0000, ($FFFFF634).w
		move.w  ($FFFFF632).w, D0
		addq.w  #$01, ($FFFFF632).w
		andi.w  #$000F, D0
		move.b  Pal_HTzCyc_Data(PC, D0), ($FFFFF635).w ; Offset_0x0020D4
		lsl.w   #$03, D0
		move.l  $00(A0, D0), ($FFFFFB26).w
		move.l  $04(A0, D0), ($FFFFFB3C).w
Offset_0x0020D2:
		rts  
;-------------------------------------------------------------------------------                
Pal_HTzCyc_Data:                                               ; Offset_0x0020D4
		dc.b    $0B, $0B, $0B, $0A, $08, $0A, $0B, $0B
		dc.b    $0B, $0B, $0D, $0F, $0D, $0B, $0B, $0B                                                                    
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Hill Top
; <<<-
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Hidden Palace
; ->>>
;-------------------------------------------------------------------------------
PalCycle_HPz:                                                  ; Offset_0x0020E4
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x002124
		move.w  #$0004, ($FFFFF634).w
		lea     (Pal_HPzCyc1), A0                      ; Offset_0x0023B8
		move.w  ($FFFFF632).w, D0
		subq.w  #$02, ($FFFFF632).w
		bcc.s   Offset_0x002106
		move.w  #$0006, ($FFFFF632).w
Offset_0x002106:
		lea     ($FFFFFB72).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
		lea     (Pal_HPzCyc2), A0                      ; Offset_0x0023C8
		lea     ($FFFFFAF2).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
Offset_0x002124:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Hidden Palace
; <<<-
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Oil Ocean
; ->>>
;-------------------------------------------------------------------------------
PalCycle_OOz:                                                  ; Offset_0x002126
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x002152
		move.w  #$0007, ($FFFFF634).w
		lea     (Pal_OOzCyc), A0                       ; Offset_0x0023D8
		move.w  ($FFFFF632).w, D0
		addq.w  #$02, ($FFFFF632).w
		andi.w  #$0006, ($FFFFF632).w
		lea     ($FFFFFB54).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
Offset_0x002152:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Oil Ocean
; <<<-
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Dust Hill
; ->>>
;-------------------------------------------------------------------------------
PalCycle_DHz:                                                  ; Offset_0x002154
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x00217A
		move.w  #$0001, ($FFFFF634).w
		lea     (Pal_DHzCyc), A0                       ; Offset_0x0023E8
		move.w  ($FFFFF632).w, D0
		addq.w  #$02, ($FFFFF632).w
		andi.w  #$0006, ($FFFFF632).w
		move.w  $00(A0, D0), ($FFFFFB36).w
Offset_0x00217A:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Dust Hill
; <<<-
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Casino Night
; ->>>
;-------------------------------------------------------------------------------
PalCycle_CNz:                                                  ; Offset_0x00217C
		subq.w  #$01, ($FFFFF634).w
		bpl     Offset_0x00221A
		move.w  #$0007, ($FFFFF634).w
		lea     (Pal_CNzCyc1), A0                      ; Offset_0x0023F0
		move.w  ($FFFFF632).w, D0
		addq.w  #$02, ($FFFFF632).w
		cmpi.w  #$0006, ($FFFFF632).w
		bcs.s   Offset_0x0021A6
		move.w  #$0000, ($FFFFF632).w
Offset_0x0021A6:
		lea     $00(A0, D0), A0
		lea     (Palette_Buffer).w, A1                       ; $FFFFFB00
		move.w  $0000(A0), $004A(A1)
		move.w  $0006(A0), $004C(A1)
		move.w  $000C(A0), $004E(A1)
		move.w  $0012(A0), $0056(A1)
		move.w  $0018(A0), $0058(A1)
		move.w  $001E(A0), $005A(A1)
		lea     (Pal_CNzCyc2), A0                      ; Offset_0x002414
		lea     $00(A0, D0), A0
		move.w  $0000(A0), $0064(A1)
		move.w  $0006(A0), $0066(A1)
		move.w  $000C(A0), $0068(A1)
		lea     (Pal_CNzCyc3), A0                      ; Offset_0x002426
		move.w  ($FFFFF652).w, D0
		addq.w  #$02, ($FFFFF652).w
		cmpi.w  #$0024, ($FFFFF652).w
		bcs.s   Offset_0x00220A
		move.w  #$0000, ($FFFFF652).w
Offset_0x00220A:
		lea     ($FFFFFB72).w, A1
		move.w  $04(A0, D0), (A1)+
		move.w  $02(A0, D0), (A1)+
		move.w  $00(A0, D0), (A1)+
Offset_0x00221A:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Casino Night
; <<<-
;-------------------------------------------------------------------------------
		
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Chemical Plant
; ->>>
;-------------------------------------------------------------------------------
PalCycle_CPz:                                                  ; Offset_0x00221C
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x00228C
		move.w  #$0007, ($FFFFF634).w
		lea     (Pal_CPzCyc1), A0                      ; Offset_0x00244E
		move.w  ($FFFFF632).w, D0
		addq.w  #$06, ($FFFFF632).w
		cmpi.w  #$0036, ($FFFFF632).w
		bcs.s   Offset_0x002244
		move.w  #$0000, ($FFFFF632).w
Offset_0x002244:
		lea     ($FFFFFB78).w, A1
		move.l  $00(A0, D0), (A1)+
		move.w  $04(A0, D0), (A1)
		lea     (Pal_CPzCyc2), A0                      ; Offset_0x002484
		move.w  ($FFFFF652).w, D0
		addq.w  #$02, ($FFFFF652).w
		cmpi.w  #$002A, ($FFFFF652).w
		bcs.s   Offset_0x00226C
		move.w  #$0000, ($FFFFF652).w
Offset_0x00226C:
		move.w  $00(A0, D0), ($FFFFFB7E).w
		lea     (Pal_CPzCyc3), A0                      ; Offset_0x0024AE
		move.w  ($FFFFF654).w, D0
		addq.w  #$02, ($FFFFF654).w
		andi.w  #$001E, ($FFFFF654).w
		move.w  $00(A0, D0), ($FFFFFB5E).w
Offset_0x00228C:
		rts
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Chemical Plant
; <<<-
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Neo Green Hill
; ->>>
;-------------------------------------------------------------------------------
PalCycle_NGHz:                                                 ; Offset_0x00228E
		lea     (Pal_NGHzCyc), A0                      ; Offset_0x0022DC
		subq.w  #$01, ($FFFFF634).w
		bpl.s   Offset_0x0022BA
		move.w  #$0005, ($FFFFF634).w
		move.w  ($FFFFF632).w, D0
		addq.w  #$01, ($FFFFF632).w
		andi.w  #$0003, D0
		lsl.w   #$03, D0
		lea     ($FFFFFB44).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
Offset_0x0022BA:
		rts    
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas da Neo Green Hill
; <<<-
;-------------------------------------------------------------------------------
; Pal_S1_Title_Screen: ; Left over                             ; Offset_0x0022BC
		dc.w    $0C42, $0E86, $0ECA, $0EEC, $0EEC, $0C42, $0E86, $0ECA
		dc.w    $0ECA, $0EEC, $0C42, $0E86, $0E86, $0ECA, $0EEC, $0C42
;-------------------------------------------------------------------------------  
Pal_GHzCyc:                                                    ; Offset_0x0022DC  
Pal_NGHzCyc:                                                   ; Offset_0x0022DC
		dc.w    $0A86, $0E86, $0EA8, $0ECA, $0ECA, $0A86, $0E86, $0EA8
		dc.w    $0EA8, $0ECA, $0A86, $0E86, $0E86, $0EA8, $0ECA, $0A86
;-------------------------------------------------------------------------------  
Pal_HTzCyc:                                                    ; Offset_0x0022FC  
		dc.w    $000E, $006E, $00AE, $00EE, $00EE, $000E, $006E, $00AE
		dc.w    $02CE, $00EE, $000E, $006E, $006E, $04EE, $08EE, $002E
		dc.w    $004E, $008E, $06EE, $0AEE, $08EE, $002E, $006E, $04EE
		dc.w    $02CE, $00EE, $000E, $006E, $006E, $02CE, $00EE, $000E
		dc.w    $000E, $006E, $00AE, $00EE, $00CE, $000C, $004E, $008E
		dc.w    $006E, $00AC, $000A, $002E, $000C, $004C, $008E, $0008
		dc.w    $000A, $002E, $006E, $00AC, $00CE, $000C, $004E, $008E
		dc.w    $00AE, $00EE, $000E, $006E, $006E, $00AE, $00EE, $000E 
;-------------------------------------------------------------------------------  
Pal_WzCyc:                                                     ; Offset_0x00237C 
		dc.w    $0248, $046A, $048C, $06CE, $0248, $046A, $048C, $06CE
;-------------------------------------------------------------------------------   
Pal_MzCyc1:                                                    ; Offset_0x00238C 
		dc.w    $0006, $0008, $000A, $000C, $000A, $0008 
;-------------------------------------------------------------------------------
Pal_MzCyc2:                                                    ; Offset_0x002398 
		dc.w    $0422, $0866, $0ECC, $0422, $0866, $0ECC  
;-------------------------------------------------------------------------------  
Pal_MzCyc3:                                                    ; Offset_0x0023A4   
		dc.w    $00A0, $0000, $00EE, $0000, $002E, $0000, $0E2E, $0000
		dc.w    $0E80, $0000 
;------------------------------------------------------------------------------- 
Pal_HPzCyc1:                                                   ; Offset_0x0023B8  
		dc.w    $0E44, $0E82, $0EA8, $0EEE, $0E44, $0E82, $0EA8, $0EEE 
;------------------------------------------------------------------------------- 
Pal_HPzCyc2:                                                   ; Offset_0x0023C8  
		dc.w    $0E84, $0EA6, $0EC6, $0EE6, $0E84, $0EA6, $0EC6, $0EE6
;-------------------------------------------------------------------------------  
Pal_OOzCyc:                                                    ; Offset_0x0023D8 
		dc.w    $0400, $0602, $0804, $0806, $0400, $0602, $0804, $0806 
;-------------------------------------------------------------------------------  
Pal_DHzCyc:                                                    ; Offset_0x0023E8  
		dc.w    $000C, $006E, $00CE, $08EE  
;-------------------------------------------------------------------------------    
Pal_CNzCyc1:                                                   ; Offset_0x0023F0    
		dc.w    $000E, $00EE, $006E, $006E, $000E, $00EE, $00EE, $006E
		dc.w    $000E, $00EC, $0080, $00C4, $00C4, $00EC, $0080, $0080
		dc.w    $00C4, $00EC    
;-------------------------------------------------------------------------------  
Pal_CNzCyc2:                                                   ; Offset_0x002414   
		dc.w    $0044, $0088, $00EE, $0088, $00EE, $0044, $00EE, $0044
		dc.w    $0088 
;-------------------------------------------------------------------------------    
Pal_CNzCyc3:                                                   ; Offset_0x002426     
		dc.w    $008E, $00AE, $00EC, $0EEE, $00EA, $00E4, $06C0, $0CC4
		dc.w    $0E80, $0E40, $0E04, $0C08, $0C2E, $080E, $040E, $000E
		dc.w    $004E, $006E, $008E, $00AE     
;-------------------------------------------------------------------------------  
Pal_CPzCyc1:                                                   ; Offset_0x00244E 
		dc.w    $0E40, $0C00, $0C00, $0E60, $0C20, $0C00, $0E40, $0E40
		dc.w    $0C00, $0C20, $0E60, $0C20, $0C00, $0E40, $0C40, $0C00
		dc.w    $0C20, $0E40, $0C00, $0C00, $0E60, $0C20, $0C00, $0E40
		dc.w    $0E20, $0C00, $0C20
;------------------------------------------------------------------------------- 
Pal_CPzCyc2:                                                   ; Offset_0x002484   
		dc.w    $00E0, $00C2, $00A4, $0086, $0068, $004A, $002C, $000E
		dc.w    $020C, $040A, $0608, $0806, $0A04, $0C02, $0E00, $0C20
		dc.w    $0A40, $0860, $0680, $04A0, $02C0
;------------------------------------------------------------------------------- 
Pal_CPzCyc3:                                                   ; Offset_0x0024AE  
		dc.w    $000E, $000C, $000A, $0008, $0006, $0004, $0002, $0004
		dc.w    $0006, $0008, $000A, $000C, $000E, $002E, $004E, $002E
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas do Super Sonic
; ->>>
;------------------------------------------------------------------------------- 
PalCycle_SuperSonic:                                           ; Offset_0x0024CE
		tst.b   ($FFFFF65F).w
		beq.s   Offset_0x002510
		bmi.s   Offset_0x002512
		subq.b  #$01, ($FFFFF65E).w
		bpl.s   Offset_0x002510
		move.b  #$03, ($FFFFF65E).w
		lea     (Pal_SuperSonic_Cyc), A0               ; Offset_0x002548
		move.w  ($FFFFF65C).w, D0
		addq.w  #$08, ($FFFFF65C).w
		cmpi.w  #$0030, ($FFFFF65C).w
		bcs.s   Offset_0x002504
		move.b  #$FF, ($FFFFF65F).w
		move.b  #$00, ($FFFFB02A).w
Offset_0x002504:
		lea     ($FFFFFB04).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
Offset_0x002510:
		rts
Offset_0x002512:
		subq.b  #$01, ($FFFFF65E).w
		bpl.s   Offset_0x002510
		move.b  #$07, ($FFFFF65E).w
		lea     (Pal_SuperSonic_Cyc), A0               ; Offset_0x002548
		move.w  ($FFFFF65C).w, D0
		addq.w  #$08, ($FFFFF65C).w
		cmpi.w  #$0078, ($FFFFF65C).w
		bcs.s   Offset_0x00253A
		move.w  #$0030, ($FFFFF65C).w
Offset_0x00253A:
		lea     ($FFFFFB04).w, A1
		move.l  $00(A0, D0), (A1)+
		move.l  $04(A0, D0), (A1)
		rts 
;-------------------------------------------------------------------------------                
Pal_SuperSonic_Cyc:                                            ; Offset_0x002548
		incbin "Palettes/SuperSonic_C.bin"
		even
;-------------------------------------------------------------------------------
; Rotina para as paletas ciclícas do Super Sonic
; <<<-
;------------------------------------------------------------------------------- 

;===============================================================================
; Rotina de alternação de paleta de cores
; <<<-
;===============================================================================  

;===============================================================================
; Rotinas para escurecer / clarear a tela progressivamente
; ->>>
;=============================================================================== 
Pal_FadeTo:                                                    ; Offset_0x0025C8
		move.w  #$003F, ($FFFFF626).w
Pal_FadeTo_2:                                                  ; Offset_0x0025CE                
		moveq   #$00, D0
		lea     (Palette_Buffer).w, A0                       ; $FFFFFB00
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		moveq   #$00, D1
		move.b  ($FFFFF627).w, D0
Offset_0x0025E0:
		move.w  D1, (A0)+
		dbra    D0, Offset_0x0025E0
		move.w  #$0015, D4
Pal_FadeTo_Loop:                                               ; Offset_0x0025EA
		move.b  #$12, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr.s   Pal_FadeIn                             ; Offset_0x002600
		bsr     RunPLC                                 ; Offset_0x001800
		dbra    D4, Pal_FadeTo_Loop                    ; Offset_0x0025EA
		rts
;-------------------------------------------------------------------------------                                                                         
Pal_FadeIn:                                                    ; Offset_0x002600
		moveq   #$00, D0
		lea     (Palette_Buffer).w, A0                       ; $FFFFFB00
		lea     (Palette_Underwater_Buffer).w, A1            ; $FFFFFB80
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		adda.w  D0, A1
		move.b  ($FFFFF627).w, D0
Offset_0x002616:
		bsr.s   Pal_AddColor                           ; Offset_0x002640
		dbra    D0, Offset_0x002616
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   Offset_0x00263E
		moveq   #$00, D0
		lea     ($FFFFFA80).w, A0
		lea     ($FFFFFA00).w, A1
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		adda.w  D0, A1
		move.b  ($FFFFF627).w, D0
Offset_0x002638:
		bsr.s   Pal_AddColor                           ; Offset_0x002640
		dbra    D0, Offset_0x002638
Offset_0x00263E:
		rts
;-------------------------------------------------------------------------------                                                                            
Pal_AddColor:                                                  ; Offset_0x002640
		move.w  (A1)+, D2
		move.w  (A0), D3
		cmp.w   D2, D3
		beq.s   Pal_NoAdd                              ; Offset_0x002668
Pal_AddBlue:                
		move.w  D3, D1
		addi.w  #$0200, D1
		cmp.w   D2, D1
		bhi.s   Pal_AddGreen                           ; Offset_0x002656
		move.w  D1, (A0)+
		rts
Pal_AddGreen:                                                  ; Offset_0x002656
		move.w  D3, D1
		addi.w  #$0020, D1
		cmp.w   D2, D1
		bhi.s   Pal_AddRed                             ; Offset_0x002664
		move.w  D1, (A0)+
		rts
Pal_AddRed:                                                    ; Offset_0x002664
		addq.w  #$02, (A0)+
		rts
Pal_NoAdd:                                                     ; Offset_0x002668
		addq.w  #$02, A0
		rts
;-------------------------------------------------------------------------------
Pal_FadeFrom:                                                  ; Offset_0x00266C
		move.w  #$003F, ($FFFFF626).w
		move.w  #$0015, D4
Pal_FadeFrom_Loop:                                             ; Offset_0x002676
		move.b  #$12, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr.s   Pal_FadeOut                            ; Offset_0x00268C
		bsr     RunPLC                                 ; Offset_0x001800
		dbra    D4, Pal_FadeFrom_Loop                  ; Offset_0x002676
		rts
;-------------------------------------------------------------------------------                
Pal_FadeOut:                                                   ; Offset_0x00268C
		moveq   #$00, D0
		lea     (Palette_Buffer).w, A0                       ; $FFFFFB00
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		move.b  ($FFFFF627).w, D0
Offset_0x00269C:
		bsr.s   Pal_DecColor                           ; Offset_0x0026BA
		dbra    D0, Offset_0x00269C
		moveq   #$00, D0
		lea     ($FFFFFA80).w, A0
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		move.b  ($FFFFF627).w, D0
Offset_0x0026B2:
		bsr.s   Pal_DecColor                           ; Offset_0x0026BA
		dbra    D0, Offset_0x0026B2
		rts
;-------------------------------------------------------------------------------                                                                            
Pal_DecColor:                                                  ; Offset_0x0026BA
		move.w  (A0), D2
		beq.s   Pal_NoDec                              ; Offset_0x0026E6
Pal_DecRed:                
		move.w  D2, D1
		andi.w  #$000E, D1
		beq.s   Pal_DecGreen                           ; Offset_0x0026CA
		subq.w  #$02, (A0)+
		rts
Pal_DecGreen:                                                  ; Offset_0x0026CA
		move.w  D2, D1
		andi.w  #$00E0, D1
		beq.s   Pal_DecBlue                            ; Offset_0x0026D8
		subi.w  #$0020, (A0)+
		rts
Pal_DecBlue:                                                   ; Offset_0x0026D8
		move.w  D2, D1
		andi.w  #$0E00, D1
		beq.s   Pal_NoDec                              ; Offset_0x0026E6
		subi.w  #$0200, (A0)+
		rts
Pal_NoDec:                                                     ; Offset_0x0026E6
		addq.w  #$02, A0
		rts       
;------------------------------------------------------------------------------- 
Pal_MakeWhite: ; Usado pelo Special Stage                      ; Offset_0x0026EA
		move.w  #$003F, ($FFFFF626).w
		moveq   #$00, D0
		lea     (Palette_Buffer).w, A0                       ; $FFFFFB00
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		move.w  #$0EEE, D1
		move.b  ($FFFFF627).w, D0
Offset_0x002704:
		move.w  D1, (A0)+
		dbra    D0, Offset_0x002704
		move.w  #$0015, D4
Offset_0x00270E:
		move.b  #$12, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr.s   Pal_WhiteToBlack                       ; Offset_0x002724
		bsr     RunPLC                                 ; Offset_0x001800
		dbra    D4, Offset_0x00270E
		rts
;-------------------------------------------------------------------------------                                                                           
Pal_WhiteToBlack:                                              ; Offset_0x002724
		moveq   #$00, D0
		lea     (Palette_Buffer).w, A0                       ; $FFFFFB00
		lea     (Palette_Underwater_Buffer).w, A1            ; $FFFFFB80
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		adda.w  D0, A1
		move.b  ($FFFFF627).w, D0
Offset_0x00273A:
		bsr.s   Pal_DecColor_2                         ; Offset_0x002764
		dbra    D0, Offset_0x00273A
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   Offset_0x002762
		moveq   #$00, D0
		lea     ($FFFFFA80).w, A0
		lea     ($FFFFFA00).w, A1
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		adda.w  D0, A1
		move.b  ($FFFFF627).w, D0
Offset_0x00275C:
		bsr.s   Pal_DecColor_2                         ; Offset_0x002764
		dbra    D0, Offset_0x00275C
Offset_0x002762:
		rts
;-------------------------------------------------------------------------------  
Pal_DecColor_2:                                                ; Offset_0x002764
		move.w  (A1)+, D2
		move.w  (A0), D3
		cmp.w   D2, D3
		beq.s   Pal_NoDec_2                            ; Offset_0x002790
Pal_DecBlue_2:
		move.w  D3, D1
		subi.w  #$0200, D1
		bcs.s   Pal_DecGreen_2                         ; Offset_0x00277C
		cmp.w   D2, D1
		bcs.s   Pal_DecGreen_2                         ; Offset_0x00277C
		move.w  D1, (A0)+
		rts
Pal_DecGreen_2:                                                ; Offset_0x00277C
		move.w  D3, D1
		subi.w  #$0020, D1
		bcs.s   Pal_DecRed_2                           ; Offset_0x00278C
		cmp.w   D2, D1
		bcs.s   Pal_DecRed_2                           ; Offset_0x00278C
		move.w  D1, (A0)+
		rts
Pal_DecRed_2:                                                  ; Offset_0x00278C
		subq.w  #$02, (A0)+
		rts
Pal_NoDec_2:                                                   ; Offset_0x002790
		addq.w  #$02, A0
		rts    
;-------------------------------------------------------------------------------  
Pal_MakeFlash:  ; Usado pelo Special Stage                     ; Offset_0x002794
		move.w  #$003F, ($FFFFF626).w
		move.w  #$0015, D4
Offset_0x00279E:
		move.b  #$12, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr.s   Pal_ToWhite                            ; Offset_0x0027B4
		bsr     RunPLC                                 ; Offset_0x001800
		dbra    D4, Offset_0x00279E
		rts
;-------------------------------------------------------------------------------                
Pal_ToWhite:                                                   ; Offset_0x0027B4
		moveq   #$00, D0
		lea     (Palette_Buffer).w, A0                       ; $FFFFFB00
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		move.b  ($FFFFF627).w, D0
Offset_0x0027C4:
		bsr.s   Pal_AddColor_2                         ; Offset_0x0027E2
		dbra    D0, Offset_0x0027C4
		moveq   #$00, D0
		lea     ($FFFFFA80).w, A0
		move.b  ($FFFFF626).w, D0
		adda.w  D0, A0
		move.b  ($FFFFF627).w, D0
Offset_0x0027DA:
		bsr.s   Pal_AddColor_2                         ; Offset_0x0027E2
		dbra    D0, Offset_0x0027DA
		rts
;-------------------------------------------------------------------------------
Pal_AddColor_2:                                                ; Offset_0x0027E2
		move.w  (A0), D2
		cmpi.w  #$0EEE, D2
		beq.s   Pal_NoAdd_2                            ; Offset_0x00281E
Pal_AddRed_2:                
		move.w  D2, D1
		andi.w  #$000E, D1
		cmpi.w  #$000E, D1
		beq.s   Pal_AddGreen_2                         ; Offset_0x0027FA
		addq.w  #$02, (A0)+
		rts
Pal_AddGreen_2:                                                ; Offset_0x0027FA
		move.w  D2, D1
		andi.w  #$00E0, D1
		cmpi.w  #$00E0, D1
		beq.s   Pal_AddBlue_2                          ; Offset_0x00280C
		addi.w  #$0020, (A0)+
		rts
Pal_AddBlue_2:                                                 ; Offset_0x00280C
		move.w  D2, D1
		andi.w  #$0E00, D1
		cmpi.w  #$0E00, D1
		beq.s   Pal_NoAdd_2                            ; Offset_0x00281E
		addi.w  #$0200, (A0)+
		rts
Pal_NoAdd_2:                                                   ; Offset_0x00281E
		addq.w  #$02, A0
		rts                                     
;===============================================================================
; Rotinas para escurecer / clarear a tela progressivamente
; <<<-
;=============================================================================== 

;-------------------------------------------------------------------------------  
; Paleta ciclíca do logo da SEGA 
; ->>>
;-------------------------------------------------------------------------------  
PalCycle_Sega:                                                 ; Offset_0x002822
		tst.b   ($FFFFF635).w
		bne.s   Offset_0x002882
		lea     ($FFFFFB20).w, A1
		lea     (Pal_SegaCyc1), A0                     ; Offset_0x0028D8
		moveq   #$05, D1
		move.w  ($FFFFF632).w, D0
Offset_0x002838:
		bpl.s   Offset_0x002842
		addq.w  #$02, A0
		subq.w  #$01, D1
		addq.w  #$02, D0
		bra.s   Offset_0x002838
Offset_0x002842:
		move.w  D0, D2
		andi.w  #$001E, D2
		bne.s   Offset_0x00284C
		addq.w  #$02, D0
Offset_0x00284C:
		cmpi.w  #$0060, D0
		bcc.s   Offset_0x002856
		move.w  (A0)+, $00(A1, D0)
Offset_0x002856:
		addq.w  #$02, D0
		dbra    D1, Offset_0x002842
		move.w  ($FFFFF632).w, D0
		addq.w  #$02, D0
		move.w  D0, D2
		andi.w  #$001E, D2
		bne.s   Offset_0x00286C
		addq.w  #$02, D0
Offset_0x00286C:
		cmpi.w  #$0064, D0
		blt.s   Offset_0x00287A
		move.w  #$0401, ($FFFFF634).w
		moveq   #-$0C, D0
Offset_0x00287A:
		move.w  D0, ($FFFFF632).w
		moveq   #$01, D0
		rts
Offset_0x002882:
		subq.b  #$01, ($FFFFF634).w
		bpl.s   Offset_0x0028D4
		move.b  #$04, ($FFFFF634).w
		move.w  ($FFFFF632).w, D0
		addi.w  #$000C, D0
		cmpi.w  #$0030, D0
		bcs.s   Offset_0x0028A0
		moveq   #$00, D0
		rts
Offset_0x0028A0:
		move.w  D0, ($FFFFF632).w
		lea     (Pal_SegaCyc2), A0                     ; Offset_0x0028E4
		lea     $00(A0, D0), A0
		lea     ($FFFFFB04).w, A1
		move.l  (A0)+, (A1)+
		move.l  (A0)+, (A1)+
		move.w  (A0)+, (A1)
		lea     ($FFFFFB20).w, A1
		moveq   #$00, D0
		moveq   #$2C, D1
Offset_0x0028C0:
		move.w  D0, D2
		andi.w  #$001E, D2
		bne.s   Offset_0x0028CA
		addq.w  #$02, D0
Offset_0x0028CA:
		move.w  (A0), $00(A1, D0)
		addq.w  #$02, D0
		dbra    D1, Offset_0x0028C0
Offset_0x0028D4:
		moveq   #$01, D0
		rts                 
;-------------------------------------------------------------------------------
Pal_SegaCyc1:                                                  ; Offset_0x0028D8                    
		dc.w    $0EEE, $0EEA, $0EE4, $0EC0, $0EE4, $0EEA
;-------------------------------------------------------------------------------   
Pal_SegaCyc2:                                                  ; Offset_0x0028E4  
		dc.w    $0EEC, $0EEA, $0EEA, $0EEA, $0EEA, $0EEA, $0EEC, $0EEA
		dc.w    $0EE4, $0EC0, $0EC0, $0EC0, $0EEC, $0EEA, $0EE4, $0EC0
		dc.w    $0EA0, $0E60, $0EEA, $0EE4, $0EC0, $0EA0, $0E80, $0E00           
;-------------------------------------------------------------------------------  
; Paleta ciclíca do logo da SEGA
; <<<-
;-------------------------------------------------------------------------------
		      
;===============================================================================
; Rotinas para carga da paleta selecionada em D0 no buffer de paletas
; ->>>
;===============================================================================  
PalLoad1:                                                      ; Offset_0x002914
		lea     (PalPointers), A1                      ; Offset_0x002980
		lsl.w   #$03, D0
		adda.w  D0, A1
		move.l  (A1)+, A2               ; Localização da paleta no ROM  
		move.w  (A1)+, A3               ; Destino da paleta na RAM 
		adda.w  #$0080, A3              ; Adiciona $80 no Destino da RAM 
		move.w  (A1)+, D7               ; Quantidade de cores a ser lido 
PalLoad1_Loop:                                                 ; Offset_0x002928
		move.l  (A2)+, (A3)+
		dbra    D7, PalLoad1_Loop                      ; Offset_0x002928
		rts      
;-------------------------------------------------------------------------------    
PalLoad2:                                                      ; Offset_0x002930
		lea     (PalPointers), A1                      ; Offset_0x002980
		lsl.w   #$03, D0
		adda.w  D0, A1
		move.l  (A1)+, A2               ; Localização da paleta no ROM
		move.w  (A1)+, A3               ; Destino da paleta na RAM  
		move.w  (A1)+, D7               ; Quantidade de cores a ser lido
PalLoad2_Loop:                                                 ; Offset_0x002940
		move.l  (A2)+, (A3)+
		dbra    D7, PalLoad2_Loop                      ; Offset_0x002940
		rts      
;-------------------------------------------------------------------------------  
PalLoad3_Water:                                                ; Offset_0x002948
		lea     (PalPointers), A1                      ; Offset_0x002980
		lsl.w   #$03, D0
		adda.w  D0, A1
		move.l  (A1)+, A2
		move.w  (A1)+, A3
		suba.w  #$0080, A3             ; Subtrai $0080 no Destino da RAM
		move.w  (A1)+, D7              
Offset_0x00295C:
		move.l  (A2)+, (A3)+
		dbra    D7, Offset_0x00295C
		rts   
;-------------------------------------------------------------------------------
PalLoad4_Water:                                                ; Offset_0x002964
		lea     (PalPointers), A1                      ; Offset_0x002980
		lsl.w   #$03, D0
		adda.w  D0, A1
		move.l  (A1)+, A2
		move.w  (A1)+, A3
		suba.w  #$0100, A3             ; Subtrai $0100 no Destino da RAM
		move.w  (A1)+, D7
Offset_0x002978:
		move.l  (A2)+, (A3)+
		dbra    D7, Offset_0x002978
		rts    
;-------------------------------------------------------------------------------  
PalPointers:                                                   ; Offset_0x002980
		dc.l    Pal_Sega_Bg                            ; Offset_0x002A50
		dc.w    $FB00, $001F
		dc.l    Pal_Title_Screen                       ; Offset_0x002AD0
		dc.w    $FB00, $001F
		dc.l    Pal_Level_Select_Menu                  ; Offset_0x002B50
		dc.w    $FB00, $001F
		dc.l    Pal_Sonic_And_Miles                    ; Offset_0x002BD0
		dc.w    $FB00, $0007
		dc.l    Pal_GHz                                ; Offset_0x002BF0
		dc.w    $FB20, $0017
		dc.l    Pal_Lvl1                               ; Offset_0x002BF0
		dc.w    $FB20, $0017
		dc.l    Pal_Wz                                 ; Offset_0x002C50
		dc.w    $FB20, $0017
		dc.l    Pal_Lvl3                               ; Offset_0x002BF0
		dc.w    $FB20, $0017
		dc.l    Pal_Mz                                 ; Offset_0x002CB0
		dc.w    $FB20, $0017
		dc.l    Pal_Mz                                 ; Offset_0x002CB0
		dc.w    $FB20, $0017
		dc.l    Pal_Lvl6     ; Casino Night Act 2      ; Offset_0x002F70
		dc.w    $FB20, $0017
		dc.l    Pal_HTz                                ; Offset_0x002D10
		dc.w    $FB20, $0017
		dc.l    Pal_HPz                                ; Offset_0x002D70
		dc.w    $FB20, $0017
		dc.l    Pal_Lvl9                               ; Offset_0x002BF0
		dc.w    $FB20, $0017
		dc.l    Pal_OOz                                ; Offset_0x002E50
		dc.w    $FB20, $0017
		dc.l    Pal_DHz                                ; Offset_0x002EB0
		dc.w    $FB20, $0017
		dc.l    Pal_CNz                                ; Offset_0x002F10
		dc.w    $FB20, $0017
		dc.l    Pal_CPz                                ; Offset_0x002FD0
		dc.w    $FB20, $0017
		dc.l    Pal_GCz                                ; Offset_0x002BF0
		dc.w    $FB20, $0017
		dc.l    Pal_NGHz                               ; Offset_0x0030B0
		dc.w    $FB20, $0017
		dc.l    Pal_DEz                                ; Offset_0x003190
		dc.w    $FB20, $0017
		dc.l    Pal_HPz_Water                          ; Offset_0x002DD0
		dc.w    $FB00, $001F
		dc.l    Pal_CPz_Water                          ; Offset_0x003030
		dc.w    $FB00, $001F
		dc.l    Pal_NGHz_Water                         ; Offset_0x003110
		dc.w    $FB00, $001F
		dc.l    Pal_Special_Stage_Main                 ; Offset_0x0031B0
		dc.w    $FB00, $001F
		dc.l    Offset_0x003230
		dc.w    $FB20, $0007 
		
Pal_Sega_Bg:                                                   ; Offset_0x002A50
		incbin  'palettes/sega_bg.pal' 
Pal_Title_Screen:                                              ; Offset_0x002AD0
		incbin  'palettes/titlscrn.pal'
Pal_Level_Select_Menu:                                         ; Offset_0x002B50
		incbin  'palettes/lvl_menu.pal' 
Pal_Sonic_And_Miles:                                           ; Offset_0x002BD0
		incbin  'palettes/sonic.pal'
Pal_GHz:                                                       ; Offset_0x002BF0
Pal_Lvl1:                                                      ; Offset_0x002BF0
Pal_Lvl3:                                                      ; Offset_0x002BF0
Pal_Lvl9:                                                      ; Offset_0x002BF0
Pal_GCz:                                                       ; Offset_0x002BF0
		incbin  'palettes/ghz.pal'
Pal_Wz:                                                        ; Offset_0x002C50  
		incbin  'palettes/wz.pal'
Pal_Mz:                                                        ; Offset_0x002CB0
		incbin  'palettes/mz.pal'
Pal_HTz:                                                       ; Offset_0x002D10
		incbin  'palettes/htz.pal'
Pal_HPz:                                                       ; Offset_0x002D70
		incbin  'palettes/hpz.pal'
Pal_HPz_Water:                                                 ; Offset_0x002DD0
		incbin  'palettes/hpz_uw.pal'
Pal_OOz:                                                       ; Offset_0x002E50
		incbin  'palettes/ooz.pal' 
Pal_DHz:                                                       ; Offset_0x002EB0
		incbin  'palettes/dhz.pal' 
Pal_CNz:                                                       ; Offset_0x002F10
		incbin  'palettes/cnz_1.pal'
Pal_Lvl6:     ; Casino Night Act 2                             ; Offset_0x002F70
		incbin  'palettes/cnz_2.pal'                
Pal_CPz:                                                       ; Offset_0x002FD0  
		incbin  'palettes/cpz.pal'
Pal_CPz_Water:                                                 ; Offset_0x003030
		incbin  'palettes/cpz_uw.pal'
Pal_NGHz:                                                      ; Offset_0x0030B0
		incbin  'palettes/nghz.pal'
Pal_NGHz_Water:                                                ; Offset_0x003110
		incbin  'palettes/nghz_uw.pal'
Pal_DEz:                                                       ; Offset_0x003190
		incbin  'palettes/dez.pal'
Pal_Special_Stage_Main:                                        ; Offset_0x0031B0
		incbin  'palettes/ss_main.pal'
Offset_0x003230:
		incbin  'palettes/unused.bin'
;===============================================================================
; Rotinas para carga da paleta selecionada em D0 no buffer de paletas
; <<<-
;===============================================================================   

;===============================================================================
; Aguarda pela conclusão do procedimento de interrupção vertical
; ->>>
;=============================================================================== 
Wait_For_VSync:                                                ; Offset_0x003250
		move    #$2300, SR
Wait_For_VSync_Inf_Loop:                                       ; Offset_0x003254
		tst.b   (VBlank_Index).w                             ; $FFFFF62A
		bne.s   Wait_For_VSync_Inf_Loop                ; Offset_0x003254
		rts
;===============================================================================
; Aguarda pela conclusão do procedimento de interrupção vertical
; <<<-
;===============================================================================                     
		    
;===============================================================================
; Geração de números pseudo aleatórios
; ->>>
;===============================================================================
PseudoRandomNumber:                                            ; Offset_0x00325C
		move.l  ($FFFFF636).w, D1
		bne.s   Offset_0x003268
		move.l  #$2A6D365A, D1
Offset_0x003268:
		move.l  D1, D0
		asl.l   #$02, D1
		add.l   D0, D1
		asl.l   #$03, D1
		add.l   D0, D1
		move.w  D1, D0
		swap.w  D1
		add.w   D1, D0
		move.w  D0, D1
		swap.w  D1
		move.l  D1, ($FFFFF636).w
		rts 
;===============================================================================
; Geração de números pseudo aleatórios
; <<<-
;===============================================================================
 
;===============================================================================
; Rotina para calcular o Seno usando tabela pré-calculada
; ->>>
;===============================================================================   
CalcSine:                                                      ; Offset_0x003282
		andi.w  #$00FF, D0
		add.w   D0, D0
		addi.w  #$0080, D0
		move.w  Sine_Table(PC, D0), D1                 ; Offset_0x00329A
		subi.w  #$0080, D0
		move.w  Sine_Table(PC, D0), D0                 ; Offset_0x00329A
		rts
;-------------------------------------------------------------------------------
Sine_Table:                                                    ; Offset_0x00329A
		incbin "misc/sinedata.bin"
		even
;===============================================================================
; Rotina para calcular o Seno usando tabela pré-calculada
; <<<-
;===============================================================================  
  
;===============================================================================
; Rotina para calcular o Ângulo usando tabela pré-calculada
; ->>>
;===============================================================================
CalcAngle:                                                     ; Offset_0x00351A
		movem.l D3/D4, -(A7)
		moveq   #$00, D3
		moveq   #$00, D4
		move.w  D1, D3
		move.w  D2, D4
		or.w    D3, D4
		beq.s   Offset_0x003576
		move.w  D2, D4
		tst.w   D3
		bpl     Offset_0x003534
		neg.w   D3
Offset_0x003534:
		tst.w   D4
		bpl     Offset_0x00353C
		neg.w   D4
Offset_0x00353C:
		cmp.w   D3, D4
		bcc     Offset_0x00354E
		lsl.l   #$08, D4
		divu.w  D3, D4
		moveq   #$00, D0
		move.b  Angle_Table(PC, D4), D0                ; Offset_0x003580
		bra.s   Offset_0x003558
Offset_0x00354E:
		lsl.l   #$08, D3
		divu.w  D4, D3
		moveq   #$40, D0
		sub.b   Angle_Table(PC, D3), D0                ; Offset_0x003580
Offset_0x003558:
		tst.w   D1
		bpl     Offset_0x003564
		neg.w   D0
		addi.w  #$0080, D0
Offset_0x003564:
		tst.w   D2
		bpl     Offset_0x003570
		neg.w   D0
		addi.w  #$0100, D0
Offset_0x003570:
		movem.l (A7)+, D3/D4
		rts
Offset_0x003576:
		move.w  #$0040, D0
		movem.l (A7)+, D3/D4
		rts
;-------------------------------------------------------------------------------
Angle_Table:                                                   ; Offset_0x003580
		incbin "Misc/AngleData.bin"
		even
;===============================================================================
; Rotina para calcular o Ângulo usando tabela pré-calculada
; <<<-
;===============================================================================  
		nop
;===============================================================================
; Logo da SEGA
; ->>>
;===============================================================================                                                                          
Sega_Screen:                                                   ; Offset_0x003684
		move.b  #$FD, D0
		bsr     Play_Music                             ; Offset_0x00150C
		bsr     ClearPLC                               ; Offset_0x0017F2
		bsr     Pal_FadeFrom                           ; Offset_0x00266C
		lea     (VDP_Control_Port), A6                       ; $00C00004
		move.w  #$8004, (A6)
		move.w  #$8230, (A6)
		move.w  #$8407, (A6)
		move.w  #$8700, (A6)
		move.w  #$8B00, (A6)
		move.w  #$8C81, (A6)
		clr.b   ($FFFFF64E).w
		move    #$2700, SR
		move.w  ($FFFFF60C).w, D0
		andi.b  #$BF, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
		bsr     ClearScreen                            ; Offset_0x001418
		move.l  #$40000000, (VDP_Control_Port)               ; $00C00004
		lea     (Art_SEGA), A0                         ; Offset_0x074876
		bsr     NemesisDec                             ; Offset_0x001654
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		lea     (Sega_Mappings), A0                    ; Offset_0x074CE6
		move.w  #$0000, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.l  #$65100003, D0
		moveq   #$17, D1
		moveq   #$07, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		lea     ($FFFF0180), A1
		move.l  #$40000003, D0
		moveq   #$27, D1
		moveq   #$1B, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		tst.b   (Hardware_Id).w                              ; $FFFFFFF8
		bmi.s   Offset_0x003736
		lea     ($FFFF0A40), A1
		move.l  #$453A0003, D0
		moveq   #$02, D1
		moveq   #$01, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
Offset_0x003736:
		moveq   #$00, D0
		bsr     PalLoad2                               ; Offset_0x002930
		move.w  #$FFF6, ($FFFFF632).w
		move.w  #$0000, ($FFFFF634).w
		move.w  #$0000, ($FFFFF662).w
		move.w  #$0000, ($FFFFF660).w
		move.w  #$00B4, (Timer_Count_Down).w                 ; $FFFFF614
		move.w  ($FFFFF60C).w, D0
		ori.b   #$40, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
Offset_0x003768:
		move.b  #$02, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr     PalCycle_Sega                          ; Offset_0x002822
		bne.s   Offset_0x003768
		move.b  #$FA, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		move.b  #$02, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		move.w  #$00B4, (Timer_Count_Down).w                 ; $FFFFF614
Offset_0x003790:
		move.b  #$14, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq.s   Offset_0x0037A8
		andi.b  #$80, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Offset_0x003790
Offset_0x0037A8:
		move.b  #$04, (Game_Mode).w                          ; $FFFFF600
		rts
;===============================================================================
; Logo da SEGA
; <<<-
;=============================================================================== 

;===============================================================================
; Tela título
; ->>>
;=============================================================================== 
Title_Screen:                                                  ; Offset_0x0037B0
		move.b  #$FD, D0
		bsr     Play_Music                             ; Offset_0x00150C
		bsr     ClearPLC                               ; Offset_0x0017F2
		bsr     Pal_FadeFrom                           ; Offset_0x00266C
		move    #$2700, SR
		lea     (VDP_Control_Port), A6                       ; $00C00004
		move.w  #$8004, (A6)
		move.w  #$8230, (A6)
		move.w  #$8407, (A6)
		move.w  #$9001, (A6)
		move.w  #$9200, (A6)
		move.w  #$8B03, (A6)
		move.w  #$8720, (A6)
		clr.b   ($FFFFF64E).w
		move.w  #$8C81, (A6)
		bsr     ClearScreen                            ; Offset_0x001418
		lea     ($FFFFAC00).w, A1
		moveq   #$00, D0
		move.w  #$00FF, D1
Offset_0x0037FC:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0037FC
		lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
		moveq   #$00, D0
		move.w  #$07FF, D1
Offset_0x00380C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00380C
		lea     ($FFFFF700).w, A1
		moveq   #$00, D0
		move.w  #$003F, D1
Offset_0x00381C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00381C
		lea     (Camera_X).w, A1                             ; $FFFFEE00
		moveq   #$00, D0
		move.w  #$003F, D1
Offset_0x00382C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00382C
		lea     (Palette_Underwater_Buffer).w, A1            ; $FFFFFB80
		moveq   #$00, D0
		move.w  #$001F, D1
Offset_0x00383C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00383C
		moveq   #$03, D0
		bsr     PalLoad1                               ; Offset_0x002914
		bsr     Pal_FadeTo                             ; Offset_0x0025C8
		move    #$2700, SR
		move.l  #$40000000, (VDP_Control_Port)               ; $00C00004
		lea     (Art_Title_Screen_Bg_Wings), A0        ; Offset_0x075436
		bsr     NemesisDec                             ; Offset_0x001654
		move.l  #$40000001, (VDP_Control_Port)               ; $00C00004
		lea     (Art_Title_Screen_Sonic_Miles), A0     ; Offset_0x076D98
		bsr     NemesisDec                             ; Offset_0x001654
		lea     (VDP_Data_Port), A6                          ; $00C00000
		move.l  #$50000003, $0004(A6)
		lea     (Art_Menu_Text), A5                    ; Offset_0x0005E8
		move.w  #$028F, D1
Offset_0x003890:
		move.w  (A5)+, (A6)
		dbra    D1, Offset_0x003890
		nop
		move.b  #$00, (Saved_Level_Flag).w                   ; $FFFFFE30
		move.w  #$0000, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
		move.w  #$0000, (Auto_Control_Player_Flag).w         ; $FFFFFFF0
		move.w  #$0000, ($FFFFFFDA).w
		move.w  #$0000, (Level_Id).w                         ; $FFFFFE10
		move.w  #$0000, ($FFFFF634).w
		bsr     Pal_FadeFrom                           ; Offset_0x00266C
		move    #$2700, SR
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		lea     (TS_Wings_Sonic_Mappings), A0          ; Offset_0x074DE2
		move.w  #$0000, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.l  #$40000003, D0
		moveq   #$27, D1
		moveq   #$1B, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		lea     (Title_Screen_Bg_Mappings), A0         ; Offset_0x074F3A
		move.w  #$0000, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.l  #$60000003, D0
		moveq   #$1F, D1
		moveq   #$1B, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		lea     (Title_Screen_R_Bg_Mappings), A0       ; Offset_0x0751EE
		move.w  #$0000, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.l  #$60400003, D0
		moveq   #$1F, D1
		moveq   #$1B, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		moveq   #$01, D0
		bsr     PalLoad1                               ; Offset_0x002914
		move.b  #$99, D0
		bsr     Play_Music                             ; Offset_0x00150C
		move.b  #$00, (Debug_Mode_Active_Flag).w             ; $FFFFFFFA
		move.w  #$0000, (Two_Player_Flag).w                  ; $FFFFFFD8
		move.w  #$0178, (Timer_Count_Down).w                 ; $FFFFF614
		lea     (Obj_Memory_Address+$0080).w, A1             ; $FFFFB080
		moveq   #$00, D0
		move.w  #$000F, D1
Offset_0x003966:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x003966
		move.b  #$0E, (Obj_Memory_Address+$0040).w           ; $FFFFB040
		move.b  #$0E, (Obj_Memory_Address+$0080).w           ; $FFFFB080
		move.b  #$01, (Obj_Memory_Address+$009A).w           ; $FFFFB09A
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		moveq   #$00, D0
		bsr     LoadPLC2                               ; Offset_0x0017C6
		move.w  #$0000, ($FFFFFFD4).w
		move.w  #$0000, ($FFFFFFD6).w
		move.b  #$01, ($FFFFFFD0).w
		move.w  #$0004, ($FFFFEED2).w
		move.w  #$0000, ($FFFFE500).w
		move.w  ($FFFFF60C).w, D0
		ori.b   #$40, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
		bsr     Pal_FadeTo                             ; Offset_0x0025C8
TitleScreen_Loop:                                              ; Offset_0x0039C0
		move.b  #$04, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		bsr     Bg_Scroll_Title_Screen                 ; Offset_0x005F00
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		bsr     RunPLC                                 ; Offset_0x001800
		tst.b   (Hardware_Id).w                              ; $FFFFFFF8
		bpl.s   Code_Sequence_J                        ; Offset_0x0039EC
		lea     (Level_Select_Code_J), A0              ; Offset_0x003BD2
		bra.s   Level_Select_Cheat_Test                ; Offset_0x0039F2
Code_Sequence_J:                                               ; Offset_0x0039EC
		lea     (Level_Select_Code_US), A0             ; Offset_0x003BCA
Level_Select_Cheat_Test:                                       ; Offset_0x0039F2
		move.w  ($FFFFFFD4).w, D0
		adda.w  D0, A0
		move.b  (Control_Ports_Buffer_Data+$0001).w, D0      ; $FFFFF605
		andi.b  #$0F, D0
		cmp.b   (A0), D0
		bne.s   Title_Cheat_NoMatch                    ; Offset_0x003A38
		addq.w  #$01, ($FFFFFFD4).w
		tst.b   D0
		bne.s   Title_Cheat_CountC                     ; Offset_0x003A4A
		lea     ($FFFFFFD0).w, A0
		move.w  ($FFFFFFD6).w, D1
		lsr.w   #$01, D1
		andi.w  #$0003, D1
		beq.s   Title_Cheat_PlayRing                   ; Offset_0x003A28
		tst.b   (Hardware_Id).w                              ; $FFFFFFF8
		bpl.s   Title_Cheat_PlayRing                   ; Offset_0x003A28
		moveq   #$01, D1
		move.b  D1, $01(A0, D1)
Title_Cheat_PlayRing:                                          ; Offset_0x003A28
		move.b  #$01, $00(A0, D1)
		move.b  #$B5, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		bra.s   Title_Cheat_CountC                     ; Offset_0x003A4A
Title_Cheat_NoMatch:                                           ; Offset_0x003A38
		tst.b   D0
		beq.s   Title_Cheat_CountC                     ; Offset_0x003A4A
		cmpi.w  #$0009, ($FFFFFFD4).w
		beq.s   Title_Cheat_CountC                     ; Offset_0x003A4A
		move.w  #$0000, ($FFFFFFD4).w
Title_Cheat_CountC:                                            ; Offset_0x003A4A:
		move.b  (Control_Ports_Buffer_Data+$0001).w, D0      ; $FFFFF605
		andi.b  #$20, D0
		beq.s   Offset_0x003A58
		addq.w  #$01, ($FFFFFFD6).w
Offset_0x003A58:
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Offset_0x003BDA
		andi.b  #$80, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq     TitleScreen_Loop                       ; Offset_0x0039C0
Offset_0x003A6A:                
		tst.b   ($FFFFFFD0).w
		beq     Offset_0x003B8A
		cmpi.b  #$C0, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		bne     Offset_0x003B8A
		move.b  #$91, D0
		bsr     Play_Music                             ; Offset_0x00150C
		moveq   #$02, D0
		bsr     PalLoad2                               ; Offset_0x002930
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		moveq   #$00, D0
		move.w  #$00DF, D1
LevelSelect_ClearScroll:                                       ; Offset_0x003A94
		move.l  D0, (A1)+
		dbra    D1, LevelSelect_ClearScroll            ; Offset_0x003A94
		move.l  D0, ($FFFFF616).w
		move    #$2700, SR
		lea     (VDP_Data_Port), A6                          ; $00C00000
		move.l  #$60000003, (VDP_Control_Port)               ; $00C00004
		move.w  #$03FF, D1
LevelSelect_ClearVRAM:                                         ; Offset_0x003AB6
		move.l  D0, (A6)
		dbra    D1, LevelSelect_ClearVRAM              ; Offset_0x003AB6
		bsr     Offset_0x003D3C
LevelSelect_Loop:                                              ; Offset_0x003AC0
		move.b  #$04, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr     LevelSelect_Controls                   ; Offset_0x003CA6
		bsr     RunPLC                                 ; Offset_0x001800
		tst.l   (PLC_Buffer).w                               ; $FFFFF680
		bne.s   LevelSelect_Loop                       ; Offset_0x003AC0
		andi.b  #$F0, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   LevelSelect_Loop                       ; Offset_0x003AC0
		move.w  #$0000, (Two_Player_Flag).w                  ; $FFFFFFD8
		btst    #$04, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x003AF4
		move.w  #$0001, (Two_Player_Flag).w                  ; $FFFFFFD8
Offset_0x003AF4:
		move.w  ($FFFFFF82).w, D0
		cmpi.w  #$001A, D0
		bne.s   Offset_0x003B14
		btst    #$06, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		bne.s   LevelSelect_Loop                       ; Offset_0x003AC0
		move.w  ($FFFFFF84).w, D0
		addi.w  #$0080, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		bra.s   LevelSelect_Loop                       ; Offset_0x003AC0
Offset_0x003B14:
		add.w   D0, D0
		move.w  Level_Select_Array(PC, D0), D0         ; Offset_0x003B4C
		bmi     LevelSelect_Loop                       ; Offset_0x003AC0
		cmpi.w  #$4000, D0
		bne.s   Level_Select_Load_Level                ; Offset_0x003B82
		move.b  #gm_SpecialStage, (Game_Mode).w        ; $10,  $FFFFF600
		clr.w   (Level_Id).w                                 ; $FFFFFE10
		move.b  #$03, (Life_Count).w                         ; $FFFFFE12
		moveq   #$00, D0
		move.w  D0, (Ring_Count).w                           ; $FFFFFE20
		move.l  D0, (Time_Count).w                           ; $FFFFFE22
		move.l  D0, (Score_Count).w                          ; $FFFFFE26
		move.l  #$00001388, ($FFFFFFC0).w         
		rts
;------------------------------------------------------------------------------- 
Level_Select_Array:                                            ; Offset_0x003B4C
		dc.w    $0000, $0001         ; GHz
		dc.w    $0200, $0201         ; Wz
		dc.w    $0400, $0401, $0500  ; Mz
		dc.w    $0700, $0701         ; HTz
		dc.w    $0800, $0801         ; HPz
		dc.w    $0A00, $0A01         ; OOz
		dc.w    $0B00, $0B01         ; DHz
		dc.w    $0C00, $0C01         ; CNz
		dc.w    $0D00, $0D01         ; CPz
		dc.w    $0E00, $0E01         ; GCz
		dc.w    $0F00, $0F01         ; NGHz
		dc.w    $1000, $1001         ; Dez
		dc.w    $4000                ; SS 
		dc.w    $0000                ; Sound Test
;-------------------------------------------------------------------------------
Level_Select_Load_Level:                                       ; Offset_0x003B82
		andi.w  #$3FFF, D0
		move.w  D0, (Level_Id).w                             ; $FFFFFE10
Offset_0x003B8A:                
		move.b  #gm_PlayMode, (Game_Mode).w             ; $0C, $FFFFF600
		move.b  #$03, (Life_Count).w                         ; $FFFFFE12
		moveq   #$00, D0
		move.w  D0, (Ring_Count).w                           ; $FFFFFE20
		move.l  D0, (Time_Count).w                           ; $FFFFFE22
		move.l  D0, (Score_Count).w                          ; $FFFFFE26
		move.b  D0, ($FFFFFE16).w
		move.b  D0, (Emerald_Count).w                        ; $FFFFFE57
		move.l  D0, (Emerald_Collected_Flag_List).w          ; $FFFFFE58
		move.l  D0, (Emerald_Collected_Flag_List+$0004).w    ; $FFFFFE5C
		move.b  D0, ($FFFFFE18).w
		move.l  #$00001388, ($FFFFFFC0).w
		move.b  #$E0, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		rts                                                        
;-------------------------------------------------------------------------------
Level_Select_Code_US:                                          ; Offset_0x003BCA
		dc.b    $01, $02, $02, $02, $02, $01, $00, $FF
Level_Select_Code_J:                                           ; Offset_0x003BD2 
		dc.b    $01, $02, $02, $02, $02, $01, $00, $FF   
;-------------------------------------------------------------------------------
Offset_0x003BDA:
		move.w  #$001E, (Timer_Count_Down).w                 ; $FFFFF614
Offset_0x003BE0:
		move.b  #$04, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr     RunPLC                                 ; Offset_0x001800
		move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
		addq.w  #$02, D0
		move.w  D0, (Player_One_Position_X).w                ; $FFFFB008
		cmpi.w  #$1C00, D0
		bcs.s   Offset_0x003C06
		move.b  #$00, (Game_Mode).w                          ; $FFFFF600
		rts
Offset_0x003C06:
		andi.b  #$80, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		bne     Offset_0x003A6A
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		bne     Offset_0x003BE0
		move.b  #$E0, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		move.w  ($FFFFFFF2).w, D0
		andi.w  #$0007, D0
		add.w   D0, D0
		move.w  Demo_Mode_Level_Array(PC, D0), D0      ; Offset_0x003C8E
		move.w  D0, (Level_Id).w                             ; $FFFFFE10
		addq.w  #$01, ($FFFFFFF2).w
		cmpi.w  #$0004, ($FFFFFFF2).w
		bcs.s   Offset_0x003C44
		move.w  #$0000, ($FFFFFFF2).w
Offset_0x003C44:
		move.w  #$0001, (Auto_Control_Player_Flag).w         ; $FFFFFFF0
		move.b  #$08, (Game_Mode).w                          ; $FFFFF600
		cmpi.w  #$0000, D0
		bne.s   Offset_0x003C5C
		move.w  #$0001, (Two_Player_Flag).w                  ; $FFFFFFD8
Offset_0x003C5C:
		cmpi.w  #$0600, D0
		bne.s   Offset_0x003C70
		move.b  #$10, (Game_Mode).w                          ; $FFFFF600
		clr.w   (Level_Id).w                                 ; $FFFFFE10
		clr.b   ($FFFFFE16).w
Offset_0x003C70:
		move.b  #$03, (Life_Count).w                         ; $FFFFFE12
		moveq   #$00, D0
		move.w  D0, (Ring_Count).w                           ; $FFFFFE20
		move.l  D0, (Time_Count).w                           ; $FFFFFE22
		move.l  D0, (Score_Count).w                          ; $FFFFFE26
		move.l  #$00001388, ($FFFFFFC0).w
		rts  
;-------------------------------------------------------------------------------
Demo_Mode_Level_Array:                                         ; Offset_0x003C8E
		dc.w    $0D00, $0000, $0800, $0700, $0500, $0500, $0500, $0500
		dc.w    $0400, $0400, $0400, $0400
;-------------------------------------------------------------------------------
LevelSelect_Controls:                                          ; Offset_0x003CA6
		move.b  (Control_Ports_Buffer_Data+$0001).w, D1      ; $FFFFF605
		andi.b  #$03, D1
		bne.s   Offset_0x003CB6
		subq.w  #$01, ($FFFFFF80).w
		bpl.s   Offset_0x003CF0
Offset_0x003CB6:
		move.w  #$000B, ($FFFFFF80).w
		move.b  (Control_Ports_Buffer_Data).w, D1            ; $FFFFF604
		andi.b  #$03, D1
		beq.s   Offset_0x003CF0
		move.w  ($FFFFFF82).w, D0
		btst    #$00, D1
		beq.s   Offset_0x003CD6
		subq.w  #$01, D0
		bcc.s   Offset_0x003CD6
		moveq   #$1A, D0
Offset_0x003CD6:
		btst    #$01, D1
		beq.s   Offset_0x003CE6
		addq.w  #$01, D0
		cmpi.w  #$001B, D0
		bcs.s   Offset_0x003CE6
		moveq   #$00, D0
Offset_0x003CE6:
		move.w  D0, ($FFFFFF82).w
		bsr     Offset_0x003D3C
		rts
Offset_0x003CF0:
		cmpi.w  #$001A, ($FFFFFF82).w
		bne.s   Offset_0x003D3A
		move.w  ($FFFFFF84).w, D0
		move.b  (Control_Ports_Buffer_Data+$0001).w, D1      ; $FFFFF605
		andi.b  #$0C, D1
		beq.s   Offset_0x003D22
		btst    #$02, D1
		beq.s   Offset_0x003D12
		subq.b  #$01, D0
		bcc.s   Offset_0x003D12
		moveq   #$7F, D0
Offset_0x003D12:
		btst    #$03, D1
		beq.s   Offset_0x003D22
		addq.b  #$01, D0
		cmpi.w  #$0080, D0
		bcs.s   Offset_0x003D22
		moveq   #$00, D0
Offset_0x003D22:
		btst    #$06, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Offset_0x003D32
		addi.b  #$10, D0
		andi.b  #$7F, D0
Offset_0x003D32:
		move.w  D0, ($FFFFFF84).w
		bsr     Offset_0x003D3C
Offset_0x003D3A:
		rts
Offset_0x003D3C:
		lea     (Level_Select_Text), A1                ; Offset_0x003DF4
		lea     (VDP_Data_Port), A6                          ; $00C00000
		move.l  #$608C0003, D4
		move.w  #$8680, D3
		moveq   #$1A, D1
Offset_0x003D54:
		move.l  D4, $0004(A6)
		bsr     Offset_0x003DD8
		addi.l  #$00800000, D4
		dbra    D1, Offset_0x003D54
		moveq   #$00, D0
		move.w  ($FFFFFF82).w, D0
		move.w  D0, D1
		move.l  #$608C0003, D4
		lsl.w   #$07, D0
		swap.w  D0
		add.l   D0, D4
		lea     (Level_Select_Text), A1                ; Offset_0x003DF4
		mulu.w  #$001B, D1
		adda.w  D1, A1
		move.w  #$C680, D3
		move.l  D4, $0004(A6)
		bsr     Offset_0x003DD8
		move.w  #$8680, D3
		cmpi.w  #$001A, ($FFFFFF82).w
		bne.s   Offset_0x003DA2
		move.w  #$C680, D3
Offset_0x003DA2:
		move.l  #$6DB00003, (VDP_Control_Port)               ; $00C00004
		move.w  ($FFFFFF84).w, D0
		addi.w  #$0080, D0
		move.b  D0, D2
		lsr.b   #$04, D0
		bsr     Offset_0x003DC4
		move.b  D2, D0
		bsr     Offset_0x003DC4
		rts
Offset_0x003DC4:
		andi.w  #$000F, D0
		cmpi.b  #$0A, D0
		bcs.s   Offset_0x003DD2
		addi.b  #$07, D0
Offset_0x003DD2:
		add.w   D3, D0
		move.w  D0, (A6)
		rts
Offset_0x003DD8:
		moveq   #$1A, D2
Offset_0x003DDA:
		moveq   #$00, D0
		move.b  (A1)+, D0
		bpl.s   Offset_0x003DEA
		move.w  #$0000, (A6)
		dbra    D2, Offset_0x003DDA
		rts
Offset_0x003DEA:
		add.w   D3, D0
		move.w  D0, (A6)
		dbra    D2, Offset_0x003DDA
		rts    
;-------------------------------------------------------------------------------
Level_Select_Text:                                             ; Offset_0x003DF4  
		dc.b    _G,_R,_E,_E,_N,__,_H,_I,_L,_L,__,_Z,_O,_N,_E,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0  
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1  
		dc.b    _W,_O,_O,_D,__,_Z,_O,_N,_E,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0  
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1 
		dc.b    _M,_E,_T,_R,_O,_P,_O,_L,_I,_S,__,_Z,_O,_N,_E,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0  
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1  
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_2     
		dc.b    _H,_I,_L,_L,__,_T,_O,_P,__,_Z,_O,_N,_E,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1
		dc.b    _H,_I,_D,_D,_E,_N,__,_P,_A,_L,_A,_C,_E,__,_Z,_O,_N,_E,__,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1
		dc.b    _O,_I,_L,__,_O,_C,_E,_A,_N,__,_Z,_O,_N,_E,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1 
		dc.b    _D,_U,_S,_T,__,_H,_I,_L,_L,__,_Z,_O,_N,_E,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1                  
		dc.b    _C,_A,_S,_I,_N,_O,__,_N,_I,_G,_H,_T,__,_Z,_O,_N,_E,__,__,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1 
		dc.b    _C,_H,_E,_M,_I,_C,_A,_L,__,_P,_L,_A,_N,_T,__,_Z,_O,_N,_E,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1 
		dc.b    _G,_E,_N,_O,_C,_I,_D,_E,__,_C,_I,_T,_Y,__,_Z,_O,_N,_E,__,__,_S,_T,_A,_G,_E,__,_0 
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1 
		dc.b    _N,_E,_O,__,_G,_R,_E,_E,_N,__,_H,_I,_L,_L,__,_Z,_O,_N,_E,__,_S,_T,_A,_G,_E,__,_0  
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1  
		dc.b    _D,_E,_A,_T,_H,__,_E,_G,_G,__,_Z,_O,_N,_E,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_0  
		dc.b    __,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__,_S,_T,_A,_G,_E,__,_1  
		dc.b    _S,_P,_E,_C,_I,_A,_L,__,_S,_T,_A,_G,_E,__,__,__,__,__,__,__,__,__,__,__,__,__,__
		dc.b    _S,_O,_U,_N,_D,__,_S,_E,_L,_E,_C,_T,__,__,__,__,__,__,__,__,__,__,__,__,__,__,__
		dc.b    $00 ; alinhamento
;-------------------------------------------------------------------------------
; Offset_0x0040CE:
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.w  #$02EB, D2
Offset_0x0040D8:
		move.w  (A1), D0
		move.w  D0, D1
		andi.w  #$F800, D1
		andi.w  #$07FF, D0
		lsr.w   #$01, D0
		or.w    D0, D1
		move.w  D1, (A1)+
		dbra    D2, Offset_0x0040D8
		rts     
;-------------------------------------------------------------------------------  
; Offset_0x0040F0:
		lea     ($00FE0000), A1
		lea     ($00FE0080), A2
		lea     (M68K_RAM_Start), A3                         ; $FFFF0000
		move.w  #$003F, D1
Offset_0x004106:
		bsr     Offset_0x004198
		bsr     Offset_0x004198
		dbra    D1, Offset_0x004106
		lea     ($00FE0000), A1
		lea     (M68K_RAM_Start&$00FFFFFF), A2               ; $00FF0000
		move.w  #$003F, D1
Offset_0x004122:
		move.w  #$0000, (A2)+
		dbra    D1, Offset_0x004122
		move.w  #$3FBF, D1
Offset_0x00412E:
		move.w  (A1)+, (A2)+
		dbra    D1, Offset_0x00412E
		rts       
;-------------------------------------------------------------------------------  
; Offset_0x004136:
		lea     ($00FE0000), A1
		lea     (M68K_RAM_Start), A3                         ; $FFFF0000
		moveq   #$1F, D0
Offset_0x004144:
		move.l  (A1)+, (A3)+
		dbra    D0, Offset_0x004144
		moveq   #$00, D7
		lea     ($00FE0000), A1
		move.w  #$00FF, D5
Offset_0x004156:
		lea     (M68K_RAM_Start), A3                         ; $FFFF0000
		move.w  D7, D6
Offset_0x00415E:
		movem.l A1-A3, -(A7)
		move.w  #$003F, D0
Offset_0x004166:
		cmpm.w  (A1)+, (A3)+
		bne.s   Offset_0x00417C
		dbra    D0, Offset_0x004166
		movem.l (A7)+, A1-A3
		adda.w  #$0080, A1
		dbra    D5, Offset_0x004156
		bra.s   Offset_0x004196
Offset_0x00417C:
		movem.l (A7)+, A1-A3
		adda.w  #$0080, A3
		dbra    D6, Offset_0x00415E
		moveq   #$1F, D0
Offset_0x00418A:
		move.l  (A1)+, (A3)+
		dbra    D0, Offset_0x00418A
		addq.l  #$01, D7
		dbra    D5, Offset_0x004156
Offset_0x004196:
		bra.s   Offset_0x004196
;-------------------------------------------------------------------------------                
Offset_0x004198:
		moveq   #$07, D0
Offset_0x00419A:
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A2)+
		move.l  (A3)+, (A2)+
		move.l  (A3)+, (A2)+
		move.l  (A3)+, (A2)+
		dbra    D0, Offset_0x00419A
		adda.w  #$0080, A1
		adda.w  #$0080, A2
		rts                
;===============================================================================
; Tela título
; <<<-
;=============================================================================== 

;===============================================================================
; Modo de jogo ou demonstração das fases 
; ->>>
;=============================================================================== 
PlayList:                                                      ; Offset_0x0041B8
		incbin "Misc/MusicList.bin"
		even
;-------------------------------------------------------------------------------
Level:                                                         ; Offset_0x0041C8
		bset    #$07, (Game_Mode).w                          ; $FFFFF600
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bmi.s   Level_Init                             ; Offset_0x0041DC
		move.b  #$F9, D0
		bsr     Play_Sfx                               ; Offset_0x001512
Level_Init:                                                    ; Offset_0x0041DC
		bsr     ClearPLC                               ; Offset_0x0017F2
		bsr     Pal_FadeFrom                           ; Offset_0x00266C
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bmi.s   Offset_0x004224
		move    #$2700, SR
		bsr     ClearScreen                            ; Offset_0x001418
		move    #$2300, SR
		moveq   #$00, D0
		move.w  D0, ($FFFFFE04).w
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		add.w   D0, D0
		move.w  D0, D1
		add.w   D0, D0
		add.w   D1, D0
		lea     (TilesMainTable), A2                   ; Offset_0x02E708
		lea     $00(A2, D0), A2
		moveq   #$00, D0
		move.b  (A2), D0
		beq.s   Offset_0x00421E
		bsr     LoadPLC                                ; Offset_0x001794
Offset_0x00421E:
		moveq   #$01, D0
		bsr     LoadPLC                                ; Offset_0x001794
Offset_0x004224:
		lea     ($FFFFAC00).w, A1
		moveq   #$00, D0
		move.w  #$00FF, D1
Offset_0x00422E:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00422E
		lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
		moveq   #$00, D0
		move.w  #$07FF, D1
Offset_0x00423E:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00423E
		lea     ($FFFFF628).w, A1
		moveq   #$00, D0
		move.w  #$0015, D1
Offset_0x00424E:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00424E
		lea     ($FFFFF700).w, A1
		moveq   #$00, D0
		move.w  #$003F, D1
Offset_0x00425E:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00425E
		lea     ($FFFFFE60).w, A1
		moveq   #$00, D0
		move.w  #$0047, D1
Offset_0x00426E:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00426E
		cmpi.w  #$0D01, (Level_Id).w                         ; $FFFFFE10
		beq.s   Init_Water                             ; Offset_0x00428C
		cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
		beq.s   Init_Water                             ; Offset_0x00428C
		cmpi.b  #$08, (Level_Id).w                           ; $FFFFFE10
		bne.s   Init_No_Water                          ; Offset_0x004298
Init_Water:                                                    ; Offset_0x00428C
		move.b  #$01, (Water_Level_Flag).w                   ; $FFFFF730
		move.w  #$0000, (Two_Player_Flag).w                  ; $FFFFFFD8
Init_No_Water:                                                 ; Offset_0x004298
		lea     (VDP_Control_Port), A6                       ; $00C00004
		move.w  #$8B03, (A6)
		move.w  #$8230, (A6)
		move.w  #$8407, (A6)
		move.w  #$857C, (A6)
		move.w  #$9001, (A6)
		move.w  #$8004, (A6)
		move.w  #$8720, (A6)
		tst.b   ($FFFFFFD2).w
		beq.s   Offset_0x0042DA
		btst    #$05, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x0042CC
		move.w  #$8C89, (A6)
Offset_0x0042CC:
		btst    #$06, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x0042DA
		move.b  #$01, (Debug_Mode_Active_Flag).w             ; $FFFFFFFA
Offset_0x0042DA:
		move.w  #$8ADF, (Horizontal_Interrupt_Count).w       ; $FFFFF624
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x0042F4
		move.w  #$8A6B, (Horizontal_Interrupt_Count).w       ; $FFFFF624
		move.w  #$8014, (A6)
		move.w  #$8C87, (A6)
Offset_0x0042F4:
		move.w  (Horizontal_Interrupt_Count).w, (A6)         ; $FFFFF624
		move.l  #DMA_Buffer_List, (DMA_Buffer_List_End).w ; $FFFFDC00, $FFFFDCFC 
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   LevelInit_NoWater                      ; Offset_0x004340
		move.w  #$8014, (A6)
		moveq   #$00, D0
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		subi.w  #$0800, D0
		ror.b   #$01, D0
		lsr.w   #$06, D0
		andi.w  #$FFFFFFFE, D0
		lea     (Water_Height_Array), A1               ; Offset_0x004736
		move.w  $00(A1, D0), D0
		move.w  D0, (Water_Level).w                          ; $FFFFF646
		move.w  D0, (Water_Level_Change).w                   ; $FFFFF648
		move.w  D0, (Water_Level_New).w                      ; $FFFFF64A
		clr.b   ($FFFFF64D).w
		clr.b   ($FFFFF64E).w
		move.b  #$01, ($FFFFF64C).w
LevelInit_NoWater:                                             ; Offset_0x004340
		moveq   #$03, D0
		bsr     PalLoad2                               ; Offset_0x002930
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   LevelInit_NoUndewaterPalette           ; Offset_0x004372
		moveq   #$15, D0
		cmpi.b  #$08, (Level_Id).w                           ; $FFFFFE10
		beq.s   LevelInit_UndewaterPalette             ; Offset_0x004362
		moveq   #$16, D0
		cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
		beq.s   LevelInit_UndewaterPalette             ; Offset_0x004362
		moveq   #$17, D0
LevelInit_UndewaterPalette:                                    ; Offset_0x004362
		bsr     PalLoad3_Water                         ; Offset_0x002948
		tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
		beq.s   LevelInit_NoUndewaterPalette           ; Offset_0x004372
		move.b  ($FFFFFE53).w, ($FFFFF64E).w
LevelInit_NoUndewaterPalette:                                  ; Offset_0x004372
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bmi.s   Offset_0x0043C0
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		lea     PlayList(PC), A1                       ; Offset_0x0041B8
		move.b  $00(A1, D0), D0
		bsr     Play_Music                             ; Offset_0x00150C
		move.b  #$34, (Title_Card_RAM_Obj_Data).w            ; $FFFFB080
LevelInit_TitleCard:                                           ; Offset_0x004390
		move.b  #$0C, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		bsr     RunPLC                                 ; Offset_0x001800
		move.w  ($FFFFB108).w, D0
		cmp.w   ($FFFFB130).w, D0
		bne.s   LevelInit_TitleCard                    ; Offset_0x004390
		tst.l   (PLC_Buffer).w                               ; $FFFFF680
		bne.s   LevelInit_TitleCard                    ; Offset_0x004390
		jsr     (Head_Up_Display_Base)                 ; Offset_0x02D488
Offset_0x0043C0:
		moveq   #$03, D0
		bsr     PalLoad1                               ; Offset_0x002914
		bsr     Level_Size_Load                        ; Offset_0x0059A4
		bsr     Background_Scroll_Layer                ; Offset_0x005E04
		bset    #$02, (Scroll_Flag_Array).w                  ; $FFFFEE50
		bsr     Main_Level_Load_16_128_Blocks          ; Offset_0x0078AE
		jsr     (Load_16x16_Mappings_For_Dyn_Sprites)  ; Offset_0x02CC94
		bsr     Load_Tiles_From_Start                  ; Offset_0x0077D2
		jsr     (FloorLog_Unk)                         ; Offset_0x013F46
		bsr     Load_Colision_Index                    ; Offset_0x004B28
		bsr     Water_Effects                          ; Offset_0x0046D8
		move.b  #$01, (Player_One).w                         ; $FFFFB000
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bmi.s   Offset_0x004402
		move.b  #$21, (HUD_RAM_Obj_Data).w                   ; $FFFFB380
Offset_0x004402:
		move.b  #$02, (Player_Two).w                         ; $FFFFB040
		move.w  (Player_One_Position_X).w, (Player_Two_Position_X).w ; $FFFFB008, $FFFFB048
		move.w  (Player_One_Position_Y).w, (Player_Two_Position_Y).w ; $FFFFB00C, $FFFFB04C
		subi.w  #$0020, (Player_Two_Position_X).w            ; $FFFFB048
		addi.w  #$0004, (Player_Two_Position_Y).w            ; $FFFFB04C
		move.b  #$08, ($FFFFB400).w
		move.b  #$08, ($FFFFB440).w
		move.w  #$0000, ($FFFFF602).w
		move.w  #$0000, (Control_Ports_Buffer_Data).w        ; $FFFFF604
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   Offset_0x004456
		move.b  #$04, ($FFFFB780).w
		move.w  #$0060, ($FFFFB788).w
		move.b  #$04, ($FFFFB7C0).w
		move.w  #$0120, ($FFFFB7C8).w
Offset_0x004456:
		cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
		bne.s   Offset_0x004464
		move.b  #$7C, ($FFFFB580).w
Offset_0x004464:
		cmpi.b  #$0A, (Level_Id).w                           ; $FFFFFE10
		bne.s   Offset_0x004472
		move.b  #$07, ($FFFFB780).w
Offset_0x004472:
		jsr     (Load_Object_Pos)                      ; Offset_0x00E1E8
		jsr     (Load_Ring_Pos)                        ; Offset_0x00DDC4
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		bsr     Jmp_00_To_Dynamic_Art_Cues             ; Offset_0x0052B4
		moveq   #$00, D0
		tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
		bne.s   Offset_0x0044A2
		move.w  D0, (Ring_Count).w                           ; $FFFFFE20
		move.l  D0, (Time_Count).w                           ; $FFFFFE22
		move.b  D0, (Ring_Life_Flag).w                       ; $FFFFFE1B
Offset_0x0044A2:
		move.b  D0, ($FFFFFE1A).w
		move.b  D0, (Shield_Flag).w                          ; $FFFFFE2C
		move.b  D0, (Invincibility_Flag).w                   ; $FFFFFE2D
		move.b  D0, (Hi_Speed_Flag).w                        ; $FFFFFE2E
		move.b  D0, ($FFFFFE2F).w
		move.w  D0, (Debug_Mode_Flag_Index).w                ; $FFFFFE08
		move.w  D0, ($FFFFFE02).w
		bsr     Oscillate_Num_Init                     ; Offset_0x004BE2
		move.b  #$01, (HUD_Score_Refresh_Flag).w             ; $FFFFFE1F
		move.b  #$01, (HUD_Rings_Refresh_Flag).w             ; $FFFFFE1D
		move.b  #$01, (HUD_Timer_Refresh_Flag).w             ; $FFFFFE1E
		move.w  #$0004, ($FFFFEED2).w
		move.w  #$0000, ($FFFFE500).w
		move.w  #$0000, ($FFFFF790).w
		move.w  #$0000, ($FFFFF732).w
		lea     (Demo_Index), A1                       ; Offset_0x004A70
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		lsl.w   #$02, D0
		move.l  $00(A1, D0), A1
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bpl.s   Offset_0x004516
		lea     (Demo_End_Index), A1                   ; Offset_0x004AF8
		move.w  ($FFFFFFF4).w, D0
		subq.w  #$01, D0
		lsl.w   #$02, D0
		move.l  $00(A1, D0), A1
Offset_0x004516:
		move.b  $0001(A1), ($FFFFF792).w
		subq.b  #$01, ($FFFFF792).w
		lea     (Demo_Green_Hill_Miles), A1            ; Offset_0x004EB2
		move.b  $0001(A1), ($FFFFF734).w
		subq.b  #$01, ($FFFFF734).w
		move.w  #$0668, (Timer_Count_Down).w                 ; $FFFFF614
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bpl.s   Offset_0x004550
		move.w  #$021C, (Timer_Count_Down).w                 ; $FFFFF614
		cmpi.w  #$0004, ($FFFFFFF4).w
		bne.s   Offset_0x004550
		move.w  #$01FE, (Timer_Count_Down).w                 ; $FFFFF614
Offset_0x004550:
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   Offset_0x004570
		moveq   #$15, D0
		cmpi.b  #$08, (Level_Id).w                           ; $FFFFFE10
		beq.s   Offset_0x00456C
		moveq   #$16, D0
		cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
		beq.s   Offset_0x00456C
		moveq   #$17, D0
Offset_0x00456C:
		bsr     PalLoad4_Water                         ; Offset_0x002964
Offset_0x004570:
		move.w  #$0003, D1
Offset_0x004574:
		move.b  #$08, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		dbra    D1, Offset_0x004574
		move.w  #$202F, ($FFFFF626).w
		bsr     Pal_FadeTo_2                           ; Offset_0x0025CE
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bmi.s   Offset_0x0045A4
		addq.b  #$02, ($FFFFB0A4).w
		addq.b  #$04, ($FFFFB0E4).w
		addq.b  #$04, ($FFFFB124).w
		addq.b  #$04, ($FFFFB164).w
		bra.s   Offset_0x0045AC
Offset_0x0045A4:
		moveq   #$02, D0
		jsr     (LoadPLC)                              ; Offset_0x001794
Offset_0x0045AC:
		bclr    #$07, (Game_Mode).w                          ; $FFFFF600
Level_Main_Loop:                                               ; Offset_0x0045B2
		bsr     Pause                                  ; Offset_0x00152A
		move.b  #$08, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		addq.w  #$01, ($FFFFFE04).w
		bsr     Init_Demo_Control                      ; Offset_0x00495C
		bsr     Water_Effects                          ; Offset_0x0046D8
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		tst.w   ($FFFFFE02).w
		bne     Level                                  ; Offset_0x0041C8
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne.s   Offset_0x0045E8
		cmpi.b  #$06, (Player_One+Obj_Routine).w             ; $FFFFB024
		bcc.s   Offset_0x0045EC
Offset_0x0045E8:
		bsr     Background_Scroll_Layer                ; Offset_0x005E04
Offset_0x0045EC:
		bsr     Change_Water_Surface_Pos               ; Offset_0x0046AE
		jsr     (Load_Ring_Pos)                        ; Offset_0x00DDC4
		bsr     Jmp_00_To_Dynamic_Art_Cues             ; Offset_0x0052B4
		bsr     PalCycle_Load                          ; Offset_0x001F70
		bsr     RunPLC                                 ; Offset_0x001800
		bsr     Oscillate_Num_Do                       ; Offset_0x004C38
		bsr     Change_Object_Frame                    ; Offset_0x004CD0
		bsr     Test_End_Level_Art_Load                ; Offset_0x004D3E
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		jsr     (Load_Object_Pos)                      ; Offset_0x00E1E8
		cmpi.b  #gm_DemoMode, (Game_Mode).w            ; $08 ; $FFFFF600
		beq.s   Offset_0x00462E
		cmpi.b  #gm_PlayMode, (Game_Mode).w            ; $0C ; $FFFFF600
		beq     Level_Main_Loop                        ; Offset_0x0045B2
		rts
Offset_0x00462E:
		tst.w   ($FFFFFE02).w
		bne.s   Offset_0x00464C
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq.s   Offset_0x00464C
		cmpi.b  #gm_DemoMode, (Game_Mode).w            ; $08 ; $FFFFF600
		beq     Level_Main_Loop                        ; Offset_0x0045B2
		move.b  #gm_SEGALogo, (Game_Mode).w            ; $00 ; $FFFFF600                        ; $FFFFF600
		rts
Offset_0x00464C:
		cmpi.b  #gm_DemoMode, (Game_Mode).w            ; $08 ; $FFFFF600
		bne.s   Offset_0x004666
		move.b  #gm_SEGALogo, (Game_Mode).w            ; $00 ; $FFFFF600
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bpl.s   Offset_0x004666
		move.b  #$1C, (Game_Mode).w                          ; $FFFFF600
Offset_0x004666:
		move.w  #$003C, (Timer_Count_Down).w                 ; $FFFFF614
		move.w  #$003F, ($FFFFF626).w
		clr.w   ($FFFFF794).w
Offset_0x004676:
		move.b  #$08, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr     Init_Demo_Control                      ; Offset_0x00495C
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		jsr     (Load_Object_Pos)                      ; Offset_0x00E1E8
		subq.w  #$01, ($FFFFF794).w
		bpl.s   Offset_0x0046A6
		move.w  #$0002, ($FFFFF794).w
		bsr     Pal_FadeOut                            ; Offset_0x00268C
Offset_0x0046A6:
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		bne.s   Offset_0x004676
		rts
;-------------------------------------------------------------------------------                  
; Modificar a superfície d´água
; ->>>
;-------------------------------------------------------------------------------                                   
Change_Water_Surface_Pos:                                      ; Offset_0x0046AE
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   Offset_0x0046D6
		move.w  (Camera_X).w, D1                             ; $FFFFEE00
		btst    #$00, ($FFFFFE05).w
		beq.s   Offset_0x0046C4
		addi.w  #$0020, D1
Offset_0x0046C4:
		move.w  D1, D0
		addi.w  #$0060, D0
		move.w  D0, ($FFFFB788).w
		addi.w  #$0120, D1
		move.w  D1, ($FFFFB7C8).w
Offset_0x0046D6:
		rts
;-------------------------------------------------------------------------------                  
; Modificar a superfície d´água
; <<<-
;-------------------------------------------------------------------------------                                   

;-------------------------------------------------------------------------------                  
; Efeitos embaixo d´água
; ->>>
;-------------------------------------------------------------------------------                                                                         
Water_Effects:                                                 ; Offset_0x0046D8
		tst.b   (Water_Level_Flag).w                         ; $FFFFF730
		beq.s   Offset_0x004734
		tst.b   (Level_Scroll_Flag).w                        ; $FFFFEEDC
		bne.s   Offset_0x0046F0
		cmpi.b  #$06, (Player_One+Obj_Routine).w             ; $FFFFB024
		bcc.s   Offset_0x0046F0
		bsr     Dynamic_Water_Height                   ; Offset_0x004756
Offset_0x0046F0:
		clr.b   ($FFFFF64E).w
		moveq   #$00, D0
		cmpi.b  #$0F, (Level_Id).w                           ; $FFFFFE10
		beq.s   Offset_0x004704
		move.b  ($FFFFFE60).w, D0
		lsr.w   #$01, D0
Offset_0x004704:
		add.w   (Water_Level_Change).w, D0                   ; $FFFFF648
		move.w  D0, (Water_Level).w                          ; $FFFFF646
		move.w  (Water_Level).w, D0                          ; $FFFFF646
		sub.w   (Camera_Y).w, D0                             ; $FFFFEE04
		bcc.s   Offset_0x004726
		tst.w   D0
		bpl.s   Offset_0x004726
		move.b  #$DF, (Scanlines_Count).w                    ; $FFFFF625
		move.b  #$01, ($FFFFF64E).w
Offset_0x004726:
		cmpi.w  #$00DF, D0
		bcs.s   Offset_0x004730
		move.w  #$00DF, D0
Offset_0x004730:
		move.b  D0, (Scanlines_Count).w                      ; $FFFFF625
Offset_0x004734:
		rts
;-------------------------------------------------------------------------------                  
; Efeitos embaixo d´água
; <<<-
;-------------------------------------------------------------------------------  
Water_Height_Array:                                            ; Offset_0x004736
		dc.w    $0600, $0600  ; HPz
		dc.w    $0600, $0600  
		dc.w    $0600, $0600  ; OOz
		dc.w    $0600, $0600  ; DHz
		dc.w    $0600, $0600  ; CNz
		dc.w    $0600, $0710  ; CPz
		dc.w    $0600, $0600  ; GCz
		dc.w    $0410, $0510  ; NGHz
;-------------------------------------------------------------------------------                                
; Muda o nível d´água nas fases
; ->>>
;------------------------------------------------------------------------------- 
Dynamic_Water_Height:                                          ; Offset_0x004756
		moveq   #$00, D0
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		subi.w  #$0800, D0
		ror.b   #$01, D0
		lsr.w   #$06, D0
		andi.w  #$FFFFFFFE, D0
		move.w  Dynamic_Water_Index(PC, D0), D0        ; Offset_0x00478A
		jsr     Dynamic_Water_Index(PC, D0)            ; Offset_0x00478A
		moveq   #$00, D1
		move.b  ($FFFFF64C).w, D1
		move.w  (Water_Level_New).w, D0                      ; $FFFFF64A
		sub.w   (Water_Level_Change).w, D0                   ; $FFFFF648
		beq.s   Offset_0x004788
		bcc.s   Offset_0x004784
		neg.w   D1
Offset_0x004784:
		add.w   D1, (Water_Level_Change).w                   ; $FFFFF648
Offset_0x004788:
		rts      
;-------------------------------------------------------------------------------                
Dynamic_Water_Index:                                           ; Offset_0x00478A                
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; HPz_1  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; HPz_2  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; Lvl9_1 ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; Lvl9_2 ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; OOz_1  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; OOz_2  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; DHz_1  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; DHz_2  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; CNz_1  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; CNz_2  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; CPz_1  ; Offset_0x0047AA
		dc.w    Dynamic_CPz_Water-Dynamic_Water_Index  ; CPz_2  ; Offset_0x0047AC
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; DEz_1  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; DEz_2  ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; NGHz_1 ; Offset_0x0047AA
		dc.w    Dynamic_Null_Water-Dynamic_Water_Index ; NGHz_2 ; Offset_0x0047AA
;-------------------------------------------------------------------------------                 
Dynamic_Null_Water:                                            ; Offset_0x0047AA
		rts                                                       
;-------------------------------------------------------------------------------    
Dynamic_CPz_Water:                                             ; Offset_0x0047AC
		cmpi.w  #$1DE0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x0047BA
		move.w  #$0510, (Water_Level_New).w                  ; $FFFFF64A
Offset_0x0047BA:
		rts  
;-------------------------------------------------------------------------------                    
S1_Lz_Wind_Tunnels:  ; Left over do Sonic 1                    ; Offset_0x0047BC
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne     Offset_0x004898
		lea     (S1_LZ_Wind_Data+$0008), A2            ; Offset_0x0048A2
		moveq   #$00, D0
		move.b  (Act_Id).w, D0                               ; $FFFFFE11
		lsl.w   #$03, D0
		adda.w  D0, A2
		moveq   #$00, D1
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   Offset_0x0047E0
		moveq   #$01, D1
		subq.w  #$08, A2
Offset_0x0047E0:
		lea     (Player_One).w, A1                           ; $FFFFB000
Offset_0x0047E4:
		move.w  Obj_X(A1), D0                                    ; $0008
		cmp.w   (A2), D0
		bcs     Offset_0x004882
		cmp.w   $0004(A2), D0
		bcc     Offset_0x004882
		move.w  Obj_Y(A1), D2                                    ; $000C
		cmp.w   $0002(A2), D2
		bcs     Offset_0x004882
		cmp.w   $0006(A2), D2
		bcc.s   Offset_0x004882
		move.b  ($FFFFFE0F).w, D0
		andi.b  #$3F, D0
		bne.s   Offset_0x00481C
		move.w  #$00D0, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x00481C:
		tst.b   ($FFFFF7C9).w
		bne     Offset_0x004898
		cmpi.b  #$04, Obj_Routine(A1)                            ; $0024
		bcc.s   Offset_0x004894
		move.b  #$01, ($FFFFF7C7).w
		subi.w  #$0080, D0
		cmp.w   (A2), D0
		bcc.s   Offset_0x00484A
		moveq   #$02, D0
		cmpi.b  #$01, (Act_Id).w                             ; $FFFFFE11
		bne.s   Offset_0x004846
		neg.w   D0
Offset_0x004846:
		add.w   D0, Obj_Y(A1)                                    ; $000C
Offset_0x00484A:
		addi.w  #$0004, Obj_X(A1)                                ; $0008
		move.w  #$0400, Obj_Speed(A1)                            ; $0010
		move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
		move.b  #$0F, Obj_Ani_Number(A1)                         ; $001C
		bset    #$01, Obj_Status(A1)                             ; $0022
		btst    #$00, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x004874
		subq.w  #$01, Obj_Y(A1)                                  ; $000C
Offset_0x004874:
		btst    #$01, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x004880
		addq.w  #$01, Obj_Y(A1)                                  ; $000C
Offset_0x004880:
		rts
Offset_0x004882:
		addq.w  #$08, A2
		dbra    D1, Offset_0x0047E4
		tst.b   ($FFFFF7C7).w
		beq.s   Offset_0x004898
		move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
Offset_0x004894:
		clr.b   ($FFFFF7C7).w
Offset_0x004898:
		rts   
;-------------------------------------------------------------------------------
S1_LZ_Wind_Data:                                               ; Offset_0x00489A   
		dc.w    $0A80, $0300, $0C10, $0380
		dc.w    $0F80, $0100, $1410, $0180
		dc.w    $0460, $0400, $0710, $0480
		dc.w    $0A20, $0600, $1610, $06E0
		dc.w    $0C80, $0600, $13D0, $0680  
;------------------------------------------------------------------------------- 
S1_LZ_Water_Slides:                                            ; Offset_0x0048C2
		lea     (Player_One).w, A1                           ; $FFFFB000
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x0048F6
		move.w  Obj_Y(A1), D0                                    ; $000C
		andi.w  #$0700, D0
		move.b  Obj_X(A1), D1                                    ; $0008
		andi.w  #$007F, D1
		add.w   D1, D0
		lea     (Level_Map_Buffer).w, A2                     ; $FFFF8000
		move.b  $00(A2, D0), D0
		lea     Offset_0x00495B(PC), A2
		moveq   #$06, D1
Offset_0x0048EE:
		cmp.b   -(A2), D0
		dbeq    D1, Offset_0x0048EE
		beq.s   Offset_0x004908
Offset_0x0048F6:
		tst.b   (Player_Status_Flag).w                       ; $FFFFF7CA
		beq.s   Offset_0x004906
		move.w  #$0005, Obj_Player_Control(A1)                   ; $002E
		clr.b   (Player_Status_Flag).w                       ; $FFFFF7CA
Offset_0x004906:
		rts
Offset_0x004908:
		cmpi.w  #$0003, D1
		bcc.s   Offset_0x004910
		nop
Offset_0x004910:
		bclr    #$00, Obj_Status(A1)                             ; $0022
		move.b  Offset_0x00494C(PC, D1), D0
		move.b  D0, Obj_Inertia(A1)                              ; $0014
		bpl.s   Offset_0x004926
		bset    #$00, Obj_Status(A1)                             ; $0022
Offset_0x004926:
		clr.b   $0015(A1)
		move.b  #$1B, Obj_Ani_Number(A1)                         ; $001C
		move.b  #$01, (Player_Status_Flag).w                 ; $FFFFF7CA
		move.b  ($FFFFFE0F).w, D0
		andi.b  #$1F, D0
		bne.s   Offset_0x00494A
		move.w  #$00D0, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x00494A:
		rts       
;-------------------------------------------------------------------------------
Offset_0x00494C:
		dc.b    $0A, $F5, $0A, $F6, $F5, $F4, $0B, $00
		dc.b    $02, $07, $03, $4C, $4B, $08, $04   
;-------------------------------------------------------------------------------  
Offset_0x00495B:
		dc.b    $00     
;-------------------------------------------------------------------------------  
Init_Demo_Control:                                             ; Offset_0x00495C
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bne.s   Demo_Mode_Control                      ; Offset_0x0049DA
		rts    
;-------------------------------------------------------------------------------
; Demo_Record: ; Não usado                                    ;  Offset_0x004964
		lea     ($00FE8000), A1
		move.w  ($FFFFF790).w, D0
		adda.w  D0, A1
		move.b  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
		cmp.b   (A1), D0
		bne.s   Offset_0x004986
		addq.b  #$01, $0001(A1)
		cmpi.b  #$FF, $0001(A1)
		beq.s   Offset_0x004986
		bra.s   Offset_0x00499A
Offset_0x004986:
		move.b  D0, $0002(A1)
		move.b  #$00, $0003(A1)
		addq.w  #$02, ($FFFFF790).w
		andi.w  #$03FF, ($FFFFF790).w
Offset_0x00499A:
		cmpi.b  #$00, (Level_Id).w                           ; $FFFFFE10
		bne.s   Offset_0x0049D8
		lea     ($00FEC000), A1
		move.w  ($FFFFF732).w, D0
		adda.w  D0, A1
		move.b  ($FFFFF606).w, D0
		cmp.b   (A1), D0
		bne.s   Offset_0x0049C4
		addq.b  #$01, $0001(A1)
		cmpi.b  #$FF, $0001(A1)
		beq.s   Offset_0x0049C4
		bra.s   Offset_0x0049D8
Offset_0x0049C4:
		move.b  D0, $0002(A1)
		move.b  #$00, $0003(A1)
		addq.w  #$02, ($FFFFF732).w
		andi.w  #$03FF, ($FFFFF732).w
Offset_0x0049D8:
		rts
;-------------------------------------------------------------------------------  
Demo_Mode_Control:                                             ; Offset_0x0049DA
		tst.b   (Control_Ports_Buffer_Data).w                ; $FFFFF604
		bpl.s   Offset_0x0049EC
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bmi.s   Offset_0x0049EC
		move.b  #gm_TitleScreen, (Game_Mode).w          ; $04, $FFFFF600
Offset_0x0049EC:
		lea     (Demo_Index), A1                       ; Offset_0x004A70
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		cmpi.b  #gm_SpecialStage, (Game_Mode).w         ; $10, $FFFFF600
		bne.s   Offset_0x004A02
		moveq   #$06, D0
Offset_0x004A02:
		lsl.w   #$02, D0
		move.l  $00(A1, D0), A1
		move.w  ($FFFFF790).w, D0
		adda.w  D0, A1
		move.b  (A1), D0
		lea     (Control_Ports_Buffer_Data).w, A0            ; $FFFFF604
		move.b  D0, D1
		moveq   #$00, D2
		eor.b   D2, D0
		move.b  D1, (A0)+
		and.b   D1, D0
		move.b  D0, (A0)+
		subq.b  #$01, ($FFFFF792).w
		bcc.s   Offset_0x004A30
		move.b  $0003(A1), ($FFFFF792).w
		addq.w  #$02, ($FFFFF790).w
Offset_0x004A30:
		cmpi.b  #$00, (Level_Id).w                           ; $FFFFFE10
		bne.s   Offset_0x004A68
		lea     (Demo_Green_Hill_Miles), A1            ; Offset_0x004EB2
		move.w  ($FFFFF732).w, D0
		adda.w  D0, A1
		move.b  (A1), D0
		lea     ($FFFFF606).w, A0
		move.b  D0, D1
		moveq   #$00, D2
		eor.b   D2, D0
		move.b  D1, (A0)+
		and.b   D1, D0
		move.b  D0, (A0)+
		subq.b  #$01, ($FFFFF734).w
		bcc.s   Offset_0x004A66
		move.b  $0003(A1), ($FFFFF734).w
		addq.w  #$02, ($FFFFF732).w
Offset_0x004A66:
		rts
Offset_0x004A68:
		move.w  #$0000, ($FFFFF606).w
		rts     
;-------------------------------------------------------------------------------  
Demo_Index:                                                    ; Offset_0x004A70
		dc.l    Demo_Green_Hill                        ; Offset_0x004DB2
		dc.l    Demo_Lvl1                              ; Offset_0x004DB2
		dc.l    Demo_Wood                              ; Offset_0x004DB2
		dc.l    Demo_Lvl3                              ; Offset_0x004DB2
		dc.l    Demo_Metropolis                        ; Offset_0x004DB2
		dc.l    Demo_Metropolis                        ; Offset_0x004DB2
		dc.l    Demo_Lvl6                              ; Offset_0x004DB2
		dc.l    Demo_Hill_Top                          ; Offset_0x004FB2
		dc.l    Demo_Hidden_Palace                     ; Offset_0x0050B2
		dc.l    Demo_Lvl9                              ; Offset_0x004DB2
		dc.l    Demo_Oil_Ocean                         ; Offset_0x004DB2
		dc.l    Demo_Dust_Hill                         ; Offset_0x004DB2
		dc.l    Demo_Casino_Night                      ; Offset_0x004DB2
		dc.l    Demo_Chemical_Plant                    ; Offset_0x0051B2
		dc.l    Demo_Genocide_City                     ; Offset_0x004DB2 
		dc.l    Demo_Neo_Green_Hill                    ; Offset_0x004DB2                   
		dc.l    Demo_Death_Egg                         ; Offset_0x004DB2      
;-------------------------------------------------------------------------------
; Offset_0x004AB4:
		dc.l    $00FE8000, $00FE8000, $00FE8000, $00FE8000
		dc.l    $00FE8000, $00FE8000, $00FE8000, $00FE8000
		dc.l    $00FE8000, $00FE8000, $00FE8000, $00FE8000
		dc.l    $00FE8000, $00FE8000, $00FE8000, $00FE8000
		dc.l    $00FE8000
;-------------------------------------------------------------------------------
Demo_End_Index: ; Left over do Sonic 1                         ; Offset_0x004AF8    
		dc.w    $008B, $0837, $0042, $085C, $006A, $085F, $002F, $082C
		dc.w    $0021, $0803, $2830, $0808, $002E, $0815, $000F, $0846
		dc.w    $001A, $08FF, $08CA, $0000, $0000, $0000, $0000, $0000
;-------------------------------------------------------------------------------
Load_Colision_Index:                                           ; Offset_0x004B28
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		lsl.w   #$02, D0
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		move.l  Primary_Colision_Index(PC, D0), A1     ; Offset_0x004B5A
		lea     (Primary_Colision_Data_Buffer).w, A2         ; $FFFFD000
		bsr.s   Load_Load_Colision_Index               ; Offset_0x004B4A
		move.l  Secundary_Colision_Index(PC, D0), A1   ; Offset_0x004B9E
		lea     (Secundary_Colision_Data_Buffer).w, A2       ; $FFFFD600
Load_Load_Colision_Index:                                      ; Offset_0x004B4A
		move.w  #$02FF, D1
		moveq   #$00, D2
Load_Load_Colision_Index_Loop:                                 ; Offset_0x004B50
		move.b  (A1)+, D2
		move.w  D2, (A2)+
		dbra    D1, Load_Load_Colision_Index_Loop      ; Offset_0x004B50
		rts                 
;-------------------------------------------------------------------------------  
Primary_Colision_Index:                                        ; Offset_0x004B5A
		dc.l    Green_Hill_Colision_Data_1             ; Offset_0x0389EA
		dc.l    Lvl1_Colision_Data_1                   ; Offset_0x03B3EA
		dc.l    Wood_Colision_Data_1                   ; Offset_0x038FEA
		dc.l    Lvl3_Colision_Data_1                   ; Offset_0x03B3EA
		dc.l    Metropolis_Colision_Data_1             ; Offset_0x0392EA
		dc.l    Metropolis_Colision_Data_1             ; Offset_0x0392EA
		dc.l    Lvl6_Colision_Data_1                   ; Offset_0x03B3EA
		dc.l    Hill_Top_Colision_Data_1               ; Offset_0x0389EA
		dc.l    Hidden_Palace_Colision_Data_1          ; Offset_0x0395EA
		dc.l    Lvl9_Colision_Data_1                   ; Offset_0x03B3EA
		dc.l    Oil_Ocean_Colision_Data_1              ; Offset_0x039BEA
		dc.l    Dust_Hill_Colision_Data_1              ; Offset_0x039EEA
		dc.l    Casino_Night_Colision_Data_1           ; Offset_0x03A1EA
		dc.l    Chemical_Plant_Colision_Data_1         ; Offset_0x03A7EA
		dc.l    Genocide_City_Colision_Data_1          ; Offset_0x03B3EA
		dc.l    Neo_Green_Hill_Colision_Data_1         ; Offset_0x03ADEA
		dc.l    Death_Egg_Colision_Data_1              ; Offset_0x03B3EA   
;------------------------------------------------------------------------------- 
Secundary_Colision_Index:                                      ; Offset_0x004B9E
		dc.l    Green_Hill_Colision_Data_2             ; Offset_0x038CEA
		dc.l    Lvl1_Colision_Data_2                   ; Offset_0x03B3EA
		dc.l    Wood_Colision_Data_2                   ; Offset_0x038FEA
		dc.l    Lvl3_Colision_Data_2                   ; Offset_0x03B3EA
		dc.l    Metropolis_Colision_Data_2             ; Offset_0x0392EA
		dc.l    Metropolis_Colision_Data_2             ; Offset_0x0392EA
		dc.l    Lvl6_Colision_Data_2                   ; Offset_0x03B3EA
		dc.l    Hill_Top_Colision_Data_2               ; Offset_0x038CEA
		dc.l    Hidden_Palace_Colision_Data_2          ; Offset_0x0398EA
		dc.l    Lvl9_Colision_Data_2                   ; Offset_0x03B3EA
		dc.l    Oil_Ocean_Colision_Data_2              ; Offset_0x039BEA
		dc.l    Dust_Hill_Colision_Data_2              ; Offset_0x039EEA
		dc.l    Casino_Night_Colision_Data_2           ; Offset_0x03A4EA
		dc.l    Chemical_Plant_Colision_Data_2         ; Offset_0x03AAEA
		dc.l    Genocide_City_Colision_Data_2          ; Offset_0x03B3EA
		dc.l    Neo_Green_Hill_Colision_Data_2         ; Offset_0x03B0EA
		dc.l    Death_Egg_Colision_Data_2              ; Offset_0x03B3EA                               
;-------------------------------------------------------------------------------
Oscillate_Num_Init:                                            ; Offset_0x004BE2
		lea     ($FFFFFE5E).w, A1
		lea     (Oscillate_Data), A2                   ; Offset_0x004BF6
		moveq   #$20, D1
Offset_0x004BEE:
		move.w  (A2)+, (A1)+
		dbra    D1, Offset_0x004BEE
		rts 
;-------------------------------------------------------------------------------                
Oscillate_Data:                                                ; Offset_0x004BF6 
		dc.w    $007D, $0080, $0000, $0080, $0000, $0080, $0000, $0080
		dc.w    $0000, $0080, $0000, $0080, $0000, $0080, $0000, $0080
		dc.w    $0000, $0080, $0000, $3848, $00EE, $2080, $00B4, $3080
		dc.w    $010E, $5080, $01C2, $7080, $0276, $0080, $0000, $4000
		dc.w    $00FE
;-------------------------------------------------------------------------------                                                                            
Oscillate_Num_Do:                                              ; Offset_0x004C38
		cmpi.b  #$06, (Player_One+Obj_Routine).w             ; $FFFFB024
		bcc.s   Offset_0x004C8E
		lea     ($FFFFFE5E).w, A1
		lea     (Oscillate_Data2), A2                  ; Offset_0x004C90
		move.w  (A1)+, D3
		moveq   #$0F, D1
Offset_0x004C4E:
		move.w  (A2)+, D2
		move.w  (A2)+, D4
		btst    D1, D3
		bne.s   Offset_0x004C6E
		move.w  $0002(A1), D0
		add.w   D2, D0
		move.w  D0, $0002(A1)
		add.w   D0, $0000(A1)
		cmp.b   $0000(A1), D4
		bhi.s   Offset_0x004C84
		bset    D1, D3
		bra.s   Offset_0x004C84
Offset_0x004C6E:
		move.w  $0002(A1), D0
		sub.w   D2, D0
		move.w  D0, $0002(A1)
		add.w   D0, $0000(A1)
		cmp.b   $0000(A1), D4
		bls.s   Offset_0x004C84
		bclr    D1, D3
Offset_0x004C84:
		addq.w  #$04, A1
		dbra    D1, Offset_0x004C4E
		move.w  D3, ($FFFFFE5E).w
Offset_0x004C8E:
		rts                                                                 
;-------------------------------------------------------------------------------   
Oscillate_Data2:                                               ; Offset_0x004C90
		dc.w    $0002, $0010, $0002, $0018, $0002, $0020, $0002, $0030
		dc.w    $0004, $0020, $0008, $0008, $0008, $0040, $0004, $0040
		dc.w    $0002, $0038, $0002, $0038, $0002, $0020, $0003, $0030
		dc.w    $0005, $0050, $0007, $0070, $0002, $0040, $0002, $0040    
;===============================================================================
; Sub Rotina para fazer os anéis e outros objetos girarem em torno de si  
; ->>>
;===============================================================================
Change_Object_Frame:                                           ; Offset_0x004CD0
		subq.b  #$01, (Object_Frame_Buffer).w                ; $FFFFFEA0
		bpl.s   Offset_0x004CE6
		move.b  #$0B, (Object_Frame_Buffer).w                ; $FFFFFEA0
		subq.b  #$01, (Object_Frame_Buffer+$0001).w          ; $FFFFFEA1
		andi.b  #$07, (Object_Frame_Buffer+$0001).w          ; $FFFFFEA1
Offset_0x004CE6:
		subq.b  #$01, (Object_Frame_Buffer+$0002).w          ; $FFFFFEA2
		bpl.s   Offset_0x004CFC
		move.b  #$07, (Object_Frame_Buffer+$0002).w          ; $FFFFFEA2
		addq.b  #$01, (Object_Frame_Buffer+$0003).w          ; $FFFFFEA3
		andi.b  #$03, (Object_Frame_Buffer+$0003).w          ; $FFFFFEA3
Offset_0x004CFC:
		subq.b  #$01, (Object_Frame_Buffer+$0004).w          ; $FFFFFEA4
		bpl.s   Offset_0x004D1A
		move.b  #$07, (Object_Frame_Buffer+$0004).w          ; $FFFFFEA4
		addq.b  #$01, (Object_Frame_Buffer+$0005).w          ; $FFFFFEA5
		cmpi.b  #$06, (Object_Frame_Buffer+$0005).w          ; $FFFFFEA5
		bcs.s   Offset_0x004D1A
		move.b  #$00, (Object_Frame_Buffer+$0005).w          ; $FFFFFEA5
Offset_0x004D1A:
		tst.b   (Object_Frame_Buffer+$0006).w                ; $FFFFFEA6
		beq.s   Offset_0x004D3C
		moveq   #$00, D0
		move.b  (Object_Frame_Buffer+$0006).w, D0            ; $FFFFFEA6
		add.w   (Object_Frame_Buffer+$0008).w, D0            ; $FFFFFEA8
		move.w  D0, (Object_Frame_Buffer+$0008).w            ; $FFFFFEA8
		rol.w   #$07, D0
		andi.w  #$0003, D0
		move.b  D0, (Object_Frame_Buffer+$0007).w            ; $FFFFFEA7
		subq.b  #$01, (Object_Frame_Buffer+$0006).w          ; $FFFFFEA6
Offset_0x004D3C:
		rts                                            
;===============================================================================
; Sub Rotina para fazer os anéis e outros objetos girarem em torno de si  
; <<<-
;===============================================================================

;===============================================================================
; Verifica se esta no final da fase 
; ->>>
;===============================================================================  
Test_End_Level_Art_Load:                                       ; Offset_0x004D3E
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne     Offset_0x004DB0
		cmpi.w  #$0001, (Level_Id).w                         ; $FFFFFE10
		beq.s   Offset_0x004DB0
		cmpi.w  #$0701, (Level_Id).w                         ; $FFFFFE10
		beq.s   Offset_0x004DB0
		cmpi.w  #$0B01, (Level_Id).w                         ; $FFFFFE10
		beq.s   Offset_0x004DB0
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		move.w  (Sonic_Level_Limits_Max_X).w, D1             ; $FFFFEECA
		subi.w  #$0100, D1
		cmp.w   D1, D0
		blt.s   Offset_0x004D84
		tst.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
		beq.s   Offset_0x004D84
		cmp.w   (Sonic_Level_Limits_Min_X).w, D1             ; $FFFFEEC8
		beq.s   Offset_0x004D84
		move.w  D1, (Sonic_Level_Limits_Min_X).w             ; $FFFFEEC8
		moveq   #$27, D0
		bra     LoadPLC2                               ; Offset_0x0017C6
Offset_0x004D84:
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x004DB0
		move.w  (Camera_X_2).w, D0                           ; $FFFFEE20
		move.w  (Miles_Level_Limits_Max_X).w, D1             ; $FFFFEEFA
		subi.w  #$0100, D1
		cmp.w   D1, D0
		blt.s   Offset_0x004DB0
		tst.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
		beq.s   Offset_0x004DB0
		cmp.w   (Miles_Level_Limits_Min_X).w, D1             ; $FFFFEEF8
		beq.s   Offset_0x004DB0
		move.w  D1, (Miles_Level_Limits_Min_X).w             ; $FFFFEEF8
		moveq   #$27, D0
		bra     LoadPLC2                               ; Offset_0x0017C6
Offset_0x004DB0:
		rts
;===============================================================================
; Verifica se esta no final da fase 
; <<<-
;===============================================================================
Demo_Green_Hill:                                               ; Offset_0x004DB2
Demo_Lvl1:                                                     ; Offset_0x004DB2
Demo_Wood:                                                     ; Offset_0x004DB2
Demo_Lvl3:                                                     ; Offset_0x004DB2
Demo_Metropolis:                                               ; Offset_0x004DB2
Demo_Lvl6:                                                     ; Offset_0x004DB2
Demo_Lvl9:                                                     ; Offset_0x004DB2
Demo_Oil_Ocean:                                                ; Offset_0x004DB2
Demo_Dust_Hill:                                                ; Offset_0x004DB2
Demo_Casino_Night:                                             ; Offset_0x004DB2
Demo_Genocide_City:                                            ; Offset_0x004DB2
Demo_Neo_Green_Hill:                                           ; Offset_0x004DB2
Demo_Death_Egg:                                                ; Offset_0x004DB2 
		incbin  'misc/ehzdemosonic.dat'
Demo_Green_Hill_Miles:                                         ; Offset_0x004EB2
		incbin  'misc/ehzdemotails.dat'
Demo_Hill_Top:                                                 ; Offset_0x004FB2
		incbin  'misc/htzdemo.dat'
Demo_Hidden_Palace:                                            ; Offset_0x0050B2 
		incbin  'misc/hpzdemo.dat'
Demo_Chemical_Plant:                                           ; Offset_0x0051B2
		incbin  'misc/cpzdemo.dat'
;===============================================================================
; Modo de jogo ou demonstração das fases 
; <<<-
;=============================================================================== 
		nop
Jmp_00_To_Dynamic_Art_Cues:                                    ; Offset_0x0052B4
		jmp     (Dynamic_Art_Cues)                     ; Offset_0x02C61C
		dc.w    $0000
;===============================================================================
; Rotina principal de controle dos Estágios Especiais
; ->>>
;===============================================================================                  
Special_Stage:                                                 ; Offset_0x0052BC
		move.w  #$00CA, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		bsr     Pal_MakeFlash                          ; Offset_0x002794
		move    #$2700, SR
		lea     (VDP_Control_Port), A6                       ; $00C00004
		move.w  #$8B03, (A6)
		move.w  #$8004, (A6)
		move.w  #$8AAF, (Horizontal_Interrupt_Count).w       ; $FFFFF624
		move.w  #$9011, (A6)
		move.w  ($FFFFF60C).w, D0
		andi.b  #$BF, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
		bsr     ClearScreen                            ; Offset_0x001418
		move    #$2300, SR
		lea     (VDP_Control_Port), A5                       ; $00C00004
		move.w  #$8F01, (A5)
		move.l  #$946F93FF, (A5)
		move.w  #$9780, (A5)
		move.l  #$50000081, (A5)
		move.w  #$0000, (VDP_Data_Port)                      ; $00C00000
Offset_0x00531C:
		move.w  (A5), D1
		btst    #$01, D1
		bne.s   Offset_0x00531C
		move.w  #$8F02, (A5)
		bsr     Special_Stage_Background_Load          ; Offset_0x00556C
		moveq   #$14, D0
		bsr     RunPLC_ROM                             ; Offset_0x001900
		lea     (Special_Stage_Memory_Address).w, A1         ; $FFFFD000
		moveq   #$00, D0
		move.w  #$07FF, D1
SS_Loop_Clear_ObjRam:                                          ; Offset_0x00533C
		move.l  D0, (A1)+
		dbra    D1, SS_Loop_Clear_ObjRam               ; Offset_0x00533C
		lea     ($FFFFF700).w, A1
		moveq   #$00, D0
		move.w  #$003F, D1
Offset_0x00534C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00534C
		lea     ($FFFFFE60).w, A1
		moveq   #$00, D0
		move.w  #$0027, D1
Offset_0x00535C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00535C
		lea     ($FFFFAA00).w, A1
		moveq   #$00, D0
		move.w  #$007F, D1
Offset_0x00536C:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00536C
		clr.b   ($FFFFF64E).w
		clr.w   ($FFFFFE02).w
		moveq   #$16, D0
		bsr     PalLoad1                               ; Offset_0x002914
		jsr     (Special_Stage_Load)                   ; Offset_0x02BC66
		move.l  #$00000000, (Camera_X).w                     ; $FFFFEE00
		move.l  #$00000000, (Camera_Y).w                     ; $FFFFEE04
		move.b  #$09, (Player_One).w                         ; $FFFFB000
		bsr     Special_Stage_Pal_Cycle                ; Offset_0x005626
		clr.w   ($FFFFF750).w
		move.w  #$0040, ($FFFFF752).w
		move.w  #$0089, D0
		bsr     Play_Music                             ; Offset_0x00150C
		move.w  #$0000, ($FFFFF790).w
		lea     (Demo_Index), A1                       ; Offset_0x004A70
		moveq   #$06, D0
		lsl.w   #$02, D0
		move.l  $00(A1, D0), A1
		move.b  $0001(A1), ($FFFFF792).w
		subq.b  #$01, ($FFFFF792).w
		clr.w   (Ring_Count).w                               ; $FFFFFE20
		clr.b   (Ring_Life_Flag).w                           ; $FFFFFE1B
		move.w  #$0000, (Debug_Mode_Flag_Index).w            ; $FFFFFE08
		move.w  #$0708, (Timer_Count_Down).w                 ; $FFFFF614
		tst.b   ($FFFFFFD2).w
		beq.s   Offset_0x0053F8
		btst    #$06, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x0053F8
		move.b  #$01, (Debug_Mode_Active_Flag).w             ; $FFFFFFFA
Offset_0x0053F8:
		move.w  ($FFFFF60C).w, D0
		ori.b   #$40, D0
		move.w  D0, (VDP_Control_Port)                       ; $00C00004
		bsr     Pal_MakeWhite                          ; Offset_0x0026EA
Special_Stage_Loop:                                            ; Offset_0x00540A
		bsr     Pause                                  ; Offset_0x00152A
		move.b  #$0A, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr     Init_Demo_Control                      ; Offset_0x00495C
		move.w  (Control_Ports_Buffer_Data).w, ($FFFFF602).w ; $FFFFF604
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		jsr     (Special_Stage_Show_Layout)            ; Offset_0x02B738
		bsr     Special_Stage_Background_Animate       ; Offset_0x0058A8
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		beq.s   Offset_0x005446
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		beq     Special_Stage_Game_Reset               ; Offset_0x00555A
Offset_0x005446:
		cmpi.b  #gm_SpecialStage, (Game_Mode).w         ; $10, $FFFFF600
		beq     Special_Stage_Loop                     ; Offset_0x00540A
		tst.w   (Auto_Control_Player_Flag).w                 ; $FFFFFFF0
		bne     Special_Stage_Exit_To_Level            ; Offset_0x005562
		move.b  #gm_PlayMode, (Game_Mode).w            ; $0C,  $FFFFF600
		cmpi.w  #$0503, (Level_Id).w                         ; $FFFFFE10
		bcs.s   Offset_0x00546A
		clr.w   (Level_Id).w                                 ; $FFFFFE10
Offset_0x00546A:
		move.w  #$003C, (Timer_Count_Down).w                 ; $FFFFF614
		move.w  #$003F, ($FFFFF626).w
		clr.w   ($FFFFF794).w
Special_Stage_Loop_2:                                          ; Offset_0x00547A
		move.b  #$16, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		bsr     Init_Demo_Control                      ; Offset_0x00495C
		move.w  (Control_Ports_Buffer_Data).w, ($FFFFF602).w ; $FFFFF604
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		jsr     (Special_Stage_Show_Layout)            ; Offset_0x02B738
		bsr     Special_Stage_Background_Animate       ; Offset_0x0058A8
		subq.w  #$01, ($FFFFF794).w
		bpl.s   Offset_0x0054B4
		move.w  #$0002, ($FFFFF794).w
		bsr     Pal_ToWhite                            ; Offset_0x0027B4
Offset_0x0054B4:
		tst.w   (Timer_Count_Down).w                         ; $FFFFF614
		bne.s   Special_Stage_Loop_2                   ; Offset_0x00547A
		move    #$2700, SR
		lea     (VDP_Control_Port), A6                       ; $00C00004
		move.w  #$8230, (A6)
		move.w  #$8407, (A6)
		move.w  #$9001, (A6)
		bsr     ClearScreen                            ; Offset_0x001418
		jsr     (Head_Up_Display_Base)                 ; Offset_0x02D488
		move    #$2300, SR
		moveq   #$16, D0
		bsr     PalLoad2                               ; Offset_0x002930
		moveq   #$00, D0
		bsr     LoadPLC2                               ; Offset_0x0017C6
		moveq   #$1B, D0
		bsr     LoadPLC                                ; Offset_0x001794
		move.b  #$01, (HUD_Score_Refresh_Flag).w             ; $FFFFFE1F
		move.b  #$01, ($FFFFF7D6).w
		move.w  (Ring_Count).w, D0                           ; $FFFFFE20
		mulu.w  #$000A, D0
		move.w  D0, ($FFFFF7D4).w
		move.w  #$008E, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		lea     (Obj_Memory_Address).w, A1                   ; $FFFFB000
		moveq   #$00, D0
		move.w  #$07FF, D1
S1_SS_Results_Clear_Ram_Loop:                                  ; Offset_0x00551C
		move.l  D0, (A1)+
		dbra    D1, S1_SS_Results_Clear_Ram_Loop       ; Offset_0x00551C
;-------------------------------------------------------------------------------
SS_Results_Loop:                                               ; Offset_0x005522
		bsr     Pause                                  ; Offset_0x00152A
		move.b  #$0C, (VBlank_Index).w                       ; $FFFFF62A
		bsr     Wait_For_VSync                         ; Offset_0x003250
		jsr     (Load_Objects)                         ; Offset_0x00CEA8
		jsr     (Build_Sprites)                        ; Offset_0x00D442
		bsr     RunPLC                                 ; Offset_0x001800
		tst.w   ($FFFFFE02).w
		beq.s   SS_Results_Loop                        ; Offset_0x005522
		tst.l   (PLC_Buffer).w                               ; $FFFFF680
		bne.s   SS_Results_Loop                        ; Offset_0x005522
		move.w  #$00CA, D0
		bsr     Play_Sfx                               ; Offset_0x001512
		bsr     Pal_MakeFlash                          ; Offset_0x002794
		rts  
;------------------------------------------------------------------------------- 
Special_Stage_Game_Reset:                                      ; Offset_0x00555A
		move.b  #gm_SEGALogo, (Game_Mode).w             ; $00, $FFFFF600
		rts
;-------------------------------------------------------------------------------                
Special_Stage_Exit_To_Level:                                   ; Offset_0x005562
		cmpi.b  #gm_PlayMode, (Game_Mode).w             ; $0C, $FFFFF600
		beq.s   Special_Stage_Game_Reset               ; Offset_0x00555A
		rts
;-------------------------------------------------------------------------------                
Special_Stage_Background_Load:                                 ; Offset_0x00556C
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.w  #$4051, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		move.l  #$50000001, D3
		lea     (M68K_RAM_Start+$0080), A2                   ; $FFFF0080
		moveq   #$06, D7
Offset_0x005588:
		move.l  D3, D0
		moveq   #$03, D6
		moveq   #$00, D4
		cmpi.w  #$0003, D7
		bcc.s   Offset_0x005596
		moveq   #$01, D4
Offset_0x005596:
		moveq   #$07, D5
Offset_0x005598:
		move.l  A2, A1
		eori.b  #$01, D4
		bne.s   Offset_0x0055AC
		cmpi.w  #$0006, D7
		bne.s   Offset_0x0055BC
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
Offset_0x0055AC:
		movem.l D0-D4, -(A7)
		moveq   #$07, D1
		moveq   #$07, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		movem.l (A7)+, D0-D4
Offset_0x0055BC:
		addi.l  #$00100000, D0
		dbra    D5, Offset_0x005598
		addi.l  #$03800000, D0
		eori.b  #$01, D4
		dbra    D6, Offset_0x005596
		addi.l  #$10000000, D3
		bpl.s   Offset_0x0055E6
		swap.w  D3
		addi.l  #$0000C000, D3
		swap.w  D3
Offset_0x0055E6:
		adda.w  #$0080, A2
		dbra    D7, Offset_0x005588
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.w  #$4000, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.l  #$40000003, D0
		moveq   #$3F, D1
		moveq   #$1F, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.l  #$50000003, D0
		moveq   #$3F, D1
		moveq   #$3F, D2
		bsr     ShowVDPGraphics                        ; Offset_0x0015A4
		rts
;-------------------------------------------------------------------------------                
Special_Stage_Pal_Cycle:                                       ; Offset_0x005626
		tst.w   (Pause_Status).w                             ; $FFFFF63A
		bne.s   Offset_0x0056AA
		subq.w  #$01, ($FFFFF79C).w
		bpl.s   Offset_0x0056AA
		lea     (VDP_Control_Port), A6                       ; $00C00004
		move.w  ($FFFFF79A).w, D0
		addq.w  #$01, ($FFFFF79A).w
		andi.w  #$001F, D0
		lsl.w   #$02, D0
		lea     (SS_Pal_Cycle_Data), A0                ; Offset_0x005700
		adda.w  D0, A0
		move.b  (A0)+, D0
		bpl.s   Offset_0x005656
		move.w  #$01FF, D0
Offset_0x005656:
		move.w  D0, ($FFFFF79C).w
		moveq   #$00, D0
		move.b  (A0)+, D0
		move.w  D0, ($FFFFF7A0).w
		lea     (SS_Pal_Cycle_Data_01), A1             ; Offset_0x005780
		lea     $00(A1, D0), A1
		move.w  #$8200, D0
		move.b  (A1)+, D0
		move.w  D0, (A6)
		move.b  (A1), ($FFFFF616).w
		move.w  #$8400, D0
		move.b  (A0)+, D0
		move.w  D0, (A6)
		move.l  #$40000010, (VDP_Control_Port)               ; $00C00004
		move.l  ($FFFFF616).w, (VDP_Data_Port)               ; $00C00000
		moveq   #$00, D0
		move.b  (A0)+, D0
		bmi.s   Offset_0x0056AC
		lea     (Pal_SS_Cycle1), A1                    ; Offset_0x00578E
		adda.w  D0, A1
		lea     ($FFFFFB4E).w, A2
		move.l  (A1)+, (A2)+
		move.l  (A1)+, (A2)+
		move.l  (A1)+, (A2)+
Offset_0x0056AA:
		rts
Offset_0x0056AC:
		move.w  ($FFFFF79E).w, D1
		cmpi.w  #$008A, D0
		bcs.s   Offset_0x0056B8
		addq.w  #$01, D1
Offset_0x0056B8:
		mulu.w  #$002A, D1
		lea     (Pal_SS_Cycle2), A1                    ; Offset_0x0057D6
		adda.w  D1, A1
		andi.w  #$007F, D0
		bclr    #$00, D0
		beq.s   Offset_0x0056DC
		lea     ($FFFFFB6E).w, A2
		move.l  (A1), (A2)+
		move.l  $0004(A1), (A2)+
		move.l  $0008(A1), (A2)+
Offset_0x0056DC:
		adda.w  #$000C, A1
		lea     ($FFFFFB5A).w, A2
		cmpi.w  #$000A, D0
		bcs.s   Offset_0x0056F2
		subi.w  #$000A, D0
		lea     ($FFFFFB7A).w, A2
Offset_0x0056F2:
		move.w  D0, D1
		add.w   D0, D0
		add.w   D1, D0
		adda.w  D0, A1
		move.l  (A1)+, (A2)+
		move.w  (A1)+, (A2)+
		rts
;-------------------------------------------------------------------------------
SS_Pal_Cycle_Data:                                             ; Offset_0x005700 
		dc.w    $0300, $0792, $0300, $0790, $0300, $078E, $0300, $078C
		dc.w    $0300, $078B, $0300, $0780, $0300, $0782, $0300, $0784
		dc.w    $0300, $0786, $0300, $0788, $0708, $0700, $070A, $070C
		dc.w    $FF0C, $0718, $FF0C, $0718, $070A, $070C, $0708, $0700
		dc.w    $0300, $0688, $0300, $0686, $0300, $0684, $0300, $0682
		dc.w    $0300, $0681, $0300, $068A, $0300, $068C, $0300, $068E
		dc.w    $0300, $0690, $0300, $0692, $0702, $0624, $0704, $0630
		dc.w    $FF06, $063C, $FF06, $063C, $0704, $0630, $0702, $0624     
;-------------------------------------------------------------------------------
SS_Pal_Cycle_Data_01:                                          ; Offset_0x005780   
		dc.w    $1001, $1800, $1801, $2000, $2001, $2800, $2801
;-------------------------------------------------------------------------------
Pal_SS_Cycle1:                                                 ; Offset_0x00578E  
		dc.w    $0400, $0600, $0620, $0624, $0664, $0666, $0600, $0820
		dc.w    $0A64, $0A68, $0AA6, $0AAA, $0800, $0C42, $0E86, $0ECA
		dc.w    $0EEC, $0EEE, $0400, $0420, $0620, $0620, $0864, $0666
		dc.w    $0420, $0620, $0842, $0842, $0A86, $0AAA, $0620, $0842
		dc.w    $0A64, $0C86, $0EA8, $0EEE 
;-------------------------------------------------------------------------------
Pal_SS_Cycle2:                                                 ; Offset_0x0057D6 
		dc.w    $0EEA, $0EE0, $0AA0, $0880, $0660, $0440, $0EE0, $0AA0
		dc.w    $0440, $0AA0, $0AA0, $0AA0, $0860, $0860, $0860, $0640
		dc.w    $0640, $0640, $0400, $0400, $0400, $0AEC, $06EA, $04C6
		dc.w    $02A4, $0082, $0060, $06EA, $04C6, $0060, $04C6, $04C6
		dc.w    $04C6, $0484, $0484, $0484, $0442, $0442, $0442, $0400
		dc.w    $0400, $0400, $0ECC, $0E8A, $0C68, $0A46, $0824, $0602
		dc.w    $0E8A, $0C68, $0602, $0C68, $0C68, $0C68, $0846, $0846
		dc.w    $0846, $0624, $0624, $0624, $0400, $0400, $0400, $0AEC
		dc.w    $08CA, $06A8, $0486, $0264, $0042, $08CA, $06A8, $0042
		dc.w    $06A8, $06A8, $06A8, $0684, $0684, $0684, $0442, $0442
		dc.w    $0442, $0400, $0400, $0400, $0EEC, $0CCA, $0AA8, $0886
		dc.w    $0664, $0442, $0CCA, $0AA8, $0442, $0AA8, $0AA8, $0AA8
		dc.w    $0864, $0864, $0864, $0642, $0642, $0642, $0400, $0400
		dc.w    $0400  
;-------------------------------------------------------------------------------  
Special_Stage_Background_Animate:                              ; Offset_0x0058A8
		move.w  ($FFFFF7A0).w, D0
		bne.s   Offset_0x0058BA
		move.w  #$0000, (Camera_Y_x4).w                      ; $FFFFEE0C
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
Offset_0x0058BA:
		cmpi.w  #$0008, D0
		bcc.s   Offset_0x005912
		cmpi.w  #$0006, D0
		bne.s   Offset_0x0058D4
		addq.w  #$01, (Camera_X_x4).w                        ; $FFFFEE18
		addq.w  #$01, (Camera_Y_x4).w                        ; $FFFFEE0C
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
Offset_0x0058D4:
		moveq   #$00, D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
		swap.w  D0
		lea     (SS_Bg_Animate_Data_02), A1            ; Offset_0x00598F
		lea     ($FFFFAA00).w, A3
		moveq   #$09, D3
Offset_0x0058EA:
		move.w  $0002(A3), D0
		bsr     CalcSine                               ; Offset_0x003282
		moveq   #$00, D2
		move.b  (A1)+, D2
		muls.w  D2, D0
		asr.l   #$08, D0
		move.w  D0, (A3)+
		move.b  (A1)+, D2
		ext.w   D2
		add.w   D2, (A3)+
		dbra    D3, Offset_0x0058EA
		lea     ($FFFFAA00).w, A3
		lea     (SS_Bg_Animate_Data_00), A2            ; Offset_0x00597C
		bra.s   Offset_0x005942
Offset_0x005912:
		cmpi.w  #$000C, D0
		bne.s   Offset_0x005938
		subq.w  #$01, (Camera_X_x4).w                        ; $FFFFEE18
		lea     ($FFFFAB00).w, A3
		move.l  #$00018000, D2
		moveq   #$06, D1
Offset_0x005928:
		move.l  (A3), D0
		sub.l   D2, D0
		move.l  D0, (A3)+
		subi.l  #$00002000, D2
		dbra    D1, Offset_0x005928
Offset_0x005938:
		lea     ($FFFFAB00).w, A3
		lea     (SS_Bg_Animate_Data_01), A2            ; Offset_0x005987
Offset_0x005942:
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_X_x4).w, D0                          ; $FFFFEE18
		neg.w   D0
		swap.w  D0
		moveq   #$00, D3
		move.b  (A2)+, D3
		move.w  (Camera_Y_x4).w, D2                          ; $FFFFEE0C
		neg.w   D2
		andi.w  #$00FF, D2
		lsl.w   #$02, D2
Offset_0x00595E:
		move.w  (A3)+, D0
		addq.w  #$02, A3
		moveq   #$00, D1
		move.b  (A2)+, D1
		subq.w  #$01, D1
Offset_0x005968:
		move.l  D0, $00(A1, D2)
		addq.w  #$04, D2
		andi.w  #$03FC, D2
		dbra    D1, Offset_0x005968
		dbra    D3, Offset_0x00595E
		rts
;-------------------------------------------------------------------------------
SS_Bg_Animate_Data_00:                                         ; Offset_0x00597C  
		dc.b    $09, $28, $18, $10, $28, $18, $10, $30
		dc.b    $18, $08, $10   
;-------------------------------------------------------------------------------
SS_Bg_Animate_Data_01:                                         ; Offset_0x005987   
		dc.b    $06, $30, $30, $30, $28, $18, $18, $18
;-------------------------------------------------------------------------------
SS_Bg_Animate_Data_02:                                         ; Offset_0x00598F  
		dc.b    $08, $02, $04, $FF, $02, $03, $08, $FF
		dc.b    $04, $02, $02, $03, $08, $FD, $04, $02
		dc.b    $02, $03, $02, $FF, $00                
;===============================================================================
; Rotina principal de controle dos Estágios Especiais
; <<<-
;===============================================================================  

;===============================================================================
; Rotina para carregar os limites das fases
; ->>>
;===============================================================================
Level_Size_Load:                                               ; Offset_0x0059A4
		clr.w   (Scroll_Flag_Array).w                        ; $FFFFEE50
		clr.w   (Scroll_Flag_Array+$0002).w                  ; $FFFFEE52
		clr.w   (Scroll_Flag_Array+$0004).w                  ; $FFFFEE54
		clr.w   (Scroll_Flag_Array+$0006).w                  ; $FFFFEE56
		clr.w   (Scroll_Flag_Array+$0008).w                  ; $FFFFEE58
		clr.w   (Scroll_Flag_Array+$000A).w                  ; $FFFFEE5A
		clr.w   (Scroll_Flag_Array+$000C).w                  ; $FFFFEE5C
		clr.w   (Scroll_Flag_Array+$000E).w                  ; $FFFFEE5E
		clr.w   (Scroll_Flag_Array_2).w                      ; $FFFFEEA0
		clr.w   (Scroll_Flag_Array_2+$0002).w                ; $FFFFEEA2
		clr.w   (Scroll_Flag_Array_2+$0004).w                ; $FFFFEEA4
		clr.w   (Scroll_Flag_Array_2+$0006).w                ; $FFFFEEA6
		clr.w   (Scroll_Flag_Array_2+$0008).w                ; $FFFFEEA8
		clr.w   (Scroll_Flag_Array_2+$000A).w                ; $FFFFEEAA
		clr.w   (Scroll_Flag_Array_2+$000C).w                ; $FFFFEEAC
		clr.w   (Scroll_Flag_Array_2+$000E).w                ; $FFFFEEAE
		clr.b   (Level_Scroll_Flag).w                        ; $FFFFEEDC
		clr.b   ($FFFFEEBC).w
		clr.b   ($FFFFEEBD).w
		moveq   #$00, D0
		move.b  D0, (Dyn_Resize_Routine).w                   ; $FFFFEEDF
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		ror.b   #$01, D0
		lsr.w   #$04, D0
		lea     Level_Size_Array(PC, D0), A0           ; Offset_0x005A2E
		move.l  (A0)+, D0
		move.l  D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEEC8
		move.l  D0, ($FFFFEEC0).w
		move.l  D0, (Miles_Level_Limits_Min_X).w             ; $FFFFEEF8
		move.l  (A0)+, D0
		move.l  D0, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEECC
		move.l  D0, ($FFFFEEC4).w
		move.l  D0, ($FFFFEEFC).w
		move.w  #$1010, ($FFFFEE40).w
		move.w  #$0060, ($FFFFEED8).w
		bra     Level_Load_Player_Position             ; Offset_0x005B3E      
;-------------------------------------------------------------------------------
Level_Size_Array:                                              ; Offset_0x005A2E
		dc.l    $000029A0, $00000320, $00002940, $00000420  ; GHz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720  ; Wz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720
		dc.l    $00002280, $FF000800, $00001E80, $FF000800  ; Mz
		dc.l    $00002A80, $FF000800, $00003FFF, $FF000800  ; Mz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720
		dc.l    $00002800, $00000720, $00003280, $00000720  ; HTz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720  ; HPz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720
		dc.l    $00002F80, $00000680, $00002580, $00000680  ; OOz
		dc.l    $00002380, $03C00720, $00003FFF, $00600720  ; DHz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720  ; CNz
		dc.l    $00002780, $00000720, $00002880, $00000720  ; CPz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720  ; GCz
		dc.l    $000028C0, $020003A0, $000026C0, $018005A0  ; NGHz
		dc.l    $00003FFF, $00000720, $00003FFF, $00000720  ; DEz                                                                                    
;===============================================================================
; Rotina para carregar os limites das fases
; <<<-
;=============================================================================== 

;===============================================================================
; Rotina para carregar a posição do jogador na tela
; ->>>
;===============================================================================
Level_Load_Player_Position:                                    ; Offset_0x005B3E
		tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
		beq.s   Level_Load_Player_Position_From_Start  ; Offset_0x005B54
		jsr     (Level_Restore_Info)                   ; Offset_0x014650
		move.w  (Player_One_Position_X).w, D1                ; $FFFFB008
		move.w  (Player_One_Position_Y).w, D0                ; $FFFFB00C
		bra.s   Level_Load_Player_Position_2           ; Offset_0x005B70
Level_Load_Player_Position_From_Start:                         ; Offset_0x005B54
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		ror.b   #$01, D0
		lsr.w   #$05, D0
		lea     Player_Start_Position_Array(PC, D0), A1 ; Offset_0x005BAA
		moveq   #$00, D1
		move.w  (A1)+, D1
		move.w  D1, (Player_One_Position_X).w                ; $FFFFB008
		moveq   #$00, D0
		move.w  (A1), D0
		move.w  D0, (Player_One_Position_Y).w                ; $FFFFB00C
Level_Load_Player_Position_2:                                  ; Offset_0x005B70
		subi.w  #$00A0, D1
		bcc.s   Offset_0x005B78
		moveq   #$00, D1
Offset_0x005B78:
		move.w  (Sonic_Level_Limits_Max_X).w, D2             ; $FFFFEECA
		cmp.w   D2, D1
		bcs.s   Offset_0x005B82
		move.w  D2, D1
Offset_0x005B82:
		move.w  D1, (Camera_X).w                             ; $FFFFEE00
		move.w  D1, (Camera_X_2).w                           ; $FFFFEE20
		subi.w  #$0060, D0
		bcc.s   Offset_0x005B92
		moveq   #$00, D0
Offset_0x005B92:
		cmp.w   (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
		blt.s   Offset_0x005B9C
		move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEECE
Offset_0x005B9C:
		move.w  D0, (Camera_Y).w                             ; $FFFFEE04
		move.w  D0, (Camera_Y_2).w                           ; $FFFFEE24
		bsr     Background_Scroll_Speed                ; Offset_0x005C32
		rts  
;-------------------------------------------------------------------------------
Player_Start_Position_Array:                                   ; Offset_0x005BAA
		dc.w    $0060, $028F, $0040, $02AF  ; GHz
		dc.w    $0060, $028F, $0040, $02AF
		dc.w    $0060, $01AC, $0040, $01AC  ; Wz
		dc.w    $0060, $028F, $0040, $02AF
		dc.w    $0060, $028C, $0060, $05EC  ; Mz
		dc.w    $0060, $020C, $0040, $02AF  ; Mz
		dc.w    $0060, $028F, $0040, $02AF
		dc.w    $0060, $03EF, $0060, $06AF  ; HTz
		dc.w    $0230, $01AC, $0030, $01BD  ; HPz
		dc.w    $0060, $028F, $0040, $02AF
		dc.w    $0060, $06AC, $0050, $056C  ; OOz
		dc.w    $0060, $06AC, $0060, $05AC  ; DHz
		dc.w    $0060, $02AC, $0060, $058C  ; CNz
		dc.w    $0030, $01EC, $0030, $012C  ; CPz
		dc.w    $0060, $028F, $0040, $02AF  ; GCz
		dc.w    $0050, $037C, $0050, $037C  ; NGHz
		dc.w    $0060, $028F, $0040, $02AF  ; DEz
;===============================================================================
; Rotina para carregar a posição do jogador na tela
; <<<-
;===============================================================================   

;===============================================================================
; Rotina de para controle de rolagem da tela
; ->>>
;===============================================================================
Background_Scroll_Speed:                                       ; Offset_0x005C32
		tst.b   (Saved_Level_Flag).w                         ; $FFFFFE30
		bne.s   Offset_0x005C60
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.w  D0, (Camera_Y_x4_Mod_10).w                   ; $FFFFEE14
		move.w  D1, (Camera_X_x2).w                          ; $FFFFEE08
		move.w  D1, (Camera_X_x8).w                          ; $FFFFEE10
		move.w  D1, (Camera_X_x4).w                          ; $FFFFEE18
		move.w  D0, ($FFFFEE2C).w
		move.w  D0, ($FFFFEE34).w
		move.w  D1, ($FFFFEE28).w
		move.w  D1, ($FFFFEE30).w
		move.w  D1, ($FFFFEE38).w
Offset_0x005C60:
		moveq   #$00, D2
		move.b  (Level_Id).w, D2                             ; $FFFFFE10
		add.w   D2, D2
		move.w  Bg_Scroll_Speed_Index(PC, D2), D2      ; Offset_0x005C70
		jmp     Bg_Scroll_Speed_Index(PC, D2)          ; Offset_0x005C70
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_Index:                                         ; Offset_0x005C70 
		dc.w    Bg_Scroll_Speed_GHz-Bg_Scroll_Speed_Index  ; Offset_0x005C92
		dc.w    Bg_Scroll_Speed_Lvl1-Bg_Scroll_Speed_Index ; Offset_0x005CBE
		dc.w    Bg_Scroll_Speed_Wz-Bg_Scroll_Speed_Index   ; Offset_0x005CC0
		dc.w    Bg_Scroll_Speed_Lvl3-Bg_Scroll_Speed_Index ; Offset_0x005CBE
		dc.w    Bg_Scroll_Speed_Mz-Bg_Scroll_Speed_Index   ; Offset_0x005CD2
		dc.w    Bg_Scroll_Speed_Mz-Bg_Scroll_Speed_Index   ; Offset_0x005CD2
		dc.w    Bg_Scroll_Speed_Lvl6-Bg_Scroll_Speed_Index ; Offset_0x005CBE
		dc.w    Bg_Scroll_Speed_HTz-Bg_Scroll_Speed_Index  ; Offset_0x005CE0
		dc.w    Bg_Scroll_Speed_HPz-Bg_Scroll_Speed_Index  ; Offset_0x005D0C
		dc.w    Bg_Scroll_Speed_Lvl9-Bg_Scroll_Speed_Index ; Offset_0x005D2E
		dc.w    Bg_Scroll_Speed_OOz-Bg_Scroll_Speed_Index  ; Offset_0x005D30
		dc.w    Bg_Scroll_Speed_DHz-Bg_Scroll_Speed_Index  ; Offset_0x005D5E
		dc.w    Bg_Scroll_Speed_CNz-Bg_Scroll_Speed_Index  ; Offset_0x005D90
		dc.w    Bg_Scroll_Speed_CPz-Bg_Scroll_Speed_Index  ; Offset_0x005DBA
		dc.w    Bg_Scroll_Speed_GCz-Bg_Scroll_Speed_Index  ; Offset_0x005DCE
		dc.w    Bg_Scroll_Speed_NGHz-Bg_Scroll_Speed_Index ; Offset_0x005DD0
		dc.w    Bg_Scroll_Speed_DEz-Bg_Scroll_Speed_Index  ; Offset_0x005E02  
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_GHz:                                           ; Offset_0x005C92
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		clr.l   (Camera_Y_x4).w                              ; $FFFFEE0C
		clr.l   (Camera_Y_x4_Mod_10).w                       ; $FFFFEE14
		clr.l   (Camera_Y_x4_Mod_10_2).w                     ; $FFFFEE1C
		lea     ($FFFFA800).w, A2
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   ($FFFFEE28).w
		clr.l   ($FFFFEE2C).w
		clr.l   ($FFFFEE34).w
		clr.l   ($FFFFEE3C).w
		rts
;------------------------------------------------------------------------------- 
Bg_Scroll_Speed_Lvl1:                                          ; Offset_0x005CBE 
Bg_Scroll_Speed_Lvl3:                                          ; Offset_0x005CBE
Bg_Scroll_Speed_Lvl6:                                          ; Offset_0x005CBE
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_Wz:                                            ; Offset_0x005CC0
		asr.w   #$02, D0
		addi.w  #$0400, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		asr.w   #$03, D1
		move.w  D1, (Camera_X_x2).w                          ; $FFFFEE08
		rts
;-------------------------------------------------------------------------------  
Bg_Scroll_Speed_Mz:                                            ; Offset_0x005CD2
		asr.w   #$02, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		asr.w   #$03, D1
		move.w  D1, (Camera_X_x2).w                          ; $FFFFEE08
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_HTz:                                           ; Offset_0x005CE0
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		clr.l   (Camera_Y_x4).w                              ; $FFFFEE0C
		clr.l   (Camera_Y_x4_Mod_10).w                       ; $FFFFEE14
		clr.l   (Camera_Y_x4_Mod_10_2).w                     ; $FFFFEE1C
		lea     ($FFFFA800).w, A2
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   ($FFFFEE28).w
		clr.l   ($FFFFEE2C).w
		clr.l   ($FFFFEE34).w
		clr.l   ($FFFFEE3C).w
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_HPz:                                           ; Offset_0x005D0C
		asr.w   #$01, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		rts     
;-------------------------------------------------------------------------------
; Bg_Scroll_Speed_SYz: ; Left Over Sonic 1                     ; Offset_0x005D18
		asl.l   #$04, D0
		move.l  D0, D2
		asl.l   #$01, D0
		add.l   D2, D0
		asr.l   #$08, D0
		addq.w  #$01, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_Lvl9:                                          ; Offset_0x005D2E
		rts
;------------------------------------------------------------------------------- 
Bg_Scroll_Speed_OOz:                                           ; Offset_0x005D30
		lsr.w   #$03, D0
		addi.w  #$0050, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		rts                                    
;-------------------------------------------------------------------------------
; Bg_Scroll_Speed_SYz: ; Left Over Sonic 1                     ; Offset_0x005D40
		asl.l   #$04, D0
		move.l  D0, D2
		asl.l   #$01, D0
		add.l   D2, D0
		asr.l   #$08, D0
		addq.w  #$01, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		rts      
;-------------------------------------------------------------------------------
; Offset_0x005D56:
		asr.w   #$03, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_DHz:                                           ; Offset_0x005D5E
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		clr.l   ($FFFFEE28).w
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   Offset_0x005D7E
		divu.w  #$0003, D0
		subi.w  #$0140, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.w  D0, ($FFFFEE2C).w
		rts
Offset_0x005D7E:
		divu.w  #$0006, D0
		subi.w  #$0010, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.w  D0, ($FFFFEE2C).w
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_CNz:                                           ; Offset_0x005D90
		lsr.w   #$06, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.w  D0, ($FFFFEE2C).w
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		lea     ($FFFFA800).w, A2
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   ($FFFFEE28).w
		clr.l   ($FFFFEE2C).w
		clr.l   ($FFFFEE34).w
		clr.l   ($FFFFEE3C).w
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_CPz:                                           ; Offset_0x005DBA
		lsr.w   #$02, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.w  D0, ($FFFFEE2C).w
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		clr.l   (Camera_X_x8).w                              ; $FFFFEE10
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_GCz:                                           ; Offset_0x005DCE
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_NGHz:                                          ; Offset_0x005DD0
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		beq.s   Bg_Scroll_Speed_NGHz_Act_1             ; Offset_0x005DE2
		subi.w  #$00E0, D0
		lsr.w   #$01, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		bra.s   Bg_Scroll_Speed_NGHz_Init              ; Offset_0x005DEA
Bg_Scroll_Speed_NGHz_Act_1:                                    ; Offset_0x005DE2
		subi.w  #$0180, D0
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
Bg_Scroll_Speed_NGHz_Init:                                     ; Offset_0x005DEA
		clr.l   (Camera_X_x2).w                              ; $FFFFEE08
		clr.l   (Camera_Y_x4_Mod_10).w                       ; $FFFFEE14
		clr.l   (Camera_Y_x4_Mod_10_2).w                     ; $FFFFEE1C
		lea     ($FFFFA800).w, A2
		clr.l   (A2)+
		clr.l   (A2)+
		clr.l   (A2)+
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Speed_DEz:                                           ; Offset_0x005E02
		rts
;===============================================================================
; Rotina de para controle de rolagem da tela
; <<<-
;===============================================================================

;===============================================================================
; Rotina para rolar a tela de acordo com a posição do personagem
; ->>>
;===============================================================================                                                                                 
Background_Scroll_Layer:                                       ; Offset_0x005E04
		tst.b   (Level_Scroll_Flag).w                        ; $FFFFEEDC
		beq.s   Offset_0x005E0C
		rts
Offset_0x005E0C:
		clr.w   (Scroll_Flag_Array).w                        ; $FFFFEE50
		clr.w   (Scroll_Flag_Array+$0002).w                  ; $FFFFEE52
		clr.w   (Scroll_Flag_Array+$0004).w                  ; $FFFFEE54
		clr.w   (Scroll_Flag_Array+$0006).w                  ; $FFFFEE56
		clr.w   (Scroll_Flag_Array+$0008).w                  ; $FFFFEE58
		clr.w   (Scroll_Flag_Array+$000A).w                  ; $FFFFEE5A
		clr.w   (Scroll_Flag_Array+$000C).w                  ; $FFFFEE5C
		clr.w   (Scroll_Flag_Array+$000E).w                  ; $FFFFEE5E
		lea     (Player_One).w, A0                           ; $FFFFB000
		lea     (Camera_X).w, A1                             ; $FFFFEE00
		lea     (Sonic_Level_Limits_Min_X).w, A2             ; $FFFFEEC8
		lea     (Scroll_Flag_Array).w, A3                    ; $FFFFEE50
		lea     (Horizontal_Scrolling).w, A4                 ; $FFFFEEB0
		lea     ($FFFFEED0).w, A5
		lea     ($FFFFE500).w, A6
		bsr     Scroll_Horizontal                      ; Offset_0x006C32
		lea     ($FFFFEE40).w, A2
		bsr     Scroll_Horizontal_2                    ; Offset_0x006C10
		lea     (Camera_Y).w, A1                             ; $FFFFEE04
		lea     (Sonic_Level_Limits_Min_X).w, A2             ; $FFFFEEC8
		lea     (Vertical_Scrolling).w, A4                   ; $FFFFEEB2
		bsr     Scroll_Vertical                        ; Offset_0x006CA2
		lea     ($FFFFEE41).w, A2
		bsr     Scroll_Vertical_2                      ; Offset_0x006DA6
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x005EB2
		lea     (Player_Two).w, A0                           ; $FFFFB040
		lea     (Camera_X_2).w, A1                           ; $FFFFEE20
		lea     (Miles_Level_Limits_Min_X).w, A2             ; $FFFFEEF8
		lea     (Scroll_Flag_Array+$0008).w, A3              ; $FFFFEE58
		lea     ($FFFFEEB8).w, A4
		lea     ($FFFFEED4).w, A5
		lea     ($FFFFE700).w, A6
		bsr     Scroll_Horizontal                      ; Offset_0x006C32
		lea     ($FFFFEE48).w, A2
		bsr     Scroll_Horizontal_2                    ; Offset_0x006C10
		lea     (Camera_Y_2).w, A1                           ; $FFFFEE24
		lea     (Miles_Level_Limits_Min_X).w, A2             ; $FFFFEEF8
		lea     ($FFFFEEBA).w, A4
		bsr     Scroll_Vertical                        ; Offset_0x006CA2
		lea     ($FFFFEE49).w, A2
		bsr     Scroll_Vertical_2                      ; Offset_0x006DA6
Offset_0x005EB2:
		bsr     Dyn_Screen_Boss_Loader                 ; Offset_0x007AD4
		move.w  (Camera_Y).w, ($FFFFF616).w                  ; $FFFFEE04
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		move.l  (Camera_X).w, ($FFFFEEF0).w                  ; $FFFFEE00
		move.l  (Camera_Y).w, ($FFFFEEF4).w                  ; $FFFFEE04
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		move.w  Bg_Scroll_Index(PC, D0), D0            ; Offset_0x005EDE
		jmp     Bg_Scroll_Index(PC, D0)                ; Offset_0x005EDE    
;-------------------------------------------------------------------------------
Bg_Scroll_Index:                                               ; Offset_0x005EDE
		dc.w    Bg_Scroll_GHz-Bg_Scroll_Index          ; Offset_0x005F24
		dc.w    Bg_Scroll_Lvl1-Bg_Scroll_Index         ; Offset_0x006B94
		dc.w    Bg_Scroll_Wz-Bg_Scroll_Index           ; Offset_0x006160
		dc.w    Bg_Scroll_Lvl3-Bg_Scroll_Index         ; Offset_0x006B94
		dc.w    Bg_Scroll_Mz-Bg_Scroll_Index           ; Offset_0x006198
		dc.w    Bg_Scroll_Mz-Bg_Scroll_Index           ; Offset_0x006198
		dc.w    Bg_Scroll_Lvl6-Bg_Scroll_Index         ; Offset_0x006B94
		dc.w    Bg_Scroll_HTz-Bg_Scroll_Index          ; Offset_0x0061D0
		dc.w    Bg_Scroll_HPz-Bg_Scroll_Index          ; Offset_0x00640C
		dc.w    Bg_Scroll_Lvl9-Bg_Scroll_Index         ; Offset_0x006B94
		dc.w    Bg_Scroll_OOz-Bg_Scroll_Index          ; Offset_0x0064D2
		dc.w    Bg_Scroll_DHz-Bg_Scroll_Index          ; Offset_0x00650A
		dc.w    Bg_Scroll_CNz-Bg_Scroll_Index          ; Offset_0x0068A4
		dc.w    Bg_Scroll_CPz-Bg_Scroll_Index          ; Offset_0x006972
		dc.w    Bg_Scroll_GCz-Bg_Scroll_Index          ; Offset_0x006B94
		dc.w    Bg_Scroll_NGHz-Bg_Scroll_Index         ; Offset_0x006A78
		dc.w    Bg_Scroll_DEz-Bg_Scroll_Index          ; Offset_0x006B94     
;-------------------------------------------------------------------------------   
Bg_Scroll_Title_Screen:                                        ; Offset_0x005F00
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		cmpi.w  #$1C00, D0
		bcc.s   Offset_0x005F12
		addq.w  #$08, D0
Offset_0x005F12:
		move.w  D0, (Camera_X).w                             ; $FFFFEE00
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_X).w, D2                             ; $FFFFEE00
		neg.w   D2
		moveq   #$00, D0
		bra.s   Offset_0x005F40
;-------------------------------------------------------------------------------  
Bg_Scroll_GHz:                                                 ; Offset_0x005F24
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne     Bg_Scroll_GHz_Act_2                    ; Offset_0x00606A
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		move.w  D0, D2
		swap.w  D0
Offset_0x005F40:
		move.w  #$0000, D0
		move.w  #$0015, D1
Offset_0x005F48:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x005F48
		move.w  D2, D0
		asr.w   #$06, D0
		move.w  #$0039, D1
Offset_0x005F56:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x005F56
		move.w  D0, D3
		move.b  ($FFFFFE0F).w, D1
		andi.w  #$0007, D1
		bne.s   Offset_0x005F6C
		subq.w  #$01, ($FFFFA800).w
Offset_0x005F6C:
		move.w  ($FFFFA800).w, D1
		andi.w  #$001F, D1
		lea     (Bg_Scroll_Data), A2                   ; Offset_0x006028
		lea     $00(A2, D1), A2
		move.w  #$0014, D1
Offset_0x005F82:
		move.b  (A2)+, D0
		ext.w   D0
		add.w   D3, D0
		move.l  D0, (A1)+
		dbra    D1, Offset_0x005F82
		move.w  #$0000, D0
		move.w  #$000A, D1
Offset_0x005F96:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x005F96
		move.w  D2, D0
		asr.w   #$04, D0
		move.w  #$000F, D1
Offset_0x005FA4:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x005FA4
		move.w  D2, D0
		asr.w   #$04, D0
		move.w  D0, D1
		asr.w   #$01, D1
		add.w   D1, D0
		move.w  #$000F, D1
Offset_0x005FB8:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x005FB8
		move.l  D0, D4
		swap.w  D4
		move.w  D2, D0
		asr.w   #$01, D0
		move.w  D2, D1
		asr.w   #$03, D1
		sub.w   D1, D0
		ext.l   D0
		asl.l   #$08, D0
		divs.w  #$0030, D0
		ext.l   D0
		asl.l   #$08, D0
		moveq   #$00, D3
		move.w  D2, D3
		asr.w   #$03, D3
		move.w  #$000E, D1
Offset_0x005FE2:
		move.w  D4, (A1)+
		move.w  D3, (A1)+
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		dbra    D1, Offset_0x005FE2
		move.w  #$0008, D1
Offset_0x005FF4:
		move.w  D4, (A1)+
		move.w  D3, (A1)+
		move.w  D4, (A1)+
		move.w  D3, (A1)+
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		dbra    D1, Offset_0x005FF4
		move.w  #$000E, D1
Offset_0x00600C:
		move.w  D4, (A1)+
		move.w  D3, (A1)+
		move.w  D4, (A1)+
		move.w  D3, (A1)+
		move.w  D4, (A1)+
		move.w  D3, (A1)+
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		dbra    D1, Offset_0x00600C
		rts         
;-------------------------------------------------------------------------------
Bg_Scroll_Data:                                                ; Offset_0x006028
		dc.b    $01, $02, $01, $03, $01, $02, $02, $01
		dc.b    $02, $03, $01, $02, $01, $02, $00, $00
		dc.b    $02, $00, $03, $02, $02, $03, $02, $02
		dc.b    $01, $03, $00, $00, $01, $00, $01, $03
		dc.b    $01, $02, $01, $03, $01, $02, $02, $01
		dc.b    $02, $03, $01, $02, $01, $02, $00, $00
		dc.b    $02, $00, $03, $02, $02, $03, $02, $02
		dc.b    $01, $03, $00, $00, $01, $00, $01, $03
		dc.b    $01, $02                       
;-------------------------------------------------------------------------------
Bg_Scroll_GHz_Act_2:                                           ; Offset_0x00606A
		move.b  ($FFFFFE0F).w, D1
		andi.w  #$0007, D1
		bne.s   Offset_0x006078
		subq.w  #$01, ($FFFFA800).w
Offset_0x006078:
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		andi.l  #$FFFEFFFE, ($FFFFF616).w
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		move.w  #$000A, D1
		bsr.s   Offset_0x0060C0
		moveq   #$00, D0
		move.w  D0, ($FFFFF620).w
		subi.w  #$00E0, ($FFFFF620).w
		move.w  (Camera_Y_2).w, ($FFFFF61E).w                ; $FFFFEE24
		subi.w  #$00E0, ($FFFFF61E).w
		andi.l  #$FFFEFFFE, ($FFFFF61E).w
		lea     ($FFFFE1B0).w, A1
		move.w  (Camera_X_2).w, D0                           ; $FFFFEE20
		move.w  #$000E, D1
Offset_0x0060C0:
		neg.w   D0
		move.w  D0, D2
		swap.w  D0
		move.w  #$0000, D0
Offset_0x0060CA:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0060CA
		move.w  D2, D0
		asr.w   #$06, D0
		move.w  #$001C, D1
Offset_0x0060D8:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0060D8
		move.w  D0, D3
		move.w  ($FFFFA800).w, D1
		andi.w  #$001F, D1
		lea     Bg_Scroll_Data(PC), A2                 ; Offset_0x006028
		lea     $00(A2, D1), A2
		move.w  #$000A, D1
Offset_0x0060F4:
		move.b  (A2)+, D0
		ext.w   D0
		add.w   D3, D0
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0060F4
		move.w  #$0000, D0
		move.w  #$0004, D1
Offset_0x006108:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006108
		move.w  D2, D0
		asr.w   #$04, D0
		move.w  #$0007, D1
Offset_0x006116:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006116
		move.w  D2, D0
		asr.w   #$04, D0
		move.w  D0, D1
		asr.w   #$01, D1
		add.w   D1, D0
		move.w  #$0007, D1
Offset_0x00612A:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00612A
		move.w  D2, D0
		asr.w   #$01, D0
		move.w  D2, D1
		asr.w   #$03, D1
		sub.w   D1, D0
		ext.l   D0
		asl.l   #$08, D0
		divs.w  #$0030, D0
		ext.l   D0
		asl.l   #$08, D0
		moveq   #$00, D3
		move.w  D2, D3
		asr.w   #$03, D3
		move.w  #$0027, D1
Offset_0x006150:
		move.w  D2, (A1)+
		move.w  D3, (A1)+
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		dbra    D1, Offset_0x006150
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_Wz:                                                  ; Offset_0x006160
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$05, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$06, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$00DF, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x006190:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006190
		rts  
;-------------------------------------------------------------------------------
Bg_Scroll_Mz:                                                  ; Offset_0x006198
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$05, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$06, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$00DF, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x0061C8:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0061C8
		rts  
;-------------------------------------------------------------------------------
Bg_Scroll_HTz:                                                 ; Offset_0x0061D0
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne     Bg_Scroll_HTz_Act_2                    ; Offset_0x00637C
		tst.b   ($FFFFEEBC).w
		bne     Offset_0x0062FE
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		move.w  D0, D2
		swap.w  D0
		move.w  D2, D0
		asr.w   #$03, D0
		move.w  #$007F, D1
Offset_0x0061FC:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0061FC
		move.l  D0, D4
		move.w  ($FFFFA822).w, D0
		addq.w  #$04, ($FFFFA822).w
		sub.w   D0, D2
		move.w  D2, D0
		move.w  D0, D1
		asr.w   #$01, D0
		asr.w   #$04, D1
		sub.w   D1, D0
		ext.l   D0
		asl.l   #$08, D0
		divs.w  #$0070, D0
		ext.l   D0
		asl.l   #$08, D0
		lea     ($FFFFA800).w, A2
		moveq   #$00, D3
		move.w  D1, D3
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A2)+
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A2)+
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A2)+
		move.w  D3, (A2)+
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		moveq   #$03, D1
Offset_0x006250:
		move.w  D3, (A2)+
		move.w  D3, (A2)+
		move.w  D3, (A2)+
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		dbra    D1, Offset_0x006250
		add.l   D0, D0
		add.l   D0, D0
		move.w  D3, D4
		move.l  D4, (A1)+
		move.l  D4, (A1)+
		move.l  D4, (A1)+
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, D4
		move.l  D4, (A1)+
		move.l  D4, (A1)+
		move.l  D4, (A1)+
		move.l  D4, (A1)+
		move.l  D4, (A1)+
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, D4
		move.w  #$0006, D1
Offset_0x00628E:
		move.l  D4, (A1)+
		dbra    D1, Offset_0x00628E
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, D4
		move.w  #$0007, D1
Offset_0x0062A2:
		move.l  D4, (A1)+
		dbra    D1, Offset_0x0062A2
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, D4
		move.w  #$0009, D1
Offset_0x0062B6:
		move.l  D4, (A1)+
		dbra    D1, Offset_0x0062B6
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, D4
		move.w  #$000E, D1
Offset_0x0062CC:
		move.l  D4, (A1)+
		dbra    D1, Offset_0x0062CC
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		move.w  #$0002, D2
Offset_0x0062E0:
		move.w  D3, D4
		move.w  #$000F, D1
Offset_0x0062E6:
		move.l  D4, (A1)+
		dbra    D1, Offset_0x0062E6
		swap.w  D3
		add.l   D0, D3
		add.l   D0, D3
		add.l   D0, D3
		add.l   D0, D3
		swap.w  D3
		dbra    D2, Offset_0x0062E0
		rts
Offset_0x0062FE:
		move.w  (Horizontal_Scrolling_Sub).w, D4             ; $FFFFEEB4
		ext.l   D4
		lsl.l   #$08, D4
		moveq   #$02, D6
		bsr     Scroll_Block_2                         ; Offset_0x006E32
		move.w  (Vertical_Scrolling_Sub).w, D5               ; $FFFFEEB6
		ext.l   D5
		lsl.l   #$08, D5
		moveq   #$00, D6
		bsr     Scroll_Block_3                         ; Offset_0x006E66
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		move.w  (Camera_Y).w, ($FFFFF616).w                  ; $FFFFEE04
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		moveq   #$00, D2
		tst.b   ($FFFFEEBD).w
		beq.s   Offset_0x00635A
		move.w  ($FFFFFE04).w, D0
		andi.w  #$003F, D0
		lea     Bg_Scroll_Data(PC), A1                 ; Offset_0x006028
		lea     $00(A1, D0), A1
		moveq   #$00, D0
		move.b  (A1)+, D0
		add.w   D0, ($FFFFF616).w
		add.w   D0, ($FFFFF618).w
		add.w   D0, ($FFFFEEF4).w
		move.b  (A1)+, D2
		add.w   D2, ($FFFFEEF0).w
Offset_0x00635A:
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$00DF, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		add.w   D2, D0
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		add.w   D2, D0
		neg.w   D0
Offset_0x006374:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006374
		rts
;-------------------------------------------------------------------------------                
Bg_Scroll_HTz_Act_2                                            ; Offset_0x00637C
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$06, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$02, D5
		moveq   #$00, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.b  #$00, (Scroll_Flag_Array+$0002).w            ; $FFFFEE52
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		andi.l  #$FFFEFFFE, ($FFFFF616).w
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$006F, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x0063BC:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0063BC
		move.w  ($FFFFEEB8).w, D4
		ext.l   D4
		asl.l   #$06, D4
		add.l   D4, ($FFFFEE28).w
		moveq   #$00, D0
		move.w  D0, ($FFFFF620).w
		subi.w  #$00E0, ($FFFFF620).w
		move.w  (Camera_Y_2).w, ($FFFFF61E).w                ; $FFFFEE24
		subi.w  #$00E0, ($FFFFF61E).w
		andi.l  #$FFFEFFFE, ($FFFFF61E).w
		lea     ($FFFFE1B0).w, A1
		move.w  #$0073, D1
		move.w  (Camera_X_2).w, D0                           ; $FFFFEE20
		neg.w   D0
		swap.w  D0
		move.w  ($FFFFEE28).w, D0
		neg.w   D0
Offset_0x006404:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006404
		rts 
;-------------------------------------------------------------------------------
Bg_Scroll_HPz:                                                 ; Offset_0x00640C
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$06, D4
		moveq   #$02, D6
		bsr     Scroll_Block_2                         ; Offset_0x006E32
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$07, D5
		moveq   #$06, D6
		bsr     Scroll_Block_3                         ; Offset_0x006E66
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     ($FFFFA800).w, A1
		move.w  (Camera_X).w, D2                             ; $FFFFEE00
		neg.w   D2
		move.w  D2, D0
		asr.w   #$01, D0
		move.w  #$0007, D1
Offset_0x006440:
		move.w  D0, (A1)+
		dbra    D1, Offset_0x006440
		move.w  D2, D0
		asr.w   #$03, D0
		sub.w   D2, D0
		ext.l   D0
		asl.l   #$03, D0
		divs.w  #$0008, D0
		ext.l   D0
		asl.l   #$04, D0
		asl.l   #$08, D0
		moveq   #$00, D3
		move.w  D2, D3
		asr.w   #$01, D3
		lea     ($FFFFA860).w, A2
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A1)+
		move.w  D3, (A1)+
		move.w  D3, (A1)+
		move.w  D3, -(A2)
		move.w  D3, -(A2)
		move.w  D3, -(A2)
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A1)+
		move.w  D3, (A1)+
		move.w  D3, -(A2)
		move.w  D3, -(A2)
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A1)+
		move.w  D3, -(A2)
		swap.w  D3
		add.l   D0, D3
		swap.w  D3
		move.w  D3, (A1)+
		move.w  D3, -(A2)
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
		move.w  #$0019, D1
Offset_0x0064A2:
		move.w  D0, (A1)+
		dbra    D1, Offset_0x0064A2
		adda.w  #$000E, A1
		move.w  D2, D0
		asr.w   #$01, D0
		move.w  #$0017, D1
Offset_0x0064B4:
		move.w  D0, (A1)+
		dbra    D1, Offset_0x0064B4
		lea     ($FFFFA800).w, A2
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		move.w  D0, D2
		andi.w  #$03F0, D0
		lsr.w   #$03, D0
		lea     $00(A2, D0), A2
		bra     Bg_Scroll_X                            ; Offset_0x006BCC 
;-------------------------------------------------------------------------------
Bg_Scroll_OOz:                                                 ; Offset_0x0064D2
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$05, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$05, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$00DF, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x006502:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006502
		rts  
;-------------------------------------------------------------------------------
Bg_Scroll_DHz:                                                 ; Offset_0x00650A
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne     Bg_Scroll_DHz_2P                       ; Offset_0x006662
		move.w  (Camera_Y).w, D0                             ; $FFFFEE04
		move.l  (Camera_Y_x4).w, D3                          ; $FFFFEE0C
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   Bg_Scroll_DHz_Act_2                    ; Offset_0x00652A
		divu.w  #$0003, D0
		subi.w  #$0140, D0
		bra.s   Bg_Scroll_DHz_1                        ; Offset_0x006532
;-------------------------------------------------------------------------------                                                       
Bg_Scroll_DHz_Act_2:                                           ; Offset_0x00652A
		divu.w  #$0006, D0
		subi.w  #$0010, D0
Bg_Scroll_DHz_1:                                               ; Offset_0x006532
		swap.w  D0
		moveq   #$06, D6
		bsr     Scroll_Block_3_D0                      ; Offset_0x006E6E
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		moveq   #$00, D2
		tst.b   ($FFFFEEBD).w
		beq.s   Offset_0x00656E
		move.w  ($FFFFFE04).w, D0
		andi.w  #$003F, D0
		lea     Bg_Scroll_Data(PC), A1                 ; Offset_0x006028
		lea     $00(A1, D0), A1
		moveq   #$00, D0
		move.b  (A1)+, D0
		add.w   D0, ($FFFFF616).w
		add.w   D0, ($FFFFF618).w
		add.w   D0, ($FFFFEEF4).w
		move.b  (A1)+, D2
		add.w   D2, ($FFFFEEF0).w
Offset_0x00656E:
		lea     ($FFFFA800).w, A2
		lea     $001E(A2), A3
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		ext.l   D0
		asl.l   #$04, D0
		divs.w  #$000A, D0
		ext.l   D0
		asl.l   #$04, D0
		asl.l   #$08, D0
		move.l  D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000E(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000C(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000A(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0008(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0006(A2)
		move.w  D1, $0010(A2)
		move.w  D1, $001C(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0004(A2)
		move.w  D1, $0012(A2)
		move.w  D1, $001A(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0002(A2)
		move.w  D1, $0014(A2)
		move.w  D1, $0018(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, (A2)
		move.w  D1, $0016(A2)
		lea     (DHz_Bg_Scroll_Data), A3               ; Offset_0x00664A
		lea     ($FFFFA800).w, A2
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_Y_x4).w, D1                          ; $FFFFEE0C
		moveq   #$00, D0
Offset_0x00661C:
		move.b  (A3)+, D0
		addq.w  #$02, A2
		sub.w   D0, D1
		bcc.s   Offset_0x00661C
		neg.w   D1
		subq.w  #$02, A2
		move.w  #$00DF, D2
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x006638:
		move.l  D0, (A1)+
		subq.w  #$01, D1
		bne.s   Offset_0x006644
		move.b  (A3)+, D1
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x006644:
		dbra    D2, Offset_0x006638
		rts 
;------------------------------------------------------------------------------- 
DHz_Bg_Scroll_Data:                                            ; Offset_0x00664A
		dc.b    $25, $17
		dc.b    $12, $07
		dc.b    $07, $02
		dc.b    $02, $30
		dc.b    $0D, $13
		dc.b    $20, $40
		dc.b    $20, $13
		dc.b    $0D, $30
		dc.b    $02, $02
		dc.b    $07, $07
		dc.b    $20, $12
		dc.b    $17, $25                                                    
;-------------------------------------------------------------------------------
Bg_Scroll_DHz_2P:                                              ; Offset_0x006662
		moveq   #$00, D0
		move.w  (Camera_Y).w, D0                             ; $FFFFEE04
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   Bg_Scroll_DHz_2P_Act_2                 ; Offset_0x006678
		divu.w  #$0003, D0
		subi.w  #$0140, D0
		bra.s   Bg_Scroll_DHz_2P_1                     ; Offset_0x006680
;-------------------------------------------------------------------------------                
Bg_Scroll_DHz_2P_Act_2:                                        ; Offset_0x006678
		divu.w  #$0006, D0
		subi.w  #$0010, D0
Bg_Scroll_DHz_2P_1:                                            ; Offset_0x006680
		move.w  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.w  D0, ($FFFFF618).w
		andi.l  #$FFFEFFFE, ($FFFFF616).w
		lea     ($FFFFA800).w, A2
		lea     $001E(A2), A3
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		ext.l   D0
		asl.l   #$04, D0
		divs.w  #$000A, D0
		ext.l   D0
		asl.l   #$04, D0
		asl.l   #$08, D0
		move.l  D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000E(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000C(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000A(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0008(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0006(A2)
		move.w  D1, $0010(A2)
		move.w  D1, $001C(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0004(A2)
		move.w  D1, $0012(A2)
		move.w  D1, $001A(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0002(A2)
		move.w  D1, $0014(A2)
		move.w  D1, $0018(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, (A2)
		move.w  D1, $0016(A2)
		lea     (DHz_Bg_Scroll_Data_2P), A3            ; Offset_0x00676E
		lea     ($FFFFA800).w, A2
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_Y_x4).w, D1                          ; $FFFFEE0C
		lsr.w   #$01, D1
		moveq   #$00, D0
Offset_0x006740:
		move.b  (A3)+, D0
		addq.w  #$02, A2
		sub.w   D0, D1
		bcc.s   Offset_0x006740
		neg.w   D1
		subq.w  #$02, A2
		move.w  #$006F, D2
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x00675C:
		move.l  D0, (A1)+
		subq.w  #$01, D1
		bne.s   Offset_0x006768
		move.b  (A3)+, D1
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x006768:
		dbra    D2, Offset_0x00675C
		bra.s   Offset_0x006786   
;-------------------------------------------------------------------------------  
DHz_Bg_Scroll_Data_2P:                                         ; Offset_0x00676E
		dc.b    $13, $0B, $09, $04, $03, $01, $01, $18
		dc.b    $06, $0A, $10, $20, $10, $0A, $06, $18
		dc.b    $01, $01, $03, $04, $10, $09, $0B, $13
;-------------------------------------------------------------------------------
Offset_0x006786:
		moveq   #$00, D0
		move.w  (Camera_Y_2).w, D0                           ; $FFFFEE24
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   Offset_0x00679C
		divu.w  #$0003, D0
		subi.w  #$0140, D0
		bra.s   Offset_0x0067A4
Offset_0x00679C:
		divu.w  #$0006, D0
		subi.w  #$0010, D0
Offset_0x0067A4:
		move.w  D0, ($FFFFEE2C).w
		move.w  D0, ($FFFFF620).w
		subi.w  #$00E0, ($FFFFF620).w
		move.w  (Camera_Y_2).w, ($FFFFF61E).w                ; $FFFFEE24
		subi.w  #$00E0, ($FFFFF61E).w
		andi.l  #$FFFEFFFE, ($FFFFF61E).w
		lea     ($FFFFA800).w, A2
		lea     $001E(A2), A3
		move.w  (Camera_X_2).w, D0                           ; $FFFFEE20
		ext.l   D0
		asl.l   #$04, D0
		divs.w  #$000A, D0
		ext.l   D0
		asl.l   #$04, D0
		asl.l   #$08, D0
		move.l  D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000E(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000C(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $000A(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0008(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0006(A2)
		move.w  D1, $0010(A2)
		move.w  D1, $001C(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0004(A2)
		move.w  D1, $0012(A2)
		move.w  D1, $001A(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, $0002(A2)
		move.w  D1, $0014(A2)
		move.w  D1, $0018(A2)
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, (A2)
		move.w  D1, $0016(A2)
		lea     DHz_Bg_Scroll_Data_2P+$0001(PC), A3    ; Offset_0x00676F
		lea     ($FFFFA800).w, A2
		lea     ($FFFFE1B0).w, A1
		move.w  ($FFFFEE2C).w, D1
		lsr.w   #$01, D1
		moveq   #$17, D0
		bra.s   Offset_0x006878   
Offset_0x006876:
		move.b  (A3)+, D0
Offset_0x006878:
		addq.w  #$02, A2                   
		sub.w   D0, D1
		bcc.s   Offset_0x006876
		neg.w   D1
		subq.w  #$02, A2
		move.w  #$0073, D2
		move.w  (Camera_X_2).w, D0                           ; $FFFFEE20
		neg.w   D0
		swap.w  D0
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x006892:
		move.l  D0, (A1)+
		subq.w  #$01, D1
		bne.s   Offset_0x00689E
		move.b  (A3)+, D1
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x00689E:
		dbra    D2, Offset_0x006892
		rts                             
;-------------------------------------------------------------------------------
Bg_Scroll_CNz:                                                 ; Offset_0x0068A4    
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne     Bg_Scroll_CNz_2P                       ; Offset_0x0068E8
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$06, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$02, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		clr.b   (Scroll_Flag_Array+$0002).w                  ; $FFFFEE52
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$00DF, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x0068E0:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x0068E0
		rts
;-------------------------------------------------------------------------------                
Bg_Scroll_CNz_2P:                                              ; Offset_0x0068E8
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$06, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$02, D5
		moveq   #$00, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		andi.l  #$FFFEFFFE, ($FFFFF616).w
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$006F, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x006922:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006922
		move.w  ($FFFFEEB8).w, D4
		ext.l   D4
		asl.l   #$06, D4
		add.l   D4, ($FFFFEE28).w
		moveq   #$00, D0
		move.w  D0, ($FFFFF620).w
		subi.w  #$00E0, ($FFFFF620).w
		move.w  (Camera_Y_2).w, ($FFFFF61E).w                ; $FFFFEE24
		subi.w  #$00E0, ($FFFFF61E).w
		andi.l  #$FFFEFFFE, ($FFFFF61E).w
		lea     ($FFFFE1B0).w, A1
		move.w  #$0073, D1
		move.w  (Camera_X_2).w, D0                           ; $FFFFEE20
		neg.w   D0
		swap.w  D0
		move.w  ($FFFFEE28).w, D0
		neg.w   D0
Offset_0x00696A:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00696A
		rts
;-------------------------------------------------------------------------------
Bg_Scroll_CPz:                                                 ; Offset_0x006972
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$05, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$06, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$07, D4
		moveq   #$04, D6
		bsr     Scroll_Block_4                         ; Offset_0x006E9A
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		move.w  D0, (Camera_Y_x4_Mod_10).w                   ; $FFFFEE14
		move.w  D0, ($FFFFF618).w
		move.b  (Scroll_Flag_Array+$0002).w, D0              ; $FFFFEE52
		or.b    ($FFFFEE54).w, D0
		move.b  D0, (Scroll_Flag_Array+$0006).w              ; $FFFFEE56
		clr.b   (Scroll_Flag_Array+$0002).w                  ; $FFFFEE52
		clr.b   (Scroll_Flag_Array+$0004).w                  ; $FFFFEE54
		move.b  ($FFFFFE0F).w, D1
		andi.w  #$0007, D1
		bne.s   Offset_0x0069C2
		subq.w  #$01, ($FFFFA800).w
Offset_0x0069C2:
		lea     (Draw_CPz_Bg_Data+$0001), A0           ; Offset_0x0072A3
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		move.w  D0, D2
		andi.w  #$03F0, D0
		lsr.w   #$04, D0
		lea     $00(A0, D0), A0
		move.w  D0, D4
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$000E, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		andi.w  #$000F, D2
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		cmpi.b  #$12, D4
		beq.s   Offset_0x006A40
		bcs.s   Offset_0x0069FE
		move.w  (Camera_X_x8).w, D0                          ; $FFFFEE10
Offset_0x0069FE:
		neg.w   D0
		add.w   D2, D2
		jmp     CPz_Bg_Scroll_X_Start_Index(PC, D2)    ; Offset_0x006A18
;-------------------------------------------------------------------------------                
CPz_Bg_Scroll_X_Loop:                                          ; Offset_0x006A06
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		cmpi.b  #$12, D4
		beq.s   Offset_0x006A4A
		bcs.s   CPz_Process_Scroll_X                   ; Offset_0x006A16
		move.w  (Camera_X_x8).w, D0                          ; $FFFFEE10
CPz_Process_Scroll_X:                                          ; Offset_0x006A16
		neg.w   D0
CPz_Bg_Scroll_X_Start_Index:                                   ; Offset_0x006A18                
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		addq.b  #$01, D4
		dbra    D1, CPz_Bg_Scroll_X_Loop               ; Offset_0x006A06
		rts
Offset_0x006A40:
		move.w  #$000F, D0
		sub.w   D2, D0
		move.w  D0, D2
		bra.s   Offset_0x006A4E
Offset_0x006A4A:
		move.w  #$000F, D2
Offset_0x006A4E:
		move.w  (Camera_X_x2).w, D3                          ; $FFFFEE08
		neg.w   D3
		move.w  ($FFFFA800).w, D0
		andi.w  #$001F, D0
		lea     Bg_Scroll_Data(PC), A2                 ; Offset_0x006028
		lea     $00(A2, D0), A2
Offset_0x006A64:
		move.b  (A2)+, D0
		ext.w   D0
		add.w   D3, D0
		move.l  D0, (A1)+
		dbra    D2, Offset_0x006A64
		addq.b  #$01, D4
		dbra    D1, CPz_Bg_Scroll_X_Loop               ; Offset_0x006A06
		rts
;-------------------------------------------------------------------------------   
Bg_Scroll_NGHz:                                                ; Offset_0x006A78
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		muls.w  #$0119, D4
		moveq   #$02, D6
		bsr     Scroll_Block_2                         ; Offset_0x006E32
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$07, D5
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   Bg_Scroll_NGHz_Act_2                   ; Offset_0x006A98
		asl.l   #$01, D5
;-------------------------------------------------------------------------------                
Bg_Scroll_NGHz_Act_2:                                          ; Offset_0x006A98
		moveq   #$06, D6
		bsr     Scroll_Block_3                         ; Offset_0x006E66
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		moveq   #$00, D2
		tst.b   ($FFFFEEBD).w
		beq.s   Offset_0x006AD2
		move.w  ($FFFFFE04).w, D0
		andi.w  #$003F, D0
		lea     Bg_Scroll_Data(PC), A1                 ; Offset_0x006028
		lea     $00(A1, D0), A1
		moveq   #$00, D0
		move.b  (A1)+, D0
		add.w   D0, ($FFFFF616).w
		add.w   D0, ($FFFFF618).w
		add.w   D0, ($FFFFEEF4).w
		move.b  (A1)+, D2
		add.w   D2, ($FFFFEEF0).w
Offset_0x006AD2:
		lea     ($FFFFA800).w, A2
		lea     $0006(A2), A3
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		ext.l   D0
		asl.l   #$04, D0
		divs.w  #$000A, D0
		ext.l   D0
		asl.l   #$04, D0
		asl.l   #$08, D0
		move.l  D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D1, D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		swap.w  D1
		add.l   D0, D1
		swap.w  D1
		move.w  D1, (A3)+
		move.w  D1, (A2)
		move.w  D1, $0004(A2)
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		move.w  D0, $0002(A2)
		move.w  D0, $0016(A2)
		move.w  D0, $0000(A2)
		move.w  D0, $0004(A2)
		lea     (NGHz_Bg_Scroll_Data), A3              ; Offset_0x006B88
		lea     ($FFFFA800).w, A2
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  (Camera_Y_x4).w, D1                          ; $FFFFEE0C
		moveq   #$00, D0
Offset_0x006B5A:
		move.b  (A3)+, D0
		addq.w  #$02, A2
		sub.w   D0, D1
		bcc.s   Offset_0x006B5A
		neg.w   D1
		subq.w  #$02, A2
		move.w  #$00DF, D2
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x006B76:
		move.l  D0, (A1)+
		subq.w  #$01, D1
		bne.s   Offset_0x006B82
		move.b  (A3)+, D1
		move.w  (A2)+, D0
		neg.w   D0
Offset_0x006B82:
		dbra    D2, Offset_0x006B76
		rts                                 
;-------------------------------------------------------------------------------
NGHz_Bg_Scroll_Data:                                           ; Offset_0x006B88
		dc.b    $B0, $70, $30, $60, $15, $0C, $0E, $06
		dc.b    $0C, $1F, $30, $C0
;------------------------------------------------------------------------------- 
Bg_Scroll_Lvl1:                                                ; Offset_0x006B94
Bg_Scroll_Lvl3:                                                ; Offset_0x006B94
Bg_Scroll_Lvl6:                                                ; Offset_0x006B94
Bg_Scroll_Lvl9:                                                ; Offset_0x006B94
Bg_Scroll_GCz:                                                 ; Offset_0x006B94
Bg_Scroll_DEz:                                                 ; Offset_0x006B94 
		move.w  (Horizontal_Scrolling).w, D4                 ; $FFFFEEB0
		ext.l   D4
		asl.l   #$05, D4
		move.w  (Vertical_Scrolling).w, D5                   ; $FFFFEEB2
		ext.l   D5
		asl.l   #$06, D5
		bsr     Scroll_Block_1                         ; Offset_0x006DC8
		move.w  (Camera_Y_x4).w, ($FFFFF618).w               ; $FFFFEE0C
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$00DF, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		move.w  (Camera_X_x2).w, D0                          ; $FFFFEE08
		neg.w   D0
Offset_0x006BC4:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x006BC4
		rts  
;-------------------------------------------------------------------------------
Bg_Scroll_X:                                                   ; Offset_0x006BCC
		lea     (Scroll_Buffer_Data).w, A1                   ; $FFFFE000
		move.w  #$000E, D1               ; Varredura de tela * 16 pixels 
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		neg.w   D0
		swap.w  D0
		andi.w  #$000F, D2
		add.w   D2, D2
		move.w  (A2)+, D0
		jmp     Bg_Scroll_X_Start_Index(PC, D2)        ; Offset_0x006BEA
;-------------------------------------------------------------------------------                
Bg_Scroll_X_Loop:                                              ; Offset_0x006BE8
		move.w  (A2)+, D0
Bg_Scroll_X_Start_Index:                                       ; Offset_0x006BEA
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		move.l  D0, (A1)+
		dbra    D1, Bg_Scroll_X_Loop                   ; Offset_0x006BE8
		rts                                                                    
;-------------------------------------------------------------------------------
Scroll_Horizontal_2:                                           ; Offset_0x006C10
		move.w  (A1), D0
		andi.w  #$0010, D0
		move.b  (A2), D1
		eor.b   D1, D0
		bne.s   Offset_0x006C30
		eori.b  #$10, (A2)
		move.w  (A1), D0
		sub.w   D4, D0
		bpl.s   Offset_0x006C2C
		bset    #$02, (A3)
		rts
Offset_0x006C2C:
		bset    #$03, (A3)
Offset_0x006C30:
		rts                                                   
;-------------------------------------------------------------------------------
Scroll_Horizontal:                                             ; Offset_0x006C32
		move.w  (A1), D4
		move.w  (A5), D1
		beq.s   Offset_0x006C56
		subi.w  #$0100, D1
		move.w  D1, (A5)
		moveq   #$00, D1
		move.b  (A5), D1
		lsl.b   #$02, D1
		addq.b  #$04, D1
		move.w  $0002(A5), D0
		sub.b   D1, D0
		move.w  $00(A6, D0), D0
		andi.w  #$3FFF, D0
		bra.s   Offset_0x006C5A
Offset_0x006C56:
		move.w  $0008(A0), D0
Offset_0x006C5A:
		sub.w   (A1), D0
		subi.w  #$0090, D0
		blt.s   Offset_0x006C6C
		subi.w  #$0010, D0
		bge.s   Offset_0x006C80
		clr.w   (A4)
		rts
Offset_0x006C6C:
		cmpi.w  #$FFF0, D0
		bgt.s   Offset_0x006C76
		move.w  #$FFF0, D0
Offset_0x006C76:
		add.w   (A1), D0
		cmp.w   (A2), D0
		bgt.s   Offset_0x006C96
		move.w  (A2), D0
		bra.s   Offset_0x006C96
Offset_0x006C80:
		cmpi.w  #$0010, D0
		bcs.s   Offset_0x006C8A
		move.w  #$0010, D0
Offset_0x006C8A:
		add.w   (A1), D0
		cmp.w   $0002(A2), D0
		blt.s   Offset_0x006C96
		move.w  $0002(A2), D0
Offset_0x006C96:
		move.w  D0, D1
		sub.w   (A1), D1
		asl.w   #$08, D1
		move.w  D0, (A1)
		move.w  D1, (A4)
		rts                                   
;-------------------------------------------------------------------------------
Scroll_Vertical:                                               ; Offset_0x006CA2
		moveq   #$00, D1
		move.w  $000C(A0), D0
		sub.w   (A1), D0
		cmpi.w  #$FF00, (Sonic_Level_Limits_Min_Y).w         ; $FFFFEECC
		bne.s   Offset_0x006CB6
		andi.w  #$07FF, D0
Offset_0x006CB6:
		btst    #$02, $0022(A0)
		beq.s   Offset_0x006CC0
		subq.w  #$05, D0
Offset_0x006CC0:
		btst    #$01, $0022(A0)
		beq.s   Offset_0x006CE0
		addi.w  #$0020, D0
		sub.w   ($FFFFEED8).w, D0
		bcs.s   Offset_0x006D2A
		subi.w  #$0040, D0
		bcc.s   Offset_0x006D2A
		tst.b   (Vertical_Scroll_Flag).w                     ; $FFFFEEDE
		bne.s   Offset_0x006D3C
		bra.s   Offset_0x006CEC
Offset_0x006CE0:
		sub.w   ($FFFFEED8).w, D0
		bne.s   Offset_0x006CF0
		tst.b   (Vertical_Scroll_Flag).w                     ; $FFFFEEDE
		bne.s   Offset_0x006D3C
Offset_0x006CEC:
		clr.w   (A4)
		rts
Offset_0x006CF0:
		cmpi.w  #$0060, ($FFFFEED8).w
		bne.s   Offset_0x006D18
		move.w  $0014(A0), D1
		bpl.s   Offset_0x006D00
		neg.w   D1
Offset_0x006D00:
		cmpi.w  #$0800, D1
		bcc.s   Offset_0x006D2A
		move.w  #$0600, D1
		cmpi.w  #$0006, D0
		bgt.s   Offset_0x006D78
		cmpi.w  #$FFFFFFFA, D0
		blt.s   Offset_0x006D52
		bra.s   Offset_0x006D42
Offset_0x006D18:
		move.w  #$0200, D1
		cmpi.w  #$0002, D0
		bgt.s   Offset_0x006D78
		cmpi.w  #$FFFFFFFE, D0
		blt.s   Offset_0x006D52
		bra.s   Offset_0x006D42
Offset_0x006D2A:
		move.w  #$1000, D1
		cmpi.w  #$0010, D0
		bgt.s   Offset_0x006D78
		cmpi.w  #$FFF0, D0
		blt.s   Offset_0x006D52
		bra.s   Offset_0x006D42
Offset_0x006D3C:
		moveq   #$00, D0
		move.b  D0, (Vertical_Scroll_Flag).w                 ; $FFFFEEDE
Offset_0x006D42:
		moveq   #$00, D1
		move.w  D0, D1
		add.w   (A1), D1
		tst.w   D0
		bpl     Offset_0x006D80
		bra     Offset_0x006D5C
Offset_0x006D52:
		neg.w   D1
		ext.l   D1
		asl.l   #$08, D1
		add.l   (A1), D1
		swap.w  D1
Offset_0x006D5C:
		cmp.w   $0004(A2), D1
		bgt.s   Offset_0x006D96
		cmpi.w  #$FF00, D1
		bgt.s   Offset_0x006D72
		andi.w  #$07FF, D1
		andi.w  #$07FF, (A1)
		bra.s   Offset_0x006D96
Offset_0x006D72:
		move.w  $0004(A2), D1
		bra.s   Offset_0x006D96
Offset_0x006D78:
		ext.l   D1
		asl.l   #$08, D1
		add.l   (A1), D1
		swap.w  D1
Offset_0x006D80:
		cmp.w   $0006(A2), D1
		blt.s   Offset_0x006D96
		subi.w  #$0800, D1
		bcs.s   Offset_0x006D92
		subi.w  #$0800, (A1)
		bra.s   Offset_0x006D96
Offset_0x006D92:
		move.w  $0006(A2), D1
Offset_0x006D96:
		move.w  (A1), D4
		swap.w  D1
		move.l  D1, D3
		sub.l   (A1), D3
		ror.l   #$08, D3
		move.w  D3, (A4)
		move.l  D1, (A1)
		rts         
;-------------------------------------------------------------------------------
Scroll_Vertical_2:                                             ; Offset_0x006DA6
		move.w  (A1), D0
		andi.w  #$0010, D0
		move.b  (A2), D1
		eor.b   D1, D0
		bne.s   Offset_0x006DC6
		eori.b  #$10, (A2)
		move.w  (A1), D0
		sub.w   D4, D0
		bpl.s   Offset_0x006DC2
		bset    #$00, (A3)
		rts
Offset_0x006DC2:
		bset    #$01, (A3)
Offset_0x006DC6:
		rts  
;-------------------------------------------------------------------------------
Scroll_Block_1:                                                ; Offset_0x006DC8
		move.l  (Camera_X_x2).w, D2                          ; $FFFFEE08
		move.l  D2, D0
		add.l   D4, D0
		move.l  D0, (Camera_X_x2).w                          ; $FFFFEE08
		move.l  D0, D1
		swap.w  D1
		andi.w  #$0010, D1
		move.b  ($FFFFEE42).w, D3
		eor.b   D3, D1
		bne.s   Offset_0x006DFC
		eori.b  #$10, ($FFFFEE42).w
		sub.l   D2, D0
		bpl.s   Offset_0x006DF6
		bset    #$02, (Scroll_Flag_Array+$0002).w            ; $FFFFEE52
		bra.s   Offset_0x006DFC
Offset_0x006DF6:
		bset    #$03, (Scroll_Flag_Array+$0002).w            ; $FFFFEE52
Offset_0x006DFC:
		move.l  (Camera_Y_x4).w, D3                          ; $FFFFEE0C
		move.l  D3, D0
		add.l   D5, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, D1
		swap.w  D1
		andi.w  #$0010, D1
		move.b  ($FFFFEE43).w, D2
		eor.b   D2, D1
		bne.s   Offset_0x006E30
		eori.b  #$10, ($FFFFEE43).w
		sub.l   D3, D0
		bpl.s   Offset_0x006E2A
		bset    #$00, (Scroll_Flag_Array+$0002).w            ; $FFFFEE52
		rts
Offset_0x006E2A:
		bset    #$01, (Scroll_Flag_Array+$0002).w            ; $FFFFEE52
Offset_0x006E30:
		rts 
;-------------------------------------------------------------------------------
Scroll_Block_2:                                                ; Offset_0x006E32
		move.l  (Camera_X_x2).w, D2                          ; $FFFFEE08
		move.l  D2, D0
		add.l   D4, D0
		move.l  D0, (Camera_X_x2).w                          ; $FFFFEE08
		move.l  D0, D1
		swap.w  D1
		andi.w  #$0010, D1
		move.b  ($FFFFEE42).w, D3
		eor.b   D3, D1
		bne.s   Offset_0x006E64
		eori.b  #$10, ($FFFFEE42).w
		sub.l   D2, D0
		bpl.s   Offset_0x006E5E
		bset    D6, (Scroll_Flag_Array+$0002).w              ; $FFFFEE52
		bra.s   Offset_0x006E64
Offset_0x006E5E:
		addq.b  #$01, D6
		bset    D6, (Scroll_Flag_Array+$0002).w              ; $FFFFEE52
Offset_0x006E64:
		rts                       
;-------------------------------------------------------------------------------
Scroll_Block_3:                                                ; Offset_0x006E66
		move.l  (Camera_Y_x4).w, D3                          ; $FFFFEE0C
		move.l  D3, D0
		add.l   D5, D0
Scroll_Block_3_D0:                                             ; Offset_0x006E6E                
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, D1
		swap.w  D1
		andi.w  #$0010, D1
		move.b  ($FFFFEE43).w, D2
		eor.b   D2, D1
		bne.s   Offset_0x006E98
		eori.b  #$10, ($FFFFEE43).w
		sub.l   D3, D0
		bpl.s   Offset_0x006E92
		bset    D6, (Scroll_Flag_Array+$0002).w              ; $FFFFEE52
		rts
Offset_0x006E92:
		addq.b  #$01, D6
		bset    D6, (Scroll_Flag_Array+$0002).w              ; $FFFFEE52
Offset_0x006E98:
		rts   
;-------------------------------------------------------------------------------
Scroll_Block_4:                                                ; Offset_0x006E9A
		move.l  (Camera_X_x8).w, D2                          ; $FFFFEE10
		move.l  D2, D0
		add.l   D4, D0
		move.l  D0, (Camera_X_x8).w                          ; $FFFFEE10
		move.l  D0, D1
		swap.w  D1
		andi.w  #$0010, D1
		move.b  ($FFFFEE44).w, D3
		eor.b   D3, D1
		bne.s   Offset_0x006ECC
		eori.b  #$10, ($FFFFEE44).w
		sub.l   D2, D0
		bpl.s   Offset_0x006EC6
		bset    D6, (Scroll_Flag_Array+$0004).w              ; $FFFFEE54
		bra.s   Offset_0x006ECC
Offset_0x006EC6:
		addq.b  #$01, D6
		bset    D6, (Scroll_Flag_Array+$0004).w              ; $FFFFEE54
Offset_0x006ECC:
		rts   
;-------------------------------------------------------------------------------    
; Scroll_Block_5: ; Left over do Sonic 1, não usado            ; Offset_0x006ECE
		move.l  (Camera_X_x4).w, D2                          ; $FFFFEE18
		move.l  D2, D0
		add.l   D4, D0
		move.l  D0, (Camera_X_x4).w                          ; $FFFFEE18
		move.l  D0, D1
		swap.w  D1
		andi.w  #$0010, D1
		move.b  ($FFFFEE46).w, D3
		eor.b   D3, D1
		bne.s   Offset_0x006F00
		eori.b  #$10, ($FFFFEE46).w
		sub.l   D2, D0
		bpl.s   Offset_0x006EFA
		bset    D6, (Scroll_Flag_Array+$0006).w              ; $FFFFEE56
		bra.s   Offset_0x006F00
Offset_0x006EFA:
		addq.b  #$01, D6
		bset    D6, (Scroll_Flag_Array+$0006).w              ; $FFFFEE56
Offset_0x006F00:
		rts 
;------------------------------------------------------------------------------- 
; Offset_0x006F02: ; Left over do Sonic 1, não usado         
		lea     (VDP_Control_Port), A5                       ; $00C00004
		lea     (VDP_Data_Port), A6                          ; $00C00000
		lea     (Scroll_Flag_Array+$0002).w, A2              ; $FFFFEE52
		lea     (Camera_X_x2).w, A3                          ; $FFFFEE08
		lea     (Level_Map_Bg_Buffer).w, A4                  ; $FFFF8080
		move.w  #$6000, D2
		bsr     Offset_0x007094
		lea     (Scroll_Flag_Array+$0004).w, A2              ; $FFFFEE54
		lea     (Camera_X_x8).w, A3                          ; $FFFFEE10
		bra     Offset_0x007164
;===============================================================================
; Rotina para rolar a tela de acordo com a posição do personagem
; <<<-
;===============================================================================

;===============================================================================
; Rotina de processamento de rolagem da tela durante o movimento dos personagens  
; ->>>
;=============================================================================== 
LoadTilesAsYouMove:                                            ; Offset_0x006F2E
		lea     (VDP_Control_Port), A5                       ; $00C00004
		lea     (VDP_Data_Port), A6                          ; $00C00000
		lea     (Scroll_Flag_Array_2+$0002).w, A2            ; $FFFFEEA2
		lea     ($FFFFEE68).w, A3
		lea     (Level_Map_Bg_Buffer).w, A4                  ; $FFFF8080
		move.w  #$6000, D2
		bsr     Offset_0x007094
		lea     (Scroll_Flag_Array_2+$0004).w, A2            ; $FFFFEEA4
		lea     ($FFFFEE70).w, A3
		bsr     Offset_0x007164
		lea     (Scroll_Flag_Array_2+$0006).w, A2            ; $FFFFEEA6
		lea     ($FFFFEE78).w, A3
		bsr     Offset_0x007254
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x006F80
		lea     (Scroll_Flag_Array_2+$0008).w, A2            ; $FFFFEEA8
		lea     ($FFFFEE80).w, A3
		lea     (Level_Map_Buffer).w, A4                     ; $FFFF8000
		move.w  #$6000, D2
		bsr     Offset_0x00702E
Offset_0x006F80:
		lea     (Scroll_Flag_Array_2).w, A2                  ; $FFFFEEA0
		lea     ($FFFFEE60).w, A3
		lea     (Level_Map_Buffer).w, A4                     ; $FFFF8000
		move.w  #$4000, D2
		tst.b   (Refresh_Level_Layout).w                     ; $FFFFF720
		beq.s   Draw_FG                                ; Offset_0x006FC8
		move.b  #$00, (Refresh_Level_Layout).w               ; $FFFFF720
		moveq   #-$10, D4
		moveq   #$0F, D6
Draw_All:                                                      ; Offset_0x006FA0
		movem.l D4-D6, -(A7)
		moveq   #-$10, D5
		move.w  D4, D1
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  D1, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
		movem.l (A7)+, D4-D6
		addi.w  #$0010, D4
		dbra    D6, Draw_All                           ; Offset_0x006FA0
		move.b  #$00, (Scroll_Flag_Array_2).w                ; $FFFFEEA0
		rts
Draw_FG:                                                       ; Offset_0x006FC8
		tst.b   (A2)
		beq.s   Offset_0x00702C
		bclr    #$00, (A2)
		beq.s   Offset_0x006FE2
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x006FE2:
		bclr    #$01, (A2)
		beq.s   Offset_0x006FFC
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x006FFC:
		bclr    #$02, (A2)
		beq.s   Offset_0x007012
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     DrawTiles_TopBottom                    ; Offset_0x0073D6
Offset_0x007012:
		bclr    #$03, (A2)
		beq.s   Offset_0x00702C
		moveq   #-$10, D4
		move.w  #$0140, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		move.w  #$0140, D5
		bsr     DrawTiles_TopBottom                    ; Offset_0x0073D6
Offset_0x00702C:
		rts
Offset_0x00702E:
		tst.b   (A2)
		beq.s   Offset_0x007092
		bclr    #$00, (A2)
		beq.s   Offset_0x007048
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos_2                        ; Offset_0x007794
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x007048:
		bclr    #$01, (A2)
		beq.s   Offset_0x007062
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos_2                        ; Offset_0x007794
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x007062:
		bclr    #$02, (A2)
		beq.s   Offset_0x007078
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos_2                        ; Offset_0x007794
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     DrawTiles_TopBottom                    ; Offset_0x0073D6
Offset_0x007078:
		bclr    #$03, (A2)
		beq.s   Offset_0x007092
		moveq   #-$10, D4
		move.w  #$0140, D5
		bsr     Calc_VRAM_Pos_2                        ; Offset_0x007794
		moveq   #-$10, D4
		move.w  #$0140, D5
		bsr     DrawTiles_TopBottom                    ; Offset_0x0073D6
Offset_0x007092:
		rts
Offset_0x007094:
		tst.b   (A2)
		beq     Offset_0x007162
		bclr    #$00, (A2)
		beq.s   Offset_0x0070B0
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x0070B0:
		bclr    #$01, (A2)
		beq.s   Offset_0x0070CA
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x0070CA:
		bclr    #$02, (A2)
		beq.s   Offset_0x0070E0
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     DrawTiles_TopBottom                    ; Offset_0x0073D6
Offset_0x0070E0:
		bclr    #$03, (A2)
		beq.s   Offset_0x0070FA
		moveq   #-$10, D4
		move.w  #$0140, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		move.w  #$0140, D5
		bsr     DrawTiles_TopBottom                    ; Offset_0x0073D6
Offset_0x0070FA:
		bclr    #$04, (A2)
		beq.s   Offset_0x007112
		moveq   #-$10, D4
		moveq   #$00, D5
		bsr     Calc_VRAM_Pos_D5                       ; Offset_0x00775A
		moveq   #-$10, D4
		moveq   #$00, D5
		moveq   #$1F, D6
		bsr     DrawTiles_LeftRight_D6                 ; Offset_0x007468
Offset_0x007112:
		bclr    #$05, (A2)
		beq.s   Offset_0x00712E
		move.w  #$00E0, D4
		moveq   #$00, D5
		bsr     Calc_VRAM_Pos_D5                       ; Offset_0x00775A
		move.w  #$00E0, D4
		moveq   #$00, D5
		moveq   #$1F, D6
		bsr     DrawTiles_LeftRight_D6                 ; Offset_0x007468
Offset_0x00712E:
		bclr    #$06, (A2)
		beq.s   Offset_0x007146
		moveq   #-$10, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		moveq   #-$10, D4
		moveq   #-$10, D5
		moveq   #$1F, D6
		bsr     Offset_0x00745C
Offset_0x007146:
		bclr    #$07, (A2)
		beq.s   Offset_0x007162
		move.w  #$00E0, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$00E0, D4
		moveq   #-$10, D5
		moveq   #$1F, D6
		bsr     Offset_0x00745C
Offset_0x007162:
		rts
Offset_0x007164:
		tst.b   (A2)
		beq     Offset_0x0071A6
		bclr    #$00, (A2)
		beq.s   Offset_0x007186
		move.w  #$0070, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$0070, D4
		moveq   #-$10, D5
		moveq   #$02, D6
		bsr     DrawTiles_TopBottom_D6                 ; Offset_0x0073D8
Offset_0x007186:
		bclr    #$01, (A2)
		beq.s   Offset_0x0071A6
		move.w  #$0070, D4
		move.w  #$0140, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$0070, D4
		move.w  #$0140, D5
		moveq   #$02, D6
		bsr     DrawTiles_TopBottom_D6                 ; Offset_0x0073D8
Offset_0x0071A6:
		rts 
;-------------------------------------------------------------------------------
; Scrap Brain Zone Deformation
; Leftover from Sonic 1
;-------------------------------------------------------------------------------
Draw_SBz_Bg_Data:                                              ; Offset_0x0071A8
		dc.b    $00, $00, $00, $00, $00, $06, $06, $06
		dc.b    $06, $06, $06, $06, $06, $06, $06, $04
		dc.b    $04, $04, $04, $04, $04, $04, $02, $02
		dc.b    $02, $02, $02, $02, $02, $02, $02, $02
		dc.b    $02, $00 
;-------------------------------------------------------------------------------
Draw_SBz_Bg:                                                   ; Offset_0x0071CA
		moveq   #-$10, D4
		bclr    #$00, (A2)
		bne.s   Offset_0x0071DC
		bclr    #$01, (A2)
		beq.s   Offset_0x007224
		move.w  #$00E0, D4
Offset_0x0071DC:
		lea     Draw_SBz_Bg_Data+$01(PC), A0           ; Offset_0x0071A9
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		add.w   D4, D0
		andi.w  #$01F0, D0
		lsr.w   #$04, D0
		move.b  $00(A0, D0), D0
		lea     (Scroll_Mem_Address_Data), A3          ; Offset_0x007350
		move.w  $00(A3, D0), A3
		beq.s   Offset_0x007210
		moveq   #-$10, D5
		movem.l D4/D5, -(A7)
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		movem.l (A7)+, D4/D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
		bra.s   Offset_0x007224
Offset_0x007210:
		moveq   #$00, D5
		movem.l D4/D5, -(A7)
		bsr     Calc_VRAM_Pos_D5                       ; Offset_0x00775A
		movem.l (A7)+, D4/D5
		moveq   #$1F, D6
		bsr     DrawTiles_LeftRight_D6                 ; Offset_0x007468
Offset_0x007224:
		tst.b   (A2)
		bne.s   Offset_0x00722A
		rts
Offset_0x00722A:
		moveq   #-$10, D4
		moveq   #-$10, D5
		move.b  (A2), D0
		andi.b  #$A8, D0
		beq.s   Offset_0x00723E
		lsr.b   #$01, D0
		move.b  D0, (A2)
		move.w  #$0140, D5
Offset_0x00723E:
		lea     Draw_SBz_Bg_Data(PC), A0               ; Offset_0x0071A8
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		andi.w  #$01F0, D0
		lsr.w   #$04, D0
		lea     $00(A0, D0), A0
		bra     Offset_0x007358
;-------------------------------------------------------------------------------
; Rotina de controle da rolagem da fase Scrap Brain Zone 1 
; Left over do Sonic 1
; <<<-
;-------------------------------------------------------------------------------                
Offset_0x007254:
		tst.b   (A2)
		beq     Offset_0x0072A0
		cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
		beq     Draw_CPz_Bg                            ; Offset_0x0072E4
		bclr    #$00, (A2)
		beq.s   Offset_0x007280
		move.w  #$0040, D4
		moveq   #-$10, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$0040, D4
		moveq   #-$10, D5
		moveq   #$02, D6
		bsr     DrawTiles_TopBottom_D6                 ; Offset_0x0073D8
Offset_0x007280:
		bclr    #$01, (A2)
		beq.s   Offset_0x0072A0
		move.w  #$0040, D4
		move.w  #$0140, D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  #$0040, D4
		move.w  #$0140, D5
		moveq   #$02, D6
		bsr     DrawTiles_TopBottom_D6                 ; Offset_0x0073D8
Offset_0x0072A0:
		rts     
;-------------------------------------------------------------------------------  
; Rotina de controle da rolagem da fase Chemical Plant
; ->>>
;-------------------------------------------------------------------------------              
Draw_CPz_Bg_Data:                                              ; Offset_0x0072A2
		dc.b    $02, $02, $02, $02, $02, $02, $02, $02
		dc.b    $02, $02, $02, $02, $02, $02, $02, $02
		dc.b    $02, $02, $02, $02, $04, $04, $04, $04
		dc.b    $04, $04, $04, $04, $04, $04, $04, $04
		dc.b    $04, $04, $04, $04, $04, $04, $04, $04
		dc.b    $04, $04, $04, $04, $04, $04, $04, $04
		dc.b    $04, $04, $04, $04, $04, $04, $04, $04
		dc.b    $04, $04, $04, $04, $04, $04, $04, $04
		dc.b    $04, $00  
;-------------------------------------------------------------------------------  
Draw_CPz_Bg:                                                   ; Offset_0x0072E4
		moveq   #-$10, D4
		bclr    #$00, (A2)
		bne.s   Offset_0x0072F6
		bclr    #$01, (A2)
		beq.s   Offset_0x007320
		move.w  #$00E0, D4
Offset_0x0072F6:
		lea     Draw_CPz_Bg_Data+$01(PC), A0           ; Offset_0x0072A3
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		add.w   D4, D0
		andi.w  #$03F0, D0
		lsr.w   #$04, D0
		move.b  $00(A0, D0), D0
		move.w  Scroll_Mem_Address_Data(PC, D0), A3    ; Offset_0x007350
		moveq   #-$10, D5
		movem.l D4/D5, -(A7)
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		movem.l (A7)+, D4/D5
		bsr     DrawTiles_LeftRight                    ; Offset_0x007464
Offset_0x007320:
		tst.b   (A2)
		bne.s   Offset_0x007326
		rts
Offset_0x007326:
		moveq   #-$10, D4
		moveq   #-$10, D5
		move.b  (A2), D0
		andi.b  #$A8, D0
		beq.s   Offset_0x00733A
		lsr.b   #$01, D0
		move.b  D0, (A2)
		move.w  #$0140, D5
Offset_0x00733A:
		lea     Draw_CPz_Bg_Data(PC), A0               ; Offset_0x0072A2
		move.w  (Camera_Y_x4).w, D0                          ; $FFFFEE0C
		andi.w  #$07F0, D0
		lsr.w   #$04, D0
		lea     $00(A0, D0), A0
		bra     Offset_0x007358    
;-------------------------------------------------------------------------------  
; Rotina de controle da rolagem da fase Chemical Plant
; <<<-
;------------------------------------------------------------------------------- 
Scroll_Mem_Address_Data:                                       ; Offset_0x007350
		dc.w    $EE68, $EE68, $EE70, $EE78
;------------------------------------------------------------------------------- 
Offset_0x007358:
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   Offset_0x00739A
		moveq   #$0F, D6
		move.l  #$00800000, D7
Offset_0x007366:
		moveq   #$00, D0
		move.b  (A0)+, D0
		btst    D0, (A2)
		beq.s   Offset_0x00738E
		move.w  Scroll_Mem_Address_Data(PC, D0), A3    ; Offset_0x007350
		movem.l D4/D5/A0, -(A7)
		movem.l D4/D5, -(A7)
		bsr     Draw_Blocks                            ; Offset_0x007716
		movem.l (A7)+, D4/D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		bsr     Draw_Tiles_3                           ; Offset_0x007646
		movem.l (A7)+, D4/D5/A0
Offset_0x00738E:
		addi.w  #$0010, D4
		dbra    D6, Offset_0x007366
		clr.b   (A2)
		rts
Offset_0x00739A:
		moveq   #$0F, D6
		move.l  #$00800000, D7
Offset_0x0073A2:
		moveq   #$00, D0
		move.b  (A0)+, D0
		btst    D0, (A2)
		beq.s   Offset_0x0073CA
		move.w  Scroll_Mem_Address_Data(PC, D0), A3    ; Offset_0x007350
		movem.l D4/D5/A0, -(A7)
		movem.l D4/D5, -(A7)
		bsr     Draw_Blocks                            ; Offset_0x007716
		movem.l (A7)+, D4/D5
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		bsr     Draw_Tiles_4                           ; Offset_0x0076CC
		movem.l (A7)+, D4/D5/A0
Offset_0x0073CA:
		addi.w  #$0010, D4
		dbra    D6, Offset_0x0073A2
		clr.b   (A2)
		rts         
;-------------------------------------------------------------------------------                
; Rotina para desenhar a tela na vertical
; ->>>
;------------------------------------------------------------------------------- 
DrawTiles_TopBottom:                                           ; Offset_0x0073D6
		moveq   #$0F, D6
DrawTiles_TopBottom_D6:                                        ; Offset_0x0073D8                
		add.w   (A3), D5
		add.w   $0004(A3), D4
		move.l  #$00800000, D7
		move.l  D0, D1
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   DrawTiles_TopBottom_2P                 ; Offset_0x007426
Offset_0x0073F0:
		move.w  (A0), D3
		andi.w  #$03FF, D3
		lsl.w   #$03, D3
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		adda.w  D3, A1
		move.l  D1, D0
		bsr     Draw_Tiles_3                           ; Offset_0x007646
		adda.w  #$0010, A0
		addi.w  #$0100, D1
		andi.w  #$0FFF, D1
		addi.w  #$0010, D4
		move.w  D4, D0
		andi.w  #$0070, D0
		bne.s   Offset_0x007420
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x007420:
		dbra    D6, Offset_0x0073F0
		rts
DrawTiles_TopBottom_2P:                                        ; Offset_0x007426
		move.w  (A0), D3
		andi.w  #$03FF, D3
		lsl.w   #$03, D3
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		adda.w  D3, A1
		move.l  D1, D0
		bsr     Draw_Tiles_4                           ; Offset_0x0076CC
		adda.w  #$0010, A0
		addi.w  #$0080, D1
		andi.w  #$0FFF, D1
		addi.w  #$0010, D4
		move.w  D4, D0
		andi.w  #$0070, D0
		bne.s   Offset_0x007456
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x007456:
		dbra    D6, DrawTiles_TopBottom_2P             ; Offset_0x007426
		rts 
;-------------------------------------------------------------------------------                
; Rotina para desenhar a tela na vertical
; <<<-
;-------------------------------------------------------------------------------                     
Offset_0x00745C:
		add.w   (A3), D5
		add.w   $0004(A3), D4
		bra.s   Offset_0x00746C     
;-------------------------------------------------------------------------------                
; Rotina para desenhar a tela na horizontal
; ->>>
;-------------------------------------------------------------------------------     
DrawTiles_LeftRight:                                           ; Offset_0x007464
		moveq   #$15, D6
		add.w   (A3), D5
DrawTiles_LeftRight_D6:                                        ; Offset_0x007468                
		add.w   $0004(A3), D4
Offset_0x00746C:
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   Offset_0x0074EA
		move.l  A2, -(A7)
		move.w  D6, -(A7)
		lea     ($FFFFEF00).w, A2
		move.l  D0, D1
		or.w    D2, D1
		swap.w  D1
		move.l  D1, -(A7)
		move.l  D1, (A5)
		swap.w  D1
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x00748A:
		move.w  (A0), D3
		andi.w  #$03FF, D3
		lsl.w   #$03, D3
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		adda.w  D3, A1
		bsr     Draw_Tiles                             ; Offset_0x0075A6
		addq.w  #$02, A0
		addq.b  #$04, D1
		bpl.s   Offset_0x0074AC
		andi.b  #$7F, D1
		swap.w  D1
		move.l  D1, (A5)
		swap.w  D1
Offset_0x0074AC:
		addi.w  #$0010, D5
		move.w  D5, D0
		andi.w  #$0070, D0
		bne.s   Offset_0x0074BC
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x0074BC:
		dbra    D6, Offset_0x00748A
		move.l  (A7)+, D1
		addi.l  #$00800000, D1
		lea     ($FFFFEF00).w, A2
		move.l  D1, (A5)
		swap.w  D1
		move.w  (A7)+, D6
Offset_0x0074D2:
		move.l  (A2)+, (A6)
		addq.b  #$04, D1
		bmi.s   Offset_0x0074E2
		ori.b   #$80, D1
		swap.w  D1
		move.l  D1, (A5)
		swap.w  D1
Offset_0x0074E2:
		dbra    D6, Offset_0x0074D2
		move.l  (A7)+, A2
		rts
Offset_0x0074EA:
		move.l  D0, D1
		or.w    D2, D1
		swap.w  D1
		move.l  D1, (A5)
		swap.w  D1
		tst.b   D1
		bmi.s   Offset_0x007534
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x0074FC:
		move.w  (A0), D3
		andi.w  #$03FF, D3
		lsl.w   #$03, D3
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		adda.w  D3, A1
		bsr     Draw_Tiles_2                           ; Offset_0x007608
		addq.w  #$02, A0
		addq.b  #$04, D1
		bpl.s   Offset_0x00751E
		andi.b  #$7F, D1
		swap.w  D1
		move.l  D1, (A5)
		swap.w  D1
Offset_0x00751E:
		addi.w  #$0010, D5
		move.w  D5, D0
		andi.w  #$0070, D0
		bne.s   Offset_0x00752E
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x00752E:
		dbra    D6, Offset_0x0074FC
		rts
Offset_0x007534:
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x007538:
		move.w  (A0), D3
		andi.w  #$03FF, D3
		lsl.w   #$03, D3
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		adda.w  D3, A1
		bsr     Draw_Tiles_2                           ; Offset_0x007608
		addq.w  #$02, A0
		addq.b  #$04, D1
		bmi.s   Offset_0x00755A
		ori.b   #$80, D1
		swap.w  D1
		move.l  D1, (A5)
		swap.w  D1
Offset_0x00755A:
		addi.w  #$0010, D5
		move.w  D5, D0
		andi.w  #$0070, D0
		bne.s   Offset_0x00756A
		bsr     Calc_Chunk_RAM_Pos                     ; Offset_0x007570
Offset_0x00756A:
		dbra    D6, Offset_0x007538
		rts                 
;-------------------------------------------------------------------------------                
; Rotina para desenhar a tela na horizontal
; <<<-
;-------------------------------------------------------------------------------    

;-------------------------------------------------------------------------------  
; Rotina para calcular o bloco em relação a posição da tela
; ->>>
;-------------------------------------------------------------------------------                                                                         
Calc_Chunk_RAM_Pos:                                            ; Offset_0x007570
		movem.l D4/D5, -(A7)
		move.w  D4, D3
		add.w   D3, D3
		andi.w  #$0F00, D3
		lsr.w   #$03, D5
		move.w  D5, D0
		lsr.w   #$04, D0
		andi.w  #$007F, D0
		add.w   D3, D0
		moveq   #-$01, D3
		clr.w   D3
		move.b  $00(A4, D0), D3
		lsl.w   #$07, D3
		andi.w  #$0070, D4
		andi.w  #$000E, D5
		add.w   D4, D3
		add.w   D5, D3
		move.l  D3, A0
		movem.l (A7)+, D4/D5
		rts 
;-------------------------------------------------------------------------------  
; Rotina para calcular o bloco em relação a posição da tela
; <<<-
;-------------------------------------------------------------------------------   

;-------------------------------------------------------------------------------  
; Rotinas para desenhar os tiles 8x8
; ->>>
;-------------------------------------------------------------------------------  
Draw_Tiles:                                                    ; Offset_0x0075A6
		btst    #$03, (A0)              ; Y Flip ?
		bne.s   Draw_FlipY                             ; Offset_0x0075D2
		btst    #$02, (A0)              ; X_Flip ?
		bne.s   Draw_FlipX                             ; Offset_0x0075B8
		move.l  (A1)+, (A6)
		move.l  (A1)+, (A2)+
		rts
Draw_FlipX:                                                    ; Offset_0x0075B8
		move.l  (A1)+, D3
		eori.l  #$08000800, D3
		swap.w  D3
		move.l  D3, (A6)
		move.l  (A1)+, D3
		eori.l  #$08000800, D3
		swap.w  D3
		move.l  D3, (A2)+
		rts
Draw_FlipY:                                                    ; Offset_0x0075D2
		btst    #$02, (A0)              ; X_Flip ?
		bne.s   Draw_FlipXY                            ; Offset_0x0075EE
		move.l  (A1)+, D0
		move.l  (A1)+, D3
		eori.l  #$10001000, D3
		move.l  D3, (A6)
		eori.l  #$10001000, D0
		move.l  D0, (A2)+
		rts
Draw_FlipXY:                                                   ; Offset_0x0075EE
		move.l  (A1)+, D0
		move.l  (A1)+, D3
		eori.l  #$18001800, D3
		swap.w  D3
		move.l  D3, (A6)
		eori.l  #$18001800, D0
		swap.w  D0
		move.l  D0, (A2)+
		rts
;-------------------------------------------------------------------------------
Draw_Tiles_2:                                                  ; Offset_0x007608
		btst    #$03, (A0)              ; Y Flip ?
		bne.s   Draw_FlipY_2                           ; Offset_0x007626
		btst    #$02, (A0)              ; X Flip ?
		bne.s   Draw_FlipX_2                           ; Offset_0x007618
		move.l  (A1)+, (A6)
		rts
Draw_FlipX_2:                                                  ; Offset_0x007618
		move.l  (A1)+, D3
		eori.l  #$08000800, D3
		swap.w  D3
		move.l  D3, (A6)
		rts
Draw_FlipY_2:                                                  ; Offset_0x007626
		btst    #$02, (A0)              ; X Flip ?
		bne.s   Draw_FlipXY_2                          ; Offset_0x007638
		move.l  (A1)+, D3
		eori.l  #$10001000, D3
		move.l  D3, (A6)
		rts
Draw_FlipXY_2:                                                 ; Offset_0x007638
		move.l  (A1)+, D3
		eori.l  #$18001800, D3
		swap.w  D3
		move.l  D3, (A6)
		rts 
;-------------------------------------------------------------------------------    
Draw_Tiles_3:                                                  ; Offset_0x007646
		or.w    D2, D0
		swap.w  D0
		btst    #$03, (A0)              ; Y Flip ?
		bne.s   Draw_FlipY_3                           ; Offset_0x007682
		btst    #$02, (A0)              ; X Flip ?
		bne.s   Draw_FlipX_3                           ; Offset_0x007662
		move.l  D0, (A5)
		move.l  (A1)+, (A6)
		add.l   D7, D0
		move.l  D0, (A5)
		move.l  (A1)+, (A6)
		rts
Draw_FlipX_3:                                                  ; Offset_0x007662
		move.l  D0, (A5)
		move.l  (A1)+, D3
		eori.l  #$08000800, D3
		swap.w  D3
		move.l  D3, (A6)
		add.l   D7, D0
		move.l  D0, (A5)
		move.l  (A1)+, D3
		eori.l  #$08000800, D3
		swap.w  D3
		move.l  D3, (A6)
		rts
Draw_FlipY_3:                                                  ; Offset_0x007682
		btst    #$02, (A0)              ; X Flip ?
		bne.s   Draw_FlipXY_3                          ; Offset_0x0076A8
		move.l  D5, -(A7)
		move.l  D0, (A5)
		move.l  (A1)+, D5
		move.l  (A1)+, D3
		eori.l  #$10001000, D3
		move.l  D3, (A6)
		add.l   D7, D0
		move.l  D0, (A5)
		eori.l  #$10001000, D5
		move.l  D5, (A6)
		move.l  (A7)+, D5
		rts
Draw_FlipXY_3:                                                 ; Offset_0x0076A8
		move.l  D5, -(A7)
		move.l  D0, (A5)
		move.l  (A1)+, D5
		move.l  (A1)+, D3
		eori.l  #$18001800, D3
		swap.w  D3
		move.l  D3, (A6)
		add.l   D7, D0
		move.l  D0, (A5)
		eori.l  #$18001800, D5
		swap.w  D5
		move.l  D5, (A6)
		move.l  (A7)+, D5
		rts                                                                                                                                                                               
;-------------------------------------------------------------------------------  
Draw_Tiles_4:                                                  ; Offset_0x0076CC
		or.w    D2, D0
		swap.w  D0
		btst    #$03, (A0)              ; Y Flip ?
		bne.s   Draw_FlipY_4                           ; Offset_0x0076F2
		btst    #$02, (A0)              ; X Flip ?
		bne.s   Draw_FlipX_4                           ; Offset_0x0076E2
		move.l  D0, (A5)
		move.l  (A1)+, (A6)
		rts
Draw_FlipX_4:                                                  ; Offset_0x0076E2
		move.l  D0, (A5)
		move.l  (A1)+, D3
		eori.l  #$08000800, D3
		swap.w  D3
		move.l  D3, (A6)
		rts
Draw_FlipY_4:                                                  ; Offset_0x0076F2
		btst    #$02, (A0)              ; X Flip ?
		bne.s   Draw_FlipXY_4                          ; Offset_0x007706
		move.l  D0, (A5)
		move.l  (A1)+, D3
		eori.l  #$10001000, D3
		move.l  D3, (A6)
		rts
Draw_FlipXY_4:                                                 ; Offset_0x007706
		move.l  D0, (A5)
		move.l  (A1)+, D3
		eori.l  #$18001800, D3
		swap.w  D3
		move.l  D3, (A6)
		rts             
;-------------------------------------------------------------------------------  
; Rotinas para desenhar os tiles 8x8
; <<<-
;-------------------------------------------------------------------------------  
	     
;------------------------------------------------------------------------------- 
; Rotinas para desenhar os blocos 16x16
; ->>>
;-------------------------------------------------------------------------------
Draw_Blocks:                                                   ; Offset_0x007716
		add.w   (A3), D5
		add.w   $0004(A3), D4
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		move.w  D4, D3
		add.w   D3, D3
		andi.w  #$0F00, D3
		lsr.w   #$03, D5
		move.w  D5, D0
		lsr.w   #$04, D0
		andi.w  #$007F, D0
		add.w   D3, D0
		moveq   #-$01, D3
		clr.w   D3
		move.b  $00(A4, D0), D3
		lsl.w   #$07, D3
		andi.w  #$0070, D4
		andi.w  #$000E, D5
		add.w   D4, D3
		add.w   D5, D3
		move.l  D3, A0
		move.w  (A0), D3
		andi.w  #$03FF, D3
		lsl.w   #$03, D3
		adda.w  D3, A1
		rts
;------------------------------------------------------------------------------- 
; Rotinas para desenhar os blocos 16x16
; <<<-
;-------------------------------------------------------------------------------

;------------------------------------------------------------------------------- 
; Rotinas para calcular a posição da VRAM
; ->>>
;-------------------------------------------------------------------------------   
Calc_VRAM_Pos:                                                 ; Offset_0x007758
		add.w   (A3), D5
Calc_VRAM_Pos_D5:                                              ; Offset_0x00775A                
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   Calc_VRAM_Pos_2P                       ; Offset_0x00777A
		add.w   $0004(A3), D4
		andi.w  #$00F0, D4
		andi.w  #$01F0, D5
		lsl.w   #$04, D4
		lsr.w   #$02, D5
		add.w   D5, D4
		moveq   #$03, D0
		swap.w  D0
		move.w  D4, D0
		rts
Calc_VRAM_Pos_2P:                                              ; Offset_0x00777A
		add.w   $0004(A3), D4
Calc_VRAM_Pos_2P_D4:                                           ; Offset_0x00777E
		andi.w  #$01F0, D4
		andi.w  #$01F0, D5
		lsl.w   #$03, D4
		lsr.w   #$02, D5
		add.w   D5, D4
		moveq   #$03, D0
		swap.w  D0
		move.w  D4, D0
		rts   
;-------------------------------------------------------------------------------                 
Calc_VRAM_Pos_2:                                               ; Offset_0x007794
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   Calc_VRAM_Pos_2_2P                     ; Offset_0x0077B6
		add.w   $0004(A3), D4
		add.w   (A3), D5
		andi.w  #$00F0, D4
		andi.w  #$01F0, D5
		lsl.w   #$04, D4
		lsr.w   #$02, D5
		add.w   D5, D4
		moveq   #$02, D0
		swap.w  D0
		move.w  D4, D0
		rts
Calc_VRAM_Pos_2_2P:                                            ; Offset_0x0077B6
		add.w   $0004(A3), D4
		add.w   (A3), D5
		andi.w  #$01F0, D4
		andi.w  #$01F0, D5
		lsl.w   #$03, D4
		lsr.w   #$02, D5
		add.w   D5, D4
		moveq   #$02, D0
		swap.w  D0
		move.w  D4, D0
		rts
;------------------------------------------------------------------------------- 
; Rotinas para calcular a posição da VRAM
; <<<-
;-------------------------------------------------------------------------------   
							     
;===============================================================================
; Rotina de processamento de rolagem da tela durante o movimento dos personagens  
; <<<-
;=============================================================================== 

;===============================================================================
; Rotina para carregar os tiles da fase a partir da posição do jogador usado 
; ->>>          durante a carga da fase.
;===============================================================================
Load_Tiles_From_Start:                                         ; Offset_0x0077D2
		lea     (VDP_Control_Port), A5                       ; $00C00004
		lea     (VDP_Data_Port), A6                          ; $00C00000
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x0077F2
		lea     (Camera_X_2).w, A3                           ; $FFFFEE20
		lea     (Level_Map_Buffer).w, A4                     ; $FFFF8000
		move.w  #$6000, D2
		bsr.s   Offset_0x00784E
Offset_0x0077F2:
		lea     (Camera_X).w, A3                             ; $FFFFEE00
		lea     (Level_Map_Buffer).w, A4                     ; $FFFF8000
		move.w  #$4000, D2
		bsr.s   Offset_0x00781E
		lea     (Camera_X_x2).w, A3                          ; $FFFFEE08
		lea     (Level_Map_Bg_Buffer).w, A4                  ; $FFFF8080
		move.w  #$6000, D2
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq     Offset_0x00781E
		cmpi.b  #$0B, (Level_Id).w                           ; $FFFFFE10
		beq     Offset_0x00787E
Offset_0x00781E:
		moveq   #-$10, D4  
		moveq   #$0F, D6
Offset_0x007822:
		movem.l D4-D6, -(A7)
		moveq   #$00, D5
		move.w  D4, D1
		bsr     Calc_VRAM_Pos                          ; Offset_0x007758
		move.w  D1, D4
		moveq   #$00, D5
		moveq   #$1F, D6
		move    #$2700, SR
		bsr     Offset_0x00745C
		move    #$2300, SR
		movem.l (A7)+, D4-D6
		addi.w  #$0010, D4
		dbra    D6, Offset_0x007822
		rts
Offset_0x00784E:
		moveq   #-$10, D4
		moveq   #$0F, D6
Offset_0x007852:
		movem.l D4-D6, -(A7)
		moveq   #$00, D5
		move.w  D4, D1
		bsr     Calc_VRAM_Pos_2                        ; Offset_0x007794
		move.w  D1, D4
		moveq   #$00, D5
		moveq   #$1F, D6
		move    #$2700, SR
		bsr     Offset_0x00745C
		move    #$2300, SR
		movem.l (A7)+, D4-D6
		addi.w  #$0010, D4
		dbra    D6, Offset_0x007852
		rts
Offset_0x00787E:
		moveq   #$00, D4
		moveq   #$1F, D6
Offset_0x007882:
		movem.l D4-D6, -(A7)
		moveq   #$00, D5
		move.w  D4, D1
		bsr     Calc_VRAM_Pos_2P_D4                    ; Offset_0x00777E
		move.w  D1, D4
		moveq   #$00, D5
		moveq   #$1F, D6
		move    #$2700, SR
		bsr     Offset_0x00746C
		move    #$2300, SR
		movem.l (A7)+, D4-D6
		addi.w  #$0010, D4
		dbra    D6, Offset_0x007882
		rts
;===============================================================================
; Rotina para carregar os tiles da fase a partir da posição do jogador usado 
; <<<-          durante a carga da fase.
;===============================================================================

;===============================================================================
; Carregar os Tiles 16x16, 128x128 e o leiaute das fases    
; ->>>
;===============================================================================  
Main_Level_Load_16_128_Blocks:                                 ; Offset_0x0078AE
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		add.w   D0, D0
		move.w  D0, D1
		add.w   D0, D0
		add.w   D1, D0
		lea     (TilesMainTable), A2                   ; Offset_0x02E708
		lea     $00(A2, D0), A2
		move.l  A2, -(A7)
		addq.w  #$04, A2
		move.l  (A2)+, A0
		bra.s   Main_Level_Load_Blocks_Convert16       ; Offset_0x0078DE 
;-------------------------------------------------------------------------------
; Offset_0x0078D0: ; Left Over do Sonic 1
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		move.w  #$0000, D0
		bsr     EnigmaDec                              ; Offset_0x001932
		bra.s   Offset_0x007902
;-------------------------------------------------------------------------------                
Main_Level_Load_Blocks_Convert16:                              ; Offset_0x0078DE
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		move.w  #$0BFF, D2
Main_Level_Load_16_Blocks_Loop:                                ; Offset_0x0078E6
		move.w  (A0)+, D0
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Main_Level_Load_16_Blocks_Not2p        ; Offset_0x0078FC
		move.w  D0, D1
		andi.w  #$F800, D0
		andi.w  #$07FF, D1
		lsr.w   #$01, D1
		or.w    D1, D0
Main_Level_Load_16_Blocks_Not2p:                               ; Offset_0x0078FC
		move.w  D0, (A1)+
		dbra    D2, Main_Level_Load_16_Blocks_Loop     ; Offset_0x0078E6
Offset_0x007902:
		cmpi.b  #$07, (Level_Id).w                           ; $FFFFFE10
		bne.s   Offset_0x007934
		lea     (Blocks_Mem_Address+$0980).w, A1             ; $FFFF9980
		lea     (Hill_Top_Blocks), A0                  ; Offset_0x08F64E
		move.w  #$03FF, D2
Offset_0x007918:
		move.w  (A0)+, D0
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x00792E
		move.w  D0, D1
		andi.w  #$F800, D0
		andi.w  #$07FF, D1
		lsr.w   #$01, D1
		or.w    D1, D0
Offset_0x00792E:
		move.w  D0, (A1)+
		dbra    D2, Offset_0x007918
Offset_0x007934:
		move.l  (A2)+, A0
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		bsr     KosinskiDec                            ; Offset_0x001AB0
		bra.s   Load_Level_Data                        ; Offset_0x007972  
;-------------------------------------------------------------------------------
; Offset_0x007942:
		bra.s   Offset_0x007962
;-------------------------------------------------------------------------------
; Offset_0x007944:
		moveq   #$00, D1
		moveq   #$00, D2
		move.w  (A0)+, D0
		lea     $00(A0, D0), A1
		lea     (M68K_RAM_Start), A2                         ; $FFFF0000
		lea     (Level_Map_Buffer).w, A3                     ; $FFFF8000
Offset_0x007958:
		bsr     Offset_0x001B50
		tst.w   D0
		bmi.s   Offset_0x007958
		bra.s   Load_Level_Data                        ; Offset_0x007972
Offset_0x007962:
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.w  #$3FFF, D0
Offset_0x00796C:
		move.w  (A0)+, (A1)+
		dbra    D0, Offset_0x00796C
;-------------------------------------------------------------------------------                
Load_Level_Data:                                               ; Offset_0x007972
		bsr     Load_Level_Layout                      ; Offset_0x00799A
		move.l  (A7)+, A2
		addq.w  #$04, A2
		moveq   #$00, D0
		move.b  (A2), D0
		beq.s   Load_Level_Palete                      ; Offset_0x007984
		bsr     LoadPLC                                ; Offset_0x001794    
;-------------------------------------------------------------------------------
Load_Level_Palete:                                             ; Offset_0x007984
		addq.w  #$04, A2
		moveq   #$00, D0
		move.b  (A2), D0
		cmpi.w  #$0C01, (Level_Id).w                         ; $FFFFFE10
		bne.s   Offset_0x007994
		moveq   #$0A, D0
Offset_0x007994:
		bsr     PalLoad1                               ; Offset_0x002914
		rts    
;-------------------------------------------------------------------------------
Load_Level_Layout:                                             ; Offset_0x00799A
		lea     (Level_Map_Buffer).w, A3                     ; $FFFF8000
		move.w  #$03FF, D1
		moveq   #$00, D0
Offset_0x0079A4:
		move.l  D0, (A3)+
		dbra    D1, Offset_0x0079A4
		lea     (Level_Map_Buffer).w, A3                     ; $FFFF8000
		moveq   #$00, D1
		bsr     Interleave_Level_Layout                ; Offset_0x0079BA
		lea     (Level_Map_Bg_Buffer).w, A3                  ; $FFFF8080
		moveq   #$02, D1
Interleave_Level_Layout:                                       ; Offset_0x0079BA
		moveq   #$00, D0
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		ror.b   #$01, D0
		lsr.w   #$05, D0
		add.w   D1, D0
		lea     (Level_Layout), A1                     ; Offset_0x03CA4E
		move.w  $00(A1, D0), D0
		lea     $00(A1, D0.l), A1
		moveq   #$00, D1
		move.w  D1, D2
		move.b  (A1)+, D1
		move.b  (A1)+, D2
		move.l  D1, D5
		addq.l  #$01, D5
		moveq   #$00, D3
		move.w  #$0080, D3
		divu.w  D5, D3
		subq.w  #$01, D3
Offset_0x0079EA:
		move.l  A3, A0
		move.w  D3, D4
Offset_0x0079EE:
		move.l  A1, -(A7)
		move.w  D1, D0
Offset_0x0079F2:
		move.b  (A1)+, (A0)+
		dbra    D0, Offset_0x0079F2
		move.l  (A7)+, A1
		dbra    D4, Offset_0x0079EE
		lea     $00(A1, D5), A1
		lea     $0100(A3), A3
		dbra    D2, Offset_0x0079EA
		rts                
;===============================================================================
; Carregar os Tiles 16x16, 128x128 e o leiaute das fases    
; <<<-
;===============================================================================

; Offset_0x007A0C: ; Não usado
		lea     ($00FE0000), A1
		lea     ($00FE0080), A2
		lea     (M68K_RAM_Start), A3                         ; $FFFF0000
		move.w  #$003F, D1
Offset_0x007A22:
		bsr     Offset_0x007AB4
		bsr     Offset_0x007AB4
		dbra    D1, Offset_0x007A22
		lea     ($00FE0000), A1
		lea     (M68K_RAM_Start&$00FFFFFF), A2               ; $00FF0000
		move.w  #$003F, D1
Offset_0x007A3E:
		move.w  #$0000, (A2)+
		dbra    D1, Offset_0x007A3E
		move.w  #$3FBF, D1
Offset_0x007A4A:
		move.w  (A1)+, (A2)+
		dbra    D1, Offset_0x007A4A
		rts 
;-------------------------------------------------------------------------------   
; Offset_0x007A52: ; Não usado
		lea     ($00FE0000), A1
		lea     (M68K_RAM_Start), A3                         ; $FFFF0000
		moveq   #$1F, D0
Offset_0x007A60:
		move.l  (A1)+, (A3)+
		dbra    D0, Offset_0x007A60
		moveq   #$00, D7
		lea     ($00FE0000), A1
		move.w  #$00FF, D5
Offset_0x007A72:
		lea     (M68K_RAM_Start), A3                         ; $FFFF0000
		move.w  D7, D6
Offset_0x007A7A:
		movem.l A1-A3, -(A7)
		move.w  #$003F, D0
Offset_0x007A82:
		cmpm.w  (A1)+, (A3)+
		bne.s   Offset_0x007A98
		dbra    D0, Offset_0x007A82
		movem.l (A7)+, A1-A3
		adda.w  #$0080, A1
		dbra    D5, Offset_0x007A72
		bra.s   Offset_0x007AB2
Offset_0x007A98:
		movem.l (A7)+, A1-A3
		adda.w  #$0080, A3
		dbra    D6, Offset_0x007A7A
		moveq   #$1F, D0
Offset_0x007AA6:
		move.l  (A1)+, (A3)+
		dbra    D0, Offset_0x007AA6
		addq.l  #$01, D7
		dbra    D5, Offset_0x007A72
Offset_0x007AB2:
		bra.s   Offset_0x007AB2 
;-------------------------------------------------------------------------------
Offset_0x007AB4: ; Referência de rotina não usada
		moveq   #$07, D0
Offset_0x007AB6:
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A1)+
		move.l  (A3)+, (A2)+
		move.l  (A3)+, (A2)+
		move.l  (A3)+, (A2)+
		move.l  (A3)+, (A2)+
		dbra    D0, Offset_0x007AB6
		adda.w  #$0080, A1
		adda.w  #$0080, A2
		rts 
;===============================================================================
; Rotina para defenir os limites da tela e carregar os chefes de fase
; ->>>
;===============================================================================  
Dyn_Screen_Boss_Loader:                                        ; Offset_0x007AD4
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		move.w  DynResize_Index(PC, D0), D0            ; Offset_0x007B3A
		jsr     DynResize_Index(PC, D0)                ; Offset_0x007B3A
		moveq   #$02, D1
		move.w  ($FFFFEEC6).w, D0
		sub.w   ($FFFFEECE).w, D0
		beq.s   Offset_0x007B12
		bcc.s   Offset_0x007B14
		neg.w   D1
		move.w  (Camera_Y).w, D0                             ; $FFFFEE04
		cmp.w   ($FFFFEEC6).w, D0
		bls.s   Offset_0x007B08
		move.w  D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEECE
		andi.w  #$FFFFFFFE, (Sonic_Level_Limits_Max_Y).w         ; $FFFFEECE
Offset_0x007B08:
		add.w   D1, ($FFFFEECE).w
		move.b  #$01, (Vertical_Scroll_Flag).w               ; $FFFFEEDE
Offset_0x007B12:
		rts
Offset_0x007B14:
		move.w  (Camera_Y).w, D0                             ; $FFFFEE04
		addi.w  #$0008, D0
		cmp.w   ($FFFFEECE).w, D0
		bcs.s   Offset_0x007B2E
		btst    #$01, ($FFFFB022).w
		beq.s   Offset_0x007B2E
		add.w   D1, D1
		add.w   D1, D1
Offset_0x007B2E:
		add.w   D1, ($FFFFEECE).w
		move.b  #$01, (Vertical_Scroll_Flag).w               ; $FFFFEEDE
		rts 
;-------------------------------------------------------------------------------
DynResize_Index:                                               ; Offset_0x007B3A
		dc.w    DynResize_GHz-DynResize_Index          ; Offset_0x007B5C
		dc.w    DynResize_Lvl1-DynResize_Index         ; Offset_0x007BE4
		dc.w    DynResize_Wz-DynResize_Index           ; Offset_0x007BE6
		dc.w    DynResize_Lvl3-DynResize_Index         ; Offset_0x007BE8
		dc.w    DynResize_Mz-DynResize_Index           ; Offset_0x007BEA
		dc.w    DynResize_Mz3-DynResize_Index          ; Offset_0x007BEC
		dc.w    DynResize_Lvl6-DynResize_Index         ; Offset_0x007C58
		dc.w    DynResize_HTz-DynResize_Index          ; Offset_0x007C5A
		dc.w    DynResize_HPz-DynResize_Index          ; Offset_0x0082AC
		dc.w    DynResize_Lvl9-DynResize_Index         ; Offset_0x0082AE
		dc.w    DynResize_OOz-DynResize_Index          ; Offset_0x0082B0
		dc.w    DynResize_DHz-DynResize_Index          ; Offset_0x0082B2
		dc.w    DynResize_CNz-DynResize_Index          ; Offset_0x008372
		dc.w    DynResize_CPz-DynResize_Index          ; Offset_0x0083EA
		dc.w    DynResize_GCz-DynResize_Index          ; Offset_0x0083EC
		dc.w    DynResize_NGHz-DynResize_Index         ; Offset_0x0083EE
		dc.w    DynResize_DEz-DynResize_Index          ; Offset_0x008466
;===============================================================================                  
DynResize_GHz:                                                 ; Offset_0x007B5C
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   DynResize_GHz_Act_2                    ; Offset_0x007B64
		rts
;-------------------------------------------------------------------------------  
DynResize_GHz_Act_2:                                           ; Offset_0x007B64
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_GHz_Idx(PC, D0), D0          ; Offset_0x007B72
		jmp     DynResize_GHz_Idx(PC, D0)              ; Offset_0x007B72
;-------------------------------------------------------------------------------  
DynResize_GHz_Idx:                                             ; Offset_0x007B72  
		dc.w    Offset_0x007B78-DynResize_GHz_Idx
		dc.w    Offset_0x007BC2-DynResize_GHz_Idx
		dc.w    Offset_0x007BD6-DynResize_GHz_Idx
;-------------------------------------------------------------------------------                
Offset_0x007B78:
		cmpi.w  #$26E0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007BC0
		move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE00, $FFFFEEC8
		move.w  #$0390, ($FFFFEEC6).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x007BAC
		move.b  #$56, (A1)        ; Carrega o objeto 0x56 - Chefe da GHz
		move.b  #$81, Obj_Subtype(A1)                            ; $0028
		move.w  #$29D0, Obj_X(A1)                                ; $0008
		move.w  #$0426, Obj_Y(A1)                                ; $000C
Offset_0x007BAC:
		move.w  #$008E, D0
		bsr     Play_Music                             ; Offset_0x00150C
		move.b  #$02, (Boss_Flag).w                          ; $FFFFF7AA
		moveq   #$29, D0
		bra     LoadPLC                                ; Offset_0x001794
Offset_0x007BC0:
		rts
;-------------------------------------------------------------------------------                 
Offset_0x007BC2:
		cmpi.w  #$2880, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007BD4
		move.w  #$2880, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x007BD4:
		rts
;-------------------------------------------------------------------------------                 
Offset_0x007BD6:
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		beq.s   Offset_0x007BE0
		bsr     Load_Level_Results                     ; Offset_0x00F1F6
Offset_0x007BE0:
		rts         
;===============================================================================
		rts
;===============================================================================
DynResize_Lvl1:                                                ; Offset_0x007BE4   
		rts  
;===============================================================================
DynResize_Wz:                                                  ; Offset_0x007BE6  
		rts  
;===============================================================================
DynResize_Lvl3:                                                ; Offset_0x007BE8  
		rts  
;===============================================================================
DynResize_Mz:                                                  ; Offset_0x007BEA  
		rts  
;===============================================================================
DynResize_Mz3:                                                 ; Offset_0x007BEC  
		rts   
; Offset_0x007BEE:
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_Mz3_Idx(PC, D0), D0          ; Offset_0x007BFC
		jmp     DynResize_Mz3_Idx(PC, D0)              ; Offset_0x007BFC  
;-------------------------------------------------------------------------------
DynResize_Mz3_Idx:                                             ; Offset_0x007BFC
		dc.w    Offset_0x007C02-DynResize_Mz3_Idx
		dc.w    Offset_0x007C32-DynResize_Mz3_Idx
		dc.w    Offset_0x007C4C-DynResize_Mz3_Idx    
;-------------------------------------------------------------------------------
Offset_0x007C02:
		cmpi.w  #$2800, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007C30
		move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE00, $FFFFEEC8
		move.w  #$0400, ($FFFFEEC6).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x007C24
		move.b  #$54, (A1)         ; Carrega o objeto 0x54 - Chefe da Mz
Offset_0x007C24:
		move.b  #$07, (Boss_Flag).w                          ; $FFFFF7AA
		moveq   #$2E, D0
		bra     LoadPLC                                ; Offset_0x001794
Offset_0x007C30:
		rts      
;-------------------------------------------------------------------------------
Offset_0x007C32:
		cmpi.w  #$2980, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007C4A
		move.w  #$2980, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
		move.w  #$2980, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x007C4A:
		rts               
;-------------------------------------------------------------------------------
Offset_0x007C4C:
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		beq.s   Offset_0x007C56
		bsr     Load_Level_Results                     ; Offset_0x00F1F6
Offset_0x007C56:
		rts
;===============================================================================
DynResize_Lvl6:                                                ; Offset_0x007C58 
		rts
;===============================================================================
DynResize_HTz:                                                 ; Offset_0x007C5A  
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne     DynResize_HTz_Act_2                    ; Offset_0x007EBE
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_HTz_Act_1_Idx(PC, D0), D0    ; Offset_0x007C70
		jmp     DynResize_HTz_Act_1_Idx(PC, D0)        ; Offset_0x007C70
;------------------------------------------------------------------------------- 
DynResize_HTz_Act_1_Idx:                                       ; Offset_0x007C70
		dc.w    Offset_0x007C76-DynResize_HTz_Act_1_Idx
		dc.w    Offset_0x007CE2-DynResize_HTz_Act_1_Idx
		dc.w    Offset_0x007DE8-DynResize_HTz_Act_1_Idx     
;-------------------------------------------------------------------------------
Offset_0x007C76:
		cmpi.w  #$0400, (Camera_Y).w                         ; $FFFFEE04
		bcs.s   Offset_0x007CBE
		cmpi.w  #$1800, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007CBE
		move.b  #$01, ($FFFFEEBC).w
		move.l  (Camera_X).w, (Camera_X_x2).w     ; $FFFFEE00, $FFFFEE08
		move.l  (Camera_Y).w, (Camera_Y_x4).w     ; $FFFFEE04, $FFFFEE0C
		moveq   #$00, D0
		move.w  D0, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D0, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		move.w  D0, ($FFFFEEE2).w
		move.w  #$0140, ($FFFFEEE4).w
		subi.w  #$0100, ($FFFFEE0C).w
		move.w  #$0000, ($FFFFEEE6).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x007CBC:
		rts
Offset_0x007CBE:
		tst.b   ($FFFFEEBC).w
		beq.s   Offset_0x007CBC
		move.w  #$0200, D0
		moveq   #$00, D1
		move.w  D1, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D1, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		bsr     Offset_0x007E4C
		or.w    D0, D1
		bne.s   Offset_0x007CBC
		move.b  #$00, ($FFFFEEBC).w
		rts                        
;-------------------------------------------------------------------------------
Offset_0x007CE2:
		cmpi.w  #$1978, (Camera_X).w                         ; $FFFFEE00
		bcs     Offset_0x007D74
		cmpi.w  #$1E00, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007CFC
		move.b  #$00, ($FFFFEEBD).w
		bra.s   Offset_0x007D74
Offset_0x007CFC:
		tst.b   ($FFFFEEE8).w
		bne.s   Offset_0x007D2C
		cmpi.w  #$0140, ($FFFFEEE4).w
		beq.s   Offset_0x007D56
		move.w  ($FFFFFE04).w, D0
		move.w  D0, D1
		andi.w  #$0003, D0
		bne.s   Offset_0x007D74
		addq.w  #$01, ($FFFFEEE4).w
		andi.w  #$003F, D1
		bne.s   Offset_0x007D74
		move.w  #$00E1, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		bra.s   Offset_0x007D74
Offset_0x007D2C:
		cmpi.w  #$00E0, ($FFFFEEE4).w
		beq.s   Offset_0x007D56
		move.w  ($FFFFFE04).w, D0
		move.w  D0, D1
		andi.w  #$0003, D0
		bne.s   Offset_0x007D74
		subq.w  #$01, ($FFFFEEE4).w
		andi.w  #$003F, D1
		bne.s   Offset_0x007D74
		move.w  #$00E1, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		bra.s   Offset_0x007D74
Offset_0x007D56:
		move.b  #$00, ($FFFFEEBD).w
		subq.w  #$01, ($FFFFEEE6).w
		bpl.s   Offset_0x007D74
		move.w  #$0078, ($FFFFEEE6).w
		eori.b  #$01, ($FFFFEEE8).w
		move.b  #$01, ($FFFFEEBD).w
Offset_0x007D74:
		cmpi.w  #$1800, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007D9C
		cmpi.w  #$1F00, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x007DC2
		move.w  (Horizontal_Scrolling).w, (Horizontal_Scrolling_Sub).w ; $FFFFEEB0, $FFFFEEB4
		move.w  (Vertical_Scrolling).w, (Vertical_Scrolling_Sub).w ; $FFFFEEB2, $FFFFEEB6
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		move.w  (Camera_Y).w, D1                             ; $FFFFEE04
		bra     Offset_0x007E4C
Offset_0x007D9C:
		move.l  #$04000000, (Camera_X_x2).w                  ; $FFFFEE08
		moveq   #$00, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, ($FFFFEEE2).w
		move.b  D0, ($FFFFEEE8).w
		subq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.w  #$00F8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		rts
Offset_0x007DC2:
		move.l  #$04000000, (Camera_X_x2).w                  ; $FFFFEE08
		moveq   #$00, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, ($FFFFEEE2).w
		move.b  D0, ($FFFFEEE8).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.w  #$00F8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		rts           
;-------------------------------------------------------------------------------
Offset_0x007DE8:
		cmpi.w  #$1F00, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x007E28
		move.b  #$01, ($FFFFEEBC).w
		move.l  (Camera_X).w, (Camera_X_x2).w     ; $FFFFEE00, $FFFFEE08
		move.l  (Camera_Y).w, (Camera_Y_x4).w     ; $FFFFEE04, $FFFFEE0C
		moveq   #$00, D0
		move.w  D0, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D0, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		move.w  D0, ($FFFFEEE2).w
		move.w  #$0140, ($FFFFEEE4).w
		subi.w  #$0100, ($FFFFEE0C).w
		move.w  #$0000, ($FFFFEEE6).w
		subq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x007E26:
		rts
Offset_0x007E28:
		tst.b   ($FFFFEEBC).w
		beq.s   Offset_0x007E26
		move.w  #$0200, D0
		moveq   #$00, D1
		move.w  D1, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D1, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		bsr     Offset_0x007E4C
		or.w    D0, D1
		bne.s   Offset_0x007E26
		move.b  #$00, ($FFFFEEBC).w
		rts
Offset_0x007E4C:
		sub.w   ($FFFFEE08).w, D0
		sub.w   ($FFFFEEE2).w, D0
		bpl.s   Offset_0x007E62
		cmpi.w  #$FFF0, D0
		bgt.s   Offset_0x007E60
		move.w  #$FFF0, D0
Offset_0x007E60:
		bra.s   Offset_0x007E6C
Offset_0x007E62:
		cmpi.w  #$0010, D0
		bcs.s   Offset_0x007E6C
		move.w  #$0010, D0
Offset_0x007E6C:
		move.b  D0, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		sub.w   ($FFFFEE0C).w, D1
		sub.w   ($FFFFEEE4).w, D1
		bpl.s   Offset_0x007E86
		cmpi.w  #$FFF0, D1
		bgt.s   Offset_0x007E84
		move.w  #$FFF0, D1
Offset_0x007E84:
		bra.s   Offset_0x007E90
Offset_0x007E86:
		cmpi.w  #$0010, D1
		bcs.s   Offset_0x007E90
		move.w  #$0010, D1
Offset_0x007E90:
		move.b  D1, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		rts   
;-------------------------------------------------------------------------------
; Offset_0x007E96: ; Não usado
		btst    #$00, ($FFFFF606).w
		beq.s   Offset_0x007EA8
		tst.w   ($FFFFEEE4).w
		beq.s   Offset_0x007EA8
		subq.w  #$01, ($FFFFEEE4).w
Offset_0x007EA8:
		btst    #$01, ($FFFFF606).w
		beq.s   Offset_0x007EBC
		cmpi.w  #$0700, ($FFFFEEE4).w
		beq.s   Offset_0x007EBC
		addq.w  #$01, ($FFFFEEE4).w
Offset_0x007EBC:
		rts    
;-------------------------------------------------------------------------------
DynResize_HTz_Act_2:                                           ; Offset_0x007EBE
		bsr     Offset_0x008238
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_HTz_Act_2_Idx(PC, D0), D0    ; Offset_0x007ED0
		jmp     DynResize_HTz_Act_2_Idx(PC, D0)        ; Offset_0x007ED0
;-------------------------------------------------------------------------------
DynResize_HTz_Act_2_Idx:                                       ; Offset_0x007ED0
		dc.w    Offset_0x007EE0-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x007F62-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x008068-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x0080CC-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x0081CA-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x008256-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x008286-DynResize_HTz_Act_2_Idx
		dc.w    Offset_0x0082A0-DynResize_HTz_Act_2_Idx 
;-------------------------------------------------------------------------------
Offset_0x007EE0:
		cmpi.w  #$14C0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007F3E
		move.b  #$01, ($FFFFEEBC).w
		move.l  (Camera_X).w, (Camera_X_x2).w     ; $FFFFEE00, $FFFFEE08
		move.l  (Camera_Y).w, (Camera_Y_x4).w     ; $FFFFEE04, $FFFFEE0C
		moveq   #$00, D0
		move.w  D0, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D0, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		move.w  D0, ($FFFFEEE2).w
		move.w  #$02C0, ($FFFFEEE4).w
		subi.w  #$0100, ($FFFFEE0C).w
		move.w  #$0000, ($FFFFEEE6).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		cmpi.w  #$0380, (Camera_Y).w                         ; $FFFFEE04
		bcs.s   Offset_0x007F3C
		move.w  #$F980, ($FFFFEEE2).w
		addi.w  #$0480, ($FFFFEE08).w
		move.w  #$0300, ($FFFFEEE4).w
		addq.b  #$06, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x007F3C:
		rts
Offset_0x007F3E:
		tst.b   ($FFFFEEBC).w
		beq.s   Offset_0x007F3C
		move.w  #$0200, D0
		moveq   #$00, D1
		move.w  D1, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D1, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		bsr     Offset_0x007E4C
		or.w    D0, D1
		bne.s   Offset_0x007F3C
		move.b  #$00, ($FFFFEEBC).w
		rts       
;-------------------------------------------------------------------------------
Offset_0x007F62:
		cmpi.w  #$1678, (Camera_X).w                         ; $FFFFEE00
		bcs     Offset_0x007FF4
		cmpi.w  #$1A00, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x007F7C
		move.b  #$00, ($FFFFEEBD).w
		bra.s   Offset_0x007FF4
Offset_0x007F7C:
		tst.b   ($FFFFEEE8).w
		bne.s   Offset_0x007FAC
		cmpi.w  #$02C0, ($FFFFEEE4).w
		beq.s   Offset_0x007FD6
		move.w  ($FFFFFE04).w, D0
		move.w  D0, D1
		andi.w  #$0003, D0
		bne.s   Offset_0x007FF4
		addq.w  #$01, ($FFFFEEE4).w
		andi.w  #$003F, D1
		bne.s   Offset_0x007FF4
		move.w  #$00E1, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		bra.s   Offset_0x007FF4
Offset_0x007FAC:
		cmpi.w  #$0000, ($FFFFEEE4).w
		beq.s   Offset_0x007FD6
		move.w  ($FFFFFE04).w, D0
		move.w  D0, D1
		andi.w  #$0003, D0
		bne.s   Offset_0x007FF4
		subq.w  #$01, ($FFFFEEE4).w
		andi.w  #$003F, D1
		bne.s   Offset_0x007FF4
		move.w  #$00E1, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		bra.s   Offset_0x007FF4
Offset_0x007FD6:
		move.b  #$00, ($FFFFEEBD).w
		subq.w  #$01, ($FFFFEEE6).w
		bpl.s   Offset_0x007FF4
		move.w  #$0078, ($FFFFEEE6).w
		eori.b  #$01, ($FFFFEEE8).w
		move.b  #$01, ($FFFFEEBD).w
Offset_0x007FF4:
		cmpi.w  #$14C0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x00801C
		cmpi.w  #$1B00, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x008042
		move.w  (Horizontal_Scrolling).w, (Horizontal_Scrolling_Sub).w ; $FFFFEEB0, $FFFFEEB4
		move.w  (Vertical_Scrolling).w, (Vertical_Scrolling_Sub).w ; $FFFFEEB2, $FFFFEEB6
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		move.w  (Camera_Y).w, D1                             ; $FFFFEE04
		bra     Offset_0x007E4C
Offset_0x00801C:
		move.l  #$04000000, (Camera_X_x2).w                  ; $FFFFEE08
		moveq   #$00, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, ($FFFFEEE2).w
		move.b  D0, ($FFFFEEE8).w
		subq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.w  #$00F8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		rts
Offset_0x008042:
		move.l  #$04000000, (Camera_X_x2).w                  ; $FFFFEE08
		moveq   #$00, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, ($FFFFEEE2).w
		move.b  D0, ($FFFFEEE8).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.w  #$00F8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		rts 
;-------------------------------------------------------------------------------
Offset_0x008068:
		cmpi.w  #$1B00, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x0080A8
		move.b  #$01, ($FFFFEEBC).w
		move.l  (Camera_X).w, (Camera_X_x2).w     ; $FFFFEE00, $FFFFEE08
		move.l  (Camera_Y).w, (Camera_Y_x4).w     ; $FFFFEE04, $FFFFEE0C
		moveq   #$00, D0
		move.w  D0, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D0, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		move.w  D0, ($FFFFEEE2).w
		move.w  #$02C0, ($FFFFEEE4).w
		subi.w  #$0100, ($FFFFEE0C).w
		move.w  #$0000, ($FFFFEEE6).w
		subq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x0080A6:
		rts
Offset_0x0080A8:
		tst.b   ($FFFFEEBC).w
		beq.s   Offset_0x0080A6
		move.w  #$0200, D0
		moveq   #$00, D1
		move.w  D1, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D1, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		bsr     Offset_0x007E4C
		or.w    D0, D1
		bne.s   Offset_0x0080A6
		move.b  #$00, ($FFFFEEBC).w
		rts     
;-------------------------------------------------------------------------------
Offset_0x0080CC:
		cmpi.w  #$15F0, (Camera_X).w                         ; $FFFFEE00
		bcs     Offset_0x008156
		cmpi.w  #$1AC0, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x008156
		tst.b   ($FFFFEEE8).w
		bne.s   Offset_0x00810E
		cmpi.w  #$0300, ($FFFFEEE4).w
		beq.s   Offset_0x008138
		move.w  ($FFFFFE04).w, D0
		move.w  D0, D1
		andi.w  #$0003, D0
		bne.s   Offset_0x008156
		addq.w  #$01, ($FFFFEEE4).w
		andi.w  #$003F, D1
		bne.s   Offset_0x008156
		move.w  #$00E1, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		bra.s   Offset_0x008156
Offset_0x00810E:
		cmpi.w  #$0000, ($FFFFEEE4).w
		beq.s   Offset_0x008138
		move.w  ($FFFFFE04).w, D0
		move.w  D0, D1
		andi.w  #$0003, D0
		bne.s   Offset_0x008156
		subq.w  #$01, ($FFFFEEE4).w
		andi.w  #$003F, D1
		bne.s   Offset_0x008156
		move.w  #$00E1, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		bra.s   Offset_0x008156
Offset_0x008138:
		move.b  #$00, ($FFFFEEBD).w
		subq.w  #$01, ($FFFFEEE6).w
		bpl.s   Offset_0x008156
		move.w  #$0078, ($FFFFEEE6).w
		eori.b  #$01, ($FFFFEEE8).w
		move.b  #$01, ($FFFFEEBD).w
Offset_0x008156:
		cmpi.w  #$14C0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x00817E
		cmpi.w  #$1B00, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x0081A4
		move.w  (Horizontal_Scrolling).w, (Horizontal_Scrolling_Sub).w ; $FFFFEEB0, $FFFFEEB4
		move.w  (Vertical_Scrolling).w, (Vertical_Scrolling_Sub).w ; $FFFFEEB2, $FFFFEEB6
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		move.w  (Camera_Y).w, D1                             ; $FFFFEE04
		bra     Offset_0x007E4C
Offset_0x00817E:
		move.l  #$04000000, (Camera_X_x2).w                  ; $FFFFEE08
		moveq   #$00, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, ($FFFFEEE2).w
		move.b  D0, ($FFFFEEE8).w
		subq.b  #$06, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.w  #$00F8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		rts
Offset_0x0081A4:
		move.l  #$04000000, (Camera_X_x2).w                  ; $FFFFEE08
		moveq   #$00, D0
		move.l  D0, (Camera_Y_x4).w                          ; $FFFFEE0C
		move.l  D0, ($FFFFEEE2).w
		move.b  D0, ($FFFFEEE8).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.w  #$00F8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
		rts      
;-------------------------------------------------------------------------------
Offset_0x0081CA:
		cmpi.w  #$1B00, (Camera_X).w                         ; $FFFFEE00
		bcc.s   Offset_0x008212
		move.b  #$01, ($FFFFEEBC).w
		move.l  (Camera_X).w, (Camera_X_x2).w     ; $FFFFEE00, $FFFFEE08
		move.l  (Camera_Y).w, (Camera_Y_x4).w     ; $FFFFEE04, $FFFFEE0C
		moveq   #$00, D0
		move.w  D0, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D0, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		move.w  #$F980, ($FFFFEEE2).w
		addi.w  #$0480, ($FFFFEE08).w
		move.w  #$0300, ($FFFFEEE4).w
		subi.w  #$0100, ($FFFFEE0C).w
		move.w  #$0000, ($FFFFEEE6).w
		subq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x008210:
		rts
Offset_0x008212:
		tst.b   ($FFFFEEBC).w
		beq.s   Offset_0x008210
		move.w  #$0200, D0
		moveq   #$00, D1
		move.w  D1, (Horizontal_Scrolling_Sub).w             ; $FFFFEEB4
		move.w  D1, (Vertical_Scrolling_Sub).w               ; $FFFFEEB6
		bsr     Offset_0x007E4C
		or.w    D0, D1
		bne.s   Offset_0x008210
		move.b  #$00, ($FFFFEEBC).w
		rts            
;-------------------------------------------------------------------------------    
		rts          
;-------------------------------------------------------------------------------
Offset_0x008238:
		cmpi.w  #$2B00, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x008254
		cmpi.b  #$0A, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bge.s   Offset_0x008254
		move.b  #$0A, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		move.b  #$00, ($FFFFEEBC).w
Offset_0x008254:
		rts                                                             
;------------------------------------------------------------------------------- 
Offset_0x008256:
		cmpi.w  #$2B80, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x008284
		move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE00, $FFFFEEC8
		move.w  #$04A0, ($FFFFEEC6).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x008278
		move.b  #$52, (A1)        ; Carrega o objeto 0x52 - Chefe da HTz
Offset_0x008278:
		move.b  #$03, (Boss_Flag).w                          ; $FFFFF7AA
		moveq   #$2A, D0
		bra     LoadPLC                                ; Offset_0x001794
Offset_0x008284:
		rts             
;-------------------------------------------------------------------------------    
Offset_0x008286:
		cmpi.w  #$2E80, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x00829E
		move.w  #$3040, ($FFFFEEC2).w
		move.w  #$2E80, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x00829E:
		rts                
;-------------------------------------------------------------------------------
Offset_0x0082A0:
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		beq.s   Offset_0x0082AA
		bsr     Load_Level_Results                     ; Offset_0x00F1F6
Offset_0x0082AA:
		rts 
;===============================================================================
DynResize_HPz:                                                 ; Offset_0x0082AC   
		rts 
;===============================================================================
DynResize_Lvl9:                                                ; Offset_0x0082AE  
		rts   
;===============================================================================
DynResize_OOz:                                                 ; Offset_0x0082B0 
		rts   
;===============================================================================
DynResize_DHz:                                                 ; Offset_0x0082B2  
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   DynResize_DHz_Act_2                    ; Offset_0x0082BA
		rts
;------------------------------------------------------------------------------- 
DynResize_DHz_Act_2:                                           ; Offset_0x0082BA:
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_DHz_Idx(PC, D0), D0          ; Offset_0x0082C8
		jmp     DynResize_DHz_Idx(PC, D0)              ; Offset_0x0082C8
;------------------------------------------------------------------------------- 
DynResize_DHz_Idx:                                             ; Offset_0x0082C8
		dc.w    Offset_0x0082CE-DynResize_DHz_Idx
		dc.w    Offset_0x008338-DynResize_DHz_Idx
		dc.w    Offset_0x008366-DynResize_DHz_Idx    
;-------------------------------------------------------------------------------
Offset_0x0082CE:
		cmpi.w  #$05C0, (Camera_Y).w                         ; $FFFFEE04
		bcs.s   Offset_0x008336
		cmpi.w  #$1C00, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x008336
		move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE00, $FFFFEEC8
		move.w  #$0600, ($FFFFEEC6).w
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x0082F8
		move.b  #$57, (A1)        ; Carrega o objeto 0x57 - Chefe da DHz
Offset_0x0082F8:
		move.l  #$6C000002, (VDP_Control_Port)               ; $00C00004
		lea     (VDP_Data_Port), A6                          ; $00C00000
		lea     (Art_DHz_Boss_Rocks), A2               ; Offset_0x088F8C
		moveq   #$03, D0
Offset_0x008310:
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		move.l  (A2)+, (A6)
		dbra    D0, Offset_0x008310
		move.b  #$05, (Boss_Flag).w                          ; $FFFFF7AA
		moveq   #$2C, D0
		bsr     LoadPLC                                ; Offset_0x001794
		moveq   #$19, D0
		bsr     PalLoad2                               ; Offset_0x002930
Offset_0x008336:
		rts       
;-------------------------------------------------------------------------------
Offset_0x008338:
		cmpi.w  #$20F0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x008350
		move.w  #$20F0, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
		move.w  #$20F0, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x008350:
		subi.w  #$0001, ($FFFFEEC6).w
		cmpi.w  #$05E0, ($FFFFEEC6).w
		bcc.s   Offset_0x008364
		move.w  #$05E0, ($FFFFEEC6).w
Offset_0x008364:
		rts     
;-------------------------------------------------------------------------------
Offset_0x008366:
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		beq.s   Offset_0x008370
		bsr     Load_Level_Results                     ; Offset_0x00F1F6
Offset_0x008370:
		rts            
;===============================================================================
DynResize_CNz:                                                 ; Offset_0x008372  
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   DynResize_CNz_Act_2                    ; Offset_0x00837A
		rts
;------------------------------------------------------------------------------- 
DynResize_CNz_Act_2:                                           ; Offset_0x00837A
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_CNz_Idx(PC, D0), D0          ; Offset_0x008388
		jmp     DynResize_CNz_Idx(PC, D0)              ; Offset_0x008388
;------------------------------------------------------------------------------- 
DynResize_CNz_Idx:                                             ; Offset_0x008388  
		dc.w    Offset_0x00838E-DynResize_CNz_Idx
		dc.w    Offset_0x0083C4-DynResize_CNz_Idx
		dc.w    Offset_0x0083DE-DynResize_CNz_Idx                          
;-------------------------------------------------------------------------------
Offset_0x00838E:
		cmpi.w  #$2400, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x0083C2
		move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE00, $FFFFEEC8
		move.w  #$05C0, ($FFFFEEC6).w
		move.w  #$05C0, (Sonic_Level_Limits_Max_Y).w         ; $FFFFEECE
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x0083B6
		move.b  #$51, (A1)        ; Carrega o objeto 0x51 - Chefe da CNz
Offset_0x0083B6:
		move.b  #$06, (Boss_Flag).w                          ; $FFFFF7AA
		moveq   #$2D, D0
		bra     LoadPLC                                ; Offset_0x001794
Offset_0x0083C2:
		rts
;-------------------------------------------------------------------------------                
Offset_0x0083C4:
		cmpi.w  #$2700, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x0083DC
		move.w  #$2748, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
		move.w  #$2700, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x0083DC:
		rts
;-------------------------------------------------------------------------------                
Offset_0x0083DE:
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		beq.s   Offset_0x0083E8
		bsr     Load_Level_Results                     ; Offset_0x00F1F6
Offset_0x0083E8:
		rts
;===============================================================================
DynResize_CPz:                                                 ; Offset_0x0083EA 
		rts
;=============================================================================== 
DynResize_GCz:                                                 ; Offset_0x0083EC
		rts
;===============================================================================  
DynResize_NGHz:                                                ; Offset_0x0083EE 
		tst.b   (Act_Id).w                                   ; $FFFFFE11
		bne.s   DynResize_NGHz_Act_2                   ; Offset_0x0083F6
		rts
;------------------------------------------------------------------------------- 
DynResize_NGHz_Act_2:                                          ; Offset_0x0083F6
		moveq   #$00, D0
		move.b  (Dyn_Resize_Routine).w, D0                   ; $FFFFEEDF
		move.w  DynResize_NGHz_Idx(PC, D0), D0         ; Offset_0x008404
		jmp     DynResize_NGHz_Idx(PC, D0)             ; Offset_0x008404
;-------------------------------------------------------------------------------   
DynResize_NGHz_Idx:                                            ; Offset_0x008404 
		dc.w    Offset_0x00840A-DynResize_NGHz_Idx
		dc.w    Offset_0x008440-DynResize_NGHz_Idx
		dc.w    Offset_0x00845A-DynResize_NGHz_Idx  
;-------------------------------------------------------------------------------
Offset_0x00840A:
		cmpi.w  #$28A0, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x00843E
		move.w  (Camera_X).w, (Sonic_Level_Limits_Min_X).w ; $FFFFEE00, $FFFFEEC8
		move.w  #$0400, ($FFFFEEC6).w
		move.w  #$0400, (Sonic_Level_Limits_Max_Y).w         ; $FFFFEECE
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x008432
		move.b  #$89, (A1)       ; Carrega o objeto 0x89 - Chefe da NGHz
Offset_0x008432:
		move.b  #$04, (Boss_Flag).w                          ; $FFFFF7AA
		moveq   #$2B, D0
		bra     LoadPLC                                ; Offset_0x001794
Offset_0x00843E:
		rts          
;-------------------------------------------------------------------------------
Offset_0x008440:
		cmpi.w  #$2A40, (Camera_X).w                         ; $FFFFEE00
		bcs.s   Offset_0x008458
		move.w  #$2A40, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
		move.w  #$2A40, (Sonic_Level_Limits_Min_X).w         ; $FFFFEEC8
		addq.b  #$02, (Dyn_Resize_Routine).w                 ; $FFFFEEDF
Offset_0x008458:
		rts 
;-------------------------------------------------------------------------------
Offset_0x00845A:
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		beq.s   Offset_0x008464
		bsr     Load_Level_Results                     ; Offset_0x00F1F6
Offset_0x008464:
		rts             
;=============================================================================== 
DynResize_DEz:                                                 ; Offset_0x008466  
		rts     
;===============================================================================
; Rotina para defenir os limites da tela e carregar os chefes de fase
; <<<-
;===============================================================================  

Obj_0x11_Bridge:                                               ; Offset_0x008468
		include 'objects/obj_0x11.asm'    
Obj_0x15_Bridge:                                               ; Offset_0x008A84
		include 'objects/obj_0x15.asm'      
Jmp_00_To_Object_HitWall_Right:                                ; Offset_0x00903C
;-------------------------------------------------------------------------------
		jmp     (Object_HitWall_Right)                 ; Offset_0x01430A  
		dc.w    $0000
;-------------------------------------------------------------------------------
Obj_0x17_Log_Spikes:                                           ; Offset_0x009044
		include 'objects/obj_0x17.asm'                                         
;------------------------------------------------------------------------------- 
		nop                                      
;------------------------------------------------------------------------------- 
Obj_0x18_Platforms:                                            ; Offset_0x0091E0
		include 'objects/obj_0x18.asm'               
;------------------------------------------------------------------------------- 
		nop                                 
;-------------------------------------------------------------------------------
Obj_0x1A_Collapsing_Platforms:                                 ; Offset_0x0095DC
		include 'objects/obj_0x1A.asm'                    
Obj_0x1F_Collapsing_Platforms:                                 ; Offset_0x009728
		include 'objects/obj_0x1F.asm'   
;------------------------------------------------------------------------------- 
Collapsing_Platforms_Data:                                     ; Offset_0x009912
		dc.b    $1C, $18, $14, $10, $1A, $16, $12, $0E
		dc.b    $0A, $06, $18, $14, $10, $0C, $08, $04
		dc.b    $16, $12, $0E, $0A, $06, $02, $14, $10
		dc.b    $0C    
;-------------------------------------------------------------------------------
HPz_Collapsing_Platforms_Data:                                 ; Offset_0x00992B
		dc.b    $18, $1C, $20, $1E, $1A, $16, $06, $0E
		dc.b    $14, $12, $0A, $02  
;-------------------------------------------------------------------------------
Collapsing_Platforms_2_Data:                                   ; Offset_0x009937
		dc.b    $1E, $16, $0E, $06, $1A, $12, $0A, $02             
;-------------------------------------------------------------------------------
Collapsing_Platforms_2_Data_2:                                 ; Offset_0x00993F
		dc.b    $16, $1E, $1A, $12, $06, $0E, $0A, $02  
;-------------------------------------------------------------------------------
OOz_Collapsing_Platforms_Data:                                 ; Offset_0x009947
		dc.b    $1A, $12, $0A, $02, $16, $0E, $06          
;-------------------------------------------------------------------------------
DHz_Collapsing_Platforms_Data:                                 ; Offset_0x00994E
		dc.b    $1A, $16, $12, $0E, $0A, $02    
;-------------------------------------------------------------------------------
NGHz_Collapsing_Platforms_Data:                                ; Offset_0x009954
		dc.b    $16, $1A, $18, $12, $06, $0E, $0A, $02  
;-------------------------------------------------------------------------------
Offset_0x00995C:
		dc.b    $20, $20, $20, $20, $20, $20, $20, $20
		dc.b    $21, $21, $22, $22, $23, $23, $24, $24
		dc.b    $25, $25, $26, $26, $27, $27, $28, $28
		dc.b    $29, $29, $2A, $2A, $2B, $2B, $2C, $2C
		dc.b    $2D, $2D, $2E, $2E, $2F, $2F, $30, $30
		dc.b    $30, $30, $30, $30, $30, $30, $30, $30  
;-------------------------------------------------------------------------------   
Collapsing_Platforms_Mappings:                                 ; Offset_0x00998C
		dc.w    Offset_0x009994-Collapsing_Platforms_Mappings
		dc.w    Offset_0x009A16-Collapsing_Platforms_Mappings
		dc.w    Offset_0x009A98-Collapsing_Platforms_Mappings
		dc.w    Offset_0x009B62-Collapsing_Platforms_Mappings
Offset_0x009994:
		dc.w    $0010
		dc.l    $C80E0057, $002B0010
		dc.l    $D00D0063, $0031FFF0
		dc.l    $E00D006B, $00350010
		dc.l    $E00D0073, $0039FFF0
		dc.l    $D806007B, $003DFFE0
		dc.l    $D8060081, $0040FFD0
		dc.l    $F00D0087, $00430010
		dc.l    $F00D008F, $0047FFF0
		dc.l    $F0050097, $004BFFE0
		dc.l    $F005009B, $004DFFD0
		dc.l    $000D009F, $004F0010
		dc.l    $000500A7, $00530000
		dc.l    $000D00AB, $0055FFE0
		dc.l    $000500B3, $0059FFD0
		dc.l    $100D00AB, $00550010
		dc.l    $100500B7, $005B0000
Offset_0x009A16:
		dc.w    $0010
		dc.l    $C80E0057, $002B0010
		dc.l    $D00D0063, $0031FFF0
		dc.l    $E00D006B, $00350010
		dc.l    $E00D0073, $0039FFF0
		dc.l    $D806007B, $003DFFE0
		dc.l    $D80600BB, $005DFFD0
		dc.l    $F00D0087, $00430010
		dc.l    $F00D008F, $0047FFF0
		dc.l    $F0050097, $004BFFE0
		dc.l    $F00500C1, $0060FFD0
		dc.l    $000D009F, $004F0010
		dc.l    $000500A7, $00530000
		dc.l    $000D00AB, $0055FFE0
		dc.l    $000500B7, $005BFFD0
		dc.l    $100D00AB, $00550010
		dc.l    $100500B7, $005B0000
Offset_0x009A98:
		dc.w    $0019
		dc.l    $C806005D, $002E0020
		dc.l    $C8060057, $002B0010
		dc.l    $D0050067, $00330000
		dc.l    $D0050063, $0031FFF0
		dc.l    $E005006F, $00370020
		dc.l    $E005006B, $00350010
		dc.l    $E0050077, $003B0000
		dc.l    $E0050073, $0039FFF0
		dc.l    $D806007B, $003DFFE0
		dc.l    $D8060081, $0040FFD0
		dc.l    $F005008B, $00450020
		dc.l    $F0050087, $00430010
		dc.l    $F0050093, $00490000
		dc.l    $F005008F, $0047FFF0
		dc.l    $F0050097, $004BFFE0
		dc.l    $F005009B, $004DFFD0
		dc.l    $0005008B, $00450020
		dc.l    $0005008B, $00450010
		dc.l    $000500A7, $00530000
		dc.l    $000500AB, $0055FFF0
		dc.l    $000500AB, $0055FFE0
		dc.l    $000500B3, $0059FFD0
		dc.l    $100500AB, $00550020
		dc.l    $100500AB, $00550010
		dc.l    $100500B7, $005B0000
Offset_0x009B62:
		dc.w    $0019
		dc.l    $C806005D, $002E0020
		dc.l    $C8060057, $002B0010
		dc.l    $D0050067, $00330000
		dc.l    $D0050063, $0031FFF0
		dc.l    $E005006F, $00370020
		dc.l    $E005006B, $00350010
		dc.l    $E0050077, $003B0000
		dc.l    $E0050073, $0039FFF0
		dc.l    $D806007B, $003DFFE0
		dc.l    $D80600BB, $005DFFD0
		dc.l    $F005008B, $00450020
		dc.l    $F0050087, $00430010
		dc.l    $F0050093, $00490000
		dc.l    $F005008F, $0047FFF0
		dc.l    $F0050097, $004BFFE0
		dc.l    $F00500C1, $0060FFD0
		dc.l    $0005008B, $00450020
		dc.l    $0005008B, $00450010
		dc.l    $000500A7, $00530000
		dc.l    $000500AB, $0055FFF0
		dc.l    $000500AB, $0055FFE0
		dc.l    $000500B7, $005BFFD0
		dc.l    $100500AB, $00550020
		dc.l    $100500AB, $00550010
		dc.l    $100500B7, $005B0000   
;------------------------------------------------------------------------------- 
Collapsing_Platforms_Mappings_2:                               ; Offset_0x009C2C
		dc.w    Offset_0x009C34-Collapsing_Platforms_Mappings_2
		dc.w    Offset_0x009C56-Collapsing_Platforms_Mappings_2
		dc.w    Offset_0x009C98-Collapsing_Platforms_Mappings_2
		dc.w    Offset_0x009CBA-Collapsing_Platforms_Mappings_2
Offset_0x009C34:
		dc.w    $0004
		dc.l    $F80D0000, $0000FFE0
		dc.l    $080D0000, $0000FFE0
		dc.l    $F80D0000, $00000000
		dc.l    $080D0000, $00000000
Offset_0x009C56:
		dc.w    $0008
		dc.l    $F8050000, $0000FFE0
		dc.l    $F8050000, $0000FFF0
		dc.l    $F8050000, $00000000
		dc.l    $F8050000, $00000010
		dc.l    $08050000, $0000FFE0
		dc.l    $08050000, $0000FFF0
		dc.l    $08050000, $00000000
		dc.l    $08050000, $00000010
Offset_0x009C98:
		dc.w    $0004
		dc.l    $F80D0000, $0000FFE0
		dc.l    $080D0008, $0004FFE0
		dc.l    $F80D0000, $00000000
		dc.l    $080D0008, $00040000
Offset_0x009CBA:
		dc.w    $0008
		dc.l    $F8050000, $0000FFE0
		dc.l    $F8050004, $0002FFF0
		dc.l    $F8050000, $00000000
		dc.l    $F8050004, $00020010
		dc.l    $08050008, $0004FFE0
		dc.l    $0805000C, $0006FFF0
		dc.l    $08050008, $00040000
		dc.l    $0805000C, $00060010  
;-------------------------------------------------------------------------------
Offset_0x009CFC:
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10              
;-------------------------------------------------------------------------------
Offset_0x009D0C:
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10
		dc.b    $10, $10, $10, $10, $10, $10, $10, $10   
;-------------------------------------------------------------------------------   
HPz_Collapsing_Platforms_Mappings:                             ; Offset_0x009D3C
		dc.w    Offset_0x009D42-HPz_Collapsing_Platforms_Mappings
		dc.w    Offset_0x009D84-HPz_Collapsing_Platforms_Mappings
		dc.w    Offset_0x009D84-HPz_Collapsing_Platforms_Mappings
Offset_0x009D42:
		dc.w    $0008
		dc.l    $F00D0000, $0000FFD0
		dc.l    $000D0008, $0004FFD0
		dc.l    $F0050004, $0002FFF0
		dc.l    $F0050804, $08020000
		dc.l    $0005000C, $0006FFF0
		dc.l    $0005080C, $08060000
		dc.l    $F00D0800, $08000010
		dc.l    $000D0808, $08040010
Offset_0x009D84:
		dc.w    $000C
		dc.l    $F0050000, $0000FFD0
		dc.l    $F0050004, $0002FFE0
		dc.l    $F0050004, $0002FFF0
		dc.l    $F0050804, $08020000
		dc.l    $F0050804, $08020010
		dc.l    $F0050800, $08000020
		dc.l    $00050008, $0004FFD0
		dc.l    $0005000C, $0006FFE0
		dc.l    $0005000C, $0006FFF0
		dc.l    $0005080C, $08060000
		dc.l    $0005080C, $08060010
		dc.l    $00050808, $08040020   
;-------------------------------------------------------------------------------
OOz_Collapsing_Platforms_Mappings:                             ; Offset_0x009DE6
		dc.w    Offset_0x009DEC-OOz_Collapsing_Platforms_Mappings
		dc.w    Offset_0x009DEC-OOz_Collapsing_Platforms_Mappings
		dc.w    Offset_0x009DEC-OOz_Collapsing_Platforms_Mappings
Offset_0x009DEC:
		dc.w    $0007
		dc.l    $F00F0810, $0808FFC0
		dc.l    $F00F0810, $0808FFE0
		dc.l    $F00F0810, $08080000
		dc.l    $F00F0800, $08000020
		dc.l    $100D0820, $0810FFC0
		dc.l    $100D0820, $0810FFE0
		dc.l    $100D0820, $08100000   
;-------------------------------------------------------------------------------
DHz_Collapsing_Platforms_Mappings:                             ; Offset_0x009E26
		dc.w    Offset_0x009E2A-DHz_Collapsing_Platforms_Mappings
		dc.w    Offset_0x009E4C-DHz_Collapsing_Platforms_Mappings
Offset_0x009E2A:
		dc.w    $0004
		dc.l    $F00D0000, $0000FFE0
		dc.l    $F00D0800, $08000000
		dc.l    $00090008, $0004FFF0
		dc.l    $000B000E, $00070008
Offset_0x009E4C:
		dc.w    $0006
		dc.l    $F0050000, $0000FFE0
		dc.l    $F0050004, $0002FFF0
		dc.l    $F0050804, $08020000
		dc.l    $F0050800, $08000010
		dc.l    $00090008, $0004FFF0
		dc.l    $000B000E, $00070008     
;-------------------------------------------------------------------------------
NGHz_Collapsing_Platforms_Mappings:                            ; Offset_0x009E7E
		dc.w    Offset_0x009E82-NGHz_Collapsing_Platforms_Mappings
		dc.w    Offset_0x009EA4-NGHz_Collapsing_Platforms_Mappings
Offset_0x009E82:
		dc.w    $0004
		dc.l    $F00D0055, $002AFFE0
		dc.l    $F00D0855, $082A0000
		dc.l    $000D00A3, $0051FFE0
		dc.l    $000D08A3, $08510000
Offset_0x009EA4:
		dc.w    $0008
		dc.l    $F0050055, $002AFFE0
		dc.l    $F0050059, $002CFFF0
		dc.l    $F0050859, $082C0000
		dc.l    $F0050855, $082A0010
		dc.l    $000500A3, $0051FFE0
		dc.l    $000500A7, $0053FFF0
		dc.l    $000508A7, $08530000
		dc.l    $000508A3, $08510010  
;------------------------------------------------------------------------------- 
		nop                                                       
;------------------------------------------------------------------------------- 
Obj_0x1C_Misc:                                                 ; Offset_0x009EE8
		include 'objects/obj_0x1C.asm'
Obj_0x71_Mz_HPz_Misc:                                          ; Offset_0x009FA0
		include 'objects/obj_0x71.asm'   
;-------------------------------------------------------------------------------
HTz_Misc_Mappings:                                             ; Offset_0x00A086
		dc.w    Offset_0x00A08A-HTz_Misc_Mappings
		dc.w    Offset_0x00A094-HTz_Misc_Mappings
Offset_0x00A08A:
		dc.w    $0001
		dc.l    $F8050002, $0001FFF8
Offset_0x00A094:
		dc.w    $0001
		dc.l    $F8050006, $0003FFF8       
;-------------------------------------------------------------------------------  
Offset_0x00A09E:
		dc.w    Offset_0x00A0A2-Offset_0x00A09E
		dc.w    Offset_0x00A0AC-Offset_0x00A09E
Offset_0x00A0A2:
		dc.w    $0001
		dc.l    $F8010000, $0000FFFC
Offset_0x00A0AC:
		dc.w    $0001
		dc.l    $F8010002, $0001FFFC         
;-------------------------------------------------------------------------------
OOz_Misc_Mappings:                                             ; Offset_0x00A0B6
		dc.w    Offset_0x00A0BE-OOz_Misc_Mappings
		dc.w    Offset_0x00A0C8-OOz_Misc_Mappings
		dc.w    Offset_0x00A0D2-OOz_Misc_Mappings
		dc.w    Offset_0x00A0DC-OOz_Misc_Mappings
Offset_0x00A0BE:
		dc.w    $0001
		dc.l    $F8050000, $0000FFF8
Offset_0x00A0C8:
		dc.w    $0001
		dc.l    $F8050004, $0002FFF8
Offset_0x00A0D2:
		dc.w    $0001
		dc.l    $F8052008, $2004FFF8
Offset_0x00A0DC:
		dc.w    $0001
		dc.l    $F801000C, $0006FFFC      
;-------------------------------------------------------------------------------
Mz_Misc_Mappings:                                              ; Offset_0x00A0E6
		dc.w    Offset_0x00A0EC-Mz_Misc_Mappings
		dc.w    Offset_0x00A0F6-Mz_Misc_Mappings
		dc.w    Offset_0x00A100-Mz_Misc_Mappings
Offset_0x00A0EC:
		dc.w    $0001
		dc.l    $F8010004, $0002FFFC
Offset_0x00A0F6:
		dc.w    $0001
		dc.l    $F8010006, $0003FFFC
Offset_0x00A100:
		dc.w    $0001
		dc.l    $FC0C0000, $0000FFF0   
;-------------------------------------------------------------------------------
Mz_Lava_Bubble_Mappings:                                       ; Offset_0x00A10A
		dc.w    Offset_0x00A118-Mz_Lava_Bubble_Mappings
		dc.w    Offset_0x00A122-Mz_Lava_Bubble_Mappings
		dc.w    Offset_0x00A12C-Mz_Lava_Bubble_Mappings
		dc.w    Offset_0x00A136-Mz_Lava_Bubble_Mappings
		dc.w    Offset_0x00A140-Mz_Lava_Bubble_Mappings
		dc.w    Offset_0x00A14A-Mz_Lava_Bubble_Mappings
		dc.w    Offset_0x00A154-Mz_Lava_Bubble_Mappings
Offset_0x00A118:
		dc.w    $0001
		dc.l    $02040000, $0000FFF8
Offset_0x00A122:
		dc.w    $0001
		dc.l    $00040000, $0000FFF8
Offset_0x00A12C:
		dc.w    $0001
		dc.l    $FE040000, $0000FFF8
Offset_0x00A136:
		dc.w    $0001
		dc.l    $FC040000, $0000FFF8
Offset_0x00A140:
		dc.w    $0001
		dc.l    $FC080002, $0001FFF4
Offset_0x00A14A:
		dc.w    $0001
		dc.l    $FC0C0005, $0002FFF0
Offset_0x00A154:
		dc.w    $0000                          
;-------------------------------------------------------------------------------  
		nop               
;-------------------------------------------------------------------------------  
Obj_0x2A_Up_Down_Pillar:                                       ; Offset_0x00A158
		include 'objects/obj_0x2A.asm' 
Obj_0x2D_Automatic_Door:                                       ; Offset_0x00A22E 
		include 'objects/obj_0x2D.asm'          
;-------------------------------------------------------------------------------   
		nop                                                              
;-------------------------------------------------------------------------------  
Obj_0x28_Flickies:                                             ; Offset_0x00A3E8
		include 'objects/obj_0x28.asm'       
Obj_0x29_Enemy_Points:                                         ; Offset_0x00A922  
		include 'objects/obj_0x29.asm'     
;-------------------------------------------------------------------------------  
Flickies_Mappings:                                             ; Offset_0x00A978
		dc.w    Offset_0x00A988-Flickies_Mappings
		dc.w    Offset_0x00A992-Flickies_Mappings
		dc.w    Offset_0x00A97E-Flickies_Mappings
Offset_0x00A97E:
		dc.w    $0001
		dc.l    $EC070000, $0000FFF8
Offset_0x00A988:
		dc.w    $0001
		dc.l    $F8050008, $0004FFF8
Offset_0x00A992:
		dc.w    $0001
		dc.l    $F805000C, $0006FFF8         
;-------------------------------------------------------------------------------
Flickies_Mappings_01:                                          ; Offset_0x00A99C
		dc.w    Offset_0x00A9AC-Flickies_Mappings_01
		dc.w    Offset_0x00A9B6-Flickies_Mappings_01
		dc.w    Offset_0x00A9A2-Flickies_Mappings_01
Offset_0x00A9A2:
		dc.w    $0001
		dc.l    $EC070000, $0000FFF8
Offset_0x00A9AC:
		dc.w    $0001
		dc.l    $F8090008, $0004FFF4
Offset_0x00A9B6:
		dc.w    $0001
		dc.l    $F809000E, $0007FFF4 
;-------------------------------------------------------------------------------
Flickies_Mappings_02:                                          ; Offset_0x00A9C0
		dc.w    Offset_0x00A9D0-Flickies_Mappings_02
		dc.w    Offset_0x00A9DA-Flickies_Mappings_02
		dc.w    Offset_0x00A9C6-Flickies_Mappings_02
Offset_0x00A9C6:
		dc.w    $0001
		dc.l    $F4060000, $0000FFF8
Offset_0x00A9D0:
		dc.w    $0001
		dc.l    $F8090006, $0003FFF4
Offset_0x00A9DA:
		dc.w    $0001
		dc.l    $F809000C, $0006FFF4    
;-------------------------------------------------------------------------------
Flickies_Mappings_03:                                          ; Offset_0x00A9E4
		dc.w    Offset_0x00A9F4-Flickies_Mappings_03
		dc.w    Offset_0x00A9FE-Flickies_Mappings_03
		dc.w    Offset_0x00A9EA-Flickies_Mappings_03
Offset_0x00A9EA:
		dc.w    $0001
		dc.l    $F4060000, $0000FFF8
Offset_0x00A9F4:
		dc.w    $0001
		dc.l    $F8050006, $0003FFF8
Offset_0x00A9FE:
		dc.w    $0001
		dc.l    $F805000A, $0005FFF8       
;-------------------------------------------------------------------------------
Flickies_Mappings_04:                                          ; Offset_0x00AA08
		dc.w    Offset_0x00AA18-Flickies_Mappings_04
		dc.w    Offset_0x00AA22-Flickies_Mappings_04
		dc.w    Offset_0x00AA0E-Flickies_Mappings_04
Offset_0x00AA0E:
		dc.w    $0001
		dc.l    $F4060000, $0000FFF8
Offset_0x00AA18:
		dc.w    $0001
		dc.l    $F4060006, $0003FFF8
Offset_0x00AA22:
		dc.w    $0001
		dc.l    $F406000C, $0006FFF8  
;-------------------------------------------------------------------------------
Enemy_Points_Mappings:                                         ; Offset_0x00AA2C
		dc.w    Offset_0x00AA3A-Enemy_Points_Mappings
		dc.w    Offset_0x00AA44-Enemy_Points_Mappings
		dc.w    Offset_0x00AA4E-Enemy_Points_Mappings
		dc.w    Offset_0x00AA58-Enemy_Points_Mappings
		dc.w    Offset_0x00AA6A-Enemy_Points_Mappings
		dc.w    Offset_0x00AA74-Enemy_Points_Mappings
		dc.w    Offset_0x00AA86-Enemy_Points_Mappings
Offset_0x00AA3A:
		dc.w    $0001
		dc.l    $F8050002, $0001FFF8
Offset_0x00AA44:
		dc.w    $0001
		dc.l    $F8050006, $0003FFF8
Offset_0x00AA4E:
		dc.w    $0001
		dc.l    $F805000A, $0005FFF8
Offset_0x00AA58:
		dc.w    $0002
		dc.l    $F8010000, $0000FFF8
		dc.l    $F805000E, $00070000
Offset_0x00AA6A:
		dc.w    $0001
		dc.l    $F8010000, $0000FFFC
Offset_0x00AA74:
		dc.w    $0002
		dc.l    $F8050002, $0001FFF0
		dc.l    $F805000E, $00070000
Offset_0x00AA86:
		dc.w    $0002
		dc.l    $F805000A, $0005FFF0
		dc.l    $F805000E, $00070000    
;-------------------------------------------------------------------------------
Obj_0x25_Rings:                                                ; Offset_0x00AA98
		include 'objects/obj_0x25.asm'             
;-------------------------------------------------------------------------------   
; Rotina para adicionar anéis ao contador, verificando o limmite e bonificando
; ->>>          com vida extra ao adiquirir 100 e 200 anéis
;-------------------------------------------------------------------------------   
Add_Rings:                                                     ; Offset_0x00AB92
		addq.w  #$01, (Ring_Count).w                         ; $FFFFFE20
		ori.b   #$01, (HUD_Rings_Refresh_Flag).w             ; $FFFFFE1D
		move.w  #$00B5, D0
		cmpi.w  #$0064, (Ring_Count).w                       ; $FFFFFE20
		bcs.s   Offset_0x00ABCC
		bset    #$01, (Ring_Life_Flag).w                     ; $FFFFFE1B
		beq.s   Offset_0x00ABC0
		cmpi.w  #$00C8, (Ring_Count).w                       ; $FFFFFE20
		bcs.s   Offset_0x00ABCC
		bset    #$02, (Ring_Life_Flag).w                     ; $FFFFFE1B
		bne.s   Offset_0x00ABCC
Offset_0x00ABC0:
		addq.b  #$01, (Life_Count).w                         ; $FFFFFE12
		addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
		move.w  #$0088, D0
Offset_0x00ABCC:
		jmp     (Play_Sfx)                             ; Offset_0x001512 
;-------------------------------------------------------------------------------   
; Rotina para adicionar anéis ao contador, verificando o limmite e bonificando
; <<<-          com vida extra ao adiquirir 100 e 200 anéis
;------------------------------------------------------------------------------- 
Obj_0x37_Rings_Lost:                                           ; Offset_0x00ABD2
		include 'objects/obj_0x37.asm' 
Obj_S1_0x4B_Big_Ring:                                          ; Offset_0x00AD26
		include 'objects/objs1_4B.asm'     
Obj_S1_0x7C_Big_Ring_Flash:                                    ; Offset_0x00ADEA
		include 'objects/objs1_7C.asm'                            
;-------------------------------------------------------------------------------   
Rings_Animate_Data:                                            ; Offset_0x00AE98
		dc.w    Offset_0x00AE9A-Rings_Animate_Data
Offset_0x00AE9A:
		dc.b    $05, $04, $05, $06, $07, $FC
;-------------------------------------------------------------------------------  
Rings_Mappings:                                                ; Offset_0x00AEA0
		dc.w    Offset_0x00AEB2-Rings_Mappings
		dc.w    Offset_0x00AEBC-Rings_Mappings
		dc.w    Offset_0x00AEC6-Rings_Mappings
		dc.w    Offset_0x00AED0-Rings_Mappings
		dc.w    Offset_0x00AEDA-Rings_Mappings
		dc.w    Offset_0x00AEE4-Rings_Mappings
		dc.w    Offset_0x00AEEE-Rings_Mappings
		dc.w    Offset_0x00AEF8-Rings_Mappings
		dc.w    Offset_0x00AF02-Rings_Mappings
Offset_0x00AEB2:
		dc.w    $0001
		dc.l    $F8050000, $0000FFF8
Offset_0x00AEBC:
		dc.w    $0001
		dc.l    $F8050004, $0002FFF8
Offset_0x00AEC6:
		dc.w    $0001
		dc.l    $F8010008, $0004FFFC
Offset_0x00AED0:
		dc.w    $0001
		dc.l    $F8050804, $0802FFF8
Offset_0x00AEDA:
		dc.w    $0001
		dc.l    $F805000A, $0005FFF8
Offset_0x00AEE4:
		dc.w    $0001
		dc.l    $F805180A, $1805FFF8
Offset_0x00AEEE:
		dc.w    $0001
		dc.l    $F805080A, $0805FFF8
Offset_0x00AEF8:
		dc.w    $0001
		dc.l    $F805100A, $1005FFF8
Offset_0x00AF02:
		dc.w    $0000  
;-------------------------------------------------------------------------------
Big_Ring_Mappings:                                             ; Offset_0x00AF04
		dc.w    Offset_0x00AF0C-Big_Ring_Mappings
		dc.w    Offset_0x00AF5E-Big_Ring_Mappings
		dc.w    Offset_0x00AFA0-Big_Ring_Mappings
		dc.w    Offset_0x00AFC2-Big_Ring_Mappings
Offset_0x00AF0C:
		dc.w    $000A
		dc.l    $E0080000, $0000FFE8
		dc.l    $E0080003, $00010000
		dc.l    $E80C0006, $0003FFE0
		dc.l    $E80C000A, $00050000
		dc.l    $F007000E, $0007FFE0
		dc.l    $F0070016, $000B0010
		dc.l    $100C001E, $000FFFE0
		dc.l    $100C0022, $00110000
		dc.l    $18080026, $0013FFE8
		dc.l    $18080029, $00140000
Offset_0x00AF5E:
		dc.w    $0008
		dc.l    $E00C002C, $0016FFF0
		dc.l    $E8080030, $0018FFE8
		dc.l    $E8090033, $00190000
		dc.l    $F0070039, $001CFFE8
		dc.l    $F8050041, $00200008
		dc.l    $08090045, $00220000
		dc.l    $1008004B, $0025FFE8
		dc.l    $180C004E, $0027FFF0
Offset_0x00AFA0:
		dc.w    $0004
		dc.l    $E0070052, $0029FFF4
		dc.l    $E0030852, $08290004
		dc.l    $0007005A, $002DFFF4
		dc.l    $0003085A, $082D0004
Offset_0x00AFC2:
		dc.w    $0008
		dc.l    $E00C082C, $0816FFF0
		dc.l    $E8080830, $08180000
		dc.l    $E8090833, $0819FFE8
		dc.l    $F0070839, $081C0008
		dc.l    $F8050841, $0820FFE8
		dc.l    $08090845, $0822FFE8
		dc.l    $1008084B, $08250000
		dc.l    $180C084E, $0827FFF0      
;------------------------------------------------------------------------------- 
Big_Ring_Flash_Mappings:                                       ; Offset_0x00B004
		dc.w    Offset_0x00B014-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B026-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B048-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B06A-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B08C-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B0AE-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B0D0-Big_Ring_Flash_Mappings
		dc.w    Offset_0x00B0E2-Big_Ring_Flash_Mappings
Offset_0x00B014:
		dc.w    $0002
		dc.l    $E00F0000, $00000000
		dc.l    $000F1000, $10000000
Offset_0x00B026:
		dc.w    $0004
		dc.l    $E00F0010, $0008FFF0
		dc.l    $E0070020, $00100010
		dc.l    $000F1010, $1008FFF0
		dc.l    $00071020, $10100010
Offset_0x00B048:
		dc.w    $0004
		dc.l    $E00F0028, $0014FFE8
		dc.l    $E00B0038, $001C0008
		dc.l    $000F1028, $1014FFE8
		dc.l    $000B1038, $101C0008
Offset_0x00B06A:
		dc.w    $0004
		dc.l    $E00F0834, $081AFFE0
		dc.l    $E00F0034, $001A0000
		dc.l    $000F1834, $181AFFE0
		dc.l    $000F1034, $101A0000
Offset_0x00B08C:
		dc.w    $0004
		dc.l    $E00B0838, $081CFFE0
		dc.l    $E00F0828, $0814FFF8
		dc.l    $000B1838, $181CFFE0
		dc.l    $000F1828, $1814FFF8
Offset_0x00B0AE:
		dc.w    $0004
		dc.l    $E0070820, $0810FFE0
		dc.l    $E00F0810, $0808FFF0
		dc.l    $00071820, $1810FFE0
		dc.l    $000F1810, $1808FFF0
Offset_0x00B0D0:
		dc.w    $0002
		dc.l    $E00F0800, $0800FFE0
		dc.l    $000F1800, $1800FFE0
Offset_0x00B0E2:
		dc.w    $0004
		dc.l    $E00F0044, $0022FFE0
		dc.l    $E00F0844, $08220000
		dc.l    $000F1044, $1022FFE0
		dc.l    $000F1844, $18220000     
;-------------------------------------------------------------------------------                                
Obj_0x26_Monitors:                                             ; Offset_0x00B104
		include 'objects/obj_0x26.asm'
Obj_0x2E_Monitors_Contents:                                    ; Offset_0x00B2D2
		include 'objects/obj_0x2E.asm'         
;-------------------------------------------------------------------------------   
; Rotinas complementares referenciadas no objeto 0x26
; ->>>
;------------------------------------------------------------------------------- 
Offset_0x00B49E:
		lea     (Player_One).w, A1                           ; $FFFFB000
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00B4F6
		move.w  D1, D3
		add.w   D3, D3
		cmp.w   D3, D0
		bhi.s   Offset_0x00B4F6
		move.b  Obj_Height_2(A1), D3                             ; $0016
		ext.w   D3
		add.w   D3, D2
		move.w  Obj_Y(A1), D3                                    ; $000C
		sub.w   Obj_Y(A0), D3                                    ; $000C
		add.w   D2, D3
		bmi.s   Offset_0x00B4F6
		add.w   D2, D2
		cmp.w   D2, D3
		bcc.s   Offset_0x00B4F6
		tst.b   Obj_Timer(A1)                                    ; $002A
		bmi.s   Offset_0x00B4F6
		cmpi.b  #$06, (Player_One+Obj_Routine).w             ; $FFFFB024
		bcc.s   Offset_0x00B4F6
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne.s   Offset_0x00B4F6
		cmp.w   D0, D1
		bcc.s   Offset_0x00B4EC
		add.w   D1, D1
		sub.w   D1, D0
Offset_0x00B4EC:
		cmpi.w  #$0010, D3
		bcs.s   Offset_0x00B4FA
Offset_0x00B4F2:
		moveq   #$01, D1
		rts
Offset_0x00B4F6:
		moveq   #$00, D1
		rts
Offset_0x00B4FA:
		moveq   #$00, D1
		move.b  Obj_Width(A0), D1                                ; $0019
		addq.w  #$04, D1
		move.w  D1, D2
		add.w   D2, D2
		add.w   Obj_X(A1), D1                                    ; $0008
		sub.w   Obj_X(A0), D1                                    ; $0008
		bmi.s   Offset_0x00B4F2
		cmp.w   D2, D1
		bcc.s   Offset_0x00B4F2
		moveq   #-$01, D1
		rts     
;-------------------------------------------------------------------------------                   
Monitors_Animate_Data:                                         ; Offset_0x00B518
		dc.w    Offset_0x00B52E-Monitors_Animate_Data
		dc.w    Offset_0x00B532-Monitors_Animate_Data
		dc.w    Offset_0x00B53A-Monitors_Animate_Data
		dc.w    Offset_0x00B542-Monitors_Animate_Data
		dc.w    Offset_0x00B54A-Monitors_Animate_Data
		dc.w    Offset_0x00B552-Monitors_Animate_Data
		dc.w    Offset_0x00B55A-Monitors_Animate_Data
		dc.w    Offset_0x00B562-Monitors_Animate_Data
		dc.w    Offset_0x00B56A-Monitors_Animate_Data
		dc.w    Offset_0x00B572-Monitors_Animate_Data
		dc.w    Offset_0x00B57A-Monitors_Animate_Data
Offset_0x00B52E:
		dc.b    $01, $00, $01, $FF
Offset_0x00B532:
		dc.b    $01, $00, $02, $02, $01, $02, $02, $FF
Offset_0x00B53A:
		dc.b    $01, $00, $03, $03, $01, $03, $03, $FF
Offset_0x00B542:
		dc.b    $01, $00, $04, $04, $01, $04, $04, $FF
Offset_0x00B54A:
		dc.b    $01, $00, $05, $05, $01, $05, $05, $FF
Offset_0x00B552:
		dc.b    $01, $00, $06, $06, $01, $06, $06, $FF
Offset_0x00B55A:
		dc.b    $01, $00, $07, $07, $01, $07, $07, $FF
Offset_0x00B562:
		dc.b    $01, $00, $08, $08, $01, $08, $08, $FF
Offset_0x00B56A:
		dc.b    $01, $00, $09, $09, $01, $09, $09, $FF
Offset_0x00B572:
		dc.b    $01, $00, $0A, $0A, $01, $0A, $0A, $FF
Offset_0x00B57A:
		dc.b    $02, $00, $01, $0B, $FE, $01       
;-------------------------------------------------------------------------------
Monitors_Mappings:                                             ; Offset_0x00B580
		dc.w    Monitor_Empty_Map-Monitors_Mappings    ; Offset_0x00B598
		dc.w    Monitor_Empty_2_Map-Monitors_Mappings  ; Offset_0x00B5A2
		dc.w    Monitor_SonicLife_Map-Monitors_Mappings ; Offset_0x00B5B4
		dc.w    Monitor_MilesLife_Map-Monitors_Mappings ; Offset_0x00B5C6
		dc.w    Monitor_Robotnik_Map-Monitors_Mappings  ; Offset_0x00B5D8
		dc.w    Monitor_Rings_Map-Monitors_Mappings    ; Offset_0x00B5EA
		dc.w    Monitor_Shoes_Map-Monitors_Mappings    ; Offset_0x00B5FC
		dc.w    Monitor_Shield_Map-Monitors_Mappings   ; Offset_0x00B60E
		dc.w    Monitor_Invincibility_Map-Monitors_Mappings ; Offset_0x00B620
		dc.w    Monitor_Question_Mark_Map-Monitors_Mappings ; Offset_0x00B632
		dc.w    Monitor_Spring_Map-Monitors_Mappings   ; Offset_0x00B644
		dc.w    Monitor_Broken_Map-Monitors_Mappings   ; Offset_0x00B656
Monitor_Empty_Map:                                             ; Offset_0x00B598
		dc.w    $0001
		dc.l    $EF0F0000, $0000FFF0
Monitor_Empty_2_Map:                                           ; Offset_0x00B5A2
		dc.w    $0002
		dc.l    $F5050018, $000CFFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_SonicLife_Map:                                         ; Offset_0x00B5B4
		dc.w    $0002
		dc.l    $F5050154, $00AAFFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_MilesLife_Map:                                         ; Offset_0x00B5C6
		dc.w    $0002
		dc.l    $F505001C, $000EFFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Robotnik_Map:                                          ; Offset_0x00B5D8
		dc.w    $0002
		dc.l    $F5050020, $0010FFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Rings_Map:                                             ; Offset_0x00B5EA
		dc.w    $0002
		dc.l    $F5052024, $2012FFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Shoes_Map:                                             ; Offset_0x00B5FC
		dc.w    $0002
		dc.l    $F5050028, $0014FFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Shield_Map:                                            ; Offset_0x00B60E
		dc.w    $0002
		dc.l    $F505002C, $0016FFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Invincibility_Map:                                     ; Offset_0x00B620
		dc.w    $0002
		dc.l    $F5050030, $0018FFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Question_Mark_Map:                                     ; Offset_0x00B632
		dc.w    $0002
		dc.l    $F5050034, $001AFFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Spring_Map:                                            ; Offset_0x00B644
		dc.w    $0002
		dc.l    $F5050038, $001CFFF8
		dc.l    $EF0F0000, $0000FFF0
Monitor_Broken_Map:                                            ; Offset_0x00B656
		dc.w    $0001
		dc.l    $FF0D0010, $0008FFF0 
;-------------------------------------------------------------------------------   
; Rotinas complementares referenciadas no objeto 0x26
; <<<-
;------------------------------------------------------------------------------- 
Obj_0x0E_Sonic_Miles:                                          ; Offset_0x00B660
		include 'objects/obj_0x0E.asm' 
Obj_0x0F:                                                      ; Offset_0x00B6E6
		include 'objects/obj_0x0F.asm'             
;-------------------------------------------------------------------------------  
S1_Sonic_In_Title_Screen_Animate_Data:                         ; Offset_0x00B802
		dc.w    Offset_0x00B804-S1_Sonic_In_Title_Screen_Animate_Data
Offset_0x00B804:
		dc.b    $07, $00, $01, $02, $03, $04, $05, $06
		dc.b    $07, $FE, $02, $00      
;-------------------------------------------------------------------------------  
S1_Press_Start_Button_Animate_Data:                            ; Offset_0x00B810
		dc.w    Offset_0x00B812-S1_Press_Start_Button_Animate_Data
Offset_0x00B812:
		dc.b    $1F, $00, $01, $FF
;-------------------------------------------------------------------------------  
S1_Press_Start_Button_Mappings:                                ; Offset_0x00B816
		dc.w    Offset_0x00B81E-S1_Press_Start_Button_Mappings
		dc.w    Offset_0x00B820-S1_Press_Start_Button_Mappings
		dc.w    Offset_0x00B852-S1_Press_Start_Button_Mappings
		dc.w    Offset_0x00B944-S1_Press_Start_Button_Mappings
Offset_0x00B81E:
		dc.w    $0000
Offset_0x00B820:
		dc.w    $0006
		dc.l    $000C00F0, $00780000
		dc.l    $000000F3, $00790020
		dc.l    $000000F3, $00790030
		dc.l    $000C00F4, $007A0038
		dc.l    $000800F8, $007C0060
		dc.l    $000800FB, $007D0078
Offset_0x00B852:
		dc.w    $001E
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $B80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $D80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
		dc.l    $F80F0000, $0000FF80
Offset_0x00B944:
		dc.w    $0001
		dc.l    $FC040000, $0000FFF8                     
;-------------------------------------------------------------------------------                    
Sonic_Miles_Mappings:                                          ; Offset_0x00B94E
		dc.w    Sonic_In_Title_Screen_Map-Sonic_Miles_Mappings ; Offset_0x00B952
		dc.w    Miles_In_Title_Screen_Map-Sonic_Miles_Mappings ; Offset_0x00B9AC
Sonic_In_Title_Screen_Map:                                     ; Offset_0x00B952
		dc.w    $000B
		dc.l    $D40D0000, $0000FFD8
		dc.l    $CC0E0008, $0004FFF8
		dc.l    $CC070014, $000A0018
		dc.l    $E40F001C, $000EFFE0
		dc.l    $E40B002C, $00160000
		dc.l    $EC070038, $001C0018
		dc.l    $040F0040, $0020FFD8
		dc.l    $040F0050, $0028FFF8
		dc.l    $0C060060, $00300018
		dc.l    $24040066, $0033FFE8
		dc.l    $240D0068, $0034FFF8
Miles_In_Title_Screen_Map:                                     ; Offset_0x00B9AC
		dc.w    $000A
		dc.l    $DC060070, $0038FFEC
		dc.l    $F40F0076, $003BFFD4
		dc.l    $F40F0086, $0043FFF4
		dc.l    $E4090096, $004BFFFC
		dc.l    $DC0B009C, $004E0014
		dc.l    $FC0800A8, $00540014
		dc.l    $040500AB, $00550014
		dc.l    $140400AF, $0057FFD4
		dc.l    $140D00B1, $0058FFE4
		dc.l    $140D00B9, $005C0004                                      
;-------------------------------------------------------------------------------  
		nop                                                              
;-------------------------------------------------------------------------------  
Obj_0x34_Title_Cards:                                          ; Offset_0x00BA00 
		include 'objects/obj_0x34.asm'              
Obj_0x39_Time_Over_Game_Over:                                  ; Offset_0x00BC44
		include 'objects/obj_0x39.asm'  
Obj_0x3A_Level_Results:                                        ; Offset_0x00BD06
		include 'objects/obj_0x3A.asm'         
Obj_S1_0x7E_Special_Stage_Results:                             ; Offset_0x00BF3E
		include 'objects/objs1_7E.asm'   
Obj_S1_0x7F_Emeralds:                                          ; Offset_0x00C0E4
		include 'objects/objs1_7F.asm'       
;-------------------------------------------------------------------------------                
; Mapeamento dos títulos das fases
; ->>>                
;-------------------------------------------------------------------------------
Title_Cards_Mappings:                                          ; Offset_0x00C176
		dc.w    GHz_TC_Map-Title_Cards_Mappings        ; Offset_0x00C18E
		dc.w    Lz_TC_Map-Title_Cards_Mappings         ; Offset_0x00C1D8
		dc.w    Mz_TC_Map-Title_Cards_Mappings         ; Offset_0x00C222
		dc.w    SLz_TC_Map-Title_Cards_Mappings        ; Offset_0x00C254
		dc.w    SYz_TC_Map-Title_Cards_Mappings        ; Offset_0x00C29E
		dc.w    SBz_TC_Map-Title_Cards_Mappings        ; Offset_0x00C2F0
		dc.w    ZONE_TC_Map-Title_Cards_Mappings       ; Offset_0x00C342
		dc.w    Act_1_TC_Map-Title_Cards_Mappings      ; Offset_0x00C364
		dc.w    Act_2_TC_Map-Title_Cards_Mappings      ; Offset_0x00C376
		dc.w    Act_3_TC_Map-Title_Cards_Mappings      ; Offset_0x00C388
		dc.w    TC_Oval_Map-Title_Cards_Mappings       ; Offset_0x00C39A
		dc.w    Fz_TC_Map-Title_Cards_Mappings         ; Offset_0x00C404
GHz_TC_Map:                                                    ; Offset_0x00C18E
		dc.w    $0009
		dc.l    $F8050018, $000CFFB4  ; G
		dc.l    $F805003A, $001DFFC4  ; R
		dc.l    $F8050010, $0008FFD4  ; E
		dc.l    $F8050010, $0008FFE4  ; E
		dc.l    $F805002E, $0017FFF4  ; N
		dc.l    $F805001C, $000E0014  ; H
		dc.l    $F8010020, $00100024  ; I
		dc.l    $F8050026, $0013002C  ; L
		dc.l    $F8050026, $0013003C  ; L
Lz_TC_Map:                                                     ; Offset_0x00C1D8
		dc.w    $0009
		dc.l    $F8050026, $0013FFBC  ; L
		dc.l    $F8050000, $0000FFCC  ; A
		dc.l    $F8050004, $0002FFDC  ; B
		dc.l    $F805004A, $0025FFEC  ; Y
		dc.l    $F805003A, $001DFFFC  ; R
		dc.l    $F8010020, $0010000C  ; I
		dc.l    $F805002E, $00170014  ; N
		dc.l    $F8050042, $00210024  ; T
		dc.l    $F805001C, $000E0034  ; H
Mz_TC_Map:                                                     ; Offset_0x00C222
		dc.w    $0006
		dc.l    $F805002A, $0015FFCF  ; M
		dc.l    $F8050000, $0000FFE0  ; A
		dc.l    $F805003A, $001DFFF0  ; R
		dc.l    $F8050004, $00020000  ; B
		dc.l    $F8050026, $00130010  ; L
		dc.l    $F8050010, $00080020  ; E
SLz_TC_Map:                                                    ; Offset_0x00C254
		dc.w    $0009
		dc.l    $F805003E, $001FFFB4  ; S
		dc.l    $F8050042, $0021FFC4  ; T
		dc.l    $F8050000, $0000FFD4  ; A
		dc.l    $F805003A, $001DFFE4  ; R
		dc.l    $F8050026, $00130004  ; L
		dc.l    $F8010020, $00100014  ; I
		dc.l    $F8050018, $000C001C  ; G
		dc.l    $F805001C, $000E002C  ; H
		dc.l    $F8050042, $0021003C  ; T
SYz_TC_Map:                                                    ; Offset_0x00C29E
		dc.w    $000A
		dc.l    $F805003E, $001FFFAC  ; S
		dc.l    $F8050036, $001BFFBC  ; P
		dc.l    $F805003A, $001DFFCC  ; R
		dc.l    $F8010020, $0010FFDC  ; I
		dc.l    $F805002E, $0017FFE4  ; N
		dc.l    $F8050018, $000CFFF4  ; G
		dc.l    $F805004A, $00250014  ; Y
		dc.l    $F8050000, $00000024  ; A
		dc.l    $F805003A, $001D0034  ; R
		dc.l    $F805000C, $00060044  ; D
SBz_TC_Map:                                                    ; Offset_0x00C2F0
		dc.w    $000A
		dc.l    $F805003E, $001FFFAC  ; S
		dc.l    $F8050008, $0004FFBC  ; C
		dc.l    $F805003A, $001DFFCC  ; R
		dc.l    $F8050000, $0000FFDC  ; A
		dc.l    $F8050036, $001BFFEC  ; P
		dc.l    $F8050004, $0002000C  ; B
		dc.l    $F805003A, $001D001C  ; R
		dc.l    $F8050000, $0000002C  ; A
		dc.l    $F8010020, $0010003C  ; I
		dc.l    $F805002E, $00170044  ; N
ZONE_TC_Map:                                                   ; Offset_0x00C342
		dc.w    $0004
		dc.l    $F805004E, $0027FFE0  ; Z
		dc.l    $F8050032, $0019FFF0  ; O
		dc.l    $F805002E, $00170000  ; N
		dc.l    $F8050010, $00080010  ; E
Act_1_TC_Map:                                                  ; Offset_0x00C364
		dc.w    $0002
		dc.l    $040C0053, $0029FFEC  ; ACT
		dc.l    $F4020057, $002B000C  ; 1
Act_2_TC_Map:                                                  ; Offset_0x00C376
		dc.w    $0002
		dc.l    $040C0053, $0029FFEC  ; ACT
		dc.l    $F406005A, $002D0008  ; 2
Act_3_TC_Map:                                                  ; Offset_0x00C388
		dc.w    $0002
		dc.l    $040C0053, $0029FFEC  ; ACT
		dc.l    $F4060060, $00300008  ; 3
TC_Oval_Map:                                                   ; Offset_0x00C39A
		dc.w    $000D                 ; OVAL
		dc.l    $E40C0070, $0038FFF4
		dc.l    $E4020074, $003A0014
		dc.l    $EC040077, $003BFFEC
		dc.l    $F4050079, $003CFFE4
		dc.l    $140C1870, $1838FFEC
		dc.l    $04021874, $183AFFE4
		dc.l    $0C041877, $183B0004
		dc.l    $FC051879, $183C000C
		dc.l    $EC08007D, $003EFFFC
		dc.l    $F40C007C, $003EFFF4
		dc.l    $FC08007C, $003EFFF4
		dc.l    $040C007C, $003EFFEC
		dc.l    $0C08007C, $003EFFEC
Fz_TC_Map:                                                     ; Offset_0x00C404
		dc.w    $0005
		dc.l    $F8050014, $000AFFDC  ; F
		dc.l    $F8010020, $0010FFEC  ; I
		dc.l    $F805002E, $0017FFF4  ; N
		dc.l    $F8050000, $00000004  ; A
		dc.l    $F8050026, $00130014  ; L
;-------------------------------------------------------------------------------                
; Mapeamento dos títulos das fases
; <<<-                
;-------------------------------------------------------------------------------    

;-------------------------------------------------------------------------------                
; Mapeamento das mensagens de "GAME OVER" e "TIME OVER"
; ->>>                
;-------------------------------------------------------------------------------                 
Time_Over_Game_Over_Mappings:                                  ; Offset_0x00C42E
		dc.w    Offset_0x00C436-Time_Over_Game_Over_Mappings
		dc.w    Offset_0x00C448-Time_Over_Game_Over_Mappings
		dc.w    Offset_0x00C45A-Time_Over_Game_Over_Mappings
		dc.w    Offset_0x00C46C-Time_Over_Game_Over_Mappings
Offset_0x00C436:
		dc.w    $0002
		dc.l    $F80D0000, $0000FFB8
		dc.l    $F80D0008, $0004FFD8
Offset_0x00C448:
		dc.w    $0002
		dc.l    $F80D0014, $000A0008
		dc.l    $F80D000C, $00060028
Offset_0x00C45A:
		dc.w    $0002
		dc.l    $F809001C, $000EFFC4
		dc.l    $F80D0008, $0004FFDC
Offset_0x00C46C:
		dc.w    $0002
		dc.l    $F80D0014, $000A000C
		dc.l    $F80D000C, $0006002C
;-------------------------------------------------------------------------------                
; Mapeamento das mensagens de "GAME OVER" e "TIME OVER"
; <<<-                
;------------------------------------------------------------------------------- 

;-------------------------------------------------------------------------------                
; Mapeamento da tela de resultado das fases
; ->>>                
;------------------------------------------------------------------------------- 
Level_Results_Mappings:                                        ; Offset_0x00C47E
		dc.w    LR_Sonic_Has_Map-Level_Results_Mappings ; Offset_0x00C490
		dc.w    LR_Passed_Map-Level_Results_Mappings   ; Offset_0x00C4D2
		dc.w    LR_Score_Map-Level_Results_Mappings    ; Offset_0x00C504
		dc.w    LR_Time_Bonus_Map-Level_Results_Mappings ; Offset_0x00C536
		dc.w    LR_Ring_Bonus_Map-Level_Results_Mappings ; Offset_0x00C570
		dc.w    TC_Oval_Map-Level_Results_Mappings     ; Offset_0x00C39A
		dc.w    Act_1_TC_Map-Level_Results_Mappings    ; Offset_0x00C364
		dc.w    Act_2_TC_Map-Level_Results_Mappings    ; Offset_0x00C376
		dc.w    Act_3_TC_Map-Level_Results_Mappings    ; Offset_0x00C388
LR_Sonic_Has_Map:                                              ; Offset_0x00C490
		dc.w    $0008
		dc.l    $F805003E, $001FFFB8  ; S
		dc.l    $F8050032, $0019FFC8  ; O
		dc.l    $F805002E, $0017FFD8  ; N
		dc.l    $F8010020, $0010FFE8  ; I
		dc.l    $F8050008, $0004FFF0  ; C
		dc.l    $F805001C, $000E0010  ; H
		dc.l    $F8050000, $00000020  ; A
		dc.l    $F805003E, $001F0030  ; S
LR_Passed_Map:                                                 ; Offset_0x00C4D2
		dc.w    $0006
		dc.l    $F8050036, $001BFFD0  ; P 
		dc.l    $F8050000, $0000FFE0  ; A
		dc.l    $F805003E, $001FFFF0  ; S
		dc.l    $F805003E, $001F0000  ; S
		dc.l    $F8050010, $00080010  ; E
		dc.l    $F805000C, $00060020  ; D
LR_Score_Map:                                                  ; Offset_0x00C504
		dc.w    $0006
		dc.l    $F80D014A, $00A5FFB0  ; SCOR
		dc.l    $F8010162, $00B1FFD0  ; E
		dc.l    $F8090164, $00B20018  
		dc.l    $F80D016A, $00B50030
		dc.l    $F704006E, $0037FFCD
		dc.l    $FF04186E, $1837FFCD
LR_Time_Bonus_Map:                                             ; Offset_0x00C536
		dc.w    $0007
		dc.l    $F80D015A, $00ADFFB0  ; TIME
		dc.l    $F80D0066, $0033FFD9  ; BONU
		dc.l    $F801014A, $00A5FFF9  ; S
		dc.l    $F704006E, $0037FFF6  
		dc.l    $FF04186E, $1837FFF6
		dc.l    $F80DFFF0, $FBF80028
		dc.l    $F8010170, $00B80048
LR_Ring_Bonus_Map:                                             ; Offset_0x00C570
		dc.w    $0007
		dc.l    $F80D0152, $00A9FFB0  ; RING
		dc.l    $F80D0066, $0033FFD9  ; BONU
		dc.l    $F801014A, $00A5FFF9  ; S
		dc.l    $F704006E, $0037FFF6
		dc.l    $FF04186E, $1837FFF6
		dc.l    $F80DFFF8, $FBFC0028
		dc.l    $F8010170, $00B80048
;-------------------------------------------------------------------------------                
; Mapeamento da tela de resultado das fases
; <<<-                
;-------------------------------------------------------------------------------  
    
;-------------------------------------------------------------------------------                
; Mapeamento da tela de resultado dos estágios especiais
; ->>>                
;-------------------------------------------------------------------------------
Special_Stage_Results_Mappings:                                ; Offset_0x00C5AA
		dc.w    SS_Res_CHAOS_EMERALDS_Map-Special_Stage_Results_Mappings ; Offset_0x00C5BC
		dc.w    SS_Res_SCORE_Map-Special_Stage_Results_Mappings ; Offset_0x00C626 
		dc.w    SS_Res_RING_BONUS_Map-Special_Stage_Results_Mappings ; Offset_0x00C658
		dc.w    TC_Oval_Map-Special_Stage_Results_Mappings ; Offset_0x00C39A
		dc.w    SS_Res_CONTINUE_Frame1_Map-Special_Stage_Results_Mappings ; Offset_0x00C692
		dc.w    SS_Res_CONTINUE_Frame2_Map-Special_Stage_Results_Mappings ; Offset_0x00C6B4
		dc.w    SS_Res_CONTINUE_Frame3_Map-Special_Stage_Results_Mappings ; Offset_0x00C6D6
		dc.w    SS_Res_SPECIAL_STAGE_Map-Special_Stage_Results_Mappings ; Offset_0x00C6F0
		dc.w    SS_Res_SONIC_GOT_THEM_ALL_Map-Special_Stage_Results_Mappings ; Offset_0x00C752
SS_Res_CHAOS_EMERALDS_Map:                                     ; Offset_0x00C5BC
		dc.w    $000D
		dc.l    $F8050008, $0004FF90  ; C
		dc.l    $F805001C, $000EFFA0  ; H
		dc.l    $F8050000, $0000FFB0  ; A
		dc.l    $F8050032, $0019FFC0  ; O
		dc.l    $F805003E, $001FFFD0  ; S
		dc.l    $F8050010, $0008FFF0  ; E
		dc.l    $F805002A, $00150000  ; M
		dc.l    $F8050010, $00080010  ; E
		dc.l    $F805003A, $001D0020  ; R
		dc.l    $F8050000, $00000030  ; A
		dc.l    $F8050026, $00130040  ; L
		dc.l    $F805000C, $00060050  ; D
		dc.l    $F805003E, $001F0060  ; S
SS_Res_SCORE_Map:                                              ; Offset_0x00C626
		dc.w    $0006
		dc.l    $F80D014A, $00A5FFB0  ; SCOR
		dc.l    $F8010162, $00B1FFD0  ; E
		dc.l    $F8090164, $00B20018
		dc.l    $F80D016A, $00B50030
		dc.l    $F704006E, $0037FFCD
		dc.l    $FF04186E, $1837FFCD
SS_Res_RING_BONUS_Map:                                         ; Offset_0x00C658
		dc.w    $0007
		dc.l    $F80D0152, $00A9FFB0  ; RING
		dc.l    $F80D0066, $0033FFD9  ; BONU
		dc.l    $F801014A, $00A5FFF9  ; S
		dc.l    $F704006E, $0037FFF6
		dc.l    $FF04186E, $1837FFF6
		dc.l    $F80DFFF8, $FBFC0028
		dc.l    $F8010170, $00B80048
SS_Res_CONTINUE_Frame1_Map:                                    ; Offset_0x00C692
		dc.w    $0004
		dc.l    $F80DFFD1, $7FC8FFB0
		dc.l    $F80DFFD9, $7FD4FFD0
		dc.l    $F801FFE1, $7FE0FFF0
		dc.l    $F8061FE3, $2FE30040
SS_Res_CONTINUE_Frame2_Map:                                    ; Offset_0x00C6B4
		dc.w    $0004
		dc.l    $F80DFFD1, $7FC8FFB0
		dc.l    $F80DFFD9, $7FD4FFD0
		dc.l    $F801FFE1, $7FE0FFF0
		dc.l    $F8061FE9, $2FEC0040
SS_Res_CONTINUE_Frame3_Map:                                    ; Offset_0x00C6D6
		dc.w    $0003
		dc.l    $F80DFFD1, $7FC8FFB0
		dc.l    $F80DFFD9, $7FD4FFD0
		dc.l    $F801FFE1, $7FE0FFF0
SS_Res_SPECIAL_STAGE_Map:                                      ; Offset_0x00C6F0
		dc.w    $000C
		dc.l    $F805003E, $001FFF9C  ; S
		dc.l    $F8050036, $001BFFAC  ; P
		dc.l    $F8050010, $0008FFBC  ; E
		dc.l    $F8050008, $0004FFCC  ; C
		dc.l    $F8010020, $0010FFDC  ; I
		dc.l    $F8050000, $0000FFE4  ; A
		dc.l    $F8050026, $0013FFF4  ; L
		dc.l    $F805003E, $001F0014  ; S
		dc.l    $F8050042, $00210024  ; T
		dc.l    $F8050000, $00000034  ; A
		dc.l    $F8050018, $000C0044  ; G
		dc.l    $F8050010, $00080054  ; E
SS_Res_SONIC_GOT_THEM_ALL_Map:                                 ; Offset_0x00C752
		dc.w    $000F
		dc.l    $F805003E, $001FFF88  ; S
		dc.l    $F8050032, $0019FF98  ; O
		dc.l    $F805002E, $0017FFA8  ; N
		dc.l    $F8010020, $0010FFB8  ; I
		dc.l    $F8050008, $0004FFC0  ; C
		dc.l    $F8050018, $000CFFD8  ; G
		dc.l    $F8050032, $0019FFE8  ; O
		dc.l    $F8050042, $0021FFF8  ; T
		dc.l    $F8050042, $00210010  ; T
		dc.l    $F805001C, $000E0020  ; H
		dc.l    $F8050010, $00080030  ; E
		dc.l    $F805002A, $00150040  ; M
		dc.l    $F8050000, $00000058  ; A
		dc.l    $F8050026, $00130068  ; L
		dc.l    $F8050026, $00130078  ; L
;-------------------------------------------------------------------------------                
; Mapeamento da tela de resultado dos estágios especiais
; <<<-                
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------                
; Mapeamento das esmeraldas usadas na tela de resultado dos estágios especiais
; ->>>                
;-------------------------------------------------------------------------------
Emeralds_Mappings:                                             ; Offset_0x00C7CC
		dc.w    Offset_0x00C7DA-Emeralds_Mappings
		dc.w    Offset_0x00C7E4-Emeralds_Mappings
		dc.w    Offset_0x00C7EE-Emeralds_Mappings
		dc.w    Offset_0x00C7F8-Emeralds_Mappings
		dc.w    Offset_0x00C802-Emeralds_Mappings
		dc.w    Offset_0x00C80C-Emeralds_Mappings
		dc.w    Offset_0x00C816-Emeralds_Mappings
Offset_0x00C7DA:
		dc.w    $0001
		dc.l    $F8052004, $2002FFF8
Offset_0x00C7E4:
		dc.w    $0001
		dc.l    $F8050000, $0000FFF8
Offset_0x00C7EE:
		dc.w    $0001
		dc.l    $F8054004, $4002FFF8
Offset_0x00C7F8:
		dc.w    $0001
		dc.l    $F8056004, $6002FFF8
Offset_0x00C802:
		dc.w    $0001
		dc.l    $F8052008, $2004FFF8
Offset_0x00C80C:
		dc.w    $0001
		dc.l    $F805200C, $2006FFF8
Offset_0x00C816:
		dc.w    $0000
;-------------------------------------------------------------------------------                
; Mapeamento das esmeraldas usadas na tela de resultado dos estágios especiais
; <<<-                
;-------------------------------------------------------------------------------
Obj_0x36_Spikes:                                               ; Offset_0x00C818
		include 'objects/obj_0x36.asm'
Obj_0x3B_Rock:                                                 ; Offset_0x00CBD4    
		include 'objects/obj_0x3B.asm'                         
;-------------------------------------------------------------------------------
		dc.w    $0000                   
;-------------------------------------------------------------------------------
Obj_0x3C_Breakable_Wall:                                       ; Offset_0x00CC50
		include 'objects/obj_0x3C.asm' 
Obj_Null:                                                      ; Offset_0x00CEA4
		bra     Obj_Null_2                             ; Offset_0x00D1AA            
;===============================================================================
; Carrega os objetos na memória     
; ->>>
;===============================================================================
Load_Objects:                                                  ; Offset_0x00CEA8
		lea     (Obj_Memory_Address).w, A0                   ; $FFFFB000
		moveq   #$7F, D7
		moveq   #$00, D0
		cmpi.b  #$06, (Player_One+Obj_Routine).w             ; $FFFFB024
		bcc.s   Offset_0x00CED2
Loop_Load_Object:                                              ; Offset_0x00CEB8
		move.b  (A0), D0
		beq.s   Load_Next_Object                       ; Offset_0x00CEC8
		add.w   D0, D0
		add.w   D0, D0
		move.l  Object_List-$0004(PC, D0), A1          ; Offset_0x00CEEE
		jsr     (A1)                                  
		moveq   #$00, D0
Load_Next_Object:                                              ; Offset_0x00CEC8
		lea     Obj_Size(A0), A0                                 ; $0040
		dbra    D7, Loop_Load_Object                   ; Offset_0x00CEB8
		rts
Offset_0x00CED2:
		moveq   #$1F, D7
		bsr.s   Loop_Load_Object                       ; Offset_0x00CEB8
		moveq   #$5F, D7
Loop_Load_Object_2:                                            ; Offset_0x00CED8
		moveq   #$00, D0
		move.b  (A0), D0
		beq.s   Load_Next_Object_2                     ; Offset_0x00CEE8
		tst.b   Obj_Flags(A0)                                    ; $0001
		bpl.s   Load_Next_Object_2                     ; Offset_0x00CEE8
		bsr     DisplaySprite                          ; Offset_0x00D322
Load_Next_Object_2:                                            ; Offset_0x00CEE8
		lea     Obj_Size(A0), A0                                 ; $0040
		dbra    D7, Loop_Load_Object_2                 ; Offset_0x00CED8
		rts
;-------------------------------------------------------------------------------
Object_List:                                                   ; Offset_0x00CEF2
		dc.l    Obj_0x01_Sonic                         ; Offset_0x00FAF0
		dc.l    Obj_0x02_Miles                         ; Offset_0x011130
		dc.l    Obj_0x03_Layer_Switch                  ; Offset_0x014DC8
		dc.l    Obj_0x04_Water_Surface                 ; Offset_0x0159CC
		dc.l    Obj_0x05_Miles_Tail                    ; Offset_0x012442
		dc.l    Obj_0x06_Spiral_Attributes             ; Offset_0x0163A8
		dc.l    Obj_0x07_0il_Attributes                ; Offset_0x018E50
		dc.l    Obj_0x08_Dust_Water_Splash             ; Offset_0x0131B0
		dc.l    Obj_0x09_Sonic_In_Special_Stage        ; Offset_0x02BF70
		dc.l    Obj_0x0A_Sonic_Miles_Underwater        ; Offset_0x01254C
		dc.l    Obj_0x0B_Open_Close_Platform           ; Offset_0x0151C4
		dc.l    Obj_0x0C_Unk_Platform                  ; Offset_0x01531C
		dc.l    Obj_0x0D_End_Panel                     ; Offset_0x00F098
		dc.l    Obj_0x0E_Sonic_Miles                   ; Offset_0x00B660
		dc.l    Obj_0x0F                               ; Offset_0x00B6E6
		dc.l    Obj_Null_3                             ; Offset_0x02C612
		dc.l    Obj_0x11_Bridge                        ; Offset_0x008468
		dc.l    Obj_0x12_HPz_Master_Emerald            ; Offset_0x015420
		dc.l    Obj_0x13_HPz_Waterfalls                ; Offset_0x0154A8
		dc.l    Obj_0x14_Seesaw                        ; Offset_0x016808
		dc.l    Obj_0x15_Bridge                        ; Offset_0x008A84
		dc.l    Obj_0x16_Teleferics                    ; Offset_0x016C8C
		dc.l    Obj_0x17_Log_Spikes                    ; Offset_0x009044
		dc.l    Obj_0x18_Platforms                     ; Offset_0x0091E0
		dc.l    Obj_0x19_Rotating_Platforms            ; Offset_0x016EB8
		dc.l    Obj_0x1A_Collapsing_Platforms          ; Offset_0x0095DC
		dc.l    Obj_0x1B_Speed_Booster                 ; Offset_0x017114
		dc.l    Obj_0x1C_Misc                          ; Offset_0x009EE8
		dc.l    Obj_0x1D_Worms                         ; Offset_0x01726C
		dc.l    Obj_0x1E_Tube_Attributes               ; Offset_0x0173E4
		dc.l    Obj_0x1F_Collapsing_Platforms          ; Offset_0x009728
		dc.l    Obj_0x20_HTz_Boss_FireBall             ; Offset_0x017E34
		dc.l    Obj_0x21_Head_Up_Display               ; Offset_0x02D100
		dc.l    Obj_0x22_Arrow_Shooter                 ; Offset_0x01A44C
		dc.l    Obj_0x23_Pillar                        ; Offset_0x01A644
		dc.l    Obj_0x24_Oxygen_Bubbles                ; Offset_0x0149CC
		dc.l    Obj_0x25_Rings                         ; Offset_0x00AA98
		dc.l    Obj_0x26_Monitors                      ; Offset_0x00B104
		dc.l    Obj_0x27_Object_Hit                    ; Offset_0x016174
		dc.l    Obj_0x28_Flickies                      ; Offset_0x00A3E8
		dc.l    Obj_0x29_Enemy_Points                  ; Offset_0x00A922
		dc.l    Obj_0x2A_Up_Down_Pillar                ; Offset_0x00A158
		dc.l    Obj_0x2B_Raising_Pillar                ; Offset_0x01A812
		dc.l    Obj_0x2C_Leaves                        ; Offset_0x01AEB8
		dc.l    Obj_0x2D_Automatic_Door                ; Offset_0x00A22E
		dc.l    Obj_0x2E_Monitors_Contents             ; Offset_0x00B2D2
		dc.l    Obj_0x2F_Breakable_Floor               ; Offset_0x01813C
		dc.l    Obj_0x30_Earthquake_Tiles_Attributes   ; Offset_0x01870C
		dc.l    Obj_0x31_Lava_Attributes               ; Offset_0x015EDC
		dc.l    Obj_0x32_Breakable_Obstacle            ; Offset_0x01834A
		dc.l    Obj_0x33_Touch_Booster                 ; Offset_0x018924
		dc.l    Obj_0x34_Title_Cards                   ; Offset_0x00BA00
		dc.l    Obj_0x35_Invincibility                 ; Offset_0x012B72
		dc.l    Obj_0x36_Spikes                        ; Offset_0x00C818
		dc.l    Obj_0x37_Rings_Lost                    ; Offset_0x00ABD2
		dc.l    Obj_0x38_Shield                        ; Offset_0x012AF0
		dc.l    Obj_0x39_Time_Over_Game_Over           ; Offset_0x00BC44
		dc.l    Obj_0x3A_Level_Results                 ; Offset_0x00BD06
		dc.l    Obj_0x3B_Rock                          ; Offset_0x00CBD4
		dc.l    Obj_0x3C_Breakable_Wall                ; Offset_0x00CC50
		dc.l    Obj_0x3D_Break_Boost                   ; Offset_0x019BF8
		dc.l    Obj_0x3E_Egg_Prison                    ; Offset_0x02AEE8
		dc.l    Obj_0x3F_Fans                          ; Offset_0x01F538
		dc.l    Obj_0x40_Diagonal_Springs              ; Offset_0x01B12C
		dc.l    Obj_0x41_Springs                       ; Offset_0x00E744
		dc.l    Obj_0x42_Steam_Vent                    ; Offset_0x01B3EC
		dc.l    Obj_0x43_Giant_Spikeball               ; Offset_0x018C70
		dc.l    Obj_0x44_Red_Ball_Bumper               ; Offset_0x01486C
		dc.l    Obj_0x45_Spring_Push_Boost             ; Offset_0x018F20
		dc.l    Obj_0x46_Spring_Ball                   ; Offset_0x01983E
		dc.l    Obj_0x47_Switch                        ; Offset_0x019B1C
		dc.l    Obj_0x48_Cannon                        ; Offset_0x01A03C
		dc.l    Obj_0x49_Waterfall                     ; Offset_0x015C8E
		dc.l    Obj_0x4A_Octus                         ; Offset_0x021704
		dc.l    Obj_0x4B_Buzzer                        ; Offset_0x023F78
		dc.l    Obj_0x4C_Batbot                        ; Offset_0x01FA18
		dc.l    Obj_0x4D_Rhinobot                      ; Offset_0x0228EC
		dc.l    Obj_0x4E_Crocobot                      ; Offset_0x021160
		dc.l    Obj_0x4F_Dinobot                       ; Offset_0x0219B4
		dc.l    Obj_0x50_Aquis                         ; Offset_0x021DAC
		dc.l    Obj_0x51_CNz_Boss                      ; Offset_0x0271CC
		dc.l    Obj_0x52_HTz_Boss                      ; Offset_0x025860
		dc.l    Obj_0x53_Mz_Boss_Balls_Robotniks       ; Offset_0x027B80
		dc.l    Obj_0x54_Mz_Boss                       ; Offset_0x027A90
		dc.l    Obj_0x55_Mz_Boss                       ; Offset_0x027A90
		dc.l    Obj_0x56_GHz_Boss                      ; Offset_0x0200F8
		dc.l    Obj_0x57_DHz_Boss                      ; Offset_0x026990               
		dc.l    Obj_0x58_GHz_Boss                      ; Offset_0x020372
		dc.l    Obj_0x59_Motobug                       ; Offset_0x022638
		dc.l    Obj_0x5A                               ; Offset_0x021B18
		dc.l    Obj_0x5B_GHz_Boss                      ; Offset_0x020786
		dc.l    Obj_0x5C_Masher                        ; Offset_0x024294
		dc.l    Obj_0x5D                               ; Offset_0x024394
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_0x64_Pistons                       ; Offset_0x01B6D4
		dc.l    Obj_0x65_Platform_Over_Gear            ; Offset_0x01B894
		dc.l    Obj_0x66_Springs_Wall                  ; Offset_0x01BCF4
		dc.l    Obj_0x67_Teleport_Attributes           ; Offset_0x01BEFC
		dc.l    Obj_0x68_Block_Harpon                  ; Offset_0x01C334
		dc.l    Obj_0x69_Screw_Nut                     ; Offset_0x01C624
		dc.l    Obj_0x6A_DHz_Three_Boxes_Mz_Ptfrm      ; Offset_0x01C850
		dc.l    Obj_0x6B_Mz_Platform                   ; Offset_0x01CB0C
		dc.l    Obj_0x6C_Mz_Moving_Platforms           ; Offset_0x01CDC8
		dc.l    Obj_0x6D_Harpoon                       ; Offset_0x01C534
		dc.l    Obj_0x6E_Machine                       ; Offset_0x01D140
		dc.l    Obj_Ox6F_Parallelogram_Elevator        ; Offset_0x01D354
		dc.l    Obj_0x70_Rotating_Gears                ; Offset_0x01D6AC
		dc.l    Obj_0x71_Mz_HPz_Misc                   ; Offset_0x009FA0
		dc.l    Obj_0x72_Conveyor_Belt_Attributes      ; Offset_0x01DA28
		dc.l    Obj_0x73_Rotating_Rings                ; Offset_0x01DAB0
		dc.l    Obj_0x74_Invisible_Block               ; Offset_0x015FBA
		dc.l    Obj_0x75_Spikeball_Chain               ; Offset_0x01DCA4
		dc.l    Obj_0x76_Platform_Spikes               ; Offset_0x01DED4
		dc.l    Obj_0x77_Bridge                        ; Offset_0x01E064
		dc.l    Obj_0x78_Stair_Case_Platforms          ; Offset_0x01E2A8
		dc.l    Obj_0x79_Lamp_Post                     ; Offset_0x0144C0
		dc.l    Obj_0x7A_Platform_Horizontal           ; Offset_0x01E47C
		dc.l    Obj_0x7B_Spring_Tubes                  ; Offset_0x01E66C
		dc.l    Obj_0x7C_Metal_Structure               ; Offset_0x0160BE
		dc.l    Obj_0x7D_Hidden_Bonus                  ; Offset_0x014768
		dc.l    Obj_0x7E_Super_Sonic_Stars             ; Offset_0x013552
		dc.l    Obj_0x7F_Vines_Switch                  ; Offset_0x01E8A4
		dc.l    Obj_0x80_Vines_Chain_Hook              ; Offset_0x01EA30
		dc.l    Obj_0x81_Vertical_Bridge               ; Offset_0x01ED8C
		dc.l    Obj_0x82_Falling_Pillar                ; Offset_0x01F018
		dc.l    Obj_0x83_Three_Rotating_Platforms      ; Offset_0x01F284
		dc.l    Obj_0x84_Auto_Spin                     ; Offset_0x016248
		dc.l    Obj_Null_2                             ; Offset_0x00D1AA
		dc.l    Obj_Null_2                             ; Offset_0x00D1AA
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_Null                               ; Offset_0x00CEA4
		dc.l    Obj_0x89_NGHz_Boss                     ; Offset_0x025FE0
		dc.l    Obj_0x8A_S1_Credits                    ; Offset_0x02A7CC
		dc.l    Obj_Null_2                             ; Offset_0x00D1AA
		dc.l    Obj_0x8C_NGHz_Whisp                    ; Offset_0x027F84
		dc.l    Obj_0x8D_Hidden_Grounder               ; Offset_0x0280A0
		dc.l    Obj_0x8E_Grounder                      ; Offset_0x0280A0
		dc.l    Obj_0x8F_Wall_Hidden_Grounder          ; Offset_0x02819E
		dc.l    Obj_0x90_Rock_Hidden_Grounder          ; Offset_0x0281E4
		dc.l    Obj_0x91_Chop_Chop                     ; Offset_0x0283BC
		dc.l    Obj_0x92_Spiker                        ; Offset_0x02851E
		dc.l    Obj_0x93_Spiker_Drill                  ; Offset_0x0285F8
		dc.l    Obj_0x94_Rexon_Body                    ; Offset_0x02891E
		dc.l    Obj_0x95_Sol                           ; Offset_0x0286FA
		dc.l    Obj_0x96_Rexon_Body                    ; Offset_0x02891E
		dc.l    Obj_0x97_Rexon_Head                    ; Offset_0x0289CC
		dc.l    Obj_0x98_Enemies_Weapons               ; Offset_0x028CE4
		dc.l    Obj_0x99_Nebula                        ; Offset_0x028DA2
		dc.l    Obj_0x9A_Turtloid                      ; Offset_0x028F08
		dc.l    Obj_0x9B_Turtloid_Rider                ; Offset_0x028FE4
		dc.l    Obj_0x9C_Enemy_Boost                   ; Offset_0x029060
		dc.l    Obj_0x9D_Coconuts                      ; Offset_0x0291D8
		dc.l    Obj_0x9E_Crawlton                      ; Offset_0x0293F4
		dc.l    Obj_0x9F_Shellcracker                  ; Offset_0x0295B2
		dc.l    Obj_0xA0_Shellcracker_Craw             ; Offset_0x0296DE
		dc.l    Obj_0xA1_Slicer                        ; Offset_0x029906
		dc.l    Obj_0xA2_Slicer_Pincers                ; Offset_0x0299CE
		dc.l    Obj_0xA3_Flasher                       ; Offset_0x029C34
		dc.l    Obj_0xA4_Asteron                       ; Offset_0x029E94
		dc.l    Obj_0xA5_Horizontal_Spiny              ; Offset_0x02A004
		dc.l    Obj_0xA6_Vertical_Spiny                ; Offset_0x02A0A0
		dc.l    Obj_0xA7_Grabber                       ; Offset_0x02A2D4
		dc.l    Obj_0xA8_Grabber_Sub                   ; Offset_0x02A2EE
		dc.l    Obj_0xA9_Grabber_Sub                   ; Offset_0x02A308
		dc.l    Obj_0xAA_Grabber_Sub                   ; Offset_0x02A322
		dc.l    Obj_0xAB_Grabber_Sub                   ; Offset_0x02A33C
		dc.l    Obj_0xAC_Balkiry                       ; Offset_0x02A3F4
		dc.l    Obj_0xAD_Clucker_Platform              ; Offset_0x02A47E
		dc.l    Obj_0xAE_Clucker                       ; Offset_0x02A4D0                
;===============================================================================
; Carrega os objetos na memória     
; <<<-
;===============================================================================

;-------------------------------------------------------------------------------  
Obj_Null_2:                                                    ; Offset_0x00D1AA
		bra     DeleteObject                           ; Offset_0x00D314 
;-------------------------------------------------------------------------------  
ObjectFall:                                                    ; Offset_0x00D1AE
		move.l  Obj_X(A0), D2                                    ; $0008
		move.l  Obj_Y(A0), D3                                    ; $000C
		move.w  Obj_Speed(A0), D0                                ; $0010
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  Obj_Speed_Y(A0), D0                              ; $0012
		addi.w  #$0038, Obj_Speed_Y(A0)                          ; $0012
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, Obj_X(A0)                                    ; $0008
		move.l  D3, Obj_Y(A0)                                    ; $000C
		rts      
;-------------------------------------------------------------------------------
SpeedToPos:                                                    ; Offset_0x00D1DA
		move.l  Obj_X(A0), D2                                    ; $0008
		move.l  Obj_Y(A0), D3                                    ; $000C
		move.w  Obj_Speed(A0), D0                                ; $0010
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  Obj_Speed_Y(A0), D0                              ; $0012
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, Obj_X(A0)                                    ; $0008
		move.l  D3, Obj_Y(A0)                                    ; $000C
		rts    
;-------------------------------------------------------------------------------
MarkObjGone:                                                   ; Offset_0x00D200
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x00D20A
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D20A:
		move.w  Obj_X(A0), D0                                    ; $0008
		andi.w  #$FF80, D0
		sub.w   ($FFFFF7DA).w, D0
		cmpi.w  #$0280, D0
		bhi     Offset_0x00D222
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D222:
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D0
		move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
		beq.s   Offset_0x00D234
		bclr    #$07, $02(A2, D0)
Offset_0x00D234:
		bra     DeleteObject                           ; Offset_0x00D314
;-------------------------------------------------------------------------------
MarkObjGone_2:                                                 ; Offset_0x00D238
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x00D242
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D242:
		andi.w  #$FF80, D0
		sub.w   ($FFFFF7DA).w, D0
		cmpi.w  #$0280, D0
		bhi     Offset_0x00D256
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D256:
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D0
		move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
		beq.s   Offset_0x00D268
		bclr    #$07, $02(A2, D0)
Offset_0x00D268:
		bra     DeleteObject                           ; Offset_0x00D314
;-------------------------------------------------------------------------------
MarkObjGone_3:                                                 ; Offset_0x00D26C
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x00D274
		rts
Offset_0x00D274:
		move.w  Obj_X(A0), D0                                    ; $0008
		andi.w  #$FF80, D0
		sub.w   ($FFFFF7DA).w, D0
		cmpi.w  #$0280, D0
		bhi     Offset_0x00D28A
		rts
Offset_0x00D28A:
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D0
		move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
		beq.s   Offset_0x00D29C
		bclr    #$07, $02(A2, D0)
Offset_0x00D29C:
		bra     DeleteObject                           ; Offset_0x00D314     
;-------------------------------------------------------------------------------
MarkObjGone_4:                                                 ; Offset_0x00D2A0
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   MarkObjGone_4_2P                       ; Offset_0x00D2D4
		move.w  Obj_X(A0), D0                                    ; $0008
		andi.w  #$FF80, D0
		sub.w   ($FFFFF7DA).w, D0
		cmpi.w  #$0280, D0
		bhi     Offset_0x00D2BE
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D2BE:
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D0
		move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
		beq.s   Offset_0x00D2D0
		bclr    #$07, $02(A2, D0)
Offset_0x00D2D0:
		bra     DeleteObject                           ; Offset_0x00D314
MarkObjGone_4_2P                                               ; Offset_0x00D2D4
		move.w  Obj_X(A0), D0                                    ; $0008
		andi.w  #$FF00, D0
		move.w  D0, D1
		sub.w   ($FFFFF7DA).w, D0
		cmpi.w  #$0300, D0
		bhi     Offset_0x00D2EE
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D2EE:
		sub.w   ($FFFFF7DC).w, D1
		cmpi.w  #$0300, D1
		bhi     Offset_0x00D2FE
		bra     DisplaySprite                          ; Offset_0x00D322
Offset_0x00D2FE:
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D0
		move.b  Obj_Respaw_Ref(A0), D0                           ; $0023
		beq.s   Offset_0x00D310
		bclr    #$07, $02(A2, D0)
Offset_0x00D310:
		bra     DeleteObject                           ; Offset_0x00D314
;===============================================================================
; Rotinas para limpar a memória alocada pelo objeto   
; ->>>
;===============================================================================  
DeleteObject:                                                  ; Offset_0x00D314
		move.l  A0, A1
DeleteObject_A1:                                               ; Offset_0x00D316                
		moveq   #$00, D1
		moveq   #$0F, D0
DeleteObject_FreeRam_Loop:                                     ; Offset_0x00D31A
		move.l  D1, (A1)+
		dbra    D0, DeleteObject_FreeRam_Loop          ; Offset_0x00D31A
		rts 
;===============================================================================
; Rotinas para limpar a memória alocada pelo objeto   
; <<<-
;===============================================================================

;===============================================================================
; Rotinas para exibição do sprite   
; ->>>
;=============================================================================== 
DisplaySprite:                                                 ; Offset_0x00D322
		lea     ($FFFFAC00).w, A1
		move.w  Obj_Priority(A0), D0                             ; $0018
		lsr.w   #$01, D0
		andi.w  #$0380, D0
		adda.w  D0, A1
		cmpi.w  #$007E, (A1)
		bcc.s   Exit_DisplaySprite                     ; Offset_0x00D33E
		addq.w  #$02, (A1)
		adda.w  (A1), A1
		move.w  A0, (A1)
Exit_DisplaySprite:                                            ; Offset_0x00D33E
		rts    
;-------------------------------------------------------------------------------
DisplaySprite_A1:                                              ; Offset_0x00D340
		lea     ($FFFFAC00).w, A2
		move.w  Obj_Priority(A1), D0                             ; $0018
		lsr.w   #$01, D0
		andi.w  #$0380, D0
		adda.w  D0, A2
		cmpi.w  #$007E, (A2)
		bcc.s   Exit_DisplaySprite_A1                  ; Offset_0x00D35C
		addq.w  #$02, (A2)
		adda.w  (A2), A2
		move.w  A1, (A2)
Exit_DisplaySprite_A1:                                         ; Offset_0x00D35C
		rts     
;-------------------------------------------------------------------------------
DisplaySprite_Param:                                           ; Offset_0x00D35E
		lea     ($FFFFAC00).w, A1
		adda.w  D0, A1
		cmpi.w  #$007E, (A1)
		bcc.s   Exit_DisplaySprite_Param               ; Offset_0x00D370
		addq.w  #$02, (A1)
		adda.w  (A1), A1
		move.w  A0, (A1)
Exit_DisplaySprite_Param:                                      ; Offset_0x00D370
		rts
;===============================================================================
; Rotinas para exibição do sprite   
; <<<-
;===============================================================================
 
;===============================================================================
; Rotina para animação do sprite   
; ->>>
;===============================================================================      
AnimateSprite:                                                 ; Offset_0x00D372
		moveq   #$00, D0
		move.b  Obj_Ani_Number(A0), D0                           ; $001C
		cmp.b   Obj_Ani_Flag(A0), D0                             ; $001D
		beq.s   Offset_0x00D38E
		move.b  D0, Obj_Ani_Flag(A0)                             ; $001D
		move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
		move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
Offset_0x00D38E:
		subq.b  #$01, Obj_Ani_Time(A0)                           ; $001E
		bpl.s   Offset_0x00D3C8
		add.w   D0, D0
		adda.w  $00(A1, D0), A1
		move.b  (A1), Obj_Ani_Time(A0)                           ; $001E
		moveq   #$00, D1
		move.b  Obj_Ani_Frame(A0), D1                            ; $001B
		move.b  $01(A1, D1), D0
		bmi.s   Offset_0x00D3CA
Offset_0x00D3AA:
		andi.b  #$7F, D0
		move.b  D0, Obj_Map_Id(A0)                               ; $001A
		move.b  Obj_Status(A0), D1                               ; $0022
		andi.b  #$03, D1
		andi.b  #$FC, Obj_Flags(A0)                              ; $0001
		or.b    D1, Obj_Flags(A0)                                ; $0001
		addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
Offset_0x00D3C8:
		rts
Offset_0x00D3CA:
		addq.b  #$01, D0
		bne.s   Offset_0x00D3DA
		move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
		move.b  Obj_Flags(A1), D0                                ; $0001
		bra.s   Offset_0x00D3AA
Offset_0x00D3DA:
		addq.b  #$01, D0
		bne.s   Offset_0x00D3EE
		move.b  $02(A1, D1), D0
		sub.b   D0, Obj_Ani_Frame(A0)                            ; $001B
		sub.b   D0, D1
		move.b  $01(A1, D1), D0
		bra.s   Offset_0x00D3AA
Offset_0x00D3EE:
		addq.b  #$01, D0
		bne.s   Offset_0x00D3FA
		move.b  $02(A1, D1), Obj_Ani_Number(A0)                  ; $001C
		rts
Offset_0x00D3FA:
		addq.b  #$01, D0
		bne.s   Offset_0x00D40E
		addq.b  #$02, Obj_Routine(A0)                            ; $0024
		move.b  #$00, Obj_Ani_Time(A0)                           ; $001E
		addq.b  #$01, Obj_Ani_Frame(A0)                          ; $001B
		rts
Offset_0x00D40E:
		addq.b  #$01, D0
		bne.s   Offset_0x00D41E
		move.b  #$00, Obj_Ani_Frame(A0)                          ; $001B
		clr.b   Obj_Routine_2(A0)                                ; $0025
		rts
Offset_0x00D41E:
		addq.b  #$01, D0
		bne.s   Offset_0x00D428
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		rts
Offset_0x00D428:
		addq.b  #$01, D0
		bne.s   Offset_0x00D430
		addq.b  #$02, Obj_Timer(A0)                              ; $002A
Offset_0x00D430:
		rts
;===============================================================================
; Rotina para animação do sprite   
; <<<-
;===============================================================================     
				      
;===============================================================================
; Rotina para compilar os sprites de acordo com as definições dos objetos
; ->>>
;===============================================================================
Build_Sprites_Screen_Pos:                                      ; Offset_0x00D432
		dc.l    $00000000, $FFFFEEF0, $FFFFEE08, $FFFFEE18
;-------------------------------------------------------------------------------                
Build_Sprites:                                                 ; Offset_0x00D442
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne     Build_Sprites_2P                       ; Offset_0x00D7A2
		lea     ($FFFFF800).w, A2
		moveq   #$00, D5
		moveq   #$00, D4
		tst.b   ($FFFFF711).w
		beq.s   Offset_0x00D45C
		bsr     Build_Rings                            ; Offset_0x00DFAC
Offset_0x00D45C:
		lea     ($FFFFAC00).w, A4
		moveq   #$07, D7
Offset_0x00D462:
		tst.w   (A4)
		beq     Offset_0x00D53C
		moveq   #$02, D6
Offset_0x00D46A:
		move.w  $00(A4, D6), A0
		tst.b   (A0)
		beq     Offset_0x00D55E
		tst.l   Obj_Map(A0)                                      ; $0004
		beq     Offset_0x00D55E
		andi.b  #$7F, Obj_Flags(A0)                              ; $0001
		move.b  Obj_Flags(A0), D0                                ; $0001
		move.b  D0, D4
		btst    #$06, D0
		bne     Offset_0x00D560
		andi.w  #$000C, D0
		beq.s   Offset_0x00D4E8
		move.l  Build_Sprites_Screen_Pos(PC, D0), A1   ; Offset_0x00D432
		moveq   #$00, D0
		move.b  Obj_Width(A0), D0                                ; $0019
		move.w  Obj_X(A0), D3                                    ; $0008
		sub.w   (A1), D3
		move.w  D3, D1
		add.w   D0, D1
		bmi     Offset_0x00D534
		move.w  D3, D1
		sub.w   D0, D1
		cmpi.w  #$0140, D1
		bge     Offset_0x00D534
		addi.w  #$0080, D3
		btst    #$04, D4
		beq.s   Offset_0x00D4F2
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A1), D2                                  ; $0004
		move.w  D2, D1
		add.w   D0, D1
		bmi.s   Offset_0x00D534
		move.w  D2, D1
		sub.w   D0, D1
		cmpi.w  #$00E0, D1
		bge.s   Offset_0x00D534
		addi.w  #$0080, D2
		bra.s   Offset_0x00D50E
Offset_0x00D4E8:
		move.w  Obj_Sub_Y(A0), D2                                ; $000A
		move.w  Obj_X(A0), D3                                    ; $0008
		bra.s   Offset_0x00D50E
Offset_0x00D4F2:
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A1), D2                                  ; $0004
		addi.w  #$0080, D2
		andi.w  #$07FF, D2
		cmpi.w  #$0060, D2
		bcs.s   Offset_0x00D534
		cmpi.w  #$0180, D2
		bcc.s   Offset_0x00D534
Offset_0x00D50E:
		move.l  Obj_Map(A0), A1                                  ; $0004
		moveq   #$00, D1
		btst    #$05, D4
		bne.s   Offset_0x00D52A
		move.b  Obj_Map_Id(A0), D1                               ; $001A
		add.w   D1, D1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00D52E
Offset_0x00D52A:
		bsr     Offset_0x00D656
Offset_0x00D52E:
		ori.b   #$80, Obj_Flags(A0)                              ; $0001
Offset_0x00D534:
		addq.w  #$02, D6
		subq.w  #$02, (A4)
		bne     Offset_0x00D46A
Offset_0x00D53C:
		lea     $0080(A4), A4
		dbra    D7, Offset_0x00D462
		move.b  D5, ($FFFFF62C).w
		cmpi.b  #$50, D5
		beq.s   Offset_0x00D556
		move.l  #$00000000, (A2)
		rts
Offset_0x00D556:
		move.b  #$00, $FFFFFFFB(a2)
		rts
Offset_0x00D55E:
		bra.s   Offset_0x00D534
Offset_0x00D560:
		move.l  A4, -(A7)
		lea     (Camera_X).w, A4                             ; $FFFFEE00
		move.w  Obj_Art_VRAM(A0), A3                             ; $0002
		move.l  Obj_Map(A0), A5                                  ; $0004
		moveq   #$00, D0
		move.b  $000E(A0), D0
		move.w  Obj_X(A0), D3                                    ; $0008
		sub.w   (A4), D3
		move.w  D3, D1
		add.w   D0, D1
		bmi     Offset_0x00D648
		move.w  D3, D1
		sub.w   D0, D1
		cmpi.w  #$0140, D1
		bge     Offset_0x00D648
		addi.w  #$0080, D3
		btst    #$04, D4
		beq.s   Offset_0x00D5C0
		moveq   #$00, D0
		move.b  Obj_Inertia(A0), D0                              ; $0014
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A4), D2                                  ; $0004
		move.w  D2, D1
		add.w   D0, D1
		bmi     Offset_0x00D648
		move.w  D2, D1
		sub.w   D0, D1
		cmpi.w  #$00E0, D1
		bge     Offset_0x00D648
		addi.w  #$0080, D2
		bra.s   Offset_0x00D5DC
Offset_0x00D5C0:
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A4), D2                                  ; $0004
		addi.w  #$0080, D2
		andi.w  #$07FF, D2
		cmpi.w  #$0060, D2
		bcs.s   Offset_0x00D648
		cmpi.w  #$0180, D2
		bcc.s   Offset_0x00D648
Offset_0x00D5DC:
		moveq   #$00, D1
		move.b  Obj_Boss_Ani_Map(A0), D1                         ; $000B
		beq.s   Offset_0x00D5FA
		add.w   D1, D1
		move.l  A5, A1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00D5FA
		move.w  D4, -(A7)
		bsr     Offset_0x00D64E
		move.w  (A7)+, D4
Offset_0x00D5FA:
		ori.b   #$80, Obj_Flags(A0)                              ; $0001
		lea     Obj_Speed(A0), A6                                ; $0010
		moveq   #$00, D0
		move.b  Obj_Ani_Boss_Cnt(A0), D0                         ; $000F
		subq.w  #$01, D0
		bcs.s   Offset_0x00D648
Offset_0x00D60E:
		swap.w  D0
		move.w  (A6)+, D3
		sub.w   (A4), D3
		addi.w  #$0080, D3
		move.w  (A6)+, D2
		sub.w   Obj_Map(A4), D2                                  ; $0004
		addi.w  #$0080, D2
		andi.w  #$07FF, D2
		addq.w  #$01, A6
		moveq   #$00, D1
		move.b  (A6)+, D1
		add.w   D1, D1
		move.l  A5, A1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00D642
		move.w  D4, -(A7)
		bsr     Offset_0x00D64E
		move.w  (A7)+, D4
Offset_0x00D642:
		swap.w  D0
		dbra    D0, Offset_0x00D60E
Offset_0x00D648:
		move.l  (A7)+, A4
		bra     Offset_0x00D534
Offset_0x00D64E:
		cmpi.b  #$50, D5
		bcs.s   Offset_0x00D660
		rts
Offset_0x00D656:
		move.w  Obj_Art_VRAM(A0), A3                             ; $0002
		cmpi.b  #$50, D5
		bcc.s   Offset_0x00D696
Offset_0x00D660:
		btst    #$00, D4
		bne.s   Offset_0x00D698
		btst    #$01, D4
		bne     Build_Sprite_Upside_Down_Right         ; Offset_0x00D6F8
Build_Sprite_Right:                                            ; Offset_0x00D66E
		move.b  (A1)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		move.w  (A1)+, D0
		add.w   A3, D0
		move.w  D0, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00D690
		addq.w  #$01, D0
Offset_0x00D690:
		move.w  D0, (A2)+
		dbra    D1, Build_Sprite_Right                 ; Offset_0x00D66E
Offset_0x00D696:
		rts
Offset_0x00D698:
		btst    #$01, D4
		bne     Build_Sprite_Upside_Down_Left          ; Offset_0x00D740
Build_Sprite_Left:                                             ; Offset_0x00D6A0
		move.b  (A1)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  D4, (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		move.w  (A1)+, D0
		add.w   A3, D0
		eori.w  #$0800, D0
		move.w  D0, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		neg.w   D0
		move.b  Offset_0x00D6D8(PC, D4), D4
		sub.w   D4, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00D6D0
		addq.w  #$01, D0
Offset_0x00D6D0:
		move.w  D0, (A2)+
		dbra    D1, Build_Sprite_Left                  ; Offset_0x00D6A0
		rts 
;------------------------------------------------------------------------------- 
Offset_0x00D6D8:
		dc.b    $08, $08, $08, $08, $10, $10, $10, $10
		dc.b    $18, $18, $18, $18, $20, $20, $20, $20    
;-------------------------------------------------------------------------------   
Offset_0x00D6E8:
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20      
;-------------------------------------------------------------------------------       
Build_Sprite_Upside_Down_Right:                                ; Offset_0x00D6F8
		move.b  (A1)+, D0
		move.b  (A1), D4
		ext.w   D0
		neg.w   D0
		move.b  Offset_0x00D6E8(PC, D4), D4
		sub.w   D4, D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		move.w  (A1)+, D0
		add.w   A3, D0
		eori.w  #$1000, D0
		move.w  D0, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00D728
		addq.w  #$01, D0
Offset_0x00D728:
		move.w  D0, (A2)+
		dbra    D1, Build_Sprite_Upside_Down_Right     ; Offset_0x00D6F8
		rts            
;-------------------------------------------------------------------------------  
Offset_0x00D730:
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20  
;-------------------------------------------------------------------------------  
Build_Sprite_Upside_Down_Left:                                 ; Offset_0x00D740
		move.b  (A1)+, D0
		move.b  (A1), D4
		ext.w   D0
		neg.w   D0
		move.b  Offset_0x00D730(PC, D4), D4
		sub.w   D4, D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  D4, (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		move.w  (A1)+, D0
		add.w   A3, D0
		eori.w  #$1800, D0
		move.w  D0, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		neg.w   D0
		move.b  Offset_0x00D782(PC, D4), D4
		sub.w   D4, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00D77A
		addq.w  #$01, D0
Offset_0x00D77A:
		move.w  D0, (A2)+
		dbra    D1, Build_Sprite_Upside_Down_Left      ; Offset_0x00D740
		rts     
;-------------------------------------------------------------------------------
Offset_0x00D782:
		dc.b    $08, $08, $08, $08, $10, $10, $10, $10
		dc.b    $18, $18, $18, $18, $20, $20, $20, $20     
;-------------------------------------------------------------------------------
Build_Sprites_Screen_Pos_2P:                                   ; Offset_0x00D792
		dc.l    $00000000, $FFFFEE00, $FFFFEE08, $FFFFEE18      
;------------------------------------------------------------------------------- 
Build_Sprites_2P:                                              ; Offset_0x00D7A2
		tst.w   ($FFFFF644).w
		bne.s   Build_Sprites_2P                       ; Offset_0x00D7A2
		lea     ($FFFFF800).w, A2
		moveq   #$02, D5
		moveq   #$00, D4
		move.l  #$01D80F01, (A2)+
		move.l  #$00000001, (A2)+
		move.l  #$01D80F02, (A2)+
		move.l  #$00000000, (A2)+
		tst.b   ($FFFFF711).w
		beq.s   Offset_0x00D7D2
		bsr     Build_Rings_2P                         ; Offset_0x00E02C
Offset_0x00D7D2:
		lea     ($FFFFAC00).w, A4
		moveq   #$07, D7
Offset_0x00D7D8:
		move.w  (A4), D0
		beq     Offset_0x00D8B0
		move.w  D0, -(A7)
		moveq   #$02, D6
Offset_0x00D7E2:
		move.w  $00(A4, D6), A0
		tst.b   (A0)
		beq     Offset_0x00D8A6
		andi.b  #$7F, Obj_Flags(A0)                              ; $0001
		move.b  Obj_Flags(A0), D0                                ; $0001
		move.b  D0, D4
		btst    #$06, D0
		bne     Offset_0x00D9EA
		andi.w  #$000C, D0
		beq.s   Offset_0x00D856
		move.l  Build_Sprites_Screen_Pos_2P(PC, D0), A1 ; Offset_0x00D792
		moveq   #$00, D0
		move.b  Obj_Width(A0), D0                                ; $0019
		move.w  Obj_X(A0), D3                                    ; $0008
		sub.w   (A1), D3
		move.w  D3, D1
		add.w   D0, D1
		bmi     Offset_0x00D8A6
		move.w  D3, D1
		sub.w   D0, D1
		cmpi.w  #$0140, D1
		bge.s   Offset_0x00D8A6
		addi.w  #$0080, D3
		btst    #$04, D4
		beq.s   Offset_0x00D864
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A1), D2                                  ; $0004
		move.w  D2, D1
		add.w   D0, D1
		bmi.s   Offset_0x00D8A6
		move.w  D2, D1
		sub.w   D0, D1
		cmpi.w  #$00E0, D1
		bge.s   Offset_0x00D8A6
		addi.w  #$0100, D2
		bra.s   Offset_0x00D880
Offset_0x00D856:
		move.w  Obj_Sub_Y(A0), D2                                ; $000A
		move.w  Obj_X(A0), D3                                    ; $0008
		addi.w  #$0080, D2
		bra.s   Offset_0x00D880
Offset_0x00D864:
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A1), D2                                  ; $0004
		addi.w  #$0080, D2
		cmpi.w  #$0060, D2
		bcs.s   Offset_0x00D8A6
		cmpi.w  #$0180, D2
		bcc.s   Offset_0x00D8A6
		addi.w  #$0080, D2
Offset_0x00D880:
		move.l  Obj_Map(A0), A1                                  ; $0004
		moveq   #$00, D1
		btst    #$05, D4
		bne.s   Offset_0x00D89C
		move.b  Obj_Map_Id(A0), D1                               ; $001A
		add.w   D1, D1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00D8A0
Offset_0x00D89C:
		bsr     Build_Sprites_2P_Sub_01                ; Offset_0x00DBFE
Offset_0x00D8A0:
		ori.b   #$80, Obj_Flags(A0)                              ; $0001
Offset_0x00D8A6:
		addq.w  #$02, D6
		subq.w  #$02, (A7)
		bne     Offset_0x00D7E2
		addq.w  #$02, A7
Offset_0x00D8B0:
		lea     $0080(A4), A4
		dbra    D7, Offset_0x00D7D8
		move.b  D5, ($FFFFF62C).w
		cmpi.b  #$50, D5
		bcc.s   Offset_0x00D8CA
		move.l  #$00000000, (A2)
		bra.s   Offset_0x00D8E2
Offset_0x00D8CA:
		move.b  #$00, $FFFFFFFB(a2)
		bra.s   Offset_0x00D8E2
;-------------------------------------------------------------------------------
Offset_0x00D8D2:
		dc.l    $00000000, $FFFFEE20, $FFFFEE28, $FFFFEE38
;-------------------------------------------------------------------------------
Offset_0x00D8E2:
		lea     ($FFFFDD00).w, A2
		moveq   #$00, D5
		moveq   #$00, D4
		tst.b   ($FFFFF711).w
		beq.s   Offset_0x00D8F4
		bsr     Build_Rings_2P_Miles                   ; Offset_0x00E042
Offset_0x00D8F4:
		lea     ($FFFFAC00).w, A4
		moveq   #$07, D7
Offset_0x00D8FA:
		tst.w   (A4)
		beq     Offset_0x00D9C8
		moveq   #$02, D6
Offset_0x00D902:
		move.w  $00(A4, D6), A0
		tst.b   (A0)
		beq     Offset_0x00D9C0
		move.b  Obj_Flags(A0), D0                                ; $0001
		move.b  D0, D4
		btst    #$06, D0
		bne     Offset_0x00DAD4
		andi.w  #$000C, D0
		beq.s   Offset_0x00D970
		move.l  Offset_0x00D8D2(PC, D0), A1
		moveq   #$00, D0
		move.b  Obj_Width(A0), D0                                ; $0019
		move.w  Obj_X(A0), D3                                    ; $0008
		sub.w   (A1), D3
		move.w  D3, D1
		add.w   D0, D1
		bmi     Offset_0x00D9C0
		move.w  D3, D1
		sub.w   D0, D1
		cmpi.w  #$0140, D1
		bge.s   Offset_0x00D9C0
		addi.w  #$0080, D3
		btst    #$04, D4
		beq.s   Offset_0x00D97E
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A1), D2                                  ; $0004
		move.w  D2, D1
		add.w   D0, D1
		bmi.s   Offset_0x00D9C0
		move.w  D2, D1
		sub.w   D0, D1
		cmpi.w  #$00E0, D1
		bge.s   Offset_0x00D9C0
		addi.w  #$01E0, D2
		bra.s   Offset_0x00D99A
Offset_0x00D970:
		move.w  Obj_Sub_Y(A0), D2                                ; $000A
		move.w  Obj_X(A0), D3                                    ; $0008
		addi.w  #$0160, D2
		bra.s   Offset_0x00D99A
Offset_0x00D97E:
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A1), D2                                  ; $0004
		addi.w  #$0080, D2
		cmpi.w  #$0060, D2
		bcs.s   Offset_0x00D9C0
		cmpi.w  #$0180, D2
		bcc.s   Offset_0x00D9C0
		addi.w  #$0160, D2
Offset_0x00D99A:
		move.l  Obj_Map(A0), A1                                  ; $0004
		moveq   #$00, D1
		btst    #$05, D4
		bne.s   Offset_0x00D9B6
		move.b  Obj_Map_Id(A0), D1                               ; $001A
		add.w   D1, D1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00D9BA
Offset_0x00D9B6:
		bsr     Build_Sprites_2P_Sub_01                ; Offset_0x00DBFE
Offset_0x00D9BA:
		ori.b   #$80, Obj_Flags(A0)                              ; $0001
Offset_0x00D9C0:
		addq.w  #$02, D6
		subq.w  #$02, (A4)
		bne     Offset_0x00D902
Offset_0x00D9C8:
		lea     $0080(A4), A4
		dbra    D7, Offset_0x00D8FA
		move.b  D5, ($FFFFF62C).w
		cmpi.b  #$50, D5
		beq.s   Offset_0x00D9E2
		move.l  #$00000000, (A2)
		rts
Offset_0x00D9E2:
		move.b  #$00, $FFFFFFFB(a2)
		rts
Offset_0x00D9EA:
		move.l  A4, -(A7)
		lea     (Camera_X).w, A4                             ; $FFFFEE00
		move.w  Obj_Art_VRAM(A0), A3                             ; $0002
		move.l  Obj_Map(A0), A5                                  ; $0004
		moveq   #$00, D0
		move.b  $000E(A0), D0
		move.w  Obj_X(A0), D3                                    ; $0008
		sub.w   (A4), D3
		move.w  D3, D1
		add.w   D0, D1
		bmi     Offset_0x00DACE
		move.w  D3, D1
		sub.w   D0, D1
		cmpi.w  #$0140, D1
		bge     Offset_0x00DACE
		addi.w  #$0080, D3
		btst    #$04, D4
		beq.s   Offset_0x00DA4A
		moveq   #$00, D0
		move.b  Obj_Inertia(A0), D0                              ; $0014
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A4), D2                                  ; $0004
		move.w  D2, D1
		add.w   D0, D1
		bmi     Offset_0x00DACE
		move.w  D2, D1
		sub.w   D0, D1
		cmpi.w  #$00E0, D1
		bge     Offset_0x00DACE
		addi.w  #$0100, D2
		bra.s   Offset_0x00DA66
Offset_0x00DA4A:
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A4), D2                                  ; $0004
		addi.w  #$0080, D2
		cmpi.w  #$0060, D2
		bcs.s   Offset_0x00DACE
		cmpi.w  #$0180, D2
		bcc.s   Offset_0x00DACE
		addi.w  #$0080, D2
Offset_0x00DA66:
		moveq   #$00, D1
		move.b  Obj_Boss_Ani_Map(A0), D1                         ; $000B
		beq.s   Offset_0x00DA84
		add.w   D1, D1
		move.l  A5, A1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00DA84
		move.w  D4, -(A7)
		bsr     Build_Sprites_2P_Sub_00                ; Offset_0x00DBF6
		move.w  (A7)+, D4
Offset_0x00DA84:
		ori.b   #$80, Obj_Flags(A0)                              ; $0001
		lea     Obj_Speed(A0), A6                                ; $0010
		moveq   #$00, D0
		move.b  Obj_Ani_Boss_Cnt(A0), D0                         ; $000F
		subq.w  #$01, D0
		bcs.s   Offset_0x00DACE
Offset_0x00DA98:
		swap.w  D0
		move.w  (A6)+, D3
		sub.w   (A4), D3
		addi.w  #$0080, D3
		move.w  (A6)+, D2
		sub.w   Obj_Map(A4), D2                                  ; $0004
		addi.w  #$0100, D2
		addq.w  #$01, A6
		moveq   #$00, D1
		move.b  (A6)+, D1
		add.w   D1, D1
		move.l  A5, A1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00DAC8
		move.w  D4, -(A7)
		bsr     Build_Sprites_2P_Sub_00                ; Offset_0x00DBF6
		move.w  (A7)+, D4
Offset_0x00DAC8:
		swap.w  D0
		dbra    D0, Offset_0x00DA98
Offset_0x00DACE:
		move.l  (A7)+, A4
		bra     Offset_0x00D8A6
Offset_0x00DAD4:
		move.l  A4, -(A7)
		lea     (Camera_X_2).w, A4                           ; $FFFFEE20
		move.w  Obj_Art_VRAM(A0), A3                             ; $0002
		move.l  Obj_Map(A0), A5                                  ; $0004
		moveq   #$00, D0
		move.b  $000E(A0), D0
		move.w  Obj_X(A0), D3                                    ; $0008
		sub.w   (A4), D3
		move.w  D3, D1
		add.w   D0, D1
		bmi     Offset_0x00DBB8
		move.w  D3, D1
		sub.w   D0, D1
		cmpi.w  #$0140, D1
		bge     Offset_0x00DBB8
		addi.w  #$0080, D3
		btst    #$04, D4
		beq.s   Offset_0x00DB34
		moveq   #$00, D0
		move.b  Obj_Inertia(A0), D0                              ; $0014
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A4), D2                                  ; $0004
		move.w  D2, D1
		add.w   D0, D1
		bmi     Offset_0x00DBB8
		move.w  D2, D1
		sub.w   D0, D1
		cmpi.w  #$00E0, D1
		bge     Offset_0x00DBB8
		addi.w  #$01E0, D2
		bra.s   Offset_0x00DB50
Offset_0x00DB34:
		move.w  Obj_Y(A0), D2                                    ; $000C
		sub.w   Obj_Map(A4), D2                                  ; $0004
		addi.w  #$0080, D2
		cmpi.w  #$0060, D2
		bcs.s   Offset_0x00DBB8
		cmpi.w  #$0180, D2
		bcc.s   Offset_0x00DBB8
		addi.w  #$0160, D2
Offset_0x00DB50:
		moveq   #$00, D1
		move.b  Obj_Boss_Ani_Map(A0), D1                         ; $000B
		beq.s   Offset_0x00DB6E
		add.w   D1, D1
		move.l  A5, A1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00DB6E
		move.w  D4, -(A7)
		bsr     Build_Sprites_2P_Sub_00                ; Offset_0x00DBF6
		move.w  (A7)+, D4
Offset_0x00DB6E:
		ori.b   #$80, Obj_Flags(A0)                              ; $0001
		lea     Obj_Speed(A0), A6                                ; $0010
		moveq   #$00, D0
		move.b  Obj_Ani_Boss_Cnt(A0), D0                         ; $000F
		subq.w  #$01, D0
		bcs.s   Offset_0x00DBB8
Offset_0x00DB82:
		swap.w  D0
		move.w  (A6)+, D3
		sub.w   (A4), D3
		addi.w  #$0080, D3
		move.w  (A6)+, D2
		sub.w   Obj_Map(A4), D2                                  ; $0004
		addi.w  #$01E0, D2
		addq.w  #$01, A6
		moveq   #$00, D1
		move.b  (A6)+, D1
		add.w   D1, D1
		move.l  A5, A1
		adda.w  $00(A1, D1), A1
		move.w  (A1)+, D1
		subq.w  #$01, D1
		bmi.s   Offset_0x00DBB2
		move.w  D4, -(A7)
		bsr     Build_Sprites_2P_Sub_00                ; Offset_0x00DBF6
		move.w  (A7)+, D4
Offset_0x00DBB2:
		swap.w  D0
		dbra    D0, Offset_0x00DB82
Offset_0x00DBB8:
		move.l  (A7)+, A4
		bra     Offset_0x00D9C0 
		
;-------------------------------------------------------------------------------
; Rotinas para modificar os atributos das sprites no modo entrelaçado / 2P
; ->>>
;-------------------------------------------------------------------------------
ModifySpriteAttr_2P:                                           ; Offset_0x00DBBE
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Exit_ModifySpriteAttr_2P               ; Offset_0x00DBD8
		move.w  Obj_Art_VRAM(A0), D0                             ; $0002
		andi.w  #$07FF, D0
		lsr.w   #$01, D0
		andi.w  #$F800, Obj_Art_VRAM(A0)                         ; $0002
		add.w   D0, Obj_Art_VRAM(A0)                             ; $0002
Exit_ModifySpriteAttr_2P:                                      ; Offset_0x00DBD8
		rts    
;-------------------------------------------------------------------------------
ModifySpriteAttr_2P_A1:                                        ; Offset_0x00DBDA
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Exit_ModifySpriteAttr_2P_A1            ; Offset_0x00DBF4
		move.w  Obj_Art_VRAM(A1), D0                             ; $0002
		andi.w  #$07FF, D0
		lsr.w   #$01, D0
		andi.w  #$F800, Obj_Art_VRAM(A1)                         ; $0002
		add.w   D0, Obj_Art_VRAM(A1)                             ; $0002
Exit_ModifySpriteAttr_2P_A1:                                   ; Offset_0x00DBF4
		rts             
;-------------------------------------------------------------------------------
; Rotinas para modificar os atributos das sprites no modo entrelaçado / 2P
; <<<-
;-------------------------------------------------------------------------------
Build_Sprites_2P_Sub_00:                                       ; Offset_0x00DBF6
		cmpi.b  #$50, D5
		bcs.s   Offset_0x00DC16
		rts
;-------------------------------------------------------------------------------                
Build_Sprites_2P_Sub_01:                                       ; Offset_0x00DBFE
		move.w  Obj_Art_VRAM(A0), A3                             ; $0002
		cmpi.b  #$50, D5
		bcc.s   Offset_0x00DC42
		btst    #$00, D4
		bne.s   Offset_0x00DC54
		btst    #$01, D4
		bne     Offset_0x00DCB6
Offset_0x00DC16:
		move.b  (A1)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  Offset_0x00DC44(PC, D4), (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   A3, D0
		move.w  D0, (A2)+
		move.w  (A1)+, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00DC3C
		addq.w  #$01, D0
Offset_0x00DC3C:
		move.w  D0, (A2)+
		dbra    D1, Offset_0x00DC16
Offset_0x00DC42:
		rts
;-------------------------------------------------------------------------------                                 
Offset_0x00DC44: 
		dc.b    $00, $00, $01, $01, $04, $04, $05, $05
		dc.b    $08, $08, $09, $09, $0C, $0C, $0D, $0D
;-------------------------------------------------------------------------------
Offset_0x00DC54:
		btst    #$01, D4
		bne     Offset_0x00DD12
Offset_0x00DC5C:
		move.b  (A1)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  Offset_0x00DC44(PC, D4), (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   A3, D0
		eori.w  #$0800, D0
		move.w  D0, (A2)+
		move.w  (A1)+, D0
		neg.w   D0
		move.b  Offset_0x00DC96(PC, D4), D4
		sub.w   D4, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00DC8E
		addq.w  #$01, D0
Offset_0x00DC8E:
		move.w  D0, (A2)+
		dbra    D1, Offset_0x00DC5C
		rts
;-------------------------------------------------------------------------------                  
Offset_0x00DC96:                                                             
		dc.b    $08, $08, $08, $08, $10, $10, $10, $10
		dc.b    $18, $18, $18, $18, $20, $20, $20, $20
;------------------------------------------------------------------------------- 
Offset_0x00DCA6:
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20 
;-------------------------------------------------------------------------------
Offset_0x00DCB6:
		move.b  (A1)+, D0
		move.b  (A1), D4
		ext.w   D0
		neg.w   D0
		move.b  Offset_0x00DCA6(PC, D4), D4
		sub.w   D4, D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  Offset_0x00DCF2(PC, D4), (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   A3, D0
		eori.w  #$1000, D0
		move.w  D0, (A2)+
		move.w  (A1)+, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00DCEA
		addq.w  #$01, D0
Offset_0x00DCEA:
		move.w  D0, (A2)+
		dbra    D1, Offset_0x00DCB6
		rts
;-------------------------------------------------------------------------------
Offset_0x00DCF2:                                                      
		dc.b    $00, $00, $01, $01, $04, $04, $05, $05
		dc.b    $08, $08, $09, $09, $0C, $0C, $0D, $0D      
;------------------------------------------------------------------------------- 
Offset_0x00DD02:
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20
		dc.b    $08, $10, $18, $20, $08, $10, $18, $20
;-------------------------------------------------------------------------------
Offset_0x00DD12:
		move.b  (A1)+, D0
		move.b  (A1), D4
		ext.w   D0
		neg.w   D0
		move.b  Offset_0x00DD02(PC, D4), D4
		sub.w   D4, D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  Offset_0x00DCF2(PC, D4), (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   A3, D0
		eori.w  #$1800, D0
		move.w  D0, (A2)+
		move.w  (A1)+, D0
		neg.w   D0
		move.b  Offset_0x00DD56(PC, D4), D4
		sub.w   D4, D0
		add.w   D3, D0
		andi.w  #$01FF, D0
		bne.s   Offset_0x00DD4E
		addq.w  #$01, D0
Offset_0x00DD4E:
		move.w  D0, (A2)+
		dbra    D1, Offset_0x00DD12
		rts
;-------------------------------------------------------------------------------
Offset_0x00DD56:
		dc.b    $08, $08, $08, $08, $10, $10, $10, $10
		dc.b    $18, $18, $18, $18, $20, $20, $20, $20                
;===============================================================================
; Rotina para compilar os sprites de acordo com as definições dos objetos
; <<<-
;===============================================================================
Check_Object_On_Screen:                                        ; Offset_0x00DD66
		move.w  Obj_X(A0), D0                                    ; $0008
		sub.w   (Camera_X).w, D0                             ; $FFFFEE00
		bmi.s   Not_On_Screen                          ; Offset_0x00DD8A
		cmpi.w  #$0140, D0
		bge.s   Not_On_Screen                          ; Offset_0x00DD8A
		move.w  Obj_Y(A0), D1                                    ; $000C
		sub.w   (Camera_Y).w, D1                             ; $FFFFEE04
		bmi.s   Not_On_Screen                          ; Offset_0x00DD8A
		cmpi.w  #$00E0, D1
		bge.s   Not_On_Screen                          ; Offset_0x00DD8A
		moveq   #$00, D0
		rts
Not_On_Screen:                                                 ; Offset_0x00DD8A
		moveq   #$01, D0
		rts   
;-------------------------------------------------------------------------------
Check_Object_On_Screen_2:                                      ; Offset_0x00DD8E
		moveq   #$00, D1
		move.b  Obj_Width(A0), D1                                ; $0019
		move.w  Obj_X(A0), D0                                    ; $0008
		sub.w   (Camera_X).w, D0                             ; $FFFFEE00
		add.w   D1, D0
		bmi.s   Not_On_Screen_2                        ; Offset_0x00DDBE
		add.w   D1, D1
		sub.w   D1, D0
		cmpi.w  #$0140, D0
		bge.s   Not_On_Screen_2                        ; Offset_0x00DDBE
		move.w  Obj_Y(A0), D1                                    ; $000C
		sub.w   (Camera_Y).w, D1                             ; $FFFFEE04
		bmi.s   Not_On_Screen_2                        ; Offset_0x00DDBE
		cmpi.w  #$00E0, D1
		bge.s   Not_On_Screen_2                        ; Offset_0x00DDBE
		moveq   #$00, D0
		rts
Not_On_Screen_2:                                               ; Offset_0x00DDBE
		moveq   #$01, D0
		rts 
		nop                  
;===============================================================================
; Rotina para carregar o pocicionamento dos anéis nas fases
; ->>>
;===============================================================================   
Load_Ring_Pos:                                                 ; Offset_0x00DDC4
		moveq   #$00, D0
		move.b  ($FFFFF710).w, D0
		move.w  Offset_0x00DDD2(PC, D0), D0
		jmp     Offset_0x00DDD2(PC, D0) 
;-------------------------------------------------------------------------------
Offset_0x00DDD2:
		dc.w    Offset_0x00DDD6-Offset_0x00DDD2
		dc.w    Offset_0x00DE20-Offset_0x00DDD2          
;-------------------------------------------------------------------------------
Offset_0x00DDD6:
		addq.b  #$02, ($FFFFF710).w
		bsr     Load_Rings_Layout                      ; Offset_0x00E0D8
		lea     ($FFFFE800).w, A1
		move.w  (Camera_X).w, D4                             ; $FFFFEE00
		subq.w  #$08, D4
		bhi.s   Offset_0x00DDF2
		moveq   #$01, D4
		bra.s   Offset_0x00DDF2    
Offset_0x00DDEE:
		lea     $0006(A1), A1
Offset_0x00DDF2:
		cmp.w   $0002(A1), D4
		bhi.s   Offset_0x00DDEE
		move.w  A1, ($FFFFF712).w
		move.w  A1, ($FFFFF716).w
		addi.w  #$0150, D4
		bra.s   Offset_0x00DE0A
Offset_0x00DE06:
		lea     $0006(A1), A1
Offset_0x00DE0A:
		cmp.w   $0002(A1), D4
		bhi.s   Offset_0x00DE06
		move.w  A1, ($FFFFF714).w
		move.w  A1, ($FFFFF718).w
		move.b  #$01, ($FFFFF711).w
		rts
;-------------------------------------------------------------------------------                
Offset_0x00DE20:
		lea     ($FFFFEF80).w, A2
		move.w  (A2)+, D1
		subq.w  #$01, D1
		bcs.s   Offset_0x00DE56
Offset_0x00DE2A:
		move.w  (A2)+, D0
		beq.s   Offset_0x00DE2A
		move.w  D0, A1
		subq.b  #$01, (A1)
		bne.s   Offset_0x00DE52
		move.b  #$06, (A1)
		addq.b  #$01, $0001(A1)
		cmpi.b  #$08, $0001(A1)
		bne.s   Offset_0x00DE52
		move.w  #$FFFF, (A1)
		move.w  #$0000, $FFFFFFFE(A2)
		subq.w  #$01, ($FFFFEF80).w
Offset_0x00DE52:
		dbra    D1, Offset_0x00DE2A
Offset_0x00DE56:
		move.w  ($FFFFF712).w, A1
		move.w  (Camera_X).w, D4                             ; $FFFFEE00
		subq.w  #$08, D4
		bhi.s   Offset_0x00DE6A
		moveq   #$01, D4
		bra.s   Offset_0x00DE6A         
Offset_0x00DE66:
		lea     $0006(A1), A1
Offset_0x00DE6A:
		cmp.w   $0002(A1), D4
		bhi.s   Offset_0x00DE66
		bra.s   Offset_0x00DE74   
Offset_0x00DE72:
		subq.w  #$06, A1
Offset_0x00DE74:
		cmp.w   $FFFFFFFC(A1), D4
		bls.s   Offset_0x00DE72
		move.w  A1, ($FFFFF712).w
		move.w  ($FFFFF714).w, A2
		addi.w  #$0150, D4
		bra.s   Offset_0x00DE8C   
Offset_0x00DE88:
		lea     $0006(A2), A2
Offset_0x00DE8C:
		cmp.w   $0002(A2), D4
		bhi.s   Offset_0x00DE88
		bra.s   Offset_0x00DE96 
Offset_0x00DE94:
		subq.w  #$06, A2
Offset_0x00DE96:
		cmp.w   $FFFFFFFC(A2), D4
		bls.s   Offset_0x00DE94
		move.w  A2, ($FFFFF714).w
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   Offset_0x00DEB0
		move.w  A1, ($FFFFF716).w
		move.w  A2, ($FFFFF718).w
		rts
Offset_0x00DEB0:
		move.w  ($FFFFF716).w, A1
		move.w  (Camera_X_2).w, D4                           ; $FFFFEE20
		subq.w  #$08, D4
		bhi.s   Offset_0x00DEC4
		moveq   #$01, D4
		bra.s   Offset_0x00DEC4             
Offset_0x00DEC0:
		lea     $0006(A1), A1
Offset_0x00DEC4:
		cmp.w   $0002(A1), D4
		bhi.s   Offset_0x00DEC0
		bra.s   Offset_0x00DECE
Offset_0x00DECC:
		subq.w  #$06, A1
Offset_0x00DECE:
		cmp.w   $FFFFFFFC(A1), D4
		bls.s   Offset_0x00DECC
		move.w  A1, ($FFFFF716).w
		move.w  ($FFFFF718).w, A2
		addi.w  #$0150, D4
		bra.s   Offset_0x00DEE6
Offset_0x00DEE2:
		lea     $0006(A2), A2
Offset_0x00DEE6:
		cmp.w   $0002(A2), D4
		bhi.s   Offset_0x00DEE2
		bra.s   Offset_0x00DEF0   
Offset_0x00DEEE:
		subq.w  #$06, A2
Offset_0x00DEF0:
		cmp.w   $FFFFFFFC(A2), D4
		bls.s   Offset_0x00DEEE
		move.w  A2, ($FFFFF718).w
		rts   
;===============================================================================
; Rotina para carregar o pocicionamento dos anéis nas fases
; <<<-
;===============================================================================
		
;===============================================================================
; Rotinas para responder ao toque dos anéis pelo jogador
; ->>>
;===============================================================================
TouchRings:                                                    ; Offset_0x00DEFC
		move.w  ($FFFFF712).w, A1
		move.w  ($FFFFF714).w, A2
		cmpa.w  #Player_One, A0                                  ; $B000
		beq.s   Offset_0x00DF12
		move.w  ($FFFFF716).w, A1
		move.w  ($FFFFF718).w, A2
Offset_0x00DF12:
		cmpa.l  A1, A2
		beq     Offset_0x00DFAA
		cmpi.w  #$005A, Obj_P_Invunerblt_Time(A0)                ; $0030
		bcc     Offset_0x00DFAA
		move.w  Obj_X(A0), D2                                    ; $0008
		move.w  Obj_Y(A0), D3                                    ; $000C
		subi.w  #$0008, D2
		moveq   #$00, D5
		move.b  Obj_Height_2(A0), D5                             ; $0016
		subq.b  #$03, D5
		sub.w   D5, D3
		cmpi.b  #$4D, Obj_Map_Id(A0)                             ; $001A
		bne.s   Touch_Rings_NoDuck                     ; Offset_0x00DF46
		addi.w  #$000C, D3
		moveq   #$0A, D5
Touch_Rings_NoDuck:                                            ; Offset_0x00DF46
		move.w  #$0006, D1
		move.w  #$000C, D6
		move.w  #$0010, D4
		add.w   D5, D5
Offset_0x00DF54:
		tst.w   (A1)
		bne     Offset_0x00DFA0
		move.w  $0002(A1), D0
		sub.w   D1, D0
		sub.w   D2, D0
		bcc.s   Offset_0x00DF6C
		add.w   D6, D0
		bcs.s   Offset_0x00DF72
		bra     Offset_0x00DFA0
Offset_0x00DF6C:
		cmp.w   D4, D0
		bhi     Offset_0x00DFA0
Offset_0x00DF72:
		move.w  $0004(A1), D0
		sub.w   D1, D0
		sub.w   D3, D0
		bcc.s   Offset_0x00DF84
		add.w   D6, D0
		bcs.s   Offset_0x00DF8A
		bra     Offset_0x00DFA0
Offset_0x00DF84:
		cmp.w   D5, D0
		bhi     Offset_0x00DFA0
Offset_0x00DF8A:
		move.w  #$0604, (A1)
		bsr     Add_Rings                              ; Offset_0x00AB92
		lea     ($FFFFEF82).w, A3
Offset_0x00DF96:
		tst.w   (A3)+
		bne.s   Offset_0x00DF96
		move.w  A1, -(A3)
		addq.w  #$01, ($FFFFEF80).w
Offset_0x00DFA0:
		lea     $0006(A1), A1
		cmpa.l  A1, A2
		bne     Offset_0x00DF54
Offset_0x00DFAA:
		rts                
;===============================================================================
; Rotinas para responder ao toque dos anéis pelo jogador
; <<<-
;===============================================================================

;===============================================================================
; Rotinas para mostrar os anéis de acordo com a localização do jogador na fase
; ->>>
;===============================================================================
Build_Rings:                                                   ; Offset_0x00DFAC
		move.w  ($FFFFF712).w, A0
		move.w  ($FFFFF714).w, A4
		cmpa.l  A0, A4
		bne.s   Offset_0x00DFBA
		rts
Offset_0x00DFBA:
		lea     (Camera_X).w, A3                             ; $FFFFEE00
Offset_0x00DFBE:
		tst.w   (A0)
		bmi     Offset_0x00E020
		move.w  $0002(A0), D3
		sub.w   (A3), D3
		addi.w  #$0080, D3
		move.w  $0004(A0), D2
		sub.w   $0004(A3), D2
		andi.w  #$07FF, D2
		addi.w  #$0008, D2
		bmi.s   Offset_0x00E020
		cmpi.w  #$00F0, D2
		bge.s   Offset_0x00E020
		addi.w  #$0078, D2
		lea     (Level_Rings_Mappings), A1             ; Offset_0x00E198
		moveq   #$00, D1
		move.b  $0001(A0), D1
		bne.s   Offset_0x00DFFC
		move.b  (Object_Frame_Buffer+$0003).w, D1            ; $FFFFFEA3
Offset_0x00DFFC:
		add.w   D1, D1
		adda.w  $00(A1, D1), A1
		move.b  (A1)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		move.w  (A1)+, D0
		addi.w  #$26BC, D0
		move.w  D0, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		add.w   D3, D0
		move.w  D0, (A2)+
Offset_0x00E020:
		lea     $0006(A0), A0
		cmpa.l  A0, A4
		bne     Offset_0x00DFBE
		rts    
;------------------------------------------------------------------------------- 
Build_Rings_2P:                                                ; Offset_0x00E02C
		lea     (Camera_X).w, A3                             ; $FFFFEE00
		move.w  #$0078, D6
		move.w  ($FFFFF712).w, A0
		move.w  ($FFFFF714).w, A4
		cmpa.l  A0, A4
		bne.s   Offset_0x00E058
		rts      
;-------------------------------------------------------------------------------
Build_Rings_2P_Miles:                                          ; Offset_0x00E042
		lea     (Camera_X_2).w, A3                           ; $FFFFEE20
		move.w  #$0158, D6
		move.w  ($FFFFF716).w, A0
		move.w  ($FFFFF718).w, A4
		cmpa.l  A0, A4
		bne.s   Offset_0x00E058
		rts
Offset_0x00E058:
		tst.w   (A0)
		bmi     Offset_0x00E0BC
		move.w  $0002(A0), D3
		sub.w   (A3), D3
		addi.w  #$0080, D3
		move.w  $0004(A0), D2
		sub.w   $0004(A3), D2
		andi.w  #$07FF, D2
		addi.w  #$0088, D2
		bmi.s   Offset_0x00E0BC
		cmpi.w  #$0170, D2
		bge.s   Offset_0x00E0BC
		add.w   D6, D2
		lea     (Level_Rings_Mappings), A1             ; Offset_0x00E198
		moveq   #$00, D1
		move.b  $0001(A0), D1
		bne.s   Offset_0x00E094
		move.b  (Object_Frame_Buffer+$0003).w, D1            ; $FFFFFEA3
Offset_0x00E094:
		add.w   D1, D1
		adda.w  $00(A1, D1), A1
		move.b  (A1)+, D0
		ext.w   D0
		add.w   D2, D0
		move.w  D0, (A2)+
		move.b  (A1)+, D4
		move.b  Offset_0x00E0C8(PC, D4), (A2)+
		addq.b  #$01, D5
		move.b  D5, (A2)+
		addq.w  #$02, A1
		move.w  (A1)+, D0
		addi.w  #$235E, D0
		move.w  D0, (A2)+
		move.w  (A1)+, D0
		add.w   D3, D0
		move.w  D0, (A2)+
Offset_0x00E0BC:
		lea     $0006(A0), A0
		cmpa.l  A0, A4
		bne     Offset_0x00E058
		rts 
;-------------------------------------------------------------------------------                 
Offset_0x00E0C8:
		dc.b    $00, $00, $01, $01, $04, $04, $05, $05
		dc.b    $08, $08, $09, $09, $0C, $0C, $0D, $0D  
;===============================================================================
; Rotinas para mostrar os anéis de acordo com a localização do jogador na fase
; <<<-
;===============================================================================

;===============================================================================
; Rotina para carregar os anéis das fases
; ->>>
;===============================================================================
Load_Rings_Layout:                                             ; Offset_0x00E0D8
		lea     ($FFFFE800).w, A1
		moveq   #$00, D0
		move.w  #$017F, D1
Offset_0x00E0E2:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00E0E2
		lea     ($FFFFEF80).w, A1
		move.w  #$000F, D1
Offset_0x00E0F0:
		move.l  D0, (A1)+
		dbra    D1, Offset_0x00E0F0
		moveq   #$00, D5
		moveq   #$00, D0
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		ror.b   #$01, D0
		lsr.w   #$06, D0
		lea     (Rings_Layout), A1                     ; Offset_0x0E8000
		move.w  $00(A1, D0), D0
		lea     $00(A1, D0), A1
		lea     ($FFFFE806).w, A2
Offset_0x00E114:
		move.w  (A1)+, D2
		bmi.s   Offset_0x00E15C
		move.w  (A1)+, D3
		bmi.s   Offset_0x00E13C
		move.w  D3, D0
		rol.w   #$04, D0
		andi.w  #$0007, D0
		andi.w  #$0FFF, D3
Offset_0x00E128:
		move.w  #$0000, (A2)+
		move.w  D2, (A2)+
		move.w  D3, (A2)+
		addi.w  #$0018, D2
		addq.w  #$01, D5
		dbra    D0, Offset_0x00E128
		bra.s   Offset_0x00E114
Offset_0x00E13C:
		move.w  D3, D0
		rol.w   #$04, D0
		andi.w  #$0007, D0
		andi.w  #$0FFF, D3
Offset_0x00E148:
		move.w  #$0000, (A2)+
		move.w  D2, (A2)+
		move.w  D3, (A2)+
		addi.w  #$0018, D3
		addq.w  #$01, D5
		dbra    D0, Offset_0x00E148
		bra.s   Offset_0x00E114
Offset_0x00E15C:
		move.w  D5, ($FFFFFF40).w
		moveq   #-$01, D0
		move.l  D0, (A2)+
		lea     ($FFFFE802).w, A1
		move.w  #$00FE, D3
Offset_0x00E16C:
		move.w  D3, D4
		lea     $0006(A1), A2
		move.w  (A1), D0
Offset_0x00E174:
		tst.w   (A2)
		beq.s   Offset_0x00E186
		cmp.w   (A2), D0
		bls.s   Offset_0x00E186
		move.l  (A1), D1
		move.l  (A2), D0
		move.l  D0, (A1)
		move.l  D1, (A2)
		swap.w  D0
Offset_0x00E186:
		lea     $0006(A2), A2
		dbra    D4, Offset_0x00E174
		lea     $0006(A1), A1
		dbra    D3, Offset_0x00E16C
		rts   
;===============================================================================
; Rotina para carregar os anéis das fases
; <<<-
;===============================================================================  
  
;===============================================================================
; Mapeamento dos anéis
; ->>>
;===============================================================================
Level_Rings_Mappings:                                          ; Offset_0x00E198
		dc.w    Offset_0x00E1A8-Level_Rings_Mappings
		dc.w    Offset_0x00E1B0-Level_Rings_Mappings
		dc.w    Offset_0x00E1B8-Level_Rings_Mappings
		dc.w    Offset_0x00E1C0-Level_Rings_Mappings
		dc.w    Offset_0x00E1C8-Level_Rings_Mappings
		dc.w    Offset_0x00E1D0-Level_Rings_Mappings
		dc.w    Offset_0x00E1D8-Level_Rings_Mappings
		dc.w    Offset_0x00E1E0-Level_Rings_Mappings
Offset_0x00E1A8:
		dc.l    $F8050000, $0000FFF8
Offset_0x00E1B0:
		dc.l    $F8050004, $0002FFF8
Offset_0x00E1B8:
		dc.l    $F8010008, $0004FFFC
Offset_0x00E1C0:
		dc.l    $F8050804, $0802FFF8
Offset_0x00E1C8:
		dc.l    $F805000A, $0005FFF8
Offset_0x00E1D0:
		dc.l    $F805180A, $1805FFF8
Offset_0x00E1D8:
		dc.l    $F805080A, $0805FFF8
Offset_0x00E1E0:
		dc.l    $F805100A, $1005FFF8 
;===============================================================================
; Mapeamento dos anéis
; <<<-
;===============================================================================

;===============================================================================
; Rotina para carregar o posicionamento dos objetos nas fases
; ->>>
;===============================================================================
Load_Object_Pos:                                               ; Offset_0x00E1E8
		moveq   #$00, D0
		move.b  ($FFFFF76C).w, D0
		move.w  Offset_0x00E1F6(PC, D0), D0
		jmp     Offset_0x00E1F6(PC, D0)                
;-------------------------------------------------------------------------------
Offset_0x00E1F6:
		dc.w    Offset_0x00E1FC-Offset_0x00E1F6
		dc.w    Load_Object_Pos_1P_Mode-Offset_0x00E1F6 ; Offset_0x00E2A8
		dc.w    Load_Object_Pos_2P_Mode-Offset_0x00E1F6 ; Offset_0x00E3F0
;-------------------------------------------------------------------------------
Offset_0x00E1FC:
		addq.b  #$02, ($FFFFF76C).w
		move.w  (Level_Id).w, D0                             ; $FFFFFE10
		ror.b   #$01, D0
		lsr.w   #$06, D0
		lea     (Objects_Layout), A0                   ; Offset_0x04C000
		move.l  A0, A1
		adda.w  $00(A0, D0), A0
		move.l  A0, ($FFFFF770).w
		move.l  A0, ($FFFFF774).w
		move.l  A0, ($FFFFF778).w
		move.l  A0, ($FFFFF77C).w
		lea     ($FFFFFC00).w, A2
		move.w  #$0101, (A2)+
		move.w  #$005E, D0
Offset_0x00E230:
		clr.l   (A2)+
		dbra    D0, Offset_0x00E230
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D2
		move.w  (Camera_X).w, D6                             ; $FFFFEE00
		subi.w  #$0080, D6
		bcc.s   Offset_0x00E248
		moveq   #$00, D6
Offset_0x00E248:
		andi.w  #$FF80, D6
		move.l  ($FFFFF770).w, A0
Offset_0x00E250:
		cmp.w   (A0), D6
		bls.s   Offset_0x00E262
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E25E
		move.b  (A2), D2
		addq.b  #$01, (A2)
Offset_0x00E25E:
		addq.w  #$06, A0
		bra.s   Offset_0x00E250
Offset_0x00E262:
		move.l  A0, ($FFFFF770).w
		move.l  A0, ($FFFFF778).w
		move.l  ($FFFFF774).w, A0
		subi.w  #$0080, D6
		bcs.s   Offset_0x00E286
Offset_0x00E274:
		cmp.w   (A0), D6
		bls.s   Offset_0x00E286
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E282
		addq.b  #$01, $0001(A2)
Offset_0x00E282:
		addq.w  #$06, A0
		bra.s   Offset_0x00E274
Offset_0x00E286:
		move.l  A0, ($FFFFF774).w
		move.l  A0, ($FFFFF77C).w
		move.w  #$FFFF, ($FFFFF76E).w
		move.w  #$FFFF, ($FFFFF78C).w
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Load_Object_Pos_1P_Mode                ; Offset_0x00E2A8
		addq.b  #$02, ($FFFFF76C).w
		bra     Load_Object_Pos_2P_Mode_Init           ; Offset_0x00E374
;-------------------------------------------------------------------------------                
Load_Object_Pos_1P_Mode:                                       ; Offset_0x00E2A8
		move.w  (Camera_X).w, D1                             ; $FFFFEE00
		subi.w  #$0080, D1
		andi.w  #$FF80, D1
		move.w  D1, ($FFFFF7DA).w
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D2
		move.w  (Camera_X).w, D6                             ; $FFFFEE00
		andi.w  #$FF80, D6
		cmp.w   ($FFFFF76E).w, D6
		beq     Offset_0x00E372
		bge.s   Offset_0x00E32E
		move.w  D6, ($FFFFF76E).w
		move.l  ($FFFFF774).w, A0
		subi.w  #$0080, D6
		bcs.s   Offset_0x00E30A
Offset_0x00E2DE:
		cmp.w   $FFFFFFFA(A0), D6
		bge.s   Offset_0x00E30A
		subq.w  #$06, A0
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E2F4
		subq.b  #$01, $0001(A2)
		move.b  $0001(A2), D2
Offset_0x00E2F4:
		bsr     Offset_0x00E65A
		bne.s   Offset_0x00E2FE
		subq.w  #$06, A0
		bra.s   Offset_0x00E2DE
Offset_0x00E2FE:
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E308
		addq.b  #$01, $0001(A2)
Offset_0x00E308:
		addq.w  #$06, A0
Offset_0x00E30A:
		move.l  A0, ($FFFFF774).w
		move.l  ($FFFFF770).w, A0
		addi.w  #$0300, D6
Offset_0x00E316:
		cmp.w   $FFFFFFFA(A0), D6
		bgt.s   Offset_0x00E328
		tst.b   $FFFFFFFC(A0)
		bpl.s   Offset_0x00E324
		subq.b  #$01, (A2)
Offset_0x00E324:
		subq.w  #$06, A0
		bra.s   Offset_0x00E316
Offset_0x00E328:
		move.l  A0, ($FFFFF770).w
		rts
Offset_0x00E32E:
		move.w  D6, ($FFFFF76E).w
		move.l  ($FFFFF770).w, A0
		addi.w  #$0280, D6
Offset_0x00E33A:
		cmp.w   (A0), D6
		bls.s   Offset_0x00E34E
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E348
		move.b  (A2), D2
		addq.b  #$01, (A2)
Offset_0x00E348:
		bsr     Offset_0x00E65A
		beq.s   Offset_0x00E33A
Offset_0x00E34E:
		move.l  A0, ($FFFFF770).w
		move.l  ($FFFFF774).w, A0
		subi.w  #$0300, D6
		bcs.s   Offset_0x00E36E
Offset_0x00E35C:
		cmp.w   (A0), D6
		bls.s   Offset_0x00E36E
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E36A
		addq.b  #$01, $0001(A2)
Offset_0x00E36A:
		addq.w  #$06, A0
		bra.s   Offset_0x00E35C
Offset_0x00E36E:
		move.l  A0, ($FFFFF774).w
Offset_0x00E372:
		rts
;-------------------------------------------------------------------------------                
Load_Object_Pos_2P_Mode_Init:                                  ; Offset_0x00E374
		moveq   #-$01, D0
		move.l  D0, ($FFFFF780).w
		move.l  D0, ($FFFFF784).w
		move.l  D0, ($FFFFF788).w
		move.l  D0, ($FFFFF78C).w
		move.w  #$0000, ($FFFFF76E).w
		move.w  #$0000, ($FFFFF78C).w
		lea     ($FFFFFC00).w, A2
		move.w  (A2), ($FFFFF78E).w
		moveq   #$00, D2
		lea     ($FFFFFC00).w, A5
		lea     ($FFFFF770).w, A4
		lea     ($FFFFF786).w, A1
		lea     ($FFFFF789).w, A6
		moveq   #-$02, D6
		bsr     Offset_0x00E508
		lea     ($FFFFF786).w, A1
		moveq   #-$01, D6
		bsr     Offset_0x00E508
		lea     ($FFFFF786).w, A1
		moveq   #$00, D6
		bsr     Offset_0x00E508
		lea     ($FFFFF78E).w, A5
		lea     ($FFFFF778).w, A4
		lea     ($FFFFF789).w, A1
		lea     ($FFFFF786).w, A6
		moveq   #-$02, D6
		bsr     Offset_0x00E508
		lea     ($FFFFF789).w, A1
		moveq   #-$01, D6
		bsr     Offset_0x00E508
		lea     ($FFFFF789).w, A1
		moveq   #$00, D6
		bsr     Offset_0x00E508
;-------------------------------------------------------------------------------                
Load_Object_Pos_2P_Mode:                                       ; Offset_0x00E3F0                
		move.w  (Camera_X).w, D1                             ; $FFFFEE00
		andi.w  #$FF00, D1
		move.w  D1, ($FFFFF7DA).w
		move.w  (Camera_X_2).w, D1                           ; $FFFFEE20
		andi.w  #$FF00, D1
		move.w  D1, ($FFFFF7DC).w
		move.b  (Camera_X).w, D6                             ; $FFFFEE00
		andi.w  #$00FF, D6
		move.w  ($FFFFF76E).w, D0
		cmp.w   ($FFFFF76E).w, D6
		beq.s   Offset_0x00E430
		move.w  D6, ($FFFFF76E).w
		lea     ($FFFFFC00).w, A5
		lea     ($FFFFF770).w, A4
		lea     ($FFFFF786).w, A1
		lea     ($FFFFF789).w, A6
		bsr.s   Offset_0x00E45A
Offset_0x00E430:
		move.b  (Camera_X_2).w, D6                           ; $FFFFEE20
		andi.w  #$00FF, D6
		move.w  ($FFFFF78C).w, D0
		cmp.w   ($FFFFF78C).w, D6
		beq.s   Offset_0x00E458
		move.w  D6, ($FFFFF78C).w
		lea     ($FFFFF78E).w, A5
		lea     ($FFFFF778).w, A4
		lea     ($FFFFF789).w, A1
		lea     ($FFFFF786).w, A6
		bsr.s   Offset_0x00E45A
Offset_0x00E458:
		rts
Offset_0x00E45A:
		lea     ($FFFFFC00).w, A2
		moveq   #$00, D2
		cmp.w   D0, D6
		beq     Offset_0x00E372
		bge     Offset_0x00E508
		move.b  $0002(A1), D2
		move.b  $0001(A1), $0002(A1)
		move.b  (A1), $0001(A1)
		move.b  D6, (A1)
		cmp.b   (A6), D2
		beq.s   Offset_0x00E490
		cmp.b   $0001(A6), D2
		beq.s   Offset_0x00E490
		cmp.b   $0002(A6), D2
		beq.s   Offset_0x00E490
		bsr     Offset_0x00E5EA
		bra.s   Offset_0x00E494
Offset_0x00E490:
		bsr     Offset_0x00E5AE
Offset_0x00E494:
		bsr     Offset_0x00E58A
		bne.s   Offset_0x00E4B8
		move.l  $0004(A4), A0
Offset_0x00E49E:
		cmp.b   $FFFFFFFA(A0), D6
		bne.s   Offset_0x00E4B2
		tst.b   $FFFFFFFC(A0)
		bpl.s   Offset_0x00E4AE
		subq.b  #$01, $0001(A5)
Offset_0x00E4AE:
		subq.w  #$06, A0
		bra.s   Offset_0x00E49E
Offset_0x00E4B2:
		move.l  A0, $0004(A4)
		bra.s   Offset_0x00E4EE
Offset_0x00E4B8:
		move.l  $0004(A4), A0
		move.b  D6, (A1)
Offset_0x00E4BE:
		cmp.b   $FFFFFFFA(A0), D6
		bne.s   Offset_0x00E4EA
		subq.w  #$06, A0
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E4D4
		subq.b  #$01, $0001(A5)
		move.b  $0001(A5), D2
Offset_0x00E4D4:
		bsr     Load_Object_2P                         ; Offset_0x00E6A4
		bne.s   Offset_0x00E4DE
		subq.w  #$06, A0
		bra.s   Offset_0x00E4BE
Offset_0x00E4DE:
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E4E8
		addq.b  #$01, $0001(A5)
Offset_0x00E4E8:
		addq.w  #$06, A0
Offset_0x00E4EA:
		move.l  A0, $0004(A4)
Offset_0x00E4EE:
		move.l  (A4), A0
		addq.w  #$03, D6
Offset_0x00E4F2:
		cmp.b   $FFFFFFFA(A0), D6
		bne.s   Offset_0x00E504
		tst.b   $FFFFFFFC(A0)
		bpl.s   Offset_0x00E500
		subq.b  #$01, (A5)
Offset_0x00E500:
		subq.w  #$06, A0
		bra.s   Offset_0x00E4F2
Offset_0x00E504:
		move.l  A0, (A4)
		rts
Offset_0x00E508:
		addq.w  #$02, D6
		move.b  (A1), D2
		move.b  $0001(A1), (A1)
		move.b  $0002(A1), $0001(A1)
		move.b  D6, $0002(A1)
		cmp.b   (A6), D2
		beq.s   Offset_0x00E530
		cmp.b   $0001(A6), D2
		beq.s   Offset_0x00E530
		cmp.b   $0002(A6), D2
		beq.s   Offset_0x00E530
		bsr     Offset_0x00E5EA
		bra.s   Offset_0x00E534
Offset_0x00E530:
		bsr     Offset_0x00E5AE
Offset_0x00E534:
		bsr     Offset_0x00E58A
		bne.s   Offset_0x00E550
		move.l  (A4), A0
Offset_0x00E53C:
		cmp.b   (A0), D6
		bne.s   Offset_0x00E54C
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E548
		addq.b  #$01, (A5)
Offset_0x00E548:
		addq.w  #$06, A0
		bra.s   Offset_0x00E53C
Offset_0x00E54C:
		move.l  A0, (A4)
		bra.s   Offset_0x00E56A
Offset_0x00E550:
		move.l  (A4), A0
		move.b  D6, (A1)
Offset_0x00E554:
		cmp.b   (A0), D6
		bne.s   Offset_0x00E568
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E562
		move.b  (A5), D2
		addq.b  #$01, (A5)
Offset_0x00E562:
		bsr     Load_Object_2P                         ; Offset_0x00E6A4
		beq.s   Offset_0x00E554
Offset_0x00E568:
		move.l  A0, (A4)
Offset_0x00E56A:
		move.l  $0004(A4), A0
		subq.w  #$03, D6
		bcs.s   Offset_0x00E584
Offset_0x00E572:
		cmp.b   (A0), D6
		bne.s   Offset_0x00E584
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E580
		addq.b  #$01, $0001(A5)
Offset_0x00E580:
		addq.w  #$06, A0
		bra.s   Offset_0x00E572
Offset_0x00E584:
		move.l  A0, $0004(A4)
		rts
Offset_0x00E58A:
		move.l  A1, -(A7)
		lea     ($FFFFF780).w, A1
		cmp.b   (A1)+, D6
		beq.s   Offset_0x00E5AA
		cmp.b   (A1)+, D6
		beq.s   Offset_0x00E5AA
		cmp.b   (A1)+, D6
		beq.s   Offset_0x00E5AA
		cmp.b   (A1)+, D6
		beq.s   Offset_0x00E5AA
		cmp.b   (A1)+, D6
		beq.s   Offset_0x00E5AA
		cmp.b   (A1)+, D6
		beq.s   Offset_0x00E5AA
		moveq   #$01, D0
Offset_0x00E5AA:
		move.l  (A7)+, A1
		rts
Offset_0x00E5AE:
		lea     ($FFFFF780).w, A1
		lea     (Obj_Start_Addr_2P).w, A3                    ; $FFFFBE00
		tst.b   (A1)+
		bmi.s   Offset_0x00E5E6
		lea     (Obj_Page_01_2P_Addr).w, A3                  ; $FFFFC100
		tst.b   (A1)+
		bmi.s   Offset_0x00E5E6
		lea     (Obj_Page_02_2P_Addr).w, A3                  ; $FFFFC400
		tst.b   (A1)+
		bmi.s   Offset_0x00E5E6
		lea     (Obj_Page_03_2P_Addr).w, A3                  ; $FFFFC700
		tst.b   (A1)+
		bmi.s   Offset_0x00E5E6
		lea     (Obj_Page_04_2P_Addr).w, A3                  ; $FFFFCA00
		tst.b   (A1)+
		bmi.s   Offset_0x00E5E6
		lea     (Obj_Page_05_2P_Addr).w, A3                  ; $FFFFCD00
		tst.b   (A1)+
		bmi.s   Offset_0x00E5E6
		nop
		nop
Offset_0x00E5E6:
		subq.w  #$01, A1
		rts
Offset_0x00E5EA:
		lea     ($FFFFF780).w, A1
		lea     (Obj_Start_Addr_2P).w, A3                    ; $FFFFBE00
		cmp.b   (A1)+, D2
		beq.s   Offset_0x00E622
		lea     (Obj_Page_01_2P_Addr).w, A3                  ; $FFFFC100
		cmp.b   (A1)+, D2
		beq.s   Offset_0x00E622
		lea     (Obj_Page_02_2P_Addr).w, A3                  ; $FFFFC400
		cmp.b   (A1)+, D2
		beq.s   Offset_0x00E622
		lea     (Obj_Page_03_2P_Addr).w, A3                  ; $FFFFC700
		cmp.b   (A1)+, D2
		beq.s   Offset_0x00E622
		lea     (Obj_Page_04_2P_Addr).w, A3                  ; $FFFFCA00
		cmp.b   (A1)+, D2
		beq.s   Offset_0x00E622
		lea     (Obj_Page_05_2P_Addr).w, A3                  ; $FFFFCD00
		cmp.b   (A1)+, D2
		beq.s   Offset_0x00E622
		nop
		nop
Offset_0x00E622:
		move.b  #$FF, -(A1)
		movem.l A1/A3, -(A7)
		moveq   #$00, D1
		moveq   #Obj_Page_Size_2P-$01, D2                          ; $0B
Offset_0x00E62E:
		tst.b   (A3)
		beq.s   Offset_0x00E64A
		move.l  A3, A1
		moveq   #$00, D0
		move.b  Obj_Respaw_Ref(A1), D0                           ; $0023    
		beq.s   DeleteObject_2P                        ; Offset_0x00E642
		bclr    #$07, $02(A2, D0)
;-------------------------------------------------------------------------------
;  Rotina para liberar a memória utilizada pelo Objeto em A1 no modo 2 jogadores
; ->>>                         
;------------------------------------------------------------------------------- 
DeleteObject_2P:                                               ; Offset_0x00E642
		moveq   #$0F, D0
Offset_0x00E644:
		move.l  D1, (A1)+
		dbra    D0, Offset_0x00E644  
;-------------------------------------------------------------------------------
;  Rotina para liberar a memória utilizada pelo Objeto em A1 no modo 2 jogadores
; <<<-                         
;-------------------------------------------------------------------------------  
Offset_0x00E64A:
		lea     Obj_Size(A3), A3                                 ; $0040
		dbra    D2, Offset_0x00E62E
		moveq   #$00, D2
		movem.l (A7)+, A1/A3
		rts
Offset_0x00E65A:
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E66E
		bset    #$07, $02(A2, D2)
		beq.s   Offset_0x00E66E
		addq.w  #$06, A0
		moveq   #$00, D0
		rts
Offset_0x00E66E:
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x00E6A2
		move.w  (A0)+, Obj_X(A1)                                 ; $0008
		move.w  (A0)+, D0
		bpl.s   Offset_0x00E680
		move.b  D2, Obj_Respaw_Ref(A1)                           ; $0023
Offset_0x00E680:
		move.w  D0, D1
		andi.w  #$0FFF, D0
		move.w  D0, Obj_Y(A1)                                    ; $000C
		rol.w   #$03, D1
		andi.b  #$03, D1
		move.b  D1, Obj_Flags(A1)                                ; $0001
		move.b  D1, Obj_Status(A1)                               ; $0022
		move.b  (A0)+, Obj_Id(A1)                                ; $0000
		move.b  (A0)+, Obj_Subtype(A1)                           ; $0028
		moveq   #$00, D0
Offset_0x00E6A2:
		rts
;------------------------------------------------------------------------------- 
Load_Object_2P:                                                ; Offset_0x00E6A4
		tst.b   $0002(A0)
		bpl.s   Offset_0x00E6B8
		bset    #$07, $02(A2, D2)
		beq.s   Offset_0x00E6B8
		addq.w  #$06, A0
		moveq   #$00, D0
		rts
Offset_0x00E6B8:
		btst    #$05, $0002(A0)
		beq.s   Offset_0x00E6C8
		bsr     SingleObjectLoad                       ; Offset_0x00E6FE
		bne.s   Offset_0x00E6FC
		bra.s   Offset_0x00E6CE
Offset_0x00E6C8:
		bsr     Load_Object_List                       ; Offset_0x00E730
		bne.s   Offset_0x00E6FC
Offset_0x00E6CE:
		move.w  (A0)+, Obj_X(A1)                                 ; $0008
		move.w  (A0)+, D0
		bpl.s   Offset_0x00E6DA
		move.b  D2, $0023(A1)
Offset_0x00E6DA:
		move.w  D0, D1
		andi.w  #$0FFF, D0
		move.w  D0, $000C(A1)
		rol.w   #$03, D1
		andi.b  #$03, D1
		move.b  D1, Obj_Flags(A1)                                ; $0001
		move.b  D1, Obj_Status(A1)                               ; $0022
		move.b  (A0)+, Obj_Id(A1)                                ; $0000
		move.b  (A0)+, Obj_Subtype(A1)                           ; $0028
		moveq   #$00, D0
Offset_0x00E6FC:
		rts
;-------------------------------------------------------------------------------
; Rotina para carregar um objeto a partir do endereco $FFFFB800
; ->>>
;-------------------------------------------------------------------------------                
SingleObjectLoad:                                              ; Offset_0x00E6FE
		lea     ($FFFFB800).w, A1
		move.w  #$005F, D0
Loop_Find_Free_Ram:                                            ; Offset_0x00E706
		tst.b   (A1)
		beq.s   Exit_SingleObjectLoad                  ; Offset_0x00E712
		lea     Obj_Size(A1), A1                                 ; $0040
		dbra    D0, Loop_Find_Free_Ram                 ; Offset_0x00E706
Exit_SingleObjectLoad:                                         ; Offset_0x00E712
		rts        
;-------------------------------------------------------------------------------
; Rotina para carregar um objeto a partir do endereco $FFFFB800
; <<<-
;------------------------------------------------------------------------------- 

;-------------------------------------------------------------------------------
; Rotina para carregar um objeto a partir do endereco $FFFFD000
; ->>>
;------------------------------------------------------------------------------- 
SingleObjectLoad_2:                                            ; Offset_0x00E714
		move.l  A0, A1
		move.w  #$D000, D0
		sub.w   A0, D0
		lsr.w   #$06, D0
		subq.w  #$01, D0
		bcs.s   Exit_SingleObjectLoad_2                ; Offset_0x00E72E
Loop_Find_Free_Ram_2:                                          ; Offset_0x00E722
		tst.b   (A1)
		beq.s   Exit_SingleObjectLoad_2                ; Offset_0x00E72E
		lea     Obj_Size(A1), A1                                 ; $0040
		dbra    D0, Loop_Find_Free_Ram_2               ; Offset_0x00E722
Exit_SingleObjectLoad_2:                                       ; Offset_0x00E72E
		rts
;-------------------------------------------------------------------------------
; Rotina para carregar um objeto a partir do endereco $FFFFD000
; <<<-
;-------------------------------------------------------------------------------                 

;-------------------------------------------------------------------------------
; Rotina para carregar a lista de objetos na memória
; ->>>
;------------------------------------------------------------------------------- 
Load_Object_List:                                              ; Offset_0x00E730
		move.l  A3, A1
		move.w  #$000B, D0
Loop_Find_Free_Ram_3:                                          ; Offset_0x00E736
		tst.b   (A1)
		beq.s   Exit_Load_Object_List                  ; Offset_0x00E742
		lea     Obj_Size(A1), A1                                 ; $0040
		dbra    D0, Loop_Find_Free_Ram_3               ; Offset_0x00E736
Exit_Load_Object_List:                                         ; Offset_0x00E742
		rts         
;-------------------------------------------------------------------------------
; Rotina para carregar a lista de objetos na memória
; <<<-
;-------------------------------------------------------------------------------                 
Obj_0x41_Springs:                                              ; Offset_0x00E744
		include 'objects/obj_0x41.asm' 
;-------------------------------------------------------------------------------                   
		nop                                                                          
;------------------------------------------------------------------------------- 
Obj_0x0D_End_Panel:                                            ; Offset_0x00F098
		include 'objects/obj_0x0D.asm'             
;-------------------------------------------------------------------------------                   
		nop                                                                          
;-------------------------------------------------------------------------------                    
SolidObject:                                                   ; Offset_0x00F344
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   SolidObject_A1                         ; Offset_0x00F362
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		tst.b   Obj_Flags(A1)                                    ; $0001
		bpl     Offset_0x00F39C
		addq.b  #$01, D6
SolidObject_A1:                                                ; Offset_0x00F362
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     SolidObject_Sub_00                     ; Offset_0x00F5F6
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F386
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F386
		cmp.w   D2, D0
		bcs.s   Offset_0x00F394
Offset_0x00F386:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F394:
		move.w  D4, D2
		bsr     Player_On_Platform                     ; Offset_0x00F78C
		moveq   #$00, D4
Offset_0x00F39C:
		rts    
;-------------------------------------------------------------------------------
SolidObject_2:                                                 ; Offset_0x00F39E
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   SolidObject_2_A1                       ; Offset_0x00F3B4
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
SolidObject_2_A1:                                              ; Offset_0x00F3B4
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     Solid_Object_Monitors                  ; Offset_0x00F5FE
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F3D8
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F3D8
		cmp.w   D2, D0
		bcs.s   Offset_0x00F3E6
Offset_0x00F3D8:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F3E6:
		move.w  D4, D2
		bsr     Player_On_Platform                     ; Offset_0x00F78C
		moveq   #$00, D4
		rts   
;-------------------------------------------------------------------------------
SolidObject_3:                                                 ; Offset_0x00F3F0
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   SolidObject_3_A1                       ; Offset_0x00F406
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
SolidObject_3_A1:                                              ; Offset_0x00F406
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     SolidObject_3_Sub_00                   ; Offset_0x00F53C
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F42A
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F42A
		cmp.w   D2, D0
		bcs.s   Offset_0x00F438
Offset_0x00F42A:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F438:
		move.w  D4, D2
		bsr     Offset_0x00F7C6
		moveq   #$00, D4
		rts 
;-------------------------------------------------------------------------------
Offset_0x00F442:
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   Offset_0x00F458
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
Offset_0x00F458:
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     Offset_0x00F596
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F47C
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F47C
		cmp.w   D2, D0
		bcs.s   Offset_0x00F48A
Offset_0x00F47C:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F48A:
		move.w  D4, D2
		bsr     Offset_0x00F808
		moveq   #$00, D4
		rts  
;-------------------------------------------------------------------------------
Offset_0x00F494:
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   Offset_0x00F4AA
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
Offset_0x00F4AA:
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     Offset_0x00F4FA
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F4CC
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F4CC
		add.w   D1, D1
		cmp.w   D1, D0
		bcs.s   Offset_0x00F4DA
Offset_0x00F4CC:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F4DA:
		move.w  Obj_Y(A0), D0                                    ; $000C
		sub.w   D2, D0
		add.w   D3, D0
		moveq   #$00, D1
		move.b  Obj_Height_2(A1), D1                             ; $0016
		sub.w   D1, D0
		move.w  D0, Obj_Y(A1)                                    ; $000C
		sub.w   Obj_X(A0), D4                                    ; $0008
		sub.w   D4, Obj_X(A1)                                    ; $0008
		moveq   #$00, D4
		rts
Offset_0x00F4FA:
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00F6D2
		move.w  D1, D4
		add.w   D4, D4
		cmp.w   D4, D0
		bhi     Offset_0x00F6D2
		move.w  Obj_Y(A0), D5                                    ; $000C
		add.w   D3, D5
		move.b  Obj_Height_2(A1), D3                             ; $0016
		ext.w   D3
		add.w   D3, D2
		move.w  Obj_Y(A1), D3                                    ; $000C
		sub.w   D5, D3
		addq.w  #$04, D3
		add.w   D2, D3
		bmi     Offset_0x00F6D2
		move.w  D2, D4
		add.w   D4, D4
		cmp.w   D4, D3
		bcc     Offset_0x00F6D2
		bra     SolidObject_3_Sub_01                   ; Offset_0x00F63C  
;-------------------------------------------------------------------------------
SolidObject_3_Sub_00:                                          ; Offset_0x00F53C
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00F6D2
		move.w  D1, D3
		add.w   D3, D3
		cmp.w   D3, D0
		bhi     Offset_0x00F6D2
		move.w  D0, D5
		btst    #$00, Obj_Flags(A0)                              ; $0001
		beq.s   Offset_0x00F562
		not.w   D5
		add.w   D3, D5
Offset_0x00F562:
		lsr.w   #$01, D5
		move.b  $00(A2, D5), D3
		sub.b   (A2), D3
		ext.w   D3
		move.w  Obj_Y(A0), D5                                    ; $000C
		sub.w   D3, D5
		move.b  Obj_Height_2(A1), D3                             ; $0016
		ext.w   D3
		add.w   D3, D2
		move.w  Obj_Y(A1), D3                                    ; $000C
		sub.w   D5, D3
		addq.w  #$04, D3
		add.w   D2, D3
		bmi     Offset_0x00F6D2
		move.w  D2, D4
		add.w   D4, D4
		cmp.w   D4, D3
		bcc     Offset_0x00F6D2
		bra     SolidObject_3_Sub_01                   ; Offset_0x00F63C 
;------------------------------------------------------------------------------- 
Offset_0x00F596:
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00F6D2
		move.w  D1, D3
		add.w   D3, D3
		cmp.w   D3, D0
		bhi     Offset_0x00F6D2
		move.w  D0, D5
		btst    #$00, Obj_Flags(A0)                              ; $0001
		beq.s   Offset_0x00F5BC
		not.w   D5
		add.w   D3, D5
Offset_0x00F5BC:
		andi.w  #$FFFFFFFE, D5
		move.b  $00(A2, D5), D3
		move.b  $01(A2, D5), D2
		ext.w   D2
		ext.w   D3
		move.w  Obj_Y(A0), D5                                    ; $000C
		sub.w   D3, D5
		move.w  Obj_Y(A1), D3                                    ; $000C
		sub.w   D5, D3
		move.b  Obj_Height_2(A1), D5                             ; $0016
		ext.w   D5
		add.w   D5, D3
		addq.w  #$04, D3
		bmi     Offset_0x00F6D2
		add.w   D5, D2
		move.w  D2, D4
		add.w   D5, D4
		cmp.w   D4, D3
		bcc     Offset_0x00F6D2
		bra     SolidObject_3_Sub_01                   ; Offset_0x00F63C
;-------------------------------------------------------------------------------
SolidObject_Sub_00:                                            ; Offset_0x00F5F6
		tst.b   Obj_Flags(A0)                                    ; $0001
		bpl     Offset_0x00F6D2  
;-------------------------------------------------------------------------------                
Solid_Object_Monitors:                                         ; Offset_0x00F5FE
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00F6D2
		move.w  D1, D3
		add.w   D3, D3
		cmp.w   D3, D0
		bhi     Offset_0x00F6D2
		move.b  Obj_Height_2(A1), D3                             ; $0016
		ext.w   D3
		add.w   D3, D2
		move.w  Obj_Y(A1), D3                                    ; $000C
		sub.w   Obj_Y(A0), D3                                    ; $000C
		addq.w  #$04, D3
		add.w   D2, D3
		bmi     Offset_0x00F6D2
		andi.w  #$07FF, D3
		move.w  D2, D4
		add.w   D4, D4
		cmp.w   D4, D3
		bcc     Offset_0x00F6D2
SolidObject_3_Sub_01:                                          ; Offset_0x00F63C
		tst.b   Obj_Timer(A1)                                    ; $002A
		bmi     Offset_0x00F6D2
		cmpi.b  #$06, Obj_Routine(A1)                            ; $0024
		bcc     Offset_0x00F6F0
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne     Offset_0x00F6F0
		move.w  D0, D5
		cmp.w   D0, D1
		bcc.s   Offset_0x00F664
		add.w   D1, D1
		sub.w   D1, D0
		move.w  D0, D5
		neg.w   D5
Offset_0x00F664:
		move.w  D3, D1
		cmp.w   D3, D2
		bcc.s   Offset_0x00F672
		subq.w  #$04, D3
		sub.w   D4, D3
		move.w  D3, D1
		neg.w   D1
Offset_0x00F672:
		cmp.w   D1, D5
		bhi     Offset_0x00F6F4
Offset_0x00F678:
		cmpi.w  #$0004, D1
		bls.s   Offset_0x00F6C4
		tst.w   D0
		beq.s   Offset_0x00F69E
		bmi.s   Offset_0x00F68C
		tst.w   Obj_Speed(A1)                                    ; $0010
		bmi.s   Offset_0x00F69E
		bra.s   Offset_0x00F692
Offset_0x00F68C:
		tst.w   Obj_Speed(A1)                                    ; $0010
		bpl.s   Offset_0x00F69E
Offset_0x00F692:
		move.w  #$0000, Obj_Inertia(A1)                          ; $0014
		move.w  #$0000, Obj_Speed(A1)                            ; $0010
Offset_0x00F69E:
		sub.w   D0, Obj_X(A1)                                    ; $0008
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F6C4
		move.l  D6, D4
		addq.b  #$02, D4
		bset    D4, Obj_Status(A0)                               ; $0022
		bset    #$05, Obj_Status(A1)                             ; $0022
		move.w  D6, D4
		addi.b  #$0D, D4
		bset    D4, D6
		moveq   #$01, D4
		rts
Offset_0x00F6C4:
		bsr.s   Offset_0x00F6E2
		move.w  D6, D4
		addi.b  #$0D, D4
		bset    D4, D6
		moveq   #$01, D4
		rts
Offset_0x00F6D2:
		move.l  D6, D4
		addq.b  #$02, D4
		btst    D4, Obj_Status(A0)                               ; $0022
		beq.s   Offset_0x00F6F0
		move.w  #$0001, Obj_Ani_Number(A1)                       ; $001C
Offset_0x00F6E2:
		move.l  D6, D4
		addq.b  #$02, D4
		bclr    D4, Obj_Status(A0)                               ; $0022
		bclr    #$05, Obj_Status(A1)                             ; $0022
Offset_0x00F6F0:
		moveq   #$00, D4
		rts
Offset_0x00F6F4:
		tst.w   D3
		bmi.s   Offset_0x00F700
		cmpi.w  #$0010, D3
		bcs.s   Offset_0x00F750
		bra.s   Offset_0x00F6D2
Offset_0x00F700:
		tst.w   Obj_Speed_Y(A1)                                  ; $0012
		beq.s   Offset_0x00F722
		bpl.s   Offset_0x00F716
		tst.w   D3
		bpl.s   Offset_0x00F716
		sub.w   D3, Obj_Y(A1)                                    ; $000C
		move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
Offset_0x00F716:
		move.w  D6, D4
		addi.b  #$0F, D4
		bset    D4, D6
		moveq   #-$02, D4
		rts
Offset_0x00F722:
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F716
		move.w  D0, D4
		bpl.s   Offset_0x00F730
		neg.w   D4
Offset_0x00F730:
		cmpi.w  #$0010, D4
		bcs     Offset_0x00F678
		move.l  A0, -(A7)
		move.l  A1, A0
		jsr     (Kill_Player)                          ; Offset_0x02B57C
		move.l  (A7)+, A0
		move.w  D6, D4
		addi.b  #$0F, D4
		bset    D4, D6
		moveq   #-$02, D4
		rts
Offset_0x00F750:
		subq.w  #$04, D3
		moveq   #$00, D1
		move.b  Obj_Width(A0), D1                                ; $0019
		move.w  D1, D2
		add.w   D2, D2
		add.w   Obj_X(A1), D1                                    ; $0008
		sub.w   Obj_X(A0), D1                                    ; $0008
		bmi.s   Offset_0x00F788
		cmp.w   D2, D1
		bcc.s   Offset_0x00F788
		tst.w   Obj_Speed_Y(A1)                                  ; $0012
		bmi.s   Offset_0x00F788
		sub.w   D3, Obj_Y(A1)                                    ; $000C
		subq.w  #$01, Obj_Y(A1)                                  ; $000C
		bsr     Player_On_Spiral                       ; Offset_0x00F99A
		move.w  D6, D4
		addi.b  #$11, D4
		bset    D4, D6
		moveq   #-$01, D4
		rts
Offset_0x00F788:
		moveq   #$00, D4
		rts     
;-------------------------------------------------------------------------------
Player_On_Platform:                                            ; Offset_0x00F78C
		move.w  Obj_Y(A0), D0                                    ; $000C
		sub.w   D3, D0
		bra.s   Offset_0x00F79C
Offset_0x00F794:
		move.w  Obj_Y(A0), D0                                    ; $000C
		subi.w  #$0009, D0
Offset_0x00F79C:
		tst.b   Obj_Timer(A1)                                    ; $002A
		bmi.s   Offset_0x00F7C4
		cmpi.b  #$06, Obj_Routine(A1)                            ; $0024
		bcc.s   Offset_0x00F7C4
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne.s   Offset_0x00F7C4
		moveq   #$00, D1
		move.b  Obj_Height_2(A1), D1                             ; $0016
		sub.w   D1, D0
		move.w  D0, Obj_Y(A1)                                    ; $000C
		sub.w   Obj_X(A0), D2                                    ; $0008
		sub.w   D2, Obj_X(A1)                                    ; $0008
Offset_0x00F7C4:
		rts   
;-------------------------------------------------------------------------------
Offset_0x00F7C6:
		btst    #$03, Obj_Status(A1)                             ; $0022
		beq.s   Offset_0x00F806
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		lsr.w   #$01, D0
		btst    #$00, Obj_Flags(A0)                              ; $0001
		beq.s   Offset_0x00F7E6
		not.w   D0
		add.w   D1, D0
Offset_0x00F7E6:
		move.b  $00(A2, D0), D1
		ext.w   D1
		move.w  Obj_Y(A0), D0                                    ; $000C
		sub.w   D1, D0
		moveq   #$00, D1
		move.b  Obj_Height_2(A1), D1                             ; $0016
		sub.w   D1, D0
		move.w  D0, Obj_Y(A1)                                    ; $000C
		sub.w   Obj_X(A0), D2                                    ; $0008
		sub.w   D2, Obj_X(A1)                                    ; $0008
Offset_0x00F806:
		rts    
;-------------------------------------------------------------------------------
Offset_0x00F808:
		btst    #$03, Obj_Status(A1)                             ; $0022
		beq.s   Offset_0x00F806
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		btst    #$00, Obj_Flags(A0)                              ; $0001
		beq.s   Offset_0x00F826
		not.w   D0
		add.w   D1, D0
Offset_0x00F826:
		andi.w  #$FFFFFFFE, D0
		bra.s   Offset_0x00F7E6
;-------------------------------------------------------------------------------
Platform_Object:                                               ; Offset_0x00F82C
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   Platform_Object_A1                     ; Offset_0x00F842
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
Platform_Object_A1:                                            ; Offset_0x00F842
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     Offset_0x00F940
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F866
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F866
		cmp.w   D2, D0
		bcs.s   Offset_0x00F874
Offset_0x00F866:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F874:
		move.w  D4, D2
		bsr     Player_On_Platform                     ; Offset_0x00F78C
		moveq   #$00, D4
		rts   
;-------------------------------------------------------------------------------
Platform_Object_2:                                             ; Offset_0x00F87E
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   Platform_Object_2_A1                   ; Offset_0x00F894
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
Platform_Object_2_A1:                                          ; Offset_0x00F894
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     Offset_0x00FA08
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F8B8
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F8B8
		cmp.w   D2, D0
		bcs.s   Offset_0x00F8C6
Offset_0x00F8B8:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F8C6:
		move.w  D4, D2
		bsr     Offset_0x00F7C6
		moveq   #$00, D4
		rts  
;-------------------------------------------------------------------------------
Platform_Object_3:                                             ; Offset_0x00F8D0
		lea     (Player_One).w, A1                           ; $FFFFB000
		moveq   #$03, D6
		movem.l D1-D4, -(A7)
		bsr.s   Platform_Object_3_A1                   ; Offset_0x00F8E6
		movem.l (A7)+, D1-D4
		lea     (Player_Two).w, A1                           ; $FFFFB040
		addq.b  #$01, D6
Platform_Object_3_A1:                                          ; Offset_0x00F8E6
		btst    D6, Obj_Status(A0)                               ; $0022
		beq     Offset_0x00FA40
		move.w  D1, D2
		add.w   D2, D2
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00F90A
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00F90A
		cmp.w   D2, D0
		bcs.s   Offset_0x00F918
Offset_0x00F90A:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    D6, Obj_Status(A0)                               ; $0022
		moveq   #$00, D4
		rts
Offset_0x00F918:
		move.w  D4, D2
		bsr     Player_On_Platform                     ; Offset_0x00F78C
		moveq   #$00, D4
		rts    
;-------------------------------------------------------------------------------   
Offset_0x00F922:
		tst.w   Obj_Speed_Y(A1)                                  ; $0012
		bmi     Offset_0x00FA06
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00FA06
		cmp.w   D2, D0
		bcc     Offset_0x00FA06
		bra.s   Offset_0x00F95E   
;-------------------------------------------------------------------------------
Offset_0x00F940:
		tst.w   Obj_Speed_Y(A1)                                  ; $0012
		bmi     Offset_0x00FA06
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00FA06
		add.w   D1, D1
		cmp.w   D1, D0
		bcc     Offset_0x00FA06
Offset_0x00F95E:
		move.w  Obj_Y(A0), D0                                    ; $000C
		sub.w   D3, D0
Offset_0x00F964:                
		move.w  Obj_Y(A1), D2                                    ; $000C
		move.b  Obj_Height_2(A1), D1                             ; $0016
		ext.w   D1
		add.w   D2, D1
		addq.w  #$04, D1
		sub.w   D1, D0
		bhi     Offset_0x00FA06
		cmpi.w  #$FFF0, D0
		bcs     Offset_0x00FA06
		tst.b   Obj_Timer(A1)                                    ; $002A
		bmi     Offset_0x00FA06
		cmpi.b  #$06, Obj_Routine(A1)                            ; $0024
		bcc     Offset_0x00FA06
		add.w   D0, D2
		addq.w  #$03, D2
		move.w  D2, Obj_Y(A1)                                    ; $000C
;-------------------------------------------------------------------------------
Player_On_Spiral:                                              ; Offset_0x00F99A                
		btst    #$03, Obj_Status(A1)                             ; $0022
		beq.s   Offset_0x00F9B6
		moveq   #$00, D0
		move.b  Obj_Player_Last(A1), D0                          ; $003D
		lsl.w   #$06, D0
		addi.l  #Player_One, D0                              ; $FFFFB000
		move.l  D0, A3
		bclr    D6, Obj_Status(A3)                               ; $0022
Offset_0x00F9B6:
		move.w  A0, D0
		subi.w  #Obj_Memory_Address, D0                          ; $B000
		lsr.w   #$06, D0
		andi.w  #$007F, D0
		move.b  D0, Obj_Control_Var_11(A1)                       ; $003D
		move.b  #$00, Obj_Angle(A1)                              ; $0026
		move.w  #$0000, Obj_Speed_Y(A1)                          ; $0012
		move.w  Obj_Speed(A1), Obj_Inertia(A1)            ; $0010, $0014
		btst    #$01, Obj_Status(A1)                             ; $0022
		beq.s   Offset_0x00F9FC
		move.l  A0, -(A7)
		move.l  A1, A0
		move.w  A0, D1
		subi.w  #Obj_Memory_Address, D1                          ; $B000
		bne.s   Offset_0x00F9F4
		jsr     (Sonic_ResetOnFloor)                   ; Offset_0x010A46
		bra.s   Offset_0x00F9FA
Offset_0x00F9F4:
		jsr     (Miles_ResetOnFloor)                   ; Offset_0x011EC6
Offset_0x00F9FA:
		move.l  (A7)+, A0
Offset_0x00F9FC:
		bset    #$03, Obj_Status(A1)                             ; $0022
		bset    D6, Obj_Status(A0)                               ; $0022
Offset_0x00FA06:
		rts   
;------------------------------------------------------------------------------- 
Offset_0x00FA08:
		tst.w   Obj_Speed_Y(A1)                                  ; $0012
		bmi     Offset_0x00FA06
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00FA06
		add.w   D1, D1
		cmp.w   D1, D0
		bcc.s   Offset_0x00FA06
		btst    #$00, Obj_Flags(A0)                              ; $0001
		beq.s   Offset_0x00FA2E
		not.w   D0
		add.w   D1, D0
Offset_0x00FA2E:
		lsr.w   #$01, D0
		move.b  $00(A2, D0), D3
		ext.w   D3
		move.w  Obj_Y(A0), D0                                    ; $000C
		sub.w   D3, D0
		bra     Offset_0x00F964  
;-------------------------------------------------------------------------------
Offset_0x00FA40:
		tst.w   Obj_Speed_Y(A1)                                  ; $0012
		bmi     Offset_0x00FA06
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi     Offset_0x00FA06
		add.w   D1, D1
		cmp.w   D1, D0
		bcc     Offset_0x00FA06
		move.w  Obj_Y(A0), D0                                    ; $000C
		sub.w   D3, D0
		bra     Offset_0x00F964  
;-------------------------------------------------------------------------------
Exit_Plaform:                                                  ; Offset_0x00FA68
		move.w  D1, D2
		add.w   D2, D2
		lea     (Player_One).w, A1                           ; $FFFFB000
		btst    #$01, Obj_Status(A1)                             ; $0022
		bne.s   Offset_0x00FA88
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   Obj_X(A0), D0                                    ; $0008
		add.w   D1, D0
		bmi.s   Offset_0x00FA88
		cmp.w   D2, D0
		bcs.s   Offset_0x00FA9A
Offset_0x00FA88:
		bclr    #$03, Obj_Status(A1)                             ; $0022
		move.b  #$02, Obj_Routine(A0)                            ; $0024
		bclr    #$03, Obj_Status(A0)                             ; $0022
Offset_0x00FA9A:
		rts 
;-------------------------------------------------------------------------------
Offset_0x00FA9C: ; Usado pelo objeto 0x30 - Terremoto na Hill Top
		lea     (Player_One).w, A1                           ; $FFFFB000
		btst    #$03, Obj_Status(A0)                             ; $0022
		beq.s   Offset_0x00FAC4
		jsr     (Player_HitFloor_A1)                   ; Offset_0x0141B2
		tst.w   D1
		beq.s   Offset_0x00FAB4
		bpl.s   Offset_0x00FAC4
Offset_0x00FAB4:
		lea     (Player_One).w, A1                           ; $FFFFB000
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    #$03, Obj_Status(A0)                             ; $0022
Offset_0x00FAC4:
		lea     (Player_Two).w, A1                           ; $FFFFB040
		btst    #$04, Obj_Status(A0)                             ; $0022
		beq.s   Offset_0x00FAEC
		jsr     (Player_HitFloor_A1)                   ; Offset_0x0141B2
		tst.w   D1
		beq.s   Offset_0x00FADC
		bpl.s   Offset_0x00FAEC
Offset_0x00FADC:
		lea     (Player_Two).w, A1                           ; $FFFFB040
		bclr    #$03, Obj_Status(A1)                             ; $0022
		bclr    #$04, Obj_Status(A0)                             ; $0022
Offset_0x00FAEC:
		moveq   #$00, D4
		rts             
;-------------------------------------------------------------------------------
Obj_0x01_Sonic:                                                ; Offset_0x00FAF0
		include 'objects/obj_0x01.asm' 
;-------------------------------------------------------------------------------
Kill_Sonic:                                                    ; Offset_0x011128
		jmp     (Kill_Player)                          ; Offset_0x02B57C
;-------------------------------------------------------------------------------                                 
		dc.w    $0000                           
;-------------------------------------------------------------------------------
Obj_0x02_Miles:                                                ; Offset_0x011130
		include 'objects/obj_0x02.asm'  
Obj_0x05_Miles_Tail:                                           ; Offset_0x012442   
		include 'objects/obj_0x05.asm'          
;-------------------------------------------------------------------------------        
Kill_Miles:                                                    ; Offset_0x012544
		jmp     (Kill_Player)                          ; Offset_0x02B57C 
;-------------------------------------------------------------------------------                                 
		dc.w    $0000     
;-------------------------------------------------------------------------------                
Obj_0x0A_Sonic_Miles_Underwater:                               ; Offset_0x01254C
		include 'objects/obj_0x0A.asm'
Obj_0x38_Shield:                                               ; Offset_0x012AF0
		include 'objects/obj_0x38.asm'   
Obj_0x35_Invincibility:                                        ; Offset_0x012B72
		include 'objects/obj_0x35.asm'          
;-------------------------------------------------------------------------------
Shield_AnimateData:                                            ; Offset_0x013066
		dc.w    Offset_0x013068-Shield_AnimateData
Offset_0x013068:
		dc.b    $00, $05, $00, $05
		dc.b    $01, $05, $02, $05
		dc.b    $03, $05, $04, $FF
;-------------------------------------------------------------------------------
Shield_Mappings:                                               ; Offset_0x013074
		dc.w    Offset_0x013080-Shield_Mappings
		dc.w    Offset_0x0130A2-Shield_Mappings
		dc.w    Offset_0x0130C4-Shield_Mappings
		dc.w    Offset_0x0130E6-Shield_Mappings
		dc.w    Offset_0x013108-Shield_Mappings
		dc.w    Offset_0x01312A-Shield_Mappings
Offset_0x013080:
		dc.w    $0004
		dc.l    $F0050000, $0000FFF0
		dc.l    $F0050800, $08000000
		dc.l    $00051000, $1000FFF0
		dc.l    $00051800, $18000000
Offset_0x0130A2:
		dc.w    $0004
		dc.l    $F0050004, $0002FFF0
		dc.l    $F0050804, $08020000
		dc.l    $00051004, $1002FFF0
		dc.l    $00051804, $18020000
Offset_0x0130C4:
		dc.w    $0004
		dc.l    $F0050008, $0004FFF0
		dc.l    $F0050808, $08040000
		dc.l    $00051008, $1004FFF0
		dc.l    $00051808, $18040000
Offset_0x0130E6:
		dc.w    $0004
		dc.l    $F005000C, $0006FFF0
		dc.l    $F005080C, $08060000
		dc.l    $0005100C, $1006FFF0
		dc.l    $0005180C, $18060000
Offset_0x013108:
		dc.w    $0004
		dc.l    $F0050010, $0008FFF0
		dc.l    $F0050810, $08080000
		dc.l    $00051010, $1008FFF0
		dc.l    $00051810, $18080000
Offset_0x01312A:
		dc.w    $0004
		dc.l    $E00B0014, $000AFFE8
		dc.l    $E00B0814, $080A0000
		dc.l    $000B1014, $100AFFE8
		dc.l    $000B1814, $180A0000  
;-------------------------------------------------------------------------------
Invicibility_Stars_Mappings:                                   ; Offset_0x01314C
		dc.w    Offset_0x01315E-Invicibility_Stars_Mappings
		dc.w    Offset_0x013160-Invicibility_Stars_Mappings
		dc.w    Offset_0x01316A-Invicibility_Stars_Mappings
		dc.w    Offset_0x013174-Invicibility_Stars_Mappings
		dc.w    Offset_0x01317E-Invicibility_Stars_Mappings
		dc.w    Offset_0x013188-Invicibility_Stars_Mappings
		dc.w    Offset_0x013192-Invicibility_Stars_Mappings
		dc.w    Offset_0x01319C-Invicibility_Stars_Mappings
		dc.w    Offset_0x0131A6-Invicibility_Stars_Mappings
Offset_0x01315E:
		dc.w    $0000
Offset_0x013160:
		dc.w    $0001
		dc.l    $F8010000, $0000FFFC
Offset_0x01316A:
		dc.w    $0001
		dc.l    $F8010002, $0001FFFC
Offset_0x013174:
		dc.w    $0001
		dc.l    $F8010004, $0002FFFC
Offset_0x01317E:
		dc.w    $0001
		dc.l    $F8010006, $0003FFFC
Offset_0x013188:
		dc.w    $0001
		dc.l    $F8010008, $0004FFFC
Offset_0x013192:
		dc.w    $0001
		dc.l    $F805000A, $0005FFF8
Offset_0x01319C:
		dc.w    $0001
		dc.l    $F805000E, $0007FFF8
Offset_0x0131A6:
		dc.w    $0001
		dc.l    $F00F0012, $0009FFF0    
;-------------------------------------------------------------------------------
Obj_0x08_Dust_Water_Splash:                                    ; Offset_0x0131B0    
		include 'objects/obj_0x08.asm'
Obj_0x7E_Super_Sonic_Stars:                                    ; Offset_0x013552
		include 'objects/obj_0x7E.asm'                                                               
;===============================================================================
; Rotina para calcular o ângulo do jogador
; ->>>                    
;===============================================================================
Player_AnglePos:                                               ; Offset_0x013694
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
		beq.s   Offset_0x0136AC
		move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x0136AC:
		move.b  Obj_Player_Top_Solid(A0), D5                     ; $003E
		btst    #$03, Obj_Status(A0)                             ; $0022
		beq.s   Offset_0x0136C4
		moveq   #$00, D0
		move.b  D0, ($FFFFF768).w
		move.b  D0, ($FFFFF76A).w
		rts
Offset_0x0136C4:
		moveq   #$03, D0
		move.b  D0, ($FFFFF768).w
		move.b  D0, ($FFFFF76A).w
		move.b  Obj_Angle(A0), D0                                ; $0026
		addi.b  #$20, D0
		bpl.s   Offset_0x0136E6
		move.b  Obj_Angle(A0), D0                                ; $0026
		bpl.s   Offset_0x0136E0
		subq.b  #$01, D0
Offset_0x0136E0:
		addi.b  #$20, D0
		bra.s   Offset_0x0136F2
Offset_0x0136E6:
		move.b  Obj_Angle(A0), D0                                ; $0026
		bpl.s   Offset_0x0136EE
		addq.b  #$01, D0
Offset_0x0136EE:
		addi.b  #$1F, D0
Offset_0x0136F2:
		andi.b  #$C0, D0
		cmpi.b  #$40, D0
		beq     Player_WalkVertL                       ; Offset_0x013948
		cmpi.b  #$80, D0
		beq     Player_WalkCeiling                     ; Offset_0x01389A
		cmpi.b  #$C0, D0
		beq     Player_WalkVertR                       ; Offset_0x0137F2
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF768).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		neg.w   D0
		add.w   D0, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  (A7)+, D0
		bsr     Player_Angle                           ; Offset_0x0137B6
		tst.w   D1
		beq.s   Offset_0x01377C
		bpl.s   Offset_0x01377E
		cmpi.w  #$FFF2, D1
		blt.s   Offset_0x01377C
		add.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x01377C:
		rts
Offset_0x01377E:
		move.b  Obj_Speed(A0), D0                                ; $0010
		bpl.s   Offset_0x013786
		neg.b   D0
Offset_0x013786:
		addq.b  #$04, D0
		cmpi.b  #$0E, D0
		bcs.s   Offset_0x013792
		move.b  #$0E, D0
Offset_0x013792:
		cmp.b   D0, D1
		bgt.s   Offset_0x01379C
Offset_0x013796:
		add.w   D1, Obj_Y(A0)                                    ; $000C
		rts
Offset_0x01379C:
		tst.b   Obj_Player_St_Convex(A0)                         ; $0038
		bne.s   Offset_0x013796
		bset    #$01, Obj_Status(A0)                             ; $0022
		bclr    #$05, Obj_Status(A0)                             ; $0022
		move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
		rts
;-------------------------------------------------------------------------------                
Player_Angle:                                                  ; Offset_0x0137B6
		move.b  ($FFFFF76A).w, D2
		cmp.w   D0, D1
		ble.s   Offset_0x0137C4
		move.b  ($FFFFF768).w, D2
		move.w  D0, D1
Offset_0x0137C4:
		btst    #$00, D2
		bne.s   Offset_0x0137E0
		move.b  D2, D0
		sub.b   Obj_Angle(A0), D0                                ; $0026
		bpl.s   Offset_0x0137D4
		neg.b   D0
Offset_0x0137D4:
		cmpi.b  #$20, D0
		bcc.s   Offset_0x0137E0
		move.b  D2, Obj_Angle(A0)                                ; $0026
		rts
Offset_0x0137E0:
		move.b  Obj_Angle(A0), D2                                ; $0026
		addi.b  #$20, D2
		andi.b  #$C0, D2
		move.b  D2, Obj_Angle(A0)                                ; $0026
		rts
;===============================================================================
; Rotina para calcular o ângulo do jogador
; <<<-                    
;===============================================================================    
	    
;===============================================================================
; Rotina para calcular a posição do jogador em rampas
; ->>>                    
;===============================================================================
Player_WalkVertR:                                              ; Offset_0x0137F2
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		neg.w   D0
		add.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF768).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  (A7)+, D0
		bsr     Player_Angle                           ; Offset_0x0137B6
		tst.w   D1
		beq.s   Offset_0x013860
		bpl.s   Offset_0x013862
		cmpi.w  #$FFF2, D1
		blt.s   Offset_0x013860
		add.w   D1, Obj_X(A0)                                    ; $0008
Offset_0x013860:
		rts
Offset_0x013862:
		move.b  Obj_Speed_Y(A0), D0                              ; $0012
		bpl.s   Offset_0x01386A
		neg.b   D0
Offset_0x01386A:
		addq.b  #$04, D0
		cmpi.b  #$0E, D0
		bcs.s   Offset_0x013876
		move.b  #$0E, D0
Offset_0x013876:
		cmp.b   D0, D1
		bgt.s   Offset_0x013880
Offset_0x01387A:
		add.w   D1, Obj_X(A0)                                    ; $0008
		rts
Offset_0x013880:
		tst.b   Obj_Player_St_Convex(A0)                         ; $0038
		bne.s   Offset_0x01387A
		bset    #$01, Obj_Status(A0)                             ; $0022
		bclr    #$05, Obj_Status(A0)                             ; $0022
		move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
		rts                 
;===============================================================================
; Rotina para calcular a posição do jogador em rampas
; <<<-                    
;===============================================================================                
		
;===============================================================================
; Rotina para calcular a posição do jogador ao andar no teto
; ->>>                    
;===============================================================================                
Player_WalkCeiling:                                            ; Offset_0x01389A
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D2
		eori.w  #$000F, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0800, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D2
		eori.w  #$000F, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		sub.w   D0, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$FFF0, A3
		move.w  #$0800, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  (A7)+, D0
		bsr     Player_Angle                           ; Offset_0x0137B6
		tst.w   D1
		beq.s   Offset_0x01390E
		bpl.s   Offset_0x013910
		cmpi.w  #$FFF2, D1
		blt.s   Offset_0x01390E
		sub.w   D1, Obj_Y(A0)                                    ; $000C
Offset_0x01390E:
		rts
Offset_0x013910:
		move.b  Obj_Speed(A0), D0                                ; $0010
		bpl.s   Offset_0x013918
		neg.b   D0
Offset_0x013918:
		addq.b  #$04, D0
		cmpi.b  #$0E, D0
		bcs.s   Offset_0x013924
		move.b  #$0E, D0
Offset_0x013924:
		cmp.b   D0, D1
		bgt.s   Offset_0x01392E
Offset_0x013928:
		sub.w   D1, Obj_Y(A0)                                    ; $000C
		rts
Offset_0x01392E:
		tst.b   Obj_Player_St_Convex(A0)                         ; $0038
		bne.s   Offset_0x013928
		bset    #$01, Obj_Status(A0)                             ; $0022
		bclr    #$05, Obj_Status(A0)                             ; $0022
		move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
		rts
;===============================================================================
; Rotina para calcular a posição do jogador ao andar no teto
; <<<-                    
;===============================================================================  
		 
;===============================================================================
; Rotina para calcular a posição do jogador em rampas
; ->>>                    
;===============================================================================             
Player_WalkVertL:                                              ; Offset_0x013948
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		sub.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D3
		eori.w  #$000F, D3
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0400, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D3
		eori.w  #$000F, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$FFF0, A3
		move.w  #$0400, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  (A7)+, D0
		bsr     Player_Angle                           ; Offset_0x0137B6
		tst.w   D1
		beq.s   Offset_0x0139BC
		bpl.s   Offset_0x0139BE
		cmpi.w  #$FFF2, D1
		blt.s   Offset_0x0139BC
		sub.w   D1, Obj_X(A0)                                    ; $0008
Offset_0x0139BC:
		rts
Offset_0x0139BE:
		move.b  Obj_Speed_Y(A0), D0                              ; $0012
		bpl.s   Offset_0x0139C6
		neg.b   D0
Offset_0x0139C6:
		addq.b  #$04, D0
		cmpi.b  #$0E, D0
		bcs.s   Offset_0x0139D2
		move.b  #$0E, D0
Offset_0x0139D2:
		cmp.b   D0, D1
		bgt.s   Offset_0x0139DC
Offset_0x0139D6:
		sub.w   D1, Obj_X(A0)                                    ; $0008
		rts
Offset_0x0139DC:
		tst.b   Obj_Player_St_Convex(A0)                         ; $0038
		bne.s   Offset_0x0139D6
		bset    #$01, Obj_Status(A0)                             ; $0022
		bclr    #$05, Obj_Status(A0)                             ; $0022
		move.b  #$01, Obj_Ani_Flag(A0)                           ; $001D
		rts
;===============================================================================
; Rotina para calcular a posição do jogador em rampas
; <<<-                    
;===============================================================================                 

;===============================================================================
; Rotina para testar em qual tile o objeto esta
; ->>>
;===============================================================================
Floor_Check_Tile:                                              ; Offset_0x0139F6
		move.w  D2, D0
		add.w   D0, D0
		andi.w  #$0F00, D0
		move.w  D3, D1
		lsr.w   #$03, D1
		move.w  D1, D4
		lsr.w   #$04, D1
		andi.w  #$007F, D1
		add.w   D1, D0
		moveq   #-$01, D1
		clr.w   D1
		lea     (Level_Map_Buffer).w, A1                     ; $FFFF8000
		move.b  $00(A1, D0), D1
		add.w   D1, D1
		move.w  Chunk_Mem_Address(PC, D1), D1          ; Offset_0x013A30
		move.w  D2, D0
		andi.w  #$0070, D0
		add.w   D0, D1
		andi.w  #$000E, D4
		add.w   D4, D1
		move.l  D1, A1
		rts                
;-------------------------------------------------------------------------------
; Tabela contendo os endereços dos tiles 128x128 -> Ex: Tile 1 = $0080
; ->>>
;-------------------------------------------------------------------------------                     
Chunk_Mem_Address:                                             ; Offset_0x013A30 
		dc.w    $0000, $0080, $0100, $0180, $0200, $0280, $0300, $0380
		dc.w    $0400, $0480, $0500, $0580, $0600, $0680, $0700, $0780
		dc.w    $0800, $0880, $0900, $0980, $0A00, $0A80, $0B00, $0B80
		dc.w    $0C00, $0C80, $0D00, $0D80, $0E00, $0E80, $0F00, $0F80
		dc.w    $1000, $1080, $1100, $1180, $1200, $1280, $1300, $1380
		dc.w    $1400, $1480, $1500, $1580, $1600, $1680, $1700, $1780
		dc.w    $1800, $1880, $1900, $1980, $1A00, $1A80, $1B00, $1B80
		dc.w    $1C00, $1C80, $1D00, $1D80, $1E00, $1E80, $1F00, $1F80
		dc.w    $2000, $2080, $2100, $2180, $2200, $2280, $2300, $2380
		dc.w    $2400, $2480, $2500, $2580, $2600, $2680, $2700, $2780
		dc.w    $2800, $2880, $2900, $2980, $2A00, $2A80, $2B00, $2B80
		dc.w    $2C00, $2C80, $2D00, $2D80, $2E00, $2E80, $2F00, $2F80
		dc.w    $3000, $3080, $3100, $3180, $3200, $3280, $3300, $3380
		dc.w    $3400, $3480, $3500, $3580, $3600, $3680, $3700, $3780
		dc.w    $3800, $3880, $3900, $3980, $3A00, $3A80, $3B00, $3B80
		dc.w    $3C00, $3C80, $3D00, $3D80, $3E00, $3E80, $3F00, $3F80
		dc.w    $4000, $4080, $4100, $4180, $4200, $4280, $4300, $4380
		dc.w    $4400, $4480, $4500, $4580, $4600, $4680, $4700, $4780
		dc.w    $4800, $4880, $4900, $4980, $4A00, $4A80, $4B00, $4B80
		dc.w    $4C00, $4C80, $4D00, $4D80, $4E00, $4E80, $4F00, $4F80
		dc.w    $5000, $5080, $5100, $5180, $5200, $5280, $5300, $5380
		dc.w    $5400, $5480, $5500, $5580, $5600, $5680, $5700, $5780
		dc.w    $5800, $5880, $5900, $5980, $5A00, $5A80, $5B00, $5B80
		dc.w    $5C00, $5C80, $5D00, $5D80, $5E00, $5E80, $5F00, $5F80
		dc.w    $6000, $6080, $6100, $6180, $6200, $6280, $6300, $6380
		dc.w    $6400, $6480, $6500, $6580, $6600, $6680, $6700, $6780
		dc.w    $6800, $6880, $6900, $6980, $6A00, $6A80, $6B00, $6B80
		dc.w    $6C00, $6C80, $6D00, $6D80, $6E00, $6E80, $6F00, $6F80
		dc.w    $7000, $7080, $7100, $7180, $7200, $7280, $7300, $7380
		dc.w    $7400, $7480, $7500, $7580, $7600, $7680, $7700, $7780
		dc.w    $7800, $7880, $7900, $7980, $7A00, $7A80, $7B00, $7B80
		dc.w    $7C00, $7C80, $7D00, $7D80, $7E00, $7E80, $7F00, $7F80
;-------------------------------------------------------------------------------
; Tabela contendo os endereços dos tiles 128x128 -> Ex: Tile 1 = $0080
; <<<-
;-------------------------------------------------------------------------------                  
										      
;===============================================================================
; Rotina para testar em qual tile o objeto esta
; <<<-
;===============================================================================

;===============================================================================
; Rotina para localizar o chão
; ->>>
;===============================================================================
FindFloor:                                                     ; Offset_0x013C30
		bsr     Floor_Check_Tile                       ; Offset_0x0139F6
		move.w  (A1), D0
		move.w  D0, D4
		andi.w  #$03FF, D0
		beq.s   Offset_0x013C42
		btst    D5, D4
		bne.s   Offset_0x013C50
Offset_0x013C42:
		add.w   A3, D2
		bsr     FindFloor_2                            ; Offset_0x013CD6
		sub.w   A3, D2
		addi.w  #$0010, D1
		rts
Offset_0x013C50:
		move.l  (Current_Colision_Pointer).w, A2             ; $FFFFF796
		add.w   D0, D0
		move.w  $00(A2, D0), D0
		beq.s   Offset_0x013C42
		lea     (AngleMap), A2                         ; Offset_0x0368EA
		move.b  $00(A2, D0), (A4)
		lsl.w   #$04, D0
		move.w  D3, D1
		btst    #$0A, D4
		beq.s   Offset_0x013C74
		not.w   D1
		neg.b   (A4)
Offset_0x013C74:
		btst    #$0B, D4
		beq.s   Offset_0x013C84
		addi.b  #$40, (A4)
		neg.b   (A4)
		subi.b  #$40, (A4)
Offset_0x013C84:
		andi.w  #$000F, D1
		add.w   D0, D1
		lea     (Colision_Array_1), A2                 ; Offset_0x0369EA
		move.b  $00(A2, D1), D0
		ext.w   D0
		eor.w   D6, D4
		btst    #$0B, D4
		beq.s   Offset_0x013CA0
		neg.w   D0
Offset_0x013CA0:
		tst.w   D0
		beq.s   Offset_0x013C42
		bmi.s   Offset_0x013CBC
		cmpi.b  #$10, D0
		beq.s   Offset_0x013CC8
		move.w  D2, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		move.w  #$000F, D1
		sub.w   D0, D1
		rts
Offset_0x013CBC:
		move.w  D2, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		bpl     Offset_0x013C42
Offset_0x013CC8:
		sub.w   A3, D2
		bsr     FindFloor_2                            ; Offset_0x013CD6
		add.w   A3, D2
		subi.w  #$0010, D1
		rts
;-------------------------------------------------------------------------------                                                                    
FindFloor_2:                                                   ; Offset_0x013CD6
		bsr     Floor_Check_Tile                       ; Offset_0x0139F6
		move.w  (A1), D0
		move.w  D0, D4
		andi.w  #$03FF, D0
		beq.s   Offset_0x013CE8
		btst    D5, D4
		bne.s   Offset_0x013CF6
Offset_0x013CE8:
		move.w  #$000F, D1
		move.w  D2, D0
		andi.w  #$000F, D0
		sub.w   D0, D1
		rts
Offset_0x013CF6:
		move.l  (Current_Colision_Pointer).w, A2             ; $FFFFF796
		add.w   D0, D0
		move.w  $00(A2, D0), D0
		beq.s   Offset_0x013CE8
		lea     (AngleMap), A2                         ; Offset_0x0368EA
		move.b  $00(A2, D0), (A4)
		lsl.w   #$04, D0
		move.w  D3, D1
		btst    #$0A, D4
		beq.s   Offset_0x013D1A
		not.w   D1
		neg.b   (A4)
Offset_0x013D1A:
		btst    #$0B, D4
		beq.s   Offset_0x013D2A
		addi.b  #$40, (A4)
		neg.b   (A4)
		subi.b  #$40, (A4)
Offset_0x013D2A:
		andi.w  #$000F, D1
		add.w   D0, D1
		lea     (Colision_Array_1), A2                 ; Offset_0x0369EA
		move.b  $00(A2, D1), D0
		ext.w   D0
		eor.w   D6, D4
		btst    #$0B, D4
		beq.s   Offset_0x013D46
		neg.w   D0
Offset_0x013D46:
		tst.w   D0
		beq.s   Offset_0x013CE8
		bmi.s   Offset_0x013D5C
		move.w  D2, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		move.w  #$000F, D1
		sub.w   D0, D1
		rts
Offset_0x013D5C:
		move.w  D2, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		bpl     Offset_0x013CE8
		not.w   D1
		rts
;===============================================================================
; Rotina para localizar o chão
; <<<-
;===============================================================================

;===============================================================================
; Rotina para o objeto localizar o chão
; ->>>
;===============================================================================
Object_FindFloor:                                              ; Offset_0x013D6C
		bsr     Floor_Check_Tile                       ; Offset_0x0139F6
		move.w  (A1), D0
		move.w  D0, D4
		andi.w  #$03FF, D0
		beq.s   Offset_0x013D7E
		btst    D5, D4
		bne.s   Offset_0x013D84
Offset_0x013D7E:
		move.w  #$0010, D1
		rts
Offset_0x013D84:
		move.l  (Current_Colision_Pointer).w, A2             ; $FFFFF796
		add.w   D0, D0
		move.w  $00(A2, D0), D0
		beq.s   Offset_0x013D7E
		lea     (AngleMap), A2                         ; Offset_0x0368EA
		move.b  $00(A2, D0), (A4)
		lsl.w   #$04, D0
		move.w  D3, D1
		btst    #$0A, D4
		beq.s   Offset_0x013DA8
		not.w   D1
		neg.b   (A4)
Offset_0x013DA8:
		btst    #$0B, D4
		beq.s   Offset_0x013DB8
		addi.b  #$40, (A4)
		neg.b   (A4)
		subi.b  #$40, (A4)
Offset_0x013DB8:
		andi.w  #$000F, D1
		add.w   D0, D1
		lea     (Colision_Array_1), A2                 ; Offset_0x0369EA
		move.b  $00(A2, D1), D0
		ext.w   D0
		eor.w   D6, D4
		btst    #$0B, D4
		beq.s   Offset_0x013DD4
		neg.w   D0
Offset_0x013DD4:
		tst.w   D0
		beq.s   Offset_0x013D7E
		bmi.s   Offset_0x013DF0
		cmpi.b  #$10, D0
		beq.s   Offset_0x013DFC
		move.w  D2, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		move.w  #$000F, D1
		sub.w   D0, D1
		rts
Offset_0x013DF0:
		move.w  D2, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		bpl     Offset_0x013D7E
Offset_0x013DFC:
		sub.w   A3, D2
		bsr     FindFloor_2                            ; Offset_0x013CD6
		add.w   A3, D2
		subi.w  #$0010, D1
		rts
;===============================================================================
; Rotina para o objeto localizar o chão
; <<<-
;===============================================================================

;===============================================================================
; Rotina para localizar a parede
; ->>>
;===============================================================================
FindWall:                                                      ; Offset_0x013E0A
		bsr     Floor_Check_Tile                       ; Offset_0x0139F6
		move.w  (A1), D0
		move.w  D0, D4
		andi.w  #$03FF, D0
		beq.s   Offset_0x013E1C
		btst    D5, D4
		bne.s   Offset_0x013E2A
Offset_0x013E1C:
		add.w   A3, D3
		bsr     FindWall_2                             ; Offset_0x013EB0
		sub.w   A3, D3
		addi.w  #$0010, D1
		rts
Offset_0x013E2A:
		move.l  (Current_Colision_Pointer).w, A2             ; $FFFFF796
		add.w   D0, D0
		move.w  $00(A2, D0), D0
		beq.s   Offset_0x013E1C
		lea     (AngleMap), A2                         ; Offset_0x0368EA
		move.b  $00(A2, D0), (A4)
		lsl.w   #$04, D0
		move.w  D2, D1
		btst    #$0B, D4
		beq.s   Offset_0x013E56
		not.w   D1
		addi.b  #$40, (A4)
		neg.b   (A4)
		subi.b  #$40, (A4)
Offset_0x013E56:
		btst    #$0A, D4
		beq.s   Offset_0x013E5E
		neg.b   (A4)
Offset_0x013E5E:
		andi.w  #$000F, D1
		add.w   D0, D1
		lea     (Colision_Array_2), A2                 ; Offset_0x0379EA
		move.b  $00(A2, D1), D0
		ext.w   D0
		eor.w   D6, D4
		btst    #$0A, D4
		beq.s   Offset_0x013E7A
		neg.w   D0
Offset_0x013E7A:
		tst.w   D0
		beq.s   Offset_0x013E1C
		bmi.s   Offset_0x013E96
		cmpi.b  #$10, D0
		beq.s   Offset_0x013EA2
		move.w  D3, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		move.w  #$000F, D1
		sub.w   D0, D1
		rts
Offset_0x013E96:
		move.w  D3, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		bpl     Offset_0x013E1C
Offset_0x013EA2:
		sub.w   A3, D3
		bsr     FindWall_2                             ; Offset_0x013EB0
		add.w   A3, D3
		subi.w  #$0010, D1
		rts
;-------------------------------------------------------------------------------                                                                       
FindWall_2:                                                    ; Offset_0x013EB0
		bsr     Floor_Check_Tile                       ; Offset_0x0139F6
		move.w  (A1), D0
		move.w  D0, D4
		andi.w  #$03FF, D0
		beq.s   Offset_0x013EC2
		btst    D5, D4
		bne.s   Offset_0x013ED0
Offset_0x013EC2:
		move.w  #$000F, D1
		move.w  D3, D0
		andi.w  #$000F, D0
		sub.w   D0, D1
		rts
Offset_0x013ED0:
		move.l  (Current_Colision_Pointer).w, A2             ; $FFFFF796
		add.w   D0, D0
		move.w  $00(A2, D0), D0
		beq.s   Offset_0x013EC2
		lea     (AngleMap), A2                         ; Offset_0x0368EA
		move.b  $00(A2, D0), (A4)
		lsl.w   #$04, D0
		move.w  D2, D1
		btst    #$0B, D4
		beq.s   Offset_0x013EFC
		not.w   D1
		addi.b  #$40, (A4)
		neg.b   (A4)
		subi.b  #$40, (A4)
Offset_0x013EFC:
		btst    #$0A, D4
		beq.s   Offset_0x013F04
		neg.b   (A4)
Offset_0x013F04:
		andi.w  #$000F, D1
		add.w   D0, D1
		lea     (Colision_Array_2), A2                 ; Offset_0x0379EA
		move.b  $00(A2, D1), D0
		ext.w   D0
		eor.w   D6, D4
		btst    #$0A, D4
		beq.s   Offset_0x013F20
		neg.w   D0
Offset_0x013F20:
		tst.w   D0
		beq.s   Offset_0x013EC2
		bmi.s   Offset_0x013F36
		move.w  D3, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		move.w  #$000F, D1
		sub.w   D0, D1
		rts
Offset_0x013F36:
		move.w  D3, D1
		andi.w  #$000F, D1
		add.w   D1, D0
		bpl     Offset_0x013EC2
		not.w   D1
		rts
;===============================================================================
; Rotina para localizar a parede
; <<<-
;===============================================================================

;=============================================================================== 
; Rotina não usada, algo como executar um log das colisões
; ->>>             (Talvez usada durante o desenvolvimento)          
;===============================================================================    
FloorLog_Unk:                                                  ; Offset_0x013F46
		rts              ; Com este rts a rotina abaixo ficou desativada
; Offset_0x013F48:
		lea     (Colision_Array_1), A1                 ; Offset_0x0369EA
		lea     (Colision_Array_1), A2                 ; Offset_0x0369EA
		move.w  #$00FF, D3
Offset_0x013F58:
		moveq   #$10, D5
		move.w  #$000F, D2
Offset_0x013F5E:
		moveq   #$00, D4
		move.w  #$000F, D1
Offset_0x013F64:
		move.w  (A1)+, D0
		lsr.l   D5, D0
		addx.w  D4, D4
		dbra    D1, Offset_0x013F64
		move.w  D4, (A2)+
		suba.w  #$0020, A1
		subq.w  #$01, D5
		dbra    D2, Offset_0x013F5E
		adda.w  #$0020, A1
		dbra    D3, Offset_0x013F58
		lea     (Colision_Array_1), A1                 ; Offset_0x0369EA
		lea     (Colision_Array_2), A2                 ; Offset_0x0379EA
		bsr.s   Offset_0x013F9C
		lea     (Colision_Array_1), A1                 ; Offset_0x0369EA
		lea     (Colision_Array_1), A2                 ; Offset_0x0369EA
Offset_0x013F9C:
		move.w  #$0FFF, D3
Offset_0x013FA0:
		moveq   #$00, D2
		move.w  #$000F, D1
		move.w  (A1)+, D0
		beq.s   Offset_0x013FCE
		bmi.s   Offset_0x013FB8
Offset_0x013FAC:
		lsr.w   #$01, D0
		bcc.s   Offset_0x013FB2
		addq.b  #$01, D2
Offset_0x013FB2:
		dbra    D1, Offset_0x013FAC
		bra.s   Offset_0x013FD0
Offset_0x013FB8:
		cmpi.w  #$FFFF, D0
		beq.s   Offset_0x013FCA
Offset_0x013FBE:
		lsl.w   #$01, D0
		bcc.s   Offset_0x013FC4
		subq.b  #$01, D2
Offset_0x013FC4:
		dbra    D1, Offset_0x013FBE
		bra.s   Offset_0x013FD0
Offset_0x013FCA:
		move.w  #$0010, D0
Offset_0x013FCE:
		move.w  D0, D2
Offset_0x013FD0:
		move.b  D2, (A2)+
		dbra    D3, Offset_0x013FA0
		rts
;=============================================================================== 
; Rotina não usada, algo como executar um log das  colisões
; <<<-             (Talvez usada durante o desenvolvimento)          
;===============================================================================  
     
;===============================================================================
; Rotina para calcular o quanto de espaço há na frente do jogador
; ->>>                    
;===============================================================================
Player_WalkSpeed:                                              ; Offset_0x013FD8
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
		beq.s   Offset_0x013FF0
		move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x013FF0:
		move.b  Obj_Player_LRB_Solid(A0), D5                     ; $003F
		move.l  Obj_X(A0), D3                                    ; $0008
		move.l  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_Speed(A0), D1                                ; $0010
		ext.l   D1
		asl.l   #$08, D1
		add.l   D1, D3
		move.w  Obj_Speed_Y(A0), D1                              ; $0012
		ext.l   D1
		asl.l   #$08, D1
		add.l   D1, D2
		swap.w  D2
		swap.w  D3
		move.b  D0, ($FFFFF768).w
		move.b  D0, ($FFFFF76A).w
		move.b  D0, D1
		addi.b  #$20, D0
		bpl.s   Offset_0x014030
		move.b  D1, D0
		bpl.s   Offset_0x01402A
		subq.b  #$01, D0
Offset_0x01402A:
		addi.b  #$20, D0
		bra.s   Offset_0x01403A
Offset_0x014030:
		move.b  D1, D0
		bpl.s   Offset_0x014036
		addq.b  #$01, D0
Offset_0x014036:
		addi.b  #$1F, D0
Offset_0x01403A:
		andi.b  #$C0, D0
		beq     Offset_0x01413A
		cmpi.b  #$80, D0
		beq     Offset_0x0143A8
		andi.b  #$38, D1
		bne.s   Offset_0x014052
		addq.w  #$08, D2
Offset_0x014052:
		cmpi.b  #$40, D0
		beq     Player_HitWall_D3                      ; Offset_0x014470
		bra     Offset_0x0142EE
;===============================================================================
; Rotina para calcular o quanto de espaço há na frente do jogador
; <<<-                    
;===============================================================================

;===============================================================================
; Rotina para calcular o quanto de espaço há acima do jogador
; ->>>                    
;===============================================================================
CalcRoomOverHead:                                              ; Offset_0x01405E
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
		beq.s   Offset_0x014076
		move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x014076:
		move.b  Obj_Player_LRB_Solid(A0), D5                     ; $003F
		move.b  D0, ($FFFFF768).w
		move.b  D0, ($FFFFF76A).w
		addi.b  #$20, D0
		andi.b  #$C0, D0
		cmpi.b  #$40, D0
		beq     Player_DontRunOnWallsL                 ; Offset_0x014400
		cmpi.b  #$80, D0
		beq     Player_DontRunOnWalls                  ; Offset_0x014338
		cmpi.b  #$C0, D0
		beq     Player_DontRunOnWallsR                 ; Offset_0x014286
Offset_0x0140A2: ; Referenciado pelos jogadores 
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
		beq.s   Offset_0x0140BA
		move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x0140BA:
		move.b  Obj_Player_Top_Solid(A0), D5                     ; $003E
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF768).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		sub.w   D0, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  (A7)+, D0
		move.b  #$00, D2
Offset_0x01411A:                
		move.b  ($FFFFF76A).w, D3
		cmp.w   D0, D1
		ble.s   Offset_0x014128
		move.b  ($FFFFF768).w, D3
		exg.l   D0, D1
Offset_0x014128:
		btst    #$00, D3
		beq.s   Offset_0x014130
		move.b  D2, D3
Offset_0x014130:
		rts
;===============================================================================
; Rotina para calcular o quanto de espaço há acima do jogador
; <<<-                    
;===============================================================================
; Offset_0x014132:
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
Offset_0x01413A:                
		addi.w  #$000A, D2
		lea     ($FFFFF768).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.b  #$00, D2
Offset_0x014152:               
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Offset_0x01415E
		move.b  D2, D3
Offset_0x01415E:
		rts
;===============================================================================
; Rotina para detectar se o jogador tocou o chão
; ->>> 
;===============================================================================
Player_HitFloor:                                               ; Offset_0x014160
		move.w  Obj_X(A0), D3                                    ; $0008
Player_HitFloor_D3:                                            ; Offset_0x014164                
		move.w  Obj_Y(A0), D2                                    ; $000C
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		cmpi.b  #$0C, Obj_Player_Top_Solid(A0)                   ; $003E
		beq.s   Offset_0x01418A
		move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x01418A:
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$0010, A3
		move.w  #$0000, D6
		move.b  Obj_Player_Top_Solid(A0), D5                     ; $003E
		bsr     FindFloor                              ; Offset_0x013C30
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Offset_0x0141B0
		move.b  #$00, D3
Offset_0x0141B0:
		rts
;-------------------------------------------------------------------------------               
Player_HitFloor_A1:                                            ; Offset_0x0141B2
		move.w  Obj_X(A1), D3                                    ; $0008
		move.w  Obj_Y(A1), D2                                    ; $000C
		moveq   #$00, D0
		move.b  Obj_Height_2(A1), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		move.l  #Primary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD000, $FFFFF796
		cmpi.b  #$0C, Obj_Player_Top_Solid(A1)                   ; $003E
		beq.s   Offset_0x0141DC
		move.l  #Secundary_Colision_Data_Buffer, (Current_Colision_Pointer).w ; $FFFFD600, $FFFFF796
Offset_0x0141DC:
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$0010, A3
		move.w  #$0000, D6
		move.b  Obj_Player_Top_Solid(A1), D5                     ; $003E
		bsr     FindFloor                              ; Offset_0x013C30
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Offset_0x014202
		move.b  #$00, D3
Offset_0x014202:
		rts
;===============================================================================
; Rotina para detectar se o jogador tocou o chão
; <<<- 
;===============================================================================

;===============================================================================
; Rotina para detectar se o objeto tocou o chão
; ->>> 
;===============================================================================
ObjHitFloor:                                                   ; Offset_0x014204
		move.w  Obj_X(A0), D3                                    ; $0008
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$0010, A3
		move.w  #$0000, D6
		moveq   #$0C, D5
		bsr     FindFloor                              ; Offset_0x013C30
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Offset_0x014238
		move.b  #$00, D3
Offset_0x014238:
		rts                           
;===============================================================================
; Rotina para detectar se o objeto tocou o chão
; <<<- 
;===============================================================================

;===============================================================================
; Rotina para detectar se o objeto bola de fogo tocou o chão
; ->>> 
;===============================================================================
Fire_FindFloor:                                                ; Offset_0x01423A
		move.w  Obj_X(A1), D3                                    ; $0008
		move.w  Obj_Y(A1), D2                                    ; $000C
		move.b  Obj_Height_2(A1), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$0010, A3
		move.w  #$0000, D6
		moveq   #$0C, D5
		bra     FindFloor                              ; Offset_0x013C30                           
;===============================================================================
; Rotina para detectar se o objeto bola de fogo tocou o chão
; <<<- 
;===============================================================================

;===============================================================================
; Rotina para detectar se o objeto anel tocou o chão
; ->>> 
;===============================================================================
Ring_FindFloor:                                                ; Offset_0x014260
		move.w  Obj_X(A0), D3                                    ; $0008
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D2
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$0010, A3
		move.w  #$0000, D6
		moveq   #$0C, D5
		bra     Object_FindFloor                       ; Offset_0x013D6C                 
;===============================================================================
; Rotina para detectar se o objeto anel tocou o chão
; <<<- 
;===============================================================================                 
Player_DontRunOnWallsR:                                        ; Offset_0x014286
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		sub.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF768).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  (A7)+, D0
		move.b  #$C0, D2
		bra     Offset_0x01411A 
;-------------------------------------------------------------------------------
Offset_0x0142E6: ; Referenciado pelos jogadores 
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
Offset_0x0142EE:                
		addi.w  #$000A, D3
		lea     ($FFFFF768).w, A4
		move.w  #$0010, A3
		move.w  #$0000, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.b  #$C0, D2
		bra     Offset_0x014152
;===============================================================================
; Rotina para detectar se o objeto tocou a parede a direita
; ->>> 
;===============================================================================                   
Object_HitWall_Right:                                          ; Offset_0x01430A
		add.w   Obj_X(A0), D3                                    ; $0008
		move.w  Obj_Y(A0), D2                                    ; $000C
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$0010, A3
		move.w  #$0000, D6
		moveq   #$0D, D5
		bsr     FindWall                               ; Offset_0x013E0A
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Exit_Object_HitWall_Right              ; Offset_0x014336
		move.b  #$C0, D3
Exit_Object_HitWall_Right:                                     ; Offset_0x014336
		rts
;===============================================================================
; Rotina para detectar se o objeto tocou a parede a direita
; <<<- 
;===============================================================================                 
Player_DontRunOnWalls:                                         ; Offset_0x014338
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D2
		eori.w  #$000F, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D3
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0800, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D2
		eori.w  #$000F, D2
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		sub.w   D0, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$FFF0, A3
		move.w  #$0800, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.w  (A7)+, D0
		move.b  #$80, D2
		bra     Offset_0x01411A
;------------------------------------------------------------------------------- 
; Offset_0x0143A0:
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
Offset_0x0143A8:                
		subi.w  #$000A, D2
		eori.w  #$000F, D2
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0800, D6
		bsr     FindFloor                              ; Offset_0x013C30
		move.b  #$80, D2
		bra     Offset_0x014152     
;===============================================================================
; Rotina para detectar se o objeto tocou o teto
; ->>> 
;===============================================================================  
Object_HitCeiling:                                             ; Offset_0x0143C8
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D2
		eori.w  #$000F, D2
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0800, D6
		moveq   #$0D, D5
		bsr     FindFloor                              ; Offset_0x013C30
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Offset_0x0143FE
		move.b  #$80, D3
Offset_0x0143FE:
		rts                
;===============================================================================
; Rotina para detectar se o objeto tocou o teto
; <<<- 
;===============================================================================                  
Player_DontRunOnWallsL:                                        ; Offset_0x014400
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		sub.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D3
		eori.w  #$000F, D3
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0400, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  D1, -(A7)
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
		moveq   #$00, D0
		move.b  Obj_Width_2(A0), D0                              ; $0017
		ext.w   D0
		add.w   D0, D2
		move.b  Obj_Height_2(A0), D0                             ; $0016
		ext.w   D0
		sub.w   D0, D3
		eori.w  #$000F, D3
		lea     ($FFFFF76A).w, A4
		move.w  #$FFF0, A3
		move.w  #$0400, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.w  (A7)+, D0
		move.b  #$40, D2
		bra     Offset_0x01411A
;===============================================================================
; Rotina para detectar se o jogador tocou a parede
; ->>> 
;=============================================================================== 
Player_HitWall:                                                ; Offset_0x014468
		move.w  Obj_Y(A0), D2                                    ; $000C
		move.w  Obj_X(A0), D3                                    ; $0008
Player_HitWall_D3:                                             ; Offset_0x014470                
		subi.w  #$000A, D3
		eori.w  #$000F, D3
		lea     ($FFFFF768).w, A4
		move.w  #$FFF0, A3
		move.w  #$0400, D6
		bsr     FindWall                               ; Offset_0x013E0A
		move.b  #$40, D2
		bra     Offset_0x014152
;===============================================================================
; Rotina para detectar se o jogador tocou a parede
; <<<- 
;===============================================================================  

;===============================================================================
; Rotina para detectar se o objeto tocou a parede a esquerda
; ->>> 
;===============================================================================
Object_HitWall_Left:                                           ; Offset_0x014490
		add.w   Obj_X(A0), D3                                    ; $0008
		move.w  Obj_Y(A0), D2                                    ; $000C
		lea     ($FFFFF768).w, A4
		move.b  #$00, (A4)
		move.w  #$FFF0, A3
		move.w  #$0400, D6
		moveq   #$0D, D5
		bsr     FindWall                               ; Offset_0x013E0A
		move.b  ($FFFFF768).w, D3
		btst    #$00, D3
		beq.s   Exit_Object_HitWall_Left               ; Offset_0x0144BC
		move.b  #$40, D3
Exit_Object_HitWall_Left:                                      ; Offset_0x0144BC
		rts 
;===============================================================================
; Rotina para detectar se o objeto tocou a parede a esquerda
; <<<- 
;===============================================================================
		nop       
;------------------------------------------------------------------------------- 
Obj_0x79_Lamp_Post:                                            ; Offset_0x0144C0
		include 'objects/obj_0x79.asm'                        
;-------------------------------------------------------------------------------       
		nop       
;-------------------------------------------------------------------------------    
Obj_0x7D_Hidden_Bonus:                                         ; Offset_0x014768
		include 'objects/obj_0x7D.asm'         
;-------------------------------------------------------------------------------       
		nop                                            
;-------------------------------------------------------------------------------
Obj_0x44_Red_Ball_Bumper:                                      ; Offset_0x01486C
		include 'objects/obj_0x44.asm' 
Obj_0x24_Oxygen_Bubbles:                                       ; Offset_0x0149CC 
		include 'objects/obj_0x24.asm'                     
;-------------------------------------------------------------------------------
Sonic_Underwater_Mappings:                                     ; Offset_0x014CFC
		dc.w    Offset_0x014D40-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D4A-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D4A-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D54-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D5E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D68-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D72-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D7C-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D9E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D9E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D9E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D9E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D9E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014D9E-Sonic_Underwater_Mappings
		dc.w    Offset_0x014DA8-Sonic_Underwater_Mappings
		dc.w    Offset_0x014DB2-Sonic_Underwater_Mappings
		dc.w    Offset_0x014DBC-Sonic_Underwater_Mappings
Miles_Underwater_Mappings:                                     ; Offset_0x014D1E
		dc.w    Offset_0x014D40-Miles_Underwater_Mappings
		dc.w    Offset_0x014D4A-Miles_Underwater_Mappings
		dc.w    Offset_0x014D4A-Miles_Underwater_Mappings
		dc.w    Offset_0x014D54-Miles_Underwater_Mappings
		dc.w    Offset_0x014D5E-Miles_Underwater_Mappings
		dc.w    Offset_0x014D68-Miles_Underwater_Mappings
		dc.w    Offset_0x014D72-Miles_Underwater_Mappings
		dc.w    Offset_0x014D7C-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBE-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBE-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBE-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBE-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBE-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBE-Miles_Underwater_Mappings
		dc.w    Offset_0x014DA8-Miles_Underwater_Mappings
		dc.w    Offset_0x014DB2-Miles_Underwater_Mappings
		dc.w    Offset_0x014DBC-Miles_Underwater_Mappings                
Offset_0x014D40:
		dc.w    $0001
		dc.l    $FC00008D, $0046FFFC
Offset_0x014D4A:
		dc.w    $0001
		dc.l    $FC00008E, $0048FFFC
Offset_0x014D54:
		dc.w    $0001
		dc.l    $F805008F, $0049FFF8
Offset_0x014D5E:
		dc.w    $0001
		dc.l    $F8050093, $004FFFF8
Offset_0x014D68:
		dc.w    $0001
		dc.l    $F40A001C, $000EFFF4
Offset_0x014D72:
		dc.w    $0001
		dc.l    $F00F0008, $0004FFF0
Offset_0x014D7C:
		dc.w    $0004
		dc.l    $F0050018, $000CFFF0
		dc.l    $F0050818, $080C0000
		dc.l    $00051018, $100CFFF0
		dc.l    $00051818, $180C0000
Offset_0x014D9E:
		dc.w    $0001
		dc.l    $F4061F41, $1BA0FFF8
Offset_0x014DA8:
		dc.w    $0001
		dc.l    $F8050000, $0000FFF8
Offset_0x014DB2:
		dc.w    $0001
		dc.l    $F8050004, $0002FFF8
Offset_0x014DBC:
		dc.w    $0000                
Offset_0x014DBE:
		dc.w    $0001
		dc.l    $F4061F31, $1B98FFF8  
;-------------------------------------------------------------------------------                 
Obj_0x03_Layer_Switch:                                         ; Offset_0x014DC8  
		include 'objects/obj_0x03.asm'                
Obj_0x0B_Open_Close_Platform:                                  ; Offset_0x0151C4
		include 'objects/obj_0x0B.asm' 
;-------------------------------------------------------------------------------   
		nop   
;-------------------------------------------------------------------------------  
Jmp_00_To_MarkObjGone:                                         ; Offset_0x015314
		jmp     (MarkObjGone)                          ; Offset_0x00D200 
;-------------------------------------------------------------------------------
		dc.w    $0000
;------------------------------------------------------------------------------- 
Obj_0x0C_Unk_Platform:                                         ; Offset_0x01531C
		include 'objects/obj_0x0C.asm'                  
;------------------------------------------------------------------------------- 
		nop
Jmp_01_To_MarkObjGone:                                         ; Offset_0x015414
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_00_To_CalcSine:                                            ; Offset_0x01541A
		jmp     (CalcSine)                             ; Offset_0x003282     
;-------------------------------------------------------------------------------
Obj_0x12_HPz_Master_Emerald:                                   ; Offset_0x015420 
		include 'objects/obj_0x12.asm'                     
;-------------------------------------------------------------------------------
		nop
Jmp_00_To_DisplaySprite:                                       ; Offset_0x01549C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_00_To_DeleteObject:                                        ; Offset_0x0154A2
		jmp     (DeleteObject)                         ; Offset_0x00D314  
;-------------------------------------------------------------------------------  
Obj_0x13_HPz_Waterfalls:                                       ; Offset_0x0154A8
		include 'objects/obj_0x13.asm'  
;-------------------------------------------------------------------------------     
Jmp_01_To_DisplaySprite:                                       ; Offset_0x0159C0
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_01_To_DeleteObject:                                        ; Offset_0x0159C6
		jmp     (DeleteObject)                         ; Offset_0x00D314 
;-------------------------------------------------------------------------------   
Obj_0x04_Water_Surface:                                        ; Offset_0x0159CC  
		include 'objects/obj_0x04.asm'   
Obj_0x49_Waterfall:                                            ; Offset_0x015C8E
		include 'objects/obj_0x49.asm'     
Obj_0x31_Lava_Attributes:                                      ; Offset_0x015EDC
		include 'objects/obj_0x31.asm'   
Obj_0x74_Invisible_Block:                                      ; Offset_0x015FBA 
		include 'objects/obj_0x74.asm'   
Obj_0x7C_Metal_Structure:                                      ; Offset_0x0160BE
		include 'objects/obj_0x7C.asm'   
Obj_0x27_Object_Hit:                                           ; Offset_0x016174
		include 'objects/obj_0x27.asm'        
Obj_0x84_Auto_Spin:                                            ; Offset_0x016248
		include 'objects/obj_0x84.asm'                                                                                                
;-------------------------------------------------------------------------------  
Jmp_02_To_DisplaySprite:                                       ; Offset_0x016390   
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_02_To_DeleteObject:                                        ; Offset_0x016396
		jmp     (DeleteObject)                         ; Offset_0x00D314                
Jmp_00_To_ModifySpriteAttr_2P:                                 ; Offset_0x01639C   
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE               
Jmp_00_To_Check_Object_On_Screen:                              ; Offset_0x0163A2
		jmp     (Check_Object_On_Screen)               ; Offset_0x00DD66
;-------------------------------------------------------------------------------                
Obj_0x06_Spiral_Attributes:                                    ; Offset_0x0163A8
		include 'objects/obj_0x06.asm'                            
;-------------------------------------------------------------------------------  
		nop         
;------------------------------------------------------------------------------- 
Jmp_01_To_CalcSine:                                            ; Offset_0x016800
		jmp     (CalcSine)                             ; Offset_0x003282  
;-------------------------------------------------------------------------------  
		dc.w    $0000                    
;-------------------------------------------------------------------------------
Obj_0x14_Seesaw:                                               ; Offset_0x016808
		include 'objects/obj_0x14.asm'                             
;-------------------------------------------------------------------------------
Jmp_00_To_SingleObjectLoad_2:                                  ; Offset_0x016C74
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_01_To_ModifySpriteAttr_2P:                                 ; Offset_0x016C7A  
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_00_To_ObjectFall:                                          ; Offset_0x016C80
		jmp     (ObjectFall)                           ; Offset_0x00D1AE                
Jmp_00_To_MarkObjGone_2:                                       ; Offset_0x016C86  
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238  
;-------------------------------------------------------------------------------               
Obj_0x16_Teleferics:                                           ; Offset_0x016C8C
		include 'objects/obj_0x16.asm'                        
;-------------------------------------------------------------------------------  
		nop
Jmp_03_To_DeleteObject:                                        ; Offset_0x016E98
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_02_To_MarkObjGone:                                         ; Offset_0x016E9E
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_01_To_SingleObjectLoad_2:                                  ; Offset_0x016EA4
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_02_To_ModifySpriteAttr_2P:                                 ; Offset_0x016EAA
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_00_To_SpeedToPos:                                          ; Offset_0x016EB0
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000             
;-------------------------------------------------------------------------------  
Obj_0x19_Rotating_Platforms:                                   ; Offset_0x016EB8
		include 'objects/obj_0x19.asm'   
;-------------------------------------------------------------------------------
		nop
Jmp_03_To_DisplaySprite:                                       ; Offset_0x0170FC
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_04_To_DeleteObject:                                        ; Offset_0x017102
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_03_To_ModifySpriteAttr_2P:                                 ; Offset_0x017108
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_01_To_SpeedToPos:                                          ; Offset_0x01710E
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA                  
;-------------------------------------------------------------------------------  
Obj_0x1B_Speed_Booster:                                        ; Offset_0x017114
		include 'objects/obj_0x1B.asm'                                           
;------------------------------------------------------------------------------- 
		nop
Jmp_03_To_MarkObjGone:                                         ; Offset_0x017260
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_04_To_ModifySpriteAttr_2P:                                 ; Offset_0x017266
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE   
;-------------------------------------------------------------------------------
Obj_0x1D_Worms:                                                ; Offset_0x01726C
		include 'objects/obj_0x1D.asm'                            
;-------------------------------------------------------------------------------
		nop
Jmp_04_To_MarkObjGone:                                         ; Offset_0x0173CC
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_02_To_SingleObjectLoad_2:                                  ; Offset_0x0173D2
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_00_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x0173D8
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_02_To_SpeedToPos:                                          ; Offset_0x0173DE
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
;-------------------------------------------------------------------------------
Obj_0x1E_Tube_Attributes:                                      ; Offset_0x0173E4
		include 'objects/obj_0x1E.asm'                 
;-------------------------------------------------------------------------------  
Jmp_00_To_MarkObjGone_3:                                       ; Offset_0x017E2C
		jmp     (MarkObjGone_3)                        ; Offset_0x00D26C
		dc.w    $0000
;-------------------------------------------------------------------------------
Obj_0x20_HTz_Boss_FireBall:                                    ; Offset_0x017E34
		include 'objects/obj_0x20.asm'   
;-------------------------------------------------------------------------------  
Jmp_05_To_DeleteObject:                                        ; Offset_0x018118
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_05_To_MarkObjGone:                                         ; Offset_0x01811E
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_03_To_SingleObjectLoad_2:                                  ; Offset_0x018124
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_00_To_AnimateSprite:                                       ; Offset_0x01812A
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_05_To_ModifySpriteAttr_2P:                                 ; Offset_0x018130
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_03_To_SpeedToPos:                                          ; Offset_0x018136
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA                 
;-------------------------------------------------------------------------------  
Obj_0x2F_Breakable_Floor:                                      ; Offset_0x01813C
		include 'objects/obj_0x2F.asm'     
Obj_0x32_Breakable_Obstacle:                                   ; Offset_0x01834A
		include 'objects/obj_0x32.asm'    
;-------------------------------------------------------------------------------                
Breakable_Floor_Mappings:                                      ; Offset_0x01852A
		dc.w    Offset_0x01853E-Breakable_Floor_Mappings
		dc.w    Offset_0x018588-Breakable_Floor_Mappings
		dc.w    Offset_0x0185DA-Breakable_Floor_Mappings
		dc.w    Offset_0x0185DA-Breakable_Floor_Mappings
		dc.w    Offset_0x01861C-Breakable_Floor_Mappings
		dc.w    Offset_0x01861C-Breakable_Floor_Mappings
		dc.w    Offset_0x01864E-Breakable_Floor_Mappings
		dc.w    Offset_0x01864E-Breakable_Floor_Mappings
		dc.w    Offset_0x018670-Breakable_Floor_Mappings
		dc.w    Offset_0x018670-Breakable_Floor_Mappings
Offset_0x01853E:
		dc.w    $0009
		dc.l    $D80D0012, $0009FFF0
		dc.l    $E805004A, $0025FFF0
		dc.l    $E805004A, $00250000
		dc.l    $F805004E, $0027FFF0
		dc.l    $F805004E, $00270000
		dc.l    $08050052, $0029FFF0
		dc.l    $08050052, $00290000
		dc.l    $18050052, $0029FFF0
		dc.l    $18050052, $00290000
Offset_0x018588:
		dc.w    $000A
		dc.l    $D8050012, $0009FFF0
		dc.l    $D8050016, $000B0000
		dc.l    $E805004A, $0025FFF0
		dc.l    $E805004A, $00250000
		dc.l    $F805004E, $0027FFF0
		dc.l    $F805004E, $00270000
		dc.l    $08050052, $0029FFF0
		dc.l    $08050052, $00290000
		dc.l    $18050052, $0029FFF0
		dc.l    $18050052, $00290000
Offset_0x0185DA:
		dc.w    $0008
		dc.l    $E005004A, $0025FFF0
		dc.l    $E005004A, $00250000
		dc.l    $F005004E, $0027FFF0
		dc.l    $F005004E, $00270000
		dc.l    $00050052, $0029FFF0
		dc.l    $00050052, $00290000
		dc.l    $10050052, $0029FFF0
		dc.l    $10050052, $00290000
Offset_0x01861C:
		dc.w    $0006
		dc.l    $E805004E, $0027FFF0
		dc.l    $E805004E, $00270000
		dc.l    $F8050052, $0029FFF0
		dc.l    $F8050052, $00290000
		dc.l    $08050052, $0029FFF0
		dc.l    $08050052, $00290000
Offset_0x01864E:
		dc.w    $0004
		dc.l    $F0050052, $0029FFF0
		dc.l    $F0050052, $00290000
		dc.l    $00050052, $0029FFF0
		dc.l    $00050052, $00290000
Offset_0x018670:
		dc.w    $0002
		dc.l    $F8050052, $0029FFF0
		dc.l    $F8050052, $00290000      
;-------------------------------------------------------------------------------
HTz_Rock_Mappings:                                             ; Offset_0x018682
		dc.w    Offset_0x018684-HTz_Rock_Mappings
Offset_0x018684:
		dc.w    $0006
		dc.l    $F0050000, $0000FFE8
		dc.l    $F0050004, $0002FFF8
		dc.l    $F0050008, $00040008
		dc.l    $0005000C, $0006FFE8
		dc.l    $00050010, $0008FFF8
		dc.l    $00050010, $00080008    
;-------------------------------------------------------------------------------
CPz_Tunel_Obstacle_Mappings:                                   ; Offset_0x0186B6
		dc.w    Offset_0x0186B8-CPz_Tunel_Obstacle_Mappings
Offset_0x0186B8:
		dc.w    $0004
		dc.l    $F0050000, $0000FFF0
		dc.l    $F0050800, $08000000
		dc.l    $00050000, $0000FFF0
		dc.l    $00050800, $08000000   
;-------------------------------------------------------------------------------
		nop
Jmp_04_To_DisplaySprite:                                       ; Offset_0x0186DC
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_06_To_DeleteObject:                                        ; Offset_0x0186E2
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_00_To_SingleObjectLoad:                                    ; Offset_0x0186E8
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_06_To_MarkObjGone:                                         ; Offset_0x0186EE
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_06_To_ModifySpriteAttr_2P:                                 ; Offset_0x0186F4
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_00_To_Smash_Object:                                        ; Offset_0x0186FA
		jmp     (Smash_Object)                         ; Offset_0x00CD24
Jmp_00_To_SolidObject:                                         ; Offset_0x018700
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_04_To_SpeedToPos:                                          ; Offset_0x018706
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA    
;-------------------------------------------------------------------------------  
Obj_0x30_Earthquake_Tiles_Attributes:                          ; Offset_0x01870C  
		include 'objects/obj_0x30.asm'                    
;-------------------------------------------------------------------------------  
Jmp_07_To_DeleteObject:                                        ; Offset_0x018900
		jmp     (DeleteObject)                         ; Offset_0x00D314
Offset_0x018906:
		jmp     (Offset_0x02B4CA)
Jmp_01_To_MarkObjGone_3:                                       ; Offset_0x01890C
		jmp     (MarkObjGone_3)                        ; Offset_0x00D26C
Offset_0x018912:
		jmp     (Offset_0x00FA9C)
Jmp_00_To_SolidObject_2:                                       ; Offset_0x018918
		jmp     (SolidObject_2)                        ; Offset_0x00F39E
Jmp_00_To_SolidObject_3:                                       ; Offset_0x01891E
		jmp     (SolidObject_3)                        ; Offset_0x00F3F0                                                
;-------------------------------------------------------------------------------
Obj_0x33_Touch_Booster:                                        ; Offset_0x018924
		include 'objects/obj_0x33.asm'                                                              
;-------------------------------------------------------------------------------  
Jmp_07_To_MarkObjGone:                                         ; Offset_0x018C5C
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_04_To_SingleObjectLoad_2:                                  ; Offset_0x018C62
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_01_To_SolidObject:                                         ; Offset_0x018C68
		jmp     (SolidObject)                          ; Offset_0x00F344
		dc.w    $0000                            
;------------------------------------------------------------------------------- 
Obj_0x43_Giant_Spikeball:                                      ; Offset_0x018C70
		include 'objects/obj_0x43.asm'        
;-------------------------------------------------------------------------------   
Jmp_05_To_SingleObjectLoad_2:                                  ; Offset_0x018E44
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_07_To_ModifySpriteAttr_2P:                                 ; Offset_0x018E4A
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE                 
;-------------------------------------------------------------------------------
Obj_0x07_0il_Attributes:                                       ; Offset_0x018E50 
		include 'objects/obj_0x07.asm'                                       
;-------------------------------------------------------------------------------   
		nop
Oil_Kill_Player:                                               ; Offset_0x018F14
		jmp     (Kill_Player)                          ; Offset_0x02B57C
Jmp_00_To_Platform_Object_A1:                                  ; Offset_0x018F1A
		jmp     (Platform_Object_A1)                   ; Offset_0x00F842                 
;------------------------------------------------------------------------------- 
Obj_0x45_Spring_Push_Boost:                                    ; Offset_0x018F20  
		include 'objects/obj_0x45.asm'  
Obj_0x46_Spring_Ball:                                          ; Offset_0x01983E   
		include 'objects/obj_0x46.asm'                            
;-------------------------------------------------------------------------------
		nop
Jmp_08_To_DeleteObject:                                        ; Offset_0x019AEC
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_01_To_SingleObjectLoad:                                    ; Offset_0x019AF2
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_08_To_MarkObjGone:                                         ; Offset_0x019AF8
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_08_To_ModifySpriteAttr_2P:                                 ; Offset_0x019AFE
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_02_To_SolidObject:                                         ; Offset_0x019B04
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_00_To_SolidObject_2_A1:                                    ; Offset_0x019B0A
		jmp     (SolidObject_2_A1)                     ; Offset_0x00F3B4
Offset_0x019B10:
		jmp     (Offset_0x00F494)
Jmp_05_To_SpeedToPos:                                          ; Offset_0x019B16
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
;-------------------------------------------------------------------------------               
Obj_0x47_Switch:                                               ; Offset_0x019B1C
		include 'objects/obj_0x47.asm'                     
;-------------------------------------------------------------------------------  
		nop
Jmp_09_To_MarkObjGone:                                         ; Offset_0x019BE4
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_09_To_ModifySpriteAttr_2P:                                 ; Offset_0x019BEA
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_03_To_SolidObject:                                         ; Offset_0x019BF0
		jmp     (SolidObject)                          ; Offset_0x00F344
		dc.w    $0000                  
;------------------------------------------------------------------------------- 
Obj_0x3D_Break_Boost:                                          ; Offset_0x019BF8
		include 'objects/obj_0x3D.asm'       
;-------------------------------------------------------------------------------    
Jmp_05_To_DisplaySprite:                                       ; Offset_0x01A004
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_09_To_DeleteObject:                                        ; Offset_0x01A00A
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0A_To_MarkObjGone:                                         ; Offset_0x01A010
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_06_To_SingleObjectLoad_2:                                  ; Offset_0x01A016
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_02_To_MarkObjGone_3:                                       ; Offset_0x01A01C
		jmp     (MarkObjGone_3)                        ; Offset_0x00D26C
Jmp_0A_To_ModifySpriteAttr_2P:                                 ; Offset_0x01A022
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_01_To_Smash_Object:                                        ; Offset_0x01A028
		jmp     (Smash_Object)                         ; Offset_0x00CD24
Jmp_04_To_SolidObject:                                         ; Offset_0x01A02E
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_06_To_SpeedToPos:                                          ; Offset_0x01A034
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA    
		dc.w    $0000                          
;------------------------------------------------------------------------------- 
Obj_0x48_Cannon:                                               ; Offset_0x01A03C
		include 'objects/obj_0x48.asm'                  
;-------------------------------------------------------------------------------   
		nop
Jmp_06_To_DisplaySprite:                                       ; Offset_0x01A438
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0B_To_MarkObjGone:                                         ; Offset_0x01A43E
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0B_To_ModifySpriteAttr_2P:                                 ; Offset_0x01A444
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE  
		dc.w    $0000                              
;------------------------------------------------------------------------------- 
Obj_0x22_Arrow_Shooter:                                        ; Offset_0x01A44C
		include 'objects/obj_0x22.asm'                           
;-------------------------------------------------------------------------------   
Jmp_0A_To_DeleteObject:                                        ; Offset_0x01A620
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_02_To_SingleObjectLoad:                                    ; Offset_0x01A626
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_0C_To_MarkObjGone:                                         ; Offset_0x01A62C
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_01_To_AnimateSprite:                                       ; Offset_0x01A632
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_0C_To_ModifySpriteAttr_2P:                                 ; Offset_0x01A638
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_07_To_SpeedToPos:                                          ; Offset_0x01A63E
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
;-------------------------------------------------------------------------------
Obj_0x23_Pillar:                                               ; Offset_0x01A644
		include 'objects/obj_0x23.asm'    
Obj_0x2B_Raising_Pillar:                                       ; Offset_0x01A812
		include 'objects/obj_0x2B.asm'                        
;-------------------------------------------------------------------------------  
Jmp_07_To_DisplaySprite:                                       ; Offset_0x01AE8C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0B_To_DeleteObject:                                        ; Offset_0x01AE92
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0D_To_MarkObjGone:                                         ; Offset_0x01AE98
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_07_To_SingleObjectLoad_2:                                  ; Offset_0x01AE9E
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_0D_To_ModifySpriteAttr_2P:                                 ; Offset_0x01AEA4
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_05_To_SolidObject:                                         ; Offset_0x01AEAA
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_08_To_SpeedToPos:                                          ; Offset_0x01AEB0
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000    
;-------------------------------------------------------------------------------
Obj_0x2C_Leaves:                                               ; Offset_0x01AEB8   
		include 'objects/obj_0x2C.asm'                
;-------------------------------------------------------------------------------    
Jmp_08_To_DisplaySprite:                                       ; Offset_0x01B10C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0C_To_DeleteObject:                                        ; Offset_0x01B112
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_03_To_SingleObjectLoad:                                    ; Offset_0x01B118
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_00_To_PseudoRandomNumber:                                  ; Offset_0x01B11E
		jmp     (PseudoRandomNumber)                   ; Offset_0x00325C
Jmp_02_To_CalcSine:                                            ; Offset_0x01B124
		jmp     (CalcSine)                             ; Offset_0x003282   
		dc.w    $0000 
;-------------------------------------------------------------------------------  
Obj_0x40_Diagonal_Springs:                                     ; Offset_0x01B12C
		include 'objects/obj_0x40.asm'  
;-------------------------------------------------------------------------------  
		nop
Jmp_0E_To_MarkObjGone:                                         ; Offset_0x01B3D4
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_02_To_AnimateSprite:                                       ; Offset_0x01B3DA
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_0E_To_ModifySpriteAttr_2P:                                 ; Offset_0x01B3E0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_00_To_SolidObject_3_A1:                                    ; Offset_0x01B3E6
		jmp     (SolidObject_3_A1)                     ; Offset_0x00F406 
;-------------------------------------------------------------------------------  
Obj_0x42_Steam_Vent:                                           ; Offset_0x01B3EC
		include 'objects/obj_0x42.asm'                             
;-------------------------------------------------------------------------------   
		nop
Jmp_09_To_DisplaySprite:                                       ; Offset_0x01B6B0
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0D_To_DeleteObject:                                        ; Offset_0x01B6B6
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_04_To_SingleObjectLoad:                                    ; Offset_0x01B6BC
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_0F_To_MarkObjGone:                                         ; Offset_0x01B6C2
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0F_To_ModifySpriteAttr_2P:                                 ; Offset_0x01B6C8
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_01_To_SolidObject_2_A1:                                    ; Offset_0x01B6CE
		jmp     (SolidObject_2_A1)                     ; Offset_0x00F3B4   
;-------------------------------------------------------------------------------
Obj_0x64_Pistons:                                              ; Offset_0x01B6D4
		include 'objects/obj_0x64.asm'                          
;-------------------------------------------------------------------------------     
Jmp_10_To_ModifySpriteAttr_2P:                                 ; Offset_0x01B888
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_06_To_SolidObject:                                         ; Offset_0x01B88E
		jmp     (SolidObject)                          ; Offset_0x00F344  
;-------------------------------------------------------------------------------                                
Obj_0x65_Platform_Over_Gear:                                   ; Offset_0x01B894
		include 'objects/obj_0x65.asm'              
;-------------------------------------------------------------------------------   
Jmp_10_To_MarkObjGone:                                         ; Offset_0x01BCDC
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_08_To_SingleObjectLoad_2:                                  ; Offset_0x01BCE2
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_11_To_ModifySpriteAttr_2P:                                 ; Offset_0x01BCE8
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_07_To_SolidObject:                                         ; Offset_0x01BCEE
		jmp     (SolidObject)                          ; Offset_0x00F344     
;-------------------------------------------------------------------------------
Obj_0x66_Springs_Wall:                                         ; Offset_0x01BCF4
		include 'objects/obj_0x66.asm'                                
;-------------------------------------------------------------------------------   
Jmp_0A_To_DisplaySprite:                                       ; Offset_0x01BEE4
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0E_To_DeleteObject:                                        ; Offset_0x01BEEA
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_12_To_ModifySpriteAttr_2P:                                 ; Offset_0x01BEF0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_02_To_SolidObject_2_A1:                                    ; Offset_0x01BEF6
		jmp     (SolidObject_2_A1)                     ; Offset_0x00F3B4  
;------------------------------------------------------------------------------- 
Obj_0x67_Teleport_Attributes:                                  ; Offset_0x01BEFC  
		include 'objects/obj_0x67.asm'                               
;-------------------------------------------------------------------------------    
Jmp_0B_To_DisplaySprite:                                       ; Offset_0x01C320
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_03_To_AnimateSprite:                                       ; Offset_0x01C326
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_03_To_MarkObjGone_3:                                       ; Offset_0x01C32C
		jmp     (MarkObjGone_3)                        ; Offset_0x00D26C
		dc.w    $0000                                     
;-------------------------------------------------------------------------------
Obj_0x68_Block_Harpon:                                         ; Offset_0x01C334
		include 'objects/obj_0x68.asm'       
Obj_0x6D_Harpoon:                                              ; Offset_0x01C534 
		include 'objects/obj_0x6D.asm'
;------------------------------------------------------------------------------- 
Jmp_11_To_MarkObjGone:                                         ; Offset_0x01C604
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_09_To_SingleObjectLoad_2:                                  ; Offset_0x01C60A
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_13_To_ModifySpriteAttr_2P:                                 ; Offset_0x01C610
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_08_To_SolidObject:                                         ; Offset_0x01C616
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_01_To_MarkObjGone_2:                                       ; Offset_0x01C61C
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238    
		dc.w    $0000
;-------------------------------------------------------------------------------                
Obj_0x69_Screw_Nut:                                            ; Offset_0x01C624
		include 'objects/obj_0x69.asm'   
;------------------------------------------------------------------------------- 
		nop
Jmp_12_To_MarkObjGone:                                         ; Offset_0x01C830
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_00_To_ObjHitFloor:                                         ; Offset_0x01C836
		jmp     (ObjHitFloor)                          ; Offset_0x014204
Jmp_14_To_ModifySpriteAttr_2P:                                 ; Offset_0x01C83C
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_09_To_SolidObject:                                         ; Offset_0x01C842
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_09_To_SpeedToPos:                                          ; Offset_0x01C848
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA     
		dc.w    $0000
;-------------------------------------------------------------------------------                  
Obj_0x6A_DHz_Three_Boxes_Mz_Ptfrm:                             ; Offset_0x01C850
		include 'objects/obj_0x6A.asm'    
;-------------------------------------------------------------------------------
Jmp_0A_To_SingleObjectLoad_2:                                  ; Offset_0x01CAF4
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_15_To_ModifySpriteAttr_2P:                                 ; Offset_0x01CAFA
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_0A_To_SolidObject:                                         ; Offset_0x01CB00
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_02_To_MarkObjGone_2:                                       ; Offset_0x01CB06
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238 
;-------------------------------------------------------------------------------                  
Obj_0x6B_Mz_Platform:                                          ; Offset_0x01CB0C
		include 'objects/obj_0x6B.asm'                           
;-------------------------------------------------------------------------------
		nop
Jmp_16_To_ModifySpriteAttr_2P:                                 ; Offset_0x01CDB0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_0B_To_SolidObject:                                         ; Offset_0x01CDB6
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_03_To_MarkObjGone_2:                                       ; Offset_0x01CDBC
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238
Jmp_0A_To_SpeedToPos:                                          ; Offset_0x01CDC2
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
;------------------------------------------------------------------------------- 
Obj_0x6C_Mz_Moving_Platforms:                                  ; Offset_0x01CDC8
		include 'objects/obj_0x6C.asm'                     
;------------------------------------------------------------------------------- 
		nop
Jmp_0C_To_DisplaySprite:                                       ; Offset_0x01D11C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0F_To_DeleteObject:                                        ; Offset_0x01D122
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_05_To_SingleObjectLoad:                                    ; Offset_0x01D128
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_17_To_ModifySpriteAttr_2P:                                 ; Offset_0x01D12E
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_00_To_Platform_Object:                                     ; Offset_0x01D134
		jmp     (Platform_Object)                      ; Offset_0x00F82C
Jmp_0B_To_SpeedToPos:                                          ; Offset_0x01D13A
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
;-------------------------------------------------------------------------------
Obj_0x6E_Machine:                                              ; Offset_0x01D140
		include 'objects/obj_0x6E.asm'                      
;-------------------------------------------------------------------------------
Jmp_18_To_ModifySpriteAttr_2P:                                 ; Offset_0x01D348
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_0C_To_SolidObject:                                         ; Offset_0x01D34E
		jmp     (SolidObject)                          ; Offset_0x00F344     
;-------------------------------------------------------------------------------   
Obj_Ox6F_Parallelogram_Elevator:                               ; Offset_0x01D354
		include 'objects/obj_0x6F.asm'                              
;-------------------------------------------------------------------------------    
		nop
Jmp_19_To_ModifySpriteAttr_2P:                                 ; Offset_0x01D6A0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Offset_0x01D6A6:
		jmp     (Offset_0x00F442)       
;-------------------------------------------------------------------------------  
Obj_0x70_Rotating_Gears:                                       ; Offset_0x01D6AC
		include 'objects/obj_0x70.asm'                          
;-------------------------------------------------------------------------------    
		nop
Jmp_0B_To_SingleObjectLoad_2:                                  ; Offset_0x01DA14
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_01_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x01DA1A
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_0D_To_SolidObject:                                         ; Offset_0x01DA20
		jmp     (SolidObject)                          ; Offset_0x00F344   
		dc.w    $0000
;------------------------------------------------------------------------------- 
Obj_0x72_Conveyor_Belt_Attributes:                             ; Offset_0x01DA28
		include 'objects/obj_0x72.asm' 
;-------------------------------------------------------------------------------  
		nop
Jmp_04_To_MarkObjGone_3:                                       ; Offset_0x01DAA8
		jmp     (MarkObjGone_3)                        ; Offset_0x00D26C 
		dc.w    $0000                 
;------------------------------------------------------------------------------- 
Obj_0x73_Rotating_Rings:                                       ; Offset_0x01DAB0 
		include 'objects/obj_0x73.asm' 
;-------------------------------------------------------------------------------   
Jmp_0D_To_DisplaySprite:                                       ; Offset_0x01DC84
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_06_To_SingleObjectLoad:                                    ; Offset_0x01DC8A
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_00_To_DeleteObject_A1:                                     ; Offset_0x01DC90
		jmp     (DeleteObject_A1)                      ; Offset_0x00D316
Jmp_1A_To_ModifySpriteAttr_2P:                                 ; Offset_0x01DC96
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_0E_To_SolidObject:                                         ; Offset_0x01DC9C
		jmp     (SolidObject)                          ; Offset_0x00F344   
		dc.w    $0000                 
;------------------------------------------------------------------------------- 
Obj_0x75_Spikeball_Chain:                                      ; Offset_0x01DCA4
		include 'objects/obj_0x75.asm'                               
;-------------------------------------------------------------------------------   
		nop
Jmp_00_To_DisplaySprite_Param:                                 ; Offset_0x01DE9C
		jmp     (DisplaySprite_Param)                  ; Offset_0x00D35E
Jmp_0E_To_DisplaySprite:                                       ; Offset_0x01DEA2
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_10_To_DeleteObject:                                        ; Offset_0x01DEA8
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_13_To_MarkObjGone:                                         ; Offset_0x01DEAE
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_01_To_DeleteObject_A1:                                     ; Offset_0x01DEB4
		jmp     (DeleteObject_A1)                      ; Offset_0x00D316
Jmp_0C_To_SingleObjectLoad_2:                                  ; Offset_0x01DEBA
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_1B_To_ModifySpriteAttr_2P:                                 ; Offset_0x01DEC0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_03_To_CalcSine:                                            ; Offset_0x01DEC6
		jmp     (CalcSine)                             ; Offset_0x003282
Jmp_0F_To_SolidObject:                                         ; Offset_0x01DECC
		jmp     (SolidObject)                          ; Offset_0x00F344  
		dc.w    $0000                 
;------------------------------------------------------------------------------- 
Obj_0x76_Platform_Spikes:                                      ; Offset_0x01DED4
		include 'objects/obj_0x76.asm'                    
;-------------------------------------------------------------------------------
		nop
Jmp_00_To_Hurt_Player_A1:                                      ; Offset_0x01E04C
		jmp     (Hurt_Player_A1)                       ; Offset_0x00C9A4
Jmp_1C_To_ModifySpriteAttr_2P:                                 ; Offset_0x01E052
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_10_To_SolidObject:                                         ; Offset_0x01E058
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_04_To_MarkObjGone_2:                                       ; Offset_0x01E05E
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238   
;------------------------------------------------------------------------------- 
Obj_0x77_Bridge:                                               ; Offset_0x01E064 
		include 'objects/obj_0x77.asm'                             
;-------------------------------------------------------------------------------
Jmp_14_To_MarkObjGone:                                         ; Offset_0x01E294
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_1D_To_ModifySpriteAttr_2P:                                 ; Offset_0x01E29A
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_11_To_SolidObject:                                         ; Offset_0x01E2A0
		jmp     (SolidObject)                          ; Offset_0x00F344    
		dc.w    $0000                 
;------------------------------------------------------------------------------- 
Obj_0x78_Stair_Case_Platforms:                                 ; Offset_0x01E2A8  
		include 'objects/obj_0x78.asm'                 
;-------------------------------------------------------------------------------    
Jmp_0D_To_SingleObjectLoad_2:                                  ; Offset_0x01E464
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_02_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x01E46A
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_12_To_SolidObject:                                         ; Offset_0x01E470
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_05_To_MarkObjGone_2:                                       ; Offset_0x01E476
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238 
;-------------------------------------------------------------------------------    
Obj_0x7A_Platform_Horizontal:                                  ; Offset_0x01E47C
		include 'objects/obj_0x7A.asm'              
;-------------------------------------------------------------------------------
Jmp_0F_To_DisplaySprite:                                       ; Offset_0x01E654
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0E_To_SingleObjectLoad_2:                                  ; Offset_0x01E65A
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_1E_To_ModifySpriteAttr_2P:                                 ; Offset_0x01E660
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_01_To_Platform_Object:                                     ; Offset_0x01E666
		jmp     (Platform_Object)                      ; Offset_0x00F82C 
;------------------------------------------------------------------------------- 
Obj_0x7B_Spring_Tubes:                                         ; Offset_0x01E66C  
		include 'objects/obj_0x7B.asm'                            
;------------------------------------------------------------------------------- 
		nop
Jmp_10_To_DisplaySprite:                                       ; Offset_0x01E884
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_11_To_DeleteObject:                                        ; Offset_0x01E88A
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_04_To_AnimateSprite:                                       ; Offset_0x01E890
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_1F_To_ModifySpriteAttr_2P:                                 ; Offset_0x01E896
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_03_To_SolidObject_2_A1:                                    ; Offset_0x01E89C
		jmp     (SolidObject_2_A1)                     ; Offset_0x00F3B4
		dc.w    $0000   
;------------------------------------------------------------------------------- 
Obj_0x7F_Vines_Switch:                                         ; Offset_0x01E8A4
		include 'objects/obj_0x7F.asm'                               
;-------------------------------------------------------------------------------  
Jmp_15_To_MarkObjGone:                                         ; Offset_0x01EA24
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_20_To_ModifySpriteAttr_2P:                                 ; Offset_0x01EA2A
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE   
;------------------------------------------------------------------------------- 
Obj_0x80_Vines_Chain_Hook:                                     ; Offset_0x01EA30 
		include 'objects/obj_0x80.asm' 
;-------------------------------------------------------------------------------  
Jmp_16_To_MarkObjGone:                                         ; Offset_0x01ED80
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_21_To_ModifySpriteAttr_2P:                                 ; Offset_0x01ED86
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE                   
;------------------------------------------------------------------------------- 
Obj_0x81_Vertical_Bridge:                                      ; Offset_0x01ED8C
		include 'objects/obj_0x81.asm'                           
;------------------------------------------------------------------------------- 
		nop
Jmp_01_To_DisplaySprite_Param:                                 ; Offset_0x01EFE8
		jmp     (DisplaySprite_Param)                  ; Offset_0x00D35E
Jmp_11_To_DisplaySprite:                                       ; Offset_0x01EFEE
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_12_To_DeleteObject:                                        ; Offset_0x01EFF4
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_02_To_DeleteObject_A1:                                     ; Offset_0x01EFFA
		jmp     (DeleteObject_A1)                      ; Offset_0x00D316
Jmp_0F_To_SingleObjectLoad_2:                                  ; Offset_0x01F000
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_22_To_ModifySpriteAttr_2P:                                 ; Offset_0x01F006
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_04_To_CalcSine:                                            ; Offset_0x01F00C
		jmp     (CalcSine)                             ; Offset_0x003282
Jmp_13_To_SolidObject:                                         ; Offset_0x01F012
		jmp     (SolidObject)                          ; Offset_0x00F344  
;-------------------------------------------------------------------------------
Obj_0x82_Falling_Pillar:                                       ; Offset_0x01F018
		include 'objects/obj_0x82.asm'
;------------------------------------------------------------------------------- 
		nop
Jmp_01_To_ObjHitFloor:                                         ; Offset_0x01F260
		jmp     (ObjHitFloor)                          ; Offset_0x014204
Jmp_23_To_ModifySpriteAttr_2P:                                 ; Offset_0x01F266
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_00_To_Object_HitCeiling:                                   ; Offset_0x01F26C
		jmp     (Object_HitCeiling)                    ; Offset_0x0143C8
Jmp_14_To_SolidObject:                                         ; Offset_0x01F272
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_06_To_MarkObjGone_2:                                       ; Offset_0x01F278
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238
Jmp_0C_To_SpeedToPos:                                          ; Offset_0x01F27E
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA                                                                                  
;-------------------------------------------------------------------------------
Obj_0x83_Three_Rotating_Platforms:                             ; Offset_0x01F284
		include 'objects/obj_0x83.asm'             
;------------------------------------------------------------------------------- 
		nop
Jmp_02_To_DisplaySprite_Param:                                 ; Offset_0x01F500
		jmp     (DisplaySprite_Param)                  ; Offset_0x00D35E
Jmp_12_To_DisplaySprite:                                       ; Offset_0x01F506
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_13_To_DeleteObject:                                        ; Offset_0x01F50C
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_03_To_DeleteObject_A1:                                     ; Offset_0x01F512
		jmp     (DeleteObject_A1)                      ; Offset_0x00D316
Jmp_10_To_SingleObjectLoad_2:                                  ; Offset_0x01F518
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_24_To_ModifySpriteAttr_2P:                                 ; Offset_0x01F51E
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_05_To_CalcSine:                                            ; Offset_0x01F524
		jmp     (CalcSine)                             ; Offset_0x003282
Jmp_02_To_Platform_Object:                                     ; Offset_0x01F52A
		jmp     (Platform_Object)                      ; Offset_0x00F82C
Jmp_07_To_MarkObjGone_2:                                       ; Offset_0x01F530
		jmp     (MarkObjGone_2)                        ; Offset_0x00D238
		dc.w    $0000                     
;-------------------------------------------------------------------------------
Obj_0x3F_Fans:                                                 ; Offset_0x01F538
		include 'objects/obj_0x3F.asm'    
;-------------------------------------------------------------------------------
		nop
Jmp_17_To_MarkObjGone:                                         ; Offset_0x01F8E4
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_25_To_ModifySpriteAttr_2P:                                 ; Offset_0x01F8EA
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
;-------------------------------------------------------------------------------
Obj_Spinning_Ball:                                             ; Offset_0x01F8F0
		include 'objects/obj_spbl.asm'                
;-------------------------------------------------------------------------------
Jmp_18_To_MarkObjGone:                                         ; Offset_0x01F9EC
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_05_To_AnimateSprite:                                       ; Offset_0x01F9F2
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_02_To_ObjHitFloor:                                         ; Offset_0x01F9F8
		jmp     (ObjHitFloor)                          ; Offset_0x014204
Jmp_00_To_Object_HitWall_Left:                                 ; Offset_0x01F9FE
		jmp     (Object_HitWall_Left)                  ; Offset_0x014490
Jmp_26_To_ModifySpriteAttr_2P:                                 ; Offset_0x01FA04
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_01_To_Object_HitWall_Right:                                ; Offset_0x01FA0A
		jmp     (Object_HitWall_Right)                 ; Offset_0x01430A
Jmp_01_To_ObjectFall:                                          ; Offset_0x01FA10
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
		dc.w    $0000    
;------------------------------------------------------------------------------- 
Obj_0x4C_Batbot:                                               ; Offset_0x01FA18  
		include 'objects/obj_0x4C.asm'     
;-------------------------------------------------------------------------------
		dc.w    $0000                                              
Jmp_19_To_MarkObjGone:                                         ; Offset_0x01FE8C
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_06_To_AnimateSprite:                                       ; Offset_0x01FE92
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_0D_To_SpeedToPos:                                          ; Offset_0x01FE98
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA 
		dc.w    $0000         
;-------------------------------------------------------------------------------
Previus_Build_Obj_0x52_Piranha: ; Objeto 0z52 no Sonic 2 Beta  ; Offset_0x01FEA0
		include 'objects/objpb_52.asm'                 
;------------------------------------------------------------------------------- 
		dc.w    $0000                 
Jmp_1A_To_MarkObjGone:                                         ; Offset_0x0200E4
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_07_To_AnimateSprite:                                       ; Offset_0x0200EA
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_0E_To_SpeedToPos:                                          ; Offset_0x0200F0
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000                 
;------------------------------------------------------------------------------- 
Obj_0x56_GHz_Boss:                                             ; Offset_0x0200F8
		include 'objects/obj_0x56.asm'     
Obj_0x58_GHz_Boss:                                             ; Offset_0x020372
		include 'objects/obj_0x58.asm'     
;------------------------------------------------------------------------------- 
Jmp_13_To_DisplaySprite:                                       ; Offset_0x0204FC
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_14_To_DeleteObject:                                        ; Offset_0x020502
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_03_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x020508
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_27_To_ModifySpriteAttr_2P:                                 ; Offset_0x02050E
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE  
;===============================================================================
; Complemento do objeto 0x56 - Chefe na Green Hill
; ->>>
;===============================================================================                
Obj_0x56_GHz_Boss_Sub_2:                                       ; Offset_0x020514
		moveq   #$00, D0
		move.b  Obj_Routine_2(A0), D0                            ; $0025
		move.w  Offset_0x020522(PC, D0), D1
		jmp     Offset_0x020522(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x020522:
		dc.w    Offset_0x02052E-Offset_0x020522
		dc.w    Offset_0x020554-Offset_0x020522
		dc.w    Offset_0x0205B0-Offset_0x020522
		dc.w    Offset_0x0205E2-Offset_0x020522
		dc.w    Offset_0x02060C-Offset_0x020522
		dc.w    Offset_0x020626-Offset_0x020522   
;-------------------------------------------------------------------------------
Offset_0x02052E:
		move.b  #$00, Obj_Col_Flags(A0)                          ; $0020
		cmpi.w  #$29D0, Obj_X(A0)                                ; $0008
		ble.s   Offset_0x020546
		subi.w  #$0001, Obj_X(A0)                                ; $0008
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
Offset_0x020546:
		move.w  #$29D0, Obj_X(A0)                                ; $0008
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58  
;-------------------------------------------------------------------------------
Offset_0x020554:
		moveq   #$00, D0
		move.b  Obj_Control_Var_00(A0), D0                       ; $002C
		move.w  Offset_0x020562(PC, D0), D1
		jmp     Offset_0x020562(PC, D1)     
;-------------------------------------------------------------------------------
Offset_0x020562:
		dc.w    Offset_0x020566-Offset_0x020562
		dc.w    Offset_0x02058C-Offset_0x020562     
;-------------------------------------------------------------------------------
Offset_0x020566:
		cmpi.w  #$041E, Obj_Y(A0)                                ; $000C
		bge.s   Offset_0x020578
		addi.w  #$0001, Obj_Y(A0)                                ; $000C
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
Offset_0x020578:
		addq.b  #$02, Obj_Control_Var_00(A0)                     ; $002C
		bset    #$00, Obj_Control_Var_01(A0)                     ; $002D
		move.w  #$003C, Obj_Timer(A0)                            ; $002A
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58   
;-------------------------------------------------------------------------------
Offset_0x02058C:
		subi.w  #$0001, Obj_Timer(A0)                            ; $002A
		bpl     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
		move.w  #$FE00, Obj_Speed(A0)                            ; $0010
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
		bset    #$01, Obj_Control_Var_01(A0)                     ; $002D
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58     
;-------------------------------------------------------------------------------
Offset_0x0205B0:
		bsr     Offset_0x020724
		bsr     Offset_0x020702
		move.w  Obj_Control_Var_02(A0), D0                       ; $002E
		lsr.w   #$01, D0
		subi.w  #$0014, D0
		move.w  D0, Obj_Y(A0)                                    ; $000C
		move.w  #$0000, Obj_Control_Var_02(A0)                   ; $002E
		move.l  Obj_X(A0), D2                                    ; $0008
		move.w  Obj_Speed(A0), D0                                ; $0010
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.l  D2, Obj_X(A0)                                    ; $0008
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58 
;-------------------------------------------------------------------------------
Offset_0x0205E2:
		subq.w  #$01, Obj_Control_Var_10(A0)                     ; $003C
		bpl     Boss_Defeated                          ; Offset_0x023AEC
		bset    #$00, Obj_Status(A0)                             ; $0022
		bclr    #$07, Obj_Status(A0)                             ; $0022
		clr.w   Obj_Speed(A0)                                    ; $0010
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		move.w  #$FFDA, Obj_Control_Var_10(A0)                   ; $003C
		move.w  #$000C, Obj_Timer(A0)                            ; $002A
		rts  
;-------------------------------------------------------------------------------
Offset_0x02060C:
		addq.w  #$01, Obj_Y(A0)                                  ; $000C
		subq.w  #$01, Obj_Timer(A0)                              ; $002A
		bpl     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		move.b  #$00, Obj_Control_Var_00(A0)                     ; $002C
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58  
;-------------------------------------------------------------------------------
Offset_0x020626:
		moveq   #$00, D0
		move.b  Obj_Control_Var_00(A0), D0                       ; $002C
		move.w  Offset_0x020640(PC, D0), D1
		jsr     Offset_0x020640(PC, D1)
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		bne     Jmp_15_To_DeleteObject                 ; Offset_0x020E5E
		bra     Jmp_14_To_DisplaySprite                ; Offset_0x020E58   
;-------------------------------------------------------------------------------
Offset_0x020640:
		dc.w    Offset_0x020646-Offset_0x020640
		dc.w    Offset_0x0206BE-Offset_0x020640
		dc.w    Offset_0x0206D8-Offset_0x020640   
;-------------------------------------------------------------------------------
Offset_0x020646:
		bclr    #$00, Obj_Control_Var_01(A0)                     ; $002D
		bsr     Jmp_11_To_SingleObjectLoad_2           ; Offset_0x020E6A
		bne     Jmp_14_To_DisplaySprite                ; Offset_0x020E58
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_04, Obj_Map(A1) ; Offset_0x020CE4, $0004
		move.w  #$25E8, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$20, Obj_Width(A1)                              ; $0019
		move.b  #$04, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		addi.w  #$000C, Obj_Y(A1)                                ; $000C
		move.b  Obj_Status(A0), Obj_Status(A1)            ; $0022, $0022
		move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
		move.b  #$08, Obj_Routine(A1)                            ; $0024
		move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
		move.w  #$0010, Obj_Timer(A1)                            ; $002A
		move.w  #$0032, Obj_Timer(A0)                            ; $002A
		addq.b  #$02, Obj_Control_Var_00(A0)                     ; $002C
		rts       
;-------------------------------------------------------------------------------
Offset_0x0206BE:
		subi.w  #$0001, Obj_Timer(A0)                            ; $002A
		bpl.s   Offset_0x0206D6
		bset    #$02, Obj_Control_Var_01(A0)                     ; $002D
		move.w  #$0060, Obj_Timer(A0)                            ; $002A
		addq.b  #$02, Obj_Control_Var_00(A0)                     ; $002C
Offset_0x0206D6:
		rts   
;-------------------------------------------------------------------------------
Offset_0x0206D8:
		subq.w  #$01, Obj_Y(A0)                                  ; $000C
		subi.w  #$0001, Obj_Timer(A0)                            ; $002A
		bpl.s   Offset_0x020700
		addq.w  #$01, Obj_Y(A0)                                  ; $000C
		addq.w  #$02, Obj_X(A0)                                  ; $0008
		cmpi.w  #$2B08, Obj_X(A0)                                ; $0008
		bcs.s   Offset_0x020700
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		bne.s   Offset_0x020700
		move.b  #$01, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
Offset_0x020700:
		rts
Offset_0x020702:
		move.w  Obj_X(A0), D0                                    ; $0008
		cmpi.w  #$2720, D0
		ble.s   Offset_0x020712
		cmpi.w  #$2B08, D0
		blt.s   Offset_0x020722
Offset_0x020712:
		bchg    #00, Obj_Status(A0)                              ; $0022
		bchg    #00, Obj_Flags(A0)                               ; $0001
		neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x020722:
		rts
Offset_0x020724:
		cmpi.b  #$06, Obj_Routine_2(A0)                          ; $0025
		bcc.s   Offset_0x02076A
		tst.b   Obj_Status(A0)                                   ; $0022
		bmi.s   Offset_0x02076C
		tst.b   Obj_Col_Flags(A0)                                ; $0020
		bne.s   Offset_0x02076A
		tst.b   Obj_Control_Var_12(A0)                           ; $003E
		bne.s   Offset_0x02074E
		move.b  #$20, Obj_Control_Var_12(A0)                     ; $003E
		move.w  #$00AC, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02074E:
		lea     ($FFFFFB22).w, A1
		moveq   #$00, D0
		tst.w   (A1)
		bne.s   Offset_0x02075C
		move.w  #$0EEE, D0
Offset_0x02075C:
		move.w  D0, (A1)
		subq.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
		bne.s   Offset_0x02076A
		move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
Offset_0x02076A:
		rts
Offset_0x02076C:
		moveq   #$64, D0
		bsr     Jmp_00_To_AddPoints                    ; Offset_0x020E82
		move.b  #$06, Obj_Routine_2(A0)                          ; $0025
		move.w  #$00B3, Obj_Control_Var_10(A0)                   ; $003C
		bset    #$03, Obj_Control_Var_01(A0)                     ; $002D
		rts 
;===============================================================================
; Complemento do objeto 0x56 - Chefe na Green Hill
; <<<-
;===============================================================================                  
Obj_0x5B_GHz_Boss:                                             ; Offset_0x020786
		include 'objects/obj_0x5B.asm'      
;===============================================================================
; Complemento do objeto 0x56 - Chefe na Green Hill
; ->>>
;===============================================================================               
Obj_0x56_GHz_Boss_Sub_3:                                       ; Offset_0x020A32
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x020AAA
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_05, Obj_Map(A1) ; Offset_0x020DCC, $0004
		move.w  #$2400, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$10, Obj_Width(A1)                              ; $0019
		move.b  #$01, Obj_Priority(A1)                           ; $0018
		move.b  #$10, Obj_Height_2(A1)                           ; $0016
		move.b  #$10, Obj_Width_2(A1)                            ; $0017
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		addi.w  #$001C, Obj_X(A1)                                ; $0008
		addi.w  #$000C, Obj_Y(A1)                                ; $000C
		move.w  #$FE00, Obj_Speed(A1)                            ; $0010
		move.b  #$04, Obj_Routine(A1)                            ; $0024
		move.b  #$04, Obj_Map_Id(A1)                             ; $001A
		move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
		move.w  #$0016, Obj_Timer(A1)                            ; $002A
Offset_0x020AAA:
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x020B22
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_05, Obj_Map(A1) ; Offset_0x020DCC, $0004
		move.w  #$2400, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$10, Obj_Width(A1)                              ; $0019
		move.b  #$01, Obj_Priority(A1)                           ; $0018
		move.b  #$10, Obj_Height_2(A1)                           ; $0016
		move.b  #$10, Obj_Width_2(A1)                            ; $0017
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		addi.w  #$FFF4, Obj_X(A1)                                ; $0008
		addi.w  #$000C, Obj_Y(A1)                                ; $000C
		move.w  #$FE00, Obj_Speed(A1)                            ; $0010
		move.b  #$04, Obj_Routine(A1)                            ; $0024
		move.b  #$04, Obj_Map_Id(A1)                             ; $001A
		move.b  #$01, Obj_Ani_Number(A1)                         ; $001C
		move.w  #$004B, Obj_Timer(A1)                            ; $002A
Offset_0x020B22:
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x020B9A
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_05, Obj_Map(A1) ; Offset_0x020DCC, $0004
		move.w  #$2400, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$10, Obj_Width(A1)                              ; $0019
		move.b  #$02, Obj_Priority(A1)                           ; $0018
		move.b  #$10, Obj_Height_2(A1)                           ; $0016
		move.b  #$10, Obj_Width_2(A1)                            ; $0017
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		addi.w  #$FFD4, Obj_X(A1)                                ; $0008
		addi.w  #$000C, Obj_Y(A1)                                ; $000C
		move.w  #$FE00, Obj_Speed(A1)                            ; $0010
		move.b  #$04, Obj_Routine(A1)                            ; $0024
		move.b  #$06, Obj_Map_Id(A1)                             ; $001A
		move.b  #$02, Obj_Ani_Number(A1)                         ; $001C
		move.w  #$0030, Obj_Timer(A1)                            ; $002A
Offset_0x020B9A:
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x020BFA
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_05, Obj_Map(A1) ; Offset_0x020DCC, $0004
		move.w  #$2400, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$10, Obj_Width(A1)                              ; $0019
		move.b  #$01, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		addi.w  #$FFCA, Obj_X(A1)                                ; $0008
		addi.w  #$0008, Obj_Y(A1)                                ; $000C
		move.b  #$06, Obj_Routine(A1)                            ; $0024
		move.b  #$01, Obj_Map_Id(A1)                             ; $001A
		move.b  #$00, Obj_Ani_Number(A1)                         ; $001C
Offset_0x020BFA:
		rts                
;-------------------------------------------------------------------------------
Obj_0x56_GHz_Boss_Sub_4:                                       ; Offset_0x020BFC
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x020C44
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_05, Obj_Map(A1) ; Offset_0x020DCC, $0004
		move.w  #$0400, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$20, Obj_Width(A1)                              ; $0019
		move.b  #$02, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		move.b  #$02, Obj_Routine(A1)                            ; $0024
Offset_0x020C44:
		bsr     Obj_0x56_GHz_Boss_Sub_3                ; Offset_0x020A32
		subi.w  #$0008, Obj_Control_Var_0C(A0)                   ; $0038
		move.w  #$2A00, Obj_X(A0)                                ; $0008
		move.w  #$02C0, Obj_Y(A0)                                ; $000C
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x020CA8
		move.b  #$5B, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #GHz_Boss_Mappings_04, Obj_Map(A1) ; Offset_0x020CE4, $0004
		move.w  #$25E8, Obj_Art_VRAM(A1)                         ; $0002
		bsr     Jmp_04_To_ModifySpriteAttr_2P_A1       ; Offset_0x020E76
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$20, Obj_Width(A1)                              ; $0019
		move.b  #$04, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		move.w  #$001E, Obj_Timer(A1)                            ; $002A
		move.b  #$00, Obj_Routine(A1)                            ; $0024
Offset_0x020CA8:
		rts                                                             
;-------------------------------------------------------------------------------
GHz_Boss_Animate_Data_01:                                      ; Offset_0x020CAA
		dc.w    Offset_0x020CB0-GHz_Boss_Animate_Data_01
		dc.w    Offset_0x020CB4-GHz_Boss_Animate_Data_01
		dc.w    Offset_0x020CCA-GHz_Boss_Animate_Data_01
Offset_0x020CB0:
		dc.b    $01, $05, $06, $FF
Offset_0x020CB4:
		dc.b    $01, $01, $01, $01, $02, $02, $02, $03
		dc.b    $03, $03, $04, $04, $04, $00, $00, $00
		dc.b    $00, $00, $00, $00, $00, $FF
Offset_0x020CCA:
		dc.b    $01, $00, $00, $00, $00, $00, $00, $00
		dc.b    $00, $04, $04, $04, $03, $03, $03, $02
		dc.b    $02, $02, $01, $01, $01, $05, $06, $FE
		dc.b    $02, $00    
;-------------------------------------------------------------------------------
GHz_Boss_Mappings_04:                                          ; Offset_0x020CE4
		dc.w    Offset_0x020CF2-GHz_Boss_Mappings_04
		dc.w    Offset_0x020CFC-GHz_Boss_Mappings_04
		dc.w    Offset_0x020D26-GHz_Boss_Mappings_04
		dc.w    Offset_0x020D50-GHz_Boss_Mappings_04
		dc.w    Offset_0x020D6A-GHz_Boss_Mappings_04
		dc.w    Offset_0x020D84-GHz_Boss_Mappings_04
		dc.w    Offset_0x020D9E-GHz_Boss_Mappings_04
Offset_0x020CF2:
		dc.w    $0001
		dc.l    $D8050000, $00000002
Offset_0x020CFC:
		dc.w    $0005
		dc.l    $D8050004, $00020002
		dc.l    $D80D000C, $00060012
		dc.l    $D80D000C, $00060032
		dc.l    $D80D000C, $0006FFE2
		dc.l    $D80D000C, $0006FFC2
Offset_0x020D26:
		dc.w    $0005
		dc.l    $D8050004, $00020002
		dc.l    $D80D000C, $00060012
		dc.l    $D8050008, $00040032
		dc.l    $D80D000C, $0006FFE2
		dc.l    $D8050008, $0004FFD2
Offset_0x020D50:
		dc.w    $0003
		dc.l    $D8050004, $00020002
		dc.l    $D80D000C, $00060012
		dc.l    $D80D000C, $0006FFE2
Offset_0x020D6A:
		dc.w    $0003
		dc.l    $D8050004, $00020002
		dc.l    $D8050008, $00040012
		dc.l    $D8050008, $0004FFF2
Offset_0x020D84:
		dc.w    $0003
		dc.l    $D8050000, $00000002
		dc.l    $D80D000C, $00060012
		dc.l    $D80D000C, $00060032
Offset_0x020D9E:
		dc.w    $0003
		dc.l    $D8050004, $00020002
		dc.l    $D80D000C, $0006FFE2
		dc.l    $D80D000C, $0006FFC2      
;-------------------------------------------------------------------------------
GHz_Boss_Animate_Data_02:                                      ; Offset_0x020DB8
		dc.w    Offset_0x020DBE-GHz_Boss_Animate_Data_02
		dc.w    Offset_0x020DC3-GHz_Boss_Animate_Data_02
		dc.w    Offset_0x020DC7-GHz_Boss_Animate_Data_02
Offset_0x020DBE:
		dc.b    $05, $01, $02, $03, $FF
Offset_0x020DC3:
		dc.b    $01, $04, $05, $FF
Offset_0x020DC7:
		dc.b    $01, $06, $07, $FF, $00  
;-------------------------------------------------------------------------------
GHz_Boss_Mappings_05:                                          ; Offset_0x020DCC
		dc.w    Offset_0x020DDE-GHz_Boss_Mappings_05
		dc.w    Offset_0x020DF8-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E02-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E0C-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E16-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E20-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E2A-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E34-GHz_Boss_Mappings_05
		dc.w    Offset_0x020E3E-GHz_Boss_Mappings_05
Offset_0x020DDE:
		dc.w    $0003
		dc.l    $F00F0000, $0000FFD0
		dc.l    $F00F0010, $0008FFF0
		dc.l    $F00F0020, $00100010
Offset_0x020DF8:
		dc.w    $0001
		dc.l    $F00F0030, $0018FFF0
Offset_0x020E02:
		dc.w    $0001
		dc.l    $F00F0040, $0020FFF0
Offset_0x020E0C:
		dc.w    $0001
		dc.l    $F00F0050, $0028FFF0
Offset_0x020E16:
		dc.w    $0001
		dc.l    $F00F0060, $0030FFF0
Offset_0x020E20:
		dc.w    $0001
		dc.l    $F00F1060, $1030FFF0
Offset_0x020E2A:
		dc.w    $0001
		dc.l    $F00F0070, $0038FFF0
Offset_0x020E34:
		dc.w    $0001
		dc.l    $F00F1070, $1038FFF0
Offset_0x020E3E:
		dc.w    $0003
		dc.l    $F00F8000, $8000FFD0
		dc.l    $F00F8010, $8008FFF0
		dc.l    $F00F8020, $80100010                                                               
;===============================================================================
; Complemento do objeto 0x56 - Chefe na Green Hill
; <<<-
;===============================================================================
Jmp_14_To_DisplaySprite:                                       ; Offset_0x020E58
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_15_To_DeleteObject:                                        ; Offset_0x020E5E
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_1B_To_MarkObjGone:                                         ; Offset_0x020E64
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_11_To_SingleObjectLoad_2:                                  ; Offset_0x020E6A
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_08_To_AnimateSprite:                                       ; Offset_0x020E70
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_04_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x020E76
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_03_To_ObjHitFloor:                                         ; Offset_0x020E7C
		jmp     (ObjHitFloor)                          ; Offset_0x014204
Jmp_00_To_AddPoints:                                           ; Offset_0x020E82
		jmp     (AddPoints)                            ; Offset_0x02D2D4
Jmp_02_To_ObjectFall:                                          ; Offset_0x020E88
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
		dc.w    $0000
;-------------------------------------------------------------------------------
Obj_Bubble_Monster:                                            ; Offset_0x020E90
		include 'objects/obj_bbmn.asm'                     
;-------------------------------------------------------------------------------   
Jmp_16_To_DeleteObject:                                        ; Offset_0x02113C
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_07_To_SingleObjectLoad:                                    ; Offset_0x021142
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_1C_To_MarkObjGone:                                         ; Offset_0x021148
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_09_To_AnimateSprite:                                       ; Offset_0x02114E
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_28_To_ModifySpriteAttr_2P:                                 ; Offset_0x021154
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_0F_To_SpeedToPos:                                          ; Offset_0x02115A
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA  
;-------------------------------------------------------------------------------
Obj_0x4E_Crocobot:                                             ; Offset_0x021160
		include 'objects/obj_0x4E.asm'                 
;-------------------------------------------------------------------------------  
Jmp_1D_To_MarkObjGone:                                         ; Offset_0x021440
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0A_To_AnimateSprite:                                       ; Offset_0x021446
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_03_To_ObjectFall:                                          ; Offset_0x02144C
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_10_To_SpeedToPos:                                          ; Offset_0x021452
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA  
;-------------------------------------------------------------------------------
Obj_Blink:                                                     ; Offset_0x021458
		include 'objects/obj_blnk.asm'                     
;-------------------------------------------------------------------------------  
Jmp_17_To_DeleteObject:                                        ; Offset_0x0216CC
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_08_To_SingleObjectLoad:                                    ; Offset_0x0216D2
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_1E_To_MarkObjGone:                                         ; Offset_0x0216D8
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0B_To_AnimateSprite:                                       ; Offset_0x0216DE
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_01_To_PseudoRandomNumber:                                  ; Offset_0x0216E4
		jmp     (PseudoRandomNumber)                   ; Offset_0x00325C
Jmp_04_To_ObjHitFloor:                                         ; Offset_0x0216EA
		jmp     (ObjHitFloor)                          ; Offset_0x014204
Jmp_29_To_ModifySpriteAttr_2P:                                 ; Offset_0x0216F0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_04_To_ObjectFall:                                          ; Offset_0x0216F6
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_11_To_SpeedToPos:                                          ; Offset_0x0216FC
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000  
;-------------------------------------------------------------------------------
Obj_0x4A_Octus:                                                ; Offset_0x021704 
		include 'objects/obj_0x4A.asm' 
;------------------------------------------------------------------------------- 
Jmp_15_To_DisplaySprite:                                       ; Offset_0x021994
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_18_To_DeleteObject:                                        ; Offset_0x02199A
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_1F_To_MarkObjGone:                                         ; Offset_0x0219A0
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0C_To_AnimateSprite:                                       ; Offset_0x0219A6
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_05_To_ObjectFall:                                          ; Offset_0x0219AC
		jmp     (ObjectFall)                           ; Offset_0x00D1AE  
		dc.w    $0000         
;-------------------------------------------------------------------------------
Obj_0x4F_Dinobot:                                              ; Offset_0x0219B4
		include 'objects/obj_0x4F.asm'                         
;------------------------------------------------------------------------------- 
		dc.w    $0000                                               
Jmp_16_To_DisplaySprite:                                       ; Offset_0x021AF8
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_19_To_DeleteObject:                                        ; Offset_0x021AFE
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0D_To_AnimateSprite:                                       ; Offset_0x021B04
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_06_To_ObjectFall:                                          ; Offset_0x021B0A
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_12_To_SpeedToPos:                                          ; Offset_0x021B10
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
		dc.w    $0000                                               
;------------------------------------------------------------------------------- 
Obj_0x5A:                                                      ; Offset_0x021B18
		include 'objects/obj_0x5A.asm'                           
;-------------------------------------------------------------------------------   
Jmp_09_To_SingleObjectLoad:                                    ; Offset_0x021D98
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_20_To_MarkObjGone:                                         ; Offset_0x021D9E
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0E_To_AnimateSprite:                                       ; Offset_0x021DA4
		jmp     (AnimateSprite)                        ; Offset_0x00D372   
		dc.w    $0000                          
;-------------------------------------------------------------------------------
Obj_0x50_Aquis:                                                ; Offset_0x021DAC
		include 'objects/obj_0x50.asm'                             
Previus_Build_Obj_0x51_Aquis: ; Objeto 0z51 no Sonic 2 Beta    ; Offset_0x0223C8
		include 'objects/objpb_51.asm'                                                                                    
;-------------------------------------------------------------------------------   
Jmp_17_To_DisplaySprite:                                       ; Offset_0x02260C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_1A_To_DeleteObject:                                        ; Offset_0x022612
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0A_To_SingleObjectLoad:                                    ; Offset_0x022618
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_21_To_MarkObjGone:                                         ; Offset_0x02261E
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_0F_To_AnimateSprite:                                       ; Offset_0x022624
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_07_To_ObjectFall:                                          ; Offset_0x02262A
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_13_To_SpeedToPos:                                          ; Offset_0x022630
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000                                                    
;------------------------------------------------------------------------------- 
Obj_0x59_Motobug:                                              ; Offset_0x022638
		include 'objects/obj_0x59.asm'                           
;-------------------------------------------------------------------------------
Jmp_1B_To_DeleteObject:                                        ; Offset_0x0228BC
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_12_To_SingleObjectLoad_2:                                  ; Offset_0x0228C2
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_10_To_AnimateSprite:                                       ; Offset_0x0228C8
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_05_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x0228CE
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_00_To_MarkObjGone_4:                                       ; Offset_0x0228D4
		jmp     (MarkObjGone_4)                        ; Offset_0x00D2A0
Jmp_2A_To_ModifySpriteAttr_2P:                                 ; Offset_0x0228DA
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_08_To_ObjectFall:                                          ; Offset_0x0228E0
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_14_To_SpeedToPos:                                          ; Offset_0x0228E6
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
;-------------------------------------------------------------------------------
Obj_0x4D_Rhinobot:                                             ; Offset_0x0228EC
		include 'objects/obj_0x4D.asm'                                
;-------------------------------------------------------------------------------
		dc.w    $0000
Jmp_22_To_MarkObjGone:                                         ; Offset_0x022BA8
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_11_To_AnimateSprite:                                       ; Offset_0x022BAE
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_09_To_ObjectFall:                                          ; Offset_0x022BB4
		jmp     (ObjectFall)                           ; Offset_0x00D1AE  
		dc.w    $0000                
;-------------------------------------------------------------------------------
Obj_CPz_Boss:                                                  ; Offset_0x022BBC
		include 'objects/obj_cpzb.asm'                                     
;===============================================================================
; Rotinas referenciadas pelo Chefe na Green Hill
; ->>>
;===============================================================================    
Offset_0x02385E:
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x0238A2
		move.b  #$57, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
		move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$20, Obj_Width(A1)                              ; $0019
		move.b  #$02, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		move.b  #$0E, Obj_Routine(A1)                            ; $0024
Offset_0x0238A2:
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x0238FE
		move.b  #$57, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
		move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$20, Obj_Width(A1)                              ; $0019
		move.b  #$04, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		subi.w  #$0038, Obj_Y(A1)                                ; $000C
		subi.w  #$0010, Obj_X(A1)                                ; $0008
		move.w  #$FFF0, Obj_Control_Var_02(A1)                   ; $002E
		addi.b  #$0C, Obj_Routine(A1)                            ; $0024
		move.b  #$06, Obj_Ani_Number(A1)                         ; $001C
Offset_0x0238FE:
		jsr     (SingleObjectLoad_2)                   ; Offset_0x00E714
		bne.s   Offset_0x02393C
		move.b  #$57, Obj_Id(A1)                                 ; $0000
		move.l  A0, Obj_Control_Var_08(A1)                       ; $0034
		move.l  #Offset_0x023CD2, Obj_Map(A1)                    ; $0004
		move.w  #$2460, Obj_Art_VRAM(A1)                         ; $0002
		move.b  #$04, Obj_Flags(A1)                              ; $0001
		move.b  #$20, Obj_Width(A1)                              ; $0019
		move.b  #$04, Obj_Priority(A1)                           ; $0018
		move.l  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.l  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
Offset_0x02393C:
		rts                      
;===============================================================================

Offset_0x02393E:
		bsr     Offset_0x02395E
		moveq   #$00, D0
		move.b  Obj_Routine_2(A0), D0                            ; $0025
		move.w  Offset_0x023950(PC, D0), D1
		jmp     Offset_0x023950(PC, D1)                         
;-------------------------------------------------------------------------------    
Offset_0x023950:
		dc.w    Offset_0x023A2A-Offset_0x023950
		dc.w    Offset_0x023B50-Offset_0x023950
		dc.w    Offset_0x023BD4-Offset_0x023950
		dc.w    Offset_0x023BE8-Offset_0x023950
		dc.w    Offset_0x023982-Offset_0x023950
		dc.w    Offset_0x0239B2-Offset_0x023950
		dc.w    Offset_0x0239F4-Offset_0x023950   
;------------------------------------------------------------------------------- 
Offset_0x02395E:
		cmpi.b  #$08, Obj_Routine_2(A0)                          ; $0025
		bge.s   Offset_0x023976
		move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
		sub.w   Obj_X(A0), D0                                    ; $0008
		bgt.s   Offset_0x023978
		bclr    #$00, Obj_Status(A0)                             ; $0022
Offset_0x023976:
		rts
Offset_0x023978:
		bset    #$00, Obj_Status(A0)                             ; $0022
		rts         
;------------------------------------------------------------------------------- 
; Offset_0x023980:
		rts     
;------------------------------------------------------------------------------- 
Offset_0x023982:
		subq.w  #$01, Obj_Control_Var_10(A0)                     ; $003C
		bpl     Boss_Defeated                          ; Offset_0x023AEC
		bset    #$00, Obj_Status(A0)                             ; $0022
		bclr    #$07, Obj_Status(A0)                             ; $0022
		clr.w   Obj_Speed(A0)                                    ; $0010
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		move.w  #$FFDA, Obj_Control_Var_10(A0)                   ; $003C
		tst.b   (Boss_Defeated_Flag).w                       ; $FFFFF7A7
		bne.s   Offset_0x0239B0
		move.b  #$01, (Boss_Defeated_Flag).w                 ; $FFFFF7A7
Offset_0x0239B0:
		rts            
;------------------------------------------------------------------------------- 
Offset_0x0239B2:
		addq.w  #$01, Obj_Control_Var_10(A0)                     ; $003C
		beq.s   Offset_0x0239C2
		bpl.s   Offset_0x0239C8
		addi.w  #$0018, Obj_Speed_Y(A0)                          ; $0012
		bra.s   Offset_0x0239EC
Offset_0x0239C2:
		clr.w   Obj_Speed_Y(A0)                                  ; $0012
		bra.s   Offset_0x0239EC
Offset_0x0239C8:
		cmpi.w  #$0030, Obj_Control_Var_10(A0)                   ; $003C
		bcs.s   Offset_0x0239E0
		beq.s   Offset_0x0239E8
		cmpi.w  #$0038, Obj_Control_Var_10(A0)                   ; $003C
		bcs.s   Offset_0x0239EC
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		bra.s   Offset_0x0239EC
Offset_0x0239E0:
		subi.w  #$0008, Obj_Speed_Y(A0)                          ; $0012
		bra.s   Offset_0x0239EC
Offset_0x0239E8:
		clr.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x0239EC:
		bsr     Offset_0x023AC6
		bra     Offset_0x023A46   
;------------------------------------------------------------------------------- 
Offset_0x0239F4:
		bset    #$06, Obj_Control_Var_02(A0)                     ; $002E
		move.w  #$0400, Obj_Speed(A0)                            ; $0010
		move.w  #$FFC0, Obj_Speed_Y(A0)                          ; $0012
		cmpi.w  #$2AC0, (Sonic_Level_Limits_Max_X).w         ; $FFFFEECA
		beq.s   Offset_0x023A14
		addq.w  #$02, (Sonic_Level_Limits_Max_X).w           ; $FFFFEECA
		bra.s   Offset_0x023A1A
Offset_0x023A14:
		tst.b   Obj_Flags(A0)                                    ; $0001
		bpl.s   Offset_0x023A22
Offset_0x023A1A:
		bsr     Offset_0x023AC6
		bra     Offset_0x023A46
Offset_0x023A22:
		addq.l  #$04, A7
		jmp     (DeleteObject)                         ; Offset_0x00D314   
;------------------------------------------------------------------------------- 
Offset_0x023A2A:
		move.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
		bsr     Offset_0x023AC6
		cmpi.w  #$05A0, Obj_Control_Var_0C(A0)                   ; $0038
		bne.s   Offset_0x023A46
		move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
Offset_0x023A46:
		move.b  Obj_Control_Var_13(A0), D0                       ; $003F
		jsr     (CalcSine)                             ; Offset_0x003282
		asr.w   #$06, D0
		add.w   Obj_Control_Var_0C(A0), D0                       ; $0038
		move.w  D0, Obj_Y(A0)                                    ; $000C
		move.w  Obj_Control_Var_04(A0), Obj_X(A0)         ; $0008, $0030
		addq.b  #$02, Obj_Control_Var_13(A0)                     ; $003F
		cmpi.b  #$08, Obj_Routine_2(A0)                          ; $0025
		bcc.s   Offset_0x023AB0
		tst.b   Obj_Status(A0)                                   ; $0022
		bmi.s   Offset_0x023AB2
		tst.b   Obj_Col_Flags(A0)                                ; $0020
		bne.s   Offset_0x023AB0
		tst.b   Obj_Control_Var_12(A0)                           ; $003E
		bne.s   Offset_0x023A8E
		move.b  #$20, Obj_Control_Var_12(A0)                     ; $003E
		move.w  #$00AC, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x023A8E:
		lea     ($FFFFFB22).w, A1
		moveq   #$00, D0
		tst.w   (A1)
		bne.s   Offset_0x023A9C
		move.w  #$0EEE, D0
Offset_0x023A9C:
		move.w  D0, (A1)
		subq.b  #$01, Obj_Control_Var_12(A0)                     ; $003E
		bne.s   Offset_0x023AB0
		move.b  #$0F, Obj_Col_Flags(A0)                          ; $0020
		bclr    #$01, Obj_Control_Var_01(A0)                     ; $002D
Offset_0x023AB0:
		rts
Offset_0x023AB2:
		moveq   #$64, D0
		bsr     Jmp_01_To_AddPoints                    ; Offset_0x023F66
		move.b  #$08, Obj_Routine_2(A0)                          ; $0025
		move.w  #$00B3, Obj_Control_Var_10(A0)                   ; $003C
		rts
Offset_0x023AC6:
		move.l  Obj_Control_Var_04(A0), D2                       ; $0030
		move.l  Obj_Control_Var_0C(A0), D3                       ; $0038
		move.w  Obj_Speed(A0), D0                                ; $0010
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D2
		move.w  Obj_Speed_Y(A0), D0                              ; $0012
		ext.l   D0
		asl.l   #$08, D0
		add.l   D0, D3
		move.l  D2, Obj_Control_Var_04(A0)                       ; $0030
		move.l  D3, Obj_Control_Var_0C(A0)                       ; $0038
		rts
;------------------------------------------------------------------------------- 
; Rotina utilizada após os chefes de fase serem derrotados
; ->>>
;-------------------------------------------------------------------------------    
Boss_Defeated:                                                 ; Offset_0x023AEC 
		move.b  ($FFFFFE0F).w, D0
		andi.b  #$07, D0
		bne.s   Exit_Boss_Defeated                     ; Offset_0x023B32
		jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
		bne.s   Exit_Boss_Defeated                     ; Offset_0x023B32
		move.b  #$58, Obj_Id(A1)                                 ; $0000
		move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		jsr     (PseudoRandomNumber)                   ; Offset_0x00325C
		move.w  D0, D1
		moveq   #$00, D1
		move.b  D0, D1
		lsr.b   #$02, D1
		subi.w  #$0020, D1
		add.w   D1, Obj_X(A1)                                    ; $0008
		lsr.w   #$08, D0
		lsr.b   #$02, D0
		subi.w  #$0020, D0
		add.w   D0, Obj_Y(A1)                                    ; $000C
Exit_Boss_Defeated:                                            ; Offset_0x023B32
		rts
;------------------------------------------------------------------------------- 
; Rotina utilizada após os chefes de fase serem derrotados
; <<<-
;-------------------------------------------------------------------------------                 
Offset_0x023B34:
		jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
		bne.s   Offset_0x023B4E
		move.b  #$58, Obj_Id(A1)                                 ; $0000
		move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
Offset_0x023B4E:
		rts     
;------------------------------------------------------------------------------- 
Offset_0x023B50:
		cmpi.w  #$0600, Obj_Control_Var_04(A0)                   ; $0030
		blt.s   Offset_0x023B6C
		cmpi.w  #$0700, Obj_Control_Var_04(A0)                   ; $0030
		blt.s   Offset_0x023B66
		move.w  #$0780, D0
		bra.s   Offset_0x023B70
Offset_0x023B66:
		move.w  #$0680, D0
		bra.s   Offset_0x023B70
Offset_0x023B6C:
		move.w  #$0580, D0
Offset_0x023B70:
		move.w  #$0038, D1
		btst    #$00, Obj_Flags(A0)                              ; $0001
		beq.s   Offset_0x023B7E
		neg.w   D1
Offset_0x023B7E:
		add.w   D1, D0
		cmp.w   Obj_Control_Var_04(A0), D0                       ; $0030
		beq.s   Offset_0x023B9E
		bgt.s   Offset_0x023B90
		move.w  #$FF80, Obj_Speed(A0)                            ; $0010
		bra.s   Offset_0x023B96
Offset_0x023B90:
		move.w  #$0080, Obj_Speed(A0)                            ; $0010
Offset_0x023B96:
		bsr     Offset_0x023AC6
		bra     Offset_0x023A46
Offset_0x023B9E:
		cmpi.w  #$05A0, Obj_Control_Var_0C(A0)                   ; $0038
		bne     Offset_0x023A46
		move.w  #$0000, Obj_Speed(A0)                            ; $0010
		move.w  #$0000, Obj_Speed_Y(A0)                          ; $0012
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		btst    #$02, Obj_Control_Var_02(A0)                     ; $002E
		beq.s   Offset_0x023BCA
		bclr    #$00, Obj_Control_Var_02(A0)                     ; $002E
		bra     Offset_0x023A46
Offset_0x023BCA:
		bset    #$00, Obj_Control_Var_02(A0)                     ; $002E
		bra     Offset_0x023A46  
;------------------------------------------------------------------------------- 
Offset_0x023BD4:
		btst    #$00, Obj_Control_Var_02(A0)                     ; $002E
		beq.s   Offset_0x023BE0
		bra     Offset_0x023A46
Offset_0x023BE0:
		addq.b  #$02, Obj_Routine_2(A0)                          ; $0025
		bra     Offset_0x023A46    
;------------------------------------------------------------------------------- 
Offset_0x023BE8:
		move.w  (Player_One_Position_X).w, D0                ; $FFFFB008
		addi.w  #$004C, D0
		cmp.w   Obj_Control_Var_04(A0), D0                       ; $0030
		bgt.s   Offset_0x023C16
		beq     Offset_0x023A46
		subi.l  #$00008000, Obj_Control_Var_04(A0)               ; $0030
		cmpi.w  #$0558, Obj_Control_Var_04(A0)                   ; $0030
		bgt     Offset_0x023A46
		move.w  #$0558, Obj_Control_Var_04(A0)                   ; $0030
		bra     Offset_0x023A46
Offset_0x023C16:
		addi.l  #$00008000, Obj_Control_Var_04(A0)               ; $0030
		cmpi.w  #$07C0, Obj_Control_Var_04(A0)                   ; $0030
		blt     Offset_0x023A46
		move.w  #$07C0, Obj_Control_Var_04(A0)                   ; $0030
		bra     Offset_0x023A46         
;-------------------------------------------------------------------------------  
Offset_0x023C32:
		dc.w    Offset_0x023C68-Offset_0x023C32
		dc.w    Offset_0x023C6B-Offset_0x023C32
		dc.w    Offset_0x023C6E-Offset_0x023C32
		dc.w    Offset_0x023C73-Offset_0x023C32
		dc.w    Offset_0x023C77-Offset_0x023C32
		dc.w    Offset_0x023C7E-Offset_0x023C32
		dc.w    Offset_0x023C81-Offset_0x023C32
		dc.w    Offset_0x023C84-Offset_0x023C32
		dc.w    Offset_0x023C87-Offset_0x023C32
		dc.w    Offset_0x023C8A-Offset_0x023C32
		dc.w    Offset_0x023C8D-Offset_0x023C32
		dc.w    Offset_0x023C99-Offset_0x023C32
		dc.w    Offset_0x023CA4-Offset_0x023C32
		dc.w    Offset_0x023CA7-Offset_0x023C32
		dc.w    Offset_0x023CAA-Offset_0x023C32
		dc.w    Offset_0x023CAD-Offset_0x023C32
		dc.w    Offset_0x023CB0-Offset_0x023C32
		dc.w    Offset_0x023CB3-Offset_0x023C32
		dc.w    Offset_0x023CB6-Offset_0x023C32
		dc.w    Offset_0x023CB9-Offset_0x023C32
		dc.w    Offset_0x023CBC-Offset_0x023C32
		dc.w    Offset_0x023CBF-Offset_0x023C32
		dc.w    Offset_0x023CC2-Offset_0x023C32
		dc.w    Offset_0x023CC5-Offset_0x023C32
		dc.w    Offset_0x023CC8-Offset_0x023C32
		dc.w    Offset_0x023CCB-Offset_0x023C32
		dc.w    Offset_0x023CCF-Offset_0x023C32
Offset_0x023C68:
		dc.b    $0F, $00, $FF
Offset_0x023C6B:
		dc.b    $0F, $01, $FF
Offset_0x023C6E:
		dc.b    $05, $02, $03, $02, $FF
Offset_0x023C73:
		dc.b    $05, $02, $03, $FF
Offset_0x023C77:
		dc.b    $02, $04, $05, $06, $07, $08, $FF
Offset_0x023C7E:
		dc.b    $03, $09, $FF
Offset_0x023C81:
		dc.b    $0F, $0A, $FF
Offset_0x023C84:
		dc.b    $0F, $1C, $FF
Offset_0x023C87:
		dc.b    $0F, $1E, $FF
Offset_0x023C8A:
		dc.b    $0F, $0B, $FF
Offset_0x023C8D:
		dc.b    $03, $0C, $0C, $0D, $0D, $0D, $0D, $0D
		dc.b    $0C, $0C, $FD, $09
Offset_0x023C99:
		dc.b    $03, $0E, $0E, $0F, $0F, $0F, $0F, $0F
		dc.b    $0E, $0E, $FF
Offset_0x023CA4:
		dc.b    $0F, $10, $FF
Offset_0x023CA7:
		dc.b    $0F, $11, $FF
Offset_0x023CAA:
		dc.b    $0F, $12, $FF
Offset_0x023CAD:
		dc.b    $0F, $13, $FF
Offset_0x023CB0:
		dc.b    $0F, $14, $FF
Offset_0x023CB3:
		dc.b    $0F, $15, $FF
Offset_0x023CB6:
		dc.b    $0F, $16, $FF
Offset_0x023CB9:
		dc.b    $0F, $17, $FF
Offset_0x023CBC:
		dc.b    $0F, $18, $FF
Offset_0x023CBF:
		dc.b    $0F, $19, $FF
Offset_0x023CC2:
		dc.b    $0F, $1A, $FF
Offset_0x023CC5:
		dc.b    $0F, $1B, $FF
Offset_0x023CC8:
		dc.b    $0F, $1C, $FF
Offset_0x023CCB:
		dc.b    $01, $1D, $1F, $FF
Offset_0x023CCF:
		dc.b    $0F, $1E, $FF
;-------------------------------------------------------------------------------
Offset_0x023CD2:
		dc.w    Offset_0x023D22-Offset_0x023CD2
		dc.w    Offset_0x023D3C-Offset_0x023CD2
		dc.w    Offset_0x023D46-Offset_0x023CD2
		dc.w    Offset_0x023D50-Offset_0x023CD2
		dc.w    Offset_0x023D5A-Offset_0x023CD2
		dc.w    Offset_0x023D64-Offset_0x023CD2
		dc.w    Offset_0x023D6E-Offset_0x023CD2
		dc.w    Offset_0x023D78-Offset_0x023CD2
		dc.w    Offset_0x023D82-Offset_0x023CD2
		dc.w    Offset_0x023D8C-Offset_0x023CD2
		dc.w    Offset_0x023D96-Offset_0x023CD2
		dc.w    Offset_0x023DA8-Offset_0x023CD2
		dc.w    Offset_0x023DB2-Offset_0x023CD2
		dc.w    Offset_0x023DBC-Offset_0x023CD2
		dc.w    Offset_0x023DC6-Offset_0x023CD2
		dc.w    Offset_0x023DD0-Offset_0x023CD2
		dc.w    Offset_0x023DDA-Offset_0x023CD2
		dc.w    Offset_0x023DE4-Offset_0x023CD2
		dc.w    Offset_0x023DEE-Offset_0x023CD2
		dc.w    Offset_0x023DF8-Offset_0x023CD2
		dc.w    Offset_0x023E02-Offset_0x023CD2
		dc.w    Offset_0x023E14-Offset_0x023CD2
		dc.w    Offset_0x023E26-Offset_0x023CD2
		dc.w    Offset_0x023E38-Offset_0x023CD2
		dc.w    Offset_0x023E4A-Offset_0x023CD2
		dc.w    Offset_0x023E64-Offset_0x023CD2
		dc.w    Offset_0x023E7E-Offset_0x023CD2
		dc.w    Offset_0x023E98-Offset_0x023CD2
		dc.w    Offset_0x023EB2-Offset_0x023CD2
		dc.w    Offset_0x023ECC-Offset_0x023CD2
		dc.w    Offset_0x023ED6-Offset_0x023CD2
		dc.w    Offset_0x023EF8-Offset_0x023CD2
		dc.w    Offset_0x023F02-Offset_0x023CD2
		dc.w    Offset_0x023F0C-Offset_0x023CD2
		dc.w    Offset_0x023F16-Offset_0x023CD2
		dc.w    Offset_0x023F20-Offset_0x023CD2
		dc.w    Offset_0x023F2A-Offset_0x023CD2
		dc.w    Offset_0x023F34-Offset_0x023CD2
		dc.w    Offset_0x023F3E-Offset_0x023CD2
		dc.w    Offset_0x023F48-Offset_0x023CD2
Offset_0x023D22:
		dc.w    $0003
		dc.l    $B80D0000, $0000FFF8
		dc.l    $C80A0008, $00040008
		dc.l    $E0050011, $00080010
Offset_0x023D3C:
		dc.w    $0001
		dc.l    $FC000024, $0012FFFC
Offset_0x023D46:
		dc.w    $0001
		dc.l    $FC040025, $0012FFF5
Offset_0x023D50:
		dc.w    $0001
		dc.l    $FC040027, $0013FFF6
Offset_0x023D5A:
		dc.w    $0001
		dc.l    $C4000036, $001BFFFB
Offset_0x023D64:
		dc.w    $0001
		dc.l    $C4000037, $001BFFFB
Offset_0x023D6E:
		dc.w    $0001
		dc.l    $C4000038, $001CFFFB
Offset_0x023D78:
		dc.w    $0001
		dc.l    $C4010039, $001CFFFB
Offset_0x023D82:
		dc.w    $0001
		dc.l    $C401003B, $001DFFFB
Offset_0x023D8C:
		dc.w    $0001
		dc.l    $FC00003D, $001EFFFC
Offset_0x023D96:
		dc.w    $0002
		dc.l    $000E0015, $000A0000
		dc.l    $08080021, $00100018
Offset_0x023DA8:
		dc.w    $0001
		dc.l    $18080029, $00140000
Offset_0x023DB2:
		dc.w    $0001
		dc.l    $1808002C, $00160000
Offset_0x023DBC:
		dc.w    $0001
		dc.l    $1808002F, $00170008
Offset_0x023DC6:
		dc.w    $0001
		dc.l    $18040032, $0019FFFC
Offset_0x023DD0:
		dc.w    $0001
		dc.l    $18040034, $001AFFFC
Offset_0x023DDA:
		dc.w    $0001
		dc.l    $10080063, $00310000
Offset_0x023DE4:
		dc.w    $0001
		dc.l    $10080066, $00330000
Offset_0x023DEE:
		dc.w    $0001
		dc.l    $10080069, $00340000
Offset_0x023DF8:
		dc.w    $0001
		dc.l    $1008006C, $00360000
Offset_0x023E02:
		dc.w    $0002
		dc.l    $1008006C, $00360000
		dc.l    $08080063, $00310000
Offset_0x023E14:
		dc.w    $0002
		dc.l    $1008006C, $00360000
		dc.l    $08080066, $00330000
Offset_0x023E26:
		dc.w    $0002
		dc.l    $1008006C, $00360000
		dc.l    $08080069, $00340000
Offset_0x023E38:
		dc.w    $0002
		dc.l    $1008006C, $00360000
		dc.l    $0808006C, $00360000
Offset_0x023E4A:
		dc.w    $0003
		dc.l    $1008006C, $00360000
		dc.l    $0808006C, $00360000
		dc.l    $00080063, $00310000
Offset_0x023E64:
		dc.w    $0003
		dc.l    $1008006C, $00360000
		dc.l    $0808006C, $00360000
		dc.l    $00080066, $00330000
Offset_0x023E7E:
		dc.w    $0003
		dc.l    $1008006C, $00360000
		dc.l    $0808006C, $00360000
		dc.l    $00080069, $00340000
Offset_0x023E98:
		dc.w    $0003
		dc.l    $1008006C, $00360000
		dc.l    $0808006C, $00360000
		dc.l    $0008006C, $00360000
Offset_0x023EB2:
		dc.w    $0003
		dc.l    $000E0015, $000A0000
		dc.l    $08080021, $00100018
		dc.l    $08080021, $00100030
Offset_0x023ECC:
		dc.w    $0001
		dc.l    $000B003E, $001F0000
Offset_0x023ED6:
		dc.w    $0004
		dc.l    $000E0015, $000A0000
		dc.l    $08080021, $00100018
		dc.l    $08080021, $00100030
		dc.l    $08080021, $00100048
Offset_0x023EF8:
		dc.w    $0001
		dc.l    $000B083E, $081F0000
Offset_0x023F02:
		dc.w    $0001
		dc.l    $000E0015, $000A0000
Offset_0x023F0C:
		dc.w    $0001
		dc.l    $00080021, $00100000
Offset_0x023F16:
		dc.w    $0001
		dc.l    $B80D0000, $0000FFF8
Offset_0x023F20:
		dc.w    $0001
		dc.l    $C80A0008, $00040008
Offset_0x023F2A:
		dc.w    $0001
		dc.l    $E0050011, $00080010
Offset_0x023F34:
		dc.w    $0001
		dc.l    $E00A004A, $0025FFF0
Offset_0x023F3E:
		dc.w    $0001
		dc.l    $E80D0053, $0029FFF0
Offset_0x023F48:
		dc.w    $0001
		dc.l    $E80D005B, $002DFFF0   
;===============================================================================
; Rotinas referenciadas pelo Chefe na Green Hill
; <<<-
;===============================================================================                  
		dc.w    $0000
Jmp_18_To_DisplaySprite:                                       ; Offset_0x023F54
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_1C_To_DeleteObject:                                        ; Offset_0x023F5A
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_23_To_MarkObjGone:                                         ; Offset_0x023F60
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_01_To_AddPoints:                                           ; Offset_0x023F66
		jmp     (AddPoints)                            ; Offset_0x02D2D4
Jmp_0A_To_ObjectFall:                                          ; Offset_0x023F6C
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_15_To_SpeedToPos:                                          ; Offset_0x023F72
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA         
;-------------------------------------------------------------------------------
Obj_0x4B_Buzzer:                                               ; Offset_0x023F78
		include 'objects/obj_0x4B.asm'                                   
;-------------------------------------------------------------------------------   
		dc.w    $0000
Jmp_1D_To_DeleteObject:                                        ; Offset_0x024268
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_13_To_SingleObjectLoad_2:                                  ; Offset_0x02426E
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_12_To_AnimateSprite:                                       ; Offset_0x024274
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_06_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x02427A
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_01_To_MarkObjGone_4:                                       ; Offset_0x024280
		jmp     (MarkObjGone_4)                        ; Offset_0x00D2A0
Jmp_2B_To_ModifySpriteAttr_2P:                                 ; Offset_0x024286
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_16_To_SpeedToPos:                                          ; Offset_0x02428C
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000             
;-------------------------------------------------------------------------------                                 
Obj_0x5C_Masher:                                               ; Offset_0x024294
		include 'objects/obj_0x5C.asm' 
;-------------------------------------------------------------------------------
		dc.w    $0000                                               
Jmp_24_To_MarkObjGone:                                         ; Offset_0x02437C
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_13_To_AnimateSprite:                                       ; Offset_0x024382
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_2C_To_ModifySpriteAttr_2P:                                 ; Offset_0x024388
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_17_To_SpeedToPos:                                          ; Offset_0x02438E
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA   
;-------------------------------------------------------------------------------
Obj_0x5D:                                                      ; Offset_0x024394
		include 'objects/obj_0x5D.asm'                           
;-------------------------------------------------------------------------------   
		nop
Jmp_19_To_DisplaySprite:                                       ; Offset_0x025834
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_1E_To_DeleteObject:                                        ; Offset_0x02583A
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_07_To_ModifySpriteAttr_2P_A1:                              ; Offset_0x025840
		jmp     (ModifySpriteAttr_2P_A1)               ; Offset_0x00DBDA
Jmp_02_To_AddPoints:                                           ; Offset_0x025846
		jmp     (AddPoints)                            ; Offset_0x02D2D4
Jmp_2D_To_ModifySpriteAttr_2P:                                 ; Offset_0x02584C
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_0B_To_ObjectFall:                                          ; Offset_0x025852
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_18_To_SpeedToPos:                                          ; Offset_0x025858
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA
		dc.w    $0000                     
;-------------------------------------------------------------------------------   
Obj_0x52_HTz_Boss:                                             ; Offset_0x025860
		include 'objects/obj_0x52.asm'                       
;-------------------------------------------------------------------------------  
		dc.w    $0000                                          
Jmp_1A_To_DisplaySprite:                                       ; Offset_0x025FB0
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_1F_To_DeleteObject:                                        ; Offset_0x025FB6
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0B_To_SingleObjectLoad:                                    ; Offset_0x025FBC
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_25_To_MarkObjGone:                                         ; Offset_0x025FC2
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_14_To_AnimateSprite:                                       ; Offset_0x025FC8
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_05_To_ObjHitFloor:                                         ; Offset_0x025FCE
		jmp     (ObjHitFloor)                          ; Offset_0x014204
Jmp_00_To_Obj_0x20_HTz_Boss_FireBall:                          ; Offset_0x025FD4
		jmp     (Obj_0x20_HTz_Boss_FireBall)           ; Offset_0x017E34
Jmp_2E_To_ModifySpriteAttr_2P:                                 ; Offset_0x025FDA
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE  
;------------------------------------------------------------------------------- 
Obj_0x89_NGHz_Boss:                                            ; Offset_0x025FE0  
		include 'objects/obj_0x89.asm'                       
;-------------------------------------------------------------------------------
Jmp_1B_To_DisplaySprite:                                       ; Offset_0x02696C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_20_To_DeleteObject:                                        ; Offset_0x026972
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0C_To_SingleObjectLoad:                                    ; Offset_0x026978
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_15_To_AnimateSprite:                                       ; Offset_0x02697E
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_02_To_PseudoRandomNumber:                                  ; Offset_0x026984
		jmp     (PseudoRandomNumber)                   ; Offset_0x00325C
Jmp_15_To_SolidObject:                                         ; Offset_0x02698A
		jmp     (SolidObject)                          ; Offset_0x00F344                
;------------------------------------------------------------------------------- 
Obj_0x57_DHz_Boss:                                             ; Offset_0x026990
		include 'objects/obj_0x57.asm'                                          
;-------------------------------------------------------------------------------   
Jmp_1C_To_DisplaySprite:                                       ; Offset_0x0271AC
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_21_To_DeleteObject:                                        ; Offset_0x0271B2
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0D_To_SingleObjectLoad:                                    ; Offset_0x0271B8
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_03_To_PseudoRandomNumber:                                  ; Offset_0x0271BE
		jmp     (PseudoRandomNumber)                   ; Offset_0x00325C
Jmp_0C_To_ObjectFall:                                          ; Offset_0x0271C4
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
		dc.w    $0000       
;-------------------------------------------------------------------------------   
Obj_0x51_CNz_Boss:                                             ; Offset_0x0271CC
		include 'objects/obj_0x51.asm'  
;-------------------------------------------------------------------------------
		dc.w    $0000                            
Jmp_1D_To_DisplaySprite:                                       ; Offset_0x027A78
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_22_To_DeleteObject:                                        ; Offset_0x027A7E
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_0E_To_SingleObjectLoad:                                    ; Offset_0x027A84
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_04_To_PseudoRandomNumber:                                  ; Offset_0x027A8A
		jmp     (PseudoRandomNumber)                   ; Offset_0x00325C    
;-------------------------------------------------------------------------------    
Obj_0x54_Mz_Boss:                                              ; Offset_0x027A90
Obj_0x55_Mz_Boss:                                              ; Offset_0x027A90
		include 'objects/obj_0x54.asm'  
Obj_0x53_Mz_Boss_Balls_Robotniks:                              ; Offset_0x027B80
		include 'objects/obj_0x53.asm'             
;-------------------------------------------------------------------------------
		dc.w    $0000                                         
Jmp_1E_To_DisplaySprite:                                       ; Offset_0x027E8C
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_0F_To_SingleObjectLoad:                                    ; Offset_0x027E92
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_16_To_AnimateSprite:                                       ; Offset_0x027E98
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_0D_To_ObjectFall:                                          ; Offset_0x027E9E
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
;-------------------------------------------------------------------------------
; Rotina usada para inicializar o parâmetro de alguns objetos
; ->>>
;-------------------------------------------------------------------------------
Object_Settings:                                               ; Offset_0x027EA4
		moveq   #$00, D0
		move.b  Obj_Subtype(A0), D0                              ; $0028
		move.w  ObjSet_List(PC, D0), D0                ; Offset_0x027ED6
		lea     ObjSet_List(PC, D0), A1                ; Offset_0x027ED6
		move.l  (A1)+, Obj_Map(A0)                               ; $0004
		move.w  (A1)+, Obj_Art_VRAM(A0)                          ; $0002
		bsr     Jmp_2F_To_ModifySpriteAttr_2P          ; Offset_0x02A7B2
		move.b  (A1)+, D0
		or.b    D0, Obj_Flags(A0)                                ; $0001
		move.b  (A1)+, Obj_Priority(A0)                          ; $0018
		move.b  (A1)+, Obj_Width(A0)                             ; $0019
		move.b  (A1), Obj_Col_Flags(A0)                          ; $0020
		addq.b  #$02, Obj_Routine(A0)                            ; $0024
		rts    
;-------------------------------------------------------------------------------                
ObjSet_List:                                                   ; Offset_0x027ED6  
		dc.w    Obj_0x8C_Ptr-ObjSet_List               ; Offset_0x028068
		dc.w    Obj_0x8E_Ptr-ObjSet_List               ; Offset_0x0282D4
		dc.w    Obj_0x8F_Ptr-ObjSet_List               ; Offset_0x0282DE
		dc.w    Obj_0x90_Ptr-ObjSet_List               ; Offset_0x0282E8
		dc.w    Obj_0x91_Ptr-ObjSet_List               ; Offset_0x0284F6
		dc.w    Obj_0x92_Ptr-ObjSet_List               ; Offset_0x028678
		dc.w    Obj_0x96_Rexon_Body-ObjSet_List        ; Offset_0x02891E
		dc.w    Obj_0x96_Ptr-ObjSet_List               ; Offset_0x028C6A
		dc.w    Rexon_Fireball_Map_Ptr-ObjSet_List     ; Offset_0x028D52
		dc.w    Obj_0x99_Ptr-ObjSet_List               ; Offset_0x028E5A
		dc.w    Nebula_Bomb_Map_Ptr-ObjSet_List        ; Offset_0x028D5C
		dc.w    Obj_0x9A_Ptr-ObjSet_List               ; Offset_0x029110
		dc.w    Obj_0x9B_Ptr-ObjSet_List               ; Offset_0x02911A
		dc.w    Obj_0x9C_Ptr-ObjSet_List               ; Offset_0x029124
		dc.w    Turtloid_Bullet_Map_Ptr-ObjSet_List    ; Offset_0x028D66
		dc.w    Obj_0x9D_Ptr-ObjSet_List               ; Offset_0x02935C
		dc.w    Coconuts_Coconut_Map_Ptr-ObjSet_List   ; Offset_0x028D70
		dc.w    Obj_0x9E_Ptr-ObjSet_List               ; Offset_0x02958E
		dc.w    Offset_0x029842-ObjSet_List
		dc.w    Offset_0x02984C-ObjSet_List
		dc.w    Obj_0xA1_Ptr-ObjSet_List               ; Offset_0x029AB6
		dc.w    Obj_0xA2_Ptr-ObjSet_List               ; Offset_0x029AC0
		dc.w    Offset_0x029D76-ObjSet_List
		dc.w    Obj_0xA4_Ptr-ObjSet_List               ; Offset_0x029FA0
		dc.w    Asteron_Spikes_Map_Ptr-ObjSet_List     ; Offset_0x028D7A
		dc.w    Obj_0xA5_Ptr-ObjSet_List               ; Offset_0x02A1C8
		dc.w    Spiny_Shot_Map_Ptr-ObjSet_List         ; Offset_0x028D84
		dc.w    Obj_0xA7_Ptr-ObjSet_List               ; Offset_0x02A356
		dc.w    Obj_0xA8_Ptr-ObjSet_List               ; Offset_0x02A360
		dc.w    Obj_0xA9_Ptr-ObjSet_List               ; Offset_0x02A36A
		dc.w    Grabber_Unk_Map_Ptr-ObjSet_List        ; Offset_0x028D8E
		dc.w    Obj_0xAC_Ptr-ObjSet_List               ; Offset_0x02A424
		dc.w    Obj_0xAD_Ptr-ObjSet_List               ; Offset_0x02A5DE
		dc.w    Obj_0xAE_Ptr-ObjSet_List               ; Offset_0x02A5E8
		dc.w    Clucker_Bullet_Map_Ptr-ObjSet_List     ; Offset_0x028D98
;-------------------------------------------------------------------------------
Object_Check_Player_Position:                                  ; Offset_0x027F1C
		moveq   #$00, D0
		moveq   #$00, D1
		lea     (Player_One).w, A1                           ; $FFFFB000
		move.w  Obj_X(A0), D2                                    ; $0008
		sub.w   Obj_X(A1), D2                                    ; $0008
		bcc.s   Offset_0x027F30
		addq.w  #$02, D0
Offset_0x027F30:
		move.w  Obj_Y(A0), D3                                    ; $000C
		sub.w   Obj_Y(A1), D3                                    ; $000C
		bcc.s   Offset_0x027F3C
		addq.w  #$02, D1
Offset_0x027F3C:
		rts        
;-------------------------------------------------------------------------------
Offset_0x027F3E:
		move.w  Obj_Speed(A0), D2                                ; $0010
		bpl.s   Offset_0x027F50
		neg.w   D0
		cmp.w   D0, D2
		bcc.s   Offset_0x027F56
		move.w  D0, D2
		bra     Offset_0x027F56
Offset_0x027F50:
		cmp.w   D0, D2
		bls.s   Offset_0x027F56
		move.w  D0, D2
Offset_0x027F56:
		move.w  Obj_Speed_Y(A0), D3                              ; $0012
		bpl.s   Offset_0x027F68
		neg.w   D1
		cmp.w   D1, D3
		bcc.s   Offset_0x027F6E
		move.w  D1, D3
		bra     Offset_0x027F6E
Offset_0x027F68:
		cmp.w   D1, D3
		bls.s   Offset_0x027F6E
		move.w  D1, D3
Offset_0x027F6E:
		move.w  D2, Obj_Speed(A0)                                ; $0010
		move.w  D3, Obj_Speed_Y(A0)                              ; $0012
		rts                                                              
;-------------------------------------------------------------------------------   
Offset_0x027F78:
		moveq   #$00, D0
		move.w  D0, Obj_Speed(A0)                                ; $0010
		move.w  D0, Obj_Speed_Y(A0)                              ; $0012
		rts
;-------------------------------------------------------------------------------
; Rotina usada para inicializar o parâmetro de alguns objetos
; <<<-
;-------------------------------------------------------------------------------
Obj_0x8C_NGHz_Whisp:                                           ; Offset_0x027F84
		include 'objects/obj_0x8C.asm'  
Obj_0x8D_Hidden_Grounder:                                      ; Offset_0x0280A0
Obj_0x8E_Grounder:                                             ; Offset_0x0280A0 
		include 'objects/obj_0x8E.asm'
Obj_0x8F_Wall_Hidden_Grounder:                                 ; Offset_0x02819E
		include 'objects/obj_0x8F.asm' 
Obj_0x90_Rock_Hidden_Grounder:                                 ; Offset_0x0281E4   
		include 'objects/obj_0x90.asm'                               
Obj_0x91_Chop_Chop:                                            ; Offset_0x0283BC
		include 'objects/obj_0x91.asm'
Obj_0x92_Spiker:                                               ; Offset_0x02851E
		include 'objects/obj_0x92.asm'  
Obj_0x93_Spiker_Drill:                                         ; Offset_0x0285F8      
		include 'objects/obj_0x93.asm'
Obj_0x95_Sol:                                                  ; Offset_0x0286FA
		include 'objects/obj_0x95.asm'
Obj_0x94_Rexon_Body:                                           ; Offset_0x02891E
Obj_0x96_Rexon_Body:                                           ; Offset_0x02891E  
		include 'objects/obj_0x96.asm'
Obj_0x97_Rexon_Head:                                           ; Offset_0x0289CC  
		include 'objects/obj_0x97.asm' 
Obj_0x98_Enemies_Weapons:                                      ; Offset_0x028CE4  
		include 'objects/obj_0x98.asm' 
Obj_0x99_Nebula:                                               ; Offset_0x028DA2
		include 'objects/obj_0x99.asm' 
Obj_0x9A_Turtloid:                                             ; Offset_0x028F08
		include 'objects/obj_0x9A.asm'
Obj_0x9B_Turtloid_Rider:                                       ; Offset_0x028FE4
		include 'objects/obj_0x9B.asm'  
Obj_0x9C_Enemy_Boost:                                          ; Offset_0x029060 
		include 'objects/obj_0x9C.asm'  
Obj_0x9D_Coconuts:                                             ; Offset_0x0291D8
		include 'objects/obj_0x9D.asm' 
Obj_0x9E_Crawlton:                                             ; Offset_0x0293F4  
		include 'objects/obj_0x9E.asm'
Obj_0x9F_Shellcracker:                                         ; Offset_0x0295B2
		include 'objects/obj_0x9F.asm'      
Obj_0xA0_Shellcracker_Craw:                                    ; Offset_0x0296DE  
		include 'objects/obj_0xA0.asm' 
Obj_0xA1_Slicer:                                               ; Offset_0x029906 
		include 'objects/obj_0xA1.asm'  
Obj_0xA2_Slicer_Pincers:                                       ; Offset_0x0299CE
		include 'objects/obj_0xA2.asm' 
Obj_0xA3_Flasher:                                              ; Offset_0x029C34  
		include 'objects/obj_0xA3.asm' 
Obj_0xA4_Asteron:                                              ; Offset_0x029E94
		include 'objects/obj_0xA4.asm'
Obj_0xA5_Horizontal_Spiny:                                     ; Offset_0x02A004
		include 'objects/obj_0xA5.asm' 
Obj_0xA6_Vertical_Spiny:                                       ; Offset_0x02A0A0    
		include 'objects/obj_0xA6.asm' 
Obj_0xA7_Grabber:                                              ; Offset_0x02A2D4
		include 'objects/obj_0xA7.asm' 
Obj_0xA8_Grabber_Sub:                                          ; Offset_0x02A2EE
		include 'objects/obj_0xA8.asm' 
Obj_0xA9_Grabber_Sub:                                          ; Offset_0x02A308
		include 'objects/obj_0xA9.asm' 
Obj_0xAA_Grabber_Sub:                                          ; Offset_0x02A322
		include 'objects/obj_0xAA.asm' 
Obj_0xAB_Grabber_Sub:                                          ; Offset_0x02A33C   
		include 'objects/obj_0xAB.asm' 
Obj_0xAC_Balkiry:                                              ; Offset_0x02A3F4    
		include 'objects/obj_0xAC.asm' 
Obj_0xAD_Clucker_Platform:                                     ; Offset_0x02A47E  
		include 'objects/obj_0xAD.asm'  
Obj_0xAE_Clucker:                                              ; Offset_0x02A4D0
		include 'objects/obj_0xAE.asm'   
;------------------------------------------------------------------------------- 
Jmp_03_To_DisplaySprite_Param:                                 ; Offset_0x02A788
		jmp     (DisplaySprite_Param)                  ; Offset_0x00D35E
Jmp_1F_To_DisplaySprite:                                       ; Offset_0x02A78E
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Jmp_23_To_DeleteObject:                                        ; Offset_0x02A794
		jmp     (DeleteObject)                         ; Offset_0x00D314
Jmp_10_To_SingleObjectLoad:                                    ; Offset_0x02A79A
		jmp     (SingleObjectLoad)                     ; Offset_0x00E6FE
Jmp_26_To_MarkObjGone:                                         ; Offset_0x02A7A0
		jmp     (MarkObjGone)                          ; Offset_0x00D200
Jmp_14_To_SingleObjectLoad_2:                                  ; Offset_0x02A7A6
		jmp     (SingleObjectLoad_2)                   ; Offset_0x00E714
Jmp_17_To_AnimateSprite:                                       ; Offset_0x02A7AC
		jmp     (AnimateSprite)                        ; Offset_0x00D372
Jmp_2F_To_ModifySpriteAttr_2P:                                 ; Offset_0x02A7B2
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
Jmp_16_To_SolidObject:                                         ; Offset_0x02A7B8
		jmp     (SolidObject)                          ; Offset_0x00F344
Jmp_0E_To_ObjectFall:                                          ; Offset_0x02A7BE
		jmp     (ObjectFall)                           ; Offset_0x00D1AE
Jmp_19_To_SpeedToPos:                                          ; Offset_0x02A7C4
		jmp     (SpeedToPos)                           ; Offset_0x00D1DA 
		dc.w    $0000
;-------------------------------------------------------------------------------
Obj_0x8A_S1_Credits:                                           ; Offset_0x02A7CC  
		include 'objects/obj_0x8A.asm'   
;-------------------------------------------------------------------------------
		nop
Jmp_30_To_ModifySpriteAttr_2P:                                 ; Offset_0x02AEE0
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE  
		dc.w    $0000                 
;-------------------------------------------------------------------------------  
Obj_0x3E_Egg_Prison:                                           ; Offset_0x02AEE8
		include 'objects/obj_0x3E.asm'                             
;-------------------------------------------------------------------------------  
Jmp_31_To_ModifySpriteAttr_2P:                                 ; Offset_0x02B1E4
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE   
		dc.w    $0000                 
;===============================================================================
; Rotina usada para responder quando o jogador tocar em algum objeto
; ->>>
;===============================================================================  
TouchResponse:                                                 ; Offset_0x02B1EC
		nop
		bsr     Jmp_00_To_TouchRings                   ; Offset_0x02B732
		tst.b   (Boss_Flag).w                                ; $FFFFF7AA
		bne     Touch_Boss                             ; Offset_0x02B2DC
		move.w  Obj_X(A0), D2                                    ; $0008
		move.w  Obj_Y(A0), D3                                    ; $000C
		subi.w  #$0008, D2
		moveq   #$00, D5
		move.b  Obj_Height_2(A0), D5                             ; $0016
		subq.b  #$03, D5
		sub.w   D5, D3
		cmpi.b  #$4D, Obj_Map_Id(A0)                             ; $001A
		bne.s   Touch_NoDuck                           ; Offset_0x02B21E
		addi.w  #$000C, D3
		moveq   #$0A, D5
Touch_NoDuck:                                                  ; Offset_0x02B21E
		move.w  #$0010, D4
		add.w   D5, D5
		lea     ($FFFFB800).w, A1
		move.w  #$005F, D6
Touch_Loop:                                                    ; Offset_0x02B22C
		move.b  Obj_Col_Flags(A1), D0                            ; $0020
		bne     Touch_Height                           ; Offset_0x02B240
Touch_NextObject:                                              ; Offset_0x02B234
		lea     Obj_Size(A1), A1                                 ; $0040
		dbra    D6, Touch_Loop                         ; Offset_0x02B22C
		moveq   #$00, D0
		rts
;-------------------------------------------------------------------------------                
Touch_Height:                                                  ; Offset_0x02B240
		andi.w  #$003F, D0
		add.w   D0, D0
		lea     Touch_Sizes(PC, D0), A2                ; Offset_0x02B28C
		moveq   #$00, D1
		move.b  (A2)+, D1
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   D1, D0
		sub.w   D2, D0
		bcc.s   Offset_0x02B262
		add.w   D1, D1
		add.w   D1, D0
		bcs.s   Offset_0x02B268
		bra     Touch_NextObject                       ; Offset_0x02B234
Offset_0x02B262:
		cmp.w   D4, D0
		bhi     Touch_NextObject                       ; Offset_0x02B234
Offset_0x02B268:
		moveq   #$00, D1
		move.b  (A2)+, D1
		move.w  Obj_Y(A1), D0                                    ; $000C
		sub.w   D1, D0
		sub.w   D3, D0
		bcc.s   Offset_0x02B282
		add.w   D1, D1
		add.w   D1, D0
		bcs     Offset_0x02B366
		bra     Touch_NextObject                       ; Offset_0x02B234
Offset_0x02B282:
		cmp.w   D5, D0
		bhi     Touch_NextObject                       ; Offset_0x02B234
		bra     Offset_0x02B366
;-------------------------------------------------------------------------------
Touch_Sizes:                                                   ; Offset_0x02B28C
		dc.b    $04, $04, $14, $14, $0C, $14, $14, $0C
		dc.b    $04, $10, $0C, $12, $10, $10, $06, $06
		dc.b    $18, $0C, $0C, $10, $10, $0C, $08, $08
		dc.b    $14, $10, $14, $08, $0E, $0E, $18, $18
		dc.b    $28, $10, $10, $18, $08, $10, $20, $70
		dc.b    $40, $20, $80, $20, $20, $20, $08, $08
		dc.b    $04, $04, $20, $08, $0C, $0C, $08, $04
		dc.b    $18, $04, $28, $04, $04, $08, $04, $18
		dc.b    $04, $28, $04, $20, $18, $18, $0C, $18
		dc.b    $48, $08, $18, $28, $10, $04, $20, $02
;-------------------------------------------------------------------------------  
Touch_Boss:                                                    ; Offset_0x02B2DC
		lea     Touch_Sizes(PC), A3                    ; Offset_0x02B28C
		move.w  Obj_X(A0), D2                                    ; $0008
		move.w  Obj_Y(A0), D3                                    ; $000C
		subi.w  #$0008, D2
		moveq   #$00, D5
		move.b  Obj_Height_2(A0), D5                             ; $0016
		subq.b  #$03, D5
		sub.w   D5, D3
		cmpi.b  #$4D, Obj_Map_Id(A0)                             ; $001A
		bne.s   Touch_NoDuck_Boss                      ; Offset_0x02B304
		addi.w  #$000C, D3
		moveq   #$0A, D5
Touch_NoDuck_Boss:                                             ; Offset_0x02B304
		move.w  #$0010, D4
		add.w   D5, D5
		lea     ($FFFFB800).w, A1
		move.w  #$005F, D6
Offset_0x02B312:
		move.b  Obj_Col_Flags(A1), D0                            ; $0020
		bne.s   Offset_0x02B324
Offset_0x02B318:
		lea     Obj_Size(A1), A1                                 ; $0040
		dbra    D6, Offset_0x02B312
		moveq   #$00, D0
		rts
Offset_0x02B324:
		bsr     Offset_0x02B65C
		andi.w  #$003F, D0
		add.w   D0, D0
		lea     $00(A3, D0), A2
		moveq   #$00, D1
		move.b  (A2)+, D1
		move.w  Obj_X(A1), D0                                    ; $0008
		sub.w   D1, D0
		sub.w   D2, D0
		bcc.s   Offset_0x02B348
		add.w   D1, D1
		add.w   D1, D0
		bcs.s   Offset_0x02B34C
		bra.s   Offset_0x02B318
Offset_0x02B348:
		cmp.w   D4, D0
		bhi.s   Offset_0x02B318
Offset_0x02B34C:
		moveq   #$00, D1
		move.b  (A2)+, D1
		move.w  Obj_Y(A1), D0                                    ; $000C
		sub.w   D1, D0
		sub.w   D3, D0
		bcc.s   Offset_0x02B362
		add.w   D1, D1
		add.w   D1, D0
		bcs.s   Offset_0x02B366
		bra.s   Offset_0x02B318
Offset_0x02B362:
		cmp.w   D5, D0
		bhi.s   Offset_0x02B318
Offset_0x02B366:
		move.b  Obj_Col_Flags(A1), D1                            ; $0020
		andi.b  #$C0, D1
		beq     Offset_0x02B3E0
		cmpi.b  #$C0, D1
		beq     Touch_Special                          ; Offset_0x02B5D4
		tst.b   D1
		bmi     Offset_0x02B4CA
		move.b  Obj_Col_Flags(A1), D0                            ; $0020
		andi.b  #$3F, D0
		cmpi.b  #$06, D0
		beq.s   Offset_0x02B3A0
		cmpi.w  #$005A, Obj_P_Invunerblt_Time(A0)                ; $0030
		bcc     Offset_0x02B39E
		move.b  #$04, Obj_Routine(A1)                            ; $0024
Offset_0x02B39E:
		rts
Offset_0x02B3A0:
		tst.w   Obj_Speed_Y(A0)                                  ; $0012
		bpl.s   Offset_0x02B3CC
		move.w  Obj_Y(A0), D0                                    ; $000C
		subi.w  #$0010, D0
		cmp.w   Obj_Y(A1), D0                                    ; $000C
		bcs.s   Offset_0x02B3DE
		neg.w   Obj_Speed_Y(A0)                                  ; $0012
		move.w  #$FE80, Obj_Speed_Y(A1)                          ; $0012
		tst.b   Obj_Routine_2(A1)                                ; $0025
		bne.s   Offset_0x02B3DE
		move.b  #$04, Obj_Routine_2(A1)                          ; $0025
		rts
Offset_0x02B3CC:
		cmpi.b  #$02, Obj_Ani_Number(A0)                         ; $001C
		bne.s   Offset_0x02B3DE
		neg.w   Obj_Speed_Y(A0)                                  ; $0012
		move.b  #$04, Obj_Routine(A1)                            ; $0024
Offset_0x02B3DE:
		rts
Offset_0x02B3E0:
		tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
		bne.s   Offset_0x02B3F8
		cmpi.b  #$09, Obj_Ani_Number(A0)                         ; $001C
		beq.s   Offset_0x02B3F8
		cmpi.b  #$02, Obj_Ani_Number(A0)                         ; $001C
		bne     Offset_0x02B4CA
Offset_0x02B3F8:
		btst    #$06, Obj_Flags(A1)                              ; $0001
		beq.s   Offset_0x02B42A
		tst.b   Obj_P_Invcbility_Time(A1)                        ; $0032
		beq.s   Offset_0x02B428
		neg.w   Obj_Speed(A0)                                    ; $0010
		neg.w   Obj_Speed_Y(A0)                                  ; $0012
		cmpi.b  #$03, (Boss_Flag).w                          ; $FFFFF7AA
		beq.s   Offset_0x02B41E
		asr.w   Obj_Speed(A0)                                    ; $0010
		asr.w   Obj_Speed_Y(A0)                                  ; $0012
Offset_0x02B41E:
		move.b  #$00, Obj_Col_Flags(A1)                          ; $0020
		subq.b  #$01, Obj_P_Invcbility_Time(A1)                  ; $0032
Offset_0x02B428:
		rts
Offset_0x02B42A:
		tst.b   Obj_Col_Prop(A1)                                 ; $0021
		beq.s   Touch_KillEnemy                        ; Offset_0x02B454
		neg.w   Obj_Speed(A0)                                    ; $0010
		neg.w   Obj_Speed_Y(A0)                                  ; $0012
		asr.w   Obj_Speed(A0)                                    ; $0010
		asr.w   Obj_Speed_Y(A0)                                  ; $0012
		move.b  #$00, Obj_Col_Flags(A1)                          ; $0020
		subq.b  #$01, Obj_Col_Prop(A1)                           ; $0021
		bne.s   Offset_0x02B452
		bset    #$07, Obj_Status(A1)                             ; $0022
Offset_0x02B452:
		rts
;-------------------------------------------------------------------------------                
Touch_KillEnemy:                                               ; Offset_0x02B454
		bset    #$07, Obj_Status(A1)                             ; $0022
		moveq   #$00, D0
		move.w  ($FFFFF7D0).w, D0
		addq.w  #$02, ($FFFFF7D0).w
		cmpi.w  #$0006, D0
		bcs.s   Offset_0x02B46C
		moveq   #$06, D0
Offset_0x02B46C:
		move.w  D0, Obj_Player_Top_Solid(A1)                     ; $003E
		move.w  Enemy_Points(PC, D0), D0               ; Offset_0x02B4BC
		cmpi.w  #$0020, ($FFFFF7D0).w
		bcs.s   Offset_0x02B486
		move.w  #$03E8, D0
		move.w  #$000A, Obj_Player_Top_Solid(A1)                 ; $003E
Offset_0x02B486:
		bsr     AddPoints                              ; Offset_0x02D2D4
		move.b  #$27, Obj_Id(A1)                                 ; $0000
		move.b  #$00, Obj_Routine(A1)                            ; $0024
		tst.w   Obj_Speed_Y(A0)                                  ; $0012
		bmi.s   Offset_0x02B4AC
		move.w  Obj_Y(A0), D0                                    ; $000C
		cmp.w   Obj_Y(A1), D0                                    ; $000C
		bcc.s   Offset_0x02B4B4
		neg.w   Obj_Speed_Y(A0)                                  ; $0012
		rts
Offset_0x02B4AC:
		addi.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
		rts
Offset_0x02B4B4:
		subi.w  #$0100, Obj_Speed_Y(A0)                          ; $0012
		rts                                             
;-------------------------------------------------------------------------------  
Enemy_Points:                                                  ; Offset_0x02B4BC
		dc.w    $000A      ;  100
		dc.w    $0014      ;  200
		dc.w    $0032      ;  500
		dc.w    $0064      ; 1000   
;-------------------------------------------------------------------------------                  
Offset_0x02B4C4:
		bset    #$07, Obj_Status(A1)   
Offset_0x02B4CA:
		tst.b   (Invincibility_Flag).w                       ; $FFFFFE2D
		beq.s   Touch_Hurt                             ; Offset_0x02B4D4
Offset_0x02B4D0:
		moveq   #-$01, D0
		rts                      
;-------------------------------------------------------------------------------                 
Touch_Hurt:                                                    ; Offset_0x02B4D4
		nop
		tst.w   Obj_P_Invunerblt_Time(A0)                        ; $0030
		bne.s   Offset_0x02B4D0
		move.l  A1, A2            
;-------------------------------------------------------------------------------
Hurt_Player:                                                   ; Offset_0x02B4DE                          
		tst.b   (Shield_Flag).w                              ; $FFFFFE2C
		bne.s   Hurt_Shield                            ; Offset_0x02B506
		tst.w   (Ring_Count).w                               ; $FFFFFE20
		beq     Hurt_NoRings                           ; Offset_0x02B574
		jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
		bne.s   Hurt_Shield                            ; Offset_0x02B506
		move.b  #$37, Obj_Id(A1)                                 ; $0000
		move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
Hurt_Shield                                                    ; Offset_0x02B506
		move.b  #$00, (Shield_Flag).w                        ; $FFFFFE2C
		move.b  #$04, Obj_Routine(A0)                            ; $0024
		bsr     Jmp_00_To_Sonic_ResetOnFloor           ; Offset_0x02B72C
		bset    #$01, Obj_Status(A0)                             ; $0022
		move.w  #$FC00, Obj_Speed_Y(A0)                          ; $0012
		move.w  #$FE00, Obj_Speed(A0)                            ; $0010
		btst    #$06, Obj_Status(A0)                             ; $0022
		beq.s   Offset_0x02B53C
		move.w  #$FE00, Obj_Speed_Y(A0)                          ; $0012
		move.w  #$FF00, Obj_Speed(A0)                            ; $0010
Offset_0x02B53C:
		move.w  Obj_X(A0), D0                                    ; $0008
		cmp.w   Obj_X(A2), D0                                    ; $0008
		bcs.s   Offset_0x02B54A
		neg.w   Obj_Speed(A0)                                    ; $0010
Offset_0x02B54A:
		move.w  #$0000, Obj_Inertia(A0)                          ; $0014
		move.b  #$1A, Obj_Ani_Number(A0)                         ; $001C
		move.w  #$0078, Obj_P_Invunerblt_Time(A0)                ; $0030
		move.w  #$00A3, D0
		cmpi.b  #$36, (A2)
		bne.s   Offset_0x02B56A
		move.w  #$00A6, D0
Offset_0x02B56A:
		jsr     (Play_Sfx)                             ; Offset_0x001512
		moveq   #-$01, D0
		rts
;-------------------------------------------------------------------------------                
Hurt_NoRings:                                                  ; Offset_0x02B574
		tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
		bne     Hurt_Shield                            ; Offset_0x02B506
Kill_Player:                                                   ; Offset_0x02B57C                
		tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
		bne.s   Kill_NoDeath                           ; Offset_0x02B5D0
		move.b  #$00, (Invincibility_Flag).w                 ; $FFFFFE2D
		move.b  #$06, Obj_Routine(A0)                            ; $0024
		bsr     Jmp_00_To_Sonic_ResetOnFloor           ; Offset_0x02B72C
		bset    #$01, Obj_Status(A0)                             ; $0022
		move.w  #$F900, Obj_Speed_Y(A0)                          ; $0012
		move.w  #$0000, Obj_Speed(A0)                            ; $0010
		move.w  #$0000, Obj_Inertia(A0)                          ; $0014
		move.w  Obj_Y(A0), Obj_Player_St_Convex(A0)       ; $000C, $0038
		move.b  #$18, Obj_Ani_Number(A0)                         ; $001C
		bset    #$07, Obj_Art_VRAM(A0)                           ; $0002
		move.w  #$00A3, D0
		cmpi.b  #$36, (A2)
		bne.s   Offset_0x02B5CA
		move.w  #$00A6, D0
Offset_0x02B5CA:
		jsr     (Play_Sfx)                             ; Offset_0x001512
Kill_NoDeath:                                                  ; Offset_0x02B5D0
		moveq   #-$01, D0
		rts                      
;-------------------------------------------------------------------------------                
Touch_Special:                                                 ; Offset_0x02B5D4:
		move.b  Obj_Col_Flags(A1), D1                            ; $0020
		andi.b  #$3F, D1
		cmpi.b  #$06, D1
		beq.s   Offset_0x02B644
		cmpi.b  #$0B, D1
		beq.s   Offset_0x02B60E
		cmpi.b  #$0C, D1
		beq.s   Offset_0x02B612
		cmpi.b  #$14, D1
		beq.s   Offset_0x02B644
		cmpi.b  #$15, D1
		beq.s   Offset_0x02B644
		cmpi.b  #$16, D1
		beq.s   Offset_0x02B644
		cmpi.b  #$17, D1
		beq.s   Offset_0x02B644
		cmpi.b  #$21, D1
		beq.s   Offset_0x02B656
		rts
Offset_0x02B60E:
		bra     Offset_0x02B4C4
Offset_0x02B612:
		sub.w   D0, D5
		cmpi.w  #$0008, D5
		bcc.s   Offset_0x02B640
		move.w  Obj_X(A1), D0                                    ; $0008
		subq.w  #$04, D0
		btst    #$00, Obj_Status(A1)                             ; $0022
		beq.s   Offset_0x02B62C
		subi.w  #$0010, D0
Offset_0x02B62C:
		sub.w   D2, D0
		bcc.s   Offset_0x02B638
		addi.w  #$0018, D0
		bcs.s   Offset_0x02B63C
		bra.s   Offset_0x02B640
Offset_0x02B638:
		cmp.w   D4, D0
		bhi.s   Offset_0x02B640
Offset_0x02B63C:
		bra     Offset_0x02B4CA
Offset_0x02B640:
		bra     Offset_0x02B3E0
Offset_0x02B644:
		move.w  A0, D1
		subi.w  #Obj_Memory_Address, D1                          ; $B000
		beq.s   Offset_0x02B650
		addq.b  #$01, Obj_Col_Prop(A1)                           ; $0021
Offset_0x02B650:
		addq.b  #$01, Obj_Col_Prop(A1)                           ; $0021
		rts
Offset_0x02B656:
		addq.b  #$01, Obj_Col_Prop(A1)                           ; $0021
		rts                      
;------------------------------------------------------------------------------- 
Offset_0x02B65C:
		cmpi.b  #$0F, D0
		bne.s   Offset_0x02B676
		moveq   #$00, D0
		move.b  (Boss_Flag).w, D0                            ; $FFFFF7AA
		beq.s   Offset_0x02B676
		subq.w  #$01, D0
		add.w   D0, D0
		move.w  Offset_0x02B678(PC, D0), D0
		jmp     Offset_0x02B678(PC, D0)
Offset_0x02B676:
		rts  
;------------------------------------------------------------------------------- 
Offset_0x02B678:
		dc.w    Offset_0x02B688-Offset_0x02B678
		dc.w    Offset_0x02B688-Offset_0x02B678
		dc.w    Offset_0x02B68E-Offset_0x02B678
		dc.w    Offset_0x02B6F6-Offset_0x02B678
		dc.w    Offset_0x02B6F6-Offset_0x02B678
		dc.w    Offset_0x02B6F6-Offset_0x02B678
		dc.w    Offset_0x02B6F6-Offset_0x02B678
		dc.w    Offset_0x02B6F6-Offset_0x02B678 
;------------------------------------------------------------------------------- 
Offset_0x02B688:
		move.b  Obj_Col_Flags(A1), D0                            ; $0020
		rts         
;------------------------------------------------------------------------------- 
Offset_0x02B68E:
		tst.b   ($FFFFF73F).w
		bne.s   Offset_0x02B696
		rts
Offset_0x02B696:
		move.w  D7, -(A7)
		moveq   #$00, D1
		move.b  Obj_Ani_Boss_Frame(A1), D1                       ; $0015
		subq.b  #$02, D1
		cmpi.b  #$07, D1
		bgt.s   Offset_0x02B6D6
		move.w  D1, D7
		add.w   D7, D7
		move.w  Obj_X(A1), D0                                    ; $0008
		btst    #$00, Obj_Flags(A1)                              ; $0001
		beq.s   Offset_0x02B6BC
		add.w   Offset_0x02B6DE(PC, D7), D0
		bra.s   Offset_0x02B6C0
Offset_0x02B6BC:
		sub.w   Offset_0x02B6DE(PC, D7), D0
Offset_0x02B6C0:
		move.b  Offset_0x02B6EE(PC, D1), D1
		ori.l   #$00040000, D1
		move.w  Obj_Y(A1), D7                                    ; $000C
		subi.w  #$001C, D7
		bsr     Offset_0x02B6FC
Offset_0x02B6D6:
		move.w  (A7)+, D7
		move.b  Obj_Col_Flags(A1), D0                            ; $0020
		rts
;-------------------------------------------------------------------------------
Offset_0x02B6DE:
		dc.w    $001C, $0020, $0028, $0034, $003C, $0044, $0060, $0070 
;-------------------------------------------------------------------------------   
Offset_0x02B6EE:
		dc.b    $04, $04, $08, $0C, $14, $1C, $24, $08
;------------------------------------------------------------------------------- 
Offset_0x02B6F6:
		move.b  Obj_Col_Flags(A1), D0                            ; $0020
		rts
Offset_0x02B6FC:
		sub.w   D1, D0
		sub.w   D2, D0
		bcc.s   Offset_0x02B70A
		add.w   D1, D1
		add.w   D1, D0
		bcs.s   Offset_0x02B70E
Offset_0x02B708:
		rts
Offset_0x02B70A:
		cmp.w   D4, D0
		bhi.s   Offset_0x02B708
Offset_0x02B70E:
		swap.w  D1
		sub.w   D1, D7
		sub.w   D3, D7
		bcc.s   Offset_0x02B720
		add.w   D1, D1
		add.w   D1, D7
		bcs     Offset_0x02B4CA
		bra.s   Offset_0x02B708
Offset_0x02B720:
		cmp.w   D5, D7
		bhi     Offset_0x02B708
		bra     Offset_0x02B4CA    
;------------------------------------------------------------------------------- 
		nop                                                            
;------------------------------------------------------------------------------- 
Jmp_00_To_Sonic_ResetOnFloor:                                  ; Offset_0x02B72C
		jmp     (Sonic_ResetOnFloor)                   ; Offset_0x010A46
Jmp_00_To_TouchRings:                                          ; Offset_0x02B732
		jmp     (TouchRings)                           ; Offset_0x00DEFC                      
							      
;===============================================================================
; Rotina para mostrar o leiaute dos Estágios Especiais - Left over do Sonic 1
; ->>>
;===============================================================================  
Special_Stage_Show_Layout:                                     ; Offset_0x02B738   
		bsr     Offset_0x02B87A
		bsr     Offset_0x02BABA
		move.w  D5, -(A7)
		lea     (Level_Map_Buffer).w, A1                     ; $FFFF8000
		move.b  ($FFFFF750).w, D0
		andi.b  #$FC, D0
		jsr     (CalcSine)                             ; Offset_0x003282
		move.w  D0, D4
		move.w  D1, D5
		muls.w  #$0018, D4
		muls.w  #$0018, D5
		moveq   #$00, D2
		move.w  (Camera_X).w, D2                             ; $FFFFEE00
		divu.w  #$0018, D2
		swap.w  D2
		neg.w   D2
		addi.w  #$FF4C, D2
		moveq   #$00, D3
		move.w  (Camera_Y).w, D3                             ; $FFFFEE04
		divu.w  #$0018, D3
		swap.w  D3
		neg.w   D3
		addi.w  #$FF4C, D3
		move.w  #$000F, D7
Offset_0x02B788:
		movem.w D0-D2, -(A7)
		movem.w D0/D1, -(A7)
		neg.w   D0
		muls.w  D2, D1
		muls.w  D3, D0
		move.l  D0, D6
		add.l   D1, D6
		movem.w (A7)+, D0/D1
		muls.w  D2, D0
		muls.w  D3, D1
		add.l   D0, D1
		move.l  D6, D2
		move.w  #$000F, D6
Offset_0x02B7AA:
		move.l  D2, D0
		asr.l   #$08, D0
		move.w  D0, (A1)+
		move.l  D1, D0
		asr.l   #$08, D0
		move.w  D0, (A1)+
		add.l   D5, D2
		add.l   D4, D1
		dbra    D6, Offset_0x02B7AA
		movem.w (A7)+, D0-D2
		addi.w  #$0018, D3
		dbra    D7, Offset_0x02B788
		move.w  (A7)+, D5
		lea     (M68K_RAM_Start), A0                         ; $FFFF0000
		moveq   #$00, D0
		move.w  (Camera_Y).w, D0                             ; $FFFFEE04
		divu.w  #$0018, D0
		mulu.w  #$0080, D0
		adda.l  D0, A0
		moveq   #$00, D0
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		divu.w  #$0018, D0
		adda.w  D0, A0
		lea     (Level_Map_Buffer).w, A4                     ; $FFFF8000
		move.w  #$000F, D7
Offset_0x02B7F6:
		move.w  #$000F, D6
Offset_0x02B7FA:
		moveq   #$00, D0
		move.b  (A0)+, D0
		beq.s   Offset_0x02B852
		cmpi.b  #$4E, D0
		bhi.s   Offset_0x02B852
		move.w  (A4), D3
		addi.w  #$0120, D3
		cmpi.w  #$0070, D3
		bcs.s   Offset_0x02B852
		cmpi.w  #$01D0, D3
		bcc.s   Offset_0x02B852
		move.w  $0002(A4), D2
		addi.w  #$00F0, D2
		cmpi.w  #$0070, D2
		bcs.s   Offset_0x02B852
		cmpi.w  #$0170, D2
		bcc.s   Offset_0x02B852
		lea     (SS_Ram_Layout_Address), A5                  ; $FFFF4000
		lsl.w   #$03, D0
		lea     $00(A5, D0), A5
		move.l  (A5)+, A1
		move.w  (A5)+, D1
		add.w   D1, D1
		adda.w  $00(A1, D1), A1
		move.w  (A5)+, A3
		moveq   #$00, D1
		move.b  (A1)+, D1
		subq.b  #$01, D1
		bmi.s   Offset_0x02B852
		jsr     (Build_Sprite_Right)                   ; Offset_0x00D66E
Offset_0x02B852:
		addq.w  #$04, A4
		dbra    D6, Offset_0x02B7FA
		lea     $0070(A0), A0
		dbra    D7, Offset_0x02B7F6
		move.b  D5, ($FFFFF62C).w
		cmpi.b  #$50, D5
		beq.s   Offset_0x02B872
		move.l  #$00000000, (A2)
		rts
Offset_0x02B872:
		move.b  #$00, $FFFFFFFB(a2)
		rts
Offset_0x02B87A:
		lea     (SS_Ram_Layout_Address+$000C), A1            ; $FFFF400C
		moveq   #$00, D0
		move.b  ($FFFFF750).w, D0
		lsr.b   #$02, D0
		andi.w  #$000F, D0
		moveq   #$23, D1
Offset_0x02B88E:
		move.w  D0, (A1)
		addq.w  #$08, A1
		dbra    D1, Offset_0x02B88E
		lea     (SS_Ram_Layout_Address+$0005), A1            ; $FFFF4005
		subq.b  #$01, (Object_Frame_Buffer+$0002).w          ; $FFFFFEA2
		bpl.s   Offset_0x02B8B2
		move.b  #$07, (Object_Frame_Buffer+$0002).w          ; $FFFFFEA2
		addq.b  #$01, (Object_Frame_Buffer+$0003).w          ; $FFFFFEA3
		andi.b  #$03, (Object_Frame_Buffer+$0003).w          ; $FFFFFEA3
Offset_0x02B8B2:
		move.b  (Object_Frame_Buffer+$0003).w, $01D0(A1)     ; $FFFFFEA3
		subq.b  #$01, (Object_Frame_Buffer+$0004).w          ; $FFFFFEA4
		bpl.s   Offset_0x02B8CE
		move.b  #$07, (Object_Frame_Buffer+$0004).w          ; $FFFFFEA4
		addq.b  #$01, (Object_Frame_Buffer+$0005).w          ; $FFFFFEA5
		andi.b  #$01, (Object_Frame_Buffer+$0005).w          ; $FFFFFEA5
Offset_0x02B8CE:
		move.b  (Object_Frame_Buffer+$0005).w, D0            ; $FFFFFEA5
		move.b  D0, $0138(A1)
		move.b  D0, $0160(A1)
		move.b  D0, $0148(A1)
		move.b  D0, $0150(A1)
		move.b  D0, $01D8(A1)
		move.b  D0, $01E0(A1)
		move.b  D0, $01E8(A1)
		move.b  D0, $01F0(A1)
		move.b  D0, $01F8(A1)
		move.b  D0, $0200(A1)
		subq.b  #$01, (Object_Frame_Buffer+$0006).w          ; $FFFFFEA6
		bpl.s   Offset_0x02B910
		move.b  #$04, (Object_Frame_Buffer+$0006).w          ; $FFFFFEA6
		addq.b  #$01, (Object_Frame_Buffer+$0007).w          ; $FFFFFEA7
		andi.b  #$03, (Object_Frame_Buffer+$0007).w          ; $FFFFFEA7
Offset_0x02B910:
		move.b  (Object_Frame_Buffer+$0007).w, D0            ; $FFFFFEA7
		move.b  D0, $0168(A1)
		move.b  D0, $0170(A1)
		move.b  D0, $0178(A1)
		move.b  D0, $0180(A1)
		subq.b  #$01, (Object_Frame_Buffer).w                ; $FFFFFEA0
		bpl.s   Offset_0x02B93A
		move.b  #$07, (Object_Frame_Buffer).w                ; $FFFFFEA0
		subq.b  #$01, (Object_Frame_Buffer+$0001).w          ; $FFFFFEA1
		andi.b  #$07, (Object_Frame_Buffer+$0001).w          ; $FFFFFEA1
Offset_0x02B93A:
		lea     (SS_Ram_Layout_Address+$0016), A1            ; $FFFF4016
		lea     (SS_WaRiVramSet), A0                   ; Offset_0x02BA24
		moveq   #$00, D0
		move.b  (Object_Frame_Buffer+$0001).w, D0            ; $FFFFFEA1
		add.w   D0, D0
		lea     $00(A0, D0), A0
		move.w  (A0), (A1)
		move.w  $0002(A0), $0008(A1)
		move.w  $0004(A0), $0010(A1)
		move.w  $0006(A0), $0018(A1)
		move.w  $0008(A0), $0020(A1)
		move.w  $000A(A0), $0028(A1)
		move.w  $000C(A0), $0030(A1)
		move.w  $000E(A0), $0038(A1)
		adda.w  #$0020, A0
		adda.w  #$0048, A1
		move.w  (A0), (A1)
		move.w  $0002(A0), $0008(A1)
		move.w  $0004(A0), $0010(A1)
		move.w  $0006(A0), $0018(A1)
		move.w  $0008(A0), $0020(A1)
		move.w  $000A(A0), $0028(A1)
		move.w  $000C(A0), $0030(A1)
		move.w  $000E(A0), $0038(A1)
		adda.w  #$0020, A0
		adda.w  #$0048, A1
		move.w  (A0), (A1)
		move.w  $0002(A0), $0008(A1)
		move.w  $0004(A0), $0010(A1)
		move.w  $0006(A0), $0018(A1)
		move.w  $0008(A0), $0020(A1)
		move.w  $000A(A0), $0028(A1)
		move.w  $000C(A0), $0030(A1)
		move.w  $000E(A0), $0038(A1)
		adda.w  #$0020, A0
		adda.w  #$0048, A1
		move.w  (A0), (A1)
		move.w  $0002(A0), $0008(A1)
		move.w  $0004(A0), $0010(A1)
		move.w  $0006(A0), $0018(A1)
		move.w  $0008(A0), $0020(A1)
		move.w  $000A(A0), $0028(A1)
		move.w  $000C(A0), $0030(A1)
		move.w  $000E(A0), $0038(A1)
		adda.w  #$0020, A0
		adda.w  #$0048, A1
		rts 
;-------------------------------------------------------------------------------                
SS_WaRiVramSet:                                                ; Offset_0x02BA24
		dc.w    $0142, $6142, $0142, $0142, $0142, $0142, $0142, $6142
		dc.w    $0142, $6142, $0142, $0142, $0142, $0142, $0142, $6142
		dc.w    $2142, $0142, $2142, $2142, $2142, $2142, $2142, $0142
		dc.w    $2142, $0142, $2142, $2142, $2142, $2142, $2142, $0142
		dc.w    $4142, $2142, $4142, $4142, $4142, $4142, $4142, $2142
		dc.w    $4142, $2142, $4142, $4142, $4142, $4142, $4142, $2142
		dc.w    $6142, $4142, $6142, $6142, $6142, $6142, $6142, $4142
		dc.w    $6142, $4142, $6142, $6142, $6142, $6142, $6142, $4142 
;-------------------------------------------------------------------------------  
Offset_0x02BAA4:
		lea     (SS_Ram_Layout_Address+$0400), A2            ; $FFFF4400
		move.w  #$001F, D0
Offset_0x02BAAE:
		tst.b   (A2)
		beq.s   Offset_0x02BAB8
		addq.w  #$08, A2
		dbra    D0, Offset_0x02BAAE
Offset_0x02BAB8:
		rts
;-------------------------------------------------------------------------------                
Offset_0x02BABA:
		lea     (SS_Ram_Layout_Address+$0400), A0            ; $FFFF4400
		move.w  #$001F, D7
Offset_0x02BAC4:
		moveq   #$00, D0
		move.b  (A0), D0
		beq.s   Offset_0x02BAD2
		lsl.w   #$02, D0
		move.l  SS_AniIndex-$04(PC, D0), A1            ; Offset_0x02BAD6
		jsr     (A1)
Offset_0x02BAD2:
		addq.w  #$08, A0
		dbra    D7, Offset_0x02BAC4
		rts  
;-------------------------------------------------------------------------------
SS_AniIndex:                                                   ; Offset_0x02BADA
		dc.l    SS_1_Animate                           ; Offset_0x02BAF2
		dc.l    SS_2_Animate                           ; Offset_0x02BB22
		dc.l    SS_3_Animate                           ; Offset_0x02BB58
		dc.l    SS_4_Animate                           ; Offset_0x02BB88
		dc.l    SS_5_Animate                           ; Offset_0x02BBBE
		dc.l    SS_6_Animate                           ; Offset_0x02BBFE   
;-------------------------------------------------------------------------------      
SS_1_Animate:                                                  ; Offset_0x02BAF2
		subq.b  #$01, $0002(A0)
		bpl.s   Offset_0x02BB1A
		move.b  #$05, $0002(A0)
		moveq   #$00, D0
		move.b  $0003(A0), D0
		addq.b  #$01, $0003(A0)
		move.l  $0004(A0), A1
		move.b  SS_1_Animate_Data(PC, D0), D0          ; Offset_0x02BB1C
		move.b  D0, (A1)
		bne.s   Offset_0x02BB1A
		clr.l   (A0)
		clr.l   $0004(A0)
Offset_0x02BB1A:
		rts
;-------------------------------------------------------------------------------
SS_1_Animate_Data:                                             ; Offset_0x02BB1C
		dc.b    $42, $43, $44, $45, $00, $00
;-------------------------------------------------------------------------------  
SS_2_Animate:                                                  ; Offset_0x02BB22
		subq.b  #$01, $0002(A0)
		bpl.s   Offset_0x02BB50
		move.b  #$07, $0002(A0)
		moveq   #$00, D0
		move.b  $0003(A0), D0
		addq.b  #$01, $0003(A0)
		move.l  $0004(A0), A1
		move.b  SS_2_Animate_Data(PC, D0), D0          ; Offset_0x02BB52
		bne.s   Offset_0x02BB4E
		clr.l   (A0)
		clr.l   $0004(A0)
		move.b  #$25, (A1)
		rts
Offset_0x02BB4E:
		move.b  D0, (A1)
Offset_0x02BB50:
		rts     
;-------------------------------------------------------------------------------  
SS_2_Animate_Data:                                             ; Offset_0x02BB52
		dc.b    $32, $33, $32, $33, $00, $00
;-------------------------------------------------------------------------------  
SS_3_Animate:                                                  ; Offset_0x02BB58
		subq.b  #$01, $0002(A0)
		bpl.s   Offset_0x02BB80
		move.b  #$05, $0002(A0)
		moveq   #$00, D0
		move.b  $0003(A0), D0
		addq.b  #$01, $0003(A0)
		move.l  $0004(A0), A1
		move.b  SS_3_Animate_Data(PC, D0), D0          ; Offset_0x02BB82
		move.b  D0, (A1)
		bne.s   Offset_0x02BB80
		clr.l   (A0)
		clr.l   $0004(A0)
Offset_0x02BB80:
		rts 
;-------------------------------------------------------------------------------  
SS_3_Animate_Data:                                             ; Offset_0x02BB82
		dc.b    $46, $47, $48, $49, $00, $00
;------------------------------------------------------------------------------- 
SS_4_Animate:                                                  ; Offset_0x02BB88
		subq.b  #$01, $0002(A0)
		bpl.s   Offset_0x02BBB6
		move.b  #$07, $0002(A0)
		moveq   #$00, D0
		move.b  $0003(A0), D0
		addq.b  #$01, $0003(A0)
		move.l  $0004(A0), A1
		move.b  SS_4_Animate_Data(PC, D0), D0          ; Offset_0x02BBB8
		bne.s   Offset_0x02BBB4
		clr.l   (A0)
		clr.l   $0004(A0)
		move.b  #$2B, (A1)
		rts
Offset_0x02BBB4:
		move.b  D0, (A1)
Offset_0x02BBB6:
		rts   
;------------------------------------------------------------------------------- 
SS_4_Animate_Data:                                             ; Offset_0x02BBB8
		dc.b    $2B, $31, $2B, $31, $00, $00                       
;------------------------------------------------------------------------------- 
SS_5_Animate:                                                  ; Offset_0x02BBBE
		subq.b  #$01, $0002(A0)
		bpl.s   Offset_0x02BBF6
		move.b  #$05, $0002(A0)
		moveq   #$00, D0
		move.b  $0003(A0), D0
		addq.b  #$01, $0003(A0)
		move.l  $0004(A0), A1
		move.b  SS_5_Animate_Data(PC, D0), D0          ; Offset_0x02BBF8
		move.b  D0, (A1)
		bne.s   Offset_0x02BBF6
		clr.l   (A0)
		clr.l   $0004(A0)
		move.b  #$04, (Player_One+Obj_Routine).w             ; $FFFFB024
		move.w  #$00A8, D0
		jsr     (Play_Sfx)                             ; Offset_0x001512
Offset_0x02BBF6:
		rts       
;-------------------------------------------------------------------------------  
SS_5_Animate_Data:                                             ; Offset_0x02BBF8
		dc.b    $46, $47, $48, $49, $00, $00
;-------------------------------------------------------------------------------   
SS_6_Animate:                                                  ; Offset_0x02BBFE
		subq.b  #$01, $0002(A0)
		bpl.s   Offset_0x02BC2A
		move.b  #$01, $0002(A0)
		moveq   #$00, D0
		move.b  $0003(A0), D0
		addq.b  #$01, $0003(A0)
		move.l  $0004(A0), A1
		move.b  SS_6_Animate_Data(PC, D0), D0          ; Offset_0x02BC2C
		move.b  D0, (A1)
		bne.s   Offset_0x02BC2A
		move.b  $0004(A0), (A1)
		clr.l   (A0)
		clr.l   $0004(A0)
Offset_0x02BC2A:
		rts       
;-------------------------------------------------------------------------------  
SS_6_Animate_Data:                                             ; Offset_0x02BC2C
		dc.b    $4B, $4C, $4D, $4E, $4B, $4C, $4D, $4E
		dc.b    $00, $00                                                              
;===============================================================================
; Rotina para mostrar o leiaute dos Estágios Especiais - Left over do Sonic 1
; <<<-
;===============================================================================
				
;===============================================================================
; Rotina para carregar o leiaute dos Estágios Especiais - Left over do Sonic 1
; ->>>
;===============================================================================   
Special_Stage_Layout_Index:                                    ; Offset_0x02BC36
		dc.l    Special_Stage_1                        ; Offset_0x03B3EA
		dc.l    Special_Stage_2                        ; Offset_0x03B664
		dc.l    Special_Stage_3                        ; Offset_0x03BA76
		dc.l    Special_Stage_4                        ; Offset_0x03BDD2
		dc.l    Special_Stage_5                        ; Offset_0x03C2AC
		dc.l    Special_Stage_6                        ; Offset_0x03C75C
;-------------------------------------------------------------------------------                  
SS_Player_Start_Position_Array:                                ; Offset_0x02BC4E
		dc.w    $03D0, $02E0   ; Special Stage 1
		dc.w    $0328, $0574   ; Special Stage 2
		dc.w    $04E4, $02E0   ; Special Stage 3
		dc.w    $03AD, $02E0   ; Special Stage 4
		dc.w    $0340, $06B8   ; Special Stage 5
		dc.w    $049B, $0358   ; Special Stage 6    
;-------------------------------------------------------------------------------    
Special_Stage_Load:                                            ; Offset_0x02BC66
		moveq   #$00, D0
		move.b  (Special_Stage_Id).w, D0                     ; $FFFFFE16
		addq.b  #$01, (Special_Stage_Id).w                   ; $FFFFFE16
		cmpi.b  #$06, (Special_Stage_Id).w                   ; $FFFFFE16
		bcs.s   Offset_0x02BC7E
		move.b  #$00, (Special_Stage_Id).w                   ; $FFFFFE16
Offset_0x02BC7E:
		cmpi.b  #$06, (Emerald_Count).w                      ; $FFFFFE57
		beq.s   Offset_0x02BCA0
		moveq   #$00, D1
		move.b  (Emerald_Count).w, D1                        ; $FFFFFE57
		subq.b  #$01, D1
		bcs.s   Offset_0x02BCA0
		lea     (Emerald_Collected_Flag_List).w, A3          ; $FFFFFE58
Offset_0x02BC94:
		cmp.b   $00(A3, D1), D0
		bne.s   Offset_0x02BC9C
		bra.s   Special_Stage_Load                     ; Offset_0x02BC66
Offset_0x02BC9C:
		dbra    D1, Offset_0x02BC94
Offset_0x02BCA0:
		lsl.w   #$02, D0
		lea     SS_Player_Start_Position_Array(PC, D0), A1 ; Offset_0x02BC4E
		move.w  (A1)+, (Player_One_Position_X).w             ; $FFFFB008
		move.w  (A1)+, (Player_One_Position_Y).w             ; $FFFFB00C
		move.l  Special_Stage_Layout_Index(PC, D0), A0 ; Offset_0x02BC36
		lea     (SS_Ram_Layout_Address), A1                  ; $FFFF4000
		move.w  #$0000, D0
		jsr     (EnigmaDec)                            ; Offset_0x001932
		lea     (M68K_RAM_Start), A1                         ; $FFFF0000
		move.w  #$0FFF, D0
Offset_0x02BCCC:
		clr.l   (A1)+
		dbra    D0, Offset_0x02BCCC
		lea     ($FFFF1020), A1
		lea     (SS_Ram_Layout_Address), A0                  ; $FFFF4000
		moveq   #$3F, D1
Offset_0x02BCE0:
		moveq   #$3F, D2
Offset_0x02BCE2:
		move.b  (A0)+, (A1)+
		dbra    D2, Offset_0x02BCE2
		lea     Obj_Size(A1), A1                                 ; $0040
		dbra    D1, Offset_0x02BCE0
		lea     (SS_Ram_Layout_Address+$0008), A1            ; $FFFF4008
		lea     (SS_Obj_Mappings_Ptr), A0              ; Offset_0x02BD22 
		moveq   #$4D, D1
Offset_0x02BCFE:
		move.l  (A0)+, (A1)+
		move.w  #$0000, (A1)+
		move.b  $FFFFFFFC(A0), $FFFFFFFF(A1)
		move.w  (A0)+, (A1)+
		dbra    D1, Offset_0x02BCFE
		lea     (SS_Ram_Layout_Address+$0400), A1            ; $FFFF4400
		move.w  #$003F, D1
Offset_0x02BD1A:
		clr.l   (A1)+
		dbra    D1, Offset_0x02BD1A
		rts
;-------------------------------------------------------------------------------
SS_Obj_Mappings_Ptr:                                           ; Offset_0x02BD22
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $2142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $4142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $6142
		dc.l    Red_Ball_Bumper_Mappings               ; Offset_0x014994
		dc.w    $023B
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0570
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0251
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0370
		dc.l    SS_Up_Mappings                         ; Offset_0x02BF2A
		dc.w    $0263
		dc.l    SS_Down_Mappings                       ; Offset_0x02BF3A
		dc.w    $0263
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $22F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A
		dc.w    $0470
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A
		dc.w    $05F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A
		dc.w    $65F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A
		dc.w    $25F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A
		dc.w    $45F0
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $02F0
		dc.l    (($01<<$18)|Red_Ball_Bumper_Mappings)  ; Offset_0x014994
		dc.w    $023B
		dc.l    (($02<<$18)|Red_Ball_Bumper_Mappings)  ; Offset_0x014994
		dc.w    $023B
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0797
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $07A0
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $07A9
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $0797
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $07A0
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $07A9
		dc.l    Rings_Mappings                         ; Offset_0x00AEA0
		dc.w    $27B2
		dc.l    SS_Emerald_Mappings                    ; Offset_0x02BF52
		dc.w    $0770
		dc.l    SS_Emerald_Mappings                    ; Offset_0x02BF52
		dc.w    $2770
		dc.l    SS_Emerald_Mappings                    ; Offset_0x02BF52
		dc.w    $4770
		dc.l    SS_Emerald_Mappings                    ; Offset_0x02BF52
		dc.w    $6770
		dc.l    SS_Red_Emerald_Mappings                ; Offset_0x02BF4A
		dc.w    $0770
		dc.l    SS_Gray_Emerald_Mappings               ; Offset_0x02BF4E
		dc.w    $0770
		dc.l    SS_Reverse_Goal_Mappings               ; Offset_0x02BEF6
		dc.w    $04F0                                                            
		dc.l    (($04<<$18)|Rings_Mappings)            ; Offset_0x00AEA0
		dc.w    $27B2
		dc.l    (($05<<$18)|Rings_Mappings)            ; Offset_0x00AEA0                   
		dc.w    $27B2
		dc.l    (($06<<$18)|Rings_Mappings)            ; Offset_0x00AEA0  
		dc.w    $27B2
		dc.l    (($07<<$18)|Rings_Mappings)            ; Offset_0x00AEA0 
		dc.w    $27B2
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A
		dc.w    $23F0
		dc.l    (($01<<$18)|SS_Red_White_Ball_Mappings) ; Offset_0x02BF0A
		dc.w    $23F0
		dc.l    (($02<<$18)|SS_Red_White_Ball_Mappings) ; Offset_0x02BF0A
		dc.w    $23F0
		dc.l    (($03<<$18)|SS_Red_White_Ball_Mappings) ; Offset_0x02BF0A
		dc.w    $23F0  
		dc.l    (($02<<$18)|SS_Reverse_Goal_Mappings)  ; Offset_0x02BEF6
		dc.w    $04F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A                  
		dc.w    $05F0                   
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A 
		dc.w    $65F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A 
		dc.w    $25F0
		dc.l    SS_Red_White_Ball_Mappings             ; Offset_0x02BF0A 
		dc.w    $45F0       
;-------------------------------------------------------------------------------
; Mapeamentos no formato do Sonic 1 
; ->>>
;-------------------------------------------------------------------------------
SS_Reverse_Goal_Mappings:                                      ; Offset_0x02BEF6
		dc.w    Offset_0x02BEFC-SS_Reverse_Goal_Mappings
		dc.w    Offset_0x02BF02-SS_Reverse_Goal_Mappings
		dc.w    Offset_0x02BF08-SS_Reverse_Goal_Mappings
Offset_0x02BEFC:
		dc.b    $01
		dc.b    $F4, $0A, $00, $00, $F4
Offset_0x02BF02:
		dc.b    $01
		dc.b    $F4, $0A, $00, $09, $F4
Offset_0x02BF08:
		dc.w    $00  
;-------------------------------------------------------------------------------
SS_Red_White_Ball_Mappings:                                    ; Offset_0x02BF0A
		dc.w    Offset_0x02BF12-SS_Red_White_Ball_Mappings
		dc.w    Offset_0x02BF18-SS_Red_White_Ball_Mappings
		dc.w    Offset_0x02BF1E-SS_Red_White_Ball_Mappings
		dc.w    Offset_0x02BF24-SS_Red_White_Ball_Mappings
Offset_0x02BF12:
		dc.b    $01
		dc.b    $F4, $0A, $00, $00, $F4
Offset_0x02BF18:
		dc.b    $01
		dc.b    $F4, $0A, $08, $00, $F4
Offset_0x02BF1E:
		dc.b    $01
		dc.b    $F4, $0A, $18, $00, $F4
Offset_0x02BF24:
		dc.b    $01
		dc.b    $F4, $0A, $10, $00, $F4       
;-------------------------------------------------------------------------------
SS_Up_Mappings:                                                ; Offset_0x02BF2A
		dc.w    Offset_0x02BF2E-SS_Up_Mappings
		dc.w    Offset_0x02BF34-SS_Up_Mappings
Offset_0x02BF2E:
		dc.b    $01
		dc.b    $F4, $0A, $00, $00, $F4
Offset_0x02BF34:
		dc.b    $01
		dc.b    $F4, $0A, $00, $12, $F4        
;-------------------------------------------------------------------------------
SS_Down_Mappings:                                              ; Offset_0x02BF3A
		dc.w    Offset_0x02BF3E-SS_Down_Mappings
		dc.w    Offset_0x02BF44-SS_Down_Mappings
Offset_0x02BF3E:
		dc.b    $01
		dc.b    $F4, $0A, $00, $09, $F4
Offset_0x02BF44:
		dc.b    $01
		dc.b    $F4, $0A, $00, $12, $F4      
;-------------------------------------------------------------------------------
SS_Red_Emerald_Mappings:                                       ; Offset_0x02BF4A
		dc.w    Offset_0x02BF56-SS_Red_Emerald_Mappings
		dc.w    Offset_0x02BF68-SS_Red_Emerald_Mappings
SS_Gray_Emerald_Mappings:                                      ; Offset_0x02BF4E
		dc.w    Offset_0x02BF5C-SS_Gray_Emerald_Mappings
		dc.w    Offset_0x02BF68-SS_Gray_Emerald_Mappings
SS_Emerald_Mappings:                                           ; Offset_0x02BF52  
		dc.w    Offset_0x02BF62-SS_Emerald_Mappings
		dc.w    Offset_0x02BF68-SS_Emerald_Mappings
Offset_0x02BF56:
		dc.b    $01
		dc.b    $F8, $05, $00, $00, $F8   
Offset_0x02BF5C:
		dc.b    $01
		dc.b    $F8, $05, $00, $04, $F8      
Offset_0x02BF62:
		dc.b    $01
		dc.b    $F8, $05, $00, $08, $F8
Offset_0x02BF68:
		dc.b    $01
		dc.b    $F8, $05, $00, $0C, $F8
;-------------------------------------------------------------------------------
; Mapeamentos no formato do Sonic 1 
; <<<-
;-------------------------------------------------------------------------------
		nop
;-------------------------------------------------------------------------------
Obj_0x09_Sonic_In_Special_Stage:                               ; Offset_0x02BF70 
		include 'objects/obj_0x09.asm'            
;-------------------------------------------------------------------------------
Obj_Null_3:                                                    ; Offset_0x02C612
		rts
Jmp_32_To_ModifySpriteAttr_2P:                                 ; Offset_0x02C614
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
		dc.w    $0000      
;===============================================================================
; Rotina para carregar os gráficos dinamicamente para a VRAM
; Ex: Flores na Emerald Hill, Óleo na Oil Ocean, etc...
; ->>>
;===============================================================================                
Dynamic_Art_Cues:                                              ; Offset_0x02C61C
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		add.w   D0, D0
		move.w  Dynamic_Art_Idx+$02(PC, D0), D1        ; Offset_0x02C63A
		lea     Dynamic_Art_Idx(PC, D1), A2            ; Offset_0x02C638
		move.w  Dynamic_Art_Idx(PC, D0), D0            ; Offset_0x02C638
		jmp     Dynamic_Art_Idx(PC, D0)                ; Offset_0x02C638
;-------------------------------------------------------------------------------                 
		rts  
;-------------------------------------------------------------------------------                
Dynamic_Art_Idx:                                               ; Offset_0x02C638
		dc.w    GHz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C860
		dc.w    GHz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02C8C8
		dc.w    Lvl1_Animate_Routine-Dynamic_Art_Idx   ; Offset_0x02C67C
		dc.w    Lvl1_Animate_Script-Dynamic_Art_Idx    ; Offset_0x02CBC0
		dc.w    Wz_Animate_Routine-Dynamic_Art_Idx     ; Offset_0x02C67C
		dc.w    Wz_Animate_Script-Dynamic_Art_Idx      ; Offset_0x02CBC0
		dc.w    Lvl3_Animate_Routine-Dynamic_Art_Idx   ; Offset_0x02C67C
		dc.w    Lvl3_Animate_Script-Dynamic_Art_Idx    ; Offset_0x02CBC0
		dc.w    Mz_Animate_Routine-Dynamic_Art_Idx     ; Offset_0x02C860
		dc.w    Mz_Animate_Script-Dynamic_Art_Idx      ; Offset_0x02C92C
		dc.w    Mz_Animate_Routine-Dynamic_Art_Idx     ; Offset_0x02C860
		dc.w    Mz_Animate_Script-Dynamic_Art_Idx      ; Offset_0x02C92C
		dc.w    Lvl6_Animate_Routine-Dynamic_Art_Idx   ; Offset_0x02C67C
		dc.w    Lvl6_Animate_Script-Dynamic_Art_Idx    ; Offset_0x02CBC0
		dc.w    HTz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C67E
		dc.w    HTz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02C96C
		dc.w    HPz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C860
		dc.w    HPz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02C9D0
		dc.w    Lvl9_Animate_Routine-Dynamic_Art_Idx   ; Offset_0x02C67C
		dc.w    Lvl9_Animate_Script-Dynamic_Art_Idx    ; Offset_0x02CBC0
		dc.w    OOz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C860
		dc.w    OOz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02C9FC
		dc.w    DHz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C67C
		dc.w    DHz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02CBC0
		dc.w    CHz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C860
		dc.w    CNz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02CA42
		dc.w    CPz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C860
		dc.w    CPz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02CB84
		dc.w    GCz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C67C
		dc.w    GCz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02CBC0
		dc.w    NGHz_Animate_Routine-Dynamic_Art_Idx   ; Offset_0x02C860
		dc.w    NGHz_Animate_Script-Dynamic_Art_Idx    ; Offset_0x02CB96
		dc.w    DEz_Animate_Routine-Dynamic_Art_Idx    ; Offset_0x02C67C
		dc.w    DEz_Animate_Script-Dynamic_Art_Idx     ; Offset_0x02CBC0   
;-------------------------------------------------------------------------------   
Lvl1_Animate_Routine:                                          ; Offset_0x02C67C
Wz_Animate_Routine:                                            ; Offset_0x02C67C
Lvl3_Animate_Routine:                                          ; Offset_0x02C67C
Lvl6_Animate_Routine:                                          ; Offset_0x02C67C
Lvl9_Animate_Routine:                                          ; Offset_0x02C67C
DHz_Animate_Routine:                                           ; Offset_0x02C67C
GCz_Animate_Routine:                                           ; Offset_0x02C67C
DEz_Animate_Routine:                                           ; Offset_0x02C67C
		rts      
;------------------------------------------------------------------------------- 
HTz_Animate_Routine:                                           ; Offset_0x02C67E
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne     HTz_Animate_Routine_2P                 ; Offset_0x02C860
		lea     ($FFFFF7F0).w, A3
		moveq   #$00, D0
		move.w  (Camera_X).w, D1                             ; $FFFFEE00
		neg.w   D1
		asr.w   #$03, D1
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		lsr.w   #$04, D0
		add.w   D1, D0
		subi.w  #$0010, D0
		divu.w  #$0030, D0
		swap.w  D0
		cmp.b   $0001(A3), D0
		beq.s   Offset_0x02C6F0
		move.b  D0, $0001(A3)
		move.w  D0, D2
		andi.w  #$0007, D0
		add.w   D0, D0
		add.w   D0, D0
		add.w   D0, D0
		move.w  D0, D1
		add.w   D0, D0
		add.w   D1, D0
		andi.w  #$0038, D2
		lsr.w   #$02, D2
		add.w   D2, D0
		lea     HTz_RAM_Dyn_Sprites(PC, D0), A4        ; Offset_0x02C6F4
		moveq   #$05, D5
		move.w  #$A000, D4
Offset_0x02C6D4:
		moveq   #-$01, D1
		move.w  (A4)+, D1
		andi.l  #$00FFFFFF, D1
		move.w  D4, D2
		moveq   #$40, D3
		jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
		addi.w  #$0080, D4
		dbra    D5, Offset_0x02C6D4
Offset_0x02C6F0:
		bra     Offset_0x02C7B4
;-------------------------------------------------------------------------------
; Array dos endereços da RAM para serem usados pelos sprites animados da 
; Hill Top, Os sprites são descomprimidos para RAM e carregados dinamicamente
; a partir da RAM. Note que nestes endereços estão os Chunks (128x128) da Hill
; Top, esses chunks não são usados para o layout. Deve se tomar cuidado ao 
; editar a Hill Top a partir de editores de fases, pois os editores não 
; reconhecem que os chunks não podem ser usado e se você usá-los ao carregar
; a fase durante o jogo notará que os chunks estão diferentes do que se viu
; no editor de fases.
;-------------------------------------------------------------------------------                
HTz_RAM_Dyn_Sprites:                                           ; Offset_0x02C6F4
		dc.w    $0080, $0180, $0280, $0580, $0600, $0700, $0080, $0180
		dc.w    $0280, $0580, $0600, $0700, $0980, $0A80, $0B80, $0C80
		dc.w    $0D00, $0D80, $0980, $0A80, $0B80, $0C80, $0D00, $0D80
		dc.w    $0E80, $1180, $1200, $1280, $1300, $1380, $0E80, $1180
		dc.w    $1200, $1280, $1300, $1380, $1400, $1480, $1500, $1580
		dc.w    $1600, $1900, $1400, $1480, $1500, $1580, $1600, $1900
		dc.w    $1D00, $1D80, $1E00, $1F80, $2400, $2580, $1D00, $1D80
		dc.w    $1E00, $1F80, $2400, $2580, $2600, $2680, $2780, $2B00
		dc.w    $2F00, $3280, $2600, $2680, $2780, $2B00, $2F00, $3280
		dc.w    $3600, $3680, $3780, $3C80, $3D00, $3F00, $3600, $3680
		dc.w    $3780, $3C80, $3D00, $3F00, $3F80, $4080, $4480, $4580
		dc.w    $4880, $4900, $3F80, $4080, $4480, $4580, $4880, $4900   
;-------------------------------------------------------------------------------
Offset_0x02C7B4:
		lea     ($FFFFA800).w, A1
		move.w  (Camera_X).w, D2                             ; $FFFFEE00
		neg.w   D2
		asr.w   #$03, D2
		move.l  A2, -(A7)
		lea     (Art_Hill_Top_Background_Uncomp), A0   ; Offset_0x030C2A
		lea     ($FFFF7C00), A2
		moveq   #$0F, D1
Offset_0x02C7D0:
		move.w  (A1)+, D0
		neg.w   D0
		add.w   D2, D0
		andi.w  #$001F, D0
		lsr.w   #$01, D0
		bcc.s   Offset_0x02C7E2
		addi.w  #$0200, D0
Offset_0x02C7E2:
		lea     $00(A0, D0), A4
		lsr.w   #$01, D0
		bcs.s   Offset_0x02C80C
		move.l  (A4)+, (A2)+
		adda.w  #$003C, A2
		move.l  (A4)+, (A2)+
		adda.w  #$003C, A2
		move.l  (A4)+, (A2)+
		adda.w  #$003C, A2
		move.l  (A4)+, (A2)+
		suba.w  #$00C0, A2
		adda.w  #$0020, A0
		dbra    D1, Offset_0x02C7D0
		bra.s   Offset_0x02C844
Offset_0x02C80C:
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		adda.w  #$003C, A2
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		adda.w  #$003C, A2
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		adda.w  #$003C, A2
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		move.b  (A4)+, (A2)+
		suba.w  #$00C0, A2
		adda.w  #$0020, A0
		dbra    D1, Offset_0x02C7D0
Offset_0x02C844:
		move.l  #$00FF7C00, D1
		move.w  #$A300, D2
		move.w  #$0080, D3
		jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
		move.l  (A7)+, A2
		addq.w  #$02, A3
		bra     Offset_0x02C864
;-------------------------------------------------------------------------------  
GHz_Animate_Routine:                                           ; Offset_0x02C860
Mz_Animate_Routine:                                            ; Offset_0x02C860
HTz_Animate_Routine_2P:                                        ; Offset_0x02C860
HPz_Animate_Routine:                                           ; Offset_0x02C860
OOz_Animate_Routine:                                           ; Offset_0x02C860
CHz_Animate_Routine:                                           ; Offset_0x02C860
CPz_Animate_Routine:                                           ; Offset_0x02C860
NGHz_Animate_Routine:                                          ; Offset_0x02C860
		lea     ($FFFFF7F0).w, A3
Offset_0x02C864:                
		move.w  (A2)+, D6
Offset_0x02C866:
		subq.b  #$01, (A3)
		bcc.s   Offset_0x02C8AC
		moveq   #$00, D0
		move.b  $0001(A3), D0
		cmp.b   $0006(A2), D0
		bcs.s   Offset_0x02C87C
		moveq   #$00, D0
		move.b  D0, $0001(A3)
Offset_0x02C87C:
		addq.b  #$01, $0001(A3)
		move.b  (A2), (A3)
		bpl.s   Offset_0x02C88A
		add.w   D0, D0
		move.b  $09(A2, D0), (A3)
Offset_0x02C88A:
		move.b  $08(A2, D0), D0
		lsl.w   #$05, D0
		move.w  $0004(A2), D2
		move.l  (A2), D1
		andi.l  #$00FFFFFF, D1
		add.l   D0, D1
		moveq   #$00, D3
		move.b  $0007(A2), D3
		lsl.w   #$04, D3
		jsr     (DMA_68KtoVRAM)                        ; Offset_0x0015C4
Offset_0x02C8AC:
		move.b  $0006(A2), D0
		tst.b   (A2)
		bpl.s   Offset_0x02C8B6
		add.b   D0, D0
Offset_0x02C8B6:
		addq.b  #$01, D0
		andi.w  #$00FE, D0
		lea     $08(A2, D0), A2
		addq.w  #$02, A3
		dbra    D6, Offset_0x02C866
		rts
;-------------------------------------------------------------------------------
GHz_Animate_Script:                                            ; Offset_0x02C8C8 
		dc.w    $0004                      ; Total de Animações
		dc.l    ($FF<<$18)|Art_GHz_Flower_1            ; Offset_0x030000
		dc.w    $7280                      ; VRAM 
		dc.w    $0602                      ; Quadros / Tiles
		dc.w    $007F, $0213, $0007, $0207 ; Carregar quadro / Tempo do quadro
		dc.w    $0007, $0207               ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_GHz_Flower_2            ; Offset_0x030080                  
		dc.w    $72C0                      ; VRAM
		dc.w    $0802                      ; Quadros / Tiles
		dc.w    $027F, $000B, $020B, $000B ; Carregar quadro / Tempo do quadro
		dc.w    $0205, $0005, $0205, $0005 ; Carregar quadro / Tempo do quadro
		dc.l    ($07<<$18)|Art_GHz_Flower_3            ; Offset_0x030100 
		dc.w    $7300                      ; VRAM
		dc.w    $0202                      ; Quadros / Tiles
		dc.w    $0002                      ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_GHz_Flower_4            ; Offset_0x030180   
		dc.w    $7340                      ; VRAM
		dc.w    $0802                      ; Quadros / Tiles
		dc.w    $007F, $0207, $0007, $0207 ; Carregar quadro / Tempo do quadro
		dc.w    $0007, $020B, $000B, $020B ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_GHz_Dyn_Wall            ; Offset_0x030200
		dc.w    $7380                      ; VRAM
		dc.w    $0602                      ; Quadros / Tiles
		dc.w    $0017, $0209, $040B, $0617 ; Carregar quadro / Tempo do quadro 
		dc.w    $040B, $0209               ; Carregar quadro / Tempo do quadro  
;------------------------------------------------------------------------------- 
Mz_Animate_Script:                                             ; Offset_0x02C92C  
		dc.w    $0003                      ; Total de Animações
		dc.l    Art_Mz_Spinnig_Cylinder                ; Offset_0x03102A               
		dc.w    $6980                      ; VRAM 
		dc.w    $0810                      ; Quadros / Tiles
		dc.w    $0010, $2030, $4050, $6070 ; Carregar quadro / Tempo do quadro
		dc.l    ($0D<<$18)|Art_Mz_Lava                 ; Offset_0x03202A
		dc.w    $6800                      ; VRAM 
		dc.w    $060C                      ; Quadros / Tiles
		dc.w    $000C, $1824, $180C        ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_Mz_Pistons              ; Offset_0x03262A
		dc.w    $6B80                      ; VRAM 
		dc.w    $0406                      ; Quadros / Tiles
		dc.w    $0013, $0607, $0C13, $0607 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_Mz_Pistons              ; Offset_0x03262A
		dc.w    $6C40                      ; VRAM 
		dc.w    $0406                      ; Quadros / Tiles
		dc.w    $0C13, $0607, $0013, $0607 ; Carregar quadro / Tempo do quadro   
;-------------------------------------------------------------------------------
HTz_Animate_Script:                                            ; Offset_0x02C96C  
		dc.w    $0004                      ; Total de Animações
		dc.l    ($FF<<$18)|Art_HTz_Flower_1            ; Offset_0x030000
		dc.w    $7280                      ; VRAM 
		dc.w    $0602                      ; Quadros / Tiles
		dc.w    $007F, $0213, $0007, $0207 ; Carregar quadro / Tempo do quadro
		dc.w    $0007, $0207               ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_HTz_Flower_2            ; Offset_0x030080                  
		dc.w    $72C0                      ; VRAM
		dc.w    $0802                      ; Quadros / Tiles
		dc.w    $027F, $000B, $020B, $000B ; Carregar quadro / Tempo do quadro
		dc.w    $0205, $0005, $0205, $0005 ; Carregar quadro / Tempo do quadro
		dc.l    ($07<<$18)|Art_HTz_Flower_3            ; Offset_0x030100 
		dc.w    $7300                      ; VRAM
		dc.w    $0202                      ; Quadros / Tiles
		dc.w    $0002                      ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_HTz_Flower_4            ; Offset_0x030180   
		dc.w    $7340                      ; VRAM
		dc.w    $0802                      ; Quadros / Tiles
		dc.w    $007F, $0207, $0007, $0207 ; Carregar quadro / Tempo do quadro
		dc.w    $0007, $020B, $000B, $020B ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_HTz_Dyn_Wall            ; Offset_0x030200 
		dc.w    $7380                      ; VRAM
		dc.w    $0602                      ; Quadros / Tiles
		dc.w    $0017, $0209, $040B, $0617 ; Carregar quadro / Tempo do quadro
		dc.w    $040B, $0209               ; Carregar quadro / Tempo do quadro
;-------------------------------------------------------------------------------  
HPz_Animate_Script:                                            ; Offset_0x02C9D0
		dc.w    $0002                      ; Total de Animações
		dc.l    ($08<<$18)|Art_HPz_Orbs                ; Offset_0x032C6A
		dc.w    $5D00                      ; VRAM
		dc.w    $0608                      ; Quadros / Tiles
		dc.w    $0000, $0810, $1008        ; Carregar quadro / Tempo do quadro                
		dc.l    ($08<<$18)|Art_HPz_Orbs                ; Offset_0x032C6A
		dc.w    $5E00                      ; VRAM
		dc.w    $0608                      ; Quadros / Tiles
		dc.w    $0810, $1008, $0000        ; Carregar quadro / Tempo do quadro
		dc.l    ($08<<$18)|Art_HPz_Orbs                ; Offset_0x032C6A
		dc.w    $5F00                      ; VRAM
		dc.w    $0608                      ; Quadros / Tiles
		dc.w    $1008, $0000, $0810        ; Carregar quadro / Tempo do quadro 
;------------------------------------------------------------------------------- 
OOz_Animate_Script:                                            ; Offset_0x02C9FC  
		dc.w    $0004                      ; Total de Animações
		dc.l    ($FF<<$18)|Art_OOz_Red_Balls           ; Offset_0x032F6A
		dc.w    $56C0                      ; VRAM
		dc.w    $0404                      ; Quadros / Tiles
		dc.w    $000B, $0405, $0809, $0403 ; Carregar quadro / Tempo do quadro                                                                                                       
		dc.l    ($06<<$18)|Art_OOz_Rotating_Square_1   ; Offset_0x0330EA
		dc.w    $5740                      ; VRAM
		dc.w    $0404                      ; Quadros / Tiles
		dc.w    $0004, $080C               ; Carregar quadro / Tempo do quadro                                                                              
		dc.l    ($06<<$18)|Art_OOz_Rotating_Square_2   ; Offset_0x0332EA
		dc.w    $57C0                      ; VRAM
		dc.w    $0404                      ; Quadros / Tiles
		dc.w    $0004, $080C               ; Carregar quadro / Tempo do quadro                                                            
		dc.l    ($11<<$18)|Art_OOz_Oil_1               ; Offset_0x0334EA
		dc.w    $5840                      ; VRAM
		dc.w    $0610                      ; Quadros / Tiles
		dc.w    $0010, $2030, $2010        ; Carregar quadro / Tempo do quadro                                                            
		dc.l    ($11<<$18)|Art_OOz_Oil_2               ; Offset_0x033CEA
		dc.w    $5A40                      ; VRAM
		dc.w    $0610                      ; Quadros / Tiles
		dc.w    $0010, $2030, $2010        ; Carregar quadro / Tempo do quadro 
;------------------------------------------------------------------------------- 
CNz_Animate_Script:                                            ; Offset_0x02CA42
		dc.w    $0007                      ; Total de Animações
		dc.l    ($FF<<$18)|Art_CNz_Blue_Cards          ; Offset_0x0344EA
		dc.w    $A600                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles                  
		dc.w    $00C7, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro 
		dc.w    $00C7, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.w    $0005, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.w    $0005, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Blue_Cards          ; Offset_0x0344EA
		dc.w    $A680                   
		dc.w    $1004                      ; Quadros / Tiles   
		dc.w    $04C7, $1405, $2005, $2805 ; Carregar quadro / Tempo do quadro
		dc.w    $30C7, $3805, $2005, $4005 ; Carregar quadro / Tempo do quadro
		dc.w    $0405, $1405, $2005, $2805 ; Carregar quadro / Tempo do quadro
		dc.w    $3005, $3805, $2005, $4005 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Blue_Cards          ; Offset_0x0344EA
		dc.w    $A700                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles 
		dc.w    $08C7, $1805, $2405, $2C05 ; Carregar quadro / Tempo do quadro
		dc.w    $34C7, $3C05, $2405, $4405 ; Carregar quadro / Tempo do quadro
		dc.w    $0805, $1805, $2405, $2C05 ; Carregar quadro / Tempo do quadro
		dc.w    $3405, $3C05, $2405, $4405 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Blue_Cards          ; Offset_0x0344EA
		dc.w    $A780                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles 
		dc.w    $0CC7, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.w    $0CC7, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.w    $0C05, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.w    $0C05, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Pink_Cards          ; Offset_0x034DEA          
		dc.w    $A400                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles 
		dc.w    $0005, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.w    $3005, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.w    $00C7, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.w    $30C7, $1005, $1005, $1005 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Pink_Cards          ; Offset_0x034DEA
		dc.w    $A480                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles 
		dc.w    $0405, $1405, $2005, $2805 ; Carregar quadro / Tempo do quadro
		dc.w    $3405, $4005, $2005, $4805 ; Carregar quadro / Tempo do quadro
		dc.w    $04C7, $1405, $2005, $2805 ; Carregar quadro / Tempo do quadro
		dc.w    $34C7, $4005, $2005, $4805 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Pink_Cards          ; Offset_0x034DEA
		dc.w    $A500                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles 
		dc.w    $0805, $1805, $2405, $2C05 ; Carregar quadro / Tempo do quadro
		dc.w    $3805, $4405, $2405, $4C05 ; Carregar quadro / Tempo do quadro
		dc.w    $08C7, $1805, $2405, $2C05 ; Carregar quadro / Tempo do quadro
		dc.w    $38C7, $4405, $2405, $4C05 ; Carregar quadro / Tempo do quadro
		dc.l    ($FF<<$18)|Art_CNz_Pink_Cards          ; Offset_0x034DEA
		dc.w    $A580                      ; VRAM
		dc.w    $1004                      ; Quadros / Tiles 
		dc.w    $0C05, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.w    $3C05, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.w    $0CC7, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
		dc.w    $3CC7, $1C05, $1C05, $1C05 ; Carregar quadro / Tempo do quadro
;------------------------------------------------------------------------------- 
CPz_Animate_Script:                                            ; Offset_0x02CB84 
		dc.w    $0000                      ; Total de Animações
		dc.l    ($04<<$18)|Art_CPz_Dyn_Background ; Offset_0x0363EA
		dc.w    $6E00                      ; VRAM
		dc.w    $0802                      ; Quadros / Tiles
		dc.w    $0002, $0406, $080A, $0C0E ; Carregar quadro / Tempo do quadro
;------------------------------------------------------------------------------- 
NGHz_Animate_Script:                                           ; Offset_0x02CB96 
		dc.w    $0003                      ; Total de Animações
		dc.l    ($05<<$18)|Art_NGHz_Water_Falls_1      ; Offset_0x0365EA
		dc.w    $8780                      ; VRAM
		dc.w    $0204                      ; Quadros / Tiles  
		dc.w    $0004                      ; Carregar quadro / Tempo do quadro 
		dc.l    ($05<<$18)|Art_NGHz_Water_Falls_1      ; Offset_0x0365EA
		dc.w    $8600                      ; VRAM
		dc.w    $0204                      ; Quadros / Tiles   
		dc.w    $0400                      ; Carregar quadro / Tempo do quadro 
		dc.l    ($05<<$18)|Art_NGHz_Water_Falls_2      ; Offset_0x0366EA
		dc.w    $8580                      ; VRAM
		dc.w    $0204                      ; Quadros / Tiles
		dc.w    $0004                      ; Carregar quadro / Tempo do quadro 
		dc.l    ($05<<$18)|Art_NGHz_Water_Falls_3      ; Offset_0x0367EA
		dc.w    $8500                      ; VRAM
		dc.w    $0204                      ; Quadros / Tiles 
		dc.w    $0004                      ; Carregar quadro / Tempo do quadro  
Lvl1_Animate_Script:                                           ; Offset_0x02CBC0
Wz_Animate_Script:                                             ; Offset_0x02CBC0
Lvl3_Animate_Script:                                           ; Offset_0x02CBC0
Lvl6_Animate_Script:                                           ; Offset_0x02CBC0
Lvl9_Animate_Script:                                           ; Offset_0x02CBC0
DHz_Animate_Script:                                            ; Offset_0x02CBC0
GCz_Animate_Script:                                            ; Offset_0x02CBC0
DEz_Animate_Script:                                            ; Offset_0x02CBC0 
		cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
		beq.s   Offset_0x02CBCA
Offset_0x02CBC8:
		rts 
;===============================================================================
; Rotina para carregar os gráficos dinamicamente para a VRAM
; Ex: Flores na Emerald Hill, Óleo na Oil Ocean, etc...
; <<<-
;===============================================================================                 
		
;===============================================================================
; Rotina não usada para executar algum efeito na Chemical Plant
; ->>>
;=============================================================================== 
Offset_0x02CBCA:
		move.w  (Camera_X).w, D0                             ; $FFFFEE00
		cmpi.w  #$1940, D0
		bcs.s   Offset_0x02CBC8
		cmpi.w  #$1F80, D0
		bcc.s   Offset_0x02CBC8
		subq.b  #$01, ($FFFFF721).w
		bpl.s   Offset_0x02CBC8
		move.b  #$07, ($FFFFF721).w
		move.b  #$01, (Refresh_Level_Layout).w               ; $FFFFF720
		lea     ($FFFF7500), A1
		bsr.s   Offset_0x02CBFA
		lea     ($FFFF7D00), A1
Offset_0x02CBFA:
		move.w  #$0007, D1
Offset_0x02CBFE:
		move.w  (A1), D0
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0072(A1), (A1)+
		adda.w  #$0070, A1
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0072(A1), (A1)+
		adda.w  #$0070, A1
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0072(A1), (A1)+
		adda.w  #$0070, A1
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  $0002(A1), (A1)+
		move.w  D0, (A1)+
		suba.w  #$0180, A1
		dbra    D1, Offset_0x02CBFE
		rts
;===============================================================================
; Rotina não usada para executar algum efeito na Chemical Plant
; <<<-
;===============================================================================                 
	
;===============================================================================
; Rotina para carregar os mapeamentos para os gráficos dinâmicos das fases
; ->>>
;===============================================================================  
Load_16x16_Mappings_For_Dyn_Sprites:                           ; Offset_0x02CC94
		cmpi.b  #$07, (Level_Id).w                           ; $FFFFFE10
		bne.s   Load_16x16_Map_Dyn_Not_HTz             ; Offset_0x02CCAC
		bsr     Hill_Top_Init_Dyn_Sprites              ; Offset_0x02D0BC
		move.b  #$FF, ($FFFFF7F1).w
		move.w  #$FFFF, ($FFFFA820).w
Load_16x16_Map_Dyn_Not_HTz:                                    ; Offset_0x02CCAC:
		cmpi.b  #$0D, (Level_Id).w                           ; $FFFFFE10
		bne.s   Load_16x16_Map_Dyn_Not_CPz             ; Offset_0x02CCBA
		move.b  #$FF, ($FFFFF7F1).w
Load_16x16_Map_Dyn_Not_CPz:                                    ; Offset_0x02CCBA:
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
		add.w   D0, D0
		move.w  Map16Delta_Index(PC, D0), D0           ; Offset_0x02CCFC
		lea     Map16Delta_Index(PC, D0), A0           ; Offset_0x02CCFC
		tst.w   (A0)
		beq.s   Offset_0x02CCE2
		lea     (Blocks_Mem_Address).w, A1                   ; $FFFF9000
		adda.w  (A0)+, A1
		move.w  (A0)+, D1
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		bne.s   Offset_0x02CCE4
Offset_0x02CCDC:
		move.w  (A0)+, (A1)+
		dbra    D1, Offset_0x02CCDC
Offset_0x02CCE2:
		rts
Offset_0x02CCE4:
		move.w  (A0)+, D0
		move.w  D0, D1
		andi.w  #$F800, D0
		andi.w  #$07FF, D1
		lsr.w   #$01, D1
		or.w    D1, D0
		move.w  D0, (A1)+
		dbra    D1, Offset_0x02CCE4
		rts         
;------------------------------------------------------------------------------- 
Map16Delta_Index:                                              ; Offset_0x02CCFC
		dc.w    Map16Delta_GHz-Map16Delta_Index        ; Offset_0x02CD1E
		dc.w    Map16Delta_Lvl1-Map16Delta_Index       ; Offset_0x02D0BA
		dc.w    Map16Delta_Wz-Map16Delta_Index         ; Offset_0x02D0BA
		dc.w    Map16Delta_Lvl3-Map16Delta_Index       ; Offset_0x02D0BA
		dc.w    Map16Delta_Mz-Map16Delta_Index         ; Offset_0x02CD9A
		dc.w    Map16Delta_Mz-Map16Delta_Index         ; Offset_0x02CD9A
		dc.w    Map16Delta_Lvl6-Map16Delta_Index       ; Offset_0x02D0BA
		dc.w    Map16Delta_HTz-Map16Delta_Index        ; Offset_0x02CD1E
		dc.w    Map16Delta_HPz-Map16Delta_Index        ; Offset_0x02CE6E
		dc.w    Map16Delta_Lvl9-Map16Delta_Index       ; Offset_0x02D0BA
		dc.w    Map16Delta_OOz-Map16Delta_Index        ; Offset_0x02CF62
		dc.w    Map16Delta_DHz-Map16Delta_Index        ; Offset_0x02D0BA
		dc.w    Map16Delta_CNz-Map16Delta_Index        ; Offset_0x02CFC6
		dc.w    Map16Delta_CPz-Map16Delta_Index        ; Offset_0x02D06A
		dc.w    Map16Delta_GCz-Map16Delta_Index        ; Offset_0x02D0BA
		dc.w    Map16Delta_NGHz-Map16Delta_Index       ; Offset_0x02D076
		dc.w    Map16Delta_DEz-Map16Delta_Index        ; Offset_0x02D0BA  
;------------------------------------------------------------------------------- 
Map16Delta_GHz:                                                ; Offset_0x02CD1E 
Map16Delta_HTz:                                                ; Offset_0x02CD1E   
		dc.w    $1788 ; Endereço da RAM para carregar os mapeamentos ($1788+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $003B ; Quantidade de Words a serem movidas para RAM    ($0000..$003B) -> move.w  (A0)+, D1                
		dc.w    $4500, $4504, $4501, $4505, $4508, $450C, $4509, $450D
		dc.w    $4510, $4514, $4511, $4515, $4502, $4506, $4503, $4507
		dc.w    $450A, $450E, $450B, $450F, $4512, $4516, $4513, $4517
		dc.w    $6518, $651A, $6519, $651B, $651C, $651E, $651D, $651F
		dc.w    $439C, $4B9C, $439D, $4B9D, $4158, $439C, $4159, $439D
		dc.w    $4B9C, $4958, $4B9D, $4959, $6394, $6B94, $6395, $6B95
		dc.w    $E396, $EB96, $E397, $EB97, $6398, $6B98, $6399, $6B99
		dc.w    $E39A, $EB9A, $E39B, $EB9B
;-------------------------------------------------------------------------------
Map16Delta_Mz:                                                 ; Offset_0x02CD9A 
		dc.w    $1730 ; Endereço da RAM para carregar os mapeamentos ($1730+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $0067 ; Quantidade de Words a serem movidas para RAM    ($0000..$0067) -> move.w  (A0)+, D1                
		dc.w    $235C, $2B5C, $235D, $2B5D, $235E, $2B5E, $235F, $2B5F
		dc.w    $635A, $635A, $635B, $635B, $6358, $6358, $6359, $6359
		dc.w    $6356, $6356, $6357, $6357, $6354, $6354, $6355, $6355
		dc.w    $6352, $6352, $6353, $6353, $6350, $6350, $6351, $6351
		dc.w    $634E, $634E, $634F, $634F, $634C, $634C, $634D, $634D
		dc.w    $2360, $2B60, $2361, $2B61, $2362, $2B62, $2363, $2B63
		dc.w    $2364, $2B64, $2365, $2B65, $2366, $2B66, $2367, $2B67
		dc.w    $C000, $C000, $C340, $C341, $C000, $C000, $C342, $C343
		dc.w    $C344, $C345, $C348, $C349, $C346, $C347, $C34A, $C34B
		dc.w    $E35A, $E35A, $E35B, $E35B, $E358, $E358, $E359, $E359
		dc.w    $E356, $E356, $E357, $E357, $E354, $E354, $E355, $E355
		dc.w    $E352, $E352, $E353, $E353, $E350, $E350, $E351, $E351
		dc.w    $E34E, $E34E, $E34F, $E34F, $E34C, $E34C, $E34D, $E34D
;-------------------------------------------------------------------------------  
Map16Delta_HPz:                                                ; Offset_0x02CE6E
		dc.w    $1710 ; Endereco da RAM para carregar os mapeamentos ($1710+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $0077 ; Quantidade de Words a serem movidas para RAM    ($0000..$0077) -> move.w  (A0)+, D1               
		dc.w    $62E8, $62E9, $62EA, $62EB, $62EC, $62ED, $62EE, $62EF
		dc.w    $62F0, $62F1, $62F2, $62F3, $62F4, $62F5, $62F6, $62F7
		dc.w    $62F8, $62F9, $62FA, $62FB, $62FC, $62FD, $62FE, $62FF
		dc.w    $42E8, $42E9, $42EA, $42EB, $42EC, $42ED, $42EE, $42EF
		dc.w    $42F0, $42F1, $42F2, $42F3, $42F4, $42F5, $42F6, $42F7
		dc.w    $42F8, $42F9, $42FA, $42FB, $42FC, $42FD, $42FE, $42FF
		dc.w    $0000, $62E8, $0000, $62EA, $62E9, $62EC, $62EB, $62EE
		dc.w    $62ED, $0000, $62EF, $0000, $0000, $62F0, $0000, $62F2
		dc.w    $62F1, $62F4, $62F3, $62F6, $62F5, $0000, $62F7, $0000
		dc.w    $0000, $62F8, $0000, $62FA, $62F9, $62FC, $62FB, $62FE
		dc.w    $62FD, $0000, $62FF, $0000, $0000, $42E8, $0000, $42EA
		dc.w    $42E9, $42EC, $42EB, $42EE, $42ED, $0000, $42EF, $0000
		dc.w    $0000, $42F0, $0000, $42F2, $42F1, $42F4, $42F3, $42F6
		dc.w    $42F5, $0000, $42F7, $0000, $0000, $42F8, $0000, $42FA
		dc.w    $42F9, $42FC, $42FB, $42FE, $42FD, $0000, $42FF, $0000
;------------------------------------------------------------------------------- 
Map16Delta_OOz:                                                ; Offset_0x02CF62 
		dc.w    $17A0 ; Endereco da RAM para carregar os mapeamentos ($17A0+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $002F ; Quantidade de Words a serem movidas para RAM    ($0000..$0027) -> move.w  (A0)+, D1               
		dc.w    $82B6, $82B8, $82B7, $82B9, $E2BA, $E2BB, $E2BC, $E2BD
		dc.w    $0000, $62BE, $0000, $62C0, $62BF, $0000, $62C1, $0000
		dc.w    $C2C2, $C2C3, $C2CA, $C2CB, $C2C4, $C2C5, $C2CC, $C2CD
		dc.w    $C2C6, $C2C7, $C2CE, $C2CF, $C2C8, $C2C9, $C2D0, $C2D1
		dc.w    $C2D2, $C2D3, $C2DA, $C2DB, $C2D4, $C2D5, $C2DC, $C2DD
		dc.w    $C2D6, $C2D7, $C2DE, $C2DF, $C2D8, $C2D9, $C2E0, $C2E1 
;-------------------------------------------------------------------------------
Map16Delta_CNz:                                                ; Offset_0x02CFC6 
		dc.w    $1760 ; Endereco da RAM para carregar os mapeamentos ($1760+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $004F ; Quantidade de Words a serem movidas para RAM    ($0000..$004F) -> move.w  (A0)+, D1                
		dc.w    $0368, $036C, $0369, $036D, $0370, $0374, $0371, $0375
		dc.w    $036A, $036E, $036B, $036F, $0372, $0376, $0373, $0377
		dc.w    $0500, $0504, $0501, $0505, $0508, $050C, $0509, $050D
		dc.w    $0502, $0506, $0503, $0507, $050A, $050E, $050B, $050F
		dc.w    $0510, $0514, $0511, $0515, $0518, $051C, $0519, $051D
		dc.w    $0512, $0516, $0513, $0517, $051A, $051E, $051B, $051F
		dc.w    $4520, $4524, $4521, $4525, $4528, $452C, $4529, $452D
		dc.w    $4522, $4526, $4523, $4527, $452A, $452E, $452B, $452F
		dc.w    $4530, $4534, $4531, $4535, $4538, $453C, $4539, $453D
		dc.w    $4532, $4536, $4533, $4537, $453A, $453E, $453B, $453F
;-------------------------------------------------------------------------------
Map16Delta_CPz:                                                ; Offset_0x02D06A  
		dc.w    $17F8 ; Endereco da RAM para carregar os mapeamentos ($17F8+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $0003 ; Quantidade de Words a serem movidas para RAM    ($0000..$0003) -> move.w  (A0)+, D1                
		dc.w    $4370, $4371, $4370, $4371   
;------------------------------------------------------------------------------- 
Map16Delta_NGHz:                                               ; Offset_0x02D076  
		dc.w    $17C0 ; Endereco da RAM para carregar os mapeamentos ($17C0+$FFFF9000) -> adda.w  (A0)+, A1
		dc.w    $001F ; Quantidade de Words a serem movidas para RAM    ($0000..$001F) -> move.w  (A0)+, D1
		dc.w    $C428, $C429, $C42A, $C42B, $C42C, $C42D, $C42E, $C42F
		dc.w    $C430, $C431, $C432, $C433, $C43C, $C43D, $C43E, $C43F
		dc.w    $4428, $4429, $442A, $442B, $442C, $442D, $442E, $442F
		dc.w    $4430, $4431, $4432, $4433, $443C, $443D, $443E, $443F
;------------------------------------------------------------------------------- 
Map16Delta_Lvl1:                                               ; Offset_0x02D0BA
Map16Delta_Wz:                                                 ; Offset_0x02D0BA
Map16Delta_Lvl3:                                               ; Offset_0x02D0BA
Map16Delta_Lvl6:                                               ; Offset_0x02D0BA
Map16Delta_Lvl9:                                               ; Offset_0x02D0BA
Map16Delta_DHz:                                                ; Offset_0x02D0BA
Map16Delta_GCz:                                                ; Offset_0x02D0BA
Map16Delta_DEz:                                                ; Offset_0x02D0BA    
		dc.w    $0000
;-------------------------------------------------------------------------------    
Hill_Top_Init_Dyn_Sprites:                                     ; Offset_0x02D0BC
		lea     (Art_Hill_Top_Background), A0          ; Offset_0x030300
		lea     ($FFFFB800).w, A4
		bsr     Jmp_00_To_NemesisDecToRAM              ; Offset_0x02D0F8
		lea     ($FFFFB800).w, A1
		lea     HTz_RAM_Dyn_Sprites(PC), A4            ; Offset_0x02C6F4
		moveq   #$00, D2
		moveq   #$07, D4
Offset_0x02D0D6:
		moveq   #$05, D3
Offset_0x02D0D8:
		moveq   #-$01, D0
		move.w  (A4)+, D0
		move.l  D0, A2
		moveq   #$1F, D1
Offset_0x02D0E0:
		move.l  (A1), (A2)+
		move.l  D2, (A1)+
		dbra    D1, Offset_0x02D0E0
		dbra    D3, Offset_0x02D0D8
		adda.w  #$000C, A4
		dbra    D4, Offset_0x02D0D6
		rts    
;===============================================================================
; Rotina para carregar os mapeamentos para os gráficos dinâmicos das fases
; <<<-
;===============================================================================          
; Offset_0x02D0F6:
		nop
Jmp_00_To_NemesisDecToRAM:                                     ; Offset_0x02D0F8
		jmp     (NemesisDecToRAM)                      ; Offset_0x001666     
		dc.w    $0000           
;===============================================================================
; Rotina para carregar o leiaute dos Estágios Especiais - Left over do Sonic 1
; <<<-
;===============================================================================  
Obj_0x21_Head_Up_Display:                                      ; Offset_0x02D100
		include 'objects/obj_0x21.asm'
;-------------------------------------------------------------------------------                  
AddPoints:                                                     ; Offset_0x02D2D4
		move.b  #$01, (HUD_Score_Refresh_Flag).w             ; $FFFFFE1F
		lea     (Score_Count).w, A3                          ; $FFFFFE26
		add.l   D0, (A3)
		move.l  #$000F423F, D1   ; 999.999
		cmp.l   (A3), D1
		bhi.s   Offset_0x02D2EC
		move.l  D1, (A3)
Offset_0x02D2EC:
		move.l  (A3), D0
		cmp.l   ($FFFFFFC0).w, D0
		bcs.s   Offset_0x02D314
		addi.l  #$00001388, ($FFFFFFC0).w   ; 50.000
		tst.b   (Hardware_Id).w                              ; $FFFFFFF8
		bmi.s   Offset_0x02D314
		addq.b  #$01, (Life_Count).w                         ; $FFFFFE12
		addq.b  #$01, (HUD_Life_Refresh_Flag).w              ; $FFFFFE1C
		move.w  #$0088, D0
		jmp     (Play_Music)                           ; Offset_0x00150C
Offset_0x02D314:
		rts
;===============================================================================
; Rotina para atualizar os contadores na tela (Pontos, Tempo, Vidas...).
; ->>>
;===============================================================================
HudUpdate:                                                     ; Offset_0x02D316
		nop
		lea     (VDP_Data_Port), A6                          ; $00C00000
		tst.w   (Debug_Mode_Active_Flag).w                   ; $FFFFFFFA
		bne     Offset_0x02D408
		tst.b   (HUD_Score_Refresh_Flag).w                   ; $FFFFFE1F
		beq.s   Offset_0x02D33E
		clr.b   (HUD_Score_Refresh_Flag).w                   ; $FFFFFE1F
		move.l  #$5C800003, D0
		move.l  (Score_Count).w, D1                          ; $FFFFFE26
		bsr     Offset_0x02D542
Offset_0x02D33E:
		tst.b   (HUD_Rings_Refresh_Flag).w                   ; $FFFFFE1D
		beq.s   Offset_0x02D35E
		bpl.s   Offset_0x02D34A
		bsr     Offset_0x02D474
Offset_0x02D34A:
		clr.b   (HUD_Rings_Refresh_Flag).w                   ; $FFFFFE1D
		move.l  #$5F400003, D0
		moveq   #$00, D1
		move.w  (Ring_Count).w, D1                           ; $FFFFFE20
		bsr     Offset_0x02D538
Offset_0x02D35E:
		tst.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
		beq.s   Offset_0x02D3BA
		tst.w   (Pause_Status).w                             ; $FFFFF63A
		bne.s   Offset_0x02D3BA
		lea     (Time_Count).w, A1                           ; $FFFFFE22
		cmpi.l  #$00093B3B, (A1)+
		nop
		addq.b  #$01, -(A1)
		cmpi.b  #$3C, (A1)
		bcs.s   Offset_0x02D3BA
		move.b  #$00, (A1)
		addq.b  #$01, -(A1)
		cmpi.b  #$3C, (A1)
		bcs.s   Offset_0x02D39A
		move.b  #$00, (A1)
		addq.b  #$01, -(A1)
		cmpi.b  #$09, (A1)
		bcs.s   Offset_0x02D39A
		move.b  #$09, (A1)
Offset_0x02D39A:
		move.l  #$5E400003, D0
		moveq   #$00, D1
		move.b  (Time_Count_Minutes).w, D1                   ; $FFFFFE23
		bsr     Offset_0x02D610
		move.l  #$5EC00003, D0
		moveq   #$00, D1
		move.b  (Time_Count_Seconds).w, D1                   ; $FFFFFE24
		bsr     Offset_0x02D618
Offset_0x02D3BA:
		tst.b   (HUD_Life_Refresh_Flag).w                    ; $FFFFFE1C
		beq.s   Offset_0x02D3C8
		clr.b   (HUD_Life_Refresh_Flag).w                    ; $FFFFFE1C
		bsr     Offset_0x02D6D0
Offset_0x02D3C8:
		tst.b   ($FFFFF7D6).w
		beq.s   Offset_0x02D3F0
		clr.b   ($FFFFF7D6).w
		move.l  #$6E000002, (VDP_Control_Port)               ; $00C00004
		moveq   #$00, D1
		move.w  ($FFFFF7D2).w, D1
		bsr     Offset_0x02D670
		moveq   #$00, D1
		move.w  ($FFFFF7D4).w, D1
		bsr     Offset_0x02D670
Offset_0x02D3F0:
		rts                      
;-------------------------------------------------------------------------------                                                      
Time_Over:    ; Não usado                                      ; Offset_0x02D3F2
		clr.b   (HUD_Timer_Refresh_Flag).w                   ; $FFFFFE1E
		lea     (Obj_Memory_Address).w, A0                   ; $FFFFB000
		move.l  A0, A2
		bsr     Kill_Player                            ; Offset_0x02B57C
		move.b  #$01, ($FFFFFE1A).w
		rts   
;-------------------------------------------------------------------------------  
Offset_0x02D408:
		bsr     Offset_0x02D4E0
		tst.b   (HUD_Rings_Refresh_Flag).w                   ; $FFFFFE1D
		beq.s   Offset_0x02D42C
		bpl.s   Offset_0x02D418
		bsr     Offset_0x02D474
Offset_0x02D418:
		clr.b   (HUD_Rings_Refresh_Flag).w                   ; $FFFFFE1D
		move.l  #$5F400003, D0
		moveq   #$00, D1
		move.w  (Ring_Count).w, D1                           ; $FFFFFE20
		bsr     Offset_0x02D538
Offset_0x02D42C:
		move.l  #$5EC00003, D0
		moveq   #$00, D1
		move.b  ($FFFFF62C).w, D1
		bsr     Offset_0x02D618
		tst.b   (HUD_Life_Refresh_Flag).w                    ; $FFFFFE1C
		beq.s   Offset_0x02D44A
		clr.b   (HUD_Life_Refresh_Flag).w                    ; $FFFFFE1C
		bsr     Offset_0x02D6D0
Offset_0x02D44A:
		tst.b   ($FFFFF7D6).w
		beq.s   Offset_0x02D472
		clr.b   ($FFFFF7D6).w
		move.l  #$6E000002, (VDP_Control_Port)               ; $00C00004
		moveq   #$00, D1
		move.w  ($FFFFF7D2).w, D1
		bsr     Offset_0x02D670
		moveq   #$00, D1
		move.w  ($FFFFF7D4).w, D1
		bsr     Offset_0x02D670
Offset_0x02D472:
		rts
Offset_0x02D474:
		move.l  #$5F400003, (VDP_Control_Port)               ; $00C00004
		lea     HUD_Rings_Mask(PC), A2                 ; Offset_0x02D4DC
		move.w  #$0002, D2
		bra.s   Offset_0x02D4A4       
;-------------------------------------------------------------------------------  
Head_Up_Display_Base:                                          ; Offset_0x02D488
		lea     (VDP_Data_Port), A6                          ; $00C00000
		bsr     Offset_0x02D6D0
		move.l  #$5C400003, (VDP_Control_Port)               ; $00C00004
		lea     HUD_ScoreTime_Mask(PC), A2             ; Offset_0x02D4D0
		move.w  #$000E, D2
Offset_0x02D4A4:
		lea     HUD_Art_Numbers(PC), A1                ; Offset_0x02D73A
Offset_0x02D4A8:
		move.w  #$000F, D1
		move.b  (A2)+, D0
		bmi.s   Offset_0x02D4C4
		ext.w   D0
		lsl.w   #$05, D0
		lea     $00(A1, D0), A3
Offset_0x02D4B8:
		move.l  (A3)+, (A6)
		dbra    D1, Offset_0x02D4B8
Offset_0x02D4BE:
		dbra    D2, Offset_0x02D4A8
		rts
Offset_0x02D4C4:
		move.l  #$00000000, (A6)
		dbra    D1, Offset_0x02D4C4
		bra.s   Offset_0x02D4BE                                        
;-------------------------------------------------------------------------------                
HUD_ScoreTime_Mask:                                            ; Offset_0x02D4D0
		dc.l    $16FFFFFF, $FFFFFF00, $00140000  
HUD_Rings_Mask:                                                ; Offset_0x02D4DC    
		dc.l    $FFFF0000   
;-------------------------------------------------------------------------------
Offset_0x02D4E0:
		move.l  #$5C400003, (VDP_Control_Port)               ; $00C00004
		move.w  (Camera_X).w, D1                             ; $FFFFEE00
		swap.w  D1
		move.w  (Player_One_Position_X).w, D1                ; $FFFFB008
		bsr.s   Offset_0x02D500
		move.w  (Camera_Y).w, D1                             ; $FFFFEE04
		swap.w  D1
		move.w  (Player_One_Position_Y).w, D1                ; $FFFFB00C
Offset_0x02D500:
		moveq   #$07, D6
		lea     (HUD_Art_Debug_Numbers), A1            ; Offset_0x02DB7A
Offset_0x02D508:
		rol.w   #$04, D1
		move.w  D1, D2
		andi.w  #$000F, D2
		cmpi.w  #$000A, D2
		bcs.s   Offset_0x02D51A
		addi.w  #$0007, D2
Offset_0x02D51A:
		lsl.w   #$05, D2
		lea     $00(A1, D2), A3
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		swap.w  D1
		dbra    D6, Offset_0x02D508
		rts    
;-------------------------------------------------------------------------------
Offset_0x02D538:
		lea     (HUD_Val_000100), A2                   ; Offset_0x02D604
		moveq   #$02, D6
		bra.s   Offset_0x02D54A
Offset_0x02D542:
		lea     (HUD_Val_100000), A2                   ; Offset_0x02D5F8
		moveq   #$05, D6
Offset_0x02D54A:
		moveq   #$00, D4
		lea     HUD_Art_Numbers(PC), A1                ; Offset_0x02D73A
Offset_0x02D550:
		moveq   #$00, D2
		move.l  (A2)+, D3
Offset_0x02D554:
		sub.l   D3, D1
		bcs.s   Offset_0x02D55C
		addq.w  #$01, D2
		bra.s   Offset_0x02D554
Offset_0x02D55C:
		add.l   D3, D1
		tst.w   D2
		beq.s   Offset_0x02D566
		move.w  #$0001, D4
Offset_0x02D566:
		tst.w   D4
		beq.s   Offset_0x02D594
		lsl.w   #$06, D2
		move.l  D0, $0004(A6)
		lea     $00(A1, D2), A3
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
Offset_0x02D594:
		addi.l  #$00400000, D0
		dbra    D6, Offset_0x02D550
		rts                    
;-------------------------------------------------------------------------------
Time_Count_Down:                                               ; Offset_0x02D5A0
		move.l  #$5F800003, (VDP_Control_Port)               ; $00C00004
		lea     (VDP_Data_Port), A6                          ; $00C00000
		lea     (HUD_Val_000010), A2                   ; Offset_0x02D608
		moveq   #$01, D6
		moveq   #$00, D4
		lea     HUD_Art_Numbers(PC), A1                ; Offset_0x02D73A
Offset_0x02D5BE:
		moveq   #$00, D2
		move.l  (A2)+, D3
Offset_0x02D5C2:
		sub.l   D3, D1
		bcs.s   Offset_0x02D5CA
		addq.w  #$01, D2
		bra.s   Offset_0x02D5C2
Offset_0x02D5CA:
		add.l   D3, D1
		lsl.w   #$06, D2
		lea     $00(A1, D2), A3
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		dbra    D6, Offset_0x02D5BE
		rts
;-------------------------------------------------------------------------------                
HUD_Val_100000:                                                ; Offset_0x02D5F8 
		dc.l    $000186A0
;HUD_Val_010000:                                               ; Offset_0x02D5FC
		dc.l    $00002710
HUD_Val_001000:                                                ; Offset_0x02D600
		dc.l    $000003E8
HUD_Val_000100:                                                ; Offset_0x02D604
		dc.l    $00000064
HUD_Val_000010:                                                ; Offset_0x02D608
		dc.l    $0000000A 
HUD_Val_000001:                                                ; Offset_0x02D60C  
		dc.l    $00000001        
;-------------------------------------------------------------------------------
Offset_0x02D610:
		lea     HUD_Val_000001(PC), A2                 ; Offset_0x02D60C
		moveq   #$00, D6
		bra.s   Offset_0x02D61E
Offset_0x02D618:
		lea     HUD_Val_000010(PC), A2                 ; Offset_0x02D608
		moveq   #$01, D6
Offset_0x02D61E:
		moveq   #$00, D4
		lea     HUD_Art_Numbers(PC), A1                ; Offset_0x02D73A
Offset_0x02D624:
		moveq   #$00, D2
		move.l  (A2)+, D3
Offset_0x02D628:
		sub.l   D3, D1
		bcs.s   Offset_0x02D630
		addq.w  #$01, D2
		bra.s   Offset_0x02D628
Offset_0x02D630:
		add.l   D3, D1
		tst.w   D2
		beq.s   Offset_0x02D63A
		move.w  #$0001, D4
Offset_0x02D63A:
		lsl.w   #$06, D2
		move.l  D0, $0004(A6)
		lea     $00(A1, D2), A3
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		addi.l  #$00400000, D0
		dbra    D6, Offset_0x02D624
		rts    
;-------------------------------------------------------------------------------
Offset_0x02D670:
		lea     HUD_Val_001000(PC), A2                 ; Offset_0x02D600
		moveq   #$03, D6
		moveq   #$00, D4
		lea     HUD_Art_Numbers(PC), A1                ; Offset_0x02D73A
Offset_0x02D67C:
		moveq   #$00, D2
		move.l  (A2)+, D3
Offset_0x02D680:
		sub.l   D3, D1
		bcs.s   Offset_0x02D688
		addq.w  #$01, D2
		bra.s   Offset_0x02D680
Offset_0x02D688:
		add.l   D3, D1
		tst.w   D2
		beq.s   Offset_0x02D692
		move.w  #$0001, D4
Offset_0x02D692:
		tst.w   D4
		beq.s   Offset_0x02D6C2
		lsl.w   #$06, D2
		lea     $00(A1, D2), A3
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
Offset_0x02D6BC:
		dbra    D6, Offset_0x02D67C
		rts
Offset_0x02D6C2:
		moveq   #$0F, D5
Offset_0x02D6C4:
		move.l  #$00000000, (A6)
		dbra    D5, Offset_0x02D6C4
		bra.s   Offset_0x02D6BC
Offset_0x02D6D0:
		move.l  #$7BA00003, D0
		moveq   #$00, D1
		move.b  (Life_Count).w, D1                           ; $FFFFFE12
		lea     HUD_Val_000010(PC), A2                 ; Offset_0x02D608
		moveq   #$01, D6
		moveq   #$00, D4
		lea     HUD_Art_Life_Numbers(PC), A1           ; Offset_0x02DA3A
Offset_0x02D6E8:
		move.l  D0, $0004(A6)
		moveq   #$00, D2
		move.l  (A2)+, D3
Offset_0x02D6F0:
		sub.l   D3, D1
		bcs.s   Offset_0x02D6F8
		addq.w  #$01, D2
		bra.s   Offset_0x02D6F0
Offset_0x02D6F8:
		add.l   D3, D1
		tst.w   D2
		beq.s   Offset_0x02D702
		move.w  #$0001, D4
Offset_0x02D702:
		tst.w   D4
		beq.s   Offset_0x02D728
Offset_0x02D706:
		lsl.w   #$05, D2
		lea     $00(A1, D2), A3
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
		move.l  (A3)+, (A6)
Offset_0x02D71C:
		addi.l  #$00400000, D0
		dbra    D6, Offset_0x02D6E8
		rts
Offset_0x02D728:
		tst.w   D6
		beq.s   Offset_0x02D706
		moveq   #$07, D5
Offset_0x02D72E:
		move.l  #$00000000, (A6)
		dbra    D5, Offset_0x02D72E
		bra.s   Offset_0x02D71C          
;-------------------------------------------------------------------------------                                                
HUD_Art_Numbers:                                               ; Offset_0x02D73A
		incbin  'art/uncompressed/hud_numb.dat'
HUD_Art_Life_Numbers:                                          ; Offset_0x02DA3A
		incbin  'art/uncompressed/hud_num2.dat'
HUD_Art_Debug_Numbers:                                         ; Offset_0x02DB7A  
		incbin  'art/uncompressed/hud_debg.dat'
;===============================================================================
; Rotina para atualizar os contadores na tela (Pontos, Tempo, Vidas...).
; <<<-
;===============================================================================
		nop
Jmp_33_To_ModifySpriteAttr_2P:                                 ; Offset_0x02DE5C                  
		jmp     (ModifySpriteAttr_2P)                  ; Offset_0x00DBBE
		dc.w    $0000    
;===============================================================================
; Modo de depuração
; ->>>
;===============================================================================              
Debug_Mode:                                                    ; Offset_0x02DE64
		moveq   #$00, D0
		move.b  (Debug_Mode_Flag_Index).w, D0                ; $FFFFFE08
		move.w  Debug_Mode_Routine_List(PC, D0), D1    ; Offset_0x02DE72
		jmp     Debug_Mode_Routine_List(PC, D1)        ; Offset_0x02DE72
;-------------------------------------------------------------------------------
Debug_Mode_Routine_List:                                       ; Offset_0x02DE72
		dc.w    Offset_0x02DE76-Debug_Mode_Routine_List
		dc.w    Offset_0x02DEE0-Debug_Mode_Routine_List        
;-------------------------------------------------------------------------------
Offset_0x02DE76:
		addq.b  #$02, (Debug_Mode_Flag_Index).w              ; $FFFFFE08
		move.w  (Sonic_Level_Limits_Min_Y).w, ($FFFFFEF0).w  ; $FFFFEECC
		move.w  ($FFFFEEC6).w, ($FFFFFEF2).w
		andi.w  #$07FF, (Player_One_Position_Y).w            ; $FFFFB00C
		andi.w  #$07FF, (Camera_Y).w                         ; $FFFFEE04
		andi.w  #$07FF, (Camera_Y_x4).w                      ; $FFFFEE0C
		move.b  #$00, Obj_Map_Id(A0)                             ; $001A
		move.b  #$00, Obj_Ani_Number(A0)                         ; $001C
		cmpi.b  #gm_SpecialStage, (Game_Mode).w        ; $10,  $FFFFF600
		bne.s   Offset_0x02DEB0
		moveq   #$06, D0
		bra.s   Offset_0x02DEB6
Offset_0x02DEB0:
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
Offset_0x02DEB6:
		lea     (Debug_Mode_Object_List), A2           ; Offset_0x02E0B2
		add.w   D0, D0
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, D6
		cmp.b   ($FFFFFE06).w, D6
		bhi.s   Offset_0x02DED0
		move.b  #$00, ($FFFFFE06).w                
Offset_0x02DED0:
		bsr     Offset_0x02E092
		move.b  #$0C, ($FFFFFE0A).w
		move.b  #$01, ($FFFFFE0B).w   
;-------------------------------------------------------------------------------
Offset_0x02DEE0:
		moveq   #$06, D0
		cmpi.b  #gm_SpecialStage, (Game_Mode).w        ; $10,  $FFFFF600
		beq.s   Offset_0x02DEF0
		moveq   #$00, D0
		move.b  (Level_Id).w, D0                             ; $FFFFFE10
Offset_0x02DEF0:
		lea     (Debug_Mode_Object_List), A2           ; Offset_0x02E0B2
		add.w   D0, D0
		adda.w  $00(A2, D0), A2
		move.w  (A2)+, D6
		bsr     Offset_0x02DF08
		jmp     (DisplaySprite)                        ; Offset_0x00D322
Offset_0x02DF08:
		moveq   #$00, D4
		move.w  #$0001, D1
		move.b  (Control_Ports_Buffer_Data+$0001).w, D4      ; $FFFFF605
		andi.w  #$000F, D4
		bne.s   Offset_0x02DF4A
		move.b  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
		andi.w  #$000F, D0
		bne.s   Offset_0x02DF32
		move.b  #$0C, ($FFFFFE0A).w
		move.b  #$0F, ($FFFFFE0B).w
		bra     Offset_0x02DFAE
Offset_0x02DF32:
		subq.b  #$01, ($FFFFFE0A).w
		bne.s   Offset_0x02DF4E
		move.b  #$01, ($FFFFFE0A).w
		addq.b  #$01, ($FFFFFE0B).w
		bne.s   Offset_0x02DF4A
		move.b  #$FF, ($FFFFFE0B).w
Offset_0x02DF4A:
		move.b  (Control_Ports_Buffer_Data).w, D4            ; $FFFFF604
Offset_0x02DF4E:
		moveq   #$00, D1
		move.b  ($FFFFFE0B).w, D1
		addq.w  #$01, D1
		swap.w  D1
		asr.l   #$04, D1
		move.l  Obj_Y(A0), D2                                    ; $000C
		move.l  Obj_X(A0), D3                                    ; $0008
		btst    #$00, D4
		beq.s   Offset_0x02DF78
		sub.l   D1, D2
		moveq   #$00, D0
		move.w  (Sonic_Level_Limits_Min_Y).w, D0             ; $FFFFEECC
		swap.w  D0
		cmp.l   D0, D2
		bge.s   Offset_0x02DF78
		move.l  D0, D2
Offset_0x02DF78:
		btst    #$01, D4
		beq.s   Offset_0x02DF92
		add.l   D1, D2
		moveq   #$00, D0
		move.w  ($FFFFEEC6).w, D0
		addi.w  #$00DF, D0
		swap.w  D0
		cmp.l   D0, D2
		blt.s   Offset_0x02DF92
		move.l  D0, D2
Offset_0x02DF92:
		btst    #$02, D4
		beq.s   Offset_0x02DF9E
		sub.l   D1, D3
		bcc.s   Offset_0x02DF9E
		moveq   #$00, D3
Offset_0x02DF9E:
		btst    #$03, D4
		beq.s   Offset_0x02DFA6
		add.l   D1, D3
Offset_0x02DFA6:
		move.l  D2, Obj_Y(A0)                                    ; $000C
		move.l  D3, Obj_X(A0)                                    ; $0008
Offset_0x02DFAE:
		btst    #$06, (Control_Ports_Buffer_Data).w          ; $FFFFF604
		beq.s   Offset_0x02DFE6
		btst    #$05, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Offset_0x02DFCA
		subq.b  #$01, ($FFFFFE06).w
		bcc.s   Offset_0x02DFE2
		add.b   D6, ($FFFFFE06).w
		bra.s   Offset_0x02DFE2
Offset_0x02DFCA:
		btst    #$06, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Offset_0x02DFE6
		addq.b  #$01, ($FFFFFE06).w
		cmp.b   ($FFFFFE06).w, D6
		bhi.s   Offset_0x02DFE2
		move.b  #$00, ($FFFFFE06).w
Offset_0x02DFE2:
		bra     Offset_0x02E092
Offset_0x02DFE6:
		btst    #$05, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Offset_0x02E02A
		jsr     (SingleObjectLoad)                     ; Offset_0x00E6FE
		bne.s   Offset_0x02E02A
		move.w  Obj_X(A0), Obj_X(A1)                      ; $0008, $0008
		move.w  Obj_Y(A0), Obj_Y(A1)                      ; $000C, $000C
		move.b  Obj_Map(A0), Obj_Id(A1)                   ; $0000, $0004
		move.b  Obj_Flags(A0), Obj_Flags(A1)              ; $0001, $0001
		move.b  Obj_Flags(A0), Obj_Status(A1)             ; $0001, $0022
		andi.b  #$7F, Obj_Status(A1)                             ; $0022
		moveq   #$00, D0
		move.b  ($FFFFFE06).w, D0
		lsl.w   #$03, D0
		move.b  $04(A2, D0), Obj_Subtype(A1)                     ; $0028
		rts
Offset_0x02E02A:
		btst    #$04, (Control_Ports_Buffer_Data+$0001).w    ; $FFFFF605
		beq.s   Offset_0x02E090
		moveq   #$00, D0
		move.w  D0, (Debug_Mode_Flag_Index).w                ; $FFFFFE08
		move.l  #Sonic_Mappings, ($FFFFB004).w         ; Offset_0x06FBE0
		move.w  #$0780, ($FFFFB002).w
		tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
		beq.s   Offset_0x02E052
		move.w  #$03C0, ($FFFFB002).w
Offset_0x02E052:
		move.b  D0, ($FFFFB01C).w
		move.w  D0, Obj_Sub_Y(A0)                                ; $000A
		move.w  D0, $000E(A0)
		move.w  Obj_X(A0), (Player_Two_Position_X).w         ; $FFFFB048; $0008
		move.w  Obj_Y(A0), (Player_Two_Position_Y).w         ; $FFFFB04C; $000C
		move.w  ($FFFFFEF0).w, (Sonic_Level_Limits_Min_Y).w  ; $FFFFEECC
		move.w  ($FFFFFEF2).w, ($FFFFEEC6).w
		cmpi.b  #$10, (Game_Mode).w                          ; $FFFFF600
		bne.s   Offset_0x02E090
		move.b  #$02, ($FFFFB01C).w
		bset    #$02, ($FFFFB022).w
		bset    #$01, ($FFFFB022).w
Offset_0x02E090:
		rts
Offset_0x02E092:
		moveq   #$00, D0
		move.b  ($FFFFFE06).w, D0
		lsl.w   #$03, D0
		move.l  $00(A2, D0), Obj_Map(A0)                         ; $0004
		move.w  $06(A2, D0), Obj_Art_VRAM(A0)                    ; $0002
		move.b  $05(A2, D0), Obj_Map_Id(A0)                      ; $001A
		bsr     Jmp_34_To_ModifySpriteAttr_2P          ; Offset_0x02E700
		rts
;-------------------------------------------------------------------------------
Debug_Mode_Object_List:                                        ; Offset_0x02E0B2
		include "_inc/Debug Index.asm"

;===============================================================================  
TilesMainTable:                                                ; Offset_0x02E708
;------------ ; $00
		dc.l    ($04<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($05<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($04<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $01
		dc.l    ($06<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($07<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($05<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $02                
		dc.l    ($08<<$18)|Wood_Tiles                  ; Offset_0x09572C
		dc.l    ($09<<$18)|Wood_Blocks                 ; Offset_0x09478C
		dc.l    ($06<<$18)|Wood_Chunks                 ; Offset_0x099424
;------------ ; $03                
		dc.l    ($0A<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($0B<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($07<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $04                
		dc.l    ($0C<<$18)|Metropolis_Tiles            ; Offset_0x09C314
		dc.l    ($0D<<$18)|Metropolis_Blocks           ; Offset_0x09B054 
		dc.l    ($08<<$18)|Metropolis_Chunks           ; Offset_0x09F854
;------------ ; $05                
		dc.l    ($0C<<$18)|Metropolis_Tiles            ; Offset_0x09C314
		dc.l    ($0D<<$18)|Metropolis_Blocks           ; Offset_0x09B054
		dc.l    ($08<<$18)|Metropolis_Chunks           ; Offset_0x09F854
;------------ ; $06                
		dc.l    ($10<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($11<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($0A<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $07                
		dc.l    ($12<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($13<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($0B<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $08                
		dc.l    ($14<<$18)|Hidden_Palace_Tiles         ; Offset_0x0A3AB4
		dc.l    ($15<<$18)|Hidden_Palace_Blocks        ; Offset_0x0A24D4
		dc.l    ($0C<<$18)|Hidden_Palace_Chunks        ; Offset_0x0A6936
;------------ ; $09                
		dc.l    ($16<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($17<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($0D<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $0A                
		dc.l    ($18<<$18)|Oil_Ocean_Tiles             ; Offset_0x0A9C96
		dc.l    ($19<<$18)|Oil_Ocean_Blocks            ; Offset_0x0A86B6
		dc.l    ($0E<<$18)|Oil_Ocean_Chunks            ; Offset_0x0AC996
;------------ ; $0B                
		dc.l    ($1A<<$18)|Dust_Hill_Tiles             ; Offset_0x0B0146
		dc.l    ($1B<<$18)|Dust_Hill_Blocks            ; Offset_0x0AEE86
		dc.l    ($0F<<$18)|Dust_Hill_Chunks            ; Offset_0x0B3A68
;------------ ; $0C                
		dc.l    ($1C<<$18)|Casino_Night_Tiles          ; Offset_0x0B6F18
		dc.l    ($1D<<$18)|Casino_Night_Blocks         ; Offset_0x0B65B8
		dc.l    ($10<<$18)|Casino_Night_Chunks         ; Offset_0x0B9F62
;------------ ; $0D                
		dc.l    ($1E<<$18)|Chemical_Plant_Tiles        ; Offset_0x0BD452
		dc.l    ($1F<<$18)|Chemical_Plant_Blocks       ; Offset_0x0BBE72
		dc.l    ($11<<$18)|Chemical_Plant_Chunks       ; Offset_0x0C0FA4
;------------ ; $0E                
		dc.l    ($20<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($21<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($12<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;------------ ; $0F                
		dc.l    ($22<<$18)|Neo_Green_Hill_Tiles        ; Offset_0x0C4DA4
		dc.l    ($23<<$18)|Neo_Green_Hill_Blocks       ; Offset_0x0C34A4
		dc.l    ($13<<$18)|Neo_Green_Hill_Chunks       ; Offset_0x0CA586
;------------ ; $10                
		dc.l    ($24<<$18)|Green_Hill_Tiles            ; Offset_0x08C7FE
		dc.l    ($25<<$18)|Green_Hill_Blocks           ; Offset_0x08B85E
		dc.l    ($14<<$18)|Green_Hill_Chunks           ; Offset_0x09152C
;-------------------------------------------------------------------------------
ArtLoadCues:                                                   ; Offset_0x02E7D4
		include "_inc/Pattern Load Cues.asm"

;===============================================================================

Previous_Build_Colision_Array_2_Overwrite_Data:                ; Offset_0x02EDFE
		incbin  'leftovers/pb_c_ar2.dat'
Previous_Build_Green_Hill_Colision_Data_1:                     ; Offset_0x02F2EA
Previous_Build_Hill_Top_Colision_Data_1:                       ; Offset_0x02F2EA
		incbin  'level/shared/ghz_col1.dat'
Previous_Build_Green_Hill_Colision_Data_2:                     ; Offset_0x02F5EA 
Previous_Build_Hill_Top_Colision_Data_2:                       ; Offset_0x02F5EA
		incbin  'level/shared/ghz_col2.dat'
Previous_Build_Wood_Colision_Data_1:                           ; Offset_0x02F8EA
Previous_Build_Wood_Colision_Data_2:                           ; Offset_0x02F8EA
		incbin  'level/wood zone/wz_col.dat'
Previous_Build_Metropolis_Colision_Data_1:                     ; Offset_0x02FBEA
Previous_Build_Metropolis_Colision_Data_2:                     ; Offset_0x02FBEA
		incbin  'level/metropolis zone/mz_col.dat'
Previous_Build_Hidden_Palace_Colision_Data_1_Overwrite_Data:   ; Offset_0x02FEEA  
		incbin  'leftovers/hpzpb_col1.dat'
;-------------------------------------------------------------------------------
Art_GHz_Flower_1:                                              ; Offset_0x030000
Art_HTz_Flower_1:                                              ; Offset_0x030000
		incbin  'art/uncompressed/flower_1.dat'
Art_GHz_Flower_2:                                              ; Offset_0x030080                 
Art_HTz_Flower_2:                                              ; Offset_0x030080                                
		incbin  'art/uncompressed/flower_2.dat'
Art_GHz_Flower_3:                                              ; Offset_0x030100 
Art_HTz_Flower_3:                                              ; Offset_0x030100
		incbin  'art/uncompressed/flower_3.dat'
Art_GHz_Flower_4:                                              ; Offset_0x030180                   
Art_HTz_Flower_4:                                              ; Offset_0x030180   
		incbin  'art/uncompressed/flower_4.dat'
Art_GHz_Dyn_Wall:                                              ; Offset_0x030200
Art_HTz_Dyn_Wall:                                              ; Offset_0x030200 
		incbin  'art/uncompressed/dyn_wall.dat'
Art_Hill_Top_Background:                                       ; Offset_0x030300
		incbin  'art/nemesis/backgnd.nem'
Art_Hill_Top_Background_Uncomp:                                ; Offset_0x030C2A 
		incbin  'art/uncompressed/htzbackgnd.dat'
Art_Mz_Spinnig_Cylinder:                                       ; Offset_0x03102A
		incbin  'art/uncompressed/spin_cyl.dat'
Art_Mz_Lava:                                                   ; Offset_0x03202A
		incbin  'art/uncompressed/lava.dat'
Art_Mz_Pistons:                                                ; Offset_0x03262A
		incbin  'art/uncompressed/pistons.dat'
Art_HPz_Background:                                            ; Offset_0x03286A
		incbin  'art/uncompressed/backgnd.dat'                                  
Art_HPz_Orbs:                                                  ; Offset_0x032C6A
		incbin  'art/uncompressed/orbs.dat'
Art_OOz_Red_Balls:                                             ; Offset_0x032F6A
		incbin  'art/uncompressed/red_ball.dat'
Art_OOz_Rotating_Square_1:                                     ; Offset_0x0330EA
		incbin  'art/uncompressed/r_squar1.dat'
Art_OOz_Rotating_Square_2:                                     ; Offset_0x0332EA
		incbin  'art/uncompressed/r_squar2.dat'
Art_OOz_Oil_1:                                                 ; Offset_0x0334EA
		incbin  'art/uncompressed/oil_1.dat'
Art_OOz_Oil_2:                                                 ; Offset_0x033CEA
		incbin  'art/uncompressed/oil_2.dat'
Art_CNz_Blue_Cards:                                            ; Offset_0x0344EA
		incbin  'art/uncompressed/bluecard.dat' 
Art_CNz_Pink_Cards:                                            ; Offset_0x034DEA
		incbin  'art/uncompressed/pinkcard.dat'
Art_CNz_Slot_Machine_Checks:                                   ; Offset_0x0357EA
		incbin  'art/uncompressed/sm_check.dat'                
Art_CPz_Dyn_Background:                                        ; Offset_0x0363EA
		incbin  'art/uncompressed/cpzbackgnd.dat' 
Art_NGHz_Water_Falls_1:                                        ; Offset_0x0365EA
		incbin  'art/uncompressed/water_f1.dat'
Art_NGHz_Water_Falls_2:                                        ; Offset_0x0366EA
		incbin  'art/uncompressed/water_f2.dat'
Art_NGHz_Water_Falls_3:                                        ; Offset_0x0367EA
		incbin  'art/uncompressed/water_f3.dat'                                
AngleMap:                                                      ; Offset_0x0368EA 
		incbin  'collision data/anglemap.dat'
Colision_Array_1:                                              ; Offset_0x0369EA 
		incbin  'collision data/c_array1.dat'
Colision_Array_2:                                              ; Offset_0x0379EA
		incbin  'collision data/c_array2.dat'
Green_Hill_Colision_Data_1:                                    ; Offset_0x0389EA
Hill_Top_Colision_Data_1:                                      ; Offset_0x0389EA
		incbin  'level/shared/ghz_col1.dat'
Green_Hill_Colision_Data_2:                                    ; Offset_0x038CEA 
Hill_Top_Colision_Data_2:                                      ; Offset_0x038CEA
		incbin  'level/shared/ghz_col2.dat'
Wood_Colision_Data_1:                                          ; Offset_0x038FEA
Wood_Colision_Data_2:                                          ; Offset_0x038FEA
		incbin  'level/wood zone/wz_col.dat'
Metropolis_Colision_Data_1:                                    ; Offset_0x0392EA
Metropolis_Colision_Data_2:                                    ; Offset_0x0392EA
		incbin  'level/metropolis zone/mz_col.dat'
Hidden_Palace_Colision_Data_1:                                 ; Offset_0x0395EA  
		incbin  'level/hidden palace zone/hpz_col1.dat'
Hidden_Palace_Colision_Data_2:                                 ; Offset_0x0398EA  
		incbin  'level/hidden palace zone/hpz_col2.dat'
Oil_Ocean_Colision_Data_1:                                     ; Offset_0x039BEA 
Oil_Ocean_Colision_Data_2:                                     ; Offset_0x039BEA 
		incbin  'level/oil ocean zone/ooz_col.dat'
Dust_Hill_Colision_Data_1:                                     ; Offset_0x039EEA
Dust_Hill_Colision_Data_2:                                     ; Offset_0x039EEA
		incbin  'level/dust hill zone/dhz_col.dat'
Casino_Night_Colision_Data_1:                                  ; Offset_0x03A1EA
		incbin  'level/casino night zone/cnz_col1.dat'
Casino_Night_Colision_Data_2:                                  ; Offset_0x03A4EA
		incbin  'level/casino night zone/cnz_col2.dat'
Chemical_Plant_Colision_Data_1:                                ; Offset_0x03A7EA
		incbin  'level/chemical plant zone/cpz_col1.dat'
Chemical_Plant_Colision_Data_2:                                ; Offset_0x03AAEA
		incbin  'level/chemical plant zone/cpz_col2.dat'
Neo_Green_Hill_Colision_Data_1:                                ; Offset_0x03ADEA 
		incbin  'level/neo green hill zone/nghzcol1.dat'
Neo_Green_Hill_Colision_Data_2:                                ; Offset_0x03B0EA
		incbin  'level/neo green hill zone/nghzcol2.dat'
Lvl1_Colision_Data_1:                                          ; Offset_0x03B3EA
Lvl1_Colision_Data_2:                                          ; Offset_0x03B3EA
Lvl3_Colision_Data_1:                                          ; Offset_0x03B3EA
Lvl3_Colision_Data_2:                                          ; Offset_0x03B3EA
Lvl6_Colision_Data_1:                                          ; Offset_0x03B3EA
Lvl6_Colision_Data_2:                                          ; Offset_0x03B3EA      
Lvl9_Colision_Data_1:                                          ; Offset_0x03B3EA
Lvl9_Colision_Data_2:                                          ; Offset_0x03B3EA                                                                              
Genocide_City_Colision_Data_1:                                 ; Offset_0x03B3EA
Genocide_City_Colision_Data_2:                                 ; Offset_0x03B3EA
Death_Egg_Colision_Data_1:                                     ; Offset_0x03B3EA                          
Death_Egg_Colision_Data_2:                                     ; Offset_0x03B3EA  
		    
Special_Stage_1:                                               ; Offset_0x03B3EA
		incbin  'level/special stage/stage_1.eni'
Special_Stage_2:                                               ; Offset_0x03B664
		incbin  'level/special stage/stage_2.eni'
Special_Stage_3:                                               ; Offset_0x03BA76
		incbin  'level/special stage/stage_3.eni'
Special_Stage_4:                                               ; Offset_0x03BDD2
		incbin  'level/special stage/stage_4.eni'
Special_Stage_5:                                               ; Offset_0x03C2AC
		incbin  'level/special stage/stage_5.eni'
Special_Stage_6:                                               ; Offset_0x03C75C                    
		incbin  'level/special stage/stage_6.eni'
;=============================================================================== 
; Leiaute das fases
; ->>>
;===============================================================================  
Level_Layout:                                                  ; Offset_0x03CA4E
;------------ ; $00
		dc.w    GHz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x03CAD6
		dc.w    GHz_Background_Map_Act_1-Level_Layout  ; Offset_0x03DADA
		dc.w    GHz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x03D2D8
		dc.w    GHz_Background_Map_Act_2-Level_Layout  ; Offset_0x03DADA
;------------ ; $01                
		dc.w    Lvl1_Foreground_Map_Act_1-Level_Layout ; Offset_0x03DAE4
		dc.w    Lvl1_Background_Map_Act_1-Level_Layout ; Offset_0x03DAE4
		dc.w    Lvl1_Foreground_Map_Act_2-Level_Layout ; Offset_0x03DAE4
		dc.w    Lvl1_Background_Map_Act_2-Level_Layout ; Offset_0x03DAE4
;------------ ; $02                
		dc.w    Wz_Foreground_Map_Act_1-Level_Layout   ; Offset_0x03DAE8
		dc.w    Wz_Background_Map_Act_1-Level_Layout   ; Offset_0x03EAEC
		dc.w    Wz_Foreground_Map_Act_2-Level_Layout   ; Offset_0x03E2EA
		dc.w    Wz_Background_Map_Act_2-Level_Layout   ; Offset_0x03F2EE
;------------ ; $03                
		dc.w    Lvl3_Foreground_Map_Act_1-Level_Layout ; Offset_0x03FAF0
		dc.w    Lvl3_Background_Map_Act_1-Level_Layout ; Offset_0x03FAF0
		dc.w    Lvl3_Foreground_Map_Act_2-Level_Layout ; Offset_0x03FAF0
		dc.w    Lvl3_Background_Map_Act_2-Level_Layout ; Offset_0x03FAF0
;------------ ; $04                
		dc.w    Mz_Foreground_Map_Act_1-Level_Layout   ; Offset_0x03FAF4
		dc.w    Mz_Background_Map_Act_1-Level_Layout   ; Offset_0x040AF8
		dc.w    Mz_Foreground_Map_Act_2-Level_Layout   ; Offset_0x0402F6
		dc.w    Mz_Background_Map_Act_2-Level_Layout   ; Offset_0x040AF8
;------------ ; $05                
		dc.w    Mz_Foreground_Map_Act_3-Level_Layout   ; Offset_0x040B5A
		dc.w    Mz_Background_Map_Act_3-Level_Layout   ; Offset_0x040AF8
		dc.w    Mz_Foreground_Map_Act_4-Level_Layout   ; Offset_0x040B5A
		dc.w    Mz_Background_Map_Act_4-Level_Layout   ; Offset_0x040AF8
;------------ ; $06                
		dc.w    Lvl6_Foreground_Map_Act_1-Level_Layout ; Offset_0x04135C
		dc.w    Lvl6_Background_Map_Act_1-Level_Layout ; Offset_0x04135C
		dc.w    Lvl6_Foreground_Map_Act_2-Level_Layout ; Offset_0x04135C
		dc.w    Lvl6_Background_Map_Act_2-Level_Layout ; Offset_0x04135C
;------------ ; $07                
		dc.w    HTz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x041360
		dc.w    HTz_Background_Map_Act_1-Level_Layout  ; Offset_0x042364
		dc.w    HTz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x041B62
		dc.w    HTz_Background_Map_Act_2-Level_Layout  ; Offset_0x042B66
;------------ ; $08                
		dc.w    HPz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x043368
		dc.w    HPz_Background_Map_Act_1-Level_Layout  ; Offset_0x043B6A
		dc.w    HPz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x043368
		dc.w    HPz_Background_Map_Act_2-Level_Layout  ; Offset_0x043B6A
;------------ ; $09                
		dc.w    Lvl9_Foreground_Map_Act_1-Level_Layout ; Offset_0x043BB4
		dc.w    Lvl9_Background_Map_Act_1-Level_Layout ; Offset_0x043BB4
		dc.w    Lvl9_Foreground_Map_Act_2-Level_Layout ; Offset_0x043BB4
		dc.w    Lvl9_Background_Map_Act_2-Level_Layout ; Offset_0x043BB4
;------------ ; $0A                
		dc.w    OOz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x043BB8
		dc.w    OOz_Background_Map_Act_1-Level_Layout  ; Offset_0x044BBC
		dc.w    OOz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x0443BA
		dc.w    OOz_Background_Map_Act_2-Level_Layout  ; Offset_0x044BBC
;------------ ; $0B                
		dc.w    DHz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x044BD6
		dc.w    DHz_Background_Map_Act_1-Level_Layout  ; Offset_0x045BDA
		dc.w    DHz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x0453D8
		dc.w    DHz_Background_Map_Act_2-Level_Layout  ; Offset_0x045BDA
;------------ ; $0C                
		dc.w    CNz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x045BEC
		dc.w    CNz_Background_Map_Act_1-Level_Layout  ; Offset_0x046BF0
		dc.w    CNz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x0463EE
		dc.w    CNz_Background_Map_Act_2-Level_Layout  ; Offset_0x046BF0
;------------ ; $0D                
		dc.w    CPz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x046BFA
		dc.w    CPz_Background_Map_Act_1-Level_Layout  ; Offset_0x047BFE
		dc.w    CPz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x0473FC
		dc.w    CPz_Background_Map_Act_2-Level_Layout  ; Offset_0x047BFE
;------------ ; $0E                
		dc.w    GCz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x047C2A
		dc.w    GCz_Background_Map_Act_1-Level_Layout  ; Offset_0x047C2A
		dc.w    GCz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x047C2A
		dc.w    GCz_Background_Map_Act_2-Level_Layout  ; Offset_0x047C2A
;------------ ; $0F                
		dc.w    NGHz_Foreground_Map_Act_1-Level_Layout ; Offset_0x047C2E
		dc.w    NGHz_Background_Map_Act_1-Level_Layout ; Offset_0x048C32
		dc.w    NGHz_Foreground_Map_Act_2-Level_Layout ; Offset_0x048430
		dc.w    NGHz_Background_Map_Act_2-Level_Layout ; Offset_0x049434
;------------ ; $10                
		dc.w    DEz_Foreground_Map_Act_1-Level_Layout  ; Offset_0x049C36
		dc.w    DEz_Background_Map_Act_1-Level_Layout  ; Offset_0x049C36
		dc.w    DEz_Foreground_Map_Act_2-Level_Layout  ; Offset_0x049C36
		dc.w    DEz_Background_Map_Act_2-Level_Layout  ; Offset_0x049C36
;-------------------------------------------------------------------------------
GHz_Foreground_Map_Act_1:                                      ; Offset_0x03CAD6
		incbin  'level/emerald hill zone/fg_map1.dat'
GHz_Foreground_Map_Act_2:                                      ; Offset_0x03D2D8
		incbin  'level/emerald hill zone/fg_map2.dat'
GHz_Background_Map_Act_1:                                      ; Offset_0x03DADA
GHz_Background_Map_Act_2:                                      ; Offset_0x03DADA
		incbin  'level/emerald hill zone/bg_map.dat'
Lvl1_Foreground_Map_Act_1:                                     ; Offset_0x03DAE4
Lvl1_Background_Map_Act_1:                                     ; Offset_0x03DAE4
Lvl1_Foreground_Map_Act_2:                                     ; Offset_0x03DAE4
Lvl1_Background_Map_Act_2:                                     ; Offset_0x03DAE4
		dc.b    $00      ; Tamanho X 
		dc.b    $00      ; Tamanho Y
		dc.b    $00, $00 ; Dados
Wz_Foreground_Map_Act_1:                                       ; Offset_0x03DAE8
		incbin  'level/wood zone/fg_map1.dat'
Wz_Foreground_Map_Act_2:                                       ; Offset_0x03E2EA
		incbin  'level/wood zone/fg_map2.dat'
Wz_Background_Map_Act_1:                                       ; Offset_0x03EAEC
		incbin  'level/wood zone/bg_map1.dat'
Wz_Background_Map_Act_2:                                       ; Offset_0x03F2EE
		incbin  'level/wood zone/bg_map2.dat'
Lvl3_Foreground_Map_Act_1:                                     ; Offset_0x03FAF0
Lvl3_Background_Map_Act_1:                                     ; Offset_0x03FAF0
Lvl3_Foreground_Map_Act_2:                                     ; Offset_0x03FAF0
Lvl3_Background_Map_Act_2:                                     ; Offset_0x03FAF0
		dc.b    $00      ; Tamanho X 
		dc.b    $00      ; Tamanho Y
		dc.b    $00, $00 ; Dados
Mz_Foreground_Map_Act_1:                                       ; Offset_0x03FAF4
		incbin  'level/metropolis zone/fg_map1.dat'
Mz_Foreground_Map_Act_2:                                       ; Offset_0x0402F6
		incbin  'level/metropolis zone/fg_map2.dat'
Mz_Background_Map_Act_1:                                       ; Offset_0x040AF8
Mz_Background_Map_Act_2:                                       ; Offset_0x040AF8
Mz_Background_Map_Act_3:                                       ; Offset_0x040AF8
Mz_Background_Map_Act_4:                                       ; Offset_0x040AF8
		incbin  'level/metropolis zone/bg_map.dat'
Mz_Foreground_Map_Act_3:                                       ; Offset_0x040B5A
Mz_Foreground_Map_Act_4:                                       ; Offset_0x040B5A
		incbin  'level/metropolis zone/fg_map3.dat'               
Lvl6_Foreground_Map_Act_1:                                     ; Offset_0x04135C
Lvl6_Background_Map_Act_1:                                     ; Offset_0x04135C
Lvl6_Foreground_Map_Act_2:                                     ; Offset_0x04135C
Lvl6_Background_Map_Act_2:                                     ; Offset_0x04135C
		dc.b    $00      ; Tamanho X 
		dc.b    $00      ; Tamanho Y
		dc.b    $00, $00 ; Dados
HTz_Foreground_Map_Act_1:                                      ; Offset_0x041360
		incbin  'level/hill top zone/fg_map1.dat'
HTz_Foreground_Map_Act_2:                                      ; Offset_0x041B62
		incbin  'level/hill top zone/fg_map2.dat'
HTz_Background_Map_Act_1:                                      ; Offset_0x042364
		incbin  'level/hill top zone/bg_map1.dat'
HTz_Background_Map_Act_2:                                      ; Offset_0x042B66                
		incbin  'level/hill top zone/bg_map2.dat'
HPz_Foreground_Map_Act_1:                                      ; Offset_0x043368
HPz_Foreground_Map_Act_2:                                      ; Offset_0x043368
		incbin  'level/hidden palace zone/fg_map.dat'
HPz_Background_Map_Act_1:                                      ; Offset_0x043B6A   
HPz_Background_Map_Act_2:                                      ; Offset_0x043B6A
		incbin  'level/hidden palace zone/bg_map.dat'
Lvl9_Foreground_Map_Act_1:                                     ; Offset_0x043BB4
Lvl9_Background_Map_Act_1:                                     ; Offset_0x043BB4
Lvl9_Foreground_Map_Act_2:                                     ; Offset_0x043BB4
Lvl9_Background_Map_Act_2:                                     ; Offset_0x043BB4
		dc.b    $00      ; Tamanho X 
		dc.b    $00      ; Tamanho Y
		dc.b    $00, $00 ; Dados
OOz_Foreground_Map_Act_1:                                      ; Offset_0x043BB8
		incbin  'level/oil ocean zone/fg_map1.dat'
OOz_Foreground_Map_Act_2:                                      ; Offset_0x0443BA
		incbin  'level/oil ocean zone/fg_map2.dat'
OOz_Background_Map_Act_1:                                      ; Offset_0x044BBC  
OOz_Background_Map_Act_2:                                      ; Offset_0x044BBC
		incbin  'level/oil ocean zone/bg_map.dat'                        
DHz_Foreground_Map_Act_1:                                      ; Offset_0x044BD6
		incbin  'level/dust hill zone/fg_map1.dat'
DHz_Foreground_Map_Act_2:                                      ; Offset_0x0453D8
		incbin  'level/dust hill zone/fg_map2.dat'
DHz_Background_Map_Act_1:                                      ; Offset_0x045BDA
DHz_Background_Map_Act_2:                                      ; Offset_0x045BDA
		incbin  'level/dust hill zone/bg_map.dat'
CNz_Foreground_Map_Act_1:                                      ; Offset_0x045BEC
		incbin  'level/casino night zone/fg_map1.dat'
CNz_Foreground_Map_Act_2:                                      ; Offset_0x0463EE
		incbin  'level/casino night zone/fg_map2.dat'
CNz_Background_Map_Act_1:                                      ; Offset_0x046BF0
CNz_Background_Map_Act_2:                                      ; Offset_0x046BF0
		incbin  'level/casino night zone/bg_map.dat'
CPz_Foreground_Map_Act_1:                                      ; Offset_0x046BFA
		incbin  'level/chemical plant zone/fg_map1.dat'
CPz_Foreground_Map_Act_2:                                      ; Offset_0x0473FC
		incbin  'level/chemical plant zone/fg_map2.dat'
CPz_Background_Map_Act_1:                                      ; Offset_0x047BFE 
CPz_Background_Map_Act_2:                                      ; Offset_0x047BFE
		incbin  'level/chemical plant zone/bg_map.dat'
GCz_Foreground_Map_Act_1:                                      ; Offset_0x047C2A
GCz_Background_Map_Act_1:                                      ; Offset_0x047C2A
GCz_Foreground_Map_Act_2:                                      ; Offset_0x047C2A
GCz_Background_Map_Act_2:                                      ; Offset_0x047C2A
		dc.b    $00      ; Tamanho X 
		dc.b    $00      ; Tamanho Y
		dc.b    $00, $00 ; Dados
NGHz_Foreground_Map_Act_1:                                     ; Offset_0x047C2E
		incbin  'level/neo green hill zone/fg_map1.dat'
NGHz_Foreground_Map_Act_2:                                     ; Offset_0x048430
		incbin  'level/neo green hill zone/fg_map2.dat'
NGHz_Background_Map_Act_1:                                     ; Offset_0x048C32
		incbin  'level/neo green hill zone/bg_map1.dat'
NGHz_Background_Map_Act_2:                                     ; Offset_0x049434
		incbin  'level/neo green hill zone/bg_map2.dat'
DEz_Foreground_Map_Act_1:                                      ; Offset_0x049C36
DEz_Background_Map_Act_1:                                      ; Offset_0x049C36
DEz_Foreground_Map_Act_2:                                      ; Offset_0x049C36
DEz_Background_Map_Act_2:                                      ; Offset_0x049C36    
		dc.b    $00      ; Tamanho X 
		dc.b    $00      ; Tamanho Y
		dc.b    $00, $00 ; Dados
;=============================================================================== 
; Leiaute das fases
; <<<-
;===============================================================================  
; Anel gigante para acesso aos estágios especiais.
; Não usado, left over do Sonic 1.
Art_Big_Ring:                                                  ; Offset_0x049C3A
		incbin  'art/uncompressed/big_ring.dat'
Previous_Build_Art_Big_Ring_Overwrite:                         ; Offset_0x04A87A
		incbin  'art/uncompressed/pbigring.dat'
;-------------------------------------------------------------------------------
; Dados no formato nemesis sobrescritos.
; Tiles 8x8 da fase Star Light do Sonic 1. 
; No disassembly do Sonic 1J estes dados são os mesmos presentes no arquivo 
; "Sonic_1_Jap/Data/SLz/Tiles.nem" (0x0BF4 á 0x1377)
; ->>> 
;-------------------------------------------------------------------------------               
Star_Light_Tiles_Overwrite:                                    ; Offset_0x04A87C
		incbin  'level/star light zone/tiles.dat'                
;-------------------------------------------------------------------------------
; Dados no formato nemesis sobrescritos.
; Tiles 8x8 da fase Star Light do Sonic 1.    
; No disassembly do Sonic 1J estes dados são os mesmos presentes no arquivo 
; "Sonic_1_Jap/Data/SLz/Tiles.nem" (0x0BF4 á 0x1377)
; <<<- 
;-------------------------------------------------------------------------------                  
;===============================================================================
; Leiaute dos objetos nas fases
; ->>>
;===============================================================================
Objects_Layout:                                                ; Offset_0x04C000
		dc.w    GHz_Obj_Act1-Objects_Layout            ; Offset_0x04C04A
		dc.w    GHz_Obj_Act2-Objects_Layout            ; Offset_0x04C302
		dc.w    Lvl1_Obj_Act1-Objects_Layout           ; Offset_0x04ED20
		dc.w    Lvl1_Obj_Act2-Objects_Layout           ; Offset_0x04ED20
		dc.w    Wz_Obj_Act1-Objects_Layout             ; Offset_0x04ED20
		dc.w    Wz_Obj_Act2-Objects_Layout             ; Offset_0x04ED20
		dc.w    Lvl3_Obj_Act1-Objects_Layout           ; Offset_0x04ED20
		dc.w    Lvl3_Obj_Act2-Objects_Layout           ; Offset_0x04ED20
		dc.w    Mz_Obj_Act1-Objects_Layout             ; Offset_0x04C638
		dc.w    Mz_Obj_Act2-Objects_Layout             ; Offset_0x04CA04
		dc.w    Mz_Obj_Act3-Objects_Layout             ; Offset_0x04CDD0
		dc.w    Mz_Obj_Act4-Objects_Layout             ; Offset_0x04CDD0
		dc.w    Lvl6_Obj_Act1-Objects_Layout           ; Offset_0x04ED20
		dc.w    Lvl6_Obj_Act2-Objects_Layout           ; Offset_0x04ED20
		dc.w    HTz_Obj_Act1-Objects_Layout            ; Offset_0x04D214
		dc.w    HTz_Obj_Act2-Objects_Layout            ; Offset_0x04D4A2
		dc.w    HPz_Obj_Act1-Objects_Layout            ; Offset_0x04D958
		dc.w    HPz_Obj_Act2-Objects_Layout            ; Offset_0x04DA60
		dc.w    Lvl9_Obj_Act1-Objects_Layout           ; Offset_0x04ED20
		dc.w    Lvl9_Obj_Act2-Objects_Layout           ; Offset_0x04ED20
		dc.w    OOz_Obj_Act1-Objects_Layout            ; Offset_0x04DA6C
		dc.w    OOz_Obj_Act2-Objects_Layout            ; Offset_0x04DBCE
		dc.w    DHz_Obj_Act1-Objects_Layout            ; Offset_0x04DDBA
		dc.w    DHz_Obj_Act2-Objects_Layout            ; Offset_0x04E06C
		dc.w    CNz_Obj_Act1-Objects_Layout            ; Offset_0x04ED20
		dc.w    CNz_Obj_Act2-Objects_Layout            ; Offset_0x04ED20
		dc.w    CPz_Obj_Act1-Objects_Layout            ; Offset_0x04E384
		dc.w    CPz_Obj_Act2-Objects_Layout            ; Offset_0x04E61E
		dc.w    GCz_Obj_Act1-Objects_Layout            ; Offset_0x04ED20
		dc.w    GCz_Obj_Act2-Objects_Layout            ; Offset_0x04ED20
		dc.w    NGHz_Obj_Act1-Objects_Layout           ; Offset_0x04E9BA
		dc.w    NGHz_Obj_Act2-Objects_Layout           ; Offset_0x04EB8E
		dc.w    DEz_Obj_Act1-Objects_Layout            ; Offset_0x04ED20
		dc.w    DEz_Obj_Act2-Objects_Layout            ; Offset_0x04ED20   
;-------------------------------------------------------------------------------                 
		dc.w    $FFFF, $0000, $0000       
GHz_Obj_Act1:                                                  ; Offset_0x04C04A
		incbin  'level/emerald hill zone/obj_act1.dat'
GHz_Obj_Act2:                                                  ; Offset_0x04C302
		incbin  'level/emerald hill zone/obj_act2.dat'
Mz_Obj_Act1:                                                   ; Offset_0x04C638
		incbin  'level/metropolis zone/obj_act1.dat'
Mz_Obj_Act2:                                                   ; Offset_0x04CA04
		incbin  'level/metropolis zone/obj_act2.dat'
Mz_Obj_Act3:                                                   ; Offset_0x04CDD0
Mz_Obj_Act4:                                                   ; Offset_0x04CDD0
		incbin  'level/metropolis zone/obj_act3.dat'
HTz_Obj_Act1:                                                  ; Offset_0x04D214
		incbin  'level/hill top zone/obj_act1.dat'
HTz_Obj_Act2:                                                  ; Offset_0x04D4A2
		incbin  'level/hill top zone/obj_act2.dat'
HPz_Obj_Act1:                                                  ; Offset_0x04D958
		incbin  'level/hidden palace zone/obj_act.dat'
HPz_Obj_Act2:                                                  ; Offset_0x04DA60
		dc.w    $FFFF, $0000, $0000 
		dc.w    $FFFF, $0000, $0000 
OOz_Obj_Act1:                                                  ; Offset_0x04DA6C
		incbin  'level/oil ocean zone/obj_act1.dat'
OOz_Obj_Act2:                                                  ; Offset_0x04DBCE
		incbin  'level/oil ocean zone/obj_act2.dat'
DHz_Obj_Act1:                                                  ; Offset_0x04DDBA
		incbin  'level/dust hill zone/obj_act1.dat'
DHz_Obj_Act2:                                                  ; Offset_0x04E06C
		incbin  'level/dust hill zone/obj_act2.dat'       
CPz_Obj_Act1:                                                  ; Offset_0x04E384
		incbin  'level/chemical plant zone/obj_act1.dat'
CPz_Obj_Act2:                                                  ; Offset_0x04E61E
		incbin  'level/chemical plant zone/obj_act2.dat'
NGHz_Obj_Act1:                                                 ; Offset_0x04E9BA
		incbin  'level/neo green hill zone/obj_act1.dat'
NGHz_Obj_Act2:                                                 ; Offset_0x04EB8E
		incbin  'level/neo green hill zone/obj_act2.dat'
GCz_Obj_Act1:                                                  ; Offset_0x04ED20
GCz_Obj_Act2:                                                  ; Offset_0x04ED20
CNz_Obj_Act1:                                                  ; Offset_0x04ED20  
CNz_Obj_Act2:                                                  ; Offset_0x04ED20
Lvl1_Obj_Act1:                                                 ; Offset_0x04ED20
Lvl1_Obj_Act2:                                                 ; Offset_0x04ED20
Wz_Obj_Act1:                                                   ; Offset_0x04ED20
Wz_Obj_Act2:                                                   ; Offset_0x04ED20
Lvl3_Obj_Act1:                                                 ; Offset_0x04ED20
Lvl3_Obj_Act2:                                                 ; Offset_0x04ED20
Lvl6_Obj_Act1:                                                 ; Offset_0x04ED20
Lvl6_Obj_Act2:                                                 ; Offset_0x04ED20
Lvl9_Obj_Act1:                                                 ; Offset_0x04ED20
Lvl9_Obj_Act2:                                                 ; Offset_0x04ED20
DEz_Obj_Act1:                                                  ; Offset_0x04ED20
DEz_Obj_Act2:                                                  ; Offset_0x04ED20   
		dc.w    $FFFF, $0000, $0000  
		dc.w    $0000   
;-------------------------------------------------------------------------------
; Dados no formato kosinski sobrescritos.
; Tiles 8x8 da fase Star Light do Sonic 1. 
; No disassembly do Sonic 1J estes dados são os mesmos presentes no arquivo 
; "Sonic_1_Jap/Data/SLz/Chunks.kos" (0x054C á 0x1377)
; ->>> 
;-------------------------------------------------------------------------------               
Star_Light_Chunks_Overwrite:                                   ; Offset_0x04ED28
		incbin  'level/star light zone/chunks.dat'
;-------------------------------------------------------------------------------
; Dados no formato kosinski sobrescritos.
; Tiles 8x8 da fase Star Light do Sonic 1. 
; No disassembly do Sonic 1J estes dados são os mesmos presentes no arquivo 
; "Sonic_1_Jap/Data/SLz/Chunks.kos" (0x054C á 0x1377)
; <<<- 
;-------------------------------------------------------------------------------    
			   
;===============================================================================
; Leiaute dos objetos nas fases
; <<<-
;===============================================================================  
Art_Sonic:                                                     ; Offset_0x050000
		incbin  'art/uncompressed/sonic.dat'
Art_Miles:                                                     ; Offset_0x064320
		incbin  'art/uncompressed/miles.dat'
;-------------------------------------------------------------------------------
Sonic_Mappings:                                                ; Offset_0x06FBE0
		include "Map/Sonic.asm"
;-------------------------------------------------------------------------------
Sonic_Dyn_Script:                                               ; Offset_0x0714E0
		include "Map/SonicPLC.asm"
;-------------------------------------------------------------------------------
Art_Shield:                                                    ; Offset_0x071D8E
		incbin  'art/nemesis/shield.nem'  
Art_Invencibility_Stars:                                       ; Offset_0x071F14   
		incbin  'art/nemesis/invstars.nem' 
Art_Water_Splash_Dust:                                         ; Offset_0x071FFC  
		incbin  'art/uncompressed/spshdust.dat'
Art_Water_Splash:                                              ; Offset_0x07393C                  
		incbin  'art/nemesis/w_splash.nem'                               
;-------------------------------------------------------------------------------  
Miles_Mappings:                                                ; Offset_0x0739E2             
		include "Map/Tails.asm"
;-------------------------------------------------------------------------------
Miles_Dyn_Script:                                              ; Offset_0x07446C
		include "Map/TailsPLC.asm"
;-------------------------------------------------------------------------------  
Art_SEGA:                                                      ; Offset_0x074876
		incbin  'art/nemesis/sega.nem'
Sega_Mappings:                                                 ; Offset_0x074CE6                
		incbin  'map/eni/sega.eni'
TS_Wings_Sonic_Mappings:                                       ; Offset_0x074DE2
		incbin  'map/eni/titlescr.eni'
Title_Screen_Bg_Mappings:                                      ; Offset_0x074F3A
		incbin  'map/eni/titscrbg.eni'
Title_Screen_R_Bg_Mappings:                                    ; Offset_0x0751EE
		incbin  'map/eni/titscrb2.eni'
Art_Title_Screen_Bg_Wings:                                     ; Offset_0x075436
		incbin  'art/nemesis/titlescr.nem' ; Title Screen Wings and background
Art_Title_Screen_Sonic_Miles:                                  ; Offset_0x076D98
		incbin  'art/nemesis/sncmlscr.nem' ; Sonic And Miles in Title Screen
Art_FireBall:                                                  ; Offset_0x0778DC
		incbin  'art/nemesis/fireball.nem'
Art_GHz_Waterfall:                                             ; Offset_0x077A52
		incbin  'art/nemesis/ehzwatrfall.nem'               
Art_HTz_Lava_Bubble:                                           ; Offset_0x077B58
		incbin  'art/nemesis/lvbubble.nem' 
Art_GHz_Bridge:                                                ; Offset_0x077CA6
		incbin  'art/nemesis/ehzbridge.nem'  
Art_HTz_Teleferic:                                             ; Offset_0x077D7E
		incbin  'art/nemesis/telefrcs.nem'               
Art_HTz_Automatic_Door:                                        ; Offset_0x078072 
		incbin  'art/nemesis/htzautodoor.nem'                  
Art_HTz_See_saw:                                               ; Offset_0x0780EA
		incbin  'art/nemesis/see-saw.nem' 
Art_Unk_Fireball: ; Não usado                                  ; Offset_0x078282
		incbin  'art/nemesis/unkfball.nem'                                   
Art_HTz_Rock:                                                  ; Offset_0x078390  
		incbin  'art/nemesis/rock.nem'       
Art_HTz_See_saw_badnick:                                       ; Offset_0x0784C6
		incbin  'art/nemesis/see-sawb.nem'                              
Art_Mz_Rotating_Gear:                                          ; Offset_0x078532
		incbin  'art/nemesis/gear.nem'  
Art_Mz_Gear_Holes:                                             ; Offset_0x07898A
		incbin  'art/nemesis/gearhole.nem'  
Art_Mz_Harpon_Platform:                                        ; Offset_0x078A32
		incbin  'art/nemesis/harp_ptf.nem' 
Art_Mz_Steam:                                                  ; Offset_0x078B00
		incbin  'art/nemesis/steam.nem'  
Art_Mz_Harpon:                                                 ; Offset_0x078C0A
		incbin  'art/nemesis/harpoon.nem' 
Art_Mz_Screw_Nut:                                              ; Offset_0x078CCC
		incbin  'art/nemesis/screwnut.nem' 
Art_Mz_Lava_Bubble:                                            ; Offset_0x078D42
		incbin  'art/nemesis/mzlvbubble.nem'
Art_Mz_Elevator:                                               ; Offset_0x078DF8
		incbin  'art/nemesis/mzelevator.nem'
Art_Mz_Parallelogram_Elevator:                                 ; Offset_0x078E68
		incbin  'art/nemesis/parallel.nem'
Art_Mz_Miscellaneous:                                          ; Offset_0x079114
		incbin  'art/nemesis/miscelns.nem'
Art_Mz_Mini_Gear:                                              ; Offset_0x0791B6
		incbin  'art/nemesis/minigear.nem'
Art_Mz_Teleport_Flash:                                         ; Offset_0x079298
		incbin  'art/nemesis/tlpflash.nem'    
Art_HPz_Bridge:                                                ; Offset_0x0792A4
		incbin  'art/nemesis/hpzbridge.nem'
Art_HPz_Waterfall:                                             ; Offset_0x07941C
		incbin  'art/nemesis/hpzwatrfall.nem'
Art_HPz_Emerald:                                               ; Offset_0x07977E
		incbin  'art/nemesis/emerald.nem'
Art_HPz_Platform:                                              ; Offset_0x0799F0
		incbin  'art/nemesis/platform.nem'   
Art_HPz_Orbs_2:                                                ; Offset_0x079AB0
		incbin  'art/nemesis/orbs.nem'
Art_HPz_Unknow_Platform:                                       ; Offset_0x079CEC
		incbin  'art/nemesis/unkptfm.nem'                  
Art_OOz_Giant_Spikeball:                                       ; Offset_0x079E86
		incbin  'art/nemesis/gspkball.nem'
Art_OOz_Touch_Boost_Up:                                        ; Offset_0x07A07E
		incbin  'art/nemesis/boost_up.nem' 
Art_OOz_Break_To_Boost_Horizontal:                             ; Offset_0x07A114
		incbin  'art/nemesis/brkbst_h.nem'
Art_OOz_Oil:                                                   ; Offset_0x07A180
		incbin  'art/nemesis/oil.nem'
Art_OOz_Oil_01:                                                ; Offset_0x07A2FC
		incbin  'art/nemesis/oil_01.nem'
Art_OOz_Ball:                                                  ; Offset_0x07A428
		incbin  'art/nemesis/ball.nem'
Art_OOz_Cannon:                                                ; Offset_0x07A548
		incbin  'art/nemesis/cannon.nem'   
Art_OOz_Collapsing_Platform:                                   ; Offset_0x07A838
		incbin  'art/nemesis/oozplatform.nem'
Art_OOz_Spring_Push_Boost:                                     ; Offset_0x07AACC
		incbin  'art/nemesis/spngpush.nem'
Art_OOz_Swing_Platform:                                        ; Offset_0x07AC8E
		incbin  'art/nemesis/swngptfm.nem'
Art_OOz_Break_To_Boost_Vertical:                               ; Offset_0x07AEB0
		incbin  'art/nemesis/brkbst_v.nem'
Art_OOz_Elevator:                                              ; Offset_0x07AF20
		incbin  'art/nemesis/oozelevator.nem'
Art_OOz_Fans:                                                  ; Offset_0x07B0BC
		incbin  'art/nemesis/fans.nem'
Art_OOz_Fire_Booster:                                          ; Offset_0x07B37C
		incbin  'art/nemesis/fire_bst.nem'
Art_DHz_Box:                                                   ; Offset_0x07B468
		incbin  'art/nemesis/dhzbox.nem'
Art_DHz_Collapsing_Platform:                                   ; Offset_0x07B6A6
		incbin  'art/nemesis/clp_ptfm.nem'
Art_DHz_Vines:                                                 ; Offset_0x07B850
		incbin  'art/nemesis/vines.nem'
Art_DHz_Vines_01:                                              ; Offset_0x07B948
		incbin  'art/nemesis/vines_1.nem'
Art_DHz_Bridge:                                                ; Offset_0x07B9F2
		incbin  'art/nemesis/bridge.nem'
Art_CNz_Green_Platforms:                                       ; Offset_0x07BA62
		incbin  'art/nemesis/greenptf.nem'
Art_CNz_Spikeball_Slot_Machine:                                ; Offset_0x07BACA
		incbin  'art/nemesis/spikball.nem'
Art_CNz_Box:                                                   ; Offset_0x07BB2A
		incbin  'art/nemesis/box.nem'
Art_CNz_Elevator:                                              ; Offset_0x07BBA4
		incbin  'art/nemesis/elevator.nem'
Art_CNz_Slot_Machine_Starter:                                  ; Offset_0x07BC16
		incbin  'art/nemesis/slotmach.nem'
Art_CNz_Blue_Bumper:                                           ; Offset_0x07BC84
		incbin  'art/nemesis/bbumpers.nem'
Art_CNz_Bumpers:                                               ; Offset_0x07BD0E
		incbin  'art/nemesis/bumpers.nem'
Art_CNz_Diagonal_Launcher:                                     ; Offset_0x07BEA0
		incbin  'art/nemesis/d_launch.nem'
Art_CNz_Vertical_Launcher:                                     ; Offset_0x07C086
		incbin  'art/nemesis/v_launch.nem'
Art_CNz_Green_Bumpers:                                         ; Offset_0x07C1BC
		incbin  'art/nemesis/gbumpers.nem'
Art_CNz_Flippers:                                              ; Offset_0x07C2E2
		incbin  'art/nemesis/flippers.nem'
Art_CPz_Triangle_Platform:                                     ; Offset_0x07C606
		incbin  'art/nemesis/tri_ptfm.nem'
Art_Water_Surface:                                             ; Offset_0x07C754
		incbin  'art/nemesis/watrsurf.nem'
Art_CPz_Speed_Booster:                                         ; Offset_0x07C8C4
		incbin  'art/nemesis/speedbst.nem'
Art_CPz_Worms:                                                 ; Offset_0x07C92C
		incbin  'art/nemesis/worms.nem'
Art_CPz_Metal_Structure:                                       ; Offset_0x07C99E
		incbin  'art/nemesis/metal_st.nem'
Art_CPz_Breakable_Block:                                       ; Offset_0x07CBA8
		incbin  'art/nemesis/brkblock.nem'
Art_CPz_Automatic_Door:                                        ; Offset_0x07CBE8
		incbin  'art/nemesis/autodoor.nem'
Art_CPz_Open_Close_Platform:                                   ; Offset_0x07CC54
		incbin  'art/nemesis/oc_ptfrm.nem'
Art_CPz_Platforms:                                             ; Offset_0x07CE36
		incbin  'art/nemesis/cpzplatform.nem'
Art_CPz_Spring_Tubes:                                          ; Offset_0x07CFF6
		incbin  'art/nemesis/spgtubes.nem'
Art_NGHz_Water_Surface:                                        ; Offset_0x07D1F2
		incbin  'art/nemesis/nghzwatrsurf.nem'
Art_NGHz_Leaves:                                               ; Offset_0x07D2D8
		incbin  'art/nemesis/leaves.nem'
Art_NGHz_Arrow_Shooter:                                        ; Offset_0x07D364
		incbin  'art/nemesis/arrow_s.nem'
Art_NGHz_Automatic_Door:                                       ; Offset_0x07D4C2
		incbin  'art/nemesis/nghzautodoor.nem'
Art_Switch:                                                    ; Offset_0x07D55A
		incbin  'art/nemesis/switch.nem'
Art_Vertical_Spring:                                           ; Offset_0x07D632
		incbin  'art/nemesis/v_spring.nem'
Art_Horizontal_Spring:                                         ; Offset_0x07D74E
		incbin  'art/nemesis/h_spring.nem'
Art_Diagonal_Spring:                                           ; Offset_0x07D818
		incbin  'art/nemesis/d_spring.nem'
Art_Head_Up_Display:                                           ; Offset_0x07D9EC
		incbin  'art/nemesis/hud.nem'
Art_Head_Up_Display_Sonic:                                     ; Offset_0x07DAF4
		incbin  'art/nemesis/hudsonic.nem'
Art_Rings:                                                     ; Offset_0x07DC0A
		incbin  'art/nemesis/rings.nem'
Art_Monitors:                                                  ; Offset_0x07DCFE
		incbin  'art/nemesis/monitors.nem'
Art_Spikes:                                                    ; Offset_0x07E128
		incbin  'art/nemesis/spikes.nem'
Art_Hit_Enemy_Points:                                          ; Offset_0x07E178
		incbin  'art/nemesis/points.nem'
Art_LampPost:                                                  ; Offset_0x07E252
		incbin  'art/nemesis/lamppost.nem'
Art_End_Panel:                                                 ; Offset_0x07E2F8
		incbin  'art/nemesis/endpanel.nem'
Art_Diagonal_Spring_01:                                        ; Offset_0x07E8CE
		incbin  'art/nemesis/dspring1.nem'
Art_DHz_Horizontal_Spikes:                                     ; Offset_0x07EA1E
		incbin  'art/nemesis/h_spikes.nem'
Art_Oxygen_Bubbles:                                            ; Offset_0x07EA9A
		incbin  'art/nemesis/oxygen.nem'
Art_Bubbles:                                                   ; Offset_0x07EC66
		incbin  'art/nemesis/bubbles.nem'
Art_Oxygen_Numbers:                                            ; Offset_0x07ED04
		incbin  'art/uncompressed/oxygnumb.dat'
Art_Game_Over_Time_Over:                                       ; Offset_0x07F184
		incbin  'art/nemesis/gt_over.nem'
Art_Explosion:                                                 ; Offset_0x07F316
		incbin  'art/nemesis/explosn.nem'
Art_Blue_Bird:                                                 ; Offset_0x07F6CA
		incbin  'art/nemesis/bluebird.nem'
Art_Squirrel:                                                  ; Offset_0x07F80C
		incbin  'art/nemesis/squirrel.nem'
Art_Mouse:                                                     ; Offset_0x07F970
		incbin  'art/nemesis/mouse.nem'
Art_Chicken:                                                   ; Offset_0x07FAAA
		incbin  'art/nemesis/chicken.nem'
Art_Monkey:                                                    ; Offset_0x07FC0C
		incbin  'art/nemesis/monkey.nem'
Art_Pigeon:                                                    ; Offset_0x07FD4C
		incbin  'art/nemesis/pigeon.nem'
Art_Pig:                                                       ; Offset_0x07FE7A
		incbin  'art/nemesis/pig.nem'
Art_Seal:                                                      ; Offset_0x07FFB0
		incbin  'art/nemesis/seal.nem'
Art_Penguin:                                                   ; Offset_0x0800CC
		incbin  'art/nemesis/penguin.nem'
Art_Turtle:                                                    ; Offset_0x080248
		incbin  'art/nemesis/turtle.nem'
Art_Bear:                                                      ; Offset_0x0803FA
		incbin  'art/nemesis/bear.nem'
Art_Rabbit:                                                    ; Offset_0x08053C
		incbin  'art/nemesis/rabbit.nem'
Art_HPz_Crocobot: ; Não usado                                  ; Offset_0x080694
		incbin  'art/nemesis/crocobot.nem'
Art_GHz_Buzzer:                                                ; Offset_0x080A36
		incbin  'art/nemesis/buzzer.nem'
Art_Batbot:                                                    ; Offset_0x080C36
		incbin  'art/nemesis/batbot.nem'
Art_Octus:                                                     ; Offset_0x080F8C
		incbin  'art/nemesis/octus.nem'
Art_Rhinobot:                                                  ; Offset_0x0812AC
		incbin  'art/nemesis/rhinobot.nem'
Art_Dinobot:                                                   ; Offset_0x081674
		incbin  'art/nemesis/dinobot.nem'
Art_Hpz_Piranha: ; Não usado                                   ; Offset_0x081A4A
		incbin  'art/nemesis/piranha.nem'
Art_Aquis:                                                     ; Offset_0x081F42
		incbin  'art/nemesis/aquis.nem'
Art_Spinning_Ball: ; Não usado                                 ; Offset_0x0822A2
		incbin  'art/nemesis/spinball.nem'
Art_Blink:    ; Não usado                                      ; Offset_0x082538
		incbin  'art/nemesis/blink.nem'
Art_Bubble_Monster: ; Não usado                                ; Offset_0x082764
		incbin  'art/nemesis/bmonster.nem'
Art_Ghz_Motobug: ; Não usado                                   ; Offset_0x082986
		incbin  'art/nemesis/motobug.nem'
Art_CNz_Crawl: ; Não usado                                     ; Offset_0x082B82
		incbin  'art/nemesis/crawl.nem'
Art_GHz_Masher:                                                ; Offset_0x082EE0
		incbin  'art/nemesis/masher.nem'
Art_Robotnik_Ship:                                             ; Offset_0x0830EC
		incbin  'art/nemesis/robotnik.nem'
Art_CPz_Boss:                                                  ; Offset_0x083828
		incbin  'art/nemesis/cpzboss.nem'
Art_Boss_Explosions:                                           ; Offset_0x083D86
		incbin  'art/nemesis/explosns.nem'
Art_Ship_Boost:                                                ; Offset_0x08440E
		incbin  'art/nemesis/shpboost.nem'
Art_Boss_Smokes:                                               ; Offset_0x08448C
		incbin  'art/nemesis/boss_smk.nem'
Art_GHz_Boss_Car:                                              ; Offset_0x084572
		incbin  'art/nemesis/boss_car.nem'
Art_GHz_Boss_Blades:                                           ; Offset_0x084D5E                
		incbin  'art/nemesis/b_blades.nem'              
Art_HTz_Boss_Fire_Cannon:                                      ; Offset_0x084E52
		incbin  'art/nemesis/bossfire.nem'              
Art_NGHz_Boss:                                                 ; Offset_0x08561E
		incbin  'art/nemesis/nghzboss.nem'
Art_DHz_Boss:                                                  ; Offset_0x086678
		incbin  'art/nemesis/dhzboss.nem'             
Art_CNz_Boss:                                                  ; Offset_0x0875B6
		incbin  'art/nemesis/boss.nem'
Art_OOz_Boss:                                                  ; Offset_0x087DE0
		incbin  'art/nemesis/oozboss.nem'
Art_Mz_Boss_Balls_And_Robotniks:                               ; Offset_0x08884E
		incbin  'art/nemesis/bossball.nem'                           
Art_DHz_Boss_Rocks:                                            ; Offset_0x088F8C  
		incbin  'art/uncompressed/bossrock.dat'
Art_Whisp:                                                     ; Offset_0x08900C
		incbin  'art/nemesis/whisp.nem'
Art_Grounder:                                                  ; Offset_0x089136
		incbin  'art/nemesis/grounder.nem' 
Art_Chop_Chop:                                                 ; Offset_0x0895C2
		incbin  'art/nemesis/chopchop.nem'   
Art_Rexon:                                                     ; Offset_0x089814
		incbin  'art/nemesis/rexon.nem'                            
Art_Spiker:                                                    ; Offset_0x0899D2
		incbin  'art/nemesis/spiker.nem'    
Art_Nebula:                                                    ; Offset_0x089B6A
		incbin  'art/nemesis/nebula.nem' 
Art_Turtloid:                                                  ; Offset_0x089D8A
		incbin  'art/nemesis/turtloid.nem'                                                
Art_GHz_Coconuts:                                              ; Offset_0x08A2A2  
		incbin  'art/nemesis/coconuts.nem'
Art_Crawlton:                                                  ; Offset_0x08A55E
		incbin  'art/nemesis/crawlton.nem'
Art_Flasher:                                                   ; Offset_0x08A686
		incbin  'art/nemesis/flasher.nem'
Art_Slicer:                                                    ; Offset_0x08A7CC   
		incbin  'art/nemesis/slicer.nem'
Art_Shellcracker:                                              ; Offset_0x08AAA4
		incbin  'art/nemesis/shellcrc.nem' 
Art_Asteron:                                                   ; Offset_0x08AD4C   
		incbin  'art/nemesis/asteron.nem'                
Art_Lander:                                                    ; Offset_0x08AE7C
		incbin  'art/nemesis/lander.nem'
Art_Grabber:                                                   ; Offset_0x08B100
		incbin  'art/nemesis/grabber.nem'     
Art_Clucker:                                                   ; Offset_0x08B428
		incbin  'art/nemesis/clucker.nem'
Art_Balkiry:                                                   ; Offset_0x08B662 
		incbin  'art/nemesis/balkiry.nem'
Green_Hill_Blocks:                                             ; Offset_0x08B85E   
		incbin  'level/emerald hill zone/blocks.dat'                              
Green_Hill_Tiles:                                              ; Offset_0x08C7FE
		incbin  'level/emerald hill zone/tiles.nem'
Hill_Top_Blocks:                                               ; Offset_0x08F64E
		incbin  'level/hill top zone/blocks.dat'
Hill_Top_Tiles:                                                ; Offset_0x08FDFE
		incbin  'level/hill top zone/tiles.nem'
Art_Hill_Top_Dynamic_Init:                                     ; Offset_0x091224    
		incbin  'art/nemesis/htzdyn_init.nem'
Green_Hill_Chunks:                                             ; Offset_0x09152C
		incbin  'level/shared/chunks.kos' 
		dc.w    $0000, $0000
Wood_Blocks:                                                   ; Offset_0x09478C                
		incbin  'level/wood zone/blocks.dat'
Wood_Tiles:                                                    ; Offset_0x09572C
		incbin  'level/wood zone/tiles.nem'
Wood_Chunks:                                                   ; Offset_0x099424
		incbin  'level/wood zone/chunks.kos'
		dc.w    $0000, $0000, $0000, $0000, $0000, $0000 
Metropolis_Blocks:                                             ; Offset_0x09B054                 
		incbin  'level/metropolis zone/blocks.dat'
Metropolis_Tiles:                                              ; Offset_0x09C314
		incbin  'level/metropolis zone/tiles.nem'
Art_Metropolis_Dynamic_Init:                                   ; Offset_0x091224    
		incbin  'art/nemesis/mzdyn_init.nem'
Metropolis_Chunks:                                             ; Offset_0x09F854
		incbin  'level/metropolis zone/chunks.kos'
Hidden_Palace_Blocks:                                          ; Offset_0x0A24D4                
		incbin  'level/hidden palace zone/blocks.dat'
Hidden_Palace_Tiles:                                           ; Offset_0x0A3AB4
		incbin  'level/hidden palace zone/tiles.nem'
Art_Hidden_Palace_Dynamic_Init:                                ; Offset_0x0A67C2    
		incbin  'art/nemesis/dyn_init.nem'
Hidden_Palace_Chunks:                                          ; Offset_0x0A6936
		incbin  'level/hidden palace zone/chunks.kos' 
		dc.w    $0000, $0000, $0000
Oil_Ocean_Blocks:                                              ; Offset_0x0A86B6                
		incbin  'level/oil ocean zone/blocks.dat'
Oil_Ocean_Tiles:                                               ; Offset_0x0A9C96
		incbin  'level/oil ocean zone/tiles.nem'
Art_Oil_Ocean_Dynamic_Init:                                    ; Offset_0x0AC7A8    
		incbin  'art/nemesis/oozdyn_init.nem'
Oil_Ocean_Chunks:                                              ; Offset_0x0AC996
		incbin  'level/oil ocean zone/chunks.kos' 
Dust_Hill_Blocks:                                              ; Offset_0x0AEE86
		incbin  'level/dust hill zone/blocks.dat'
Dust_Hill_Tiles:                                               ; Offset_0x0B0146
		incbin  'level/dust hill zone/tiles.nem'
Dust_Hill_Chunks:                                              ; Offset_0x0B3A68
		incbin  'level/dust hill zone/chunks.kos'
		dc.w    $0000, $0000, $0000 
Casino_Night_Blocks:                                           ; Offset_0x0B65B8   
		incbin  'level/casino night zone/blocks.dat'
Casino_Night_Tiles:                                            ; Offset_0x0B6F18
		incbin  'level/casino night zone/tiles.nem'
Art_Casino_Night_Dynamic_Init:                                 ; Offset_0x0B9E78    
		incbin  'art/nemesis/cnzdyn_init.nem'
Casino_Night_Chunks:                                           ; Offset_0x0B9F62
		incbin  'level/casino night zone/chunks.kos'
		dc.w    $0000, $0000, $0000 
Chemical_Plant_Blocks:                                         ; Offset_0x0BBE72     
		incbin  'level/chemical plant zone/blocks.dat'
Chemical_Plant_Tiles:                                          ; Offset_0x0BD452
		incbin  'level/chemical plant zone/tiles.nem'
Art_Chemical_Plant_Dynamic_Init:                               ; Offset_0x0C0F7A    
		incbin  'art/nemesis/cpzdyn_init.nem'                 
Chemical_Plant_Chunks:                                         ; Offset_0x0C0FA4
		incbin  'level/chemical plant zone/chunks.kos'
		dc.w    $0000, $0000, $0000  
Neo_Green_Hill_Blocks:                                         ; Offset_0x0C34A4
		incbin  'level/neo green hill zone/blocks.dat'
Neo_Green_Hill_Tiles:                                          ; Offset_0x0C4DA4
		incbin  'level/neo green hill zone/tiles.nem'
Art_Neo_Green_Hill_Dynamic_Init:                               ; Offset_0x0CA426    
		incbin  'art/nemesis/nghzdyn_init.nem'
Neo_Green_Hill_Chunks:                                         ; Offset_0x0CA586
		incbin  'level/neo green hill zone/chunks.kos'
		dc.w    $0000
;-------------------------------------------------------------------------------                
Previous_Build_Chemical_Plant_Tiles_Overwrite:                 ; Offset_0x0CD158
		incbin  'leftovers/cpzpb_tiles.dat'
Previous_Build_Art_Chemical_Plant_Dynamic_Init:                ; Offset_0x0CDFC6
		incbin  'art/nemesis/dyninit2.nem'
Previous_Build_Chemical_Plant_Chunks:                          ; Offset_0x0CE03A
		incbin  'leftovers/cpzchunks.dat'            
Previous_Build_Neo_Green_Hill_Blocks:                          ; Offset_0x0D603A 
		incbin  'leftovers/nghzpb_blcks.dat'
Previous_Build_Neo_Green_Hill_Tiles:                           ; Offset_0x0D793A                                            
		incbin  'leftovers/nghzpb_tiles.nem'
Previous_Build_Art_Neo_Green_Hill_Dynamic_Init:                ; Offset_0x0DCEEA
		incbin  'art/nemesis/nghzdyn_init.nem'
Previous_Build_Neo_Green_Hill_Chunks:                          ; Offset_0x0DD04A
		incbin  'leftovers/nghzpb_chnks.dat'
		dc.w     $0000
Previous_Build_Neo_Green_Hill_Tiles_Overwrite:                 ; Offset_0x0E504C                                   
		incbin  'leftovers/nghzpb_tiles.dat'
Previous_Build_Art_Neo_Green_Hill_Dynamic_Init_2:              ; Offset_0x0E57E6
		incbin  'art/nemesis/nghzdyn_init.nem'
Uncompiled_Asm:                                                ; Offset_0x0E5946                 
		include "Leftovers/Uncompiled ASM.asm"
;===============================================================================
; Leiaute dos anéis nas fases
; ->>>
;===============================================================================  
Rings_Layout:                                                  ; Offset_0x0E8000
		dc.w    GHz_Rng_Act1-Rings_Layout              ; Offset_0x0E8044
		dc.w    GHz_Rng_Act2-Rings_Layout              ; Offset_0x0E81DE
		dc.w    Lvl1_Rng_Act1-Rings_Layout             ; Offset_0x0E83FC
		dc.w    Lvl1_Rng_Act2-Rings_Layout             ; Offset_0x0E83FE
		dc.w    Wz_Rng_Act1-Rings_Layout               ; Offset_0x0E8400
		dc.w    Wz_Rng_Act2-Rings_Layout               ; Offset_0x0E8402
		dc.w    Lvl3_Rng_Act1-Rings_Layout             ; Offset_0x0E8404
		dc.w    Lvl3_Rng_Act2-Rings_Layout             ; Offset_0x0E8406
		dc.w    Mz_Rng_Act1-Rings_Layout               ; Offset_0x0E8408
		dc.w    Mz_Rng_Act2-Rings_Layout               ; Offset_0x0E8696
		dc.w    Mz_Rng_Act3-Rings_Layout               ; Offset_0x0E88E4
		dc.w    Mz_Rng_Act4-Rings_Layout               ; Offset_0x0E89CE
		dc.w    Lvl6_Rng_Act1-Rings_Layout             ; Offset_0x0E89D0
		dc.w    Lvl6_Rng_Act2-Rings_Layout             ; Offset_0x0E89D2
		dc.w    HTz_Rng_Act1-Rings_Layout              ; Offset_0x0E89D4
		dc.w    HTz_Rng_Act2-Rings_Layout              ; Offset_0x0E8ACA
		dc.w    HPz_Rng_Act1-Rings_Layout              ; Offset_0x0E8C2C
		dc.w    HPz_Rng_Act2-Rings_Layout              ; Offset_0x0E8D9E
		dc.w    Lvl9_Rng_Act1-Rings_Layout             ; Offset_0x0E8DA0
		dc.w    Lvl9_Rng_Act2-Rings_Layout             ; Offset_0x0E8DA2
		dc.w    OOz_Rng_Act1-Rings_Layout              ; Offset_0x0E8DA4
		dc.w    OOz_Rng_Act2-Rings_Layout              ; Offset_0x0E8E76
		dc.w    DHz_Rng_Act1-Rings_Layout              ; Offset_0x0E8F40
		dc.w    DHz_Rng_Act2-Rings_Layout              ; Offset_0x0E912E
		dc.w    CNz_Rng_Act1-Rings_Layout              ; Offset_0x0E92F8
		dc.w    CNz_Rng_Act2-Rings_Layout              ; Offset_0x0E92FA
		dc.w    CPz_Rng_Act1-Rings_Layout              ; Offset_0x0E92FC
		dc.w    CPz_Rng_Act2-Rings_Layout              ; Offset_0x0E93CA
		dc.w    GCz_Rng_Act1-Rings_Layout              ; Offset_0x0E9520
		dc.w    GCz_Rng_Act2-Rings_Layout              ; Offset_0x0E9522
		dc.w    NGHz_Rng_Act1-Rings_Layout             ; Offset_0x0E9524
		dc.w    NGHz_Rng_Act2-Rings_Layout             ; Offset_0x0E9602
		dc.w    DEz_Rng_Act1-Rings_Layout              ; Offset_0x0E973C
		dc.w    DEz_Rng_Act2-Rings_Layout              ; Offset_0x0E973E
;-------------------------------------------------------------------------------
GHz_Rng_Act1:                                                  ; Offset_0x0E8044
		incbin  'level/emerald hill zone/rng_act1.dat'
GHz_Rng_Act2:                                                  ; Offset_0x0E81DE
		incbin  'level/emerald hill zone/rng_act2.dat'
Lvl1_Rng_Act1:                                                 ; Offset_0x0E83FC
		dc.w    $FFFF
Lvl1_Rng_Act2:                                                 ; Offset_0x0E83FE
		dc.w    $FFFF
Wz_Rng_Act1:                                                   ; Offset_0x0E8400
		dc.w    $FFFF
Wz_Rng_Act2:                                                   ; Offset_0x0E8402
		dc.w    $FFFF
Lvl3_Rng_Act1:                                                 ; Offset_0x0E8404
		dc.w    $FFFF
Lvl3_Rng_Act2:                                                 ; Offset_0x0E8406
		dc.w    $FFFF
Mz_Rng_Act1:                                                   ; Offset_0x0E8408
		incbin  'level/metropolis zone/rng_act1.dat'
Mz_Rng_Act2:                                                   ; Offset_0x0E8696
		incbin  'level/metropolis zone/rng_act2.dat'
Mz_Rng_Act3:                                                   ; Offset_0x0E88E4
		incbin  'level/metropolis zone/rng_act3.dat'
Mz_Rng_Act4:                                                   ; Offset_0x0E89CE
		dc.w    $FFFF
Lvl6_Rng_Act1:                                                 ; Offset_0x0E89D0
		dc.w    $FFFF
Lvl6_Rng_Act2:                                                 ; Offset_0x0E89D2
		dc.w    $FFFF
HTz_Rng_Act1:                                                  ; Offset_0x0E89D4
		incbin  'level/hill top zone/rng_act1.dat'
HTz_Rng_Act2:                                                  ; Offset_0x0E8ACA
		incbin  'level/hill top zone/rng_act2.dat'
HPz_Rng_Act1:                                                  ; Offset_0x0E8C2C
		incbin  'level/hidden palace zone/rng_act.dat'
HPz_Rng_Act2:                                                  ; Offset_0x0E8D9E
		dc.w    $FFFF
Lvl9_Rng_Act1:                                                 ; Offset_0x0E8DA0
		dc.w    $FFFF
Lvl9_Rng_Act2:                                                 ; Offset_0x0E8DA2
		dc.w    $FFFF
OOz_Rng_Act1:                                                  ; Offset_0x0E8DA4
		incbin  'level/oil ocean zone/rng_act1.dat'
OOz_Rng_Act2:                                                  ; Offset_0x0E8E76
		incbin  'level/oil ocean zone/rng_act2.dat'
DHz_Rng_Act1:                                                  ; Offset_0x0E8F40
		incbin  'level/dust hill zone/rng_act1.dat'
DHz_Rng_Act2:                                                  ; Offset_0x0E912E
		incbin  'level/dust hill zone/rng_act2.dat'
CNz_Rng_Act1:                                                  ; Offset_0x0E92F8
		dc.w    $FFFF
CNz_Rng_Act2:                                                  ; Offset_0x0E92FA
		dc.w    $FFFF
CPz_Rng_Act1:                                                  ; Offset_0x0E92FC
		incbin  'level/chemical plant zone/rng_act1.dat'
CPz_Rng_Act2:                                                  ; Offset_0x0E93CA
		incbin  'level/chemical plant zone/rng_act2.dat'
GCz_Rng_Act1:                                                  ; Offset_0x0E9520
		dc.w    $FFFF
GCz_Rng_Act2:                                                  ; Offset_0x0E9522
		dc.w    $FFFF
NGHz_Rng_Act1:                                                 ; Offset_0x0E9524
		incbin  'level/neo green hill zone/rng_act1.dat'
NGHz_Rng_Act2:                                                 ; Offset_0x0E9602
		incbin  'level/neo green hill zone/rng_act2.dat'
DEz_Rng_Act1:                                                  ; Offset_0x0E973C
		dc.w    $FFFF
DEz_Rng_Act2:                                                  ; Offset_0x0E973E 
		dc.w    $FFFF
Previous_Build_NGHz_Rng_Act2:                                  ; Offset_0x0E9740
		incbin  'leftovers/nghzpb_rng_2.dat'
		dc.w    $FFFF
		dc.w    $FFFF
;===============================================================================
; Leiaute dos anéis nas fases
; <<<-
;=============================================================================== 
Previous_Build_DAC_Sample_01_Overwrite:                        ; Offset_0x0E978C 
		incbin  'leftovers/PB_DAC01.bin'
Previous_Build_DAC_Sample_02:                                  ; Offset_0x0E99B7 
		incbin  'sound/driver/DAC_02.bin'
Previous_Build_DAC_Sample_06: ; Sonic 2 Beta                   ; Offset_0x0EA56C  
		incbin  'leftovers/PB_DAC06.bin'
Previous_Build_DAC_Sample_03: ; Sonic 2 Beta                   ; Offset_0x0EAA6B  
		incbin  'leftovers/PB_DAC03.bin'
Previous_Build_DAC_Sample_04: ; Sonic 2 Beta                   ; Offset_0x0EACD3
		incbin  'leftovers/PB_DAC04.bin'
;-------------------------------------------------------------------------------                
		cnop    $00000000, $000EC000
;===============================================================================
; Rotina para carregar o driver de som 
; ->>>
;=============================================================================== 
SoundDriverLoad:                                               ; Offset_0x0EC000
		move    SR, -(A7)                                               
		movem.l D0-D7/A0-A6, -(A7)                                      
		move    #$2700, SR                                              
		lea     (Z80_Bus_Request), A3                        ; $00A11100
		lea     (Z80_Reset), A2                              ; $00A11200
		moveq   #$00, D2                                                
		move.w  #$0100, D1                                              
		move.w  D1, (A3)                                                
		move.w  D1, (A2)                                                
Offset_0x0EC020:
		btst    D2, (A3)                                                
		bne.s   Offset_0x0EC020                                         
		jsr     Offset_0x0EC03C(PC)
		move.w  D2, (A2)                                                
		move.w  D2, (A3)                                                
		moveq   #$17, D0                                                
Offset_0x0EC02E:
		dbra    D0, Offset_0x0EC02E                                     
		move.w  D1, (A2)                                                
		movem.l (A7)+, D0-D7/A0-A6                                      
		move    (A7)+, SR                                               
		rts                                                             
;-------------------------------------------------------------------------------
Offset_0x0EC03C:
		lea     Z80_Sound_Driver(PC), A6               ; Offset_0x0EC0DC                              
		move.w  #$0E7E, D7                                              
		moveq   #$00, D6                                                
		lea     (Z80_RAM_Start), A5                          ; $00A00000
		moveq   #$00, D5                                                
		lea     (Z80_RAM_Start), A4                          ; $00A00000
Offset_0x0EC054:
		lsr.w   #$01, D6                                                
		btst    #$08, D6                                                
		bne.s   Offset_0x0EC066                                         
		jsr     Offset_0x0EC0D2(PC)                                     
		move.b  D0, D6                                                  
		ori.w   #$FF00, D6                                              
Offset_0x0EC066:
		btst    #$00, D6                                                
		beq.s   Offset_0x0EC078                                         
		jsr     Offset_0x0EC0D2(PC)                                     
		move.b  D0, (A5)+                                               
		addq.w  #$01, D5                                                
		bra     Offset_0x0EC054                                         
Offset_0x0EC078:
		jsr     Offset_0x0EC0D2(PC)                                     
		moveq   #$00, D4                                                
		move.b  D0, D4                                                  
		jsr     Offset_0x0EC0D2(PC)                                     
		move.b  D0, D3                                                  
		andi.w  #$000F, D3                                              
		addq.w  #$02, D3                                                
		andi.w  #$00F0, D0                                              
		lsl.w   #$04, D0                                                
		add.w   D0, D4                                                  
		addi.w  #$0012, D4                                              
		andi.w  #$0FFF, D4                                              
		move.w  D5, D0                                                  
		andi.w  #$F000, D0                                              
		add.w   D0, D4                                                  
		cmp.w   D4, D5                                                  
		bcc.s   Offset_0x0EC0C0                                         
		subi.w  #$1000, D4                                              
		bcc.s   Offset_0x0EC0C0                                         
		add.w   D3, D5                                                  
		addq.w  #$01, D5                                                
Offset_0x0EC0B2:
		move.b  #$00, (A5)+                                             
		addq.w  #$01, D4                                                
		dbra    D3, Offset_0x0EC0B2                                     
		bra     Offset_0x0EC054                                         
Offset_0x0EC0C0:
		add.w   D3, D5                                                  
		addq.w  #$01, D5                                                
Offset_0x0EC0C4:
		move.b  $00(A4, D4), (A5)+                                      
		addq.w  #$01, D4                                                
		dbra    D3, Offset_0x0EC0C4                                     
		bra     Offset_0x0EC054   
;-------------------------------------------------------------------------------
Offset_0x0EC0D2:
		move.b  (A6)+, D0                                               
		subq.w  #$01, D7                                                
		bne.s   Offset_0x0EC0DA                                         
		addq.w  #$04, A7                                                
Offset_0x0EC0DA:
		rts    
;-------------------------------------------------------------------------------
Z80_Sound_Driver:                                              ; Offset_0x0EC0DC
		incbin  'sound/driver/snd_drv.sax'
;-------------------------------------------------------------------------------  
		cnop    $00000000, $000ED000      
DAC_Sample_00:                                                 ; Offset_0x0ED000  
		incbin  'sound/driver/DAC_00.bin'
DAC_Sample_01:                                                 ; Offset_0x0ED294 
		incbin  'sound/driver/DAC_01.bin'
DAC_Sample_02:                                                 ; Offset_0x0ED9B7 
		incbin  'sound/driver/DAC_02.bin'
DAC_Sample_03:                                                 ; Offset_0x0EE56C  
		incbin  'sound/driver/DAC_03.bin'
DAC_Sample_04:                                                 ; Offset_0x0EED7A  
		incbin  'sound/driver/DAC_04.bin'
DAC_Sample_05:                                                 ; Offset_0x0EF2F0  
		incbin  'sound/driver/DAC_05.bin'
DAC_Sample_06:                                                 ; Offset_0x0EFA3C  
		incbin  'sound/driver/DAC_06.bin'
;-------------------------------------------------------------------------------
Music_81_Ptr equ (Music_Versus_Result_Final&$FFFF)|$8000  
Music_82_Ptr equ (Music_Green_Hill&$FFFF)|$8000  
Music_83_Ptr equ (Music_Hidden_Palace_Beta&$FFFF)|$8000  
Music_84_Ptr equ (Music_Oil_Ocean_Final&$FFFF)|$8000  
Music_85_Ptr equ (Music_Metropolis&$FFFF)|$8000  
Music_86_Ptr equ (Music_Hill_Top&$FFFF)|$8000  
Music_87_Ptr equ (Music_Neo_Green_Hill&$FFFF)|$8000  
Music_88_Ptr equ (Music_Oil_Ocean_Beta&$FFFF)|$8000  
Music_89_Ptr equ (Music_Casino_Night&$FFFF)|$8000  
Music_8A_Ptr equ (Music_Death_Egg&$FFFF)|$8000  
Music_8B_Ptr equ (Music_Dust_Hill&$FFFF)|$8000  
Music_8C_Ptr equ (Music_Green_Hill_Versus_Final&$FFFF)|$8000  
Music_8D_Ptr equ (Music_Sky_Chase&$FFFF)|$8000  
Music_8E_Ptr equ (Music_Chemical_Plant&$FFFF)|$8000  
Music_8F_Ptr equ (Music_Sky_Fortress&$FFFF)|$8000  
Music_90_Ptr equ (Music_Hidden_Palace_Final&$FFFF)|$8000
Music_91_Ptr equ (Music_Level_Select_Menu&$FFFF)|$8000  
Music_92_Ptr equ (Music_Special_Stage&$FFFF)|$8000  
Music_93_Ptr equ (Music_Level_Boss&$FFFF)|$8000  
Music_94_Ptr equ (Music_Final_Boss&$FFFF)|$8000  
Music_95_Ptr equ (Music_End_Sequence&$FFFF)|$8000  
Music_96_Ptr equ (Music_Super_Sonic&$FFFF)|$8000    
Music_97_Ptr equ (Music_Invencibility&$FFFF)|$8000  
Music_98_Ptr equ (Music_Extra_Life&$FFFF)|$8000  
Music_99_Ptr equ (Music_Title_Screen&$FFFF)|$8000  
Music_9A_Ptr equ (Music_Level_Results&$FFFF)|$8000  
Music_9B_Ptr equ (Music_Time_Over_Game_Over&$FFFF)|$8000  
Music_9C_Ptr equ (Music_Continue&$FFFF)|$8000  
Music_9D_Ptr equ (Music_Get_Emerald&$FFFF)|$8000  
Music_9E_Ptr equ (Music_Hidden_Palace_Final&$FFFF)|$8000  
;-------------------------------------------------------------------------------               
		dc.w    (((Music_97_Ptr>>$08)|(Music_97_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_98_Ptr>>$08)|(Music_98_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_99_Ptr>>$08)|(Music_99_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_9A_Ptr>>$08)|(Music_9A_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_9B_Ptr>>$08)|(Music_9B_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_9C_Ptr>>$08)|(Music_9C_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_9D_Ptr>>$08)|(Music_9D_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_90_Ptr>>$08)|(Music_90_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_9E_Ptr>>$08)|(Music_9E_Ptr<<$08))&$FFFF)               
Music_Invencibility:                                           ; Offset_0x0F0012
		incbin  'sound/music/invcb_97.snd'
Music_Extra_Life:                                              ; Offset_0x0F023D
		incbin  'sound/music/1up_98.snd'
Music_Title_Screen:                                            ; Offset_0x0F032A
		incbin  'sound/music/tscr_99.snd'
Music_Level_Results:                                           ; Offset_0x0F04FF
		incbin  'sound/music/lres_9A.snd'
Music_Time_Over_Game_Over:                                     ; Offset_0x0F0654
		incbin  'sound/music/tgovr_9B.snd'
Music_Continue:                                                ; Offset_0x0F07A3
		incbin  'sound/music/cont_9c.snd'
Music_Get_Emerald:                                             ; Offset_0x0F0900
		incbin  'sound/music/emrld_9d.snd'
Music_Hidden_Palace_Final:                                     ; Offset_0x0F09CE
		incbin  'sound/music/hpz_90.snd'
;-------------------------------------------------------------------------------                                                    
		cnop    $00000000, $000F1E8C
;-------------------------------------------------------------------------------                
Sega_Snd:                                                      ; Offset_0x0F1E8C               
		incbin  'sound/driver/sega.snd'                                                                                                     
;-------------------------------------------------------------------------------
		dc.w    (((Music_88_Ptr>>$08)|(Music_88_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_82_Ptr>>$08)|(Music_82_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_85_Ptr>>$08)|(Music_85_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_89_Ptr>>$08)|(Music_89_Ptr<<$08))&$FFFF)                  
		dc.w    (((Music_8B_Ptr>>$08)|(Music_8B_Ptr<<$08))&$FFFF)                  
		dc.w    (((Music_83_Ptr>>$08)|(Music_83_Ptr<<$08))&$FFFF)
		dc.w    (((Music_87_Ptr>>$08)|(Music_87_Ptr<<$08))&$FFFF)                   
		dc.w    (((Music_8A_Ptr>>$08)|(Music_8A_Ptr<<$08))&$FFFF)                 
		dc.w    (((Music_92_Ptr>>$08)|(Music_92_Ptr<<$08))&$FFFF)                  
		dc.w    (((Music_91_Ptr>>$08)|(Music_91_Ptr<<$08))&$FFFF)                  
		dc.w    (((Music_95_Ptr>>$08)|(Music_95_Ptr<<$08))&$FFFF)                
		dc.w    (((Music_94_Ptr>>$08)|(Music_94_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_8E_Ptr>>$08)|(Music_8E_Ptr<<$08))&$FFFF)                   
		dc.w    (((Music_93_Ptr>>$08)|(Music_93_Ptr<<$08))&$FFFF)                 
		dc.w    (((Music_8D_Ptr>>$08)|(Music_8D_Ptr<<$08))&$FFFF)                  
		dc.w    (((Music_84_Ptr>>$08)|(Music_84_Ptr<<$08))&$FFFF)                    
		dc.w    (((Music_8F_Ptr>>$08)|(Music_8F_Ptr<<$08))&$FFFF)                  
		dc.w    (((Music_8C_Ptr>>$08)|(Music_8C_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_81_Ptr>>$08)|(Music_81_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_96_Ptr>>$08)|(Music_96_Ptr<<$08))&$FFFF) 
		dc.w    (((Music_86_Ptr>>$08)|(Music_86_Ptr<<$08))&$FFFF) 
Music_Oil_Ocean_Beta:                                          ; Offset_0x0F802A
		incbin  'sound/music/ooz_88.snd' 
Music_Green_Hill:                                              ; Offset_0x0F85AC
		incbin  'sound/music/ghz_82.snd'
Music_Metropolis:                                              ; Offset_0x0F8D1E
		incbin  'sound/music/mz_85.snd'
Music_Casino_Night:                                            ; Offset_0x0F9299
		incbin  'sound/music/cnz_89.snd'
Music_Dust_Hill:                                               ; Offset_0x0F99B6
		incbin  'sound/music/dhz_8b.snd'
Music_Hidden_Palace_Beta:                                      ; Offset_0x0FA056
		incbin  'sound/music/hpz_83.snd'
Music_Neo_Green_Hill:                                          ; Offset_0x0FA54F
		incbin  'sound/music/nghz_87.snd'
Music_Death_Egg:                                               ; Offset_0x0FACDC
		incbin  'sound/music/dez_8a.snd'
Music_Special_Stage:                                           ; Offset_0x0FB1C3
		incbin  'sound/music/ss_92.snd'
Music_Level_Select_Menu:                                       ; Offset_0x0FB7CA
		incbin  'sound/music/menu_91.snd'
Music_End_Sequence:                                            ; Offset_0x0FB945
		incbin  'sound/music/endsq_95.snd'
Music_Final_Boss:                                              ; Offset_0x0FBF3E
		incbin  'sound/music/dezfb_94.snd'
Music_Chemical_Plant:                                          ; Offset_0x0FC276
		incbin  'sound/music/cpz_8e.snd'
Music_Level_Boss:                                              ; Offset_0x0FC8C1
		incbin  'sound/music/boss_93.snd'
Music_Sky_Chase:                                               ; Offset_0x0FCB93
		incbin  'sound/music/scz_8d.snd'
Music_Oil_Ocean_Final:                                         ; Offset_0x0FCF96
		incbin  'sound/music/ooz_84.snd'
Music_Sky_Fortress:                                            ; Offset_0x0FD41A
		incbin  'sound/music/sfz_8f.snd'
Music_Green_Hill_Versus_Final:                                 ; Offset_0x0FD847
		incbin  'sound/music/ghzvs_8c.snd'
Music_Versus_Result_Final:                                     ; Offset_0x0FDD60
		incbin  'sound/music/vsres_81.snd'
Music_Super_Sonic:                                             ; Offset_0x0FE1C3
		incbin  'sound/music/super_96.snd'
Music_Hill_Top:                                                ; Offset_0x0FE4B6
		incbin  'sound/music/htz_86.snd'
;-------------------------------------------------------------------------------
		cnop    $00000000, $000FEE00
;------------------------------------------------------------------------------- 
Sfx_A0_Ptr equ (Sfx_A0&$FFFF)|$8000   
Sfx_A1_Ptr equ (Sfx_A1&$FFFF)|$8000    
Sfx_A2_Ptr equ (Sfx_A2&$FFFF)|$8000    
Sfx_A3_Ptr equ (Sfx_A3&$FFFF)|$8000  
Sfx_A4_Ptr equ (Sfx_A4&$FFFF)|$8000 
Sfx_A5_Ptr equ (Sfx_A5&$FFFF)|$8000  
Sfx_A6_Ptr equ (Sfx_A6&$FFFF)|$8000   
Sfx_A7_Ptr equ (Sfx_A7&$FFFF)|$8000    
Sfx_A8_Ptr equ (Sfx_A8&$FFFF)|$8000    
Sfx_A9_Ptr equ (Sfx_A9&$FFFF)|$8000  
Sfx_AA_Ptr equ (Sfx_AA&$FFFF)|$8000 
Sfx_AB_Ptr equ (Sfx_AB&$FFFF)|$8000  
Sfx_AC_Ptr equ (Sfx_AC&$FFFF)|$8000   
Sfx_AD_Ptr equ (Sfx_AD&$FFFF)|$8000    
Sfx_AE_Ptr equ (Sfx_AE&$FFFF)|$8000    
Sfx_AF_Ptr equ (Sfx_AF&$FFFF)|$8000  
Sfx_B0_Ptr equ (Sfx_B0&$FFFF)|$8000 
Sfx_B1_Ptr equ (Sfx_B1&$FFFF)|$8000  
Sfx_B2_Ptr equ (Sfx_B2&$FFFF)|$8000   
Sfx_B3_Ptr equ (Sfx_B3&$FFFF)|$8000    
Sfx_B4_Ptr equ (Sfx_B4&$FFFF)|$8000    
Sfx_B5_Ptr equ (Sfx_B5&$FFFF)|$8000  
Sfx_B6_Ptr equ (Sfx_B6&$FFFF)|$8000 
Sfx_B7_Ptr equ (Sfx_B7&$FFFF)|$8000  
Sfx_B8_Ptr equ (Sfx_B8&$FFFF)|$8000    
Sfx_B9_Ptr equ (Sfx_B9&$FFFF)|$8000  
Sfx_BA_Ptr equ (Sfx_BA&$FFFF)|$8000 
Sfx_BB_Ptr equ (Sfx_BB&$FFFF)|$8000  
Sfx_BC_Ptr equ (Sfx_BC&$FFFF)|$8000   
Sfx_BD_Ptr equ (Sfx_BD&$FFFF)|$8000    
Sfx_BE_Ptr equ (Sfx_BE&$FFFF)|$8000    
Sfx_BF_Ptr equ (Sfx_BF&$FFFF)|$8000 
Sfx_C0_Ptr equ (Sfx_C0&$FFFF)|$8000 
Sfx_C1_Ptr equ (Sfx_C1&$FFFF)|$8000  
Sfx_C2_Ptr equ (Sfx_C2&$FFFF)|$8000   
Sfx_C3_Ptr equ (Sfx_C3&$FFFF)|$8000    
Sfx_C4_Ptr equ (Sfx_C4&$FFFF)|$8000    
Sfx_C5_Ptr equ (Sfx_C5&$FFFF)|$8000  
Sfx_C6_Ptr equ (Sfx_C6&$FFFF)|$8000 
Sfx_C7_Ptr equ (Sfx_C7&$FFFF)|$8000  
Sfx_C8_Ptr equ (Sfx_C8&$FFFF)|$8000    
Sfx_C9_Ptr equ (Sfx_C9&$FFFF)|$8000  
Sfx_CA_Ptr equ (Sfx_CA&$FFFF)|$8000 
Sfx_CB_Ptr equ (Sfx_CB&$FFFF)|$8000  
Sfx_CC_Ptr equ (Sfx_CC&$FFFF)|$8000   
Sfx_CD_Ptr equ (Sfx_CD&$FFFF)|$8000    
Sfx_CE_Ptr equ (Sfx_CE&$FFFF)|$8000    
Sfx_CF_Ptr equ (Sfx_CF&$FFFF)|$8000 
Sfx_D0_Ptr equ (Sfx_D0&$FFFF)|$8000 
Sfx_D1_Ptr equ (Sfx_D1&$FFFF)|$8000  
Sfx_D2_Ptr equ (Sfx_D2&$FFFF)|$8000   
Sfx_D3_Ptr equ (Sfx_D3&$FFFF)|$8000    
Sfx_D4_Ptr equ (Sfx_D4&$FFFF)|$8000    
Sfx_D5_Ptr equ (Sfx_D5&$FFFF)|$8000  
Sfx_D6_Ptr equ (Sfx_D6&$FFFF)|$8000 
Sfx_D7_Ptr equ (Sfx_D7&$FFFF)|$8000  
Sfx_D8_Ptr equ (Sfx_D8&$FFFF)|$8000    
Sfx_D9_Ptr equ (Sfx_D9&$FFFF)|$8000  
Sfx_DA_Ptr equ (Sfx_DA&$FFFF)|$8000 
Sfx_DB_Ptr equ (Sfx_DB&$FFFF)|$8000  
Sfx_DC_Ptr equ (Sfx_DC&$FFFF)|$8000   
Sfx_DD_Ptr equ (Sfx_DD&$FFFF)|$8000    
Sfx_DE_Ptr equ (Sfx_DE&$FFFF)|$8000    
Sfx_DF_Ptr equ (Sfx_DF&$FFFF)|$8000 
Sfx_E0_Ptr equ (Sfx_E0&$FFFF)|$8000 
Sfx_E1_Ptr equ (Sfx_E1&$FFFF)|$8000  
Sfx_E2_Ptr equ (Sfx_E2&$FFFF)|$8000   
Sfx_E3_Ptr equ (Sfx_E3&$FFFF)|$8000    
Sfx_E4_Ptr equ (Sfx_E4&$FFFF)|$8000    
Sfx_E5_Ptr equ (Sfx_E5&$FFFF)|$8000 
Sfx_E6_Ptr equ (Sfx_E6&$FFFF)|$8000 
Sfx_E7_Ptr equ (Sfx_E7&$FFFF)|$8000  
Sfx_E8_Ptr equ (Sfx_E8&$FFFF)|$8000    
Sfx_E9_Ptr equ (Sfx_E9&$FFFF)|$8000 
;-------------------------------------------------------------------------------          
Sfx_A0_To_E9:                                                  ; Offset_0x0FEE00      
		dc.w    (((Sfx_A0_Ptr>>$08)|(Sfx_A0_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_A1_Ptr>>$08)|(Sfx_A1_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_A2_Ptr>>$08)|(Sfx_A2_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_A3_Ptr>>$08)|(Sfx_A3_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_A4_Ptr>>$08)|(Sfx_A4_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_A5_Ptr>>$08)|(Sfx_A5_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_A6_Ptr>>$08)|(Sfx_A6_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_A7_Ptr>>$08)|(Sfx_A7_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_A8_Ptr>>$08)|(Sfx_A8_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_A9_Ptr>>$08)|(Sfx_A9_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_AA_Ptr>>$08)|(Sfx_AA_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_AB_Ptr>>$08)|(Sfx_AB_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_AC_Ptr>>$08)|(Sfx_AC_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_AD_Ptr>>$08)|(Sfx_AD_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_AE_Ptr>>$08)|(Sfx_AE_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_AF_Ptr>>$08)|(Sfx_AF_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_B0_Ptr>>$08)|(Sfx_B0_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_B1_Ptr>>$08)|(Sfx_B1_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_B2_Ptr>>$08)|(Sfx_B2_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_B3_Ptr>>$08)|(Sfx_B3_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_B4_Ptr>>$08)|(Sfx_B4_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_B5_Ptr>>$08)|(Sfx_B5_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_B6_Ptr>>$08)|(Sfx_B6_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_B7_Ptr>>$08)|(Sfx_B7_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_B8_Ptr>>$08)|(Sfx_B8_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_B9_Ptr>>$08)|(Sfx_B9_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_BA_Ptr>>$08)|(Sfx_BA_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_BB_Ptr>>$08)|(Sfx_BB_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_BC_Ptr>>$08)|(Sfx_BC_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_BD_Ptr>>$08)|(Sfx_BD_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_BE_Ptr>>$08)|(Sfx_BE_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_BF_Ptr>>$08)|(Sfx_BF_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_C0_Ptr>>$08)|(Sfx_C0_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_C1_Ptr>>$08)|(Sfx_C1_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_C2_Ptr>>$08)|(Sfx_C2_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_C3_Ptr>>$08)|(Sfx_C3_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_C4_Ptr>>$08)|(Sfx_C4_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_C5_Ptr>>$08)|(Sfx_C5_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_C6_Ptr>>$08)|(Sfx_C6_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_C7_Ptr>>$08)|(Sfx_C7_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_C8_Ptr>>$08)|(Sfx_C8_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_C9_Ptr>>$08)|(Sfx_C9_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_CA_Ptr>>$08)|(Sfx_CA_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_CB_Ptr>>$08)|(Sfx_CB_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_CC_Ptr>>$08)|(Sfx_CC_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_CD_Ptr>>$08)|(Sfx_CD_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_CE_Ptr>>$08)|(Sfx_CE_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_CF_Ptr>>$08)|(Sfx_CF_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_D0_Ptr>>$08)|(Sfx_D0_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_D1_Ptr>>$08)|(Sfx_D1_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_D2_Ptr>>$08)|(Sfx_D2_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_D3_Ptr>>$08)|(Sfx_D3_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_D4_Ptr>>$08)|(Sfx_D4_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_D5_Ptr>>$08)|(Sfx_D5_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_D6_Ptr>>$08)|(Sfx_D6_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_D7_Ptr>>$08)|(Sfx_D7_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_D8_Ptr>>$08)|(Sfx_D8_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_D9_Ptr>>$08)|(Sfx_D9_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_DA_Ptr>>$08)|(Sfx_DA_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_DB_Ptr>>$08)|(Sfx_DB_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_DC_Ptr>>$08)|(Sfx_DC_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_DD_Ptr>>$08)|(Sfx_DD_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_DE_Ptr>>$08)|(Sfx_DE_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_DF_Ptr>>$08)|(Sfx_DF_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_E0_Ptr>>$08)|(Sfx_E0_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_E1_Ptr>>$08)|(Sfx_E1_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_E2_Ptr>>$08)|(Sfx_E2_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_E3_Ptr>>$08)|(Sfx_E3_Ptr<<$08))&$FFFF)
		dc.w    (((Sfx_E4_Ptr>>$08)|(Sfx_E4_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_E5_Ptr>>$08)|(Sfx_E5_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_E6_Ptr>>$08)|(Sfx_E6_Ptr<<$08))&$FFFF)      
		dc.w    (((Sfx_E7_Ptr>>$08)|(Sfx_E7_Ptr<<$08))&$FFFF) 
		dc.w    (((Sfx_E8_Ptr>>$08)|(Sfx_E8_Ptr<<$08))&$FFFF)   
		dc.w    (((Sfx_E9_Ptr>>$08)|(Sfx_E9_Ptr<<$08))&$FFFF)              
Sfx_A0:                                                        ; Offset_0x0FEE94
		incbin  'sound/sfx_A0.snd'
Sfx_A1:                                                        ; Offset_0x0FEEAA
		incbin  'sound/sfx_A1.snd'
Sfx_A2:                                                        ; Offset_0x0FEED4
		incbin  'sound/sfx_A2.snd'
Sfx_A3:                                                        ; Offset_0x0FEEF3
		incbin  'sound/sfx_A3.snd'
Sfx_A4:                                                        ; Offset_0x0FEF25
		incbin  'sound/sfx_A4.snd'
Sfx_A5:                                                        ; Offset_0x0FEF5A
		incbin  'sound/sfx_A5.snd'
Sfx_A6:                                                        ; Offset_0x0FEF86
		incbin  'sound/sfx_A6.snd'
Sfx_A7:                                                        ; Offset_0x0FEFB5
		incbin  'sound/sfx_A7.snd'
Sfx_A8:                                                        ; Offset_0x0FEFE4
		incbin  'sound/sfx_A8.snd'
Sfx_A9:                                                        ; Offset_0x0FEFFE
		incbin  'sound/sfx_A9.snd'
Sfx_AA:                                                        ; Offset_0x0FF010
		incbin  'sound/sfx_AA.snd'
Sfx_AB:                                                        ; Offset_0x0FF051
		incbin  'sound/sfx_AB.snd'
Sfx_AC:                                                        ; Offset_0x0FF070
		incbin  'sound/sfx_AC.snd'
Sfx_AD:                                                        ; Offset_0x0FF0A4
		incbin  'sound/sfx_AD.snd'
Sfx_AE:                                                        ; Offset_0x0FF0DA
		incbin  'sound/sfx_AE.snd'
Sfx_AF:                                                        ; Offset_0x0FF124
		incbin  'sound/sfx_AF.snd'
Sfx_B0:                                                        ; Offset_0x0FF151
		incbin  'sound/sfx_B0.snd'
Sfx_B1:                                                        ; Offset_0x0FF182
		incbin  'sound/sfx_B1.snd'
Sfx_B2:                                                        ; Offset_0x0FF1AE
		incbin  'sound/sfx_B2.snd'
Sfx_B3:                                                        ; Offset_0x0FF1FD
		incbin  'sound/sfx_B3.snd'
Sfx_B4:                                                        ; Offset_0x0FF22E
		incbin  'sound/sfx_B4.snd'
Sfx_B5:                                                        ; Offset_0x0FF289
		incbin  'sound/sfx_B5.snd'
Sfx_B6:                                                        ; Offset_0x0FF29E
		incbin  'sound/sfx_B6.snd'
Sfx_B7:                                                        ; Offset_0x0FF2BB
		incbin  'sound/sfx_B7.snd'
Sfx_B8:                                                        ; Offset_0x0FF2F6
		incbin  'sound/sfx_B8.snd'
Sfx_B9:                                                        ; Offset_0x0FF313
		incbin  'sound/sfx_B9.snd'
Sfx_BA:                                                        ; Offset_0x0FF35D
		incbin  'sound/sfx_BA.snd'
Sfx_BB:                                                        ; Offset_0x0FF385
		incbin  'sound/sfx_BB.snd'
Sfx_BC:                                                        ; Offset_0x0FF3B0
		incbin  'sound/sfx_BC.snd'
Sfx_BD:                                                        ; Offset_0x0FF3F1
		incbin  'sound/sfx_BD.snd'
Sfx_BE:                                                        ; Offset_0x0FF444
		incbin  'sound/sfx_BE.snd'
Sfx_BF:                                                        ; Offset_0x0FF47E
		incbin  'sound/sfx_BF.snd'
Sfx_C0:                                                        ; Offset_0x0FF4F0
		incbin  'sound/sfx_C0.snd'
Sfx_C1:                                                        ; Offset_0x0FF51E
		incbin  'sound/sfx_C1.snd'
Sfx_C2:                                                        ; Offset_0x0FF558
		incbin  'sound/sfx_C2.snd'
Sfx_C3:                                                        ; Offset_0x0FF569
		incbin  'sound/sfx_C3.snd'
Sfx_C4:                                                        ; Offset_0x0FF5E3
		incbin  'sound/sfx_C4.snd'
Sfx_C5:                                                        ; Offset_0x0FF60B
		incbin  'sound/sfx_C5.snd'
Sfx_C6:                                                        ; Offset_0x0FF672
		incbin  'sound/sfx_C6.snd'
Sfx_C7:                                                        ; Offset_0x0FF69A
		incbin  'sound/sfx_C7.snd'
Sfx_C8:                                                        ; Offset_0x0FF6C8
		incbin  'sound/sfx_C8.snd'
Sfx_C9:                                                        ; Offset_0x0FF6D9
		incbin  'sound/sfx_C9.snd'
Sfx_CA:                                                        ; Offset_0x0FF706
		incbin  'sound/sfx_CA.snd'
Sfx_CB:                                                        ; Offset_0x0FF733
		incbin  'sound/sfx_CB.snd'
Sfx_CC:                                                        ; Offset_0x0FF766
		incbin  'sound/sfx_CC.snd'
Sfx_CD:                                                        ; Offset_0x0FF7A0
		incbin  'sound/sfx_CD.snd'
Sfx_CE:                                                        ; Offset_0x0FF7AD
		incbin  'sound/sfx_CE.snd'
Sfx_CF:                                                        ; Offset_0x0FF7C2
		incbin  'sound/sfx_CF.snd'
Sfx_D0:                                                        ; Offset_0x0FF7F9
		incbin  'sound/sfx_D0.snd'
Sfx_D1:                                                        ; Offset_0x0FF82C
		incbin  'sound/sfx_D1.snd'
Sfx_D2:                                                        ; Offset_0x0FF865
		incbin  'sound/sfx_D2.snd'
Sfx_D3:                                                        ; Offset_0x0FF8A2
		incbin  'sound/sfx_D3.snd'
Sfx_D4:                                                        ; Offset_0x0FF8E1
		incbin  'sound/sfx_D4.snd'
Sfx_D5:                                                        ; Offset_0x0FF909
		incbin  'sound/sfx_D5.snd'
Sfx_D6:                                                        ; Offset_0x0FF933
		incbin  'sound/sfx_D6.snd'
Sfx_D7:                                                        ; Offset_0x0FF978
		incbin  'sound/sfx_D7.snd'
Sfx_D8:                                                        ; Offset_0x0FF9A0
		incbin  'sound/sfx_D8.snd'
Sfx_D9:                                                        ; Offset_0x0FF9CA
		incbin  'sound/sfx_D9.snd'
Sfx_DA:                                                        ; Offset_0x0FF9F7
		incbin  'sound/sfx_DA.snd'
Sfx_DB:                                                        ; Offset_0x0FFA24
		incbin  'sound/sfx_DB.snd'
Sfx_DC:                                                        ; Offset_0x0FFA58
		incbin  'sound/sfx_DC.snd'
Sfx_DD:                                                        ; Offset_0x0FFA9F
		incbin  'sound/sfx_DD.snd'
Sfx_DE:                                                        ; Offset_0x0FFAC7
		incbin  'sound/sfx_DE.snd'
Sfx_DF:                                                        ; Offset_0x0FFB01
		incbin  'sound/sfx_DF.snd'
Sfx_E0:                                                        ; Offset_0x0FFB9D
		incbin  'sound/sfx_E0.snd'
Sfx_E1:                                                        ; Offset_0x0FFBD8
		incbin  'sound/sfx_E1.snd'
Sfx_E2:                                                        ; Offset_0x0FFC3F
		incbin  'sound/sfx_E2.snd'
Sfx_E3:                                                        ; Offset_0x0FFC76
		incbin  'sound/sfx_E3.snd'
Sfx_E4:                                                        ; Offset_0x0FFCA5
		incbin  'sound/sfx_E4.snd'
Sfx_E5:                                                        ; Offset_0x0FFCCD
		incbin  'sound/sfx_E5.snd'
Sfx_E6:                                                        ; Offset_0x0FFCEE
		incbin  'sound/sfx_E6.snd'
Sfx_E7:                                                        ; Offset_0x0FFD28
		incbin  'sound/sfx_E7.snd'
Sfx_E8:                                                        ; Offset_0x0FFD84
		incbin  'sound/sfx_E8.snd'
Sfx_E9:                                                        ; Offset_0x0FFDAE
		incbin  'sound/sfx_E9.snd'
;-------------------------------------------------------------------------------                                                    
		cnop    $00000000, $000FFFFE
		dc.w    $0000                
;===============================================================================
; Rotina para carregar o driver de som 
; <<<-
;=============================================================================== 
	   

END