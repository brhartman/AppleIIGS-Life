; ------------------------------------------------------------------------------
; board.s
; ------------------------------------------------------------------------------
               mx          %00


BoardCur       ds          4
BoardNext      ds          4


; AllocateBoard
; Return Stack = board handle, board pointer
; ------------------------------------------------------------------------------
AllocateBoard

               PushLong    #32000
               jsr         NewAlloc
               PullLong    DPTmp1
               PullLong    DPTmp2

; DPTmp1 is the board handle, DPTmp2 is the board pointer

; Clear the values in the block of memory
               ldy         #32000
               lda         #$0000
:ClearMem      dey
               dey
               sta         [DPTmp2],y
               bne         :ClearMem

; Push the board pointer and board handle
               plx                          ; rts address
               PushLong    DPTmp2
               PushLong    DPTmp1
               phx                          ; rts address

               rts


; InitBoard
; ------------------------------------------------------------------------------
InitBoard
; Populate BoardCur with the initial starting state
               ldy         #32000
]loop          jsr         RandNumToA
               and         #$1111
               dey
               dey
               sta         [DPBoardCur],y
               bne         ]loop
               rts


; UpdateBoard
; ------------------------------------------------------------------------------
UpdateBoard
; Iterate BoardCur and populate BoardNext with the next generation

               lda         DPBoardCur
               sta         DPUpdateSrc
               sta         BaseUpdateSrc
               lda         DPBoardCur+2
               sta         DPUpdateSrc+2

               lda         DPBoardNext
               sta         DPUpdateDst
               sta         BaseUpdateDst
               lda         DPBoardNext+2
               sta         DPUpdateDst+2

; Load and compute the corner cells

               jsr         LoadCellsCrnNW
               jsr         ComputeCell
               sta         [DPUpdateDst],y

               IncrementY  #158
               jsr         LoadCellsCrnNE
               jsr         ComputeCell
               sta         [DPUpdateDst],y

               IncrementY  #31682
               jsr         LoadCellsCrnSW
               jsr         ComputeCell
               sta         [DPUpdateDst],y

               IncrementY  #158
               jsr         LoadCellsCrnSE
               jsr         ComputeCell
               sta         [DPUpdateDst],y

; Load and compute the top edge cells

               ldy         #2

]loop
               jsr         LoadCellsN
               jsr         ComputeCell
               sta         [DPUpdateDst],y
               iny
               iny

               cpy         #158
               bne         ]loop

; Load and compute the bottom edge cells

               ldy         #31842

]loop
               jsr         LoadCellsS
               jsr         ComputeCell
               sta         [DPUpdateDst],y
               iny
               iny

               cpy         #31998
               bne         ]loop

; Load and compute the left edge, inner, and right edge cells

               ldx         #2
               ldy         #160

]loopOuter
               jsr         LoadCellsW
               jsr         ComputeCell
               sta         [DPUpdateDst],y
               iny
               iny

]loopInner
               jsr         LoadCellsIn
               jsr         ComputeCell
               sta         [DPUpdateDst],y
               inx
               inx
               iny
               iny

               cpx         #158
               bne         ]loopInner

               ldx         #2
               jsr         LoadCellsE
               jsr         ComputeCell
               sta         [DPUpdateDst],y
               iny
               iny

               cpy         #31836
               bcc         ]loopOuter

               rts


BaseUpdateSrc  ds          2
BaseUpdateDst  ds          2


; BoardToScreen
; ------------------------------------------------------------------------------
BoardToScreen
; Iterate BoardNext copying it to both the screen and BoardCur

               jsr         ShadowOff

               ldy         #$0000
]loop          lda         [DPBoardNext],y
               sta         [DPBoardCur],y
               tyx
               stal        $012000,x
               iny
               iny
               cpy         #32000
               bne         ]loop

               jsr         ShadowedUpdate

               rts
