; ------------------------------------------------------------------------------
; equates.s
; ------------------------------------------------------------------------------
              mx    %00

; memory
DPMem0        equ   $0010
DPMem1        equ   $0014
DPMem2        equ   $0018
DPMem3        equ   $001a

; graphics
DPPEISlamLoc  equ   $0040
EntryDP       equ   $0044
EntryStack    equ   $0048

; global
DPTmp0        equ   $0080
DPTmp1        equ   $0084
DPTmp2        equ   $0088
DPTmp3        equ   $008a

; board
DPBoardCur    equ   $0090
DPBoardNext   equ   $0094
DPUpdateSrc   equ   $0098
DPUpdateDst   equ   $009c
