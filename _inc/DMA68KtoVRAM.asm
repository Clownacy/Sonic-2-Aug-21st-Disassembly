DMA68K:                                                 ; Offset_0x0015C4
                move.l  (DMA_Buffer_List_End).w, A1                  ; $FFFFDCFC
                cmpa.w  #DMA_Buffer_List_End, A1                         ; $DCFC
                beq.s   Offset_0x001620
                move.w  #$9300, D0
                move.b  D3, D0
                move.w  D0, (A1)+
                move.w  #$9400, D0
                lsr.w   #$08, D3
                move.b  D3, D0
                move.w  D0, (A1)+
                move.w  #$9500, D0
                lsr.l   #$01, D1
                move.b  D1, D0
                move.w  D0, (A1)+
                move.w  #$9600, D0
                lsr.l   #$08, D1
                move.b  D1, D0
                move.w  D0, (A1)+
                move.w  #$9700, D0
                lsr.l   #$08, D1
                move.b  D1, D0
                move.w  D0, (A1)+
                andi.l  #$0000FFFF, D2
                lsl.l   #$02, D2
                lsr.w   #$02, D2
                swap.w  D2
                ori.l   #$40000080, D2
                move.l  D2, (A1)+
                move.l  A1, (DMA_Buffer_List_End).w                  ; $FFFFDCFC
                cmpa.w  #DMA_Buffer_List_End, A1                         ; $DCFC
                beq.s   Offset_0x001620
                move.w  #$0000, (A1)
Offset_0x001620:
                rts
 
Process_DMA:                                                   ; Offset_0x001622
                lea     (VDP_Control_Port), A5                       ; $00C00004
                lea     (DMA_Buffer_List).w, A1                      ; $FFFFDC00
Process_DMA_Loop:                                              ; Offset_0x00162C
                move.w  (A1)+, D0
                beq.s   Process_DMA_End                        ; Offset_0x001644
                move.w  D0, (A5)
                move.w  (A1)+, (A5)
                move.w  (A1)+, (A5)
                move.w  (A1)+, (A5)
                move.w  (A1)+, (A5)
                move.w  (A1)+, (A5)
                move.w  (A1)+, (A5)
                cmpa.w  #DMA_Buffer_List_End, A1                         ; $DCFC
                bne.s   Process_DMA_Loop                       ; Offset_0x00162C
Process_DMA_End:                                               ; Offset_0x001644
                move.w  #$0000, (DMA_Buffer_List).w                  ; $FFFFDC00
                move.l  #DMA_Buffer_List, (DMA_Buffer_List_End).w ; $FFFFDC00, $FFFFDCFC
                rts