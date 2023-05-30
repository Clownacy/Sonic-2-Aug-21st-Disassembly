; Constants

gm_SEGALogo                    equ $00
gm_TitleScreen                 equ $04
gm_DemoMode                    equ $08
gm_PlayMode                    equ $0C
gm_SpecialStage                equ $10 
gm_Continue                    equ $14

Obj_Id                         equ $0000
Obj_Flags                      equ $0001
Obj_Art_VRAM                   equ $0002
Obj_Map                        equ $0004
Obj_X                          equ $0008
Obj_Sub_Y                      equ $000A
Obj_Y                          equ $000C
Obj_Speed                      equ $0010
Obj_Speed_Y                    equ $0012
Obj_Inertia                    equ $0014
Obj_Height_2                   equ $0016
Obj_Width_2                    equ $0017
Obj_Priority                   equ $0018
Obj_Width                      equ $0019
Obj_Map_Id                     equ $001A
Obj_Ani_Frame                  equ $001B
Obj_Ani_Number                 equ $001C
Obj_Ani_Flag                   equ $001D
Obj_Ani_Time                   equ $001E
Obj_Ani_Time_2                 equ $001F
Obj_Col_Flags                  equ $0020
Obj_Col_Prop                   equ $0021
Obj_Status                     equ $0022
Obj_Respaw_Ref                 equ $0023
Obj_Routine                    equ $0024
Obj_Routine_2                  equ $0025
Obj_Angle                      equ $0026
Obj_Flip_Angle                 equ $0027
Obj_Subtype                    equ $0028
Obj_Timer                      equ $002A
Obj_Control_Var_00             equ $002C
Obj_Control_Var_01             equ $002D
Obj_Control_Var_02             equ $002E
Obj_Control_Var_03             equ $002F
Obj_Control_Var_04             equ $0030
Obj_Control_Var_05             equ $0031
Obj_Control_Var_06             equ $0032
Obj_Control_Var_07             equ $0033  
Obj_Control_Var_08             equ $0034
Obj_Control_Var_09             equ $0035
Obj_Control_Var_0A             equ $0036
Obj_Control_Var_0B             equ $0037
Obj_Control_Var_0C             equ $0038
Obj_Control_Var_0D             equ $0039
Obj_Control_Var_0E             equ $003A
Obj_Control_Var_0F             equ $003B
Obj_Control_Var_10             equ $003C
Obj_Control_Var_11             equ $003D
Obj_Control_Var_12             equ $003E
Obj_Control_Var_13             equ $003F
Obj_Size                       equ $0040

Obj_Player_Flip_Flag           equ $0029
Obj_Player_Status              equ $002B
Obj_P_Flips_Remaining          equ $002C
Obj_Player_Flip_Speed          equ $002D
Obj_Player_Control             equ $002E
Obj_P_Invunerblt_Time          equ $0030
Obj_P_Invcbility_Time          equ $0032
Obj_P_Spd_Shoes_Time           equ $0034
Obj_Player_Next_Tilt           equ $0036
Obj_Player_Tilt                equ $0037
Obj_Player_St_Convex           equ $0038
Obj_Player_Spdsh_Flag          equ $0039
Obj_Player_Spdsh_Cnt           equ $003A
Obj_Player_Jump                equ $003C
Obj_Player_Last                equ $003D
Obj_Player_Top_Solid           equ $003E
Obj_Player_LRB_Solid           equ $003F

Obj_Boss_Routine               equ $000A
Obj_Boss_Ani_Map               equ $000B
Obj_Ani_Boss_Cnt               equ $000F 
Obj_Ani_Boss_Frame             equ $0015
Obj_Boss_Hit                   equ $0021
Obj_Ani_Boss_Routine           equ $0026
Obj_Boss_Hit_2                 equ $0032

HTz_Robotnik_Pos_X             equ $0010
HTz_Robotnik_Pos_Y             equ $0012 

NGHz_Robotnik_Pos_X            equ $0010
NGHz_Robotnik_Pos_Y            equ $0012
NGHz_Hammer_Pos_X              equ $0016
NGHz_Hammer_Pos_Y              equ $0018
NGHz_Ship_Boost_Pos_X          equ $001C
NGHz_Ship_Boost_Pos_Y          equ $001E

DHz_Front_Drill_Pos_X          equ $0010
DHz_Front_Drill_Pos_Y          equ $0012
DHz_Ship_Boost_Pos_X           equ $0016
DHz_Ship_Boost_Pos_Y           equ $0018
DHz_Robotnik_Pos_X             equ $001C
DHz_Robotnik_Pos_Y             equ $001E
DHz_Back_Drill_Pos_X           equ $0022
DHz_Back_Drill_Pos_Y           equ $0024

CNz_R_Catcher_Pos_X            equ $0010
CNz_R_Catcher_Pos_Y            equ $0012
CNz_Boss_Ship_Pos_X            equ $0016
CNz_Boss_Ship_Pos_Y            equ $0018
CNz_Robotnik_Pos_X             equ $001C
CNz_Robotnik_Pos_Y             equ $001E
CNz_L_Catcher_Pos_X            equ $0022
CNz_L_Catcher_Pos_Y            equ $0024
CNz_L_Catcher_Pos_Y_1          equ $002E
CNz_R_Catcher_Fall_Y           equ $0034
CNz_L_Catcher_Fall_Y           equ $003A

Obj_Page_Size_2P               equ $000C

; Level Select Text
_0 = $00
_1 = $01
_2 = $02                
_A = $11
_B = $12
_C = $13
_D = $14                
_E = $15
_F = $16
_G = $17
_H = $18
_I = $19
_J = $1A
_K = $1B
_L = $1C
_M = $1D
_N = $1E
_O = $1F
_P = $20
_Q = $21
_R = $22
_S = $23
_T = $24
_U = $25
_V = $26
_W = $27
_X = $28
_Y = $0F
_Z = $10
__ = $FF 

; Z80

Z80_RAM_Start                  equ $00A00000 

; I/O

IO_Hardware_Version            equ $00A10001 
IO_Joypad_Port_0               equ $00A10003
IO_Port_0_Control              equ $00A10008
IO_Port_1_Control              equ $00A1000A
IO_Expansion_Control           equ $00A1000C

Z80_Bus_Request                equ $00A11100 
Z80_Reset                      equ $00A11200 

; VDP

VDP_Data_Port                  equ $00C00000
VDP_Control_Port               equ $00C00004

; RAM

M68K_RAM_Start                 equ $FFFF0000

SS_Ram_Layout_Address          equ M68K_RAM_Start+$4000

Level_Map_Buffer               equ M68K_RAM_Start+$8000
Level_Map_Bg_Buffer            equ Level_Map_Buffer+$0080

Blocks_Mem_Address             equ M68K_RAM_Start+$9000

Obj_Memory_Address             equ M68K_RAM_Start+$B000
Player_One                     equ Obj_Memory_Address
Player_One_Position_X          equ Player_One+Obj_X
Player_One_Position_Y          equ Player_One+Obj_Y
Player_Two                     equ Obj_Memory_Address+$0040
Player_Two_Position_X          equ Player_Two+Obj_X
Player_Two_Position_Y          equ Player_Two+Obj_Y
Title_Card_RAM_Obj_Data        equ Obj_Memory_Address+$0080
HUD_RAM_Obj_Data               equ Obj_Memory_Address+$0380
Level_Results_RAM_Obj_Data     equ Obj_Memory_Address+$05C0

Obj_Start_Addr_2P              equ M68K_RAM_Start+$BE00
Obj_Page_01_2P_Addr            equ M68K_RAM_Start+$C100
Obj_Page_02_2P_Addr            equ M68K_RAM_Start+$C400
Obj_Page_03_2P_Addr            equ M68K_RAM_Start+$C700
Obj_Page_04_2P_Addr            equ M68K_RAM_Start+$CA00
Obj_Page_05_2P_Addr            equ M68K_RAM_Start+$CD00

Special_Stage_Memory_Address   equ M68K_RAM_Start+$D000

Primary_Colision_Data_Buffer   equ M68K_RAM_Start+$D000
Secundary_Colision_Data_Buffer equ M68K_RAM_Start+$D600

DMA_Buffer_List                equ M68K_RAM_Start+$DC00
DMA_Buffer_List_End            equ M68K_RAM_Start+$DCFC

Scroll_Buffer_Data             equ M68K_RAM_Start+$E000
Camera_X                       equ M68K_RAM_Start+$EE00 
Camera_Y                       equ M68K_RAM_Start+$EE04 
Camera_X_x2                    equ M68K_RAM_Start+$EE08 
Camera_Y_x4                    equ M68K_RAM_Start+$EE0C 
Camera_Y_x4_Mod_10             equ M68K_RAM_Start+$EE14 
Camera_X_x8                    equ M68K_RAM_Start+$EE10 
Camera_X_x4                    equ M68K_RAM_Start+$EE18
Camera_Y_x4_Mod_10_2           equ M68K_RAM_Start+$EE1C 
Camera_X_2                     equ M68K_RAM_Start+$EE20 
Camera_Y_2                     equ M68K_RAM_Start+$EE24
Scroll_Flag_Array              equ M68K_RAM_Start+$EE50
Scroll_Flag_Array_2            equ M68K_RAM_Start+$EEA0
Horizontal_Scrolling           equ M68K_RAM_Start+$EEB0
Vertical_Scrolling             equ M68K_RAM_Start+$EEB2
Horizontal_Scrolling_Sub       equ M68K_RAM_Start+$EEB4
Vertical_Scrolling_Sub         equ M68K_RAM_Start+$EEB6
Sonic_Level_Limits_Min_X       equ M68K_RAM_Start+$EEC8
Sonic_Level_Limits_Max_X       equ M68K_RAM_Start+$EECA
Sonic_Level_Limits_Min_Y       equ M68K_RAM_Start+$EECC
Sonic_Level_Limits_Max_Y       equ M68K_RAM_Start+$EECE
Level_Scroll_Flag              equ M68K_RAM_Start+$EEDC
Vertical_Scroll_Flag           equ M68K_RAM_Start+$EEDE
Dyn_Resize_Routine             equ M68K_RAM_Start+$EEDF
Miles_Level_Limits_Min_X       equ M68K_RAM_Start+$EEF8
Miles_Level_Limits_Max_X       equ M68K_RAM_Start+$EEFA
Miles_Level_Limits_Max_Y       equ M68K_RAM_Start+$EEFE
Game_Mode                      equ M68K_RAM_Start+$F600
Control_Ports_Buffer_Data      equ M68K_RAM_Start+$F604
Timer_Count_Down               equ M68K_RAM_Start+$F614 
Horizontal_Interrupt_Count     equ M68K_RAM_Start+$F624
Scanlines_Count                equ M68K_RAM_Start+$F625
VBlank_Index                   equ M68K_RAM_Start+$F62A
Pause_Status                   equ M68K_RAM_Start+$F63A
Water_Level                    equ M68K_RAM_Start+$F646
Water_Level_Change             equ M68K_RAM_Start+$F648
Water_Level_New                equ M68K_RAM_Start+$F64A
PLC_Buffer                     equ M68K_RAM_Start+$F680
Refresh_Level_Layout           equ M68K_RAM_Start+$F720
Water_Level_Flag               equ M68K_RAM_Start+$F730
Boss_Animate_Buffer            equ M68K_RAM_Start+$F740
Boss_Move_Buffer               equ M68K_RAM_Start+$F750
Sonic_Max_Speed                equ M68K_RAM_Start+$F760
Sonic_Acceleration             equ M68K_RAM_Start+$F762
Sonic_Deceleration             equ M68K_RAM_Start+$F764
Current_Colision_Pointer       equ M68K_RAM_Start+$F796
Boss_Defeated_Flag             equ M68K_RAM_Start+$F7A7
Boss_Flag                      equ M68K_RAM_Start+$F7AA
Player_Status_Flag             equ M68K_RAM_Start+$F7CA
Palette_Buffer                 equ M68K_RAM_Start+$FB00
Palette_Underwater_Buffer      equ M68K_RAM_Start+$FB80
Exception_Index                equ M68K_RAM_Start+$FC44
StackPointer                   equ M68K_RAM_Start+$FE00
Debug_Mode_Flag_Index          equ M68K_RAM_Start+$FE08
Level_Id                       equ M68K_RAM_Start+$FE10
Act_Id                         equ M68K_RAM_Start+$FE11
Life_Count                     equ M68K_RAM_Start+$FE12
Special_Stage_Id               equ M68K_RAM_Start+$FE16
Super_Sonic_Flag               equ M68K_RAM_Start+$FE19
Ring_Life_Flag                 equ M68K_RAM_Start+$FE1B
HUD_Life_Refresh_Flag          equ M68K_RAM_Start+$FE1C
HUD_Rings_Refresh_Flag         equ M68K_RAM_Start+$FE1D
HUD_Timer_Refresh_Flag         equ M68K_RAM_Start+$FE1E
HUD_Score_Refresh_Flag         equ M68K_RAM_Start+$FE1F
Ring_Count                     equ M68K_RAM_Start+$FE20
Time_Count                     equ M68K_RAM_Start+$FE22
Time_Count_Minutes             equ M68K_RAM_Start+$FE23
Time_Count_Seconds             equ M68K_RAM_Start+$FE24
Time_Count_CentiSeconds        equ M68K_RAM_Start+$FE25
Score_Count                    equ M68K_RAM_Start+$FE26
Shield_Flag                    equ M68K_RAM_Start+$FE2C
Invincibility_Flag             equ M68K_RAM_Start+$FE2D
Hi_Speed_Flag                  equ M68K_RAM_Start+$FE2E
Saved_Level_Flag               equ M68K_RAM_Start+$FE30
Emerald_Count                  equ M68K_RAM_Start+$FE57
Emerald_Collected_Flag_List    equ M68K_RAM_Start+$FE58
Object_Frame_Buffer            equ M68K_RAM_Start+$FEA0
Miles_Max_Speed                equ M68K_RAM_Start+$FEC0
Miles_Acceleration             equ M68K_RAM_Start+$FEC2
Miles_Deceleration             equ M68K_RAM_Start+$FEC4
Two_Player_Flag                equ M68K_RAM_Start+$FFD8
Sound_Buffer_Id                equ M68K_RAM_Start+$FFE0
Auto_Control_Player_Flag       equ M68K_RAM_Start+$FFF0
Hardware_Id                    equ M68K_RAM_Start+$FFF8 
Debug_Mode_Active_Flag         equ M68K_RAM_Start+$FFFA 
Init_Flag                      equ M68K_RAM_Start+$FFFC

; CRAM
Color_RAM_Address              equ $C0000000